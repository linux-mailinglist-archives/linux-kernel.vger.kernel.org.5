Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29C076FA95
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjHDHAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjHDHAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:00:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F01734;
        Fri,  4 Aug 2023 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691132430; x=1722668430;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ne+JqBEQHk7qUD0ThACCJcrerguld7Xe85FCmjyAQ9M=;
  b=carc+Xy20g76rrr6kJJgutR0Sq6kv+lzAjdqYkFXcCF/7SKac8AD1NbQ
   zkKskckVbjaCbp9yeIpmmwHFYhc3I+K/35DBtCyIO7RETTOx3oWHqUR6K
   48i43ejTudXxO+XYxn6NFliy70Q4a0vgIX9cP1nPPhv5f2NjRxMP4A+Gt
   bE9kWF+mqN+DpOLH7C0Mzt+em2ygyU0P62EircuNXIH3QP0UHF0IizIcc
   dqgv9weBCBwL22dCjuNchSS4JBxB7m6aHYU3wJ2WMyilDJfywcVXbnEC4
   K/N7WcHEdAyrcOdjRcfuKOqJJ4ILpz7gTJ8CDxzPs0mBkIyJNnCgxqegG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="350386906"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="350386906"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 00:00:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="759441316"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="759441316"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.129])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 00:00:24 -0700
Message-ID: <2cc01594-02b8-1976-22f5-38aa1c66ac37@intel.com>
Date:   Fri, 4 Aug 2023 10:00:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v5 5/7] perf test: Update base-record & system-wide-dummy
 attr expected values for test-record-C0
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230804020741.99806-1-yangjihong1@huawei.com>
 <20230804020741.99806-6-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230804020741.99806-6-yangjihong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/08/23 05:07, Yang Jihong wrote:
> 1. Because a dummy sideband event is added to the sampling of specified
>    CPUs. When evlist contains evsel of different sample_type,
>    evlist__config() will change the default PERF_SAMPLE_ID bit to
>    PERF_SAMPLE_IDENTIFICATION bit.
>    The attr sample_type expected value of base-record and system-wide-dummy
>    in test-record-C0 needs to be updated.
> 
> 2. The perf record uses evlist__add_aux_dummy() instead of
>    evlist__add_dummy() to add a dummy event.
>    The expected value of system-wide-dummy attr needs to be updated.
> 
> The perf test result is as follows:
> 
>   # ./perf test list  2>&1 | grep 'Setup struct perf_event_attr'
>    17: Setup struct perf_event_attr
>   # ./perf test 17
>    17: Setup struct perf_event_attr                                    : Ok
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Tested-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/attr/system-wide-dummy | 14 ++++++++------
>  tools/perf/tests/attr/test-record-C0    |  4 ++--
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
> index 2f3e3eb728eb..a1e1d6a263bf 100644
> --- a/tools/perf/tests/attr/system-wide-dummy
> +++ b/tools/perf/tests/attr/system-wide-dummy
> @@ -9,8 +9,10 @@ flags=8
>  type=1
>  size=136
>  config=9
> -sample_period=4000
> -sample_type=455
> +sample_period=1
> +# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> +# PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER
> +sample_type=65671
>  read_format=4|20
>  # Event will be enabled right away.
>  disabled=0
> @@ -18,12 +20,12 @@ inherit=1
>  pinned=0
>  exclusive=0
>  exclude_user=0
> -exclude_kernel=0
> -exclude_hv=0
> +exclude_kernel=1
> +exclude_hv=1
>  exclude_idle=0
>  mmap=1
>  comm=1
> -freq=1
> +freq=0
>  inherit_stat=0
>  enable_on_exec=0
>  task=1
> @@ -32,7 +34,7 @@ precise_ip=0
>  mmap_data=0
>  sample_id_all=1
>  exclude_host=0
> -exclude_guest=0
> +exclude_guest=1
>  exclude_callchain_kernel=0
>  exclude_callchain_user=0
>  mmap2=1
> diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
> index 317730b906dd..198e8429a1bf 100644
> --- a/tools/perf/tests/attr/test-record-C0
> +++ b/tools/perf/tests/attr/test-record-C0
> @@ -10,9 +10,9 @@ cpu=0
>  enable_on_exec=0
>  
>  # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> -# PERF_SAMPLE_ID | PERF_SAMPLE_PERIOD
> +# PERF_SAMPLE_PERIOD | PERF_SAMPLE_IDENTIFIER
>  # + PERF_SAMPLE_CPU added by -C 0
> -sample_type=455
> +sample_type=65927
>  
>  # Dummy event handles mmaps, comm and task.
>  mmap=0

