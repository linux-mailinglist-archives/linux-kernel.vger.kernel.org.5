Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1237FDBBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343850AbjK2Pne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbjK2Pnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:43:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA222A2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701272618; x=1732808618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y9tsmU7ogEklBkMdjJr8QxsQZCNfar7+o5AACJhQ1K8=;
  b=W/uFgg/Rl3LI6G2BRQwweM9yMt3REChXLQtjYwaqoVe/zmPbAyBADZxG
   MeKGKqAzD3Z8l7bUinNPtAyJ/xU6Pv3QT14v93QbmnPLzFfMGMhkW67y6
   2hrdXjh0qZYC9GkU5E3YWe339D2PRi4QnL4rRWnydoJZOq2ZvYUeolHf4
   6YYkngxpkqFrDltKBTowClOf6NZ4B2TDUR/3ZI4JkrH9j4sI/LtVP7X+P
   9hRrSFyxo1UlFyras+2wwJINFL9REb8rxpnTpQD9xeUM5RG5zqJwXcMKI
   OVFzxlI+3thGgLBgWVr5MsH9dzl/5sTwy1UUrF6YjmuvTyOgxRv2AdA6W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392925486"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="392925486"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 07:43:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772724584"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="772724584"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2023 07:43:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Mit-0000Oy-15;
        Wed, 29 Nov 2023 15:43:35 +0000
Date:   Wed, 29 Nov 2023 23:42:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/tests/module_test/test_uleb128.S:9: Error:
 unrecognized opcode `ld a0,second'
Message-ID: <202311292253.s5OGiu3s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18d46e76d7c2eedd8577fae67e3f1d4db25018b0
commit: af71bc194916b10f9b394f9b14419d99700a5e67 riscv: Add tests for riscv module loading
date:   3 weeks ago
config: riscv-randconfig-r001-20230116 (https://download.01.org/0day-ci/archive/20231129/202311292253.s5OGiu3s-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311292253.s5OGiu3s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311292253.s5OGiu3s-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/kernel/tests/module_test/test_uleb128.S: Assembler messages:
>> arch/riscv/kernel/tests/module_test/test_uleb128.S:9: Error: unrecognized opcode `ld a0,second'
>> arch/riscv/kernel/tests/module_test/test_uleb128.S:15: Error: unrecognized opcode `ld a0,fourth'


vim +9 arch/riscv/kernel/tests/module_test/test_uleb128.S

   > 9		ld	a0, second
    10		addi	a0, a0, -127
    11		ret
    12	
    13	.global test_uleb_large
    14	test_uleb_large:
  > 15		ld	a0, fourth
    16		addi	a0, a0, -0x07e8
    17		ret
    18	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
