Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D173773705
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjHHCpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjHHCpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:45:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCE319AF;
        Mon,  7 Aug 2023 19:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691462737; x=1722998737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0z+zOqNkDGFTtr7pqf9PD+lHQCQkE8xsKx0TOsjhCnE=;
  b=dN7d4Driet/zNAa0rVoK8rf+5tCMXymYV3yxnqaevjEAeu2eU9HOREee
   u4U5JSiGONRxti2+fbeuc7iLTaNMxtNFbNCDefJ7rKZTms4KPENcmE8lI
   G45UGFAs4oULrui8mj5/rq5FzqHfvsV1rtdxYLdcDa3m3rCs9EJF0iYRP
   fsrPDMAG9C+JAcMP9AhOWFJfbqZyt2M7jRgCqsd/maYWwkxEciKHZygZz
   ngAevmH9bX6a3gXH/MCU5kflqMYjARfty/yzlVHacJ0A3f3b/rH2QBqSa
   lKcZcRBKh+0O0yqJ/530AgaC4zvY6u5Qz/QCM8EXQ9fpa+Fwn1KejfWX8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="370695214"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="370695214"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 19:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801170047"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="801170047"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2023 19:45:34 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTCiz-00051t-0x;
        Tue, 08 Aug 2023 02:45:33 +0000
Date:   Tue, 8 Aug 2023 10:44:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] Makefile.extrawarn: enable
 -Wmissing-variable-declarations for W=1
