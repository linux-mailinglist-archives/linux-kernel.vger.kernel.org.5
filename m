Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B915D7E8978
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 07:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjKKGN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 01:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjKKGNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 01:13:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C492421C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 22:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699683227; x=1731219227;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vHqijR5gNaagmundI5p2Fy4vF3g3shnsGnqr81vG03Y=;
  b=UJgwE0GxlCk+/36SNSqgdgLTIUrx7/X5+YXD+BXPrp+AOx2MzydJ9EcF
   ue9LL5dfwyHrByzhOsc2Y+oKrUYrjzdHyJO47NaqyF4NzGWI0UPO5MoGC
   Qs34vRN0J5cvZ519mxVGlfxV9xn3b4552hc0l7uavjXt9fXwmRQW2rv6r
   a/8qBDDFnEwQYSpw9zt7hAp8LTt5usOzMZy1fP1CpLb7yb/jaMMAZEEM6
   uA34FEnCyFSbQckxdRcMbOXHY/JYEbVlB3d5XmSTZBvp/2dVpF1NZrW5D
   EkJhBkyBw3LPlJm7wnVHgYhBMXBsUDGxG6SR4XtlnYaqAYmcx8YRHm3Cf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="389123307"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="389123307"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 22:13:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="5216041"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Nov 2023 22:13:45 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1hFW-000AGA-2b;
        Sat, 11 Nov 2023 06:13:42 +0000
Date:   Sat, 11 Nov 2023 14:12:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/events/core.c:1315:15: sparse: sparse: incompatible types in
 comparison expression (different address spaces):
Message-ID: <202311111312.rJ50lGx1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 41a2901e7d220875752a8c870e0b53288a578c20 rcu: Remove SPARSE_RCU_POINTER Kconfig option
date:   6 years ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231111/202311111312.rJ50lGx1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111312.rJ50lGx1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111312.rJ50lGx1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/events/core.c:569:26: sparse: sparse: function 'perf_pmu_name' with external linkage has definition
   kernel/events/core.c:965:1: sparse: sparse: symbol 'perf_cgroup_switch' was not declared. Should it be static?
   kernel/events/core.c:1074:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got int * @@
   kernel/events/core.c:1074:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:1074:22: sparse:     got int *
   kernel/events/core.c:1081:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got int * @@
   kernel/events/core.c:1081:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:1081:22: sparse:     got int *
>> kernel/events/core.c:1315:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1315:15: sparse:    struct perf_event_context [noderef] <asn:4> *
>> kernel/events/core.c:1315:15: sparse:    struct perf_event_context *
   kernel/events/core.c:1328:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1328:28: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:1328:28: sparse:    struct perf_event_context *
   kernel/events/core.c:2901:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:2901:18: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:2901:18: sparse:    struct perf_event_context *
   kernel/events/core.c:2902:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:2902:23: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:2902:23: sparse:    struct perf_event_context *
   kernel/events/core.c:2933:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:2933:25: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:2933:25: sparse:    struct perf_event_context *
   kernel/events/core.c:2934:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:2934:25: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:2934:25: sparse:    struct perf_event_context *
   kernel/events/core.c:2957:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:2957:43: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:2957:43: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:2968:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:2968:43: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:2968:43: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:3823:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:3823:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:3823:26: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:4745:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4745:22: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:4745:22: sparse:    struct ring_buffer *
   kernel/events/core.c:4861:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4861:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:4861:14: sparse:    struct ring_buffer *
   kernel/events/core.c:4894:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4894:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:4894:14: sparse:    struct ring_buffer *
   kernel/events/core.c:4950:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4950:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:4950:14: sparse:    struct ring_buffer *
   kernel/events/core.c:5036:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5036:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:5036:14: sparse:    struct ring_buffer *
   kernel/events/core.c:5049:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5049:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:5049:14: sparse:    struct ring_buffer *
   kernel/events/core.c:6256:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:6256:23: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:6256:23: sparse:    struct perf_event_context *
   kernel/events/core.c:6346:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:6346:13: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:6346:13: sparse:    struct ring_buffer *
   kernel/events/core.c:6354:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:6354:43: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:6354:43: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:7005:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7005:23: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:7005:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7676:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7676:9: sparse:    struct swevent_hlist [noderef] <asn:4> *
