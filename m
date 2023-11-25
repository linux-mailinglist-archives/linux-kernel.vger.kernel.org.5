Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE627F8BE8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjKYPE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:04:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB555F2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:04:33 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b31232bf0so22444745e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700924672; x=1701529472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScKfY09ekk9iyTG+1Y3vImjdJv6TZqfXKZB9Xfb5+7c=;
        b=sqy2gTGpD2fI9gUeN2IWDhKaE67kiOQdaPPy7Z1J9naTkwMfu1SsrLudPxOl+T2RsC
         70Xx906fHoqb04mqlgSUI41Gt2BrKatdVHprt4mf6hA4md9BTiJQxqhuk+O1FbXjxmRb
         xGzgMhI4Rz1HCLQ5GyvtG4oucs7luTtI0NQNcVzwW+4yienhVZUrKKMd3NVLxkZn5lh8
         arQAnVYPfr3ignG3L2VpSO7lPpA2mkdZakjV+BLEROXuTmBr7/B5cyCrZ6EGrxNBtwkQ
         uKsv3IETkBtTLA5jn+OBpSVNrrrC9x1UA35Si+Smefp9TMbW1+wry/8+CDw53gS6H9Vg
         5DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700924672; x=1701529472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScKfY09ekk9iyTG+1Y3vImjdJv6TZqfXKZB9Xfb5+7c=;
        b=HywWaaqPuizE2qh3Ce7ecYOeG5P0VyR3cHsnQMHo93ex8pM4c+C81WOiUrv46TW9oC
         3Ehnifbt7x4zSPUm+KJWcmyX5SFE+wwWMFry8nIjN0yJskU8SCm1LHol9qmh8pSrXMr1
         erGNhtMXaTf9dUS6VaoEafI/Sf0b0xbHWmkVXllO0Ve5nysU/Hx4KUgTJhWDs3YoPnVr
         7e0RaBpMsdYNEjd3KK81R6uFTZrDQ3cP6pdOMetj7izlweNDRf61OgGsHzVs+hnrKIA+
         m5VXAuCTIs83VnyB8HaP8f0yOBvCKGb98FMyUKbwxj9rQ1LXp7OV4JYCNQ//PxPDcVDq
         WA2w==
X-Gm-Message-State: AOJu0Yyd4nCCn58AIKp7GLNsUlcPhY1d2kE8M7pVdP+dUu8MyevPAVg/
        wJcZo3+IomriftBiT9+CNOc4Ag==
X-Google-Smtp-Source: AGHT+IFoPTyLpDwlGytHlyDJns+285CNXDsFuYADSsEvWPkUn3TL99C5LbOY9PrRsWyP/d1TcYx/fA==
X-Received: by 2002:a05:600c:314f:b0:40b:2a18:f1be with SMTP id h15-20020a05600c314f00b0040b2a18f1bemr4857156wmo.1.1700924672282;
        Sat, 25 Nov 2023 07:04:32 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f9-20020a0560001b0900b003143867d2ebsm6896206wrz.63.2023.11.25.07.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 07:04:31 -0800 (PST)
Message-ID: <d8cd02e7-7e85-4b75-b48c-e9544d03c197@linaro.org>
Date:   Sat, 25 Nov 2023 15:04:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qrb4210-rb2: Enable bluetooth
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231120-topic-rb2_bt-v1-0-509db2e28e70@linaro.org>
 <20231120-topic-rb2_bt-v1-2-509db2e28e70@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231120-topic-rb2_bt-v1-2-509db2e28e70@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 25/11/2023 13:04, Konrad Dybcio wrote:
