Return-Path: <linux-kernel+bounces-105791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7356987E484
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29926281B71
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668AB24B21;
	Mon, 18 Mar 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsJEdQr4"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B702374C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748711; cv=none; b=frZvlDSWVUPiUNykiYKkIwjh+AwPsz/QjYnBzBV4cGOIE7B4HkuGYDFl7iXY2szbxY1WwpilA+sAv2FPol61Q4n1emhZk9CTl25XzTqHcQV8DcFUuJPTldCEcvqeTqGSv4U2unxRafoW1b7VsEaG2NgReDdvmxGQGw5F4NCSmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748711; c=relaxed/simple;
	bh=Fst39intlKRDb/8ggxNIhAICJfqxINb4emMiCTbBLds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N4e0FF9bGg2HmiTPb7ycMHFJNWV4R+vdZj7qZorkCS+DqRWS+7B9qQnpwh+sg1Woe4tZeBvoQPJ85BT6OFVu+/g6fSKBncZU/HWkcMXDd8XUQs7sTry7fd3pCfFDK+NosUUpAR3im69+6XjFxrWBOztbjrc2/uc5XkDHnV7O3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GsJEdQr4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56b7facf2e1so336458a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710748707; x=1711353507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFGE95RVCnIMXh4rzBbheQjJCqPcx4uOp3c9aQsSW7U=;
        b=GsJEdQr4pKSPUuMOlGATSqcAlohQXnjQkW5DYFwKGpdU3TJ9iyz1ji6RdkTSchhfsS
         HO/+034C6HtKofXuq+w9LeROKzScenFuZGGlibOl8flfH8ykMcnda61D//kdPBR9eOfq
         IqmtzRHCJkJpwgwylTgsqtde/TZz/WnvYC9KVmM6ve5xPBX+pF+BoSXFvL0upeN01n7l
         a4U06OpxLa67YRTeAR6SWawgoRIBoPeTDj2ildHVUsAH+CNGE3Vbr9NTfUDcJ3nqTMrd
         qRaoqqbGLQFjdZNVw0U6aAmc3tq0MKp7P27DPQwapjeYL3XsHoDowHby1WznImFpmOSV
         p3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748707; x=1711353507;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFGE95RVCnIMXh4rzBbheQjJCqPcx4uOp3c9aQsSW7U=;
        b=cKf4VHO9vQAirURkrtqu7Y5BwW/P8ybNUuz+Z8+mgprUX/DbbEBLPkAZkKq6GbaniZ
         BXTG23G5yb/DEsrKHZLnmoLYS8IDIn0DE1UStndSNf/hASeFePSQ+SUrI72tBm+1WkWy
         bO4eKcwuafCAe9PjLblgR5elVgmJwgRuZ71LRn9tvKYH1XNG1hXtqBx1CQZWS19Kwafa
         ktJ+lf4FFTGuZSI9sohWWmDmKrW7ooZh0+gBmhjCjDYm34Mg3qoaJ0RCHTcoz7W+cgAM
         O8CT6yN4XwqbAEoTrR/ImsYf7mA3Ns930d8oDuQlsMIjjUvPZGg5sDfxfXzC2Yv+TXkv
         tgvw==
X-Forwarded-Encrypted: i=1; AJvYcCUHqWXT+l5IcPZQcYtN7S5EdLK66/A7cd/MUgzJPgl2X9coqI5PLYrT7MfyBTd0R1aLaN+vxXTpBKoWRQUFoPoeM7CkadILVoUauC/+
X-Gm-Message-State: AOJu0Yx5JPIN8Xd3mKeHkGA/EfR33bLMEkIONsOTd3R7XzZhs3D3Sthn
	ZBP7dNiv8Bva9XFLdvhLe5GbaHoQ+1kRf83edBCIorAxefp883YUwxo/dgFAakEgB5TmgFzxa56
	l
X-Google-Smtp-Source: AGHT+IGWsAI8IE05B16HXMG4BE0mLPO5bP9vn+BWp97d0rV7EEb40TJsYMYSTg3wKa+JjrRBguKLGA==
X-Received: by 2002:a50:cccd:0:b0:568:b71a:5954 with SMTP id b13-20020a50cccd000000b00568b71a5954mr1822684edj.10.1710748707006;
        Mon, 18 Mar 2024 00:58:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id co24-20020a0564020c1800b00568c613570dsm1911155edb.79.2024.03.18.00.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 00:58:26 -0700 (PDT)