>> kernel/events/core.c:7676:9: sparse:    struct swevent_hlist *
   kernel/events/core.c:8851:35: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct perf_cpu_context [noderef] <asn:3> * @@     got struct perf_cpu_context *[noderef] pmu_cpu_context @@
   kernel/events/core.c:8851:35: sparse:     expected struct perf_cpu_context [noderef] <asn:3> *
   kernel/events/core.c:8851:35: sparse:     got struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:8860:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got struct perf_cpu_context *[noderef] pmu_cpu_context @@
   kernel/events/core.c:8860:24: sparse:     expected void [noderef] <asn:3> *__pdata
   kernel/events/core.c:8860:24: sparse:     got struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:8875:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
   kernel/events/core.c:8926:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:8926:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:8926:26: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:9005:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int *[noderef] pmu_disable_count @@     got int [noderef] <asn:3> * @@
   kernel/events/core.c:9005:32: sparse:     expected int *[noderef] pmu_disable_count
   kernel/events/core.c:9005:32: sparse:     got int [noderef] <asn:3> *
   kernel/events/core.c:9045:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct perf_cpu_context *[noderef] pmu_cpu_context @@     got struct perf_cpu_context [noderef] <asn:3> * @@
   kernel/events/core.c:9045:30: sparse:     expected struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:9045:30: sparse:     got struct perf_cpu_context [noderef] <asn:3> *
   kernel/events/core.c:9050:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct perf_cpu_context *[noderef] pmu_cpu_context @@     got struct perf_cpu_context [noderef] <asn:3> * @@
   kernel/events/core.c:9050:30: sparse:     expected struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:9050:30: sparse:     got struct perf_cpu_context [noderef] <asn:3> *
   kernel/events/core.c:9057:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:9057:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:9057:26: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:9109:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got int *[noderef] pmu_disable_count @@
   kernel/events/core.c:9109:24: sparse:     expected void [noderef] <asn:3> *__pdata
   kernel/events/core.c:9109:24: sparse:     got int *[noderef] pmu_disable_count
   kernel/events/core.c:9130:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got int *[noderef] pmu_disable_count @@
   kernel/events/core.c:9130:24: sparse:     expected void [noderef] <asn:3> *__pdata
   kernel/events/core.c:9130:24: sparse:     got int *[noderef] pmu_disable_count
   kernel/events/core.c:10285:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:10285:20: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:10285:20: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:10286:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:10286:20: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:10286:20: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:10456:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:10456:9: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:10456:9: sparse:    struct perf_event_context *
   kernel/events/core.c:10566:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:10566:17: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:10566:17: sparse:    struct perf_event_context *
   kernel/events/core.c:156:9: sparse: sparse: context imbalance in 'perf_ctx_lock' - wrong count at exit
   kernel/events/core.c:164:17: sparse: sparse: context imbalance in 'perf_ctx_unlock' - unexpected unlock
   kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:1074:22: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:1081:22: sparse: sparse: dereference of noderef expression
   kernel/events/core.c: note: in included file (through include/linux/rculist.h, include/linux/dcache.h, include/linux/fs.h):
   include/linux/rcupdate.h:663:9: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
   kernel/events/core.c:1362:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
   kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:2360:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
   kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:2957:43: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:2968:43: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:3823:26: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:3854:17: sparse: sparse: context imbalance in 'find_get_context' - unexpected unlock
   kernel/events/core.c: note: in included file:
   kernel/events/internal.h:201:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got void const *buf @@
   kernel/events/internal.h:201:1: sparse:     expected void const [noderef] <asn:1> *from
   kernel/events/internal.h:201:1: sparse:     got void const *buf
   kernel/events/core.c:6354:43: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:7525:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7525:17: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:7525:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:7545:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7545:17: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:7545:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:7665:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7665:16: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:7665:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:7665:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7665:16: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:7665:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:7665:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7665:16: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:7665:16: sparse:    struct swevent_hlist *
--
>> kernel/events/ring_buffer.c:137:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer *
>> kernel/events/ring_buffer.c:137:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer *
>> kernel/events/ring_buffer.c:137:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer *
   kernel/events/ring_buffer.c:105:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     105 | static bool __always_inline
         | ^~~~~~
   kernel/events/ring_buffer.c:116:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     116 | static int __always_inline
         | ^~~~~~
--
>> kernel/events/callchain.c:67:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/callchain.c:67:9: sparse:    struct callchain_cpus_entries [noderef] <asn:4> *
>> kernel/events/callchain.c:67:9: sparse:    struct callchain_cpus_entries *
   kernel/events/callchain.c:165:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/callchain.c:165:19: sparse:    struct callchain_cpus_entries [noderef] <asn:4> *
   kernel/events/callchain.c:165:19: sparse:    struct callchain_cpus_entries *
--
>> fs/proc/inode.c:49:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/proc/inode.c:49:17: sparse:    struct ctl_table_header [noderef] <asn:4> *
>> fs/proc/inode.c:49:17: sparse:    struct ctl_table_header *
--
>> fs/proc/proc_sysctl.c:889:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/proc/proc_sysctl.c:889:16: sparse:    struct ctl_table_header [noderef] <asn:4> *
>> fs/proc/proc_sysctl.c:889:16: sparse:    struct ctl_table_header *
   fs/proc/proc_sysctl.c:294:32: sparse: sparse: context imbalance in 'start_unregistering' - unexpected unlock
   fs/proc/proc_sysctl.c:1523: warning: expecting prototype for register_sysctl_table_path(). Prototype was for register_sysctl_paths() instead
