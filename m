Return-Path: <linux-kernel+bounces-164682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637AB8B8106
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D91D28313A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192561A38C2;
	Tue, 30 Apr 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZnHqwnk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2D1A0B14;
	Tue, 30 Apr 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507366; cv=none; b=drAceS3CEzlye4pyllpTIoW5kFKn2UtAWhJi+nu/LH1zibeiyqz4ngYQjbTC3md1Tgq73kh+u6oNLMuRGElNEGbRi/VJFh9ZiN5ekyLf7hf729XF8T2a3OExnQ4vvgHdpAS7rDvgLPAUKiSSTNTt/tUVgY1Siomr/1OvIKxIHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507366; c=relaxed/simple;
	bh=z/hzkvAw4HpIHwx7QhuODABtWCOx9qSg+vkHietsgfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9ErpTPU6JfTR3Qr4Gxjm1Ex8y8mDzEixyIet6WUyX2lRBt8Z6LV/Lv9DcazEcTt0NjirBArIF6vRj1pdEozqsS8SjqN0h6jWu1OEd+lpO71nmpekp0FB9k2xI1RNxqU+E4LMlfn8MxpCVN+R5krDTS7tIkmwJ5iYba6t/un9kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZnHqwnk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714507364; x=1746043364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z/hzkvAw4HpIHwx7QhuODABtWCOx9qSg+vkHietsgfM=;
  b=IZnHqwnkBHV+Q4SMdEoJzmcMs4C3zDYGRoYNa82Ao4a/iCLXOULAVEOG
   54IeHZO3IZX2PrszRH5kHYz0SFbAPZEL7myB4o6t6/FnRNGKKWkpv9gRM
   0xY5bKv7R1t1UFZaEKmcJwGswoBx8lRUrIkhPN+pYMM7HKl9rDq3egmfT
   JqYOZVIkHyvV5pdU/U2OYlqHCbH2zLVXsVqDnoBFghrdr+Mgd5BHygQTA
   OmrI/vmwBSONSlNG7Jpe0OZcftoDv9JYfvpFErONZMjoW1jsDXMGQT3m+
   3Q3FeoNl2vJDGsmZO9lgUBLz/lJHzz/E2vhA2TruV7y8B/7385yLvAiz/
   w==;
X-CSE-ConnectionGUID: BM6GMOPoSB+xfI132i7xcA==
X-CSE-MsgGUID: xgaBIrLeRFioQTbyOzIs9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="14061793"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="14061793"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 13:02:44 -0700
X-CSE-ConnectionGUID: gGfIK8MlQ9qssAk/E+BeRQ==
X-CSE-MsgGUID: es3bxTpKR+Wmy+yzhZxljg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26987650"
Received: from ayork-mobl.amr.corp.intel.com (HELO [10.212.209.118]) ([10.212.209.118])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 13:02:42 -0700
Message-ID: <bdc5d132-8530-4e38-999c-42af446232e0@linux.intel.com>
Date: Tue, 30 Apr 2024 13:02:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: scan: Avoid enumerating devices with clearly
 invalid _STA values
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Salil Mehta
 <salil.mehta@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12427278.O9o76ZdvQC@kreacher>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <12427278.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/30/24 9:02 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The return value of _STA with the "present" bit unset and the "enabled"
> bit set is clearly invalid as per the ACPI specification, Section 6.3.7
> "_STA (Device Status)", so make the ACPI device enumeration code
> disregard devices with such _STA return values.
>
> Also, because this implies that status.enabled will only be set if
> status.present is set too, acpi_device_is_enabled() can be modified
> to simply return the value of the former.
>
> Link: https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#sta-device-status
> Link: https://lore.kernel.org/linux-acpi/88179311a503493099028c12ca37d430@huawei.com/
> Suggested-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>
> v1 -> v2:
>    * Fix a confusing comment.
>    * Add R-by from Jonathan (thank you!)
>
> ---
>  drivers/acpi/bus.c  |   11 +++++++++++
>  drivers/acpi/scan.c |    2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/acpi/bus.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/bus.c
> +++ linux-pm/drivers/acpi/bus.c
> @@ -112,6 +112,17 @@ int acpi_bus_get_status(struct acpi_devi
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> +	if (!device->status.present && device->status.enabled) {
> +		pr_info(FW_BUG "Device [%s] status [%08x]: not present and enabled\n",
> +			device->pnp.bus_id, (u32)sta);

Nit: Do you think it should be pr_warn ?

> +		device->status.enabled = 0;
> +		/*
> +		 * The status is clearly invalid, so clear the functional bit as
> +		 * well to avoid attempting to use the device.
> +		 */
> +		device->status.functional = 0;
> +	}
> +
>  	acpi_set_device_status(device, sta);
>  
>  	if (device->status.functional && !device->status.present) {
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1962,7 +1962,7 @@ bool acpi_device_is_present(const struct
>  
>  bool acpi_device_is_enabled(const struct acpi_device *adev)
>  {
> -	return adev->status.present && adev->status.enabled;
> +	return adev->status.enabled;
>  }
>  
>  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
>
>
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


