Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49647B6D95
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbjJCP6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjJCP6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:58:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122FDA7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696348711; x=1727884711;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TFrk4ur3x8E9mkF3Q1y7BMSgWVokUVLBq4ZPjpRm6v4=;
  b=GSkrSfkFZMohsPIFugnXbRorEIXBFuHRvjnIlLbZg362W3lGAbjtQ1AG
   xqfopwf3pWm4WeOchU11UUsUoWt8FHndq9JwiNhD9wS1X2F6368pJ5+bG
   kK1rRme9315V+oyFCf5oOciITdjzdHobGF2xX3MGmfmfljaDlLHLcSCoP
   CdgNI1dvzyb6N+eurXTcYb/FJUa7TegSqUYtbuTEwlKXufnLicJG6JLT+
   Hh8w5Kp/6T4uwQd5TDZi27Cw/+/2adFbnw0YUk5vutMKPqF5QtRLTZYrU
   EnErBGzzDbJCGV/hvML8f8iEmreqUoFs57Hn3xS37QNRaEeFN2Ax3aT7s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="363177993"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="363177993"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 08:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082063481"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1082063481"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 08:58:30 -0700
Received: from [10.209.133.202] (kliang2-mobl1.ccr.corp.intel.com [10.209.133.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C73D0580D95;
        Tue,  3 Oct 2023 08:58:27 -0700 (PDT)
Message-ID: <94a2011f-38a6-a883-99c5-5693128f803e@linux.intel.com>
Date:   Tue, 3 Oct 2023 11:58:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH V3 1/6] perf: Add branch stack extra
Content-Language: en-US
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20230911154822.2559213-1-kan.liang@linux.intel.com>
 <20231002154535.GB35785@noisy.programming.kicks-ass.net>
 <ce16c6c1-9bdc-35e2-fe85-155bd7edbaa4@linux.intel.com>
 <20231002213752.GB1539@noisy.programming.kicks-ass.net>
 <ed169d4d-76d5-c134-c685-ad3d812028be@linux.intel.com>
 <20231003102733.GC1539@noisy.programming.kicks-ass.net>
 <ZRwuE8LPkwtkjX5C@tassilo>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZRwuE8LPkwtkjX5C@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-03 11:06 a.m., Andi Kleen wrote:
>> I'm thinking we should do something like expose branch_counter_nr and
>> branch_counter_width in the sysfs node, and then rename this extra field
>> to counters.
>>
>> Then userspace can do something like:
>>
>> 	for (i = 0; i < branch_counter_nr; i++) {
>> 		counter[i] = counters & ((1 << branch_counter_width) - 1);
>> 		counters >>= branch_counter_width;
>> 	}
>>
>> to extract the actual counter values.
> 
> perf script/report won't necessarily have access to the sysfs
> values if they run on a different system
> 
> It would need extra PT style metadata written by perf record to
> perf.data and read by the user tools.
> 
> Seems complicated. It would be better if it just parsed on its own.
> 

If so, perf probably have to save the information in the
perf_branch_entry. At least, perf has to be able to support 64 counters
and 64 width. That will use at least 12 bits of the info field of the
perf_branch_entry. (We only have 31 spare bits now. Almost half.) That
seems a waste.

Perf tool already supports "branches" in the caps folder. It has been
saved in the header. We can use a similar way to support
"branch_counter_nr" and "branch_counter_width". It doesn't seem very
complex. I think I will try the sysfs method first.

Thanks,
Kan
