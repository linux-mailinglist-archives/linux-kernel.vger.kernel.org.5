Return-Path: <linux-kernel+bounces-4658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64910818059
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6451C22B38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00425CB9;
	Tue, 19 Dec 2023 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvnG9E54"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6539522B;
	Tue, 19 Dec 2023 04:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f060e059a3so3159154fac.1;
        Mon, 18 Dec 2023 20:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702958619; x=1703563419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nl46Laaf5BxsrexhW0VqzTfPX9XGtBYJT5ohcciFkz4=;
        b=VvnG9E54D7b7O/Ol7uT9VkrSkrXr7VhVJo2cplSSIWc4YRZVaUcHA2lk1zKE4txSL4
         4FoiM9ZhqTX4QalcQbvTw9L+WNPzZNyTFcywbkev10pB+bmobzYMUl5I/TLEmEXyPAWt
         Rzn2qVpBbl1ApfXa213IT0+74VfG0WrXlykYMyHv1XyLU/ibwDOMnyWkkAiAKubBau11
         pjnOR0Bqv/Dnlu0qxtBmXxepDRV3oNohcYAPFJyFXmwW9b9zQc7p98sqkyf9DO6tK7Vf
         T6aqOhBgQGjjcGNnBDqFelXQER34MQ6da7yoFAatDAO1c5YddZChuG+SRZ3XJrpj5A13
         Fcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702958619; x=1703563419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nl46Laaf5BxsrexhW0VqzTfPX9XGtBYJT5ohcciFkz4=;
        b=UMg36zaznZb4yGumURBo6/DCQHcfhacpaFq0Bxy1N1JZJVPAIDt7Ms+8oNV/oYnmjY
         d7dwbxTtcDJNuUZtyO48kXck/bedY8L7IrbavU8HJ3oGXw5J91J3EGi38EQIIXMAYObj
         bJF+qw++C/iilXF113q9lerO9fGOyM9UyfFctEOJAliIXlAq4vCKm2HxJRPefC7EnzGM
         +KgQwfVMy+4ef2HFA/ResZE9OLp8gfabNRNvkrmBkvUwEl6jP3UlGp6hHlAs/nDb2T5e
         jiQKxEVqwYjSKipIos2nYPg70ZTRM4tSXupGmr9lHNEnGUGVD82SCp/pCnddTqzhYC+g
         paMA==
X-Gm-Message-State: AOJu0Yyc4bNUbFff0VAW5kTFk8etG5JjplfyhIbaw4r/FANN7mz163du
	dOOgTas63TrJ4tIjYkMZkaKqiS/z0IgfaZc/bJw=
X-Google-Smtp-Source: AGHT+IHI78ApR44WhF5zXGZj0dkyTeWRzgqJPpruDxQ6d6wP7WOlUcfPVqyb2IyEr7XVV10B1YvjdK6JypkmutV/2p0=
X-Received: by 2002:a05:6870:2327:b0:1fb:31a0:619c with SMTP id
 w39-20020a056870232700b001fb31a0619cmr21702223oao.47.1702958618637; Mon, 18
 Dec 2023 20:03:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129110853.94344-1-lukasz.luba@arm.com> <20231129110853.94344-10-lukasz.luba@arm.com>
 <20231217175923.wxmfocgckpaytptb@airbuntu>
In-Reply-To: <20231217175923.wxmfocgckpaytptb@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 19 Dec 2023 12:03:28 +0800
Message-ID: <CAB8ipk_5TjUTrZ-nrGAwYMugLJFF72MvvRDzPJqaCayNwCm1wg@mail.gmail.com>
Subject: Re: [PATCH v5 09/23] PM: EM: Use runtime modified EM for CPUs energy
 estimation in EAS
To: Qais Yousef <qyousef@layalina.io>
Cc: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael@kernel.org, dietmar.eggemann@arm.com, 
	rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com, 
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com, 
	pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 1:59=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 11/29/23 11:08, Lukasz Luba wrote:
> > The new Energy Model (EM) supports runtime modification of the performa=
nce
> > state table to better model the power used by the SoC. Use this new
> > feature to improve energy estimation and therefore task placement in
> > Energy Aware Scheduler (EAS).
>
> nit: you moved the code to use the new runtime em table instead of the on=
e
> parsed at boot.
>
> >
> > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > ---
> >  include/linux/energy_model.h | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.=
h
> > index 1e618e431cac..94a77a813724 100644
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -238,6 +238,7 @@ static inline unsigned long em_cpu_energy(struct em=
_perf_domain *pd,
> >                               unsigned long max_util, unsigned long sum=
_util,
> >                               unsigned long allowed_cpu_cap)
> >  {
> > +     struct em_perf_table *runtime_table;
> >       unsigned long freq, scale_cpu;
> >       struct em_perf_state *ps;
> >       int cpu, i;
> > @@ -255,7 +256,14 @@ static inline unsigned long em_cpu_energy(struct e=
m_perf_domain *pd,
> >        */
> >       cpu =3D cpumask_first(to_cpumask(pd->cpus));
> >       scale_cpu =3D arch_scale_cpu_capacity(cpu);
> > -     ps =3D &pd->table[pd->nr_perf_states - 1];
> > +
> > +     /*
> > +      * No rcu_read_lock() since it's already called by task scheduler=
.
> > +      * The runtime_table is always there for CPUs, so we don't check.
> > +      */
>
> WARN_ON(rcu_read_lock_held()) instead?

I agree, or SCHED_WARN_ON(!rcu_read_lock_held()) ?

>
>
> Cheers
>
> --
> Qais Yousef
>
> > +     runtime_table =3D rcu_dereference(pd->runtime_table);
> > +
> > +     ps =3D &runtime_table->state[pd->nr_perf_states - 1];
> >
> >       max_util =3D map_util_perf(max_util);
> >       max_util =3D min(max_util, allowed_cpu_cap);
> > @@ -265,9 +273,9 @@ static inline unsigned long em_cpu_energy(struct em=
_perf_domain *pd,
> >        * Find the lowest performance state of the Energy Model above th=
e
> >        * requested frequency.
> >        */
> > -     i =3D em_pd_get_efficient_state(pd->table, pd->nr_perf_states, fr=
eq,
> > -                                   pd->flags);
> > -     ps =3D &pd->table[i];
> > +     i =3D em_pd_get_efficient_state(runtime_table->state, pd->nr_perf=
_states,
> > +                                   freq, pd->flags);
> > +     ps =3D &runtime_table->state[i];
> >
> >       /*
> >        * The capacity of a CPU in the domain at the performance state (=
ps)
> > --
> > 2.25.1
> >
>

