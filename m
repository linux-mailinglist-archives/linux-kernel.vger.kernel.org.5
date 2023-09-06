Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC189793EA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbjIFOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbjIFOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:22:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178FF1733
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:22:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so39807266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694010119; x=1694614919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aH4htNzKGyY0NdJjI9Mh9TCs3stuoDgE8Vga1mOypZE=;
        b=B1M2mycWyOr51VgXntoehG9uufrIAzFv28rjZl/9qZGtg9+keev98X4Ef3v1Kgnp26
         qUzb5X6HFSeMGaUWWI4o17eo9xjmToBoHx+bSm+u+QJMxfPZe29rvp9KWgel3eZx8Q31
         XLLUmcs5WdpWARkdZqoCEUXxG5iIADSJ3ANwTv3I3fNVCmrxxm4wMDNRynrRjIpBzvWi
         Cvk6GwWtWcOBNzAdrer4MS6KurywSwA8KmbBTQ7ejdiEDbN8QvmoXjdN5hPPexuKq0Lo
         UUie34i3HkPuafIqNLV7/eiwJ3pq4i2sMN9bQsSgPbmLHEsDU3+6w2+2tBSTxb6WMxOc
         s8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694010119; x=1694614919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aH4htNzKGyY0NdJjI9Mh9TCs3stuoDgE8Vga1mOypZE=;
        b=M8gUB6QSRHyba7g7jOql9yXFEZUOVtOszhoE3wWr0mtM44dOTiH7q3xcMMmCG32ZL+
         CQZz3TyoNXdBfjq4BMuswqsIcbhSGLX7Sb1J9L79BgqxfjxW8l7+/Ox3b6V2MUUCNH4V
         7UCzy/T3CitbuRsKVgYGoTvFz4Y2blaWKVMx5zPTLainClA0kvw0Rq4h8FKQZ/4XleNR
         KBNI2sFSUHS9Xk07vrkoZoY+pYEpoHF0W2g7niS6hI6cUk7erUam4hzApvxBzHExOdZ7
         9+XVdHx3vy33VX10nUOC9JfN2y4g3V5tPefJvRWPpQGSXR67s7RAuqP5eB3bjQuTSMf0
         +EKg==
X-Gm-Message-State: AOJu0YxfVyhD2RGGcKjcjSGmdUQ7GHDt0teczG9MQfWuQiqMQdiUm4iP
        zfrB2A9S44qV2xC8Q1wQMMSUsw==
X-Google-Smtp-Source: AGHT+IFi+OpUFkhb9ey5NOFeAogtUpHwnCW7LVTTvZROsam4q2ZF0lAdYYLSknDRZ3B3wuhs91z/Uw==
X-Received: by 2002:a17:906:76da:b0:9a1:8a54:145f with SMTP id q26-20020a17090676da00b009a18a54145fmr2460169ejn.40.1694010119371;
        Wed, 06 Sep 2023 07:21:59 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064a8a00b009937e7c4e54sm9041491eju.39.2023.09.06.07.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 07:21:58 -0700 (PDT)
Message-ID: <d84e5757-a8b6-4b32-b326-6114e55ee5ea@linaro.org>
Date:   Wed, 6 Sep 2023 15:21:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: at91/trivial: fix typo in crypto DT naming
Content-Language: en-US
To:     nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org
References: <20230906135838.59247-1-nicolas.ferre@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230906135838.59247-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/23 14:58, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Fix typo in DT name for TDES node.
> 
> Fixes: 4b6140b96dfe ("ARM: dts: at91: Use the generic "crypto" node name for the crypto IPs")
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  arch/arm/boot/dts/microchip/sama5d4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/sama5d4.dtsi b/arch/arm/boot/dts/microchip/sama5d4.dtsi
> index 41284e013f53..cbfc60fed37c 100644
> --- a/arch/arm/boot/dts/microchip/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama5d4.dtsi
> @@ -694,7 +694,7 @@ aes: crypto@fc044000 {
>  				clock-names = "aes_clk";
>  			};
>  
> -			tdes: crpyto@fc04c000 {
> +			tdes: crypto@fc04c000 {
>  				compatible = "atmel,at91sam9g46-tdes";
>  				reg = <0xfc04c000 0x100>;
>  				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 0>;
