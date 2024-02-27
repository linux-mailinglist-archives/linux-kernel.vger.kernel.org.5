Return-Path: <linux-kernel+bounces-84113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B172886A240
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C5A1C21158
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1D153BED;
	Tue, 27 Feb 2024 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GSoLZex2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE58F145356;
	Tue, 27 Feb 2024 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072024; cv=none; b=Ho3w544ycquccXHUZcrPcnnG3C16V2fcxzcWTfrN1w8sVHJvzI+wjxtr1zmD2vJwPcEXI941JNaP3p+nLc6vJu2GTq9Rk3d0oYddBBxNukdmcXLp4qkk9wrGL1tN1bDD3ZZhIyKjOen5LmATxfUIbaWE0F5WxaOMBrD/w98O5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072024; c=relaxed/simple;
	bh=j8LfYVouX4k2vRN1QgUanbEePwX2K7J8uWDxmEyKdDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtetK+1/2qQ7n6YBXeMOKeEe77lBSaUsJBEjMFBhnP0dxCbsqarSrPof1KUpcLlSHokHQiFaNUiJ9orSCDzhGBC2LvaPTpNzRwYTFm64vhtIiNlHD9QMEYTMT5w3aL/PZqNSHipcHpRkeoOjWqfUKFa2qUJJPLEevGc7dPbztdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GSoLZex2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=b36HH6QrFanQlF+vf1qyLlG8Z5HxvOBibGB+wGgOjjs=; b=GSoLZex2HDFRN7EDrII+1mE3V+
	RkVBl6Tg0shOEdj1c9ObrYHrjQ9lNw5a7mS3CUD4GoRUvuwvIEvGZFYeWQ/sW7b3vsST/5/07LFy0
	lictBUnSgvVHCoALi0B0AbnD276ZqAXcv+3OUtAKYvSBG2H+Z0QO9l/VLjuS5nD456DL8lR7T3bnV
	NZknCRgPuZ1JCXM+OAXi/+kIjZ1kPegu0rbeAhDogdWxS2oCPeL4bsYEQ4rF9CzQ7jEade0pzFCYI
	aMmNGcYPFfLj9U7TRlb+S21mWEetprmn7gzbjAjfeOej/BQtbjUYQoXAuiTqb4kt1b5tqEvRePMIY
	+R+tDEVg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf5hf-000000072QM-0soH;
	Tue, 27 Feb 2024 22:13:35 +0000
Message-ID: <9c00ac32-020e-4fc4-9ca3-df4ca77033f7@infradead.org>
Date: Tue, 27 Feb 2024 14:13:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] auxdisplay: Add 7 segment LED display driver
Content-Language: en-US
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, andy@kernel.org,
 geert@linux-m68k.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, ojeda@kernel.org, tzimmermann@suse.de,
 javierm@redhat.com, robin@protonic.nl, lee@kernel.org, pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-2-chris.packham@alliedtelesis.co.nz>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240227212244.262710-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 2/27/24 13:22, Chris Packham wrote:
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index d4be0a3695ce..52a245ca0c8d 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -211,6 +211,16 @@ config ARM_CHARLCD
>  	  line and the Linux version on the second line, but that's
>  	  still useful.
>  
> +config SEG_LED
> +	tristate "Generic 7 segment LED display"

	                  7-segment

> +	select LINEDISP
> +	help
> +	  This driver supports a generic 7 segment LED display made up

	                                 7-segment

> +	  of GPIO pins connected to the individual segments.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called seg-led.

-- 
#Randy

