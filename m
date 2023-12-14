Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3512813216
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573259AbjLNNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573229AbjLNNtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:49:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98B78E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:49:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA13DC433C7;
        Thu, 14 Dec 2023 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702561757;
        bh=+YaP//k66yYn7P7wEQDb5TW+zpn9I0lJ4Asbfy7dees=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuXKCk6+Sjijr2Oaj9DQy7ryY55jHeUtaosd+PrOvL2Gkbp55JwXqanRLNcfzzIyU
         6097ZavOI0gNXTXj1+iF0pqakOnJ0n+y3jsT5BilJQzl1y0Q2oINBHGs0gQ6OgYZR4
         3p6YeAHBLeuu+A8BqXKnlZzvXONBwj5H8WvvrArVKxi9b06uWC383CHPeTLP6L62xV
         JFCUhuW0Q0xh7FoPN92Eh0GqoOA+PmXJ9mlkmf2idbnIV2oQWzBZ5w+PybKy4pAmlp
         CsurFIBYSBRooKI5wGbiEM0ajGTU5wLMmpfwTnmQ7PvjO26Hi2v06NEnDcLi/p9xTC
         uKakxdxaQvRGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 23C82403EF; Thu, 14 Dec 2023 10:49:14 -0300 (-03)
Date:   Thu, 14 Dec 2023 10:49:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Changbin Du <changbin.du@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Paran Lee <p4ranlee@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 00/14] Clean up libperf cpumap's empty function
Message-ID: <ZXsH2rragIC7YmCS@kernel.org>
References: <20231129060211.1890454-1-irogers@google.com>
 <ZXifiVytVbebYE3U@kernel.org>
 <84755553-3a79-4693-9396-084e9ae41235@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84755553-3a79-4693-9396-084e9ae41235@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 13, 2023 at 02:48:15PM +0200, Adrian Hunter escreveu:
> On 12/12/23 19:59, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 28, 2023 at 10:01:57PM -0800, Ian Rogers escreveu:
> >> Rename and clean up the use of libperf CPU map functions particularly
> >> focussing on perf_cpu_map__empty that may return true for maps
> >> containing CPUs but also with an "any CPU"/dummy value.
> >>
> >> perf_cpu_map__nr is also troubling in that iterating an empty CPU map
> >> will yield the "any CPU"/dummy value. Reduce the appearance of some
> >> calls to this by using the perf_cpu_map__for_each_cpu macro.
> >>
> >> Ian Rogers (14):
> >>   libperf cpumap: Rename perf_cpu_map__dummy_new
> >>   libperf cpumap: Rename and prefer sysfs for perf_cpu_map__default_new
> >>   libperf cpumap: Rename perf_cpu_map__empty
> >>   libperf cpumap: Replace usage of perf_cpu_map__new(NULL)
> >>   libperf cpumap: Add for_each_cpu that skips the "any CPU" case
> > 
> > Applied 1-6, with James Reviewed-by tags, would be good to have Adrian
> > check the PT and BTS parts, testing the end result if he things its all
> > ok.

Ian,

	1-6 is in perf-tools-next now, can you please consider Adrian's
suggestion to reduce patch size and rebase the remaining patches?

- Arnaldo
 
