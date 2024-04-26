Return-Path: <linux-kernel+bounces-160524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E18B3EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE073284405
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7AB168B06;
	Fri, 26 Apr 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT13YVuA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3D762EF;
	Fri, 26 Apr 2024 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154153; cv=none; b=YKjHXvHdb+Nu7pfoSYFfcYbuEZJU1cs0GXqBhnnTvZsljiHVBY8pLgrlK3dqO2Ij9RaaHJ0VbJrQ/55QTMCP2ykB9+IvoKAiCCSZfK/LNxohgvISYADAs2MssSJ6ruXrkqiXuK+bRvJnU5OTH1Njm/Afo9U90QaDDqu8yTziRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154153; c=relaxed/simple;
	bh=Pf7pPVZks5xzzNAo26Zws/OeKXgG3gHu4RXtYM46N9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djlRHkf7jdjnU4D7eqBVDccazZtovrDCPWpLjhEcdRYgn5rID6GBXSTnp6fEt0WgQJ34cA132S9CxOUGQn3K3d66lbQ1tRyQuD6xdnAwn9kDGGrV7wcDz7kMkR3KOzvl1ab5dSiNGxSV2xB5YP768PvnOqfxAfpDKxPlCG41mfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rT13YVuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CB3C113CD;
	Fri, 26 Apr 2024 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714154153;
	bh=Pf7pPVZks5xzzNAo26Zws/OeKXgG3gHu4RXtYM46N9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rT13YVuAd+8ccqqsaeo+9P3Qc8BDiML7tpLr7wfW9bntsqaw2rdB5xsWWrKvikMqC
	 eCX9N+G/07ubtvRVIuXLJSU6HUErL29t4evS2P95KiUoQCphl48fRKuDay4W1SbrzS
	 dsGRN5cG9qgMtMU1ZeMXQWku+C1odaR5jBkY3MwgA4SidP/+SC3qcpHonJ5T8KlNz8
	 g+Dk+bNhaGz1zzvMf6vVnx10Fp6nzxqw4ripQMV3W5kI96eCtY+L+L0XZ9UkTEkvBP
	 le+YcR/GiZNvid2rWbhZ+UPc1EgXQgzcg3qiPzRX9UD0I323u0bmEWZSYxa3UVHP3D
	 SLxi2Pq71NWHA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5acf5723325so642551eaf.0;
        Fri, 26 Apr 2024 10:55:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXU8P0ed1Wn7DZAerrjOi+txVW7I26NOOCqHDu5tPaUm8JbrS8vIZx2ugcu7eVIHzWO1YEjj4orDLrAu5fCShfJw46pgPQF1ak34RoQbhnkzTteeI0DyEB9aslAptbafRQ/DI+m+4=
X-Gm-Message-State: AOJu0YzEgtZ52YSmL+lBKSSRIpLCLuJuz4WIcLA0LifQNf8lmRQqcNiC
	X9NFjzISEBqSd9gbWZuDS43UwEZYeRUD5eDXw6UTmjJd53eSX616Q5OPSno9tbIru6SUwexe/Xu
	RawnsHJwJUX75tK4PshZ46XqNcmA=
X-Google-Smtp-Source: AGHT+IGfT0gR3dFwO92Z66hwwW4O5HId7nGuyO2CkkjEns+2cLwSmfAD+s1THu68DSpl6Kxo4Ygbj6QNzDEASHW7q1w=
X-Received: by 2002:a05:6871:6ac:b0:239:9a:d3a4 with SMTP id
 l44-20020a05687106ac00b00239009ad3a4mr3680726oao.0.1714154152504; Fri, 26 Apr
 2024 10:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422162040.1502626-1-rui.zhang@intel.com> <20240422162040.1502626-2-rui.zhang@intel.com>