> Enable the QCA bluetooth on RB2. It identifies like the following:
> 
> Bluetooth: hci0: QCA Product ID   :0x0000000a
> Bluetooth: hci0: QCA SOC Version  :0x40020150
> Bluetooth: hci0: QCA ROM Version  :0x00000201
> Bluetooth: hci0: QCA Patch Version:0x00000001
> Bluetooth: hci0: QCA controller version 0x01500201
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 81 +++++++++++++++++++++++++++++++-
>   1 file changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> index 9738c0dacd58..bd751236f983 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -15,6 +15,7 @@ / {
>   
>   	aliases {
>   		serial0 = &uart4;
> +		serial1 = &uart3;
>   	};
>   
>   	chosen {
> @@ -352,7 +353,8 @@ vreg_l8a_0p664: l8 {
>   
>   		vreg_l9a_1p8: l9 {
>   			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <2000000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-allow-set-load;
>   		};
>   
>   		vreg_l10a_1p8: l10 {
> @@ -389,11 +391,13 @@ vreg_l15a_3p128: l15 {
>   		vreg_l16a_1p3: l16 {
>   			regulator-min-microvolt = <1704000>;
>   			regulator-max-microvolt = <1904000>;
> +			regulator-allow-set-load;
>   		};
>   
>   		vreg_l17a_1p3: l17 {
>   			regulator-min-microvolt = <1152000>;
>   			regulator-max-microvolt = <1384000>;
> +			regulator-allow-set-load;
>   		};
>   
>   		vreg_l18a_1p232: l18 {
> @@ -426,6 +430,7 @@ vreg_l22a_2p96: l22 {
>   		vreg_l23a_3p3: l23 {
>   			regulator-min-microvolt = <3200000>;
>   			regulator-max-microvolt = <3400000>;
> +			regulator-allow-set-load;
>   		};
>   
>   		vreg_l24a_2p96: l24 {
> @@ -487,6 +492,60 @@ &tlmm {
>   			       <56 3>, <61 2>, <64 1>,
>   			       <68 1>, <72 8>, <96 1>;
>   
> +	uart3_default: uart3-default-state {
> +		cts-pins {
> +			pins = "gpio8";
> +			function = "qup3";
> +			bias-bus-hold;
> +		};
> +
> +		rts-pins {
> +			pins = "gpio9";
> +			function = "qup3";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		tx-pins {
> +			pins = "gpio10";
> +			function = "qup3";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		rx-pins {
> +			pins = "gpio11";
> +			function = "qup3";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	uart3_sleep: uart3-sleep-state {
> +		cts-pins {
> +			pins = "gpio8";
> +			function = "gpio";
> +			bias-bus-hold;
> +		};
> +
> +		rts-pins {
> +			pins = "gpio9";
> +			function = "gpio";
> +			bias-pull-down;
> +		};
> +
> +		tx-pins {
> +			pins = "gpio10";
> +			function = "gpio";
> +			bias-pull-up;
> +		};
> +
> +		rx-pins {
> +			pins = "gpio11";
> +			function = "gpio";
> +			bias-pull-up;
> +		};
> +	};
> +

My reading of downstream has all of these pins drive-strength = <2>.


>   	lt9611_rst_pin: lt9611-rst-state {
>   		pins = "gpio41";
>   		function = "gpio";
> @@ -508,6 +567,26 @@ sdc2_card_det_n: sd-card-det-n-state {
>   	};
>   };
>   
> +&uart3 {
> +	interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
> +	pinctrl-0 = <&uart3_default>;
> +	pinctrl-1 = <&uart3_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3988-bt";
> +
> +		vddio-supply = <&vreg_l9a_1p8>;
> +		vddxo-supply = <&vreg_l16a_1p3>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l23a_3p3>;
> +		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
> +		max-speed = <3200000>;
> +	};
> +};

Does firmware name not matter here ?

bluetooth {
     compatible = "qcom,wcn3990-bt";
     vddio-supply = <&vreg_s4a_1p8>;
     vddxo-supply = <&vreg_l7a_1p8>;
     vddrf-supply = <&vreg_l17a_1p3>;
     vddch0-supply = <&vreg_l25a_3p3>;
     max-speed = <3200000>;
     firmware-name = "crnv21.bin";
};

> +
>   &uart4 {
>   	status = "okay";
>   };

---
bod
