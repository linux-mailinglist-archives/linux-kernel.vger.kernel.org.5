Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57939800168
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjLACI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjLACI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:08:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61313198
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701396540; x=1732932540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TY/+wn7IOSODV+thJH4zKZ5KoN8TjLrzO4ZngD8AUEY=;
  b=j/7g9sjCSWldTrb3H11qv2E53HSkxU4fxcUJmWkkZ1tJz27u4PklzEUJ
   UuhObuekkkmMq37S2FAc9Jpfzeg68DCCDOOqfB3HZ565AYYLmTGz/fijU
   gklKg6SWDYgGN03NT+XBdhWp9Xf+mUb9tpo2vxdXkDF0GKl2h0MJNbXNi
   XkUIFmDp1BYu04/Ydg3zHz4oTOniI05oHmOgtRMZdl78BhTLMND8vZWI2
   Qj/md/F6NUgtl3sL6cNQpUEdIgQdYsn6IDX5W8A9uMHaGs7Duzt1561c0
   2P7JCykcW2e4Vh9uZcYYo6Mt4WdJRapEhQ0UTeUy9fiPb7aFFJh0vA8V2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="424573012"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="424573012"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 18:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803893635"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="803893635"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2023 18:08:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8sxb-0002xE-1y;
        Fri, 01 Dec 2023 02:08:55 +0000
Date:   Fri, 1 Dec 2023 10:08:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/loongarch/kernel/signal.c:370:47: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202312011002.Ruq1PBC9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2594faafeee2f4406ff82790604e4e3f55037d60
commit: 616500232e632dba8b03981eeccadacf2fbf1c30 LoongArch: Add vector extensions support
date:   5 months ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20231201/202312011002.Ruq1PBC9-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231201/202312011002.Ruq1PBC9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312011002.Ruq1PBC9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/loongarch/kernel/signal.c:94:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:94:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:94:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:94:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:114:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:114:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:114:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:114:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:132:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:132:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:132:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:132:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:153:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:153:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:153:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:153:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:173:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:173:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:173:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:173:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:198:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:198:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:198:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:198:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:223:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:223:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:223:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:223:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:232:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:232:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:232:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:232:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:241:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:241:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:241:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:241:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:250:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:250:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:250:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:250:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:259:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:259:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:259:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:259:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:268:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:268:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:268:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:268:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:300:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:300:52: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:300:52: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:301:92: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:301:92: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:301:92: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:301:47: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:301:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fpu_context [noderef] __user *fpu_ctx @@     got struct fpu_context * @@
   arch/loongarch/kernel/signal.c:301:47: sparse:     expected struct fpu_context [noderef] __user *fpu_ctx
   arch/loongarch/kernel/signal.c:301:47: sparse:     got struct fpu_context *
   arch/loongarch/kernel/signal.c:302:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:302:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:302:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:302:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:334:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:334:52: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:334:52: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:335:92: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:335:92: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:335:92: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:335:47: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:335:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fpu_context [noderef] __user *fpu_ctx @@     got struct fpu_context * @@
   arch/loongarch/kernel/signal.c:335:47: sparse:     expected struct fpu_context [noderef] __user *fpu_ctx
   arch/loongarch/kernel/signal.c:335:47: sparse:     got struct fpu_context *
   arch/loongarch/kernel/signal.c:336:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:336:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:336:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:336:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:369:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:369:52: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:369:52: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:370:92: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:370:92: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:370:92: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:370:47: sparse: sparse: cast removes address space '__user' of expression
>> arch/loongarch/kernel/signal.c:370:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct lsx_context [noderef] __user *lsx_ctx @@     got struct lsx_context * @@
   arch/loongarch/kernel/signal.c:370:47: sparse:     expected struct lsx_context [noderef] __user *lsx_ctx
   arch/loongarch/kernel/signal.c:370:47: sparse:     got struct lsx_context *
   arch/loongarch/kernel/signal.c:371:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:371:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:371:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:371:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:406:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:406:52: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:406:52: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:407:92: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:407:92: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:407:92: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:407:47: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:407:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct lsx_context [noderef] __user *lsx_ctx @@     got struct lsx_context * @@
   arch/loongarch/kernel/signal.c:407:47: sparse:     expected struct lsx_context [noderef] __user *lsx_ctx
   arch/loongarch/kernel/signal.c:407:47: sparse:     got struct lsx_context *
   arch/loongarch/kernel/signal.c:408:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:408:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:408:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:408:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:444:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:444:53: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:444:53: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:446:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:446:64: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:446:64: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:446:18: sparse: sparse: cast removes address space '__user' of expression
