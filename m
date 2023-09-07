Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BCE796FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 06:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjIGEau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 00:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjIGEat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 00:30:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14919AF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 21:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694061045; x=1725597045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IhdZDVelb2SRvHh1ye8Ux/q8QfgoNi62xkzGDYgICuc=;
  b=YKF/prNttC3mt04KC2CHfjP3tPmlGmAOLIL4V0Rxu1Nb7a0NR7C2P36m
   qNgFVEyC+EGNAmrdxV5H53CQorD3CFs4eQ3mNSmcyMM60IAxxT4AMGodX
   IiNlwkTWwLBgI0hv2XJA5XovIbBYOvpZI3XCT9g4k0JhbuE0cVS9j/cGW
   VZJ/i24gf6RNFutmPRnS6du10OT5mbb121J2TmumHft0n1qiPMG+kTnhw
   SxAtWPCcp+m9A7UFgiqjCBX+e3osC9EHz4W0dXVsZw3+itRgtNWoMijdD
   Qc+ZEq6HQDJqiHzTGz/DQAz4NjtkJdZIndZTcPPOffowxiWvuaKyVSozN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="381042293"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="381042293"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 21:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="741852563"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="741852563"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2023 21:30:43 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qe6fB-0000s7-2D;
        Thu, 07 Sep 2023 04:30:41 +0000
Date:   Thu, 7 Sep 2023 12:30:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Hao Luo <haoluo@google.com>
Subject: kernel/cgroup/rstat.c:166:22: error: no previous declaration for
 'bpf_rstat_flush'
Message-ID: <202309071214.ACNNqbiA-lkp@intel.com>
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

Hi Yosry,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ba2090ca64ea1aa435744884124387db1fac70f
commit: a319185be9f5ad13c2a296d448ac52ffe45d194c cgroup: bpf: enable bpf programs to integrate with rstat
date:   1 year ago
config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20230907/202309071214.ACNNqbiA-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309071214.ACNNqbiA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309071214.ACNNqbiA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/cgroup/rstat.c:166:22: error: no previous declaration for 'bpf_rstat_flush' [-Werror=missing-declarations]
    __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
                         ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/bpf_rstat_flush +166 kernel/cgroup/rstat.c

   147	
   148	/*
   149	 * A hook for bpf stat collectors to attach to and flush their stats.
   150	 * Together with providing bpf kfuncs for cgroup_rstat_updated() and
   151	 * cgroup_rstat_flush(), this enables a complete workflow where bpf progs that
   152	 * collect cgroup stats can integrate with rstat for efficient flushing.
   153	 *
   154	 * A static noinline declaration here could cause the compiler to optimize away
   155	 * the function. A global noinline declaration will keep the definition, but may
   156	 * optimize away the callsite. Therefore, __weak is needed to ensure that the
   157	 * call is still emitted, by telling the compiler that we don't know what the
   158	 * function might eventually be.
   159	 *
   160	 * __diag_* below are needed to dismiss the missing prototype warning.
   161	 */
   162	__diag_push();
   163	__diag_ignore_all("-Wmissing-prototypes",
   164			  "kfuncs which will be used in BPF programs");
   165	
 > 166	__weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
   167					     struct cgroup *parent, int cpu)
   168	{
   169	}
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
