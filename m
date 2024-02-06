Return-Path: <linux-kernel+bounces-55240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF09C84B980
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4971F258AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477181350D8;
	Tue,  6 Feb 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="bOZr2nez"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A221350C7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233100; cv=none; b=MhOFweYlR2xaaEB4lRZXczkk+MJMbkl+S+ApLImh5B0z37U4DxZcecBN4WceMMlgnDzUxmcn4xPBN/jEeur/UTlEmHdu3lvuiiLTbRF0hPFN43RwIdTiEjZL8o7F2H/9ZrHrlqFsuVOlUJ4ItY0UAv+Qtn1+b96iUycAJw3yN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233100; c=relaxed/simple;
	bh=fPBcXEBOYEvNiJGGuWwzLCGt9M0ntx4QAPdAwviiUP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV6kqcihfKI9UjHPYhgYXn45JE3o4Bkyk4E/OfAcoH7ZpOP8CKSSBoS7UoiD2VUYJRvHTZ+62U1pE2xTmVG9Vg+xGZulZbr6nAcEvAyvbjNBh4i7V7rDE6HuP+6o1iD8r/MKpLVRJTaP34FgJQDQDWvezqGcQtc2D0h6VcbIbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=bOZr2nez; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so22827425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707233097; x=1707837897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8iG1nEjZ34xJAHn3HtL9ZdlAEvsHwQNdGlCa0tB85Y=;
        b=bOZr2nezSuBcmc4mXKyKcbwcAVQ5hxTs1AQCst26s0c5wZNWYGT4ZccvqJQg7WTFqP
         clWPwc3/oRS0nsXq6H5AkTGJXsllfEIQNN6PuaWiAM8abqf20o6Jpb3QDMBmuSyMDTcu
         CO2tpOgvigbQkIZ/LPV/TqakHginr3ZqaPAN+u408HNlw3pL/0+CPG+M5/3a4JxSfIe1
         F+0tXf4EyvzFpC+Lzh4IHLWjBfrc7vOCDv4EaxFEv8PoyjsTpzwy2Dg6AKiY0Q8QuOsA
         Y16zMyxIl1bm9TwbcTcFsJSocOsjTWvck2OiER40zoG4HdKaIZtV5Ij7rfgOd30ulavO
         7lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233097; x=1707837897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8iG1nEjZ34xJAHn3HtL9ZdlAEvsHwQNdGlCa0tB85Y=;
        b=p2hQkwIqqLAOJ6/dJGvW9eBOKpXPX/zO92nMD0v42FNSCCiVy9N8nY1KyM6bEQlPGx
         mR7z0XWF+VUdW7UUdPyAp/zcgX8wGAMgf4XgBfYdSsq2qTZmjSuTc94GFSr9bAvoYekt
         lt0BDx3GUaSDB0yAoVuXjaFLpxvGYpcG3Te3i3gSBPNwhSJUASX1NVYI2wXgx9nNrTbc
         2+FPnaEVDAbYHXZtxZjeEMEw97XzMjFOXV/nLdcnTsjWGKIEa07ArJFlVB5drxBzFobk
         57QFhf4PdpZjS5WUHKaGUPM4fjQr7xzhba0U4tAWqezCpsWT0G07GM4+M7XyY4zNaLZj
         +wdg==
X-Gm-Message-State: AOJu0YzmLbvHGyT7CEd5KuVrlNfNyTe4RvQEpe8N/+ykXMQ4TVilxbtd
	9lb80/+ShkVlrjFdbQmGbJQZtzBM4NB4dvCsD8mfYqsK1ygAvdsuIf5K33e9ll0=
X-Google-Smtp-Source: AGHT+IFh1zUDupYpmqf88PGzN/Evm8d5pQuCZQQpD7egPpMsrigldHcg7ut9PUYlVkzUlKrGc19ZpA==
X-Received: by 2002:a05:600c:1e1a:b0:40f:f069:8d13 with SMTP id ay26-20020a05600c1e1a00b0040ff0698d13mr799812wmb.9.1707233097002;
        Tue, 06 Feb 2024 07:24:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUtunWavw8gAgO9dEBzl64aQn0m94Dqvwi4euv3JMFmWb4AZEc5QkAHjbr+TVw0+NcpwOWu369Nff8JNFIliit3ZwXOm7MUcdbtbD6B74TTI90Vq++pIuu+4PO4G2yl7+LxQXh0+RVEszHnvnH1EVaQKOcNV7h4oNxPVy3wt412nNMVfrA7Vi7/4wdXkdMFyCrH2gVrn22tsWq7yTTr+DcsbkJ/lc6YsGg7Rs+C8uVAig==
Received: from airbuntu (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040e813f1f31sm2379003wmf.25.2024.02.06.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:24:56 -0800 (PST)
Date: Tue, 6 Feb 2024 15:24:55 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Hillf Danton <hdanton@sina.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v5 2/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240206152455.xvtlyuvmkaja3xr4@airbuntu>
References: <20240205021123.2225933-1-qyousef@layalina.io>
 <20240206105530.763-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206105530.763-1-hdanton@sina.com>

On 02/06/24 18:55, Hillf Danton wrote:

> > +/*
> > + * Check the max capacity the task is allowed to run at for misfit detection.
> > + */
> > +static void set_task_max_allowed_capacity(struct task_struct *p)
> > +{
> > +	struct asym_cap_data *entry;
> > +
> > +	if (!sched_asym_cpucap_active())
> > +		return;
> > +
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> > +		cpumask_t *cpumask;
> > +
> > +		cpumask = cpu_capacity_span(entry);
> > +		if (!cpumask_intersects(p->cpus_ptr, cpumask))
> > +			continue;
> > +
> > +		p->max_allowed_capacity = entry->capacity;
> > +		break;
> 
> Given what max_allowed_capacity could mean, it is needed to find the max
> capacity by iterating the asym_cap_list instead of the first capacity
> determined by the allowed CPU mask.

I don't think we can rely on that as there is no guarantee on the position of
the biggest CPU. We would have to iterate through every CPU in the mask instead
to figure out the one with the largest capacity. And we moved to this as
Vincent wasn't keen on assuming we have few CPUs and potentially not scaling on
systems with large number of CPUs. This list should be faster as the number of
capacity level is much smaller than the number of CPUs.

> > +	}
> > +	rcu_read_unlock();
> > +}
> 
> BTW is it working in case of systems with a super core?
> 
> 	cpu0-3	cpu4-6	cpu7
> 	little	big	super
> 	core	core	core

It should. Super here should have the capacity of 1024 and everything else
scaled relative to it like any other system with 3 tiers of capacities.

