Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A65789287
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjHYX5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjHYX4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:56:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF76A10FF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693007790; x=1724543790;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ek1n8HKD7YmORLoNXPw2D6p/endwN4T6wqNUjPY0+B0=;
  b=krS1XWYYUEH5TshzT9zLXw61BMz8mcuK7DDpJGomTENR8Snvm/JIcKRS
   uIRiUDq8//U2yFLVu5ctnmpNaR3sj3pWGVRc9Kb1ph7qM+ly3tH+MhW5c
   yeadFabW5PagGmEEhYs4vSRx8JKCjkJ9DJxXUvbZokIPFFnVNzcaVQ6fC
   4KsXJkOBodIQdk3iB9KiiB4c+rFMKsJUYxlh7SB9zYqMikINo/J9tCiLL
   q/ZvAjwhzMq3nCxS2ryEckklZ5EiP4eMz0VtvFxrqZdR5yvz/k0GiP7p3
   BAMws/HD+iaNWdxxbeNYkj3xWo4wWoiWrAzjUTcGUdZZoCXguWW+uHB5T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359822574"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="359822574"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="911446498"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="911446498"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Aug 2023 16:56:25 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZgf9-00048h-2F;
        Fri, 25 Aug 2023 23:56:23 +0000
Date:   Sat, 26 Aug 2023 07:55:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: vmlinux.o: warning: objtool: cfi_chip_setup+0x1ba: cfi_build_cmd()
 is missing a __noreturn annotation
