Return-Path: <linux-kernel+bounces-165146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 042CF8B88A1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD06B20E0F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57A548EF;
	Wed,  1 May 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpzlSzF0"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3932A5336A
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714559529; cv=none; b=rG1iWu6wOWrxfq76EFKGb1eMY1lH6RYUnxuI9TW4ChMc2YQ6rtV5yQkugfWTqrDbsQG17H3sSmT996JfrrMVzEjZtA8H3IBXVCPdda44/LNHD3euc8Ukviyo1vSJba4CmdGMa1C6T+P2UpkRvpeq6y2zVFi25RHgBkiuWIJeKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714559529; c=relaxed/simple;
	bh=GAKXLe2Is4H3TF3PuKnSnSg9R0sRbQcdm6AZsy/uFf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyYNKX5hh1BfoeQBn8jn7nZKH3kE/jMBuQz4ZNS40zZFerNPDuYEoe5aPAzqhb8ZRm/Oc0aACCdugWyhzyNBhwIXrBV4ld8QgijQLYs9oBrmioYA1YRpa6qytWgj/W+QXQHVUkpw4sn/jJG5bQ0r0Dbubtdo20i1ZI60hMeirvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jpzlSzF0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b07f6b38daso484879a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714559527; x=1715164327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uY43QB8T+78HEj8GRDRsb60L4Nl0N1qrUHvHx08Om7c=;
        b=jpzlSzF03hItuCf31xobOjInNOA/JLgEExgtu+rqETaWpCoECoGwZq3zfoqjqZ+BEI
         8HSwU0nTfnZB7IHy6lXAp6BrjcOfvbHZKA4F9xkaWm9u/i9Snjg2eGgYxLRyrOkbx4b5
         OOg6BagEOWoWMmzX33qvLe2FRDoTili7ROw0CMjoyHuMNNOfZrdT5BkUua7sK/05K8zK
         WgHBb8OG9AGTg3tUK9HrvDAoOLaikPnS89/JuSf7EmLhQUszXzQnLSGDVYsZfRpYSMxo
         zWV1GoPRUuiVM9vGdJ/WG5btrw4O8BAkjRigwTw2Z7MnVfCxImZjlgL5t2dJm+vNkmuc
         r0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714559527; x=1715164327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uY43QB8T+78HEj8GRDRsb60L4Nl0N1qrUHvHx08Om7c=;
        b=eqJEhwz4Eq8A56DdHrBj7X07btzjnqGFJTqaVQX+soPjIAsiBzNh3lyR7vg3w/n6zo
         TA3GnNOfOQO12eCIxDkSQA9tM5lbcPMcL7XEhegRX2kFJATSGiWu1etuYQKtTQp86l/o
         8iYX8ewgBXsF9LmkhuvGoTrAtsj/jO++vaA2jawPOHFzvarOQhbxpT6ecaB1Y93Xx9DV
         XVFy2eBx6BmTlFo83P3kJXfZTR0ku6arlpFNaPIG2Fj0SXjeQmOdeC/sK+2oQZTM2YJP
         6lu0NlZpMxPFO1seGczIMRgH2TSfvKtYO0o1S41uSqCJl3f+vT2TRpX8xrk7I/ahovHW
         Ny3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkVdnuJPyVbIhKwBZ+i0TSg8KQrXiyuAGQizX/BcewfxoRLpFpyvtjmHwccS0k8AYPdX6cxV/YN687syEE1CH21LrM1jU1Rba57jn6
X-Gm-Message-State: AOJu0YzU5FhkkmiZFlGug/eivme0z6ylhmOsKMjDgbcYktih4V0yXRCj
	WA05m12/DSOGVl0DighwLU574ffuWWkvqrr8/PksQd8PsBhnUeCg4KewAaEzqvLUsVijeg59wWr
	nuzxBFNEFJLuuv6MUOtHwHqawpDf042A+sIV0IQ==
