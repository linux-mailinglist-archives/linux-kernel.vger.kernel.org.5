Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB407E8B42
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 15:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjKKOpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKKOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:45:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B63AA8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699713899; x=1731249899;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nGThmn244lw7LSM9OvXpI+S/eU8tx0PV47aYK0e5KVo=;
  b=fIQZ5PO+kiWei98mESPwtGGgMve2EhW4lduH6VKxJ/Bs32wWDTU+sSKZ
   JwXgtfCp03dPoEGAWCp0BtbXoUCwHIYnIUulACpc8GZLaPjqdJjVhkgIR
   8TmOx7iwJPF9ikzwaWL8pQ+sbtB63Hpx83fSz87tVS92LgKlFpvSQ06s8
   H6okkzra5Ru5YwVH5LvUKjrAndxRN0m86XIYAkLKYKVid+L0oTowf++IA
   GpJLYA8Rq56AIsbYqkjzHS+FcOlZmECDSJqsdbSUJ+qibTAiF3TXASsDI
   XkgouUIpZamvUcILW4QymPoXij80sOAtSFR/eIQlBh/mG2FLvuBlAaHKa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="3293156"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="3293156"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 06:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="854604536"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="854604536"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2023 06:44:56 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1pEE-000AW6-2a;
        Sat, 11 Nov 2023 14:44:54 +0000
Date:   Sat, 11 Nov 2023 22:43:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/events/core.c:4881:24: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202311112205.oMWYlOQe-lkp@intel.com>
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
commit: ee219b946e4bf7df2d2c68dfaae1bdaa360ec2ea uapi: turn __poll_t sparse checks on by default
date:   5 years ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231111/202311112205.oMWYlOQe-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311112205.oMWYlOQe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311112205.oMWYlOQe-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/events/core.c:570:26: sparse: sparse: function 'perf_pmu_name' with external linkage has definition
   kernel/events/core.c:1034:1: sparse: sparse: symbol 'perf_cgroup_switch' was not declared. Should it be static?
   kernel/events/core.c:1132:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got int * @@
   kernel/events/core.c:1132:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:1132:22: sparse:     got int *
   kernel/events/core.c:1139:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got int * @@
   kernel/events/core.c:1139:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:1139:22: sparse:     got int *
   kernel/events/core.c:1382:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1382:15: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:1382:15: sparse:    struct perf_event_context *
   kernel/events/core.c:1395:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1395:28: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:1395:28: sparse:    struct perf_event_context *
   kernel/events/core.c:3083:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3083:18: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:3083:18: sparse:    struct perf_event_context *
   kernel/events/core.c:3084:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3084:23: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:3084:23: sparse:    struct perf_event_context *
   kernel/events/core.c:3115:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3115:25: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:3115:25: sparse:    struct perf_event_context *
   kernel/events/core.c:3116:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3116:25: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:3116:25: sparse:    struct perf_event_context *
   kernel/events/core.c:3139:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:3139:43: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:3139:43: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:3150:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:3150:43: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:3150:43: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:4119:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:4119:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:4119:26: sparse:     got struct perf_cpu_context *
>> kernel/events/core.c:4881:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] events @@     got int @@
   kernel/events/core.c:4881:24: sparse:     expected restricted __poll_t [usertype] events
   kernel/events/core.c:4881:24: sparse:     got int
   kernel/events/core.c:5068:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5068:22: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:5068:22: sparse:    struct ring_buffer *
   kernel/events/core.c:5197:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5197:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:5197:14: sparse:    struct ring_buffer *
   kernel/events/core.c:5230:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5230:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:5230:14: sparse:    struct ring_buffer *
   kernel/events/core.c:5287:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5287:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:5287:14: sparse:    struct ring_buffer *
   kernel/events/core.c:5373:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5373:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:5373:14: sparse:    struct ring_buffer *
   kernel/events/core.c:5386:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5386:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:5386:14: sparse:    struct ring_buffer *
   kernel/events/core.c:6646:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:6646:23: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:6646:23: sparse:    struct perf_event_context *
   kernel/events/core.c:6736:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:6736:13: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/core.c:6736:13: sparse:    struct ring_buffer *
   kernel/events/core.c:6744:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:6744:43: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:6744:43: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:7399:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7399:23: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:7399:23: sparse:    struct perf_event_context *
   kernel/events/core.c:8079:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8079:9: sparse:    struct swevent_hlist [noderef] <asn:4> *
   kernel/events/core.c:8079:9: sparse:    struct swevent_hlist *
   kernel/events/core.c:9408:35: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct perf_cpu_context [noderef] <asn:3> * @@     got struct perf_cpu_context *[noderef] pmu_cpu_context @@
   kernel/events/core.c:9408:35: sparse:     expected struct perf_cpu_context [noderef] <asn:3> *
   kernel/events/core.c:9408:35: sparse:     got struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:9425:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got struct perf_cpu_context *[noderef] pmu_cpu_context @@
   kernel/events/core.c:9425:24: sparse:     expected void [noderef] <asn:3> *__pdata
   kernel/events/core.c:9425:24: sparse:     got struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:9440:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
   kernel/events/core.c:9491:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:9491:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:9491:26: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:9570:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int *[noderef] pmu_disable_count @@     got int [noderef] <asn:3> * @@
   kernel/events/core.c:9570:32: sparse:     expected int *[noderef] pmu_disable_count
   kernel/events/core.c:9570:32: sparse:     got int [noderef] <asn:3> *
   kernel/events/core.c:9610:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct perf_cpu_context *[noderef] pmu_cpu_context @@     got struct perf_cpu_context [noderef] <asn:3> * @@
   kernel/events/core.c:9610:30: sparse:     expected struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:9610:30: sparse:     got struct perf_cpu_context [noderef] <asn:3> *
   kernel/events/core.c:9615:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct perf_cpu_context *[noderef] pmu_cpu_context @@     got struct perf_cpu_context [noderef] <asn:3> * @@
   kernel/events/core.c:9615:30: sparse:     expected struct perf_cpu_context *[noderef] pmu_cpu_context
   kernel/events/core.c:9615:30: sparse:     got struct perf_cpu_context [noderef] <asn:3> *
   kernel/events/core.c:9622:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:9622:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:9622:26: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:9675:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got int *[noderef] pmu_disable_count @@
   kernel/events/core.c:9675:24: sparse:     expected void [noderef] <asn:3> *__pdata
   kernel/events/core.c:9675:24: sparse:     got int *[noderef] pmu_disable_count
   kernel/events/core.c:9696:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got int *[noderef] pmu_disable_count @@
   kernel/events/core.c:9696:24: sparse:     expected void [noderef] <asn:3> *__pdata
   kernel/events/core.c:9696:24: sparse:     got int *[noderef] pmu_disable_count
   kernel/events/core.c:10897:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:10897:20: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:10897:20: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:10898:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:10898:20: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:10898:20: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:11068:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:11068:9: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:11068:9: sparse:    struct perf_event_context *
   kernel/events/core.c:11178:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:11178:17: sparse:    struct perf_event_context [noderef] <asn:4> *
   kernel/events/core.c:11178:17: sparse:    struct perf_event_context *
   kernel/events/core.c:11566:6: sparse: sparse: symbol 'perf_swevent_init_cpu' was not declared. Should it be static?
   kernel/events/core.c:11631:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:11631:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:11631:26: sparse:     got struct perf_cpu_context *
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
   kernel/events/core.c:1132:22: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:1139:22: sparse: sparse: dereference of noderef expression
   kernel/events/core.c: note: in included file (through include/linux/rculist.h, include/linux/dcache.h, include/linux/fs.h):
   include/linux/rcupdate.h:686:9: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
   kernel/events/core.c:1429:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
   kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
   kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
   kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
   kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
   kernel/events/core.c:2538:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
