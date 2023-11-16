Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FBB7EE413
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjKPPUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjKPPUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:20:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0B1AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700148050; x=1731684050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rwg1spkErK2RHGowjwwxQ9ye/SLIix5m4vLE3yJbN3U=;
  b=RaV74/e1kHXWKHd58QLqcr/TbdVLSnkbBJlGnKNra+YI53/1cBiB8t22
   JRRfVX2OldhP4imTfzHTtIDMTteKySNHM0IZpsLdLf5yJx+T46GmDhaED
   SZeckrlxJkP0uU0SrCT06fhnrkTuKeGvuhyA+JKo9TOU17dqw8I98pVon
   jmSyLZ2VlZcvdO8CcrSXR2Go8msSPFPwK0yjex5c321iAIYb3fuMfATbJ
   H40OOi19AqXpQ8kAvngZWMAYwZ02XGovXA/NRIixSCUuzBRl10JGHlxPY
   ZBkSMnlby+80NZvQzHyTp5t1bLcvNE79wMAeBLYexnujeu4SVIRiFSo9c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="457600699"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="457600699"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 07:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="758862751"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="758862751"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 07:20:50 -0800
Received: from [10.209.160.241] (kliang2-mobl1.ccr.corp.intel.com [10.209.160.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 805C4580D2C;
        Thu, 16 Nov 2023 07:20:49 -0800 (PST)
Message-ID: <d46a6f38-7c3a-4ed4-8038-8c6a2417a8b7@linux.intel.com>
Date:   Thu, 16 Nov 2023 10:20:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/4] x86/smp: Export symbol cpu_clustergroup_mask
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        artem.bityutskiy@linux.intel.com, rui.zhang@intel.com
References: <20231116142245.1233485-1-kan.liang@linux.intel.com>
 <20231116142245.1233485-2-kan.liang@linux.intel.com>
 <20231116144034.GG8262@noisy.programming.kicks-ass.net>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231116144034.GG8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-16 9:40 a.m., Peter Zijlstra wrote:
> On Thu, Nov 16, 2023 at 06:22:43AM -0800, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Intel cstate PMU driver will invoke the topology_cluster_cpumask() to
>> retrieve the CPU mask of a cluster. A modpost error is triggered since
>> the symbol cpu_clustergroup_mask is not exported.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  arch/x86/kernel/smpboot.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index 48e040618731..376387ca6be5 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -747,6 +747,7 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
>>  {
>>  	return cpu_l2c_shared_mask(cpu);
>>  }
>> +EXPORT_SYMBOL(cpu_clustergroup_mask);
> 
> I made that _GPL.

Sure.
> 
> Queued the lot.

Thanks!

Kan
