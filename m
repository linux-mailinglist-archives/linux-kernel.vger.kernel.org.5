Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2621D7F0E69
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjKTJFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjKTJFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:05:08 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC64B9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:05:02 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50a938dda08so5850703e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700471100; x=1701075900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3mwRoBHU+mIoEx5T4OrV3FDOsPOEAWYHGCGx5RMjVk=;
        b=EKpTFNTSjMtHkQUPTIKFk+uxQS7uuXCFVjvEPRHE0PRYMala0ECFUCSgS6nU6P83P8
         Yb1mw8UgzkPk8DQFWpJO3ilGi9CusQNlKbyziRyeyj1lgnWqfM1YX1rnEjmFhWCRaypq
         7z284UY8iOPcNbJUJkUwTD/yVQiJ1rN1jddBqy+h8vKH+o0rPeCyH7bJ+MrGMJaIkhaq
         DOV3as8LWtL3S7cjRZ1RlcqkS5SAhO+38Kd6S7dudo+gIBOmv/Ks/VLWR0/+6IqNwtkN
         0aMbZchPQQd1Vox3QKf29xLUBQWaox/se/hLofluu9NgyX1kZNH7fAEyi/RR4kA3yLda
         ihPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471100; x=1701075900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3mwRoBHU+mIoEx5T4OrV3FDOsPOEAWYHGCGx5RMjVk=;
        b=QD4XioTpxwwalY6Pud7KN7al1pq+Lb0W/HoNF3xzxjv7sHYcYa8U2ajAwWl9BSE6gP
         /losoX58b0YdF4n2cE/GaLdSwpyzcxgioUAFh+Pfx5NysHw9iFpEm8vBuPUuTk6dMnwL
         /qrlsekq2eSv9K7c4ejklFIEQa57sqw4tpPE19LBE3avSoDHqV4/e5qoSkEZ3r9+18St
         lRzY8usJkvDcEgBcHqHNF4KKH6L/po/0tld9ijLoX24M3DVF3Vx5P3WUalNSPh+BGElt
         cyaslqNMHBaIGJC7r9d7ejnhCeZvDUVZlZQmBdgCMmKhsBV3rhryNkfxy/8Prt9Ri7ko
         Anig==
X-Gm-Message-State: AOJu0YyDMywDIQFmrWqhdyRrP3Nx6AZbm9LZnI15eEOYM+uKizl9T/7Y
        cgfz9jFAPd9Csu341ew+Xmau5A==
X-Google-Smtp-Source: AGHT+IE/FkUGvUsVMC9xq0GOW+nf1mwTvvlaPqrNu9KvJnsZlqLLTpbldlHI+HW2DtnkLLVujo9k8A==
X-Received: by 2002:ac2:51ad:0:b0:509:5d4b:742f with SMTP id f13-20020ac251ad000000b005095d4b742fmr4502483lfk.20.1700471100391;
        Mon, 20 Nov 2023 01:05:00 -0800 (PST)
Received: from linaro.org ([5.12.73.111])
        by smtp.gmail.com with ESMTPSA id b15-20020a056000054f00b0031980294e9fsm10491061wrf.116.2023.11.20.01.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 01:04:59 -0800 (PST)
Date:   Mon, 20 Nov 2023 11:04:58 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        ulf.hansson@linaro.org, agross@kernel.org, conor+dt@kernel.org,
        ayan.kumar.halder@amd.com, j@jannau.net,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com,
        lpieralisi@kernel.org, quic_rjendra@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_tsoni@quicinc.com, neil.armstrong@linaro.org
Subject: Re: [PATCH V2 4/5] arm64: dts: qcom: x1e80100: Add Compute Reference
 Device
Message-ID: <ZVshOsDYUJ8OFfc2@linaro.org>
References: <20231117113931.26660-1-quic_sibis@quicinc.com>
 <20231117113931.26660-5-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117113931.26660-5-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-17 17:09:30, Sibi Sankar wrote:
> Add basic support for X1E80100 CRD board dts, which allows it to boot
> to a shell.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

You dropped the initial authorship here. Please fix and re-send.

