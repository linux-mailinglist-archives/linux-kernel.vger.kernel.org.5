Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CB9761911
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjGYM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGYM6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:58:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13FA18D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690289894; x=1721825894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=stnh+wmjA6O9FykdrAKagdvaN25UsFr22hBgPFoFqfM=;
  b=S3ZT9PCFR0zzl86z+9jQo0DGNPFyge8k9r1CCfHi8wqbAszXtRBe2mQQ
   iEMGtFvcpLxBNpZv6Z7n/rcLR6SCRwWm1k3difFYy8nRJNGaGbXktmp73
   b+/LebRUsADZTteeAQ+/LnvAghcdpZsIvLzYiMx8NSzYuz3v0kE2O8uqh
   pB3tq166tWJaPG81VyQvJ/c7zLfCDbWLdvwaxrJwfywF8bUOHFrvZiIa/
   /4wd6XH1py16gngkXHzp/I36yyd/xhUy3uenG7J0JqbXS74i7OPOJ34wU
   t3WnyqWyebUPcn8L9opYKRSn6VFB/BJTuuZcmiKFpqgzLjM2lzFOr75Uv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="431513784"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431513784"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 05:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="720056708"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="720056708"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2023 05:58:12 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOHcB-000Aci-33;
        Tue, 25 Jul 2023 12:58:11 +0000
Date:   Tue, 25 Jul 2023 20:57:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: cpuidle_enter_state+0x1d3: return with
 instrumentation enabled
