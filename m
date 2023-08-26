Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683D2789592
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHZJwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjHZJwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:52:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B8B1BDB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:52:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50043cf2e29so2519195e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693043530; x=1693648330;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcCJka8GaBPp1JWKaEMYYjB5JT7EHUSr4X2gpzZXC9g=;
        b=pnl4MhHP53c380d37z7A+ixNSi3Xr+ZO/n0gY/FXrhnuC3Tgt+qDvopTltBePdDHUK
         MZY6OBxHnj0arQ+GfS3Oi+bB0pO+g070Q3evp4v337aL81SHzFGrsmxr6RDSr/lng2zq
         hhlEk62QQmvgrySwPE+Z3AigeHBoXh0nSbilc3jPoraW4DexahW8l3U/PtNHZWINrWQh
         FxNzvqN+TFPnngqv+ipTyl2yDsMylinXUda4LVcsDXKAc2ZRtVJj1x6f9X75tb5uuKm0
         YbT7Zl1kmjEfNwHEZK6KPXiof0xYl/+LLenWTi8lsf4FkG9FPKHTxmzwMwbhNRmUOzVf
         FaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693043530; x=1693648330;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcCJka8GaBPp1JWKaEMYYjB5JT7EHUSr4X2gpzZXC9g=;
        b=HJuLF3PN1MCcCnyXKewlcvLreqB5WFASaDxrfA9AgpSpe05Bcn7QZdoh+H9Mria3W/
         utbD2xFejozszA/ll6GVgWnV9ZI/zJEwgjUZ6dW0WN9pOjtT7Spf7W5tB1OGIiXSVSkv
         46X3nSGAjL7Ofa2ghTXsUaBGakWoGCpT2c/8JSaU7CFgxUE3juegI002iyDPL8PI9EwT
         jU1GYqZviwvbeWjy5vAxXhYUD43m7w2cjtMLh0sNwG0KryRIH3SBAEAITisLFAEI5Ung
         iV8EnHmX5xkO4Uapag7ct4Hu1hs5dM1KVPnTyhW2an2xIFqxejvLr+Nt7TTnu8otX0bx
         quQA==
X-Gm-Message-State: AOJu0YyPuvX44RuXIVvWNtr0kMzje9Vn9URIZTu/6CqM7BVCuY88zdDc
        kfduFKLdLIsb5pwsyy0+XNUDrQ==
X-Google-Smtp-Source: AGHT+IH/6EoQPI/jxdprlMmW/GOjCqqBLDpSULcNdofMvV+kmS2E2NnKymyAllE0jIvAIGAZaKcl4A==
X-Received: by 2002:a19:791d:0:b0:4fd:cbd6:d2ff with SMTP id u29-20020a19791d000000b004fdcbd6d2ffmr12826691lfc.33.1693043529828;
        Sat, 26 Aug 2023 02:52:09 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id u8-20020ac25188000000b00500a44e158csm649584lfi.235.2023.08.26.02.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 02:52:09 -0700 (PDT)
Message-ID: <832569a3-096e-435e-8a60-c6a501fd385a@linaro.org>
Date:   Sat, 26 Aug 2023 11:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] ARM: dts: qcom: add common dt for MSM8x26 Lumias
 along with Nokia Lumia 630
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
        Jack Matthews <jm5112356@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20230813152623.64989-1-rayyan@ansari.sh>
 <20230813152623.64989-3-rayyan@ansari.sh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230813152623.64989-3-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.2023 17:23, Rayyan Ansari wrote:
> Add a common device tree for Lumia phones based on the Qualcomm MSM8x26
> family of chipsets.
> 
> Currently supports:
> - Framebuffer
> - Touchscreen
> - Keys
> - Regulators
> - MMC
> - USB
> - UART
> 
> Also add an initial device tree for the Nokia Lumia 630, codenamed
> "moneypenny".
> 
> Co-authored-by: Dominik Kobinski <dominikkobinski314@gmail.com>
> Co-authored-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Co-authored-by: Jack Matthews <jm5112356@gmail.com>
> Signed-off-by: Dominik Kobinski <dominikkobinski314@gmail.com>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Signed-off-by: Jack Matthews <jm5112356@gmail.com>
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  arch/arm/boot/dts/qcom/Makefile               |   1 +
>  .../qcom/qcom-msm8226-microsoft-common.dtsi   | 329 ++++++++++++++++++
>  .../qcom-msm8226-microsoft-moneypenny.dts     |  23 ++
>  3 files changed, 353 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
>  create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-moneypenny.dts
> 
> diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
> index 3dfb1c8cefb8..b2569059ce8d 100644
> --- a/arch/arm/boot/dts/qcom/Makefile
> +++ b/arch/arm/boot/dts/qcom/Makefile
> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-ipq4019-ap.dk07.1-c2.dtb \
>  	qcom-ipq8064-ap148.dtb \
>  	qcom-ipq8064-rb3011.dtb \
> +	qcom-msm8226-microsoft-moneypenny.dtb \
>  	qcom-msm8226-samsung-s3ve3g.dtb \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8916-samsung-e5.dtb \
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
> new file mode 100644
> index 000000000000..ddfe7965f564
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Common Board Device Tree for Microsoft MSM8x26-based Lumias
> + *
> + * Copyright (c) 2023, Jack Matthews <jm5112356@gmail.com>
> + * Copyright (c) 2023, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> + * Copyright (c) 2023, Dominik Kobinski <dominikkobinski314@gmail.com>
> + * Copyright (c) 2023, Rayyan Ansari <rayyan@ansari.sh>
> + */
> +
> +#include "qcom-msm8226.dtsi"
> +#include "qcom-pm8226.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/*
> + * Delete all generic (msm8226.dtsi) reserved
> + * memory mappings which are different on these devices.
> + */
> +/delete-node/ &smem_region;
> +
> +/ {
> +	aliases {
> +		mmc0 = &sdhc_1; /* eMMC */
> +		mmc1 = &sdhc_2; /* microSD */
> +		display0 = &framebuffer;
> +	};
> +
> +	chosen {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		stdout-path = "display0";
> +
> +		framebuffer: framebuffer@3200000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0x3200000 0x800000>;
> +			format = "a8r8g8b8";
> +			width = <720>;
> +			height = <1280>;
> +			stride = <(720 * 4)>;
> +
> +			clocks = <&mmcc MDSS_AHB_CLK>,
> +				 <&mmcc MDSS_AXI_CLK>,
> +				 <&mmcc MDSS_BYTE0_CLK>,
> +				 <&mmcc MDSS_MDP_CLK>,
> +				 <&mmcc MDSS_PCLK0_CLK>,
> +				 <&mmcc MDSS_VSYNC_CLK>;
> +			power-domains = <&mmcc MDSS_GDSC>;
> +		};
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&gpio_keys_default>;
> +		pinctrl-names = "default";
> +
> +		label = "GPIO Buttons";
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +	};
> +
> +	/*
> +	 * This device being a WP platform has a different
> +	 * memory layout than other Android based devices.
> +	 * This smem memory region is directly copied from
> +	 * the original UEFI firmware.
> +	 */
> +	reserved-memory {
> +		display_reserved: framebuffer@3200000 {
> +			reg = <0x3200000 0x800000>;
> +			no-map;
> +		};
> +
> +		smem_region: smem@fa00000 {
> +			reg = <0xfa00000 0x100000>;
Padding the addr field to 8 hex digits would make this easier to 
compare

[...]

> +	touchscreen_default: touchscreen-default-state {
> +		irq-pins {
> +			pins = "gpio17";
> +			function = "gpio";
> +
> +			drive-strength = <8>;
Drop newline above

Konrad
