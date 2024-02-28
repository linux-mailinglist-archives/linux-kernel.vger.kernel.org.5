Return-Path: <linux-kernel+bounces-85037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FDD86AF6F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42461F26B92
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ACD1487D8;
	Wed, 28 Feb 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8bVv+3o"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61B145FF8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124627; cv=none; b=bOGPIBjkYm9b9juDI81l2S0cDCffeKQJ/ctdhDTm+GtAngR2siSJmkQLn30wpjHU7jvhNRZLnv8i8ndhN16ia0jZ9f45AS/3X7cmOv/4QF4jUI9j7dNPechN+Gy5cVU1smMuKo91c5PZgbN0uaGrlVj/U95/vNnSQ40/LdRu2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124627; c=relaxed/simple;
	bh=wn+MbCcn/K0Zldg29qQxf+CfHyOjH6LfxU3Y9Bem8xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANQA3sd9L6qPxpukVC4HKz+wD0TVPjSTmN0JeTZr8IgAsxq/NkYc1AfgLigtYdsEO9kI8t5D1Mbc/L0xkaP1RXwgf/u/8VTbm1OLF1QDpADty258jdOz0j8itDaJ3OGoGe4Yzc9QXRtJyoCkeB2nyOcDUbJP6ByBkblyk+5FVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8bVv+3o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412a390347dso26122715e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709124624; x=1709729424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86IJ2VFchpa/vyWFfSlDmU7WJYSKBDcdQ3imeHjnKGk=;
        b=f8bVv+3oBvT6NtuSqdX9qYaiA0Ny0XrGdvfArvjBpYCFzn04FBcAjYHB/RDbM38N4X
         nP338LTIP2n1OxC13shHx2/6PFGShi7YQk+yqUIqRlxL2npDodJXXM0zvfXjmVLDH563
         pdjXEPSnWPQBcXXPywfw+EDYCYLlfSiWBc3KZvf9SO2HewDRierbijdUKZhjlYkWpY9m
         r9OZ9KK0SFi82DN+16ok6Qg4c2LN1yNZWRQkOhuYPIuovyvQnkU6JG06nPF5VpsB1lQ1
         sPw4tQdmVcMlQ0uOBR7QEQ8wwVl6FsP1+T5wdfhn8MW18NZ5VMgqoyMBrwOt9oh0IOBu
         A1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709124624; x=1709729424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86IJ2VFchpa/vyWFfSlDmU7WJYSKBDcdQ3imeHjnKGk=;
        b=ffUBZy85NvOv+LIrMRmPhHEhggSYHHDew+uCPjlReuTvG2cIK1F/DOZTpyOjDvZC57
         iYHVVEHktvB1qEUGpq5w+MdIZZmJ9i6jscpx84j6/KkAO68/ihqwizzT8sR+d7C2mZud
         7O4k34XZER9jSu/93J6TZAvXau14f6OaCrPI7uDHTCuPPGScUPgTkpCnSoF+46FV+eA1
         ZqMhpvOKPZDEnUGM/VgDFVvZYT11GVvtcBdNQzv8WEGpJeJu/CDuOdctP4CqJtqyKxDF
         4lzLjkVPmDNbH30vVjHGfjPftDrqVRNiF3z/xlS+7jAlPgVZEs/TQL0Nwk5tDRwbcMOU
         tgQw==
X-Forwarded-Encrypted: i=1; AJvYcCUjjCtS4eOTGFxqlisKqICstSWTLTt+EUtlXPKVd9BXBsNTJlx52CDg8gxC+eqv/Ok5E+WT2n1RDU5BnrW4L+6UlWfpSAK7RTYTzEK2
X-Gm-Message-State: AOJu0YwjkecApP0F8X+zQnrtpgrYMmLLN6oYxIFZegCemDhXwtCe2+Uo
	Jeo8ZdVv+Z+mM5WNCI404PQEVqYje+TJZdA+8ZhjvlxeAomfFNSj
