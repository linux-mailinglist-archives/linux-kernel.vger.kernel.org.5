Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4B799CCF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 08:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346298AbjIJGUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 02:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjIJGUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 02:20:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E9B1B5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 23:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694326829; x=1725862829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6sfAMrdtEDYW7poy6kdkc1l17V50lW0S6HsOgd402Mg=;
  b=Zv5/Eu0qXRGaQ4kE6jTh7wKU2dlZeEHv3ZOml+XET+YtHl2TIBn3NRPJ
   mZACDMvptu4+8IUk1qVFsYAmc/6dZ18paOVGXelXgQnQPTFHp2lgYlJgq
   zw7+6edVyUOzImKAlIbNXxTdx0DORsBY3AR0+xCsq8HplOZb2dErKXexK
   i3eN9s5v6u+DraimXimCUn6lyMdxR6GFZAiaeP7EFgwt7QEUfiOIBZeM0
   fLlLy2OfYl/2HGRWYARqGmxIwoMG6DDav2wUB3kdxSFmiNn35JDlgi41S
   PGz9VI/dPByQP8v3Y2/kt+eXzyhfm6QuXG/RS4mwGcrXMUMLOwBHJ7fZN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357337573"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="357337573"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 23:20:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="989706189"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="989706189"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Sep 2023 23:20:27 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfDo1-0004W4-1t;
        Sun, 10 Sep 2023 06:20:25 +0000
Date:   Sun, 10 Sep 2023 14:19:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: intel_idle_ibrs+0x17: call to
 sched_smt_active() leaves .noinstr.text section
