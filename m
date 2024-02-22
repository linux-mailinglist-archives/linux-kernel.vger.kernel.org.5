Return-Path: <linux-kernel+bounces-76197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B40DC85F414
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691EF285EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF5537167;
	Thu, 22 Feb 2024 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqsHdGeZ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18292BB1B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593370; cv=none; b=L3c9lWqhSOQd5FwfZbcegWHIYatXUMl7ZRflwzjbw8jPP7SYzJ8FpQ2T15Xne4eokGRrZCxciAGS/NDgHVoBVGHzyvkwHgK9bBKyKuOHr6uV8HNPSsFznDFXsNa5TPW8V9iWuBFd4TZXX1WDWM2Xtz5nD6vVgG8hEVO6yR+DdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593370; c=relaxed/simple;
	bh=ahinyDPMODXy2KLfJ+IOe8FdqNa4TWTb0+x3vo+3E0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFvxjK2nJSI/m0xxvMBEG/x83wDuUdYOC5O5/oYMuToKb/GvyAffYpBoMYACyk9f5Ma5zkFR6QQzFb+BR6/N39WJtm2vJXXilxMwpXanGKSl292hLD6VhBoLC1yjMSv/eKN9dzIc94ZqZzrellSl8MZaoIh2Wz9dy4MNG4s74oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqsHdGeZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so31049495ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708593368; x=1709198168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fwK+yTpO7SX5kgyJp1UX/5QVGMXw8ddrnJys0GyWcU=;
        b=OqsHdGeZcKFwMRDaeDOChXa2Lso0Gl8Jk/2brGGJunIv/luu7yl9XElDWLTXny0t9C
         ZtvKDnimWKdyGOctCjqDXd23ssKxA//9xCPvTaZr9dhpAdpmeIWMzB1pIqhzRyC/Q9nT
         5Tp1UXlwvUedd7je4yrRCgWdu0quunugkrxJb1V4XWw5v36lgAJJ+wxdTn1Ul2+C9XXC
         ElkVikGvaWhDOkXx01/IGWsHiaUFkZjJe0fXfCUo5ZTWnD4JVVbgPnwZMco7RFDNHvwV
         3Pr6N/LmipjKN4cJrKG2Ety7vkzko1Y2yNY6EituzWH1+kePJ98Zx3zDQHzSMubtWHff
         6aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708593368; x=1709198168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fwK+yTpO7SX5kgyJp1UX/5QVGMXw8ddrnJys0GyWcU=;
        b=A7FPSOwViLpcRoz+aA4THaxVrYat17EYHsP7cMV0K2zqBSN+hsCRqI/v56SSAt2vbq
         Kud3qX3tOlgMvX/E4gUo1CmVs0q3KE2JB+cKU3qH6cV8Z7M4LTMDb6fFn7rrZ729UlVQ
         ZfIZ9N/fzVdT1hXaVxxMm6Y/P43qgM7fgDQARCCbosVxatMFMNiogcwOxOCYzzstwRxl
         gwwFTseQu+MVcgPKCQPszRXWq0muE+29Awtb/oVbsq/tP6aWuXP7ivJEX66tE0Z6brju
         VjH3M4JCponB8Z44+p80u1nzW0+Xr4Nk3jCoVvSIaBA44zxH+Ij4lsPjRsQMTE7VonF7
         VyeA==
X-Forwarded-Encrypted: i=1; AJvYcCWsEzEHDchW/DixKDYs/siNPuobXhaJ4q/+Yex/PslEVRxgC2YOvhnqyiQOBJ+Vqejyr6QlT/xs0bafLaschTuSONzucO5SPNrjD04I
X-Gm-Message-State: AOJu0YwdpQWExWfb5I3pIy7qrNYFxj0GJI10oRj2FFzawV3wgZnFunCR
	vWqzt3hOQtV+fgUl2ud4gkZWLEHapTWlUJjmisKXeCp4TVdy1POH
