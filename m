Return-Path: <linux-kernel+bounces-123679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B3D890C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8291D1F243E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467D513AD00;
	Thu, 28 Mar 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="xdSU8ysV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EA1DDD5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711661617; cv=none; b=u224aqhHF6vNHirjvUuNBure5x2e/pTGHwqkVPd/xNq/ngIz6/u0t4sf1trXAj+GiT0NI1iIQepHcP1iR5An96ej3EBVY+8pYSO4jwKHRh2IuV7krsBC4BWjSPFla3WbCtLXYFdE+eZ2P6FMXhAGVkFsKLg3teQM0RAHc8nqSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711661617; c=relaxed/simple;
	bh=XFki6ZC5tOSk0WForLx4ZHDQSqjcH/p30/OMKIvnRBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh+elde7BCV3X2TnXwfLRqfWV8dly9YQIR5CaevLAjDWfVLji+RuZ2z/84QUnw1+lGZVlW2M7eotQlT9Xy3Uo/GOS2yHb5x68Wj1KanM5ih26L7iWMZGxz26Qd2SEmA1MrUxPnnUCAC25baSepeeU39KsQmVc3pqvEvUPBJD+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=xdSU8ysV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4149532da36so9959295e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711661613; x=1712266413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJWkSfVOf/LktYRkKHYTWHXKtjRfezrzjSDDPelmTjo=;
        b=xdSU8ysVaBWrAnk23F+xpElCKqlrHgbedgitL8EUQTRVGItpIZvT7Fo/PstEzg8c/o
         8WsbO5Uh5Y70v6hj+Tzxe8z6A7ELpR6lugj6yj8HoKdLSQdln+JJg0AqfCD7C/pO9FcC
         /XCwjEHlkSrV803kk/G65S2vFVrussPZUewd/MVpk62nb/blDLuoLIF47yNpP/PN1jyR
         yvIrn3JZ8JhqsxYHCHm/aPgcw1iXCN+1PnJCzkHT5XsEbje9WRleKOUrPanZYL/pVtag
         E7q4RW8Kl45xKtSqxWbOFA/RRI2AoU9wy8kO4d/nYulv6KaWZ0KmsI0Xx+w2XhOVcbbt
         IUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711661613; x=1712266413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJWkSfVOf/LktYRkKHYTWHXKtjRfezrzjSDDPelmTjo=;
        b=w7TiVloudUK8P5E65IpGcwd7DS2bMirGgvdXrMslF69IvS84FITsDbPZ2449cFJtTI
         lLUtAv60RoGRdA9fUeSel1hSgCiVXHtLwTsuydsw/dZw+gQliB0iXuGlPArfyQdy1+wI
         gZ0zLo0fR/eTri1BJOOouA+wzyqAHwNNDsorDQVPJbelyyqxkHVWEiVwTwSjb31a/CeV
         kuP6bUYXjibm9hJ+CLWsifNV6zCiCzlZcdhzbD6j0wL0H2Y7yLJUgDfAaj4SrwNFbXjM
         YevNAlUN55BiZXgQoG+7HabF9fk5al/6DSxkRC/KYJd+3i0fEoOHQosT5xiXt3oDK33H
         xzZw==
X-Forwarded-Encrypted: i=1; AJvYcCXJlz1LzRPAdvy2wST8ySq6L72iw4amKrLA7+wJl1o+I+8deCqCIc12bMGOiWshsS4tPdMSvMCEUbeCJRemcRfOdfz5GU5PKeU27RLf
X-Gm-Message-State: AOJu0Yx7e1i/Tbl4znlL4/N6T3472rc7K/mbqrzvEuN+BxlkuKNhLLW6
	tQ4B18bLuyWo33WEnru/32cqwk2iDMK/Z4rWuclY0viqQK+i9C0f6RXxht/YI+g=
