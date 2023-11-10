Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA71F7E846D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbjKJUmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346230AbjKJUlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:41:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C5B2B7F5;
        Fri, 10 Nov 2023 01:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699607848; x=1731143848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1rI7B1mbSpr0x0m6XcSgRTnf3/7PPzT+G9Y/3Sg1CwQ=;
  b=mkSrdnhQpM0eHIPIFoZYsiYLDqmX/qXWAM1FfWG4dN6018aLCeMGlguG
   +JWgtmEzL2DHUkNjkxAZwhfbVdLWh8GRv1y9wT0plFN2PJW5gJwTJRKSO
   0+5Wk0XuGkz5y1oTDwbPDJ8n3HWj2ZG6xPo3+quQYGIOUjg5TCFQjMAIE
   USree6uWgs3V4t5eFwCycqmnKFndO9t6EBVVGJg5ZOFld2lSz1izc6BV+
   c0XoFa6bqEIW3B/5sWcpvFh6huh2ckIpz6ONo2b4DrguJAvWugtbMU0/+
   fXGMqR9H12VHHKy8sykP0qy2NvsgND/HRr4+gGJKoVqRs8M77hEovAeaa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="3142624"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="3142624"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 01:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="763709668"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="763709668"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Nov 2023 01:17:24 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1Ndi-0009WP-2H;
        Fri, 10 Nov 2023 09:17:22 +0000
Date:   Fri, 10 Nov 2023 17:16:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com,
        vkoul@kernel.org
Subject: Re: [PATCH 4/4] dmaengine: fsl-edma: integrate TCD64 support for
 i.MX95
