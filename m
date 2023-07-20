Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01E175A64B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjGTG0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGTG0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:26:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B952111
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689834397; x=1721370397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ab9EpTq3kAxuQgLzIkGiqoqUu64VuJ68ylr/9K2+01M=;
  b=VCWvsaLf/hOk5c9TcoNS9vS/TZHXLKM+dsNZgwmLoVbd6trtYJrcp72I
   RR7jT+vwZfdGH+Uc6PBajl9tI0M3ddrKzq6KG90JvoBOtTPDj4GquF5ut
   2IgX977XENcI80ceazVEo75msv1VQfczSkRHs8asSnxlamyiJGQQEr5py
   Kit9gZlfnIJaifsxQcAPewci3KenVG/DPJGCOyv6rMoTMHTgSGLXBRBsv
   czvCYxpZX2hcAaRp/kTTMugl0pl199Z7uPQ9ZmVhsdV0YMVgAyxBXjpKx
   EnSCw9MfdstDcP4Of4Y/i29iWB0HFX7gx/+BCXO/nyQvVoesRMszY9A9c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="430412046"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="430412046"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 23:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="718256631"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="718256631"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 23:26:31 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMN7O-0005ob-1q;
        Thu, 20 Jul 2023 06:26:30 +0000
Date:   Thu, 20 Jul 2023 14:25:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Victor Lim <vlim@gigadevice.com>, tudor.ambarus@linaro.org,
        pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, akumarma@amd.com
Cc:     oe-kbuild-all@lists.linux.dev, michael@walle.cc,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        vikhyat.goyal@amd.com, Victor Lim <vlim@gigadevice.com>
Subject: Re: [PATCH V1 1/1] linux: drivers: mtd: spi-nor: gigadevice.c
Message-ID: <202307201459.rKBT7i1H-lkp@intel.com>
References: <20230720042834.12296-1-vlim@gigadevice.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720042834.12296-1-vlim@gigadevice.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Victor,

kernel test robot noticed the following build errors:

[auto build test ERROR on mtd/spi-nor/next]
[also build test ERROR on linus/master v6.5-rc2 next-20230720]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Victor-Lim/linux-drivers-mtd-spi-nor-gigadevice-c/20230720-123114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
patch link:    https://lore.kernel.org/r/20230720042834.12296-1-vlim%40gigadevice.com
patch subject: [PATCH V1 1/1] linux: drivers: mtd: spi-nor: gigadevice.c
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230720/202307201459.rKBT7i1H-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307201459.rKBT7i1H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307201459.rKBT7i1H-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mtd/spi-nor/gigadevice.c:75:58: error: macro "INFO" passed 5 arguments, but takes just 4
      75 |                               SPI_NOR_IO_MODE_EN_VOLATILE)
         |                                                          ^
   In file included from drivers/mtd/spi-nor/gigadevice.c:9:
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
>> drivers/mtd/spi-nor/gigadevice.c:71:26: error: 'INFO' undeclared here (not in a function)
      71 |         { "gd25lx256e",  INFO(0xc86819, 0, 64 * 1024, 512,
         |                          ^~~~
>> drivers/mtd/spi-nor/gigadevice.c:76:28: error: 'gd25lx256e_fixups' undeclared here (not in a function); did you mean 'gd25q256_fixups'?
      76 |                 .fixups = &gd25lx256e_fixups },
         |                            ^~~~~~~~~~~~~~~~~
         |                            gd25q256_fixups
   drivers/mtd/spi-nor/gigadevice.c:78:66: error: macro "INFO" passed 5 arguments, but takes just 4
      78 |         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
         |                                                                  ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:80:66: error: macro "INFO" passed 5 arguments, but takes just 4
      80 |         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
         |                                                                  ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:82:66: error: macro "INFO" passed 5 arguments, but takes just 4
      82 |         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
         |                                                                  ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:84:65: error: macro "INFO" passed 5 arguments, but takes just 4
      84 |         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
         |                                                                 ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:86:65: error: macro "INFO" passed 5 arguments, but takes just 4
      86 |         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
         |                                                                 ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:88:86: error: macro "INFO" passed 5 arguments, but takes just 4
      88 |         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
         |                                                                                      ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:90:86: error: macro "INFO" passed 5 arguments, but takes just 4
      90 |         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
         |                                                                                      ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:92:66: error: macro "INFO" passed 5 arguments, but takes just 4
      92 |         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
         |                                                                  ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:94:66: error: macro "INFO" passed 5 arguments, but takes just 4
      94 |         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
         |                                                                  ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:96:66: error: macro "INFO" passed 5 arguments, but takes just 4
      96 |         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
         |                                                                  ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:98:48: error: macro "INFO" passed 5 arguments, but takes just 4
      98 |         SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
         |                                                ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:100:48: error: macro "INFO" passed 5 arguments, but takes just 4
     100 |         SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
         |                                                ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:102:48: error: macro "INFO" passed 5 arguments, but takes just 4
     102 |         SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
         |                                                ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:104:65: error: macro "INFO" passed 5 arguments, but takes just 4
     104 |         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
         |                                                                 ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:106:65: error: macro "INFO" passed 5 arguments, but takes just 4
     106 |         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)       },
         |                                                                 ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:108:65: error: macro "INFO" passed 5 arguments, but takes just 4
     108 |         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)       },
         |                                                                 ^
   drivers/mtd/spi-nor/core.h:563: note: macro "INFO" defined here
     563 | #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)              \
         | 
   drivers/mtd/spi-nor/gigadevice.c:110:65: error: macro "INFO" passed 5 arguments, but takes just 4


