Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3127C97B8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 04:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjJOCwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 22:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJOCw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 22:52:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC6EDC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 19:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697338342; x=1728874342;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sdGJKNH2NFvHOmTJifwCxmHqTQkM5h+s6ZWtV/qO7XA=;
  b=ZUipqK0tYmBUIz+Vqif/+Qft5VakordFnuXp2B2bIm9aSOHnFBpQSYIR
   yD4Y4kTJE3NLGc86NuDgJajkqeDljMsfft7eAiCHe2GSRzRpmnhH37PBM
   1Pr1ydiR5Isadziu1Qx8g2SwCXkXxgLSysgYJpB4c51QEUeWQngNWWxeS
   SCP4nPS5FYG6u2ZSo1ARqQWvsAj83lATSqd4XiZhHs2Dr5+rKcqAVxrF5
   65MOgwfdmgEHD6ZwxMgYWtXsPDUaLAt70O+/qyrF8fU2CtqC+S1Eml9+d
   2uLb/ON9sYGA5IrHG2d23wrUZwhXSTBPG+TAZztWETiKt5YHEX3OHMu8V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="6925459"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="6925459"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 19:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790353023"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="790353023"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Oct 2023 19:52:19 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrrEn-0006xJ-1C;
        Sun, 15 Oct 2023 02:52:17 +0000
Date:   Sun, 15 Oct 2023 10:51:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: vmlinux.o: warning: objtool: cfi_chip_setup+0x1ba: cfi_build_cmd()
 is missing a __noreturn annotation
Message-ID: <202310151025.cvXlOsf0-lkp@intel.com>
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

