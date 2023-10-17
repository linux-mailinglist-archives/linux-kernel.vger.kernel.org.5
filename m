Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE257CBE57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjJQJD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbjJQJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:03:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512CB8E;
        Tue, 17 Oct 2023 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697533433; x=1729069433;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bYg38E3e/vhXYWresPVnGgaNf/gc0H4id9aMD0AqQJM=;
  b=BE0Z6mbQZgghka3Nc7awanwJ454pIFIkdt5M+Hqxg1mAz6CQ6q2ftXoe
   dnM15I/m+wVN3vkQioFEiF0hF6f5QGa1AkTuJD6YKTzB0OG9mlJRjSjNT
   /EH1DUK5wWAkifNyny4k2N+LVyc4awEHhZhIMfi+ELsB6iyexlTO9M6Sv
   KGI4e42stoq3vNGV97CchE4oYemWRXS/If/P23iBat4oFrPDr8NmMiSh5
   D7b/z+Vev/aj/fsh8VljE+5jNCCvvZXFSoDyLIkWOyjnP22sWZNfG6lLT
   1Ks743IBEuk+8lltt2E0fzY4KH1zgDzfobB0QaiO/vA1WvVojB3GwCMuc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376106189"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="376106189"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785409867"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785409867"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.44.24])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:03:47 -0700
Date:   Tue, 17 Oct 2023 12:03:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Ma Jun <Jun.Ma2@amd.com>
cc:     amd-gfx@lists.freedesktop.org, lenb@kernel.org,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, majun@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Evan Quan <quanliangl@hotmail.com>
Subject: Re: [PATCH v12 9/9] drm/amd/pm: enable Wifi RFI mitigation feature
 support for SMU13.0.7
In-Reply-To: <20231017025358.1773598-10-Jun.Ma2@amd.com>
Message-ID: <9ab5375c-d911-ab3-5522-e0e1dd33f043@linux.intel.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com> <20231017025358.1773598-10-Jun.Ma2@amd.com>
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
> Fulfill the SMU13.0.7 support for Wifi RFI mitigation feature.
> 
> Signed-off-by: Evan Quan <quanliangl@hotmail.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> --
> v10->v11:
>   - downgrade the prompt level on message failure(Lijo)
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 62f2886ab4df..c5736fb3cf6d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -126,6 +126,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
>  	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
>  	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
>  	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
> +	MSG_MAP(EnableUCLKShadow,		PPSMC_MSG_EnableUCLKShadow,            0),
>  };
>  
>  static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
> @@ -207,6 +208,7 @@ static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
>  	TAB_MAP(ACTIVITY_MONITOR_COEFF),
>  	[SMU_TABLE_COMBO_PPTABLE] = {1, TABLE_COMBO_PPTABLE},
>  	TAB_MAP(OVERDRIVE),
> +	TAB_MAP(WIFIBAND),
>  };
>  
>  static struct cmn2asic_mapping smu_v13_0_7_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
> @@ -503,6 +505,9 @@ static int smu_v13_0_7_tables_init(struct smu_context *smu)
>  	               AMDGPU_GEM_DOMAIN_VRAM);
>  	SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE, MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE,
>  			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> +	SMU_TABLE_INIT(tables, SMU_TABLE_WIFIBAND,
> +		       sizeof(WifiBandEntryTable_t), PAGE_SIZE,
> +		       AMDGPU_GEM_DOMAIN_VRAM);
>  
>  	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
>  	if (!smu_table->metrics_table)
> @@ -2179,6 +2184,57 @@ static int smu_v13_0_7_set_df_cstate(struct smu_context *smu,
>  					       NULL);
>  }
>  
> +static bool smu_v13_0_7_wbrf_support_check(struct smu_context *smu)
> +{
> +	return smu->smc_fw_version > 0x00524600;
> +}
> +
> +static int smu_v13_0_7_set_wbrf_exclusion_ranges(struct smu_context *smu,
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

After having seen this construct nth time, I think you should have a 
static inline function for this check with a proper name.

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
> +	 * Per confirm with PMFW team, WifiBandEntryNum = 0 is a valid setting.
> +	 * Considering the scenarios below:
> +	 * - At first the wifi device adds an exclusion range e.g. (2400,2500) to
> +	 *   BIOS and our driver gets notified. We will set WifiBandEntryNum = 1
> +	 *   and pass the WifiBandEntry (2400, 2500) to PMFW.
> +	 *
> +	 * - Later the wifi device removes the wifiband list added above and
> +	 *   our driver gets notified again. At this time, driver will set
> +	 *   WifiBandEntryNum = 0 and pass an empty WifiBandEntry list to PMFW.
> +	 *   - PMFW may still need to do some uclk shadow update(e.g. switching
> +	 *     from shadow clock back to primary clock) on receiving this.
> +	 */
> +
> +	ret = smu_cmn_update_table(smu,
> +				   SMU_TABLE_WIFIBAND,
> +				   0,
> +				   (void *)(&wifi_bands),
> +				   true);
> +	if (ret)
> +		dev_warn(smu->adev->dev, "Failed to set wifiband!");
> +
> +	return ret;
> +}

Is this whole function duplicate of the one in the other file? Don't 
duplicate code like this but create reusable functions properly.

-- 
 i.

> +
>  static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
>  	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
>  	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
> @@ -2247,6 +2303,9 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
>  	.set_mp1_state = smu_v13_0_7_set_mp1_state,
>  	.set_df_cstate = smu_v13_0_7_set_df_cstate,
>  	.gpo_control = smu_v13_0_gpo_control,
> +	.is_asic_wbrf_supported = smu_v13_0_7_wbrf_support_check,
> +	.enable_uclk_shadow = smu_v13_0_enable_uclk_shadow,
> +	.set_wbrf_exclusion_ranges = smu_v13_0_7_set_wbrf_exclusion_ranges,
>  };
>  
>  void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
> 

