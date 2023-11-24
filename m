Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534A37F74B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345185AbjKXNUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjKXNT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:19:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C819210DC;
        Fri, 24 Nov 2023 05:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700832003; x=1732368003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=peRuZaBCZzr/v4C9Q1MvL6hloPYVyHK9MBs7TTjylkU=;
  b=Aa8liEpWMzykbvH9Av38NtxXXkTa46hSrv+lzT7tHXA9nJ6r4g6MDkEG
   mKEwXzvCRn5C6SeQf4V3THKyWc/d7hkEzHlt4xQs1cc93ALpejk5SEtsj
   3zrkHSRsqqrssdcHvG1X2p8W8MxpwOUETPrjboZeHsm9dvzJJJQJ8ga5r
   KOnEl9s6aw+BdAA4/YP+19ATzDYTR0w0LTkxVuNGCOPY8bEeOn0LtUu+L
   zo7mXVs1BEi6ujASfjcTsZXroUfra83i/yeyKjJ7txto8+H4ulfV2+aHc
   oCup6wgDyIn0s4HjUe9Prm3wqD0hagS/Bf/cKV/Ohg65EurnG/DQH4kc4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="382823364"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="382823364"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:20:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="885274437"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="885274437"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Nov 2023 05:20:00 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6W69-0002nb-2u;
        Fri, 24 Nov 2023 13:19:57 +0000
Date:   Fri, 24 Nov 2023 21:19:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshul Dalal <anshulusr@gmail.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Anshul Dalal <anshulusr@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v10 2/2] input: joystick: driver for Adafruit Seesaw
 Gamepad
Message-ID: <202311241512.0CL83yG6-lkp@intel.com>
References: <20231121123409.2231115-2-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121123409.2231115-2-anshulusr@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus hid/for-next linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshul-Dalal/input-joystick-driver-for-Adafruit-Seesaw-Gamepad/20231121-204243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20231121123409.2231115-2-anshulusr%40gmail.com
patch subject: [PATCH v10 2/2] input: joystick: driver for Adafruit Seesaw Gamepad
config: hexagon-randconfig-r123-20231123 (https://download.01.org/0day-ci/archive/20231124/202311241512.0CL83yG6-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231124/202311241512.0CL83yG6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241512.0CL83yG6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/input/joystick/adafruit-seesaw.c:21:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/input/joystick/adafruit-seesaw.c:21:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/input/joystick/adafruit-seesaw.c:21:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/input/joystick/adafruit-seesaw.c:300:34: warning: unused variable 'seesaw_of_table' [-Wunused-const-variable]
     300 | static const struct of_device_id seesaw_of_table[] = {
         |                                  ^
   7 warnings generated.


vim +/seesaw_of_table +300 drivers/input/joystick/adafruit-seesaw.c

   299	
 > 300	static const struct of_device_id seesaw_of_table[] = {
   301		{ .compatible = "adafruit,seesaw-gamepad"},
   302		{ /* Sentinel */ }
   303	};
   304	MODULE_DEVICE_TABLE(of, seesaw_of_table);
   305	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
