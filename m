Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD75A78F290
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347020AbjHaS2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbjHaS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:28:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF2BE5F;
        Thu, 31 Aug 2023 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693506484; x=1725042484;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ea/sTx0D8MlShxKH9bpADte97S2HmsTxsSCI9AEkSYE=;
  b=MGc9Elma1SPmbWQbuaaiNy7B3QnkVBmki2m9mZ3t1iu7PQSca+CPYFnF
   ABELhDOmynCghbS0xR2Iyau4Q9Af61dBh1VlZGy9cln+f2XCj4XeFFNB1
   veSNLWexVy9dzMGpNz7P26XpELOM40o5aiVKI2HKvYo+ix8XjHbdAbob4
   WBW1sD/veLFQizRp7X9MDxrYvJrWXo+7h3jqixHM7VKV6cMKobsW37OXP
   OQKBi2PuaFX/SidMsfp9yq/hWFVzs2ccC1osPEGdq/MFwtHGf6xBhmfLk
   Sqeiq/eAzuZy/boOvYIgAiPAbAC2MXYLbDItr7m+HJvZsLE+6+VioH0MO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375967595"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="375967595"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="774684931"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="774684931"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:28:03 -0700
Received: from [10.212.25.104] (kliang2-mobl1.ccr.corp.intel.com [10.212.25.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DA9FA580ABF;
        Thu, 31 Aug 2023 11:28:01 -0700 (PDT)
Message-ID: <c2affcc9-468f-bf4c-a080-65b31e05a83f@linux.intel.com>
Date:   Thu, 31 Aug 2023 14:28:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 0/3] perf list/debug output fixes
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230831071421.2201358-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230831071421.2201358-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-31 3:14 a.m., Ian Rogers wrote:
> Fix a long standing parse_events_term cloning bug so that the bad
> display of terms can be fixed and the code somewhat more intuitive:
> https://lore.kernel.org/lkml/20230830070753.1821629-2-irogers@google.com/
> 

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> Fix a bug caused by the rename of 'cpu' to 'default_core' in perf list.
> 
> Add more documentation, increase type safety and fix some related bugs
> where terms weren't initialized properly.
> 
> Ian Rogers (3):
>   perf list: Don't print Unit for default_core
>   perf parse-events: Name the two term enums
>   perf parse-events: Fix propagation of term's no_value when cloning
> 
>  tools/perf/builtin-list.c      |   2 +-
>  tools/perf/util/parse-events.c | 203 +++++++++++++++++++++++----------
>  tools/perf/util/parse-events.h |  60 +++++++---
>  tools/perf/util/parse-events.l |   2 +-
>  tools/perf/util/parse-events.y |  27 +++--
>  tools/perf/util/pmu.c          |   2 +-
>  6 files changed, 207 insertions(+), 89 deletions(-)
> 