In-Reply-To: <20240422162040.1502626-2-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 19:55:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iaf8Own=NuHZuYfVpKPBM-ZYHf-SYEgwsjREg-XfuNbA@mail.gmail.com>
Message-ID: <CAJZ5v0iaf8Own=NuHZuYfVpKPBM-ZYHf-SYEgwsjREg-XfuNbA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] powercap: intel_rapl: Introduce APIs for PMU support
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 6:21=E2=80=AFPM Zhang Rui <rui.zhang@intel.com> wro=
te:
>
> Introduce two new APIs rapl_package_add_pmu()/rapl_package_remove_pmu().
>
> RAPL driver can invoke these APIs to expose its supported energy
> counters via perf PMU. The new RAPL PMU is fully compatible with current
> MSR RAPL PMU, including using the same PMU name and events
> name/id/unit/scale, etc.
>
> For example, use below command
>  perf stat -e power/energy-pkg/ -e power/energy-ram/ FOO
> to get the energy consumption if power/energy-pkg/ and power/energy-ram/
> events are available in the "perf list" output.
>
> This does not introduce any conflict because TPMI RAPL is the only user
> of these APIs currently, and it never co-exists with MSR RAPL.
>
> Note that RAPL Packages can be probed/removed dynamically, and the
> events supported by each TPMI RAPL device can be different. Thus the
> RAPL PMU support is done on demand, which means
> 1. PMU is registered only if it is needed by a RAPL Package. PMU events
>    for unsupported counters are not exposed.
> 2. PMU is unregistered and registered when a new RAPL Package is probed
>    and supports new counters that are not supported by current PMU.
>    For example, on a dual-package system using TPMI RAPL, it is possible
>    that Package 1 behaves as TPMI domain root and supports Psys domain.
>    In this case, register PMU without Psys event when probing Package 0,
>    and re-register the PMU with Psys event when probing Package 1.
> 3. PMU is unregistered when all registered RAPL Packages don't need PMU.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 578 +++++++++++++++++++++++++++
>  include/linux/intel_rapl.h           |  32 ++
>  2 files changed, 610 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index c4302caeb631..1fa45ed8ba0b 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -15,6 +15,8 @@
>  #include <linux/list.h>
>  #include <linux/log2.h>
>  #include <linux/module.h>
> +#include <linux/nospec.h>
> +#include <linux/perf_event.h>
>  #include <linux/platform_device.h>
>  #include <linux/powercap.h>
>  #include <linux/processor.h>
> @@ -1507,6 +1509,582 @@ static int rapl_detect_domains(struct rapl_packag=
e *rp)
>         return 0;
>  }
>
> +#ifdef CONFIG_PERF_EVENTS
> +
> +/*
> + * Support for RAPL PMU
> + *
> + * Register a PMU if any of the registered RAPL Packages have the requir=
ement
> + * of exposing its energy counters via Perf PMU.
> + *
> + * PMU Name:
> + *     power
> + *
> + * Events:
> + *     Name            Event id        RAPL Domain
> + *     energy_cores    0x01            RAPL_DOMAIN_PP0
> + *     energy_pkg      0x02            RAPL_DOMAIN_PACKAGE
> + *     energy_ram      0x03            RAPL_DOMAIN_DRAM
> + *     energy_gpu      0x04            RAPL_DOMAIN_PP1
> + *     energy_psys     0x05            RAPL_DOMAIN_PLATFORM
> + *
> + * Unit:
> + *     Joules
> + *
> + * Scale:
> + *     2.3283064365386962890625e-10
> + *     The same RAPL domain in different RAPL Packages may have differen=
t
> + *     energy units. Use 2.3283064365386962890625e-10 (2^-32) Joules as
> + *     the fixed unit for all energy counters, and covert each hardware
> + *     counter increase to N times of PMU event counter increases.
> + *
> + * This is fully compatible with the current MSR RAPL PMU. This means th=
at
> + * userspace programs like turbostat can use the same code to handle RAP=
L Perf
> + * PMU, no matter what RAPL Interface driver (MSR/TPMI, etc) is running
> + * underlying on the platform.
> + *
> + * Note that RAPL Packages can be probed/removed dynamically, and the ev=
ents
> + * supported by each TPMI RAPL device can be different. Thus the RAPL PM=
U
> + * support is done on demand, which means
> + * 1. PMU is registered only if it is needed by a RAPL Package. PMU even=
ts for
> + *    unsupported counters are not exposed.
> + * 2. PMU is unregistered and registered when a new RAPL Package is prob=
ed and
> + *    supports new counters that are not supported by current PMU.
> + * 3. PMU is unregistered when all registered RAPL Packages don't need P=
MU.
> + */
> +
> +struct rapl_pmu {
> +       struct pmu pmu;                 /* Perf PMU structure */
> +       u64 timer_ms;                   /* Maximum expiration time to avo=
id counter overflow */
> +       unsigned long domain_map;       /* Events supported by current re=
gistered PMU */
> +       bool registered;                /* Whether the PMU has been regis=
tered or not */
> +};
> +
> +static struct rapl_pmu rapl_pmu;
> +
> +/* PMU helpers */
> +
> +static int get_pmu_cpu(struct rapl_package *rp)
> +{
> +       int cpu;
> +
> +       if (!rp->has_pmu)
> +               return nr_cpu_ids;
> +
> +       /* Only TPMI RAPL is supported for now */
> +       if (rp->priv->type !=3D RAPL_IF_TPMI)
> +               return nr_cpu_ids;
> +
> +       /* TPMI RAPL uses any CPU in the package for PMU */
> +       for_each_online_cpu(cpu)
> +               if (topology_physical_package_id(cpu) =3D=3D rp->id)
> +                       return cpu;
> +
> +       return nr_cpu_ids;
> +}
> +
> +static bool is_rp_pmu_cpu(struct rapl_package *rp, int cpu)
> +{
> +       if (!rp->has_pmu)
> +               return false;
> +
> +       /* Only TPMI RAPL is supported for now */
> +       if (rp->priv->type !=3D RAPL_IF_TPMI)
> +               return nr_cpu_ids;

As per the comment, this should be false, shouldn't it?

> +
> +       /* TPMI RAPL uses any CPU in the package for PMU */
> +       return topology_physical_package_id(cpu) =3D=3D rp->id;
> +}
> +
> +static struct rapl_package_pmu_data *event_to_pmu_data(struct perf_event=
 *event)
