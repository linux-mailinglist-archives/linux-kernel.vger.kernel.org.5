Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5504D7E0B48
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbjKCWuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjKCWuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:50:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26AAD62
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699051799; x=1730587799;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kfPQsqOccDvUON6GTPzis7PXbOxOOiY/8EKa2W4wUAk=;
  b=M+ll0KxruTIvTp45RUZAIOBVlHBtcDdI3HByN5v0R/OYukPABdUOmLp3
   LZI1U37OHl/zSyI3JRepBtcWTatc/vmoUybdQqVUgj1uc9AzxyapgLv5r
   7UHjl44TfNthumZPNIqvk5P1eC2OYhYuC9APL4cQoCw8W0y4D+PlJ6JS8
   lSY5WPWTtRYz1udZVJuJdluTNm0Fwj/+vd2BTleC657FLWMeIWmlC5uex
   uLmJXXVEyPhQVc0hRtH78zLUIAAHWGvJ/XVioxOh3JC7yreJmICxlBboN
   eof4wjtbwoDhhnw1NAh2ZsFnAUh8pmYLFHqv/Syj978IYX1HGJaU88wbJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="386209157"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="386209157"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="9522718"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Nov 2023 15:49:58 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz2zD-00031b-12;
        Fri, 03 Nov 2023 22:49:55 +0000
Date:   Sat, 4 Nov 2023 06:47:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: acpi_idle_enter_bm+0x40: call to
 lockdep_hardirqs_on_prepare() leaves .noinstr.text section