--
>> fs/fcntl.c:878:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:878:22: sparse:    struct fasync_struct [noderef] <asn:4> *
>> fs/fcntl.c:878:22: sparse:    struct fasync_struct *
   fs/fcntl.c:889:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:889:33: sparse:    struct fasync_struct [noderef] <asn:4> *
   fs/fcntl.c:889:33: sparse:    struct fasync_struct *
   In file included from fs/fcntl.c:7:
   include/linux/syscalls.h:196:25: warning: 'sys_fcntl' alias between functions of incompatible types 'long int(unsigned int,  unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       10-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:185:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     185 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/fcntl.c:359:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     359 | SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       22-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:185:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     185 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/fcntl.c:359:1: note: in expansion of macro 'SYSCALL_DEFINE3'
     359 | SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
         | ^~~~~~~~~~~~~~~
   fs/fcntl.c: In function 'send_sigio_to_task':
   fs/fcntl.c:641:28: warning: this statement may fall through [-Wimplicit-fallthrough=]
     641 |                         if (!do_send_sig_info(signum, &si, p, group))
         |                            ^
   fs/fcntl.c:644:17: note: here
     644 |                 case 0:
         |                 ^~~~
--
   fs/dcache.c:538:28: sparse: sparse: context imbalance in '__dentry_kill' - unexpected unlock
   fs/dcache.c:581:9: sparse: sparse: context imbalance in 'dentry_kill' - wrong count at exit
   fs/dcache.c:791:9: sparse: sparse: context imbalance in 'dput' - unexpected unlock
   fs/dcache.c:920:18: sparse: sparse: context imbalance in 'd_prune_aliases' - different lock contexts for basic block
   fs/dcache.c:963:44: sparse: sparse: context imbalance in 'shrink_dentry_list' - unexpected unlock
   fs/dcache.c:1019:24: sparse: sparse: context imbalance in 'dentry_lru_isolate' - wrong count at exit
   fs/dcache.c:1100:24: sparse: sparse: context imbalance in 'dentry_lru_isolate_shrink' - wrong count at exit
   fs/dcache.c:1167:13: sparse: sparse: context imbalance in 'd_walk' - different lock contexts for basic block
   fs/dcache.c: note: in included file (through include/linux/dcache.h, include/linux/fs.h, include/linux/seq_file.h, ...):
>> include/linux/rculist_bl.h:23:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:23:33: sparse:    struct hlist_bl_node [noderef] <asn:4> *
>> include/linux/rculist_bl.h:23:33: sparse:    struct hlist_bl_node *
>> include/linux/rculist_bl.h:23:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rculist_bl.h:23:33: sparse:    struct hlist_bl_node [noderef] <asn:4> *
>> include/linux/rculist_bl.h:23:33: sparse:    struct hlist_bl_node *
   In file included from fs/dcache.c:17:
   include/linux/syscalls.h:196:25: warning: 'sys_getcwd' alias between functions of incompatible types 'long int(char *, long unsigned int)' and 'long int(long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       19-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:184:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     184 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/dcache.c:3413:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3413 | SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       31-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:184:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     184 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   fs/dcache.c:3413:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3413 | SYSCALL_DEFINE2(getcwd, char __user *, buf, unsigned long, size)
         | ^~~~~~~~~~~~~~~
   fs/dcache.c:442: warning: expecting prototype for d_drop(). Prototype was for __d_drop() instead
   fs/dcache.c:866: warning: expecting prototype for d_find_alias(). Prototype was for __d_find_alias() instead
--
>> fs/seq_file.c:980:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:980:24: sparse:    struct hlist_node [noderef] <asn:4> *
>> fs/seq_file.c:980:24: sparse:    struct hlist_node *
   fs/seq_file.c:982:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:982:24: sparse:    struct hlist_node [noderef] <asn:4> *
   fs/seq_file.c:982:24: sparse:    struct hlist_node *
   fs/seq_file.c: In function 'seq_lseek':
   fs/seq_file.c:324:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
     324 |                 offset += file->f_pos;
         |                 ~~~~~~~^~~~~~~~~~~~~~
   fs/seq_file.c:325:9: note: here
     325 |         case SEEK_SET:
         |         ^~~~
   fs/seq_file.c:996: warning: expecting prototype for seq_hlist_start_precpu(). Prototype was for seq_hlist_start_percpu() instead
