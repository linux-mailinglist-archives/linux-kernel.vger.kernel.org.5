Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0607DB23C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 04:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjJ3DUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 23:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3DUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 23:20:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03468BD;
        Sun, 29 Oct 2023 20:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698636000; x=1730172000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yRaMyJdeEKY3i1iGnqG12Lko57gYZ93LAzlgj2NDC6U=;
  b=AgqYj5FW71suE1DMLV+scjzgZHvm3ZUPfMg20vPlCXsf3W3dLCrqoSdp
   uohfjV6+HPu9ruEEVFALFSYV+hpGJMavqG1yW5YtLYmpqi/WXWw4hJVGt
   +zETF0M+HmXMzc1i4cH1deTEZlg3azOb/qeABxjxbg8Vy6Zgf6GPEbli7
   y4HIb1qvMIjyefgqCM2vT9wdyMiH06iIeftNLoWw+GHNTxSIqqvmAO5Tc
   Ad5x8OHVHAbW/Q4qBm2mI+WVNRpatoIWQKnns6nyDVh5dSvheh6x0ndEr
   eXmWR8AkXuTF9JwP80QQDP8W3ahimbERo53w+5FrXwJDpxrUvKyAuETNr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="454471269"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="454471269"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 20:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="933655577"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="933655577"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2023 20:19:54 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxIoh-000D0t-1N;
        Mon, 30 Oct 2023 03:19:51 +0000
Date:   Mon, 30 Oct 2023 11:19:06 +0800
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
Message-ID: <202310301031.IZuhUjMc-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231030/202310301031.IZuhUjMc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310301031.IZuhUjMc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310301031.IZuhUjMc-lkp@intel.com/

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
>> arch/sh/include/asm/io.h:129:18: error: too many arguments to function 'ioread32'
     129 | #define ioread32 ioread32
         |                  ^~~~~~~~
   drivers/staging/media/omap4iss/iss_resizer.c:119:25: note: in expansion of macro 'ioread32'
     119 |         u32 reg_value = ioread32(iss->base_addr + OMAP4_ISS_MEM_ISP_RESIZER,
         |                         ^~~~~~~~
   In file included from arch/sh/include/asm/io.h:22:
   include/asm-generic/iomap.h:32:21: note: declared here
      32 | extern unsigned int ioread32(const void __iomem *);
         |                     ^~~~~~~~
   drivers/staging/media/omap4iss/iss_resizer.c:122:33: error: 'struct iss_device' has no member named 'base_addr'
     122 |         iowrite32(reg_value, iss->base_addr + OMAP4_ISS_MEM_ISP_RESIZER,
         |                                 ^~
>> arch/sh/include/asm/io.h:135:19: error: too many arguments to function 'iowrite32'
     135 | #define iowrite32 iowrite32
         |                   ^~~~~~~~~
   drivers/staging/media/omap4iss/iss_resizer.c:122:9: note: in expansion of macro 'iowrite32'
     122 |         iowrite32(reg_value, iss->base_addr + OMAP4_ISS_MEM_ISP_RESIZER,
         |         ^~~~~~~~~
   include/asm-generic/iomap.h:53:13: note: declared here
      53 | extern void iowrite32(u32, void __iomem *);
         |             ^~~~~~~~~


vim +/ioread32 +129 arch/sh/include/asm/io.h

b94692e84dccf1 Baoquan He 2023-07-06  125  
b94692e84dccf1 Baoquan He 2023-07-06  126  #define ioread8 ioread8
b94692e84dccf1 Baoquan He 2023-07-06  127  #define ioread16 ioread16
b94692e84dccf1 Baoquan He 2023-07-06  128  #define ioread16be ioread16be
b94692e84dccf1 Baoquan He 2023-07-06 @129  #define ioread32 ioread32
b94692e84dccf1 Baoquan He 2023-07-06  130  #define ioread32be ioread32be
b94692e84dccf1 Baoquan He 2023-07-06  131  
b94692e84dccf1 Baoquan He 2023-07-06  132  #define iowrite8 iowrite8
b94692e84dccf1 Baoquan He 2023-07-06  133  #define iowrite16 iowrite16
b94692e84dccf1 Baoquan He 2023-07-06  134  #define iowrite16be iowrite16be
b94692e84dccf1 Baoquan He 2023-07-06 @135  #define iowrite32 iowrite32
b94692e84dccf1 Baoquan He 2023-07-06  136  #define iowrite32be iowrite32be
b94692e84dccf1 Baoquan He 2023-07-06  137  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
