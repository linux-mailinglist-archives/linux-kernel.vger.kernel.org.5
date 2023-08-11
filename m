Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3373779505
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjHKQqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjHKQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:46:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81E530DE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691772348; x=1723308348;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2QKFtFhBf4OWwXoX1losLazDKrV3xxMsgg8OelwbuEY=;
  b=dGL40rYCj7NB2XNUd460CCPDowk9z3W/JO3mVEk4YO3oPuIL+i3ITPdt
   6PxyPgHrOrbmROLJHSq2RJ10c/OHl1tXoLP0bDjPxbGSI0UEtA9stubMq
   BYm+HSWEFti8Y9l13G6E4KVP+XpGkVO1nhxXINFZpfyw3uedJTj68IJwt
   0482V6Hv2k0xsmd3ivrpPu54zZBWI4GmC80a9SHHkzz/+UINYQkuepf5S
   WzW0L5gbfVuPFDlonpKT+V3pZHwzklj1YbcVIdffm+BKEY1SBsI4YcvdA
   1H9AnmEXhheZOPYt+wRMRy9D4nOxnza4z1Ojb4TMSNwc3OTmd61F8Ofyx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="438053066"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="438053066"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 09:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="1063367063"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="1063367063"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2023 09:45:45 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUVGj-0007sy-0H;
        Fri, 11 Aug 2023 16:45:45 +0000
Date:   Sat, 12 Aug 2023 00:45:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: arch/x86/kernel/alternative.o: warning: objtool:
 .altinstr_replacement+0xc: call without frame pointer save/setup