--
   kernel/fork.c:1831:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] <asn:4> *real_parent @@     got struct task_struct * @@
   kernel/fork.c:1831:32: sparse:     expected struct task_struct [noderef] <asn:4> *real_parent
   kernel/fork.c:1831:32: sparse:     got struct task_struct *
   kernel/fork.c:1885:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] <asn:4> * @@
   kernel/fork.c:1885:54: sparse:     expected struct list_head *head
   kernel/fork.c:1885:54: sparse:     got struct list_head [noderef] <asn:4> *
   kernel/fork.c:2166:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/fork.c:2166:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2166:24: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
>> kernel/fork.c:1601:27: sparse: sparse: dereference of noderef expression
>> kernel/fork.c:1601:27: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1603:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through arch/x86/include/asm/stacktrace.h, arch/x86/include/asm/perf_event.h, include/linux/perf_event.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] <asn:4> *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] <asn:4> *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] <asn:4> *ptracer_cred
   kernel/fork.c:1883:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1884:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1960:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c:1960:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c:163:13: warning: no previous prototype for 'arch_release_thread_stack' [-Wmissing-prototypes]
     163 | void __weak arch_release_thread_stack(unsigned long *stack)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:460:13: warning: no previous prototype for 'fork_init' [-Wmissing-prototypes]
     460 | void __init fork_init(void)
         |             ^~~~~~~~~
   kernel/fork.c: In function 'dup_task_struct':
   kernel/fork.c:514:27: warning: variable 'stack_vm_area' set but not used [-Wunused-but-set-variable]
     514 |         struct vm_struct *stack_vm_area;
         |                           ^~~~~~~~~~~~~
   In file included from kernel/fork.c:51:
   kernel/fork.c: At top level:
   include/linux/syscalls.h:196:25: warning: 'sys_set_tid_address' alias between functions of incompatible types 'long int(int *)' and 'long int(long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       41-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:1452:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    1452 | SYSCALL_DEFINE1(set_tid_address, int __user *, tidptr)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       53-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:1452:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    1452 | SYSCALL_DEFINE1(set_tid_address, int __user *, tidptr)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_unshare' alias between functions of incompatible types 'long int(long unsigned int)' and 'long int(long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       65-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:2299:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    2299 | SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       77-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:2299:1: note: in expansion of macro 'SYSCALL_DEFINE1'
    2299 | SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_clone' alias between functions of incompatible types 'long int(long unsigned int,  long unsigned int,  int *, int *, long unsigned int)' and 'long int(long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       89-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:187:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     187 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:2132:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    2132 | SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       101-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:187:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     187 | #define SYSCALL_DEFINE5(name, ...) SYSCALL_DEFINEx(5, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/fork.c:2132:1: note: in expansion of macro 'SYSCALL_DEFINE5'
    2132 | SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
         | ^~~~~~~~~~~~~~~
   In file included from include/linux/sched/signal.h:5,
                    from include/linux/sched/cputime.h:4,
                    from kernel/fork.c:23:
   include/linux/signal.h: In function 'sigemptyset':
--
   kernel/exit.c:98:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/exit.c:98:19: sparse:    struct sighand_struct [noderef] <asn:4> *
   kernel/exit.c:98:19: sparse:    struct sighand_struct *
   kernel/exit.c:245:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/exit.c:245:16: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/exit.c:245:16: sparse:    struct task_struct *
   kernel/exit.c:315:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/exit.c:315:16: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/exit.c:315:16: sparse:    struct task_struct *
   kernel/exit.c:350:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:350:37: sparse:     expected struct task_struct *tsk
   kernel/exit.c:350:37: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:353:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:353:32: sparse:     expected struct task_struct *task
   kernel/exit.c:353:32: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:354:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:354:35: sparse:     expected struct task_struct *task
   kernel/exit.c:354:35: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:399:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:399:24: sparse:     expected struct task_struct *parent
   kernel/exit.c:399:24: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:626:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:626:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:626:29: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:628:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/exit.c:628:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:628:29: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:690:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] <asn:4> *real_parent @@     got struct task_struct *[assigned] reaper @@
   kernel/exit.c:690:40: sparse:     expected struct task_struct [noderef] <asn:4> *real_parent
   kernel/exit.c:690:40: sparse:     got struct task_struct *[assigned] reaper
   kernel/exit.c:691:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/exit.c:691:25: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/exit.c:691:25: sparse:    struct task_struct *