Message-ID: <202311040645.iX61nohP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
commit: 2b5a0e425e6e319b1978db1e9564f6af4228a567 objtool/idle: Validate __cpuidle code as noinstr
date:   10 months ago
config: x86_64-buildonly-randconfig-001-20231104 (https://download.01.org/0day-ci/archive/20231104/202311040645.iX61nohP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040645.iX61nohP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040645.iX61nohP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x90: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_safe_halt+0xd: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: io_idle+0xc: call to __inb.isra.0() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: acpi_idle_enter_bm+0x40: call to lockdep_hardirqs_on_prepare() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x4e: call to __this_cpu_preempt_check.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter+0x1e: call to __this_cpu_preempt_check.constprop.0() leaves .noinstr.text section


objdump-func vmlinux.o acpi_idle_enter_bm:
0000 0000000000000410 <acpi_idle_enter_bm>:
0000  410:	41 55                	push   %r13
0002  412:	49 89 fd             	mov    %rdi,%r13
0005  415:	41 54                	push   %r12
0007  417:	41 89 cc             	mov    %ecx,%r12d
000a  41a:	55                   	push   %rbp
000b  41b:	48 89 d5             	mov    %rdx,%rbp
000e  41e:	53                   	push   %rbx
000f  41f:	48 89 f3             	mov    %rsi,%rbx
0012  422:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	423: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0017  427:	0f b6 5b 20          	movzbl 0x20(%rbx),%ebx
001b  42b:	c0 eb 04             	shr    $0x4,%bl
001e  42e:	83 e3 01             	and    $0x1,%ebx
0021  431:	90                   	nop
0022  432:	80 7d 10 00          	cmpb   $0x0,0x10(%rbp)
0026  436:	0f 84 90 00 00 00    	je     4cc <acpi_idle_enter_bm+0xbc>
002c  43c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	43d: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0031  441:	84 db                	test   %bl,%bl
0033  443:	75 48                	jne    48d <acpi_idle_enter_bm+0x7d>
0035  445:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	446: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
003a  44a:	e8 00 00 00 00       	call   44f <acpi_idle_enter_bm+0x3f>	44b: R_X86_64_PC32	.text+0xa47d6c
003f  44f:	90                   	nop
0040  450:	e8 00 00 00 00       	call   455 <acpi_idle_enter_bm+0x45>	451: R_X86_64_PC32	.text+0xa47d6c
0045  455:	e8 00 00 00 00       	call   45a <acpi_idle_enter_bm+0x4a>	456: R_X86_64_PC32	.text+0xa4904c
004a  45a:	48 89 ef             	mov    %rbp,%rdi
004d  45d:	e8 2e ff ff ff       	call   390 <acpi_idle_do_entry>
0052  462:	e8 00 00 00 00       	call   467 <acpi_idle_enter_bm+0x57>	463: R_X86_64_PC32	.text+0xa4904c
0057  467:	e8 00 00 00 00       	call   46c <acpi_idle_enter_bm+0x5c>	468: R_X86_64_PC32	.text+0xa47d6c
005c  46c:	90                   	nop
005d  46d:	84 db                	test   %bl,%bl
005f  46f:	0f 85 91 00 00 00    	jne    506 <acpi_idle_enter_bm+0xf6>
0065  475:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	476: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
006a  47a:	90                   	nop
006b  47b:	5b                   	pop    %rbx
006c  47c:	44 89 e0             	mov    %r12d,%eax
006f  47f:	5d                   	pop    %rbp
0070  480:	41 5c                	pop    %r12
0072  482:	41 5d                	pop    %r13
0074  484:	31 d2                	xor    %edx,%edx
0076  486:	31 c9                	xor    %ecx,%ecx
0078  488:	31 f6                	xor    %esi,%esi
007a  48a:	31 ff                	xor    %edi,%edi
007c  48c:	c3                   	ret
007d  48d:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	48e: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0082  492:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	495: R_X86_64_32S	.data+0x33aa80
0089  499:	e8 00 00 00 00       	call   49e <acpi_idle_enter_bm+0x8e>	49a: R_X86_64_PLT32	_raw_spin_lock-0x4
008e  49e:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 4a4 <acpi_idle_enter_bm+0x94>	4a0: R_X86_64_PC32	.bss+0x7b9534
0094  4a4:	83 c0 01             	add    $0x1,%eax
0097  4a7:	89 05 00 00 00 00    	mov    %eax,0x0(%rip)        # 4ad <acpi_idle_enter_bm+0x9d>	4a9: R_X86_64_PC32	.bss+0x7b9534
009d  4ad:	83 f8 01             	cmp    $0x1,%eax
00a0  4b0:	0f 84 85 00 00 00    	je     53b <acpi_idle_enter_bm+0x12b>
00a6  4b6:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	4b7: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00ab  4bb:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	4be: R_X86_64_32S	.data+0x33aa80
00b2  4c2:	e8 00 00 00 00       	call   4c7 <acpi_idle_enter_bm+0xb7>	4c3: R_X86_64_PLT32	_raw_spin_unlock-0x4
00b7  4c7:	e9 79 ff ff ff       	jmp    445 <acpi_idle_enter_bm+0x35>
00bc  4cc:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	4cd: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00c1  4d1:	e8 00 00 00 00       	call   4d6 <acpi_idle_enter_bm+0xc6>	4d2: R_X86_64_PC32	.text+0xa4866c
00c6  4d6:	85 c0                	test   %eax,%eax
00c8  4d8:	0f 84 5e ff ff ff    	je     43c <acpi_idle_enter_bm+0x2c>
00ce  4de:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	4df: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00d3  4e3:	45 8b a5 2c 04 00 00 	mov    0x42c(%r13),%r12d
00da  4ea:	45 85 e4             	test   %r12d,%r12d
00dd  4ed:	78 65                	js     554 <acpi_idle_enter_bm+0x144>
00df  4ef:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	4f0: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00e4  4f4:	49 63 c4             	movslq %r12d,%rax
00e7  4f7:	48 8b 2c c5 00 00 00 00 	mov    0x0(,%rax,8),%rbp	4fb: R_X86_64_32S	.data+0x33aae0
00ef  4ff:	31 db                	xor    %ebx,%ebx
00f1  501:	e9 3f ff ff ff       	jmp    445 <acpi_idle_enter_bm+0x35>
00f6  506:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	507: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00fb  50b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	50e: R_X86_64_32S	.data+0x33aa80
0102  512:	e8 00 00 00 00       	call   517 <acpi_idle_enter_bm+0x107>	513: R_X86_64_PLT32	_raw_spin_lock-0x4
0107  517:	31 f6                	xor    %esi,%esi
0109  519:	bf 13 00 00 00       	mov    $0x13,%edi
010e  51e:	e8 00 00 00 00       	call   523 <acpi_idle_enter_bm+0x113>	51f: R_X86_64_PLT32	acpi_write_bit_register-0x4
0113  523:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	526: R_X86_64_32S	.data+0x33aa80
011a  52a:	83 2d 00 00 00 00 01 	subl   $0x1,0x0(%rip)        # 531 <acpi_idle_enter_bm+0x121>	52c: R_X86_64_PC32	.bss+0x7b9533
0121  531:	e8 00 00 00 00       	call   536 <acpi_idle_enter_bm+0x126>	532: R_X86_64_PLT32	_raw_spin_unlock-0x4
0126  536:	e9 3a ff ff ff       	jmp    475 <acpi_idle_enter_bm+0x65>
012b  53b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	53c: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0130  540:	be 01 00 00 00       	mov    $0x1,%esi
0135  545:	bf 13 00 00 00       	mov    $0x13,%edi
013a  54a:	e8 00 00 00 00       	call   54f <acpi_idle_enter_bm+0x13f>	54b: R_X86_64_PLT32	acpi_write_bit_register-0x4
013f  54f:	e9 62 ff ff ff       	jmp    4b6 <acpi_idle_enter_bm+0xa6>
0144  554:	48 c7 c5 00 00 00 00 	mov    $0x0,%rbp	557: R_X86_64_32S	.data+0x33aa40
014b  55b:	41 bc f0 ff ff ff    	mov    $0xfffffff0,%r12d
0151  561:	31 db                	xor    %ebx,%ebx
0153  563:	e9 dd fe ff ff       	jmp    445 <acpi_idle_enter_bm+0x35>
0158  568:	0f 1f 84 00 00 00 00 00 	nopl   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
