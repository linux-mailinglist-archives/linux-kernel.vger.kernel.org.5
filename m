Return-Path: <linux-kernel+bounces-17145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A38248E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DF21C227DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8E2C1A1;
	Thu,  4 Jan 2024 19:18:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463732C190;
	Thu,  4 Jan 2024 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5962dd690d3so37948eaf.0;
        Thu, 04 Jan 2024 11:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395906; x=1705000706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmU6aKDRYLf17fij0V7tIgXas7RGhF4di9PC4dZzjFs=;
        b=ksKfF7vCBDx1p/gxSfKh8/W/0S14hrtnri6SRujxkxTTZswzucDw1LgOEyzpkXO4KU
         1RvA48qBdnY86kZ1JZaMf65wvyq36C9a95rULGAT5v80GrcfGiQoDMTN8BkNhpzZV0ea
         1/T74vXB31HyJbQgpyYwG1fZqMOtLbWMC8EaJmUeES/MOpyND5Pdautn/kOHmifRGzMP
         OBH6E5Znm6UhFLxKpRDq8OZdiJO36c9W9X50LAhvQngZ+nF52W0qsJe0jm8h40hMribm
         B61OIsW8AF3vr9ye2C66ch5fnv3B/Dlh6zfLUp9iZASRFKk4E6ILYyvnCivCUymRc2Di
         6gXg==
X-Gm-Message-State: AOJu0Yyr7sWYgTdHEyhEdiRFSLKe8wLAxFcZwgf4Raw+WtqyRqZyQnp0
	ns3YXcAbIZPVGQZBzRP6GAxmyxqCg2VOhcKs2sM=
X-Google-Smtp-Source: AGHT+IENyFl7pVfDbTb8kaYyTf58MJ3B+0Xon/2HfBDn27a3InOUpWq6YeEO26ImsdGN0KHhUPNvbNthL+Lv8P4xKxA=
X-Received: by 2002:a4a:a306:0:b0:596:2300:27b7 with SMTP id
 q6-20020a4aa306000000b00596230027b7mr2029793ool.1.1704395906263; Thu, 04 Jan
 2024 11:18:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104171553.2080674-1-lukasz.luba@arm.com> <20240104171553.2080674-8-lukasz.luba@arm.com>
In-Reply-To: <20240104171553.2080674-8-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 20:18:15 +0100
Message-ID: <CAJZ5v0jETcdATvjgULoGmr_g+cGA3=XWyCTjO1vkBZURCsGuLw@mail.gmail.com>
Subject: Re: [PATCH v6 07/23] PM: EM: Refactor how the EM table is allocated
 and populated
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com, 
	amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org, 
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, 
	wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The changelog actually sets what happens here, so why don't you put
that into the changelog too?  Something like: "Split the allocation
and initialization of the EM table"

On Thu, Jan 4, 2024 at 6:15=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> Split the process of allocation and data initialization for the EM table.
> The upcoming changes for modifiable EM will use it.
>
> This change is not expected to alter the general functionality.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 55 ++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 3c8542443dd4..e7826403ae1d 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -142,18 +142,26 @@ static int em_compute_costs(struct device *dev, str=
uct em_perf_state *table,
>         return 0;
>  }
>
> +static int em_allocate_perf_table(struct em_perf_domain *pd,
> +                                 int nr_states)
> +{
> +       pd->table =3D kcalloc(nr_states, sizeof(struct em_perf_state),
> +                           GFP_KERNEL);
> +       if (!pd->table)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
>  static int em_create_perf_table(struct device *dev, struct em_perf_domai=
n *pd,
> -                               int nr_states, struct em_data_callback *c=
b,
> +                               struct em_perf_state *table,
> +                               struct em_data_callback *cb,
>                                 unsigned long flags)
>  {
>         unsigned long power, freq, prev_freq =3D 0;
> -       struct em_perf_state *table;
> +       int nr_states =3D pd->nr_perf_states;
>         int i, ret;
>
> -       table =3D kcalloc(nr_states, sizeof(*table), GFP_KERNEL);
> -       if (!table)
> -               return -ENOMEM;
> -
>         /* Build the list of performance states for this performance doma=
in */
>         for (i =3D 0, freq =3D 0; i < nr_states; i++, freq++) {
>                 /*
> @@ -165,7 +173,7 @@ static int em_create_perf_table(struct device *dev, s=
truct em_perf_domain *pd,
>                 if (ret) {
>                         dev_err(dev, "EM: invalid perf. state: %d\n",
>                                 ret);
> -                       goto free_ps_table;
> +                       return -EINVAL;
>                 }
>
>                 /*
> @@ -175,7 +183,7 @@ static int em_create_perf_table(struct device *dev, s=
truct em_perf_domain *pd,
>                 if (freq <=3D prev_freq) {
>                         dev_err(dev, "EM: non-increasing freq: %lu\n",
>                                 freq);
> -                       goto free_ps_table;
> +                       return -EINVAL;
>                 }
>
>                 /*
> @@ -185,7 +193,7 @@ static int em_create_perf_table(struct device *dev, s=
truct em_perf_domain *pd,
>                 if (!power || power > EM_MAX_POWER) {
>                         dev_err(dev, "EM: invalid power: %lu\n",
>                                 power);
> -                       goto free_ps_table;
> +                       return -EINVAL;
>                 }
>
>                 table[i].power =3D power;
> @@ -194,16 +202,9 @@ static int em_create_perf_table(struct device *dev, =
struct em_perf_domain *pd,
>
>         ret =3D em_compute_costs(dev, table, cb, nr_states, flags);
>         if (ret)
> -               goto free_ps_table;
> -
> -       pd->table =3D table;
> -       pd->nr_perf_states =3D nr_states;
> +               return -EINVAL;
>
>         return 0;
> -
> -free_ps_table:
> -       kfree(table);
> -       return -EINVAL;
>  }
>
>  static int em_create_pd(struct device *dev, int nr_states,
> @@ -234,11 +235,15 @@ static int em_create_pd(struct device *dev, int nr_=
states,
>                         return -ENOMEM;
>         }
>
> -       ret =3D em_create_perf_table(dev, pd, nr_states, cb, flags);
> -       if (ret) {
> -               kfree(pd);
> -               return ret;
> -       }
> +       pd->nr_perf_states =3D nr_states;
> +
> +       ret =3D em_allocate_perf_table(pd, nr_states);
> +       if (ret)
> +               goto free_pd;
> +
> +       ret =3D em_create_perf_table(dev, pd, pd->table, cb, flags);
> +       if (ret)
> +               goto free_pd_table;
>
>         if (_is_cpu_device(dev))
>                 for_each_cpu(cpu, cpus) {
> @@ -249,6 +254,12 @@ static int em_create_pd(struct device *dev, int nr_s=
tates,
>         dev->em_pd =3D pd;
>
>         return 0;
> +
> +free_pd_table:
> +       kfree(pd->table);
> +free_pd:
> +       kfree(pd);
> +       return -EINVAL;
>  }
>
>  static void
> --

The code changes LGTM.

