Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843FB7CBE1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjJQIve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjJQIvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:51:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE69B93;
        Tue, 17 Oct 2023 01:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697532689; x=1729068689;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I2U51BeL5fBNZOAKAWZm9O4BjdxUwlVA5UXcv34xKTA=;
  b=mZwtl0UG2+/Zzs0GbHaDoovXf6zCfaa5lOsFpZoxBRxG6kSH3WyERGCP
   9E4cOr0aE7DCbEOBk1pJSpo/J7KIGolPk6lhKf4PCasUX1SSC7bE3yq1S
   msb89ka5IU5gB6vWFXpmNa2QXl7qACq5yzxjHau81V7Y5TEdLouvtHZJI
   gLzQ1TSwMGV3yYWBGH75fgrsg0W0g1CZmo6fsDWUhwHxJW8ZQRnQ/zD/X
   2Yxn/vC9T9zCis9q7kV+T8gBzMNjfVPGH2/DElijDs1qEHQzrG6nkOL1K
   GkOKfL5XGO/u4T1JRc4qCbc7sA1jkNNA4yta1DvgRaL+KYsTBXwZvt+VL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="4336709"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="4336709"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="879747289"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="879747289"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.44.24])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:51:23 -0700
Date:   Tue, 17 Oct 2023 11:51:20 +0300 (EEST)
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
Subject: Re: [PATCH v12 6/9] drm/amd/pm: setup the framework to support Wifi
 RFI mitigation feature
In-Reply-To: <20231017025358.1773598-7-Jun.Ma2@amd.com>
Message-ID: <7583aaca-d7ad-c05b-731f-f7f0b345872b@linux.intel.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com> <20231017025358.1773598-7-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-949281964-1697532687=:2358"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-949281964-1697532687=:2358
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 17 Oct 2023, Ma Jun wrote:

