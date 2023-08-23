Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B8C785C44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbjHWPiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjHWPiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:38:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80198E50;
        Wed, 23 Aug 2023 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692805078; x=1724341078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fbd57d8EgQnBHxmiKKKRj62HefG0K1c5zKhZKQRHO4o=;
  b=SjzuCHiIZxUhiPOHYmg1LeLlztKn2pFptL7zITqsiQThoQ9zEiFk81qJ
   ATRXtYRhWQcgMK2qwoDZrOtU5VS6IwdI6ZBXOUqdaqCCAY3mon/em1MWc
   vCA7ZXGrNjwniz1Mm1y6gcN9mHcRn8VXldlviRW9Y+uTJ5PjKqds4ZOh2
   OSain6W40D3wNsvvZHgro3PKDGOmM/PnPQgJGlhOyj3pp6ozso2TM4iAZ
   XXdyZJxrDx3o6eRkeuuXnU5eGC/tMl/hdJmVcoQR09MMkr+b99E91TdoR
   aSR/XmC8KuL+XC3RHt6xjtvhJLSFqU0SG6Hvf3b0jLMR0lUcb3LLu+0Lz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374168934"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374168934"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 08:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="686514914"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686514914"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.188])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 08:37:54 -0700
Message-ID: <78a87ed2-3aa8-95ef-28ae-19961f7c4acb@intel.com>
Date:   Wed, 23 Aug 2023 18:37:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [perf-tools-next:tmp.perf-tools-next] [perf dlfilter] f178a76b05:
 perf-sanity-tests.dlfilter_C_API.fail
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202308232146.94d82cb4-oliver.sang@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <202308232146.94d82cb4-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/23 17:57, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "perf-sanity-tests.dlfilter_C_API.fail" on:
> 
> commit: f178a76b054fd046d212c3c67745146ff191a443 ("perf dlfilter: Add a test for resolve_address()")
> https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> 
> [test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb22182]

We sometimes make a test for an issue then fix it, so the new test fails,
but is fixed in a subsequent patch.  If you read the commit it says as much:

commit f178a76b054fd046d212c3c67745146ff191a443
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Mon Jul 31 12:18:55 2023 +0300

    perf dlfilter: Add a test for resolve_address()
    
    Extend the "dlfilter C API" test to test
    perf_dlfilter_fns.resolve_address(). The test currently fails, but passes
    after a subsequent patch.
    
    Reviewed-by: Ian Rogers <irogers@google.com>
    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: https://lore.kernel.org/r/20230731091857.10681-1-adrian.hunter@intel.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

The fix is:

42c6dd9d23019ff339d0aca80a444eb71087050e perf dlfilter: Initialize addr_location before passing it to thread__find_symbol_fb()
> 
> in testcase: perf-sanity-tests
> version: perf-x86_64-00c7b5f4ddc5-1_20230402
> with following parameters:
> 
> 	perf_compiler: gcc
> 
> 
> 
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308232146.94d82cb4-oliver.sang@intel.com
> 
> 
> 
>  66: Convert perf time to TSC                                        :
>  66.1: TSC support                                                   : Ok
>  66.2: Perf time to TSC                                              : Ok
>  67: dlfilter C API                                                  : FAILED!  <---
>  68: Sigtrap                                                         : Ok
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230823/202308232146.94d82cb4-oliver.sang@intel.com
> 
> 
> 