X-Google-Smtp-Source: AGHT+IGmRx+68/sDu6ryluWMYnkHIUe7b0YZ5ikAs6+rsiZAPC2URFDT+xVlYslSzF7knTTRFWoq8g==
X-Received: by 2002:a05:600c:310a:b0:414:63c2:71bf with SMTP id g10-20020a05600c310a00b0041463c271bfmr361815wmo.41.1711661613209;
        Thu, 28 Mar 2024 14:33:33 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id fl20-20020a05600c0b9400b00415464010fcsm2693466wmb.41.2024.03.28.14.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:33:32 -0700 (PDT)
Date: Thu, 28 Mar 2024 21:33:31 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	peterz@infradead.org, dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: Re: [PATCH] sched/fair: Combine EAS check with overutilized access
Message-ID: <20240328213331.2vmuub3qud7nfx6t@airbuntu>
References: <20240326152616.380999-1-sshegde@linux.ibm.com>
 <ZgMiwYxF5rnVTpLf@gmail.com>
 <CAKfTPtCk_aD-g-uADdoiWrGVHBbbVMuBKzWjyrKuA609O8vJzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCk_aD-g-uADdoiWrGVHBbbVMuBKzWjyrKuA609O8vJzA@mail.gmail.com>

On 03/26/24 21:15, Vincent Guittot wrote:
> On Tue, 26 Mar 2024 at 20:32, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> >
> > > Access to overutilized is always used with sched_energy_enabled in
> > > the pattern:
> > >
> > > if (sched_energy_enabled && !overutilized)
> > >        do something
> > >
> > > So modify the helper function to return this pattern. This is more
> > > readable code as it would say, do something when root domain is not
> > > overutilized. This function always return true when EAS is disabled.
> > >
> > > No change in functionality intended.
> > >
> > > Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > > ---
> > >  kernel/sched/fair.c | 20 +++++++-------------
> > >  1 file changed, 7 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 24a7530a7d3f..e222e3ad4cfe 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6686,12 +6686,11 @@ static inline bool cpu_overutilized(int cpu)
> > >  }
> > >
> > >  /*
> > > - * Ensure that caller can do EAS. overutilized value
> > > - * make sense only if EAS is enabled
> > > + * overutilized value make sense only if EAS is enabled
> > >   */
> > >  static inline int is_rd_overutilized(struct root_domain *rd)
> > >  {
> > > -     return READ_ONCE(rd->overutilized);
> > > +     return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
> > >  }
> > >
> > >  static inline void set_rd_overutilized_status(struct root_domain *rd,
> > > @@ -6710,8 +6709,6 @@ static inline void check_update_overutilized_status(struct rq *rq)
> > >        * overutilized field is used for load balancing decisions only
> > >        * if energy aware scheduler is being used
> > >        */
> > > -     if (!sched_energy_enabled())
> > > -             return;
> > >
> > >       if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
> > >               set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
> >
> > On a second thought, I'm not sure removing the open-coded
> > sched_energy_enabled() branches is a good idea: the current code makes it
> > really, really clear when we are within EAS code paths.
> >
> > Hiding it within is_rd_overutilized() makes it a lot less obvious IMO.
> 
> That's probably a matter of pov. I prefer embedding everything to make
> sure to have useless access to rd->overutilized

I do think it is better this way too.

> 
> >
> > And this one:
> >
> > > @@ -8202,7 +8199,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> > >                   cpumask_test_cpu(cpu, p->cpus_ptr))
> > >                       return cpu;
> > >
> > > -             if (sched_energy_enabled()) {
> > > +             if (!is_rd_overutilized(this_rq()->rd)) {
> > >                       new_cpu = find_energy_efficient_cpu(p, prev_cpu);
> > >                       if (new_cpu >= 0)
> > >                               return new_cpu;
> >
> > Didn't have a root_domain::overutilized check before?
> 
> This is the one that was in find_energy_efficient_cpu() before.

But not sure about moving is_rd_overutilized() call out of
find_energy_efficient_cpu() is a good call here. Are we trying to save the
function call? Looking at disassembly the function was completely inlined into
select_task_rq_fair() on my recent compilation on Apple M1 system (6.8 kernel).

I see it is applied now. I agree it is a matter of PoV. So no big deal.

