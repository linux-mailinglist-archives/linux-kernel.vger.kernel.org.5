Return-Path: <linux-kernel+bounces-165472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7C8B8CF3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB410B20FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0674B12F58A;
	Wed,  1 May 2024 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDRKl5X2"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4D8827
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577283; cv=none; b=IPX0PNxLvutoOJfO7+N5OBePDM5l8oxYXtZaTfRfbApXh0XHBp4a8oCI69OXcsGcxq/YEwKr1wP48KOecn7CNky0qJ9AVsFz3J0WrIFn587I7Vd12VwQq3D+Ed3PBskN5Fa3k3RfMl6hzSZCDAFh6kY+pcgnW26qTux8pZC1LnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577283; c=relaxed/simple;
	bh=baa2FJGf6NUedlRWXPK2fHDoQzTKmsCMBIPUSWdcbL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLh/WcrtPMFhKNyrX2i8u3FiOy9euWAyeWAkeCsHl4YeG7XNoZhoF4UFxzr35V67IhrGomyvx+OBLW/Y8CEeN93nDpzGk7TfW0WrKgao692i5MBd32Q1+ee3OC55fuapo0p6rfBRYd21nA9ziHpZ3iLWG9tsvowSxU0YV5w1r6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDRKl5X2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61ab31d63edso7965847b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714577280; x=1715182080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30JvKxAOBphF8LtRNVdNO2eNwyR9fbZNf8k4FnIsRRM=;
        b=eDRKl5X2HqMOIVBwSUxK1kDb846yKVjjJB7JJmSUEKBFa30VFoe2SnysU8ghs83IWq
         3xfcqQt1IN+/oYqzNUHCsKMoT2O6ehPd4eCcCInQWNjVDGmZwcps/FCfLd5vgYwkOdEG
         U8mpokBZvSMjCBNdjJF3TFOLsnlsSqIKke98Pj2HWg4UZhp0aApsfiFKF2ksVyzHw84E
         0PnwC0mHXxT1W7d94ynwMcwl7hFparzmuHvwAswMZzuNaQgGynqe/0L2wSZhpE4afIch
         Or5unOG+QhcRdBc7tUkMMQ5WwEQEyHEzhjfrj6i3Oo3exLt77lhSpxIv9b9tYjer+Kjx
         QoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714577280; x=1715182080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30JvKxAOBphF8LtRNVdNO2eNwyR9fbZNf8k4FnIsRRM=;
        b=pv712R7MA0qgfqMWASXRxEMWZ3nGmC1DKlmXNNywaniUcutSxc2ptCCw7GM1jNpGvc
         B2PHxSNidersCGRqRQhF4f9GdHajLPb+BMD6pO+JpWAPFkyA8I6OjU9yicjgIfW3mG1z
         9ta+4LanGOdR6KC7r8jqckcR+nv4CTZxiM33VaJQ8p11JxUnk+viV7hKLofprjnREP10
         TpCxFV3M1JUP3Ohq3tF0NNPX+Eczm5ovVP+UH1p4oSoTpDJyhJWas4VrnoENCyo5sEUv
         RPbYY6jDasItxvGF8EqfY80wbRJNE0VVPU2AS5Q7mm1qhVgnC1otjMBR7En7KI6uGo9/
         hnsg==
X-Forwarded-Encrypted: i=1; AJvYcCXs4P5puRXP4NKhltr21U5Ex1g2/qF6SUawBVBAk4aWEL2CpetOWuO2yXkE6KZK7j8p+oqcC1Jf9tnpQpbFZhCW28CW0Kf0nH+Hwat/
X-Gm-Message-State: AOJu0YykN7Nd/7wNVmftKErmjHbumCHM+oiZ2N10jfr7dbQA4KbFMYae
	EASc/FstFzjVCPVj5AlEOCDtp6KgMKKCFqvhrAz/ep62cBnx2P0e
X-Google-Smtp-Source: AGHT+IEtT1BCNnzn0JAkNwWCCwr0S32Ov1Ly+UZSd3FsU5f9FfGvrhrM9quDZBlYtBXBBJGaf+Cxzw==
X-Received: by 2002:a0d:ddd4:0:b0:615:2fa1:c55d with SMTP id g203-20020a0dddd4000000b006152fa1c55dmr4016027ywe.19.1714577280420;
        Wed, 01 May 2024 08:28:00 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id u69-20020a818448000000b0061be5db0fe7sm1021424ywf.8.2024.05.01.08.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:27:59 -0700 (PDT)
