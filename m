Return-Path: <linux-kernel+bounces-27712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608F582F48E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E2A284E39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAFF1CFA4;
	Tue, 16 Jan 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNZCm4Yh"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5011CF83
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430881; cv=none; b=ZI/u9qTxsMFNb78sAixoLlTLEDiT+447VKkXgVPQXW75qsTFxKQ2gDFMXdqA5qms+EpdHW7qgxpXMyS5gjaq7fQbAIbVoACp3njBpinxhyFNUKINS+WgVyntjESERYql5sJhglA8QQ90vJT2i4vCiHBeKQVW+xDhCMJDLOctgFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430881; c=relaxed/simple;
	bh=skAATRqyy1r1tXpqX1AJT+E1P2ZgxCO8L4HYRBY2LUo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ0jZfak7jukxqG5shaLSHqFCN0kU8j+YJGY1oKoVVsm2uV/VWtYEGKaIOkdFiURRCfECS6b7b5j2oaSDrepnfOeD8N1IyydzKX1sQYV9ba8pf7QLjda1uBrdFv9XGs63bvYcDE5cFTM/9+oj50CCNgzjQ6kKDzdAGczYyx9ERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNZCm4Yh; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d41bb4da91so56661635ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705430880; x=1706035680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bnp1+XVPjbA4Wce0cI801zWaZZnYO1jaDgk1dU1pqk=;
        b=eNZCm4YhgyXMRKRepZ6tvLTVW+NguAehAdmdIRA1T/kKwMwE9mKBbroRCNJrYmhkx0
         +aAixiwIf9X/jBwtluSC7OhFsbP1nKRrB4Bl8oZ7MryYflj440E5A4ZHcZnX2QTuVbsp
         YHANF/ydi7Zg1XSpXkrlyM+mWeLVMp8J2MdrBzyZ+np2owd1kwIdN603dauPWw5Wd1le
         GVv40qLYq0ZuDWAsXWa6yU+egsl3kEEP0o2XhT0/4fMStm//pTh6d87D98hovW1X/EJl
         uJpUFYAkQlWVxuHhr5wKKT+CDMs2Bzgf/4J1Ys5+mD8v/0UfK2aHUQ7vkm2FcvEiyyrC
         +tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705430880; x=1706035680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bnp1+XVPjbA4Wce0cI801zWaZZnYO1jaDgk1dU1pqk=;
        b=qypr5/+U06HaOQbdxzChI3FoJA8WFlR2XV6Cl8BedocBEKR9+c9jrMFfpuZt+IQufB
         Jnh2hnN0XlcqWw/cxQ7LPTejmo4wE4fSRAih/2ZLfq0V3jm+PHKL3as5wuPwHvZYT/yb
         1+vSLfRKiTB4UodS2C7yisnBMl2rkHUhUg6BINytGpS1WbQbNHh3N4W/Ofmvycl+SIlz
         Sh/BcyVoPR0ztn5L9eh3q6uxJLssLArSDENFmb0k9G4DV1XzjR1zxDbISCf/9g85Z0AC
         ZHo1C7Zoitgm8P8547froyEFtDCOr6VacXLpc7L+nE6RGfvdZvj+ujT9PTNXkEuom6rE
         Cw0w==
X-Gm-Message-State: AOJu0YwBjOhNMvROjX33BBsivNIz6iZ0+TIx8hIrOUS/T8IayRe+ahjs
	PiNh0ItIOeCip3i9bUCeXo4=
X-Google-Smtp-Source: AGHT+IFwNiK2DqaUfEYiKFo4Mxl8SS29bHumQdL+Wcec18MVSdQ/77Cp8TQ4cbjg7FoPvR2346c4vw==
X-Received: by 2002:a17:903:234f:b0:1d5:d00:c19d with SMTP id c15-20020a170903234f00b001d50d00c19dmr4876995plh.105.1705430879645;
        Tue, 16 Jan 2024 10:47:59 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id jz3-20020a170903430300b001d4b0ae7052sm9639897plb.135.2024.01.16.10.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:47:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jan 2024 08:47:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] kernel/workqueue: Bind rescuer to unbound
 cpumask for WQ_UNBOUND
Message-ID: <ZabPXiT8WoLyLoyk@slm.duckdns.org>
References: <20240116161929.232885-1-juri.lelli@redhat.com>
 <20240116161929.232885-3-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116161929.232885-3-juri.lelli@redhat.com>

On Tue, Jan 16, 2024 at 05:19:27PM +0100, Juri Lelli wrote:
> At the time they are created unbound workqueues rescuers currently use
> cpu_possible_mask as their affinity, but this can be too wide in case a
> workqueue unbound mask has been set as a subset of cpu_possible_mask.
> 
> Make new rescuers use their associated workqueue unbound cpumask from
> the start.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Apply 1-2 to wq/for-6.9.

Thanks.

-- 
tejun

