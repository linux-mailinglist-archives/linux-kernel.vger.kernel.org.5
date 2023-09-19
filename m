Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41267A6842
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjISPlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjISPk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:40:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE3C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695138052; x=1726674052;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CFmL6XWZQBKQRwOfFu657L7VxNhRxEfMe8riYW/OQEg=;
  b=RrzkvhFVW3zpQLx6c5pO0y9eDUalDtlflMRMMqeguEuxv8Hpn+MoXcrK
   n1ekfncTsCuZkeMTG7xVswL6pMo6MkXXlxZkla9uqdXLlCGLufbPp7HAo
   lMn+QzabQerwSpZDKIZqS53ANzC+Z4b/B9iYg1FiYP5O7snNIlLuVaC3X
   xPc1up91E4ey1tOZQZGcQjiWHF+t74I+MLcnBmqV5IGAPJUUFBWRga40j
   EvZHuQBUqiPOGvSrxd16xYP0XG/cCnUZ8FogygvgZs1Wt9HDtdbsNG/mu
   BQcJXnA9o2pRUDpxjksK3arj+kX6s1mBvB5Hz0MQt18zlOsPcCRrmqvss
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="378868991"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="378868991"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 08:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="889543789"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="889543789"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2023 08:39:38 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qicpq-0007ZP-2l;
        Tue, 19 Sep 2023 15:40:22 +0000
Date:   Tue, 19 Sep 2023 23:40:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: vmlinux.o: warning: objtool: cfi_staa_resume+0x169: cfi_build_cmd()
 is missing a __noreturn annotation