X-Google-Smtp-Source: AGHT+IHHxG4JWICeDLuztNawuKFTnSNi1EmWO/nxYJpnXk4m/1/Lpe5zyZaKq0UMvUEL34XWvQwh/A==
X-Received: by 2002:a17:902:ce82:b0:1db:f7f6:a73a with SMTP id f2-20020a170902ce8200b001dbf7f6a73amr13990727plg.25.1708593367863;
        Thu, 22 Feb 2024 01:16:07 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902e2d100b001d8ecf5ff6csm9452573plc.147.2024.02.22.01.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:16:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 21 Feb 2024 23:16:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v2 wq/6.10] workqueue: Implement disable/enable_work()
Message-ID: <ZdcQ1jfOKNTlbB6C@slm.duckdns.org>
References: <20240221174333.700197-1-tj@kernel.org>
 <CAJhGHyCJS7Pb_5dwTQtcZ25yOVzxFULJEYT4o3id_3xdj32EYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyCJS7Pb_5dwTQtcZ25yOVzxFULJEYT4o3id_3xdj32EYA@mail.gmail.com>

Hello,

On Thu, Feb 22, 2024 at 11:33:24AM +0800, Lai Jiangshan wrote:
> From the last patch:
> > - tasklet_disable_nosync()      -> disable_work()
> > - tasklet_disable[_in_atomic]() -> disable_work_sync()
> 
> I think it is a misuse-prone conversion.
> 
> A developer familiar with tasklet_disable() might happily use disable_work()
> and, to her/his surprise, leave the running works unsynced.
> 
> And tasklet_disable_nosync() is used at only 3 places while tasklet_disable()
> is used a lot.  I think the shorter name for the most common cases is better.

While I agree that this can be argued either way, keeping the interface
congruent with the existing cancel_work_sync() and friends seems a lot more
important to me. It can be a bit more confusing for users who are used to
tasklet interface but then again we aren't gonna rename cancel_work_sync()
to kill_work() and the conversion overhead isn't all that significant or
lasting. However, if we break the consnistency within workqueue API, that's
a source of lasting confusion.

> Moreover, IMHO the unsynchronized variants of tasklet/work disabling functions
> never have a strong scenario. I think it should be discouraged.
>
> Although it will be inconsistent with the name of cancel_work[_sync](),
> I still suggest:
> tasklet_disable_nosync() -> disable_work_nosync()
> tasklet_disable() -> disable_work().
>
> Even cancel_work_sync() is used a lot more than cancel_work(), so I
> also suggest rename cancel_work() to cancel_work_nosync() and leave
> cancel_work_sync() unchanged (at least for a while).

Maybe but I'm not sure this would bring meaingful benefits at this point.
Besides, even if we do something like this, we should still keep cancel and
disable names in sync. Let's leave this topic for some other day.

> [changed topic:]
> 
> I feel uncomfortable with tasklet_disable_in_atomic() implicitly
> being implemented in disable_work_sync().
> 
> I think it is a revert of the commit ca5f62511895 ("tasklets: Provide
> tasklet_disable_in_atomic()") in which tglx discouraged the usage of
> tasklet_disable_in_atomic() and marked it "error prone".
> 
> And even tasklet_disable_in_atomic() is implemented in disable_work_sync(),
> I prefer to sleepable-wait than spinning-wait when disable_work_sync() is
> called in a sleepable context for BH work item.
> 
> All the above is just my feeling, not reasoning, nor rejection of the patches.

So, tasklet atomic wait isn't great in that it busy-spins softirq on the CPU
that the disabled tasklet is queued on. The only busy waiting that happens
in the workqueue implementation is the waiter waiting for the target work
item which is currently executing to finish. This shouldn't be error-prone
as long as the calling context is checked.

I'm not strongly against putting atomic disable in a separate interface. I
just couldn't think of strong enough justifications for doing so. If it's
safe and the busy wait is bound by the target work item's execution time,
might as well make the interface simpler and give users one less thing to
think about.

Thanks.

-- 
tejun

