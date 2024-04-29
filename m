Return-Path: <linux-kernel+bounces-161694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E708B4FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3F61C20A99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E8F8F55;
	Mon, 29 Apr 2024 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5vBSTSx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A528479;
	Mon, 29 Apr 2024 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714360650; cv=none; b=WugXaqwiQEwHoAusv0y5fNNdpz4aCJPvPNNjQpH2YxaXgCPghDAZ5Cf0tFBh6UCUaFwJzq4Y8AjRWRiLwzRLP/nYzxT2Ytf5BRZpGttHjmqBSjy15Yf+v0sGyg4QjdXcVippq/GziQ+UVgmahcwpFl7JOqg9g+G1U4KIt74vZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714360650; c=relaxed/simple;
	bh=LpZ9V9l5qJovLac16qnAWUf3Hb3AUmwg8mQ6a+IXK74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LHmz5+dYr5sXPm66fXvNEoqu/OE7zfrwc5ATEqVJelCg3i9fBzYMcaJaKhch9ldaesg9avz4LR68vRbneGC8UoWaGh+0F5mMw8FRCGek8x9s63H4Q3i7L+g1jTf1vl2BPsa7OErIJ4zdbbNCGPCOm1s6GT9sQPAj7vb0dH3R3ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5vBSTSx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714360649; x=1745896649;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=LpZ9V9l5qJovLac16qnAWUf3Hb3AUmwg8mQ6a+IXK74=;
  b=g5vBSTSxkqnS8oh+qHrKnNj7Tnvk8pof9ypRYTBxpEf3qOee4KJu1aDH
   l38YIfNJpNeChRLm07PJ06uGvffEw1PhGFUWaLJgJjSwqx/bGpDlkoZ9/
   DXnbPJvevVR5H26BTz6cl7GEO8wSZHOwbGARO3w6vACWEWolirwqynCOZ
   WQnymrcY9v0YROAyuKQ51buYgNQrKO0ptHT/hnIQ4SnxWJcf9tfHuunMV
   EOtnTOF4+swK4Bq2qEidZfNM9mqvm2kVhyUrOgWbCQB3hVOb1c+7mhFbB
   RnEGi3voW1ZoV5PYrZ8/7JKbY+NuFisxTWlMtMkoBnoUg0w4OwnnrOmD3
   g==;
X-CSE-ConnectionGUID: mIBKOGZfRle8WQIrd4zGjw==
X-CSE-MsgGUID: AkYXZ6U/QLm3wzT13asjHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10226751"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="10226751"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 20:17:28 -0700
X-CSE-ConnectionGUID: kw3XAXG/RaymIdn1zh5qfg==
X-CSE-MsgGUID: BTu6RewSQ4WPFi7knnvEUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="56876721"
Received: from kscheema-mobl.amr.corp.intel.com (HELO [10.251.17.13]) ([10.251.17.13])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 20:17:27 -0700
Message-ID: <2e27438f-8f96-43fc-afa3-b2e34817a0fd@linux.intel.com>
Date: Sun, 28 Apr 2024 20:17:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/fujitsu-laptop: Replace sprintf() with
 sysfs_emit()
To: Szilard Fabian <szfabian@bluemarch.art>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, jwoithe@just42.net,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
References: <20240428192548.113261-1-szfabian@bluemarch.art>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240428192548.113261-1-szfabian@bluemarch.art>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/28/24 12:26 PM, Szilard Fabian wrote:
> As suggested by Documentation/filesystems/sysfs.rst sysfs_emit() should be
> used when formatting the value to be returned to user space.
>
> Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/fujitsu-laptop.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 94480af49467..968fc91bd5e4 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -386,11 +386,11 @@ static ssize_t lid_show(struct device *dev, struct device_attribute *attr,
>  	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
>  
>  	if (!(priv->flags_supported & FLAG_LID))
> -		return sprintf(buf, "unknown\n");
> +		return sysfs_emit(buf, "unknown\n");
>  	if (priv->flags_state & FLAG_LID)
> -		return sprintf(buf, "open\n");
> +		return sysfs_emit(buf, "open\n");
>  	else
> -		return sprintf(buf, "closed\n");
> +		return sysfs_emit(buf, "closed\n");
>  }
>  
>  static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
> @@ -399,11 +399,11 @@ static ssize_t dock_show(struct device *dev, struct device_attribute *attr,
>  	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
>  
>  	if (!(priv->flags_supported & FLAG_DOCK))
> -		return sprintf(buf, "unknown\n");
> +		return sysfs_emit(buf, "unknown\n");
>  	if (priv->flags_state & FLAG_DOCK)
> -		return sprintf(buf, "docked\n");
> +		return sysfs_emit(buf, "docked\n");
>  	else
> -		return sprintf(buf, "undocked\n");
> +		return sysfs_emit(buf, "undocked\n");
>  }
>  
>  static ssize_t radios_show(struct device *dev, struct device_attribute *attr,
> @@ -412,11 +412,11 @@ static ssize_t radios_show(struct device *dev, struct device_attribute *attr,
>  	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
>  
>  	if (!(priv->flags_supported & FLAG_RFKILL))
> -		return sprintf(buf, "unknown\n");
> +		return sysfs_emit(buf, "unknown\n");
>  	if (priv->flags_state & FLAG_RFKILL)
> -		return sprintf(buf, "on\n");
> +		return sysfs_emit(buf, "on\n");
>  	else
> -		return sprintf(buf, "killed\n");
> +		return sysfs_emit(buf, "killed\n");
>  }
>  
>  static DEVICE_ATTR_RO(lid);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


