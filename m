Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5B17E0D99
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbjKDDoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjKDDoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:44:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29719112
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699069454; x=1730605454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qHGfTpzVJu5gEGybckTvVqRdk6b8e0Pm4EH3TTazn34=;
  b=bqkqHdoTcnuW20wGsK7pabJBw6sQW+1jIvnV9EsOypsnR+LTeYnaUDbf
   opxF0EmDqC4JM/iJxRCkhVdQpy53YYQhuoCwAXvvEZPU/JW1T7aCoYJGs
   updauzCsszTv4lsyzo7EySHppaSaMS/A4qWR6T95CttnFa6tPxlcAHMGc
   /qwD1JMlgtR74DNb0d8tbD1UgpqZzimCggFjg76oQ/YoiD7RChu1FVDLo
   nVPI6vAfxkG7y451T3tpPNg5qJ6VlFYw3Ev+f5wxTfUVjlaG9sFw253Gw
   d76x60bNYgumTHfDRyFDUoBuMGcXlYHJaVnNzb6YQPvKRI6JEpEe98TfU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="475293247"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="475293247"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 20:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1093263361"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="1093263361"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Nov 2023 20:44:12 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz7Zy-0003Mn-0n;
        Sat, 04 Nov 2023 03:44:10 +0000
Date:   Sat, 4 Nov 2023 11:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: enter_s2idle_proper+0xd5: call to
 lockdep_hardirqs_on_prepare() leaves .noinstr.text section
