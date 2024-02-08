Return-Path: <linux-kernel+bounces-57931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229AE84DF26
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0561F2408A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517EE76036;
	Thu,  8 Feb 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flsOwRyY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7596EB51;
	Thu,  8 Feb 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389907; cv=none; b=T4DyHXRMcq4el/cq8k8Nwry0yjkJDpbtkkmtn/yWUGBPpcePHzBMBh9TdOUFRI+wWXmQR6M3WlDVsbnV147NxllNzs0WMcaCTApDaarJDDuC+AErPYXyIE6Ps7kkZFuOkadD0T8UaWTUdvvjYJaiiLcg8JG0fRAAEICdEhLljnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389907; c=relaxed/simple;
	bh=xyJfYGCSiVKGrJj1ToV7IaivTMqr5ZhtnLh/JsVg/cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkSmQBrtGf1EuhBSgZ604y4Sw9JNpX98VhAWmGhAaDznsLH+mMeN1OQGeYlERWiu9akwgpquWsiiYvGAuGf+RS5WyyqZyIdL4I+K/xhHLG8djSg8+ICDCKsJtZ8ZCiZmZvqHFWqnUGbh8dQz27TkbtqcKQaQWcLCYOmrUvGxzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flsOwRyY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707389906; x=1738925906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xyJfYGCSiVKGrJj1ToV7IaivTMqr5ZhtnLh/JsVg/cc=;
  b=flsOwRyYDpirE6g6hLoKkYxXSLdhNSkGSp+2HDTEYnWmIkQaiejktc17
   XSQtsaDYpTQi6D0mZGt88yk9CyysR6ANgcYUp2QdCDeOjQkjEM9KvvupQ
   kUPQowXDGues9Ig8PvfazsmFf370rEFHG+CNGWMS/VUM9OR5dzxuka4Ap
   xf1spu1x6sOAUXhASfgFX4lYSNGFFr4lOGjSJKwet32spCGoWS4LxVJP0
   nP/B+09s6RJMHwMRCLIk/UvcKDH4YRQntWXrw4h3XUgnHzFxbhga/oDj1
   VO0wSCCbpSaeXU8w70M76kZzA99co8OIKcqrqHP7mYTqx1J8VQ+NMzoVe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12559955"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="12559955"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 02:58:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="934097757"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="934097757"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 02:58:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY26m-00000002rBu-2pTz;
	Thu, 08 Feb 2024 12:58:20 +0200
Date: Thu, 8 Feb 2024 12:58:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jesus Gonzalez <jesusmgh@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Add 10EC5280 to bmi160_i2c ACPI IDs to allow
 binding on some devices
Message-ID: <ZcSzzCuNQLBcWo28@smile.fi.intel.com>
References: <ZcOLql2RGmPP10EY@smile.fi.intel.com>
 <20240207195549.37994-2-jesusmgh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207195549.37994-2-jesusmgh@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 07, 2024 at 08:55:50PM +0100, Jesus Gonzalez wrote:
> "10EC5280" is used by several manufacturers like Lenovo, GPD, or AYA (and
> probably others) in their ACPI table as the ID for the bmi160 IMU. This
> means the bmi160_i2c driver won't bind to it, and the IMU is unavailable
> to the user. Manufacturers have been approached on several occasions to
> try getting a BIOS with a fixed ID, mostly without actual positive
> results, and since affected devices are already a few years old, this is
> not expected to change. This patch enables using the bmi160_i2c driver for
> the bmi160 IMU on these devices.
> 
> Here is the relevant extract from the DSDT of a GPD Win Max 2 (AMD 6800U
> model) with the latest firmware 1.05 installed. GPD sees this as WONTFIX
> with the argument of the device working with the Windows drivers.
> 
> 	Device (BMA2)
> 	{
> 	    Name (_ADR, Zero)  // _ADR: Address
> 	    Name (_HID, "10EC5280")  // _HID: Hardware ID
> 	    Name (_CID, "10EC5280")  // _CID: Compatible ID
> 	    Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
> 	    Name (_UID, One)  // _UID: Unique ID
> 	    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> 	    {
> 		Name (RBUF, ResourceTemplate ()
> 		{
> 		    I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
> 		        AddressingMode7Bit, "\\_SB.I2CC",
> 		        0x00, ResourceConsumer, , Exclusive,
> 		        )
> 		})
> 		Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
> 	    }
> 	    
> 	    ...
> 	    
> 	}

(It's your responsibility to carry on the tags you got in case you send a new
 version. But for the sake of constructive feedback I'll give it once more this
 time, so no need to send a new version.)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Jesus Gonzalez <jesusmgh@gmail.com>
> ---
> v4: Moved comment back to relevant position inside function
> 
>  drivers/iio/imu/bmi160/bmi160_i2c.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
> index 81652c08e644..a081305254db 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -43,6 +43,15 @@ static const struct i2c_device_id bmi160_i2c_id[] = {
>  MODULE_DEVICE_TABLE(i2c, bmi160_i2c_id);
>  
>  static const struct acpi_device_id bmi160_acpi_match[] = {
> +	/*
> +	 * FIRMWARE BUG WORKAROUND
> +	 * Some manufacturers like GPD, Lenovo or Aya used the incorrect
> +	 * ID "10EC5280" for bmi160 in their DSDT. A fixed firmware is not
> +	 * available as of Feb 2024 after trying to work with OEMs, and
> +	 * this is not expected to change anymore since at least some of
> +	 * the affected devices are from 2021/2022.
> +	 */
> +	{"10EC5280", 0},
>  	{"BMI0160", 0},
>  	{ },
>  };
> -- 
> 2.43.0
> 

-- 
With Best Regards,
Andy Shevchenko



