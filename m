Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E217D0B41
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376622AbjJTJPs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 05:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376594AbjJTJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:15:46 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16568AB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:15:41 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C233024E328;
        Fri, 20 Oct 2023 17:15:33 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 20 Oct
 2023 17:15:33 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 20 Oct
 2023 17:15:32 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Fri, 20 Oct 2023 17:15:33 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     kernel test robot <lkp@intel.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: RE: arch/riscv/kernel/hibernate.c:76:65: warning: array subscript -1
 is outside array bounds of 'const void[]'
Thread-Topic: arch/riscv/kernel/hibernate.c:76:65: warning: array subscript -1
 is outside array bounds of 'const void[]'
Thread-Index: AQHaAefzQM1zvD33BUG0QDMQLERe07BSZdXQ
Date:   Fri, 20 Oct 2023 09:15:33 +0000
Message-ID: <06e2dfdcd9ab409f97d1eb0a12d391db@EXMBX066.cuchost.com>
References: <202310190159.mAUo9iEX-lkp@intel.com>
In-Reply-To: <202310190159.mAUo9iEX-lkp@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [219.93.91.231]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I followed the reproduction steps provided at the link: https://download.01.org/0day-ci/archive/20231019/202310190159.mAUo9iEX-lkp@intel.com/reproduce to download the Linux kernel, compiler version, and the config found here: https://download.01.org/0day-ci/archive/20231019/202310190159.mAUo9iEX-lkp@intel.com/config.
Indeed, I was able to reproduce the issue, but only with kernel v6.3-rc1.

When I tested with the same compiler version and config on kernel v6.6-rc6, I found no issues. Given these findings, do you believe it's still necessary to address the problem?

Thanks
Regards
Jee Heng

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Thursday, October 19, 2023 1:23 AM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Palmer Dabbelt <palmer@rivosinc.com>; Leyfoon Tan
> <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>; Conor Dooley <conor.dooley@microchip.com>;
> Andrew Jones <ajones@ventanamicro.com>
> Subject: arch/riscv/kernel/hibernate.c:76:65: warning: array subscript -1 is outside array bounds of 'const void[]'
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
> commit: c0317210012e3b985779ddd92a7c5db8424e1e97 RISC-V: Add arch functions to support hibernation/suspend-to-disk
> date:   6 months ago
> config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20231019/202310190159.mAUo9iEX-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190159.mAUo9iEX-
> lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310190159.mAUo9iEX-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/riscv/include/asm/page.h:12,
>                     from arch/riscv/include/asm/thread_info.h:11,
>                     from include/linux/thread_info.h:60,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/riscv/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/spinlock.h:56,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:7,
>                     from include/linux/mm.h:7,
>                     from arch/riscv/include/asm/cacheflush.h:9,
>                     from arch/riscv/kernel/hibernate.c:11:
>    arch/riscv/kernel/hibernate.c: In function 'pfn_is_nosave':
> >> arch/riscv/kernel/hibernate.c:76:65: warning: array subscript -1 is outside array bounds of 'const void[]' [-Warray-bounds=]
>       76 |         unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
>    include/linux/pfn.h:22:43: note: in definition of macro 'PHYS_PFN'
>       22 | #define PHYS_PFN(x)     ((unsigned long)((x) >> PAGE_SHIFT))
>          |                                           ^
>    arch/riscv/include/asm/page.h:172:33: note: in expansion of macro '__phys_to_pfn'
>      172 | #define sym_to_pfn(x)           __phys_to_pfn(__pa_symbol(x))
>          |                                 ^~~~~~~~~~~~~
>    arch/riscv/include/asm/page.h:156:44: note: in expansion of macro 'RELOC_HIDE'
>      156 | #define __pa_symbol(x)  __phys_addr_symbol(RELOC_HIDE((unsigned long)(x), 0))
>          |                                            ^~~~~~~~~~
>    arch/riscv/include/asm/page.h:172:47: note: in expansion of macro '__pa_symbol'
>      172 | #define sym_to_pfn(x)           __phys_to_pfn(__pa_symbol(x))
>          |                                               ^~~~~~~~~~~
>    arch/riscv/kernel/hibernate.c:76:40: note: in expansion of macro 'sym_to_pfn'
>       76 |         unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
>          |                                        ^~~~~~~~~~
>    In file included from arch/riscv/include/asm/sections.h:8,
>                     from include/linux/interrupt.h:21,
>                     from include/linux/kernel_stat.h:9,
>                     from include/linux/cgroup.h:26,
>                     from include/linux/memcontrol.h:13,
>                     from include/linux/swap.h:9,
>                     from include/asm-generic/tlb.h:15,
>                     from arch/riscv/include/asm/tlb.h:14,
>                     from arch/riscv/include/asm/pgalloc.h:11,
>                     from arch/riscv/kernel/hibernate.c:14:
>    include/asm-generic/sections.h:59:45: note: at offset -1 into object '__nosave_end' of size [0, 9223372036854775807]
>       59 | extern __visible const void __nosave_begin, __nosave_end;
>          |                                             ^~~~~~~~~~~~
> 
> 
> vim +76 arch/riscv/kernel/hibernate.c
> 
>     69
>     70	/*
>     71	 * Check if the given pfn is in the 'nosave' section.
>     72	 */
>     73	int pfn_is_nosave(unsigned long pfn)
>     74	{
>     75		unsigned long nosave_begin_pfn = sym_to_pfn(&__nosave_begin);
>   > 76		unsigned long nosave_end_pfn = sym_to_pfn(&__nosave_end - 1);
>     77
>     78		return ((pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn));
>     79	}
>     80
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