>> kernel/exit.c:1554:59: sparse: sparse: incompatible types in comparison expression (different base types):
>> kernel/exit.c:1554:59: sparse:    void *
   kernel/exit.c:1554:59: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:91:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   include/linux/ptrace.h:91:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:91:40: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:91:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:91:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:91:60: sparse:     got struct task_struct [noderef] <asn:4> *parent
   include/linux/ptrace.h:91:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   include/linux/ptrace.h:91:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:91:40: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:91:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:91:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:91:60: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/exit.c:1097:17: sparse: sparse: context imbalance in 'wait_task_zombie' - unexpected unlock
   kernel/exit.c:1309:9: sparse: sparse: context imbalance in 'wait_task_stopped' - unexpected unlock
   kernel/exit.c: note: in included file (through include/linux/ipc.h, include/uapi/linux/sem.h, include/linux/sem.h, ...):
   include/linux/uidgid.h:167:9: sparse: sparse: context imbalance in 'wait_task_continued' - unexpected unlock
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:91:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   include/linux/ptrace.h:91:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:91:40: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:91:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:91:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:91:60: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/exit.c: note: in included file (through include/linux/thread_info.h, arch/x86/include/asm/preempt.h, include/linux/preempt.h, ...):
   arch/x86/include/asm/current.h:14:16: sparse: sparse: context imbalance in 'do_wait' - different lock contexts for basic block
   In file included from kernel/exit.c:41:
   include/linux/syscalls.h:196:25: warning: 'sys_exit' alias between functions of incompatible types 'long int(int)' and 'long int(long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       66-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/exit.c:949:1: note: in expansion of macro 'SYSCALL_DEFINE1'
     949 | SYSCALL_DEFINE1(exit, int, error_code)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       78-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:183:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     183 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/exit.c:949:1: note: in expansion of macro 'SYSCALL_DEFINE1'
     949 | SYSCALL_DEFINE1(exit, int, error_code)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_waitpid' alias between functions of incompatible types 'long int(pid_t,  int *, int)' {aka 'long int(int,  int *, int)'} and 'long int(long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       90-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:185:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     185 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/exit.c:1732:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    1732 | SYSCALL_DEFINE3(waitpid, pid_t, pid, int __user *, stat_addr, int, options)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       102-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:185:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     185 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/exit.c:1732:1: note: in expansion of macro 'SYSCALL_DEFINE3'
    1732 | SYSCALL_DEFINE3(waitpid, pid_t, pid, int __user *, stat_addr, int, options)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_wait4' alias between functions of incompatible types 'long int(pid_t,  int *, int,  struct rusage *)' {aka 'long int(int,  int *, int,  struct rusage *)'} and 'long int(long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       114-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/exit.c:1689:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    1689 | SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       126-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/exit.c:1689:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    1689 | SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
         | ^~~~~~~~~~~~~~~
--
>> kernel/ptrace.c:49:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/ptrace.c:49:22: sparse:    struct task_struct *
   kernel/ptrace.c:49:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:68:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] <asn:4> *parent @@     got struct task_struct *new_parent @@
   kernel/ptrace.c:68:23: sparse:     expected struct task_struct [noderef] <asn:4> *parent
   kernel/ptrace.c:68:23: sparse:     got struct task_struct *new_parent
   kernel/ptrace.c:69:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] <asn:4> *ptracer_cred @@     got struct cred const * @@
   kernel/ptrace.c:69:29: sparse:     expected struct cred const [noderef] <asn:4> *ptracer_cred
   kernel/ptrace.c:69:29: sparse:     got struct cred const *
   kernel/ptrace.c:122:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] <asn:4> *ptracer_cred @@
   kernel/ptrace.c:122:18: sparse:     expected struct cred const *old_cred
   kernel/ptrace.c:122:18: sparse:     got struct cred const [noderef] <asn:4> *ptracer_cred
   kernel/ptrace.c:191:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:191:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:191:9: sparse:    struct task_struct *
   kernel/ptrace.c:236:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:236:44: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/ptrace.c:236:44: sparse:    struct task_struct *
   kernel/ptrace.c:460:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/ptrace.c:460:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:460:54: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/ptrace.c:468:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/ptrace.c:468:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:468:53: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/ptrace.c:516:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/ptrace.c:516:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:516:41: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
>> kernel/ptrace.c:466:38: sparse: sparse: dereference of noderef expression
   kernel/ptrace.c:667:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   kernel/ptrace.c:683:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   kernel/ptrace.c:835:9: sparse: sparse: context imbalance in 'ptrace_resume' - different lock contexts for basic block
   kernel/ptrace.c:1101:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block
   In file included from kernel/ptrace.c:26:
   include/linux/syscalls.h:196:25: warning: 'sys_ptrace' alias between functions of incompatible types 'long int(long int,  long int,  long unsigned int,  long unsigned int)' and 'long int(long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       36-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/ptrace.c:1123:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    1123 | SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       48-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/ptrace.c:1123:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    1123 | SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
         | ^~~~~~~~~~~~~~~
