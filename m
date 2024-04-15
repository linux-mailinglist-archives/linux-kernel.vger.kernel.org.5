Return-Path: <linux-kernel+bounces-144654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C9B8A48D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8464F1C22E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D37820DD3;
	Mon, 15 Apr 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GC+1MnKd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8958425601;
	Mon, 15 Apr 2024 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165528; cv=none; b=VGK8hhr/3gP2B6wdbySw+1An7N/NOsyA5Gp9MEUYIT/KBczxZ4bzDrrH52mjtPtoe6PoObYaZESYKungWul/vlQQ04CWqeA4ce0PRbmbGazkc9Qwps5jcU8qc28CBwIXzzg4YQGRpO+DLAOwc6IqwbfrbfYT2iEOBk8loYFU0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165528; c=relaxed/simple;
	bh=Ssi6F4ZX0iTPC1l/WPuJiSQSky5k3PTTtoixP0BwMMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOopsnulD66YScj4Lmg6HlVDuRXGT014eaTWatsraluML2XLhGca8gsvqbMO3FuV3vNYkys1pivODurQ7oT8fyW4BtL9IcxF/4HdzrNmzaJeyKaE5V2Y5HO1bNrlBPXj/5IKJpzHyTGYwSVU8HEAnew5GR1fZ/lqQPyS4r2irUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GC+1MnKd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713165527; x=1744701527;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ssi6F4ZX0iTPC1l/WPuJiSQSky5k3PTTtoixP0BwMMk=;
  b=GC+1MnKdZxawE6aSrg4tiHQqfsPh4HDZX0mY0rCx8KTFebWAmM0DdF2F
   J2Ah2hclbcZO35Dn5mBMgxxUdGg7lgYD+TBfk5IGy1dUu8T1xvt0aIQHg
   5ZLNDsQD1j1z6dqyECxSe8AuS+Doc9H6DZeTumAdAYfN2G+MisK56CR+W
   YWw9PoXyJobYfg3xHpO+KiS7YMJih7sRtXSr8nvcuarKn9JkiBfwrvSW3
   RMbWZEbdIALfdl4cGwI2DC6FiZ6rCnW/kfeMg/NkWdMtKWPaq5S8fBJ5E
   ea4o1zfeKujLTC8x3AyQ+iRWPgczUWyM1RpvEEsMc0u21q27MeS4JVda9
   Q==;
X-CSE-ConnectionGUID: 4zny9S4nTIuA6o2wIHd2aA==
X-CSE-MsgGUID: 4OAEl765RnitY2RDxJYQ5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8405726"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8405726"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:18:47 -0700
X-CSE-ConnectionGUID: RaB/amVCSfG4wFo3U11lnw==
X-CSE-MsgGUID: cYNrgRcpS/CpewXNIUB+hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="22399432"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.19])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:18:44 -0700
Message-ID: <52c08a01-8357-44dd-b727-a06438ec6c30@intel.com>
Date: Mon, 15 Apr 2024 10:18:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sdhci: Fix SD card detection issue
To: Richard Clark <richard.xnu.clark@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240415070620.133143-1-richard.xnu.clark@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240415070620.133143-1-richard.xnu.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/24 10:06, Richard Clark wrote:
> The mmc_gpio_get_cd(...) will return 0 called from sdhci_get_cd(...), which means
> the card is not present. Actually, the card detection pin is active low by default
> according to the SDHCI psec, thus the card detection result is not correct, more

SDHCI spec covers the SDHCI lines.  GPIO is separate.

> specificly below if condition is true in mmc_rescan(...):
> 	...
> 	if (mmc_card_is_removable(host) && host->ops->get_cd &&
> 		host->ops->get_cd(host) == 0) {
> 		...
> 		goto out;
> 	}
> The SD card device will have no chance to be created.
> 
> This commit fixes this detection issue via the MMC_CAP2_CD_ACTIVE_HIGH cap2 flag,
> parsed from the 'cd-inverted' property of DT.

What hardware / driver is it?

> 
> Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c79f73459915..79f33a161ca8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2483,6 +2483,9 @@ static int sdhci_get_cd(struct mmc_host *mmc)
>  	 * Try slot gpio detect, if defined it take precedence
>  	 * over build in controller functionality
>  	 */
> +	if (!(mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH))
> +		gpio_cd = !gpio_cd;

MMC_CAP2_CD_ACTIVE_HIGH is already handled in 
mmc_gpiod_request_cd(), and this turns an error (gpio_cd < 0)
into 0, which is not right.

> +
>  	if (gpio_cd >= 0)
>  		return !!gpio_cd;
>  


