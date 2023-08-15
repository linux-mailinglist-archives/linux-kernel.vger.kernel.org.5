Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3577D5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjHOWSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbjHOWSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:18:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B5E1FEE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692137896; x=1723673896;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DRTAtvevC8cYTf0/cROmcCnl7PfMq46a3BIOnGr/NOc=;
  b=TBvlRgqAzqxvKeHKgrlqlTczG35cb57vn1aEUmvd4TJsf/Si2RdtIHWQ
   LTQUMiGqHqyjOv+eUCiAEXn/+eR7JC5uzMGD6kKTAHr51L6/WakwdsLdS
   71o9IQLLdbnc+Idte1EXxZKgwXc6Yg2pmm3dwyCaxRIqsOr/C78IfRE7Z
   XOG9ZvH/H1kP38bMkYbkNpj/pJKS+m257x3D5S0ZfIx9tbGLaWQIgwavV
   nBFmfpPxbBs15QdiQUeYiuHMOMeBKXVtJ8BcS2vKjHBQwjkTXLTd3Veju
   RrqOroNwdseNTKMDtNam5bhEsXgWiv1/tUIEEG5PDyOF3C06bpHsgyI7d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403368776"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="403368776"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 15:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877512431"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2023 15:18:18 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW2Mf-0001GT-2c;
        Tue, 15 Aug 2023 22:18:13 +0000
Date:   Wed, 16 Aug 2023 06:17:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: intel_idle_ibrs+0x11: call to
 sched_smt_active() leaves .noinstr.text section