--
   kernel/signal.c:1232:27: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/signal.c:1232:27: sparse:    struct sighand_struct [noderef] <asn:4> *
   kernel/signal.c:1232:27: sparse:    struct sighand_struct *
   kernel/signal.c:1622:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/signal.c:1622:65: sparse:     expected struct task_struct *tsk
   kernel/signal.c:1622:65: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:1623:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> * @@
   kernel/signal.c:1623:40: sparse:     expected void const volatile *p
   kernel/signal.c:1623:40: sparse:     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
   kernel/signal.c:1623:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> * @@
   kernel/signal.c:1623:40: sparse:     expected void const volatile *p
   kernel/signal.c:1623:40: sparse:     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
   kernel/signal.c:1666:54: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/signal.c:1666:54: sparse:     expected struct task_struct *p
   kernel/signal.c:1666:54: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:1667:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/signal.c:1667:34: sparse:     expected struct task_struct *parent
   kernel/signal.c:1667:34: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:1696:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/signal.c:1696:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:1696:24: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:1699:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   kernel/signal.c:1699:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:1699:24: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   kernel/signal.c:2126:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] <asn:4> *parent @@
   kernel/signal.c:2126:52: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2126:52: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:2128:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> * @@
   kernel/signal.c:2128:49: sparse:     expected void const volatile *p
   kernel/signal.c:2128:49: sparse:     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
   kernel/signal.c:2128:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *p @@     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> * @@
   kernel/signal.c:2128:49: sparse:     expected void const volatile *p
   kernel/signal.c:2128:49: sparse:     got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
   kernel/signal.c:1156:9: sparse: sparse: context imbalance in 'do_send_sig_info' - different lock contexts for basic block
   kernel/signal.c:1259:9: sparse: sparse: context imbalance in '__lock_task_sighand' - different lock contexts for basic block
   kernel/signal.c:1573:9: sparse: sparse: context imbalance in 'send_sigqueue' - different lock contexts for basic block
