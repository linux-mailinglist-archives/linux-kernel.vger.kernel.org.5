Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E07F85A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjKXVvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjKXVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:51:39 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5091BCF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:51:41 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-778ac9c898dso113486585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700862700; x=1701467500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Xm1xhJP3anJSFxpLoyZ1zzy/M/WgmhkKvuuwSDDJOk=;
        b=d10Wz9gL1sJsCFLrbQakoSMsQuYXcayJqPyG8TF0TWQ+rje2Sz03Q+b9Je8RevZUns
         C8LcHGbzWLJh4Uo1t9Xq0wvDRvOlFBaNyQS3XOAwMoeoyVUV0S9Qma+Zp7Qcsgdw3pcT
         eVQtXO+GvCElWXdPJW/BK704NlyMvnG/ijEtNlOjphnyk1vkuUXHcRIim+Tgd2yrKtLH
         KYea0ugfm3Ujjm5AuXjUYLd89L1miruWBDIchamTWqY6EKEAydQqAaD2fM8cwZOyKlKl
         VmuI7BxBFQMqnO/21KQXKlueB7pfjdp27ZJr0/UdzFDlwhKvuXxxG01FcuIWulVrLBHv
         a5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700862700; x=1701467500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xm1xhJP3anJSFxpLoyZ1zzy/M/WgmhkKvuuwSDDJOk=;
        b=OSEGU5zKINe62XujRLzcK/83ePDoEJn9MewFzRydzWuR26Z8OBHXuQfKJmgycBdEit
         yNI2zQUDW63AgpnAauUx0D62hfXN+9MQ4hfJET85ZkaUaw1h6YgBR3H87sT3aJ76LZyT
         7OZIX9qicpo8YuESM+1Pgq0yPESBdgvgivP8AJl8Thip1zG27lT2F8VWG+vwMSbl/OVK
         IZ3BL+45URCcKBNWXHhxAyowgtQoAGPDnGmKVnJ6/jq3kGQP7yZ4xEjiF2mjEmIGboDC
         uJDHeiE1leDDBB6j1EUTbtfR/EDfGzPdKpa5fsbRQE39T1visW0FSlDQ2xEFd+ZpcMCx
         0UXQ==
X-Gm-Message-State: AOJu0YzrPR/7bLrq8P97Lyy7kgBVEDMvenkGuFHrqUEhBzmXtTscT30+
        Gxd6Cf5S6dL5c684KZVE+jYzQg==
X-Google-Smtp-Source: AGHT+IEfksZYqlgEngDTt+qIgv/HKyzPyan2Hxv8nWEviEKMAT25v/HiaQuc2umbEooYPfmpfC8Qfw==
X-Received: by 2002:a05:620a:1b94:b0:778:8676:1dd9 with SMTP id dv20-20020a05620a1b9400b0077886761dd9mr4703045qkb.32.1700862699751;
        Fri, 24 Nov 2023 13:51:39 -0800 (PST)
Received: from ?IPV6:2003:e8:4710:ee01::f88? (p200300e84710ee010000000000000f88.dip0.t-ipconnect.de. [2003:e8:4710:ee01::f88])
        by smtp.gmail.com with ESMTPSA id ro13-20020a05620a398d00b0077d74f884d9sm1420142qkn.117.2023.11.24.13.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 13:51:39 -0800 (PST)
Message-ID: <35c8a100-79a1-4071-a038-36398a298e2f@linaro.org>
Date:   Fri, 24 Nov 2023 21:51:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: Add base qcs6490-rb3gen2 board
 dts
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naina Mehta <quic_nainmeht@quicinc.com>
References: <20231124121305.1954-1-quic_kbajaj@quicinc.com>
 <20231124121305.1954-4-quic_kbajaj@quicinc.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231124121305.1954-4-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/11/2023 12:13, Komal Bajaj wrote:
> Add DTS for Qualcomm qcs6490-rb3gen2 board which uses
> QCS6490 SoC. This adds debug uart and usb support along
> with regulators found on this board.
> 
> Co-developed-by: Naina Mehta <quic_nainmeht@quicinc.com>
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/Makefile            |   1 +
>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 452 +++++++++++++++++++
>   2 files changed, 453 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 77babebe4904..4c0f9e4a2e5b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -90,6 +90,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-fairphone-fp5.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-idp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> new file mode 100644
> index 000000000000..0beab54c051e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -0,0 +1,452 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +/* PM7250B is configured to use SID8/9 */
> +#define PM7250B_SID 8
> +#define PM7250B_SID1 9
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sc7280.dtsi"
> +#include "pm7250b.dtsi"
> +#include "pm7325.dtsi"
> +#include "pm8350c.dtsi"
> +#include "pmk8350.dtsi"
> +
> +/delete-node/ &ipa_fw_mem;
> +/delete-node/ &remoteproc_mpss;
> +/delete-node/ &rmtfs_mem;
> +/delete-node/ &video_mem;
> +/delete-node/ &wlan_ce_mem;
> +/delete-node/ &xbl_mem;
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Robotics RB3gen2";
> +	compatible = "qcom,qcs6490-rb3gen2", "qcom,qcm6490";
> +	chassis-type = "embedded";
> +
> +	aliases {
> +		serial0 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reserved-memory {
> +		xbl_mem: xbl@80700000 {
> +			reg = <0x0 0x80700000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		cdsp_secure_heap_mem: cdsp-secure-heap@81800000 {
> +			reg = <0x0 0x81800000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		camera_mem: camera@84300000 {
> +			reg = <0x0 0x84300000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		wpss_mem: wpss@84800000 {
> +			reg = <0x0 0x84800000 0x0 0x1900000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: adsp@86100000 {
> +			reg = <0x0 0x86100000 0x0 0x2800000>;
> +			no-map;
> +		};
> +
> +		cdsp_mem: cdsp@88900000 {
> +			reg = <0x0 0x88900000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		video_mem: video@8a700000 {
> +			reg = <0x0 0x8a700000 0x0 0x700000>;
> +			no-map;
> +		};
> +
> +		cvp_mem: cvp@8ae00000 {
> +			reg = <0x0 0x8ae00000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		ipa_fw_mem: ipa-fw@8b300000 {
> +			reg = <0x0 0x8b300000 0x0 0x10000>;
> +			no-map;
> +		};
> +
> +		ipa_gsi_mem: ipa-gsi@8b310000 {
> +			reg = <0x0 0x8b310000 0x0 0xa000>;
> +			no-map;
> +		};
> +
> +		gpu_microcode_mem: gpu-microcode@8b31a000 {
> +			reg = <0x0 0x8b31a000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		tz_stat_mem: tz-stat@c0000000 {
> +			reg = <0x0 0xc0000000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		tags_mem: tags@c0100000 {
> +			reg = <0x0 0xc0100000 0x0 0x1200000>;
> +			no-map;
> +		};
> +
> +		qtee_mem: qtee@c1300000 {
> +			reg = <0x0 0xc1300000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		trusted_apps_mem: trusted_apps@c1800000 {
> +			reg = <0x0 0xc1800000 0x0 0x1c00000>;
> +			no-map;
> +		};
> +
> +		debug_vm_mem: debug-vm@d0600000 {
> +			reg = <0x0 0xd0600000 0x0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <4350000>;
> +	};
> +};
> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pm7325-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-l1-l4-l12-l15-supply = <&vreg_s7b_0p972>;
> +		vdd-l2-l7-supply = <&vreg_bob_3p296>;
> +		vdd-l3-supply = <&vreg_s2b_0p876>;
> +		vdd-l5-supply = <&vreg_s2b_0p876>;
> +		vdd-l6-l9-l10-supply = <&vreg_s8b_1p272>;
> +		vdd-l8-supply = <&vreg_s7b_0p972>;
> +		vdd-l11-l17-l18-l19-supply = <&vreg_s1b_1p872>;
> +		vdd-l13-supply = <&vreg_s7b_0p972>;
> +		vdd-l14-l16-supply = <&vreg_s8b_1p272>;
> +
> +		vreg_s1b_1p872: smps1 {
> +			regulator-min-microvolt = <1840000>;
> +			regulator-max-microvolt = <2040000>;
> +		};
> +
> +		vreg_s2b_0p876: smps2 {
> +			regulator-min-microvolt = <570070>;
> +			regulator-max-microvolt = <1050000>;
> +		};
> +
> +		vreg_s7b_0p972: smps7 {
> +			regulator-min-microvolt = <535000>;
> +			regulator-max-microvolt = <1120000>;
> +		};
> +
> +		vreg_s8b_1p272: smps8 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1500000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_RET>;
> +		};
> +
> +		vreg_l1b_0p912: ldo1 {
> +			regulator-min-microvolt = <825000>;
> +			regulator-max-microvolt = <925000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2b_3p072: ldo2 {
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3b_0p504: ldo3 {
> +			regulator-min-microvolt = <312000>;
> +			regulator-max-microvolt = <910000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4b_0p752: ldo4 {
> +			regulator-min-microvolt = <752000>;
> +			regulator-max-microvolt = <820000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		reg_l5b_0p752: ldo5 {
> +			regulator-min-microvolt = <552000>;
> +			regulator-max-microvolt = <832000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6b_1p2: ldo6 {
> +			regulator-min-microvolt = <1140000>;
> +			regulator-max-microvolt = <1260000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7b_2p952: ldo7 {
> +			regulator-min-microvolt = <2400000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8b_0p904: ldo8 {
> +			regulator-min-microvolt = <870000>;
> +			regulator-max-microvolt = <970000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9b_1p2: ldo9 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11b_1p504: ldo11 {
> +			regulator-min-microvolt = <1504000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12b_0p751: ldo12 {
> +			regulator-min-microvolt = <751000>;
> +			regulator-max-microvolt = <824000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13b_0p53: ldo13 {
> +			regulator-min-microvolt = <530000>;
> +			regulator-max-microvolt = <824000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14b_1p08: ldo14 {
> +			regulator-min-microvolt = <1080000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l15b_0p765: ldo15 {
> +			regulator-min-microvolt = <765000>;
> +			regulator-max-microvolt = <1020000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l16b_1p1: ldo16 {
> +			regulator-min-microvolt = <1100000>;
> +			regulator-max-microvolt = <1300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l17b_1p7: ldo17 {
> +			regulator-min-microvolt = <1700000>;
> +			regulator-max-microvolt = <1900000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l18b_1p8: ldo18 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l19b_1p8: ldo19 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	regulators-1 {
> +		compatible = "qcom,pm8350c-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-s9-supply = <&vph_pwr>;
> +		vdd-s10-supply = <&vph_pwr>;
> +		vdd-l1-l12-supply = <&vreg_s1b_1p872>;
> +		vdd-l2-l8-supply = <&vreg_s1b_1p872>;
> +		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob_3p296>;
> +		vdd-l6-l9-l11-supply = <&vreg_bob_3p296>;
> +		vdd-l10-supply = <&vreg_s7b_0p972>;
> +		vdd-bob-supply = <&vph_pwr>;
> +
> +		vreg_s1c_2p19: smps1 {
> +			regulator-min-microvolt = <2190000>;
> +			regulator-max-microvolt = <2210000>;
> +		};
> +
> +		vreg_s2c_0p752: smps2 {
> +			regulator-min-microvolt = <750000>;
> +			regulator-max-microvolt = <800000>;
> +		};
> +
> +		vreg_s5c_0p752: smps5 {
> +			regulator-min-microvolt = <465000>;
> +			regulator-max-microvolt = <1050000>;
> +		};
> +
> +		vreg_s7c_0p752: smps7 {
> +			regulator-min-microvolt = <465000>;
> +			regulator-max-microvolt = <800000>;
> +		};
> +
> +		vreg_s9c_1p084: smps9 {
> +			regulator-min-microvolt = <1010000>;
> +			regulator-max-microvolt = <1170000>;
> +		};
> +
> +		vreg_l1c_1p8: ldo1 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1980000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c_1p62: ldo2 {
> +			regulator-min-microvolt = <1620000>;
> +			regulator-max-microvolt = <1980000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c_2p8: ldo3 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3540000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l4c_1p62: ldo4 {
> +			regulator-min-microvolt = <1620000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5c_1p62: ldo5 {
> +			regulator-min-microvolt = <1620000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l6c_2p96: ldo6 {
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7c_3p0: ldo7 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8c_1p62: ldo8 {
> +			regulator-min-microvolt = <1620000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9c_2p96: ldo9 {
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <35440000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l10c_0p88: ldo10 {
> +			regulator-min-microvolt = <720000>;
> +			regulator-max-microvolt = <1050000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11c_2p8: ldo11 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12c_1p65: ldo12 {
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13c_2p7: ldo13 {
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_bob_3p296: bob {
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3960000>;
> +		};
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <32 2>, /* ADSP */
> +			       <48 4>; /* NFC */
> +};
> +
> +&uart5 {
> +	compatible = "qcom,geni-debug-uart";
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_1_hsphy {
> +	vdda-pll-supply = <&vreg_l10c_0p88>;
> +	vdda33-supply = <&vreg_l2b_3p072>;
> +	vdda18-supply = <&vreg_l1c_1p8>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vreg_l6b_1p2>;
> +	vdda-pll-supply = <&vreg_l1b_0p912>;
> +
> +	status = "okay";
> +};
> +
> +&wifi {
> +	memory-region = <&wlan_fw_mem>;
> +};
> --
> 2.42.0
> 
> 

-- 
// Caleb (they/them)