X-Google-Smtp-Source: AGHT+IGTwyHmq+257wSPXMNKoeHm2kGgfm2dAU/6Cg2VJ9RX0LELm6KjAJ4GzWCW742qTWrE/TY3ZA==
X-Received: by 2002:adf:fa8f:0:b0:33d:d2f8:ef1e with SMTP id h15-20020adffa8f000000b0033dd2f8ef1emr1332433wrr.66.1709124623427;
        Wed, 28 Feb 2024 04:50:23 -0800 (PST)
Received: from gmail.com (1F2EF054.nat.pool.telekom.hu. [31.46.240.84])
        by smtp.gmail.com with ESMTPSA id cc13-20020a5d5c0d000000b0033db0bbc2ccsm15094458wrb.3.2024.02.28.04.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:50:22 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 28 Feb 2024 13:50:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locking/percpu-rwsem: Trigger contention tracepoints
 only if contended
Message-ID: <Zd8sDKX8XtdrMuMb@gmail.com>
References: <20231108215322.2845536-1-namhyung@kernel.org>
 <CAM9d7chyJun57UV-6qRzgTzDEmUu5Z0mStgjRbrg2dcjUkMQzw@mail.gmail.com>
 <CAM9d7cjQv=RiOkW5=7vXUSwQn5v1XQNiJyL9egGy2VgmKWO69Q@mail.gmail.com>
 <c29d648c-451a-42af-81d3-e1660e3af46f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c29d648c-451a-42af-81d3-e1660e3af46f@redhat.com>


* Waiman Long <longman@redhat.com> wrote:

> 
> On 2/27/24 18:02, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Nov 20, 2023 at 12:28 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > Ping!
> > > 
> > > On Wed, Nov 8, 2023 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > It mistakenly fires lock contention tracepoints always in the writer path.
> > > > It should be conditional on the try lock result.
> > Can anybody take a look at this?  This makes a large noise
> > in the lock contention result.
> > 
> > Thanks,
> > Namhyung
> > 
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >   kernel/locking/percpu-rwsem.c | 11 ++++++++---
> > > >   1 file changed, 8 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> > > > index 185bd1c906b0..6083883c4fe0 100644
> > > > --- a/kernel/locking/percpu-rwsem.c
> > > > +++ b/kernel/locking/percpu-rwsem.c
> > > > @@ -223,9 +223,10 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
> > > > 
> > > >   void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
> > > >   {
> > > > +       bool contended = false;
> > > > +
> > > >          might_sleep();
> > > >          rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> > > > -       trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
> > > > 
> > > >          /* Notify readers to take the slow path. */
> > > >          rcu_sync_enter(&sem->rss);
> > > > @@ -234,8 +235,11 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
> > > >           * Try set sem->block; this provides writer-writer exclusion.
> > > >           * Having sem->block set makes new readers block.
> > > >           */
> > > > -       if (!__percpu_down_write_trylock(sem))
> > > > +       if (!__percpu_down_write_trylock(sem)) {
> > > > +               trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
> > > >                  percpu_rwsem_wait(sem, /* .reader = */ false);
> > > > +               contended = true;
> > > > +       }
> > > > 
> > > >          /* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */
> > > > 
> > > > @@ -247,7 +251,8 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
> > > > 
> > > >          /* Wait for all active readers to complete. */
> > > >          rcuwait_wait_event(&sem->writer, readers_active_check(sem), TASK_UNINTERRUPTIBLE);
> > > > -       trace_contention_end(sem, 0);
> > > > +       if (contended)
> > > > +               trace_contention_end(sem, 0);
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(percpu_down_write);
> > > > 
> > > > --
> > > > 2.42.0.869.gea05f2083d-goog
> 
> Yes, that makes sense. Sorry for missing this patch.
> 
> Reviewed-by: Waiman Long <longman@redhat.com>

Applied to tip:locking/core, thanks guys!

	Ingo

