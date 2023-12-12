Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DB80F232
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjLLQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376775AbjLLP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:56:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13688D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:56:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so8158501a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702396591; x=1703001391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4vXCh8F5LedUSisfsukth4eGUf9Q/FPN0WUaR5/XEE=;
        b=ee8l5pAa3diRouUko7Efi3B6j831XfoEQugdxcdCkcvmDlr1zNUXaZr9HSQ3cvpxEY
         AP9kA7/Fk5SlHTyp0AgM4Ezn/01lSnyAPt81g8h6/IbM09sthKjZCW1t2QSadG8/23Qc
         tZ61VUEQb9AR9Hj0HZIbzB4OigyQbegVjlyRCExSTquHztyVmsXEKiPm93+2/uhUwwcP
         bLhM0gEztm1fezgY+xa11lUvkvQnVDqLMCzCPbENRN84VqJ0BOgfoLhF2UxJfaKHbizE
         TIOs37et1xl5bKXa3pangmLOHvvQujorGUUI9kYDkYxiCQrpU7/Zx+TLHkh1P4+Tz2OW
         XhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702396591; x=1703001391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4vXCh8F5LedUSisfsukth4eGUf9Q/FPN0WUaR5/XEE=;
        b=bNtSgvNNBmDjwS9iLNa06OdZ+5S6hZMCr0GraqyjtdJibp/TMkbBaMLMdoUjQvFzzk
         XJMw7b5+vFSINWnR4ndy+pOGaX/KC8D9kFzqu52yrnTHIHKxFHZ5vOlv3eexClV0HLmY
         L2NzuJrbdkyrFDLiuAgmIQPGUbZI/mgg82F+m1uihxRjo7J5hxpyB9Nbms+7E/yaQzJj
         rdR1LNnlcUuclTMCdIY2Ox7taGDauT4NJuKjajrV7YYyUPf72nqVzuXe0l2QWRn4AN9Q
         Y2YjfzNilrp8IvgVgSWECEHnRm6LXZgLiFShJ9LvyaWg8H6JakAk3mbiT1y1Z2/P67SS
         +MWw==
X-Gm-Message-State: AOJu0YxGA4CfMl/uEWlVLz0c5LKj8twPogAhq7iHYFQHo2l5+ChE5Tja
        QcGA0G7oaq4e6duf8XRwKPnW3g==
X-Google-Smtp-Source: AGHT+IEGg6rxKLnmGKepM3gl8qsFTYq7RJMCavGZ9nBlCMjxq7R0x9NL4zxA543DCWbQ5cBSi4zuiQ==
X-Received: by 2002:a50:bac2:0:b0:551:db7e:cada with SMTP id x60-20020a50bac2000000b00551db7ecadamr169941ede.27.1702396591427;
        Tue, 12 Dec 2023 07:56:31 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id cn10-20020a0564020caa00b0054ca2619c1bsm4858893edb.9.2023.12.12.07.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:56:30 -0800 (PST)
Message-ID: <bae162b2-5f81-4275-a7bc-ac3f9886ff18@tuxon.dev>
Date:   Tue, 12 Dec 2023 17:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sama5d27_som1_ek: Remove
 mmc-ddr-3_3v property from sdmmc0 node
Content-Language: en-US
To:     Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     cristian.birsan@microchip.com
References: <20231211070345.2792-1-mihai.sain@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231211070345.2792-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.12.2023 09:03, Mihai Sain wrote:
> On board the sdmmc0 interface is wired to a SD Card socket.
> According with mmc-controller bindings, the mmc-ddr-3_3v property
> is used for eMMC devices to enable high-speed DDR mode (3.3V I/O).
> Remove the mmc-ddr-3_3v property from sdmmc0 node.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>

Applied to at91-dt, thanks!

> ---
>  arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
> index d0a6dbd377df..f3ffb8f01d8a 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
> @@ -54,7 +54,6 @@ usb2: ehci@500000 {
>  
>  		sdmmc0: sdio-host@a0000000 {
>  			bus-width = <8>;
> -			mmc-ddr-3_3v;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_sdmmc0_default>;
>  			status = "okay";