Message-ID: <202311041100.vPZ8sSuW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
commit: 17cc2b5525856d7374f09b28ba1faf1fa61b2352 cpuidle: Ensure ct_cpuidle_enter() is always called from noinstr/__cpuidle
date:   10 months ago
config: x86_64-buildonly-randconfig-001-20231104 (https://download.01.org/0day-ci/archive/20231104/202311041100.vPZ8sSuW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041100.vPZ8sSuW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041100.vPZ8sSuW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: enter_s2idle_proper+0xd5: call to lockdep_hardirqs_on_prepare() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: cpuidle_enter_state+0x317: call to lockdep_hardirqs_on_prepare() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter_bm+0x40: call to lockdep_hardirqs_on_prepare() leaves .noinstr.text section


objdump-func vmlinux.o enter_s2idle_proper:
0000 00000000000022f0 <enter_s2idle_proper>:
0000     22f0:	41 56                	push   %r14
0002     22f2:	41 55                	push   %r13
0004     22f4:	41 54                	push   %r12
0006     22f6:	49 89 fc             	mov    %rdi,%r12
0009     22f9:	55                   	push   %rbp
000a     22fa:	48 89 f5             	mov    %rsi,%rbp
000d     22fd:	53                   	push   %rbx
000e     22fe:	48 63 da             	movslq %edx,%rbx
0011     2301:	49 89 dd             	mov    %rbx,%r13
0014     2304:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	2305: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0019     2309:	90                   	nop
001a     230a:	e8 00 00 00 00       	call   230f <enter_s2idle_proper+0x1f>	230b: R_X86_64_PC32	.text+0x120b43c
001f     230f:	48 89 c7             	mov    %rax,%rdi
0022     2312:	e8 00 00 00 00       	call   2317 <enter_s2idle_proper+0x27>	2313: R_X86_64_PC32	.text+0x120b2cc
0027     2317:	49 89 c6             	mov    %rax,%r14
002a     231a:	e8 00 00 00 00       	call   231f <enter_s2idle_proper+0x2f>	231b: R_X86_64_PLT32	tick_freeze-0x4
002f     231f:	48 8d 04 5b          	lea    (%rbx,%rbx,2),%rax
0033     2323:	48 8d 04 83          	lea    (%rbx,%rax,4),%rax
0037     2327:	41 f6 44 c4 58 40    	testb  $0x40,0x58(%r12,%rax,8)
003d     232d:	0f 84 87 00 00 00    	je     23ba <enter_s2idle_proper+0xca>
0043     2333:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	2334: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0048     2338:	48 8d 04 5b          	lea    (%rbx,%rbx,2),%rax
004c     233c:	44 89 ea             	mov    %r13d,%edx
004f     233f:	4c 89 e6             	mov    %r12,%rsi
0052     2342:	48 8d 04 83          	lea    (%rbx,%rax,4),%rax
0056     2346:	48 89 ef             	mov    %rbp,%rdi
0059     2349:	41 ff 54 c4 78       	call   *0x78(%r12,%rax,8)
005e     234e:	9c                   	pushf
005f     234f:	58                   	pop    %rax
0060     2350:	f6 c4 02             	test   $0x2,%ah
0063     2353:	0f 85 8f 00 00 00    	jne    23e8 <enter_s2idle_proper+0xf8>
0069     2359:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	235a: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
006e     235e:	48 8d 04 5b          	lea    (%rbx,%rbx,2),%rax
0072     2362:	48 8d 04 83          	lea    (%rbx,%rax,4),%rax
0076     2366:	41 f6 44 c4 58 40    	testb  $0x40,0x58(%r12,%rax,8)
007c     236c:	74 67                	je     23d5 <enter_s2idle_proper+0xe5>
007e     236e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	236f: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
0083     2373:	48 c1 e3 06          	shl    $0x6,%rbx
0087     2377:	e8 00 00 00 00       	call   237c <enter_s2idle_proper+0x8c>	2378: R_X86_64_PLT32	tick_unfreeze-0x4
008c     237c:	e8 00 00 00 00       	call   2381 <enter_s2idle_proper+0x91>	237d: R_X86_64_PC32	.text+0x120b43c
0091     2381:	48 89 c7             	mov    %rax,%rdi
0094     2384:	e8 00 00 00 00       	call   2389 <enter_s2idle_proper+0x99>	2385: R_X86_64_PC32	.text+0x120b2cc
0099     2389:	4c 89 f6             	mov    %r14,%rsi
009c     238c:	48 89 c7             	mov    %rax,%rdi
009f     238f:	e8 00 00 00 00       	call   2394 <enter_s2idle_proper+0xa4>	2390: R_X86_64_PC32	.text+0x120b27c
00a4     2394:	49 89 c0             	mov    %rax,%r8
00a7     2397:	48 8d 44 1d 00       	lea    0x0(%rbp,%rbx,1),%rax
00ac     239c:	4c 01 40 68          	add    %r8,0x68(%rax)
00b0     23a0:	48 83 40 60 01       	addq   $0x1,0x60(%rax)
00b5     23a5:	90                   	nop
00b6     23a6:	5b                   	pop    %rbx
00b7     23a7:	5d                   	pop    %rbp
00b8     23a8:	41 5c                	pop    %r12
00ba     23aa:	41 5d                	pop    %r13
00bc     23ac:	41 5e                	pop    %r14
00be     23ae:	31 c0                	xor    %eax,%eax
00c0     23b0:	31 d2                	xor    %edx,%edx
00c2     23b2:	31 f6                	xor    %esi,%esi
00c4     23b4:	31 ff                	xor    %edi,%edi
00c6     23b6:	45 31 c0             	xor    %r8d,%r8d
00c9     23b9:	c3                   	ret
00ca     23ba:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	23bb: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00cf     23bf:	e8 00 00 00 00       	call   23c4 <enter_s2idle_proper+0xd4>	23c0: R_X86_64_PC32	.text+0x120b25c
00d4     23c4:	90                   	nop
00d5     23c5:	e8 00 00 00 00       	call   23ca <enter_s2idle_proper+0xda>	23c6: R_X86_64_PC32	.text+0x120b25c
00da     23ca:	e8 00 00 00 00       	call   23cf <enter_s2idle_proper+0xdf>	23cb: R_X86_64_PC32	.text+0x120b65c
00df     23cf:	90                   	nop
00e0     23d0:	e9 5e ff ff ff       	jmp    2333 <enter_s2idle_proper+0x43>
00e5     23d5:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	23d6: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00ea     23da:	90                   	nop
00eb     23db:	e8 00 00 00 00       	call   23e0 <enter_s2idle_proper+0xf0>	23dc: R_X86_64_PC32	.text+0x120b65c
00f0     23e0:	e8 00 00 00 00       	call   23e5 <enter_s2idle_proper+0xf5>	23e1: R_X86_64_PC32	.text+0x120b25c
00f5     23e5:	90                   	nop
00f6     23e6:	eb 86                	jmp    236e <enter_s2idle_proper+0x7e>
00f8     23e8:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)	23e9: R_X86_64_NONE	__sanitizer_cov_trace_pc-0x4
00fd     23ed:	fa                   	cli
00fe     23ee:	e9 66 ff ff ff       	jmp    2359 <enter_s2idle_proper+0x69>
0103     23f3:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
010e     23fe:	66 90                	xchg   %ax,%ax

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
