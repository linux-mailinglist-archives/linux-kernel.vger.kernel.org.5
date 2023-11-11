Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896797E89A7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 08:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjKKHxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 02:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKKHw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 02:52:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7D03C0C;
        Fri, 10 Nov 2023 23:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699689176; x=1731225176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P35mStZNxkg9uguD+AoPwvrzhuSkOSt4IKHX8z0Mqy4=;
  b=JvPpD1bBfwJRVHP2MurUBft1eBvhMayx3jYO3r+VFbFlcKhk+E+3wnQc
   DEoS8FseMsbwNE0+m2vEJvRFRKm4OaY/IVyIV5XtU9SqHlkYIStmsLOFV
   FzofGQQOlNdtMKSST0Ua/HFQFp7KGPnjMYNxKsCMijReamm9GRWv8bNHi
   /MRdkPRjtHi1Uh2krnly035m7Liq1/7iRmlEd0zJ5Fu0ZXBaDUSY/4Xb3
   cld7PvEeb3S1KPvvxQDPa4NaTdzN1b1H5IcRmffqv65uz78ygpCzrxizD
   QWb7oPPYA4Q1QLIa3rVbubHTcOee3dAzkrVTBiuRH/jzIwexVSNOSrThD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="454563867"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="454563867"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 23:52:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="854557822"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="854557822"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Nov 2023 23:52:51 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1inR-000AJC-2C;
        Sat, 11 Nov 2023 07:52:49 +0000
Date:   Sat, 11 Nov 2023 15:52:04 +0800
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
Message-ID: <202311111502.wEcI1Okb-lkp@intel.com>
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
config: csky-randconfig-002-20231111 (https://download.01.org/0day-ci/archive/20231111/202311111502.wEcI1Okb-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111502.wEcI1Okb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111502.wEcI1Okb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/bus/mhi/host/trace.h:225,
                    from drivers/bus/mhi/host/init.c:24:
   drivers/bus/mhi/host/./trace.h: In function 'trace_event_raw_event_mhi_process_ctrl_ev_ring':
>> drivers/bus/mhi/host/./trace.h:141:31: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     141 |                 __entry->rp = (u64)rp;
         |                               ^
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/bus/mhi/host/./trace.h:123:1: note: in expansion of macro 'TRACE_EVENT'
     123 | TRACE_EVENT(mhi_process_ctrl_ev_ring,
         | ^~~~~~~~~~~
   drivers/bus/mhi/host/./trace.h:139:9: note: in expansion of macro 'TP_fast_assign'
     139 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:103:
   drivers/bus/mhi/host/./trace.h: In function 'perf_trace_mhi_process_ctrl_ev_ring':
>> drivers/bus/mhi/host/./trace.h:141:31: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     141 |                 __entry->rp = (u64)rp;
         |                               ^
   include/trace/perf.h:51:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/bus/mhi/host/./trace.h:123:1: note: in expansion of macro 'TRACE_EVENT'
     123 | TRACE_EVENT(mhi_process_ctrl_ev_ring,
         | ^~~~~~~~~~~
   drivers/bus/mhi/host/./trace.h:139:9: note: in expansion of macro 'TP_fast_assign'
     139 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~


vim +141 drivers/bus/mhi/host/./trace.h

   124	
   125		TP_PROTO(const char *name, struct mhi_ring_element *rp, __le64 ptr,
   126			 __le32 dword0, __le32 dword1),
   127	
   128		TP_ARGS(name, rp, ptr, dword0, dword1),
   129	
   130		TP_STRUCT__entry(
   131			__field(u64, rp)
   132			__field(__le64, ptr)
   133			__string(name, name)
   134			__field(__le32, dword0)
   135			__field(__le32, dword1)
   136			__field(int, state)
   137		),
   138	
   139		TP_fast_assign(
   140			__assign_str(name, name);
 > 141			__entry->rp = (u64)rp;
   142			__entry->ptr = ptr;
   143			__entry->dword0 = dword0;
   144			__entry->dword1 = dword1;
   145			__entry->state = MHI_TRE_GET_EV_STATE(rp);
   146		),
   147	
   148		TP_printk("%s: RP:0x%llx Processing Event:0x%llx 0x%08x 0x%08x state:%s\n",
   149			  __get_str(name), __entry->rp, __entry->ptr, __entry->dword0,
   150			  __entry->dword1, mhi_state_str(__entry->state))
   151	);
   152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
