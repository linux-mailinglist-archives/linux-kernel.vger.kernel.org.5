Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04E80224B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjLCJhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:37:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D8FE6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701596278; x=1733132278;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ULroLh2kAtHR2g5SiKZUk2zuSv69LvOTwrSE4KZBfL4=;
  b=XJeRUhgJuLrakIxgDTvbhytDhGV8a1MBwdDGfqSYaGbUQEAosEwwEjsQ
   Awcc3ubuqnUUf1XAt9R8TCKCZphKxGzhlMQIQ5FAU/nsRIN9bGUqoE7+p
   SgudTVobLtzuDTHy4SB+0OC8WZEcJZyVwKN/8QZO/7yBUqDTTfkzgZXRB
   FWV5MfkIw4wYENkieuPlmG84dz2s7DjJO0cieP/w9p3wP7ge36rfDuYWE
   Y0RK0mNGbFSowSyZCHbWfA1xsK039TDqxBvHmAyKTjSONbFmdwXSjmjG/
   l4MQXAoq7jm/d6ZmW+GSGnhx8mFzP5NSMFZpKvArf6q7jyjtPe6ruUhNk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="6949789"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="6949789"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 01:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="799267083"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="799267083"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2023 01:37:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9ivA-0006V2-3A;
        Sun, 03 Dec 2023 09:37:52 +0000
Date:   Sun, 3 Dec 2023 17:37:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1750: warning:
 Function parameter or member 'init' not described in 'init_strap_condition'
