Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E3C754978
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGOOrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGOOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:47:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE792D75
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:47:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso4883127e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689432421; x=1692024421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBiIV5yRUSXK9/Tmtk0eZ67pfuNRd1c36IPnTYs0nMA=;
        b=m8/NYRie8ClFzKyPjTV0lRQt+LWRKRGK/cNPGHVb8ICf+ip4BAQX/t1MbLDu8MxXTG
         4M3XQConV8VTJ5/S9E7mAqmgM+CC6h/ZDD30ulabJBcqFbanUq8SMaAW+yxauN0V3T5P
         kqqtRNk2G1aaguUAVdDXc7sWyIMMbt8eslrVEe5jiHm7yPlxE+FBpAO8fVyjbuhG5AMT
         QO+/xLuFY071wGQTbaciM84qVldWT7p0/owLgvCeLk01YAcXnBb6CAbzQhoCJh+tqG+D
         iUjWJthHOjySo2ICRmHG4VqK0s1IwDg/OYR4CogGJ56HcNLmE8H7b/GsEVj4hQipv9XH
         4tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689432421; x=1692024421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBiIV5yRUSXK9/Tmtk0eZ67pfuNRd1c36IPnTYs0nMA=;
        b=FynNEJ7MeUvnpupZ/AvQKlak0KhNw+e/0eGraBNMh1PDcGLULzcnoApKC6wpjQL6F+
         31UBu4o7bncChDdFMehnbnBdY4ErGuG1jKcTORb/4BSZ+YK5TFKbgY0DNn9SO8zFDwYN
         /Nh/UokGox9otTFoBgFsWJeL143oh6fhVtZrmpsfYpYGPtZpHuxRHG6T7ZGl/dG8JjZe
         gXwENDzWY/381BZsq0mEExCEqy4TqfWJiZWD7LzNSad+xXXURdTChDBKC2ByarRxFclh
         HjAqAVk7Fo4z9APcrPORu6/vD/ubKuqxxbEQxLmiBuBlXtPNWRwF+m2kq0bE5Pm/qzCL
         V+/Q==
X-Gm-Message-State: ABy/qLZ49056o2cdNSh2MWSaAyTFpF6kqymoZy4+lgUMrjx28ghfqR42
        al42MzFCnxE8pLP2kRMKWbvfWg==
X-Google-Smtp-Source: APBJJlH7OMe/at3HJZJnf0XHj10h/fsfknH04pC8Qv69Dbu3SxAoytbjm1BILa8D3pdM+pggLqC13g==
X-Received: by 2002:a05:6512:1320:b0:4fb:8ff3:1f72 with SMTP id x32-20020a056512132000b004fb8ff31f72mr5614119lfu.1.1689432421611;
        Sat, 15 Jul 2023 07:47:01 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id x15-20020ac25dcf000000b004f866200361sm1906525lfq.164.2023.07.15.07.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 07:47:01 -0700 (PDT)
Message-ID: <e601ade8-efc0-898b-79de-c2927765bf72@linaro.org>
Date:   Sat, 15 Jul 2023 16:46:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: Add support for the Xiaomi
 SM7125 platform
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org
References: <20230715091932.161507-1-davidwronek@gmail.com>
 <20230715091932.161507-8-davidwronek@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230715091932.161507-8-davidwronek@gmail.com>
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