Message-ID: <202311101713.0LTPV63a-lkp@intel.com>
References: <20231109212059.1894646-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109212059.1894646-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231109]
[also build test ERROR on linus/master v6.6]
[cannot apply to vkoul-dmaengine/next v6.6 v6.6-rc7 v6.6-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-edma-involve-help-macro-fsl_edma_set-get-_tcd/20231110-053023
base:   next-20231109
patch link:    https://lore.kernel.org/r/20231109212059.1894646-5-Frank.Li%40nxp.com
patch subject: [PATCH 4/4] dmaengine: fsl-edma: integrate TCD64 support for i.MX95
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20231110/202311101713.0LTPV63a-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311101713.0LTPV63a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311101713.0LTPV63a-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/little_endian.h:14,
                    from include/linux/byteorder/little_endian.h:5,
                    from arch/csky/include/uapi/asm/byteorder.h:6,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/csky/include/asm/bitops.h:77,
                    from include/linux/bitops.h:68,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/csky/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/dma/fsl-edma-main.c:12:
   drivers/dma/fsl-edma-common.h: In function 'edma_readq':
>> drivers/dma/fsl-edma-common.h:344:31: error: implicit declaration of function 'readq'; did you mean 'readw'? [-Werror=implicit-function-declaration]
     344 |                 return swab64(readq(addr));
         |                               ^~~~~
   include/uapi/linux/swab.h:128:54: note: in definition of macro '__swab64'
     128 | #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
         |                                                      ^
   drivers/dma/fsl-edma-common.h:344:24: note: in expansion of macro 'swab64'
     344 |                 return swab64(readq(addr));
         |                        ^~~~~~
   In file included from drivers/dma/fsl-edma-main.c:22:
   drivers/dma/fsl-edma-common.h: In function 'edma_writeq':
>> drivers/dma/fsl-edma-common.h:399:17: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
     399 |                 writeq(swab64(val), addr);
         |                 ^~~~~~
         |                 writel
   cc1: some warnings being treated as errors
--
   In file included from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/little_endian.h:14,
                    from include/linux/byteorder/little_endian.h:5,
                    from arch/csky/include/uapi/asm/byteorder.h:6,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/csky/include/asm/bitops.h:77,
                    from include/linux/bitops.h:68,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/csky/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/dma/mcf-edma-main.c:6:
   drivers/dma/fsl-edma-common.h: In function 'edma_readq':
>> drivers/dma/fsl-edma-common.h:344:31: error: implicit declaration of function 'readq'; did you mean 'readw'? [-Werror=implicit-function-declaration]
     344 |                 return swab64(readq(addr));
         |                               ^~~~~
   include/uapi/linux/swab.h:128:54: note: in definition of macro '__swab64'
     128 | #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
         |                                                      ^
   drivers/dma/fsl-edma-common.h:344:24: note: in expansion of macro 'swab64'
     344 |                 return swab64(readq(addr));
         |                        ^~~~~~
   In file included from drivers/dma/mcf-edma-main.c:12:
   drivers/dma/fsl-edma-common.h: In function 'edma_writeq':
>> drivers/dma/fsl-edma-common.h:399:17: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
     399 |                 writeq(swab64(val), addr);
         |                 ^~~~~~
         |                 writel
   drivers/dma/mcf-edma-main.c: In function 'mcf_edma_probe':
   drivers/dma/mcf-edma-main.c:205:46: warning: dereferencing 'void *' pointer
     205 |                 iowrite32(0x0, &mcf_chan->tcd->csr);
         |                                              ^~
   drivers/dma/mcf-edma-main.c:205:46: error: request for member 'csr' in something not a structure or union
   cc1: some warnings being treated as errors


vim +344 drivers/dma/fsl-edma-common.h

   333	
   334	/*
   335	 * R/W functions for big- or little-endian registers:
   336	 * The eDMA controller's endian is independent of the CPU core's endian.
   337	 * For the big-endian IP module, the offset for 8-bit or 16-bit registers
   338	 * should also be swapped opposite to that in little-endian IP.
   339	 */
   340	static inline u64 edma_readq(struct fsl_edma_engine *edma, void __iomem *addr)
   341	{
   342		/* ioread64 and ioread64be was not defined at some platform */
   343		if (edma->big_endian)
 > 344			return swab64(readq(addr));
   345		else
   346			return readq(addr);
   347	}
   348	
   349	static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
   350	{
   351		if (edma->big_endian)
   352			return ioread32be(addr);
   353		else
   354			return ioread32(addr);
   355	}
   356	
   357	static inline u16 edma_readw(struct fsl_edma_engine *edma, void __iomem *addr)
   358	{
   359		if (edma->big_endian)
   360			return ioread16be(addr);
   361		else
   362			return ioread16(addr);
   363	}
   364	
   365	static inline void edma_writeb(struct fsl_edma_engine *edma,
   366				       u8 val, void __iomem *addr)
   367	{
   368		/* swap the reg offset for these in big-endian mode */
   369		if (edma->big_endian)
   370			iowrite8(val, (void __iomem *)((unsigned long)addr ^ 0x3));
   371		else
   372			iowrite8(val, addr);
   373	}
   374	
   375	static inline void edma_writew(struct fsl_edma_engine *edma,
   376				       u16 val, void __iomem *addr)
   377	{
   378		/* swap the reg offset for these in big-endian mode */
   379		if (edma->big_endian)
   380			iowrite16be(val, (void __iomem *)((unsigned long)addr ^ 0x2));
   381		else
   382			iowrite16(val, addr);
   383	}
   384	
   385	static inline void edma_writel(struct fsl_edma_engine *edma,
   386				       u32 val, void __iomem *addr)
   387	{
   388		if (edma->big_endian)
   389			iowrite32be(val, addr);
   390		else
   391			iowrite32(val, addr);
   392	}
   393	
   394	static inline void edma_writeq(struct fsl_edma_engine *edma,
   395				       u64 val, void __iomem *addr)
   396	{
   397		/* iowrite64 and iowrite64be was not defined at some platform */
   398		if (edma->big_endian)
 > 399			writeq(swab64(val), addr);
   400		else
   401			writeq(val, addr);
   402	}
   403	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
