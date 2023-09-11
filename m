Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE25E79AE00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379051AbjIKWlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243638AbjIKR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:26:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6123189
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694453195; x=1725989195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dr4FEXNz/stJi+V50/fd1tyGFjzqEyysU/Yv3GX+t5c=;
  b=UWY4NwxMcFhME7yktFIASp/IhqackrIKRuo8hwhSbVdQN7fklof1ro/k
   esj5wJG6JEtq3/oWF/oYGPaiFWsVCgVPF7ChhH/+RG6rmjHewdDCG2ari
   0c3/8iioXfUyGR9ilFb31lf5tVB0Q1iJyU7TWGIljGgQjjJFEwWh/Awi/
   JCuq8JXFM1P3OCXgQ7VaAZT9wKL8TEy+QvO27tRuG2R55/w+PReLkdDC8
   apmZL2Ieu1CNlXRlWgkSDsBkxKWoD2X2SkM47T99+oJ8DR7p51BrFqaNN
   p5RaAUimG67+Bx42S/xnTL8QkRPoDlNgh5RNeyAhZXh9hZEiwB3FH0oyQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409113777"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="409113777"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 10:26:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="808899244"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="808899244"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2023 10:26:29 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfkg7-0006XI-0v;
        Mon, 11 Sep 2023 17:26:27 +0000
Date:   Tue, 12 Sep 2023 01:25:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0x34: call to
 context_tracking_enabled_this_cpu() leaves .noinstr.text section
