Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF47E2E1A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjKFUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjKFUXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:23:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4433FD71
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699302183; x=1730838183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cHgE/nUX2vSvflUUfpPPn5BjUjh72rhn+OkK/XKDA8w=;
  b=K1rci3VtisZpRiR0/eRYMGeUaScR3vqlKo/TlqYul9Y/IZlpZLZ8kkbA
   9yDGxrQqIICVKjO8rc0nKsRtJIxaGiYwYQ9XtikCBvWgUHZi4btVXiZqs
   1J74w5n2HDCJNkF5dh+MzIW8qYKPXCo3BZYorOMblhMLTLGQ+QOW28V0y
   Kh6CtEJ3t6lxwcWfd8Gwr9anXLIE0aIBcgmHtMi48lmdJ8yRCcSnCfK+z
   W/+JQ9FwGb0H+IQSHLSwXBHvVNiF2FjdBRM4V+2j24b/cpZmmBw2+nxrR
   3223DvTac2HWnZvBJ2YdjFLAtGpJW4F0lpY67R+TGkOxxQpWC8oYHEa7z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475601359"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475601359"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 12:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="853125317"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="853125317"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Nov 2023 12:23:00 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r067g-0006i0-0g;
        Mon, 06 Nov 2023 20:23:00 +0000
Date:   Tue, 7 Nov 2023 04:22:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: {standard input}:123: Error: found '(', expected: ')'
Message-ID: <202311070356.BvkVnvMw-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 21e3134b3ec09e722cbcda69788f206adc8db1f4 MIPS: barrier: Clean up rmb() & wmb() definitions
date:   4 years, 1 month ago
config: mips-randconfig-r011-20220330 (https://download.01.org/0day-ci/archive/20231107/202311070356.BvkVnvMw-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070356.BvkVnvMw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070356.BvkVnvMw-lkp@intel.com/

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
--
   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
   {standard input}:140: Error: found '(', expected: ')'
   {standard input}:140: Error: found '(', expected: ')'
   {standard input}:140: Error: non-constant expression in ".if" statement
   {standard input}:140: Error: junk at end of line, first unrecognized character is `('
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: In function 'amdgpu_device_fini':
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:2935:13: warning: variable 'r' set but not used [-Wunused-but-set-variable]
    2935 |         int r;
         |             ^
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:53,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:40:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:67:32: warning: 'dc_fixpt_zero' defined but not used [-Wunused-const-variable=]
      67 | static const struct fixed31_32 dc_fixpt_zero = { 0 };
         |                                ^~~~~~~~~~~~~
   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:683:5: warning: no previous prototype for 'amdgpu_ras_error_cure' [-Wmissing-prototypes]
     683 | int amdgpu_ras_error_cure(struct amdgpu_device *adev,
         |     ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../include/dm_pp_interface.h:26,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu.h:53,
                    from drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:67:32: warning: 'dc_fixpt_zero' defined but not used [-Wunused-const-variable=]
      67 | static const struct fixed31_32 dc_fixpt_zero = { 0 };
         |                                ^~~~~~~~~~~~~
   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
   {standard input}:1184: Error: found '(', expected: ')'
   {standard input}:1184: Error: found '(', expected: ')'
   {standard input}:1184: Error: non-constant expression in ".if" statement
   {standard input}:1184: Error: junk at end of line, first unrecognized character is `('
--
   arch/mips/kernel/mips-cm.c:157:13: warning: no previous prototype for '__mips_cm_l2sync_phys_base' [-Wmissing-prototypes]
     157 | phys_addr_t __mips_cm_l2sync_phys_base(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
--
   cc1: warning: drivers/gpu/drm/amd/include: No such file or directory [-Wmissing-include-dirs]
   drivers/gpu/drm/radeon/radeon_combios.c: In function 'radeon_combios_get_power_modes':
   drivers/gpu/drm/radeon/radeon_combios.c:2641:17: warning: variable 'blocks' set but not used [-Wunused-but-set-variable]
    2641 |         u8 rev, blocks, tmp;
         |                 ^~~~~~
   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
--
   cc1: warning: drivers/gpu/drm/amd/include: No such file or directory [-Wmissing-include-dirs]
   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
--
   cc1: warning: drivers/gpu/drm/amd/include: No such file or directory [-Wmissing-include-dirs]
   drivers/gpu/drm/radeon/r600.c: In function 'r600_pcie_gart_tlb_flush':
   drivers/gpu/drm/radeon/r600.c:1083:21: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
    1083 |                 u32 tmp;
         |                     ^~~
   drivers/gpu/drm/radeon/r600.c: At top level:
   drivers/gpu/drm/radeon/r600.c:1616:5: warning: no previous prototype for 'r600_gpu_check_soft_reset' [-Wmissing-prototypes]
    1616 | u32 r600_gpu_check_soft_reset(struct radeon_device *rdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/r600.c:3481:5: warning: no previous prototype for 'r600_ih_ring_alloc' [-Wmissing-prototypes]
    3481 | int r600_ih_ring_alloc(struct radeon_device *rdev)
         |     ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/r600.c:3517:6: warning: no previous prototype for 'r600_ih_ring_fini' [-Wmissing-prototypes]
    3517 | void r600_ih_ring_fini(struct radeon_device *rdev)
         |      ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/r600.c: In function 'r600_mmio_hdp_flush':
   drivers/gpu/drm/radeon/r600.c:4393:21: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
    4393 |                 u32 tmp;
         |                     ^~~
   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
--
   cc1: warning: drivers/gpu/drm/amd/include: No such file or directory [-Wmissing-include-dirs]
   drivers/gpu/drm/radeon/rv770.c:1138:6: warning: no previous prototype for 'rv770_set_clk_bypass_mode' [-Wmissing-prototypes]
    1138 | void rv770_set_clk_bypass_mode(struct radeon_device *rdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
--
   cc1: warning: drivers/gpu/drm/amd/include: No such file or directory [-Wmissing-include-dirs]
   drivers/gpu/drm/radeon/radeon_legacy_tv.c: In function 'radeon_legacy_tv_mode_set':
   drivers/gpu/drm/radeon/radeon_legacy_tv.c:540:31: warning: variable 'tv_pll_cntl1' set but not used [-Wunused-but-set-variable]
     540 |         uint32_t tv_pll_cntl, tv_pll_cntl1, tv_ftotal;
         |                               ^~~~~~~~~~~~
   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
--
   cc1: warning: drivers/gpu/drm/amd/include: No such file or directory [-Wmissing-include-dirs]
   drivers/gpu/drm/radeon/evergreen.c:1281:6: warning: no previous prototype for 'evergreen_fix_pci_max_read_req_size' [-Wmissing-prototypes]
    1281 | void evergreen_fix_pci_max_read_req_size(struct radeon_device *rdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:1914:5: warning: no previous prototype for 'evergreen_get_number_of_dram_channels' [-Wmissing-prototypes]
    1914 | u32 evergreen_get_number_of_dram_channels(struct radeon_device *rdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:2664:6: warning: no previous prototype for 'evergreen_mc_stop' [-Wmissing-prototypes]
    2664 | void evergreen_mc_stop(struct radeon_device *rdev, struct evergreen_mc_save *save)
         |      ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:2762:6: warning: no previous prototype for 'evergreen_mc_resume' [-Wmissing-prototypes]
    2762 | void evergreen_mc_resume(struct radeon_device *rdev, struct evergreen_mc_save *save)
         |      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:2850:6: warning: no previous prototype for 'evergreen_mc_program' [-Wmissing-prototypes]
    2850 | void evergreen_mc_program(struct radeon_device *rdev)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c: In function 'evergreen_gpu_init':
   drivers/gpu/drm/radeon/evergreen.c:3136:13: warning: variable 'mc_shared_chmap' set but not used [-Wunused-but-set-variable]
    3136 |         u32 mc_shared_chmap, mc_arb_ramcfg;
         |             ^~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c: At top level:
   drivers/gpu/drm/radeon/evergreen.c:3710:5: warning: no previous prototype for 'evergreen_mc_init' [-Wmissing-prototypes]
    3710 | int evergreen_mc_init(struct radeon_device *rdev)
         |     ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:3769:6: warning: no previous prototype for 'evergreen_print_gpu_status_regs' [-Wmissing-prototypes]
    3769 | void evergreen_print_gpu_status_regs(struct radeon_device *rdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:3797:6: warning: no previous prototype for 'evergreen_is_display_hung' [-Wmissing-prototypes]
    3797 | bool evergreen_is_display_hung(struct radeon_device *rdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:3826:5: warning: no previous prototype for 'evergreen_gpu_check_soft_reset' [-Wmissing-prototypes]
    3826 | u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:4009:6: warning: no previous prototype for 'evergreen_gpu_pci_config_reset' [-Wmissing-prototypes]
    4009 | void evergreen_gpu_pci_config_reset(struct radeon_device *rdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:4110:6: warning: no previous prototype for 'sumo_rlc_fini' [-Wmissing-prototypes]
    4110 | void sumo_rlc_fini(struct radeon_device *rdev)
         |      ^~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:4153:5: warning: no previous prototype for 'sumo_rlc_init' [-Wmissing-prototypes]
    4153 | int sumo_rlc_init(struct radeon_device *rdev)
         |     ^~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:4381:5: warning: no previous prototype for 'evergreen_rlc_resume' [-Wmissing-prototypes]
    4381 | int evergreen_rlc_resume(struct radeon_device *rdev)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/radeon/evergreen.c:4670:6: warning: no previous prototype for 'evergreen_irq_suspend' [-Wmissing-prototypes]
    4670 | void evergreen_irq_suspend(struct radeon_device *rdev)
         |      ^~~~~~~~~~~~~~~~~~~~~
   {standard input}: Assembler messages:
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: found '(', expected: ')'
>> {standard input}:123: Error: non-constant expression in ".if" statement
>> {standard input}:123: Error: junk at end of line, first unrecognized character is `('
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