vim +/INFO +75 drivers/mtd/spi-nor/gigadevice.c

     8	
   > 9	#include "core.h"
    10	
    11	static int
    12	gd25q256_post_bfpt(struct spi_nor *nor,
    13			   const struct sfdp_parameter_header *bfpt_header,
    14			   const struct sfdp_bfpt *bfpt)
    15	{
    16		/*
    17		 * GD25Q256C supports the first version of JESD216 which does not define
    18		 * the Quad Enable methods. Overwrite the default Quad Enable method.
    19		 *
    20		 * GD25Q256 GENERATION | SFDP MAJOR VERSION | SFDP MINOR VERSION
    21		 *      GD25Q256C      | SFDP_JESD216_MAJOR | SFDP_JESD216_MINOR
    22		 *      GD25Q256D      | SFDP_JESD216_MAJOR | SFDP_JESD216B_MINOR
    23		 *      GD25Q256E      | SFDP_JESD216_MAJOR | SFDP_JESD216B_MINOR
    24		 */
    25		if (bfpt_header->major == SFDP_JESD216_MAJOR &&
    26		    bfpt_header->minor == SFDP_JESD216_MINOR)
    27			nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
    28	
    29		return 0;
    30	}
    31	
    32	static const struct spi_nor_fixups gd25q256_fixups = {
    33		.post_bfpt = gd25q256_post_bfpt,
    34	};
    35	
    36	static const struct flash_info gigadevice_nor_parts[] = {
    37		{ "gd25q16", INFO(0xc84015, 0, 64 * 1024,  32)
    38			FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
    39			NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
    40				      SPI_NOR_QUAD_READ) },
    41		{ "gd25q32", INFO(0xc84016, 0, 64 * 1024,  64)
    42			FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
    43			NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
    44				      SPI_NOR_QUAD_READ) },
    45		{ "gd25lq32", INFO(0xc86016, 0, 64 * 1024, 64)
    46			FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
    47			NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
    48				      SPI_NOR_QUAD_READ) },
    49		{ "gd25q64", INFO(0xc84017, 0, 64 * 1024, 128)
    50			FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
    51			NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
    52				      SPI_NOR_QUAD_READ) },
    53		{ "gd25lq64c", INFO(0xc86017, 0, 64 * 1024, 128)
    54			FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
    55			NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
    56				      SPI_NOR_QUAD_READ) },
    57		{ "gd25lq128d", INFO(0xc86018, 0, 64 * 1024, 256)
    58			FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
    59			NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
    60				      SPI_NOR_QUAD_READ) },
    61		{ "gd25q128", INFO(0xc84018, 0, 64 * 1024, 256)
    62			FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
    63			NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
    64				      SPI_NOR_QUAD_READ) },
    65		{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512)
    66			PARSE_SFDP
    67			FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
    68			FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
    69			.fixups = &gd25q256_fixups },
    70	/* adding these parts */
  > 71		{ "gd25lx256e",  INFO(0xc86819, 0, 64 * 1024, 512,
    72				      SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
    73				      SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ |
    74				      SPI_NOR_OCTAL_DTR_PP |
  > 75				      SPI_NOR_IO_MODE_EN_VOLATILE)
  > 76			.fixups = &gd25lx256e_fixups },
    77		{"gd25b512", INFO(0xc8471A, 0, 64 * 1024, 1024,	SECT_4K |
    78		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
    79		{"gd55b01g", INFO(0xc8471B, 0, 64 * 1024, 2048,	SECT_4K |
    80		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
    81		{"gd55b02g", INFO(0xc8471C, 0, 64 * 1024, 4096,	SECT_4K |
    82		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
    83		{"gd25f64", INFO(0xc84317, 0, 64 * 1024, 128,	SECT_4K |
    84		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
    85		{"gd25f128", INFO(0xc84318, 0, 64 * 1024, 256,	SECT_4K	|
    86		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
    87		{"gd25f256", INFO(0xc84319, 0, 64 * 1024, 512,	SECT_4K |
    88		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
    89		{"gd55f512", INFO(0xc8431A, 0, 64 * 1024, 1024,	SECT_4K |
    90		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
    91		{"gd25t512", INFO(0xc8461A, 0, 64 * 1024, 1024,	SECT_4K |
    92		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
    93		{"gd55t01g", INFO(0xc8461B, 0, 64 * 1024, 2048,	SECT_4K |
    94		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
    95		{"gd55t02ge", INFO(0xc8461C, 0, 64 * 1024, 4096,	SECT_4K |
    96		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
    97		{"gd25x512", INFO(0xc8481A, 0, 64 * 1024, 1024,	SECT_4K |
    98		SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
    99		{"gd55x01g", INFO(0xc8481B, 0, 64 * 1024, 2048,	SECT_4K |
   100		SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
   101		{"gd55x02g", INFO(0xc8481C, 0, 64 * 1024, 4096,	SECT_4K |
   102		SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
   103		{"gd25lb16", INFO(0xc86015, 0, 64 * 1024, 32,	SECT_4K |
   104		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
   105		{"gd25lb32", INFO(0xc86016, 0, 64 * 1024, 64,	SECT_4K |
   106		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
   107		{"gd25lb64", INFO(0xc86017, 0, 64 * 1024, 128,	SECT_4K |
   108		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
   109		{"gd25lb128", INFO(0xc86018, 0, 64 * 1024, 256,	SECT_4K |
   110		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
   111		{"gd25lb256", INFO(0xc86019, 0, 64 * 1024, 512,	SECT_4K |
   112		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   113		{"gd25lb256", INFO(0xc86719, 0, 64 * 1024, 512,	SECT_4K |
   114		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   115		{"gd25lb512", INFO(0xc8671A, 0, 64 * 1024, 1024,	SECT_4K |
   116		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   117		{"gd55lb01g", INFO(0xc8671B, 0, 64 * 1024, 2048,	SECT_4K |
   118		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   119		{"gd55lb02g", INFO(0xc8671C, 0, 64 * 1024, 4096,	SECT_4K |
   120		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   121		{"gd25lf80", INFO(0xc86314, 0, 64 * 1024, 16,	SECT_4K |
   122		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
   123		{"gd25lf16", INFO(0xc86315, 0, 64 * 1024, 32,	SECT_4K |
   124		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
   125		{"gd25lf32", INFO(0xc86316, 0, 64 * 1024, 64,	SECT_4K |
   126		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
   127		{"gd25lf64", INFO(0xc86317, 0, 64 * 1024, 128,	SECT_4K |
   128		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
   129		{"gd25lf128", INFO(0xc86318, 0, 64 * 1024, 256,	SECT_4K |
   130		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)	},
   131		{"gd25lf255", INFO(0xc86319, 0, 64 * 1024, 512,	SECT_4K |
   132		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   133		{"gd25lf511", INFO(0xc8631A, 0, 64 * 1024, 1024,	SECT_4K |
   134		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   135		{"gd25lt256e", INFO(0xc86619, 0, 64 * 1024, 512,	SECT_4K |
   136		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   137		{"gd25lt512", INFO(0xc8661A, 0, 64 * 1024, 1024,	SECT_4K |
   138		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   139		{"gd55lt01g", INFO(0xc8661B, 0, 64 * 1024, 2048,	SECT_4K |
   140		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   141		{"gd55lt02g", INFO(0xc8661C, 0, 64 * 1024, 4096,	SECT_4K |
   142		SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
   143		{"gd25lx512", INFO(0xc8681A, 0, 64 * 1024, 1024,	SECT_4K |
   144		SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
   145		{"gd55lx01g", INFO(0xc8681B, 0, 64 * 1024, 2048,	SECT_4K |
   146		SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
   147		{"gd55lx02g", INFO(0xc8681C, 0, 64 * 1024, 4096,	SECT_4K |
   148		SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
   149	};
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