Message-ID: <202312031704.mU64Hm58-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilia,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   968f35f4ab1c0966ceb39af3c89f2e24afedf878
commit: bacbad17fbc636125bf472240860a58a54ad62db drm/nouveau/bios: add opcodes 0x73 and 0x77
date:   8 years ago
config: x86_64-randconfig-r023-20230612 (https://download.01.org/0day-ci/archive/20231203/202312031704.mU64Hm58-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231203/202312031704.mU64Hm58-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312031704.mU64Hm58-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:424:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     424 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:575: warning: Function parameter or member 'init' not described in 'init_reserved'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:601: warning: Function parameter or member 'init' not described in 'init_done'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:601: warning: expecting prototype for INIT_DONE(). Prototype was for init_done() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:612: warning: Function parameter or member 'init' not described in 'init_io_restrict_prog'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:612: warning: expecting prototype for INIT_IO_RESTRICT_PROG(). Prototype was for init_io_restrict_prog() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:649: warning: Function parameter or member 'init' not described in 'init_repeat'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:649: warning: expecting prototype for INIT_REPEAT(). Prototype was for init_repeat() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:675: warning: Function parameter or member 'init' not described in 'init_io_restrict_pll'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:675: warning: expecting prototype for INIT_IO_RESTRICT_PLL(). Prototype was for init_io_restrict_pll() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:715: warning: Function parameter or member 'init' not described in 'init_end_repeat'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:715: warning: expecting prototype for INIT_END_REPEAT(). Prototype was for init_end_repeat() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:731: warning: Function parameter or member 'init' not described in 'init_copy'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:731: warning: expecting prototype for INIT_COPY(). Prototype was for init_copy() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:758: warning: Function parameter or member 'init' not described in 'init_not'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:758: warning: expecting prototype for INIT_NOT(). Prototype was for init_not() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:770: warning: Function parameter or member 'init' not described in 'init_io_flag_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:770: warning: expecting prototype for INIT_IO_FLAG_CONDITION(). Prototype was for init_io_flag_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:787: warning: Function parameter or member 'init' not described in 'init_dp_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:787: warning: expecting prototype for INIT_DP_CONDITION(). Prototype was for init_dp_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:835: warning: Function parameter or member 'init' not described in 'init_io_mask_or'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:835: warning: expecting prototype for INIT_IO_MASK_OR(). Prototype was for init_io_mask_or() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:854: warning: Function parameter or member 'init' not described in 'init_io_or'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:854: warning: expecting prototype for INIT_IO_OR(). Prototype was for init_io_or() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:873: warning: Function parameter or member 'init' not described in 'init_andn_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:873: warning: expecting prototype for INIT_ANDN_REG(). Prototype was for init_andn_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:890: warning: Function parameter or member 'init' not described in 'init_or_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:890: warning: expecting prototype for INIT_OR_REG(). Prototype was for init_or_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:907: warning: Function parameter or member 'init' not described in 'init_idx_addr_latched'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:907: warning: expecting prototype for INIT_INDEX_ADDRESS_LATCHED(). Prototype was for init_idx_addr_latched() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:937: warning: Function parameter or member 'init' not described in 'init_io_restrict_pll2'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:937: warning: expecting prototype for INIT_IO_RESTRICT_PLL2(). Prototype was for init_io_restrict_pll2() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:972: warning: Function parameter or member 'init' not described in 'init_pll2'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:972: warning: expecting prototype for INIT_PLL2(). Prototype was for init_pll2() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:989: warning: Function parameter or member 'init' not described in 'init_i2c_byte'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:989: warning: expecting prototype for INIT_I2C_BYTE(). Prototype was for init_i2c_byte() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1020: warning: Function parameter or member 'init' not described in 'init_zm_i2c_byte'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1020: warning: expecting prototype for INIT_ZM_I2C_BYTE(). Prototype was for init_zm_i2c_byte() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1046: warning: Function parameter or member 'init' not described in 'init_zm_i2c'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1046: warning: expecting prototype for INIT_ZM_I2C(). Prototype was for init_zm_i2c() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1080: warning: Function parameter or member 'init' not described in 'init_tmds'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1080: warning: expecting prototype for INIT_TMDS(). Prototype was for init_tmds() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1106: warning: Function parameter or member 'init' not described in 'init_zm_tmds_group'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1106: warning: expecting prototype for INIT_ZM_TMDS_GROUP(). Prototype was for init_zm_tmds_group() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1133: warning: Function parameter or member 'init' not described in 'init_cr_idx_adr_latch'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1133: warning: expecting prototype for INIT_CR_INDEX_ADDRESS_LATCHED(). Prototype was for init_cr_idx_adr_latch() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1163: warning: Function parameter or member 'init' not described in 'init_cr'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1163: warning: expecting prototype for INIT_CR(). Prototype was for init_cr() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1183: warning: Function parameter or member 'init' not described in 'init_zm_cr'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1183: warning: expecting prototype for INIT_ZM_CR(). Prototype was for init_zm_cr() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1200: warning: Function parameter or member 'init' not described in 'init_zm_cr_group'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1200: warning: expecting prototype for INIT_ZM_CR_GROUP(). Prototype was for init_zm_cr_group() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1224: warning: Function parameter or member 'init' not described in 'init_condition_time'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1224: warning: expecting prototype for INIT_CONDITION_TIME(). Prototype was for init_condition_time() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1251: warning: Function parameter or member 'init' not described in 'init_ltime'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1251: warning: expecting prototype for INIT_LTIME(). Prototype was for init_ltime() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1268: warning: Function parameter or member 'init' not described in 'init_zm_reg_sequence'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1268: warning: expecting prototype for INIT_ZM_REG_SEQUENCE(). Prototype was for init_zm_reg_sequence() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1293: warning: Function parameter or member 'init' not described in 'init_pll_indirect'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1293: warning: expecting prototype for INIT_PLL_INDIRECT(). Prototype was for init_pll_indirect() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1312: warning: Function parameter or member 'init' not described in 'init_zm_reg_indirect'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1312: warning: expecting prototype for INIT_ZM_REG_INDIRECT(). Prototype was for init_zm_reg_indirect() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1331: warning: Function parameter or member 'init' not described in 'init_sub_direct'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1331: warning: expecting prototype for INIT_SUB_DIRECT(). Prototype was for init_sub_direct() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1357: warning: Function parameter or member 'init' not described in 'init_jump'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1357: warning: expecting prototype for INIT_JUMP(). Prototype was for init_jump() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1375: warning: Function parameter or member 'init' not described in 'init_i2c_if'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1375: warning: expecting prototype for INIT_I2C_IF(). Prototype was for init_i2c_if() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1402: warning: Function parameter or member 'init' not described in 'init_copy_nv_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1402: warning: expecting prototype for INIT_COPY_NV_REG(). Prototype was for init_copy_nv_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1428: warning: Function parameter or member 'init' not described in 'init_zm_index_io'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1428: warning: expecting prototype for INIT_ZM_INDEX_IO(). Prototype was for init_zm_index_io() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1446: warning: Function parameter or member 'init' not described in 'init_compute_mem'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1446: warning: expecting prototype for INIT_COMPUTE_MEM(). Prototype was for init_compute_mem() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1464: warning: Function parameter or member 'init' not described in 'init_reset'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1464: warning: expecting prototype for INIT_RESET(). Prototype was for init_reset() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1491: warning: Function parameter or member 'init' not described in 'init_configure_mem_clk'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1491: warning: expecting prototype for INIT_CONFIGURE_MEM(). Prototype was for init_configure_mem_clk() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1550: warning: Function parameter or member 'init' not described in 'init_configure_clk'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1550: warning: expecting prototype for INIT_CONFIGURE_CLK(). Prototype was for init_configure_clk() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1584: warning: Function parameter or member 'init' not described in 'init_configure_preinit'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1584: warning: expecting prototype for INIT_CONFIGURE_PREINIT(). Prototype was for init_configure_preinit() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1610: warning: Function parameter or member 'init' not described in 'init_io'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1610: warning: expecting prototype for INIT_IO(). Prototype was for init_io() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1650: warning: Function parameter or member 'init' not described in 'init_sub'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1650: warning: expecting prototype for INIT_SUB(). Prototype was for init_sub() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1677: warning: Function parameter or member 'init' not described in 'init_ram_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1677: warning: expecting prototype for INIT_RAM_CONDITION(). Prototype was for init_ram_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1696: warning: Function parameter or member 'init' not described in 'init_nv_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1696: warning: expecting prototype for INIT_NV_REG(). Prototype was for init_nv_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1714: warning: Function parameter or member 'init' not described in 'init_macro'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1714: warning: expecting prototype for INIT_MACRO(). Prototype was for init_macro() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1738: warning: Function parameter or member 'init' not described in 'init_resume'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1738: warning: expecting prototype for INIT_RESUME(). Prototype was for init_resume() instead
>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1750: warning: Function parameter or member 'init' not described in 'init_strap_condition'
>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1750: warning: expecting prototype for INIT_STRAP_CONDITION(). Prototype was for init_strap_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1768: warning: Function parameter or member 'init' not described in 'init_time'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1768: warning: expecting prototype for INIT_TIME(). Prototype was for init_time() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1789: warning: Function parameter or member 'init' not described in 'init_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1789: warning: expecting prototype for INIT_CONDITION(). Prototype was for init_condition() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1806: warning: Function parameter or member 'init' not described in 'init_io_condition'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1806: warning: expecting prototype for INIT_IO_CONDITION(). Prototype was for init_io_condition() instead
>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1823: warning: Function parameter or member 'init' not described in 'init_zm_reg16'
>> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1823: warning: expecting prototype for INIT_ZM_REG16(). Prototype was for init_zm_reg16() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1840: warning: Function parameter or member 'init' not described in 'init_index_io'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1840: warning: expecting prototype for INIT_INDEX_IO(). Prototype was for init_index_io() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1862: warning: Function parameter or member 'init' not described in 'init_pll'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1862: warning: expecting prototype for INIT_PLL(). Prototype was for init_pll() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1879: warning: Function parameter or member 'init' not described in 'init_zm_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1879: warning: expecting prototype for INIT_ZM_REG(). Prototype was for init_zm_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1899: warning: Function parameter or member 'init' not described in 'init_ram_restrict_pll'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1899: warning: expecting prototype for INIT_RAM_RESTRICT_PLL(). Prototype was for init_ram_restrict_pll() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1929: warning: Function parameter or member 'init' not described in 'init_gpio'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1929: warning: expecting prototype for INIT_GPIO(). Prototype was for init_gpio() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1945: warning: Function parameter or member 'init' not described in 'init_ram_restrict_zm_reg_group'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1945: warning: expecting prototype for INIT_RAM_RESTRICT_ZM_GROUP(). Prototype was for init_ram_restrict_zm_reg_group() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1983: warning: Function parameter or member 'init' not described in 'init_copy_zm_reg'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:1983: warning: expecting prototype for INIT_COPY_ZM_REG(). Prototype was for init_copy_zm_reg() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2000: warning: Function parameter or member 'init' not described in 'init_zm_reg_group'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2000: warning: expecting prototype for INIT_ZM_REG_GROUP(). Prototype was for init_zm_reg_group() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2022: warning: Function parameter or member 'init' not described in 'init_xlat'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2022: warning: expecting prototype for INIT_XLAT(). Prototype was for init_xlat() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2050: warning: Function parameter or member 'init' not described in 'init_zm_mask_add'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2050: warning: expecting prototype for INIT_ZM_MASK_ADD(). Prototype was for init_zm_mask_add() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2071: warning: Function parameter or member 'init' not described in 'init_auxch'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2071: warning: expecting prototype for INIT_AUXCH(). Prototype was for init_auxch() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2095: warning: Function parameter or member 'init' not described in 'init_zm_auxch'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2095: warning: expecting prototype for INIT_AUXCH(). Prototype was for init_zm_auxch() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2117: warning: Function parameter or member 'init' not described in 'init_i2c_long_if'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2117: warning: expecting prototype for INIT_I2C_LONG_IF(). Prototype was for init_i2c_long_if() instead
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2156: warning: Function parameter or member 'init' not described in 'init_gpio_ne'
   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c:2156: warning: expecting prototype for INIT_GPIO_NE(). Prototype was for init_gpio_ne() instead


vim +1750 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c

  1743	
  1744	/**
  1745	 * INIT_STRAP_CONDITION - opcode 0x73
  1746	 *
  1747	 */
  1748	static void
  1749	init_strap_condition(struct nvbios_init *init)
> 1750	{
  1751		struct nvkm_bios *bios = init->bios;
  1752		u32 mask = nv_ro32(bios, init->offset + 1);
  1753		u32 value = nv_ro32(bios, init->offset + 5);
  1754	
  1755		trace("STRAP_CONDITION\t(R[0x101000] & 0x%08x) == 0x%08x\n", mask, value);
  1756		init->offset += 9;
  1757	
  1758		if ((init_rd32(init, 0x101000) & mask) != value)
  1759			init_exec_set(init, false);
  1760	}
  1761	
  1762	/**
  1763	 * INIT_TIME - opcode 0x74
  1764	 *
  1765	 */
  1766	static void
  1767	init_time(struct nvbios_init *init)
  1768	{
  1769		struct nvkm_bios *bios = init->bios;
  1770		u16 usec = nv_ro16(bios, init->offset + 1);
  1771	
  1772		trace("TIME\t0x%04x\n", usec);
  1773		init->offset += 3;
  1774	
  1775		if (init_exec(init)) {
  1776			if (usec < 1000)
  1777				udelay(usec);
  1778			else
  1779				mdelay((usec + 900) / 1000);
  1780		}
  1781	}
  1782	
  1783	/**
  1784	 * INIT_CONDITION - opcode 0x75
  1785	 *
  1786	 */
  1787	static void
  1788	init_condition(struct nvbios_init *init)
  1789	{
  1790		struct nvkm_bios *bios = init->bios;
  1791		u8 cond = nv_ro08(bios, init->offset + 1);
  1792	
  1793		trace("CONDITION\t0x%02x\n", cond);
  1794		init->offset += 2;
  1795	
  1796		if (!init_condition_met(init, cond))
  1797			init_exec_set(init, false);
  1798	}
  1799	
  1800	/**
  1801	 * INIT_IO_CONDITION - opcode 0x76
  1802	 *
  1803	 */
  1804	static void
  1805	init_io_condition(struct nvbios_init *init)
  1806	{
  1807		struct nvkm_bios *bios = init->bios;
  1808		u8 cond = nv_ro08(bios, init->offset + 1);
  1809	
  1810		trace("IO_CONDITION\t0x%02x\n", cond);
  1811		init->offset += 2;
  1812	
  1813		if (!init_io_condition_met(init, cond))
  1814			init_exec_set(init, false);
  1815	}
  1816	
  1817	/**
  1818	 * INIT_ZM_REG16 - opcode 0x77
  1819	 *
  1820	 */
  1821	static void
  1822	init_zm_reg16(struct nvbios_init *init)
> 1823	{
  1824		struct nvkm_bios *bios = init->bios;
  1825		u32 addr = nv_ro32(bios, init->offset + 1);
  1826		u16 data = nv_ro16(bios, init->offset + 5);
  1827	
  1828		trace("ZM_REG\tR[0x%06x] = 0x%04x\n", addr, data);
  1829		init->offset += 7;
  1830	
  1831		init_wr32(init, addr, data);
  1832	}
  1833	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