Hi Josh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc9b2e683bcba017588b9aaad80f442ad004a48f
commit: fedb724c3db5490234ddde0103811c28c2fedae0 objtool: Detect missing __noreturn annotations
date:   5 months ago
config: x86_64-randconfig-074-20230824 (https://download.01.org/0day-ci/archive/20231015/202310151025.cvXlOsf0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231015/202310151025.cvXlOsf0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310151025.cvXlOsf0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: cfi_chip_setup+0x1ba: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: cfi_probe_chip+0x72: cfi_qry_mode_on() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: cfi_staa_resume+0x184: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_write_buffer+0x1e4: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_read_onechip+0x132: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_unlock_oneblock+0x146: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_lock_oneblock+0x146: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_erase_oneblock+0x118: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: fixup_sst39vf_rev_b+0x13a: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: cfi_amdstd_resume+0x1cd: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: cfi_check_err_status+0x17c: cfi_send_gen_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: chip_ready+0x17c: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: cfi_amdstd_panic_wait+0xe9: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_panic_write_oneword+0x2f5: cfi_send_gen_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_write_oneword_once+0x133: cfi_send_gen_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: fixup_sst38vf640x_sectorsize+0x147: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: put_chip.constprop.0+0x39f: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: get_chip+0x553: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_write_oneword+0x376: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_atmel_unlock+0x16e: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_atmel_lock+0x171: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: fwh_xxlock_oneblock+0x1a4: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_read+0x199: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_erase_chip+0x375: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_write_buffer+0x1ec: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_erase_oneblock+0x383: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_otp_lock+0x171: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_otp_walk+0x277: cfi_qry_mode_on() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_reset.isra.0+0x1b9: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_secsi_read+0x42a: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_otp_write+0x11f: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_read_secsi_onechip+0x2d6: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_probe_chip.cold+0x0: unreachable instruction
   vmlinux.o: warning: objtool: do_erase_oneblock.cold+0x0: unreachable instruction


objdump-func vmlinux.o cfi_chip_setup:
0000 0000000001f6dbe0 <cfi_chip_setup>:
0000  1f6dbe0:	55                   	push   %rbp
0001  1f6dbe1:	48 8d 46 10          	lea    0x10(%rsi),%rax
0005  1f6dbe5:	48 89 c2             	mov    %rax,%rdx
0008  1f6dbe8:	48 c1 ea 03          	shr    $0x3,%rdx
000c  1f6dbec:	48 89 e5             	mov    %rsp,%rbp
000f  1f6dbef:	41 57                	push   %r15
0011  1f6dbf1:	41 56                	push   %r14
0013  1f6dbf3:	49 89 fe             	mov    %rdi,%r14
0016  1f6dbf6:	41 55                	push   %r13
0018  1f6dbf8:	49 89 f5             	mov    %rsi,%r13
001b  1f6dbfb:	41 54                	push   %r12
001d  1f6dbfd:	53                   	push   %rbx
001e  1f6dbfe:	48 83 ec 58          	sub    $0x58,%rsp
0022  1f6dc02:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
0026  1f6dc06:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0030  1f6dc10:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0034  1f6dc14:	84 c0                	test   %al,%al
0036  1f6dc16:	74 08                	je     1f6dc20 <cfi_chip_setup+0x40>
0038  1f6dc18:	3c 03                	cmp    $0x3,%al
003a  1f6dc1a:	0f 8e 23 09 00 00    	jle    1f6e543 <cfi_chip_setup+0x963>
0040  1f6dc20:	49 8d 5d 14          	lea    0x14(%r13),%rbx
0044  1f6dc24:	45 8b 65 10          	mov    0x10(%r13),%r12d
0048  1f6dc28:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0052  1f6dc32:	48 89 da             	mov    %rbx,%rdx
0055  1f6dc35:	48 c1 ea 03          	shr    $0x3,%rdx
0059  1f6dc39:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
005d  1f6dc3d:	48 89 d8             	mov    %rbx,%rax
0060  1f6dc40:	83 e0 07             	and    $0x7,%eax
0063  1f6dc43:	83 c0 03             	add    $0x3,%eax
0066  1f6dc46:	38 d0                	cmp    %dl,%al
0068  1f6dc48:	7c 08                	jl     1f6dc52 <cfi_chip_setup+0x72>
006a  1f6dc4a:	84 d2                	test   %dl,%dl
006c  1f6dc4c:	0f 85 e4 08 00 00    	jne    1f6e536 <cfi_chip_setup+0x956>
0072  1f6dc52:	45 0f af 65 14       	imul   0x14(%r13),%r12d
0077  1f6dc57:	49 8d 46 30          	lea    0x30(%r14),%rax
007b  1f6dc5b:	48 89 c2             	mov    %rax,%rdx
007e  1f6dc5e:	48 89 45 98          	mov    %rax,-0x68(%rbp)
0082  1f6dc62:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
008c  1f6dc6c:	48 c1 ea 03          	shr    $0x3,%rdx
0090  1f6dc70:	44 89 65 c8          	mov    %r12d,-0x38(%rbp)
0094  1f6dc74:	45 6b e4 2c          	imul   $0x2c,%r12d,%r12d
0098  1f6dc78:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
009c  1f6dc7c:	0f 85 a1 0a 00 00    	jne    1f6e723 <cfi_chip_setup+0xb43>
00a2  1f6dc82:	44 89 e6             	mov    %r12d,%esi
00a5  1f6dc85:	49 8b 46 30          	mov    0x30(%r14),%rax
00a9  1f6dc89:	4c 89 f7             	mov    %r14,%rdi
00ac  1f6dc8c:	e8 00 00 00 00       	call   1f6dc91 <cfi_chip_setup+0xb1>	1f6dc8d: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
00b1  1f6dc91:	49 8d 4e 28          	lea    0x28(%r14),%rcx
00b5  1f6dc95:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
00bf  1f6dc9f:	48 89 ce             	mov    %rcx,%rsi
00c2  1f6dca2:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
00c6  1f6dca6:	48 c1 ee 03          	shr    $0x3,%rsi
00ca  1f6dcaa:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
00ce  1f6dcae:	84 d2                	test   %dl,%dl
00d0  1f6dcb0:	74 09                	je     1f6dcbb <cfi_chip_setup+0xdb>
00d2  1f6dcb2:	80 fa 03             	cmp    $0x3,%dl
00d5  1f6dcb5:	0f 8e 96 08 00 00    	jle    1f6e551 <cfi_chip_setup+0x971>
00db  1f6dcbb:	41 8b 76 28          	mov    0x28(%r14),%esi
00df  1f6dcbf:	89 c2                	mov    %eax,%edx
00e1  1f6dcc1:	83 fe 01             	cmp    $0x1,%esi
00e4  1f6dcc4:	74 11                	je     1f6dcd7 <cfi_chip_setup+0xf7>
00e6  1f6dcc6:	85 f6                	test   %esi,%esi
00e8  1f6dcc8:	0f 84 ee 06 00 00    	je     1f6e3bc <cfi_chip_setup+0x7dc>
00ee  1f6dcce:	83 fe 03             	cmp    $0x3,%esi
00f1  1f6dcd1:	0f 84 e5 06 00 00    	je     1f6e3bc <cfi_chip_setup+0x7dc>
00f7  1f6dcd7:	0f b6 c2             	movzbl %dl,%eax
00fa  1f6dcda:	85 c0                	test   %eax,%eax
00fc  1f6dcdc:	0f 84 e9 06 00 00    	je     1f6e3cb <cfi_chip_setup+0x7eb>
0102  1f6dce2:	8d 04 85 1d 00 00 00 	lea    0x1d(,%rax,4),%eax
0109  1f6dce9:	be c0 0c 00 00       	mov    $0xcc0,%esi
010e  1f6dcee:	48 98                	cltq
0110  1f6dcf0:	48 89 c7             	mov    %rax,%rdi
0113  1f6dcf3:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
0117  1f6dcf7:	e8 00 00 00 00       	call   1f6dcfc <cfi_chip_setup+0x11c>	1f6dcf8: R_X86_64_PLT32	__kmalloc-0x4
011c  1f6dcfc:	49 8d 4d 30          	lea    0x30(%r13),%rcx
0120  1f6dd00:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
012a  1f6dd0a:	48 89 ce             	mov    %rcx,%rsi
012d  1f6dd0d:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
0131  1f6dd11:	48 c1 ee 03          	shr    $0x3,%rsi
0135  1f6dd15:	80 3c 16 00          	cmpb   $0x0,(%rsi,%rdx,1)
0139  1f6dd19:	0f 85 20 0a 00 00    	jne    1f6e73f <cfi_chip_setup+0xb5f>
013f  1f6dd1f:	49 89 45 30          	mov    %rax,0x30(%r13)
0143  1f6dd23:	48 85 c0             	test   %rax,%rax
0146  1f6dd26:	0f 84 9f 06 00 00    	je     1f6e3cb <cfi_chip_setup+0x7eb>
014c  1f6dd2c:	ba 1d 00 00 00       	mov    $0x1d,%edx
0151  1f6dd31:	48 89 c7             	mov    %rax,%rdi
0154  1f6dd34:	31 f6                	xor    %esi,%esi
0156  1f6dd36:	e8 00 00 00 00       	call   1f6dd3b <cfi_chip_setup+0x15b>	1f6dd37: R_X86_64_PLT32	memset-0x4
015b  1f6dd3b:	49 8d 7d 18          	lea    0x18(%r13),%rdi
015f  1f6dd3f:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0169  1f6dd49:	48 89 fa             	mov    %rdi,%rdx
016c  1f6dd4c:	48 c1 ea 03          	shr    $0x3,%rdx
0170  1f6dd50:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0174  1f6dd54:	84 c0                	test   %al,%al
0176  1f6dd56:	74 08                	je     1f6dd60 <cfi_chip_setup+0x180>
0178  1f6dd58:	3c 03                	cmp    $0x3,%al
017a  1f6dd5a:	0f 8e 56 08 00 00    	jle    1f6e5b6 <cfi_chip_setup+0x9d6>
0180  1f6dd60:	49 8d 7d 48          	lea    0x48(%r13),%rdi
0184  1f6dd64:	41 c7 45 18 01 00 00 00 	movl   $0x1,0x18(%r13)
018c  1f6dd6c:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0196  1f6dd76:	48 89 fa             	mov    %rdi,%rdx
0199  1f6dd79:	48 c1 ea 03          	shr    $0x3,%rdx
019d  1f6dd7d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
01a1  1f6dd81:	0f 85 84 09 00 00    	jne    1f6e70b <cfi_chip_setup+0xb2b>
01a7  1f6dd87:	4c 89 ea             	mov    %r13,%rdx
01aa  1f6dd8a:	4c 89 f6             	mov    %r14,%rsi
01ad  1f6dd8d:	bf 30 00 00 00       	mov    $0x30,%edi
01b2  1f6dd92:	45 31 e4             	xor    %r12d,%r12d
01b5  1f6dd95:	e8 00 00 00 00       	call   1f6dd9a <cfi_chip_setup+0x1ba>	1f6dd96: R_X86_64_PLT32	cfi_build_cmd-0x4
01ba  1f6dd9a:	44 8b 4d c8          	mov    -0x38(%rbp),%r9d
01be  1f6dd9e:	49 bf 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%r15
01c8  1f6dda8:	48 89 5d 88          	mov    %rbx,-0x78(%rbp)
01cc  1f6ddac:	49 89 45 48          	mov    %rax,0x48(%r13)
01d0  1f6ddb0:	48 8b 45 90          	mov    -0x70(%rbp),%rax
01d4  1f6ddb4:	41 c1 e1 04          	shl    $0x4,%r9d
01d8  1f6ddb8:	4c 89 6d c0          	mov    %r13,-0x40(%rbp)
01dc  1f6ddbc:	48 c1 e8 03          	shr    $0x3,%rax
01e0  1f6ddc0:	44 89 cb             	mov    %r9d,%ebx
01e3  1f6ddc3:	4c 01 f8             	add    %r15,%rax
01e6  1f6ddc6:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
01ea  1f6ddca:	48 8b 45 98          	mov    -0x68(%rbp),%rax
01ee  1f6ddce:	48 c1 e8 03          	shr    $0x3,%rax
01f2  1f6ddd2:	4c 01 f8             	add    %r15,%rax
01f5  1f6ddd5:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
01f9  1f6ddd9:	eb 32                	jmp    1f6de0d <cfi_chip_setup+0x22d>
01fb  1f6dddb:	4c 89 e8             	mov    %r13,%rax
01fe  1f6ddde:	4c 89 ee             	mov    %r13,%rsi
0201  1f6dde1:	48 c1 e8 03          	shr    $0x3,%rax
0205  1f6dde5:	83 e6 07             	and    $0x7,%esi
0208  1f6dde8:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax
020d  1f6dded:	40 38 f0             	cmp    %sil,%al
0210  1f6ddf0:	7f 08                	jg     1f6ddfa <cfi_chip_setup+0x21a>
0212  1f6ddf2:	84 c0                	test   %al,%al
0214  1f6ddf4:	0f 85 3c 08 00 00    	jne    1f6e636 <cfi_chip_setup+0xa56>
021a  1f6ddfa:	8b 45 c8             	mov    -0x38(%rbp),%eax
021d  1f6ddfd:	45 88 55 00          	mov    %r10b,0x0(%r13)
0221  1f6de01:	49 83 c4 01          	add    $0x1,%r12
0225  1f6de05:	01 c3                	add    %eax,%ebx
0227  1f6de07:	4c 39 65 b0          	cmp    %r12,-0x50(%rbp)
022b  1f6de0b:	74 76                	je     1f6de83 <cfi_chip_setup+0x2a3>
022d  1f6de0d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
0231  1f6de11:	80 38 00             	cmpb   $0x0,(%rax)
0234  1f6de14:	0f 85 56 08 00 00    	jne    1f6e670 <cfi_chip_setup+0xa90>
023a  1f6de1a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
023e  1f6de1e:	4c 8b 68 30          	mov    0x30(%rax),%r13
0242  1f6de22:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
0246  1f6de26:	4d 01 e5             	add    %r12,%r13
0249  1f6de29:	80 38 00             	cmpb   $0x0,(%rax)
024c  1f6de2c:	0f 85 30 08 00 00    	jne    1f6e662 <cfi_chip_setup+0xa82>
0252  1f6de32:	89 de                	mov    %ebx,%esi
0254  1f6de34:	49 8b 46 30          	mov    0x30(%r14),%rax
0258  1f6de38:	4c 89 f7             	mov    %r14,%rdi
025b  1f6de3b:	e8 00 00 00 00       	call   1f6de40 <cfi_chip_setup+0x260>	1f6de3c: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
0260  1f6de40:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
0264  1f6de44:	48 c1 ee 03          	shr    $0x3,%rsi
0268  1f6de48:	42 0f b6 34 3e       	movzbl (%rsi,%r15,1),%esi
026d  1f6de4d:	40 84 f6             	test   %sil,%sil
0270  1f6de50:	74 0a                	je     1f6de5c <cfi_chip_setup+0x27c>
0272  1f6de52:	40 80 fe 03          	cmp    $0x3,%sil
0276  1f6de56:	0f 8e f0 07 00 00    	jle    1f6e64c <cfi_chip_setup+0xa6c>
027c  1f6de5c:	41 8b 76 28          	mov    0x28(%r14),%esi
0280  1f6de60:	41 89 c2             	mov    %eax,%r10d
0283  1f6de63:	83 fe 01             	cmp    $0x1,%esi
0286  1f6de66:	0f 84 6f ff ff ff    	je     1f6dddb <cfi_chip_setup+0x1fb>
028c  1f6de6c:	85 f6                	test   %esi,%esi
028e  1f6de6e:	74 09                	je     1f6de79 <cfi_chip_setup+0x299>
0290  1f6de70:	83 fe 03             	cmp    $0x3,%esi
0293  1f6de73:	0f 85 62 ff ff ff    	jne    1f6dddb <cfi_chip_setup+0x1fb>
0299  1f6de79:	0f c8                	bswap  %eax
029b  1f6de7b:	41 89 c2             	mov    %eax,%r10d
029e  1f6de7e:	e9 58 ff ff ff       	jmp    1f6dddb <cfi_chip_setup+0x1fb>
02a3  1f6de83:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
02a7  1f6de87:	48 8b 5d 88          	mov    -0x78(%rbp),%rbx
02ab  1f6de8b:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
02b5  1f6de95:	4c 8b 6d c0          	mov    -0x40(%rbp),%r13
02b9  1f6de99:	48 c1 ea 03          	shr    $0x3,%rdx
02bd  1f6de9d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
02c1  1f6dea1:	0f 85 6e 08 00 00    	jne    1f6e715 <cfi_chip_setup+0xb35>
02c7  1f6dea7:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
02d1  1f6deb1:	4d 8b 65 30          	mov    0x30(%r13),%r12
02d5  1f6deb5:	49 8d 7c 24 03       	lea    0x3(%r12),%rdi
02da  1f6deba:	48 89 f8             	mov    %rdi,%rax
02dd  1f6debd:	48 c1 e8 03          	shr    $0x3,%rax
02e1  1f6dec1:	0f b6 34 10          	movzbl (%rax,%rdx,1),%esi
02e5  1f6dec5:	49 8d 44 24 04       	lea    0x4(%r12),%rax
02ea  1f6deca:	49 89 c1             	mov    %rax,%r9
02ed  1f6decd:	49 c1 e9 03          	shr    $0x3,%r9
02f1  1f6ded1:	41 0f b6 14 11       	movzbl (%r9,%rdx,1),%edx
02f6  1f6ded6:	49 89 f9             	mov    %rdi,%r9
02f9  1f6ded9:	41 83 e1 07          	and    $0x7,%r9d
02fd  1f6dedd:	44 38 ce             	cmp    %r9b,%sil
0300  1f6dee0:	41 0f 9e c1          	setle  %r9b
0304  1f6dee4:	40 84 f6             	test   %sil,%sil
0307  1f6dee7:	40 0f 95 c6          	setne  %sil
030b  1f6deeb:	41 84 f1             	test   %sil,%r9b
030e  1f6deee:	0f 85 08 08 00 00    	jne    1f6e6fc <cfi_chip_setup+0xb1c>
0314  1f6def4:	83 e0 07             	and    $0x7,%eax
0317  1f6def7:	38 c2                	cmp    %al,%dl
0319  1f6def9:	40 0f 9e c6          	setle  %sil
031d  1f6defd:	84 d2                	test   %dl,%dl
031f  1f6deff:	0f 95 c0             	setne  %al
0322  1f6df02:	40 84 c6             	test   %al,%sil
0325  1f6df05:	0f 85 f1 07 00 00    	jne    1f6e6fc <cfi_chip_setup+0xb1c>
032b  1f6df0b:	49 8d 7c 24 1c       	lea    0x1c(%r12),%rdi
0330  1f6df10:	45 0f b7 7c 24 03    	movzwl 0x3(%r12),%r15d
0336  1f6df16:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0340  1f6df20:	48 89 fa             	mov    %rdi,%rdx
0343  1f6df23:	48 c1 ea 03          	shr    $0x3,%rdx
0347  1f6df27:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
034b  1f6df2b:	48 89 fa             	mov    %rdi,%rdx
034e  1f6df2e:	83 e2 07             	and    $0x7,%edx
0351  1f6df31:	38 d0                	cmp    %dl,%al
0353  1f6df33:	7f 08                	jg     1f6df3d <cfi_chip_setup+0x35d>
0355  1f6df35:	84 c0                	test   %al,%al
0357  1f6df37:	0f 85 6f 06 00 00    	jne    1f6e5ac <cfi_chip_setup+0x9cc>
035d  1f6df3d:	66 41 81 ff 01 07    	cmp    $0x701,%r15w
0363  1f6df43:	b8 aa 02 00 00       	mov    $0x2aa,%eax
0368  1f6df48:	ba 55 55 00 00       	mov    $0x5555,%edx
036d  1f6df4d:	41 bf aa 2a 00 00    	mov    $0x2aaa,%r15d
0373  1f6df53:	41 0f 44 c7          	cmove  %r15d,%eax
0377  1f6df57:	41 89 c4             	mov    %eax,%r12d
037a  1f6df5a:	b8 55 05 00 00       	mov    $0x555,%eax
037f  1f6df5f:	0f 44 c2             	cmove  %edx,%eax
0382  1f6df62:	48 89 da             	mov    %rbx,%rdx
0385  1f6df65:	48 c1 ea 03          	shr    $0x3,%rdx
0389  1f6df69:	41 89 c7             	mov    %eax,%r15d
038c  1f6df6c:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0396  1f6df76:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
039a  1f6df7a:	48 89 d8             	mov    %rbx,%rax
039d  1f6df7d:	83 e0 07             	and    $0x7,%eax
03a0  1f6df80:	83 c0 03             	add    $0x3,%eax
03a3  1f6df83:	38 d0                	cmp    %dl,%al
03a5  1f6df85:	7c 08                	jl     1f6df8f <cfi_chip_setup+0x3af>
03a7  1f6df87:	84 d2                	test   %dl,%dl
03a9  1f6df89:	0f 85 10 06 00 00    	jne    1f6e59f <cfi_chip_setup+0x9bf>
03af  1f6df8f:	6a 00                	push   $0x0
03b1  1f6df91:	45 8b 4d 14          	mov    0x14(%r13),%r9d
03b5  1f6df95:	4d 89 e8             	mov    %r13,%r8
03b8  1f6df98:	31 d2                	xor    %edx,%edx
03ba  1f6df9a:	4c 89 f1             	mov    %r14,%rcx
03bd  1f6df9d:	31 f6                	xor    %esi,%esi
03bf  1f6df9f:	bf f0 00 00 00       	mov    $0xf0,%edi
03c4  1f6dfa4:	e8 00 00 00 00       	call   1f6dfa9 <cfi_chip_setup+0x3c9>	1f6dfa5: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
03c9  1f6dfa9:	48 89 da             	mov    %rbx,%rdx
03cc  1f6dfac:	41 58                	pop    %r8
03ce  1f6dfae:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
03d8  1f6dfb8:	48 c1 ea 03          	shr    $0x3,%rdx
03dc  1f6dfbc:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
03e0  1f6dfc0:	48 89 d8             	mov    %rbx,%rax
03e3  1f6dfc3:	83 e0 07             	and    $0x7,%eax
03e6  1f6dfc6:	83 c0 03             	add    $0x3,%eax
03e9  1f6dfc9:	38 d0                	cmp    %dl,%al
03eb  1f6dfcb:	7c 08                	jl     1f6dfd5 <cfi_chip_setup+0x3f5>
03ed  1f6dfcd:	84 d2                	test   %dl,%dl
03ef  1f6dfcf:	0f 85 bd 05 00 00    	jne    1f6e592 <cfi_chip_setup+0x9b2>
03f5  1f6dfd5:	6a 00                	push   $0x0
03f7  1f6dfd7:	45 8b 4d 14          	mov    0x14(%r13),%r9d
03fb  1f6dfdb:	31 d2                	xor    %edx,%edx
03fd  1f6dfdd:	bf aa 00 00 00       	mov    $0xaa,%edi
0402  1f6dfe2:	4d 89 e8             	mov    %r13,%r8
0405  1f6dfe5:	4c 89 f1             	mov    %r14,%rcx
0408  1f6dfe8:	44 89 fe             	mov    %r15d,%esi
040b  1f6dfeb:	e8 00 00 00 00       	call   1f6dff0 <cfi_chip_setup+0x410>	1f6dfec: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0410  1f6dff0:	48 89 da             	mov    %rbx,%rdx
0413  1f6dff3:	5f                   	pop    %rdi
0414  1f6dff4:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
041e  1f6dffe:	48 c1 ea 03          	shr    $0x3,%rdx
0422  1f6e002:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
0426  1f6e006:	48 89 d8             	mov    %rbx,%rax
0429  1f6e009:	83 e0 07             	and    $0x7,%eax
042c  1f6e00c:	83 c0 03             	add    $0x3,%eax
042f  1f6e00f:	38 d0                	cmp    %dl,%al
0431  1f6e011:	7c 08                	jl     1f6e01b <cfi_chip_setup+0x43b>
0433  1f6e013:	84 d2                	test   %dl,%dl
0435  1f6e015:	0f 85 6a 05 00 00    	jne    1f6e585 <cfi_chip_setup+0x9a5>
043b  1f6e01b:	6a 00                	push   $0x0
043d  1f6e01d:	45 8b 4d 14          	mov    0x14(%r13),%r9d
0441  1f6e021:	31 d2                	xor    %edx,%edx
0443  1f6e023:	44 89 e6             	mov    %r12d,%esi
0446  1f6e026:	4d 89 e8             	mov    %r13,%r8
0449  1f6e029:	4c 89 f1             	mov    %r14,%rcx
044c  1f6e02c:	bf 55 00 00 00       	mov    $0x55,%edi
0451  1f6e031:	e8 00 00 00 00       	call   1f6e036 <cfi_chip_setup+0x456>	1f6e032: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0456  1f6e036:	48 89 da             	mov    %rbx,%rdx
0459  1f6e039:	5e                   	pop    %rsi
045a  1f6e03a:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0464  1f6e044:	48 c1 ea 03          	shr    $0x3,%rdx
0468  1f6e048:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
046c  1f6e04c:	48 89 d8             	mov    %rbx,%rax
046f  1f6e04f:	83 e0 07             	and    $0x7,%eax
0472  1f6e052:	83 c0 03             	add    $0x3,%eax
0475  1f6e055:	38 d0                	cmp    %dl,%al
0477  1f6e057:	7c 08                	jl     1f6e061 <cfi_chip_setup+0x481>
0479  1f6e059:	84 d2                	test   %dl,%dl
047b  1f6e05b:	0f 85 17 05 00 00    	jne    1f6e578 <cfi_chip_setup+0x998>
0481  1f6e061:	6a 00                	push   $0x0
0483  1f6e063:	45 8b 4d 14          	mov    0x14(%r13),%r9d
0487  1f6e067:	31 d2                	xor    %edx,%edx
0489  1f6e069:	4c 89 f1             	mov    %r14,%rcx
048c  1f6e06c:	4d 89 e8             	mov    %r13,%r8
048f  1f6e06f:	44 89 fe             	mov    %r15d,%esi
0492  1f6e072:	bf 90 00 00 00       	mov    $0x90,%edi
0497  1f6e077:	e8 00 00 00 00       	call   1f6e07c <cfi_chip_setup+0x49c>	1f6e078: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
049c  1f6e07c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
04a0  1f6e080:	59                   	pop    %rcx
04a1  1f6e081:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
04ab  1f6e08b:	48 c1 ea 03          	shr    $0x3,%rdx
04af  1f6e08f:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
04b3  1f6e093:	0f 85 98 06 00 00    	jne    1f6e731 <cfi_chip_setup+0xb51>
04b9  1f6e099:	31 f6                	xor    %esi,%esi
04bb  1f6e09b:	49 8b 46 30          	mov    0x30(%r14),%rax
04bf  1f6e09f:	4c 89 f7             	mov    %r14,%rdi
04c2  1f6e0a2:	e8 00 00 00 00       	call   1f6e0a7 <cfi_chip_setup+0x4c7>	1f6e0a3: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
04c7  1f6e0a7:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
04cb  1f6e0ab:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
04d5  1f6e0b5:	48 c1 ee 03          	shr    $0x3,%rsi
04d9  1f6e0b9:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
04dd  1f6e0bd:	84 d2                	test   %dl,%dl
04df  1f6e0bf:	74 09                	je     1f6e0ca <cfi_chip_setup+0x4ea>
04e1  1f6e0c1:	80 fa 03             	cmp    $0x3,%dl
04e4  1f6e0c4:	0f 8e 37 05 00 00    	jle    1f6e601 <cfi_chip_setup+0xa21>
04ea  1f6e0ca:	41 8b 76 28          	mov    0x28(%r14),%esi
04ee  1f6e0ce:	89 c2                	mov    %eax,%edx
04f0  1f6e0d0:	83 fe 01             	cmp    $0x1,%esi
04f3  1f6e0d3:	74 11                	je     1f6e0e6 <cfi_chip_setup+0x506>
04f5  1f6e0d5:	85 f6                	test   %esi,%esi
04f7  1f6e0d7:	0f 84 03 03 00 00    	je     1f6e3e0 <cfi_chip_setup+0x800>
04fd  1f6e0dd:	83 fe 03             	cmp    $0x3,%esi
0500  1f6e0e0:	0f 84 fa 02 00 00    	je     1f6e3e0 <cfi_chip_setup+0x800>
0506  1f6e0e6:	4d 8d 4d 38          	lea    0x38(%r13),%r9
050a  1f6e0ea:	0f b7 d2             	movzwl %dx,%edx
050d  1f6e0ed:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0517  1f6e0f7:	4c 89 ce             	mov    %r9,%rsi
051a  1f6e0fa:	48 c1 ee 03          	shr    $0x3,%rsi
051e  1f6e0fe:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
0522  1f6e102:	84 c0                	test   %al,%al
0524  1f6e104:	74 08                	je     1f6e10e <cfi_chip_setup+0x52e>
0526  1f6e106:	3c 03                	cmp    $0x3,%al
0528  1f6e108:	0f 8e d8 04 00 00    	jle    1f6e5e6 <cfi_chip_setup+0xa06>
052e  1f6e10e:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0538  1f6e118:	41 89 55 38          	mov    %edx,0x38(%r13)
053c  1f6e11c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
0540  1f6e120:	48 c1 ea 03          	shr    $0x3,%rdx
0544  1f6e124:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0548  1f6e128:	0f 85 b8 05 00 00    	jne    1f6e6e6 <cfi_chip_setup+0xb06>
054e  1f6e12e:	8b 75 c8             	mov    -0x38(%rbp),%esi
0551  1f6e131:	49 8b 46 30          	mov    0x30(%r14),%rax
0555  1f6e135:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
0559  1f6e139:	4c 89 f7             	mov    %r14,%rdi
055c  1f6e13c:	e8 00 00 00 00       	call   1f6e141 <cfi_chip_setup+0x561>	1f6e13d: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
0561  1f6e141:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
0565  1f6e145:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0569  1f6e149:	49 89 c4             	mov    %rax,%r12
056c  1f6e14c:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0576  1f6e156:	48 c1 ea 03          	shr    $0x3,%rdx
057a  1f6e15a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
057e  1f6e15e:	84 c0                	test   %al,%al
0580  1f6e160:	74 08                	je     1f6e16a <cfi_chip_setup+0x58a>
0582  1f6e162:	3c 03                	cmp    $0x3,%al
0584  1f6e164:	0f 8e fc 03 00 00    	jle    1f6e566 <cfi_chip_setup+0x986>
058a  1f6e16a:	41 8b 46 28          	mov    0x28(%r14),%eax
058e  1f6e16e:	44 89 e2             	mov    %r12d,%edx
0591  1f6e171:	83 f8 01             	cmp    $0x1,%eax
0594  1f6e174:	74 11                	je     1f6e187 <cfi_chip_setup+0x5a7>
0596  1f6e176:	85 c0                	test   %eax,%eax
0598  1f6e178:	0f 84 6b 02 00 00    	je     1f6e3e9 <cfi_chip_setup+0x809>
059e  1f6e17e:	83 f8 03             	cmp    $0x3,%eax
05a1  1f6e181:	0f 84 62 02 00 00    	je     1f6e3e9 <cfi_chip_setup+0x809>
05a7  1f6e187:	4d 8d 7d 3c          	lea    0x3c(%r13),%r15
05ab  1f6e18b:	44 0f b7 e2          	movzwl %dx,%r12d
05af  1f6e18f:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
05b9  1f6e199:	4c 89 fa             	mov    %r15,%rdx
05bc  1f6e19c:	48 c1 ea 03          	shr    $0x3,%rdx
05c0  1f6e1a0:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
05c4  1f6e1a4:	4c 89 f8             	mov    %r15,%rax
05c7  1f6e1a7:	83 e0 07             	and    $0x7,%eax
05ca  1f6e1aa:	83 c0 03             	add    $0x3,%eax
05cd  1f6e1ad:	38 d0                	cmp    %dl,%al
05cf  1f6e1af:	7c 08                	jl     1f6e1b9 <cfi_chip_setup+0x5d9>
05d1  1f6e1b1:	84 d2                	test   %dl,%dl
05d3  1f6e1b3:	0f 85 18 04 00 00    	jne    1f6e5d1 <cfi_chip_setup+0x9f1>
05d9  1f6e1b9:	4c 89 ca             	mov    %r9,%rdx
05dc  1f6e1bc:	45 89 65 3c          	mov    %r12d,0x3c(%r13)
05e0  1f6e1c0:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
05ea  1f6e1ca:	48 c1 ea 03          	shr    $0x3,%rdx
05ee  1f6e1ce:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
05f2  1f6e1d2:	0f 85 7c 05 00 00    	jne    1f6e754 <cfi_chip_setup+0xb74>
05f8  1f6e1d8:	48 b8 ff ff ff ff ff 00 00 00 	movabs $0xffffffffff,%rax
0602  1f6e1e2:	49 23 45 38          	and    0x38(%r13),%rax
0606  1f6e1e6:	48 ba 01 00 00 00 7e 00 00 00 	movabs $0x7e00000001,%rdx
0610  1f6e1f0:	48 39 d0             	cmp    %rdx,%rax
0613  1f6e1f3:	0f 84 fc 01 00 00    	je     1f6e3f5 <cfi_chip_setup+0x815>
0619  1f6e1f9:	4c 89 ea             	mov    %r13,%rdx
061c  1f6e1fc:	4c 89 f6             	mov    %r14,%rsi
061f  1f6e1ff:	31 ff                	xor    %edi,%edi
0621  1f6e201:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
0625  1f6e205:	e8 00 00 00 00       	call   1f6e20a <cfi_chip_setup+0x62a>	1f6e206: R_X86_64_PLT32	cfi_qry_mode_off-0x4
062a  1f6e20a:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
062e  1f6e20e:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0638  1f6e218:	4c 89 ca             	mov    %r9,%rdx
063b  1f6e21b:	48 c1 ea 03          	shr    $0x3,%rdx
063f  1f6e21f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0643  1f6e223:	84 c0                	test   %al,%al
0645  1f6e225:	74 08                	je     1f6e22f <cfi_chip_setup+0x64f>
0647  1f6e227:	3c 03                	cmp    $0x3,%al
0649  1f6e229:	0f 8e 91 03 00 00    	jle    1f6e5c0 <cfi_chip_setup+0x9e0>
064f  1f6e22f:	41 83 7d 38 01       	cmpl   $0x1,0x38(%r13)
0654  1f6e234:	0f 84 35 01 00 00    	je     1f6e36f <cfi_chip_setup+0x78f>
065a  1f6e23a:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0664  1f6e244:	4c 89 fa             	mov    %r15,%rdx
0667  1f6e247:	48 c1 ea 03          	shr    $0x3,%rdx
066b  1f6e24b:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
066f  1f6e24f:	4c 89 f8             	mov    %r15,%rax
0672  1f6e252:	83 e0 07             	and    $0x7,%eax
0675  1f6e255:	83 c0 03             	add    $0x3,%eax
0678  1f6e258:	38 d0                	cmp    %dl,%al
067a  1f6e25a:	7c 08                	jl     1f6e264 <cfi_chip_setup+0x684>
067c  1f6e25c:	84 d2                	test   %dl,%dl
067e  1f6e25e:	0f 85 27 04 00 00    	jne    1f6e68b <cfi_chip_setup+0xaab>
0684  1f6e264:	4c 89 ca             	mov    %r9,%rdx
0687  1f6e267:	45 8b 65 3c          	mov    0x3c(%r13),%r12d
068b  1f6e26b:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0695  1f6e275:	48 c1 ea 03          	shr    $0x3,%rdx
0699  1f6e279:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
069d  1f6e27d:	84 c0                	test   %al,%al
069f  1f6e27f:	74 08                	je     1f6e289 <cfi_chip_setup+0x6a9>
06a1  1f6e281:	3c 03                	cmp    $0x3,%al
06a3  1f6e283:	0f 8e f5 03 00 00    	jle    1f6e67e <cfi_chip_setup+0xa9e>
06a9  1f6e289:	49 8d 7e 2c          	lea    0x2c(%r14),%rdi
06ad  1f6e28d:	45 8b 7d 38          	mov    0x38(%r13),%r15d
06b1  1f6e291:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
06bb  1f6e29b:	48 89 fa             	mov    %rdi,%rdx
06be  1f6e29e:	48 c1 ea 03          	shr    $0x3,%rdx
06c2  1f6e2a2:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
06c6  1f6e2a6:	48 89 f8             	mov    %rdi,%rax
06c9  1f6e2a9:	83 e0 07             	and    $0x7,%eax
06cc  1f6e2ac:	83 c0 03             	add    $0x3,%eax
06cf  1f6e2af:	38 d0                	cmp    %dl,%al
06d1  1f6e2b1:	7c 08                	jl     1f6e2bb <cfi_chip_setup+0x6db>
06d3  1f6e2b3:	84 d2                	test   %dl,%dl
06d5  1f6e2b5:	0f 85 71 03 00 00    	jne    1f6e62c <cfi_chip_setup+0xa4c>
06db  1f6e2bb:	41 8b 46 2c          	mov    0x2c(%r14),%eax
06df  1f6e2bf:	48 89 da             	mov    %rbx,%rdx
06e2  1f6e2c2:	48 c1 ea 03          	shr    $0x3,%rdx
06e6  1f6e2c6:	44 8d 0c c5 00 00 00 00 	lea    0x0(,%rax,8),%r9d
06ee  1f6e2ce:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
06f8  1f6e2d8:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
06fc  1f6e2dc:	48 89 d8             	mov    %rbx,%rax
06ff  1f6e2df:	83 e0 07             	and    $0x7,%eax
0702  1f6e2e2:	83 c0 03             	add    $0x3,%eax
0705  1f6e2e5:	38 d0                	cmp    %dl,%al
0707  1f6e2e7:	7c 08                	jl     1f6e2f1 <cfi_chip_setup+0x711>
0709  1f6e2e9:	84 d2                	test   %dl,%dl
070b  1f6e2eb:	0f 85 26 03 00 00    	jne    1f6e617 <cfi_chip_setup+0xa37>
0711  1f6e2f1:	41 8b 45 14          	mov    0x14(%r13),%eax
0715  1f6e2f5:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
0719  1f6e2f9:	8d 1c c5 00 00 00 00 	lea    0x0(,%rax,8),%ebx
0720  1f6e300:	48 c1 ea 03          	shr    $0x3,%rdx
0724  1f6e304:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
072e  1f6e30e:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0732  1f6e312:	84 c0                	test   %al,%al
0734  1f6e314:	74 08                	je     1f6e31e <cfi_chip_setup+0x73e>
0736  1f6e316:	3c 03                	cmp    $0x3,%al
0738  1f6e318:	0f 8e 9d 03 00 00    	jle    1f6e6bb <cfi_chip_setup+0xadb>
073e  1f6e31e:	4c 89 f6             	mov    %r14,%rsi
0741  1f6e321:	41 8b 55 10          	mov    0x10(%r13),%edx
0745  1f6e325:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
074f  1f6e32f:	48 c1 ee 03          	shr    $0x3,%rsi
0753  1f6e333:	80 3c 06 00          	cmpb   $0x0,(%rsi,%rax,1)
0757  1f6e337:	0f 85 63 03 00 00    	jne    1f6e6a0 <cfi_chip_setup+0xac0>
075d  1f6e33d:	49 8b 36             	mov    (%r14),%rsi
0760  1f6e340:	41 54                	push   %r12
0762  1f6e342:	89 d9                	mov    %ebx,%ecx
0764  1f6e344:	45 31 c0             	xor    %r8d,%r8d
0767  1f6e347:	41 57                	push   %r15
0769  1f6e349:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	1f6e34c: R_X86_64_32S	.rodata+0x3fa160
0770  1f6e350:	e8 00 00 00 00       	call   1f6e355 <cfi_chip_setup+0x775>	1f6e351: R_X86_64_PLT32	_printk-0x4
0775  1f6e355:	58                   	pop    %rax
0776  1f6e356:	5a                   	pop    %rdx
0777  1f6e357:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
077b  1f6e35b:	5b                   	pop    %rbx
077c  1f6e35c:	b8 01 00 00 00       	mov    $0x1,%eax
0781  1f6e361:	41 5c                	pop    %r12
0783  1f6e363:	41 5d                	pop    %r13
0785  1f6e365:	41 5e                	pop    %r14
0787  1f6e367:	41 5f                	pop    %r15
0789  1f6e369:	5d                   	pop    %rbp
078a  1f6e36a:	e9 00 00 00 00       	jmp    1f6e36f <cfi_chip_setup+0x78f>	1f6e36b: R_X86_64_PLT32	__x86_return_thunk-0x4
078f  1f6e36f:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0799  1f6e379:	4c 89 fa             	mov    %r15,%rdx
079c  1f6e37c:	48 c1 ea 03          	shr    $0x3,%rdx
07a0  1f6e380:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
07a4  1f6e384:	4c 89 f8             	mov    %r15,%rax
07a7  1f6e387:	83 e0 07             	and    $0x7,%eax
07aa  1f6e38a:	83 c0 03             	add    $0x3,%eax
07ad  1f6e38d:	38 d0                	cmp    %dl,%al
07af  1f6e38f:	7c 08                	jl     1f6e399 <cfi_chip_setup+0x7b9>
07b1  1f6e391:	84 d2                	test   %dl,%dl
07b3  1f6e393:	0f 85 38 03 00 00    	jne    1f6e6d1 <cfi_chip_setup+0xaf1>
07b9  1f6e399:	41 81 7d 3c 01 48 00 00 	cmpl   $0x4801,0x3c(%r13)
07c1  1f6e3a1:	0f 85 93 fe ff ff    	jne    1f6e23a <cfi_chip_setup+0x65a>
07c7  1f6e3a7:	4c 89 ef             	mov    %r13,%rdi
07ca  1f6e3aa:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
07ce  1f6e3ae:	e8 2d f7 ff ff       	call   1f6dae0 <fixup_s70gl02gs_chips>
07d3  1f6e3b3:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
07d7  1f6e3b7:	e9 7e fe ff ff       	jmp    1f6e23a <cfi_chip_setup+0x65a>
07dc  1f6e3bc:	0f c8                	bswap  %eax
07de  1f6e3be:	89 c2                	mov    %eax,%edx
07e0  1f6e3c0:	0f b6 c2             	movzbl %dl,%eax
07e3  1f6e3c3:	85 c0                	test   %eax,%eax
07e5  1f6e3c5:	0f 85 17 f9 ff ff    	jne    1f6dce2 <cfi_chip_setup+0x102>
07eb  1f6e3cb:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
07ef  1f6e3cf:	31 c0                	xor    %eax,%eax
07f1  1f6e3d1:	5b                   	pop    %rbx
07f2  1f6e3d2:	41 5c                	pop    %r12
07f4  1f6e3d4:	41 5d                	pop    %r13
07f6  1f6e3d6:	41 5e                	pop    %r14
07f8  1f6e3d8:	41 5f                	pop    %r15
07fa  1f6e3da:	5d                   	pop    %rbp
07fb  1f6e3db:	e9 00 00 00 00       	jmp    1f6e3e0 <cfi_chip_setup+0x800>	1f6e3dc: R_X86_64_PLT32	__x86_return_thunk-0x4
0800  1f6e3e0:	0f c8                	bswap  %eax
0802  1f6e3e2:	89 c2                	mov    %eax,%edx
0804  1f6e3e4:	e9 fd fc ff ff       	jmp    1f6e0e6 <cfi_chip_setup+0x506>
0809  1f6e3e9:	44 89 e0             	mov    %r12d,%eax
080c  1f6e3ec:	0f c8                	bswap  %eax
080e  1f6e3ee:	89 c2                	mov    %eax,%edx
0810  1f6e3f0:	e9 92 fd ff ff       	jmp    1f6e187 <cfi_chip_setup+0x5a7>
0815  1f6e3f5:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
0819  1f6e3f9:	44 6b 65 c8 0e       	imul   $0xe,-0x38(%rbp),%r12d
081e  1f6e3fe:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0828  1f6e408:	48 c1 ea 03          	shr    $0x3,%rdx
082c  1f6e40c:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0830  1f6e410:	0f 85 b0 03 00 00    	jne    1f6e7c6 <cfi_chip_setup+0xbe6>
0836  1f6e416:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
083a  1f6e41a:	44 89 e6             	mov    %r12d,%esi
083d  1f6e41d:	49 8b 46 30          	mov    0x30(%r14),%rax
0841  1f6e421:	4c 89 f7             	mov    %r14,%rdi
0844  1f6e424:	e8 00 00 00 00       	call   1f6e429 <cfi_chip_setup+0x849>	1f6e425: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
0849  1f6e429:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
084d  1f6e42d:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0851  1f6e431:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
085b  1f6e43b:	48 c1 ee 03          	shr    $0x3,%rsi
085f  1f6e43f:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
0863  1f6e443:	84 d2                	test   %dl,%dl
0865  1f6e445:	74 09                	je     1f6e450 <cfi_chip_setup+0x870>
0867  1f6e447:	80 fa 03             	cmp    $0x3,%dl
086a  1f6e44a:	0f 8e 5c 03 00 00    	jle    1f6e7ac <cfi_chip_setup+0xbcc>
0870  1f6e450:	41 8b 56 28          	mov    0x28(%r14),%edx
0874  1f6e454:	89 c1                	mov    %eax,%ecx
0876  1f6e456:	83 fa 01             	cmp    $0x1,%edx
0879  1f6e459:	74 11                	je     1f6e46c <cfi_chip_setup+0x88c>
087b  1f6e45b:	85 d2                	test   %edx,%edx
087d  1f6e45d:	0f 84 ca 00 00 00    	je     1f6e52d <cfi_chip_setup+0x94d>
0883  1f6e463:	83 fa 03             	cmp    $0x3,%edx
0886  1f6e466:	0f 84 c1 00 00 00    	je     1f6e52d <cfi_chip_setup+0x94d>
088c  1f6e46c:	0f b6 c1             	movzbl %cl,%eax
088f  1f6e46f:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
0893  1f6e473:	c1 e0 08             	shl    $0x8,%eax
0896  1f6e476:	89 45 c0             	mov    %eax,-0x40(%rbp)
0899  1f6e479:	8b 45 c8             	mov    -0x38(%rbp),%eax
089c  1f6e47c:	48 c1 ea 03          	shr    $0x3,%rdx
08a0  1f6e480:	89 c6                	mov    %eax,%esi
08a2  1f6e482:	c1 e6 04             	shl    $0x4,%esi
08a5  1f6e485:	29 c6                	sub    %eax,%esi
08a7  1f6e487:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
08b1  1f6e491:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
08b5  1f6e495:	0f 85 f5 02 00 00    	jne    1f6e790 <cfi_chip_setup+0xbb0>
08bb  1f6e49b:	4c 89 4d c8          	mov    %r9,-0x38(%rbp)
08bf  1f6e49f:	49 8b 46 30          	mov    0x30(%r14),%rax
08c3  1f6e4a3:	4c 89 f7             	mov    %r14,%rdi
08c6  1f6e4a6:	e8 00 00 00 00       	call   1f6e4ab <cfi_chip_setup+0x8cb>	1f6e4a7: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
08cb  1f6e4ab:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
08cf  1f6e4af:	4c 8b 4d c8          	mov    -0x38(%rbp),%r9
08d3  1f6e4b3:	49 89 c4             	mov    %rax,%r12
08d6  1f6e4b6:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
08e0  1f6e4c0:	48 c1 ea 03          	shr    $0x3,%rdx
08e4  1f6e4c4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
08e8  1f6e4c8:	84 c0                	test   %al,%al
08ea  1f6e4ca:	74 08                	je     1f6e4d4 <cfi_chip_setup+0x8f4>
08ec  1f6e4cc:	3c 03                	cmp    $0x3,%al
08ee  1f6e4ce:	0f 8e aa 02 00 00    	jle    1f6e77e <cfi_chip_setup+0xb9e>
08f4  1f6e4d4:	41 8b 56 28          	mov    0x28(%r14),%edx
08f8  1f6e4d8:	44 89 e0             	mov    %r12d,%eax
08fb  1f6e4db:	83 fa 01             	cmp    $0x1,%edx
08fe  1f6e4de:	74 09                	je     1f6e4e9 <cfi_chip_setup+0x909>
0900  1f6e4e0:	85 d2                	test   %edx,%edx
0902  1f6e4e2:	74 42                	je     1f6e526 <cfi_chip_setup+0x946>
0904  1f6e4e4:	83 fa 03             	cmp    $0x3,%edx
0907  1f6e4e7:	74 3d                	je     1f6e526 <cfi_chip_setup+0x946>
0909  1f6e4e9:	44 0f b6 e0          	movzbl %al,%r12d
090d  1f6e4ed:	8b 45 c0             	mov    -0x40(%rbp),%eax
0910  1f6e4f0:	4c 89 fa             	mov    %r15,%rdx
0913  1f6e4f3:	48 c1 ea 03          	shr    $0x3,%rdx
0917  1f6e4f7:	41 09 c4             	or     %eax,%r12d
091a  1f6e4fa:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0924  1f6e504:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
0928  1f6e508:	4c 89 f8             	mov    %r15,%rax
092b  1f6e50b:	83 e0 07             	and    $0x7,%eax
092e  1f6e50e:	83 c0 03             	add    $0x3,%eax
0931  1f6e511:	38 d0                	cmp    %dl,%al
0933  1f6e513:	7c 08                	jl     1f6e51d <cfi_chip_setup+0x93d>
0935  1f6e515:	84 d2                	test   %dl,%dl
0937  1f6e517:	0f 85 4c 02 00 00    	jne    1f6e769 <cfi_chip_setup+0xb89>
093d  1f6e51d:	45 89 65 3c          	mov    %r12d,0x3c(%r13)
0941  1f6e521:	e9 d3 fc ff ff       	jmp    1f6e1f9 <cfi_chip_setup+0x619>
0946  1f6e526:	44 89 e0             	mov    %r12d,%eax
0949  1f6e529:	0f c8                	bswap  %eax
094b  1f6e52b:	eb bc                	jmp    1f6e4e9 <cfi_chip_setup+0x909>
094d  1f6e52d:	0f c8                	bswap  %eax
094f  1f6e52f:	89 c1                	mov    %eax,%ecx
0951  1f6e531:	e9 36 ff ff ff       	jmp    1f6e46c <cfi_chip_setup+0x88c>
0956  1f6e536:	48 89 df             	mov    %rbx,%rdi
0959  1f6e539:	e8 00 00 00 00       	call   1f6e53e <cfi_chip_setup+0x95e>	1f6e53a: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
095e  1f6e53e:	e9 0f f7 ff ff       	jmp    1f6dc52 <cfi_chip_setup+0x72>
0963  1f6e543:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
0967  1f6e547:	e8 00 00 00 00       	call   1f6e54c <cfi_chip_setup+0x96c>	1f6e548: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
096c  1f6e54c:	e9 cf f6 ff ff       	jmp    1f6dc20 <cfi_chip_setup+0x40>
0971  1f6e551:	48 89 cf             	mov    %rcx,%rdi
0974  1f6e554:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
0978  1f6e558:	e8 00 00 00 00       	call   1f6e55d <cfi_chip_setup+0x97d>	1f6e559: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
097d  1f6e55d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
0981  1f6e561:	e9 55 f7 ff ff       	jmp    1f6dcbb <cfi_chip_setup+0xdb>
0986  1f6e566:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
098a  1f6e56a:	e8 00 00 00 00       	call   1f6e56f <cfi_chip_setup+0x98f>	1f6e56b: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
098f  1f6e56f:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0993  1f6e573:	e9 f2 fb ff ff       	jmp    1f6e16a <cfi_chip_setup+0x58a>
0998  1f6e578:	48 89 df             	mov    %rbx,%rdi
099b  1f6e57b:	e8 00 00 00 00       	call   1f6e580 <cfi_chip_setup+0x9a0>	1f6e57c: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
09a0  1f6e580:	e9 dc fa ff ff       	jmp    1f6e061 <cfi_chip_setup+0x481>
09a5  1f6e585:	48 89 df             	mov    %rbx,%rdi
09a8  1f6e588:	e8 00 00 00 00       	call   1f6e58d <cfi_chip_setup+0x9ad>	1f6e589: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
09ad  1f6e58d:	e9 89 fa ff ff       	jmp    1f6e01b <cfi_chip_setup+0x43b>
09b2  1f6e592:	48 89 df             	mov    %rbx,%rdi
09b5  1f6e595:	e8 00 00 00 00       	call   1f6e59a <cfi_chip_setup+0x9ba>	1f6e596: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
09ba  1f6e59a:	e9 36 fa ff ff       	jmp    1f6dfd5 <cfi_chip_setup+0x3f5>
09bf  1f6e59f:	48 89 df             	mov    %rbx,%rdi
09c2  1f6e5a2:	e8 00 00 00 00       	call   1f6e5a7 <cfi_chip_setup+0x9c7>	1f6e5a3: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
09c7  1f6e5a7:	e9 e3 f9 ff ff       	jmp    1f6df8f <cfi_chip_setup+0x3af>
09cc  1f6e5ac:	e8 00 00 00 00       	call   1f6e5b1 <cfi_chip_setup+0x9d1>	1f6e5ad: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
09d1  1f6e5b1:	e9 87 f9 ff ff       	jmp    1f6df3d <cfi_chip_setup+0x35d>
09d6  1f6e5b6:	e8 00 00 00 00       	call   1f6e5bb <cfi_chip_setup+0x9db>	1f6e5b7: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
09db  1f6e5bb:	e9 a0 f7 ff ff       	jmp    1f6dd60 <cfi_chip_setup+0x180>
09e0  1f6e5c0:	4c 89 cf             	mov    %r9,%rdi
09e3  1f6e5c3:	e8 00 00 00 00       	call   1f6e5c8 <cfi_chip_setup+0x9e8>	1f6e5c4: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
09e8  1f6e5c8:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
09ec  1f6e5cc:	e9 5e fc ff ff       	jmp    1f6e22f <cfi_chip_setup+0x64f>
09f1  1f6e5d1:	4c 89 ff             	mov    %r15,%rdi
09f4  1f6e5d4:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
09f8  1f6e5d8:	e8 00 00 00 00       	call   1f6e5dd <cfi_chip_setup+0x9fd>	1f6e5d9: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
09fd  1f6e5dd:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0a01  1f6e5e1:	e9 d3 fb ff ff       	jmp    1f6e1b9 <cfi_chip_setup+0x5d9>
0a06  1f6e5e6:	4c 89 cf             	mov    %r9,%rdi
0a09  1f6e5e9:	89 55 b0             	mov    %edx,-0x50(%rbp)
0a0c  1f6e5ec:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
0a10  1f6e5f0:	e8 00 00 00 00       	call   1f6e5f5 <cfi_chip_setup+0xa15>	1f6e5f1: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
0a15  1f6e5f5:	8b 55 b0             	mov    -0x50(%rbp),%edx
0a18  1f6e5f8:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0a1c  1f6e5fc:	e9 0d fb ff ff       	jmp    1f6e10e <cfi_chip_setup+0x52e>
0a21  1f6e601:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
0a25  1f6e605:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
0a29  1f6e609:	e8 00 00 00 00       	call   1f6e60e <cfi_chip_setup+0xa2e>	1f6e60a: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0a2e  1f6e60e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
0a32  1f6e612:	e9 b3 fa ff ff       	jmp    1f6e0ca <cfi_chip_setup+0x4ea>
0a37  1f6e617:	48 89 df             	mov    %rbx,%rdi
0a3a  1f6e61a:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
0a3e  1f6e61e:	e8 00 00 00 00       	call   1f6e623 <cfi_chip_setup+0xa43>	1f6e61f: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0a43  1f6e623:	44 8b 4d d0          	mov    -0x30(%rbp),%r9d
0a47  1f6e627:	e9 c5 fc ff ff       	jmp    1f6e2f1 <cfi_chip_setup+0x711>
0a4c  1f6e62c:	e8 00 00 00 00       	call   1f6e631 <cfi_chip_setup+0xa51>	1f6e62d: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0a51  1f6e631:	e9 85 fc ff ff       	jmp    1f6e2bb <cfi_chip_setup+0x6db>
0a56  1f6e636:	4c 89 ef             	mov    %r13,%rdi
0a59  1f6e639:	44 88 55 80          	mov    %r10b,-0x80(%rbp)
0a5d  1f6e63d:	e8 00 00 00 00       	call   1f6e642 <cfi_chip_setup+0xa62>	1f6e63e: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
0a62  1f6e642:	44 0f b6 55 80       	movzbl -0x80(%rbp),%r10d
0a67  1f6e647:	e9 ae f7 ff ff       	jmp    1f6ddfa <cfi_chip_setup+0x21a>
0a6c  1f6e64c:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
0a70  1f6e650:	48 89 45 80          	mov    %rax,-0x80(%rbp)
0a74  1f6e654:	e8 00 00 00 00       	call   1f6e659 <cfi_chip_setup+0xa79>	1f6e655: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0a79  1f6e659:	48 8b 45 80          	mov    -0x80(%rbp),%rax
0a7d  1f6e65d:	e9 fa f7 ff ff       	jmp    1f6de5c <cfi_chip_setup+0x27c>
0a82  1f6e662:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0a86  1f6e666:	e8 00 00 00 00       	call   1f6e66b <cfi_chip_setup+0xa8b>	1f6e667: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0a8b  1f6e66b:	e9 c2 f7 ff ff       	jmp    1f6de32 <cfi_chip_setup+0x252>
0a90  1f6e670:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
0a94  1f6e674:	e8 00 00 00 00       	call   1f6e679 <cfi_chip_setup+0xa99>	1f6e675: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0a99  1f6e679:	e9 9c f7 ff ff       	jmp    1f6de1a <cfi_chip_setup+0x23a>
0a9e  1f6e67e:	4c 89 cf             	mov    %r9,%rdi
0aa1  1f6e681:	e8 00 00 00 00       	call   1f6e686 <cfi_chip_setup+0xaa6>	1f6e682: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0aa6  1f6e686:	e9 fe fb ff ff       	jmp    1f6e289 <cfi_chip_setup+0x6a9>
0aab  1f6e68b:	4c 89 ff             	mov    %r15,%rdi
0aae  1f6e68e:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
0ab2  1f6e692:	e8 00 00 00 00       	call   1f6e697 <cfi_chip_setup+0xab7>	1f6e693: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0ab7  1f6e697:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
0abb  1f6e69b:	e9 c4 fb ff ff       	jmp    1f6e264 <cfi_chip_setup+0x684>
0ac0  1f6e6a0:	4c 89 f7             	mov    %r14,%rdi
0ac3  1f6e6a3:	89 55 c8             	mov    %edx,-0x38(%rbp)
0ac6  1f6e6a6:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
0aca  1f6e6aa:	e8 00 00 00 00       	call   1f6e6af <cfi_chip_setup+0xacf>	1f6e6ab: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0acf  1f6e6af:	8b 55 c8             	mov    -0x38(%rbp),%edx
0ad2  1f6e6b2:	44 8b 4d d0          	mov    -0x30(%rbp),%r9d
0ad6  1f6e6b6:	e9 82 fc ff ff       	jmp    1f6e33d <cfi_chip_setup+0x75d>
0adb  1f6e6bb:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
0adf  1f6e6bf:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
0ae3  1f6e6c3:	e8 00 00 00 00       	call   1f6e6c8 <cfi_chip_setup+0xae8>	1f6e6c4: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0ae8  1f6e6c8:	44 8b 4d d0          	mov    -0x30(%rbp),%r9d
0aec  1f6e6cc:	e9 4d fc ff ff       	jmp    1f6e31e <cfi_chip_setup+0x73e>
0af1  1f6e6d1:	4c 89 ff             	mov    %r15,%rdi
0af4  1f6e6d4:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
0af8  1f6e6d8:	e8 00 00 00 00       	call   1f6e6dd <cfi_chip_setup+0xafd>	1f6e6d9: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0afd  1f6e6dd:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
0b01  1f6e6e1:	e9 b3 fc ff ff       	jmp    1f6e399 <cfi_chip_setup+0x7b9>
0b06  1f6e6e6:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0b0a  1f6e6ea:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
0b0e  1f6e6ee:	e8 00 00 00 00       	call   1f6e6f3 <cfi_chip_setup+0xb13>	1f6e6ef: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b13  1f6e6f3:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0b17  1f6e6f7:	e9 32 fa ff ff       	jmp    1f6e12e <cfi_chip_setup+0x54e>
0b1c  1f6e6fc:	be 02 00 00 00       	mov    $0x2,%esi
0b21  1f6e701:	e8 00 00 00 00       	call   1f6e706 <cfi_chip_setup+0xb26>	1f6e702: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
0b26  1f6e706:	e9 00 f8 ff ff       	jmp    1f6df0b <cfi_chip_setup+0x32b>
0b2b  1f6e70b:	e8 00 00 00 00       	call   1f6e710 <cfi_chip_setup+0xb30>	1f6e70c: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
0b30  1f6e710:	e9 72 f6 ff ff       	jmp    1f6dd87 <cfi_chip_setup+0x1a7>
0b35  1f6e715:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
0b39  1f6e719:	e8 00 00 00 00       	call   1f6e71e <cfi_chip_setup+0xb3e>	1f6e71a: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b3e  1f6e71e:	e9 84 f7 ff ff       	jmp    1f6dea7 <cfi_chip_setup+0x2c7>
0b43  1f6e723:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0b47  1f6e727:	e8 00 00 00 00       	call   1f6e72c <cfi_chip_setup+0xb4c>	1f6e728: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b4c  1f6e72c:	e9 51 f5 ff ff       	jmp    1f6dc82 <cfi_chip_setup+0xa2>
0b51  1f6e731:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0b55  1f6e735:	e8 00 00 00 00       	call   1f6e73a <cfi_chip_setup+0xb5a>	1f6e736: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b5a  1f6e73a:	e9 5a f9 ff ff       	jmp    1f6e099 <cfi_chip_setup+0x4b9>
0b5f  1f6e73f:	48 89 cf             	mov    %rcx,%rdi
0b62  1f6e742:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
0b66  1f6e746:	e8 00 00 00 00       	call   1f6e74b <cfi_chip_setup+0xb6b>	1f6e747: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
0b6b  1f6e74b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
0b6f  1f6e74f:	e9 cb f5 ff ff       	jmp    1f6dd1f <cfi_chip_setup+0x13f>
0b74  1f6e754:	4c 89 cf             	mov    %r9,%rdi
0b77  1f6e757:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
0b7b  1f6e75b:	e8 00 00 00 00       	call   1f6e760 <cfi_chip_setup+0xb80>	1f6e75c: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b80  1f6e760:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0b84  1f6e764:	e9 6f fa ff ff       	jmp    1f6e1d8 <cfi_chip_setup+0x5f8>
0b89  1f6e769:	4c 89 ff             	mov    %r15,%rdi
0b8c  1f6e76c:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
0b90  1f6e770:	e8 00 00 00 00       	call   1f6e775 <cfi_chip_setup+0xb95>	1f6e771: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
0b95  1f6e775:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
0b99  1f6e779:	e9 9f fd ff ff       	jmp    1f6e51d <cfi_chip_setup+0x93d>
0b9e  1f6e77e:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
0ba2  1f6e782:	e8 00 00 00 00       	call   1f6e787 <cfi_chip_setup+0xba7>	1f6e783: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0ba7  1f6e787:	4c 8b 4d c8          	mov    -0x38(%rbp),%r9
0bab  1f6e78b:	e9 44 fd ff ff       	jmp    1f6e4d4 <cfi_chip_setup+0x8f4>
0bb0  1f6e790:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0bb4  1f6e794:	89 75 b0             	mov    %esi,-0x50(%rbp)
0bb7  1f6e797:	4c 89 4d c8          	mov    %r9,-0x38(%rbp)
0bbb  1f6e79b:	e8 00 00 00 00       	call   1f6e7a0 <cfi_chip_setup+0xbc0>	1f6e79c: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0bc0  1f6e7a0:	8b 75 b0             	mov    -0x50(%rbp),%esi
0bc3  1f6e7a3:	4c 8b 4d c8          	mov    -0x38(%rbp),%r9
0bc7  1f6e7a7:	e9 ef fc ff ff       	jmp    1f6e49b <cfi_chip_setup+0x8bb>
0bcc  1f6e7ac:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
0bd0  1f6e7b0:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
0bd4  1f6e7b4:	e8 00 00 00 00       	call   1f6e7b9 <cfi_chip_setup+0xbd9>	1f6e7b5: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0bd9  1f6e7b9:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
0bdd  1f6e7bd:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0be1  1f6e7c1:	e9 8a fc ff ff       	jmp    1f6e450 <cfi_chip_setup+0x870>
0be6  1f6e7c6:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0bea  1f6e7ca:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
0bee  1f6e7ce:	e8 00 00 00 00       	call   1f6e7d3 <cfi_chip_setup+0xbf3>	1f6e7cf: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0bf3  1f6e7d3:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0bf7  1f6e7d7:	e9 3a fc ff ff       	jmp    1f6e416 <cfi_chip_setup+0x836>
0bfc  1f6e7dc:	0f 1f 40 00          	nopl   0x0(%rax)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
