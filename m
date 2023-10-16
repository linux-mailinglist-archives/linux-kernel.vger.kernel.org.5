Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92F27CA82B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjJPMjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjJPMjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:39:47 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71094F9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:39:44 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57b5ef5b947so3014385eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697459983; x=1698064783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nMT1cK8ztuRUFe461aC+KLOzLZmOHrxC3db1zwij3Y=;
        b=oCIPn79vju8klCzinf2s6/R6nGfolr6+vFodRdwC26tQOD/TYrdsRTZjYDOBUxxGKv
         89SDhlV24ixm+xboam1CVpXa9SftE4pTXLS55EX1ikIsDCpthRXWE6KH/AtoHfqmjK4j
         flPhSeh44I8Bnqw1sV6ifXN44VWstS30owEQsBlXFl7+6MsN++FuD0sWegJs/e3lT8dr
         ht19ove/OwZBClhj/tZEQDjwLBTZs495/8bRy4ZA2hyXIuTk58Vi0Z/vcWeaDyRy0Xpv
         +7wqi/7pcC9cFfmKOJexqamZeLdJRwMNCuu/C9SRrqIr/uhzrbTmUPSwJ+tn2r8lTpFB
         GKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697459983; x=1698064783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nMT1cK8ztuRUFe461aC+KLOzLZmOHrxC3db1zwij3Y=;
        b=MHsNuRBMWe3nqQ+txi5VfyBjlpaEYnKQJ3M5pLaKTZgvhzF5rIPgg4jjAm2a5BNSar
         +ci1TPeWtmKlPIqL1yrVJgXY2Y0ZvIgQN2hjNy8T6if2f0CWR5siCQoLSRl56VEXkGAe
         Se/hKiIxEpcl1vUtGZbe9a8yawktqmPc4eQBC2BS2pvM610APwEprV8FhhPP+ld4T/Zj
         YUGHs1Z3tPpuBkua2VU6OfDIFxpOuAIopnG0ENCqGGsslrULhjdAY2pTm4SqrTa8MQJP
         VA8Nsh1SjiLj2pIFprAegPuHx2uRdpVA1n/m6PPc1QnDDucCuiNJAhZTO7PfV6tphOBG
         8oYg==
X-Gm-Message-State: AOJu0YzkJhRLpZjlm9DM+YMs3VZpHJ+Xx8Eu/h+02+CrDvUTE96K9+E2
        D52gyMS91shz/+1ZQWb1h1ViNA==
X-Google-Smtp-Source: AGHT+IHaPlsFYo0sjxSxx37uvKwQhoor0IYCw3x2AUy//novSjdc4vEmglNS9pNDF7i3KtujM65Y3A==
X-Received: by 2002:a05:6358:9fa8:b0:166:d379:93c1 with SMTP id fy40-20020a0563589fa800b00166d37993c1mr25087rwb.20.1697459983440;
        Mon, 16 Oct 2023 05:39:43 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.160])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7918f000000b00690dbab1623sm17942751pfa.81.2023.10.16.05.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:39:42 -0700 (PDT)
Date:   Mon, 16 Oct 2023 20:39:35 +0800
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
Subject: Re: [PATCH v2 7/7] perf pmu: Lazily compute default config
Message-ID: <20231016123935.GH928468@leoy-huanghe.lan>
References: <20231012175645.1849503-1-irogers@google.com>
 <20231012175645.1849503-8-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012175645.1849503-8-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:56:45AM -0700, Ian Rogers wrote:
