Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E67E8952
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 06:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjKKFHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 00:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjKKFHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 00:07:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F81FD7;
        Fri, 10 Nov 2023 21:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699679220; x=1731215220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vSKSY9tE7YTJMxF0CNtF11cQM9FmCkpKo8Bvq48ESLY=;
  b=gpo320WEXAoqmS01Fggkp0unQaLfNhb5O1MmMIEK+p0q7hwlfwgSsfv0
   Pjw62frGo6AAF+BkEPE8SCajCrF2nQODHhcnBVuIdRM14w2Zh7cMRNawR
   Hd8t8tu9bt1jemIKPcC/5SkwZjDbo3LeS8Py+pfbj4qUIemJb/zfwAc4R
   y1BuNKyd0IrJLcEUZ+HLggF9VhwtqnTYt+LdpSRX/3UuBbjaZEpkFrRKI
   8XUwclp8ebuGGJMjtZD67QzmjaGW27YhZf8FstQZe1AlBdKmLgKewDYM7
   ++P+DUHP6aBooTMvujQbhfhAuuXrrBkVXbDCRkD9J5VKvxIJeOFTtlAAQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="3261588"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="3261588"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 21:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="907602641"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="907602641"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2023 21:06:57 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1gCt-000ADp-0T;
        Sat, 11 Nov 2023 05:06:55 +0000
Date:   Sat, 11 Nov 2023 13:06:53 +0800
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
Subject: Re: [PATCH v3] bus: mhi: host: Add tracing support
Message-ID: <202311111237.zTm5NBLH-lkp@intel.com>
References: <20231111-ftrace_support-v3-1-f358d2911a74@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111-ftrace_support-v3-1-f358d2911a74@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3006adf3be79cde4d14b1800b963b82b6e5572e0]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/bus-mhi-host-Add-tracing-support/20231111-101955
base:   3006adf3be79cde4d14b1800b963b82b6e5572e0
patch link:    https://lore.kernel.org/r/20231111-ftrace_support-v3-1-f358d2911a74%40quicinc.com
patch subject: [PATCH v3] bus: mhi: host: Add tracing support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231111/202311111237.zTm5NBLH-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111237.zTm5NBLH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111237.zTm5NBLH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/bus/mhi/host/trace.h:224,
                    from drivers/bus/mhi/host/init.c:24:
   drivers/bus/mhi/host/./trace.h: In function 'trace_event_raw_event_mhi_process_ctrl_ev_ring':
