Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630947E8B07
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjKKNUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 08:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKKNUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 08:20:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0447230E6;
        Sat, 11 Nov 2023 05:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699708799; x=1731244799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yfgk6CCBGqckjRbY7YyOyRronAXE5qqlYifqaJYqfSM=;
  b=PcvVrIHZs/dTKXo4LpjW5fBKG44WUuiiOQ3LV62BgRrTqpnhE/ErvVwI
   Lbhqu9cXxe09tOc3EFDLnL/Vl8TkmrGlFxUYI2B1T2yWfMCgazH6kYbId
   cJL5PeUPUqP48fhMzY3b/3Ujdrn69sdlCXcAFovau5xqQF2v73ktAYude
   3nQ/gpJkrgi0kZkj0+/CA9AISa1Y9vT2umQftFOybYQK7z8S7d/2nyhuQ
   miXnELJAQxJIteakLYmMivXwguS2gCoRa/FGLBWXyvMhs4otO7c0r+lFS
   ibzjW15GufoTw8R0JcCW+dLSvVEKLhmXq5DDUBxpfCThLHrnKQvDtuozd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="476501200"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="476501200"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 05:19:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="829861140"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="829861140"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Nov 2023 05:19:54 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1ntw-000AT4-2T;
        Sat, 11 Nov 2023 13:19:52 +0000
Date:   Sat, 11 Nov 2023 21:19:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_parass@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v4] bus: mhi: host: Add tracing support
Message-ID: <202311112133.5QrqkZ0r-lkp@intel.com>
References: <20231111-ftrace_support-v4-1-c83602399461@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111-ftrace_support-v4-1-c83602399461@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3006adf3be79cde4d14b1800b963b82b6e5572e0]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/bus-mhi-host-Add-tracing-support/20231111-135816
base:   3006adf3be79cde4d14b1800b963b82b6e5572e0
patch link:    https://lore.kernel.org/r/20231111-ftrace_support-v4-1-c83602399461%40quicinc.com
patch subject: [PATCH v4] bus: mhi: host: Add tracing support
config: x86_64-randconfig-123-20231111 (https://download.01.org/0day-ci/archive/20231111/202311112133.5QrqkZ0r-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311112133.5QrqkZ0r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311112133.5QrqkZ0r-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/bus/mhi/host/init.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, drivers/bus/mhi/host/trace.h):
>> drivers/bus/mhi/host/./trace.h:17:1: sparse: sparse: cast to restricted __le64
>> drivers/bus/mhi/host/./trace.h:17:1: sparse: sparse: restricted __le64 degrades to integer
>> drivers/bus/mhi/host/./trace.h:17:1: sparse: sparse: restricted __le64 degrades to integer
>> drivers/bus/mhi/host/./trace.h:17:1: sparse: sparse: cast to restricted __le32
>> drivers/bus/mhi/host/./trace.h:17:1: sparse: sparse: restricted __le32 degrades to integer
>> drivers/bus/mhi/host/./trace.h:17:1: sparse: sparse: restricted __le32 degrades to integer
>> drivers/bus/mhi/host/./trace.h:17:1: sparse: sparse: cast to restricted __le32
>> drivers/bus/mhi/host/./trace.h:17:1: sparse: sparse: restricted __le32 degrades to integer
>> drivers/bus/mhi/host/./trace.h:17:1: sparse: sparse: restricted __le32 degrades to integer
   drivers/bus/mhi/host/./trace.h:99:1: sparse: sparse: cast to restricted __le64
   drivers/bus/mhi/host/./trace.h:99:1: sparse: sparse: restricted __le64 degrades to integer
   drivers/bus/mhi/host/./trace.h:99:1: sparse: sparse: restricted __le64 degrades to integer
   drivers/bus/mhi/host/./trace.h:99:1: sparse: sparse: cast to restricted __le32
   drivers/bus/mhi/host/./trace.h:99:1: sparse: sparse: restricted __le32 degrades to integer
   drivers/bus/mhi/host/./trace.h:99:1: sparse: sparse: restricted __le32 degrades to integer
   drivers/bus/mhi/host/./trace.h:99:1: sparse: sparse: cast to restricted __le32
   drivers/bus/mhi/host/./trace.h:99:1: sparse: sparse: restricted __le32 degrades to integer
   drivers/bus/mhi/host/./trace.h:99:1: sparse: sparse: restricted __le32 degrades to integer
   drivers/bus/mhi/host/./trace.h:123:1: sparse: sparse: cast to restricted __le64
   drivers/bus/mhi/host/./trace.h:123:1: sparse: sparse: restricted __le64 degrades to integer
   drivers/bus/mhi/host/./trace.h:123:1: sparse: sparse: restricted __le64 degrades to integer
   drivers/bus/mhi/host/./trace.h:123:1: sparse: sparse: cast to restricted __le32
   drivers/bus/mhi/host/./trace.h:123:1: sparse: sparse: restricted __le32 degrades to integer
   drivers/bus/mhi/host/./trace.h:123:1: sparse: sparse: restricted __le32 degrades to integer
   drivers/bus/mhi/host/./trace.h:123:1: sparse: sparse: cast to restricted __le32
   drivers/bus/mhi/host/./trace.h:123:1: sparse: sparse: restricted __le32 degrades to integer
   drivers/bus/mhi/host/./trace.h:123:1: sparse: sparse: restricted __le32 degrades to integer

vim +17 drivers/bus/mhi/host/./trace.h

    16	
  > 17	TRACE_EVENT(mhi_gen_tre,
    18	
    19		TP_PROTO(const char *name, int ch_num, u64 wp, __le64 tre_ptr,
    20			 __le32 dword0, __le32 dword1),
    21	
    22		TP_ARGS(name, ch_num, wp, tre_ptr, dword0, dword1),
    23	
    24		TP_STRUCT__entry(
    25			__string(name, name)
    26			__field(int, ch_num)
    27			__field(u64, wp)
    28			__field(__le64, tre_ptr)
    29			__field(__le32, dword0)
    30			__field(__le32, dword1)
    31		),
    32	
    33		TP_fast_assign(
    34			__assign_str(name, name);
    35			__entry->ch_num = ch_num;
    36			__entry->wp = wp;
    37			__entry->tre_ptr = tre_ptr;
    38			__entry->dword0 = dword0;
    39			__entry->dword1 = dword1;
    40		),
    41	
    42		TP_printk("%s: Chan: %d WP: 0x%llx TRE: 0x%llx 0x%08x 0x%08x\n",
    43			  __get_str(name), __entry->ch_num, __entry->wp, __entry->tre_ptr,
    44			  __entry->dword0, __entry->dword1)
    45	);
    46	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
