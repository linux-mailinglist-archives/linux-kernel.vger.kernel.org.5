Return-Path: <linux-kernel+bounces-36209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A15839D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C62C1F27E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19D1396;
	Wed, 24 Jan 2024 00:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OswZuhsE"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B641104
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055194; cv=none; b=Cb9dBq5KdRXNtkj121cVI7uZjnCQZHfoV50DKTAUYMVn9bkkreVwZC7a9C5Mvsgcs/z9Sl1EPeMG+KfgKa3j8Z0tyb/KG4mgDu1DURA5XUl85/xpR5FCzUC4KVJHs/6TQdmlVEZZYMf+HSdRW/BdR1Kkra0dddGghRU3kyGLwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055194; c=relaxed/simple;
	bh=+0OX+KVDk1ebh4KbEP1cHkkj5xEAoGbcz2tRclnubqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2RhzqpCZ+SRclWl6dh/Nzl7N5m7rDFzBGypy8EPNA5xnZ4HYnYPDDkhvZgJvrvXDttFd89M5hSUpmtIK4Xhyw/hIsKztm9CQXay7jIbye0DKKcL0D3XATndxNW8Lxd5Gx9YtvojL9KIWhboA3aS7w+pVmknznZ78w0YzlWDQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OswZuhsE; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bda4bd14e2so3810322b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706055192; x=1706659992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pv6Z3iKL7TcecIBrv+rhHm5TJHkfHHklG1Cx6eXBYYk=;
        b=OswZuhsEsGItyr8jKwAfWw+AJn36NlENQ1NubnPRMzMeDyQn9ItFPq27ClJoLOSAv1
         0Gbk1RCUOiExR6xl8yTYZ/6d1tQjFhs4kUj56HrUgsgqEW51iOyJuDUNECwZ1m2KDh0q
         UJ8L8gtY5t2Y/Cn1Pxfia1aQvDvflgGmnoehnB1zApZBAyTf/ZyKfmPDj3e+ecqPL4yj
         j7jEd116GDoR8QM6LOnzBp1tVEzG6R57vSkU0AZ+19i9TdHL1uupqiPejPPe0jLp155s
         TjFMPVq798XEtzl/qEtCRb0A6zX8YLZ7bU2+nM/QZse82+yMCVevQEkZYMg33cvYwqd7
         95JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706055192; x=1706659992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pv6Z3iKL7TcecIBrv+rhHm5TJHkfHHklG1Cx6eXBYYk=;
        b=VJ/ZTVD8LPP5b79x6mLYK23vbSeX75tV9MZkZizXPWyYjBt0IS6zPLKfBiXzTPplaz
         J0nLY3fPb0rDu5X1Q/pYlQ1DXLl5LufQg80nMHZyvLbhzLyY+xakqchkrwrR1Ikhw4fL
         ibOwNjV9b3uwfJwpM2qPUYTIYpDuEZd8jVS5ZHpl+mFufTh7B5ovqYwTSExBdUYeRTj0
         k5kL3olc0Qr0cyX3ZbAiLin4hQbsSedk/sdgXcU+sEbOEjpcDUuQFP3TtTT6Z4MxqKrC
         0cOiesp3/Cn7rQsrUwIPgMpSmLzvRi9lWqBAK/NhYE/9g1+EaLXsLJ0FlerHUVXZYGvE
         cvcA==
X-Gm-Message-State: AOJu0Yw4nbrFUrBwrj3v1m1a0WPQ+f2h+WNNQCj4s1r8TZIyA4HTPRPA
	K1Q5d2F4WIyA5EJiaahN+wT/rg75x8iyMlG9btf24yHd8CoV8xXd
X-Google-Smtp-Source: AGHT+IGPLhMnEs7qXRXMteBfB/sPfOt1s6oGSEidug9AZwSQZGdLqesPA2V8eYajjrrZ3U7JZW5M+A==
X-Received: by 2002:a05:6808:1996:b0:3bd:cd56:99e5 with SMTP id bj22-20020a056808199600b003bdcd5699e5mr749898oib.10.1706055191968;
        Tue, 23 Jan 2024 16:13:11 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id k11-20020aa79d0b000000b006da04f1b884sm12138016pfp.105.2024.01.23.16.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:13:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Jan 2024 14:13:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH 8/9] workqueue: Introduce struct wq_node_nr_active
Message-ID: <ZbBWFvZpLl5fAAEz@slm.duckdns.org>
References: <20240113002911.406791-1-tj@kernel.org>
 <20240113002911.406791-9-tj@kernel.org>
 <CAJhGHyCc4trDp7XQixt0EmTnwd-2fdH2hn4fH=wKRB216MQssg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyCc4trDp7XQixt0EmTnwd-2fdH2hn4fH=wKRB216MQssg@mail.gmail.com>

On Fri, Jan 19, 2024 at 03:55:49PM +0800, Lai Jiangshan wrote:
> Hello, Tejun
> 
> On Sat, Jan 13, 2024 at 8:29 AM Tejun Heo <tj@kernel.org> wrote:
> 
> > @@ -327,6 +337,7 @@ struct workqueue_struct {
> >         /* hot fields used during command issue, aligned to cacheline */
> >         unsigned int            flags ____cacheline_aligned; /* WQ: WQ_* flags */
> >         struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
> > +       struct wq_node_nr_active **node_nr_active; /* I: per-node nr_active */
> 
> flexible array can be used here.

Yeah, will do that.

Thanks.

-- 
tejun

