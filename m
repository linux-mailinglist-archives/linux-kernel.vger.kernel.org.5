Return-Path: <linux-kernel+bounces-96923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4562487632B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B01283AE2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7789B55E50;
	Fri,  8 Mar 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaoLxM6o"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7755102A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896997; cv=none; b=rdUms5zJIR8k8e1Kf9LnI0Q9E/6ZgVldMMsH8NCWZnqDlSltKFt5q/WoUYxUmkYRuQYMaC1hho4N73AMd3gbGHQFM7c2Fu+JsIZ1ZM4/8m7x07ONrhkPGv6I1wg4/puw8vGR0BCECgjkCvTHbAqhvK0w8oyQqQsT9V29c9Cizsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896997; c=relaxed/simple;
	bh=ioZRt3Pfv7wT+LmURSaJNijF6Qkrr6X1/RpPoUBbks0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThpHYOUK+7aZkaIrZ+y5jUPagaT020cz5RXMgYabDNI/+j3Y1z2sktOoGnHa7FmuWa3mv3zfyU4f6w1d7ZB8tL8E7msFvbEE7FhJQvS7yPy1VDXiCRkJqa+XGbfXcowzpzN4ENeknjplemUg9MvFlYQax/xxdOj4WuvUuLI97H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaoLxM6o; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690a9648c39so10672106d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896995; x=1710501795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//f4unDsgARaQGpvqmB/swQeGE7og7bwvNrpCB1PklA=;
        b=FaoLxM6oya0OAzFn6QLet/3w+a77kcqlclY72DTibE4qcLH0g8K3fB+h8QH4+yVJh9
         Lue8ySf3OcjM0M5dfS7nFKUzgcGEILVvIb1ERsavBnpov6bGiBtmO8GICaGIkwaPa3P2
         +wACip+Lf7+rVjNuCgHb+m+OzRQWjIW8ULryOsEkboKpl8BG25u72cPKs/zyHWaJpKAu
         d4D72RLhaexVyVBRTQcC2KnKlZdvye8Q3pau4kyO1I5vIhQ795wFd/i4xRwJCO8JZZGM
         voTj0XsLXMxZCv/PzEa5zmEfHfGag2X5M6ADFluEFwG9yn9tWd5ioEycetDvCigjQohW
         5Ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896995; x=1710501795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//f4unDsgARaQGpvqmB/swQeGE7og7bwvNrpCB1PklA=;
        b=WuI8axHmxs39M+2k0+qUyPVPq5F+dal25BA1O+LYxdXaXAAVJzajwfzbhkgHtZ22gU
         rIY664jGgj8NRGUnS9cm2+U07/N5eOrraGBrjYs5weTkejCLp49dADzF+G8vXDV7lcYH
         x586L8OWs4jY5IA5uDMA3RE17xLDfSCSHdOTycdow2La4GgbYXhQBNO6I9ou3qY6QYB8
         LDoEFr8b+iFWskz384wr68dWuWGc+MBzRwoI66cOcFWjqQc72VOGZ+XD43Yzd/v4EjPl
         Z5bdwP4S8UqCNK8slmdLbMmbn5QP1CCZK77d42WopSNFzn0an8FXgHOOU2w77AMDdmQT
         cAdg==
X-Gm-Message-State: AOJu0Yw5FaFPie/AWgTHy1TKhvdvbEGBhSPT8rXJNKBfiG3vLlGlPU1t
	1zTbwjq3++U40q80OniBGQJuXgerV6gRTvurT4u1q8h+RFYRE+BR
X-Google-Smtp-Source: AGHT+IFjvfKswn8Yc2Qsu7s7g5UfL8e3nALZhYwdup2Rsc5c+zy9HP4eBNFD0ig9ZWWw2aEWAHna/A==
X-Received: by 2002:a05:6214:76a:b0:68f:f859:ee06 with SMTP id f10-20020a056214076a00b0068ff859ee06mr5972519qvz.12.1709896994696;
        Fri, 08 Mar 2024 03:23:14 -0800 (PST)
Received: from gmail.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id mu4-20020a056214328400b0068fd10638c0sm9628521qvb.20.2024.03.08.03.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:23:14 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 8 Mar 2024 12:23:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 1/9] sched/balancing: Switch the
 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t
 sched_balance_running' flag
Message-ID: <Zer1Hkxh/UMxs3xs@gmail.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-2-mingo@kernel.org>
 <bf612672-f7c3-4585-ac31-e02a1ebf614c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf612672-f7c3-4585-ac31-e02a1ebf614c@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> system is at 75% load		<-- 	25.6% contention
> 113K probe:rebalance_domains_L37
> 84K probe:rebalance_domains_L55
> 
> 87
> system is at 100% load		<--	87.5% contention.
> 64K probe:rebalance_domains_L37
> 8K probe:rebalance_domains_L55
> 
> 
> A few reasons for contentions could be: 
>
> 1. idle load balance is running and some other cpu is becoming idle, and 
>    tries newidle_balance.
>
> 2. when system is busy, every CPU would do busy balancing, it would 
>    contend for the lock. It will not do balance as should_we_balance says 
>    this CPU need not balance. It bails out and release the lock.

Thanks, these measurements are really useful!

Would it be possible to disambiguate these two cases?

I think we should probably do something about this contention on this large 
system: especially if #2 'no work to be done' bailout is the common case.

Thanks,

	Ingo

