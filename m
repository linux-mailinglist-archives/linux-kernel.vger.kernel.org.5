Return-Path: <linux-kernel+bounces-142230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1183A8A293A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C091C2816B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E095029B;
	Fri, 12 Apr 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dPKmMVyY"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE24F20A;
	Fri, 12 Apr 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910203; cv=none; b=GhxvpcDf2QUkVCTVjOFF1/ZcKRWBnrcBGCrldv3i4kNYC42pIwZKc0yKAibHXMzZDIcvq9QmRe8BbEBIyQoOEmEit5BKmudIc1XWGFJbXOs0eIfOJG1g0Q0E/bPNTxTFy2dtUszf62xO+4dtqFjp/tC4v1lA0aF2YBQgdClbtag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910203; c=relaxed/simple;
	bh=JQsL3l+lpII2c4u6mU33BzB6l2saKrxBERfMXjR3I+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3/tyilW26dAY1GoNzD8HwtCm5F44u+LrbrjOaEbqjrupdBfZHctsXQZHAxKyJBb2F/NOooTgpRDehaMUPIuZYCl3zR9xVaFWrzvFnxIiHWztkOFwJcEHVCm6z+d6IJfMDVYfZikhqvtohlo3c0i9HNYb6klvSVTRBqbmMkjAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dPKmMVyY; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9AB23240002;
	Fri, 12 Apr 2024 08:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712910199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WClP5G2kcne2eneGfMBtJOI0aNW9KDauYWuKR9jT1z4=;
	b=dPKmMVyYATklsYzaKp5rf8tkpd+f8IfUhBwqPg7KpvV0hJVLgglFurhnD9lDD9pp5jb2BJ
	EVpvAgSIhTCZuuB1OvUya3PUnL3Of0JjnBLw65HaPawxCiA9cFsr4TQgKpho7BDCght/0X
	IgyV6JqdpIEKwTiwHRc0jwxsfMpPJAVf/Uq21A5FbA8F5X41Qcm1pCLfK0YQh9Cpvy4GY8
	e9HY7QaJhLZloTZ8GX+53+ZiuS11njbK9QqEATLSLYyPH60o3RVKD20bvNiyoCJlNWVFqx
	aLwOgDa0jeU9IHB/ezZs02Ex1epHDZbeGhMeAqpFfCcm6iPgLyTTWWa0ckt1zA==
Date: Fri, 12 Apr 2024 10:23:15 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: wefu@redhat.com
Cc: jszhang@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, guoren@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/5] drivers/rtc/rtc-xgene: Add prescaler support in APM
 X-Gene RTC driver
Message-ID: <20240412082315682039eb@mail.local>
References: <20240412080238.134191-1-wefu@redhat.com>
 <20240412080238.134191-2-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412080238.134191-2-wefu@redhat.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 12/04/2024 16:01:43+0800, wefu@redhat.com wrote:
> From: Wei Fu <wefu@redhat.com>
> 
> This patch add Counter Prescaler support in APM X-Gene RTC driver by
> getting prescaler (Optional) property value from dtb.
> 
> Signed-off-by: Wei Fu <wefu@redhat.com>
> ---
>  drivers/rtc/Kconfig     | 10 ++++++++++
>  drivers/rtc/rtc-xgene.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index c63e32d012f2..3a89f1e6095d 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1888,6 +1888,16 @@ config RTC_DRV_XGENE
>  	  This driver can also be built as a module, if so, the module
>  	  will be called "rtc-xgene".
>  
> +config RTC_DRV_XGENE_PRESCALER
> +	bool "Pre-scaler Counter support for APM X-Gene RTC driver"
> +	depends on RTC_DRV_XGENE
> +	depends on ARCH_THEAD
> +	default y
> +	help
> +	  Say Y here if your Soc has Pre-scaler Counter support on rtc-xgene.
> +
> +	  This hardware support can only be found in DW_apb_rtc after v2.06a.
> +

I don't feel like this needs a config option, rather you should have a
proper compatible string that will tell the driver whether the feature
is available.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