>> kernel/signal.c:1604:47: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1623:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1623:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1623:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1623:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1641:19: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1761:13: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file (through arch/x86/include/asm/stacktrace.h, arch/x86/include/asm/perf_event.h, include/linux/perf_event.h, ...):
   include/linux/ptrace.h:91:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   include/linux/ptrace.h:91:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:91:40: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:91:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:91:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:91:60: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:1957:13: sparse: sparse: context imbalance in 'do_signal_stop' - different lock contexts for basic block
   kernel/signal.c:2128:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2128:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2128:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2128:49: sparse: sparse: dereference of noderef expression
   include/linux/ptrace.h:91:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] <asn:4> *real_parent @@
   include/linux/ptrace.h:91:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:91:40: sparse:     got struct task_struct [noderef] <asn:4> *real_parent
   include/linux/ptrace.h:91:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] <asn:4> *parent @@
   include/linux/ptrace.h:91:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:91:60: sparse:     got struct task_struct [noderef] <asn:4> *parent
   kernel/signal.c:2206:25: sparse: sparse: context imbalance in 'get_signal' - unexpected unlock
   kernel/signal.c:3065:13: warning: no previous prototype for 'sigaction_compat_abi' [-Wmissing-prototypes]
    3065 | void __weak sigaction_compat_abi(struct k_sigaction *act,
         |             ^~~~~~~~~~~~~~~~~~~~
   In file included from kernel/signal.c:27:
   include/linux/syscalls.h:196:25: warning: 'sys_rt_sigprocmask' alias between functions of incompatible types 'long int(int,  sigset_t *, sigset_t *, size_t)' {aka 'long int(int,  sigset_t *, sigset_t *, long unsigned int)'} and 'long int(long int,  long int,  long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       70-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/signal.c:2553:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    2553 | SYSCALL_DEFINE4(rt_sigprocmask, int, how, sigset_t __user *, nset,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       82-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:186:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     186 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/signal.c:2553:1: note: in expansion of macro 'SYSCALL_DEFINE4'
    2553 | SYSCALL_DEFINE4(rt_sigprocmask, int, how, sigset_t __user *, nset,
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_rt_sigsuspend' alias between functions of incompatible types 'long int(sigset_t *, size_t)' {aka 'long int(sigset_t *, long unsigned int)'} and 'long int(long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       94-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:184:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     184 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/signal.c:3560:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3560 | SYSCALL_DEFINE2(rt_sigsuspend, sigset_t __user *, unewset, size_t, sigsetsize)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       106-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:184:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     184 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/signal.c:3560:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3560 | SYSCALL_DEFINE2(rt_sigsuspend, sigset_t __user *, unewset, size_t, sigsetsize)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:196:25: warning: 'sys_signal' alias between functions of incompatible types 'long int(int,  void (*)(int))' and 'long int(long int,  long int)' [-Wattribute-alias=]
     196 |         asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       118-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:184:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     184 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/signal.c:3513:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3513 | SYSCALL_DEFINE2(signal, int, sig, __sighandler_t, handler)
         | ^~~~~~~~~~~~~~~
   include/linux/syscalls.h:200:25: note: aliased declaration here
     200 |         asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))       130-      |                         ^~~
   include/linux/syscalls.h:192:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     192 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:184:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     184 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   kernel/signal.c:3513:1: note: in expansion of macro 'SYSCALL_DEFINE2'
    3513 | SYSCALL_DEFINE2(signal, int, sig, __sighandler_t, handler)
--
>> kernel/pid.c:471:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/pid.c:471:23: sparse:    struct pid [noderef] <asn:4> *
>> kernel/pid.c:471:23: sparse:    struct pid *
   kernel/pid.c:532:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/pid.c:532:32: sparse:    struct pid [noderef] <asn:4> *
   kernel/pid.c:532:32: sparse:    struct pid *
--
>> kernel/cred.c:147:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> kernel/cred.c:147:9: sparse:    struct cred *
   kernel/cred.c:147:9: sparse:    struct cred const [noderef] <asn:4> *
   kernel/cred.c:148:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/cred.c:148:9: sparse:    struct cred *
   kernel/cred.c:148:9: sparse:    struct cred const [noderef] <asn:4> *
   kernel/cred.c:161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t const [usertype] *v @@     got struct atomic_t const [noderef] <asn:4> * @@
   kernel/cred.c:161:9: sparse:     expected struct atomic_t const [usertype] *v
   kernel/cred.c:161:9: sparse:     got struct atomic_t const [noderef] <asn:4> *
   kernel/cred.c:161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:161:9: sparse:     expected struct cred const *cred
   kernel/cred.c:161:9: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:165:17: sparse: sparse: cast removes address space '<asn:4>' of expression
   kernel/cred.c:171:17: sparse: sparse: cast removes address space '<asn:4>' of expression
   kernel/cred.c:258:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:258:13: sparse:     expected struct cred const *old
   kernel/cred.c:258:13: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:334:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:334:42: sparse:     expected struct cred const *cred
   kernel/cred.c:334:42: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:334:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] <asn:4> *real_cred @@     got struct cred const * @@
   kernel/cred.c:334:30: sparse:     expected struct cred const [noderef] <asn:4> *real_cred
   kernel/cred.c:334:30: sparse:     got struct cred const *
   kernel/cred.c:335:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:335:27: sparse:     expected struct cred const *cred
   kernel/cred.c:335:27: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:336:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *_cred @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:336:41: sparse:     expected struct cred const *_cred
   kernel/cred.c:336:41: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:337:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t const [usertype] *v @@     got struct atomic_t const [noderef] <asn:4> * @@
   kernel/cred.c:337:17: sparse:     expected struct atomic_t const [usertype] *v
   kernel/cred.c:337:17: sparse:     got struct atomic_t const [noderef] <asn:4> *
   kernel/cred.c:337:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:337:17: sparse:     expected struct cred const *cred
   kernel/cred.c:337:17: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:374:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] <asn:4> *real_cred @@     got struct cred const * @@
   kernel/cred.c:374:32: sparse:     expected struct cred const [noderef] <asn:4> *real_cred
   kernel/cred.c:374:32: sparse:     got struct cred const *
   kernel/cred.c:426:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] <asn:4> *real_cred @@
   kernel/cred.c:426:38: sparse:     expected struct cred const *old
   kernel/cred.c:426:38: sparse:     got struct cred const [noderef] <asn:4> *real_cred
   kernel/cred.c:432:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/cred.c:432:9: sparse:    struct cred const [noderef] <asn:4> *
>> kernel/cred.c:432:9: sparse:    struct cred const *
   kernel/cred.c:523:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:523:41: sparse:     expected struct cred const *old
   kernel/cred.c:523:41: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:552:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *override @@     got struct cred const [noderef] <asn:4> *cred @@
   kernel/cred.c:552:46: sparse:     expected struct cred const *override
   kernel/cred.c:552:46: sparse:     got struct cred const [noderef] <asn:4> *cred
   kernel/cred.c:340:30: sparse: sparse: dereference of noderef expression
   kernel/cred.c:340:30: sparse: sparse: dereference of noderef expression

vim +1315 kernel/events/core.c