X-Google-Smtp-Source: AGHT+IE9uEu1vJlCTupgk+SDI07oGQrpRujdIkoor/k7RAy+jeSqTU8+p3+oUQFS3xpCSp+HkI5pSQOQZuJxs+bZ7uE=
X-Received: by 2002:a17:90a:df09:b0:2ab:8324:1b47 with SMTP id
 gp9-20020a17090adf0900b002ab83241b47mr3682681pjb.15.1714559527363; Wed, 01
 May 2024 03:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152207.479221-1-james.clark@arm.com> <20240429152207.479221-12-james.clark@arm.com>
In-Reply-To: <20240429152207.479221-12-james.clark@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 1 May 2024 11:31:56 +0100
Message-ID: <CAJ9a7Vjj++Bvu2EFVxpXvW4nes0qxVqjxgBWwi1L904p86a7gw@mail.gmail.com>
Subject: Re: [PATCH 11/17] coresight: Expose map argument in trace ID API
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com, 
	scclevenger@os.amperecomputing.com, coresight@lists.linaro.org, 
	suzuki.poulose@arm.com, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Mon, 29 Apr 2024 at 16:25, James Clark <james.clark@arm.com> wrote:
>
> The trace ID API is currently hard coded to always use the global map.
> The functions that take the map as an argument aren't currently public.
> Make them public so that Perf mode can pass in its own maps. At the
> moment all usages are still hard coded to use the global map, but now
> on the caller side.
>
> System ID functions are unchanged because they will always use the
> default map.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../hwtracing/coresight/coresight-etm-perf.c  |  5 +++--
>  .../coresight/coresight-etm3x-core.c          |  5 +++--
>  .../coresight/coresight-etm4x-core.c          |  5 +++--
>  .../hwtracing/coresight/coresight-trace-id.c  | 22 +++++++------------
>  .../hwtracing/coresight/coresight-trace-id.h  |  9 +++++---
>  5 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index c0c60e6a1703..4afb9d29f355 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -232,7 +232,7 @@ static void free_event_data(struct work_struct *work)
>                 if (!(IS_ERR_OR_NULL(*ppath)))
>                         coresight_release_path(*ppath);
>                 *ppath = NULL;
> -               coresight_trace_id_put_cpu_id(cpu);
> +               coresight_trace_id_put_cpu_id(cpu, coresight_trace_id_map_default());
>         }
>
>         /* mark perf event as done for trace id allocator */
> @@ -401,7 +401,8 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>                 }
>
>                 /* ensure we can allocate a trace ID for this CPU */
> -               trace_id = coresight_trace_id_get_cpu_id(cpu);
> +               trace_id = coresight_trace_id_get_cpu_id(cpu,
> +                                                        coresight_trace_id_map_default());
>                 if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>                         cpumask_clear_cpu(cpu, mask);
>                         coresight_release_path(path);
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 9d5c1391ffb1..4149e7675ceb 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -465,7 +465,8 @@ int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
>          *
>          * trace id function has its own lock
>          */
> -       trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
> +       trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu,
> +                                                coresight_trace_id_map_default());
>         if (IS_VALID_CS_TRACE_ID(trace_id))
>                 drvdata->traceid = (u8)trace_id;
>         else
> @@ -477,7 +478,7 @@ int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
>
>  void etm_release_trace_id(struct etm_drvdata *drvdata)
>  {
> -       coresight_trace_id_put_cpu_id(drvdata->cpu);
> +       coresight_trace_id_put_cpu_id(drvdata->cpu, coresight_trace_id_map_default());
>  }
>
>  static int etm_enable_perf(struct coresight_device *csdev,
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index a0bdfabddbc6..f32c8cd7742d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -241,7 +241,8 @@ int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
>          * or return the one currently allocated.
>          * The trace id function has its own lock
>          */
> -       trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
> +       trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu,
> +                                                coresight_trace_id_map_default());
>         if (IS_VALID_CS_TRACE_ID(trace_id))
>                 drvdata->trcid = (u8)trace_id;
>         else
> @@ -253,7 +254,7 @@ int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
>
>  void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
>  {
> -       coresight_trace_id_put_cpu_id(drvdata->cpu);
> +       coresight_trace_id_put_cpu_id(drvdata->cpu, coresight_trace_id_map_default());
>  }
>
>  struct etm4_enable_arg {
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> index 19005b5b4dc4..45ddd50d09a6 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> @@ -12,7 +12,7 @@
>
>  #include "coresight-trace-id.h"
>
> -/* Default trace ID map. Used on systems that don't require per sink mappings */
> +/* Default trace ID map. Used in sysfs mode and for system sources */
>  static struct coresight_trace_id_map id_map_default;
>
>  /* maintain a record of the mapping of IDs and pending releases per cpu */
> @@ -152,7 +152,7 @@ static void coresight_trace_id_release_all_pending(void)
>         DUMP_ID_MAP(id_map);
>  }
>
> -static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> +int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>  {
>         unsigned long flags;
>         int id;
> @@ -195,8 +195,9 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
>         DUMP_ID_MAP(id_map);
>         return id;
>  }
> +EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
>
> -static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> +void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>  {
>         unsigned long flags;
>         int id;
> @@ -222,6 +223,7 @@ static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id
>         DUMP_ID_CPU(cpu, id);
>         DUMP_ID_MAP(id_map);
>  }
> +EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
>
>  static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
>  {
> @@ -250,19 +252,11 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
>         DUMP_ID_MAP(id_map);
>  }
>
> -/* API functions */
> -

