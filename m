Return-Path: <linux-kernel+bounces-133270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC30889A17C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16175B25F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5916FF38;
	Fri,  5 Apr 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5nmgsGi"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1CA16F913
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331538; cv=none; b=tK510FjbBORAfdCctu3Y835CJezmOCuJMERvG0ZaI4hgoRDwQAuG1Mz9d0JWbUobZcI+5LnD/ZwgMxF/PjBveVvDHqYPEv91rRfWzSzakzQS7YaTVBT0AUHGBSNGsFSZtBiG2AqTQ6l47MIPaPKzuHmkb4xTtDkV3zPR1Tr6nR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331538; c=relaxed/simple;
	bh=Tic1WNEg90YNrFORV1EX7zm/FNqZsVZMCwTaIPzjXpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goj3J8Mx7jMSgMgeAiBKP1h6vrwDkuHiYw0jhsZPunxRwFTYRvbHSqC18zt2uFTH7CQMJIMkpN6vfneU/FjK/DoOI82s4U4r/QRm6afVHzh8NKf6RydP/as9P7i5Nu7Z66Vk4HKgNtD2BXGutStn8lBT2wDtiQj84iJeZ114hVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5nmgsGi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e244c7cbf8so20654955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331536; x=1712936336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4rD6dVqbf1PJQHXwURYrs04mDaFA4hXPWbjscqFp7k=;
        b=T5nmgsGiyxnkRTkiEJAOXn4mKI/rTVUFC2ddGliuDpAmDyxHDKVMkPbj+DPFA/lYNX
         7EDucBTTk4mdeAlOk30k7HIFEnskL1ofk+L47CbHusteEG9/nq6rCyUHYb/e+YSq4GAD
         8x0KhMGpwcXy/m7c6UDBfc22iMRzWXD1lrSODqwmOjKb3haGZTxnsBIfbB9AcudtkcMW
         nFgejy0CS3y55ZaUQvvC8V9i9BigAuI6rlZVILoL8WMJmnLPvXFsFS26MI/vq+mAMZiU
         QZTtSOZDBmq1hSIMdrGJ5MnuKCWQKiQPXJ4bi3DH5SUGFLqxMcrAznNXNXZPzkfDu99O
         X39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331536; x=1712936336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4rD6dVqbf1PJQHXwURYrs04mDaFA4hXPWbjscqFp7k=;
        b=QouELe+qbHdKY268liSxu3Dvai3x4wUGF/N9Kroel4HNPVDBQZ5IUhe+xoyUnP89aq
         DHdwrliG71IjuPLdqNgyXIvR0tr1XXuPcgZ3nOy68HAWTpIc0vQci2HSaTPhwMiFkZ0U
         SN4ItNhwXoego/XPXRxo/0gediVL3NKEDs0lihpIoxMzq0gqLlWtGIQj3JdDNr28IeOz
         W0HBvJlZHOEu9qXyFQyOjw7oZ0dQizexJWBUo+yrsyqqJlh4RNi+BpGeskQlhssn3czJ
         2n9PaJJtXgNMT43wQHWq+ATk+VnjmLPBi7pGmpOl+oZIRaSD/V2obDxufGs3TZbx9Bss
         sgIw==
X-Forwarded-Encrypted: i=1; AJvYcCUpnpTZ6rmhnz84rxKvyt6+GBh56iwjRgyZgW1H4cmfWA4wZK9EHEkpv70cX3HqFbkqw9XpYIEIMRoI/pZkQpCiMMGPeyKj3KT33+Pf
X-Gm-Message-State: AOJu0YzfTvypG929VWlgdbxTbxOYU7mti9r6EaY2Ugz9fBBJj26hbBUP
	MmORuKLRkfnj5mXPyf63e6VpTAmLAywFq+gycoJpfzFfRx1gaj4j
X-Google-Smtp-Source: AGHT+IFo0zC3KsZmNW08j7cfYnJs6CuNwXtZ4Vbzt0R/OgeMigiCL+n4yQF6Wh5+1WOUF7oYpipZ8w==
X-Received: by 2002:a17:902:f343:b0:1e0:b5d4:9f60 with SMTP id q3-20020a170902f34300b001e0b5d49f60mr1407595ple.28.1712331536096;
        Fri, 05 Apr 2024 08:38:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:25ab])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001defa2d8e22sm1706707plh.233.2024.04.05.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:38:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 5 Apr 2024 05:38:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on
 queue_delayed_work
Message-ID: <ZhAbDkzlKhvHee49@slm.duckdns.org>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
 <20240405140449.GB22839@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405140449.GB22839@redhat.com>

Hello, Oleg.

On Fri, Apr 05, 2024 at 04:04:49PM +0200, Oleg Nesterov wrote:
..
> > > Don't some archs allow the boot CPU to go down too tho? If so, this doesn't
> > > really solve the problem, right?
> >
> > I do not know. But I thought about this too.
> >
> > In the context of this discussion we do not care if the boot CPU goes down.
> > But we need at least one housekeeping CPU after cpu_down(). The comment in
> > cpu_down_maps_locked() says
> >
> > 	Also keep at least one housekeeping cpu onlined
> >
> > but it checks HK_TYPE_DOMAIN, and I do not know (and it is too late for me
> > to try to read the code ;) if housekeeping.cpumasks[HK_TYPE_TIMER] can get
> > empty or not.
> 
> This nearly killed me, but I managed to convince myself we shouldn't worry

Oh no, don't die. :)

> about cpu_down().
> 
> HK_FLAG_TIMER implies HK_FLAG_TICK.
> 
> HK_FLAG_TICK implies tick_nohz_full_setup() which sets
> tick_nohz_full_mask = non_housekeeping_mask.
> 
> When tick_setup_device() is called on a housekeeping CPU it does
> 		
> 	else if (tick_do_timer_boot_cpu != -1 &&
> 					!tick_nohz_full_cpu(cpu)) {
> 		tick_take_do_timer_from_boot();
> 		tick_do_timer_boot_cpu = -1;
> 
> 
> 	and this sets tick_do_timer_cpu = first-housekeeping-cpu.
> 
> cpu_down(tick_do_timer_cpu) will fail, tick_nohz_cpu_down() will nack it.
> 
> So cpu_down() can't make housekeeping.cpumasks[HK_FLAG_TIMER] empty and I
> still think that the change below is the right approach.
> 
> But probably WARN_ON() in housekeeping_any_cpu() makes sense anyway.

This would be great.

> What do you think?
> 
> Oleg.
> 
> > > > So it seems that we should fix housekeeping_setup() ? see the patch below.
> > > >
> > > > In any case the usage of cpu_present_mask doesn't look right to me.
> > > >
> > > > Oleg.
> > > >
> > > > --- a/kernel/sched/isolation.c
> > > > +++ b/kernel/sched/isolation.c
> > > > @@ -129,7 +154,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
> > > >  	cpumask_andnot(housekeeping_staging,
> > > >  		       cpu_possible_mask, non_housekeeping_mask);
> > > >
> > > > -	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
> > > > +	if (!cpumask_test_cpu(smp_processor_id(), housekeeping_staging)) {
> > > >  		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
> > > >  		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
> > > >  		if (!housekeeping.flags) {

Ensuring the boot CPU always be a housekeeping CPU makes sense to me but I'm
not very familiar with the housekeeping code. Frederic, what do you think?

Thanks.

-- 
tejun

