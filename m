Return-Path: <linux-kernel+bounces-163773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 158918B6FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46583B2159B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14D912BF15;
	Tue, 30 Apr 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8G3jEEt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48726AEC;
	Tue, 30 Apr 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473076; cv=none; b=E7rq+8Tg0Ed75bHDtkDX0P0RCt2KUlXBoTkD5YaJSSql2PewflZmsrw42pkn8YhWQCO9XEETa+SsfDsNKVt1/3NxZWiWphnUOjwj4lbs0kKAXLL5Wl10aAYOsWsXDoM7ydvamgh1X4D0lPIFKVSYw83sJg1wdlpNAJGrmxGVv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473076; c=relaxed/simple;
	bh=KwVEuTrPd6AukUgjfiufP5JtvmDvFkpccV+xOCHaQkQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QbtcQIkO9ac0RKWn37rzSaGNmDif4qo16FhR6B/lvnGPSNWwvE6XzM3up2BUDMKW49mrVmvk2cy7WNaXsj8dwAhTqF6KaTT7x+P7vMq39xKTQhuMVSOlxpi52QAqoxiuzEvlA/M7ztSysxR3OMajEQZOPuKBuf6C2ZoY1hb/3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8G3jEEt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714473075; x=1746009075;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KwVEuTrPd6AukUgjfiufP5JtvmDvFkpccV+xOCHaQkQ=;
  b=R8G3jEEti/wdSHkA3OIjHGw5/7xYRbKORkWRKpuaaUYc3ECpWC3iZqVX
   L55Etjey3N+FQhoe3cnOM2wsR7KV2XQVA66KtbRjuQNXrMUTfD7zOIjEV
   vME5RoaE2wB/A9cc/Q7Ry2OgMNQrP0+z3oAKmYuFpfaM6IE3hriCh7NjF
   ALLKyHHyFg04XLyR9KyIQmrx6m10e9ufloFf97Dm4tQxsbApZm6A8v16c
   BwYAg/UdEaQ8xmnqC21bc67TytcbMhAem7TKLhJ2rxT5KJ06exS4eBdCO
   uqhqJFRVFa9wg789cIlvN5rOPoPm24czxw/F69WLXZbfOXgarP3qoB2nn
   w==;
X-CSE-ConnectionGUID: PedwDPF8SxGitcv8jvTFWA==
X-CSE-MsgGUID: 1/LoexzMRIyU6zk3PmURVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21321904"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21321904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 03:31:14 -0700
X-CSE-ConnectionGUID: T/OkrYOPQJaDPHr9C+YLMA==
X-CSE-MsgGUID: nzBltv7XTWSsCMHIr0rdjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="31136877"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 03:31:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Apr 2024 13:31:04 +0300 (EEST)
To: Lyndon Sanche <lsanche@lyndeno.ca>
cc: mario.limonciello@amd.com, pali@kernel.org, W_Armin@gmx.de, 
    srinivas.pandruvada@linux.intel.com, Matthew Garrett <mjg59@srcf.ucam.org>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3] platform/x86: dell-laptop: Implement
 platform_profile
In-Reply-To: <20240429164844.7544-2-lsanche@lyndeno.ca>
Message-ID: <6075bdd1-324c-ced7-4424-826b50767afc@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca> <20240429164844.7544-2-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Apr 2024, Lyndon Sanche wrote:

> Some Dell laptops support configuration of preset fan modes through
> smbios tables.
> 
> If the platform supports these fan modes, set up platform_profile to
> change these modes. If not supported, skip enabling platform_profile.
> 
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---
> v3:
>  - Convert smbios-thermal-ctl docs to multiline comment and wrap
>  - Change thermal_mode_bits enum to directly be BIT() values
>   - Convert related code to use this
>  - Use FIELD_GET/PREP and GENNMASK for getting/setting thermal modes
>   - Correct offset for getting current ACC mode, setting offset
> 		unchanged
>  - Check if thermal_handler is allocated before freeing and
> 	 unregistering platform_profile
> v2:
>  - Wrap smbios-thermal-ctl comment
>  - Return proper error code when invalid state returned
>  - Simplify platform_profile_get returns
>  - Propogate ENOMEM error
> ---
>  drivers/platform/x86/dell/dell-laptop.c | 232 ++++++++++++++++++++++++
>  drivers/platform/x86/dell/dell-smbios.h |   1 +
>  2 files changed, 233 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 42f7de2b4522..fa58e7751d06 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -27,6 +27,8 @@
>  #include <linux/i8042.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> +#include <linux/platform_profile.h>
> +#include <linux/bitfield.h>
>  #include <acpi/video.h>
>  #include "dell-rbtn.h"
>  #include "dell-smbios.h"
> @@ -95,6 +97,7 @@ static struct backlight_device *dell_backlight_device;
>  static struct rfkill *wifi_rfkill;
>  static struct rfkill *bluetooth_rfkill;
>  static struct rfkill *wwan_rfkill;
> +static struct platform_profile_handler *thermal_handler;
>  static bool force_rfkill;
>  static bool micmute_led_registered;
>  static bool mute_led_registered;
> @@ -2199,6 +2202,227 @@ static int mute_led_set(struct led_classdev *led_cdev,
>  	return 0;
>  }
>  
> +/* Derived from smbios-thermal-ctl
> + *
> + * cbClass 17
> + * cbSelect 19
> + * User Selectable Thermal Tables(USTT)
> + * cbArg1 determines the function to be performed
> + * cbArg1 0x0 = Get Thermal Information
> + *  cbRES1         Standard return codes (0, -1, -2)
> + *  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is supported if
> + *                  its bit is set to 1
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + *  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC) modes.
> + *                 Each mode corresponds to the supported thermal modes in
> + *                  byte 0. A mode is supported if its bit is set to 1.
> + *     Bit 0 AAC (Balanced)
> + *     Bit 1 AAC (Cool Bottom
> + *     Bit 2 AAC (Quiet)
> + *     Bit 3 AAC (Performance)
> + *  cbRes3, byte 0 Current Thermal Mode
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performanc
> + *  cbRes3, byte 1  AAC Configuration type
> + *          0       Global (AAC enable/disable applies to all supported USTT modes)
> + *          1       USTT mode specific
> + *  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
> + *     If AAC Configuration Type is Global,
> + *          0       AAC mode disabled
> + *          1       AAC mode enabled
> + *     If AAC Configuration Type is USTT mode specific (multiple bits may be set),
> + *          Bit 0 AAC (Balanced)
> + *          Bit 1 AAC (Cool Bottom
> + *          Bit 2 AAC (Quiet)
> + *          Bit 3 AAC (Performance)
> + *  cbRes3, byte 3  Current Fan Failure Mode
> + *     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan working)
> + *     Bit 1 Catastrophic Fan Failure (all fans have failed)
> + *  cbArg1 0x1   (Set Thermal Information), both desired thermal mode and
> + *               desired AAC mode shall be applied
> + *  cbArg2, byte 0  Desired Thermal Mode to set
> + *                  (only one bit may be set for this parameter)
> + *     Bit 0 Balanced
> + *     Bit 1 Cool Bottom
> + *     Bit 2 Quiet
> + *     Bit 3 Performance
> + *  cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
> + *     If AAC Configuration Type is Global,
> + *         0  AAC mode disabled
> + *         1  AAC mode enabled
> + *
> + *     If AAC Configuration Type is USTT mode specific
> + *     (multiple bits may be set for this parameter),
> + *         Bit 0 AAC (Balanced)
> + *         Bit 1 AAC (Cool Bottom
> + *         Bit 2 AAC (Quiet)
> + *         Bit 3 AAC (Performance)
> + */
> +
> +#define DELL_ACC_GET_FIELD GENMASK(19, 16)
> +#define DELL_ACC_SET_FIELD GENMASK(11, 8)
> +#define DELL_THERMAL_SUPPORTED GENMASK(3, 0)

Please align these with tabs.

