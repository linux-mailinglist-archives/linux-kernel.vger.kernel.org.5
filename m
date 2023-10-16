Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DCB7CA7F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjJPM02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:26:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD09AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:26:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27cf7ef0ef4so3671208a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697459184; x=1698063984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmn6/sIgRo7SY0ymPqgTtwfMgrfA0Y3BP4S+nWa7vE0=;
        b=P0/RpHBTxIy91mHQ6+UqC1YBBX6ZKtla+4FqL0LAOU2vRTAM3oLIv6bMQuOQmMuaWf
         wX9pcR86OUuHVWIq8v4tZRwl/AdeK+A8aC9MzfVYxfcI1I2mGNDj7mkCMTwiXye++/Nr
         7yaeo0WOGLLtMjrUjVEhL9v44f4sEKIDBkwLXZJjZw3/okbrHoh6Bjq6pCXVyC3Su8kS
         LplqiCzO3AKl7l5QvQUq+BrKDEM+gQOTqjXWkTut38S9Swc/joJ2OK1v2NT/niFvZGh4
         4yJQAlMIrTx1krUrnAfkku5Lo9K4u/C44C/4qLKiLAHM/IK5wi6Ud9Do5HhxM1pqk8lv
         s6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697459184; x=1698063984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmn6/sIgRo7SY0ymPqgTtwfMgrfA0Y3BP4S+nWa7vE0=;
        b=TI8PuABmjGCS7A3My3e61e5v7UJZT5wyFF2tBFl+zWruA58ReQtvO0O1s7/HCRDZby
         b546FfA9uzfNCzu5/apaZSW10SuCfBTchTZDOKkprKPmVlKr0PmdA4iqqz2TckrQAW5b
         S/hdmDR5olUsP14S5ndmsRJPYKVENDe9OqusBX+G3VPx0VyQll85XWEJtluaWeFqGnU5
         aB7JR4p9Bib9+gDC7xHljxY05edjXK/W8f6OcUNuWnPTK3IRrKmRpbqPbDJ/lMblLfEr
         hDKpOsYiFim6e1YaYmiA6SMGudtHdHC1FjS6j2NVNRBm874HFYkks0fvl/3LgdLnEXSF
         q76A==
X-Gm-Message-State: AOJu0YxdR8ONdA0Woon8oceMo5OyJcHw1g2WiGkUiAPsGaGN07qn/NDY
        su1xQXjwrXw9hdv4wGEhe2wiKQ==
X-Google-Smtp-Source: AGHT+IGTpZt5mh7PLLa+PXm7c+3dddBndmP/Iy/6mV9lRWJMNC172sZoHymfQsIRPUQVZ+MW6n45MA==
X-Received: by 2002:a17:90b:1289:b0:27d:694f:195d with SMTP id fw9-20020a17090b128900b0027d694f195dmr4527726pjb.6.1697459184104;
        Mon, 16 Oct 2023 05:26:24 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.160])
        by smtp.gmail.com with ESMTPSA id 6-20020a630806000000b0056c2f1a2f6bsm5673189pgi.41.2023.10.16.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:26:22 -0700 (PDT)
Date:   Mon, 16 Oct 2023 20:26:15 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] perf arm-spe: Move PMU initialization from
 default config code
Message-ID: <20231016122615.GG928468@leoy-huanghe.lan>
References: <20231012175645.1849503-1-irogers@google.com>
 <20231012175645.1849503-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012175645.1849503-4-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:56:41AM -0700, Ian Rogers wrote:
> Avoid setting PMU values in arm_spe_pmu_default_config, move to
> perf_pmu__arch_init.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/arch/arm/util/pmu.c       | 2 ++
>  tools/perf/arch/arm64/util/arm-spe.c | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index d55d2b15f2e6..f25f68f84a94 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -23,6 +23,8 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  		pmu->default_config = cs_etm_get_default_config(pmu);
>  #if defined(__aarch64__)
>  	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
> +		pmu->selectable = true;
> +		pmu->is_uncore = false;

Arm SPE is not an uncore PMU event.  Arm SPE driver registers sysfs node
'cpumask', thus it misleads the pmu_is_uncore() function and it returns
'true' for Arm SPE event.

Here we need to explictly set false to correct the 'is_uncore' flag.

I did test on my machine, the changes work well for Arm SPE event.

Tested-by: Leo Yan <leo.yan@linaro.org>
