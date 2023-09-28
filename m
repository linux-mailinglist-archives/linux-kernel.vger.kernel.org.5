Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D367E7B2698
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjI1U2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjI1U2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:28:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A195C180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695932911; x=1727468911;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E1SH1mOmeW8N87NqKFTxh8CfCG/hBb/acV0NYiuje34=;
  b=HIrg6LiDzUBe3gITbVeGQxYGNDwHPgyOgVdBBUpxbpPqLi2QV4PZHFGd
   TSsNlLdjf/wbnl/aHXaaRri9iXn0uxRxAsGy6mHb9gMh7bPZmGnebbuyd
   4UfbmzlpnXc/VPEQkb7aDIsn6G9KZZ/IqSB5eha6IRoHZRTOJAXJzrSNw
   O1Lba/unCQTCHvUImy6OTrPVFZ8cjnzd2v5S/jswwFmKduyrEnecAvG1w
   b4YuDl3y/s69+0tXMVehpcArSyVSWpPN940tobs0aEOdn/m7dlwnjw6iB
   SWxHX6Ul7Wul5KM67UB90LS3JAbsrf80rjysXLEUcj9Kp3s44qq+j3hEB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="382070578"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="382070578"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 13:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="753132718"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="753132718"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 28 Sep 2023 13:28:28 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlxcY-0001vP-2Z;
        Thu, 28 Sep 2023 20:28:26 +0000
Date:   Fri, 29 Sep 2023 04:28:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: arch/x86/kernel/callthunks.c:303:20: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202309290455.MMN9bxIp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9ed22ae6be817d7a3f5c15ca22cbc9d3963b481d
commit: f5c1bb2afe93396d41c5cbdcb909b08a75b8dde4 x86/calldepth: Add ret/call counting for debug
date:   12 months ago
config: x86_64-randconfig-121-20230929 (https://download.01.org/0day-ci/archive/20230929/202309290455.MMN9bxIp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290455.MMN9bxIp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290455.MMN9bxIp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/callthunks.c:303:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/callthunks.c:303:20: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/callthunks.c:303:20: sparse:     got unsigned long long *
   arch/x86/kernel/callthunks.c:306:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/x86/kernel/callthunks.c:306:20: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/callthunks.c:306:20: sparse:     got unsigned long long *

vim +303 arch/x86/kernel/callthunks.c

   296	
   297	#if defined(CONFIG_CALL_THUNKS_DEBUG) && defined(CONFIG_DEBUG_FS)
   298	static int callthunks_debug_show(struct seq_file *m, void *p)
   299	{
   300		unsigned long cpu = (unsigned long)m->private;
   301	
   302		seq_printf(m, "C: %16llu R: %16llu S: %16llu X: %16llu\n,",
 > 303			   per_cpu(__x86_call_count, cpu),
   304			   per_cpu(__x86_ret_count, cpu),
   305			   per_cpu(__x86_stuffs_count, cpu),
   306			   per_cpu(__x86_ctxsw_count, cpu));
   307		return 0;
   308	}
   309	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