Message-ID: <202308120024.2BaBD1vU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25aa0bebba72b318e71fe205bfd1236550cc9534
commit: 270a69c4485d7d07516d058bcc0473c90ee22185 x86/alternative: Support relocations in alternatives
date:   3 months ago
config: x86_64-randconfig-r025-20230811 (https://download.01.org/0day-ci/archive/20230812/202308120024.2BaBD1vU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120024.2BaBD1vU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308120024.2BaBD1vU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/alternative.c:1401:32: warning: no previous prototype for '__alt_reloc_selftest' [-Wmissing-prototypes]
    1401 | __visible noinline void __init __alt_reloc_selftest(void *arg)
         |                                ^~~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/alternative.o: warning: objtool: .altinstr_replacement+0xc: call without frame pointer save/setup


objdump-func vmlinux.o .altinstr_replacement:
0000 0000000000000000 <.altinstr_replacement>:
0000    0:	e9 00 00 00 00       	jmp    5 <.altinstr_replacement+0x5>	1: R_X86_64_PLT32	swapgs_restore_regs_and_return_to_usermode-0x4
0005    5:	49 c7 c4 10 00 00 00 	mov    $0x10,%r12
000c    c:	e8 01 00 00 00       	call   12 <.altinstr_replacement+0x12>
0011   11:	cc                   	int3
0012   12:	e8 01 00 00 00       	call   18 <.altinstr_replacement+0x18>
0017   17:	cc                   	int3
0018   18:	48 83 c4 10          	add    $0x10,%rsp
001c   1c:	49 ff cc             	dec    %r12
001f   1f:	75 eb                	jne    c <.altinstr_replacement+0xc>
0021   21:	0f ae e8             	lfence
0024   24:	90                   	nop
0025   25:	90                   	nop
0026   26:	e8 01 00 00 00       	call   2c <.altinstr_replacement+0x2c>
002b   2b:	cc                   	int3
002c   2c:	48 83 c4 08          	add    $0x8,%rsp
0030   30:	0f ae e8             	lfence
0033   33:	0f 01 ca             	clac
0036   36:	e8 00 00 00 00       	call   3b <.altinstr_replacement+0x3b>	37: R_X86_64_PLT32	xen_error_entry-0x4
003b   3b:	0f 01 ca             	clac
003e   3e:	e8 00 00 00 00       	call   43 <.altinstr_replacement+0x43>	3f: R_X86_64_PLT32	xen_error_entry-0x4
0043   43:	0f 01 ca             	clac
0046   46:	e8 00 00 00 00       	call   4b <.altinstr_replacement+0x4b>	47: R_X86_64_PLT32	xen_error_entry-0x4
004b   4b:	0f 01 ca             	clac
004e   4e:	e8 00 00 00 00       	call   53 <.altinstr_replacement+0x53>	4f: R_X86_64_PLT32	xen_error_entry-0x4
0053   53:	0f 01 ca             	clac
0056   56:	e8 00 00 00 00       	call   5b <.altinstr_replacement+0x5b>	57: R_X86_64_PLT32	xen_error_entry-0x4
005b   5b:	0f 01 ca             	clac
005e   5e:	e8 00 00 00 00       	call   63 <.altinstr_replacement+0x63>	5f: R_X86_64_PLT32	xen_error_entry-0x4
0063   63:	0f 01 ca             	clac
0066   66:	e8 00 00 00 00       	call   6b <.altinstr_replacement+0x6b>	67: R_X86_64_PLT32	xen_error_entry-0x4
006b   6b:	0f 01 ca             	clac
006e   6e:	e8 00 00 00 00       	call   73 <.altinstr_replacement+0x73>	6f: R_X86_64_PLT32	xen_error_entry-0x4
0073   73:	0f 01 ca             	clac
0076   76:	e8 00 00 00 00       	call   7b <.altinstr_replacement+0x7b>	77: R_X86_64_PLT32	xen_error_entry-0x4
007b   7b:	0f 01 ca             	clac
007e   7e:	e8 00 00 00 00       	call   83 <.altinstr_replacement+0x83>	7f: R_X86_64_PLT32	xen_error_entry-0x4
0083   83:	0f 01 ca             	clac
0086   86:	e8 00 00 00 00       	call   8b <.altinstr_replacement+0x8b>	87: R_X86_64_PLT32	xen_error_entry-0x4
008b   8b:	0f 01 ca             	clac
008e   8e:	e8 00 00 00 00       	call   93 <.altinstr_replacement+0x93>	8f: R_X86_64_PLT32	xen_error_entry-0x4
0093   93:	0f 01 ca             	clac
0096   96:	e8 00 00 00 00       	call   9b <.altinstr_replacement+0x9b>	97: R_X86_64_PLT32	xen_error_entry-0x4
009b   9b:	0f 01 ca             	clac
009e   9e:	e8 00 00 00 00       	call   a3 <.altinstr_replacement+0xa3>	9f: R_X86_64_PLT32	xen_error_entry-0x4
00a3   a3:	0f 01 ca             	clac
00a6   a6:	e8 00 00 00 00       	call   ab <.altinstr_replacement+0xab>	a7: R_X86_64_PLT32	xen_error_entry-0x4
00ab   ab:	0f 01 ca             	clac
00ae   ae:	e8 00 00 00 00       	call   b3 <.altinstr_replacement+0xb3>	af: R_X86_64_PLT32	xen_error_entry-0x4
00b3   b3:	0f 01 ca             	clac
00b6   b6:	e8 00 00 00 00       	call   bb <.altinstr_replacement+0xbb>	b7: R_X86_64_PLT32	xen_error_entry-0x4
00bb   bb:	0f 01 ca             	clac
00be   be:	e8 00 00 00 00       	call   c3 <.altinstr_replacement+0xc3>	bf: R_X86_64_PLT32	xen_error_entry-0x4
00c3   c3:	0f 01 ca             	clac
00c6   c6:	0f 01 ca             	clac
00c9   c9:	e8 00 00 00 00       	call   ce <.altinstr_replacement+0xce>	ca: R_X86_64_PLT32	xen_error_entry-0x4
00ce   ce:	0f 01 ca             	clac
00d1   d1:	e8 00 00 00 00       	call   d6 <.altinstr_replacement+0xd6>	d2: R_X86_64_PLT32	xen_error_entry-0x4
00d6   d6:	0f 01 ca             	clac
00d9   d9:	e8 00 00 00 00       	call   de <.altinstr_replacement+0xde>	da: R_X86_64_PLT32	xen_error_entry-0x4
00de   de:	0f 01 ca             	clac
00e1   e1:	e8 00 00 00 00       	call   e6 <.altinstr_replacement+0xe6>	e2: R_X86_64_PLT32	xen_error_entry-0x4
00e6   e6:	0f 01 ca             	clac
00e9   e9:	e8 00 00 00 00       	call   ee <.altinstr_replacement+0xee>	ea: R_X86_64_PLT32	xen_error_entry-0x4
00ee   ee:	0f 01 ca             	clac
00f1   f1:	e8 00 00 00 00       	call   f6 <.altinstr_replacement+0xf6>	f2: R_X86_64_PLT32	xen_error_entry-0x4
00f6   f6:	0f 01 ca             	clac
00f9   f9:	e8 00 00 00 00       	call   fe <.altinstr_replacement+0xfe>	fa: R_X86_64_PLT32	xen_error_entry-0x4
00fe   fe:	0f 01 ca             	clac
0101  101:	e8 00 00 00 00       	call   106 <.altinstr_replacement+0x106>	102: R_X86_64_PLT32	xen_error_entry-0x4
0106  106:	0f 01 ca             	clac
0109  109:	e8 00 00 00 00       	call   10e <.altinstr_replacement+0x10e>	10a: R_X86_64_PLT32	xen_error_entry-0x4
010e  10e:	0f 01 ca             	clac
0111  111:	e8 00 00 00 00       	call   116 <.altinstr_replacement+0x116>	112: R_X86_64_PLT32	xen_error_entry-0x4
0116  116:	0f 01 ca             	clac
0119  119:	e8 00 00 00 00       	call   11e <.altinstr_replacement+0x11e>	11a: R_X86_64_PLT32	xen_error_entry-0x4
011e  11e:	0f 01 ca             	clac
0121  121:	e8 00 00 00 00       	call   126 <.altinstr_replacement+0x126>	122: R_X86_64_PLT32	xen_error_entry-0x4
0126  126:	0f 01 ca             	clac
0129  129:	e8 00 00 00 00       	call   12e <.altinstr_replacement+0x12e>	12a: R_X86_64_PLT32	xen_error_entry-0x4
012e  12e:	0f 01 ca             	clac
0131  131:	e8 00 00 00 00       	call   136 <.altinstr_replacement+0x136>	132: R_X86_64_PLT32	xen_error_entry-0x4
0136  136:	0f 01 ca             	clac
0139  139:	e8 00 00 00 00       	call   13e <.altinstr_replacement+0x13e>	13a: R_X86_64_PLT32	xen_error_entry-0x4
013e  13e:	0f 01 ca             	clac
0141  141:	e8 00 00 00 00       	call   146 <.altinstr_replacement+0x146>	142: R_X86_64_PLT32	xen_error_entry-0x4
0146  146:	0f 01 ca             	clac
0149  149:	e8 00 00 00 00       	call   14e <.altinstr_replacement+0x14e>	14a: R_X86_64_PLT32	xen_error_entry-0x4
014e  14e:	0f ae f0             	mfence
0151  151:	b8 2b 00 00 00       	mov    $0x2b,%eax
0156  156:	8e e8                	mov    %eax,%gs
0158  158:	0f ae e8             	lfence
015b  15b:	0f ae e8             	lfence
015e  15e:	0f ae e8             	lfence
0161  161:	0f ae e8             	lfence
0164  164:	0f 01 ca             	clac
0167  167:	0f ae e8             	lfence
016a  16a:	e9 00 00 00 00       	jmp    16f <.altinstr_replacement+0x16f>	16b: R_X86_64_PLT32	swapgs_restore_regs_and_return_to_usermode-0x4
016f  16f:	e9 00 00 00 00       	jmp    174 <.altinstr_replacement+0x174>	170: R_X86_64_PLT32	swapgs_restore_regs_and_return_to_usermode-0x4
0174  174:	0f 01 ca             	clac
0177  177:	e9 00 00 00 00       	jmp    17c <.altinstr_replacement+0x17c>	178: R_X86_64_PC32	.entry.text+0x17a7
017c  17c:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0181  181:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0186  186:	e9 00 00 00 00       	jmp    18b <.altinstr_replacement+0x18b>	187: R_X86_64_PC32	.text+0xca30
018b  18b:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0190  190:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0195  195:	f3 48 0f b8 c7       	popcnt %rdi,%rax
019a  19a:	0f ae e8             	lfence
019d  19d:	0f 31                	rdtsc
019f  19f:	0f 01 f9             	rdtscp
01a2  1a2:	f3 48 0f b8 c7       	popcnt %rdi,%rax
01a7  1a7:	e9 00 00 00 00       	jmp    1ac <.altinstr_replacement+0x1ac>	1a8: R_X86_64_PC32	.init.text+0xa54d
01ac  1ac:	e9 00 00 00 00       	jmp    1b1 <.altinstr_replacement+0x1b1>	1ad: R_X86_64_PC32	.text+0x28b1e
01b1  1b1:	e9 00 00 00 00       	jmp    1b6 <.altinstr_replacement+0x1b6>	1b2: R_X86_64_PC32	.text+0x28b5c
01b6  1b6:	e9 00 00 00 00       	jmp    1bb <.altinstr_replacement+0x1bb>	1b7: R_X86_64_PC32	.text+0x28bd0
01bb  1bb:	e9 00 00 00 00       	jmp    1c0 <.altinstr_replacement+0x1c0>	1bc: R_X86_64_PC32	.text+0x28c3e
01c0  1c0:	e9 00 00 00 00       	jmp    1c5 <.altinstr_replacement+0x1c5>	1c1: R_X86_64_PC32	.text+0x292a1
01c5  1c5:	e9 00 00 00 00       	jmp    1ca <.altinstr_replacement+0x1ca>	1c6: R_X86_64_PC32	.text+0x2947e
01ca  1ca:	e9 00 00 00 00       	jmp    1cf <.altinstr_replacement+0x1cf>	1cb: R_X86_64_PC32	.text+0x294a9
01cf  1cf:	e9 00 00 00 00       	jmp    1d4 <.altinstr_replacement+0x1d4>	1d0: R_X86_64_PC32	.text+0x294bc
01d4  1d4:	e9 00 00 00 00       	jmp    1d9 <.altinstr_replacement+0x1d9>	1d5: R_X86_64_PC32	.text+0x294f7
01d9  1d9:	e9 00 00 00 00       	jmp    1de <.altinstr_replacement+0x1de>	1da: R_X86_64_PC32	.text+0x29758
01de  1de:	e9 00 00 00 00       	jmp    1e3 <.altinstr_replacement+0x1e3>	1df: R_X86_64_PC32	.text+0x29fcd
01e3  1e3:	e9 00 00 00 00       	jmp    1e8 <.altinstr_replacement+0x1e8>	1e4: R_X86_64_PC32	.text+0x2a085
01e8  1e8:	e9 00 00 00 00       	jmp    1ed <.altinstr_replacement+0x1ed>	1e9: R_X86_64_PC32	.text+0x2a0d0
01ed  1ed:	e9 00 00 00 00       	jmp    1f2 <.altinstr_replacement+0x1f2>	1ee: R_X86_64_PC32	.text+0x2a146
01f2  1f2:	e9 00 00 00 00       	jmp    1f7 <.altinstr_replacement+0x1f7>	1f3: R_X86_64_PC32	.text+0x2a1fa
01f7  1f7:	e9 00 00 00 00       	jmp    1fc <.altinstr_replacement+0x1fc>	1f8: R_X86_64_PC32	.text+0x2a2b2
01fc  1fc:	e9 00 00 00 00       	jmp    201 <.altinstr_replacement+0x201>	1fd: R_X86_64_PC32	.text+0x2a31b
0201  201:	e9 00 00 00 00       	jmp    206 <.altinstr_replacement+0x206>	202: R_X86_64_PC32	.text+0x2ac39
0206  206:	e9 00 00 00 00       	jmp    20b <.altinstr_replacement+0x20b>	207: R_X86_64_PC32	.text+0x2ac78
020b  20b:	e9 00 00 00 00       	jmp    210 <.altinstr_replacement+0x210>	20c: R_X86_64_PC32	.text+0x2ac83
0210  210:	e9 00 00 00 00       	jmp    215 <.altinstr_replacement+0x215>	211: R_X86_64_PC32	.text+0x2aced
0215  215:	e9 00 00 00 00       	jmp    21a <.altinstr_replacement+0x21a>	216: R_X86_64_PC32	.text+0x2aff2
021a  21a:	e9 00 00 00 00       	jmp    21f <.altinstr_replacement+0x21f>	21b: R_X86_64_PC32	.text+0x2b2a3
021f  21f:	e9 00 00 00 00       	jmp    224 <.altinstr_replacement+0x224>	220: R_X86_64_PC32	.text+0x2b3d6
0224  224:	e9 00 00 00 00       	jmp    229 <.altinstr_replacement+0x229>	225: R_X86_64_PC32	.text+0x2b503
0229  229:	e9 00 00 00 00       	jmp    22e <.altinstr_replacement+0x22e>	22a: R_X86_64_PC32	.text+0x2b844
022e  22e:	e9 00 00 00 00       	jmp    233 <.altinstr_replacement+0x233>	22f: R_X86_64_PC32	.text+0x2c386
0233  233:	e9 00 00 00 00       	jmp    238 <.altinstr_replacement+0x238>	234: R_X86_64_PC32	.text+0x2c4b7
0238  238:	e8 00 00 00 00       	call   23d <.altinstr_replacement+0x23d>	239: R_X86_64_PLT32	clear_page_rep-0x4
023d  23d:	e8 00 00 00 00       	call   242 <.altinstr_replacement+0x242>	23e: R_X86_64_PLT32	clear_page_erms-0x4
0242  242:	e9 00 00 00 00       	jmp    247 <.altinstr_replacement+0x247>	243: R_X86_64_PC32	.text+0x3433e
0247  247:	e9 00 00 00 00       	jmp    24c <.altinstr_replacement+0x24c>	248: R_X86_64_PC32	.text+0x34494
024c  24c:	e9 00 00 00 00       	jmp    251 <.altinstr_replacement+0x251>	24d: R_X86_64_PC32	.text+0x34898
0251  251:	e9 00 00 00 00       	jmp    256 <.altinstr_replacement+0x256>	252: R_X86_64_PC32	.text+0x34d27
0256  256:	e9 00 00 00 00       	jmp    25b <.altinstr_replacement+0x25b>	257: R_X86_64_PC32	.text+0x34d15
025b  25b:	e9 00 00 00 00       	jmp    260 <.altinstr_replacement+0x260>	25c: R_X86_64_PC32	.text+0x34e26
0260  260:	e9 00 00 00 00       	jmp    265 <.altinstr_replacement+0x265>	261: R_X86_64_PC32	.text+0x35643
0265  265:	e9 00 00 00 00       	jmp    26a <.altinstr_replacement+0x26a>	266: R_X86_64_PC32	.text+0x35a89
026a  26a:	e9 00 00 00 00       	jmp    26f <.altinstr_replacement+0x26f>	26b: R_X86_64_PC32	.text+0x35c5d
026f  26f:	e9 00 00 00 00       	jmp    274 <.altinstr_replacement+0x274>	270: R_X86_64_PC32	.text+0x35d78
0274  274:	e9 00 00 00 00       	jmp    279 <.altinstr_replacement+0x279>	275: R_X86_64_PC32	.text+0x35e36
0279  279:	e9 00 00 00 00       	jmp    27e <.altinstr_replacement+0x27e>	27a: R_X86_64_PC32	.text+0x35f4f
027e  27e:	e9 00 00 00 00       	jmp    283 <.altinstr_replacement+0x283>	27f: R_X86_64_PC32	.text+0x368c1
0283  283:	0f 01 cb             	stac
0286  286:	0f ae e8             	lfence
0289  289:	0f 01 ca             	clac
028c  28c:	0f 01 ca             	clac
028f  28f:	e9 00 00 00 00       	jmp    294 <.altinstr_replacement+0x294>	290: R_X86_64_PC32	.text+0x391f3
0294  294:	e9 00 00 00 00       	jmp    299 <.altinstr_replacement+0x299>	295: R_X86_64_PC32	.noinstr.text+0x8bf
0299  299:	e9 00 00 00 00       	jmp    29e <.altinstr_replacement+0x29e>	29a: R_X86_64_PC32	.noinstr.text+0xb62
029e  29e:	e9 00 00 00 00       	jmp    2a3 <.altinstr_replacement+0x2a3>	29f: R_X86_64_PC32	.init.text+0x10f3f
02a3  2a3:	e9 00 00 00 00       	jmp    2a8 <.altinstr_replacement+0x2a8>	2a4: R_X86_64_PC32	.noinstr.text+0x15bc
02a8  2a8:	0f 01 cb             	stac
02ab  2ab:	0f ae e8             	lfence
02ae  2ae:	0f 01 ca             	clac
02b1  2b1:	0f 01 ca             	clac
02b4  2b4:	e9 00 00 00 00       	jmp    2b9 <.altinstr_replacement+0x2b9>	2b5: R_X86_64_PC32	.text+0x4627b
02b9  2b9:	0f 01 cb             	stac
02bc  2bc:	0f ae e8             	lfence
02bf  2bf:	0f 01 ca             	clac
02c2  2c2:	0f 01 ca             	clac
02c5  2c5:	0f 01 cb             	stac
02c8  2c8:	0f ae e8             	lfence
02cb  2cb:	e9 00 00 00 00       	jmp    2d0 <.altinstr_replacement+0x2d0>	2cc: R_X86_64_PC32	.text+0x47228
02d0  2d0:	0f 01 ca             	clac
02d3  2d3:	0f 01 ca             	clac
02d6  2d6:	e9 00 00 00 00       	jmp    2db <.altinstr_replacement+0x2db>	2d7: R_X86_64_PC32	.text+0x4a388
02db  2db:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 2e2 <.altinstr_replacement+0x2e2>	2de: R_X86_64_PC32	.init.data+0x5538c
02e2  2e2:	e8 00 00 00 00       	call   2e7 <.altinstr_replacement+0x2e7>	2e3: R_X86_64_PLT32	__alt_reloc_selftest-0x4
02e7  2e7:	f3 48 0f b8 c7       	popcnt %rdi,%rax
02ec  2ec:	0f ae e8             	lfence
02ef  2ef:	0f 31                	rdtsc
02f1  2f1:	0f 01 f9             	rdtscp
02f4  2f4:	f3 48 0f b8 c7       	popcnt %rdi,%rax
02f9  2f9:	e9 00 00 00 00       	jmp    2fe <.altinstr_replacement+0x2fe>	2fa: R_X86_64_PC32	.init.text+0x17e1d
02fe  2fe:	e9 00 00 00 00       	jmp    303 <.altinstr_replacement+0x303>	2ff: R_X86_64_PC32	.text+0x51bc3
0303  303:	e9 00 00 00 00       	jmp    308 <.altinstr_replacement+0x308>	304: R_X86_64_PC32	.text+0x51f58
0308  308:	e9 00 00 00 00       	jmp    30d <.altinstr_replacement+0x30d>	309: R_X86_64_PC32	.text+0x526d3
030d  30d:	e9 00 00 00 00       	jmp    312 <.altinstr_replacement+0x312>	30e: R_X86_64_PC32	.text+0x5272f
0312  312:	e9 00 00 00 00       	jmp    317 <.altinstr_replacement+0x317>	313: R_X86_64_PC32	.text+0x52b31
0317  317:	e9 00 00 00 00       	jmp    31c <.altinstr_replacement+0x31c>	318: R_X86_64_PC32	.text+0x527ca
031c  31c:	e9 00 00 00 00       	jmp    321 <.altinstr_replacement+0x321>	31d: R_X86_64_PC32	.text+0x52b83
0321  321:	e9 00 00 00 00       	jmp    326 <.altinstr_replacement+0x326>	322: R_X86_64_PC32	.text+0x52f5f
0326  326:	e9 00 00 00 00       	jmp    32b <.altinstr_replacement+0x32b>	327: R_X86_64_PC32	.text+0x52fbb
032b  32b:	e9 00 00 00 00       	jmp    330 <.altinstr_replacement+0x330>	32c: R_X86_64_PC32	.text+0x53419
0330  330:	e9 00 00 00 00       	jmp    335 <.altinstr_replacement+0x335>	331: R_X86_64_PC32	.text+0x530a6
0335  335:	e9 00 00 00 00       	jmp    33a <.altinstr_replacement+0x33a>	336: R_X86_64_PC32	.text+0x53420
033a  33a:	e9 00 00 00 00       	jmp    33f <.altinstr_replacement+0x33f>	33b: R_X86_64_PC32	.text+0x5357d
033f  33f:	e9 00 00 00 00       	jmp    344 <.altinstr_replacement+0x344>	340: R_X86_64_PC32	.text+0x535d9
0344  344:	e9 00 00 00 00       	jmp    349 <.altinstr_replacement+0x349>	345: R_X86_64_PC32	.text+0x539dc
0349  349:	e9 00 00 00 00       	jmp    34e <.altinstr_replacement+0x34e>	34a: R_X86_64_PC32	.text+0x53675
034e  34e:	e9 00 00 00 00       	jmp    353 <.altinstr_replacement+0x353>	34f: R_X86_64_PC32	.text+0x53a2e
0353  353:	e9 00 00 00 00       	jmp    358 <.altinstr_replacement+0x358>	354: R_X86_64_PC32	.text+0x54867
0358  358:	48 0f ae 37          	xsaveopt64 (%rdi)
035c  35c:	48 0f c7 27          	xsavec64 (%rdi)
0360  360:	48 0f c7 2f          	xsaves64 (%rdi)
0364  364:	48 0f c7 1f          	xrstors64 (%rdi)
0368  368:	e9 00 00 00 00       	jmp    36d <.altinstr_replacement+0x36d>	369: R_X86_64_PC32	.text+0x553f0
036d  36d:	e9 00 00 00 00       	jmp    372 <.altinstr_replacement+0x372>	36e: R_X86_64_PC32	.text+0x5560a
0372  372:	e9 00 00 00 00       	jmp    377 <.altinstr_replacement+0x377>	373: R_X86_64_PC32	.text+0x556da
0377  377:	e9 00 00 00 00       	jmp    37c <.altinstr_replacement+0x37c>	378: R_X86_64_PC32	.text+0x559e4
037c  37c:	e9 00 00 00 00       	jmp    381 <.altinstr_replacement+0x381>	37d: R_X86_64_PC32	.text+0x55f14
0381  381:	48 0f c7 1f          	xrstors64 (%rdi)
0385  385:	e9 00 00 00 00       	jmp    38a <.altinstr_replacement+0x38a>	386: R_X86_64_PC32	.text+0x5641c
038a  38a:	e9 00 00 00 00       	jmp    38f <.altinstr_replacement+0x38f>	38b: R_X86_64_PC32	.text+0x5646e
038f  38f:	e9 00 00 00 00       	jmp    394 <.altinstr_replacement+0x394>	390: R_X86_64_PC32	.noinstr.text+0x1abe
0394  394:	0f 01 cb             	stac
0397  397:	e8 00 00 00 00       	call   39c <.altinstr_replacement+0x39c>	398: R_X86_64_PLT32	rep_movs_alternative-0x4
039c  39c:	0f 01 ca             	clac
039f  39f:	e9 00 00 00 00       	jmp    3a4 <.altinstr_replacement+0x3a4>	3a0: R_X86_64_PC32	.text+0x56f35
03a4  3a4:	e9 00 00 00 00       	jmp    3a9 <.altinstr_replacement+0x3a9>	3a5: R_X86_64_PC32	.text+0x571c7
03a9  3a9:	e9 00 00 00 00       	jmp    3ae <.altinstr_replacement+0x3ae>	3aa: R_X86_64_PC32	.text+0x5724c
03ae  3ae:	e9 00 00 00 00       	jmp    3b3 <.altinstr_replacement+0x3b3>	3af: R_X86_64_PC32	.text+0x57384
03b3  3b3:	e9 00 00 00 00       	jmp    3b8 <.altinstr_replacement+0x3b8>	3b4: R_X86_64_PC32	.text+0x57793
03b8  3b8:	e9 00 00 00 00       	jmp    3bd <.altinstr_replacement+0x3bd>	3b9: R_X86_64_PC32	.text+0x579ad
03bd  3bd:	e9 00 00 00 00       	jmp    3c2 <.altinstr_replacement+0x3c2>	3be: R_X86_64_PC32	.text+0x57ac8
03c2  3c2:	48 0f ae 37          	xsaveopt64 (%rdi)
03c6  3c6:	48 0f c7 27          	xsavec64 (%rdi)
03ca  3ca:	48 0f c7 2f          	xsaves64 (%rdi)
03ce  3ce:	0f 01 cb             	stac
03d1  3d1:	0f 01 ca             	clac
03d4  3d4:	0f 01 cb             	stac
03d7  3d7:	e8 00 00 00 00       	call   3dc <.altinstr_replacement+0x3dc>	3d8: R_X86_64_PLT32	rep_movs_alternative-0x4
03dc  3dc:	0f 01 ca             	clac
03df  3df:	e9 00 00 00 00       	jmp    3e4 <.altinstr_replacement+0x3e4>	3e0: R_X86_64_PC32	.text+0x57dde
03e4  3e4:	0f 01 cb             	stac
03e7  3e7:	e8 00 00 00 00       	call   3ec <.altinstr_replacement+0x3ec>	3e8: R_X86_64_PLT32	rep_movs_alternative-0x4
03ec  3ec:	0f 01 ca             	clac
03ef  3ef:	0f 01 cb             	stac
03f2  3f2:	e8 00 00 00 00       	call   3f7 <.altinstr_replacement+0x3f7>	3f3: R_X86_64_PLT32	rep_movs_alternative-0x4
03f7  3f7:	0f 01 ca             	clac
03fa  3fa:	e9 00 00 00 00       	jmp    3ff <.altinstr_replacement+0x3ff>	3fb: R_X86_64_PC32	.text+0x58503
03ff  3ff:	0f 01 cb             	stac
0402  402:	0f 01 ca             	clac
0405  405:	48 0f c7 1f          	xrstors64 (%rdi)
0409  409:	48 0f c7 1f          	xrstors64 (%rdi)
040d  40d:	e9 00 00 00 00       	jmp    412 <.altinstr_replacement+0x412>	40e: R_X86_64_PC32	.text+0x587b7
0412  412:	0f 01 cb             	stac
0415  415:	e8 00 00 00 00       	call   41a <.altinstr_replacement+0x41a>	416: R_X86_64_PLT32	rep_movs_alternative-0x4
041a  41a:	0f 01 ca             	clac
041d  41d:	e9 00 00 00 00       	jmp    422 <.altinstr_replacement+0x422>	41e: R_X86_64_PC32	.text+0x589d8
0422  422:	0f 01 cb             	stac
0425  425:	e8 00 00 00 00       	call   42a <.altinstr_replacement+0x42a>	426: R_X86_64_PLT32	rep_movs_alternative-0x4
042a  42a:	0f 01 ca             	clac
042d  42d:	e9 00 00 00 00       	jmp    432 <.altinstr_replacement+0x432>	42e: R_X86_64_PC32	.text+0x58ac6
0432  432:	e9 00 00 00 00       	jmp    437 <.altinstr_replacement+0x437>	433: R_X86_64_PC32	.text+0x58ae2
0437  437:	e9 00 00 00 00       	jmp    43c <.altinstr_replacement+0x43c>	438: R_X86_64_PC32	.text+0x58bad
043c  43c:	e9 00 00 00 00       	jmp    441 <.altinstr_replacement+0x441>	43d: R_X86_64_PC32	.text+0x58cbb
0441  441:	0f 01 cb             	stac
0444  444:	e8 00 00 00 00       	call   449 <.altinstr_replacement+0x449>	445: R_X86_64_PLT32	rep_stos_alternative-0x4
0449  449:	0f 01 ca             	clac
044c  44c:	e9 00 00 00 00       	jmp    451 <.altinstr_replacement+0x451>	44d: R_X86_64_PC32	.text+0x58fcd
0451  451:	0f 01 cb             	stac
0454  454:	0f 01 ca             	clac
0457  457:	0f 01 cb             	stac
045a  45a:	0f 01 ca             	clac
045d  45d:	0f 01 cb             	stac
0460  460:	e8 00 00 00 00       	call   465 <.altinstr_replacement+0x465>	461: R_X86_64_PLT32	rep_stos_alternative-0x4
0465  465:	0f 01 ca             	clac
0468  468:	e9 00 00 00 00       	jmp    46d <.altinstr_replacement+0x46d>	469: R_X86_64_PC32	.init.text+0x18bea
046d  46d:	e9 00 00 00 00       	jmp    472 <.altinstr_replacement+0x472>	46e: R_X86_64_PC32	.text+0x5926d
0472  472:	e9 00 00 00 00       	jmp    477 <.altinstr_replacement+0x477>	473: R_X86_64_PC32	.text+0x592fa
0477  477:	e9 00 00 00 00       	jmp    47c <.altinstr_replacement+0x47c>	478: R_X86_64_PC32	.text+0x59465
047c  47c:	e9 00 00 00 00       	jmp    481 <.altinstr_replacement+0x481>	47d: R_X86_64_PC32	.init.text+0x18e35
0481  481:	e9 00 00 00 00       	jmp    486 <.altinstr_replacement+0x486>	482: R_X86_64_PC32	.text+0x59e51
0486  486:	e9 00 00 00 00       	jmp    48b <.altinstr_replacement+0x48b>	487: R_X86_64_PC32	.text+0x5a0b4
048b  48b:	e9 00 00 00 00       	jmp    490 <.altinstr_replacement+0x490>	48c: R_X86_64_PC32	.text+0x5a492
0490  490:	e9 00 00 00 00       	jmp    495 <.altinstr_replacement+0x495>	491: R_X86_64_PC32	.text+0x5abf7
0495  495:	e9 00 00 00 00       	jmp    49a <.altinstr_replacement+0x49a>	496: R_X86_64_PC32	.init.text+0x1934d
049a  49a:	e9 00 00 00 00       	jmp    49f <.altinstr_replacement+0x49f>	49b: R_X86_64_PC32	.init.text+0x1935a
049f  49f:	e9 00 00 00 00       	jmp    4a4 <.altinstr_replacement+0x4a4>	4a0: R_X86_64_PC32	.init.text+0x1955a
04a4  4a4:	e9 00 00 00 00       	jmp    4a9 <.altinstr_replacement+0x4a9>	4a5: R_X86_64_PC32	.init.text+0x198a9
04a9  4a9:	e9 00 00 00 00       	jmp    4ae <.altinstr_replacement+0x4ae>	4aa: R_X86_64_PC32	.init.text+0x198e1
04ae  4ae:	e9 00 00 00 00       	jmp    4b3 <.altinstr_replacement+0x4b3>	4af: R_X86_64_PC32	.init.text+0x19a58
04b3  4b3:	e9 00 00 00 00       	jmp    4b8 <.altinstr_replacement+0x4b8>	4b4: R_X86_64_PC32	.init.text+0x19a8f
04b8  4b8:	e9 00 00 00 00       	jmp    4bd <.altinstr_replacement+0x4bd>	4b9: R_X86_64_PC32	.text+0x5ad17
04bd  4bd:	e9 00 00 00 00       	jmp    4c2 <.altinstr_replacement+0x4c2>	4be: R_X86_64_PC32	.text+0x5ad61
04c2  4c2:	e9 00 00 00 00       	jmp    4c7 <.altinstr_replacement+0x4c7>	4c3: R_X86_64_PC32	.text+0x5af6b
04c7  4c7:	e9 00 00 00 00       	jmp    4cc <.altinstr_replacement+0x4cc>	4c8: R_X86_64_PC32	.text+0x5aed0
04cc  4cc:	e9 00 00 00 00       	jmp    4d1 <.altinstr_replacement+0x4d1>	4cd: R_X86_64_PC32	.text+0x5af24
04d1  4d1:	e9 00 00 00 00       	jmp    4d6 <.altinstr_replacement+0x4d6>	4d2: R_X86_64_PC32	.text+0x5af7b
04d6  4d6:	e9 00 00 00 00       	jmp    4db <.altinstr_replacement+0x4db>	4d7: R_X86_64_PC32	.text+0x5bc70
04db  4db:	e9 00 00 00 00       	jmp    4e0 <.altinstr_replacement+0x4e0>	4dc: R_X86_64_PC32	.text+0x5f548
04e0  4e0:	0f 01 cb             	stac
04e3  4e3:	e8 00 00 00 00       	call   4e8 <.altinstr_replacement+0x4e8>	4e4: R_X86_64_PLT32	rep_movs_alternative-0x4
04e8  4e8:	0f 01 ca             	clac
04eb  4eb:	e9 00 00 00 00       	jmp    4f0 <.altinstr_replacement+0x4f0>	4ec: R_X86_64_PC32	.text+0x638eb
04f0  4f0:	e9 00 00 00 00       	jmp    4f5 <.altinstr_replacement+0x4f5>	4f1: R_X86_64_PC32	.text+0x63905
04f5  4f5:	e9 00 00 00 00       	jmp    4fa <.altinstr_replacement+0x4fa>	4f6: R_X86_64_PC32	.text+0x6390f
04fa  4fa:	e9 00 00 00 00       	jmp    4ff <.altinstr_replacement+0x4ff>	4fb: R_X86_64_PC32	.text+0x63916
04ff  4ff:	e9 00 00 00 00       	jmp    504 <.altinstr_replacement+0x504>	500: R_X86_64_PC32	.text+0x6392a
0504  504:	e9 00 00 00 00       	jmp    509 <.altinstr_replacement+0x509>	505: R_X86_64_PC32	.text+0x6394a
0509  509:	e9 00 00 00 00       	jmp    50e <.altinstr_replacement+0x50e>	50a: R_X86_64_PC32	.text+0x65557
050e  50e:	e9 00 00 00 00       	jmp    513 <.altinstr_replacement+0x513>	50f: R_X86_64_PC32	.text+0x66ec9
0513  513:	e9 00 00 00 00       	jmp    518 <.altinstr_replacement+0x518>	514: R_X86_64_PC32	.text+0x67064
0518  518:	e9 00 00 00 00       	jmp    51d <.altinstr_replacement+0x51d>	519: R_X86_64_PC32	.text+0x67064
051d  51d:	e9 00 00 00 00       	jmp    522 <.altinstr_replacement+0x522>	51e: R_X86_64_PC32	.text+0x67064
0522  522:	e9 00 00 00 00       	jmp    527 <.altinstr_replacement+0x527>	523: R_X86_64_PC32	.init.text+0x1bc5a
0527  527:	e9 00 00 00 00       	jmp    52c <.altinstr_replacement+0x52c>	528: R_X86_64_PC32	.init.text+0x1bc61
052c  52c:	0f 30                	wrmsr
052e  52e:	e9 00 00 00 00       	jmp    533 <.altinstr_replacement+0x533>	52f: R_X86_64_PC32	.text+0x697f5
0533  533:	e9 00 00 00 00       	jmp    538 <.altinstr_replacement+0x538>	534: R_X86_64_PC32	.text+0x69852
0538  538:	e9 00 00 00 00       	jmp    53d <.altinstr_replacement+0x53d>	539: R_X86_64_PC32	.text+0x698ad
053d  53d:	e9 00 00 00 00       	jmp    542 <.altinstr_replacement+0x542>	53e: R_X86_64_PC32	.text+0x69863
0542  542:	e9 00 00 00 00       	jmp    547 <.altinstr_replacement+0x547>	543: R_X86_64_PC32	.init.text+0x1d7d0
0547  547:	e9 00 00 00 00       	jmp    54c <.altinstr_replacement+0x54c>	548: R_X86_64_PC32	.init.text+0x1e19f
054c  54c:	e9 00 00 00 00       	jmp    551 <.altinstr_replacement+0x551>	54d: R_X86_64_PC32	.text+0x6a91f
0551  551:	e9 00 00 00 00       	jmp    556 <.altinstr_replacement+0x556>	552: R_X86_64_PC32	.text+0x6aae0
0556  556:	e9 00 00 00 00       	jmp    55b <.altinstr_replacement+0x55b>	557: R_X86_64_PC32	.text+0x6ab41
055b  55b:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0560  560:	e9 00 00 00 00       	jmp    565 <.altinstr_replacement+0x565>	561: R_X86_64_PC32	.text+0x6f633
0565  565:	e9 00 00 00 00       	jmp    56a <.altinstr_replacement+0x56a>	566: R_X86_64_PC32	.text+0x6f7b0
056a  56a:	e9 00 00 00 00       	jmp    56f <.altinstr_replacement+0x56f>	56b: R_X86_64_PC32	.text+0x6f89b
056f  56f:	e9 00 00 00 00       	jmp    574 <.altinstr_replacement+0x574>	570: R_X86_64_PC32	.text+0x6f89b
0574  574:	e9 00 00 00 00       	jmp    579 <.altinstr_replacement+0x579>	575: R_X86_64_PC32	.text+0x72323
0579  579:	e9 00 00 00 00       	jmp    57e <.altinstr_replacement+0x57e>	57a: R_X86_64_PC32	.text+0x723e2
057e  57e:	e9 00 00 00 00       	jmp    583 <.altinstr_replacement+0x583>	57f: R_X86_64_PC32	.text+0x7419e
0583  583:	e9 00 00 00 00       	jmp    588 <.altinstr_replacement+0x588>	584: R_X86_64_PC32	.text+0x74433
0588  588:	e9 00 00 00 00       	jmp    58d <.altinstr_replacement+0x58d>	589: R_X86_64_PC32	.text+0x74452
058d  58d:	e9 00 00 00 00       	jmp    592 <.altinstr_replacement+0x592>	58e: R_X86_64_PC32	.text+0x74471
0592  592:	e9 00 00 00 00       	jmp    597 <.altinstr_replacement+0x597>	593: R_X86_64_PC32	.text+0x76d37
0597  597:	e9 00 00 00 00       	jmp    59c <.altinstr_replacement+0x59c>	598: R_X86_64_PC32	.text+0x76d57
059c  59c:	e9 00 00 00 00       	jmp    5a1 <.altinstr_replacement+0x5a1>	59d: R_X86_64_PC32	.text+0x76e78
05a1  5a1:	e9 00 00 00 00       	jmp    5a6 <.altinstr_replacement+0x5a6>	5a2: R_X86_64_PC32	.noinstr.text+0x2063
05a6  5a6:	e9 00 00 00 00       	jmp    5ab <.altinstr_replacement+0x5ab>	5a7: R_X86_64_PC32	.noinstr.text+0x208c
05ab  5ab:	e9 00 00 00 00       	jmp    5b0 <.altinstr_replacement+0x5b0>	5ac: R_X86_64_PC32	.text+0x788e9
05b0  5b0:	e9 00 00 00 00       	jmp    5b5 <.altinstr_replacement+0x5b5>	5b1: R_X86_64_PC32	.text+0x78e04
05b5  5b5:	e9 00 00 00 00       	jmp    5ba <.altinstr_replacement+0x5ba>	5b6: R_X86_64_PC32	.text+0x78eb7
05ba  5ba:	e9 00 00 00 00       	jmp    5bf <.altinstr_replacement+0x5bf>	5bb: R_X86_64_PC32	.noinstr.text+0x2339
05bf  5bf:	e9 00 00 00 00       	jmp    5c4 <.altinstr_replacement+0x5c4>	5c0: R_X86_64_PC32	.noinstr.text+0x2522
05c4  5c4:	e9 00 00 00 00       	jmp    5c9 <.altinstr_replacement+0x5c9>	5c5: R_X86_64_PC32	.noinstr.text+0x2666
05c9  5c9:	e9 00 00 00 00       	jmp    5ce <.altinstr_replacement+0x5ce>	5ca: R_X86_64_PC32	.noinstr.text+0x2847
05ce  5ce:	e9 00 00 00 00       	jmp    5d3 <.altinstr_replacement+0x5d3>	5cf: R_X86_64_PC32	.noinstr.text+0x28ea
05d3  5d3:	e9 00 00 00 00       	jmp    5d8 <.altinstr_replacement+0x5d8>	5d4: R_X86_64_PC32	.text+0x79710
05d8  5d8:	e9 00 00 00 00       	jmp    5dd <.altinstr_replacement+0x5dd>	5d9: R_X86_64_PC32	.text+0x7a3fa
05dd  5dd:	0f ae e8             	lfence
05e0  5e0:	0f 31                	rdtsc
05e2  5e2:	0f 01 f9             	rdtscp
05e5  5e5:	e9 00 00 00 00       	jmp    5ea <.altinstr_replacement+0x5ea>	5e6: R_X86_64_PC32	.text+0x7b8ae
05ea  5ea:	e9 00 00 00 00       	jmp    5ef <.altinstr_replacement+0x5ef>	5eb: R_X86_64_PC32	.text+0x7bac7
05ef  5ef:	e9 00 00 00 00       	jmp    5f4 <.altinstr_replacement+0x5f4>	5f0: R_X86_64_PC32	.text+0x7b9a4
05f4  5f4:	e9 00 00 00 00       	jmp    5f9 <.altinstr_replacement+0x5f9>	5f5: R_X86_64_PC32	.text+0x7ba13
05f9  5f9:	0f ae e8             	lfence
05fc  5fc:	0f 31                	rdtsc
05fe  5fe:	0f 01 f9             	rdtscp
0601  601:	0f ae e8             	lfence
0604  604:	0f 31                	rdtsc
0606  606:	0f 01 f9             	rdtscp
0609  609:	0f ae e8             	lfence
060c  60c:	0f 31                	rdtsc
060e  60e:	0f 01 f9             	rdtscp
0611  611:	0f 01 c1             	vmcall
0614  614:	0f 01 d9             	vmmcall
0617  617:	e9 00 00 00 00       	jmp    61c <.altinstr_replacement+0x61c>	618: R_X86_64_PC32	.cpuidle.text+0xdf
061c  61c:	e9 00 00 00 00       	jmp    621 <.altinstr_replacement+0x621>	61d: R_X86_64_PC32	.cpuidle.text+0x10b
0621  621:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0626  626:	f3 48 0f b8 c7       	popcnt %rdi,%rax
062b  62b:	e9 00 00 00 00       	jmp    630 <.altinstr_replacement+0x630>	62c: R_X86_64_PC32	.init.text+0x26417
0630  630:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0635  635:	e9 00 00 00 00       	jmp    63a <.altinstr_replacement+0x63a>	636: R_X86_64_PC32	.init.text+0x26b68
063a  63a:	0f ae e8             	lfence
063d  63d:	0f 31                	rdtsc
063f  63f:	0f 01 f9             	rdtscp
0642  642:	0f ae e8             	lfence
0645  645:	0f 31                	rdtsc
0647  647:	0f 01 f9             	rdtscp
064a  64a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
064f  64f:	87 3c 25 00 c3 5f ff 	xchg   %edi,0xffffffffff5fc300
0656  656:	87 3c 25 10 c3 5f ff 	xchg   %edi,0xffffffffff5fc310
065d  65d:	87 3c 25 10 c3 5f ff 	xchg   %edi,0xffffffffff5fc310
0664  664:	87 34 25 00 c3 5f ff 	xchg   %esi,0xffffffffff5fc300
066b  66b:	87 b7 00 c0 5f ff    	xchg   %esi,-0xa04000(%rdi)
0671  671:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0676  676:	0f ae e8             	lfence
0679  679:	0f 31                	rdtsc
067b  67b:	0f 01 f9             	rdtscp
067e  67e:	e8 00 00 00 00       	call   683 <.altinstr_replacement+0x683>	67f: R_X86_64_PLT32	clear_page_rep-0x4
0683  683:	e8 00 00 00 00       	call   688 <.altinstr_replacement+0x688>	684: R_X86_64_PLT32	clear_page_erms-0x4
0688  688:	e8 00 00 00 00       	call   68d <.altinstr_replacement+0x68d>	689: R_X86_64_PLT32	clear_page_rep-0x4
068d  68d:	e8 00 00 00 00       	call   692 <.altinstr_replacement+0x692>	68e: R_X86_64_PLT32	clear_page_erms-0x4
0692  692:	e9 00 00 00 00       	jmp    697 <.altinstr_replacement+0x697>	693: R_X86_64_PC32	.init.text+0x2f90b
0697  697:	f3 48 0f b8 c7       	popcnt %rdi,%rax
069c  69c:	0f 01 d9             	vmmcall
069f  69f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
06a4  6a4:	f3 48 0f b8 c7       	popcnt %rdi,%rax
06a9  6a9:	0f ae e8             	lfence
06ac  6ac:	0f 31                	rdtsc
06ae  6ae:	0f 01 f9             	rdtscp
06b1  6b1:	0f ae e8             	lfence
06b4  6b4:	0f 31                	rdtsc
06b6  6b6:	0f 01 f9             	rdtscp
06b9  6b9:	e8 00 00 00 00       	call   6be <.altinstr_replacement+0x6be>	6ba: R_X86_64_PLT32	clear_page_rep-0x4
06be  6be:	e8 00 00 00 00       	call   6c3 <.altinstr_replacement+0x6c3>	6bf: R_X86_64_PLT32	clear_page_erms-0x4
06c3  6c3:	f3 48 0f b8 c7       	popcnt %rdi,%rax
06c8  6c8:	e9 00 00 00 00       	jmp    6cd <.altinstr_replacement+0x6cd>	6c9: R_X86_64_PC32	.text+0xbdafb
06cd  6cd:	e9 00 00 00 00       	jmp    6d2 <.altinstr_replacement+0x6d2>	6ce: R_X86_64_PC32	.text+0xbf079
06d2  6d2:	e9 00 00 00 00       	jmp    6d7 <.altinstr_replacement+0x6d7>	6d3: R_X86_64_PC32	.text+0xbf3c5
06d7  6d7:	0f 0d 88 e0 00 00 00 	prefetchw 0xe0(%rax)
06de  6de:	e9 00 00 00 00       	jmp    6e3 <.altinstr_replacement+0x6e3>	6df: R_X86_64_PC32	.text+0xc0f6a
06e3  6e3:	0f 30                	wrmsr
06e5  6e5:	e9 00 00 00 00       	jmp    6ea <.altinstr_replacement+0x6ea>	6e6: R_X86_64_PC32	.text+0xc32fe
06ea  6ea:	e9 00 00 00 00       	jmp    6ef <.altinstr_replacement+0x6ef>	6eb: R_X86_64_PC32	.text+0xc40b9
06ef  6ef:	e9 00 00 00 00       	jmp    6f4 <.altinstr_replacement+0x6f4>	6f0: R_X86_64_PC32	.text+0xc40d5
06f4  6f4:	e9 00 00 00 00       	jmp    6f9 <.altinstr_replacement+0x6f9>	6f5: R_X86_64_PC32	.text+0xc4f02
06f9  6f9:	e9 00 00 00 00       	jmp    6fe <.altinstr_replacement+0x6fe>	6fa: R_X86_64_PC32	.text+0xc5000
06fe  6fe:	e9 00 00 00 00       	jmp    703 <.altinstr_replacement+0x703>	6ff: R_X86_64_PC32	.text+0xc5090
0703  703:	e9 00 00 00 00       	jmp    708 <.altinstr_replacement+0x708>	704: R_X86_64_PC32	.text+0xc512c
0708  708:	66 0f ae 38          	clflushopt (%rax)
070c  70c:	e9 00 00 00 00       	jmp    711 <.altinstr_replacement+0x711>	70d: R_X86_64_PC32	.text+0xc7446
0711  711:	e9 00 00 00 00       	jmp    716 <.altinstr_replacement+0x716>	712: R_X86_64_PC32	.text+0xc7a30
0716  716:	e9 00 00 00 00       	jmp    71b <.altinstr_replacement+0x71b>	717: R_X86_64_PC32	.init.text+0x343e3
071b  71b:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0720  720:	e9 00 00 00 00       	jmp    725 <.altinstr_replacement+0x725>	721: R_X86_64_PC32	.init.text+0x370f7
0725  725:	e9 00 00 00 00       	jmp    72a <.altinstr_replacement+0x72a>	726: R_X86_64_PC32	.text+0xcdf14
072a  72a:	e9 00 00 00 00       	jmp    72f <.altinstr_replacement+0x72f>	72b: R_X86_64_PC32	.text+0xce006
072f  72f:	e9 00 00 00 00       	jmp    734 <.altinstr_replacement+0x734>	730: R_X86_64_PC32	.text+0xce1ff
0734  734:	e9 00 00 00 00       	jmp    739 <.altinstr_replacement+0x739>	735: R_X86_64_PC32	.text+0x165cac
0739  739:	e9 00 00 00 00       	jmp    73e <.altinstr_replacement+0x73e>	73a: R_X86_64_PC32	.text+0x1671b4
073e  73e:	e9 00 00 00 00       	jmp    743 <.altinstr_replacement+0x743>	73f: R_X86_64_PC32	.text+0x169ba8
0743  743:	0f 01 cb             	stac
0746  746:	0f ae e8             	lfence
0749  749:	0f 01 ca             	clac
074c  74c:	0f 01 ca             	clac
074f  74f:	0f 01 cb             	stac
0752  752:	0f ae e8             	lfence
0755  755:	0f 01 ca             	clac
0758  758:	0f 01 ca             	clac
075b  75b:	0f 01 cb             	stac
075e  75e:	e8 00 00 00 00       	call   763 <.altinstr_replacement+0x763>	75f: R_X86_64_PLT32	rep_stos_alternative-0x4
0763  763:	0f 01 ca             	clac
0766  766:	f3 48 0f b8 c7       	popcnt %rdi,%rax
076b  76b:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0770  770:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0775  775:	f3 48 0f b8 c7       	popcnt %rdi,%rax
077a  77a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
077f  77f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0784  784:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0789  789:	f3 48 0f b8 c7       	popcnt %rdi,%rax
078e  78e:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0793  793:	41 0f 0d 0e          	prefetchw (%r14)
0797  797:	f3 48 0f b8 c7       	popcnt %rdi,%rax
079c  79c:	f3 48 0f b8 c7       	popcnt %rdi,%rax
07a1  7a1:	f3 48 0f b8 c7       	popcnt %rdi,%rax
07a6  7a6:	f3 48 0f b8 c7       	popcnt %rdi,%rax
07ab  7ab:	65 48 23 3c 25 00 00 00 00 	and    %gs:0x0,%rdi	7b0: R_X86_64_32S	tlbstate_untag_mask
07b4  7b4:	f3 48 0f b8 c7       	popcnt %rdi,%rax
07b9  7b9:	0f 01 cb             	stac
07bc  7bc:	0f ae e8             	lfence
07bf  7bf:	0f 01 ca             	clac
07c2  7c2:	0f 01 cb             	stac
07c5  7c5:	0f ae e8             	lfence
07c8  7c8:	0f 01 ca             	clac
07cb  7cb:	0f 01 ca             	clac
07ce  7ce:	0f 01 ca             	clac
07d1  7d1:	f3 48 0f b8 c7       	popcnt %rdi,%rax
07d6  7d6:	e8 00 00 00 00       	call   7db <.altinstr_replacement+0x7db>	7d7: R_X86_64_PLT32	clear_page_rep-0x4
07db  7db:	e8 00 00 00 00       	call   7e0 <.altinstr_replacement+0x7e0>	7dc: R_X86_64_PLT32	clear_page_erms-0x4
07e0  7e0:	0f 01 cb             	stac
07e3  7e3:	0f ae e8             	lfence
07e6  7e6:	0f 01 ca             	clac
07e9  7e9:	0f 01 ca             	clac
07ec  7ec:	0f 01 cb             	stac
07ef  7ef:	0f ae e8             	lfence
07f2  7f2:	0f 01 ca             	clac
07f5  7f5:	0f 01 ca             	clac
07f8  7f8:	f3 48 0f b8 c7       	popcnt %rdi,%rax
07fd  7fd:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0802  802:	0f 01 cb             	stac
0805  805:	e8 00 00 00 00       	call   80a <.altinstr_replacement+0x80a>	806: R_X86_64_PLT32	rep_movs_alternative-0x4
080a  80a:	0f 01 ca             	clac
080d  80d:	0f 01 cb             	stac
0810  810:	e8 00 00 00 00       	call   815 <.altinstr_replacement+0x815>	811: R_X86_64_PLT32	rep_movs_alternative-0x4
0815  815:	0f 01 ca             	clac
0818  818:	f3 48 0f b8 c7       	popcnt %rdi,%rax
081d  81d:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0822  822:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0827  827:	f3 48 0f b8 c7       	popcnt %rdi,%rax
082c  82c:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0831  831:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0836  836:	f3 48 0f b8 c7       	popcnt %rdi,%rax
083b  83b:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0840  840:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0845  845:	41 0f 0d 0c 06       	prefetchw (%r14,%rax,1)
084a  84a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
084f  84f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0854  854:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0859  859:	0f 01 cb             	stac
085c  85c:	e8 00 00 00 00       	call   861 <.altinstr_replacement+0x861>	85d: R_X86_64_PLT32	rep_movs_alternative-0x4
0861  861:	0f 01 ca             	clac
0864  864:	0f 01 cb             	stac
0867  867:	e8 00 00 00 00       	call   86c <.altinstr_replacement+0x86c>	868: R_X86_64_PLT32	rep_movs_alternative-0x4
086c  86c:	0f 01 ca             	clac
086f  86f:	0f 0d 48 f8          	prefetchw -0x8(%rax)
0873  873:	e8 00 00 00 00       	call   878 <.altinstr_replacement+0x878>	874: R_X86_64_PLT32	clear_page_rep-0x4
0878  878:	e8 00 00 00 00       	call   87d <.altinstr_replacement+0x87d>	879: R_X86_64_PLT32	clear_page_erms-0x4
087d  87d:	e8 00 00 00 00       	call   882 <.altinstr_replacement+0x882>	87e: R_X86_64_PLT32	clear_page_rep-0x4
0882  882:	e8 00 00 00 00       	call   887 <.altinstr_replacement+0x887>	883: R_X86_64_PLT32	clear_page_erms-0x4
0887  887:	f3 48 0f b8 c7       	popcnt %rdi,%rax
088c  88c:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0891  891:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0896  896:	f3 48 0f b8 c7       	popcnt %rdi,%rax
089b  89b:	e9 00 00 00 00       	jmp    8a0 <.altinstr_replacement+0x8a0>	89c: R_X86_64_PC32	.text+0x54aff9
08a0  8a0:	65 48 23 1c 25 00 00 00 00 	and    %gs:0x0,%rbx	8a5: R_X86_64_32S	tlbstate_untag_mask
08a9  8a9:	0f 01 cb             	stac
08ac  8ac:	0f ae e8             	lfence
08af  8af:	0f 01 ca             	clac
08b2  8b2:	0f 01 cb             	stac
08b5  8b5:	0f ae e8             	lfence
08b8  8b8:	0f 01 ca             	clac
08bb  8bb:	f3 48 0f b8 c7       	popcnt %rdi,%rax
08c0  8c0:	e8 00 00 00 00       	call   8c5 <.altinstr_replacement+0x8c5>	8c1: R_X86_64_PLT32	clear_page_rep-0x4
08c5  8c5:	e8 00 00 00 00       	call   8ca <.altinstr_replacement+0x8ca>	8c6: R_X86_64_PLT32	clear_page_erms-0x4
08ca  8ca:	0f 01 cb             	stac
08cd  8cd:	e8 00 00 00 00       	call   8d2 <.altinstr_replacement+0x8d2>	8ce: R_X86_64_PLT32	rep_movs_alternative-0x4
08d2  8d2:	0f 01 ca             	clac
08d5  8d5:	0f 01 cb             	stac
08d8  8d8:	e8 00 00 00 00       	call   8dd <.altinstr_replacement+0x8dd>	8d9: R_X86_64_PLT32	rep_movs_alternative-0x4
08dd  8dd:	0f 01 ca             	clac
08e0  8e0:	e8 00 00 00 00       	call   8e5 <.altinstr_replacement+0x8e5>	8e1: R_X86_64_PLT32	clear_page_rep-0x4
08e5  8e5:	e8 00 00 00 00       	call   8ea <.altinstr_replacement+0x8ea>	8e6: R_X86_64_PLT32	clear_page_erms-0x4
08ea  8ea:	e8 00 00 00 00       	call   8ef <.altinstr_replacement+0x8ef>	8eb: R_X86_64_PLT32	clear_page_rep-0x4
08ef  8ef:	e8 00 00 00 00       	call   8f4 <.altinstr_replacement+0x8f4>	8f0: R_X86_64_PLT32	clear_page_erms-0x4
08f4  8f4:	e9 00 00 00 00       	jmp    8f9 <.altinstr_replacement+0x8f9>	8f5: R_X86_64_PC32	.text+0x5620a8
08f9  8f9:	65 4c 23 24 25 00 00 00 00 	and    %gs:0x0,%r12	8fe: R_X86_64_32S	tlbstate_untag_mask
0902  902:	65 48 23 04 25 00 00 00 00 	and    %gs:0x0,%rax	907: R_X86_64_32S	tlbstate_untag_mask
090b  90b:	65 48 23 3c 25 00 00 00 00 	and    %gs:0x0,%rdi	910: R_X86_64_32S	tlbstate_untag_mask
0914  914:	e9 00 00 00 00       	jmp    919 <.altinstr_replacement+0x919>	915: R_X86_64_PC32	.text+0x57502a
0919  919:	e9 00 00 00 00       	jmp    91e <.altinstr_replacement+0x91e>	91a: R_X86_64_PC32	.text+0x577cc1
091e  91e:	e9 00 00 00 00       	jmp    923 <.altinstr_replacement+0x923>	91f: R_X86_64_PC32	.text+0x578804
0923  923:	65 48 23 1c 25 00 00 00 00 	and    %gs:0x0,%rbx	928: R_X86_64_32S	tlbstate_untag_mask
092c  92c:	e9 00 00 00 00       	jmp    931 <.altinstr_replacement+0x931>	92d: R_X86_64_PC32	.text+0x57ad02
0931  931:	65 4c 23 3c 25 00 00 00 00 	and    %gs:0x0,%r15	936: R_X86_64_32S	tlbstate_untag_mask
093a  93a:	65 48 23 1c 25 00 00 00 00 	and    %gs:0x0,%rbx	93f: R_X86_64_32S	tlbstate_untag_mask
0943  943:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0948  948:	f3 48 0f b8 c7       	popcnt %rdi,%rax
094d  94d:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0952  952:	e8 00 00 00 00       	call   957 <.altinstr_replacement+0x957>	953: R_X86_64_PLT32	clear_page_rep-0x4
0957  957:	e8 00 00 00 00       	call   95c <.altinstr_replacement+0x95c>	958: R_X86_64_PLT32	clear_page_erms-0x4
095c  95c:	41 0f 0d 0c 24       	prefetchw (%r12)
0961  961:	0f 0d 09             	prefetchw (%rcx)
0964  964:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0969  969:	65 48 23 04 25 00 00 00 00 	and    %gs:0x0,%rax	96e: R_X86_64_32S	tlbstate_untag_mask
0972  972:	0f 01 cb             	stac
0975  975:	e8 00 00 00 00       	call   97a <.altinstr_replacement+0x97a>	976: R_X86_64_PLT32	rep_stos_alternative-0x4
097a  97a:	0f 01 ca             	clac
097d  97d:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0982  982:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0987  987:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
098c  98c:	0f 94 c0             	sete   %al
098f  98f:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0993  993:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
0998  998:	0f 94 c0             	sete   %al
099b  99b:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
099f  99f:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
09a4  9a4:	0f 94 c0             	sete   %al
09a7  9a7:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
09ac  9ac:	0f 94 c0             	sete   %al
09af  9af:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
09b3  9b3:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
09b8  9b8:	0f 94 c0             	sete   %al
09bb  9bb:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
09bf  9bf:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
09c4  9c4:	0f 94 c0             	sete   %al
09c7  9c7:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
09cc  9cc:	0f 94 c0             	sete   %al
09cf  9cf:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
09d4  9d4:	0f 94 c0             	sete   %al
09d7  9d7:	9c                   	pushf
09d8  9d8:	8f 85 68 ff ff ff    	pop    -0x98(%rbp)
09de  9de:	0f 01 ca             	clac
09e1  9e1:	ff b5 68 ff ff ff    	push   -0x98(%rbp)
09e7  9e7:	9d                   	popf
09e8  9e8:	f3 48 0f b8 c7       	popcnt %rdi,%rax
09ed  9ed:	e8 00 00 00 00       	call   9f2 <.altinstr_replacement+0x9f2>	9ee: R_X86_64_PLT32	clear_page_rep-0x4
09f2  9f2:	e8 00 00 00 00       	call   9f7 <.altinstr_replacement+0x9f7>	9f3: R_X86_64_PLT32	clear_page_erms-0x4
09f7  9f7:	e8 00 00 00 00       	call   9fc <.altinstr_replacement+0x9fc>	9f8: R_X86_64_PLT32	clear_page_rep-0x4
09fc  9fc:	e8 00 00 00 00       	call   a01 <.altinstr_replacement+0xa01>	9fd: R_X86_64_PLT32	clear_page_erms-0x4
0a01  a01:	e8 00 00 00 00       	call   a06 <.altinstr_replacement+0xa06>	a02: R_X86_64_PLT32	clear_page_rep-0x4
0a06  a06:	e8 00 00 00 00       	call   a0b <.altinstr_replacement+0xa0b>	a07: R_X86_64_PLT32	clear_page_erms-0x4
0a0b  a0b:	0f 01 cb             	stac
0a0e  a0e:	0f ae e8             	lfence
0a11  a11:	0f 01 ca             	clac
0a14  a14:	0f 01 ca             	clac
0a17  a17:	0f 01 cb             	stac
0a1a  a1a:	0f ae e8             	lfence
0a1d  a1d:	0f 01 ca             	clac
0a20  a20:	0f 01 ca             	clac
0a23  a23:	0f 01 cb             	stac
0a26  a26:	0f ae e8             	lfence
0a29  a29:	0f 01 ca             	clac
0a2c  a2c:	0f 01 ca             	clac
0a2f  a2f:	0f 01 cb             	stac
0a32  a32:	0f ae e8             	lfence
0a35  a35:	0f 01 ca             	clac
0a38  a38:	0f 01 ca             	clac
0a3b  a3b:	0f 01 cb             	stac
0a3e  a3e:	0f ae e8             	lfence
0a41  a41:	0f 01 ca             	clac
0a44  a44:	0f 01 ca             	clac
0a47  a47:	0f 01 cb             	stac
0a4a  a4a:	e8 00 00 00 00       	call   a4f <.altinstr_replacement+0xa4f>	a4b: R_X86_64_PLT32	rep_movs_alternative-0x4
0a4f  a4f:	0f 01 ca             	clac
0a52  a52:	0f 01 cb             	stac
0a55  a55:	0f ae e8             	lfence
0a58  a58:	0f 01 ca             	clac
0a5b  a5b:	0f 01 ca             	clac
0a5e  a5e:	0f 01 cb             	stac
0a61  a61:	0f ae e8             	lfence
0a64  a64:	0f 01 ca             	clac
0a67  a67:	0f 01 ca             	clac
0a6a  a6a:	0f 01 cb             	stac
0a6d  a6d:	0f ae e8             	lfence
0a70  a70:	0f 01 ca             	clac
0a73  a73:	0f 01 ca             	clac
0a76  a76:	0f 0d 8f c0 09 00 00 	prefetchw 0x9c0(%rdi)
0a7d  a7d:	f3 0f b8 c7          	popcnt %edi,%eax
0a81  a81:	0f 01 cb             	stac
0a84  a84:	e8 00 00 00 00       	call   a89 <.altinstr_replacement+0xa89>	a85: R_X86_64_PLT32	rep_stos_alternative-0x4
0a89  a89:	0f 01 ca             	clac
0a8c  a8c:	0f 01 cb             	stac
0a8f  a8f:	e8 00 00 00 00       	call   a94 <.altinstr_replacement+0xa94>	a90: R_X86_64_PLT32	rep_stos_alternative-0x4
0a94  a94:	0f 01 ca             	clac
0a97  a97:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0a9c  a9c:	0f 01 cb             	stac
0a9f  a9f:	e8 00 00 00 00       	call   aa4 <.altinstr_replacement+0xaa4>	aa0: R_X86_64_PLT32	rep_stos_alternative-0x4
0aa4  aa4:	0f 01 ca             	clac
0aa7  aa7:	0f 01 cb             	stac
0aaa  aaa:	e8 00 00 00 00       	call   aaf <.altinstr_replacement+0xaaf>	aab: R_X86_64_PLT32	rep_stos_alternative-0x4
0aaf  aaf:	0f 01 ca             	clac
0ab2  ab2:	0f 01 cb             	stac
0ab5  ab5:	e8 00 00 00 00       	call   aba <.altinstr_replacement+0xaba>	ab6: R_X86_64_PLT32	rep_stos_alternative-0x4
0aba  aba:	0f 01 ca             	clac
0abd  abd:	0f 01 cb             	stac
0ac0  ac0:	e8 00 00 00 00       	call   ac5 <.altinstr_replacement+0xac5>	ac1: R_X86_64_PLT32	rep_stos_alternative-0x4
0ac5  ac5:	0f 01 ca             	clac
0ac8  ac8:	e9 00 00 00 00       	jmp    acd <.altinstr_replacement+0xacd>	ac9: R_X86_64_PC32	.text+0x70ac6a
0acd  acd:	0f 01 cb             	stac
0ad0  ad0:	e8 00 00 00 00       	call   ad5 <.altinstr_replacement+0xad5>	ad1: R_X86_64_PLT32	rep_stos_alternative-0x4
0ad5  ad5:	0f 01 ca             	clac
0ad8  ad8:	0f 01 cb             	stac
0adb  adb:	e8 00 00 00 00       	call   ae0 <.altinstr_replacement+0xae0>	adc: R_X86_64_PLT32	rep_stos_alternative-0x4
0ae0  ae0:	0f 01 ca             	clac
0ae3  ae3:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0ae8  ae8:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0aed  aed:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0af2  af2:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0af7  af7:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0afc  afc:	0f 01 cb             	stac
0aff  aff:	0f ae e8             	lfence
0b02  b02:	0f 01 ca             	clac
0b05  b05:	0f 01 cb             	stac
0b08  b08:	0f ae e8             	lfence
0b0b  b0b:	0f 01 ca             	clac
0b0e  b0e:	0f 01 cb             	stac
0b11  b11:	e8 00 00 00 00       	call   b16 <.altinstr_replacement+0xb16>	b12: R_X86_64_PLT32	rep_movs_alternative-0x4
0b16  b16:	0f 01 ca             	clac
0b19  b19:	0f 01 cb             	stac
0b1c  b1c:	e8 00 00 00 00       	call   b21 <.altinstr_replacement+0xb21>	b1d: R_X86_64_PLT32	rep_movs_alternative-0x4
0b21  b21:	0f 01 ca             	clac
0b24  b24:	0f 01 cb             	stac
0b27  b27:	0f 01 ca             	clac
0b2a  b2a:	0f 01 cb             	stac
0b2d  b2d:	e8 00 00 00 00       	call   b32 <.altinstr_replacement+0xb32>	b2e: R_X86_64_PLT32	rep_stos_alternative-0x4
0b32  b32:	0f 01 ca             	clac
0b35  b35:	0f 01 cb             	stac
0b38  b38:	e8 00 00 00 00       	call   b3d <.altinstr_replacement+0xb3d>	b39: R_X86_64_PLT32	rep_stos_alternative-0x4
0b3d  b3d:	0f 01 ca             	clac
0b40  b40:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0b45  b45:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0b4a  b4a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0b4f  b4f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0b54  b54:	f3 0f b8 c7          	popcnt %edi,%eax
0b58  b58:	0f ae e8             	lfence
0b5b  b5b:	0f 01 cb             	stac
0b5e  b5e:	e8 00 00 00 00       	call   b63 <.altinstr_replacement+0xb63>	b5f: R_X86_64_PLT32	rep_movs_alternative-0x4
0b63  b63:	0f 01 ca             	clac
0b66  b66:	0f 01 cb             	stac
0b69  b69:	e8 00 00 00 00       	call   b6e <.altinstr_replacement+0xb6e>	b6a: R_X86_64_PLT32	rep_movs_alternative-0x4
0b6e  b6e:	0f 01 ca             	clac
0b71  b71:	0f 01 cb             	stac
0b74  b74:	0f ae e8             	lfence
0b77  b77:	0f 01 ca             	clac
0b7a  b7a:	0f 01 ca             	clac
0b7d  b7d:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0b82  b82:	65 48 23 04 25 00 00 00 00 	and    %gs:0x0,%rax	b87: R_X86_64_32S	tlbstate_untag_mask
0b8b  b8b:	0f 01 cb             	stac
0b8e  b8e:	0f ae e8             	lfence
0b91  b91:	0f 01 ca             	clac
0b94  b94:	65 48 23 0c 25 00 00 00 00 	and    %gs:0x0,%rcx	b99: R_X86_64_32S	tlbstate_untag_mask
0b9d  b9d:	0f 01 cb             	stac
0ba0  ba0:	0f ae e8             	lfence
0ba3  ba3:	0f 01 ca             	clac
0ba6  ba6:	9c                   	pushf
0ba7  ba7:	41 5d                	pop    %r13
0ba9  ba9:	0f 01 ca             	clac
0bac  bac:	41 55                	push   %r13
0bae  bae:	9d                   	popf
0baf  baf:	9c                   	pushf
0bb0  bb0:	8f 44 24 08          	pop    0x8(%rsp)
0bb4  bb4:	0f 01 ca             	clac
0bb7  bb7:	ff 74 24 08          	push   0x8(%rsp)
0bbb  bbb:	9d                   	popf
0bbc  bbc:	9c                   	pushf
0bbd  bbd:	41 5d                	pop    %r13
0bbf  bbf:	0f 01 ca             	clac
0bc2  bc2:	41 55                	push   %r13
0bc4  bc4:	9d                   	popf
0bc5  bc5:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bca  bca:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bcf  bcf:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bd4  bd4:	e9 00 00 00 00       	jmp    bd9 <.altinstr_replacement+0xbd9>	bd5: R_X86_64_PC32	.cpuidle.text+0x2d7
0bd9  bd9:	e9 00 00 00 00       	jmp    bde <.altinstr_replacement+0xbde>	bda: R_X86_64_PC32	.cpuidle.text+0x303
0bde  bde:	e9 00 00 00 00       	jmp    be3 <.altinstr_replacement+0xbe3>	bdf: R_X86_64_PC32	.cpuidle.text+0x3a8
0be3  be3:	e9 00 00 00 00       	jmp    be8 <.altinstr_replacement+0xbe8>	be4: R_X86_64_PC32	.cpuidle.text+0x3d4
0be8  be8:	e9 00 00 00 00       	jmp    bed <.altinstr_replacement+0xbed>	be9: R_X86_64_PC32	.cpuidle.text+0x483
0bed  bed:	e9 00 00 00 00       	jmp    bf2 <.altinstr_replacement+0xbf2>	bee: R_X86_64_PC32	.cpuidle.text+0x4af
0bf2  bf2:	e9 00 00 00 00       	jmp    bf7 <.altinstr_replacement+0xbf7>	bf3: R_X86_64_PC32	.cpuidle.text+0x555
0bf7  bf7:	e9 00 00 00 00       	jmp    bfc <.altinstr_replacement+0xbfc>	bf8: R_X86_64_PC32	.cpuidle.text+0x581
0bfc  bfc:	e9 00 00 00 00       	jmp    c01 <.altinstr_replacement+0xc01>	bfd: R_X86_64_PC32	.cpuidle.text+0x648
0c01  c01:	e9 00 00 00 00       	jmp    c06 <.altinstr_replacement+0xc06>	c02: R_X86_64_PC32	.cpuidle.text+0x674
0c06  c06:	e9 00 00 00 00       	jmp    c0b <.altinstr_replacement+0xc0b>	c07: R_X86_64_PC32	.init.text+0x6984a
0c0b  c0b:	e9 00 00 00 00       	jmp    c10 <.altinstr_replacement+0xc10>	c0c: R_X86_64_PC32	.text+0xb9c01f
0c10  c10:	e9 00 00 00 00       	jmp    c15 <.altinstr_replacement+0xc15>	c11: R_X86_64_PC32	.text+0xb9e346
0c15  c15:	e9 00 00 00 00       	jmp    c1a <.altinstr_replacement+0xc1a>	c16: R_X86_64_PC32	.cpuidle.text+0x955
0c1a  c1a:	e9 00 00 00 00       	jmp    c1f <.altinstr_replacement+0xc1f>	c1b: R_X86_64_PC32	.cpuidle.text+0xa6c
0c1f  c1f:	e9 00 00 00 00       	jmp    c24 <.altinstr_replacement+0xc24>	c20: R_X86_64_PC32	.text+0xbda008
0c24  c24:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c29  c29:	0f 01 cb             	stac
0c2c  c2c:	e8 00 00 00 00       	call   c31 <.altinstr_replacement+0xc31>	c2d: R_X86_64_PLT32	rep_stos_alternative-0x4
0c31  c31:	0f 01 ca             	clac
0c34  c34:	0f 01 cb             	stac
0c37  c37:	e8 00 00 00 00       	call   c3c <.altinstr_replacement+0xc3c>	c38: R_X86_64_PLT32	rep_stos_alternative-0x4
0c3c  c3c:	0f 01 ca             	clac
0c3f  c3f:	e9 00 00 00 00       	jmp    c44 <.altinstr_replacement+0xc44>	c40: R_X86_64_PC32	.text+0xc9bb06
0c44  c44:	e9 00 00 00 00       	jmp    c49 <.altinstr_replacement+0xc49>	c45: R_X86_64_PC32	.text+0xc9bb24
0c49  c49:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c4e  c4e:	f3 0f b8 c7          	popcnt %edi,%eax
0c52  c52:	e9 00 00 00 00       	jmp    c57 <.altinstr_replacement+0xc57>	c53: R_X86_64_PC32	.text+0xcf42b2
0c57  c57:	66 0f ae 38          	clflushopt (%rax)
0c5b  c5b:	66 0f ae 7a ff       	clflushopt -0x1(%rdx)
0c60  c60:	66 0f ae 3a          	clflushopt (%rdx)
0c64  c64:	e9 00 00 00 00       	jmp    c69 <.altinstr_replacement+0xc69>	c65: R_X86_64_PC32	.text+0xcf490b
0c69  c69:	e9 00 00 00 00       	jmp    c6e <.altinstr_replacement+0xc6e>	c6a: R_X86_64_PC32	.text+0xcf4a13
0c6e  c6e:	e9 00 00 00 00       	jmp    c73 <.altinstr_replacement+0xc73>	c6f: R_X86_64_PC32	.text+0xcf4c2d
0c73  c73:	f3 0f b8 c7          	popcnt %edi,%eax
0c77  c77:	f3 0f b8 c7          	popcnt %edi,%eax
0c7b  c7b:	f3 0f b8 c7          	popcnt %edi,%eax
0c7f  c7f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c84  c84:	0f 01 cb             	stac
0c87  c87:	e8 00 00 00 00       	call   c8c <.altinstr_replacement+0xc8c>	c88: R_X86_64_PLT32	rep_stos_alternative-0x4
0c8c  c8c:	0f 01 ca             	clac
0c8f  c8f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c94  c94:	f3 0f b8 c7          	popcnt %edi,%eax
0c98  c98:	f3 0f b8 c7          	popcnt %edi,%eax
0c9c  c9c:	f3 0f b8 c7          	popcnt %edi,%eax
0ca0  ca0:	e8 00 00 00 00       	call   ca5 <.altinstr_replacement+0xca5>	ca1: R_X86_64_PLT32	clear_page_rep-0x4
0ca5  ca5:	e8 00 00 00 00       	call   caa <.altinstr_replacement+0xcaa>	ca6: R_X86_64_PLT32	clear_page_erms-0x4
0caa  caa:	65 4c 23 3c 25 00 00 00 00 	and    %gs:0x0,%r15	caf: R_X86_64_32S	tlbstate_untag_mask
0cb3  cb3:	f3 0f b8 c7          	popcnt %edi,%eax
0cb7  cb7:	f3 0f b8 c7          	popcnt %edi,%eax
0cbb  cbb:	f3 0f b8 c7          	popcnt %edi,%eax
0cbf  cbf:	f3 0f b8 c7          	popcnt %edi,%eax
0cc3  cc3:	f3 0f b8 c7          	popcnt %edi,%eax
0cc7  cc7:	f3 0f b8 c7          	popcnt %edi,%eax
0ccb  ccb:	f3 0f b8 c7          	popcnt %edi,%eax
0ccf  ccf:	f3 0f b8 c7          	popcnt %edi,%eax
0cd3  cd3:	f3 0f b8 c7          	popcnt %edi,%eax
0cd7  cd7:	f3 0f b8 c7          	popcnt %edi,%eax
0cdb  cdb:	f3 0f b8 c7          	popcnt %edi,%eax
0cdf  cdf:	f3 0f b8 c7          	popcnt %edi,%eax
0ce3  ce3:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0ce8  ce8:	f3 0f b8 c7          	popcnt %edi,%eax
0cec  cec:	f3 0f b8 c7          	popcnt %edi,%eax
0cf0  cf0:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0cf5  cf5:	0f 01 cb             	stac
0cf8  cf8:	e8 00 00 00 00       	call   cfd <.altinstr_replacement+0xcfd>	cf9: R_X86_64_PLT32	rep_stos_alternative-0x4
0cfd  cfd:	0f 01 ca             	clac
0d00  d00:	0f 01 d9             	vmmcall
0d03  d03:	f3 0f b8 c7          	popcnt %edi,%eax
0d07  d07:	f3 0f b8 c7          	popcnt %edi,%eax
0d0b  d0b:	f3 0f b8 c7          	popcnt %edi,%eax
0d0f  d0f:	f3 0f b8 c7          	popcnt %edi,%eax
0d13  d13:	f3 0f b8 c7          	popcnt %edi,%eax
0d17  d17:	f3 0f b8 c7          	popcnt %edi,%eax
0d1b  d1b:	e9 00 00 00 00       	jmp    d20 <.altinstr_replacement+0xd20>	d1c: R_X86_64_PC32	.text+0x1e60338
0d20  d20:	f3 0f b8 c7          	popcnt %edi,%eax
0d24  d24:	f3 0f b8 c7          	popcnt %edi,%eax
0d28  d28:	f3 0f b8 c7          	popcnt %edi,%eax
0d2c  d2c:	f3 0f b8 c7          	popcnt %edi,%eax
0d30  d30:	f3 0f b8 c7          	popcnt %edi,%eax
0d34  d34:	f3 0f b8 c7          	popcnt %edi,%eax
0d38  d38:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0d3d  d3d:	0f 0d 08             	prefetchw (%rax)
0d40  d40:	41 0f 0d 8c 04 c0 fe ff ff 	prefetchw -0x140(%r12,%rax,1)
0d49  d49:	0f 01 cb             	stac
0d4c  d4c:	0f ae e8             	lfence
0d4f  d4f:	0f 01 ca             	clac
0d52  d52:	0f 01 ca             	clac
0d55  d55:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0d5a  d5a:	f3 0f b8 c7          	popcnt %edi,%eax
0d5e  d5e:	f3 0f b8 c7          	popcnt %edi,%eax
0d62  d62:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0d67  d67:	f3 0f b8 c7          	popcnt %edi,%eax
0d6b  d6b:	f3 0f b8 c7          	popcnt %edi,%eax
0d6f  d6f:	f3 0f b8 c7          	popcnt %edi,%eax
0d73  d73:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0d78  d78:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0d7d  d7d:	41 0f 0d 0e          	prefetchw (%r14)
0d81  d81:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0d86  d86:	e9 00 00 00 00       	jmp    d8b <.altinstr_replacement+0xd8b>	d87: R_X86_64_PC32	.text+0x24b0720
0d8b  d8b:	e9 00 00 00 00       	jmp    d90 <.altinstr_replacement+0xd90>	d8c: R_X86_64_PC32	.text+0x24fdb9c
0d90  d90:	0f 01 cb             	stac
0d93  d93:	e9 00 00 00 00       	jmp    d98 <.altinstr_replacement+0xd98>	d94: R_X86_64_PC32	.text+0x24fdbd4
0d98  d98:	0f 01 cb             	stac
0d9b  d9b:	0f 01 cb             	stac
0d9e  d9e:	e8 00 00 00 00       	call   da3 <.altinstr_replacement+0xda3>	d9f: R_X86_64_PLT32	rep_movs_alternative-0x4
0da3  da3:	0f 01 ca             	clac
0da6  da6:	0f ae e8             	lfence
0da9  da9:	0f 31                	rdtsc
0dab  dab:	0f 01 f9             	rdtscp
0dae  dae:	0f ae e8             	lfence
0db1  db1:	0f 31                	rdtsc
0db3  db3:	0f 01 f9             	rdtscp
0db6  db6:	0f ae e8             	lfence
0db9  db9:	0f 31                	rdtsc
0dbb  dbb:	0f 01 f9             	rdtscp
0dbe  dbe:	0f ae e8             	lfence
0dc1  dc1:	0f 31                	rdtsc
0dc3  dc3:	0f 01 f9             	rdtscp
0dc6  dc6:	0f 01 cb             	stac
0dc9  dc9:	0f 01 ca             	clac
0dcc  dcc:	0f 01 cb             	stac
0dcf  dcf:	0f 01 ca             	clac
0dd2  dd2:	0f 01 cb             	stac
0dd5  dd5:	0f 01 ca             	clac
0dd8  dd8:	0f 01 cb             	stac
0ddb  ddb:	0f 01 ca             	clac
0dde  dde:	0f 01 cb             	stac
0de1  de1:	0f ae e8             	lfence
0de4  de4:	0f 01 ca             	clac
0de7  de7:	0f 01 cb             	stac
0dea  dea:	0f ae e8             	lfence
0ded  ded:	0f 01 ca             	clac
0df0  df0:	0f 01 cb             	stac
0df3  df3:	0f ae e8             	lfence
0df6  df6:	0f 01 ca             	clac
0df9  df9:	0f 01 cb             	stac
0dfc  dfc:	0f ae e8             	lfence
0dff  dff:	0f 01 ca             	clac
0e02  e02:	0f 01 ca             	clac
0e05  e05:	0f 01 cb             	stac
0e08  e08:	e8 00 00 00 00       	call   e0d <.altinstr_replacement+0xe0d>	e09: R_X86_64_PLT32	rep_movs_alternative-0x4
0e0d  e0d:	0f 01 ca             	clac
0e10  e10:	e9 00 00 00 00       	jmp    e15 <.altinstr_replacement+0xe15>	e11: R_X86_64_PC32	.noinstr.text+0x4f55
0e15  e15:	0f 01 cb             	stac
0e18  e18:	0f 01 ca             	clac
0e1b  e1b:	0f 01 cb             	stac
0e1e  e1e:	0f 01 ca             	clac
0e21  e21:	0f 01 cb             	stac
0e24  e24:	0f 01 ca             	clac
0e27  e27:	0f 01 cb             	stac
0e2a  e2a:	0f 01 ca             	clac
0e2d  e2d:	0f 01 cb             	stac
0e30  e30:	0f 01 ca             	clac
0e33  e33:	0f 01 cb             	stac
0e36  e36:	0f 01 ca             	clac
0e39  e39:	0f 01 cb             	stac
0e3c  e3c:	0f 01 ca             	clac
0e3f  e3f:	0f 01 cb             	stac
0e42  e42:	0f 01 ca             	clac
0e45  e45:	0f 01 ca             	clac
0e48  e48:	0f 01 cb             	stac
0e4b  e4b:	e8 00 00 00 00       	call   e50 <.altinstr_replacement+0xe50>	e4c: R_X86_64_PLT32	rep_movs_alternative-0x4
0e50  e50:	0f 01 ca             	clac
0e53  e53:	66 0f ae 38          	clflushopt (%rax)
0e57  e57:	66 0f ae 30          	clwb   (%rax)
0e5b  e5b:	0f 01 cb             	stac
0e5e  e5e:	0f 01 ca             	clac

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