Message-ID: <202308081050.sZEw4cQ5-lkp@intel.com>
References: <20230807-missing_proto-v2-1-3ae2e188bb0c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-missing_proto-v2-1-3ae2e188bb0c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 52a93d39b17dc7eb98b6aa3edb93943248e03b2f]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Desaulniers/Makefile-extrawarn-enable-Wmissing-variable-declarations-for-W-1/20230808-005859
base:   52a93d39b17dc7eb98b6aa3edb93943248e03b2f
patch link:    https://lore.kernel.org/r/20230807-missing_proto-v2-1-3ae2e188bb0c%40google.com
patch subject: [PATCH v2] Makefile.extrawarn: enable -Wmissing-variable-declarations for W=1
config: um-randconfig-r031-20230807 (https://download.01.org/0day-ci/archive/20230808/202308081050.sZEw4cQ5-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230808/202308081050.sZEw4cQ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308081050.sZEw4cQ5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from scripts/mod/devicetable-offsets.c:3:
   In file included from include/linux/mod_devicetable.h:14:
   In file included from include/linux/uuid.h:11:
   In file included from include/linux/string.h:20:
   In file included from arch/x86/include/asm/string.h:5:
   In file included from arch/x86/include/asm/string_64.h:6:
   In file included from include/linux/jump_label.h:255:
   In file included from include/linux/atomic.h:7:
   In file included from arch/x86/include/asm/atomic.h:7:
   In file included from arch/x86/include/asm/alternative.h:7:
>> arch/x86/include/asm/asm.h:208:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
   register unsigned long current_stack_pointer asm(_ASM_SP);
                          ^
   arch/x86/include/asm/asm.h:208:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
   register unsigned long current_stack_pointer asm(_ASM_SP);
            ^
   1 warning generated.
--
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for function 'foo' [-Wmissing-prototypes]
   void foo(void)
        ^
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void foo(void)
   ^
   static 
   In file included from arch/um/kernel/asm-offsets.c:1:
   In file included from arch/x86/um/shared/sysdep/kernel-offsets.h:3:
   In file included from include/linux/sched.h:12:
   In file included from ./arch/um/include/generated/asm/current.h:1:
   In file included from include/asm-generic/current.h:5:
   In file included from include/linux/thread_info.h:27:
   In file included from include/linux/bitops.h:34:
   In file included from include/asm-generic/bitops/generic-non-atomic.h:7:
   In file included from arch/x86/um/asm/barrier.h:6:
   In file included from arch/x86/include/asm/alternative.h:7:
>> arch/x86/include/asm/asm.h:208:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
   register unsigned long current_stack_pointer asm(_ASM_SP);
                          ^
   arch/x86/include/asm/asm.h:208:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
   register unsigned long current_stack_pointer asm(_ASM_SP);
            ^
   2 warnings generated.
--
   In file included from arch/um/drivers/hostaudio_kern.c:6:
   In file included from include/linux/fs.h:6:
   In file included from include/linux/wait_bit.h:8:
   In file included from include/linux/wait.h:7:
   In file included from include/linux/list.h:11:
   In file included from arch/x86/um/asm/barrier.h:6:
   In file included from arch/x86/include/asm/alternative.h:7:
>> arch/x86/include/asm/asm.h:208:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
   register unsigned long current_stack_pointer asm(_ASM_SP);
                          ^
   arch/x86/include/asm/asm.h:208:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
   register unsigned long current_stack_pointer asm(_ASM_SP);
            ^
>> arch/um/drivers/hostaudio_kern.c:316:3: warning: no previous extern declaration for non-static variable 'module_data' [-Wmissing-variable-declarations]
   } module_data;
     ^
   arch/um/drivers/hostaudio_kern.c:313:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
   struct {
   ^
   2 warnings generated.
--
   In file included from arch/um/drivers/daemon_kern.c:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from arch/um/drivers/daemon_kern.c:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from arch/um/drivers/daemon_kern.c:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   In file included from arch/um/drivers/daemon_kern.c:10:
   In file included from include/linux/netdevice.h:24:
   In file included from include/linux/timer.h:5:
   In file included from include/linux/list.h:11:
   In file included from arch/x86/um/asm/barrier.h:6:
   In file included from arch/x86/include/asm/alternative.h:7:
>> arch/x86/include/asm/asm.h:208:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
   register unsigned long current_stack_pointer asm(_ASM_SP);
                          ^
   arch/x86/include/asm/asm.h:208:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
   register unsigned long current_stack_pointer asm(_ASM_SP);
            ^
   13 warnings generated.
--
   In file included from arch/um/drivers/port_kern.c:7:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from arch/um/drivers/port_kern.c:7:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from arch/um/drivers/port_kern.c:7:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> arch/um/drivers/port_kern.c:147:14: warning: no previous extern declaration for non-static variable 'port_work' [-Wmissing-variable-declarations]
   DECLARE_WORK(port_work, port_work_proc);
                ^
   arch/um/drivers/port_kern.c:147:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
   DECLARE_WORK(port_work, port_work_proc);
   ^
   include/linux/workqueue.h:194:2: note: expanded from macro 'DECLARE_WORK'
           struct work_struct n = __WORK_INITIALIZER(n, f)
           ^
   In file included from arch/um/drivers/port_kern.c:6:
   In file included from include/linux/completion.h:12:
   In file included from include/linux/swait.h:5:
   In file included from include/linux/list.h:11:
   In file included from arch/x86/um/asm/barrier.h:6:
   In file included from arch/x86/include/asm/alternative.h:7:
>> arch/x86/include/asm/asm.h:208:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
   register unsigned long current_stack_pointer asm(_ASM_SP);
                          ^
   arch/x86/include/asm/asm.h:208:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
   register unsigned long current_stack_pointer asm(_ASM_SP);
            ^
   14 warnings generated.
--
   In file included from arch/um/drivers/xterm_kern.c:10:
   In file included from arch/um/include/shared/irq_kern.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from arch/um/drivers/xterm_kern.c:10:
   In file included from arch/um/include/shared/irq_kern.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from arch/um/drivers/xterm_kern.c:10:
   In file included from arch/um/include/shared/irq_kern.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   arch/um/drivers/xterm_kern.c:35:5: warning: no previous prototype for function 'xterm_fd' [-Wmissing-prototypes]
   int xterm_fd(int socket, int *pid_out)
       ^
   arch/um/drivers/xterm_kern.c:35:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int xterm_fd(int socket, int *pid_out)
   ^
   static 
   In file included from arch/um/drivers/xterm_kern.c:6:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:12:
   In file included from include/linux/list.h:11:
   In file included from arch/x86/um/asm/barrier.h:6:
   In file included from arch/x86/include/asm/alternative.h:7:
>> arch/x86/include/asm/asm.h:208:24: warning: no previous extern declaration for non-static variable 'current_stack_pointer' [-Wmissing-variable-declarations]
   register unsigned long current_stack_pointer asm(_ASM_SP);
                          ^
   arch/x86/include/asm/asm.h:208:10: note: declare 'static' if the variable is not intended to be used outside of this translation unit
   register unsigned long current_stack_pointer asm(_ASM_SP);
            ^
   14 warnings generated.
..


vim +/current_stack_pointer +208 arch/x86/include/asm/asm.h

a34746bc43eb63 include/asm-x86/asm.h      H. Peter Anvin  2008-02-04  201  
f5caf621ee3572 arch/x86/include/asm/asm.h Josh Poimboeuf  2017-09-20  202  /*
f5caf621ee3572 arch/x86/include/asm/asm.h Josh Poimboeuf  2017-09-20  203   * This output constraint should be used for any inline asm which has a "call"
f5caf621ee3572 arch/x86/include/asm/asm.h Josh Poimboeuf  2017-09-20  204   * instruction.  Otherwise the asm may be inserted before the frame pointer
f5caf621ee3572 arch/x86/include/asm/asm.h Josh Poimboeuf  2017-09-20  205   * gets set up by the containing function.  If you forget to do this, objtool
f5caf621ee3572 arch/x86/include/asm/asm.h Josh Poimboeuf  2017-09-20  206   * may print a "call without frame pointer save/setup" warning.
f5caf621ee3572 arch/x86/include/asm/asm.h Josh Poimboeuf  2017-09-20  207   */
196bd485ee4f03 arch/x86/include/asm/asm.h Andrey Ryabinin 2017-09-29 @208  register unsigned long current_stack_pointer asm(_ASM_SP);
196bd485ee4f03 arch/x86/include/asm/asm.h Andrey Ryabinin 2017-09-29  209  #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
28b60197b573cd arch/x86/include/asm/asm.h Borislav Petkov 2020-06-04  210  #endif /* __ASSEMBLY__ */
f5caf621ee3572 arch/x86/include/asm/asm.h Josh Poimboeuf  2017-09-20  211  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
