Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9A97D1AB9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 06:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjJUEPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 00:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUEPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 00:15:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D03FA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 21:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697861695; x=1729397695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fe4KExRFqaxG2mDtYcispdgsjIekNHa5OBkLNgCVLRo=;
  b=GRUJ/LcTybexL7CfCA8C4yZWBHnCxhdFeJKf8Rg7tADPZepWwT+Q73DA
   4Ik86yRMkS9211JXwklpF6je7u7J8VE+8COAsX3TU0pOFEoc2OxZpQA87
   uVjm+gg3lWALKgJ1jUM+KKvoi8JbfEEniwOehKeJQnbAqBVY60WDN4Rgs
   LHH42lME5YVJrz1iPRWqPvci7wtLYzKwIuDe4ND+HGdJJm36SQpCr8QJR
   Rz5syU/2DqN/WMT8Xjil891AFLjbRHoXkAdUEpcMgOYWgt5DiR5W+eE0Q
   vzTyLkCoUIpYexgVBX5tzF154RCG9VyL0fcUiDgBCHYj08McILqRrKXp6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="5226936"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="5226936"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 21:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="792590882"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="792590882"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2023 21:14:47 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qu3Nt-0004Op-23;
        Sat, 21 Oct 2023 04:14:45 +0000
Date:   Sat, 21 Oct 2023 12:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: vmlinux.o: warning: objtool: cfi_staa_resume+0x169: cfi_build_cmd()
 is missing a __noreturn annotation
