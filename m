Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510787DE3C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjKAOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjKAOWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:22:02 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BCB10F;
        Wed,  1 Nov 2023 07:21:54 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b566bc6daaso989109b6e.1;
        Wed, 01 Nov 2023 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698848514; x=1699453314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/KfXtnlsxkHOWGWL/ahWCJ5PQS2xM9nsLdfpk8B9gE=;
        b=mXBbJH1CgDEMFCs9LARv1F5dPfx4HzW8jmCcnb8mC2MCwiv6DkyK4gLEMoLAvcl7cq
         +morSGin12yTEg0iyW3vpC/hgqnXgfXNFTgVHKli/DV978tgoBv1sWDFOi0hOM40V1Qh
         oP4cvCHD5zX4Xl4P3/v3QX8qeqYwh3Qq8PGtjMhkp8F9SsrbyXwr+2aLf0cJGwTvcWBc
         qP5igEW8VKBpbrRx+jTOpTyaovTxKojKhwv6BPIyjoV0waI2MKI66nFIUgzKBuNzwwCv
         WiDcM47k3a/0J0+ib6y0vCYinmylok434BheAcShYOWcDnCvUM0s9Zs+TeD2BIXuhbcq
         ORZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698848514; x=1699453314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/KfXtnlsxkHOWGWL/ahWCJ5PQS2xM9nsLdfpk8B9gE=;
        b=PxtwHPiP63Ct9wOY8iXATEVxyA637NbFXVEoXU9o1TTLbGAXDyEQ7n6s6zYbHQ/ip6
         q9PFeXAU2IFb36xVq7Mk4ruiPAe41xiWHQ0i8FVAyzheBVQCeqhh9psp8IqwD/8p/P9R
         d/OgMn5zJg/hhZebGvLAV4kAZyUOBXumKoyScdxzdYSB7reUDpO/KnGgPAVSwUWgA1GC
         KVdaKOdwYzGYW+ckYpcpaSJIku8sFtpSOex0ymlgqfeU9MGDPO5A1lcwxQHRlZcne5S8
         sXYywMzhHiow55OZff0BgP8vuycAwZUz6D37vkcsvfuBsWuLW/Z9/r+hg/fKtHaIlP2B
         FEEw==
X-Gm-Message-State: AOJu0YzIY/dxdqb5SjAe4jyTnCdl7dkeLfG5CAi83YrnKN/nS0uGyk41
        wWPo5PxYgV0runNWK252R0vkSoxS4aA=
X-Google-Smtp-Source: AGHT+IHaQA8pp7eLV0RYAgQQ1vMA/CktRCYX/iXK/CmcUQOZV7ZXDwJ0UhTA3fe0js7b+okbGPmlow==
X-Received: by 2002:a05:6808:602:b0:3ae:5c0c:df0f with SMTP id y2-20020a056808060200b003ae5c0cdf0fmr16271349oih.44.1698848513642;
        Wed, 01 Nov 2023 07:21:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12-20020a0568080ecc00b003a7a34a4ed8sm229203oiv.33.2023.11.01.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 07:21:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 1 Nov 2023 07:21:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 2/2] rtc: max31335: add driver support
Message-ID: <81efcde1-8305-465a-85a2-cfe449e8a8da@roeck-us.net>
References: <20231101094835.51031-1-antoniu.miclaus@analog.com>
 <20231101094835.51031-2-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231101094835.51031-2-antoniu.miclaus@analog.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:48:14AM +0200, Antoniu Miclaus wrote:
> RTC driver for MAX31335 ±2ppm Automotive Real-Time Clock with
> Integrated MEMS Resonator.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - add Kconfig entry for HWMON dependency.
>  MAINTAINERS                |   8 +
>  drivers/rtc/Kconfig        |  20 +
>  drivers/rtc/Makefile       |   1 +
>  drivers/rtc/rtc-max31335.c | 765 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 794 insertions(+)
>  create mode 100644 drivers/rtc/rtc-max31335.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5de540ec0b..bc484cb997ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12823,6 +12823,14 @@ F:	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>  F:	Documentation/hwmon/max31827.rst
>  F:	drivers/hwmon/max31827.c
>  
> +MAX31335 RTC DRIVER
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +L:	linux-rtc@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/rtc/adi,max31335.yaml
> +F:	drivers/rtc/rtc-max31335.c
> +
>  MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
>  L:	linux-hwmon@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index d7502433c78a..360da13fe61b 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -373,6 +373,26 @@ config RTC_DRV_MAX8997
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-max8997.
>  
> +config RTC_DRV_MAX31335
> +	tristate "Analog Devices MAX31335"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the Analog Devices
> +	  MAX31335.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-max31335.
> +
> +config RTC_DRV_MAX31335_HWMON
> +	bool "HWMON support for Analog Devices MAX31335"
> +	depends on RTC_DRV_MAX31335 && HWMON
> +	depends on !(RTC_DRV_MAX31335=y && HWMON=m)
> +	default y
> +	help
> +	  Say Y here if you want to expose temperature sensor data on
> +	  rtc-max31335.
> +

This isn't used in the driver. Did you test with HWMON=n ?

Guenter
