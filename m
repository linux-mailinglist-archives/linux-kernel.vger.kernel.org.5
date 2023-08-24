Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5777866D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239109AbjHXEqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjHXEph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:45:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9845310E4;
        Wed, 23 Aug 2023 21:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692852334; x=1724388334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u5rfwar6xDQhY6j+a05ycw0TEynTIX0ltSNr1oZYiI4=;
  b=lgAssptPNRXliEUNNlBj0HI8H1DH6AEgAO1nzPdzOssdsid9t0IahSE8
   cPu5gQ7PgPXtW6hvt+0KPr2DOh9wosxA1AYGnfgAK1Uhp+L1yRB2vPdjc
   vhwh/wJELRZuh/PzBlWrNm2IuzxBCdXYhuqXXDgDYRPIxgXrdeXU5D8uM
   FypSWw+ZwjP58aDWK/9X5hh0r9a6RMByoYk629g6xKQCTJP3IciwWrKKD
   eX+z/inLFdkJpABJXY3szl12Ewsww+rIMUHVFj+o1/MFFnaek+VpSkd2V
   XeIimRbgOlSjKJM1s3LQLFOnOFD+DB4F8yfRUxS99Zhf6b6ZQaTzd1/CI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="440691013"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="440691013"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 21:45:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="860562597"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="860562597"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.187])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 21:45:29 -0700
Message-ID: <8685878c-8de0-88b9-4434-f823620f6abf@intel.com>
Date:   Thu, 24 Aug 2023 07:45:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [perf-tools-next:tmp.perf-tools-next] [perf dlfilter] f178a76b05:
 perf-sanity-tests.dlfilter_C_API.fail
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202308232146.94d82cb4-oliver.sang@intel.com>
 <78a87ed2-3aa8-95ef-28ae-19961f7c4acb@intel.com>
 <ZOa1LnnwETWCQ6n5@xsang-OptiPlex-9020>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZOa1LnnwETWCQ6n5@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/23 04:41, Oliver Sang wrote:
> hi, Adrian Hunter,
> 
> On Wed, Aug 23, 2023 at 06:37:49PM +0300, Adrian Hunter wrote:
>> On 23/08/23 17:57, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed "perf-sanity-tests.dlfilter_C_API.fail" on:
>>>
>>> commit: f178a76b054fd046d212c3c67745146ff191a443 ("perf dlfilter: Add a test for resolve_address()")
>>> https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
>>>
>>> [test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb22182]
>>
>> We sometimes make a test for an issue then fix it, so the new test fails,
>> but is fixed in a subsequent patch.  If you read the commit it says as much:
>>
>> commit f178a76b054fd046d212c3c67745146ff191a443
>> Author: Adrian Hunter <adrian.hunter@intel.com>
>> Date:   Mon Jul 31 12:18:55 2023 +0300
>>
>>     perf dlfilter: Add a test for resolve_address()
>>     
>>     Extend the "dlfilter C API" test to test
>>     perf_dlfilter_fns.resolve_address(). The test currently fails, but passes
>>     after a subsequent patch.
>>     
>>     Reviewed-by: Ian Rogers <irogers@google.com>
>>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>     Cc: Jiri Olsa <jolsa@kernel.org>
>>     Cc: Namhyung Kim <namhyung@kernel.org>
>>     Link: https://lore.kernel.org/r/20230731091857.10681-1-adrian.hunter@intel.com
>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>> The fix is:
>>
>> 42c6dd9d23019ff339d0aca80a444eb71087050e perf dlfilter: Initialize addr_location before passing it to thread__find_symbol_fb()
> 
> thanks a lot for information!
> 
> as above mentioned, when this auto-bisect done, it confirmed the issue still
> exists linux-next/master:
> [test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb22182]
> which includes 42c6dd9d23019ff339d0aca80a444eb71087050e
> 
> we will test again on latest linux-next/master:
> e3f80d3eae76c (tag: next-20230823, linux-next/master, broonie-ci/next-master) Add linux-next specific files for 20230823
> and 42c6dd9d23019ff339d0aca80a444eb71087050e
> 
> Thanks

Could you include the output from:

	perf test -v dlfilter

> 
>>>
>>> in testcase: perf-sanity-tests
>>> version: perf-x86_64-00c7b5f4ddc5-1_20230402
>>> with following parameters:
>>>
>>> 	perf_compiler: gcc
>>>
>>>
>>>
>>> compiler: gcc-12
>>> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
>>>
>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>
>>>
>>>
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202308232146.94d82cb4-oliver.sang@intel.com
>>>
>>>
>>>
>>>  66: Convert perf time to TSC                                        :
>>>  66.1: TSC support                                                   : Ok
>>>  66.2: Perf time to TSC                                              : Ok
>>>  67: dlfilter C API                                                  : FAILED!  <---
>>>  68: Sigtrap                                                         : Ok
>>>
>>>
>>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20230823/202308232146.94d82cb4-oliver.sang@intel.com
>>>
>>>
>>>
>>

