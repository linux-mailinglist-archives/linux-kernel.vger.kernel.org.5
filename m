Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875B379F618
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjINBGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjINBGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:06:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D381713
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694653563; x=1726189563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hrtQJ5Hx0V4EofOPG8SdnrLVDhZFvyUjTF15ppZlN74=;
  b=b7eVSszNRfFYMRROxKMXYoki7IiquutP4/Yg0DkUIoS4LPKegiPl3H6I
   wNxEyF2lcG64nyGr3BP/cSx462H34T/AiCcq7aUntftKa/CeC98iS6jJq
   bM36kUuL767PjvEq0SVbphsjGIfqGXWz1MVJeEr59bhlLsLv3wjT9aUMb
   DI6qPylY6DOI6YW5+H5npkXGGqsG5ncxAdTu7kzPj8Unj3pM/x+l2n/1n
   X8rvL7zl563Yg6uGCs6mrNksGeZ00Ht+KHJiyB9qXmndAcpzUnH3dHwTp
   Q8t7H1DgA1XNvaTIibExxyNx2zvSZ+lGjDkhuZndU0JpUudjzmt9B0TUT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363860836"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="363860836"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="737735834"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="737735834"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Sep 2023 18:06:00 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qganu-0000uZ-23;
        Thu, 14 Sep 2023 01:05:58 +0000
Date:   Thu, 14 Sep 2023 09:05:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [tip:x86/tdx 8/12] vmlinux.o: warning: objtool:
 __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn
 annotation
Message-ID: <202309140828.9RdmlH2Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
head:   7b804135d4d1f0a2b9dda69c6303d3f2dcbe9d37
commit: c641cfb5c157b6c3062a824fd8ba190bf06fb952 [8/12] x86/tdx: Make TDX_HYPERCALL asm similar to TDX_MODULE_CALL
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20230914/202309140828.9RdmlH2Z-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140828.9RdmlH2Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140828.9RdmlH2Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: __tdx_hypercall+0x128: __tdx_hypercall_failed() is missing a __noreturn annotation


objdump-func vmlinux.o __tdx_hypercall:
0000 0000000000000050 <__tdx_hypercall_failed>:
0000       50:	f3 0f 1e fa          	endbr64
0004       54:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	57: R_X86_64_32S	.rodata.str1.8+0xe18
000b       5b:	e8 00 00 00 00       	call   60 <__tdx_hypercall>	5c: R_X86_64_PLT32	panic-0x4
0000 0000000000000060 <__tdx_hypercall>:
0000       60:	f3 0f 1e fa          	endbr64
0004       64:	53                   	push   %rbx
0005       65:	48 89 fb             	mov    %rdi,%rbx
0008       68:	48 83 ec 70          	sub    $0x70,%rsp
000c       6c:	65 48 8b 04 25 28 00 00 00 	mov    %gs:0x28,%rax
0015       75:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
001a       7a:	31 c0                	xor    %eax,%eax
001c       7c:	48 8b 47 58          	mov    0x58(%rdi),%rax
0020       80:	48 89 e6             	mov    %rsp,%rsi
0023       83:	48 c7 04 24 cc ff 00 00 	movq   $0xffcc,(%rsp)
002b       8b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
0030       90:	48 8b 07             	mov    (%rdi),%rax
0033       93:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
0038       98:	48 8b 47 08          	mov    0x8(%rdi),%rax
003c       9c:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
0041       a1:	48 8b 47 10          	mov    0x10(%rdi),%rax
0045       a5:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
004a       aa:	48 8b 47 18          	mov    0x18(%rdi),%rax
004e       ae:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
0053       b3:	48 8b 47 20          	mov    0x20(%rdi),%rax
0057       b7:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
005c       bc:	48 8b 47 28          	mov    0x28(%rdi),%rax
0060       c0:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
0065       c5:	48 8b 47 30          	mov    0x30(%rdi),%rax
0069       c9:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
006e       ce:	48 8b 47 38          	mov    0x38(%rdi),%rax
0072       d2:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
0077       d7:	48 8b 47 50          	mov    0x50(%rdi),%rax
007b       db:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
0080       e0:	48 8b 47 40          	mov    0x40(%rdi),%rax
0084       e4:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
0089       e9:	48 8b 47 48          	mov    0x48(%rdi),%rax
008d       ed:	31 ff                	xor    %edi,%edi
008f       ef:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
0094       f4:	e8 00 00 00 00       	call   f9 <__tdx_hypercall+0x99>	f5: R_X86_64_PLT32	__tdcall_hypercall-0x4
0099       f9:	48 85 c0             	test   %rax,%rax
009c       fc:	0f 85 81 00 00 00    	jne    183 <__tdx_hypercall+0x123>
00a2      102:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
00a7      107:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
00ac      10c:	48 89 53 18          	mov    %rdx,0x18(%rbx)
00b0      110:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
00b5      115:	48 89 03             	mov    %rax,(%rbx)
00b8      118:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
00bd      11d:	48 89 53 20          	mov    %rdx,0x20(%rbx)
00c1      121:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
00c6      126:	48 89 43 08          	mov    %rax,0x8(%rbx)
00ca      12a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
00cf      12f:	48 89 53 28          	mov    %rdx,0x28(%rbx)
00d3      133:	48 8b 54 24 40       	mov    0x40(%rsp),%rdx
00d8      138:	48 89 43 10          	mov    %rax,0x10(%rbx)
00dc      13c:	48 89 53 30          	mov    %rdx,0x30(%rbx)
00e0      140:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
00e5      145:	48 89 53 38          	mov    %rdx,0x38(%rbx)
00e9      149:	48 8b 54 24 58       	mov    0x58(%rsp),%rdx
00ee      14e:	48 89 53 40          	mov    %rdx,0x40(%rbx)
00f2      152:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
00f7      157:	48 89 53 48          	mov    %rdx,0x48(%rbx)
00fb      15b:	48 8b 54 24 50       	mov    0x50(%rsp),%rdx
0100      160:	48 89 53 50          	mov    %rdx,0x50(%rbx)
0104      164:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
0109      169:	48 89 53 58          	mov    %rdx,0x58(%rbx)
010d      16d:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
0112      172:	65 48 2b 14 25 28 00 00 00 	sub    %gs:0x28,%rdx
011b      17b:	75 10                	jne    18d <__tdx_hypercall+0x12d>
011d      17d:	48 83 c4 70          	add    $0x70,%rsp
0121      181:	5b                   	pop    %rbx
0122      182:	c3                   	ret
0123      183:	e8 00 00 00 00       	call   188 <__tdx_hypercall+0x128>	184: R_X86_64_PLT32	__tdx_hypercall_failed-0x4
0128      188:	e9 75 ff ff ff       	jmp    102 <__tdx_hypercall+0xa2>
012d      18d:	e8 00 00 00 00       	call   192 <__tdx_hypercall+0x132>	18e: R_X86_64_PLT32	__stack_chk_fail-0x4
0132      192:	66 2e 0f 1f 84 00 00 00 00 00 	cs nopw 0x0(%rax,%rax,1)
013c      19c:	0f 1f 40 00          	nopl   0x0(%rax)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