> The default config is computed during creation of the PMU and may do
> things like scanning sysfs, when the PMU may just be used as part of
> scanning. Change default_config to perf_event_attr_init_default, a
> callback that is used when a default config needs initializing. This
> avoids holding onto the memory for a perf_event_attr and copying.
> 
> On a tigerlake laptop running the pmu-scan benchmark:
> 
> Before:
> Running 'internals/pmu-scan' benchmark:
> Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 28.780 usec (+- 0.503 usec)
>   Average PMU scanning took: 283.480 usec (+- 18.471 usec)
> Number of openat syscalls: 30,227
> 
> After:
> Running 'internals/pmu-scan' benchmark:
> Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 27.880 usec (+- 0.169 usec)
>   Average PMU scanning took: 245.260 usec (+- 15.758 usec)
> Number of openat syscalls: 28,914
> 
> Over 3 runs it is a nearly 12% reduction in execution time and a 4.3%
> of openat calls.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c    | 13 ++------
>  tools/perf/arch/arm/util/pmu.c       |  4 +--
>  tools/perf/arch/arm64/util/arm-spe.c | 45 ++++++++++++++--------------
>  tools/perf/arch/x86/util/intel-pt.c  | 25 ++++++++--------
>  tools/perf/arch/x86/util/pmu.c       |  2 +-
>  tools/perf/util/arm-spe.h            |  4 ++-
>  tools/perf/util/cs-etm.h             |  2 +-
>  tools/perf/util/intel-pt.h           |  3 +-
>  tools/perf/util/parse-events.c       | 12 ++++----
>  tools/perf/util/pmu.c                |  3 +-
>  tools/perf/util/pmu.h                |  7 +++--
>  11 files changed, 58 insertions(+), 62 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index b8d6a953fd74..16bba74f048b 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -917,16 +917,9 @@ struct auxtrace_record *cs_etm_record_init(int *err)
>   * (CFG_CHG and evsel__set_config_if_unset()). If no default is set then user
>   * changes aren't tracked.
>   */
> -struct perf_event_attr *
> -cs_etm_get_default_config(struct perf_pmu *pmu __maybe_unused)
> +void
> +cs_etm_get_default_config(const struct perf_pmu *pmu __maybe_unused,
> +			  struct perf_event_attr *attr)
>  {
> -	struct perf_event_attr *attr;
> -
> -	attr = zalloc(sizeof(struct perf_event_attr));
> -	if (!attr)
> -		return NULL;
> -
>  	attr->sample_period = 1;
> -
> -	return attr;
>  }
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index f25f68f84a94..7f3af3b97f3b 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -20,12 +20,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
>  		/* add ETM default config here */
>  		pmu->selectable = true;
> -		pmu->default_config = cs_etm_get_default_config(pmu);
> +		pmu->perf_event_attr_init_default = cs_etm_get_default_config;
>  #if defined(__aarch64__)
>  	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
>  		pmu->selectable = true;
>  		pmu->is_uncore = false;
> -		pmu->default_config = arm_spe_pmu_default_config(pmu);
> +		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
>  	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
>  		pmu->selectable = true;
>  #endif
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 08a76734ccd2..e3acc739bd00 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -113,6 +113,25 @@ arm_spe_snapshot_resolve_auxtrace_defaults(struct record_opts *opts,
>  	}
>  }
>  
> +static __u64 arm_spe_pmu__sample_period(const struct perf_pmu *arm_spe_pmu)
> +{
> +	static __u64 sample_period;
> +
> +	if (sample_period)
> +		return sample_period;

I would like to drop the static 'sample_period' optimization.

IIUC, it's possible for some platforms to create more than one arm_spe
events (e.g. Arm big.LITTLE system), in that case, it's incorrect to use
the single sample period for all of arm_spe events.

Otherwise, Arm SPE changes are good for me.

Thanks,
Leo

> +
> +	/*
> +	 * If kernel driver doesn't advertise a minimum,
> +	 * use max allowable by PMSIDR_EL1.INTERVAL
> +	 */
> +	if (perf_pmu__scan_file(arm_spe_pmu, "caps/min_interval", "%llu",
> +				&sample_period) != 1) {
> +		pr_debug("arm_spe driver doesn't advertise a min. interval. Using 4096\n");
> +		sample_period = 4096;
> +	}
> +	return sample_period;
> +}
> +
>  static int arm_spe_recording_options(struct auxtrace_record *itr,
>  				     struct evlist *evlist,
>  				     struct record_opts *opts)
> @@ -136,7 +155,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  				return -EINVAL;
>  			}
>  			evsel->core.attr.freq = 0;
> -			evsel->core.attr.sample_period = arm_spe_pmu->default_config->sample_period;
> +			evsel->core.attr.sample_period = arm_spe_pmu__sample_period(arm_spe_pmu);
>  			evsel->needs_auxtrace_mmap = true;
>  			arm_spe_evsel = evsel;
>  			opts->full_auxtrace = true;
> @@ -495,26 +514,8 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
>  	return &sper->itr;
>  }
>  
> -struct perf_event_attr
> -*arm_spe_pmu_default_config(struct perf_pmu *arm_spe_pmu)
> +void
> +arm_spe_pmu_default_config(const struct perf_pmu *arm_spe_pmu, struct perf_event_attr *attr)
>  {
> -	struct perf_event_attr *attr;
> -
> -	attr = zalloc(sizeof(struct perf_event_attr));
> -	if (!attr) {
> -		pr_err("arm_spe default config cannot allocate a perf_event_attr\n");
> -		return NULL;
> -	}
> -
> -	/*
> -	 * If kernel driver doesn't advertise a minimum,
> -	 * use max allowable by PMSIDR_EL1.INTERVAL
> -	 */
> -	if (perf_pmu__scan_file(arm_spe_pmu, "caps/min_interval", "%llu",
> -				  &attr->sample_period) != 1) {
> -		pr_debug("arm_spe driver doesn't advertise a min. interval. Using 4096\n");
> -		attr->sample_period = 4096;
> -	}
> -
> -	return attr;
> +	attr->sample_period = arm_spe_pmu__sample_period(arm_spe_pmu);
>  }
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 6d6cd8f9133c..fa0c718b9e72 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -60,7 +60,7 @@ struct intel_pt_recording {
>  	size_t				priv_size;
>  };
>  
> -static int intel_pt_parse_terms_with_default(struct perf_pmu *pmu,
> +static int intel_pt_parse_terms_with_default(const struct perf_pmu *pmu,
>  					     const char *str,
>  					     u64 *config)
>  {
> @@ -84,7 +84,7 @@ static int intel_pt_parse_terms_with_default(struct perf_pmu *pmu,
>  	return err;
>  }
>  
> -static int intel_pt_parse_terms(struct perf_pmu *pmu, const char *str, u64 *config)
> +static int intel_pt_parse_terms(const struct perf_pmu *pmu, const char *str, u64 *config)
>  {
>  	*config = 0;
>  	return intel_pt_parse_terms_with_default(pmu, str, config);
> @@ -177,7 +177,7 @@ static int intel_pt_pick_bit(int bits, int target)
>  	return pick;
>  }
>  
> -static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
> +static u64 intel_pt_default_config(const struct perf_pmu *intel_pt_pmu)
>  {
>  	char buf[256];
>  	int mtc, mtc_periods = 0, mtc_period;
> @@ -256,18 +256,17 @@ static int intel_pt_parse_snapshot_options(struct auxtrace_record *itr,
>  	return 0;
>  }
>  
> -struct perf_event_attr *
> -intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
> +void intel_pt_pmu_default_config(const struct perf_pmu *intel_pt_pmu,
> +				 struct perf_event_attr *attr)
>  {
> -	struct perf_event_attr *attr;
> +	static u64 config;
> +	static bool initialized;
>  
> -	attr = zalloc(sizeof(struct perf_event_attr));
> -	if (!attr)
> -		return NULL;
> -
> -	attr->config = intel_pt_default_config(intel_pt_pmu);
> -
> -	return attr;
> +	if (!initialized) {
> +		config = intel_pt_default_config(intel_pt_pmu);
> +		initialized = true;
> +	}
> +	attr->config = config;
>  }
>  
>  static const char *intel_pt_find_filter(struct evlist *evlist,
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 949b3e2c67bd..469555ae9b3c 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -23,7 +23,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
>  		pmu->auxtrace = true;
>  		pmu->selectable = true;
> -		pmu->default_config = intel_pt_pmu_default_config(pmu);
> +		pmu->perf_event_attr_init_default = intel_pt_pmu_default_config;
>  	}
>  	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
>  		pmu->auxtrace = true;
> diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
> index 98d3235781c3..4f4900c18f3e 100644
> --- a/tools/perf/util/arm-spe.h
> +++ b/tools/perf/util/arm-spe.h
> @@ -27,5 +27,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
>  int arm_spe_process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session);
>  
> -struct perf_event_attr *arm_spe_pmu_default_config(struct perf_pmu *arm_spe_pmu);
> +void arm_spe_pmu_default_config(const struct perf_pmu *arm_spe_pmu,
> +				struct perf_event_attr *attr);
> +
>  #endif
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 7cca37887917..4696267a32f0 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -242,7 +242,7 @@ struct cs_etm_packet_queue {
>  
>  int cs_etm__process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session);
> -struct perf_event_attr *cs_etm_get_default_config(struct perf_pmu *pmu);
> +void cs_etm_get_default_config(const struct perf_pmu *pmu, struct perf_event_attr *attr);
>  
>  enum cs_etm_pid_fmt {
>  	CS_ETM_PIDFMT_NONE,
> diff --git a/tools/perf/util/intel-pt.h b/tools/perf/util/intel-pt.h
> index c7d6068e3a6b..18fd0be52e6c 100644
> --- a/tools/perf/util/intel-pt.h
> +++ b/tools/perf/util/intel-pt.h
> @@ -42,6 +42,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err);
>  int intel_pt_process_auxtrace_info(union perf_event *event,
>  				   struct perf_session *session);
>  
> -struct perf_event_attr *intel_pt_pmu_default_config(struct perf_pmu *pmu);
> +void intel_pt_pmu_default_config(const struct perf_pmu *intel_pt_pmu,
> +				 struct perf_event_attr *attr);
>  
>  #endif
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index c56e07bd7dd6..ea5579510b97 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1418,11 +1418,10 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	}
>  	fix_raw(&parsed_terms, pmu);
>  
> -	if (pmu->default_config) {
> -		memcpy(&attr, pmu->default_config, sizeof(struct perf_event_attr));
> -	} else {
> -		memset(&attr, 0, sizeof(attr));
> -	}
> +	memset(&attr, 0, sizeof(attr));
> +	if (pmu->perf_event_attr_init_default)
> +		pmu->perf_event_attr_init_default(pmu, &attr);
> +
>  	attr.type = pmu->type;
>  
>  	if (list_empty(&parsed_terms.terms)) {
> @@ -1466,7 +1465,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	 * When using default config, record which bits of attr->config were
>  	 * changed by the user.
>  	 */
> -	if (pmu->default_config && get_config_chgs(pmu, &parsed_terms, &config_terms)) {
> +	if (pmu->perf_event_attr_init_default &&
> +	    get_config_chgs(pmu, &parsed_terms, &config_terms)) {
>  		parse_events_terms__exit(&parsed_terms);
>  		return -ENOMEM;
>  	}
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 8ef675ea7bdd..a967d25e899b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1402,7 +1402,7 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
>  		     struct parse_events_terms *head_terms,
>  		     struct parse_events_error *err)
>  {
> -	bool zero = !!pmu->default_config;
> +	bool zero = !!pmu->perf_event_attr_init_default;
>  
>  	return perf_pmu__config_terms(pmu, attr, head_terms, zero, err);
>  }
> @@ -2064,7 +2064,6 @@ void perf_pmu__delete(struct perf_pmu *pmu)
>  
>  	perf_cpu_map__put(pmu->cpus);
>  
> -	zfree(&pmu->default_config);
>  	zfree(&pmu->name);
>  	zfree(&pmu->alias_name);
>  	zfree(&pmu->id);
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 5a05131aa4ce..d2895d415f08 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -92,10 +92,11 @@ struct perf_pmu {
>  	 */
>  	int max_precise;
>  	/**
> -	 * @default_config: Optional default perf_event_attr determined in
> -	 * architecture specific code.
> +	 * @perf_event_attr_init_default: Optional function to default
> +	 * initialize PMU specific parts of the perf_event_attr.
>  	 */
> -	struct perf_event_attr *default_config;
> +	void (*perf_event_attr_init_default)(const struct perf_pmu *pmu,
> +					     struct perf_event_attr *attr);
>  	/**
>  	 * @cpus: Empty or the contents of either of:
>  	 * <sysfs>/bus/event_source/devices/<name>/cpumask.
> -- 
> 2.42.0.655.g421f12c284-goog
> 
