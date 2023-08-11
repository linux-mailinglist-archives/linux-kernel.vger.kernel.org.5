Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC3779B04
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjHKXHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbjHKXG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:06:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D6F3A87
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:04:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so3860172e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691795097; x=1692399897;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2Nj9Q+jUF3n9s0S49LEtlCnC/RPAy6q3qfdqCcyvnI=;
        b=gXTxLTMkSo+G6VHKHlbSBxKEdzy4tQFT8TFJCpSgz83Jng9MC7HESHF/w/UbawCErs
         VvFm0lrK8DeOvEngrrryJITKNcXdBB7hnWSMyy1d2CfRtN8AAYVSU79JSet1eJFLC1AH
         LsScZv3IxO//BhfT21Pe6lkFHiQ1ZIAqH/RSGx7xZOp7KfBqmQriTX07Pn+Dqn2AwQGb
         5E3VzMY8Zcb6FnaxgqyWi80wHwQw5PBJVff3/bZC+AGDvmcLEqHLqui/AsItahYdciQD
         Dhxp1uSl7XGOaX0pjxQL2srUHsbLX4mXqsxKwPQ9csykUihd9Snfd4QU9W+TyV/iY7yc
         ChZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691795097; x=1692399897;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2Nj9Q+jUF3n9s0S49LEtlCnC/RPAy6q3qfdqCcyvnI=;
        b=VcgKq5uS6/sE/5v17sfopSWTiJ1V+SNESb2ALmCusSpIxiP81FelrXvQshtK5fByrk
         FD9L1himCiudbE9sbvrr7b24zOFU2w9AthzdExjY0pkwNoGk/uGxchTbew7r2id8DJ9T
         eOp15z7wDH76L6X3+DMguHd13MN8giATQT0FYsbgYHEwMfv4pW5ABR+61SNUCXvvfRaE
         fZQ1AcoNQkzud+xspT2u5SUPqNZ6I14XikUjDDZI0Ijf9PRa+Lt0YKXshu6a2ez5npdQ
         lFyX+6ocVZSWrr2stUgjdTzPAZYnwrlIoTKm29cqPy8tbY+aS05IediRHl7zhUTumKSf
         iNUA==
X-Gm-Message-State: AOJu0YxmzvhgQKMlTBcZQ6ISEzgv+t/qbHh9J6f7mp3/xPWGNGxaP5H5
        YHHOxtIE7ogOr8AAV5OW9cfoJQ==
X-Google-Smtp-Source: AGHT+IFxC1IwN0DrTwbKJ3zx8r5GJOBRmidXdIw8vvngWCf5x7p2oqs8eZHeS7UKgoGrtcWgCHe1ug==
X-Received: by 2002:a05:6512:15a6:b0:4fd:bd94:e6cb with SMTP id bp38-20020a05651215a600b004fdbd94e6cbmr2838951lfb.35.1691795096697;
        Fri, 11 Aug 2023 16:04:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id c26-20020a19761a000000b004fe3512e26dsm884105lff.291.2023.08.11.16.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 16:04:56 -0700 (PDT)
Message-ID: <e98d472f-8c56-400d-a45b-bcabae674d19@linaro.org>
Date:   Sat, 12 Aug 2023 01:04:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ARM: dts: qcom: add device tree for Nokia Lumia 830
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
References: <20230811213728.23726-1-rayyan@ansari.sh>
 <20230811213728.23726-8-rayyan@ansari.sh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230811213728.23726-8-rayyan@ansari.sh>
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

On 11.08.2023 23:35, Rayyan Ansari wrote:
> Add an initial device tree for the Nokia Lumia 830, codenamed
> "tesla".
> 
> Co-authored-by: Dominik Kobinski <dominikkobinski314@gmail.com>
> Co-authored-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Co-authored-by: Jack Matthews <jm5112356@gmail.com>
> Signed-off-by: Dominik Kobinski <dominikkobinski314@gmail.com>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> Signed-off-by: Jack Matthews <jm5112356@gmail.com>
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  arch/arm/boot/dts/qcom/Makefile               |  1 +
>  .../dts/qcom/qcom-msm8926-microsoft-tesla.dts | 66 +++++++++++++++++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-tesla.dts
> 
> diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
> index 7982620ec9f9..a3d293e40820 100644
> --- a/arch/arm/boot/dts/qcom/Makefile
> +++ b/arch/arm/boot/dts/qcom/Makefile
> @@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-msm8916-samsung-grandmax.dtb \
>  	qcom-msm8916-samsung-serranove.dtb \
>  	qcom-msm8926-microsoft-superman-lte.dtb \
> +	qcom-msm8926-microsoft-tesla.dtb \
>  	qcom-msm8960-cdp.dtb \
>  	qcom-msm8960-samsung-expressatt.dtb \
>  	qcom-msm8974-lge-nexus5-hammerhead.dtb \
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-tesla.dts b/arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-tesla.dts
> new file mode 100644
> index 000000000000..5a4f4687b895
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8926-microsoft-tesla.dts
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Jack Matthews <jm5112356@gmail.com>
> + * Copyright (c) 2023, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> + * Copyright (c) 2023, Dominik Kobinski <dominikkobinski314@gmail.com>
> + * Copyright (c) 2023, Rayyan Ansari <rayyan@ansari.sh>
> + */
> +
> +/dts-v1/;
> +
> +#include "qcom-msm8226-microsoft-common.dtsi"
> +
> +/ {
> +	model = "Nokia Lumia 830";
> +	compatible = "microsoft,tesla", "qcom,msm8926";
> +	chassis-type = "handset";
> +};
> +
> +&blsp1_i2c1 {
> +	status = "okay";
> +
> +	touchscreen@4b {
> +		compatible = "syna,rmi4-i2c";
> +		reg = <0x4b>;
> +
> +		interrupts-extended = <&tlmm 17 IRQ_TYPE_EDGE_FALLING>;
> +		vdd-supply = <&pm8226_l15>;
> +		vio-supply = <&pm8226_l6>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchscreen_on>;
flip

Konrad
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		rmi4-f01@1 {
> +			reg = <0x01>;
> +			syna,nosleep-mode = <1>;
> +		};
> +
> +		rmi4-f12@12 {
> +			reg = <0x12>;
> +			syna,sensor-type = <1>;
> +		};
> +	};
> +};
> +
> +&blsp1_i2c5 {
> +	status = "disabled";
> +
> +	/delete-node/ touchscreen@4b;
> +};
> +
> +&gpio_keys {
> +	camera-snapshot {
> +		label = "Camera Snapshot";
> +		gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
> +		linux,code = <KEY_CAMERA>;
> +	};
> +
> +	camera-focus {
> +		label = "Camera Focus";
> +		gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
> +		linux,code = <KEY_CAMERA_FOCUS>;
> +	};
> +};
