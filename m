Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BF47D44E0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjJXBWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJXBWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:22:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70203EE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 18:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698110557; x=1729646557;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nDTslLenkizcRrHJKivdjS1LbaTiffk2Cypje6raSv4=;
  b=lUrmEXFBj09vaAJ85pvA4T/jHQUnYyNgc5eYsMCzIVfISH4ZWrp+0fv+
   7Gijj4zvdLSyvJ1KgA2AsuFGl0/ZPIK8BZtAOpMhEQSTpiEU9oiwbVgeP
   bmcJSoNiwFCG0Sog0WDerBBQDgKwboJmzjhdwJN8Be4OUgCNAE5Vg8GLN
   NnFnuzJdxmUSPlWpEG2gX/ssrJpfHqWYCgiE6GlyJJQ9Ui1EljffwtXFa
   HPaXp9yLnB3w2WIiSh4wHyh5OG2MwDu2G1cLAs4baG7/lDskaf4Udn2Ut
   W1tfi+ZfsOQQahcyTwkSrZ1bJzcQKmqaq2i2u2e1Q613/gTbqJ8B+RVFF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366306518"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="366306518"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1005511042"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="1005511042"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2023 18:22:33 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qv67r-0007RR-12;
        Tue, 24 Oct 2023 01:22:31 +0000
Date:   Tue, 24 Oct 2023 09:21:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [paulmck-rcu:mmap_sem.2023.10.18a 31/31] ld.lld: error: undefined
 symbol: __bad_udelay
Message-ID: <202310240930.H14JVILQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git mmap_sem.2023.10.18a
head:   4015256f2bc734d4175381762282784597f41cfa
commit: 4015256f2bc734d4175381762282784597f41cfa [31/31] EXP TESTING: introduce delay between getting a VMA and using it in show_map
config: arm-ixp4xx_defconfig (https://download.01.org/0day-ci/archive/20231024/202310240930.H14JVILQ-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310240930.H14JVILQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310240930.H14JVILQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __bad_udelay
   >>> referenced by task_mmu.c
   >>>               fs/proc/task_mmu.o:(show_map) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
