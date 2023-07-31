Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47898769583
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjGaMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjGaMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:04:42 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA910E0;
        Mon, 31 Jul 2023 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690805080; x=1722341080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Scbc1k97nOjYXKL92XVgiWyP02TWnisk0n+vpo+gYPk=;
  b=Du5vLpMD3P20Icw+Tn/XCWDJRUQ+hZRUN/OkKtJgG75wBD13nyJZdsew
   RtlUDxqAW37uV5/G8JsifAKMfYXih4AC42Z4ssgHaaomcUcCU4jprl+cx
   HXWIX2HyTOcA15h3pEdqYTVR+gokWAhwWP086n1XIztPJbClnbXf33FNQ
   Br3DcGwcFemv6TMPncxuNiZv/VzIX6QSDgKBnZBIUbzhu/uHQjMEBeCzR
   CsN1UGQk4j5Ygm1YDxAMkDrJuOeaY1L2Q3D+seHSriMGQ1dR5Et2dyr3e
   f8PgvUYPRqufEn9EiQjBiYreOkGXJOinKPdL/Am2Vt+X/TXC+yxh1i+vR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="432816281"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="432816281"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 05:04:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="678311425"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="678311425"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2023 05:04:34 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQRdZ-00056n-2a;
        Mon, 31 Jul 2023 12:04:33 +0000
Date:   Mon, 31 Jul 2023 20:04:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, olivia@selenic.com,
        herbert@gondor.apana.org.au, jiajie.ho@starfivetech.com,
        conor.dooley@microchip.com, martin@kaiser.cx, mmyangfl@gmail.com,
        jenny.zhang@starfivetech.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        leoliu@zhaoxin.com, CobeChen@zhaoxin.com, YunShen@zhaoxin.com,
        TonyWWang@zhaoxin.com, leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: Re: [PATCH v2 2/2] hwrng: add Zhaoxin HW RNG driver
Message-ID: <202307311920.0ZdHwXvk-lkp@intel.com>
References: <20230731084515.2057375-3-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731084515.2057375-3-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LeoLiu-oc,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master linus/master v6.5-rc4 next-20230731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/hwrng-via-rng-convert-to-x86_cpu_id-probing/20230731-164950
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230731084515.2057375-3-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH v2 2/2] hwrng: add Zhaoxin HW RNG driver
config: hexagon-randconfig-r024-20230731 (https://download.01.org/0day-ci/archive/20230731/202307311920.0ZdHwXvk-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230731/202307311920.0ZdHwXvk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307311920.0ZdHwXvk-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/char/hw_random/zhaoxin-rng.c:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/char/hw_random/zhaoxin-rng.c:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/char/hw_random/zhaoxin-rng.c:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/char/hw_random/zhaoxin-rng.c:16:10: fatal error: 'asm/cpu_device_id.h' file not found
   #include <asm/cpu_device_id.h>
            ^~~~~~~~~~~~~~~~~~~~~
   6 warnings and 1 error generated.


vim +16 drivers/char/hw_random/zhaoxin-rng.c

  > 16	#include <asm/cpu_device_id.h>
    17	#include <asm/fpu/api.h>
    18	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
