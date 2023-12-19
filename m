Return-Path: <linux-kernel+bounces-5689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87552818E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6A22852A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207182DF84;
	Tue, 19 Dec 2023 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvcwlnrF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526A225CE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703006840; x=1734542840;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cHRDLGJRVxshCmDokN9nM8+2sQFJHbUYsmkwmTUIYKA=;
  b=YvcwlnrFqSeV4eHZvjhol7dPCg/dx+6DmwulmOYGJ/TEpHKwSSSeepdZ
   4/P4vPksrpVBK8S6qoua/tBqFLQ0eXp4DHbz5FbEUL0QkFcPVnrOYK/XS
   uTVkkPk7NCsOMIbiRtX3wiRV5r9jeD6c1wiHZS0Ldzd+9i5CLhs9w25DD
   Bbvlh/78oemHuRgn3GAW2uIIUitHCD7jdE8Lrk/NpzgQHtCkUE+x0u+aj
   sa5wLXNR+OvDjx1H9wEwBzvZIORa6zW7GF1AKFEkxHqAuTksdEUOnt5kt
   lnGznqybDuwplE0e1TdMo42t3TEaRhDEkqDGYZNPb3kmfIEvA4cqmugmD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2925868"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2925868"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:27:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="17679091"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 19 Dec 2023 09:27:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFds9-0005kJ-2x;
	Tue, 19 Dec 2023 17:27:13 +0000
Date: Wed, 20 Dec 2023 01:26:52 +0800
From: kernel test robot <lkp@intel.com>
To: Rhys Kidd <rhyskidd@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1943: warning:
 Function parameter or member 'init' not described in 'init_reset_begun'
Message-ID: <202312200105.eNSu8nu1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rhys,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
commit: 66cbcc72ae34711854ae7af8056bfb7169f874fd drm/nouveau/bios/init: handle INIT_RESET_BEGUN devinit opcode
date:   4 years, 4 months ago
config: i386-randconfig-004-20231101 (https://download.01.org/0day-ci/archive/20231220/202312200105.eNSu8nu1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312200105.eNSu8nu1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312200105.eNSu8nu1-lkp@intel.com/

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

