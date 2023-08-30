Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA74278D9E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjH3Se1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244483AbjH3NOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:14:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E6185;
        Wed, 30 Aug 2023 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693401244; x=1724937244;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5fH0eS9X+SF+HiGQDLllch2PwJSmvVl3tYKODcp4p+4=;
  b=CxQYFA6w8R0IRivYVzkq96mESYCmp6k3U1ymwuC9jzYRthlyI9LW7uuU
   +oH14jqZ3U6qJSyGBepplMq2Ziqz8WcGjOXKNkTI1/xM2n1y+VsJCx9Zr
   kIMdWzjiYxSKDweoHd8w+vbDZRCv+cb+FYBhsQS0rKWj/J4Wnv4VzlK7B
   Kq6DyKfSvdofDD+7esPVl5axq3DXq5XBWbf7OlvlSzr9hytmryz6Mc5T5
   8XCipr0RWT03wr1X8m5GEHFGPk44qsKSEdu0ZytjGTFS8Bj+ifqQm8FDh
   fjFY50H2MvzySqz5fWwK+0uoaWnxsjM0gKXYlBfJigqg/5vcNhq5pmbZR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="378355955"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="378355955"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 06:14:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774118595"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="774118595"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 06:14:03 -0700
Received: from [10.213.187.192] (kliang2-mobl1.ccr.corp.intel.com [10.213.187.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CD3D7580C44;
        Wed, 30 Aug 2023 06:14:01 -0700 (PDT)
Message-ID: <a0b88cfe-3afe-688d-861c-a9a332f66676@linux.intel.com>
Date:   Wed, 30 Aug 2023 09:14:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1] perf metric: Add #num_cpus_online literal
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        John Garry <john.g.garry@oracle.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>
References: <20230830073026.1829912-1-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230830073026.1829912-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-30 3:30 a.m., Ian Rogers wrote:
> Returns the number of CPUs online, unlike #num_cpus that returns the
> number present. Add a test of the property. This will be used in
> future Intel metrics.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  tools/perf/tests/expr.c | 5 ++++-
>  tools/perf/util/expr.c  | 7 +++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index c1c3fcbc2753..81229fa4f1e9 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -70,7 +70,7 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  {
>  	struct expr_id_data *val_ptr;
>  	const char *p;
> -	double val, num_cpus, num_cores, num_dies, num_packages;
> +	double val, num_cpus_online, num_cpus, num_cores, num_dies, num_packages;
>  	int ret;
>  	struct expr_parse_ctx *ctx;
>  	bool is_intel = false;
> @@ -227,7 +227,10 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  
>  	/* Test toplogy constants appear well ordered. */
>  	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("#num_cpus_online",
> +			expr__parse(&num_cpus_online, ctx, "#num_cpus_online") == 0);
>  	TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
> +	TEST_ASSERT_VAL("#num_cpus >= #num_cpus_online", num_cpus >= num_cpus_online);
>  	TEST_ASSERT_VAL("#num_cores", expr__parse(&num_cores, ctx, "#num_cores") == 0);
>  	TEST_ASSERT_VAL("#num_cpus >= #num_cores", num_cpus >= num_cores);
>  	TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 0985a3cbc6f9..4488f306de78 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -427,6 +427,13 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
>  		result = cpu__max_present_cpu().cpu;
>  		goto out;
>  	}
> +	if (!strcmp("#num_cpus_online", literal)) {
> +		struct perf_cpu_map *online = cpu_map__online();
> +
> +		if (online)
> +			result = perf_cpu_map__nr(online);
> +		goto out;
> +	}
>  
>  	if (!strcasecmp("#system_tsc_freq", literal)) {
>  		result = arch_get_tsc_freq();
