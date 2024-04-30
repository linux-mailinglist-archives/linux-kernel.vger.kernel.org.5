Return-Path: <linux-kernel+bounces-164584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAED8B7FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F97281D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCA1836E0;
	Tue, 30 Apr 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThUC4bRR"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBBA1802DA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501391; cv=none; b=SD28byru84Oe0Fal3qPNtIJ2lgaP6ODimN4a9eYeAlmwLGWjNxHu2oZ8LtA3+ZGMR09sxyxFyaYGYhlqojyqZ1a4ywA4isbYG+6RkqvhhuKgjx18jQqUW6aXzQx9A2GwlwZGsRUaanYPylh5eCRMZwWbZG3KL1+7aGrH/ol28Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501391; c=relaxed/simple;
	bh=iBJZnHrXNYarliDg/M9giVZGmfwYrEdgs799HsjQpUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIunP530o5T82ywgMks36seQ3uhYhaW8zAUmNQmk76X7x+2ufG0Mzg55mD9uhqTkqNbYr9UCqT2kDq5YhGoxMpRW4ioepHKbxCJWGdBKu2kkC7P1gvapqLbwlddX0OFiiQizaRHfayFeBG4Bggau9jD4Dq3W71QY0H+LNizi4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThUC4bRR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6184acc1ef3so57135557b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714501388; x=1715106188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JW3+FSPpt+/opwIJ6LOrfIys0S22EmOBe3yi/ffGuSo=;
        b=ThUC4bRRcRgH+PNEMXgfNCqG0R6cbLCaRvSri69/CXAReNdNz/iDRd3K9UgUFHBNvn
         thhUZkbKpHOYT5sl96tJO/kvCkRg7RKLFm18el8nEzC4Jgz8DLFOhHFWgo2JqO6SpNlm
         wsVqO3tZ2ByWrc7MY4e5UAvLGdNQI25oU1QelNnQYNNrLbDCnerKJO37xyt+tYLgTbO7
         Io0hWN9UapHp5+mzZeT7vZJSQiwJrc7lDtvsJOdXSvNp6JomfCKPuQh2zlxYJsJHZ++v
         Ya26qB3WTtlVNaITS64SDXpth0Lh+8LvVV35WeIWVQJ7XLnWUHvqyuDktZ0nlyq/8UHi
         Tn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714501388; x=1715106188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW3+FSPpt+/opwIJ6LOrfIys0S22EmOBe3yi/ffGuSo=;
        b=NtgiSi9a7L+LxipVDxPVJxjbnM0tfzI6Unq5/GBRmEXI7eZCBKwPPPRH/oiuj8t9xl
         LEvaSH0Anq0XJEJq7uyw+Ai77DYpAnOeQivb7WkJUvnQ5oJLLEjtAvsgINK76BGTAOeP
         7v6N+3mvNDI1WBhwiG5vfT462DSX4iXDXGezmv8GgUn7U3qUEuid/nWR7Ei5GaEuk5ZP
         IGopkChTEDB57uGZw4iEkGR3QnrXrboGDvqJ/3bRCf2eXhUgCG0FurX4Zuki8byCjhfp
         KWlCAMzOKh1bXZHbRX1j0IeYdLCIpVP7dcxzp3iiicXCQzaNi73mBcvx54lDIjoTpBJ6
         K99g==
X-Forwarded-Encrypted: i=1; AJvYcCVvjzxmcENjrxEnpCm12RlM42nCptTfVEZ96ReB1bzLQK8qu32AclHXb25v3qgpomAmZx9ZkMocfnK5kLirvUos2mZVGxs7Hz02tnWW
X-Gm-Message-State: AOJu0Yxsxx/lpIvRPtBXDBKzzDVwazolUH3jsxkur6+Ef5/Ob4GdV2ZU
	sdAEu/TYjXOdmZxT5EHix+6ozxANtBESGoisPvYXgWkNyiSIG33h
X-Google-Smtp-Source: AGHT+IGR7Bcs9X+gvTGcQYUe5hJK+mYgUTTy07UlAHsmIleZfDkEr1UASKRkbQ9DmS8JSBnnJrebpw==
X-Received: by 2002:a05:690c:368e:b0:61a:b038:6d34 with SMTP id fu14-20020a05690c368e00b0061ab0386d34mr408457ywb.24.1714501388568;
        Tue, 30 Apr 2024 11:23:08 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05690c031400b0061bd6a13a34sm1048450ywb.24.2024.04.30.11.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:23:08 -0700 (PDT)