>> drivers/bus/mhi/host/../common.h:144:58: error: invalid type argument of '->' (have 'u64' {aka 'long long unsigned int'})
     144 | #define MHI_TRE_GET_DWORD(tre, word)    le32_to_cpu((tre)->dword[(word)])
         |                                                          ^~
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/bus/mhi/host/./trace.h:123:1: note: in expansion of macro 'TRACE_EVENT'
     123 | TRACE_EVENT(mhi_process_ctrl_ev_ring,
         | ^~~~~~~~~~~
   drivers/bus/mhi/host/./trace.h:138:9: note: in expansion of macro 'TP_fast_assign'
     138 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:413:9: note: in expansion of macro '__compiletime_assert'
     413 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:425:9: note: in expansion of macro '_compiletime_assert'
     425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:154:17: note: in expansion of macro '__BF_FIELD_CHECK'
     154 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/bus/mhi/host/../common.h:159:41: note: in expansion of macro 'FIELD_GET'
     159 | #define MHI_TRE_GET_EV_STATE(tre)       FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
         |                                         ^~~~~~~~~
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
   drivers/bus/mhi/host/../common.h:159:69: note: in expansion of macro 'MHI_TRE_GET_DWORD'
     159 | #define MHI_TRE_GET_EV_STATE(tre)       FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
         |                                                                     ^~~~~~~~~~~~~~~~~
   drivers/bus/mhi/host/./trace.h:144:34: note: in expansion of macro 'MHI_TRE_GET_EV_STATE'
     144 |                 __entry->state = MHI_TRE_GET_EV_STATE(rp);
         |                                  ^~~~~~~~~~~~~~~~~~~~
>> drivers/bus/mhi/host/../common.h:144:58: error: invalid type argument of '->' (have 'u64' {aka 'long long unsigned int'})
     144 | #define MHI_TRE_GET_DWORD(tre, word)    le32_to_cpu((tre)->dword[(word)])
         |                                                          ^~
   include/trace/trace_events.h:402:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
     402 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/bus/mhi/host/./trace.h:123:1: note: in expansion of macro 'TRACE_EVENT'
     123 | TRACE_EVENT(mhi_process_ctrl_ev_ring,
         | ^~~~~~~~~~~
   drivers/bus/mhi/host/./trace.h:138:9: note: in expansion of macro 'TP_fast_assign'
     138 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   drivers/bus/mhi/host/../common.h:159:41: note: in expansion of macro 'FIELD_GET'
     159 | #define MHI_TRE_GET_EV_STATE(tre)       FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
         |                                         ^~~~~~~~~
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
   drivers/bus/mhi/host/../common.h:159:69: note: in expansion of macro 'MHI_TRE_GET_DWORD'
     159 | #define MHI_TRE_GET_EV_STATE(tre)       FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
         |                                                                     ^~~~~~~~~~~~~~~~~
   drivers/bus/mhi/host/./trace.h:144:34: note: in expansion of macro 'MHI_TRE_GET_EV_STATE'
     144 |                 __entry->state = MHI_TRE_GET_EV_STATE(rp);
         |                                  ^~~~~~~~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:103:
   drivers/bus/mhi/host/./trace.h: In function 'perf_trace_mhi_process_ctrl_ev_ring':
>> drivers/bus/mhi/host/../common.h:144:58: error: invalid type argument of '->' (have 'u64' {aka 'long long unsigned int'})
     144 | #define MHI_TRE_GET_DWORD(tre, word)    le32_to_cpu((tre)->dword[(word)])
         |                                                          ^~
   include/trace/perf.h:51:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/bus/mhi/host/./trace.h:123:1: note: in expansion of macro 'TRACE_EVENT'
     123 | TRACE_EVENT(mhi_process_ctrl_ev_ring,
         | ^~~~~~~~~~~
   drivers/bus/mhi/host/./trace.h:138:9: note: in expansion of macro 'TP_fast_assign'
     138 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:413:9: note: in expansion of macro '__compiletime_assert'
     413 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:425:9: note: in expansion of macro '_compiletime_assert'
     425 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:154:17: note: in expansion of macro '__BF_FIELD_CHECK'
     154 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/bus/mhi/host/../common.h:159:41: note: in expansion of macro 'FIELD_GET'
     159 | #define MHI_TRE_GET_EV_STATE(tre)       FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
         |                                         ^~~~~~~~~
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
   drivers/bus/mhi/host/../common.h:159:69: note: in expansion of macro 'MHI_TRE_GET_DWORD'
     159 | #define MHI_TRE_GET_EV_STATE(tre)       FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
         |                                                                     ^~~~~~~~~~~~~~~~~
   drivers/bus/mhi/host/./trace.h:144:34: note: in expansion of macro 'MHI_TRE_GET_EV_STATE'
     144 |                 __entry->state = MHI_TRE_GET_EV_STATE(rp);
         |                                  ^~~~~~~~~~~~~~~~~~~~
>> drivers/bus/mhi/host/../common.h:144:58: error: invalid type argument of '->' (have 'u64' {aka 'long long unsigned int'})
     144 | #define MHI_TRE_GET_DWORD(tre, word)    le32_to_cpu((tre)->dword[(word)])
         |                                                          ^~
   include/trace/perf.h:51:11: note: in definition of macro 'DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   drivers/bus/mhi/host/./trace.h:123:1: note: in expansion of macro 'TRACE_EVENT'
     123 | TRACE_EVENT(mhi_process_ctrl_ev_ring,
         | ^~~~~~~~~~~
   drivers/bus/mhi/host/./trace.h:138:9: note: in expansion of macro 'TP_fast_assign'
     138 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   drivers/bus/mhi/host/../common.h:159:41: note: in expansion of macro 'FIELD_GET'
     159 | #define MHI_TRE_GET_EV_STATE(tre)       FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
         |                                         ^~~~~~~~~
   include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
   drivers/bus/mhi/host/../common.h:159:69: note: in expansion of macro 'MHI_TRE_GET_DWORD'
     159 | #define MHI_TRE_GET_EV_STATE(tre)       FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0)))
         |                                                                     ^~~~~~~~~~~~~~~~~
   drivers/bus/mhi/host/./trace.h:144:34: note: in expansion of macro 'MHI_TRE_GET_EV_STATE'
     144 |                 __entry->state = MHI_TRE_GET_EV_STATE(rp);
         |                                  ^~~~~~~~~~~~~~~~~~~~


vim +144 drivers/bus/mhi/host/../common.h

8485149c7a84bb Manivannan Sadhasivam 2022-03-01  122  
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  123  /* Channel reset command */
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  124  #define MHI_TRE_CMD_RESET_PTR		0
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  125  #define MHI_TRE_CMD_RESET_DWORD0	0
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  126  #define MHI_TRE_CMD_RESET_DWORD1(chid)	cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid) | \
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  127  						    FIELD_PREP(GENMASK(23, 16),         \
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  128  							       MHI_CMD_RESET_CHAN))
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  129  
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  130  /* Channel stop command */
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  131  #define MHI_TRE_CMD_STOP_PTR		0
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  132  #define MHI_TRE_CMD_STOP_DWORD0		0
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  133  #define MHI_TRE_CMD_STOP_DWORD1(chid)	cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid) | \
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  134  						    FIELD_PREP(GENMASK(23, 16),         \
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  135  							       MHI_CMD_STOP_CHAN))
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  136  
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  137  /* Channel start command */
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  138  #define MHI_TRE_CMD_START_PTR		0
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  139  #define MHI_TRE_CMD_START_DWORD0	0
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  140  #define MHI_TRE_CMD_START_DWORD1(chid)	cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid) | \
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  141  						    FIELD_PREP(GENMASK(23, 16),         \
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  142  							       MHI_CMD_START_CHAN))
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  143  
8485149c7a84bb Manivannan Sadhasivam 2022-03-01 @144  #define MHI_TRE_GET_DWORD(tre, word)	le32_to_cpu((tre)->dword[(word)])
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  145  #define MHI_TRE_GET_CMD_CHID(tre)	FIELD_GET(GENMASK(31, 24), MHI_TRE_GET_DWORD(tre, 1))
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  146  #define MHI_TRE_GET_CMD_TYPE(tre)	FIELD_GET(GENMASK(23, 16), MHI_TRE_GET_DWORD(tre, 1))
8485149c7a84bb Manivannan Sadhasivam 2022-03-01  147  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