7f453c24b95a08 kernel/perf_counter.c Peter Zijlstra   2009-07-21  1291  
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1292  /*
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar      2009-09-21  1293   * Get the perf_event_context for a task and lock it.
63b6da39bb38e8 kernel/events/core.c  Peter Zijlstra   2016-01-14  1294   *
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1295   * This has to cope with with the fact that until it is locked,
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1296   * the context could get moved to another task.
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1297   */
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar      2009-09-21  1298  static struct perf_event_context *
8dc85d54728566 kernel/perf_event.c   Peter Zijlstra   2010-09-02  1299  perf_lock_task_context(struct task_struct *task, int ctxn, unsigned long *flags)
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1300  {
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar      2009-09-21  1301  	struct perf_event_context *ctx;
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1302  
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1303  retry:
058ebd0eba3aff kernel/events/core.c  Peter Zijlstra   2013-07-12  1304  	/*
058ebd0eba3aff kernel/events/core.c  Peter Zijlstra   2013-07-12  1305  	 * One of the few rules of preemptible RCU is that one cannot do
058ebd0eba3aff kernel/events/core.c  Peter Zijlstra   2013-07-12  1306  	 * rcu_read_unlock() while holding a scheduler (or nested) lock when
2fd59077755c44 kernel/events/core.c  Paul E. McKenney 2015-11-04  1307  	 * part of the read side critical section was irqs-enabled -- see
058ebd0eba3aff kernel/events/core.c  Peter Zijlstra   2013-07-12  1308  	 * rcu_read_unlock_special().
058ebd0eba3aff kernel/events/core.c  Peter Zijlstra   2013-07-12  1309  	 *
058ebd0eba3aff kernel/events/core.c  Peter Zijlstra   2013-07-12  1310  	 * Since ctx->lock nests under rq->lock we must ensure the entire read
2fd59077755c44 kernel/events/core.c  Paul E. McKenney 2015-11-04  1311  	 * side critical section has interrupts disabled.
058ebd0eba3aff kernel/events/core.c  Peter Zijlstra   2013-07-12  1312  	 */
2fd59077755c44 kernel/events/core.c  Paul E. McKenney 2015-11-04  1313  	local_irq_save(*flags);
058ebd0eba3aff kernel/events/core.c  Peter Zijlstra   2013-07-12  1314  	rcu_read_lock();
8dc85d54728566 kernel/perf_event.c   Peter Zijlstra   2010-09-02 @1315  	ctx = rcu_dereference(task->perf_event_ctxp[ctxn]);
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1316  	if (ctx) {
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1317  		/*
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1318  		 * If this context is a clone of another, it might
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1319  		 * get swapped for another underneath us by
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar      2009-09-21  1320  		 * perf_event_task_sched_out, though the
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1321  		 * rcu_read_lock() protects us from any context
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1322  		 * getting freed.  Lock the context and check if it
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1323  		 * got swapped before we could get the lock, and retry
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1324  		 * if so.  If we locked the right context, then it
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1325  		 * can't get swapped on us any more.
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1326  		 */
2fd59077755c44 kernel/events/core.c  Paul E. McKenney 2015-11-04  1327  		raw_spin_lock(&ctx->lock);
8dc85d54728566 kernel/perf_event.c   Peter Zijlstra   2010-09-02  1328  		if (ctx != rcu_dereference(task->perf_event_ctxp[ctxn])) {
2fd59077755c44 kernel/events/core.c  Paul E. McKenney 2015-11-04  1329  			raw_spin_unlock(&ctx->lock);
058ebd0eba3aff kernel/events/core.c  Peter Zijlstra   2013-07-12  1330  			rcu_read_unlock();
2fd59077755c44 kernel/events/core.c  Paul E. McKenney 2015-11-04  1331  			local_irq_restore(*flags);
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1332  			goto retry;
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1333  		}
b49a9e7e72103e kernel/perf_counter.c Peter Zijlstra   2009-06-19  1334  
63b6da39bb38e8 kernel/events/core.c  Peter Zijlstra   2016-01-14  1335  		if (ctx->task == TASK_TOMBSTONE ||
63b6da39bb38e8 kernel/events/core.c  Peter Zijlstra   2016-01-14  1336  		    !atomic_inc_not_zero(&ctx->refcount)) {
2fd59077755c44 kernel/events/core.c  Paul E. McKenney 2015-11-04  1337  			raw_spin_unlock(&ctx->lock);
b49a9e7e72103e kernel/perf_counter.c Peter Zijlstra   2009-06-19  1338  			ctx = NULL;
828b6f0e261709 kernel/events/core.c  Peter Zijlstra   2016-01-27  1339  		} else {
63b6da39bb38e8 kernel/events/core.c  Peter Zijlstra   2016-01-14  1340  			WARN_ON_ONCE(ctx->task != task);
b49a9e7e72103e kernel/perf_counter.c Peter Zijlstra   2009-06-19  1341  		}
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1342  	}
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1343  	rcu_read_unlock();
2fd59077755c44 kernel/events/core.c  Paul E. McKenney 2015-11-04  1344  	if (!ctx)
2fd59077755c44 kernel/events/core.c  Paul E. McKenney 2015-11-04  1345  		local_irq_restore(*flags);
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1346  	return ctx;
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1347  }
25346b93ca0790 kernel/perf_counter.c Paul Mackerras   2009-06-01  1348  

:::::: The code at line 1315 was first introduced by commit
:::::: 8dc85d547285668e509f86c177bcd4ea055bcaaf perf: Multiple task contexts

:::::: TO: Peter Zijlstra <a.p.zijlstra@chello.nl>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
