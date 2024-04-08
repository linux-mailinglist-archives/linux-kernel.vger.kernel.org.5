Return-Path: <linux-kernel+bounces-135622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250D289C8B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEFDB23816
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5A1420D8;
	Mon,  8 Apr 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHxhKh0z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7E24B4A;
	Mon,  8 Apr 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591339; cv=none; b=ddK+070MhuFz7TnkFSnyHVawm5ZRaTqLILYariFVBXtQGc4pfAsdrEtP2hcOQ6rD2nSQqsV8klU6V4uX2iX2k3ed+W40sUI4uvVMqPRzFnTStTXxpxKrrDPTn5NKSExGEdfPiQWYhGi6bziJoWuIgKMJVcqhSbfXZ8B1EIgfrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591339; c=relaxed/simple;
	bh=dlrWxy8aJzTsV8Kbg8Ki+bRRBgvk5NN8dk84yVKvFEM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LyHnNLBbeeONm8yUC2Wgunk2Q/7Qpz2lUK308V2X8A543mklazeFTtlnOFEv/ixjDui+Rcs9cuoIH+0OSOQfpAg0y1/8vyvn+rk41/4fkhB53vFRKhRkKbE2wmCTLpE7sQdmc5kDEFfIO1PN/SlQr7cQPvn4vmuHxqB1HguqgWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHxhKh0z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712591338; x=1744127338;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dlrWxy8aJzTsV8Kbg8Ki+bRRBgvk5NN8dk84yVKvFEM=;
  b=MHxhKh0zm1Ct93u78IGekqLoklszzT9SeR2Bw81mLCacwpsmUaa2pUNk
   qwzRqI15g6cbDRWyoPsLDFjJZpaDrIpRSgEYDMheK9wazVAmomDVEUmPB
   g6CWuC1kVk8vgSeGyrk5/mbxj6eL3hwCXQSoj4CVzTOxy6SyRB9AkrNGn
   2Y4Yourd/wCgKXs2U9JhwUfUKo3yAPliNmsyIKa/ehFfLuHUlCUqvjW0J
   0CwRGiykpfXs4gODcpJUrK3oJKIXxCmOlw6sRRb5vOsnH78gY567FVLYM
   UV4hcgcidB+V1F/3AAgq/5j5eC51Pfj/9MtSWDmlnHp8OhHsvdl84Fi2k
   g==;
X-CSE-ConnectionGUID: 8OAKcLehRd+lYPzh8Cx06Q==
X-CSE-MsgGUID: IeSv79j2T0avpiuiExMFdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7784184"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7784184"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:48:57 -0700
X-CSE-ConnectionGUID: DlHRz7zkT1yaH6fwH1SsAg==
X-CSE-MsgGUID: SjTrHBcKSoSpKirqcqtjmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="51103101"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:48:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Apr 2024 18:48:50 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
    linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] ACPI: fan: Add hwmon support
In-Reply-To: <20240408123718.15512-1-W_Armin@gmx.de>
Message-ID: <63187b48-7978-3b0f-0526-79afea65c492@linux.intel.com>
References: <20240408123718.15512-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Apr 2024, Armin Wolf wrote:

> Currently, the driver does only supports a custom sysfs
> interface to allow userspace to read the fan speed.
> Add support for the standard hwmon interface so users
> can read the fan speed with standard tools like "sensors".
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/Makefile    |  1 +
>  drivers/acpi/fan.h       |  2 ++
>  drivers/acpi/fan_core.c  |  7 ++++
>  drivers/acpi/fan_hwmon.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+)
>  create mode 100644 drivers/acpi/fan_hwmon.c
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d69d5444acdb..9a2e03acc1be 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+= tiny-power-button.o
>  obj-$(CONFIG_ACPI_FAN)		+= fan.o
>  fan-objs			:= fan_core.o
>  fan-objs			+= fan_attr.o
> +fan-objs			+= fan_hwmon.o
> 
>  obj-$(CONFIG_ACPI_VIDEO)	+= video.o
>  obj-$(CONFIG_ACPI_TAD)		+= acpi_tad.o
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index e7b4b4e4a55e..45c2637566da 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -56,4 +56,6 @@ struct acpi_fan {
>  int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst);
>  int acpi_fan_create_attributes(struct acpi_device *device);
>  void acpi_fan_delete_attributes(struct acpi_device *device);
> +
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
>  #endif
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index ff72e4ef8738..6bbdbb914e95 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -7,6 +7,7 @@
>   *  Copyright (C) 2022 Intel Corporation. All rights reserved.
>   */
> 
> +#include <linux/kconfig.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -336,6 +337,12 @@ static int acpi_fan_probe(struct platform_device *pdev)
>  		if (result)
>  			return result;
> 
> +		if (IS_REACHABLE(CONFIG_HWMON)) {
> +			result = devm_acpi_fan_create_hwmon(device);
> +			if (result)
> +				return result;
> +		}
> +
>  		result = acpi_fan_create_attributes(device);
>  		if (result)
>  			return result;
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> new file mode 100644
> index 000000000000..4f2bec8664f4
> --- /dev/null
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * fan_hwmon.c - hwmon interface for the ACPI Fan driver
> + *
> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/hwmon.h>
> +#include <linux/limits.h>
> +
> +#include "fan.h"
> +
> +static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
> +				   int channel)
> +{
> +	return 0444;
> +}
> +
> +static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
> +			 long *val)
> +{
> +	struct acpi_device *adev = dev_get_drvdata(dev);
> +	struct acpi_fan_fst fst;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		ret = acpi_fan_get_fst(adev, &fst);
> +		if (ret < 0)
> +			return ret;
> +
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			if (fst.speed > LONG_MAX)
> +				return -EOVERFLOW;
> +
> +			*val = fst.speed;
> +			return 0;
> +		case hwmon_fan_fault:
> +			*val = (fst.speed == U32_MAX);
> +			return 0;

Is it okay to return 0 in this case?

> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops acpi_fan_ops = {
> +	.is_visible = acpi_fan_is_visible,
> +	.read = acpi_fan_read,
> +};
> +
> +static const struct hwmon_channel_info * const acpi_fan_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_FAULT),

One line.

-- 
 i.


> +	NULL
> +};
> +
> +static const struct hwmon_chip_info acpi_fan_chip_info = {
> +	.ops = &acpi_fan_ops,
> +	.info = acpi_fan_info,
> +};
> +
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
> +{
> +	struct device *hdev;
> +
> +	hdev = devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", device,
> +						    &acpi_fan_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hdev);
> +}
> --
> 2.39.2
> 
> 