Message-ID: <202310211207.aIbizp9p-lkp@intel.com>
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
head:   9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
commit: 719a937b7003933de1298ffa4b881dd6a234e244 iov_iter: Mark copy_iovec_from_user() noclone
date:   3 months ago
config: x86_64-randconfig-a013-20220829 (https://download.01.org/0day-ci/archive/20231021/202310211207.aIbizp9p-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310211207.aIbizp9p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310211207.aIbizp9p-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: cfi_staa_resume+0x169: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_write_buffer+0x1d0: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_unlock_oneblock+0x132: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_lock_oneblock+0x132: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_erase_oneblock+0x10b: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_read_onechip+0x118: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: jedec_reset+0x95: cfi_send_gen_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: cfi_jedec_setup+0x3ae: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: jedec_probe_chip+0x2ec: cfi_send_gen_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_erase_oneblock.cold+0x0: unreachable instruction
>> vmlinux.o: warning: objtool: jedec_probe_chip.cold+0x0: unreachable instruction


objdump-func vmlinux.o cfi_staa_resume:
0000 000000000221ac30 <cfi_staa_resume>:
0000  221ac30:	f3 0f 1e fa          	endbr64
0004  221ac34:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
000e  221ac3e:	41 57                	push   %r15
0010  221ac40:	41 56                	push   %r14
0012  221ac42:	41 55                	push   %r13
0014  221ac44:	41 54                	push   %r12
0016  221ac46:	55                   	push   %rbp
0017  221ac47:	53                   	push   %rbx
0018  221ac48:	48 89 fb             	mov    %rdi,%rbx
001b  221ac4b:	48 81 c7 90 01 00 00 	add    $0x190,%rdi
0022  221ac52:	48 89 fa             	mov    %rdi,%rdx
0025  221ac55:	48 c1 ea 03          	shr    $0x3,%rdx
0029  221ac59:	48 83 ec 30          	sub    $0x30,%rsp
002d  221ac5d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0031  221ac61:	0f 85 f1 01 00 00    	jne    221ae58 <cfi_staa_resume+0x228>
0037  221ac67:	48 8b 83 90 01 00 00 	mov    0x190(%rbx),%rax
003e  221ac6e:	48 8d 78 60          	lea    0x60(%rax),%rdi
0042  221ac72:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
0047  221ac77:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0051  221ac81:	48 89 fa             	mov    %rdi,%rdx
0054  221ac84:	48 c1 ea 03          	shr    $0x3,%rdx
0058  221ac88:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
005c  221ac8c:	0f 85 bc 01 00 00    	jne    221ae4e <cfi_staa_resume+0x21e>
0062  221ac92:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
0067  221ac97:	4c 8b 78 60          	mov    0x60(%rax),%r15
006b  221ac9b:	49 8d 47 40          	lea    0x40(%r15),%rax
006f  221ac9f:	48 89 c2             	mov    %rax,%rdx
0072  221aca2:	48 89 04 24          	mov    %rax,(%rsp)
0076  221aca6:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0080  221acb0:	48 c1 ea 03          	shr    $0x3,%rdx
0084  221acb4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0088  221acb8:	84 c0                	test   %al,%al
008a  221acba:	74 08                	je     221acc4 <cfi_staa_resume+0x94>
008c  221acbc:	3c 03                	cmp    $0x3,%al
008e  221acbe:	0f 8e 57 01 00 00    	jle    221ae1b <cfi_staa_resume+0x1eb>
0094  221acc4:	41 8b 47 40          	mov    0x40(%r15),%eax
0098  221acc8:	31 db                	xor    %ebx,%ebx
009a  221acca:	85 c0                	test   %eax,%eax
009c  221accc:	0f 8e 3a 01 00 00    	jle    221ae0c <cfi_staa_resume+0x1dc>
00a2  221acd2:	49 bc 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%r12
00ac  221acdc:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
00b1  221ace1:	48 83 c0 18          	add    $0x18,%rax
00b5  221ace5:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
00ba  221acea:	48 c1 e8 03          	shr    $0x3,%rax
00be  221acee:	4c 01 e0             	add    %r12,%rax
00c1  221acf1:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
00c6  221acf6:	eb 2e                	jmp    221ad26 <cfi_staa_resume+0xf6>
00c8  221acf8:	48 89 ef             	mov    %rbp,%rdi
00cb  221acfb:	83 c3 01             	add    $0x1,%ebx
00ce  221acfe:	e8 00 00 00 00       	call   221ad03 <cfi_staa_resume+0xd3>	221acff: R_X86_64_PLT32	mutex_unlock-0x4
00d3  221ad03:	48 8b 04 24          	mov    (%rsp),%rax
00d7  221ad07:	48 c1 e8 03          	shr    $0x3,%rax
00db  221ad0b:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax
00e0  221ad10:	84 c0                	test   %al,%al
00e2  221ad12:	74 08                	je     221ad1c <cfi_staa_resume+0xec>
00e4  221ad14:	3c 03                	cmp    $0x3,%al
00e6  221ad16:	0f 8e 0d 01 00 00    	jle    221ae29 <cfi_staa_resume+0x1f9>
00ec  221ad1c:	41 39 5f 40          	cmp    %ebx,0x40(%r15)
00f0  221ad20:	0f 8e e6 00 00 00    	jle    221ae0c <cfi_staa_resume+0x1dc>
00f6  221ad26:	4c 63 eb             	movslq %ebx,%r13
00f9  221ad29:	31 f6                	xor    %esi,%esi
00fb  221ad2b:	4f 8d 44 ad 00       	lea    0x0(%r13,%r13,4),%r8
0100  221ad30:	49 c1 e0 06          	shl    $0x6,%r8
0104  221ad34:	4b 8d ac 07 90 00 00 00 	lea    0x90(%r15,%r8,1),%rbp
010c  221ad3c:	4d 89 c6             	mov    %r8,%r14
010f  221ad3f:	48 89 ef             	mov    %rbp,%rdi
0112  221ad42:	e8 00 00 00 00       	call   221ad47 <cfi_staa_resume+0x117>	221ad43: R_X86_64_PLT32	mutex_lock_nested-0x4
0117  221ad47:	4f 8d 54 37 74       	lea    0x74(%r15,%r14,1),%r10
011c  221ad4c:	4c 89 d0             	mov    %r10,%rax
011f  221ad4f:	48 c1 e8 03          	shr    $0x3,%rax
0123  221ad53:	42 0f b6 14 20       	movzbl (%rax,%r12,1),%edx
0128  221ad58:	4c 89 d0             	mov    %r10,%rax
012b  221ad5b:	83 e0 07             	and    $0x7,%eax
012e  221ad5e:	83 c0 03             	add    $0x3,%eax
0131  221ad61:	38 d0                	cmp    %dl,%al
0133  221ad63:	7c 08                	jl     221ad6d <cfi_staa_resume+0x13d>
0135  221ad65:	84 d2                	test   %dl,%dl
0137  221ad67:	0f 85 ca 00 00 00    	jne    221ae37 <cfi_staa_resume+0x207>
013d  221ad6d:	4b 8d 44 ad 00       	lea    0x0(%r13,%r13,4),%rax
0142  221ad72:	48 c1 e0 06          	shl    $0x6,%rax
0146  221ad76:	41 83 7c 07 74 0c    	cmpl   $0xc,0x74(%r15,%rax,1)
014c  221ad7c:	0f 85 76 ff ff ff    	jne    221acf8 <cfi_staa_resume+0xc8>
0152  221ad82:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
0157  221ad87:	4c 89 fa             	mov    %r15,%rdx
015a  221ad8a:	bf ff 00 00 00       	mov    $0xff,%edi
015f  221ad8f:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
0164  221ad94:	e8 00 00 00 00       	call   221ad99 <cfi_staa_resume+0x169>	221ad95: R_X86_64_PLT32	cfi_build_cmd-0x4
0169  221ad99:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
016e  221ad9e:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
0173  221ada3:	80 39 00             	cmpb   $0x0,(%rcx)
0176  221ada6:	0f 85 c3 00 00 00    	jne    221ae6f <cfi_staa_resume+0x23f>
017c  221adac:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
0181  221adb1:	48 8b 51 18          	mov    0x18(%rcx),%rdx
0185  221adb5:	48 89 02             	mov    %rax,(%rdx)
0188  221adb8:	0f ae f0             	mfence
018b  221adbb:	4c 89 d0             	mov    %r10,%rax
018e  221adbe:	48 c1 e8 03          	shr    $0x3,%rax
0192  221adc2:	42 0f b6 14 20       	movzbl (%rax,%r12,1),%edx
0197  221adc7:	4c 89 d0             	mov    %r10,%rax
019a  221adca:	83 e0 07             	and    $0x7,%eax
019d  221adcd:	83 c0 03             	add    $0x3,%eax
01a0  221add0:	38 d0                	cmp    %dl,%al
01a2  221add2:	7c 08                	jl     221addc <cfi_staa_resume+0x1ac>
01a4  221add4:	84 d2                	test   %dl,%dl
01a6  221add6:	0f 85 86 00 00 00    	jne    221ae62 <cfi_staa_resume+0x232>
01ac  221addc:	4b 8d 44 ad 00       	lea    0x0(%r13,%r13,4),%rax
01b1  221ade1:	4b 8d bc 37 30 01 00 00 	lea    0x130(%r15,%r14,1),%rdi
01b9  221ade9:	31 c9                	xor    %ecx,%ecx
01bb  221adeb:	ba 01 00 00 00       	mov    $0x1,%edx
01c0  221adf0:	48 c1 e0 06          	shl    $0x6,%rax
01c4  221adf4:	be 03 00 00 00       	mov    $0x3,%esi
01c9  221adf9:	41 c7 44 07 74 00 00 00 00 	movl   $0x0,0x74(%r15,%rax,1)
01d2  221ae02:	e8 00 00 00 00       	call   221ae07 <cfi_staa_resume+0x1d7>	221ae03: R_X86_64_PLT32	__wake_up-0x4
01d7  221ae07:	e9 ec fe ff ff       	jmp    221acf8 <cfi_staa_resume+0xc8>
01dc  221ae0c:	48 83 c4 30          	add    $0x30,%rsp
01e0  221ae10:	5b                   	pop    %rbx
01e1  221ae11:	5d                   	pop    %rbp
01e2  221ae12:	41 5c                	pop    %r12
01e4  221ae14:	41 5d                	pop    %r13
01e6  221ae16:	41 5e                	pop    %r14
01e8  221ae18:	41 5f                	pop    %r15
01ea  221ae1a:	c3                   	ret
01eb  221ae1b:	48 8b 3c 24          	mov    (%rsp),%rdi
01ef  221ae1f:	e8 00 00 00 00       	call   221ae24 <cfi_staa_resume+0x1f4>	221ae20: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
01f4  221ae24:	e9 9b fe ff ff       	jmp    221acc4 <cfi_staa_resume+0x94>
01f9  221ae29:	48 8b 3c 24          	mov    (%rsp),%rdi
01fd  221ae2d:	e8 00 00 00 00       	call   221ae32 <cfi_staa_resume+0x202>	221ae2e: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0202  221ae32:	e9 e5 fe ff ff       	jmp    221ad1c <cfi_staa_resume+0xec>
0207  221ae37:	4c 89 d7             	mov    %r10,%rdi
020a  221ae3a:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
020f  221ae3f:	e8 00 00 00 00       	call   221ae44 <cfi_staa_resume+0x214>	221ae40: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0214  221ae44:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
0219  221ae49:	e9 1f ff ff ff       	jmp    221ad6d <cfi_staa_resume+0x13d>
021e  221ae4e:	e8 00 00 00 00       	call   221ae53 <cfi_staa_resume+0x223>	221ae4f: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0223  221ae53:	e9 3a fe ff ff       	jmp    221ac92 <cfi_staa_resume+0x62>
0228  221ae58:	e8 00 00 00 00       	call   221ae5d <cfi_staa_resume+0x22d>	221ae59: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
022d  221ae5d:	e9 05 fe ff ff       	jmp    221ac67 <cfi_staa_resume+0x37>
0232  221ae62:	4c 89 d7             	mov    %r10,%rdi
0235  221ae65:	e8 00 00 00 00       	call   221ae6a <cfi_staa_resume+0x23a>	221ae66: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
023a  221ae6a:	e9 6d ff ff ff       	jmp    221addc <cfi_staa_resume+0x1ac>
023f  221ae6f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
0244  221ae74:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
0249  221ae79:	e8 00 00 00 00       	call   221ae7e <cfi_staa_resume+0x24e>	221ae7a: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
024e  221ae7e:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
0253  221ae83:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
0258  221ae88:	e9 1f ff ff ff       	jmp    221adac <cfi_staa_resume+0x17c>
025d  221ae8d:	0f 1f 00             	nopl   (%rax)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
