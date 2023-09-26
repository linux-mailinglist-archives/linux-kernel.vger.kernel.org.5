Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2559B7AF0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjIZQZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjIZQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:25:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E16B3;
        Tue, 26 Sep 2023 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695745527; x=1727281527;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xpnX8lTTYF2at425OtGQ4G91Yj2Q43UiudbbHMtTeCU=;
  b=T5O3wg05/cio6VADwdjn8FjrVpXObNWNhRiKDgQx2FZFEX1h+E4JLns+
   Ekq529q6lP7N5oM82PoO2qlwME1sw/rnZDKVb6toBaVnXcngighFybWmT
   xJZgAt1lPPtQ8HFopNyvMikl6vKFUIVxX9Du1zm8jjfoiyZHn4voSNmpD
   jzvs4kf6xCisFtwOcMA3NlmHJo3x2N+sW5ij/2YqNyW+xeCvfz8gMz7NJ
   YXNFmQKAxUuo/oUjeJZ9GiQ2K2JuHbi/o6vEoFhxn5Fc4k/1EL4CzdyvQ
   kj7BIUnf8/8xQV737f1VU6vWdFqrFaNGZmsL8r+JlTmnm3TsdNBBdH5RV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366670505"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="366670505"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="698528646"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="698528646"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:25:07 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5DE06580D9B;
        Tue, 26 Sep 2023 09:25:05 -0700 (PDT)
Message-ID: <7ffd2c76-3499-a921-58b9-eb71432e59ff@linux.intel.com>
Date:   Tue, 26 Sep 2023 12:25:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 16/25] perf stat: Update keyword core to default_core
 to adjust to the changes for events with no unit
Content-Language: en-US
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
 <20230925061824.3818631-17-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-17-weilin.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-25 2:18 a.m., weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
>

Description?

Shouldn't the default_core be used when the keyword core is first
introduced?

Thanks,
Kan

> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/pmu-events/jevents.py | 2 +-
>  tools/perf/util/metricgroup.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 5614bc203..d8c2fd258 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -303,7 +303,7 @@ class JsonEvent:
>            'cpu_core': 'cpu_core',
>            'cpu_atom': 'cpu_atom',
>            'ali_drw': 'ali_drw',
> -          'Core': 'core',
> +          'Core': 'default_core',
>        }
>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>  
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 2e7a8e315..7884cb036 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -2085,7 +2085,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
>  		pr_debug("found event %s\n", id);
>  		if (!strncmp(id, special_pattern, strlen(special_pattern))) {
>  			struct metricgroup__event_info *event;
> -			event = event_info__new(id, "core", "0", true);
> +			event = event_info__new(id, "default_core", "0", true);
>  			if (!event) {
>  				ret = -ENOMEM;
>  				goto err_out;