> From: Evan Quan <quanliangl@hotmail.com>
> 
> With WBRF feature supported, as a driver responding to the frequencies,
> amdgpu driver is able to do shadow pstate switching to mitigate possible
> interference(between its (G-)DDR memory clocks and local radio module
> frequency bands used by Wifi 6/6e/7).
> 
> Signed-off-by: Evan Quan <quanliangl@hotmail.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> --
> v1->v2:
>   - update the prompt for feature support(Lijo)
> v8->v9:
>   - update parameter document for smu_wbrf_event_handler(Simon)
> v9->v10:
> v10->v11:
>  - correct the logics for wbrf range sorting(Lijo)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 195 ++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  23 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
>  5 files changed, 240 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6dc950c1b689..11a19384df56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -247,6 +247,8 @@ extern int amdgpu_sg_display;
>  
>  extern int amdgpu_user_partt_mode;
>  
> +extern int amdgpu_wbrf;
> +
>  #define AMDGPU_VM_MAX_NUM_CTX			4096
>  #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 0593ef8fe0a6..1c574bd3b60d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -195,6 +195,7 @@ int amdgpu_use_xgmi_p2p = 1;
>  int amdgpu_vcnfw_log;
>  int amdgpu_sg_display = -1; /* auto */
>  int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
> +int amdgpu_wbrf = -1;
>  
>  static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
>  
> @@ -981,6 +982,22 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
>  module_param(enforce_isolation, bool, 0444);
>  MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
>  
> +/**
> + * DOC: wbrf (int)
> + * Enable Wifi RFI interference mitigation feature.
> + * Due to electrical and mechanical constraints there may be likely interference of
> + * relatively high-powered harmonics of the (G-)DDR memory clocks with local radio
> + * module frequency bands used by Wifi 6/6e/7. To mitigate the possible RFI interference,
> + * with this feature enabled, PMFW will use either “shadowed P-State” or “P-State” based
> + * on active list of frequencies in-use (to be avoided) as part of initial setting or
> + * P-state transition. However, there may be potential performance impact with this
> + * feature enabled.
> + * (0 = disabled, 1 = enabled, -1 = auto (default setting, will be enabled if supported))
> + */
> +MODULE_PARM_DESC(wbrf,
> +	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
> +module_param_named(wbrf, amdgpu_wbrf, int, 0444);
> +
>  /* These devices are not supported by amdgpu.
>   * They are supported by the mach64, r128, radeon drivers
>   */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 222af2fae745..d52cd7ed2868 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1228,6 +1228,174 @@ static int smu_get_thermal_temperature_range(struct smu_context *smu)
>  	return ret;
>  }
>  
> +/**
> + * smu_wbrf_handle_exclusion_ranges - consume the wbrf exclusion ranges
> + *
> + * @smu: smu_context pointer
> + *
> + * Retrieve the wbrf exclusion ranges and send them to PMFW for proper handling.
> + * Returns 0 on success, error on failure.
> + */
> +static int smu_wbrf_handle_exclusion_ranges(struct smu_context *smu)
> +{
> +	struct wbrf_ranges_in_out wbrf_exclusion = {0};
> +	struct freq_band_range *wifi_bands = wbrf_exclusion.band_list;
> +	struct amdgpu_device *adev = smu->adev;
> +	uint32_t num_of_wbrf_ranges = MAX_NUM_OF_WBRF_RANGES;
> +	uint64_t start, end;
> +	int ret, i, j;
> +
> +	ret = amd_wbrf_retrieve_freq_band(adev->dev, &wbrf_exclusion);
> +	if (ret) {
> +		dev_err(adev->dev, "Failed to retrieve exclusion ranges!\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * The exclusion ranges array we got might be filled with holes and duplicate
> +	 * entries. For example:
> +	 * {(2400, 2500), (0, 0), (6882, 6962), (2400, 2500), (0, 0), (6117, 6189), (0, 0)...}
> +	 * We need to do some sortups to eliminate those holes and duplicate entries.
> +	 * Expected output: {(2400, 2500), (6117, 6189), (6882, 6962), (0, 0)...}
> +	 */
> +	for (i = 0; i < num_of_wbrf_ranges; i++) {
> +		start = wifi_bands[i].start;
> +		end = wifi_bands[i].end;
> +
> +		/* get the last valid entry to fill the intermediate hole */
> +		if (!start && !end) {
> +			for (j = num_of_wbrf_ranges - 1; j > i; j--)
> +				if (wifi_bands[j].start &&
> +				    wifi_bands[j].end)
> +					break;
> +
> +			/* no valid entry left */
> +			if (j <= i)
> +				break;
> +
> +			start = wifi_bands[i].start = wifi_bands[j].start;
> +			end = wifi_bands[i].end = wifi_bands[j].end;
> +			wifi_bands[j].start = 0;
> +			wifi_bands[j].end = 0;
> +			num_of_wbrf_ranges = j;
> +		}

Wouldn't it be easier and less error-prone to just sort them and then do 
the duplicate removal after that?

> +		/* eliminate duplicate entries */
> +		for (j = i + 1; j < num_of_wbrf_ranges; j++) {
> +			if ((wifi_bands[j].start == start) &&
> +			     (wifi_bands[j].end == end)) {
> +				wifi_bands[j].start = 0;
> +				wifi_bands[j].end = 0;
> +			}
> +		}
> +	}
> +
> +	/* Send the sorted wifi_bands to PMFW */
> +	ret = smu_set_wbrf_exclusion_ranges(smu, wifi_bands);
> +	/* Give it another chance */

This sounds very vague comment. What "it", what "another chance" ??

> +	if (unlikely(ret == -EBUSY)) {
> +		mdelay(5);

Magic delay without name, please add a define for it.

> +		ret = smu_set_wbrf_exclusion_ranges(smu, wifi_bands);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * smu_wbrf_event_handler - handle notify events
> + *
> + * @nb: notifier block
> + * @action: event type
> + * @_arg: event data
> + *
> + * Calls relevant amdgpu function in response to wbrf event
> + * notification from kernel.
> + */
> +static int smu_wbrf_event_handler(struct notifier_block *nb,
> +				  unsigned long action, void *_arg)
> +{
> +	struct smu_context *smu = container_of(nb, struct smu_context,
> +					       wbrf_notifier);
> +
> +	switch (action) {
> +	case WBRF_CHANGED:
> +		smu_wbrf_handle_exclusion_ranges(smu);
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	};
> +
> +	return NOTIFY_OK;
> +}
> +
> +/**
> + * smu_wbrf_support_check - check wbrf support
> + *
> + * @smu: smu_context pointer
> + *
> + * Verifies the ACPI interface whether wbrf is supported.
> + */
> +static void smu_wbrf_support_check(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +
> +	smu->wbrf_supported = smu_is_asic_wbrf_supported(smu) &&
> +			      !!amdgpu_wbrf &&

Unnecessary !!.

> +			      acpi_amd_wbrf_supported_consumer(adev->dev);
> +
> +	if (smu->wbrf_supported)
> +		dev_info(adev->dev, "RF interference mitigation is supported\n");
> +}
> +
> +/**
> + * smu_wbrf_init - init driver wbrf support
> + *
> + * @smu: smu_context pointer
> + *
> + * Verifies the AMD ACPI interfaces and registers with the wbrf
> + * notifier chain if wbrf feature is supported.
> + * Returns 0 on success, error on failure.
> + */
> +static int smu_wbrf_init(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	int ret;
> +
> +	if (!smu->wbrf_supported)
> +		return 0;
> +
> +	smu->wbrf_notifier.notifier_call = smu_wbrf_event_handler;
> +	ret = amd_wbrf_register_notifier(&smu->wbrf_notifier);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Some wifiband exclusion ranges may be already there
> +	 * before our driver loaded. To make sure our driver
> +	 * is awared of those exclusion ranges.
> +	 */
> +	ret = smu_wbrf_handle_exclusion_ranges(smu);
> +	if (ret)
> +		dev_err(adev->dev, "Failed to handle wbrf exclusion ranges\n");
> +
> +	return ret;
> +}
> +
> +/**
> + * smu_wbrf_fini - tear down driver wbrf support
> + *
> + * @smu: smu_context pointer
> + *
> + * Unregisters with the wbrf notifier chain.
> + */
> +static void smu_wbrf_fini(struct smu_context *smu)
> +{
> +	if (!smu->wbrf_supported)
> +		return;
> +
> +	amd_wbrf_unregister_notifier(&smu->wbrf_notifier);
> +}
> +
>  static int smu_smc_hw_setup(struct smu_context *smu)
>  {
>  	struct smu_feature *feature = &smu->smu_feature;
> @@ -1320,6 +1488,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  	if (ret)
>  		return ret;
>  
> +	/* Enable UclkShadow on wbrf supported */
> +	if (smu->wbrf_supported) {
> +		ret = smu_enable_uclk_shadow(smu, true);
> +		if (ret) {
> +			dev_err(adev->dev, "Failed to enable UclkShadow feature to support wbrf!\n");
> +			return ret;
> +		}
> +	}
> +
>  	/*
>  	 * With SCPM enabled, these actions(and relevant messages) are
>  	 * not needed and permitted.
> @@ -1416,6 +1593,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  	 */
>  	ret = smu_set_min_dcef_deep_sleep(smu,
>  					  smu->smu_table.boot_values.dcefclk / 100);
> +	if (ret) {
> +		dev_err(adev->dev, "Error setting min deepsleep dcefclk\n");
> +		return ret;
> +	}
> +
> +	/* Init wbrf support. Properly setup the notifier */
> +	ret = smu_wbrf_init(smu);
> +	if (ret)
> +		dev_err(adev->dev, "Error during wbrf init call\n");
>  
>  	return ret;
>  }
> @@ -1471,6 +1657,13 @@ static int smu_hw_init(void *handle)
>  		return ret;
>  	}
>  
> +	/*
> +	 * Check whether wbrf is supported. This needs to be done
> +	 * before SMU setup starts since part of SMU configuration
> +	 * relies on this.
> +	 */
> +	smu_wbrf_support_check(smu);
> +
>  	if (smu->is_apu) {
>  		ret = smu_set_gfx_imu_enable(smu);
>  		if (ret)
> @@ -1623,6 +1816,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  
> +	smu_wbrf_fini(smu);
> +
>  	cancel_work_sync(&smu->throttling_logging_work);
>  	cancel_work_sync(&smu->interrupt_work);
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 6e2069dcb6b9..39c1620d68c9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -22,6 +22,8 @@
>  #ifndef __AMDGPU_SMU_H__
>  #define __AMDGPU_SMU_H__
>  
> +#include <linux/acpi_amd_wbrf.h>
> +
>  #include "amdgpu.h"
>  #include "kgd_pp_interface.h"
>  #include "dm_pp_interface.h"
> @@ -575,6 +577,10 @@ struct smu_context
>  	u32 debug_resp_reg;
>  
>  	struct delayed_work		swctf_delayed_work;
> +
> +	/* data structures for wbrf feature support */
> +	bool				wbrf_supported;
> +	struct notifier_block		wbrf_notifier;
>  };
>  
>  struct i2c_adapter;
> @@ -1356,6 +1362,23 @@ struct pptable_funcs {
>  	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
>  	 */
>  	int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +	/**
> +	 * @is_asic_wbrf_supported: check whether PMFW supports the wbrf feature
> +	 */
> +	bool (*is_asic_wbrf_supported)(struct smu_context *smu);
> +
> +	/**
> +	 * @enable_uclk_shadow: Enable the uclk shadow feature on wbrf supported
> +	 */
> +	int (*enable_uclk_shadow)(struct smu_context *smu,
> +				  bool enablement);

Fit to one line. Please go through all your patches and fix all 
prematurely split lines.

Perhaps "enable" is enough, I don't know why you use "enablement".

> +
> +	/**
> +	 * @set_wbrf_exclusion_ranges: notify SMU the wifi bands occupied
> +	 */
> +	int (*set_wbrf_exclusion_ranges)(struct smu_context *smu,
> +					 struct freq_band_range *exclusion_ranges);
>  };
>  
>  typedef enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> index ceb13c838067..aa64c7cdf3c9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -97,6 +97,9 @@
>  #define smu_get_default_config_table_settings(smu, config_table)	smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
>  #define smu_set_config_table(smu, config_table)				smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
>  #define smu_init_pptable_microcode(smu)					smu_ppt_funcs(init_pptable_microcode, 0, smu)
> +#define smu_is_asic_wbrf_supported(smu)					smu_ppt_funcs(is_asic_wbrf_supported, false, smu)
> +#define smu_enable_uclk_shadow(smu, enablement)				smu_ppt_funcs(enable_uclk_shadow, 0, smu, enablement)
> +#define smu_set_wbrf_exclusion_ranges(smu, freq_band_range)		smu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, freq_band_range)
>  
>  #endif
>  #endif
> 

-- 
 i.

--8323329-949281964-1697532687=:2358--