> +enum thermal_mode_bits {
> +	DELL_BALANCED = BIT(0),
> +	DELL_COOL_BOTTOM = BIT(1),
> +	DELL_QUIET = BIT(2),
> +	DELL_PERFORMANCE = BIT(3),

You need #include <linux/bits.h> for BIT().

> +};
> +
> +static int thermal_get_mode(void)
> +{
> +	struct calling_interface_buffer buffer;
> +	int state;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	state = buffer.output[2];
> +	if (state & DELL_BALANCED)
> +		return DELL_BALANCED;
> +	else if (state & DELL_COOL_BOTTOM)
> +		return DELL_COOL_BOTTOM;
> +	else if (state & DELL_QUIET)
> +		return DELL_QUIET;
> +	else if (state & DELL_PERFORMANCE)
> +		return DELL_PERFORMANCE;
> +	else
> +		return -ENXIO;
> +}
> +
> +static int thermal_get_supported_modes(int *supported_bits)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*supported_bits = FIELD_GET(DELL_THERMAL_SUPPORTED, buffer.output[1]);
> +	return 0;
> +}
> +
> +static int thermal_get_acc_mode(int *acc_mode)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*acc_mode = FIELD_GET(DELL_ACC_GET_FIELD, buffer.output[3]);
> +	return 0;
> +}
> +
> +static int thermal_set_mode(enum thermal_mode_bits state)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +	int acc_mode;
> +
> +	ret = thermal_get_acc_mode(&acc_mode);
> +	if (ret)
> +		return ret;
> +
> +	dell_fill_request(&buffer, 0x1, FIELD_PREP(DELL_ACC_SET_FIELD, acc_mode) | state, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> +					enum platform_profile_option profile)
> +{
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		return thermal_set_mode(DELL_BALANCED);
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		return thermal_set_mode(DELL_PERFORMANCE);
> +	case PLATFORM_PROFILE_QUIET:
> +		return thermal_set_mode(DELL_QUIET);
> +	case PLATFORM_PROFILE_COOL:
> +		return thermal_set_mode(DELL_COOL_BOTTOM);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> +					enum platform_profile_option *profile)
> +{
> +	int ret = thermal_get_mode();
> +
> +	if (ret < 0)

I think I already mentioned about this, change to:

	int ret;

	ret = thermal_get_mode();
	if (ret < 0)

> +		return ret;
> +
> +	switch (ret) {
> +	case DELL_BALANCED:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case DELL_PERFORMANCE:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case DELL_COOL_BOTTOM:
> +		*profile = PLATFORM_PROFILE_COOL;
> +		break;
> +	case DELL_QUIET:
> +		*profile = PLATFORM_PROFILE_QUIET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	ret = thermal_get_supported_modes(&supported_modes);
> +	if (ret || !supported_modes)
> +		return 0;

I think you should propagate the error code differently from nothing 
supported:

	if (ret < 0)
		return ret;
	if (!supported_modes)
		return 0;

-- 
 i.

> +
> +	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> +	if (!thermal_handler)
> +		return -ENOMEM;
> +	thermal_handler->profile_get = thermal_platform_profile_get;
> +	thermal_handler->profile_set = thermal_platform_profile_set;
> +
> +	if (supported_modes & DELL_QUIET)
> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> +	if (supported_modes & DELL_COOL_BOTTOM)
> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> +	if (supported_modes & DELL_BALANCED)
> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> +	if (supported_modes & DELL_PERFORMANCE)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> +
> +	// Clean up but do not fail
> +	if (platform_profile_register(thermal_handler))
> +		kfree(thermal_handler);
> +
> +	return 0;
> +}
> +
> +void thermal_cleanup(void)
> +{
> +	if (thermal_handler) {
> +		platform_profile_remove();
> +		kfree(thermal_handler);
> +	}
> +}
> +
>  static struct led_classdev mute_led_cdev = {
>  	.name = "platform::mute",
>  	.max_brightness = 1,
> @@ -2238,6 +2462,11 @@ static int __init dell_init(void)
>  		goto fail_rfkill;
>  	}
>  
> +	// Do not fail module if thermal modes not supported, just skip
> +	ret = thermal_init();
> +	if (ret)
> +		goto fail_thermal;
> +
>  	if (quirks && quirks->touchpad_led)
>  		touchpad_led_init(&platform_device->dev);
>  
> @@ -2317,6 +2546,8 @@ static int __init dell_init(void)
>  		led_classdev_unregister(&mute_led_cdev);
>  fail_led:
>  	dell_cleanup_rfkill();
> +fail_thermal:
> +	thermal_cleanup();
>  fail_rfkill:
>  	platform_device_del(platform_device);
>  fail_platform_device2:
> @@ -2344,6 +2575,7 @@ static void __exit dell_exit(void)
>  		platform_device_unregister(platform_device);
>  		platform_driver_unregister(&platform_driver);
>  	}
> +	thermal_cleanup();
>  }
>  
>  /* dell-rbtn.c driver export functions which will not work correctly (and could
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index eb341bf000c6..585d042f1779 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -19,6 +19,7 @@
>  /* Classes and selects used only in kernel drivers */
>  #define CLASS_KBD_BACKLIGHT 4
>  #define SELECT_KBD_BACKLIGHT 11
> +#define SELECT_THERMAL_MANAGEMENT 19
>  
>  /* Tokens used in kernel drivers, any of these
>   * should be filtered from userspace access
> 

