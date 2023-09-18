Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70827A3FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbjIREIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbjIREIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:08:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C292EC6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 21:08:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-403012f27e3so46194645e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 21:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695010092; x=1695614892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ez612mLc6i/GdCgxr8aU9W0YYLQrGi5wZNJ79KpTovo=;
        b=E0Ee4xOhxJN7qDyhcZtNpGUmxkciCU30Aj+H3/C3xL1ZxCIP1pmanqIQHIPdR3Towu
         x8b9S44EFEpVom2yaLlBPeXV8ejVusuF/tiKSuDwY5oc4o4rsXhdpdZU6jzePDJNCvNw
         1eyTSO9/APquyka/QfrzwmVGaggWPe6ovasO3ofQ/lx8KCQFkqxubQtXEzXlTJq5wDDw
         y0hjsoz0H6/5YEG80Xygw5Q9+Dw6x8GkqNAu/I0INeJSMRBSUtU8czWXm4pKYqQOvKVZ
         +VmIrcW4hdBiwc99JUFpLz0VCS0nsbHBFavEoUW0BwYb+70ZNHlLnWN9H/yUdhDMrSMm
         uXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695010092; x=1695614892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ez612mLc6i/GdCgxr8aU9W0YYLQrGi5wZNJ79KpTovo=;
        b=Fx3TtYU36NcCMBj60mjK3bn6wBV2+/bGrHjdt7xcwmSMPDP07SRb/gNzAQerScaNAJ
         EVuR18FNTJN70ckRf1+mqEehY/d/6ik2W2NGd5MmbflFTtSMNY12aebOREawhNTqWW/S
         F3dRuZCheVfRN72Pn/z95BLHSEiYtY+BZGDh/yZufceNzi8eKBbzOE52UdABgcqhigRt
         CCJbQxOymiwNMplfBMoKhG41i36BDrLqQ5mBcIe5Xb6WQGEYtG6IZsLYTcYn7Yz9HGHC
         fNihs7OnYpCwA9JzvfKkAJbzsJPDyE6WqTSkvona6mHBbyQLTK7aK4Cb6XitkUrxjtBs
         VZjQ==
X-Gm-Message-State: AOJu0YxFQyLUqcAx9foyyG+sGh06iaZkckJDbUbvhcJFhmOQ70NuWTHs
        3z/KmiPm1yFcz2ARh6TB7ViWIA==
X-Google-Smtp-Source: AGHT+IGZar+PiSUcNuJ1lLQ9xuEptIIG5nA5eGx3IXYeILOsG9JLq1k54ufDfQiz2Ug3wmZ1PShVpQ==
X-Received: by 2002:a1c:f717:0:b0:403:b86:f624 with SMTP id v23-20020a1cf717000000b004030b86f624mr6477577wmh.23.1695010092274;
        Sun, 17 Sep 2023 21:08:12 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003feae747ff2sm14040321wmk.35.2023.09.17.21.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 21:08:11 -0700 (PDT)
Message-ID: <7d1b2f5d-cbbb-810f-b511-84d6d4682fa1@tuxon.dev>
Date:   Mon, 18 Sep 2023 07:08:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ARM: dts: at91/trivial: fix typo in crypto DT naming
Content-Language: en-US
To:     nicolas.ferre@microchip.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org
References: <20230906135838.59247-1-nicolas.ferre@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230906135838.59247-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.09.2023 16:58, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Fix typo in DT name for TDES node.
> 
> Fixes: 4b6140b96dfe ("ARM: dts: at91: Use the generic "crypto" node name for the crypto IPs")
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied, thanks!

Hi, Nicolas,

Also, I've removed the fixes tag as the node is not referenced anywhere by
its name thus no need for fixes in this case. Let me know if you consider
differently.

Thank you,
Claudiu Beznea
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
