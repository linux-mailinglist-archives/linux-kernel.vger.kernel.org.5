Return-Path: <linux-kernel+bounces-124212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE318913F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91801F22284
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3DA3D0BD;
	Fri, 29 Mar 2024 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbO34wRk"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB983987C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695343; cv=none; b=WHnSAKjCbpd6TMNrmTE6v2WgZDD9M64ZX/TyXmdQdwrT4UmMrqofczqvD5t8N+C9PRgkp8ElbnYINs5apdXbyKawXby+LgyBsqaNG6r7aZimZVO8MZV41Ga/EkiwZSWuPIkutMW7GnfYWnDWESxTqCAXbPiHRA0+otHWPqTDTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695343; c=relaxed/simple;
	bh=QXQbiJnVVa1eSAjv8dHnFmXNrGsbCLTt4hN3GgvVsdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCgivYPuwclP3KLJrPcxS8Rn3OJQyFIZ9dV3nNerw5FzKWw9ibklAk6X2cua7DQoRiSRn+0CjPpSblSa9DV5RmA2dMre1wmHduftbMXQqYYddPlQFJFRX89FlUIdziqpsdI2bW9Gx2PA7IWV8cOeWBHj3wnMSVBiFUvl71NrlRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbO34wRk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so2544407a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711695340; x=1712300140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMeupN57k+guyfuZ3NeW4qlxluCzfk8RG0ERUbR5V0s=;
        b=jbO34wRkh9Q+A6Br9Oh8FJAehUawHDilVNQiN3Kdi9OXbMoUnzcyGfsyJU1lW2xXMS
         lPTJ/EUQTiovemFONGL8PHZCQFEPlgBPGfpDNRrhYlsnwPt2apfDcST85jFnrII++ibB
         ZvlOGI8r10k1bmLOS5Jw3gF5/cuGc0XHeM6IqYS5xCjtf4Hgb9chG4ZEsUi7o9+nLFgF
         InK0F+9eiCUCTJMRATTm7xcZbwtwnHjmva8P65QLuWM4ffBsqSfuD90uCeAstjjjLuhN
         gHlEemXZZ7OFhfKT/+A+v7DnPBXP0SJRYoDgdCGsTm2xUR6mJQrUhm6axyKSrg7oFrbd
         P0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711695340; x=1712300140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMeupN57k+guyfuZ3NeW4qlxluCzfk8RG0ERUbR5V0s=;
        b=ezBaE8QlnyRORwV3J+6gziWprExLTh1bKMYFbrjANGBZqfrpKhVLxbt2GSTKYSazPe
         yOJYGuPhN69MQnSqeueXygow5DY+MQRRldayEO8M+Marh96zoglMrkF/HCitBvqbnZKK
         ZSqOJxHdT1mIZ8ChHzV/C6aFPr5tE9c/IW0HpwudWrSxbpqF36MUXJdlh9Xe4GtMfBd9
         f6fYTcX6eUANRLb8ScVBWfEzNwIMt0DO8MiHmVLl3bAwbAlIlY3qw1G+htlOfAPI4aST
         kk0Glh9/2vRJuBLx93ZmWN8RxKAhu4yQ6vUc4WjWZ0HbtnetZb/jtjXPI/d+Kf/3Xzz9
         Puog==
X-Forwarded-Encrypted: i=1; AJvYcCVKWl+ZoKIQCV84D4rxXwaMXBy5VBEozpnbPxyJkzfP3ka/pEOYBOSA15HJ1/zCXDT2Yyog0PPBt0fP6q8NzzDIbXK9aeLIULubh8wz
X-Gm-Message-State: AOJu0Yyzjz8hQ2fnXWqAMfSyNMbOOLVQ4tUnKGvE1yA5bPxNOlX/e7Q6
	XnPnUY2Nbymg5L/deOLXACPTOoVw+NJ1/+/qcRhWq3CbQNGXHM+U
X-Google-Smtp-Source: AGHT+IHAr/YKKAu+41XS4sl7fbBqHyUQYiJJ9dPCh2WBOaN1DEC3PEhhhF1mrxbsS5k3SoMCk45VDw==
X-Received: by 2002:a50:aac4:0:b0:568:d315:b85e with SMTP id r4-20020a50aac4000000b00568d315b85emr718358edc.36.1711695339269;
        Thu, 28 Mar 2024 23:55:39 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id fi8-20020a056402550800b0056c509a11acsm1664470edb.33.2024.03.28.23.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:55:38 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 Mar 2024 07:55:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, qyousef@layalina.io,
	linux-kernel@vger.kernel.org, vschneid@redhat.com
