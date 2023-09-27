Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1159C7AFD1B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjI0Hyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjI0Hyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:54:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A36B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:54:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ae75ece209so1150498366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695801284; x=1696406084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7Jlp2PcQoKOrsVy5Jf/Ifw8DifNKFzd0XusMIA25T4=;
        b=Ab92Dh80e1Xxqt+ic5Ll+dBT86pKBTGGigCk6qGq9jeH9Vc60pAKZsEWtzKQg/NBCH
         rZAuXaSMza7WolaK1xfAz6EZdeuwUEbgoBIePr5m9EJGEH/E352NIjBsxahiQEdXpxbK
         x3hUSIFYvZkFPzzXeiMU22VSMJr269MHjfVKLiRhfiZzGnuhKQq0r7qftnwIfRW6j9gF
         RfSg2ahOC1A4BO23GjHsPdIbsLe2KBa3UBl+G23vnYFU1MEXO95duUgxD8IXgr0eTIoa
         my6Egsgf9P/VL6K6hIR4FBfPbMbjkR3WE1rQdeNpQT5YLGvdS6Hf8h7U9Rr/g6FX5Nfk
         lq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695801284; x=1696406084;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7Jlp2PcQoKOrsVy5Jf/Ifw8DifNKFzd0XusMIA25T4=;
        b=WFLuo/huYfYvI8Or186yNTbUO+EF+XLaSMz7k5hImK937Aww+/7sDoxqYKiakRHmQr
         Kz21MnKsOjwWuCEl16aTcRvYE7MVjupFESMD5tltyQw9nbmODLdRL+SZ2y2rrEM9GK08
         /Io0hz8gsNjyFihZH/OeIcSFbig0qu6s3zYy7jYQLnH6ei5pqwgbvc3v+QjQ4bOGK4f7
         6uh7qruYQJlOOMbWL2tndruv/0xDWTHTYM0vyEFJxJlsF5b4uKYN6mx0rd+m76bbIeZr
         B1pgORqj1U9dPbuB+eQSQltl6DO+UC86Ksc85msz+9Pr8SPbxqs2aI/ez5CPfSUBHCHE
         uVyg==
X-Gm-Message-State: AOJu0Yw0IAXSK/Z+UqAOGhR5wL9X5gy7sxCMD8xb0GVGYtcj8BejbCdq
        t51SyP9I+YUiHy46PjSN7woDdw==
X-Google-Smtp-Source: AGHT+IFUxftRh2tI5NDPRBFMRWS4GVTwRXaEM8E2RQKMSqScFQLfy2ilcr7NrGEYIwu7jWYOjfDbqA==
X-Received: by 2002:a17:906:9a:b0:9a1:e233:e627 with SMTP id 26-20020a170906009a00b009a1e233e627mr1196529ejc.42.1695801284039;
        Wed, 27 Sep 2023 00:54:44 -0700 (PDT)
Received: from [192.168.1.160] (host-87-4-82-94.retail.telecomitalia.it. [87.4.82.94])
        by smtp.gmail.com with ESMTPSA id cb25-20020a170906a45900b009ad778a68c5sm8928632ejb.60.2023.09.27.00.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 00:54:43 -0700 (PDT)
Message-ID: <0c709939-9867-4d80-ba7e-640b594f8d7a@linaro.org>
Date:   Wed, 27 Sep 2023 09:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] arm64: dts: ti: k3-j784s4-main: Add the main
 domain watchdog instances
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org, nm@ti.com,
        vigneshr@ti.com, conor+dt@kernel.org, kristo@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     u-kumar1@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230926132805.6518-1-j-keerthy@ti.com>
 <20230926132805.6518-5-j-keerthy@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20230926132805.6518-5-j-keerthy@ti.com>
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

On 26/09/2023 15:28, Keerthy wrote:
> There are totally 19 instances of watchdog module. One each for the
> 8 A72 cores, one each for the 4 C7x cores, 1 for the GPU, 1 each
> for the 6 R5F cores in the main domain. Keeping only the A72 instances
> enabled and disabling the rest by default.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 182 +++++++++++++++++++++
>  1 file changed, 182 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 26dc3776f911..8c3efe066803 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1576,4 +1576,186 @@
>  			      <695>;
>  		bootph-pre-ram;
>  	};
> +
> +	watchdog0: watchdog@2200000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2200000 0x00 0x100>;
> +		clocks = <&k3_clks 348 1>;
> +		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 348 0>;
> +		assigned-clock-parents = <&k3_clks 348 4>;
> +	};
> +
> +	watchdog1: watchdog@2210000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2210000 0x00 0x100>;
> +		clocks = <&k3_clks 349 1>;
> +		power-domains = <&k3_pds 349 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 349 0>;
> +		assigned-clock-parents = <&k3_clks 349 4>;
> +	};
> +
> +	watchdog2: watchdog@2220000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2220000 0x00 0x100>;
> +		clocks = <&k3_clks 350 1>;
> +		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 350 0>;
> +		assigned-clock-parents = <&k3_clks 350 4>;
> +	};
> +
> +	watchdog3: watchdog@2230000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2230000 0x00 0x100>;
> +		clocks = <&k3_clks 351 1>;
> +		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 351 0>;
> +		assigned-clock-parents = <&k3_clks 351 4>;
> +	};
> +
> +	watchdog4: watchdog@2240000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2240000 0x00 0x100>;
> +		clocks = <&k3_clks 352 1>;
> +		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 352 0>;
> +		assigned-clock-parents = <&k3_clks 352 4>;
> +	};
> +
> +	watchdog5: watchdog@2250000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2250000 0x00 0x100>;
> +		clocks = <&k3_clks 353 1>;
> +		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 353 0>;
> +		assigned-clock-parents = <&k3_clks 353 4>;
> +	};
> +
> +	watchdog6: watchdog@2260000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2260000 0x00 0x100>;
> +		clocks = <&k3_clks 354 1>;
> +		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 354 0>;
> +		assigned-clock-parents = <&k3_clks 354 4>;
> +	};
> +
> +	watchdog7: watchdog@2270000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2270000 0x00 0x100>;
> +		clocks = <&k3_clks 355 1>;
> +		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 355 0>;
> +		assigned-clock-parents = <&k3_clks 355 4>;
> +	};
> +
> +	watchdog16: watchdog@2300000 {
> +		status = "disabled";

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