>> arch/loongarch/kernel/signal.c:446:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct lasx_context [noderef] __user *lasx_ctx @@     got struct lasx_context * @@
   arch/loongarch/kernel/signal.c:446:18: sparse:     expected struct lasx_context [noderef] __user *lasx_ctx
   arch/loongarch/kernel/signal.c:446:18: sparse:     got struct lasx_context *
   arch/loongarch/kernel/signal.c:447:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:447:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:447:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:447:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:484:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info *addr @@
   arch/loongarch/kernel/signal.c:484:53: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:484:53: sparse:     got struct sctx_info *addr
   arch/loongarch/kernel/signal.c:486:64: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sctx_info *info @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:486:64: sparse:     expected struct sctx_info *info
   arch/loongarch/kernel/signal.c:486:64: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:486:18: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:486:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct lasx_context [noderef] __user *lasx_ctx @@     got struct lasx_context * @@
   arch/loongarch/kernel/signal.c:486:18: sparse:     expected struct lasx_context [noderef] __user *lasx_ctx
   arch/loongarch/kernel/signal.c:486:18: sparse:     got struct lasx_context *
   arch/loongarch/kernel/signal.c:487:36: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:487:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long [noderef] [usertype] __user *regs @@     got unsigned long long [usertype] * @@
   arch/loongarch/kernel/signal.c:487:36: sparse:     expected unsigned long long [noderef] [usertype] __user *regs
   arch/loongarch/kernel/signal.c:487:36: sparse:     got unsigned long long [usertype] *
   arch/loongarch/kernel/signal.c:543:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info * @@
   arch/loongarch/kernel/signal.c:543:14: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:543:14: sparse:     got struct sctx_info *
   arch/loongarch/kernel/signal.c:570:42: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sctx_info *addr @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:570:42: sparse:     expected struct sctx_info *addr
   arch/loongarch/kernel/signal.c:570:42: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:577:42: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sctx_info *addr @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:577:42: sparse:     expected struct sctx_info *addr
   arch/loongarch/kernel/signal.c:577:42: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:584:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sctx_info *addr @@     got struct sctx_info [noderef] __user *info @@
   arch/loongarch/kernel/signal.c:584:43: sparse:     expected struct sctx_info *addr
   arch/loongarch/kernel/signal.c:584:43: sparse:     got struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:591:46: sparse: sparse: cast removes address space '__user' of expression
   arch/loongarch/kernel/signal.c:591:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sctx_info [noderef] __user *info @@     got struct sctx_info * @@
   arch/loongarch/kernel/signal.c:591:22: sparse:     expected struct sctx_info [noderef] __user *info
   arch/loongarch/kernel/signal.c:591:22: sparse:     got struct sctx_info *
   arch/loongarch/kernel/signal.c:737:17: sparse: sparse: symbol 'sys_rt_sigreturn' was not declared. Should it be static?
   arch/loongarch/kernel/signal.c: note: in included file:
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_w'
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:81:17: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_w'
   arch/loongarch/include/asm/fpu.h:81:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:81:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:72:17: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/fpu.h:81:17: sparse: sparse: cast from unknown type
   arch/loongarch/kernel/signal.c: note: in included file (through arch/loongarch/include/asm/cpu-info.h, arch/loongarch/include/asm/processor.h, ...):
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_w'
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: undefined identifier '__builtin_loongarch_csrwr_w'
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: cast from unknown type
   arch/loongarch/kernel/signal.c: note: in included file:
   arch/loongarch/include/asm/fpu.h:81:17: sparse: sparse: cast from unknown type
   arch/loongarch/kernel/signal.c: note: in included file (through arch/loongarch/include/asm/cpu-info.h, arch/loongarch/include/asm/processor.h, ...):
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:1281:1: sparse: sparse: cast from unknown type

