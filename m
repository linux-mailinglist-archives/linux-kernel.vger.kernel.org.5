Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B457E1343
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 13:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjKEMDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 07:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEMDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 07:03:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384BB3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 04:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699185828; x=1730721828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RV1j1rXGgMyuyxg7i2YHTijqBRlp/+r7n4zRnOQTczI=;
  b=awyK/Ct1cyL/zYcfPisxRy0ayrYxablurUycuqXj0jByegteDMQxb4hx
   VuHuG3ug39wxY09J8nuHB+scKWe7vdD9E+rNUTn0JZEk4Gu3Fz57t07BC
   FCYg3GBNqKsyU/zwhCI38jtknSn3tjN4pfMMeQ3CxROzfRAJJLk4yr5Go
   xK0MWpUSd26zkGl8LXUCgiVj5nZSSRyhzgYfDmmKy4n4FWR1bUUw0SKaq
   jeo9yI/vm68UHAIWCZpTpXAQAZnSGyFCjNOvubVEzFEk4GaRMnAZSjVhd
   M6ggtXM+IUUGkw59BAct22Mmuz9K5mQrpi8FKY1lyG73n+iwSxNbZUtIO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="2120101"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="2120101"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 04:03:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="852718798"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="852718798"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Nov 2023 04:03:44 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzbqw-0005Oi-0e;
        Sun, 05 Nov 2023 12:03:42 +0000
Date:   Sun, 5 Nov 2023 20:02:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rhys Kidd <rhyskidd@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1943: warning:
 Function parameter or member 'init' not described in 'init_reset_begun'
