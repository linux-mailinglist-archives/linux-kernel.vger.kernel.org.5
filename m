Return-Path: <linux-kernel+bounces-127812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F273895146
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF45B27853
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C43B60DEA;
	Tue,  2 Apr 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsB4ujla"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54855604CE;
	Tue,  2 Apr 2024 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055685; cv=none; b=T3hYfEXRZ8dWdfB5om1kLQWInfJlWjzvucrnIlqxtxLNUEFKzXLqR5zmiWB+EiMqFWNFk5CSPlr22U0F/M6VuoxYi68kYU6noArarvfzmO2MgPqaWNgLzAJh8dZSVAOofNj/8NKCfMHoqSY7bh2ANHdSzL8Pi8KDMngthEjRIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055685; c=relaxed/simple;
	bh=rj1/u8OgEk0y13URslrtKA3lalcycV6qD0VlAuEyOfk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lyhDBt3aadqvyIuXwcsQNLVICgieHv/ShJQawqmFt8XcJRA6idMrOpq0oX7x/M0iwUB39APZzfv1ivPbMAuo2ba30k8EAe1RanpEnadTaHMWGN00tQYmoAO2sC8mwyEZnTWawiHQUGOppLqG0tq8GsZvPLSDMg98IppSfJ2s+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsB4ujla; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712055683; x=1743591683;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rj1/u8OgEk0y13URslrtKA3lalcycV6qD0VlAuEyOfk=;
  b=VsB4ujlasP3P/ET4Nq3/u3Pf3TO3FRuVqaIFfR6LKD9fhvP3/3Yflp8D
   Q4NIymL7MLcrnwSUhbuViGxXVuTqb/MPvmhbC7MBJdoBu5cW6OA0NGMcv
   uJ6VFkbDmrGSTraKQUnIEvQe7GQyj1TRToUsfdEJ2PXljjXLXn1paMgFk
   ZSAx0P+eXwJwYxe/x9dAeKBnfvpOptsfeHKhS1MdKWqGcfq9PGjR3BT9u
   I4phY5GWX1+nN+aMmJbDqwSwvebkHKUb3qCW0W+OAmU5RO1CPsJOU9Vle
   GFAMfZD9IpsOK7Ka+zOE+xFHmzhkUX77u0EPczsqf9OjuDZucxKFOFSIO
   w==;
X-CSE-ConnectionGUID: MgSkvMWCRG6ChL128yFOhA==
X-CSE-MsgGUID: vHAlzYMzTKihBoqerEWVPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7346993"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7346993"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 04:01:20 -0700
X-CSE-ConnectionGUID: qoMmMPTsSny7nwf0CHiarg==
X-CSE-MsgGUID: qPkZO8VMTMabNne5/o54cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="55479605"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 04:01:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 14:01:15 +0300 (EEST)
To: "Luke D. Jones" <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] platform/x86: asus-wmi: Add support for MCU
 powersave
In-Reply-To: <20240402022607.34625-9-luke@ljones.dev>
Message-ID: <71426f4c-a44a-cf87-7045-b3f2b3fc240e@linux.intel.com>
References: <20240402022607.34625-1-luke@ljones.dev> <20240402022607.34625-9-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Apr 2024, Luke D. Jones wrote:

> Add support for an MCU powersave WMI call. This is intended to set the
> MCU in to a low-power mode when sleeping. This mode can cut sleep power
> use by around half.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Hi,

I fail to follow the logic of the patch here. This patch makes it 
configurable which is not bad in itself but what is the reason why a user 
would not always want to cut sleep power usage down? So this sounds like a 
feature that the user wants always enabled if available.

So what are the downsides of enabling it if it's supported?

-- 
 i.


> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       | 11 +++-
>  drivers/platform/x86/asus-wmi.c               | 50 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 41b92e53e88a..28144371a0f1 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -202,4 +202,13 @@ Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
>  		Set if the BIOS POST sound is played on boot.
>  			* 0 - False,
> -			* 1 - True
> \ No newline at end of file
> +			* 1 - True
> +
> +What:		/sys/devices/platform/<platform>/mcu_powersave
> +Date:		Apr 2024
> +KernelVersion:	6.10
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Set if the MCU can go in to low-power mode on system sleep
> +			* 0 - False,
> +			* 1 - True
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index ddf568ef8c5e..cf872eed0986 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1292,6 +1292,53 @@ static ssize_t nv_temp_target_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(nv_temp_target);
>  
> +/* Ally MCU Powersave ********************************************************/
> +static ssize_t mcu_powersave_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int result;
> +
> +	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
> +	if (result < 0)
> +		return result;
> +
> +	return sysfs_emit(buf, "%d\n", result);
> +}
> +
> +static ssize_t mcu_powersave_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int result, err;
> +	u32 enable;
> +
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	result = kstrtou32(buf, 10, &enable);
> +	if (result)
> +		return result;
> +
> +	if (enable > 1)
> +		return -EINVAL;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, enable, &result);
> +	if (err) {
> +		pr_warn("Failed to set MCU powersave: %d\n", err);
> +		return err;
> +	}
> +
> +	if (result > 1) {
> +		pr_warn("Failed to set MCU powersave (result): 0x%x\n", result);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "mcu_powersave");
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(mcu_powersave);
> +
>  /* Battery ********************************************************************/
>  
>  /* The battery maximum charging percentage */
> @@ -4299,6 +4346,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_ppt_platform_sppt.attr,
>  	&dev_attr_nv_dynamic_boost.attr,
>  	&dev_attr_nv_temp_target.attr,
> +	&dev_attr_mcu_powersave.attr,
>  	&dev_attr_boot_sound.attr,
>  	&dev_attr_panel_od.attr,
>  	&dev_attr_mini_led_mode.attr,
> @@ -4352,6 +4400,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		devid = ASUS_WMI_DEVID_NV_DYN_BOOST;
>  	else if (attr == &dev_attr_nv_temp_target.attr)
>  		devid = ASUS_WMI_DEVID_NV_THERM_TARGET;
> +	else if (attr == &dev_attr_mcu_powersave.attr)
> +		devid = ASUS_WMI_DEVID_MCU_POWERSAVE;
>  	else if (attr == &dev_attr_boot_sound.attr)
>  		devid = ASUS_WMI_DEVID_BOOT_SOUND;
>  	else if (attr == &dev_attr_panel_od.attr)
> 

