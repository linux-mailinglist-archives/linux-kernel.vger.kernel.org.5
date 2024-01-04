Return-Path: <linux-kernel+bounces-17182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487582493A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848ACB21BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF472C1BC;
	Thu,  4 Jan 2024 19:47:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA32C19E;
	Thu,  4 Jan 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59629f0f67aso119115eaf.0;
        Thu, 04 Jan 2024 11:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397650; x=1705002450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YPpasLIRq1YN3KdZH5r1q0RRJLitmfKfle8fM0qQes=;
        b=Sl/ITVYBcj4e+ovkmJfCuSNpX2thd5HXGrL6yKwXmj5g76rcHN+cyljqtZcNvSdDee
         Mivvfy0O0PB9/ZErx7YcG/e3uZPevD/4nIMhTbt/wWCUZF+iAr4cmPyxMLGQ0aLImwuD
         s6xluKkhEJb/NvgrPpBiM9YixCmR3M3WMayR8FJHhUVrLnwGFS4/ZjOg6VGGB0fOXCRN
         QpOJRCPj2A+TmblGx9QXWcHj0VBl/PcBKFXpsteEQZQhZTqUMPdHgIPl0ZcHGLHka1V5
         Q0Ot507lcgyUy3Lcxbez4IJUJSymOhYz8XX011NPQ08QoKhDeTkIEA7H7MS0Hyprm2wR
         4ciw==
X-Gm-Message-State: AOJu0Yy9RMzXWJELJncRosfRoxe1iYjPz1HKf2DkWvtn1LG2f9gJn5Aa
	lf9WmFkHt/1CNwUUidoAO+zmJ0Dp7l/gVU1Obm4=
X-Google-Smtp-Source: AGHT+IGa+PawcYliltEPtRGTiTs3GNq84Jl/X9dsA+kY7UlM3UrEE0U49Gy3usoA48yxV7YhsP81Ip1vEmUHGo2IY9I=
X-Received: by 2002:a4a:e70a:0:b0:596:27ee:455d with SMTP id
 y10-20020a4ae70a000000b0059627ee455dmr1950518oou.0.1704397650649; Thu, 04 Jan
 2024 11:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104171553.2080674-1-lukasz.luba@arm.com> <20240104171553.2080674-12-lukasz.luba@arm.com>
In-Reply-To: <20240104171553.2080674-12-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 20:47:19 +0100
Message-ID: <CAJZ5v0hqRkDmhRBfB4g-2EH2piv-KOQdwad7rVoSK8FzZKg=TA@mail.gmail.com>
Subject: Re: [PATCH v6 11/23] PM: EM: Add API for updating the runtime
 modifiable EM
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com, 
	amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org, 
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, 
	wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I don't really like using the API TLA in patch subjects, because it
does not really say much.  IMO a subject like this would be better:

"PM: EM: Introduce em_dev_update_perf_domain() for EM updates"

On Thu, Jan 4, 2024 at 6:15=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> Add API function em_dev_update_perf_domain() which allows to safely
> change the EM.

"... which allows the EM to be changed safely."

New paragraph:

> The concurrent modifiers are protected by the mutex
> to serialize them. Removal of the old memory is asynchronous and
> handled by the RCU mechanisms.

"Concurrent updaters are serialized with a mutex and the removal of
memory that will not be used any more is carried out with the help of
RCU."

>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h |  8 +++++++
>  kernel/power/energy_model.c  | 41 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 753d70d0ce7e..f33257ed83fd 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -183,6 +183,8 @@ struct em_data_callback {
>
>  struct em_perf_domain *em_cpu_get(int cpu);
>  struct em_perf_domain *em_pd_get(struct device *dev);
> +int em_dev_update_perf_domain(struct device *dev,
> +                             struct em_perf_table __rcu *new_table);
>  int em_dev_register_perf_domain(struct device *dev, unsigned int nr_stat=
es,
>                                 struct em_data_callback *cb, cpumask_t *s=
pan,
>                                 bool microwatts);
> @@ -376,6 +378,12 @@ struct em_perf_table __rcu *em_allocate_table(struct=
 em_perf_domain *pd)
>         return NULL;
>  }
>  static inline void em_free_table(struct em_perf_table __rcu *table) {}
> +static inline
> +int em_dev_update_perf_domain(struct device *dev,
> +                             struct em_perf_table __rcu *new_table)
> +{
> +       return -EINVAL;
> +}
>  #endif
>
>  #endif
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index bbc406db0be1..496dc00835c6 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -220,6 +220,47 @@ static int em_allocate_perf_table(struct em_perf_dom=
ain *pd,
>         return 0;
>  }
>
> +/**
> + * em_dev_update_perf_domain() - Update runtime EM table for a device
> + * @dev                : Device for which the EM is to be updated
> + * @table      : The new EM table that is going to be used from now

This is called "new_table" below.

> + *
> + * Update EM runtime modifiable table for the @dev using the provided @t=
able.
> + *
> + * This function uses mutex to serialize writers, so it must not be call=
ed

"uses a mutex"

> + * from non-sleeping context.

"a non-sleeping context".

> + *
> + * Return 0 on success or a proper error in case of failure.

It is not clear what "a proper error" means.  It would be better to
simply say "or an error code on failure" IMO.

> + */
> +int em_dev_update_perf_domain(struct device *dev,
> +                             struct em_perf_table __rcu *new_table)
> +{
> +       struct em_perf_table __rcu *old_table;
> +       struct em_perf_domain *pd;
> +
> +       /* Serialize update/unregister or concurrent updates */
> +       mutex_lock(&em_pd_mutex);
> +
> +       if (!dev || !dev->em_pd) {

dev need not be checked under the lock.

> +               mutex_unlock(&em_pd_mutex);
> +               return -EINVAL;
> +       }
> +       pd =3D dev->em_pd;
> +
> +       em_table_inc(new_table);
> +
> +       old_table =3D pd->em_table;
> +       rcu_assign_pointer(pd->em_table, new_table);
> +
> +       em_cpufreq_update_efficiencies(dev, new_table->state);
> +
> +       em_table_dec(old_table);
> +
> +       mutex_unlock(&em_pd_mutex);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
> +
>  static int em_create_runtime_table(struct em_perf_domain *pd)
>  {
>         struct em_perf_table __rcu *table;
> --

