Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0E7DB460
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjJ3Hd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjJ3HdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:33:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0C3A7;
        Mon, 30 Oct 2023 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698651201; x=1730187201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GJM2oPVyPnoA1shVpThD9ETGZjSJkdjngtuEdnq8wx8=;
  b=d+l9Eoja9RfmjMvh1RY7S2iVuLynWKJzksB13sRSHSjbMpCjza70MkAH
   rKaYv9Fh/hfkA1PgEf2p8De06BgTzYYJJIhgDdvSKrj1LXrdwCie1klKQ
   TpvucP69FrwVJZHnQn43JvYe36oVviWXwsGrsdXucsC55amOvXU7QRXEa
   GRbhjfYUkK4LnzY2LySLIc+yvDQ0hKZeYYx25Kiwc0RZAewGUou6PKb4e
   yna/B+5LO3rV718RulrOA3ptgZ8R3a6fMHGH6jjEZR/Y9G3svK7h/fJlu
   GEuFiyRZn6iiEtjJE8WSqdLUvtLudRnL97/ghr8/Vcqhi5lU9BoUIJr9k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="454492788"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="454492788"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 00:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="877043537"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="877043537"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Oct 2023 00:33:17 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxMlu-000D6h-2r;
        Mon, 30 Oct 2023 07:33:14 +0000
Date:   Mon, 30 Oct 2023 15:32:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nancy Nyambura <nicymimz@gmail.com>, gagallo7+outreachy@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, nicydaniels@gmail.com,
        outreachy@lists.linux.dev, Nancy Nyambura <nicymimz@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Media: omap4iss: Enable RSZB and update resizer control
Message-ID: <202310301558.abL6OUgF-lkp@intel.com>
References: <20231029220710.47063-1-nicymimz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029220710.47063-1-nicymimz@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nancy,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nancy-Nyambura/Media-omap4iss-Enable-RSZB-and-update-resizer-control/20231030-060944
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20231029220710.47063-1-nicymimz%40gmail.com
patch subject: [PATCH] Media: omap4iss: Enable RSZB and update resizer control
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231030/202310301558.abL6OUgF-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310301558.abL6OUgF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310301558.abL6OUgF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/media/omap4iss/iss_resizer.c: In function 'resizer_enable':
   drivers/staging/media/omap4iss/iss_resizer.c:119:37: error: 'struct iss_device' has no member named 'base_addr'
     119 |         u32 reg_value = ioread32(iss->base_addr + OMAP4_ISS_MEM_ISP_RESIZER,
         |                                     ^~
   drivers/staging/media/omap4iss/iss_resizer.c:120:27: error: 'RZ_SYSCONFIG' undeclared (first use in this function); did you mean 'RSZ_SYSCONFIG'?
     120 |                         + RZ_SYSCONFIG);
         |                           ^~~~~~~~~~~~
         |                           RSZ_SYSCONFIG
   drivers/staging/media/omap4iss/iss_resizer.c:120:27: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:11,
                    from drivers/staging/media/omap4iss/iss_resizer.c:14:
>> arch/alpha/include/asm/io.h:433:18: error: too many arguments to function 'ioread32'
     433 | #define ioread32 ioread32
         |                  ^~~~~~~~
   drivers/staging/media/omap4iss/iss_resizer.c:119:25: note: in expansion of macro 'ioread32'
     119 |         u32 reg_value = ioread32(iss->base_addr + OMAP4_ISS_MEM_ISP_RESIZER,
         |                         ^~~~~~~~
   In file included from arch/alpha/include/asm/io.h:15:
   include/asm-generic/iomap.h:32:21: note: declared here
      32 | extern unsigned int ioread32(const void __iomem *);
         |                     ^~~~~~~~
   drivers/staging/media/omap4iss/iss_resizer.c:122:33: error: 'struct iss_device' has no member named 'base_addr'
     122 |         iowrite32(reg_value, iss->base_addr + OMAP4_ISS_MEM_ISP_RESIZER,
         |                                 ^~
>> arch/alpha/include/asm/io.h:435:19: error: too many arguments to function 'iowrite32'
     435 | #define iowrite32 iowrite32
         |                   ^~~~~~~~~
   drivers/staging/media/omap4iss/iss_resizer.c:122:9: note: in expansion of macro 'iowrite32'
     122 |         iowrite32(reg_value, iss->base_addr + OMAP4_ISS_MEM_ISP_RESIZER,
         |         ^~~~~~~~~
   include/asm-generic/iomap.h:53:13: note: declared here
      53 | extern void iowrite32(u32, void __iomem *);
         |             ^~~~~~~~~


vim +/ioread32 +433 arch/alpha/include/asm/io.h

^1da177e4c3f41 include/asm-alpha/io.h      Linus Torvalds 2005-04-16  432  
7e772dad991399 arch/alpha/include/asm/io.h Linus Walleij  2022-09-06 @433  #define ioread32 ioread32
e19d4ebc536dad arch/alpha/include/asm/io.h Arnd Bergmann  2022-10-03  434  #define ioread64 ioread64
7e772dad991399 arch/alpha/include/asm/io.h Linus Walleij  2022-09-06 @435  #define iowrite32 iowrite32
e19d4ebc536dad arch/alpha/include/asm/io.h Arnd Bergmann  2022-10-03  436  #define iowrite64 iowrite64
7e772dad991399 arch/alpha/include/asm/io.h Linus Walleij  2022-09-06  437  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
