Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF0807AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377368AbjLFVxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377289AbjLFVxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:53:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C34C8F;
        Wed,  6 Dec 2023 13:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701899629; x=1733435629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uDCbKJX1mxven00yW6cLrJs/SxvPpJhQsvsSbpeHg38=;
  b=Z9AEbBJ0dnxmAJTwXN2SHWIR4dwEmUT89heLviJbMQOI+HtegqHwrc/x
   TfnH0nICi7wY8TVAYZi7NJpLklAx/hNK+AGBMeDjU9E79QAUD+0t6B7LG
   yLYUmxkCmFe3NVjAHiAo2tuG19deU81dC4D3cNRm+R1yBCrJODlaraIud
   mbyOWRwsSnW9QYZ4j/7Izajwn+2SXdh0TsI2tMYRwTDuQlnp0Rw1JjkX1
   jB/A6I90eZ4dn3SGMNvJdm5HE2gHLET20aX5hzEqtxYkmY3uqkWXN/6Vo
   xTrSZma4qusmDeWvex7D73SQeVrvWLGai2pFh7l6BioiGFw9IrJm/f66X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="15680465"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="15680465"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 13:53:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="841991548"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="841991548"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 13:53:47 -0800
Received: from [10.212.106.4] (kliang2-mobl1.ccr.corp.intel.com [10.212.106.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 52C4C580DA3;
        Wed,  6 Dec 2023 13:53:44 -0800 (PST)
Message-ID: <3e7450c1-a54f-41db-9dff-5e505297b30a@linux.intel.com>
Date:   Wed, 6 Dec 2023 16:53:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] perf mem: Remove useless header files for X86
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     irogers@google.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
 <20231206201324.184059-7-kan.liang@linux.intel.com>
 <ZXDb2Gs1ECjejSbn@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZXDb2Gs1ECjejSbn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-06 3:38 p.m., Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 06, 2023 at 12:13:24PM -0800, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The X86 mem-events.c only has perf_mem_events array now. Remove useless
>> header files.
> 
> It would be great that those were removed while you made the cleanups,
> i.e. removed the need for one of them, remove it together with the
> refactorings, etc.
> 
> But I don't think this is a requirement, just would make it cleaner.

Sure, I will merge it with the previous patch in V2.

Thanks,
Kan
> 
> Will wait for reviews now.
> 
> - Arnaldo
>  
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/mem-events.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
>> index 71ffe16de751..62df03e91c7e 100644
>> --- a/tools/perf/arch/x86/util/mem-events.c
>> +++ b/tools/perf/arch/x86/util/mem-events.c
>> @@ -1,11 +1,9 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> -#include "util/pmu.h"
>> -#include "util/pmus.h"
>> -#include "util/env.h"
>> -#include "map_symbol.h"
>> -#include "mem-events.h"
>>  #include "linux/string.h"
>> -#include "env.h"
>> +#include "util/map_symbol.h"
>> +#include "util/mem-events.h"
>> +#include "mem-events.h"
>> +
>>  
>>  #define MEM_LOADS_AUX		0x8203
>>  
>> -- 
>> 2.35.1
>>
> 