Message-ID: <202307252003.0OM6CkWI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
commit: 17cc2b5525856d7374f09b28ba1faf1fa61b2352 cpuidle: Ensure ct_cpuidle_enter() is always called from noinstr/__cpuidle
date:   6 months ago
config: x86_64-randconfig-r012-20230725 (https://download.01.org/0day-ci/archive/20230725/202307252003.0OM6CkWI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307252003.0OM6CkWI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307252003.0OM6CkWI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __asan_memset+0x34: call to __memset() with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_memmove+0x4c: call to __memmove() with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_memcpy+0x4c: call to __memcpy() with UACCESS enabled
>> vmlinux.o: warning: objtool: cpuidle_enter_state+0x1d3: return with instrumentation enabled
   vmlinux.o: warning: objtool: intel_idle_ibrs+0x17: call to sched_smt_active() leaves .noinstr.text section


objdump-func vmlinux.o cpuidle_enter_state:
0000 0000000000002ee0 <cpuidle_enter_state>:
0000     2ee0:	f3 0f 1e fa          	endbr64
0004     2ee4:	55                   	push   %rbp
0005     2ee5:	48 89 e5             	mov    %rsp,%rbp
0008     2ee8:	41 57                	push   %r15
000a     2eea:	41 56                	push   %r14
000c     2eec:	41 55                	push   %r13
000e     2eee:	41 54                	push   %r12
0010     2ef0:	53                   	push   %rbx
0011     2ef1:	48 83 ec 28          	sub    $0x28,%rsp
0015     2ef5:	48 89 fb             	mov    %rdi,%rbx
0018     2ef8:	49 89 f4             	mov    %rsi,%r12
001b     2efb:	4c 63 ea             	movslq %edx,%r13
001e     2efe:	4d 89 ee             	mov    %r13,%r14
0021     2f01:	49 83 fd 0a          	cmp    $0xa,%r13
0025     2f05:	0f 87 b0 03 00 00    	ja     32bb <cpuidle_enter_state+0x3db>
002b     2f0b:	4b 8d 44 6d 00       	lea    0x0(%r13,%r13,2),%rax
0030     2f10:	49 8d 44 85 00       	lea    0x0(%r13,%rax,4),%rax
0035     2f15:	48 c1 e0 03          	shl    $0x3,%rax
0039     2f19:	4d 8d 7c 04 18       	lea    0x18(%r12,%rax,1),%r15
003e     2f1e:	90                   	nop
003f     2f1f:	49 8d 14 04          	lea    (%r12,%rax,1),%rdx
0043     2f23:	41 f6 44 04 58 04    	testb  $0x4,0x58(%r12,%rax,1)
0049     2f29:	0f 85 77 02 00 00    	jne    31a6 <cpuidle_enter_state+0x2c6>
004f     2f2f:	c6 45 d0 00          	movb   $0x0,-0x30(%rbp)
0053     2f33:	41 f6 47 40 20       	testb  $0x20,0x40(%r15)
0058     2f38:	0f 85 88 02 00 00    	jne    31c6 <cpuidle_enter_state+0x2e6>
005e     2f3e:	4c 89 ff             	mov    %r15,%rdi
0061     2f41:	e8 00 00 00 00       	call   2f46 <cpuidle_enter_state+0x66>	2f42: R_X86_64_PLT32	sched_idle_set_state-0x4
0066     2f46:	8b 73 04             	mov    0x4(%rbx),%esi
0069     2f49:	44 89 f7             	mov    %r14d,%edi
006c     2f4c:	e8 00 00 00 00       	call   2f51 <cpuidle_enter_state+0x71>	2f4d: R_X86_64_PC32	.text+0x11d6adc
0071     2f51:	e8 00 00 00 00       	call   2f56 <cpuidle_enter_state+0x76>	2f52: R_X86_64_PC32	.text+0x11d6acc
0076     2f56:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
007a     2f5a:	e8 00 00 00 00       	call   2f5f <cpuidle_enter_state+0x7f>	2f5b: R_X86_64_PLT32	stop_critical_timings-0x4
007f     2f5f:	41 f6 47 40 40       	testb  $0x40,0x40(%r15)
0084     2f64:	0f 84 4b 01 00 00    	je     30b5 <cpuidle_enter_state+0x1d5>
008a     2f6a:	44 89 f2             	mov    %r14d,%edx
008d     2f6d:	4c 89 e6             	mov    %r12,%rsi
0090     2f70:	48 89 df             	mov    %rbx,%rdi
0093     2f73:	41 ff 57 50          	call   *0x50(%r15)
0097     2f77:	41 89 c6             	mov    %eax,%r14d
009a     2f7a:	9c                   	pushf
009b     2f7b:	58                   	pop    %rax
009c     2f7c:	f6 c4 02             	test   $0x2,%ah
009f     2f7f:	0f 85 f1 02 00 00    	jne    3276 <cpuidle_enter_state+0x396>
00a5     2f85:	41 f6 47 40 40       	testb  $0x40,0x40(%r15)
00aa     2f8a:	0f 84 65 02 00 00    	je     31f5 <cpuidle_enter_state+0x315>
00b0     2f90:	e8 00 00 00 00       	call   2f95 <cpuidle_enter_state+0xb5>	2f91: R_X86_64_PLT32	start_critical_timings-0x4
00b5     2f95:	e8 00 00 00 00       	call   2f9a <cpuidle_enter_state+0xba>	2f96: R_X86_64_PLT32	sched_clock_idle_wakeup_event-0x4
00ba     2f9a:	e8 00 00 00 00       	call   2f9f <cpuidle_enter_state+0xbf>	2f9b: R_X86_64_PC32	.text+0x11d6acc
00bf     2f9f:	49 89 c7             	mov    %rax,%r15
00c2     2fa2:	8b 73 04             	mov    0x4(%rbx),%esi
00c5     2fa5:	bf ff ff ff ff       	mov    $0xffffffff,%edi
00ca     2faa:	e8 00 00 00 00       	call   2faf <cpuidle_enter_state+0xcf>	2fab: R_X86_64_PC32	.text+0x11d6adc
00cf     2faf:	31 ff                	xor    %edi,%edi
00d1     2fb1:	e8 00 00 00 00       	call   2fb6 <cpuidle_enter_state+0xd6>	2fb2: R_X86_64_PLT32	sched_idle_set_state-0x4
00d6     2fb6:	80 7d d0 00          	cmpb   $0x0,-0x30(%rbp)
00da     2fba:	0f 85 25 02 00 00    	jne    31e5 <cpuidle_enter_state+0x305>
00e0     2fc0:	e8 00 00 00 00       	call   2fc5 <cpuidle_enter_state+0xe5>	2fc1: R_X86_64_PC32	.text+0x11d700c
00e5     2fc5:	84 c0                	test   %al,%al
00e7     2fc7:	0f 84 06 02 00 00    	je     31d3 <cpuidle_enter_state+0x2f3>
00ed     2fcd:	45 85 f6             	test   %r14d,%r14d
00f0     2fd0:	0f 88 aa 01 00 00    	js     3180 <cpuidle_enter_state+0x2a0>
00f6     2fd6:	49 63 d6             	movslq %r14d,%rdx
00f9     2fd9:	48 83 fa 09          	cmp    $0x9,%rdx
00fd     2fdd:	0f 87 74 03 00 00    	ja     3357 <cpuidle_enter_state+0x477>
0103     2fe3:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
0107     2fe7:	48 8d 04 82          	lea    (%rdx,%rax,4),%rax
010b     2feb:	4d 8b 6c c4 48       	mov    0x48(%r12,%rax,8),%r13
0110     2ff0:	4c 89 ff             	mov    %r15,%rdi
0113     2ff3:	e8 00 00 00 00       	call   2ff8 <cpuidle_enter_state+0x118>	2ff4: R_X86_64_PC32	.text+0x11d6a8c
0118     2ff8:	49 89 c7             	mov    %rax,%r15
011b     2ffb:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
011f     2fff:	e8 00 00 00 00       	call   3004 <cpuidle_enter_state+0x124>	3000: R_X86_64_PC32	.text+0x11d6a8c
0124     3004:	49 29 c7             	sub    %rax,%r15
0127     3007:	4c 89 7b 18          	mov    %r15,0x18(%rbx)
012b     300b:	48 83 fa 09          	cmp    $0x9,%rdx
012f     300f:	0f 87 e6 02 00 00    	ja     32fb <cpuidle_enter_state+0x41b>
0135     3015:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
0139     3019:	48 c1 e0 04          	shl    $0x4,%rax
013d     301d:	48 8b 4c 03 40       	mov    0x40(%rbx,%rax,1),%rcx
0142     3022:	48 83 fa 09          	cmp    $0x9,%rdx
0146     3026:	0f 87 eb 02 00 00    	ja     3317 <cpuidle_enter_state+0x437>
014c     302c:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
0150     3030:	48 c1 e0 04          	shl    $0x4,%rax
0154     3034:	4c 01 f9             	add    %r15,%rcx
0157     3037:	48 89 4c 03 40       	mov    %rcx,0x40(%rbx,%rax,1)
015c     303c:	48 83 fa 09          	cmp    $0x9,%rdx
0160     3040:	0f 87 99 02 00 00    	ja     32df <cpuidle_enter_state+0x3ff>
0166     3046:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
016a     304a:	48 c1 e0 04          	shl    $0x4,%rax
016e     304e:	48 83 44 03 38 01    	addq   $0x1,0x38(%rbx,%rax,1)
0174     3054:	48 83 fa 09          	cmp    $0x9,%rdx
0178     3058:	0f 87 15 03 00 00    	ja     3373 <cpuidle_enter_state+0x493>
017e     305e:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
0182     3062:	48 8d 04 82          	lea    (%rdx,%rax,4),%rax
0186     3066:	4d 39 7c c4 50       	cmp    %r15,0x50(%r12,%rax,8)
018b     306b:	0f 8e 89 00 00 00    	jle    30fa <cpuidle_enter_state+0x21a>
0191     3071:	45 8d 6e ff          	lea    -0x1(%r14),%r13d
0195     3075:	45 85 f6             	test   %r14d,%r14d
0198     3078:	74 27                	je     30a1 <cpuidle_enter_state+0x1c1>
019a     307a:	4d 63 e5             	movslq %r13d,%r12
019d     307d:	49 83 fc 09          	cmp    $0x9,%r12
01a1     3081:	0f 87 b4 02 00 00    	ja     333b <cpuidle_enter_state+0x45b>
01a7     3087:	4b 8d 44 64 03       	lea    0x3(%r12,%r12,2),%rax
01ac     308c:	48 c1 e0 04          	shl    $0x4,%rax
01b0     3090:	48 83 3c 03 00       	cmpq   $0x0,(%rbx,%rax,1)
01b5     3095:	0f 84 6f 01 00 00    	je     320a <cpuidle_enter_state+0x32a>
01bb     309b:	41 83 ed 01          	sub    $0x1,%r13d
01bf     309f:	73 d9                	jae    307a <cpuidle_enter_state+0x19a>
01c1     30a1:	90                   	nop
01c2     30a2:	44 89 f0             	mov    %r14d,%eax
01c5     30a5:	48 83 c4 28          	add    $0x28,%rsp
01c9     30a9:	5b                   	pop    %rbx
01ca     30aa:	41 5c                	pop    %r12
01cc     30ac:	41 5d                	pop    %r13
01ce     30ae:	41 5e                	pop    %r14
01d0     30b0:	41 5f                	pop    %r15
01d2     30b2:	5d                   	pop    %rbp
01d3     30b3:	c3                   	ret
01d4     30b4:	cc                   	int3
01d5     30b5:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 30bb <cpuidle_enter_state+0x1db>	30b7: R_X86_64_PC32	debug_locks-0x4
01db     30bb:	85 c0                	test   %eax,%eax
01dd     30bd:	74 18                	je     30d7 <cpuidle_enter_state+0x1f7>
01df     30bf:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 30c5 <cpuidle_enter_state+0x1e5>	30c1: R_X86_64_PC32	lockdep_recursion-0x4
01e5     30c5:	85 c0                	test   %eax,%eax
01e7     30c7:	75 0e                	jne    30d7 <cpuidle_enter_state+0x1f7>
01e9     30c9:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax        # 30cf <cpuidle_enter_state+0x1ef>	30cb: R_X86_64_PC32	hardirqs_enabled-0x4
01ef     30cf:	85 c0                	test   %eax,%eax
01f1     30d1:	74 04                	je     30d7 <cpuidle_enter_state+0x1f7>
01f3     30d3:	90                   	nop
01f4     30d4:	0f 0b                	ud2
01f6     30d6:	90                   	nop
01f7     30d7:	e8 00 00 00 00       	call   30dc <cpuidle_enter_state+0x1fc>	30d8: R_X86_64_PLT32	trace_hardirqs_on_prepare-0x4
01fc     30dc:	0f 1f 40 00          	nopl   0x0(%rax)
0200     30e0:	e8 00 00 00 00       	call   30e5 <cpuidle_enter_state+0x205>	30e1: R_X86_64_PLT32	lockdep_hardirqs_on_prepare-0x4
0205     30e5:	90                   	nop
0206     30e6:	e8 00 00 00 00       	call   30eb <cpuidle_enter_state+0x20b>	30e7: R_X86_64_PLT32	ct_idle_enter-0x4
020b     30eb:	48 8b 7d 08          	mov    0x8(%rbp),%rdi
020f     30ef:	e8 00 00 00 00       	call   30f4 <cpuidle_enter_state+0x214>	30f0: R_X86_64_PLT32	lockdep_hardirqs_on-0x4
0214     30f4:	90                   	nop
0215     30f5:	e9 70 fe ff ff       	jmp    2f6a <cpuidle_enter_state+0x8a>
021a     30fa:	4d 39 fd             	cmp    %r15,%r13
021d     30fd:	7d a2                	jge    30a1 <cpuidle_enter_state+0x1c1>
021f     30ff:	45 8d 46 01          	lea    0x1(%r14),%r8d
0223     3103:	45 8b 8c 24 28 04 00 00 	mov    0x428(%r12),%r9d
022b     310b:	45 39 c1             	cmp    %r8d,%r9d
022e     310e:	7e 91                	jle    30a1 <cpuidle_enter_state+0x1c1>
0230     3110:	49 63 c0             	movslq %r8d,%rax
0233     3113:	48 8d 0c 40          	lea    (%rax,%rax,2),%rcx
0237     3117:	48 c1 e1 04          	shl    $0x4,%rcx
023b     311b:	48 01 d9             	add    %rbx,%rcx
023e     311e:	48 83 f8 09          	cmp    $0x9,%rax
0242     3122:	0f 87 7b 02 00 00    	ja     33a3 <cpuidle_enter_state+0x4c3>
0248     3128:	48 83 79 30 00       	cmpq   $0x0,0x30(%rcx)
024d     312d:	0f 85 6f 01 00 00    	jne    32a2 <cpuidle_enter_state+0x3c2>
0253     3133:	4d 29 ef             	sub    %r13,%r15
0256     3136:	48 83 f8 09          	cmp    $0x9,%rax
025a     313a:	0f 87 bb 02 00 00    	ja     33fb <cpuidle_enter_state+0x51b>
0260     3140:	48 8d 0c 40          	lea    (%rax,%rax,2),%rcx
0264     3144:	48 8d 04 88          	lea    (%rax,%rcx,4),%rax
0268     3148:	4d 3b 7c c4 50       	cmp    0x50(%r12,%rax,8),%r15
026d     314d:	0f 8c 4e ff ff ff    	jl     30a1 <cpuidle_enter_state+0x1c1>
0273     3153:	48 83 fa 09          	cmp    $0x9,%rdx
0277     3157:	0f 87 d6 02 00 00    	ja     3433 <cpuidle_enter_state+0x553>
027d     315d:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
0281     3161:	48 c1 e0 04          	shl    $0x4,%rax
0285     3165:	48 83 44 03 50 01    	addq   $0x1,0x50(%rbx,%rax,1)
028b     316b:	8b 7b 04             	mov    0x4(%rbx),%edi
028e     316e:	ba 01 00 00 00       	mov    $0x1,%edx
0293     3173:	44 89 f6             	mov    %r14d,%esi
0296     3176:	e8 00 00 00 00       	call   317b <cpuidle_enter_state+0x29b>	3177: R_X86_64_PC32	.text+0x11d6c4c
029b     317b:	e9 21 ff ff ff       	jmp    30a1 <cpuidle_enter_state+0x1c1>
02a0     3180:	48 c7 43 18 00 00 00 00 	movq   $0x0,0x18(%rbx)
02a8     3188:	49 83 fd 09          	cmp    $0x9,%r13
02ac     318c:	0f 87 fd 01 00 00    	ja     338f <cpuidle_enter_state+0x4af>
02b2     3192:	4b 8d 44 6d 00       	lea    0x0(%r13,%r13,2),%rax
02b7     3197:	48 c1 e0 04          	shl    $0x4,%rax
02bb     319b:	48 83 44 03 58 01    	addq   $0x1,0x58(%rbx,%rax,1)
02c1     31a1:	e9 fb fe ff ff       	jmp    30a1 <cpuidle_enter_state+0x1c1>
02c6     31a6:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
02ca     31aa:	e8 00 00 00 00       	call   31af <cpuidle_enter_state+0x2cf>	31ab: R_X86_64_PC32	.text+0x11d6a9c
02cf     31af:	85 c0                	test   %eax,%eax
02d1     31b1:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
02d5     31b5:	75 7f                	jne    3236 <cpuidle_enter_state+0x356>
02d7     31b7:	c6 45 d0 01          	movb   $0x1,-0x30(%rbp)
02db     31bb:	41 f6 47 40 20       	testb  $0x20,0x40(%r15)
02e0     31c0:	0f 84 78 fd ff ff    	je     2f3e <cpuidle_enter_state+0x5e>
02e6     31c6:	8b 7b 04             	mov    0x4(%rbx),%edi
02e9     31c9:	e8 00 00 00 00       	call   31ce <cpuidle_enter_state+0x2ee>	31ca: R_X86_64_PLT32	leave_mm-0x4
02ee     31ce:	e9 6b fd ff ff       	jmp    2f3e <cpuidle_enter_state+0x5e>
02f3     31d3:	e8 00 00 00 00       	call   31d8 <cpuidle_enter_state+0x2f8>	31d4: R_X86_64_PLT32	trace_hardirqs_on-0x4
02f8     31d8:	fb                   	sti
02f9     31d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
0300     31e0:	e9 e8 fd ff ff       	jmp    2fcd <cpuidle_enter_state+0xed>
0305     31e5:	e8 00 00 00 00       	call   31ea <cpuidle_enter_state+0x30a>	31e6: R_X86_64_PC32	.text+0x11d6abc
030a     31ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
0310     31f0:	e9 cb fd ff ff       	jmp    2fc0 <cpuidle_enter_state+0xe0>
0315     31f5:	90                   	nop
0316     31f6:	48 8b 7d 08          	mov    0x8(%rbp),%rdi
031a     31fa:	e8 00 00 00 00       	call   31ff <cpuidle_enter_state+0x31f>	31fb: R_X86_64_PLT32	lockdep_hardirqs_off-0x4
031f     31ff:	e8 00 00 00 00       	call   3204 <cpuidle_enter_state+0x324>	3200: R_X86_64_PLT32	ct_idle_exit-0x4
0324     3204:	90                   	nop
0325     3205:	e9 86 fd ff ff       	jmp    2f90 <cpuidle_enter_state+0xb0>
032a     320a:	48 83 fa 09          	cmp    $0x9,%rdx
032e     320e:	66 90                	xchg   %ax,%ax
0330     3210:	0f 87 c9 01 00 00    	ja     33df <cpuidle_enter_state+0x4ff>
0336     3216:	48 8d 04 52          	lea    (%rdx,%rdx,2),%rax
033a     321a:	48 c1 e0 04          	shl    $0x4,%rax
033e     321e:	48 83 44 03 48 01    	addq   $0x1,0x48(%rbx,%rax,1)
0344     3224:	8b 7b 04             	mov    0x4(%rbx),%edi
0347     3227:	31 d2                	xor    %edx,%edx
0349     3229:	44 89 f6             	mov    %r14d,%esi
034c     322c:	e8 00 00 00 00       	call   3231 <cpuidle_enter_state+0x351>	322d: R_X86_64_PC32	.text+0x11d6c4c
0351     3231:	e9 6b fe ff ff       	jmp    30a1 <cpuidle_enter_state+0x1c1>
0356     3236:	48 8b 52 48          	mov    0x48(%rdx),%rdx
035a     323a:	b9 04 00 00 00       	mov    $0x4,%ecx
035f     323f:	48 89 de             	mov    %rbx,%rsi
0362     3242:	4c 89 e7             	mov    %r12,%rdi
0365     3245:	e8 00 00 00 00       	call   324a <cpuidle_enter_state+0x36a>	3246: R_X86_64_PC32	.text+0x11d6dbc
036a     324a:	41 89 c6             	mov    %eax,%r14d
036d     324d:	85 c0                	test   %eax,%eax
036f     324f:	78 7e                	js     32cf <cpuidle_enter_state+0x3ef>
0371     3251:	4c 63 e8             	movslq %eax,%r13
0374     3254:	49 83 fd 0a          	cmp    $0xa,%r13
0378     3258:	0f 87 c1 01 00 00    	ja     341f <cpuidle_enter_state+0x53f>
037e     325e:	4b 8d 44 6d 00       	lea    0x0(%r13,%r13,2),%rax
0383     3263:	49 8d 44 85 00       	lea    0x0(%r13,%rax,4),%rax
0388     3268:	4d 8d 7c c4 18       	lea    0x18(%r12,%rax,8),%r15
038d     326d:	c6 45 d0 00          	movb   $0x0,-0x30(%rbp)
0391     3271:	e9 bd fc ff ff       	jmp    2f33 <cpuidle_enter_state+0x53>
0396     3276:	80 3d 00 00 00 00 00 	cmpb   $0x0,0x0(%rip)        # 327d <cpuidle_enter_state+0x39d>	3278: R_X86_64_PC32	.data.once+0x156
039d     327d:	75 1d                	jne    329c <cpuidle_enter_state+0x3bc>
039f     327f:	c6 05 00 00 00 00 01 	movb   $0x1,0x0(%rip)        # 3286 <cpuidle_enter_state+0x3a6>	3281: R_X86_64_PC32	.data.once+0x156
03a6     3286:	90                   	nop
03a7     3287:	49 8b 77 50          	mov    0x50(%r15),%rsi
03ab     328b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	328e: R_X86_64_32S	.rodata+0x2efd40
03b2     3292:	e8 00 00 00 00       	call   3297 <cpuidle_enter_state+0x3b7>	3293: R_X86_64_PLT32	__warn_printk-0x4
03b7     3297:	90                   	nop
03b8     3298:	0f 0b                	ud2
03ba     329a:	90                   	nop
03bb     329b:	90                   	nop
03bc     329c:	fa                   	cli
03bd     329d:	e9 e3 fc ff ff       	jmp    2f85 <cpuidle_enter_state+0xa5>
03c2     32a2:	41 83 c0 01          	add    $0x1,%r8d
03c6     32a6:	48 83 c1 30          	add    $0x30,%rcx
03ca     32aa:	45 39 c1             	cmp    %r8d,%r9d
03cd     32ad:	0f 8e ee fd ff ff    	jle    30a1 <cpuidle_enter_state+0x1c1>
03d3     32b3:	49 63 c0             	movslq %r8d,%rax
03d6     32b6:	e9 63 fe ff ff       	jmp    311e <cpuidle_enter_state+0x23e>
03db     32bb:	4c 89 ee             	mov    %r13,%rsi
03de     32be:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	32c1: R_X86_64_32S	.data+0x913ce0
03e5     32c5:	e8 00 00 00 00       	call   32ca <cpuidle_enter_state+0x3ea>	32c6: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
03ea     32ca:	e9 3c fc ff ff       	jmp    2f0b <cpuidle_enter_state+0x2b>
03ef     32cf:	e8 00 00 00 00       	call   32d4 <cpuidle_enter_state+0x3f4>	32d0: R_X86_64_PLT32	default_idle_call-0x4
03f4     32d4:	41 be f0 ff ff ff    	mov    $0xfffffff0,%r14d
03fa     32da:	e9 c3 fd ff ff       	jmp    30a2 <cpuidle_enter_state+0x1c2>
03ff     32df:	48 89 d6             	mov    %rdx,%rsi
0402     32e2:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
0406     32e6:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	32e9: R_X86_64_32S	.data+0x913ba0
040d     32ed:	e8 00 00 00 00       	call   32f2 <cpuidle_enter_state+0x412>	32ee: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
0412     32f2:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
0416     32f6:	e9 4b fd ff ff       	jmp    3046 <cpuidle_enter_state+0x166>
041b     32fb:	48 89 d6             	mov    %rdx,%rsi
041e     32fe:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
0422     3302:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3305: R_X86_64_32S	.data+0x913c20
0429     3309:	e8 00 00 00 00       	call   330e <cpuidle_enter_state+0x42e>	330a: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
042e     330e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
0432     3312:	e9 fe fc ff ff       	jmp    3015 <cpuidle_enter_state+0x135>
0437     3317:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
043b     331b:	48 89 d6             	mov    %rdx,%rsi
043e     331e:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
0442     3322:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3325: R_X86_64_32S	.data+0x913be0
0449     3329:	e8 00 00 00 00       	call   332e <cpuidle_enter_state+0x44e>	332a: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
044e     332e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
0452     3332:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
0456     3336:	e9 f1 fc ff ff       	jmp    302c <cpuidle_enter_state+0x14c>
045b     333b:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
045f     333f:	4c 89 e6             	mov    %r12,%rsi
0462     3342:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3345: R_X86_64_32S	.data+0x913b20
0469     3349:	e8 00 00 00 00       	call   334e <cpuidle_enter_state+0x46e>	334a: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
046e     334e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
0472     3352:	e9 30 fd ff ff       	jmp    3087 <cpuidle_enter_state+0x1a7>
0477     3357:	48 89 d6             	mov    %rdx,%rsi
047a     335a:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
047e     335e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3361: R_X86_64_32S	.data+0x913c60
0485     3365:	e8 00 00 00 00       	call   336a <cpuidle_enter_state+0x48a>	3366: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
048a     336a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
048e     336e:	e9 70 fc ff ff       	jmp    2fe3 <cpuidle_enter_state+0x103>
0493     3373:	48 89 d6             	mov    %rdx,%rsi
0496     3376:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
049a     337a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	337d: R_X86_64_32S	.data+0x913b60
04a1     3381:	e8 00 00 00 00       	call   3386 <cpuidle_enter_state+0x4a6>	3382: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
04a6     3386:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
04aa     338a:	e9 cf fc ff ff       	jmp    305e <cpuidle_enter_state+0x17e>
04af     338f:	4c 89 ee             	mov    %r13,%rsi
04b2     3392:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3395: R_X86_64_32S	.data+0x9139e0
04b9     3399:	e8 00 00 00 00       	call   339e <cpuidle_enter_state+0x4be>	339a: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
04be     339e:	e9 ef fd ff ff       	jmp    3192 <cpuidle_enter_state+0x2b2>
04c3     33a3:	48 89 55 b0          	mov    %rdx,-0x50(%rbp)
04c7     33a7:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)
04cb     33ab:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
04cf     33af:	44 89 4d c8          	mov    %r9d,-0x38(%rbp)
04d3     33b3:	48 89 c6             	mov    %rax,%rsi
04d6     33b6:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
04da     33ba:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	33bd: R_X86_64_32S	.data+0x913aa0
04e1     33c1:	e8 00 00 00 00       	call   33c6 <cpuidle_enter_state+0x4e6>	33c2: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
04e6     33c6:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
04ea     33ca:	44 8b 45 bc          	mov    -0x44(%rbp),%r8d
04ee     33ce:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
04f2     33d2:	44 8b 4d c8          	mov    -0x38(%rbp),%r9d
04f6     33d6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
04fa     33da:	e9 49 fd ff ff       	jmp    3128 <cpuidle_enter_state+0x248>
04ff     33df:	48 89 d6             	mov    %rdx,%rsi
0502     33e2:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
0506     33e6:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	33e9: R_X86_64_32S	.data+0x913ae0
050d     33ed:	e8 00 00 00 00       	call   33f2 <cpuidle_enter_state+0x512>	33ee: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
0512     33f2:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
0516     33f6:	e9 1b fe ff ff       	jmp    3216 <cpuidle_enter_state+0x336>
051b     33fb:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
051f     33ff:	48 89 c6             	mov    %rax,%rsi
0522     3402:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
0526     3406:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3409: R_X86_64_32S	.data+0x913a60
052d     340d:	e8 00 00 00 00       	call   3412 <cpuidle_enter_state+0x532>	340e: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
0532     3412:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
0536     3416:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
053a     341a:	e9 21 fd ff ff       	jmp    3140 <cpuidle_enter_state+0x260>
053f     341f:	4c 89 ee             	mov    %r13,%rsi
0542     3422:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3425: R_X86_64_32S	.data+0x913ca0
0549     3429:	e8 00 00 00 00       	call   342e <cpuidle_enter_state+0x54e>	342a: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
054e     342e:	e9 2b fe ff ff       	jmp    325e <cpuidle_enter_state+0x37e>
0553     3433:	48 89 d6             	mov    %rdx,%rsi
0556     3436:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
055a     343a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	343d: R_X86_64_32S	.data+0x913a20
0561     3441:	e8 00 00 00 00       	call   3446 <cpuidle_enter_state+0x566>	3442: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
0566     3446:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
056a     344a:	e9 0e fd ff ff       	jmp    315d <cpuidle_enter_state+0x27d>
056f     344f:	90                   	nop

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
