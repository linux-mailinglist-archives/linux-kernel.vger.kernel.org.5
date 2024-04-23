Return-Path: <linux-kernel+bounces-155112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5348AE56B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50802877F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C0013DDA5;
	Tue, 23 Apr 2024 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holoscopio.com header.i=@holoscopio.com header.b="IziF5mDW"
Received: from grilo.cascardo.info (trem.minaslivre.org [195.201.110.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41D55E45;
	Tue, 23 Apr 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.110.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873438; cv=none; b=fp9nRLeMAoBf5OzGVfBCO106bBBrEnIktxaINGmqs8kfnMSs5PO3icDZyir/ewzoofMRk0f8YfM9O4MBKVvYpTktemmQVy8ncBOXRmFEbXzChpYmdVahNAHqlhJC6SO2CxXBbjBiPQc4QzSAnqCNVAdovpohTBvHzdBX0Fn0RWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873438; c=relaxed/simple;
	bh=+3iRm5LFaZ/p2lS8pIZ6CpMc/upaxEiYwOwlpYvaI8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEJarpS6p/uH5j5vn2NxXsmb6hM77YdfLInXw5XNuSQphykWSkPeTsEiJlf/LS3oICXZeYfOPuKw0YEcWr8xvZOqGsQTSc8q4AVBfp1mJ/uYyYKOqiiLr3zkbfRvZKWQ6srmM1itaVDQR2LjTU8MxKBpqlj7/Dx72A4FW8Np5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holoscopio.com; spf=pass smtp.mailfrom=holoscopio.com; dkim=pass (2048-bit key) header.d=holoscopio.com header.i=@holoscopio.com header.b=IziF5mDW; arc=none smtp.client-ip=195.201.110.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holoscopio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holoscopio.com
Received: from siri.cascardo.eti.br (179-125-71-233-dinamico.pombonet.net.br [179.125.71.233])
	by grilo.cascardo.info (Postfix) with ESMTPSA id 74112206F1F;
	Tue, 23 Apr 2024 08:49:55 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=holoscopio.com;
	s=mail; t=1713872997;
	bh=+3iRm5LFaZ/p2lS8pIZ6CpMc/upaxEiYwOwlpYvaI8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IziF5mDWpryRcDJHxRtLpFQFQb+m3k6LRiD/zWmEc9V13qlFJtvZ7OKDs5Z8TNhw4
	 nJgvTMTRVLfaG37R4L5h1Tac+pvz0yOLH9oRejzSaz9++QwOK4xMyoPS4EmHqFDD3v
	 m1VTv4fabUBrROCXQmBqJeTrpJojRhdgC7gFYk3qH5jW8KElFMGaxpc5Rmu/nxavpf
	 rUEIFVOjjMDRAud9UHel/OtZoFOS024SvWT6YG8/NuuiAcrAybT2ufT0H+qhnuuoTL
	 CJTToRq7w7m8PffxAjH9Q+ggd6dAU2/Kz66gLwThC7KEs3w9+VI6zj62Za/EVGajfQ
	 00sa1aXjbW12g==
Date: Tue, 23 Apr 2024 08:49:51 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: classmate-laptop: Add missing
 MODULE_DESCRIPTION()
Message-ID: <ZiegXwf0zK_cIhdR@siri.cascardo.eti.br>
References: <20240422151238.2051330-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422151238.2051330-1-andriy.shevchenko@linux.intel.com>

On Mon, Apr 22, 2024 at 06:12:38PM +0300, Andy Shevchenko wrote:
> The modpost script is not happy
> 
>   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/x86/classmate-laptop.o
> 
> because there is a missing module description.
> 
> Add it to the module.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/classmate-laptop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
> index 87462e7c6219..fb208c68a7eb 100644
> --- a/drivers/platform/x86/classmate-laptop.c
> +++ b/drivers/platform/x86/classmate-laptop.c
> @@ -13,8 +13,6 @@
>  #include <linux/input.h>
>  #include <linux/rfkill.h>
>  
> -MODULE_LICENSE("GPL");
> -
>  struct cmpc_accel {
>  	int sensitivity;
>  	int g_select;
> @@ -1139,3 +1137,5 @@ static const struct acpi_device_id cmpc_device_ids[] __maybe_unused = {
>  };
>  
>  MODULE_DEVICE_TABLE(acpi, cmpc_device_ids);
> +MODULE_DESCRIPTION("Support for Classmate PC ACPI devices");

How about "Support for Intel Classmate PC ACPI devices", like the
Kconfig devices?

Cascardo.

> +MODULE_LICENSE("GPL");
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

