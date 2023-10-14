Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E057C9640
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjJNU3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJNU3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 16:29:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C056B7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697315356; x=1728851356;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0nstX9adLNFaC+b4PFBJfIdRdkPn3BYEB0/qTadJ3MY=;
  b=nH5f7Pkqmt/cKSBg94WL7YdNCgn8MNckXGwtCUfWs/bDayhZLCfShNw6
   /Z4xS1T4McGQjUdCWG7iQuedS1HoNVprQ7w/7grMp84ew+oQOikIm22oC
   4yUS3dhbwLz2ju12dwkCzLsS6bv05ilqGWcQQAP36ej3ySGnJ2Qp785xV
   a60FcnD6RXZcKpwTH042yM8R7Q97QoL3EeQVKFi20sC9JpAlAf+hNoCDw
   9pZGfqhcw9gaMaMs1lC1kJR9q5gaFXGFna3yQ2Ksoyht722jw7dmxc4ML
   ucEeuRx8TgTq7F0EvlmDXebtTR7KKzjupOB6p84ivEVEPtvgFeXfAsmaY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="375698733"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="375698733"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 13:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="898955884"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="898955884"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Oct 2023 13:27:20 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrlG3-0006cZ-2j;
        Sat, 14 Oct 2023 20:29:11 +0000
Date:   Sun, 15 Oct 2023 04:28:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: vmlinux.o: warning: objtool: cfi_probe_chip.cold+0x0: unreachable
 instruction
Message-ID: <202310150404.ZaKODSd7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   70f8c6f8f8800d970b10676cceae42bba51a4899
commit: 5e3992fe72748ed3892be876f09d4d990548b7af objtool: Limit unreachable warnings to once per function
date:   5 months ago
config: x86_64-randconfig-074-20230824 (https://download.01.org/0day-ci/archive/20231015/202310150404.ZaKODSd7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231015/202310150404.ZaKODSd7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310150404.ZaKODSd7-lkp@intel.com/

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
0007    5c6dd:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	5c6e0: R_X86_64_32S	.data+0xa966e0
000e    5c6e4:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
0012    5c6e8:	e8 00 00 00 00       	call   5c6ed <cfi_probe_chip.cold+0x17>	5c6e9: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0017    5c6ed:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
001b    5c6f1:	e9 00 00 00 00       	jmp    5c6f6 <cfi_probe_chip.cold+0x20>	5c6f2: R_X86_64_PC32	.text+0x1f6ea3f
0020    5c6f6:	48 89 ca             	mov    %rcx,%rdx
0023    5c6f9:	4c 89 c6             	mov    %r8,%rsi
0026    5c6fc:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	5c6ff: R_X86_64_32S	.data+0xa96720
002d    5c703:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
0031    5c707:	e8 00 00 00 00       	call   5c70c <cfi_probe_chip.cold+0x36>	5c708: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0036    5c70c:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
003a    5c710:	e9 00 00 00 00       	jmp    5c715 <cfi_probe_chip.cold+0x3f>	5c711: R_X86_64_PC32	.text+0x1f6e92f
003f    5c715:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
0043    5c719:	48 89 ca             	mov    %rcx,%rdx
0046    5c71c:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	5c71f: R_X86_64_32S	.data+0xa96760
004d    5c723:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
0051    5c727:	e8 00 00 00 00       	call   5c72c <cfi_probe_chip.cold+0x56>	5c728: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0056    5c72c:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
005a    5c730:	e9 00 00 00 00       	jmp    5c735 <cfi_varsize_frob.cold>	5c731: R_X86_64_PC32	.text+0x1f6e8e0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
