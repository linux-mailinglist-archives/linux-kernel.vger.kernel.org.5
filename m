Return-Path: <linux-kernel+bounces-12815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED781FA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8BF1C21550
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA88F9E5;
	Thu, 28 Dec 2023 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="W7AjGhbW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923AF9CA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d5b89e2bfso21121755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703784778; x=1704389578; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dF9C92RFiM0uMpz4TXaSY90Z5FfObpNGK3ZwhCMW8wg=;
        b=W7AjGhbWDrEkVSNC/RqB7XplM6hEc0rXU6K/yv2ASYY5lfjvc1AT+5/HjWCGPPNZ3P
         i/4SWX2y3VU48EAGOxPDXDlcNdN0qz7wnmr+xxfspNADIa2KQahYiWSMoWLuJJn9paQN
         bY3QoVq4ZkwYIrAJKZWoLeUuWTNGsQJFyxVSexh7c/9YWWF1KIIQlyX5TYKej9TpnZHF
         OWRN/5zZkez6OdM7cOzVBv6YhJIVVxmIj2fZWeLdd2PK3CaEN1INq75YburjuRc9qKII
         dZGF13Etix/QJoBnHugU+I46uMwq+0FQzubgKk0btxzNti1/WB1Hoh6c1wbUP1yWCT2f
         rSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703784778; x=1704389578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dF9C92RFiM0uMpz4TXaSY90Z5FfObpNGK3ZwhCMW8wg=;
        b=CebL45LbKfMysuElkGlEpIJxA4so4t+Fl4dKsp8+qEZx1ltnTr+Mm9IgjwLlWQdBdr
         NUuhU6+hJSNxQ51wv8rRq9iuLQmmJlaQNdCjC347/1Z9BiExeZXKvc+HL3INdN5EXAqO
         iKLZl5yHwijwu8AGoPcnrz2HpNOm2bVUqGLiWSddwjMSgEDyQEZkYQKHO2qL+1Z3n7Pj
         L+acc2YW5IrKyF6lrJZeVMOY1m63tW3J5kRzX0e2zv0ZhMnWCkNuH+oedOqtcoDF0a+j
         j3J4AquBHj1fwbYubN5mkIzKRgaD9VJZdwudM1Z5zaR4nBpYCCr9AQNh6tO9nQqhywSl
         ngkQ==
X-Gm-Message-State: AOJu0YyjjCFNs7xbNGtP1DoJBEpmgo/hR9nFdNzxlhvr8iffYFPwO5pb
	oLIv1JIiROPu7yTbMNtKtaJvn3WIojx0uQ==
X-Google-Smtp-Source: AGHT+IEoVcHRZN247qbioInl2CgJl16iYloAaIp5hy6xNF66O7hkW66wH4NmOT4A2LdWUr+fpaKvdw==
X-Received: by 2002:a05:600c:c06:b0:40d:6e04:6ee2 with SMTP id fm6-20020a05600c0c0600b0040d6e046ee2mr583101wmb.113.1703784778422;
        Thu, 28 Dec 2023 09:32:58 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c34c300b0040d5a4865casm9792305wmq.36.2023.12.28.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 09:32:58 -0800 (PST)
Date: Thu, 28 Dec 2023 17:32:56 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael@kernel.org,
	dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 09/23] PM: EM: Use runtime modified EM for CPUs energy
 estimation in EAS
Message-ID: <20231228173256.kepuwwimb4b2osew@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-10-lukasz.luba@arm.com>
 <20231217175923.wxmfocgckpaytptb@airbuntu>
 <CAB8ipk_5TjUTrZ-nrGAwYMugLJFF72MvvRDzPJqaCayNwCm1wg@mail.gmail.com>
 <1ccd7a20-0479-46f7-a968-57a18f0c0152@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ccd7a20-0479-46f7-a968-57a18f0c0152@arm.com>

On 12/19/23 08:32, Lukasz Luba wrote:
> Hi Qais and Xuewen,
> 
> On 12/19/23 04:03, Xuewen Yan wrote:
> > On Mon, Dec 18, 2023 at 1:59 AM Qais Yousef <qyousef@layalina.io> wrote:
> > > 
> > > On 11/29/23 11:08, Lukasz Luba wrote:
> > > > The new Energy Model (EM) supports runtime modification of the performance
> > > > state table to better model the power used by the SoC. Use this new
> > > > feature to improve energy estimation and therefore task placement in
> > > > Energy Aware Scheduler (EAS).
> > > 
> > > nit: you moved the code to use the new runtime em table instead of the one
> > > parsed at boot.
> > > 
> > > > 
> > > > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > > ---
> > > >   include/linux/energy_model.h | 16 ++++++++++++----
> > > >   1 file changed, 12 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > > > index 1e618e431cac..94a77a813724 100644
> > > > --- a/include/linux/energy_model.h
> > > > +++ b/include/linux/energy_model.h
> > > > @@ -238,6 +238,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> > > >                                unsigned long max_util, unsigned long sum_util,
> > > >                                unsigned long allowed_cpu_cap)
> > > >   {
> > > > +     struct em_perf_table *runtime_table;
> > > >        unsigned long freq, scale_cpu;
> > > >        struct em_perf_state *ps;
> > > >        int cpu, i;
> > > > @@ -255,7 +256,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> > > >         */
> > > >        cpu = cpumask_first(to_cpumask(pd->cpus));
> > > >        scale_cpu = arch_scale_cpu_capacity(cpu);
> > > > -     ps = &pd->table[pd->nr_perf_states - 1];
> > > > +
> > > > +     /*
> > > > +      * No rcu_read_lock() since it's already called by task scheduler.
> > > > +      * The runtime_table is always there for CPUs, so we don't check.
> > > > +      */
> > > 
> > > WARN_ON(rcu_read_lock_held()) instead?
> > 
> > I agree, or SCHED_WARN_ON(!rcu_read_lock_held()) ?
> 
> I disagree here. This is a sched function in hot path and as comment

WARN_ON() is not a sched function.

> says:
> 
> -----------------------
>  * This function must be used only for CPU devices. There is no validation,
>  * i.e. if the EM is a CPU type and has cpumask allocated. It is called from
>  * the scheduler code quite frequently and that is why there is not checks.
> -----------------------
> 
> We don't have to put the checks or warnings everywhere in the kernel
> functions. Especially hot one like this one.

When checks are necessary, there are ways even for hot paths.

> 
> As you might not notice, we don't even check if the pd->cpus is not NULL

rcu_read_lock_held() is only enabled for lockdebug build and it's the standard
way to document and add verification to ensure locking rules are honoured. On
non lockdebug build this will be compiled out.

You had to put a long comment to ensure locking rules are correct, why not
use existing infrastructure instead to provide better checks and inherent
documentation?

We had a bug recently where the rcu_read_lock() was moved and this broke some
function buried down in the call stack. So subtle code shuffles elsewhere can
cause unwanted side effects; and it's hard to catch these bugs.

	https://lore.kernel.org/stable/20231009130130.210024505@linuxfoundation.org/

