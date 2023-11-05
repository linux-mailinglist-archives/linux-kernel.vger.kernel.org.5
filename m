Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2396F7E1620
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 20:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjKETkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 14:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKETki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 14:40:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343EEDE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699213235; x=1730749235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HJ7ebYgTZw26JpOn2NJc32tbIQS27rWBAhL0mbrc7rg=;
  b=hyDFIZQc6EumKoCg12b5/dZrq/vLEq0fFeyE0V2dy+izUltiVJbfferI
   ygIkbeyDLqvuJS2VHCyCS/l6/x6ZRwawSNmO9m49+y/NcnVnsr0ap9keU
   ZpzFaxNmYes4zPUretMRV9B3Gt2d88oWiTWsa4erxzKg34OcjJCx3mBp4
   2JBrgeu2IolP4X4YEiPhWRdA+IT6AZfhztorfblvVv3VXgMIzfS62dzEf
   Vt6B2UzGRoPUwJ6LRpTuOAHGS4eQ9ubXxpdstLVlxa42hxAvGVJUAV8uy
   5jpMF2ivy456glBuKFJdYx8Ps8YFrGB6u4aVGnR5RTtYBRU8Kmbq4QfC3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="392036265"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="392036265"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 11:40:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="791272790"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="791272790"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2023 11:40:32 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qziz0-0005kB-1A;
        Sun, 05 Nov 2023 19:40:30 +0000
Date:   Mon, 6 Nov 2023 03:40:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rhys Kidd <rhyskidd@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1954: warning:
 Function parameter or member 'init' not described in 'init_reset_end'