--
>> kernel/events/ring_buffer.c:22:39: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int i @@     got restricted __poll_t [usertype] @@
   kernel/events/ring_buffer.c:22:39: sparse:     expected int i
   kernel/events/ring_buffer.c:22:39: sparse:     got restricted __poll_t [usertype]
   kernel/events/ring_buffer.c:137:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer *
   kernel/events/ring_buffer.c:137:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer *
   kernel/events/ring_buffer.c:137:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer [noderef] <asn:4> *
   kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer *
   kernel/events/ring_buffer.c:105:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     105 | static bool __always_inline
         | ^~~~~~
   kernel/events/ring_buffer.c:116:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     116 | static int __always_inline
         | ^~~~~~
   kernel/events/ring_buffer.c:416:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
     416 | static bool __always_inline rb_need_aux_wakeup(struct ring_buffer *rb)
         | ^~~~~~

vim +4881 kernel/events/core.c

0793a61d4df8da kernel/perf_counter.c Thomas Gleixner           2008-12-04  4862  
9dd957485d7d89 kernel/events/core.c  Al Viro                   2017-07-03  4863  static __poll_t perf_poll(struct file *file, poll_table *wait)
0793a61d4df8da kernel/perf_counter.c Thomas Gleixner           2008-12-04  4864  {
cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar               2009-09-21  4865  	struct perf_event *event = file->private_data;
76369139ceb955 kernel/events/core.c  Frederic Weisbecker       2011-05-19  4866  	struct ring_buffer *rb;
a9a08845e9acbd kernel/events/core.c  Linus Torvalds            2018-02-11  4867  	__poll_t events = EPOLLHUP;
c7138f37f905bb kernel/perf_counter.c Peter Zijlstra            2009-03-24  4868  
e708d7ad807374 kernel/events/core.c  Sebastian Andrzej Siewior 2014-08-04  4869  	poll_wait(file, &event->waitq, wait);
179033b3e064d2 kernel/events/core.c  Jiri Olsa                 2014-08-07  4870  
dc633982ff3f4f kernel/events/core.c  Jiri Olsa                 2014-09-12  4871  	if (is_event_hup(event))
179033b3e064d2 kernel/events/core.c  Jiri Olsa                 2014-08-07  4872  		return events;
c7138f37f905bb kernel/perf_counter.c Peter Zijlstra            2009-03-24  4873  
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra            2011-11-26  4874  	/*
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra            2013-06-04  4875  	 * Pin the event->rb by taking event->mmap_mutex; otherwise
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra            2013-06-04  4876  	 * perf_event_set_output() can swizzle our rb and make us miss wakeups.
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra            2011-11-26  4877  	 */
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra            2011-11-26  4878  	mutex_lock(&event->mmap_mutex);
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra            2013-06-04  4879  	rb = event->rb;
9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra            2013-06-04  4880  	if (rb)
76369139ceb955 kernel/events/core.c  Frederic Weisbecker       2011-05-19 @4881  		events = atomic_xchg(&rb->poll, 0);
10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra            2011-11-26  4882  	mutex_unlock(&event->mmap_mutex);
0793a61d4df8da kernel/perf_counter.c Thomas Gleixner           2008-12-04  4883  	return events;
0793a61d4df8da kernel/perf_counter.c Thomas Gleixner           2008-12-04  4884  }
0793a61d4df8da kernel/perf_counter.c Thomas Gleixner           2008-12-04  4885  

:::::: The code at line 4881 was first introduced by commit
:::::: 76369139ceb955deefc509e6e12ce9d6ce50ccab perf: Split up buffer handling from core code

:::::: TO: Frederic Weisbecker <fweisbec@gmail.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
