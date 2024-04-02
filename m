Return-Path: <linux-kernel+bounces-127763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655AB895098
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882D81C22488
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294DF5FDB3;
	Tue,  2 Apr 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nim0KH4c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9515FB87;
	Tue,  2 Apr 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054613; cv=none; b=QE2dtRyooj39sYEUQdNX7OfJkiiMUMxUacek8kQsJWirHIx6l+sdljHKacK/HbAu43IWUau5dpayuVbk+1Q9fHWIRa7aoG9F3yKGt5Jnu4Orhd15kF8gSPobikhZNE6TFxUhlNju4DBCqnWfFr3CU5FBG9pQFaJcQMF/hOy/DJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054613; c=relaxed/simple;
	bh=2E/VcTORLT4MZBHqARbP5tVglYCe7QzuB6aizFMeckA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jUCBnpJa/wYArzhTtesXMmufh5JvjJ5nrxoQ1eRiDqjuELHE/2hGTvt+ma7Drd/I4xkQTsCarFxsvRLM++JNxVWfT1KmXaWb7Yn/YDFQydARiIsSd/Pv1DdmIz2yE8vhcmDE5aaZc7fd0HG1n4kwmmHkM6KfBeQ02JD5XaMzpVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nim0KH4c; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712054611; x=1743590611;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2E/VcTORLT4MZBHqARbP5tVglYCe7QzuB6aizFMeckA=;
  b=nim0KH4cFVnHnlQEgRKrDg+aEiDI4kv6xkImrwV2h0Kg/y6BOdIqYitF
   a8ggaxTwYOh8S7SQPyt41Nanl1OSzV0oCg1LxwVQJKDUQ6NBVfARr3HRn
   xEcr29O7YHWUTp9hPujlQLMLOupcvhiqV7fQUwowRmtDKzJEr3yjXj43R
   Fdxu8yMFR9maSTIyfUF7tMFPQXxXh0N+nHzLRxV2Z9UHQlUXsN7ijeT9P
   eDV7i1twcOV+cQWVVTXzmqTAPALkeTQ+Vfe9jZKKV/JZ93lJzu2miYV8K
   fMfqSpQEMzCY9uU7AdBYvVtpGZU8Z650xDEISOnbWN5cfuRNMdOzM0thV
   g==;
X-CSE-ConnectionGUID: XSJxXvtxSPuoINDEhfa+CA==
X-CSE-MsgGUID: T8uAT5FAQn2PSxmTK2HGuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17943776"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17943776"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18000623"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:43:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 13:43:25 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/9] platform/x86: asus-wmi: add support for 2024 ROG
 Mini-LED
In-Reply-To: <20240402022607.34625-2-luke@ljones.dev>
Message-ID: <d1ec4c78-0b1e-28ec-7324-806b29ed77c9@linux.intel.com>
References: <20240402022607.34625-1-luke@ljones.dev> <20240402022607.34625-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Apr 2024, Luke D. Jones wrote:

