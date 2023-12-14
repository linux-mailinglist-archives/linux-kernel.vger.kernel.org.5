Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A179812582
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442935AbjLNCuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjLNCua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:50:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9EBBD;
        Wed, 13 Dec 2023 18:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702522236; x=1734058236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I15hJujeofSj5fxuFiA6C/A8qOOHMoj68xaDjhNImok=;
  b=HR4+eKfoq5quv77MO2Q0bV6YMaBEdXG8/8IMgZMq86zhKTjzKrpv8iDz
   lsDIE+6puofHtQO2/+oOk62vB3mF+QfISMCU4JLggdItGGQWuRxlqCXC9
   wnxyS6PDEFoR+0uZ5SJjuSed7/022+LI8iO3hJ4sBAe2jktj7seokqdjQ
   QsmO2vkJzNFnI9B98jgO1geLG/51421552AWyS7mA/4pp6n7Lqelwx06J
   p+loGoMAftiwVeK4+v87HwNfuU0U/u44DKTA2tnTt9ly+QwpvaHzSQva4
   PrV48fhSO1xZsKoVyf6OQROxne4L64BxJRalR12gkb5EYymjktbgu1zjX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2231264"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="2231264"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 18:50:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="22215947"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 13 Dec 2023 18:50:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDbnx-000LSd-1Y;
        Thu, 14 Dec 2023 02:50:29 +0000
Date:   Thu, 14 Dec 2023 10:50:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akhil R <akhilrajeev@nvidia.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Akhil R <akhilrajeev@nvidia.com>
Subject: Re: [PATCH 3/5] crypto: tegra: Add Tegra Security Engine driver
Message-ID: <202312141027.GVOE05ds-lkp@intel.com>
References: <20231213122030.11734-4-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213122030.11734-4-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akhil,

