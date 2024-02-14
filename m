Return-Path: <linux-kernel+bounces-65871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE00855310
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7D51F2784C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DE213B785;
	Wed, 14 Feb 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC9pw1Tg"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C9134CCA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938221; cv=none; b=JBC/ioNNTzUZQPj0BpTvEAsVKisdgkrGn6cyChuyeVouSn0+OTuJgkYg1kFEAb5S8aOARr29ZPR6j7X/o55kC00HvhAftSHXkDsyKInsOap1ZVGFpNNXnXGDqu+NV2mQuNQybrjU1GeL5Ax0JBOfq1QQuQfVFC4KrWQ8q01nAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938221; c=relaxed/simple;
	bh=hPDrrV3XIMJo8q1tTjBG4ME3Gj2Sw6BkzZjvg7GqD6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH9zwO9NCl5I1uiMHfQ4SkiDgIUYDVI+XZH320aSKzk+G62jOZuxWLI+agu2in5czaxUiNM76i3p8taGfIM++BIYrJrpZ5VNnHhe2Y0DZdgx7cmWJeEweKKhEUOpn/SabUB0Rcj4UkarJbmpWTnc/XhymLr71zppXMAGLi+UBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC9pw1Tg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d70b0e521eso573125ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707938219; x=1708543019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1o3lgJRDuvLUD9lUUbwablSPS6Dg/IMDLr3dC+6DHsQ=;
        b=YC9pw1TgmmQe2V7cHpLP/evE8F32DJHzWkHymsBZbHpOENO4DrI0lbBaEibZS8Jkbc
         b1kHwTn/avE9BLq993YpvaV3durW11ZCRsw8pWUNjZ3UQ0zJY/Fm85oa5uzQ9z6GUNuP
         Yp2i22/0bTmwIHq8WDY303fg8tfnXLFUpDwEAnqRNmgfQrfHY7YYu8npAhBiNkbqfrPH
         6rLXTc8Az8blH94xR7EvhxM4OcGuUiYycxKaKvf+GMlebPBl9EZ5bgNfKSBaugIJC3o+
         hbnVt0IUzRSlnC2cCF7Kkk/XVdmFXCPcAL7Fns2yS59+ZM3RlVvkEN0TsAYK+4u++J0W
         Yoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938219; x=1708543019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o3lgJRDuvLUD9lUUbwablSPS6Dg/IMDLr3dC+6DHsQ=;
        b=Etlp2tvHlIdaLV65DY7dSTxFEa7ohFX4NE4BNsbpNcAUTvqZKXJ9Cz0ruRAP34jlPR
         5wrlPo0YytLERdGDemvOgv4fCIaNsvLUNHOGf8+pKG2ZA/lOfiGoPBwKuTXHaVP4p6Gm
         lHp5e0Ca3c+fAGUzIj3/Aci6nTKwjXlKdYLIGHvUUfSi+6FHJkjkTerFE1hzSdOWPtsS
         JwifDVR2ApRHv18AmXlZsB4DWx8caARutSuXJKLVi8GkqE7uY+Jd+UlusQFMOeQcJ9fR
         msPKUgunRaPSTL/0bNdOMZVyssGzbVbPrzB46WOJ/2BaiJBS5RMgiC2giOTCHoq6hwra
         ApYA==
X-Forwarded-Encrypted: i=1; AJvYcCW4Jon3eY1+o/x3gNSpNX3lyOkYnPVslPUe7ciV7Cro85DtnDTnVU+xeVOfqV1iJgdHGJVALf54/tyBe8/obbVFLWyw5jP/eYa65eVc
X-Gm-Message-State: AOJu0Yym6Npsaa1sMRFacD6Sugb17xBzrZo5qELhtHBCAXIJzesGS6LK
	pk8FNLSHNqgkVpVjOf5wdW40uuILWozQLIDpK03H0Kp7dl5BNVKF
X-Google-Smtp-Source: AGHT+IEpMs+uyWaWFXkALNhyE/TedYoidC1riQPQUiC+k4xadRiMsaAzbhKCVibnkbCi31QEMBQ8UQ==
X-Received: by 2002:a17:902:c951:b0:1db:402c:f098 with SMTP id i17-20020a170902c95100b001db402cf098mr4954932pla.52.1707938219611;
        Wed, 14 Feb 2024 11:16:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUN/ulDzMFEI6OJ6uIYmU3hAMNmZVX7+9Lfeuc72vxb4tvBeVMQVKLYXCnHtAcapDSjw1lwaZA6ge/B6q3TQEAiYg/2bKGG51Fa4aH0hZZoz2Kps50OEWIhNqqgl764
Received: from localhost ([2620:10d:c090:400::4:fe87])
        by smtp.gmail.com with ESMTPSA id mi15-20020a170902fccf00b001db43f3629dsm2766605plb.140.2024.02.14.11.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:16:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 14 Feb 2024 09:16:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wq/for-6.9] workqueue: Fix queue_work_on() with BH
 workqueues
Message-ID: <Zc0Rqaq5DXcJLTta@slm.duckdns.org>
References: <Zc0IzeM6tAvm1NTl@mtj.duckdns.org>
 <CAHk-=wiVWmTfaCUjZYrV6pVh3O6hYksKsWx4bJY0EhNNat9QDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVWmTfaCUjZYrV6pVh3O6hYksKsWx4bJY0EhNNat9QDg@mail.gmail.com>

Hello,

On Wed, Feb 14, 2024 at 11:03:46AM -0800, Linus Torvalds wrote:
> On Wed, 14 Feb 2024 at 10:39, Tejun Heo <tj@kernel.org> wrote:
> >
> > When queue_work_on() is used to queue a BH work item on a remote CPU, the
> > work item is queued on that CPU but kick_pool() raises softirq on the local
> > CPU.
> 
> Now, does it make a lot of sense to ask to queue a BH work on another
> CPU in the first place?
> 
> I don't think tasklets supported that. And while the workqueues
> obviously do - and you fix that case - I wonder if we shouldn't say
> "that operation makes no sense, please don't do it" rather than
> actually support it?
> 
> What made you notice this issue?

It's test code I'm using to verify new features to cover
tasklet_disable/enable(), so not a real use case. For tasklet migration,
this isn't necessary but at the same time all the mechanics are already
there, so it's nice to keep the API orthogonal and one can conceive
plausible use cases - e.g. "I'm using per-cpu work items to collect per-cpu
states but that comes with really high tail latencies, lemme switch to
per-cpu BH work items".

Thanks.

-- 
tejun