vim +370 arch/loongarch/kernel/signal.c

   365	
   366	static int protected_save_lsx_context(struct extctx_layout *extctx)
   367	{
   368		int err = 0;
   369		struct sctx_info __user *info = extctx->lsx.addr;
 > 370		struct lsx_context __user *lsx_ctx = (struct lsx_context *)get_ctx_through_ctxinfo(info);
   371		uint64_t __user *regs	= (uint64_t *)&lsx_ctx->regs;
   372		uint64_t __user *fcc	= &lsx_ctx->fcc;
   373		uint32_t __user *fcsr	= &lsx_ctx->fcsr;
   374	
   375		while (1) {
   376			lock_fpu_owner();
   377			if (is_lsx_enabled())
   378				err = save_hw_lsx_context(lsx_ctx);
   379			else {
   380				if (is_fpu_owner())
   381					save_fp(current);
   382				err = copy_lsx_to_sigcontext(lsx_ctx);
   383			}
   384			unlock_fpu_owner();
   385	
   386			err |= __put_user(LSX_CTX_MAGIC, &info->magic);
   387			err |= __put_user(extctx->lsx.size, &info->size);
   388	
   389			if (likely(!err))
   390				break;
   391			/* Touch the LSX context and try again */
   392			err = __put_user(0, &regs[0]) |
   393				__put_user(0, &regs[32*2-1]) |
   394				__put_user(0, fcc) |
   395				__put_user(0, fcsr);
   396			if (err)
   397				return err;	/* really bad sigcontext */
   398		}
   399	
   400		return err;
   401	}
   402	
   403	static int protected_restore_lsx_context(struct extctx_layout *extctx)
   404	{
   405		int err = 0, sig = 0, tmp __maybe_unused;
   406		struct sctx_info __user *info = extctx->lsx.addr;
   407		struct lsx_context __user *lsx_ctx = (struct lsx_context *)get_ctx_through_ctxinfo(info);
   408		uint64_t __user *regs	= (uint64_t *)&lsx_ctx->regs;
   409		uint64_t __user *fcc	= &lsx_ctx->fcc;
   410		uint32_t __user *fcsr	= &lsx_ctx->fcsr;
   411	
   412		err = sig = fcsr_pending(fcsr);
   413		if (err < 0)
   414			return err;
   415	
   416		while (1) {
   417			lock_fpu_owner();
   418			if (is_lsx_enabled())
   419				err = restore_hw_lsx_context(lsx_ctx);
   420			else {
   421				err = copy_lsx_from_sigcontext(lsx_ctx);
   422				if (is_fpu_owner())
   423					restore_fp(current);
   424			}
   425			unlock_fpu_owner();
   426	
   427			if (likely(!err))
   428				break;
   429			/* Touch the LSX context and try again */
   430			err = __get_user(tmp, &regs[0]) |
   431				__get_user(tmp, &regs[32*2-1]) |
   432				__get_user(tmp, fcc) |
   433				__get_user(tmp, fcsr);
   434			if (err)
   435				break;	/* really bad sigcontext */
   436		}
   437	
   438		return err ?: sig;
   439	}
   440	
   441	static int protected_save_lasx_context(struct extctx_layout *extctx)
   442	{
   443		int err = 0;
   444		struct sctx_info __user *info = extctx->lasx.addr;
   445		struct lasx_context __user *lasx_ctx =
 > 446			(struct lasx_context *)get_ctx_through_ctxinfo(info);
   447		uint64_t __user *regs	= (uint64_t *)&lasx_ctx->regs;
   448		uint64_t __user *fcc	= &lasx_ctx->fcc;
   449		uint32_t __user *fcsr	= &lasx_ctx->fcsr;
   450	
   451		while (1) {
   452			lock_fpu_owner();
   453			if (is_lasx_enabled())
   454				err = save_hw_lasx_context(lasx_ctx);
   455			else {
   456				if (is_lsx_enabled())
   457					save_lsx(current);
   458				else if (is_fpu_owner())
   459					save_fp(current);
   460				err = copy_lasx_to_sigcontext(lasx_ctx);
   461			}
   462			unlock_fpu_owner();
   463	
   464			err |= __put_user(LASX_CTX_MAGIC, &info->magic);
   465			err |= __put_user(extctx->lasx.size, &info->size);
   466	
   467			if (likely(!err))
   468				break;
   469			/* Touch the LASX context and try again */
   470			err = __put_user(0, &regs[0]) |
   471				__put_user(0, &regs[32*4-1]) |
   472				__put_user(0, fcc) |
   473				__put_user(0, fcsr);
   474			if (err)
   475				return err;	/* really bad sigcontext */
   476		}
   477	
   478		return err;
   479	}
   480	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