Message-ID: <d94a4833-3fe2-4dfa-be88-9508971d12bd@linaro.org>
Date: Mon, 18 Mar 2024 08:58:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: watchdog: ast2600 support bootstatus
Content-Language: en-US
To: Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20240318055219.3460121-1-peteryin.openbmc@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240318055219.3460121-1-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 06:52, Peter Yin wrote:
> Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600
> 
> Regarding the AST2600 specification, the WDTn Timeout Status Register
> (WDT10) has bit 1 reserved. To verify the second boot source,
> we need to check SEC14 bit 12 and bit 13.
> The bits 8-23 in the WDTn Timeout Status Register are the Watchdog
> Event Count, which we can use to verify WDIOF_EXTERN1.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
> Change log:
> 
> v1 -> v2
>   - Add comment and support WDIOF_CARDRESET in ast2600
> 
> v1
>   - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi |  8 ++---

No, DTS is always separate patchset.

>  drivers/watchdog/aspeed_wdt.c           | 45 ++++++++++++++++++++++---
>  2 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index e0b44498269f..23ae7f0430e9 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -556,24 +556,24 @@ uart5: serial@1e784000 {
>  
>  			wdt1: watchdog@1e785000 {
>  				compatible = "aspeed,ast2600-wdt";
> -				reg = <0x1e785000 0x40>;
> +				reg = <0x1e785000 0x40>, <0x1e6f2000 0x20>;

And how does it pass dtbs_check? Where did you update the bindings?

>  			};
>  
>  			wdt2: watchdog@1e785040 {
>  				compatible = "aspeed,ast2600-wdt";
> -				reg = <0x1e785040 0x40>;
> +				reg = <0x1e785040 0x40>, <0x1e6f2000 0x020>;
>  				status = "disabled";
>  			};
>  
>  			wdt3: watchdog@1e785080 {
>  				compatible = "aspeed,ast2600-wdt";
> -				reg = <0x1e785080 0x40>;
> +				reg = <0x1e785080 0x40>, <0x1e6f2000 0x020>;
>  				status = "disabled";
>  			};
>  
>  			wdt4: watchdog@1e7850c0 {
>  				compatible = "aspeed,ast2600-wdt";
> -				reg = <0x1e7850C0 0x40>;
> +				reg = <0x1e7850C0 0x40>, <0x1e6f2000 0x020>;
>  				status = "disabled";
>  			};
>  
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..65118e461130 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -33,6 +33,7 @@ struct aspeed_wdt {
>  	void __iomem		*base;
>  	u32			ctrl;
>  	const struct aspeed_wdt_config *cfg;
> +	void __iomem		*sec_base;
>  };
>  
>  static const struct aspeed_wdt_config ast2400_config = {
> @@ -82,6 +83,15 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>  #define WDT_RESET_MASK1		0x1c
>  #define WDT_RESET_MASK2		0x20
>  
> +/*
> + * Only Ast2600 support
> + */
> +#define   WDT_EVENT_COUNTER_MASK	(0xFFF << 8)
> +#define   WDT_SECURE_ENGINE_STATUS	(0x14)
> +#define   ABR_IMAGE_SOURCE		BIT(12)
> +#define   ABR_IMAGE_SOURCE_SPI		BIT(13)
> +#define   SECOND_BOOT_ENABLE		BIT(14)
> +
>  /*
>   * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
>   * enabled), specifically:
> @@ -313,6 +323,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	const char *reset_type;
>  	u32 duration;
>  	u32 status;
> +	u32 sec_st;
>  	int ret;
>  
>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> @@ -330,6 +341,12 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(wdt->base))
>  		return PTR_ERR(wdt->base);
>  
> +	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {


> +		wdt->sec_base = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(wdt->sec_base))
> +			return PTR_ERR(wdt->sec_base);
> +	}

NAK, ABI break without clear reason.

Best regards,
Krzysztof


