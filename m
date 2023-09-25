Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7107AD38B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjIYIkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjIYIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:40:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39EDAF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:40:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-313e742a787so3936031f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695631213; x=1696236013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3IXyMNInXmbMQ8Ek9MDO7j2NGL0skoofMOaL+e8dlE=;
        b=vuIcHT4u+w3nyqcZI3lMVTEzN8sJcKxwnWxKSMZPyk04+jwZMxKv2dpu/hPA9sA6lA
         AdqSGEvwrvUA7NVv4RBovdg0axXLzRlSiZOJ0luh81XWlPR8UmfIys+iK2OZHjOnPXp5
         kCHpNNGgCP/i6tjXiA8Pn+hc+K78KaYC+IUr8bHVWzOpSUPMxJUiw/wvbsS0ON2JKAEU
         S4gsAdDsP8fBrawgliasRXuyTAVs2hgwJGXsEj3lK1n5gyv02YGg0oEvcXQ2T9BJgLRe
         JlpVGpM4fYjqYcVdO+GDPWSn+yG3mtK/aQuFnHaL8VgXOU2GNIo+ivG6glVhBlhbYpJN
         0Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631213; x=1696236013;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3IXyMNInXmbMQ8Ek9MDO7j2NGL0skoofMOaL+e8dlE=;
        b=dF0pAmHTk9ULY5YWs5BZHe4G3S1g9LnC79GgBikpFW/yiC/kgGACfrA6YVpB8NFg+s
         7A+HUJ+mjjQlz0gTx6qH+crdVlPqSOgXYgeSLgt2r43xshNZvAm4gAwsHHqOfWWZVv0v
         1TuBlD7+wE7CRx7ck5jRQVAyhhOG671POEFCn7TJ+iRA1CDIWEeHn6dn8lAUVMirg4RD
         9av1PaoH+h8KDvWQhgO6kaMn0KpP55/KS6jWxSiID2Jd7Exf2KsLvdVwApil9Pw83FMe
         9nwmSq/HhlIeuHbY1nWRByv81V3ZInAEn2fuaVZcS9rbgfk7Y9gYPVjOoIHtttGKg9uH
         Zt4A==
X-Gm-Message-State: AOJu0YwfBwOhLP402BmmellmVC7ugdsRpWylqEtufayLEGasbrsvzkrf
        aWH4qXl4sG0vpqGN70g583gCew==
X-Google-Smtp-Source: AGHT+IGi1wySmyGOgUZqMGDdRntqbHLonm1/+J1W2LC0nHkg1XQNXCve9oKDO0VIDmtFQHj1PnMziQ==
X-Received: by 2002:adf:e2c6:0:b0:317:f3fd:21b0 with SMTP id d6-20020adfe2c6000000b00317f3fd21b0mr4783602wrj.7.1695631213213;
        Mon, 25 Sep 2023 01:40:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v19-20020adf8b53000000b0032318649b21sm5970555wra.31.2023.09.25.01.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 01:40:12 -0700 (PDT)
Message-ID: <5187c590-ee9a-4c46-b326-655f4c371aaf@linaro.org>
Date:   Mon, 25 Sep 2023 10:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] arm64: dts: ti: k3-j784s4-main: Add the main
 domain watchdog instances
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org, nm@ti.com,
        vigneshr@ti.com, conor+dt@kernel.org, kristo@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     u-kumar1@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230925081332.15906-1-j-keerthy@ti.com>
 <20230925081332.15906-5-j-keerthy@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20230925081332.15906-5-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2023 10:13, Keerthy wrote:
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

status is never first property. It is actually always last in node
definition.

> +		compatible = "ti,j7-rti-wdt";

OTOH, compatible is always the first property. Always. There is no
coding style which suggests different order.

Best regards,
Krzysztof