kernel test robot noticed the following build errors:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on drm/drm-next arm64/for-next/core robh/for-next linus/master v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akhil-R/dt-bindings-crypto-Add-Tegra-SE-DT-binding-doc/20231213-202407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20231213122030.11734-4-akhilrajeev%40nvidia.com
patch subject: [PATCH 3/5] crypto: tegra: Add Tegra Security Engine driver
config: hexagon-randconfig-r071-20231214 (https://download.01.org/0day-ci/archive/20231214/202312141027.GVOE05ds-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312141027.GVOE05ds-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141027.GVOE05ds-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/crypto/tegra/tegra-se-key.c:11:
   In file included from drivers/crypto/tegra/tegra-se.h:10:
   In file included from include/linux/iommu.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/crypto/tegra/tegra-se-key.c:11:
   In file included from drivers/crypto/tegra/tegra-se.h:10:
   In file included from include/linux/iommu.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/crypto/tegra/tegra-se-key.c:11:
   In file included from drivers/crypto/tegra/tegra-se.h:10:
   In file included from include/linux/iommu.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/crypto/tegra/tegra-se-key.c:57:18: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cpuvaddr[i++] = SE_AES_OP_WRSTALL | SE_AES_OP_DUMMY;
                           ^
   drivers/crypto/tegra/tegra-se.h:202:30: note: expanded from macro 'SE_AES_OP_WRSTALL'
   #define SE_AES_OP_WRSTALL                               FIELD_PREP(BIT(15), 1)
                                                           ^
   6 warnings and 1 error generated.
--
   In file included from drivers/crypto/tegra/tegra-se-aes.c:8:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/crypto/tegra/tegra-se-aes.c:8:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/crypto/tegra/tegra-se-aes.c:8:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/crypto/tegra/tegra-se-aes.c:136:11: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           return SE_CRYPTO_CFG_CBC_ENCRYPT;
                                  ^
   drivers/crypto/tegra/tegra-se.h:293:38: note: expanded from macro 'SE_CRYPTO_CFG_CBC_ENCRYPT'
   #define SE_CRYPTO_CFG_CBC_ENCRYPT                       (SE_AES_INPUT_SEL_MEMORY | \
                                                            ^
   drivers/crypto/tegra/tegra-se.h:182:36: note: expanded from macro 'SE_AES_INPUT_SEL_MEMORY'
   #define SE_AES_INPUT_SEL_MEMORY                         SE_AES_CRYPTO_CFG_INPUT_SEL(0)
                                                           ^
   drivers/crypto/tegra/tegra-se.h:181:42: note: expanded from macro 'SE_AES_CRYPTO_CFG_INPUT_SEL'
   #define SE_AES_CRYPTO_CFG_INPUT_SEL(x)                  FIELD_PREP(GENMASK(4, 3), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:173:11: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           return SE_CFG_AES_ENCRYPT;
                                  ^
   drivers/crypto/tegra/tegra-se.h:237:32: note: expanded from macro 'SE_CFG_AES_ENCRYPT'
   #define SE_CFG_AES_ENCRYPT                              (SE_AES_ENC_ALG_AES_ENC | \
                                                            ^
   drivers/crypto/tegra/tegra-se.h:137:35: note: expanded from macro 'SE_AES_ENC_ALG_AES_ENC'
   #define SE_AES_ENC_ALG_AES_ENC                          SE_AES_CFG_ENC_ALG(1)
                                                           ^
   drivers/crypto/tegra/tegra-se.h:135:34: note: expanded from macro 'SE_AES_CFG_ENC_ALG'
   #define SE_AES_CFG_ENC_ALG(x)                           FIELD_PREP(GENMASK(15, 12), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:228:18: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cpuvaddr[i++] = SE_ADDR_HI_MSB(upper_32_bits(addr)) | SE_ADDR_HI_SZ(rctx->len);
                           ^
   drivers/crypto/tegra/tegra-se.h:234:30: note: expanded from macro 'SE_ADDR_HI_MSB'
   #define SE_ADDR_HI_MSB(x)                               FIELD_PREP(GENMASK(31, 24), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:373:13: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           manifest = SE_KAC_USER_NS;
                      ^
   drivers/crypto/tegra/tegra-se.h:231:28: note: expanded from macro 'SE_KAC_USER_NS'
   #define SE_KAC_USER_NS                                  FIELD_PREP(GENMASK(6, 4), 3)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:426:25: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           rctx->crypto_config |= SE_AES_KEY_INDEX(ctx->key1_id);
                                  ^
   drivers/crypto/tegra/tegra-se.h:156:32: note: expanded from macro 'SE_AES_KEY_INDEX'
   #define SE_AES_KEY_INDEX(x)                             FIELD_PREP(GENMASK(27, 24), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:445:25: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           rctx->crypto_config |= SE_AES_KEY_INDEX(ctx->key1_id);
                                  ^
   drivers/crypto/tegra/tegra-se.h:156:32: note: expanded from macro 'SE_AES_KEY_INDEX'
   #define SE_AES_KEY_INDEX(x)                             FIELD_PREP(GENMASK(27, 24), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:585:18: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cpuvaddr[i++] = SE_LAST_BLOCK_VAL(data_count) |
                           ^
   drivers/crypto/tegra/tegra-se.h:198:33: note: expanded from macro 'SE_LAST_BLOCK_VAL'
   #define SE_LAST_BLOCK_VAL(x)                            FIELD_PREP(GENMASK(19, 0), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:616:7: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           op = SE_AES_OP_WRSTALL | SE_AES_OP_FINAL |
                ^
   drivers/crypto/tegra/tegra-se.h:202:30: note: expanded from macro 'SE_AES_OP_WRSTALL'
   #define SE_AES_OP_WRSTALL                               FIELD_PREP(BIT(15), 1)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:673:7: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           op = SE_AES_OP_WRSTALL | SE_AES_OP_FINAL |
                ^
   drivers/crypto/tegra/tegra-se.h:202:30: note: expanded from macro 'SE_AES_OP_WRSTALL'
   #define SE_AES_OP_WRSTALL                               FIELD_PREP(BIT(15), 1)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:728:10: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                 SE_AES_KEY_INDEX(ctx->key_id);
                                 ^
   drivers/crypto/tegra/tegra-se.h:156:32: note: expanded from macro 'SE_AES_KEY_INDEX'
   #define SE_AES_KEY_INDEX(x)                             FIELD_PREP(GENMASK(27, 24), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:745:10: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                 SE_AES_KEY_INDEX(ctx->key_id);
                                 ^
   drivers/crypto/tegra/tegra-se.h:156:32: note: expanded from macro 'SE_AES_KEY_INDEX'
   #define SE_AES_KEY_INDEX(x)                             FIELD_PREP(GENMASK(27, 24), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:768:10: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                 SE_AES_KEY_INDEX(ctx->key_id);
                                 ^
   drivers/crypto/tegra/tegra-se.h:156:32: note: expanded from macro 'SE_AES_KEY_INDEX'
   #define SE_AES_KEY_INDEX(x)                             FIELD_PREP(GENMASK(27, 24), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:824:18: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cpuvaddr[i++] = SE_LAST_BLOCK_VAL(data_count);
                           ^
   drivers/crypto/tegra/tegra-se.h:198:33: note: expanded from macro 'SE_LAST_BLOCK_VAL'
   #define SE_LAST_BLOCK_VAL(x)                            FIELD_PREP(GENMASK(19, 0), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:869:18: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cpuvaddr[i++] = SE_ADDR_HI_MSB(upper_32_bits(rctx->inbuf.addr)) |
                           ^
   drivers/crypto/tegra/tegra-se.h:234:30: note: expanded from macro 'SE_ADDR_HI_MSB'
   #define SE_ADDR_HI_MSB(x)                               FIELD_PREP(GENMASK(31, 24), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-aes.c:899:13: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                                         SE_AES_KEY_INDEX(ctx->key_id);
                                                         ^
   drivers/crypto/tegra/tegra-se.h:156:32: note: expanded from macro 'SE_AES_KEY_INDEX'
   #define SE_AES_KEY_INDEX(x)                             FIELD_PREP(GENMASK(27, 24), x)
--
   In file included from drivers/crypto/tegra/tegra-se-hash.c:8:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/crypto/tegra/tegra-se-hash.c:8:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/crypto/tegra/tegra-se-hash.c:8:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/crypto/tegra/tegra-se-hash.c:53:10: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   cfg |= SE_SHA_ENC_ALG_SHA;
                          ^
   drivers/crypto/tegra/tegra-se.h:59:31: note: expanded from macro 'SE_SHA_ENC_ALG_SHA'
   #define SE_SHA_ENC_ALG_SHA                              SE_SHA_CFG_ENC_ALG(3)
                                                           ^
   drivers/crypto/tegra/tegra-se.h:55:34: note: expanded from macro 'SE_SHA_CFG_ENC_ALG'
   #define SE_SHA_CFG_ENC_ALG(x)                           FIELD_PREP(GENMASK(15, 12), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-hash.c:256:24: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cpuvaddr[i++] = (u32)(SE_ADDR_HI_MSB(upper_32_bits(rctx->datbuf.addr)) |
                                 ^
   drivers/crypto/tegra/tegra-se.h:234:30: note: expanded from macro 'SE_ADDR_HI_MSB'
   #define SE_ADDR_HI_MSB(x)                               FIELD_PREP(GENMASK(31, 24), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-hash.c:331:4: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           SE_SHA_DST_HASH_REG;
                           ^
   drivers/crypto/tegra/tegra-se.h:85:32: note: expanded from macro 'SE_SHA_DST_HASH_REG'
   #define SE_SHA_DST_HASH_REG                             SE_SHA_CFG_DST(1)
                                                           ^
   drivers/crypto/tegra/tegra-se.h:83:30: note: expanded from macro 'SE_SHA_CFG_DST'
   #define SE_SHA_CFG_DST(x)                               FIELD_PREP(GENMASK(4, 2), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-hash.c:352:10: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                          SE_SHA_DST_MEMORY;
                          ^
   drivers/crypto/tegra/tegra-se.h:84:30: note: expanded from macro 'SE_SHA_DST_MEMORY'
   #define SE_SHA_DST_MEMORY                               SE_SHA_CFG_DST(0)
                                                           ^
   drivers/crypto/tegra/tegra-se.h:83:30: note: expanded from macro 'SE_SHA_CFG_DST'
   #define SE_SHA_CFG_DST(x)                               FIELD_PREP(GENMASK(4, 2), x)
                                                           ^
   drivers/crypto/tegra/tegra-se-hash.c:457:14: warning: variable 'algname' set but not used [-Wunused-but-set-variable]
           const char *algname;
                       ^
   drivers/crypto/tegra/tegra-se-hash.c:961:13: error: implicit declaration of function 'FIELD_PREP' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           manifest = SE_KAC_USER_NS;
                      ^
   drivers/crypto/tegra/tegra-se.h:231:28: note: expanded from macro 'SE_KAC_USER_NS'
   #define SE_KAC_USER_NS                                  FIELD_PREP(GENMASK(6, 4), 3)
                                                           ^
   7 warnings and 5 errors generated.


vim +/FIELD_PREP +57 drivers/crypto/tegra/tegra-se-key.c

    49	
    50	static unsigned int tegra_key_prep_ins_cmd(struct tegra_se *se, u32 *cpuvaddr,
    51						   const u32 *key, u32 keylen, u16 slot, u32 alg)
    52	{
    53		int i = 0, j;
    54	
    55		cpuvaddr[i++] = host1x_opcode_setpayload(1);
    56		cpuvaddr[i++] = se_host1x_opcode_incr_w(se->hw->regs->op);
  > 57		cpuvaddr[i++] = SE_AES_OP_WRSTALL | SE_AES_OP_DUMMY;
    58	
    59		cpuvaddr[i++] = host1x_opcode_setpayload(1);
    60		cpuvaddr[i++] = se_host1x_opcode_incr_w(se->hw->regs->manifest);
    61		cpuvaddr[i++] = se->manifest(se->owner, alg, keylen);
    62		cpuvaddr[i++] = host1x_opcode_setpayload(1);
    63		cpuvaddr[i++] = se_host1x_opcode_incr_w(se->hw->regs->key_dst);
    64	
    65		cpuvaddr[i++] = SE_AES_KEY_DST_INDEX(slot);
    66	
    67		for (j = 0; j < keylen / 4; j++) {
    68			/* Set key address */
    69			cpuvaddr[i++] = host1x_opcode_setpayload(1);
    70			cpuvaddr[i++] = se_host1x_opcode_incr_w(se->hw->regs->key_addr);
    71			cpuvaddr[i++] = j;
    72	
    73			/* Set key data */
    74			cpuvaddr[i++] = host1x_opcode_setpayload(1);
    75			cpuvaddr[i++] = se_host1x_opcode_incr_w(se->hw->regs->key_data);
    76			cpuvaddr[i++] = key[j];
    77		}
    78	
    79		cpuvaddr[i++] = host1x_opcode_setpayload(1);
    80		cpuvaddr[i++] = se_host1x_opcode_incr_w(se->hw->regs->config);
    81		cpuvaddr[i++] = SE_CFG_INS;
    82	
    83		cpuvaddr[i++] = host1x_opcode_setpayload(1);
    84		cpuvaddr[i++] = se_host1x_opcode_incr_w(se->hw->regs->op);
    85		cpuvaddr[i++] = SE_AES_OP_WRSTALL | SE_AES_OP_START |
    86				SE_AES_OP_LASTBUF;
    87	
    88		cpuvaddr[i++] = se_host1x_opcode_nonincr(host1x_uclass_incr_syncpt_r(), 1);
    89		cpuvaddr[i++] = host1x_uclass_incr_syncpt_cond_f(1) |
    90				host1x_uclass_incr_syncpt_indx_f(se->syncpt_id);
    91	
    92		dev_dbg(se->dev, "key-slot %u key-manifest %#x\n",
    93			slot, se->manifest(se->owner, alg, keylen));
    94	
    95		return i;
    96	}
    97	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
