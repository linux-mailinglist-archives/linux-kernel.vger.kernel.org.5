Return-Path: <linux-kernel+bounces-128712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F898895E82
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA611C239C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FCA15E5AE;
	Tue,  2 Apr 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="byPwPJ/y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426082BB1C;
	Tue,  2 Apr 2024 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092616; cv=none; b=DdzxOsF8oltcJD0EX//xgaagKG6J8YQeqeLrCUe0FptD1lKCXG7K97q6EZ3eETJAVKfN5A7nUS4iiHGQ7IUkka+zm6XPu5E5MK1yeUGr8cip/TMDL5O+GJ3xS3spNlxqkiyeWF/i/a5rGqeq2MuhzdAc1EU1DqCdyzX/rxiNJB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092616; c=relaxed/simple;
	bh=n0g+HFTvg6R2j0eJo5aeBjjSuqIYJzZJTM2z9GzeP6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhmzyRTav6sGwh9MkiNbCNIAJobeKBHt52g1dfdHk9jhQMOTVNInXFk0+HiFiLWwRhjolGes8YVY7fTTMR3ReHFcFO+jeEBkpK1okg+sxxfJuQXItmYe7CmGDRVhUtie1iFIcw4j/jn39jpj2oycpwQ2klFX6iyTPiXK2xpQRhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=byPwPJ/y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712092615; x=1743628615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n0g+HFTvg6R2j0eJo5aeBjjSuqIYJzZJTM2z9GzeP6c=;
  b=byPwPJ/ywjY+qPYd1CVpFkmszyBj2RPZp2QMYmyV45LHc3e7jGGv41/6
   WO5L4S732xRv8h3x0gd2+g1WcAzeZgoec9K96fzKPaX/qZzZSTPQUGAcA
   A+yv9z3H3xUUwaZFGvg61jYrcmLDNFiU9l5Tr1BB27XaxxBIoMpGrpdVk
   q3NdAJmtPhnCqlpIED6pi12mCX7dTBHsJONqaY69ThTpgsvoQdf2+ybb+
   Hs6WUUQm7lZRTiaZjHMM9bQRAgI9qq2yRW6Pg32NcqQNjcQenVQMV8qma
   Wjf5iXebvhhFH8CoFee6jnUygIIBYrWh0cAB6BWljetU/itxD7VlzqVuM
   g==;
X-CSE-ConnectionGUID: 0F2N/vh9QIamDkimOWOe/A==
X-CSE-MsgGUID: sTfQrdatSZyPDbixui23VA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="11114923"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="11114923"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:16:54 -0700
X-CSE-ConnectionGUID: NMxS1w7KQo+itrjF8mS3SA==
X-CSE-MsgGUID: w0PIozrkRwSujnr5LbGWXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18654217"
Received: from ooginni-mobl.amr.corp.intel.com (HELO [10.209.114.45]) ([10.209.114.45])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:16:54 -0700
Message-ID: <6a401cbb-efd0-475f-bc43-81041e908698@linux.intel.com>
Date: Tue, 2 Apr 2024 14:16:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] platform/x86: xiaomi-wmi: Drop unnecessary NULL
 checks
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402143059.8456-1-W_Armin@gmx.de>
 <20240402143059.8456-3-W_Armin@gmx.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240402143059.8456-3-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/2/24 7:30 AM, Armin Wolf wrote:
> The WMI driver core already makes sure that:
>
> - a valid WMI device is passed to each callback
> - the notify() callback runs after the probe() callback succeeds
>
> Remove the unnecessary NULL checks.
>
> Compile-tested only.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---

LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/xiaomi-wmi.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
> index 7efbdc111803..cbed29ca502a 100644
> --- a/drivers/platform/x86/xiaomi-wmi.c
> +++ b/drivers/platform/x86/xiaomi-wmi.c
> @@ -38,7 +38,7 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>  	struct xiaomi_wmi *data;
>  	int ret;
>
> -	if (wdev == NULL || context == NULL)
> +	if (!context)
>  		return -EINVAL;
>
>  	data = devm_kzalloc(&wdev->dev, sizeof(struct xiaomi_wmi), GFP_KERNEL);
> @@ -66,14 +66,7 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, const void *context)
>
>  static void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
>  {
> -	struct xiaomi_wmi *data;
> -
> -	if (wdev == NULL)
> -		return;
> -
> -	data = dev_get_drvdata(&wdev->dev);
> -	if (data == NULL)
> -		return;
> +	struct xiaomi_wmi *data = dev_get_drvdata(&wdev->dev);
>
>  	mutex_lock(&data->key_lock);
>  	input_report_key(data->input_dev, data->key_code, 1);
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