Message-ID: <202309120137.Eo6SpBIz-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 656d054e0a15ec327bd82801ccd58201e59f6896 jump_label,noinstr: Avoid instrumentation for JUMP_LABEL=n builds
date:   1 year, 4 months ago
config: x86_64-randconfig-102-20230911 (https://download.01.org/0day-ci/archive/20230912/202309120137.Eo6SpBIz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120137.Eo6SpBIz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120137.Eo6SpBIz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ld: warning: arch/x86/power/hibernate_asm_64.o: missing .note.GNU-stack section implies executable stack
   ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>> vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0x34: call to context_tracking_enabled_this_cpu() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x52: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x56: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x52: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x52: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: crc_pcl+0x7c: missing int3 after indirect jump
   ld: warning: vmlinux.o: requires executable stack (because the .note.GNU-stack section is executable)
   ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   ld: warning: vmlinux.o: requires executable stack (because the .note.GNU-stack section is executable)
   ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
   ld: warning: vmlinux.o: requires executable stack (because the .note.GNU-stack section is executable)
   ld: warning: vmlinux has a LOAD segment with RWX permissions


objdump-func vmlinux.o svm_vcpu_enter_exit:
0000 00000000000001eb <svm_vcpu_enter_exit>:
0000      1eb:	41 55                	push   %r13
0002      1ed:	41 54                	push   %r12
0004      1ef:	55                   	push   %rbp
0005      1f0:	53                   	push   %rbx
0006      1f1:	48 8b 87 48 24 00 00 	mov    0x2448(%rdi),%rax
000d      1f8:	48 89 fb             	mov    %rdi,%rbx
0010      1fb:	4c 8b 68 08          	mov    0x8(%rax),%r13
0014      1ff:	90                   	nop
0015      200:	e8 00 00 00 00       	call   205 <svm_vcpu_enter_exit+0x1a>	201: R_X86_64_PLT32	trace_hardirqs_on_prepare-0x4
001a      205:	e8 00 00 00 00       	call   20a <svm_vcpu_enter_exit+0x1f>	206: R_X86_64_PLT32	lockdep_hardirqs_on_prepare-0x4
001f      20a:	90                   	nop
0020      20b:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 211 <svm_vcpu_enter_exit+0x26>	20d: R_X86_64_PC32	context_tracking_key-0x4
0026      211:	85 c0                	test   %eax,%eax
0028      213:	7e 0a                	jle    21f <svm_vcpu_enter_exit+0x34>
002a      215:	bf 02 00 00 00       	mov    $0x2,%edi
002f      21a:	e8 00 00 00 00       	call   21f <svm_vcpu_enter_exit+0x34>	21b: R_X86_64_PLT32	__context_tracking_enter-0x4
0034      21f:	e8 00 00 00 00       	call   224 <svm_vcpu_enter_exit+0x39>	220: R_X86_64_PC32	.text+0x12b162
0039      224:	84 c0                	test   %al,%al
003b      226:	75 07                	jne    22f <svm_vcpu_enter_exit+0x44>
003d      228:	90                   	nop
003e      229:	e8 00 00 00 00       	call   22e <svm_vcpu_enter_exit+0x43>	22a: R_X86_64_PC32	.text+0x136e61
0043      22e:	90                   	nop
0044      22f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
0049      234:	e8 00 00 00 00       	call   239 <svm_vcpu_enter_exit+0x4e>	235: R_X86_64_PLT32	lockdep_hardirqs_on-0x4
004e      239:	48 8b 03             	mov    (%rbx),%rax
0051      23c:	80 b8 61 ab 00 00 00 	cmpb   $0x0,0xab61(%rax)
0058      243:	74 19                	je     25e <svm_vcpu_enter_exit+0x73>
005a      245:	80 b8 60 ab 00 00 00 	cmpb   $0x0,0xab60(%rax)
0061      24c:	75 06                	jne    254 <svm_vcpu_enter_exit+0x69>
0063      24e:	90                   	nop
0064      24f:	0f 0b                	ud2
0066      251:	90                   	nop
0067      252:	eb 0a                	jmp    25e <svm_vcpu_enter_exit+0x73>
0069      254:	4c 89 ef             	mov    %r13,%rdi
006c      257:	e8 00 00 00 00       	call   25c <svm_vcpu_enter_exit+0x71>	258: R_X86_64_PLT32	__svm_sev_es_vcpu_run-0x4
0071      25c:	eb 7d                	jmp    2db <svm_vcpu_enter_exit+0xf0>
0073      25e:	4c 63 63 20          	movslq 0x20(%rbx),%r12
0077      262:	48 c7 c5 00 00 00 00 	mov    $0x0,%rbp	265: R_X86_64_32S	svm_data
007e      269:	49 81 fc ff 1f 00 00 	cmp    $0x1fff,%r12
0085      270:	76 0f                	jbe    281 <svm_vcpu_enter_exit+0x96>
0087      272:	4c 89 e6             	mov    %r12,%rsi
008a      275:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	278: R_X86_64_32S	.data+0xc6500
0091      27c:	e8 00 00 00 00       	call   281 <svm_vcpu_enter_exit+0x96>	27d: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
0096      281:	4a 8b 04 e5 00 00 00 00 	mov    0x0(,%r12,8),%rax	285: R_X86_64_32S	__per_cpu_offset
009e      289:	48 8b 2c 28          	mov    (%rax,%rbp,1),%rbp
00a2      28d:	48 8b 83 30 24 00 00 	mov    0x2430(%rbx),%rax
00a9      294:	0f 01 da             	vmload
00ac      297:	eb 05                	jmp    29e <svm_vcpu_enter_exit+0xb3>
00ae      299:	e8 00 00 00 00       	call   29e <svm_vcpu_enter_exit+0xb3>	29a: R_X86_64_PLT32	kvm_spurious_fault-0x4
00b3      29e:	48 8d b3 c0 01 00 00 	lea    0x1c0(%rbx),%rsi
00ba      2a5:	4c 89 ef             	mov    %r13,%rdi
00bd      2a8:	e8 00 00 00 00       	call   2ad <svm_vcpu_enter_exit+0xc2>	2a9: R_X86_64_PLT32	__svm_vcpu_run-0x4
00c2      2ad:	48 8b 83 30 24 00 00 	mov    0x2430(%rbx),%rax
00c9      2b4:	0f 01 db             	vmsave
00cc      2b7:	eb 05                	jmp    2be <svm_vcpu_enter_exit+0xd3>
00ce      2b9:	e8 00 00 00 00       	call   2be <svm_vcpu_enter_exit+0xd3>	2ba: R_X86_64_PLT32	kvm_spurious_fault-0x4
00d3      2be:	48 8b 45 28          	mov    0x28(%rbp),%rax
00d7      2c2:	48 2b 05 00 00 00 00 	sub    0x0(%rip),%rax        # 2c9 <svm_vcpu_enter_exit+0xde>	2c5: R_X86_64_PC32	vmemmap_base-0x4
00de      2c9:	48 c1 f8 06          	sar    $0x6,%rax
00e2      2cd:	48 c1 e0 0c          	shl    $0xc,%rax
00e6      2d1:	0f 01 da             	vmload
00e9      2d4:	eb 05                	jmp    2db <svm_vcpu_enter_exit+0xf0>
00eb      2d6:	e8 00 00 00 00       	call   2db <svm_vcpu_enter_exit+0xf0>	2d7: R_X86_64_PLT32	kvm_spurious_fault-0x4
00f0      2db:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
00f5      2e0:	e8 00 00 00 00       	call   2e5 <svm_vcpu_enter_exit+0xfa>	2e1: R_X86_64_PLT32	lockdep_hardirqs_off-0x4
00fa      2e5:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 2eb <svm_vcpu_enter_exit+0x100>	2e7: R_X86_64_PC32	context_tracking_key-0x4
0100      2eb:	85 c0                	test   %eax,%eax
0102      2ed:	7e 0a                	jle    2f9 <svm_vcpu_enter_exit+0x10e>
0104      2ef:	bf 02 00 00 00       	mov    $0x2,%edi
0109      2f4:	e8 00 00 00 00       	call   2f9 <svm_vcpu_enter_exit+0x10e>	2f5: R_X86_64_PLT32	__context_tracking_exit-0x4
010e      2f9:	90                   	nop
010f      2fa:	e8 00 00 00 00       	call   2ff <svm_vcpu_enter_exit+0x114>	2fb: R_X86_64_PLT32	trace_hardirqs_off_finish-0x4
0114      2ff:	90                   	nop
0115      300:	5b                   	pop    %rbx
0116      301:	5d                   	pop    %rbp
0117      302:	41 5c                	pop    %r12
0119      304:	41 5d                	pop    %r13
011b      306:	31 c0                	xor    %eax,%eax
011d      308:	31 f6                	xor    %esi,%esi
011f      30a:	31 ff                	xor    %edi,%edi
0121      30c:	c3                   	ret
0122      30d:	cc                   	int3
0123      30e:	66 90                	xchg   %ax,%ax

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
