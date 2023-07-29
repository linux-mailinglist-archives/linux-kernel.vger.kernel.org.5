Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA09767B7F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjG2CWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjG2CWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:22:06 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAC44699
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 19:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690597325; x=1722133325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZIJtkSFP4C1Jdyx5k7KpDlEks33oF6Mr+AuBW9d9A0U=;
  b=WT5Oaz6oma9+x+CRE413jJHRdAPG/NujAWF8f2YhmCRfb2flI5fNjdxU
   /SGXYdiZXYz/3Seahg6GSJKPWG6bgLAINih6ZRPXYKRhkfeweSMFFQk1l
   4YZ8/HdsaPxbH92l3P19lsiAVbP4L9eUJOn1SJ9hrccHvJvJ03naAgUxe
   xl4ExMh8M7pNRNS9mnFM4trlJTfYGfsdMwr7kZdaR29njqllTT7Q1l0k3
   zRTwKnknPUBpXyUxJn8k4/7Y2FhKywzcNPJ6DgrthnwhHBf/cyGGAIDjZ
   Nm4ST5q2bD+xvCpHkdaKMFCJGtDqsA99rPWUecL+4yln2ARScz9+Vgn4V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358752701"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="358752701"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 19:22:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="762768503"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="762768503"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2023 19:21:45 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPZaS-0003l5-15;
        Sat, 29 Jul 2023 02:21:44 +0000
Date:   Sat, 29 Jul 2023 10:21:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: arch/mips/kernel/jump_label.c:93:6: warning: no previous prototype
 for function 'jump_label_apply_nops'
Message-ID: <202307291002.3EsIxC16-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   122e7943b252fcf48b4d085dec084e24fc8bec45
commit: fdfd42892f311e2b3695852036e5be23661dc590 jump_label: mips: move module NOP patching into arch code
date:   1 year, 1 month ago
config: mips-randconfig-r024-20230729 (https://download.01.org/0day-ci/archive/20230729/202307291002.3EsIxC16-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307291002.3EsIxC16-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307291002.3EsIxC16-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/mips/kernel/jump_label.c:93:6: warning: no previous prototype for function 'jump_label_apply_nops' [-Wmissing-prototypes]
      93 | void jump_label_apply_nops(struct module *mod)
         |      ^
   arch/mips/kernel/jump_label.c:93:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      93 | void jump_label_apply_nops(struct module *mod)
         | ^
         | static 
   1 warning generated.


vim +/jump_label_apply_nops +93 arch/mips/kernel/jump_label.c

    91	
    92	#ifdef CONFIG_MODULES
  > 93	void jump_label_apply_nops(struct module *mod)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
