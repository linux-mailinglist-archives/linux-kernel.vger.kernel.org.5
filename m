Return-Path: <linux-kernel+bounces-167481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB588BAA1D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5220F282E33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0914514F12D;
	Fri,  3 May 2024 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQMcgOPT"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B793139CE5
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729450; cv=none; b=K81SKLfDFWOgB9F/9n3QJpgZ1eVcOuN+9mjKjCU9gXgB7oh4xClbjWMostMv45o+8Y3GKFBqk/CLkRWI0Csbqe5Fm5nG+dAS+2o6H99S6V/Sk8GzHa6KMhFxE+UNdmKTf2e0Kl77WY6DtEOqnJyqkMgfWCULErL8Vrxe45Hglwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729450; c=relaxed/simple;
	bh=9xUwR67FUiYu0IYouYXTlC9kGNBbUAXAv3dzw34LI7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbTOkuJf+en240oK2erDAMWHzLV6mOIiXsEkyHRIiQKeeysIh9RZQ2mNfvSBSrUELZGPbS8z55GKdvNUf+9zvRQf4PYTNBHuxZfDMf+QYxsWKz/mpThUno2rJFLyZ6q3kMjCsjbZQf/pjbzWsfAQrzXxRjhfiogRLYG485QtT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQMcgOPT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ac9b225a91so6780564a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714729448; x=1715334248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6K7Pay8ZGGs8JQpUV4vQdePr9SGgGcaDpI0+uLfi74=;
        b=fQMcgOPTwFeQYEayu6tAKVi3PjDRbgFv0DmHfahqOsDN7cbx/0N9iXjnISszve7y40
         Uf0BhTpcE1l8X86SrOVYU2FntKWMtDT32stZ2Rxr7JJ0kKGAI3HTfOWNghsP4SNnBYpd
         DebIfTlD/7yWWUO8y3+OCF3pRO/Q0mYCOVgIKodQ0qwzJh0fIS7WqwOGjrU0e/utZ7kD
         9Eg7Ep1MOLXDmbDwgGxieAwd3gbHGHQqnjMmreFziOyF5oQaPgyPuaISoDNTmhwHGMWZ
         +7smHYGV20RH+3iR2Bq63ya6t8bc8l7u2N8+m35AeLiNCIobiWZ5GXOJ6Ce4vQUVfe5v
         Zh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714729448; x=1715334248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6K7Pay8ZGGs8JQpUV4vQdePr9SGgGcaDpI0+uLfi74=;
        b=GrdRuNj4Q4WKYr9sE8zKdsbpgORtgCebHU4Kr+les3t9NZjylXjTTekHt2jwzqNKkH
         LWFChJfMN9uEjHDjEBQZKdnw4KyG8W2Ajt7/f2PH5k6+2ne+65EP2NiB67XC02Uk7mVT
         4v0Fhh39jz5Hqx47UWv/o6RoqeDPVJdalVFLEpSZcvf54YPqAn0tbnOtbol05VHSmv/P
         uqsl5WoS0bpgBtOPZOq7aLP96ZsX4Zuhd/0uoxmO+5hdSzQqt+775Z3gA/lZIqETgqD0
         2x/ETs4PGet0pgDQPlNTR/HYcRQ3m8rBRdzqKVtDP7eA9DTiVsbWgytguBHcawGV0/n2
         EqEA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Q3FvvBPlk0yJbsCTPxA+2SwxLK0oQb8ntEGgkobEcuiQVkvkyTb7PtE6riKtccpT/igGpTdVdwYqf3Oid6KQzdOP3zgbbgOL4M1b
X-Gm-Message-State: AOJu0YyTxE5dT9wDMhWuSG30Wcy0SvsChldxRBRfZOxJUPPsTYdWuh/P
	5XSLuNHbojd+N9ZjtoYHjDIA5PvF0IHK9ZSd5Qpy/unJFrLeKi7mVl/LGYXbm2/UV0YiZP6vT9u
	L38/HAWZY/hJcdpQ3oSE+riuGlnIoBcWmXdL3Eg==
X-Google-Smtp-Source: AGHT+IEqmUCxUFheYOsEu1hmSEQa0XiyixvoaeJ456MYN5L8WNIkTLo/FnODv1me6ARbWIOQ5r0bYrUcRPz1HVkKw80=
X-Received: by 2002:a17:90a:650a:b0:2a2:70f6:8f67 with SMTP id
 i10-20020a17090a650a00b002a270f68f67mr2153090pjj.30.1714729447724; Fri, 03
 May 2024 02:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429152207.479221-1-james.clark@arm.com> <20240429152207.479221-16-james.clark@arm.com>
In-Reply-To: <20240429152207.479221-16-james.clark@arm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 3 May 2024 10:43:56 +0100
Message-ID: <CAJ9a7VicoyFAh1m+0wcEdKan_whfXP6cb7GBZvBXCukfyugjgg@mail.gmail.com>
Subject: Re: [PATCH 14/17] coresight: Use per-sink trace ID maps for Perf sessions
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

