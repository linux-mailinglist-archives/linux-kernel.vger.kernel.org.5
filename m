Return-Path: <linux-kernel+bounces-7972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ACB81AFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334FCB242E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC5615AF5;
	Thu, 21 Dec 2023 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE9adloT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3447F156DA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d2e6e14865so3688095ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703145763; x=1703750563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kHNHNkxPChwYV/cJG0BrAlWZ4xpohppGcHR/JIHLocU=;
        b=PE9adloTm81qO2cAWS4JCQq2qm3Nq44BXXxIKVR55KFH4+KFwXDkdlqJCIl2c1Kh5N
         qg8OcRnJvQgzP7Xs4toTkOjBu10+Dw1hm317QpmZ2m+HhDHj2ed2mLDbkF32sZ5calI/
         IvydIn/gTphFspMd94clmNEroXhTRC4n389E81g7gbiB3N8IzXPJqATH8zhAgWwX3TYA
         X99rFrPOfQ3boez6zhVC5KaIQ196zRCUWZQ0+EmEhWtnH4GvDA/Q5VqwsBMIxMfnlWFK
         ZF0vk4NlJ0YoOuhI/OYoz7QnApuneahsjjAwEPUfhG87fl8CtwntMC4XzplYXyZpRkwt
         ExHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703145763; x=1703750563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHNHNkxPChwYV/cJG0BrAlWZ4xpohppGcHR/JIHLocU=;
        b=X8YTQWlcfpYdVC/utr1+zL1gfGmxxePZwHwkOHHP3gN/PGGeg0Ofgs3AthsMzcnsfS
         4AjYxwp6A1fAq0CUqYZi3PQu8su1jhvxAFt0pCO9HVJeQ/0hrQU1o1g0ZwaEbsaILxzh
         JKjZp7rSKnvZF+ACyP0ODA1Y0fvSMHIxJSp/pjo5DU4NL56j5ZaZ/px/14r91iXJKhnj
         i4pmJP0jRTort5hwlazLXJ1lVPws7cNJOLfWne0igNPcCLjp3/xoVDK+jdV5aFYmP3me
         xDaHJmsj+6YVtT3ia60eeCdHln+P+SiQ8ekgt7pDVD9x0TsyVgTjGZoo8b3wzRs9t6W8
         J6Xw==
X-Gm-Message-State: AOJu0YwtcVRTfL6swBJbqyfYU2LnemGNgd8KbifAm1wxWiwmfGA/2Ali
	CtsPNLZ7biNwS2x+Cr+AhAY=
X-Google-Smtp-Source: AGHT+IF2eeZvasNcamfi7XJ3xTETWNM7R/hEg6K4F5PXh8uZy6dPonc+SRCZGCvdELZNpGbK4ymeBw==
X-Received: by 2002:a17:90a:fc88:b0:28b:eb71:5e6e with SMTP id ci8-20020a17090afc8800b0028beb715e6emr354280pjb.81.1703145763335;
        Thu, 21 Dec 2023 00:02:43 -0800 (PST)
Received: from DESKTOP-IM4PCEA.localdomain ([49.206.131.209])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a1a5d00b0028b0424a4bcsm5307787pjl.54.2023.12.21.00.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 00:02:42 -0800 (PST)
Date: Thu, 21 Dec 2023 13:32:29 +0530
From: "<Mintu Patel>" <mintupatel89@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: badolevishal1116@gmail.com, chinmoyghosh2001@gmail.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org,
	vimal.kumar32@gmail.com, will@kernel.org
Subject: Re: [PATCH v2] rt_spin_lock: To list the correct owner of
 rt_spin_lock
Message-ID: <20231221080229.GA38@DESKTOP-IM4PCEA.localdomain>
References: <20220619142038.1274-1-mintupatel89@gmail.com>
 <20220627161136.3468-1-mintupatel89@gmail.com>
 <20231206185837.GB9899@noisy.programming.kicks-ass.net>
 <20231207170130.GA78@DESKTOP-IM4PCEA.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207170130.GA78@DESKTOP-IM4PCEA.localdomain>

On Thu, Dec 07, 2023 at 10:31:30PM +0530, <Mintu Patel> wrote:
> On Wed, Dec 06, 2023 at 07:58:37PM +0100, Peter Zijlstra wrote:
> > On Mon, Jun 27, 2022 at 09:41:38PM +0530, Mintu Patel wrote:
> > >    rt_spin_lock is actually mutex on RT Kernel so it goes for contention
> > >    for lock. Currently owners of rt_spin_lock are decided before actual
> > >    acquiring of lock. This patch would depict the correct owner of
> > >    rt_spin_lock. The patch would help in solving crashes and deadlock
> > >    due to race condition of lock
> > > 
> > > acquiring rt_spin_lock        acquired the lock       released the lock
> > >                     <-------->                <------->
> > >                     contention period         Held period
> > > 
> > > Thread1                             Thread2
> > > _try_to_take_rt_mutex+0x95c+0x74    enqueue_task_dl+0x8cc/0x8dc
> > > rt_spin_lock_slowlock_locked+0xac+2 rt_mutex_setprio+0x28c/0x574
> > > rt_spin_lock_slowlock+0x5c/0x90     task_blocks_rt_mutex+0x240/0x310
> > > rt_spin_lock+0x58/0x5c              rt_spin_lock_slowlock_locked+0xac/0x2
> > > driverA_acquire_lock+0x28/0x56      rt_spin_lock_slowlock+0x5c/0x90
> > > 				    rt_spin_lock+0x58/0x5c
> > >                                     driverB_acquire_lock+0x48/0x6c
> > > 
> > > As per above call traces sample, Thread1 acquired the rt_spin_lock and
> > > went to critical section on the other hand Thread2 kept trying to acquire
> > > the same rt_spin_lock held by Thread1 ie contention period is too high.
> > > Finally Thread2 entered to dl queue due to high held time of the lock by
> > > Thread1. The below patch would help us to know the correct owner of
> > > rt_spin_lock and point us the driver's critical section. Respective
> > > driver need to be debugged for longer held period of lock.
> > > 
> > >    ex: cat /sys/kernel/debug/tracing/trace
> > > 
> > >    kworker/u13:0-150   [003] .....11   202.761025: rt_spinlock_acquire:
> > > Process: kworker/u13:0 is acquiring lock: &kbdev->hwaccess_lock
> > >    kworker/u13:0-150   [003] .....11   202.761039: rt_spinlock_acquired:
> > > Process: kworker/u13:0 has acquired lock: &kbdev->hwaccess_lock
> > >    kworker/u13:0-150   [003] .....11   202.761042: rt_spinlock_released:
> > > Process: kworker/u13:0 has released lock: &kbdev->hwaccess_lock
> > > 
> > 
> > The above is word salad and makes no sense. No other lock has special
> > tracing like this, so rt_lock doesn't need it either.
> > 
> Hi Peter,
> 
> As per current implementation of rt_spin_lock tracing mechanism on RTLinux, 
> if more than one threads are trying to acquire a rt_spin_lock,
> then multiple threads are assigned as owners of the same lock, more over
> only one thread is actual owner of lock and others are still
> contending for the same lock. Such trace logs can mislead the developers
> during debugging of critical issues like deadlock, crashes etc
> 
> The above patch would generate rt_spin_lock locking traces which would
> depict correct owner of the lock and other thread details which 
> are trying to acquire the lock.
> 
> Regards,
> Mintu Patel 

Hi Peter,

Hope you got a chance to check the reply.

Regards,
Mintu Patel