Date: Tue, 30 Apr 2024 11:23:07 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Ankit Jain <ankit-aj.jain@broadcom.com>
Cc: linux@rasmusvillemoes.dk, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	pauld@redhat.com, ajay.kaher@broadcom.com,
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
Message-ID: <ZjE3C9UgeZR02Jyy@yury-ThinkPad>
References: <20240430090431.1619622-1-ankit-aj.jain@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430090431.1619622-1-ankit-aj.jain@broadcom.com>

On Tue, Apr 30, 2024 at 02:34:31PM +0530, Ankit Jain wrote:
> commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
> and commit 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")
> introduced the logic to distribute the tasks within cpumask upon initial
> wakeup.

So let's add the authors in CC list?

> For Telco RAN deployments, isolcpus are a necessity to cater to
> the requirement of low latency applications. These isolcpus are generally
> tickless so that high priority SCHED_FIFO tasks can execute without any
> OS jitter. Since load balancing is disabled on isocpus, any task
> which gets placed on these CPUs can not be migrated on its own.
> For RT applications to execute on isolcpus, a guaranteed kubernetes pod
> with all isolcpus becomes the requirement and these RT applications are
> affine to execute on a specific isolcpu within the kubernetes pod.
> However, there may be some non-RT tasks which could also schedule in the
> same kubernetes pod without being affine to any specific CPU(inherits the
> pod cpuset affinity).

OK... It looks like adding scheduler maintainers is also a necessity to
cater here...

> With multiple spawning and running containers inside
> the pod, container runtime spawns several non-RT initializing tasks
> ("runc init") inside the pod and due to above mentioned commits, these
> non-RT tasks may get placed on any isolcpus and may starve if it happens
> to wakeup on the same CPU as SCHED_FIFO task because RT throttling is also
> disabled in telco setup. Thus, RAN deployment fails and eventually leads
> to system hangs.

Not that I'm familiar to your setup, but this sounds like a userspace
configuration problems. Can you try to move your non-RT tasks into a
cgroup attached to non-RT CPUs, or something like that? 

> With the introduction of kernel cmdline param 'sched_pick_firstcpu',
> there is an option provided for such usecases to disable the distribution
> of tasks within the cpumask logic and use the previous 'pick first cpu'
> approach for initial placement of tasks. Because many telco vendors
> configure the system in such a way that the first cpu within a cpuset
> of pod doesn't run any SCHED_FIFO or High priority tasks.
> 
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
> ---
>  lib/cpumask.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index e77ee9d46f71..3dea87d5ec1f 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -154,6 +154,23 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
>  }
>  EXPORT_SYMBOL(cpumask_local_spread);
>  
> +/*
> + * Task distribution within the cpumask feature disabled?
> + */
> +static bool cpumask_pick_firstcpu __read_mostly;
> +
> +/*
> + * Disable Tasks distribution within the cpumask feature
> + */
> +static int __init cpumask_pick_firstcpu_setup(char *str)
> +{
> +	cpumask_pick_firstcpu = 1;
> +	pr_info("cpumask: Tasks distribution within cpumask is disabled.");
> +	return 1;
> +}
> +
> +__setup("sched_pick_firstcpu", cpumask_pick_firstcpu_setup);
> +
>  static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
>  
>  /**
> @@ -171,6 +188,13 @@ unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
>  {
>  	unsigned int next, prev;
>  
> +	/*
> +	 * Don't distribute, if tasks distribution
> +	 * within cpumask feature is disabled
> +	 */
> +	if (cpumask_pick_firstcpu)
> +		return cpumask_any_and(src1p, src2p);

No, this is a wrong way.

To begin with, this parameter shouldn't control a single random
function. At least, the other cpumask_*_distribute() should be
consistent to the policy.

But in general... I don't think we should do things like that at all.
Cpumask API is a simple and plain wrapper around bitmaps. If you want
to modify a behavior of the scheduler, you could do that at scheduler
level, not in a random helper function.

Consider 2 cases:
 - Someone unrelated to scheduler would use the same helper and will
   be affected by this parameter inadvertently.
 - Scheduler will switch to using another function to distribute CPUs,
   and your setups will suddenly get broken again. This time deeply in
   production.

Thanks,
Yury

>  	/* NOTE: our first selection will skip 0. */
>  	prev = __this_cpu_read(distribute_cpu_mask_prev);
>  
> -- 
> 2.23.1