> +{
> +       struct rapl_package *rp =3D event->pmu_private;
> +
> +       return &rp->pmu_data;
> +}
> +
> +/* PMU event callbacks */
> +
> +static u64 event_read_counter(struct perf_event *event)
> +{
> +       struct rapl_package *rp =3D event->pmu_private;
> +       u64 val;
> +       int ret;
> +
> +       /* Return 0 for unsupported events */
> +       if (event->hw.idx < 0)
> +               return 0;
> +
> +       ret =3D rapl_read_data_raw(&rp->domains[event->hw.idx], ENERGY_CO=
UNTER, false, &val);
> +
> +       /* Return 0 for failed read */
> +       if (ret)
> +               return 0;
> +
> +       return val;
> +}
> +
> +static void __rapl_pmu_event_start(struct perf_event *event)
> +{
> +       struct rapl_package_pmu_data *data =3D event_to_pmu_data(event);
> +
> +       if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> +               return;
> +
> +       event->hw.state =3D 0;
> +
> +       list_add_tail(&event->active_entry, &data->active_list);
> +
> +       local64_set(&event->hw.prev_count, event_read_counter(event));
> +       if (++data->n_active =3D=3D 1)
> +               hrtimer_start(&data->hrtimer, data->timer_interval,
> +                             HRTIMER_MODE_REL_PINNED);
> +}
> +
> +static void rapl_pmu_event_start(struct perf_event *event, int mode)
> +{
> +       struct rapl_package_pmu_data *data =3D event_to_pmu_data(event);
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&data->lock, flags);
> +       __rapl_pmu_event_start(event);
> +       raw_spin_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +static u64 rapl_event_update(struct perf_event *event)
> +{
> +       struct hw_perf_event *hwc =3D &event->hw;
> +       struct rapl_package_pmu_data *data =3D event_to_pmu_data(event);
> +       u64 prev_raw_count, new_raw_count;
> +       s64 delta, sdelta;
> +       s64 tmp;
> +
> +       do {
> +               prev_raw_count =3D local64_read(&hwc->prev_count);
> +               new_raw_count =3D event_read_counter(event);
> +               tmp =3D local64_cmpxchg(&hwc->prev_count, prev_raw_count,=
 new_raw_count);
> +       } while (tmp !=3D prev_raw_count);

I think that it is only safe to call this function for draining an
event going away, because otherwise the above may turn into an endless
loop, and the function is called under a spinlock.

I would add a comment (above the loop) explaining that this is about
draining, so the counter is expected to stop incrementing shortly.

The rest of the patch LGTM.

Thanks!