Subject: Re: [PATCH v3 0/2] sched: Minor changes for rd->overload access
Message-ID: <ZgZl6JuEccBa2XT5@gmail.com>
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
 <ZgFTtAOw39tIyfzR@gmail.com>
 <3c92c18b-6a19-4477-9972-1219c29b3d71@linux.ibm.com>
 <ZgKApcWeuwxc2+WO@gmail.com>
 <38c39ea6-21df-44e9-96e7-6f6fd35822a7@linux.ibm.com>
 <ZgVHq65XKsOZpfgK@gmail.com>
 <ZgVPhODZ8/nbsqbP@gmail.com>
 <0b5a4432-384c-4470-a7b6-6fcaf8c28236@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b5a4432-384c-4470-a7b6-6fcaf8c28236@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> 
> 
> On 3/28/24 4:37 PM, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> >> Plus I've applied a patch to rename ::overload to ::overloaded. It is 
> >> silly to use an ambiguous noun instead of a clear adjective when naming 
> >> such a flag ...
> > 
> > Plus SG_OVERLOAD should be SG_OVERLOADED as well - it now looks in line 
> > with SG_OVERUTILIZED:
> > 
> >  /* Scheduling group status flags */
> >  #define SG_OVERLOADED           0x1 /* More than one runnable task on a CPU. */
> >  #define SG_OVERUTILIZED         0x2 /* One or more CPUs are over-utilized. */
> > 
> > My followup question is: why are these a bitmask, why not separate 
> > flags?
> > 
> > AFAICS we only ever set them separately:
> > 
> >  thule:~/tip> git grep SG_OVER kernel/sched/
> >  kernel/sched/fair.c:            set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
> >  kernel/sched/fair.c:                    *sg_status |= SG_OVERLOADED;
> >  kernel/sched/fair.c:                    *sg_status |= SG_OVERUTILIZED;
> >  kernel/sched/fair.c:                            *sg_status |= SG_OVERLOADED;
> >  kernel/sched/fair.c:            set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
> >  kernel/sched/fair.c:                                       sg_status & SG_OVERUTILIZED);
> >  kernel/sched/fair.c:    } else if (sg_status & SG_OVERUTILIZED) {
> >  kernel/sched/fair.c:            set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
> >  kernel/sched/sched.h:#define SG_OVERLOADED              0x1 /* More than one runnable task on a CPU. */
> >  kernel/sched/sched.h:#define SG_OVERUTILIZED            0x2 /* One or more CPUs are over-utilized. */
> >  kernel/sched/sched.h:           set_rd_overloaded(rq->rd, SG_OVERLOADED);
> > 
> > In fact this results in suboptimal code:
> > 
> >                 /* update overload indicator if we are at root domain */
> >                 set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
> >                         
> >                 /* Update over-utilization (tipping point, U >= 0) indicator */
> >                 set_rd_overutilized_status(env->dst_rq->rd,
> >                                            sg_status & SG_OVERUTILIZED);
> > 
> > Note how the bits that got mixed together in sg_status now have to be 
> > masked out individually.
> > 
> > The sg_status bitmask appears to make no sense at all to me.
> > 
> > By turning these into individual bool flags we could also do away with 
> > all the extra SG_OVERLOADED/SG_OVERUTILIZED abstraction.
> > 
> > Ie. something like the patch below? Untested.
> 
> Looks good. I see it is merged to sched/core. 
> Did a boot with that patch and hackbench is showing same results 320 CPU system.

Thanks, I've added:

    Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>
    Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>

And applied the additional docbook fix below on top as well.

Thaks,

	Ingo

=================>
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ebc8d5f855de..1dd37168da50 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9933,7 +9933,8 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
  * @sds: Load-balancing data with statistics of the local group.
  * @group: sched_group whose statistics are to be updated.
  * @sgs: variable to hold the statistics for this group.
- * @sg_status: Holds flag indicating the status of the sched_group
+ * @sg_overloaded: sched_group is overloaded
+ * @sg_overutilized: sched_group is overutilized
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
 				      struct sd_lb_stats *sds,

