Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA4A7CBE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjJQI5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:57:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B7393;
        Tue, 17 Oct 2023 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697533058; x=1729069058;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z1Di3G/cS3fbqCUFXeZYqQTg646nq7TdtKkQmoFqEYk=;
  b=kv8c94N6wT+pfYHu+k6Gs6vReWif1Fdb/3B0504KYwfg7Oj2JqU2L10e
   JM3cWum3qAacF07wCdm5lomiPDwPKLzvdtFXVzsVxd3A54UGIDltStnHi
   4fkNG1fdKn5RgIHDCZ1OJcnkOVcqlR+onW3gTvrQA7Fyf6f6mkH/Aip5G
   DEXRyqz2Dz89fxhPNmUrwqe/UqF5mtbHbj40nZ2TgdN1PNIaB8SfYL9MR
   R4l0LqAnZHDX+QetAycRQ6vIqtLamYu07wCvaChNgrmP7IbO36laHRFMI
   M7WWowFHZYovGL1GDW0YHq7DjqYqF9Kj8wOuPP40t3HKzXFjizPhgdAvT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376104457"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="376104457"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:55:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785407466"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785407466"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.44.24])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:55:54 -0700
Date:   Tue, 17 Oct 2023 11:55:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Ma Jun <Jun.Ma2@amd.com>
cc:     amd-gfx@lists.freedesktop.org, lenb@kernel.org,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, majun@amd.com,
        Netdev <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Evan Quan <quanliangl@hotmail.com>
Subject: Re: [PATCH v12 8/9] drm/amd/pm: enable Wifi RFI mitigation feature
 support for SMU13.0.0
In-Reply-To: <20231017025358.1773598-9-Jun.Ma2@amd.com>
Message-ID: <4477dd8b-bb52-f65-1de6-13dd4186fd38@linux.intel.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com> <20231017025358.1773598-9-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023, Ma Jun wrote:

> From: Evan Quan <quanliangl@hotmail.com>
> 
> Fulfill the SMU13.0.0 support for Wifi RFI mitigation feature.
> 
> Signed-off-by: Evan Quan <quanliangl@hotmail.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> --
> v10->v11:
>   - downgrade the prompt level on message failure(Lijo)
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  3 +
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 +++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 60 +++++++++++++++++++
>  5 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index d396a18fe0f3..6f88c352b53e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -325,6 +325,7 @@ enum smu_table_id
>  	SMU_TABLE_PACE,
>  	SMU_TABLE_ECCINFO,
>  	SMU_TABLE_COMBO_PPTABLE,
> +	SMU_TABLE_WIFIBAND,
>  	SMU_TABLE_COUNT,
>  };
>  
> @@ -1501,6 +1502,8 @@ enum smu_baco_seq {
>  			 __dst_size);					   \
>  })
>  
> +#define HZ_IN_MHZ		1000000U

Don't add generic conversion constants like this into driver specific 
code. Use the one from include/linux/units.h, 

