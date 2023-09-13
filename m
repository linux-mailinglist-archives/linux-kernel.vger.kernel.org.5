Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF279E484
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbjIMKFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIMKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:05:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92D196
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:04:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad8d0be93aso170480566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694599497; x=1695204297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8jQ9kgZhteJCnTpLuHVvtEChJ/PBj7uSStHbbRkHBA=;
        b=YrQfz0yOwwzm0bPwSv+aSI8WYudEJ49vTMAbWwFPZ1q4zY7S8L07JOORvGKerzlMbS
         4EUTk2DEefUBiMtSzkYsr+BkBRg+3YbFHddMf21vGxgVZWTd71EZiQsNplmpBiOXbTcv
         FTRHZtv+SsS+P8GgXWIDgcyobWJsmPtVnpjL2wu1yXkmy1K1iYS23O5f7PPeBnru/UKD
         /ElnTkLRTrD7fgc9wBmuYSPYlv3ANxj1qGhjUJKc3sjz5xWJnXE/TyUCAB50grI1YNqj
         4DIr/bCs4lCJ5sMDrme3AsTrXH5PxE4UQEZABrnyXAUx2G2ilP61e6o0vV/0/a+3aEFg
         Pvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694599497; x=1695204297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8jQ9kgZhteJCnTpLuHVvtEChJ/PBj7uSStHbbRkHBA=;
        b=TXZtE7BeBBLzjBnSQC5/tI4puzAZtBjiSu4F820SJuCAT5y29kNTr8ODsquEed+ryJ
         dN3bAeLAGz5+7n/tkdhAMFENO4vpVigNswoqm3ghOe74whI+7HZZ9Nok8aqqVyD22IjS
         qdtZyWXTetsY3dLMp3GUJwG+QRJa4X/gZoWV1CO43OxHSctrShlRTzy6EpmvsGiauOav
         t4hVRXwI4RXCYtruopYngDtkeQk2op3p2BJ7bM6LOq7FLvHBKQmEFf6+wwmHAFT1dVGW
         r4bvP+lk8zGyfL03KXXexNeZWoKEwyHrr8Wvy0qsaKHitrqgwwT5zH4Om1JyPMlPfbxN
         3FNQ==
X-Gm-Message-State: AOJu0YzLfkQydNmY2Dqv0DaEyXipAENcSdTMLo07kZ8ak6JR91mOiTi6
        vIoO9afA+aIMJ1kYr5TrApR8vTEbXEc2ZlEhMPg=
X-Google-Smtp-Source: AGHT+IGcnHe8Cof2PTv779x4WyZcCCljCtks0CkDid6AVr83sjmocZ2x8ao7qjkkiXe0miEsy7Tcow==
X-Received: by 2002:a17:907:9408:b0:96f:9cea:a34d with SMTP id dk8-20020a170907940800b0096f9ceaa34dmr7433807ejc.21.1694599496473;
        Wed, 13 Sep 2023 03:04:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906595500b009920a690cd9sm8012217ejr.59.2023.09.13.03.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:04:56 -0700 (PDT)
Message-ID: <1bfdc230-e358-6aa4-7d60-03b5477a6be9@linaro.org>
Date:   Wed, 13 Sep 2023 12:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC
 board
Content-Language: en-US
To:     yangchen.openbmc@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     patrick@stwcx.xyz, Jerry.Lin@quantatw.com, Eddie.Chen@quantatw.com,
        EasonChen1@quantatw.com
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-3-yangchen.openbmc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912140532.3797736-3-yangchen.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 16:05, yangchen.openbmc@gmail.com wrote:
> From: Yang Chen <yangchen.openbmc@gmail.com>
> 
> Add linux device tree entry related to the Minerva Chassis Management
> Controller (CMC) specific devices connected to the Aspeed SoC (AST2600).
> 
> Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed-bmc-facebook-minerva-cmc.dts       | 265 ++++++++++++++++++
>  2 files changed, 266 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/


> +
> +&i2c15 {
> +	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c128";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&adc0 {
> +	ref_voltage = <2500>;

There is no such property in the bindings.

> +	status = "okay";
> +	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
> +		&pinctrl_adc2_default &pinctrl_adc3_default
> +		&pinctrl_adc4_default &pinctrl_adc5_default
> +		&pinctrl_adc6_default &pinctrl_adc7_default>;
> +};
> +
> +&adc1 {
> +	ref_voltage = <2500>;

NAK, there is no such property.



Best regards,
Krzysztof

