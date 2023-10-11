Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72A67C5B41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjJKSZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjJKSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:25:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9821394
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:25:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5033918c09eso216264e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697048744; x=1697653544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LSPSXBCe9GeJxSOIECJ3E4iExh9+akiVQgkBJ/++LA=;
        b=CsOF3gz0qczg7jxt+Ikoan8QFZWFiB5EiQC8AwbbN8MgP+nlvewWZ7Ki82nK8ty42D
         rl6i4DTLScXSWaVfUU1oWGTCkJtmzP5gu67L+Tifjg+1P1mwzdWVSwYtJIYX0N28BM/e
         NWdgHwrkteFccwNTQomjucxSkah9aKkdir1soeRaTKBxNyonTVCFwksntGnbQnxEXxgP
         He2q2ZUK9fE5y1hE0LzR0MKp+P7ypqRMbyyx7qVugQORn/j05dLTi8Q1fZIXQG6RA3A7
         hxzKKN6pHOloHz+peCR7PwQ66A+w3Yua2ml9n4Z/fVOr2MQ8PzOORAxI6+ZUKOjh3R2A
         Vktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048744; x=1697653544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LSPSXBCe9GeJxSOIECJ3E4iExh9+akiVQgkBJ/++LA=;
        b=jadmNVDkgUN6BWOa1IDiSH1uw2thPS/6nL+9lL53qCmVE17QpNurq/kQYkfwXjaL8o
         01Wvjs1WFCMWBkbJgNP4X5+bAN8936ftjtsGR3k5ceXn1wAqSoXzLF9zH8dI74G2uIaF
         TgR50/XiFj0nQCYJZQ47ycCQm6iMBwmFuiv/yHhYT4fWMsumK5BrYhbJhvCEeIZA5zwJ
         i0V6vEi7A2g7bGiC24YYlKCNhM74nzODZo67e9bkqGungqqqLybMvsHOMt0WJoUMcJ7o
         7jNQTdw/VAaZ4sUOIilDqcSm6OFxB0Uaf9WiFHGBy68STiEq0+AUtY/4fIZ+UiGDepFs
         gmtQ==
X-Gm-Message-State: AOJu0YwRZnJ7XOerT/HkP2mBawLKwKcxdCb7nRKdXb3kKo4vKfNsYwIQ
        39b28gzfQgyLakHlT/xNjheCmQ==
X-Google-Smtp-Source: AGHT+IFSeTsD3VFDAmToxngS0ZdZuSS/JGuu/58PMZ0mcdK8rhadsxy5+joYJYirCx61VlZJFXSMPw==
X-Received: by 2002:a05:6512:3b28:b0:500:7de4:300e with SMTP id f40-20020a0565123b2800b005007de4300emr24744334lfv.58.1697048743602;
        Wed, 11 Oct 2023 11:25:43 -0700 (PDT)
Received: from [172.30.204.35] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z10-20020ac24f8a000000b004fe2de20d88sm2372674lfs.232.2023.10.11.11.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 11:25:43 -0700 (PDT)
Message-ID: <5c992232-38f2-48e4-83b7-19212c328592@linaro.org>
Date:   Wed, 11 Oct 2023 20:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: qcom: Add support for HTC One Mini 2
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20231011-htc-memul-v1-0-76e57873190c@z3ntu.xyz>
 <20231011-htc-memul-v1-3-76e57873190c@z3ntu.xyz>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231011-htc-memul-v1-3-76e57873190c@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 19:02, Luca Weiss wrote:
> Add support for this smartphone based on the MSM8926 SoC, codenamed
> "memul".
> 
> Supported functionality:
> * Power & volume buttons
> * ADSP
> * Magnetometer
> * Accelerometer
> * Touchscreen
> * Vibrator
> * Internal storage
> * SD card
> * Charger
> * USB
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   arch/arm/boot/dts/qcom/Makefile                   |   1 +
>   arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts | 337 ++++++++++++++++++++++
>   2 files changed, 338 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
> index a3d293e40820..0cb272f4fa45 100644
> --- a/arch/arm/boot/dts/qcom/Makefile
> +++ b/arch/arm/boot/dts/qcom/Makefile
> @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>   	qcom-msm8916-samsung-e7.dtb \
>   	qcom-msm8916-samsung-grandmax.dtb \
>   	qcom-msm8916-samsung-serranove.dtb \
> +	qcom-msm8926-htc-memul.dtb \
>   	qcom-msm8926-microsoft-superman-lte.dtb \
>   	qcom-msm8926-microsoft-tesla.dtb \
>   	qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts b/arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts
> new file mode 100644
> index 000000000000..b848f0cce3b4
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8926-htc-memul.dts
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Luca Weiss <luca@z3ntu.xyz>
> + */
> +
> +/dts-v1/;
> +
> +#include "qcom-msm8226.dtsi"
> +#include "qcom-pm8226.dtsi"
> +
> +/delete-node/ &adsp_region;
> +/delete-node/ &smem_region;
> +
> +/ {
> +	model = "HTC One Mini 2";
> +	compatible = "htc,memul", "qcom,msm8926", "qcom,msm8226";
> +	chassis-type = "handset";
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-power {
> +			label = "Power";
> +			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_POWER>;
> +			debounce-interval = <15>;
> +		};
> +
> +		key-volume-down {
> +			label = "Volume Down";
> +			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			debounce-interval = <15>;
> +		};
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		unknown@5b00000 {
> +			reg = <0x05b00000 0x200000>;
> +			no-map;
> +		};
> +
> +		unknown@7a00000 {
> +			reg = <0x07a00000 0x100000>;
> +			no-map;
> +		};
> +
> +		mpss_region: mpss@8000000 {
> +			reg = <0x08000000 0x4f00000>;
> +			no-map;
> +		};
> +
> +		unknown@cf00000 {
> +			reg = <0x0cf00000 0x200000>;
> +			no-map;
> +		};
> +
> +		mba_region: mba@d100000 {
> +			reg = <0x0d100000 0x3a000>;
> +			no-map;
> +		};
> +
> +		wcnss_region: wcnss@d200000 {
> +			reg = <0x0d200000 0x650000>;
> +			no-map;
> +		};
> +
> +		adsp_region: adsp@dc00000 {
> +			reg = <0x0dc00000 0x1400000>;
> +			no-map;
> +		};
> +
> +		venus_region: venus@f500000 {
> +			reg = <0x0f500000 0x500000>;
> +			no-map;
> +		};
> +
> +		smem_region: smem@fa00000 {
> +			reg = <0x0fa00000 0x100000>;
> +			no-map;
> +		};
> +
> +		unknown@fc00000 {
> +			reg = <0x0fc00000 0xa00000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&adsp {
> +	status = "okay";
firmware-path?
[...]

> +		pm8226_s3: s3 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1350000>;
> +		};
Newline between subnodes, please

[...]

> +&smbb {
> +	qcom,fast-charge-safe-current = <1750000>;
> +	qcom,fast-charge-current-limit = <1750000>;
> +	qcom,fast-charge-safe-voltage = <4360000>;
> +	qcom,fast-charge-high-threshold-voltage = <4350000>;
> +	qcom,auto-recharge-threshold-voltage = <4300000>;
> +	qcom,minimum-input-voltage = <4300000>;
we had quickcharge in 2013? nice

Konrad
