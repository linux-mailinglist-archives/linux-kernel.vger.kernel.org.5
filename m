Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747E37E12B5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 10:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjKEJBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 04:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjKEJBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 04:01:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A88A6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 01:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699174908; x=1730710908;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bWD2ogEt6FZdT+MXKYtz57KplUYtedko+Wid2xsKznk=;
  b=S20zwiyiikLMLvhSeDJAD6RIaNRqmG5x/OdvFR6SNFblo3Dq7HQVNdUx
   2iGuKR1qxWW7icjcg3fJpk7o5hy/8yzpjheP/JxkCMDlFwBRFfMGRudpP
   RSS1to1a4F2WQHxoDyQzE4JsfUwdB4CYe/gAHEtfpTzxU1AuaWTwHuZev
   f9rpd4zwVVCHllZYgYCVsCiG1th/n9/vkcvMO+6JQfD9PX0cy6ffY62tg
   7a+0kvyngK+oMondK/wnx6OS5Fpm0e4eJRhLlMtlG/B8d9Fcz23aMyC0X
   /Xp6iNp65ckmn3HYZcW9JBFziiXFBHZYoytmdodbgOcpTmlrSv//GyG4w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="392001316"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="392001316"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 01:01:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="755575703"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="755575703"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2023 01:01:45 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzZ0o-0005EO-2t;
        Sun, 05 Nov 2023 09:01:42 +0000
Date:   Sun, 5 Nov 2023 17:01:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:957:12: warning: stack frame
 size (2064) exceeds limit (2048) in 'vcn_v4_0_5_start'
Message-ID: <202311051650.4hyYNRSK-lkp@intel.com>
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

Hi Saleemkhan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: 547aad32edac17a3ec4989d8aad2426d0cbeb590 drm/amdgpu: add VCN4 ip block support
date:   9 weeks ago
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20231105/202311051650.4hyYNRSK-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051650.4hyYNRSK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051650.4hyYNRSK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:957:12: warning: stack frame size (2064) exceeds limit (2048) in 'vcn_v4_0_5_start' [-Wframe-larger-than]
     957 | static int vcn_v4_0_5_start(struct amdgpu_device *adev)
         |            ^
   1 warning generated.


vim +/vcn_v4_0_5_start +957 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c

   948	
   949	
   950	/**
   951	 * vcn_v4_0_5_start - VCN start
   952	 *
   953	 * @adev: amdgpu_device pointer
   954	 *
   955	 * Start VCN block
   956	 */
 > 957	static int vcn_v4_0_5_start(struct amdgpu_device *adev)
   958	{
   959		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
   960		struct amdgpu_ring *ring;
   961		uint32_t tmp;
   962		int i, j, k, r;
   963	
   964		if (adev->pm.dpm_enabled)
   965			amdgpu_dpm_enable_uvd(adev, true);
   966	
   967		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
   968			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
   969	
   970			if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
   971				r = vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
   972				continue;
   973			}
   974	
   975			/* disable VCN power gating */
   976			vcn_v4_0_5_disable_static_power_gating(adev, i);
   977	
   978			/* set VCN status busy */
   979			tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
   980			WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
   981	
   982			/*SW clock gating */
   983			vcn_v4_0_5_disable_clock_gating(adev, i);
   984	
   985			/* enable VCPU clock */
   986			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
   987					UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
   988	
   989			/* disable master interrupt */
   990			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
   991					~UVD_MASTINT_EN__VCPU_EN_MASK);
   992	
   993			/* enable LMI MC and UMC channels */
   994			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
   995					~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
   996	
   997			tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
   998			tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
   999			tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
  1000			WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
  1001	
  1002			/* setup regUVD_LMI_CTRL */
  1003			tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
  1004			WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
  1005					UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
  1006					UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
  1007					UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
  1008					UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
  1009	
  1010			/* setup regUVD_MPC_CNTL */
  1011			tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
  1012			tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
  1013			tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
  1014			WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
  1015	
  1016			/* setup UVD_MPC_SET_MUXA0 */
  1017			WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
  1018					((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
  1019					 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
  1020					 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
  1021					 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
  1022	
  1023			/* setup UVD_MPC_SET_MUXB0 */
  1024			WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
  1025					((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
  1026					 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
  1027					 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
  1028					 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
  1029	
  1030			/* setup UVD_MPC_SET_MUX */
  1031			WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
  1032					((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
  1033					 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
  1034					 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
  1035	
  1036			vcn_v4_0_5_mc_resume(adev, i);
  1037	
  1038			/* VCN global tiling registers */
  1039			WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
  1040					adev->gfx.config.gb_addr_config);
  1041	
  1042			/* unblock VCPU register access */
  1043			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
  1044					~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
  1045	
  1046			/* release VCPU reset to boot */
  1047			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
  1048					~UVD_VCPU_CNTL__BLK_RST_MASK);
  1049	
  1050			for (j = 0; j < 10; ++j) {
  1051				uint32_t status;
  1052	
  1053				for (k = 0; k < 100; ++k) {
  1054					status = RREG32_SOC15(VCN, i, regUVD_STATUS);
  1055					if (status & 2)
  1056						break;
  1057					mdelay(10);
  1058					if (amdgpu_emu_mode == 1)
  1059						msleep(1);
  1060				}
  1061	
  1062				if (amdgpu_emu_mode == 1) {
  1063					r = -1;
  1064					if (status & 2) {
  1065						r = 0;
  1066						break;
  1067					}
  1068				} else {
  1069					r = 0;
  1070					if (status & 2)
  1071						break;
  1072	
  1073					dev_err(adev->dev,
  1074						"VCN[%d] is not responding, trying to reset VCPU!!!\n", i);
  1075					WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
  1076								UVD_VCPU_CNTL__BLK_RST_MASK,
  1077								~UVD_VCPU_CNTL__BLK_RST_MASK);
  1078					mdelay(10);
  1079					WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
  1080							~UVD_VCPU_CNTL__BLK_RST_MASK);
  1081	
  1082					mdelay(10);
  1083					r = -1;
  1084				}
  1085			}
  1086	
  1087			if (r) {
  1088				dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
  1089				return r;
  1090			}
  1091	
  1092			/* enable master interrupt */
  1093			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
  1094					UVD_MASTINT_EN__VCPU_EN_MASK,
  1095					~UVD_MASTINT_EN__VCPU_EN_MASK);
  1096	
  1097			/* clear the busy bit of VCN_STATUS */
  1098			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
  1099					~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
  1100	
  1101			ring = &adev->vcn.inst[i].ring_enc[0];
  1102			WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
  1103					ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
  1104					VCN_RB1_DB_CTRL__EN_MASK);
  1105	
  1106			WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
  1107			WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
  1108			WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
  1109	
  1110			tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
  1111			tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
  1112			WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
  1113			fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
  1114			WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
  1115			WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
  1116	
  1117			tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
  1118			WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
  1119			ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
  1120	
  1121			tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
  1122			tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
  1123			WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
  1124			fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
  1125		}
  1126	
  1127		return 0;
  1128	}
  1129	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