Message-ID: <202308260747.YdqBfe4E-lkp@intel.com>
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
head:   382d4cd1847517ffcb1800fd462b625db7b2ebea
commit: fedb724c3db5490234ddde0103811c28c2fedae0 objtool: Detect missing __noreturn annotations
date:   3 months ago
config: x86_64-randconfig-074-20230824 (https://download.01.org/0day-ci/archive/20230826/202308260747.YdqBfe4E-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308260747.YdqBfe4E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308260747.YdqBfe4E-lkp@intel.com/

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
0000 0000000001f816a0 <cfi_chip_setup>:
0000  1f816a0:	55                   	push   %rbp
0001  1f816a1:	48 8d 46 10          	lea    0x10(%rsi),%rax
0005  1f816a5:	48 89 c2             	mov    %rax,%rdx
0008  1f816a8:	48 c1 ea 03          	shr    $0x3,%rdx
000c  1f816ac:	48 89 e5             	mov    %rsp,%rbp
000f  1f816af:	41 57                	push   %r15
0011  1f816b1:	41 56                	push   %r14
0013  1f816b3:	49 89 fe             	mov    %rdi,%r14
0016  1f816b6:	41 55                	push   %r13
0018  1f816b8:	49 89 f5             	mov    %rsi,%r13
001b  1f816bb:	41 54                	push   %r12
001d  1f816bd:	53                   	push   %rbx
001e  1f816be:	48 83 ec 58          	sub    $0x58,%rsp
0022  1f816c2:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
0026  1f816c6:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0030  1f816d0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0034  1f816d4:	84 c0                	test   %al,%al
0036  1f816d6:	74 08                	je     1f816e0 <cfi_chip_setup+0x40>
0038  1f816d8:	3c 03                	cmp    $0x3,%al
003a  1f816da:	0f 8e 23 09 00 00    	jle    1f82003 <cfi_chip_setup+0x963>
0040  1f816e0:	49 8d 5d 14          	lea    0x14(%r13),%rbx
0044  1f816e4:	45 8b 65 10          	mov    0x10(%r13),%r12d
0048  1f816e8:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0052  1f816f2:	48 89 da             	mov    %rbx,%rdx
0055  1f816f5:	48 c1 ea 03          	shr    $0x3,%rdx
0059  1f816f9:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
005d  1f816fd:	48 89 d8             	mov    %rbx,%rax
0060  1f81700:	83 e0 07             	and    $0x7,%eax
0063  1f81703:	83 c0 03             	add    $0x3,%eax
0066  1f81706:	38 d0                	cmp    %dl,%al
0068  1f81708:	7c 08                	jl     1f81712 <cfi_chip_setup+0x72>
006a  1f8170a:	84 d2                	test   %dl,%dl
006c  1f8170c:	0f 85 e4 08 00 00    	jne    1f81ff6 <cfi_chip_setup+0x956>
0072  1f81712:	45 0f af 65 14       	imul   0x14(%r13),%r12d
0077  1f81717:	49 8d 46 30          	lea    0x30(%r14),%rax
007b  1f8171b:	48 89 c2             	mov    %rax,%rdx
007e  1f8171e:	48 89 45 98          	mov    %rax,-0x68(%rbp)
0082  1f81722:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
008c  1f8172c:	48 c1 ea 03          	shr    $0x3,%rdx
0090  1f81730:	44 89 65 c8          	mov    %r12d,-0x38(%rbp)
0094  1f81734:	45 6b e4 2c          	imul   $0x2c,%r12d,%r12d
0098  1f81738:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
009c  1f8173c:	0f 85 a1 0a 00 00    	jne    1f821e3 <cfi_chip_setup+0xb43>
00a2  1f81742:	44 89 e6             	mov    %r12d,%esi
00a5  1f81745:	49 8b 46 30          	mov    0x30(%r14),%rax
00a9  1f81749:	4c 89 f7             	mov    %r14,%rdi
00ac  1f8174c:	e8 00 00 00 00       	call   1f81751 <cfi_chip_setup+0xb1>	1f8174d: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
00b1  1f81751:	49 8d 4e 28          	lea    0x28(%r14),%rcx
00b5  1f81755:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
00bf  1f8175f:	48 89 ce             	mov    %rcx,%rsi
00c2  1f81762:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
00c6  1f81766:	48 c1 ee 03          	shr    $0x3,%rsi
00ca  1f8176a:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
00ce  1f8176e:	84 d2                	test   %dl,%dl
00d0  1f81770:	74 09                	je     1f8177b <cfi_chip_setup+0xdb>
00d2  1f81772:	80 fa 03             	cmp    $0x3,%dl
00d5  1f81775:	0f 8e 96 08 00 00    	jle    1f82011 <cfi_chip_setup+0x971>
00db  1f8177b:	41 8b 76 28          	mov    0x28(%r14),%esi
00df  1f8177f:	89 c2                	mov    %eax,%edx
00e1  1f81781:	83 fe 01             	cmp    $0x1,%esi
00e4  1f81784:	74 11                	je     1f81797 <cfi_chip_setup+0xf7>
00e6  1f81786:	85 f6                	test   %esi,%esi
00e8  1f81788:	0f 84 ee 06 00 00    	je     1f81e7c <cfi_chip_setup+0x7dc>
00ee  1f8178e:	83 fe 03             	cmp    $0x3,%esi
00f1  1f81791:	0f 84 e5 06 00 00    	je     1f81e7c <cfi_chip_setup+0x7dc>
00f7  1f81797:	0f b6 c2             	movzbl %dl,%eax
00fa  1f8179a:	85 c0                	test   %eax,%eax
00fc  1f8179c:	0f 84 e9 06 00 00    	je     1f81e8b <cfi_chip_setup+0x7eb>
0102  1f817a2:	8d 04 85 1d 00 00 00 	lea    0x1d(,%rax,4),%eax
0109  1f817a9:	be c0 0c 00 00       	mov    $0xcc0,%esi
010e  1f817ae:	48 98                	cltq
0110  1f817b0:	48 89 c7             	mov    %rax,%rdi
0113  1f817b3:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
0117  1f817b7:	e8 00 00 00 00       	call   1f817bc <cfi_chip_setup+0x11c>	1f817b8: R_X86_64_PLT32	__kmalloc-0x4
011c  1f817bc:	49 8d 4d 30          	lea    0x30(%r13),%rcx
0120  1f817c0:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
012a  1f817ca:	48 89 ce             	mov    %rcx,%rsi
012d  1f817cd:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
0131  1f817d1:	48 c1 ee 03          	shr    $0x3,%rsi
0135  1f817d5:	80 3c 16 00          	cmpb   $0x0,(%rsi,%rdx,1)
0139  1f817d9:	0f 85 20 0a 00 00    	jne    1f821ff <cfi_chip_setup+0xb5f>
013f  1f817df:	49 89 45 30          	mov    %rax,0x30(%r13)
0143  1f817e3:	48 85 c0             	test   %rax,%rax
0146  1f817e6:	0f 84 9f 06 00 00    	je     1f81e8b <cfi_chip_setup+0x7eb>
014c  1f817ec:	ba 1d 00 00 00       	mov    $0x1d,%edx
0151  1f817f1:	48 89 c7             	mov    %rax,%rdi
0154  1f817f4:	31 f6                	xor    %esi,%esi
0156  1f817f6:	e8 00 00 00 00       	call   1f817fb <cfi_chip_setup+0x15b>	1f817f7: R_X86_64_PLT32	memset-0x4
015b  1f817fb:	49 8d 7d 18          	lea    0x18(%r13),%rdi
015f  1f817ff:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0169  1f81809:	48 89 fa             	mov    %rdi,%rdx
016c  1f8180c:	48 c1 ea 03          	shr    $0x3,%rdx
0170  1f81810:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0174  1f81814:	84 c0                	test   %al,%al
0176  1f81816:	74 08                	je     1f81820 <cfi_chip_setup+0x180>
0178  1f81818:	3c 03                	cmp    $0x3,%al
017a  1f8181a:	0f 8e 56 08 00 00    	jle    1f82076 <cfi_chip_setup+0x9d6>
0180  1f81820:	49 8d 7d 48          	lea    0x48(%r13),%rdi
0184  1f81824:	41 c7 45 18 01 00 00 00 	movl   $0x1,0x18(%r13)
018c  1f8182c:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0196  1f81836:	48 89 fa             	mov    %rdi,%rdx
0199  1f81839:	48 c1 ea 03          	shr    $0x3,%rdx
019d  1f8183d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
01a1  1f81841:	0f 85 84 09 00 00    	jne    1f821cb <cfi_chip_setup+0xb2b>
01a7  1f81847:	4c 89 ea             	mov    %r13,%rdx
01aa  1f8184a:	4c 89 f6             	mov    %r14,%rsi
01ad  1f8184d:	bf 30 00 00 00       	mov    $0x30,%edi
01b2  1f81852:	45 31 e4             	xor    %r12d,%r12d
01b5  1f81855:	e8 00 00 00 00       	call   1f8185a <cfi_chip_setup+0x1ba>	1f81856: R_X86_64_PLT32	cfi_build_cmd-0x4
01ba  1f8185a:	44 8b 4d c8          	mov    -0x38(%rbp),%r9d
01be  1f8185e:	49 bf 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%r15
01c8  1f81868:	48 89 5d 88          	mov    %rbx,-0x78(%rbp)
01cc  1f8186c:	49 89 45 48          	mov    %rax,0x48(%r13)
01d0  1f81870:	48 8b 45 90          	mov    -0x70(%rbp),%rax
01d4  1f81874:	41 c1 e1 04          	shl    $0x4,%r9d
01d8  1f81878:	4c 89 6d c0          	mov    %r13,-0x40(%rbp)
01dc  1f8187c:	48 c1 e8 03          	shr    $0x3,%rax
01e0  1f81880:	44 89 cb             	mov    %r9d,%ebx
01e3  1f81883:	4c 01 f8             	add    %r15,%rax
01e6  1f81886:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
01ea  1f8188a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
01ee  1f8188e:	48 c1 e8 03          	shr    $0x3,%rax
01f2  1f81892:	4c 01 f8             	add    %r15,%rax
01f5  1f81895:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
01f9  1f81899:	eb 32                	jmp    1f818cd <cfi_chip_setup+0x22d>
01fb  1f8189b:	4c 89 e8             	mov    %r13,%rax
01fe  1f8189e:	4c 89 ee             	mov    %r13,%rsi
0201  1f818a1:	48 c1 e8 03          	shr    $0x3,%rax
0205  1f818a5:	83 e6 07             	and    $0x7,%esi
0208  1f818a8:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax
020d  1f818ad:	40 38 f0             	cmp    %sil,%al
0210  1f818b0:	7f 08                	jg     1f818ba <cfi_chip_setup+0x21a>
0212  1f818b2:	84 c0                	test   %al,%al
0214  1f818b4:	0f 85 3c 08 00 00    	jne    1f820f6 <cfi_chip_setup+0xa56>
021a  1f818ba:	8b 45 c8             	mov    -0x38(%rbp),%eax
021d  1f818bd:	45 88 55 00          	mov    %r10b,0x0(%r13)
0221  1f818c1:	49 83 c4 01          	add    $0x1,%r12
0225  1f818c5:	01 c3                	add    %eax,%ebx
0227  1f818c7:	4c 39 65 b0          	cmp    %r12,-0x50(%rbp)
022b  1f818cb:	74 76                	je     1f81943 <cfi_chip_setup+0x2a3>
022d  1f818cd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
0231  1f818d1:	80 38 00             	cmpb   $0x0,(%rax)
0234  1f818d4:	0f 85 56 08 00 00    	jne    1f82130 <cfi_chip_setup+0xa90>
023a  1f818da:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
023e  1f818de:	4c 8b 68 30          	mov    0x30(%rax),%r13
0242  1f818e2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
0246  1f818e6:	4d 01 e5             	add    %r12,%r13
0249  1f818e9:	80 38 00             	cmpb   $0x0,(%rax)
024c  1f818ec:	0f 85 30 08 00 00    	jne    1f82122 <cfi_chip_setup+0xa82>
0252  1f818f2:	89 de                	mov    %ebx,%esi
0254  1f818f4:	49 8b 46 30          	mov    0x30(%r14),%rax
0258  1f818f8:	4c 89 f7             	mov    %r14,%rdi
025b  1f818fb:	e8 00 00 00 00       	call   1f81900 <cfi_chip_setup+0x260>	1f818fc: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
0260  1f81900:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
0264  1f81904:	48 c1 ee 03          	shr    $0x3,%rsi
0268  1f81908:	42 0f b6 34 3e       	movzbl (%rsi,%r15,1),%esi
026d  1f8190d:	40 84 f6             	test   %sil,%sil
0270  1f81910:	74 0a                	je     1f8191c <cfi_chip_setup+0x27c>
0272  1f81912:	40 80 fe 03          	cmp    $0x3,%sil
0276  1f81916:	0f 8e f0 07 00 00    	jle    1f8210c <cfi_chip_setup+0xa6c>
027c  1f8191c:	41 8b 76 28          	mov    0x28(%r14),%esi
0280  1f81920:	41 89 c2             	mov    %eax,%r10d
0283  1f81923:	83 fe 01             	cmp    $0x1,%esi
0286  1f81926:	0f 84 6f ff ff ff    	je     1f8189b <cfi_chip_setup+0x1fb>
028c  1f8192c:	85 f6                	test   %esi,%esi
028e  1f8192e:	74 09                	je     1f81939 <cfi_chip_setup+0x299>
0290  1f81930:	83 fe 03             	cmp    $0x3,%esi
0293  1f81933:	0f 85 62 ff ff ff    	jne    1f8189b <cfi_chip_setup+0x1fb>
0299  1f81939:	0f c8                	bswap  %eax
029b  1f8193b:	41 89 c2             	mov    %eax,%r10d
029e  1f8193e:	e9 58 ff ff ff       	jmp    1f8189b <cfi_chip_setup+0x1fb>
02a3  1f81943:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
02a7  1f81947:	48 8b 5d 88          	mov    -0x78(%rbp),%rbx
02ab  1f8194b:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
02b5  1f81955:	4c 8b 6d c0          	mov    -0x40(%rbp),%r13
02b9  1f81959:	48 c1 ea 03          	shr    $0x3,%rdx
02bd  1f8195d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
02c1  1f81961:	0f 85 6e 08 00 00    	jne    1f821d5 <cfi_chip_setup+0xb35>
02c7  1f81967:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
02d1  1f81971:	4d 8b 65 30          	mov    0x30(%r13),%r12
02d5  1f81975:	49 8d 7c 24 03       	lea    0x3(%r12),%rdi
02da  1f8197a:	48 89 f8             	mov    %rdi,%rax
02dd  1f8197d:	48 c1 e8 03          	shr    $0x3,%rax
02e1  1f81981:	0f b6 34 10          	movzbl (%rax,%rdx,1),%esi
02e5  1f81985:	49 8d 44 24 04       	lea    0x4(%r12),%rax
02ea  1f8198a:	49 89 c1             	mov    %rax,%r9
02ed  1f8198d:	49 c1 e9 03          	shr    $0x3,%r9
02f1  1f81991:	41 0f b6 14 11       	movzbl (%r9,%rdx,1),%edx
02f6  1f81996:	49 89 f9             	mov    %rdi,%r9
02f9  1f81999:	41 83 e1 07          	and    $0x7,%r9d
02fd  1f8199d:	44 38 ce             	cmp    %r9b,%sil
0300  1f819a0:	41 0f 9e c1          	setle  %r9b
0304  1f819a4:	40 84 f6             	test   %sil,%sil
0307  1f819a7:	40 0f 95 c6          	setne  %sil
030b  1f819ab:	41 84 f1             	test   %sil,%r9b
030e  1f819ae:	0f 85 08 08 00 00    	jne    1f821bc <cfi_chip_setup+0xb1c>
0314  1f819b4:	83 e0 07             	and    $0x7,%eax
0317  1f819b7:	38 c2                	cmp    %al,%dl
0319  1f819b9:	40 0f 9e c6          	setle  %sil
031d  1f819bd:	84 d2                	test   %dl,%dl
031f  1f819bf:	0f 95 c0             	setne  %al
0322  1f819c2:	40 84 c6             	test   %al,%sil
0325  1f819c5:	0f 85 f1 07 00 00    	jne    1f821bc <cfi_chip_setup+0xb1c>
032b  1f819cb:	49 8d 7c 24 1c       	lea    0x1c(%r12),%rdi
0330  1f819d0:	45 0f b7 7c 24 03    	movzwl 0x3(%r12),%r15d
0336  1f819d6:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0340  1f819e0:	48 89 fa             	mov    %rdi,%rdx
0343  1f819e3:	48 c1 ea 03          	shr    $0x3,%rdx
0347  1f819e7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
034b  1f819eb:	48 89 fa             	mov    %rdi,%rdx
034e  1f819ee:	83 e2 07             	and    $0x7,%edx
0351  1f819f1:	38 d0                	cmp    %dl,%al
0353  1f819f3:	7f 08                	jg     1f819fd <cfi_chip_setup+0x35d>
0355  1f819f5:	84 c0                	test   %al,%al
0357  1f819f7:	0f 85 6f 06 00 00    	jne    1f8206c <cfi_chip_setup+0x9cc>
035d  1f819fd:	66 41 81 ff 01 07    	cmp    $0x701,%r15w
0363  1f81a03:	b8 aa 02 00 00       	mov    $0x2aa,%eax
0368  1f81a08:	ba 55 55 00 00       	mov    $0x5555,%edx
036d  1f81a0d:	41 bf aa 2a 00 00    	mov    $0x2aaa,%r15d
0373  1f81a13:	41 0f 44 c7          	cmove  %r15d,%eax
0377  1f81a17:	41 89 c4             	mov    %eax,%r12d
037a  1f81a1a:	b8 55 05 00 00       	mov    $0x555,%eax
037f  1f81a1f:	0f 44 c2             	cmove  %edx,%eax
0382  1f81a22:	48 89 da             	mov    %rbx,%rdx
0385  1f81a25:	48 c1 ea 03          	shr    $0x3,%rdx
0389  1f81a29:	41 89 c7             	mov    %eax,%r15d
038c  1f81a2c:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0396  1f81a36:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
039a  1f81a3a:	48 89 d8             	mov    %rbx,%rax
039d  1f81a3d:	83 e0 07             	and    $0x7,%eax
03a0  1f81a40:	83 c0 03             	add    $0x3,%eax
03a3  1f81a43:	38 d0                	cmp    %dl,%al
03a5  1f81a45:	7c 08                	jl     1f81a4f <cfi_chip_setup+0x3af>
03a7  1f81a47:	84 d2                	test   %dl,%dl
03a9  1f81a49:	0f 85 10 06 00 00    	jne    1f8205f <cfi_chip_setup+0x9bf>
03af  1f81a4f:	6a 00                	push   $0x0
03b1  1f81a51:	45 8b 4d 14          	mov    0x14(%r13),%r9d
03b5  1f81a55:	4d 89 e8             	mov    %r13,%r8
03b8  1f81a58:	31 d2                	xor    %edx,%edx
03ba  1f81a5a:	4c 89 f1             	mov    %r14,%rcx
03bd  1f81a5d:	31 f6                	xor    %esi,%esi
03bf  1f81a5f:	bf f0 00 00 00       	mov    $0xf0,%edi
03c4  1f81a64:	e8 00 00 00 00       	call   1f81a69 <cfi_chip_setup+0x3c9>	1f81a65: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
03c9  1f81a69:	48 89 da             	mov    %rbx,%rdx
03cc  1f81a6c:	41 58                	pop    %r8
03ce  1f81a6e:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
03d8  1f81a78:	48 c1 ea 03          	shr    $0x3,%rdx
03dc  1f81a7c:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
03e0  1f81a80:	48 89 d8             	mov    %rbx,%rax
03e3  1f81a83:	83 e0 07             	and    $0x7,%eax
03e6  1f81a86:	83 c0 03             	add    $0x3,%eax
03e9  1f81a89:	38 d0                	cmp    %dl,%al
03eb  1f81a8b:	7c 08                	jl     1f81a95 <cfi_chip_setup+0x3f5>
03ed  1f81a8d:	84 d2                	test   %dl,%dl
03ef  1f81a8f:	0f 85 bd 05 00 00    	jne    1f82052 <cfi_chip_setup+0x9b2>
03f5  1f81a95:	6a 00                	push   $0x0
03f7  1f81a97:	45 8b 4d 14          	mov    0x14(%r13),%r9d
03fb  1f81a9b:	31 d2                	xor    %edx,%edx
03fd  1f81a9d:	bf aa 00 00 00       	mov    $0xaa,%edi
0402  1f81aa2:	4d 89 e8             	mov    %r13,%r8
0405  1f81aa5:	4c 89 f1             	mov    %r14,%rcx
0408  1f81aa8:	44 89 fe             	mov    %r15d,%esi
040b  1f81aab:	e8 00 00 00 00       	call   1f81ab0 <cfi_chip_setup+0x410>	1f81aac: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0410  1f81ab0:	48 89 da             	mov    %rbx,%rdx
0413  1f81ab3:	5f                   	pop    %rdi
0414  1f81ab4:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
041e  1f81abe:	48 c1 ea 03          	shr    $0x3,%rdx
0422  1f81ac2:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
0426  1f81ac6:	48 89 d8             	mov    %rbx,%rax
0429  1f81ac9:	83 e0 07             	and    $0x7,%eax
042c  1f81acc:	83 c0 03             	add    $0x3,%eax
042f  1f81acf:	38 d0                	cmp    %dl,%al
0431  1f81ad1:	7c 08                	jl     1f81adb <cfi_chip_setup+0x43b>
0433  1f81ad3:	84 d2                	test   %dl,%dl
0435  1f81ad5:	0f 85 6a 05 00 00    	jne    1f82045 <cfi_chip_setup+0x9a5>
043b  1f81adb:	6a 00                	push   $0x0
043d  1f81add:	45 8b 4d 14          	mov    0x14(%r13),%r9d
0441  1f81ae1:	31 d2                	xor    %edx,%edx
0443  1f81ae3:	44 89 e6             	mov    %r12d,%esi
0446  1f81ae6:	4d 89 e8             	mov    %r13,%r8
0449  1f81ae9:	4c 89 f1             	mov    %r14,%rcx
044c  1f81aec:	bf 55 00 00 00       	mov    $0x55,%edi
0451  1f81af1:	e8 00 00 00 00       	call   1f81af6 <cfi_chip_setup+0x456>	1f81af2: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0456  1f81af6:	48 89 da             	mov    %rbx,%rdx
0459  1f81af9:	5e                   	pop    %rsi
045a  1f81afa:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0464  1f81b04:	48 c1 ea 03          	shr    $0x3,%rdx
0468  1f81b08:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
046c  1f81b0c:	48 89 d8             	mov    %rbx,%rax
046f  1f81b0f:	83 e0 07             	and    $0x7,%eax
0472  1f81b12:	83 c0 03             	add    $0x3,%eax
0475  1f81b15:	38 d0                	cmp    %dl,%al
0477  1f81b17:	7c 08                	jl     1f81b21 <cfi_chip_setup+0x481>
0479  1f81b19:	84 d2                	test   %dl,%dl
047b  1f81b1b:	0f 85 17 05 00 00    	jne    1f82038 <cfi_chip_setup+0x998>
0481  1f81b21:	6a 00                	push   $0x0
0483  1f81b23:	45 8b 4d 14          	mov    0x14(%r13),%r9d
0487  1f81b27:	31 d2                	xor    %edx,%edx
0489  1f81b29:	4c 89 f1             	mov    %r14,%rcx
048c  1f81b2c:	4d 89 e8             	mov    %r13,%r8
048f  1f81b2f:	44 89 fe             	mov    %r15d,%esi
0492  1f81b32:	bf 90 00 00 00       	mov    $0x90,%edi
0497  1f81b37:	e8 00 00 00 00       	call   1f81b3c <cfi_chip_setup+0x49c>	1f81b38: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
049c  1f81b3c:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
04a0  1f81b40:	59                   	pop    %rcx
04a1  1f81b41:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
04ab  1f81b4b:	48 c1 ea 03          	shr    $0x3,%rdx
04af  1f81b4f:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
04b3  1f81b53:	0f 85 98 06 00 00    	jne    1f821f1 <cfi_chip_setup+0xb51>
04b9  1f81b59:	31 f6                	xor    %esi,%esi
04bb  1f81b5b:	49 8b 46 30          	mov    0x30(%r14),%rax
04bf  1f81b5f:	4c 89 f7             	mov    %r14,%rdi
04c2  1f81b62:	e8 00 00 00 00       	call   1f81b67 <cfi_chip_setup+0x4c7>	1f81b63: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
04c7  1f81b67:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
04cb  1f81b6b:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
04d5  1f81b75:	48 c1 ee 03          	shr    $0x3,%rsi
04d9  1f81b79:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
04dd  1f81b7d:	84 d2                	test   %dl,%dl
04df  1f81b7f:	74 09                	je     1f81b8a <cfi_chip_setup+0x4ea>
04e1  1f81b81:	80 fa 03             	cmp    $0x3,%dl
04e4  1f81b84:	0f 8e 37 05 00 00    	jle    1f820c1 <cfi_chip_setup+0xa21>
04ea  1f81b8a:	41 8b 76 28          	mov    0x28(%r14),%esi
04ee  1f81b8e:	89 c2                	mov    %eax,%edx
04f0  1f81b90:	83 fe 01             	cmp    $0x1,%esi
04f3  1f81b93:	74 11                	je     1f81ba6 <cfi_chip_setup+0x506>
04f5  1f81b95:	85 f6                	test   %esi,%esi
04f7  1f81b97:	0f 84 03 03 00 00    	je     1f81ea0 <cfi_chip_setup+0x800>
04fd  1f81b9d:	83 fe 03             	cmp    $0x3,%esi
0500  1f81ba0:	0f 84 fa 02 00 00    	je     1f81ea0 <cfi_chip_setup+0x800>
0506  1f81ba6:	4d 8d 4d 38          	lea    0x38(%r13),%r9
050a  1f81baa:	0f b7 d2             	movzwl %dx,%edx
050d  1f81bad:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0517  1f81bb7:	4c 89 ce             	mov    %r9,%rsi
051a  1f81bba:	48 c1 ee 03          	shr    $0x3,%rsi
051e  1f81bbe:	0f b6 04 06          	movzbl (%rsi,%rax,1),%eax
0522  1f81bc2:	84 c0                	test   %al,%al
0524  1f81bc4:	74 08                	je     1f81bce <cfi_chip_setup+0x52e>
0526  1f81bc6:	3c 03                	cmp    $0x3,%al
0528  1f81bc8:	0f 8e d8 04 00 00    	jle    1f820a6 <cfi_chip_setup+0xa06>
052e  1f81bce:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0538  1f81bd8:	41 89 55 38          	mov    %edx,0x38(%r13)
053c  1f81bdc:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
0540  1f81be0:	48 c1 ea 03          	shr    $0x3,%rdx
0544  1f81be4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0548  1f81be8:	0f 85 b8 05 00 00    	jne    1f821a6 <cfi_chip_setup+0xb06>
054e  1f81bee:	8b 75 c8             	mov    -0x38(%rbp),%esi
0551  1f81bf1:	49 8b 46 30          	mov    0x30(%r14),%rax
0555  1f81bf5:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
0559  1f81bf9:	4c 89 f7             	mov    %r14,%rdi
055c  1f81bfc:	e8 00 00 00 00       	call   1f81c01 <cfi_chip_setup+0x561>	1f81bfd: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
0561  1f81c01:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
0565  1f81c05:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0569  1f81c09:	49 89 c4             	mov    %rax,%r12
056c  1f81c0c:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0576  1f81c16:	48 c1 ea 03          	shr    $0x3,%rdx
057a  1f81c1a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
057e  1f81c1e:	84 c0                	test   %al,%al
0580  1f81c20:	74 08                	je     1f81c2a <cfi_chip_setup+0x58a>
0582  1f81c22:	3c 03                	cmp    $0x3,%al
0584  1f81c24:	0f 8e fc 03 00 00    	jle    1f82026 <cfi_chip_setup+0x986>
058a  1f81c2a:	41 8b 46 28          	mov    0x28(%r14),%eax
058e  1f81c2e:	44 89 e2             	mov    %r12d,%edx
0591  1f81c31:	83 f8 01             	cmp    $0x1,%eax
0594  1f81c34:	74 11                	je     1f81c47 <cfi_chip_setup+0x5a7>
0596  1f81c36:	85 c0                	test   %eax,%eax
0598  1f81c38:	0f 84 6b 02 00 00    	je     1f81ea9 <cfi_chip_setup+0x809>
059e  1f81c3e:	83 f8 03             	cmp    $0x3,%eax
05a1  1f81c41:	0f 84 62 02 00 00    	je     1f81ea9 <cfi_chip_setup+0x809>
05a7  1f81c47:	4d 8d 7d 3c          	lea    0x3c(%r13),%r15
05ab  1f81c4b:	44 0f b7 e2          	movzwl %dx,%r12d
05af  1f81c4f:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
05b9  1f81c59:	4c 89 fa             	mov    %r15,%rdx
05bc  1f81c5c:	48 c1 ea 03          	shr    $0x3,%rdx
05c0  1f81c60:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
05c4  1f81c64:	4c 89 f8             	mov    %r15,%rax
05c7  1f81c67:	83 e0 07             	and    $0x7,%eax
05ca  1f81c6a:	83 c0 03             	add    $0x3,%eax
05cd  1f81c6d:	38 d0                	cmp    %dl,%al
05cf  1f81c6f:	7c 08                	jl     1f81c79 <cfi_chip_setup+0x5d9>
05d1  1f81c71:	84 d2                	test   %dl,%dl
05d3  1f81c73:	0f 85 18 04 00 00    	jne    1f82091 <cfi_chip_setup+0x9f1>
05d9  1f81c79:	4c 89 ca             	mov    %r9,%rdx
05dc  1f81c7c:	45 89 65 3c          	mov    %r12d,0x3c(%r13)
05e0  1f81c80:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
05ea  1f81c8a:	48 c1 ea 03          	shr    $0x3,%rdx
05ee  1f81c8e:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
05f2  1f81c92:	0f 85 7c 05 00 00    	jne    1f82214 <cfi_chip_setup+0xb74>
05f8  1f81c98:	48 b8 ff ff ff ff ff 00 00 00 	movabs $0xffffffffff,%rax
0602  1f81ca2:	49 23 45 38          	and    0x38(%r13),%rax
0606  1f81ca6:	48 ba 01 00 00 00 7e 00 00 00 	movabs $0x7e00000001,%rdx
0610  1f81cb0:	48 39 d0             	cmp    %rdx,%rax
0613  1f81cb3:	0f 84 fc 01 00 00    	je     1f81eb5 <cfi_chip_setup+0x815>
0619  1f81cb9:	4c 89 ea             	mov    %r13,%rdx
061c  1f81cbc:	4c 89 f6             	mov    %r14,%rsi
061f  1f81cbf:	31 ff                	xor    %edi,%edi
0621  1f81cc1:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
0625  1f81cc5:	e8 00 00 00 00       	call   1f81cca <cfi_chip_setup+0x62a>	1f81cc6: R_X86_64_PLT32	cfi_qry_mode_off-0x4
062a  1f81cca:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
062e  1f81cce:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0638  1f81cd8:	4c 89 ca             	mov    %r9,%rdx
063b  1f81cdb:	48 c1 ea 03          	shr    $0x3,%rdx
063f  1f81cdf:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0643  1f81ce3:	84 c0                	test   %al,%al
0645  1f81ce5:	74 08                	je     1f81cef <cfi_chip_setup+0x64f>
0647  1f81ce7:	3c 03                	cmp    $0x3,%al
0649  1f81ce9:	0f 8e 91 03 00 00    	jle    1f82080 <cfi_chip_setup+0x9e0>
064f  1f81cef:	41 83 7d 38 01       	cmpl   $0x1,0x38(%r13)
0654  1f81cf4:	0f 84 35 01 00 00    	je     1f81e2f <cfi_chip_setup+0x78f>
065a  1f81cfa:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0664  1f81d04:	4c 89 fa             	mov    %r15,%rdx
0667  1f81d07:	48 c1 ea 03          	shr    $0x3,%rdx
066b  1f81d0b:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
066f  1f81d0f:	4c 89 f8             	mov    %r15,%rax
0672  1f81d12:	83 e0 07             	and    $0x7,%eax
0675  1f81d15:	83 c0 03             	add    $0x3,%eax
0678  1f81d18:	38 d0                	cmp    %dl,%al
067a  1f81d1a:	7c 08                	jl     1f81d24 <cfi_chip_setup+0x684>
067c  1f81d1c:	84 d2                	test   %dl,%dl
067e  1f81d1e:	0f 85 27 04 00 00    	jne    1f8214b <cfi_chip_setup+0xaab>
0684  1f81d24:	4c 89 ca             	mov    %r9,%rdx
0687  1f81d27:	45 8b 65 3c          	mov    0x3c(%r13),%r12d
068b  1f81d2b:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0695  1f81d35:	48 c1 ea 03          	shr    $0x3,%rdx
0699  1f81d39:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
069d  1f81d3d:	84 c0                	test   %al,%al
069f  1f81d3f:	74 08                	je     1f81d49 <cfi_chip_setup+0x6a9>
06a1  1f81d41:	3c 03                	cmp    $0x3,%al
06a3  1f81d43:	0f 8e f5 03 00 00    	jle    1f8213e <cfi_chip_setup+0xa9e>
06a9  1f81d49:	49 8d 7e 2c          	lea    0x2c(%r14),%rdi
06ad  1f81d4d:	45 8b 7d 38          	mov    0x38(%r13),%r15d
06b1  1f81d51:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
06bb  1f81d5b:	48 89 fa             	mov    %rdi,%rdx
06be  1f81d5e:	48 c1 ea 03          	shr    $0x3,%rdx
06c2  1f81d62:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
06c6  1f81d66:	48 89 f8             	mov    %rdi,%rax
06c9  1f81d69:	83 e0 07             	and    $0x7,%eax
06cc  1f81d6c:	83 c0 03             	add    $0x3,%eax
06cf  1f81d6f:	38 d0                	cmp    %dl,%al
06d1  1f81d71:	7c 08                	jl     1f81d7b <cfi_chip_setup+0x6db>
06d3  1f81d73:	84 d2                	test   %dl,%dl
06d5  1f81d75:	0f 85 71 03 00 00    	jne    1f820ec <cfi_chip_setup+0xa4c>
06db  1f81d7b:	41 8b 46 2c          	mov    0x2c(%r14),%eax
06df  1f81d7f:	48 89 da             	mov    %rbx,%rdx
06e2  1f81d82:	48 c1 ea 03          	shr    $0x3,%rdx
06e6  1f81d86:	44 8d 0c c5 00 00 00 00 	lea    0x0(,%rax,8),%r9d
06ee  1f81d8e:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
06f8  1f81d98:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
06fc  1f81d9c:	48 89 d8             	mov    %rbx,%rax
06ff  1f81d9f:	83 e0 07             	and    $0x7,%eax
0702  1f81da2:	83 c0 03             	add    $0x3,%eax
0705  1f81da5:	38 d0                	cmp    %dl,%al
0707  1f81da7:	7c 08                	jl     1f81db1 <cfi_chip_setup+0x711>
0709  1f81da9:	84 d2                	test   %dl,%dl
070b  1f81dab:	0f 85 26 03 00 00    	jne    1f820d7 <cfi_chip_setup+0xa37>
0711  1f81db1:	41 8b 45 14          	mov    0x14(%r13),%eax
0715  1f81db5:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
0719  1f81db9:	8d 1c c5 00 00 00 00 	lea    0x0(,%rax,8),%ebx
0720  1f81dc0:	48 c1 ea 03          	shr    $0x3,%rdx
0724  1f81dc4:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
072e  1f81dce:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0732  1f81dd2:	84 c0                	test   %al,%al
0734  1f81dd4:	74 08                	je     1f81dde <cfi_chip_setup+0x73e>
0736  1f81dd6:	3c 03                	cmp    $0x3,%al
0738  1f81dd8:	0f 8e 9d 03 00 00    	jle    1f8217b <cfi_chip_setup+0xadb>
073e  1f81dde:	4c 89 f6             	mov    %r14,%rsi
0741  1f81de1:	41 8b 55 10          	mov    0x10(%r13),%edx
0745  1f81de5:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
074f  1f81def:	48 c1 ee 03          	shr    $0x3,%rsi
0753  1f81df3:	80 3c 06 00          	cmpb   $0x0,(%rsi,%rax,1)
0757  1f81df7:	0f 85 63 03 00 00    	jne    1f82160 <cfi_chip_setup+0xac0>
075d  1f81dfd:	49 8b 36             	mov    (%r14),%rsi
0760  1f81e00:	41 54                	push   %r12
0762  1f81e02:	89 d9                	mov    %ebx,%ecx
0764  1f81e04:	45 31 c0             	xor    %r8d,%r8d
0767  1f81e07:	41 57                	push   %r15
0769  1f81e09:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	1f81e0c: R_X86_64_32S	.rodata+0x3fe260
0770  1f81e10:	e8 00 00 00 00       	call   1f81e15 <cfi_chip_setup+0x775>	1f81e11: R_X86_64_PLT32	_printk-0x4
0775  1f81e15:	58                   	pop    %rax
0776  1f81e16:	5a                   	pop    %rdx
0777  1f81e17:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
077b  1f81e1b:	5b                   	pop    %rbx
077c  1f81e1c:	b8 01 00 00 00       	mov    $0x1,%eax
0781  1f81e21:	41 5c                	pop    %r12
0783  1f81e23:	41 5d                	pop    %r13
0785  1f81e25:	41 5e                	pop    %r14
0787  1f81e27:	41 5f                	pop    %r15
0789  1f81e29:	5d                   	pop    %rbp
078a  1f81e2a:	e9 00 00 00 00       	jmp    1f81e2f <cfi_chip_setup+0x78f>	1f81e2b: R_X86_64_PLT32	__x86_return_thunk-0x4
078f  1f81e2f:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0799  1f81e39:	4c 89 fa             	mov    %r15,%rdx
079c  1f81e3c:	48 c1 ea 03          	shr    $0x3,%rdx
07a0  1f81e40:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
07a4  1f81e44:	4c 89 f8             	mov    %r15,%rax
07a7  1f81e47:	83 e0 07             	and    $0x7,%eax
07aa  1f81e4a:	83 c0 03             	add    $0x3,%eax
07ad  1f81e4d:	38 d0                	cmp    %dl,%al
07af  1f81e4f:	7c 08                	jl     1f81e59 <cfi_chip_setup+0x7b9>
07b1  1f81e51:	84 d2                	test   %dl,%dl
07b3  1f81e53:	0f 85 38 03 00 00    	jne    1f82191 <cfi_chip_setup+0xaf1>
07b9  1f81e59:	41 81 7d 3c 01 48 00 00 	cmpl   $0x4801,0x3c(%r13)
07c1  1f81e61:	0f 85 93 fe ff ff    	jne    1f81cfa <cfi_chip_setup+0x65a>
07c7  1f81e67:	4c 89 ef             	mov    %r13,%rdi
07ca  1f81e6a:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
07ce  1f81e6e:	e8 2d f7 ff ff       	call   1f815a0 <fixup_s70gl02gs_chips>
07d3  1f81e73:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
07d7  1f81e77:	e9 7e fe ff ff       	jmp    1f81cfa <cfi_chip_setup+0x65a>
07dc  1f81e7c:	0f c8                	bswap  %eax
07de  1f81e7e:	89 c2                	mov    %eax,%edx
07e0  1f81e80:	0f b6 c2             	movzbl %dl,%eax
07e3  1f81e83:	85 c0                	test   %eax,%eax
07e5  1f81e85:	0f 85 17 f9 ff ff    	jne    1f817a2 <cfi_chip_setup+0x102>
07eb  1f81e8b:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
07ef  1f81e8f:	31 c0                	xor    %eax,%eax
07f1  1f81e91:	5b                   	pop    %rbx
07f2  1f81e92:	41 5c                	pop    %r12
07f4  1f81e94:	41 5d                	pop    %r13
07f6  1f81e96:	41 5e                	pop    %r14
07f8  1f81e98:	41 5f                	pop    %r15
07fa  1f81e9a:	5d                   	pop    %rbp
07fb  1f81e9b:	e9 00 00 00 00       	jmp    1f81ea0 <cfi_chip_setup+0x800>	1f81e9c: R_X86_64_PLT32	__x86_return_thunk-0x4
0800  1f81ea0:	0f c8                	bswap  %eax
0802  1f81ea2:	89 c2                	mov    %eax,%edx
0804  1f81ea4:	e9 fd fc ff ff       	jmp    1f81ba6 <cfi_chip_setup+0x506>
0809  1f81ea9:	44 89 e0             	mov    %r12d,%eax
080c  1f81eac:	0f c8                	bswap  %eax
080e  1f81eae:	89 c2                	mov    %eax,%edx
0810  1f81eb0:	e9 92 fd ff ff       	jmp    1f81c47 <cfi_chip_setup+0x5a7>
0815  1f81eb5:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
0819  1f81eb9:	44 6b 65 c8 0e       	imul   $0xe,-0x38(%rbp),%r12d
081e  1f81ebe:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0828  1f81ec8:	48 c1 ea 03          	shr    $0x3,%rdx
082c  1f81ecc:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0830  1f81ed0:	0f 85 b0 03 00 00    	jne    1f82286 <cfi_chip_setup+0xbe6>
0836  1f81ed6:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
083a  1f81eda:	44 89 e6             	mov    %r12d,%esi
083d  1f81edd:	49 8b 46 30          	mov    0x30(%r14),%rax
0841  1f81ee1:	4c 89 f7             	mov    %r14,%rdi
0844  1f81ee4:	e8 00 00 00 00       	call   1f81ee9 <cfi_chip_setup+0x849>	1f81ee5: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
0849  1f81ee9:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
084d  1f81eed:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0851  1f81ef1:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
085b  1f81efb:	48 c1 ee 03          	shr    $0x3,%rsi
085f  1f81eff:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
0863  1f81f03:	84 d2                	test   %dl,%dl
0865  1f81f05:	74 09                	je     1f81f10 <cfi_chip_setup+0x870>
0867  1f81f07:	80 fa 03             	cmp    $0x3,%dl
086a  1f81f0a:	0f 8e 5c 03 00 00    	jle    1f8226c <cfi_chip_setup+0xbcc>
0870  1f81f10:	41 8b 56 28          	mov    0x28(%r14),%edx
0874  1f81f14:	89 c1                	mov    %eax,%ecx
0876  1f81f16:	83 fa 01             	cmp    $0x1,%edx
0879  1f81f19:	74 11                	je     1f81f2c <cfi_chip_setup+0x88c>
087b  1f81f1b:	85 d2                	test   %edx,%edx
087d  1f81f1d:	0f 84 ca 00 00 00    	je     1f81fed <cfi_chip_setup+0x94d>
0883  1f81f23:	83 fa 03             	cmp    $0x3,%edx
0886  1f81f26:	0f 84 c1 00 00 00    	je     1f81fed <cfi_chip_setup+0x94d>
088c  1f81f2c:	0f b6 c1             	movzbl %cl,%eax
088f  1f81f2f:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
0893  1f81f33:	c1 e0 08             	shl    $0x8,%eax
0896  1f81f36:	89 45 c0             	mov    %eax,-0x40(%rbp)
0899  1f81f39:	8b 45 c8             	mov    -0x38(%rbp),%eax
089c  1f81f3c:	48 c1 ea 03          	shr    $0x3,%rdx
08a0  1f81f40:	89 c6                	mov    %eax,%esi
08a2  1f81f42:	c1 e6 04             	shl    $0x4,%esi
08a5  1f81f45:	29 c6                	sub    %eax,%esi
08a7  1f81f47:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
08b1  1f81f51:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
08b5  1f81f55:	0f 85 f5 02 00 00    	jne    1f82250 <cfi_chip_setup+0xbb0>
08bb  1f81f5b:	4c 89 4d c8          	mov    %r9,-0x38(%rbp)
08bf  1f81f5f:	49 8b 46 30          	mov    0x30(%r14),%rax
08c3  1f81f63:	4c 89 f7             	mov    %r14,%rdi
08c6  1f81f66:	e8 00 00 00 00       	call   1f81f6b <cfi_chip_setup+0x8cb>	1f81f67: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
08cb  1f81f6b:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
08cf  1f81f6f:	4c 8b 4d c8          	mov    -0x38(%rbp),%r9
08d3  1f81f73:	49 89 c4             	mov    %rax,%r12
08d6  1f81f76:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
08e0  1f81f80:	48 c1 ea 03          	shr    $0x3,%rdx
08e4  1f81f84:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
08e8  1f81f88:	84 c0                	test   %al,%al
08ea  1f81f8a:	74 08                	je     1f81f94 <cfi_chip_setup+0x8f4>
08ec  1f81f8c:	3c 03                	cmp    $0x3,%al
08ee  1f81f8e:	0f 8e aa 02 00 00    	jle    1f8223e <cfi_chip_setup+0xb9e>
08f4  1f81f94:	41 8b 56 28          	mov    0x28(%r14),%edx
08f8  1f81f98:	44 89 e0             	mov    %r12d,%eax
08fb  1f81f9b:	83 fa 01             	cmp    $0x1,%edx
08fe  1f81f9e:	74 09                	je     1f81fa9 <cfi_chip_setup+0x909>
0900  1f81fa0:	85 d2                	test   %edx,%edx
0902  1f81fa2:	74 42                	je     1f81fe6 <cfi_chip_setup+0x946>
0904  1f81fa4:	83 fa 03             	cmp    $0x3,%edx
0907  1f81fa7:	74 3d                	je     1f81fe6 <cfi_chip_setup+0x946>
0909  1f81fa9:	44 0f b6 e0          	movzbl %al,%r12d
090d  1f81fad:	8b 45 c0             	mov    -0x40(%rbp),%eax
0910  1f81fb0:	4c 89 fa             	mov    %r15,%rdx
0913  1f81fb3:	48 c1 ea 03          	shr    $0x3,%rdx
0917  1f81fb7:	41 09 c4             	or     %eax,%r12d
091a  1f81fba:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0924  1f81fc4:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
0928  1f81fc8:	4c 89 f8             	mov    %r15,%rax
092b  1f81fcb:	83 e0 07             	and    $0x7,%eax
092e  1f81fce:	83 c0 03             	add    $0x3,%eax
0931  1f81fd1:	38 d0                	cmp    %dl,%al
0933  1f81fd3:	7c 08                	jl     1f81fdd <cfi_chip_setup+0x93d>
0935  1f81fd5:	84 d2                	test   %dl,%dl
0937  1f81fd7:	0f 85 4c 02 00 00    	jne    1f82229 <cfi_chip_setup+0xb89>
093d  1f81fdd:	45 89 65 3c          	mov    %r12d,0x3c(%r13)
0941  1f81fe1:	e9 d3 fc ff ff       	jmp    1f81cb9 <cfi_chip_setup+0x619>
0946  1f81fe6:	44 89 e0             	mov    %r12d,%eax
0949  1f81fe9:	0f c8                	bswap  %eax
094b  1f81feb:	eb bc                	jmp    1f81fa9 <cfi_chip_setup+0x909>
094d  1f81fed:	0f c8                	bswap  %eax
094f  1f81fef:	89 c1                	mov    %eax,%ecx
0951  1f81ff1:	e9 36 ff ff ff       	jmp    1f81f2c <cfi_chip_setup+0x88c>
0956  1f81ff6:	48 89 df             	mov    %rbx,%rdi
0959  1f81ff9:	e8 00 00 00 00       	call   1f81ffe <cfi_chip_setup+0x95e>	1f81ffa: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
095e  1f81ffe:	e9 0f f7 ff ff       	jmp    1f81712 <cfi_chip_setup+0x72>
0963  1f82003:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
0967  1f82007:	e8 00 00 00 00       	call   1f8200c <cfi_chip_setup+0x96c>	1f82008: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
096c  1f8200c:	e9 cf f6 ff ff       	jmp    1f816e0 <cfi_chip_setup+0x40>
0971  1f82011:	48 89 cf             	mov    %rcx,%rdi
0974  1f82014:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
0978  1f82018:	e8 00 00 00 00       	call   1f8201d <cfi_chip_setup+0x97d>	1f82019: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
097d  1f8201d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
0981  1f82021:	e9 55 f7 ff ff       	jmp    1f8177b <cfi_chip_setup+0xdb>
0986  1f82026:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
098a  1f8202a:	e8 00 00 00 00       	call   1f8202f <cfi_chip_setup+0x98f>	1f8202b: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
098f  1f8202f:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0993  1f82033:	e9 f2 fb ff ff       	jmp    1f81c2a <cfi_chip_setup+0x58a>
0998  1f82038:	48 89 df             	mov    %rbx,%rdi
099b  1f8203b:	e8 00 00 00 00       	call   1f82040 <cfi_chip_setup+0x9a0>	1f8203c: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
09a0  1f82040:	e9 dc fa ff ff       	jmp    1f81b21 <cfi_chip_setup+0x481>
09a5  1f82045:	48 89 df             	mov    %rbx,%rdi
09a8  1f82048:	e8 00 00 00 00       	call   1f8204d <cfi_chip_setup+0x9ad>	1f82049: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
09ad  1f8204d:	e9 89 fa ff ff       	jmp    1f81adb <cfi_chip_setup+0x43b>
09b2  1f82052:	48 89 df             	mov    %rbx,%rdi
09b5  1f82055:	e8 00 00 00 00       	call   1f8205a <cfi_chip_setup+0x9ba>	1f82056: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
09ba  1f8205a:	e9 36 fa ff ff       	jmp    1f81a95 <cfi_chip_setup+0x3f5>
09bf  1f8205f:	48 89 df             	mov    %rbx,%rdi
09c2  1f82062:	e8 00 00 00 00       	call   1f82067 <cfi_chip_setup+0x9c7>	1f82063: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
09c7  1f82067:	e9 e3 f9 ff ff       	jmp    1f81a4f <cfi_chip_setup+0x3af>
09cc  1f8206c:	e8 00 00 00 00       	call   1f82071 <cfi_chip_setup+0x9d1>	1f8206d: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
09d1  1f82071:	e9 87 f9 ff ff       	jmp    1f819fd <cfi_chip_setup+0x35d>
09d6  1f82076:	e8 00 00 00 00       	call   1f8207b <cfi_chip_setup+0x9db>	1f82077: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
09db  1f8207b:	e9 a0 f7 ff ff       	jmp    1f81820 <cfi_chip_setup+0x180>
09e0  1f82080:	4c 89 cf             	mov    %r9,%rdi
09e3  1f82083:	e8 00 00 00 00       	call   1f82088 <cfi_chip_setup+0x9e8>	1f82084: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
09e8  1f82088:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
09ec  1f8208c:	e9 5e fc ff ff       	jmp    1f81cef <cfi_chip_setup+0x64f>
09f1  1f82091:	4c 89 ff             	mov    %r15,%rdi
09f4  1f82094:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
09f8  1f82098:	e8 00 00 00 00       	call   1f8209d <cfi_chip_setup+0x9fd>	1f82099: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
09fd  1f8209d:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0a01  1f820a1:	e9 d3 fb ff ff       	jmp    1f81c79 <cfi_chip_setup+0x5d9>
0a06  1f820a6:	4c 89 cf             	mov    %r9,%rdi
0a09  1f820a9:	89 55 b0             	mov    %edx,-0x50(%rbp)
0a0c  1f820ac:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
0a10  1f820b0:	e8 00 00 00 00       	call   1f820b5 <cfi_chip_setup+0xa15>	1f820b1: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
0a15  1f820b5:	8b 55 b0             	mov    -0x50(%rbp),%edx
0a18  1f820b8:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0a1c  1f820bc:	e9 0d fb ff ff       	jmp    1f81bce <cfi_chip_setup+0x52e>
0a21  1f820c1:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
0a25  1f820c5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
0a29  1f820c9:	e8 00 00 00 00       	call   1f820ce <cfi_chip_setup+0xa2e>	1f820ca: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0a2e  1f820ce:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
0a32  1f820d2:	e9 b3 fa ff ff       	jmp    1f81b8a <cfi_chip_setup+0x4ea>
0a37  1f820d7:	48 89 df             	mov    %rbx,%rdi
0a3a  1f820da:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
0a3e  1f820de:	e8 00 00 00 00       	call   1f820e3 <cfi_chip_setup+0xa43>	1f820df: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0a43  1f820e3:	44 8b 4d d0          	mov    -0x30(%rbp),%r9d
0a47  1f820e7:	e9 c5 fc ff ff       	jmp    1f81db1 <cfi_chip_setup+0x711>
0a4c  1f820ec:	e8 00 00 00 00       	call   1f820f1 <cfi_chip_setup+0xa51>	1f820ed: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0a51  1f820f1:	e9 85 fc ff ff       	jmp    1f81d7b <cfi_chip_setup+0x6db>
0a56  1f820f6:	4c 89 ef             	mov    %r13,%rdi
0a59  1f820f9:	44 88 55 80          	mov    %r10b,-0x80(%rbp)
0a5d  1f820fd:	e8 00 00 00 00       	call   1f82102 <cfi_chip_setup+0xa62>	1f820fe: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
0a62  1f82102:	44 0f b6 55 80       	movzbl -0x80(%rbp),%r10d
0a67  1f82107:	e9 ae f7 ff ff       	jmp    1f818ba <cfi_chip_setup+0x21a>
0a6c  1f8210c:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
0a70  1f82110:	48 89 45 80          	mov    %rax,-0x80(%rbp)
0a74  1f82114:	e8 00 00 00 00       	call   1f82119 <cfi_chip_setup+0xa79>	1f82115: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0a79  1f82119:	48 8b 45 80          	mov    -0x80(%rbp),%rax
0a7d  1f8211d:	e9 fa f7 ff ff       	jmp    1f8191c <cfi_chip_setup+0x27c>
0a82  1f82122:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0a86  1f82126:	e8 00 00 00 00       	call   1f8212b <cfi_chip_setup+0xa8b>	1f82127: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0a8b  1f8212b:	e9 c2 f7 ff ff       	jmp    1f818f2 <cfi_chip_setup+0x252>
0a90  1f82130:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
0a94  1f82134:	e8 00 00 00 00       	call   1f82139 <cfi_chip_setup+0xa99>	1f82135: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0a99  1f82139:	e9 9c f7 ff ff       	jmp    1f818da <cfi_chip_setup+0x23a>
0a9e  1f8213e:	4c 89 cf             	mov    %r9,%rdi
0aa1  1f82141:	e8 00 00 00 00       	call   1f82146 <cfi_chip_setup+0xaa6>	1f82142: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0aa6  1f82146:	e9 fe fb ff ff       	jmp    1f81d49 <cfi_chip_setup+0x6a9>
0aab  1f8214b:	4c 89 ff             	mov    %r15,%rdi
0aae  1f8214e:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
0ab2  1f82152:	e8 00 00 00 00       	call   1f82157 <cfi_chip_setup+0xab7>	1f82153: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0ab7  1f82157:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
0abb  1f8215b:	e9 c4 fb ff ff       	jmp    1f81d24 <cfi_chip_setup+0x684>
0ac0  1f82160:	4c 89 f7             	mov    %r14,%rdi
0ac3  1f82163:	89 55 c8             	mov    %edx,-0x38(%rbp)
0ac6  1f82166:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
0aca  1f8216a:	e8 00 00 00 00       	call   1f8216f <cfi_chip_setup+0xacf>	1f8216b: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0acf  1f8216f:	8b 55 c8             	mov    -0x38(%rbp),%edx
0ad2  1f82172:	44 8b 4d d0          	mov    -0x30(%rbp),%r9d
0ad6  1f82176:	e9 82 fc ff ff       	jmp    1f81dfd <cfi_chip_setup+0x75d>
0adb  1f8217b:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
0adf  1f8217f:	44 89 4d d0          	mov    %r9d,-0x30(%rbp)
0ae3  1f82183:	e8 00 00 00 00       	call   1f82188 <cfi_chip_setup+0xae8>	1f82184: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0ae8  1f82188:	44 8b 4d d0          	mov    -0x30(%rbp),%r9d
0aec  1f8218c:	e9 4d fc ff ff       	jmp    1f81dde <cfi_chip_setup+0x73e>
0af1  1f82191:	4c 89 ff             	mov    %r15,%rdi
0af4  1f82194:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
0af8  1f82198:	e8 00 00 00 00       	call   1f8219d <cfi_chip_setup+0xafd>	1f82199: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0afd  1f8219d:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
0b01  1f821a1:	e9 b3 fc ff ff       	jmp    1f81e59 <cfi_chip_setup+0x7b9>
0b06  1f821a6:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0b0a  1f821aa:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
0b0e  1f821ae:	e8 00 00 00 00       	call   1f821b3 <cfi_chip_setup+0xb13>	1f821af: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b13  1f821b3:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0b17  1f821b7:	e9 32 fa ff ff       	jmp    1f81bee <cfi_chip_setup+0x54e>
0b1c  1f821bc:	be 02 00 00 00       	mov    $0x2,%esi
0b21  1f821c1:	e8 00 00 00 00       	call   1f821c6 <cfi_chip_setup+0xb26>	1f821c2: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
0b26  1f821c6:	e9 00 f8 ff ff       	jmp    1f819cb <cfi_chip_setup+0x32b>
0b2b  1f821cb:	e8 00 00 00 00       	call   1f821d0 <cfi_chip_setup+0xb30>	1f821cc: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
0b30  1f821d0:	e9 72 f6 ff ff       	jmp    1f81847 <cfi_chip_setup+0x1a7>
0b35  1f821d5:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
0b39  1f821d9:	e8 00 00 00 00       	call   1f821de <cfi_chip_setup+0xb3e>	1f821da: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b3e  1f821de:	e9 84 f7 ff ff       	jmp    1f81967 <cfi_chip_setup+0x2c7>
0b43  1f821e3:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0b47  1f821e7:	e8 00 00 00 00       	call   1f821ec <cfi_chip_setup+0xb4c>	1f821e8: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b4c  1f821ec:	e9 51 f5 ff ff       	jmp    1f81742 <cfi_chip_setup+0xa2>
0b51  1f821f1:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0b55  1f821f5:	e8 00 00 00 00       	call   1f821fa <cfi_chip_setup+0xb5a>	1f821f6: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b5a  1f821fa:	e9 5a f9 ff ff       	jmp    1f81b59 <cfi_chip_setup+0x4b9>
0b5f  1f821ff:	48 89 cf             	mov    %rcx,%rdi
0b62  1f82202:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
0b66  1f82206:	e8 00 00 00 00       	call   1f8220b <cfi_chip_setup+0xb6b>	1f82207: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
0b6b  1f8220b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
0b6f  1f8220f:	e9 cb f5 ff ff       	jmp    1f817df <cfi_chip_setup+0x13f>
0b74  1f82214:	4c 89 cf             	mov    %r9,%rdi
0b77  1f82217:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
0b7b  1f8221b:	e8 00 00 00 00       	call   1f82220 <cfi_chip_setup+0xb80>	1f8221c: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b80  1f82220:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0b84  1f82224:	e9 6f fa ff ff       	jmp    1f81c98 <cfi_chip_setup+0x5f8>
0b89  1f82229:	4c 89 ff             	mov    %r15,%rdi
0b8c  1f8222c:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
0b90  1f82230:	e8 00 00 00 00       	call   1f82235 <cfi_chip_setup+0xb95>	1f82231: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
0b95  1f82235:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
0b99  1f82239:	e9 9f fd ff ff       	jmp    1f81fdd <cfi_chip_setup+0x93d>
0b9e  1f8223e:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
0ba2  1f82242:	e8 00 00 00 00       	call   1f82247 <cfi_chip_setup+0xba7>	1f82243: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0ba7  1f82247:	4c 8b 4d c8          	mov    -0x38(%rbp),%r9
0bab  1f8224b:	e9 44 fd ff ff       	jmp    1f81f94 <cfi_chip_setup+0x8f4>
0bb0  1f82250:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0bb4  1f82254:	89 75 b0             	mov    %esi,-0x50(%rbp)
0bb7  1f82257:	4c 89 4d c8          	mov    %r9,-0x38(%rbp)
0bbb  1f8225b:	e8 00 00 00 00       	call   1f82260 <cfi_chip_setup+0xbc0>	1f8225c: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0bc0  1f82260:	8b 75 b0             	mov    -0x50(%rbp),%esi
0bc3  1f82263:	4c 8b 4d c8          	mov    -0x38(%rbp),%r9
0bc7  1f82267:	e9 ef fc ff ff       	jmp    1f81f5b <cfi_chip_setup+0x8bb>
0bcc  1f8226c:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
0bd0  1f82270:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
0bd4  1f82274:	e8 00 00 00 00       	call   1f82279 <cfi_chip_setup+0xbd9>	1f82275: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0bd9  1f82279:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
0bdd  1f8227d:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0be1  1f82281:	e9 8a fc ff ff       	jmp    1f81f10 <cfi_chip_setup+0x870>
0be6  1f82286:	48 8b 7d 98          	mov    -0x68(%rbp),%rdi
0bea  1f8228a:	4c 89 4d c0          	mov    %r9,-0x40(%rbp)
0bee  1f8228e:	e8 00 00 00 00       	call   1f82293 <cfi_chip_setup+0xbf3>	1f8228f: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0bf3  1f82293:	4c 8b 4d c0          	mov    -0x40(%rbp),%r9
0bf7  1f82297:	e9 3a fc ff ff       	jmp    1f81ed6 <cfi_chip_setup+0x836>
0bfc  1f8229c:	0f 1f 40 00          	nopl   0x0(%rax)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