> +
>  #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
>  int smu_get_power_limit(void *handle,
>  			uint32_t *limit,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..5bbb60289a79 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>  	__SMU_DUMMY_MAP(AllowGpo),	\
>  	__SMU_DUMMY_MAP(Mode2Reset),	\
>  	__SMU_DUMMY_MAP(RequestI2cTransaction), \
> -	__SMU_DUMMY_MAP(GetMetricsTable),
> +	__SMU_DUMMY_MAP(GetMetricsTable), \
> +	__SMU_DUMMY_MAP(EnableUCLKShadow),
>  
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index 355c156d871a..dd70b56aa71e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -299,5 +299,8 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
>  				     uint32_t pcie_gen_cap,
>  				     uint32_t pcie_width_cap);
>  
> +int smu_v13_0_enable_uclk_shadow(struct smu_context *smu,
> +				 bool enablement);
> +
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 9b62b45ebb7f..6a5cb582aa92 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2472,3 +2472,12 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
>  
>  	return 0;
>  }
> +
> +int smu_v13_0_enable_uclk_shadow(struct smu_context *smu,
> +				 bool enablement)
> +{
> +	return smu_cmn_send_smc_msg_with_param(smu,
> +					       SMU_MSG_EnableUCLKShadow,
> +					       enablement,
> +					       NULL);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 0fb6be11a0cc..08ab19559c7b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -154,6 +154,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
>  	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
>  	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
>  	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
> +	MSG_MAP(EnableUCLKShadow,		PPSMC_MSG_EnableUCLKShadow,            0),
>  };
>  
>  static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
> @@ -237,6 +238,7 @@ static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
>  	TAB_MAP(I2C_COMMANDS),
>  	TAB_MAP(ECCINFO),
>  	TAB_MAP(OVERDRIVE),
> +	TAB_MAP(WIFIBAND),
>  };
>  
>  static struct cmn2asic_mapping smu_v13_0_0_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
> @@ -496,6 +498,9 @@ static int smu_v13_0_0_tables_init(struct smu_context *smu)
>  			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>  	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
>  			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +	SMU_TABLE_INIT(tables, SMU_TABLE_WIFIBAND,
> +		       sizeof(WifiBandEntryTable_t), PAGE_SIZE,
> +		       AMDGPU_GEM_DOMAIN_VRAM);
>  
>  	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
>  	if (!smu_table->metrics_table)
> @@ -2607,6 +2612,58 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
>  	return ret;
>  }
>  
> +static bool smu_v13_0_0_wbrf_support_check(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +
> +	switch (adev->ip_versions[MP1_HWIP][0]) {
> +	case IP_VERSION(13, 0, 0):
> +		return smu->smc_fw_version >= 0x004e6300;
> +	case IP_VERSION(13, 0, 10):
> +		return smu->smc_fw_version >= 0x00503300;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int smu_v13_0_0_set_wbrf_exclusion_ranges(struct smu_context *smu,
> +						 struct freq_band_range *exclusion_ranges)
> +{
> +	WifiBandEntryTable_t wifi_bands;
> +	int valid_entries = 0;
> +	int ret, i;
> +
> +	memset(&wifi_bands, 0, sizeof(wifi_bands));
> +	for (i = 0; i < ARRAY_SIZE(wifi_bands.WifiBandEntry); i++) {
> +		if (!exclusion_ranges[i].start &&
> +		    !exclusion_ranges[i].end)
> +			break;
> +
> +		/* PMFW expects the inputs to be in Mhz unit */
> +		wifi_bands.WifiBandEntry[valid_entries].LowFreq =
> +			DIV_ROUND_DOWN_ULL(exclusion_ranges[i].start, HZ_IN_MHZ);
> +		wifi_bands.WifiBandEntry[valid_entries++].HighFreq =
> +			DIV_ROUND_UP_ULL(exclusion_ranges[i].end, HZ_IN_MHZ);
> +	}
> +	wifi_bands.WifiBandEntryNum = valid_entries;
> +
> +	/*
> +	 * Per confirm with PMFW team, WifiBandEntryNum = 0
> +	 * is a valid setting. So, there should be no direct
> +	 * return on that.
> +	 */
> +
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_WIFIBAND,
> +				   0,
> +				   (void *)(&wifi_bands),

Explicit casting to void * is never needed, drop it and the parenthesis.

This probably fits to one line after that and certainly to less lines than 
now.

> +				   true);
> +	if (ret)
> +		dev_warn(smu->adev->dev, "Failed to set wifiband!");
> +
> +	return ret;
> +}
> +
>  static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>  	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
>  	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
> @@ -2686,6 +2743,9 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>  	.send_hbm_bad_channel_flag = smu_v13_0_0_send_bad_mem_channel_flag,
>  	.gpo_control = smu_v13_0_gpo_control,
>  	.get_ecc_info = smu_v13_0_0_get_ecc_info,
> +	.is_asic_wbrf_supported = smu_v13_0_0_wbrf_support_check,
> +	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
> +	.set_wbrf_exclusion_ranges = smu_v13_0_0_set_wbrf_exclusion_ranges,
>  };
>  
>  void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> 

-- 
 i.