> Support the 2024 mini-led backlight and adjust the related functions
> to select the relevant dev-id. Also add `available_mini_led_mode` to the
> platform sysfs since the available mini-led levels can be different.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  8 ++
>  drivers/platform/x86/asus-wmi.c               | 80 ++++++++++++++++---
>  include/linux/platform_data/x86/asus-wmi.h    |  1 +
>  3 files changed, 78 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 8a7e25bde085..ef1ac1a20a71 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -126,6 +126,14 @@ Description:
>  		Change the mini-LED mode:
>  			* 0 - Single-zone,
>  			* 1 - Multi-zone
> +			* 2 - Multi-zone strong (available on newer generation mini-led)
> +
> +What:		/sys/devices/platform/<platform>/available_mini_led_mode
> +Date:		Apr 2024
> +KernelVersion:	6.10
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		List the available mini-led modes.
>  
>  What:		/sys/devices/platform/<platform>/ppt_pl1_spl
>  Date:		Jun 2023
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3f07bbf809ef..2330f02ff76f 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -288,7 +288,7 @@ struct asus_wmi {
>  	bool battery_rsoc_available;
>  
>  	bool panel_overdrive_available;
> -	bool mini_led_mode_available;
> +	u32 mini_led_dev_id;
>  
>  	struct hotplug_slot hotplug_slot;
>  	struct mutex hotplug_lock;
> @@ -2108,13 +2108,30 @@ static ssize_t mini_led_mode_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
> -	int result;
> +	u32 value;
>  
> -	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
> -	if (result < 0)
> -		return result;
> +	asus_wmi_get_devstate(asus, asus->mini_led_dev_id, &value);

Error handling missing.

> +	value = value & 0x03; // only 3 modes on 2024 version

Add #define XX GENMASK(1, 0) for this.

>  
> -	return sysfs_emit(buf, "%d\n", result);
> +	/* Remap the mode values to match previous generation mini-led.
> +	 * Some BIOSes return -19 instead of 2, which is "mini-LED off", this
> +	 * appears to be a  BIOS bug.

Is this comment still 100% valid now or should it be removed completely? 
There's no handling for -19 in ASUS_WMI_DEVID_MINI_LED_MODE2 block?

There's also a double space in the comment.

> +	 */
> +	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +		switch (value) {
> +		case 0:
> +			value = 1;
> +			break;
> +		case 1:
> +			value = 2;
> +			break;
> +		case 2:
> +			value = 0;

Add break here too.

These literals 0-2 should be named with #defines as it would make the code 
readable, current way of the mapping between literal numbers 
unintelligible magic.

> +		}
> +	} else if (value < 0) {

This will never be true because value is u32 and also because of & 0x03 
even if you'd change the type.

I don't quite follow what you're trying to do here. Why this only applies 
to cases != ASUS_WMI_DEVID_MINI_LED_MODE2?

> +		return value;
> +	}
> +	return sysfs_emit(buf, "%d\n", value);
>  }
>  
>  static ssize_t mini_led_mode_store(struct device *dev,
> @@ -2130,11 +2147,28 @@ static ssize_t mini_led_mode_store(struct device *dev,
>  	if (result)
>  		return result;
>  
> -	if (mode > 1)
> +	if (mode > 1 && asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE)
>  		return -EINVAL;
> +	if (mode > 2 && asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2)
> +		return -EINVAL;
> +	/*
> +	 * Remap the mode values so expected behaviour is the same as the last
> +	 * generation of mini-LED

Missing .

-- 
 i.

> +	 */
> +	if (asus->mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
> +		switch (mode) {
> +		case 0:
> +			mode = 2;
> +			break;
> +		case 1:
> +			mode = 0;
> +			break;
> +		case 2:
> +			mode = 1;
> +		}
> +	}
>  
> -	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MINI_LED_MODE, mode, &result);
> -
> +	err = asus_wmi_set_devstate(asus->mini_led_dev_id, mode, &result);
>  	if (err) {
>  		pr_warn("Failed to set mini-LED: %d\n", err);
>  		return err;
> @@ -2151,6 +2185,23 @@ static ssize_t mini_led_mode_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(mini_led_mode);
>  
> +static ssize_t available_mini_led_mode_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	switch (asus->mini_led_dev_id) {
> +	case ASUS_WMI_DEVID_MINI_LED_MODE:
> +		return sysfs_emit(buf, "0 1\n");
> +	case ASUS_WMI_DEVID_MINI_LED_MODE2:
> +		return sysfs_emit(buf, "0 1 2\n");
> +	}
> +
> +	return sysfs_emit(buf, "0\n");
> +}
> +
> +static DEVICE_ATTR_RO(available_mini_led_mode);
> +
>  /* Quirks *********************************************************************/
>  
>  static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
> @@ -4139,6 +4190,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_nv_temp_target.attr,
>  	&dev_attr_panel_od.attr,
>  	&dev_attr_mini_led_mode.attr,
> +	&dev_attr_available_mini_led_mode.attr,
>  	NULL
>  };
>  
> @@ -4191,7 +4243,9 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  	else if (attr == &dev_attr_panel_od.attr)
>  		ok = asus->panel_overdrive_available;
>  	else if (attr == &dev_attr_mini_led_mode.attr)
> -		ok = asus->mini_led_mode_available;
> +		ok = asus->mini_led_dev_id != 0;
> +	else if (attr == &dev_attr_available_mini_led_mode.attr)
> +		ok = asus->mini_led_dev_id != 0;
>  
>  	if (devid != -1)
>  		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
> @@ -4444,10 +4498,14 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	asus->nv_dyn_boost_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_DYN_BOOST);
>  	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
>  	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
> -	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
>  	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
>  						&& dmi_match(DMI_BOARD_NAME, "RC71L");
>  
> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
> +		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
> +	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE2))
> +		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
> +
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
>  		goto fail_fan_boost_mode;
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index ab1c7deff118..9cadce10ad9a 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -71,6 +71,7 @@
>  #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
>  #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
>  #define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
> +#define ASUS_WMI_DEVID_MINI_LED_MODE2	0x0005002E
>  
>  /* Storage */
>  #define ASUS_WMI_DEVID_CARDREADER	0x00080013
> 