> Changing the same lines of code twice in the same patch set is not
> really kernel style.
> 
> Some of the churn could be reduced by applying and rebasing on the
> patch below.
> 
> Ideally the patches should be reordered so that the lines only
> change once i.e.
> 
> 	perf_cpu_map__empty -> <replacement>
> 
> instead of
> 
> 	perf_cpu_map__empty -> <rename> -> <replacement>
> 
> If that is too much trouble, please accept my ack instead:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>


 
> 
> From: Adrian Hunter <adrian.hunter@intel.com>
> 
> Factor out perf_cpu_map__empty() use to reduce the occurrences and make
> the code more readable.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/arch/x86/util/intel-bts.c | 11 ++++++++---
>  tools/perf/arch/x86/util/intel-pt.c  | 21 ++++++++++++---------
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index d2c8cac11470..cebe994eb9db 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -59,6 +59,11 @@ intel_bts_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  	return INTEL_BTS_AUXTRACE_PRIV_SIZE;
>  }
>  
> +static bool intel_bts_per_cpu(struct evlist *evlist)
> +{
> +	return !perf_cpu_map__empty(evlist->core.user_requested_cpus);
> +}
> +
>  static int intel_bts_info_fill(struct auxtrace_record *itr,
>  			       struct perf_session *session,
>  			       struct perf_record_auxtrace_info *auxtrace_info,
> @@ -109,8 +114,8 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
>  	struct intel_bts_recording *btsr =
>  			container_of(itr, struct intel_bts_recording, itr);
>  	struct perf_pmu *intel_bts_pmu = btsr->intel_bts_pmu;
> +	bool per_cpu_mmaps = intel_bts_per_cpu(evlist);
>  	struct evsel *evsel, *intel_bts_evsel = NULL;
> -	const struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
>  	bool privileged = perf_event_paranoid_check(-1);
>  
>  	if (opts->auxtrace_sample_mode) {
> @@ -143,7 +148,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
>  	if (!opts->full_auxtrace)
>  		return 0;
>  
> -	if (opts->full_auxtrace && !perf_cpu_map__empty(cpus)) {
> +	if (opts->full_auxtrace && per_cpu_mmaps) {
>  		pr_err(INTEL_BTS_PMU_NAME " does not support per-cpu recording\n");
>  		return -EINVAL;
>  	}
> @@ -224,7 +229,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
>  		 * In the case of per-cpu mmaps, we need the CPU on the
>  		 * AUX event.
>  		 */
> -		if (!perf_cpu_map__empty(cpus))
> +		if (per_cpu_mmaps)
>  			evsel__set_sample_bit(intel_bts_evsel, CPU);
>  	}
>  
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index fa0c718b9e72..0ff9147c75da 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -312,6 +312,11 @@ static void intel_pt_tsc_ctc_ratio(u32 *n, u32 *d)
>  	*d = eax;
>  }
>  
> +static bool intel_pt_per_cpu(struct evlist *evlist)
> +{
> +	return !perf_cpu_map__empty(evlist->core.user_requested_cpus);
> +}
> +
>  static int intel_pt_info_fill(struct auxtrace_record *itr,
>  			      struct perf_session *session,
>  			      struct perf_record_auxtrace_info *auxtrace_info,
> @@ -322,7 +327,8 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
>  	struct perf_pmu *intel_pt_pmu = ptr->intel_pt_pmu;
>  	struct perf_event_mmap_page *pc;
>  	struct perf_tsc_conversion tc = { .time_mult = 0, };
> -	bool cap_user_time_zero = false, per_cpu_mmaps;
> +	bool per_cpu_mmaps = intel_pt_per_cpu(session->evlist);
> +	bool cap_user_time_zero = false;
>  	u64 tsc_bit, mtc_bit, mtc_freq_bits, cyc_bit, noretcomp_bit;
>  	u32 tsc_ctc_ratio_n, tsc_ctc_ratio_d;
>  	unsigned long max_non_turbo_ratio;
> @@ -369,8 +375,6 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
>  			ui__warning("Intel Processor Trace: TSC not available\n");
>  	}
>  
> -	per_cpu_mmaps = !perf_cpu_map__empty(session->evlist->core.user_requested_cpus);
> -
>  	auxtrace_info->type = PERF_AUXTRACE_INTEL_PT;
>  	auxtrace_info->priv[INTEL_PT_PMU_TYPE] = intel_pt_pmu->type;
>  	auxtrace_info->priv[INTEL_PT_TIME_SHIFT] = tc.time_shift;
> @@ -604,8 +608,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  	struct perf_pmu *intel_pt_pmu = ptr->intel_pt_pmu;
>  	bool have_timing_info, need_immediate = false;
>  	struct evsel *evsel, *intel_pt_evsel = NULL;
> -	const struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
>  	bool privileged = perf_event_paranoid_check(-1);
> +	bool per_cpu_mmaps = intel_pt_per_cpu(evlist);
>  	u64 tsc_bit;
>  	int err;
>  
> @@ -774,8 +778,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  	 * Per-cpu recording needs sched_switch events to distinguish different
>  	 * threads.
>  	 */
> -	if (have_timing_info && !perf_cpu_map__empty(cpus) &&
> -	    !record_opts__no_switch_events(opts)) {
> +	if (have_timing_info && per_cpu_mmaps && !record_opts__no_switch_events(opts)) {
>  		if (perf_can_record_switch_events()) {
>  			bool cpu_wide = !target__none(&opts->target) &&
>  					!target__has_task(&opts->target);
> @@ -832,7 +835,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  		 * In the case of per-cpu mmaps, we need the CPU on the
>  		 * AUX event.
>  		 */
> -		if (!perf_cpu_map__empty(cpus))
> +		if (per_cpu_mmaps)
>  			evsel__set_sample_bit(intel_pt_evsel, CPU);
>  	}
>  
> @@ -858,7 +861,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  			tracking_evsel->immediate = true;
>  
>  		/* In per-cpu case, always need the time of mmap events etc */
> -		if (!perf_cpu_map__empty(cpus)) {
> +		if (per_cpu_mmaps) {
>  			evsel__set_sample_bit(tracking_evsel, TIME);
>  			/* And the CPU for switch events */
>  			evsel__set_sample_bit(tracking_evsel, CPU);
> @@ -870,7 +873,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>  	 * Warn the user when we do not have enough information to decode i.e.
>  	 * per-cpu with no sched_switch (except workload-only).
>  	 */
> -	if (!ptr->have_sched_switch && !perf_cpu_map__empty(cpus) &&
> +	if (!ptr->have_sched_switch && per_cpu_mmaps &&
>  	    !target__none(&opts->target) &&
>  	    !intel_pt_evsel->core.attr.exclude_user)
>  		ui__warning("Intel Processor Trace decoding will not be possible except for kernel tracing!\n");
> -- 
> 2.34.1
> 
> 
> 

-- 

- Arnaldo
