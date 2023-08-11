Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D57D779966
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbjHKV10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjHKV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:27:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3952132
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:27:20 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe55d70973so2806629e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691789239; x=1692394039;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u758WKQTO5GUDnf0K7rAUrjyTkS2QMgYR2+ucEsJwh4=;
        b=zXfdY4fKDjHbzBy0QU7MrG1tAwbxcthUK17mDMN61MXTntYxIQ6R9Ea/S7L1x+d0Vb
         YP6PdCVpkLS+M1jFTtoDoAEOijWQEO8ZOX1qJEcmhB5KdAsXmNk3GtLEMUlhbAOYXPhb
         ljvxw0Z676xGU4nnnP0jqCSkWcN0L7O2vRsmRbsduQ5ruTbR2CS4bdbsw/WROn8D+0Dj
         SjoN0qyg8Q5dz7H77962mwgxCB9+03twbEVmbX3TDThbHaV7RsFFEh+FGhmm3I11kBrD
         RWljonNOal7jMZF7r5CGieS+J9aWJocHSbAITejHa9LrkABoGujy/yGtll72zUMcad+7
         uKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789239; x=1692394039;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u758WKQTO5GUDnf0K7rAUrjyTkS2QMgYR2+ucEsJwh4=;
        b=W6B23coxMIuQ+/kCxzlaAsFAQan7hOaN+FZKZHc7HDUtWWbs6vUAkDe9Z2DeKVI2iI
         2YwpHlqGpUXiuUXCisRfydfomT8IT+pjK46ph5Ahh6Tjiir6F1hS9rRwSpkrC6LexQND
         wb94xXSuVWgKwFoK5TxwGlyDbQ+my70tUJJp9WtaxEMM7Vh7eMnpg/ttmGOCvr/++zib
         E5pfRntw6SKBuCNodxLrfAUx59oXmfVa+xkd7KSkoUP2the8iJY55hvXbM5FdxXtwPz2
         bHa6tMM5+S+ye2qO3B3E6HKNFlRURVGQ5m8AQpI/M721530gcWGDOgQQ7aGO4NlsxbC6
         JQPw==
X-Gm-Message-State: AOJu0Yy6mpUTsh2131sU/iaCqvk0hVrmw/dJ40kE1i0yx89iB7wXbliL
        05m80Zsfn7ivsAtpzMRDGmb4TA==
X-Google-Smtp-Source: AGHT+IGd0fxwlEl4sDLJ8cZoJ/h9vqafsYPjeCiP5El1Kx5hgBd8rx3R5yIF8ii8pliZPbjiR4UWZQ==
X-Received: by 2002:a05:6512:3e1f:b0:4fe:8ba8:1a8b with SMTP id i31-20020a0565123e1f00b004fe8ba81a8bmr1195688lfv.7.1691789238742;
        Fri, 11 Aug 2023 14:27:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id b16-20020ac25630000000b004fb7848bacbsm860713lff.46.2023.08.11.14.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:27:18 -0700 (PDT)
Message-ID: <52fada0e-eb54-48de-88a9-0747a15ed1ce@linaro.org>
Date:   Fri, 11 Aug 2023 23:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq4019-ap.dk01.1: use existing
 labels for nodes
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230811210142.403160-1-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230811210142.403160-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2023 23:01, Robert Marko wrote:
> All of the nodes under soc already have existing labels so use those
> instead.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
dtx_diff returns an empty diff, nice

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Couple further suggestions:

- wdog can probably enabled unconditionally
- same for blsp dma since there's only one host so it must be
  used by something
- same for crypto engine as it's a common piece of hw
- you can drop mux{}, pinmux{}, pinconf{} from pin nodes, just add
  the properties directly under the pin nodes
- this devicetree could use some schema warnings cleanup (make dtbs_check
  plus things like no underscores in node names)

Konrad
>  .../boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi | 140 +++++++++---------
>  1 file changed, 69 insertions(+), 71 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> index 0505270cf508..0714616c9e45 100644
> --- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
> @@ -27,87 +27,85 @@ aliases {
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +};
>  
> -	soc {
> -		rng@22000 {
> -			status = "okay";
> -		};
> +&prng {
> +	status = "okay";
> +};
>  
> -		pinctrl@1000000 {
> -			serial_pins: serial_pinmux {
> -				mux {
> -					pins = "gpio60", "gpio61";
> -					function = "blsp_uart0";
> -					bias-disable;
> -				};
> -			};
> -
> -			spi_0_pins: spi_0_pinmux {
> -				pinmux {
> -					function = "blsp_spi0";
> -					pins = "gpio55", "gpio56", "gpio57";
> -				};
> -				pinmux_cs {
> -					function = "gpio";
> -					pins = "gpio54";
> -				};
> -				pinconf {
> -					pins = "gpio55", "gpio56", "gpio57";
> -					drive-strength = <12>;
> -					bias-disable;
> -				};
> -				pinconf_cs {
> -					pins = "gpio54";
> -					drive-strength = <2>;
> -					bias-disable;
> -					output-high;
> -				};
> -			};
> +&tlmm {
> +	serial_pins: serial_pinmux {
> +		mux {
> +			pins = "gpio60", "gpio61";
> +			function = "blsp_uart0";
> +			bias-disable;
>  		};
> +	};
>  
> -		blsp_dma: dma-controller@7884000 {
> -			status = "okay";
> +	spi_0_pins: spi_0_pinmux {
> +		pinmux {
> +			function = "blsp_spi0";
> +			pins = "gpio55", "gpio56", "gpio57";
>  		};
> -
> -		spi@78b5000 {
> -			pinctrl-0 = <&spi_0_pins>;
> -			pinctrl-names = "default";
> -			status = "okay";
> -			cs-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
> -
> -			mx25l25635e@0 {
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				reg = <0>;
> -				compatible = "mx25l25635e";
> -				spi-max-frequency = <24000000>;
> -			};
> +		pinmux_cs {
> +			function = "gpio";
> +			pins = "gpio54";
>  		};
> -
> -		serial@78af000 {
> -			pinctrl-0 = <&serial_pins>;
> -			pinctrl-names = "default";
> -			status = "okay";
> +		pinconf {
> +			pins = "gpio55", "gpio56", "gpio57";
> +			drive-strength = <12>;
> +			bias-disable;
>  		};
> -
> -		cryptobam: dma-controller@8e04000 {
> -			status = "okay";
> +		pinconf_cs {
> +			pins = "gpio54";
> +			drive-strength = <2>;
> +			bias-disable;
> +			output-high;
>  		};
> +	};
> +};
>  
> -		crypto@8e3a000 {
> -			status = "okay";
> -		};
> +&blsp_dma {
> +	status = "okay";
> +};
>  
> -		watchdog@b017000 {
> -			status = "okay";
> -		};
> +&blsp1_spi1 {
> +	pinctrl-0 = <&spi_0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	cs-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
> +
> +	mx25l25635e@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0>;
> +		compatible = "mx25l25635e";
> +		spi-max-frequency = <24000000>;
> +	};
> +};
>  
> -		wifi@a000000 {
> -			status = "okay";
> -		};
> +&blsp1_uart1 {
> +	pinctrl-0 = <&serial_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
>  
> -		wifi@a800000 {
> -			status = "okay";
> -		};
> -	};
> +&cryptobam {
> +	status = "okay";
> +};
> +
> +&crypto {
> +	status = "okay";
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};
> +
> +&wifi0 {
> +	status = "okay";
> +};
> +
> +&wifi1 {
> +	status = "okay";
>  };