Rather than remove the existing default trace ID functions, simply add
a few new ones...

e.g. given the existing...

void coresight_trace_id_put_cpu_id(int cpu)
{
    coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
}
EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);

add:-

void coresight_trace_id_put_cpu_id_map(int cpu, struct
coresight_trace_id_map *id_map)
{
    coresight_trace_id_map_put_cpu_id(cpu, id_map);
}
EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id_map);

This avoids a whole lot of churn in exposing the default map to
external functions, putting it in there and then removing it later.
When any location that was using coresight_trace_id_put_cpu_id() needs
to supply its own map, change the function name at that point to
coresight_trace_id_put_cpu_id_map()

Mike


> -int coresight_trace_id_get_cpu_id(int cpu)
> -{
> -       return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
> -}
> -EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
> -
> -void coresight_trace_id_put_cpu_id(int cpu)
> +struct coresight_trace_id_map *coresight_trace_id_map_default(void)
>  {
> -       coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
> +       return &id_map_default;
>  }
> -EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
> +EXPORT_SYMBOL_GPL(coresight_trace_id_map_default);
>
>  int coresight_trace_id_read_cpu_id(int cpu)
>  {
> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> index 49438a96fcc6..54b9d8ed903b 100644
> --- a/drivers/hwtracing/coresight/coresight-trace-id.h
> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> @@ -42,7 +42,10 @@
>  #define IS_VALID_CS_TRACE_ID(id)       \
>         ((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
>
> -/* Allocate and release IDs for a single default trace ID map */
> +/**
> + * Get the global map that's used by sysfs
> + */
> +struct coresight_trace_id_map *coresight_trace_id_map_default(void);
>
>  /**
>   * Read and optionally allocate a CoreSight trace ID and associate with a CPU.
> @@ -57,7 +60,7 @@
>   *
>   * return: CoreSight trace ID or -EINVAL if allocation impossible.
>   */
> -int coresight_trace_id_get_cpu_id(int cpu);
> +int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map);
>
>  /**
>   * Release an allocated trace ID associated with the CPU.
> @@ -70,7 +73,7 @@ int coresight_trace_id_get_cpu_id(int cpu);
>   *
>   * @cpu: The CPU index to release the associated trace ID.
>   */
> -void coresight_trace_id_put_cpu_id(int cpu);
> +void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map);
>
>  /**
>   * Read the current allocated CoreSight Trace ID value for the CPU.
> --
> 2.34.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