Message-ID: <202308160613.xez9StTT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 2b5a0e425e6e319b1978db1e9564f6af4228a567 objtool/idle: Validate __cpuidle code as noinstr
date:   7 months ago
config: x86_64-randconfig-r035-20230816 (https://download.01.org/0day-ci/archive/20230816/202308160613.xez9StTT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308160613.xez9StTT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308160613.xez9StTT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __halt+0x1d: call to hcall_func.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: default_idle+0x4: call to mds_idle_clear_cpu_buffers() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mwait_idle+0x4: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x69: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x5d: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle+0x7a: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_s2idle+0xa1: call to fpu_idle_fpregs() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_xstate+0x11: call to fpu_idle_fpregs() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_irq+0x87: call to current_set_polling_and_test() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: intel_idle_ibrs+0x11: call to sched_smt_active() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_safe_halt+0x8: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: io_idle+0x3: call to __inb.isra.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x66: call to wbinvd() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter+0x64: call to wbinvd() leaves .noinstr.text section


objdump-func vmlinux.o intel_idle_ibrs:
0000 00000000000005f0 <intel_idle_ibrs>:
0000  5f0:	f3 0f 1e fa          	endbr64
0004  5f4:	41 56                	push   %r14
0006  5f6:	49 89 f6             	mov    %rsi,%r14
0009  5f9:	41 55                	push   %r13
000b  5fb:	41 54                	push   %r12
000d  5fd:	55                   	push   %rbp
000e  5fe:	89 d5                	mov    %edx,%ebp
0010  600:	53                   	push   %rbx
0011  601:	e8 00 00 00 00       	call   606 <intel_idle_ibrs+0x16>	602: R_X86_64_PC32	.text+0xd05b1c
0016  606:	41 89 c4             	mov    %eax,%r12d
0019  609:	e8 00 00 00 00       	call   60e <intel_idle_ibrs+0x1e>	60a: R_X86_64_PLT32	spec_ctrl_current-0x4
001e  60e:	49 89 c5             	mov    %rax,%r13
0021  611:	45 84 e4             	test   %r12b,%r12b
0024  614:	0f 85 a6 00 00 00    	jne    6c0 <intel_idle_ibrs+0xd0>
002a  61a:	48 63 dd             	movslq %ebp,%rbx
002d  61d:	48 83 fb 0a          	cmp    $0xa,%rbx
0031  621:	0f 87 a5 00 00 00    	ja     6cc <intel_idle_ibrs+0xdc>
0037  627:	48 8d 04 5b          	lea    (%rbx,%rbx,2),%rax
003b  62b:	48 8d 04 83          	lea    (%rbx,%rax,4),%rax
003f  62f:	41 8b 5c c6 58       	mov    0x58(%r14,%rax,8),%ebx
0044  634:	e9 00 00 00 00       	jmp    639 <intel_idle_ibrs+0x49>	635: R_X86_64_PC32	.altinstr_aux+0xdfa
0049  639:	e9 00 00 00 00       	jmp    63e <intel_idle_ibrs+0x4e>	63a: R_X86_64_PC32	.altinstr_aux+0xe0c
004e  63e:	0f ae f0             	mfence
0051  641:	48 8b 3c 25 00 00 00 00 	mov    0x0,%rdi	645: R_X86_64_32S	pcpu_hot
0059  649:	e8 00 00 00 00       	call   64e <intel_idle_ibrs+0x5e>	64a: R_X86_64_PC32	.text+0xd05b0c
005e  64e:	0f ae f0             	mfence
0061  651:	48 8b 34 25 00 00 00 00 	mov    0x0,%rsi	655: R_X86_64_32S	pcpu_hot
0069  659:	48 89 f7             	mov    %rsi,%rdi
006c  65c:	e8 00 00 00 00       	call   661 <intel_idle_ibrs+0x71>	65d: R_X86_64_PC32	.text+0xd05bbc
0071  661:	48 89 f7             	mov    %rsi,%rdi
0074  664:	e8 00 00 00 00       	call   669 <intel_idle_ibrs+0x79>	665: R_X86_64_PC32	.text+0xd05bdc
0079  669:	85 c0                	test   %eax,%eax
007b  66b:	75 0a                	jne    677 <intel_idle_ibrs+0x87>
007d  66d:	c1 eb 18             	shr    $0x18,%ebx
0080  670:	89 df                	mov    %ebx,%edi
0082  672:	e8 00 00 00 00       	call   677 <intel_idle_ibrs+0x87>	673: R_X86_64_PC32	.text+0xd05b9c
0087  677:	e8 00 00 00 00       	call   67c <intel_idle_ibrs+0x8c>	678: R_X86_64_PC32	.text+0xd05c8c
008c  67c:	45 84 e4             	test   %r12b,%r12b
008f  67f:	75 25                	jne    6a6 <intel_idle_ibrs+0xb6>
0091  681:	5b                   	pop    %rbx
0092  682:	89 e8                	mov    %ebp,%eax
0094  684:	5d                   	pop    %rbp
0095  685:	41 5c                	pop    %r12
0097  687:	41 5d                	pop    %r13
0099  689:	41 5e                	pop    %r14
009b  68b:	31 d2                	xor    %edx,%edx
009d  68d:	31 f6                	xor    %esi,%esi
009f  68f:	31 ff                	xor    %edi,%edi
00a1  691:	c3                   	ret
00a2  692:	cc                   	int3
00a3  693:	e8 00 00 00 00       	call   698 <intel_idle_ibrs+0xa8>	694: R_X86_64_PC32	.text+0xd05c2c
00a8  698:	84 c0                	test   %al,%al
00aa  69a:	74 9d                	je     639 <intel_idle_ibrs+0x49>
00ac  69c:	e8 00 00 00 00       	call   6a1 <intel_idle_ibrs+0xb1>	69d: R_X86_64_PC32	.text+0xd05c8c
00b1  6a1:	45 84 e4             	test   %r12b,%r12b
00b4  6a4:	74 db                	je     681 <intel_idle_ibrs+0x91>
00b6  6a6:	4c 89 ef             	mov    %r13,%rdi
00b9  6a9:	e8 00 00 00 00       	call   6ae <intel_idle_ibrs+0xbe>	6aa: R_X86_64_PC32	.text+0xd05cfc
00be  6ae:	89 e8                	mov    %ebp,%eax
00c0  6b0:	5b                   	pop    %rbx
00c1  6b1:	5d                   	pop    %rbp
00c2  6b2:	41 5c                	pop    %r12
00c4  6b4:	41 5d                	pop    %r13
00c6  6b6:	41 5e                	pop    %r14
00c8  6b8:	31 d2                	xor    %edx,%edx
00ca  6ba:	31 f6                	xor    %esi,%esi
00cc  6bc:	31 ff                	xor    %edi,%edi
00ce  6be:	c3                   	ret
00cf  6bf:	cc                   	int3
00d0  6c0:	31 ff                	xor    %edi,%edi
00d2  6c2:	e8 00 00 00 00       	call   6c7 <intel_idle_ibrs+0xd7>	6c3: R_X86_64_PC32	.text+0xd05cfc
00d7  6c7:	e9 4e ff ff ff       	jmp    61a <intel_idle_ibrs+0x2a>
00dc  6cc:	48 89 de             	mov    %rbx,%rsi
00df  6cf:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	6d2: R_X86_64_32S	.data+0x80af00
00e6  6d6:	e8 00 00 00 00       	call   6db <intel_idle_ibrs+0xeb>	6d7: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
00eb  6db:	e9 47 ff ff ff       	jmp    627 <intel_idle_ibrs+0x37>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
