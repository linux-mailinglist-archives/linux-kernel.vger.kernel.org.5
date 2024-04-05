Return-Path: <linux-kernel+bounces-133360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056FF89A2D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621B1285040
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200F8171662;
	Fri,  5 Apr 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMQ2If/S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865651D530;
	Fri,  5 Apr 2024 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335604; cv=none; b=G6J59Vj1orSQkAmk4zwcuad1vV5C3n86nQxid7b4EdcnPwBvteeQjm2uT3ax63gKVipO/UL6PL1tcbzmwpM7al2ygUQZZEFowb1S9V4X9eLKEqy3LoQ/5Dvqc+qX91P999k++NVRpvyv7qIO3d+dr/OKbYSVQdzn/MJMLtafQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335604; c=relaxed/simple;
	bh=DxzqwTFUD4Mv1j19NTjgo+XFNfXl/Rg/xD/MZTnQQMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mf6470K/HfwADoHNoT4Cknt61XisowSmgMR9C/VsmlN9DzCYtAQXOKwLv7Z3s3NpCMo+NqicFpV/zTVNbmiY8m1WEhUIerSqujbDfeeSqrxobRdou4GGL0HhiqYHHPRijqeGhFnbM67hes1LkZx3MNHNJInO4xs4vjtks0E70Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMQ2If/S; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712335603; x=1743871603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DxzqwTFUD4Mv1j19NTjgo+XFNfXl/Rg/xD/MZTnQQMY=;
  b=OMQ2If/Sa8Ir+lhVuPievJfpNyeZuk2xpqX/aTFkRPYe2MKkMB3vPkR7
   whhQsNFdyJUshB3j1VElVocMvUXgNOEnHfRcWaFJ3FYOB8jY7/ys63mns
   Zq6lA8pDPOjiWFI/o+219R3IAk1i7xaKnR1pO/kibgPW6AmScNL3Gwd2d
   wAly2sQ/IOsdaJ3VZn5Fs67MZOW1YCp1KaahH1VCERaukepM2VqSxRcnP
   AJdbJh6KbXR5aLIft80c8bddOzdGySOtiG4SDbs3tN5Fkc8TeT3kxEPCg
   YUqGd+GhJZad1akZt3nMIAArOAtj55OtUNMXg6BF2m4kYK1yxkpbQOgSe
   A==;
X-CSE-ConnectionGUID: jhoaMKsUTQqw5M1B8AErlw==
X-CSE-MsgGUID: eYwe5MHRTwWf6DsEhpSB/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7537977"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7537977"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:46:41 -0700
X-CSE-ConnectionGUID: orsP5Vu6R4eJKtbFa4yiYQ==
X-CSE-MsgGUID: xjbLHS8+SH+PQi5DGs4tBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23932351"
Received: from twwright-mobl1.amr.corp.intel.com (HELO [10.209.65.212]) ([10.209.65.212])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:46:41 -0700
Message-ID: <564688b7-7d21-414d-9878-5a736777660d@linux.intel.com>
Date: Fri, 5 Apr 2024 09:46:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] gpio: wcove: Use -ENOTSUPP consistently
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Cristian Marussi <cristian.marussi@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>, peng.fan@oss.nxp.com
References: <20240405162521.3774111-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240405162521.3774111-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/5/24 9:25 AM, Andy Shevchenko wrote:
> The GPIO library expects the drivers to return -ENOTSUPP in some
> cases and not using analogue POSIX code. Make the driver to follow
> this.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/gpio/gpio-wcove.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
> index c18b6b47384f..94ca9d03c094 100644
> --- a/drivers/gpio/gpio-wcove.c
> +++ b/drivers/gpio/gpio-wcove.c
> @@ -104,7 +104,7 @@ static inline int to_reg(int gpio, enum ctrl_register type)
>  	unsigned int reg = type == CTRL_IN ? GPIO_IN_CTRL_BASE : GPIO_OUT_CTRL_BASE;
>  
>  	if (gpio >= WCOVE_GPIO_NUM)
> -		return -EOPNOTSUPP;
> +		return -ENOTSUPP;
>  
>  	return reg + gpio;
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