Message-ID: <202311060348.8mtqu7JM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: 9f9b450752d38c86f4f830214bb9276ed174d5d3 drm/nouveau/bios/init: handle INIT_RESET_END devinit opcode
date:   4 years, 2 months ago
config: i386-randconfig-004-20231101 (https://download.01.org/0day-ci/archive/20231106/202311060348.8mtqu7JM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060348.8mtqu7JM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060348.8mtqu7JM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:768: warning: Function parameter or member 'init' not described in 'init_not'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:768: warning: expecting prototype for INIT_NOT(). Prototype was for init_not() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:780: warning: Function parameter or member 'init' not described in 'init_io_flag_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:780: warning: expecting prototype for INIT_IO_FLAG_CONDITION(). Prototype was for init_io_flag_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:797: warning: Function parameter or member 'init' not described in 'init_generic_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:797: warning: expecting prototype for INIT_GENERIC_CONDITION(). Prototype was for init_generic_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:849: warning: Function parameter or member 'init' not described in 'init_io_mask_or'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:849: warning: expecting prototype for INIT_IO_MASK_OR(). Prototype was for init_io_mask_or() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:868: warning: Function parameter or member 'init' not described in 'init_io_or'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:868: warning: expecting prototype for INIT_IO_OR(). Prototype was for init_io_or() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:887: warning: Function parameter or member 'init' not described in 'init_andn_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:887: warning: expecting prototype for INIT_ANDN_REG(). Prototype was for init_andn_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:904: warning: Function parameter or member 'init' not described in 'init_or_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:904: warning: expecting prototype for INIT_OR_REG(). Prototype was for init_or_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:921: warning: Function parameter or member 'init' not described in 'init_idx_addr_latched'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:921: warning: expecting prototype for INIT_INDEX_ADDRESS_LATCHED(). Prototype was for init_idx_addr_latched() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:951: warning: Function parameter or member 'init' not described in 'init_io_restrict_pll2'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:951: warning: expecting prototype for INIT_IO_RESTRICT_PLL2(). Prototype was for init_io_restrict_pll2() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:986: warning: Function parameter or member 'init' not described in 'init_pll2'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:986: warning: expecting prototype for INIT_PLL2(). Prototype was for init_pll2() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1003: warning: Function parameter or member 'init' not described in 'init_i2c_byte'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1003: warning: expecting prototype for INIT_I2C_BYTE(). Prototype was for init_i2c_byte() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1034: warning: Function parameter or member 'init' not described in 'init_zm_i2c_byte'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1034: warning: expecting prototype for INIT_ZM_I2C_BYTE(). Prototype was for init_zm_i2c_byte() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1060: warning: Function parameter or member 'init' not described in 'init_zm_i2c'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1060: warning: expecting prototype for INIT_ZM_I2C(). Prototype was for init_zm_i2c() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1094: warning: Function parameter or member 'init' not described in 'init_tmds'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1094: warning: expecting prototype for INIT_TMDS(). Prototype was for init_tmds() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1120: warning: Function parameter or member 'init' not described in 'init_zm_tmds_group'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1120: warning: expecting prototype for INIT_ZM_TMDS_GROUP(). Prototype was for init_zm_tmds_group() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1147: warning: Function parameter or member 'init' not described in 'init_cr_idx_adr_latch'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1147: warning: expecting prototype for INIT_CR_INDEX_ADDRESS_LATCHED(). Prototype was for init_cr_idx_adr_latch() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1177: warning: Function parameter or member 'init' not described in 'init_cr'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1177: warning: expecting prototype for INIT_CR(). Prototype was for init_cr() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1197: warning: Function parameter or member 'init' not described in 'init_zm_cr'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1197: warning: expecting prototype for INIT_ZM_CR(). Prototype was for init_zm_cr() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1214: warning: Function parameter or member 'init' not described in 'init_zm_cr_group'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1214: warning: expecting prototype for INIT_ZM_CR_GROUP(). Prototype was for init_zm_cr_group() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1238: warning: Function parameter or member 'init' not described in 'init_condition_time'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1238: warning: expecting prototype for INIT_CONDITION_TIME(). Prototype was for init_condition_time() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1265: warning: Function parameter or member 'init' not described in 'init_ltime'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1265: warning: expecting prototype for INIT_LTIME(). Prototype was for init_ltime() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1282: warning: Function parameter or member 'init' not described in 'init_zm_reg_sequence'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1282: warning: expecting prototype for INIT_ZM_REG_SEQUENCE(). Prototype was for init_zm_reg_sequence() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1307: warning: Function parameter or member 'init' not described in 'init_pll_indirect'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1307: warning: expecting prototype for INIT_PLL_INDIRECT(). Prototype was for init_pll_indirect() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1326: warning: Function parameter or member 'init' not described in 'init_zm_reg_indirect'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1326: warning: expecting prototype for INIT_ZM_REG_INDIRECT(). Prototype was for init_zm_reg_indirect() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1345: warning: Function parameter or member 'init' not described in 'init_sub_direct'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1345: warning: expecting prototype for INIT_SUB_DIRECT(). Prototype was for init_sub_direct() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1371: warning: Function parameter or member 'init' not described in 'init_jump'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1371: warning: expecting prototype for INIT_JUMP(). Prototype was for init_jump() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1389: warning: Function parameter or member 'init' not described in 'init_i2c_if'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1389: warning: expecting prototype for INIT_I2C_IF(). Prototype was for init_i2c_if() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1416: warning: Function parameter or member 'init' not described in 'init_copy_nv_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1416: warning: expecting prototype for INIT_COPY_NV_REG(). Prototype was for init_copy_nv_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1442: warning: Function parameter or member 'init' not described in 'init_zm_index_io'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1442: warning: expecting prototype for INIT_ZM_INDEX_IO(). Prototype was for init_zm_index_io() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1460: warning: Function parameter or member 'init' not described in 'init_compute_mem'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1460: warning: expecting prototype for INIT_COMPUTE_MEM(). Prototype was for init_compute_mem() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1478: warning: Function parameter or member 'init' not described in 'init_reset'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1478: warning: expecting prototype for INIT_RESET(). Prototype was for init_reset() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1505: warning: Function parameter or member 'init' not described in 'init_configure_mem_clk'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1505: warning: expecting prototype for INIT_CONFIGURE_MEM(). Prototype was for init_configure_mem_clk() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1564: warning: Function parameter or member 'init' not described in 'init_configure_clk'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1564: warning: expecting prototype for INIT_CONFIGURE_CLK(). Prototype was for init_configure_clk() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1598: warning: Function parameter or member 'init' not described in 'init_configure_preinit'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1598: warning: expecting prototype for INIT_CONFIGURE_PREINIT(). Prototype was for init_configure_preinit() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1624: warning: Function parameter or member 'init' not described in 'init_io'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1624: warning: expecting prototype for INIT_IO(). Prototype was for init_io() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1664: warning: Function parameter or member 'init' not described in 'init_sub'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1664: warning: expecting prototype for INIT_SUB(). Prototype was for init_sub() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1691: warning: Function parameter or member 'init' not described in 'init_ram_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1691: warning: expecting prototype for INIT_RAM_CONDITION(). Prototype was for init_ram_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1710: warning: Function parameter or member 'init' not described in 'init_nv_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1710: warning: expecting prototype for INIT_NV_REG(). Prototype was for init_nv_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1728: warning: Function parameter or member 'init' not described in 'init_macro'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1728: warning: expecting prototype for INIT_MACRO(). Prototype was for init_macro() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1752: warning: Function parameter or member 'init' not described in 'init_resume'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1752: warning: expecting prototype for INIT_RESUME(). Prototype was for init_resume() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1764: warning: Function parameter or member 'init' not described in 'init_strap_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1764: warning: expecting prototype for INIT_STRAP_CONDITION(). Prototype was for init_strap_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1782: warning: Function parameter or member 'init' not described in 'init_time'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1782: warning: expecting prototype for INIT_TIME(). Prototype was for init_time() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1803: warning: Function parameter or member 'init' not described in 'init_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1803: warning: expecting prototype for INIT_CONDITION(). Prototype was for init_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1820: warning: Function parameter or member 'init' not described in 'init_io_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1820: warning: expecting prototype for INIT_IO_CONDITION(). Prototype was for init_io_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1837: warning: Function parameter or member 'init' not described in 'init_zm_reg16'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1837: warning: expecting prototype for INIT_ZM_REG16(). Prototype was for init_zm_reg16() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1854: warning: Function parameter or member 'init' not described in 'init_index_io'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1854: warning: expecting prototype for INIT_INDEX_IO(). Prototype was for init_index_io() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1876: warning: Function parameter or member 'init' not described in 'init_pll'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1876: warning: expecting prototype for INIT_PLL(). Prototype was for init_pll() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1893: warning: Function parameter or member 'init' not described in 'init_zm_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1893: warning: expecting prototype for INIT_ZM_REG(). Prototype was for init_zm_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1913: warning: Function parameter or member 'init' not described in 'init_ram_restrict_pll'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1913: warning: expecting prototype for INIT_RAM_RESTRICT_PLL(). Prototype was for init_ram_restrict_pll() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1943: warning: Function parameter or member 'init' not described in 'init_reset_begun'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1943: warning: expecting prototype for INIT_RESET_BEGUN(). Prototype was for init_reset_begun() instead
>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1954: warning: Function parameter or member 'init' not described in 'init_reset_end'
>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1954: warning: expecting prototype for INIT_RESET_END(). Prototype was for init_reset_end() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1965: warning: Function parameter or member 'init' not described in 'init_gpio'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1965: warning: expecting prototype for INIT_GPIO(). Prototype was for init_gpio() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1981: warning: Function parameter or member 'init' not described in 'init_ram_restrict_zm_reg_group'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1981: warning: expecting prototype for INIT_RAM_RESTRICT_ZM_GROUP(). Prototype was for init_ram_restrict_zm_reg_group() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2019: warning: Function parameter or member 'init' not described in 'init_copy_zm_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2019: warning: expecting prototype for INIT_COPY_ZM_REG(). Prototype was for init_copy_zm_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2036: warning: Function parameter or member 'init' not described in 'init_zm_reg_group'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2036: warning: expecting prototype for INIT_ZM_REG_GROUP(). Prototype was for init_zm_reg_group() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2058: warning: Function parameter or member 'init' not described in 'init_xlat'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2058: warning: expecting prototype for INIT_XLAT(). Prototype was for init_xlat() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2086: warning: Function parameter or member 'init' not described in 'init_zm_mask_add'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2086: warning: expecting prototype for INIT_ZM_MASK_ADD(). Prototype was for init_zm_mask_add() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2107: warning: Function parameter or member 'init' not described in 'init_auxch'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2107: warning: expecting prototype for INIT_AUXCH(). Prototype was for init_auxch() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2131: warning: Function parameter or member 'init' not described in 'init_zm_auxch'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2131: warning: expecting prototype for INIT_AUXCH(). Prototype was for init_zm_auxch() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2153: warning: Function parameter or member 'init' not described in 'init_i2c_long_if'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2153: warning: expecting prototype for INIT_I2C_LONG_IF(). Prototype was for init_i2c_long_if() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2192: warning: Function parameter or member 'init' not described in 'init_gpio_ne'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2192: warning: expecting prototype for INIT_GPIO_NE(). Prototype was for init_gpio_ne() instead


vim +1954 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c

  1947	
  1948	/**
  1949	 * INIT_RESET_END - opcode 0x8d
  1950	 *
  1951	 */
  1952	static void
  1953	init_reset_end(struct nvbios_init *init)
> 1954	{
  1955		trace("RESET_END\n");
  1956		init->offset += 1;
  1957	}
  1958	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
