Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E033D788E61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjHYSPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjHYSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:15:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB52A10C7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692987280; x=1724523280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X33ySa/Y0OjFTnpKOQaAxWeKl8X1KoaM22Y15O0U/EU=;
  b=Ycum+Cp5DNYM5rhEpdp/80V104GbgCQN94/9VxzYtdhWyNUJq3skLGgY
   tCo0gUeRtiXAviMPcU1Qm/WgEC8U8DL9IVKU2hnqu08+cz9RPAonjGJfb
   XYIe6Xk6eoQXrTveGvNlLqy7Sr8dqIYRfuLOIDrCwZYBdleX4aU8MqUFN
   RQyegn60y5+dv43MU0ebe7V2j8ys81RDUqVGtvk8nlBReFFaNWAAPNn7n
   OZ9tUJf4hlU4r4K3TwGrcrIErG7QkHvEXTyVYaxWeCrUT8dQvMujGGZVR
   D6HLp2TmFjPwjXOapsXDZFD+P9xD1etZ9nav2vTJxjlH2FLRfweYg8jHH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359770306"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="359770306"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 11:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="861165701"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="861165701"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 25 Aug 2023 11:14:38 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZbKP-0003st-1b;
        Fri, 25 Aug 2023 18:14:37 +0000
Date:   Sat, 26 Aug 2023 02:14:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: vmlinux.o: warning: objtool: cfi_probe_chip.cold+0x0: unreachable
 instruction
Message-ID: <202308260227.qlDu27e5-lkp@intel.com>
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
head:   4942fed84b98cfb71d3cdff1a3df0072a57bbdfa
commit: 5e3992fe72748ed3892be876f09d4d990548b7af objtool: Limit unreachable warnings to once per function
date:   3 months ago
config: x86_64-randconfig-074-20230824 (https://download.01.org/0day-ci/archive/20230826/202308260227.qlDu27e5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308260227.qlDu27e5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308260227.qlDu27e5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: cfi_chip_setup+0x1ba: unreachable instruction
   vmlinux.o: warning: objtool: cfi_probe_chip+0x72: unreachable instruction
   vmlinux.o: warning: objtool: cfi_staa_resume+0x184: unreachable instruction
   vmlinux.o: warning: objtool: do_write_buffer+0x1e4: unreachable instruction
   vmlinux.o: warning: objtool: do_read_onechip+0x132: unreachable instruction
   vmlinux.o: warning: objtool: do_unlock_oneblock+0x146: unreachable instruction
   vmlinux.o: warning: objtool: do_lock_oneblock+0x146: unreachable instruction
   vmlinux.o: warning: objtool: do_erase_oneblock+0x118: unreachable instruction
   vmlinux.o: warning: objtool: fixup_sst39vf_rev_b+0x13a: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_resume+0x1cd: unreachable instruction
   vmlinux.o: warning: objtool: cfi_check_err_status+0x17c: unreachable instruction
   vmlinux.o: warning: objtool: chip_ready+0x17c: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_panic_wait+0xe9: unreachable instruction
   vmlinux.o: warning: objtool: do_panic_write_oneword+0x2f5: unreachable instruction
   vmlinux.o: warning: objtool: do_write_oneword_once+0x133: unreachable instruction
   vmlinux.o: warning: objtool: fixup_sst38vf640x_sectorsize+0x147: unreachable instruction
   vmlinux.o: warning: objtool: put_chip.constprop.0+0x39f: unreachable instruction
   vmlinux.o: warning: objtool: get_chip+0x553: unreachable instruction
   vmlinux.o: warning: objtool: do_write_oneword+0x376: unreachable instruction
   vmlinux.o: warning: objtool: do_atmel_unlock+0x16e: unreachable instruction
   vmlinux.o: warning: objtool: do_atmel_lock+0x171: unreachable instruction
   vmlinux.o: warning: objtool: fwh_xxlock_oneblock+0x1a4: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_read+0x199: unreachable instruction
   vmlinux.o: warning: objtool: do_erase_chip+0x375: unreachable instruction
   vmlinux.o: warning: objtool: do_write_buffer+0x1ec: unreachable instruction
   vmlinux.o: warning: objtool: do_erase_oneblock+0x383: unreachable instruction
   vmlinux.o: warning: objtool: do_otp_lock+0x171: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_otp_walk+0x277: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_reset.isra.0+0x1b9: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_secsi_read+0x42a: unreachable instruction
   vmlinux.o: warning: objtool: do_otp_write+0x11f: unreachable instruction
   vmlinux.o: warning: objtool: do_read_secsi_onechip+0x2d6: unreachable instruction
>> vmlinux.o: warning: objtool: cfi_probe_chip.cold+0x0: unreachable instruction
>> vmlinux.o: warning: objtool: do_erase_oneblock.cold+0x0: unreachable instruction


objdump-func vmlinux.o cfi_probe_chip.cold:
0000 000000000005c6d6 <cfi_probe_chip.cold>:
0000    5c6d6:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
0004    5c6da:	48 89 ca             	mov    %rcx,%rdx
0007    5c6dd:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	5c6e0: R_X86_64_32S	.data+0xa9b5e0
000e    5c6e4:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
0012    5c6e8:	e8 00 00 00 00       	call   5c6ed <cfi_probe_chip.cold+0x17>	5c6e9: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0017    5c6ed:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
001b    5c6f1:	e9 00 00 00 00       	jmp    5c6f6 <cfi_probe_chip.cold+0x20>	5c6f2: R_X86_64_PC32	.text+0x1f824ff
0020    5c6f6:	48 89 ca             	mov    %rcx,%rdx
0023    5c6f9:	4c 89 c6             	mov    %r8,%rsi
0026    5c6fc:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	5c6ff: R_X86_64_32S	.data+0xa9b620
002d    5c703:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
0031    5c707:	e8 00 00 00 00       	call   5c70c <cfi_probe_chip.cold+0x36>	5c708: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0036    5c70c:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
003a    5c710:	e9 00 00 00 00       	jmp    5c715 <cfi_probe_chip.cold+0x3f>	5c711: R_X86_64_PC32	.text+0x1f823ef
003f    5c715:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
0043    5c719:	48 89 ca             	mov    %rcx,%rdx
0046    5c71c:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	5c71f: R_X86_64_32S	.data+0xa9b660
004d    5c723:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
0051    5c727:	e8 00 00 00 00       	call   5c72c <cfi_probe_chip.cold+0x56>	5c728: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0056    5c72c:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
005a    5c730:	e9 00 00 00 00       	jmp    5c735 <cfi_varsize_frob.cold>	5c731: R_X86_64_PC32	.text+0x1f823a0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