Thanks,
Abel

> 
> v2:
> * Update the part number from sc8380xp to x1e80100.
> * Override the serial uart with "qcom,geni-debug-uart" in the board files. [Rajendra]
> * Document reserved gpios. [Konrad]
> 
>  arch/arm64/boot/dts/qcom/Makefile         |   1 +
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 425 ++++++++++++++++++++++
>  2 files changed, 426 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 43bd9fcf35e5..e3ab1c91307a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -231,4 +231,5 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-qcp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> new file mode 100644
> index 000000000000..82d1ecac0ec9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "x1e80100.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. X1E80100 CRD";
> +	compatible = "qcom,x1e80100-crd", "qcom,x1e80100";
> +
> +	aliases {
> +		serial0 = &uart21;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vreg_edp_3p3: regulator-edp-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_EDP_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 70 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&edp_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pm8550-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vdd-bob1-supply = <&vph_pwr>;
> +		vdd-bob2-supply = <&vph_pwr>;
> +		vdd-l1-supply = <&vreg_s4c_1p8>;
> +		vdd-l2-l13-l14-supply = <&vreg_bob1>;
> +		vdd-l4-supply = <&vreg_s4c_1p8>;
> +		vdd-l5-l16-supply = <&vreg_bob1>;
> +		vdd-l6-l7-supply = <&vreg_bob2>;
> +		vdd-l8-l9-supply = <&vreg_bob1>;
> +		vdd-l10-supply = <&vreg_s4c_1p8>;
> +		vdd-l12-supply = <&vreg_s5j_1p2>;
> +		vdd-l15-supply = <&vreg_s4c_1p8>;
> +		vdd-l17-supply = <&vreg_bob2>;
> +
> +		vreg_bob1: bob1 {
> +			regulator-name = "vreg_bob1";
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob2: bob2 {
> +			regulator-name = "vreg_bob2";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <3008000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1b_1p8: ldo1 {
> +			regulator-name = "vreg_l1b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2b_3p0: ldo2 {
> +			regulator-name = "vreg_l2b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4b_1p8: ldo4 {
> +			regulator-name = "vreg_l4b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5b_3p0: ldo5 {
> +			regulator-name = "vreg_l5b_3p0";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6b_1p8: ldo6 {
> +			regulator-name = "vreg_l6b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7b_2p8: ldo7 {
> +			regulator-name = "vreg_l7b_2p8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8b_3p0: ldo8 {
> +			regulator-name = "vreg_l8b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9b_2p9: ldo9 {
> +			regulator-name = "vreg_l9b_2p9";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10b_1p8: ldo10 {
> +			regulator-name = "vreg_l10b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12b_1p2: ldo12 {
> +			regulator-name = "vreg_l12b_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13b_3p0: ldo13 {
> +			regulator-name = "vreg_l13b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14b_3p0: ldo14 {
> +			regulator-name = "vreg_l14b_3p0";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l15b_1p8: ldo15 {
> +			regulator-name = "vreg_l15b_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l16b_2p9: ldo16 {
> +			regulator-name = "vreg_l16b_2p9";
> +			regulator-min-microvolt = <2912000>;
> +			regulator-max-microvolt = <2912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17b_2p5: ldo17 {
> +			regulator-name = "vreg_l17b_2p5";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vdd-l1-supply = <&vreg_s5j_1p2>;
> +		vdd-l2-supply = <&vreg_s1f_0p7>;
> +		vdd-l3-supply = <&vreg_s1f_0p7>;
> +		vdd-s4-supply = <&vph_pwr>;
> +
> +		vreg_s4c_1p8: smps4 {
> +			regulator-name = "vreg_s4c_1p8";
> +			regulator-min-microvolt = <1856000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1c_1p2: ldo1 {
> +			regulator-name = "vreg_l1c_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c_0p8: ldo2 {
> +			regulator-name = "vreg_l2c_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c_0p8: ldo3 {
> +			regulator-name = "vreg_l3c_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-2 {
> +		compatible = "qcom,pmc8380-rpmh-regulators";
> +		qcom,pmic-id = "d";
> +
> +		vdd-l1-supply = <&vreg_s1f_0p7>;
> +		vdd-l2-supply = <&vreg_s1f_0p7>;
> +		vdd-l3-supply = <&vreg_s4c_1p8>;
> +		vdd-s1-supply = <&vph_pwr>;
> +
> +		vreg_l1d_0p8: ldo1 {
> +			regulator-name = "vreg_l1d_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2d_0p9: ldo2 {
> +			regulator-name = "vreg_l2d_0p9";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3d_1p8: ldo3 {
> +			regulator-name = "vreg_l3d_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-3 {
> +		compatible = "qcom,pmc8380-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vdd-l2-supply = <&vreg_s1f_0p7>;
> +		vdd-l3-supply = <&vreg_s5j_1p2>;
> +
> +		vreg_l2e_0p8: ldo2 {
> +			regulator-name = "vreg_l2e_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3e_1p2: ldo3 {
> +			regulator-name = "vreg_l3e_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-4 {
> +		compatible = "qcom,pmc8380-rpmh-regulators";
> +		qcom,pmic-id = "f";
> +
> +		vdd-l1-supply = <&vreg_s5j_1p2>;
> +		vdd-l2-supply = <&vreg_s5j_1p2>;
> +		vdd-l3-supply = <&vreg_s5j_1p2>;
> +		vdd-s1-supply = <&vph_pwr>;
> +
> +		vreg_s1f_0p7: smps1 {
> +			regulator-name = "vreg_s1f_0p7";
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1f_1p0: ldo1 {
> +			regulator-name = "vreg_l1f_1p0";
> +			regulator-min-microvolt = <1024000>;
> +			regulator-max-microvolt = <1024000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2f_1p0: ldo2 {
> +			regulator-name = "vreg_l2f_1p0";
> +			regulator-min-microvolt = <1024000>;
> +			regulator-max-microvolt = <1024000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3f_1p0: ldo3 {
> +			regulator-name = "vreg_l3f_1p0";
> +			regulator-min-microvolt = <1024000>;
> +			regulator-max-microvolt = <1024000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-6 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "i";
> +
> +		vdd-l1-supply = <&vreg_s4c_1p8>;
> +		vdd-l2-supply = <&vreg_s5j_1p2>;
> +		vdd-l3-supply = <&vreg_s1f_0p7>;
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +
> +		vreg_s1i_0p9: smps1 {
> +			regulator-name = "vreg_s1i_0p9";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s2i_1p0: smps2 {
> +			regulator-name = "vreg_s2i_1p0";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1i_1p8: ldo1 {
> +			regulator-name = "vreg_l1i_1p8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2i_1p2: ldo2 {
> +			regulator-name = "vreg_l2i_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3i_0p8: ldo3 {
> +			regulator-name = "vreg_l3i_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-7 {
> +		compatible = "qcom,pm8550ve-rpmh-regulators";
> +		qcom,pmic-id = "j";
> +
> +		vdd-l1-supply = <&vreg_s1f_0p7>;
> +		vdd-l2-supply = <&vreg_s5j_1p2>;
> +		vdd-l3-supply = <&vreg_s1f_0p7>;
> +		vdd-s5-supply = <&vph_pwr>;
> +
> +		vreg_s5j_1p2: smps5 {
> +			regulator-name = "vreg_s5j_1p2";
> +			regulator-min-microvolt = <1256000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l1j_0p8: ldo1 {
> +			regulator-name = "vreg_l1j_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2j_1p2: ldo2 {
> +			regulator-name = "vreg_l2j_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3j_0p8: ldo3 {
> +			regulator-name = "vreg_l3j_0p8";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <920000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +};
> +
> +&qupv3_2 {
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <34 2>, <44 4>, /* SPI (TPM) */
> +			       <238 1>; /* UFS Reset */
> +
> +	edp_reg_en: edp-reg-en-state {
> +		pins = "gpio70";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-disable;
> +	};
> +};
> +
> +&uart21 {
> +	compatible = "qcom,geni-debug-uart";
> +	status = "okay";
> +};
> -- 
> 2.17.1
> 
