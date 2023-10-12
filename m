Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB37C6D75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379242AbjJLL4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379254AbjJLLzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:55:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44055468D;
        Thu, 12 Oct 2023 04:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697111630; x=1728647630;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=u0eUJHiuTfxnEuvCucLEAgO20pruS/LMBzHzjX0mWE0=;
  b=MT+tfkykbqOjhGkUywZ0OYi/4m8M1c0XtzSuMyOqWoRXUbedOcIpOop/
   2mJkvzh+bmLZBYVgb+8+NrSHaGDf02JoYNoNvBFGGmAgW3+nJkiHjKpSY
   btInmaCUv4J5JJ6b5GN+FiXFi9WhEpxxXgZoyDikxjFEP8NAWDj13Ng+B
   8mZQZgOOZu2Vk9vxmjaLKgL/j5p4tPPWitB6SVBtfqIg02MRzvK5UQ7Tu
   eOJQMUORZDHC/YW+BpEaQFZ+MEi9wtjt7GfsWBVvwv50gU9ahR0BI+hyl
   bv2YzJOxNyABTENWMrgyxwIplALvZdYmb6Op7dJMnBzHA1H8Onizdmy7Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415949549"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="415949549"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870545735"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="870545735"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.84])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:53:06 -0700
Message-ID: <5887df01-1263-44ec-a625-e550cea78289@intel.com>
Date:   Thu, 12 Oct 2023 14:53:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] perf pmu: Const-ify perf_pmu__config_terms
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231007021326.4156714-1-irogers@google.com>
 <20231007021326.4156714-6-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231007021326.4156714-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 05:13, Ian Rogers wrote:
> Add const to related APIs, this is so they can be used to default
> initialize a perf_event_attr from a const pmu.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/pmu.c | 10 +++++-----
>  tools/perf/util/pmu.h |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index e11901c923d7..eb17f00bd0d2 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -156,7 +156,7 @@ static void __perf_pmu_format__load(struct perf_pmu_format *format, FILE *file)
>  	format->loaded = true;
>  }
>  
> -static void perf_pmu_format__load(struct perf_pmu *pmu, struct perf_pmu_format *format)
> +static void perf_pmu_format__load(const struct perf_pmu *pmu, struct perf_pmu_format *format)
>  {
>  	char path[PATH_MAX];
>  	FILE *file = NULL;
> @@ -1132,7 +1132,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>  }
>  
>  static struct perf_pmu_format *
> -pmu_find_format(struct list_head *formats, const char *name)
> +pmu_find_format(const struct list_head *formats, const char *name)
>  {
>  	struct perf_pmu_format *format;
>  
> @@ -1230,7 +1230,7 @@ static int pmu_resolve_param_term(struct parse_events_term *term,
>  	return -1;
>  }
>  
> -static char *pmu_formats_string(struct list_head *formats)
> +static char *pmu_formats_string(const struct list_head *formats)
>  {
>  	struct perf_pmu_format *format;
>  	char *str = NULL;
> @@ -1256,7 +1256,7 @@ static char *pmu_formats_string(struct list_head *formats)
>   * Setup one of config[12] attr members based on the
>   * user input data - term parameter.
>   */
> -static int pmu_config_term(struct perf_pmu *pmu,
> +static int pmu_config_term(const struct perf_pmu *pmu,
>  			   struct perf_event_attr *attr,
>  			   struct parse_events_term *term,
>  			   struct parse_events_terms *head_terms,
> @@ -1379,7 +1379,7 @@ static int pmu_config_term(struct perf_pmu *pmu,
>  	return 0;
>  }
>  
> -int perf_pmu__config_terms(struct perf_pmu *pmu,
> +int perf_pmu__config_terms(const struct perf_pmu *pmu,
>  			   struct perf_event_attr *attr,
>  			   struct parse_events_terms *terms,
>  			   bool zero, struct parse_events_error *err)
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 24af7297b522..5a05131aa4ce 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -193,7 +193,7 @@ void pmu_add_sys_aliases(struct perf_pmu *pmu);
>  int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
>  		     struct parse_events_terms *head_terms,
>  		     struct parse_events_error *error);
> -int perf_pmu__config_terms(struct perf_pmu *pmu,
> +int perf_pmu__config_terms(const struct perf_pmu *pmu,
>  			   struct perf_event_attr *attr,
>  			   struct parse_events_terms *terms,
>  			   bool zero, struct parse_events_error *error);