Message-ID: <202309101454.a7QZ5Agq-lkp@intel.com>
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

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   535a265d7f0dd50d8c3a4f8b4f3a452d56bd160f
commit: 2b5a0e425e6e319b1978db1e9564f6af4228a567 objtool/idle: Validate __cpuidle code as noinstr
date:   8 months ago
config: x86_64-randconfig-103-20230910 (https://download.01.org/0day-ci/archive/20230910/202309101454.a7QZ5Agq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309101454.a7QZ5Agq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309101454.a7QZ5Agq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: ibt_selftest+0x14: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: default_idle+0x8: call to arch_safe_halt() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mwait_idle+0x9: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x70: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: cpu_idle_poll.isra.0+0x54: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle+0x7c: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_s2idle+0xa1: call to fpu_idle_fpregs() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_xstate+0x16: call to fpu_idle_fpregs() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: intel_idle_ibrs+0x17: call to sched_smt_active() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_irq+0x9a: call to current_set_polling_and_test() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_safe_halt+0xc: call to test_ti_thread_flag.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: io_idle+0x7: call to __inb.isra.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x58: call to wbinvd() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter+0x5e: call to wbinvd() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ibt_selftest+0x1e: return with modified stack frame
   vmlinux.o: warning: objtool: recv_work.cold+0x0: relocation to !ENDBR: recv_work+0x34a


objdump-func vmlinux.o intel_idle_ibrs:
0000 00000000000005c0 <intel_idle_ibrs>:
0000  5c0:	f3 0f 1e fa          	endbr64
0004  5c4:	55                   	push   %rbp
0005  5c5:	48 89 e5             	mov    %rsp,%rbp
0008  5c8:	41 57                	push   %r15
000a  5ca:	49 89 f7             	mov    %rsi,%r15
000d  5cd:	41 56                	push   %r14
000f  5cf:	41 55                	push   %r13
0011  5d1:	41 54                	push   %r12
0013  5d3:	41 89 d4             	mov    %edx,%r12d
0016  5d6:	53                   	push   %rbx
0017  5d7:	e8 00 00 00 00       	call   5dc <intel_idle_ibrs+0x1c>	5d8: R_X86_64_PC32	.text+0x19baebc
001c  5dc:	41 89 c5             	mov    %eax,%r13d
001f  5df:	e8 00 00 00 00       	call   5e4 <intel_idle_ibrs+0x24>	5e0: R_X86_64_PLT32	spec_ctrl_current-0x4
0024  5e4:	49 89 c6             	mov    %rax,%r14
0027  5e7:	45 84 ed             	test   %r13b,%r13b
002a  5ea:	0f 85 a0 00 00 00    	jne    690 <intel_idle_ibrs+0xd0>
0030  5f0:	49 63 dc             	movslq %r12d,%rbx
0033  5f3:	48 83 fb 0a          	cmp    $0xa,%rbx
0037  5f7:	0f 87 9f 00 00 00    	ja     69c <intel_idle_ibrs+0xdc>
003d  5fd:	48 8d 04 5b          	lea    (%rbx,%rbx,2),%rax
0041  601:	48 8d 04 83          	lea    (%rbx,%rax,4),%rax
0045  605:	41 8b 5c c7 58       	mov    0x58(%r15,%rax,8),%ebx
004a  60a:	e9 00 00 00 00       	jmp    60f <intel_idle_ibrs+0x4f>	60b: R_X86_64_PC32	.altinstr_aux+0x2432
004f  60f:	e9 00 00 00 00       	jmp    614 <intel_idle_ibrs+0x54>	610: R_X86_64_PC32	.altinstr_aux+0x2444
0054  614:	0f ae f0             	mfence
0057  617:	48 8b 3c 25 00 00 00 00 	mov    0x0,%rdi	61b: R_X86_64_32S	pcpu_hot
005f  61f:	e8 00 00 00 00       	call   624 <intel_idle_ibrs+0x64>	620: R_X86_64_PC32	.text+0x19bae7c
0064  624:	0f ae f0             	mfence
0067  627:	4c 8b 3c 25 00 00 00 00 	mov    0x0,%r15	62b: R_X86_64_32S	pcpu_hot
006f  62f:	4c 89 ff             	mov    %r15,%rdi
0072  632:	e8 00 00 00 00       	call   637 <intel_idle_ibrs+0x77>	633: R_X86_64_PC32	.text+0x19baf7c
0077  637:	4c 89 ff             	mov    %r15,%rdi
007a  63a:	e8 00 00 00 00       	call   63f <intel_idle_ibrs+0x7f>	63b: R_X86_64_PC32	.text+0x19bafbc
007f  63f:	85 c0                	test   %eax,%eax
0081  641:	75 0a                	jne    64d <intel_idle_ibrs+0x8d>
0083  643:	c1 eb 18             	shr    $0x18,%ebx
0086  646:	89 df                	mov    %ebx,%edi
0088  648:	e8 00 00 00 00       	call   64d <intel_idle_ibrs+0x8d>	649: R_X86_64_PC32	.text+0x19baefc
008d  64d:	e8 00 00 00 00       	call   652 <intel_idle_ibrs+0x92>	64e: R_X86_64_PC32	.text+0x19bb0fc
0092  652:	45 84 ed             	test   %r13b,%r13b
0095  655:	75 22                	jne    679 <intel_idle_ibrs+0xb9>
0097  657:	5b                   	pop    %rbx
0098  658:	44 89 e0             	mov    %r12d,%eax
009b  65b:	41 5c                	pop    %r12
009d  65d:	41 5d                	pop    %r13
009f  65f:	41 5e                	pop    %r14
00a1  661:	41 5f                	pop    %r15
00a3  663:	5d                   	pop    %rbp
00a4  664:	c3                   	ret
00a5  665:	cc                   	int3
00a6  666:	e8 00 00 00 00       	call   66b <intel_idle_ibrs+0xab>	667: R_X86_64_PC32	.text+0x19bb07c
00ab  66b:	84 c0                	test   %al,%al
00ad  66d:	74 a0                	je     60f <intel_idle_ibrs+0x4f>
00af  66f:	e8 00 00 00 00       	call   674 <intel_idle_ibrs+0xb4>	670: R_X86_64_PC32	.text+0x19bb0fc
00b4  674:	45 84 ed             	test   %r13b,%r13b
00b7  677:	74 de                	je     657 <intel_idle_ibrs+0x97>
00b9  679:	4c 89 f7             	mov    %r14,%rdi
00bc  67c:	e8 00 00 00 00       	call   681 <intel_idle_ibrs+0xc1>	67d: R_X86_64_PC32	.text+0x19bb03c
00c1  681:	44 89 e0             	mov    %r12d,%eax
00c4  684:	5b                   	pop    %rbx
00c5  685:	41 5c                	pop    %r12
00c7  687:	41 5d                	pop    %r13
00c9  689:	41 5e                	pop    %r14
00cb  68b:	41 5f                	pop    %r15
00cd  68d:	5d                   	pop    %rbp
00ce  68e:	c3                   	ret
00cf  68f:	cc                   	int3
00d0  690:	31 ff                	xor    %edi,%edi
00d2  692:	e8 00 00 00 00       	call   697 <intel_idle_ibrs+0xd7>	693: R_X86_64_PC32	.text+0x19bb03c
00d7  697:	e9 54 ff ff ff       	jmp    5f0 <intel_idle_ibrs+0x30>
00dc  69c:	48 89 de             	mov    %rbx,%rsi
00df  69f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	6a2: R_X86_64_32S	.data+0xb6fd00
00e6  6a6:	e8 00 00 00 00       	call   6ab <intel_idle_ibrs+0xeb>	6a7: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
00eb  6ab:	e9 4d ff ff ff       	jmp    5fd <intel_idle_ibrs+0x3d>
00f0  6b0:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
00fb  6bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