Message-ID: <202309192309.adQMUolr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: 719a937b7003933de1298ffa4b881dd6a234e244 iov_iter: Mark copy_iovec_from_user() noclone
date:   2 months ago
config: x86_64-randconfig-a013-20220829 (https://download.01.org/0day-ci/archive/20230919/202309192309.adQMUolr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309192309.adQMUolr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309192309.adQMUolr-lkp@intel.com/

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
0000 000000000220e220 <cfi_staa_resume>:
0000  220e220:	f3 0f 1e fa          	endbr64
0004  220e224:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
000e  220e22e:	41 57                	push   %r15
0010  220e230:	41 56                	push   %r14
0012  220e232:	41 55                	push   %r13
0014  220e234:	41 54                	push   %r12
0016  220e236:	55                   	push   %rbp
0017  220e237:	53                   	push   %rbx
0018  220e238:	48 89 fb             	mov    %rdi,%rbx
001b  220e23b:	48 81 c7 90 01 00 00 	add    $0x190,%rdi
0022  220e242:	48 89 fa             	mov    %rdi,%rdx
0025  220e245:	48 c1 ea 03          	shr    $0x3,%rdx
0029  220e249:	48 83 ec 30          	sub    $0x30,%rsp
002d  220e24d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0031  220e251:	0f 85 f1 01 00 00    	jne    220e448 <cfi_staa_resume+0x228>
0037  220e257:	48 8b 83 90 01 00 00 	mov    0x190(%rbx),%rax
003e  220e25e:	48 8d 78 60          	lea    0x60(%rax),%rdi
0042  220e262:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
0047  220e267:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0051  220e271:	48 89 fa             	mov    %rdi,%rdx
0054  220e274:	48 c1 ea 03          	shr    $0x3,%rdx
0058  220e278:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
005c  220e27c:	0f 85 bc 01 00 00    	jne    220e43e <cfi_staa_resume+0x21e>
0062  220e282:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
0067  220e287:	4c 8b 78 60          	mov    0x60(%rax),%r15
006b  220e28b:	49 8d 47 40          	lea    0x40(%r15),%rax
006f  220e28f:	48 89 c2             	mov    %rax,%rdx
0072  220e292:	48 89 04 24          	mov    %rax,(%rsp)
0076  220e296:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0080  220e2a0:	48 c1 ea 03          	shr    $0x3,%rdx
0084  220e2a4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0088  220e2a8:	84 c0                	test   %al,%al
008a  220e2aa:	74 08                	je     220e2b4 <cfi_staa_resume+0x94>
008c  220e2ac:	3c 03                	cmp    $0x3,%al
008e  220e2ae:	0f 8e 57 01 00 00    	jle    220e40b <cfi_staa_resume+0x1eb>
0094  220e2b4:	41 8b 47 40          	mov    0x40(%r15),%eax
0098  220e2b8:	31 db                	xor    %ebx,%ebx
009a  220e2ba:	85 c0                	test   %eax,%eax
009c  220e2bc:	0f 8e 3a 01 00 00    	jle    220e3fc <cfi_staa_resume+0x1dc>
00a2  220e2c2:	49 bc 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%r12
00ac  220e2cc:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
00b1  220e2d1:	48 83 c0 18          	add    $0x18,%rax
00b5  220e2d5:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
00ba  220e2da:	48 c1 e8 03          	shr    $0x3,%rax
00be  220e2de:	4c 01 e0             	add    %r12,%rax
00c1  220e2e1:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
00c6  220e2e6:	eb 2e                	jmp    220e316 <cfi_staa_resume+0xf6>
00c8  220e2e8:	48 89 ef             	mov    %rbp,%rdi
00cb  220e2eb:	83 c3 01             	add    $0x1,%ebx
00ce  220e2ee:	e8 00 00 00 00       	call   220e2f3 <cfi_staa_resume+0xd3>	220e2ef: R_X86_64_PLT32	mutex_unlock-0x4
00d3  220e2f3:	48 8b 04 24          	mov    (%rsp),%rax
00d7  220e2f7:	48 c1 e8 03          	shr    $0x3,%rax
00db  220e2fb:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax
00e0  220e300:	84 c0                	test   %al,%al
00e2  220e302:	74 08                	je     220e30c <cfi_staa_resume+0xec>
00e4  220e304:	3c 03                	cmp    $0x3,%al
00e6  220e306:	0f 8e 0d 01 00 00    	jle    220e419 <cfi_staa_resume+0x1f9>
00ec  220e30c:	41 39 5f 40          	cmp    %ebx,0x40(%r15)
00f0  220e310:	0f 8e e6 00 00 00    	jle    220e3fc <cfi_staa_resume+0x1dc>
00f6  220e316:	4c 63 eb             	movslq %ebx,%r13
00f9  220e319:	31 f6                	xor    %esi,%esi
00fb  220e31b:	4f 8d 44 ad 00       	lea    0x0(%r13,%r13,4),%r8
0100  220e320:	49 c1 e0 06          	shl    $0x6,%r8
0104  220e324:	4b 8d ac 07 90 00 00 00 	lea    0x90(%r15,%r8,1),%rbp
010c  220e32c:	4d 89 c6             	mov    %r8,%r14
010f  220e32f:	48 89 ef             	mov    %rbp,%rdi
0112  220e332:	e8 00 00 00 00       	call   220e337 <cfi_staa_resume+0x117>	220e333: R_X86_64_PLT32	mutex_lock_nested-0x4
0117  220e337:	4f 8d 54 37 74       	lea    0x74(%r15,%r14,1),%r10
011c  220e33c:	4c 89 d0             	mov    %r10,%rax
011f  220e33f:	48 c1 e8 03          	shr    $0x3,%rax
0123  220e343:	42 0f b6 14 20       	movzbl (%rax,%r12,1),%edx
0128  220e348:	4c 89 d0             	mov    %r10,%rax
012b  220e34b:	83 e0 07             	and    $0x7,%eax
012e  220e34e:	83 c0 03             	add    $0x3,%eax
0131  220e351:	38 d0                	cmp    %dl,%al
0133  220e353:	7c 08                	jl     220e35d <cfi_staa_resume+0x13d>
0135  220e355:	84 d2                	test   %dl,%dl
0137  220e357:	0f 85 ca 00 00 00    	jne    220e427 <cfi_staa_resume+0x207>
013d  220e35d:	4b 8d 44 ad 00       	lea    0x0(%r13,%r13,4),%rax
0142  220e362:	48 c1 e0 06          	shl    $0x6,%rax
0146  220e366:	41 83 7c 07 74 0c    	cmpl   $0xc,0x74(%r15,%rax,1)
014c  220e36c:	0f 85 76 ff ff ff    	jne    220e2e8 <cfi_staa_resume+0xc8>
0152  220e372:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
0157  220e377:	4c 89 fa             	mov    %r15,%rdx
015a  220e37a:	bf ff 00 00 00       	mov    $0xff,%edi
015f  220e37f:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
0164  220e384:	e8 00 00 00 00       	call   220e389 <cfi_staa_resume+0x169>	220e385: R_X86_64_PLT32	cfi_build_cmd-0x4
0169  220e389:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
016e  220e38e:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
0173  220e393:	80 39 00             	cmpb   $0x0,(%rcx)
0176  220e396:	0f 85 c3 00 00 00    	jne    220e45f <cfi_staa_resume+0x23f>
017c  220e39c:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
0181  220e3a1:	48 8b 51 18          	mov    0x18(%rcx),%rdx
0185  220e3a5:	48 89 02             	mov    %rax,(%rdx)
0188  220e3a8:	0f ae f0             	mfence
018b  220e3ab:	4c 89 d0             	mov    %r10,%rax
018e  220e3ae:	48 c1 e8 03          	shr    $0x3,%rax
0192  220e3b2:	42 0f b6 14 20       	movzbl (%rax,%r12,1),%edx
0197  220e3b7:	4c 89 d0             	mov    %r10,%rax
019a  220e3ba:	83 e0 07             	and    $0x7,%eax
019d  220e3bd:	83 c0 03             	add    $0x3,%eax
01a0  220e3c0:	38 d0                	cmp    %dl,%al
01a2  220e3c2:	7c 08                	jl     220e3cc <cfi_staa_resume+0x1ac>
01a4  220e3c4:	84 d2                	test   %dl,%dl
01a6  220e3c6:	0f 85 86 00 00 00    	jne    220e452 <cfi_staa_resume+0x232>
01ac  220e3cc:	4b 8d 44 ad 00       	lea    0x0(%r13,%r13,4),%rax
01b1  220e3d1:	4b 8d bc 37 30 01 00 00 	lea    0x130(%r15,%r14,1),%rdi
01b9  220e3d9:	31 c9                	xor    %ecx,%ecx
01bb  220e3db:	ba 01 00 00 00       	mov    $0x1,%edx
01c0  220e3e0:	48 c1 e0 06          	shl    $0x6,%rax
01c4  220e3e4:	be 03 00 00 00       	mov    $0x3,%esi
01c9  220e3e9:	41 c7 44 07 74 00 00 00 00 	movl   $0x0,0x74(%r15,%rax,1)
01d2  220e3f2:	e8 00 00 00 00       	call   220e3f7 <cfi_staa_resume+0x1d7>	220e3f3: R_X86_64_PLT32	__wake_up-0x4
01d7  220e3f7:	e9 ec fe ff ff       	jmp    220e2e8 <cfi_staa_resume+0xc8>
01dc  220e3fc:	48 83 c4 30          	add    $0x30,%rsp
01e0  220e400:	5b                   	pop    %rbx
01e1  220e401:	5d                   	pop    %rbp
01e2  220e402:	41 5c                	pop    %r12
01e4  220e404:	41 5d                	pop    %r13
01e6  220e406:	41 5e                	pop    %r14
01e8  220e408:	41 5f                	pop    %r15
01ea  220e40a:	c3                   	ret
01eb  220e40b:	48 8b 3c 24          	mov    (%rsp),%rdi
01ef  220e40f:	e8 00 00 00 00       	call   220e414 <cfi_staa_resume+0x1f4>	220e410: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
01f4  220e414:	e9 9b fe ff ff       	jmp    220e2b4 <cfi_staa_resume+0x94>
01f9  220e419:	48 8b 3c 24          	mov    (%rsp),%rdi
01fd  220e41d:	e8 00 00 00 00       	call   220e422 <cfi_staa_resume+0x202>	220e41e: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0202  220e422:	e9 e5 fe ff ff       	jmp    220e30c <cfi_staa_resume+0xec>
0207  220e427:	4c 89 d7             	mov    %r10,%rdi
020a  220e42a:	4c 89 54 24 10       	mov    %r10,0x10(%rsp)
020f  220e42f:	e8 00 00 00 00       	call   220e434 <cfi_staa_resume+0x214>	220e430: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0214  220e434:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
0219  220e439:	e9 1f ff ff ff       	jmp    220e35d <cfi_staa_resume+0x13d>
021e  220e43e:	e8 00 00 00 00       	call   220e443 <cfi_staa_resume+0x223>	220e43f: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0223  220e443:	e9 3a fe ff ff       	jmp    220e282 <cfi_staa_resume+0x62>
0228  220e448:	e8 00 00 00 00       	call   220e44d <cfi_staa_resume+0x22d>	220e449: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
022d  220e44d:	e9 05 fe ff ff       	jmp    220e257 <cfi_staa_resume+0x37>
0232  220e452:	4c 89 d7             	mov    %r10,%rdi
0235  220e455:	e8 00 00 00 00       	call   220e45a <cfi_staa_resume+0x23a>	220e456: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
023a  220e45a:	e9 6d ff ff ff       	jmp    220e3cc <cfi_staa_resume+0x1ac>
023f  220e45f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
0244  220e464:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
0249  220e469:	e8 00 00 00 00       	call   220e46e <cfi_staa_resume+0x24e>	220e46a: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
024e  220e46e:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
0253  220e473:	4c 8b 54 24 10       	mov    0x10(%rsp),%r10
0258  220e478:	e9 1f ff ff ff       	jmp    220e39c <cfi_staa_resume+0x17c>
025d  220e47d:	0f 1f 00             	nopl   (%rax)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