On 15.07.2023 11:16, David Wronek wrote:
> There are 6 Xiaomi smartphones with the SM7125 SoC:
> 
> - POCO M2 Pro (gram)
> - Redmi Note 9S (curtana)
> - Redmi Note 9 Pro (Global, joyeuse)
> - Redmi Note 9 Pro (India, curtana)
> - Redmi Note 9 Pro Max (excalibur)
> - Redmi Note 10 Lite (curtana)
> 
> These devices share a common board design (a.k.a miatoll) with only a
> few differences. Add support for the common board, as well as support
> for the global Redmi Note 9 Pro.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
The copyright headers seem weird, but other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/sm7125-xiaomi-joyeuse.dts   |  16 +
>  .../boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi  | 423 ++++++++++++++++++
>  3 files changed, 440 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 337abc4ceb17..7ef9e7d43904 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -192,6 +192,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-xiaomi-laurel-sprout.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sm7125-xiaomi-joyeuse.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dts b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dts
> new file mode 100644
> index 000000000000..2b3d1ed1bcae
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sm7125-xiaomi-miatoll.dtsi"
> +
> +/ {
> +	model = "Xiaomi Redmi Note 9 Pro (Global)";
> +	compatible = "xiaomi,joyeuse", "qcom,sm7125";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,board-id = <0x50022 1>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi
> new file mode 100644
> index 000000000000..80073140e475
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/arm/qcom,ids.h>
> +#include <dt-bindings/firmware/qcom,scm.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm7125.dtsi"
> +#include "pm6150.dtsi"
> +#include "pm6150l.dtsi"
> +
> +/delete-node/ &ipa_fw_mem;
> +/delete-node/ &rmtfs_mem;
> +
> +/ {
> +	chassis-type = "handset";
> +
> +	qcom,msm-id = <QCOM_ID_SM7125 0>;
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		framebuffer@9c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0x0 0x9c000000 0x0 (1080 * 2400 * 4)>;
> +			width = <1080>;
> +			height = <2400>;
> +			stride = <(1080 * 4)>;
> +			format = "a8r8g8b8";
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
> +		};
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-vol-down {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm6150l_gpios 2 GPIO_ACTIVE_LOW>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +	};
> +
> +	reserved-memory {
> +		mpss_mem: memory@86000000 {
> +			reg = <0x0 0x86000000 0x0 0x8400000>;
> +			no-map;
> +		};
> +
> +		venus_mem: memory@8ee00000 {
> +			reg = <0x0 0x8ee00000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		cdsp_mem: memory@8f300000 {
> +			reg = <0x0 0x8f300000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: memory@91100000 {
> +			reg = <0x0 0x91100000 0x0 0x2800000>;
> +			no-map;
> +		};
> +
> +		wlan_mem: memory@93900000 {
> +			reg = <0x0 0x93900000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		ipa_fw_mem: memory@93b00000 {
> +			reg = <0x0 0x93b00000 0x0 0x10000>;
> +			no-map;
> +		};
> +
> +		gpu_mem: memory@93b15000 {
> +			reg = <0x0 0x93b15000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		cont_splash_mem: memory@9c000000 {
> +			reg = <0x0 0x9c000000 0x0 (1080 * 2400 * 4)>;
> +			no-map;
> +		};
> +
> +		pstore_mem: ramoops@9d800000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0x9d800000 0x0 0x400000>;
> +			record-size = <0x80000>;
> +			pmsg-size = <0x200000>;
> +			console-size = <0x100000>;
> +		};
> +
> +		rmtfs_mem: memory@fa601000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0x0 0xfa601000 0x0 0x200000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
> +		};
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pm6150-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vreg_s1a_1p1: smps1 {
> +			regulator-min-microvolt = <1128000>;
> +			regulator-max-microvolt = <1128000>;
> +		};
> +
> +		vreg_s4a_1p0: smps4 {
> +			regulator-min-microvolt = <824000>;
> +			regulator-max-microvolt = <1120000>;
> +		};
> +
> +		vreg_s5a_2p0: smps5 {
> +			regulator-min-microvolt = <1744000>;
> +			regulator-max-microvolt = <2040000>;
> +		};
> +
> +		vreg_l1a_1p2: ldo1 {
> +			regulator-min-microvolt = <1178000>;
> +			regulator-max-microvolt = <1256000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2a_1p0: ldo2 {
> +			regulator-min-microvolt = <944000>;
> +			regulator-max-microvolt = <1056000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3a_1p0: ldo3 {
> +			regulator-min-microvolt = <968000>;
> +			regulator-max-microvolt = <1064000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4a_0p88: ldo4 {
> +			regulator-min-microvolt = <824000>;
> +			regulator-max-microvolt = <928000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5a_2p7: ldo5 {
> +			regulator-min-microvolt = <2496000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6a_0p6: ldo6 {
> +			regulator-min-microvolt = <568000>;
> +			regulator-max-microvolt = <648000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9a_0p664: ldo9 {
> +			regulator-min-microvolt = <488000>;
> +			regulator-max-microvolt = <800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10a_1p8: ldo10 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1832000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11a_1p8: ldo11 {
> +			regulator-min-microvolt = <1696000>;
> +			regulator-max-microvolt = <1904000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-min-microvolt = <1696000>;
> +			regulator-max-microvolt = <1952000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13a_1p8: ldo13 {
> +			regulator-min-microvolt = <1696000>;
> +			regulator-max-microvolt = <1904000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14a_1p8: ldo14 {
> +			regulator-min-microvolt = <1728000>;
> +			regulator-max-microvolt = <1832000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l15a_1p8: ldo15 {
> +			regulator-min-microvolt = <1696000>;
> +			regulator-max-microvolt = <1904000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l16a_2p7: ldo16 {
> +			regulator-min-microvolt = <2496000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17a_3p1: ldo17 {
> +			regulator-min-microvolt = <2920000>;
> +			regulator-max-microvolt = <3232000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l18a_3p0: ldo18 {
> +			regulator-min-microvolt = <1696000>;
> +			regulator-max-microvolt = <1904000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l19a_3p0: ldo19 {
> +			regulator-min-microvolt = <2696000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pm6150l-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vreg_s8c_1p3: smps8 {
> +			regulator-min-microvolt = <1120000>;
> +			regulator-max-microvolt = <1408000>;
> +		};
> +
> +		vreg_l1c_1p8: ldo1 {
> +			regulator-min-microvolt = <1616000>;
> +			regulator-max-microvolt = <1984000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c_1p3: ldo2 {
> +			regulator-min-microvolt = <1168000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c_1p23: ldo3 {
> +			regulator-min-microvolt = <1144000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4c_1p8: ldo4 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5c_1p8: ldo5 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6c_3p0: ldo6 {
> +			regulator-min-microvolt = <1648000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7c_3p0: ldo7 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8c_1p8: ldo8 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1904000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9c_2p9: ldo9 {
> +			regulator-min-microvolt = <2952000>;
> +			regulator-max-microvolt = <3304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10c_3p3: ldo10 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3400000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11c_3p3: ldo11 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3400000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob: bob {
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +	};
> +};
> +
> +&dispcc {
> +	/* HACK: disable until a panel driver is ready to retain simplefb */
> +	status = "disabled";
> +};
> +
> +&pm6150_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +&pm6150_rtc {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 69 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default","sleep";
> +	pinctrl-0 = <&sdc2_on>;
> +	pinctrl-1 = <&sdc2_off>;
> +	vmmc-supply = <&vreg_l9c_2p9>;
> +	vqmmc-supply = <&vreg_l6c_3p0>;
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <34 4>, <59 4>;
> +
> +	sdc2_on: sdc2-on-state {
> +		clk-pins {
> +			pins = "sdc2_clk";
> +			bias-disable;
> +			drive-strength = <16>;
> +		};
> +
> +		cmd-pins {
> +			pins = "sdc2_cmd";
> +			bias-pull-up;
> +			drive-strength = <10>;
> +		};
> +
> +		data-pins {
> +			pins = "sdc2_data";
> +			bias-pull-up;
> +			drive-strength = <10>;
> +		};
> +
> +		sd-cd-pins {
> +			pins = "gpio69";
> +			function = "gpio";
> +			bias-pull-up;
> +			drive-strength = <2>;
> +		};
> +	};
> +
> +	sdc2_off: sdc2-off-state {
> +		clk-pins {
> +			pins = "sdc2_clk";
> +			bias-disable;
> +			drive-strength = <2>;
> +		};
> +
> +		cmd-pins {
> +			pins = "sdc2_cmd";
> +			bias-pull-up;
> +			drive-strength = <2>;
> +		};
> +
> +		data-pins {
> +			pins = "sdc2_data";
> +			bias-pull-up;
> +			drive-strength = <2>;
> +		};
> +
> +		sd-cd-pins {
> +			pins = "gpio69";
> +			function = "gpio";
> +			bias-pull-up;
> +			drive-strength = <2>;
> +		};
> +	};
> +};
> +
> +&usb_1 {
> +	qcom,select-utmi-as-pipe-clk;
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +	status = "okay";
> +};
> +
> +&usb_1_hsphy {
> +	vdd-supply = <&vreg_l4a_0p88>;
> +	vdda-phy-dpdm-supply = <&vreg_l17a_3p1>;
> +	vdda-pll-supply = <&vreg_l11a_1p8>;
> +	status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vreg_l4a_0p88>;
> +	vdda-pll-supply = <&vreg_l3c_1p23>;
> +	status = "okay";
> +};