Message-ID: <202311051924.UHNs7Tol-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: 66cbcc72ae34711854ae7af8056bfb7169f874fd drm/nouveau/bios/init: handle INIT_RESET_BEGUN devinit opcode
date:   4 years, 2 months ago
config: i386-randconfig-004-20231101 (https://download.01.org/0day-ci/archive/20231105/202311051924.UHNs7Tol-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051924.UHNs7Tol-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051924.UHNs7Tol-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:741: warning: Function parameter or member 'init' not described in 'init_copy'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:741: warning: expecting prototype for INIT_COPY(). Prototype was for init_copy() instead
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
>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1943: warning: Function parameter or member 'init' not described in 'init_reset_begun'
>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1943: warning: expecting prototype for INIT_RESET_BEGUN(). Prototype was for init_reset_begun() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1954: warning: Function parameter or member 'init' not described in 'init_gpio'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1954: warning: expecting prototype for INIT_GPIO(). Prototype was for init_gpio() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1970: warning: Function parameter or member 'init' not described in 'init_ram_restrict_zm_reg_group'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1970: warning: expecting prototype for INIT_RAM_RESTRICT_ZM_GROUP(). Prototype was for init_ram_restrict_zm_reg_group() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2008: warning: Function parameter or member 'init' not described in 'init_copy_zm_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2008: warning: expecting prototype for INIT_COPY_ZM_REG(). Prototype was for init_copy_zm_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2025: warning: Function parameter or member 'init' not described in 'init_zm_reg_group'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2025: warning: expecting prototype for INIT_ZM_REG_GROUP(). Prototype was for init_zm_reg_group() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2047: warning: Function parameter or member 'init' not described in 'init_xlat'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2047: warning: expecting prototype for INIT_XLAT(). Prototype was for init_xlat() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2075: warning: Function parameter or member 'init' not described in 'init_zm_mask_add'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2075: warning: expecting prototype for INIT_ZM_MASK_ADD(). Prototype was for init_zm_mask_add() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2096: warning: Function parameter or member 'init' not described in 'init_auxch'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2096: warning: expecting prototype for INIT_AUXCH(). Prototype was for init_auxch() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2120: warning: Function parameter or member 'init' not described in 'init_zm_auxch'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2120: warning: expecting prototype for INIT_AUXCH(). Prototype was for init_zm_auxch() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2142: warning: Function parameter or member 'init' not described in 'init_i2c_long_if'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2142: warning: expecting prototype for INIT_I2C_LONG_IF(). Prototype was for init_i2c_long_if() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2181: warning: Function parameter or member 'init' not described in 'init_gpio_ne'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2181: warning: expecting prototype for INIT_GPIO_NE(). Prototype was for init_gpio_ne() instead


vim +1943 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c

  1830	
  1831	/**
  1832	 * INIT_ZM_REG16 - opcode 0x77
  1833	 *
  1834	 */
  1835	static void
  1836	init_zm_reg16(struct nvbios_init *init)
> 1837	{
  1838		struct nvkm_bios *bios = init->subdev->device->bios;
  1839		u32 addr = nvbios_rd32(bios, init->offset + 1);
  1840		u16 data = nvbios_rd16(bios, init->offset + 5);
  1841	
  1842		trace("ZM_REG\tR[0x%06x] = 0x%04x\n", addr, data);
  1843		init->offset += 7;
  1844	
  1845		init_wr32(init, addr, data);
  1846	}
  1847	
  1848	/**
  1849	 * INIT_INDEX_IO - opcode 0x78
  1850	 *
  1851	 */
  1852	static void
  1853	init_index_io(struct nvbios_init *init)
> 1854	{
  1855		struct nvkm_bios *bios = init->subdev->device->bios;
  1856		u16 port = nvbios_rd16(bios, init->offset + 1);
  1857		u8 index = nvbios_rd16(bios, init->offset + 3);
  1858		u8  mask = nvbios_rd08(bios, init->offset + 4);
  1859		u8  data = nvbios_rd08(bios, init->offset + 5);
  1860		u8 value;
  1861	
  1862		trace("INDEX_IO\tI[0x%04x][0x%02x] &= 0x%02x |= 0x%02x\n",
  1863		      port, index, mask, data);
  1864		init->offset += 6;
  1865	
  1866		value = init_rdvgai(init, port, index) & mask;
  1867		init_wrvgai(init, port, index, data | value);
  1868	}
  1869	
  1870	/**
  1871	 * INIT_PLL - opcode 0x79
  1872	 *
  1873	 */
  1874	static void
  1875	init_pll(struct nvbios_init *init)
  1876	{
  1877		struct nvkm_bios *bios = init->subdev->device->bios;
  1878		u32  reg = nvbios_rd32(bios, init->offset + 1);
  1879		u32 freq = nvbios_rd16(bios, init->offset + 5) * 10;
  1880	
  1881		trace("PLL\tR[0x%06x] =PLL= %dkHz\n", reg, freq);
  1882		init->offset += 7;
  1883	
  1884		init_prog_pll(init, reg, freq);
  1885	}
  1886	
  1887	/**
  1888	 * INIT_ZM_REG - opcode 0x7a
  1889	 *
  1890	 */
  1891	static void
  1892	init_zm_reg(struct nvbios_init *init)
  1893	{
  1894		struct nvkm_bios *bios = init->subdev->device->bios;
  1895		u32 addr = nvbios_rd32(bios, init->offset + 1);
  1896		u32 data = nvbios_rd32(bios, init->offset + 5);
  1897	
  1898		trace("ZM_REG\tR[0x%06x] = 0x%08x\n", addr, data);
  1899		init->offset += 9;
  1900	
  1901		if (addr == 0x000200)
  1902			data |= 0x00000001;
  1903	
  1904		init_wr32(init, addr, data);
  1905	}
  1906	
  1907	/**
  1908	 * INIT_RAM_RESTRICT_PLL - opcde 0x87
  1909	 *
  1910	 */
  1911	static void
  1912	init_ram_restrict_pll(struct nvbios_init *init)
  1913	{
  1914		struct nvkm_bios *bios = init->subdev->device->bios;
  1915		u8  type = nvbios_rd08(bios, init->offset + 1);
  1916		u8 count = init_ram_restrict_group_count(init);
  1917		u8 strap = init_ram_restrict(init);
  1918		u8 cconf;
  1919	
  1920		trace("RAM_RESTRICT_PLL\t0x%02x\n", type);
  1921		init->offset += 2;
  1922	
  1923		for (cconf = 0; cconf < count; cconf++) {
  1924			u32 freq = nvbios_rd32(bios, init->offset);
  1925	
  1926			if (cconf == strap) {
  1927				trace("%dkHz *\n", freq);
  1928				init_prog_pll(init, type, freq);
  1929			} else {
  1930				trace("%dkHz\n", freq);
  1931			}
  1932	
  1933			init->offset += 4;
  1934		}
  1935	}
  1936	
  1937	/**
  1938	 * INIT_RESET_BEGUN - opcode 0x8c
  1939	 *
  1940	 */
  1941	static void
  1942	init_reset_begun(struct nvbios_init *init)
> 1943	{
  1944		trace("RESET_BEGUN\n");
  1945		init->offset += 1;
  1946	}
  1947	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