Date: Wed, 1 May 2024 08:27:58 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Phil Auld <pauld@redhat.com>
Cc: Ankit Jain <ankit-aj.jain@broadcom.com>, linux@rasmusvillemoes.dk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Paul Turner <pjt@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] lib/cpumask: Boot option to disable tasks distribution
 within cpumask
Message-ID: <ZjJfftWMbjT9r8iT@yury-ThinkPad>
References: <20240430090431.1619622-1-ankit-aj.jain@broadcom.com>
 <ZjE3C9UgeZR02Jyy@yury-ThinkPad>
 <20240501133608.GB39737@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501133608.GB39737@lorien.usersys.redhat.com>

On Wed, May 01, 2024 at 09:36:08AM -0400, Phil Auld wrote:
> 
> Hi Yuri,

[...]
 
> > Not that I'm familiar to your setup, but this sounds like a userspace
> > configuration problems. Can you try to move your non-RT tasks into a
> > cgroup attached to non-RT CPUs, or something like that? 
> >
> 
> It's not really. In a container environment just logging in to the
> container could end up with the exec'd task landing on one of
> the polling or latency sensitive cores.
> 
> In a telco deployment the applications will run containers with
> isolated(pinned) cpus with load balacning disabled.  These
> containers typically use one of these cpus for its "housekeeping"
> with the remainder used for the latency sensitive workloads.
> 
> Also, this is a change in kernel behavior which is breaking
> userspace.

Alright, that's a different story.

> We are also hitting this and are interested in a way to get the
> old behavior back for some workloads.
> 
> > > With the introduction of kernel cmdline param 'sched_pick_firstcpu',
> > > there is an option provided for such usecases to disable the distribution
> > > of tasks within the cpumask logic and use the previous 'pick first cpu'
> > > approach for initial placement of tasks. Because many telco vendors
> > > configure the system in such a way that the first cpu within a cpuset
> > > of pod doesn't run any SCHED_FIFO or High priority tasks.
> > > 
> > > Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> > > Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> > > Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
> > > ---
> > >  lib/cpumask.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/lib/cpumask.c b/lib/cpumask.c
> > > index e77ee9d46f71..3dea87d5ec1f 100644
> > > --- a/lib/cpumask.c
> > > +++ b/lib/cpumask.c
> > > @@ -154,6 +154,23 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
> > >  }
> > >  EXPORT_SYMBOL(cpumask_local_spread);
> > >  
> > > +/*
> > > + * Task distribution within the cpumask feature disabled?
> > > + */
> > > +static bool cpumask_pick_firstcpu __read_mostly;
> > > +
> > > +/*
> > > + * Disable Tasks distribution within the cpumask feature
> > > + */
> > > +static int __init cpumask_pick_firstcpu_setup(char *str)
> > > +{
> > > +	cpumask_pick_firstcpu = 1;
> > > +	pr_info("cpumask: Tasks distribution within cpumask is disabled.");
> > > +	return 1;
> > > +}
> > > +
> > > +__setup("sched_pick_firstcpu", cpumask_pick_firstcpu_setup);
> > > +
> > >  static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
> > >  
> > >  /**
> > > @@ -171,6 +188,13 @@ unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
> > >  {
> > >  	unsigned int next, prev;
> > >  
> > > +	/*
> > > +	 * Don't distribute, if tasks distribution
> > > +	 * within cpumask feature is disabled
> > > +	 */
> > > +	if (cpumask_pick_firstcpu)
> > > +		return cpumask_any_and(src1p, src2p);
> > 
> > No, this is a wrong way.
> > 
> > To begin with, this parameter shouldn't control a single random
> > function. At least, the other cpumask_*_distribute() should be
> > consistent to the policy.
> > 
> > But in general... I don't think we should do things like that at all.
> > Cpumask API is a simple and plain wrapper around bitmaps. If you want
> > to modify a behavior of the scheduler, you could do that at scheduler
> > level, not in a random helper function.
> > 
> > Consider 2 cases:
> >  - Someone unrelated to scheduler would use the same helper and will
> >    be affected by this parameter inadvertently.
> >  - Scheduler will switch to using another function to distribute CPUs,
> >    and your setups will suddenly get broken again. This time deeply in
> >    production.
> >
> 
> Yeah, I think I agree with this part.  At the scheduler level, where this
> is called, makes more sense. 
> 
> Note, this is "deeply in production" now...

So, if we all agree that touching cpumasks is a bad idea, let's drop
this patch and try figuring out a better solution.

Now that you're saying the scheduler patches break userspace, I think
it would be legitimate to revert them, unless there's a simple fix for
that.

Let's see what the folks will say. Please keep me in CC.

Thanks,
Yury

