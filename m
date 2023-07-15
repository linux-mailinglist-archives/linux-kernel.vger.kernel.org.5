Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DF275493C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGOOQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:16:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467C61BD4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:16:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b74310566cso44976571fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689430590; x=1692022590;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOkFVk3aE5gj9JDSN53HeX/jL7zEDWWGQudrXPTPABQ=;
        b=r0KRmGipoMO1dW9ldKc1SIScIEXhs1DTrrN1t9cwRuMKk2t1sokIHloRc2ZLbcZ0pO
         D4S+i9V0tqUPMr84CoRrzLIe5Mn2fnnOWiMAsKZrqfkx08HTJOtNAEZlQARHIrd78835
         66/HF275MWdBHJ2BFJ3bSYX9B83ExGzK3po0kUmiZGsIekJNAzfNzwYWcFS4DH9fYIMt
         T9rBlnS9oK7XUGqBNPzXTLylIReTKr9AbGicMEGriEBJNaD/Pi82WitStYNHPGtBKdaK
         iJ/pwXnKKzCRe/5AFp+fJogRrywW8xHoVp7T0EBXOaYhIKi3m8m5CEz4dCCMuhsp/RBW
         WPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689430590; x=1692022590;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOkFVk3aE5gj9JDSN53HeX/jL7zEDWWGQudrXPTPABQ=;
        b=Ghpxp5MD4+h0qWc9yfAiseLOxPKdsOLv4BH7UBBRT4/cA5JuKwtYupS/ubMOa0TGFR
         tS/ZSttse/mzQnN9uEH+OXwkp0xsk4eSaaWh/VDe8EqvAqzJF0ra4GNLqt8FJWr/5Ben
         qNHAhiR+aRXFW052rv2nsfc3sfqlz0wWkzNS/3lKsUSBbEczAT2yyzYE9X0a2FepNuG2
         d4x6YLK0/n1rGv6IOcgRoaTTzAzaXbPEWzG4TDO2vlEGUiVFLPelwYkUpLlRxeWAwoHc
         1/wGYIQ5iXfIKR3adEJFZfmtBFUaxvld9D5NWxTtagxiumGNBLdGfgfNH6pHq62tr584
         js/Q==
X-Gm-Message-State: ABy/qLYXjBkoPNGzwOJaHbM/nm9rbpmPyiz6FnyikLQVlExrfVbZh1v8
        PY4ickrQhMFYcyFDj40Y2DNniRAGo/vt5KDI4C012A==
X-Google-Smtp-Source: APBJJlEt8ybhaONj9h+i07UrVHkWzsDdsmsMjF6pVEq7ABL71Tin1p1Or5L4Y8LGbGESTlhiy8NzOw==
X-Received: by 2002:a2e:9184:0:b0:2ad:a78a:df0d with SMTP id f4-20020a2e9184000000b002ada78adf0dmr5023753ljg.44.1689430590557;
        Sat, 15 Jul 2023 07:16:30 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id b19-20020a2e8953000000b002b6e00a3e19sm2523363ljk.132.2023.07.15.07.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 07:16:30 -0700 (PDT)
Message-ID: <55446d48-bc6d-1d7b-1580-0b9dc7323a21@linaro.org>
Date:   Sat, 15 Jul 2023 16:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V4 1/2] arm64: dts: qcom: ipq5332: enable GPIO based LEDs
 and Buttons
Content-Language: en-US
To:     Sridharan S N <quic_sridsn@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616083238.20690-1-quic_sridsn@quicinc.com>
 <20230616083238.20690-2-quic_sridsn@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230616083238.20690-2-quic_sridsn@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.2023 10:32, Sridharan S N wrote:
> Add support for wlan-2g LED on GPIO 36 and wps buttons on GPIO 35.
> 
> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
> ---
> Changes in V4:
> 	- Added patch dependency. This change depends on below patch set
> 	  https://lore.kernel.org/linux-arm-msm/20230615090001.10970-1-quic_sridsn@quicinc.com/
> 
> Changes in V3:
> 	- Updated patch series title. Mentioned platform in series
> 	  title
> 
> Changes in V2:
> 	- Used the hypen in node name instead of underscore
> 	- Dropped the status property
> 
>  .../boot/dts/qcom/ipq5332-rdp-common.dtsi     | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
> index 97dc0e5c15f0..a8671a4ac2e4 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi
> @@ -19,6 +19,31 @@
>  	chosen {
>  		stdout-path = "serial0";
>  	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&gpio_keys_default>;
> +		pinctrl-names = "default";
> +
> +		button-wps {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <60>;
That's purely your choice, but don't you wanna make it wakeup-capable?

Otherwise:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&gpio_leds_default>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};
>  };
>  
>  &blsp1_i2c1 {
> @@ -52,6 +77,20 @@
>  /* PINCTRL */
>  
>  &tlmm {
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	gpio_leds_default: gpio-leds-default-state {
> +		pins = "gpio36";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +	};
> +
>  	i2c_1_pins: i2c-1-state {
>  		pins = "gpio29", "gpio30";
>  		function = "blsp1_i2c0";
