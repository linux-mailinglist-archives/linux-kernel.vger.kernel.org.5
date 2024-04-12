Return-Path: <linux-kernel+bounces-142571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11E88A2D49
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9716D282227
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500A25491E;
	Fri, 12 Apr 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="EmYxHmG1"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3EB5466C;
	Fri, 12 Apr 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921009; cv=pass; b=JHdCH95QVoN70+WQQqGerZwOOz8Kslfwx8iFlPJ+lJtO2PzVsYT4huxVFEQP99GKb2c1FDZOYsk4wOHG+4NQqY+4N/eyyw1PGJ2rvG9DdEV8IDVEJNMWeZroKwVF8Js92Ln5z933pexRBZ7299jnTrm54qQszt0UAxaziYGmUHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921009; c=relaxed/simple;
	bh=bNDLBTgBlVtzwEAqwZB2tSRzSl201srYl2Fp+abq8e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7iUo9vjz2ZmSQfY9AWLMoczgVoQrET1nAULT4TDHAPNQYsakZlMWchbh+/7DhZorrJ1ZxaYjjddXVTOfijvMFIpa6Wjt/G8LBl7fQh/cYFAtLmydANQP82cyKhxmR4z7lPe+DuZ2I3nnuYPeAkmFqerrf15csqywUuO08cvUE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=EmYxHmG1; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VGDhY09vbzyRj;
	Fri, 12 Apr 2024 14:23:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712921005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03x385kIPqfHMiSvA2yl74xYiPJaVpYXdYIvYybwrKQ=;
	b=EmYxHmG1f+MvGG5061agsZ9VCaKTT3qAJE4gE70yuX7TrLY+I+sGzRZc0Pl27WdIU9BS/9
	UezyAl3n3vilC2VGlNGaQLDKfdh5VqK93miGTxThx2/ozhx2VrQx3ep2QbKWWdZIjymgHi
	fojVdCbgUHWyzndUxWsKjukSawv7jBw=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712921005; a=rsa-sha256; cv=none;
	b=RWdABRImGslwCWXrfWNgNpjdyrZCHrGvn9DWX+NPxXMeF5Q5mb8xp4M5K9JE+EiLXFNjr7
	c/h4+1zlrwmIE4HZTQhG4+Csx7+iIVly6GgZm/DbOdvP1jFKJWh98u/8BJwMKTmN69abx5
	c6IE64KO60WVTWv2HYiIgW4pFzn1A7g=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712921005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03x385kIPqfHMiSvA2yl74xYiPJaVpYXdYIvYybwrKQ=;
	b=PIbJ0w5mvTpYKg3QkQQVm7BXlQZRaKSzOJYxzwtjwFX/EioJataKu2txsoEvQAnhbuItMK
	B/3TFvrSVtM4LLJVwbMzPZ9vHQ+8NxZDshAumawmPjudSNcut6kluEHeKAIY9TFUUKrHl7
	+DpzhTrLGMfPqjO0GWE8iNfncrNF5mU=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 074BB634C97;
	Fri, 12 Apr 2024 14:23:20 +0300 (EEST)
Date: Fri, 12 Apr 2024 11:23:19 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 3/4] media: i2c: add MAX96717 driver
Message-ID: <ZhkZp9KKrRy7smLn@valkosipuli.retiisi.eu>
References: <20240325131634.165361-1-julien.massot@collabora.com>
 <20240325131634.165361-4-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325131634.165361-4-julien.massot@collabora.com>

Hi Julien,

Thanks for the update.

Could you also cc me to the possible further updates, please?

On Mon, Mar 25, 2024 at 02:16:33PM +0100, Julien Massot wrote:
> This driver handles the MAX96717 serializer in tunnel mode.
> All incoming CSI traffic will be tunneled through the GMSL2
> link.
> 
> The MAX96717 driver can handle MAX96717 and MAX96717F variants
> with the same "maxim,max96717f" compatible.
> 
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
> Change since v5:
>  - set the driver compatible back to MAX96717F that can be used as a fallback for MAX96717
> 
> Change since v4:
>  - make the driver compatible with MAX96717 instead of MAX96717F
>  - Add the device id for the MAX96717
>  - remove hw_data structure for now, it can be usefull later for handling different serializers e.g max9295
> 
> Change since v3:
>  - Maintainers: align to the new binding path
>  - Kconfig: better describe the symbol
>  - store the v4l2_mbus_config_mipi_csi2 structure instead of the full endpoint in the driver private structure
>  - use MAX96717_PAD_SINK/SOURCE instead of 0/1 for pad intialization
>  - Removed incorrect call to fwnode_handle_put(priv->sd.fwnode)
>  - Use unsigned int instead of u8
>  - Allocate clk name out of the clk struct initialization
>  - fixed multiline comment
>  - Removed one unnecessary goto at the end of the probe function
> 
> Change since v2:
>  - Use CCI helpers instead of recoding register access
>  - add missing bitfield header
> ---
>  MAINTAINERS                  |   7 +
>  drivers/media/i2c/Kconfig    |  14 +
>  drivers/media/i2c/Makefile   |   1 +
>  drivers/media/i2c/max96717.c | 934 +++++++++++++++++++++++++++++++++++
>  4 files changed, 956 insertions(+)
>  create mode 100644 drivers/media/i2c/max96717.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b43102ca365d..c43088157f6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13277,6 +13277,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/i2c/maxim,max96712.yaml
>  F:	drivers/staging/media/max96712/max96712.c
>  
> +MAX96717 GMSL2 SERIALIZER DRIVER
> +M:	Julien Massot <julien.massot@collabora.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/i2c/maxim,max96717.yaml
> +F:	drivers/media/i2c/max96717.c
> +
>  MAX9860 MONO AUDIO VOICE CODEC DRIVER
>  M:	Peter Rosin <peda@axentia.se>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index 56f276b920ab..1a99396edbcf 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -1573,6 +1573,20 @@ config VIDEO_DS90UB960
>  	  Device driver for the Texas Instruments DS90UB960
>  	  FPD-Link III Deserializer and DS90UB9702 FPD-Link IV Deserializer.
>  
> +config VIDEO_MAX96717
> +	tristate "Maxim MAX96717 GMSL2 Serializer support"
> +	depends on OF && I2C && VIDEO_DEV && COMMON_CLK
> +	select I2C_MUX
> +	select GPIOLIB
> +	select V4L2_CCI_I2C

I think you'll also need MEDIA_CONTROLLER, VIDEO_V4L2_SUBDEV_API and
V4L2_FWNODE.

> +	help
> +	  Device driver for the Maxim MAX96717 GMSL2 Serializer.
> +	  MAX96717 serializers convert video on a MIPI CSI-2
> +	  input to a GMSL2 output.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called max96717.
> +
>  endmenu
>  
>  endif # VIDEO_DEV

-- 
Kind regards,

Sakari Ailus