Hi James

On Mon, 29 Apr 2024 at 16:25, James Clark <james.clark@arm.com> wrote:
>
> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
> as long as there are fewer than that many ETMs connected to each sink.
>
> Each sink owns its own trace ID map, and any Perf session connecting to
> that sink will allocate from it, even if the sink is currently in use by
> other users. This is similar to the existing behavior where the dynamic
> trace IDs are constant as long as there is any concurrent Perf session
> active. It's not completely optimal because slightly more IDs will be
> used than necessary, but the optimal solution involves tracking the PIDs
> of each session and allocating ID maps based on the session owner. This
> is difficult to do with the combination of per-thread and per-cpu modes
> and some scheduling issues. The complexity of this isn't likely to worth
> it because even with multiple users they'd just see a difference in the
> ordering of ID allocations rather than hitting any limits (unless the
> hardware does have too many ETMs connected to one sink).
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c     | 10 ++++++++++
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 15 ++++++++-------
>  include/linux/coresight.h                        |  1 +
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 9fc6f6b863e0..d1adff467670 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -902,6 +902,7 @@ static void coresight_device_release(struct device *dev)
>         struct coresight_device *csdev = to_coresight_device(dev);
>
>         fwnode_handle_put(csdev->dev.fwnode);
> +       free_percpu(csdev->perf_id_map.cpu_map);
>         kfree(csdev);
>  }
>
> @@ -1159,6 +1160,14 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>         csdev->dev.fwnode = fwnode_handle_get(dev_fwnode(desc->dev));
>         dev_set_name(&csdev->dev, "%s", desc->name);
>
> +       if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> +           csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> +               csdev->perf_id_map.cpu_map = alloc_percpu(atomic_t);
> +               if (!csdev->perf_id_map.cpu_map) {
> +                       ret = -ENOMEM;
> +                       goto err_out;
> +               }
> +       }
>         /*
>          * Make sure the device registration and the connection fixup
>          * are synchronised, so that we don't see uninitialised devices
> @@ -1216,6 +1225,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  err_out:
>         /* Cleanup the connection information */
>         coresight_release_platform_data(NULL, desc->dev, desc->pdata);
> +       kfree(csdev);
>         return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(coresight_register);
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 177cecae38d9..86ca1a9d09a7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -229,10 +229,13 @@ static void free_event_data(struct work_struct *work)
>                 struct list_head **ppath;
>
>                 ppath = etm_event_cpu_path_ptr(event_data, cpu);
> -               if (!(IS_ERR_OR_NULL(*ppath)))
> +               if (!(IS_ERR_OR_NULL(*ppath))) {
> +                       struct coresight_device *sink = coresight_get_sink(*ppath);
> +
> +                       coresight_trace_id_put_cpu_id(cpu, &sink->perf_id_map);
>                         coresight_release_path(*ppath);
> +               }
>                 *ppath = NULL;
> -               coresight_trace_id_put_cpu_id(cpu, coresight_trace_id_map_default());
>         }
>
>         /* mark perf event as done for trace id allocator */
> @@ -401,8 +404,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>                 }
>
>                 /* ensure we can allocate a trace ID for this CPU */
> -               trace_id = coresight_trace_id_get_cpu_id(cpu,
> -                                                        coresight_trace_id_map_default());
> +               trace_id = coresight_trace_id_get_cpu_id(cpu, &sink->perf_id_map);
>                 if (!IS_VALID_CS_TRACE_ID(trace_id)) {
>                         cpumask_clear_cpu(cpu, mask);
>                         coresight_release_path(path);
> @@ -497,7 +499,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>
>         /* Finally enable the tracer */
>         if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF,
> -                                     coresight_trace_id_map_default()))
> +                                     &sink->perf_id_map))
>                 goto fail_disable_path;
>
>         /*
> @@ -509,8 +511,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>                 hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
>                                    CS_AUX_HW_ID_CURR_VERSION);
>                 hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
> -                                   coresight_trace_id_read_cpu_id(cpu,
> -                                               coresight_trace_id_map_default()));
> +                                   coresight_trace_id_read_cpu_id(cpu, &sink->perf_id_map));
>                 perf_report_aux_output_id(event, hw_id);
>         }
>
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 3a678e5425dc..8c4c1860c76b 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -290,6 +290,7 @@ struct coresight_device {
>         bool sysfs_sink_activated;
>         struct dev_ext_attribute *ea;
>         struct coresight_device *def_sink;
> +       struct coresight_trace_id_map perf_id_map;

perhaps this should be sink_id_map? At some point sysfs may use is and
naming is sink... is more consistent with other sink attributes in the
structure.

>         /* sysfs links between components */
>         int nr_links;
>         bool has_conns_grp;
> --
> 2.34.1
>

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

