Return-Path: <linux-kernel+bounces-5013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2B818548
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC76D1F234D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858914A8C;
	Tue, 19 Dec 2023 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MyNIwD7R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DC14A87
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e7f0bf46a2so2023427b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702981511; x=1703586311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQkLzO626rTKTPxyLCwwXu05HLGx0XuKfJBitLo7Iug=;
        b=MyNIwD7ReWHz/0BA+jbbcO8DDo5pBKK77Dk7EP1TjhPU2MZTXkTYtNA02gLvrqWjAV
         1hDJcHLsMl+dkaQz62GO/9TsDwMOqiGsp7hMDXDpEb86G6IKMEypt3S7veDuIZ2cpAzM
         oiR0Cqw1WVRHmO9l0rq4Pu4nJGl7V68y+Ijd0NgO72+zSKcT4VfkIJhM5DG5IJXxblNP
         TfmDPivvJ+zcPJZTG33OcVXDAglQMUaei8UoxZl1ALlfFqK03sQU8vtvrHIyNNLj3F+V
         kO9oZ7UnTTLlgpwty1xQqf7eFqxZ5D2hTxSRoF6l/giGecsb0nBY5GILBY6VqcYdjX2t
         eO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702981511; x=1703586311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQkLzO626rTKTPxyLCwwXu05HLGx0XuKfJBitLo7Iug=;
        b=lb7HvnGVxNXxPHgxvbXMJWkyoEJcNaCdaw44Ur44N8TOEl9J43F+Y4IK0GbJOhjnmo
         JiAHyTVBC7hcRh1Xyl+5ZO+pr1+LosvCUsvx7syEM+052lF8JH8YrHA8B1lLDM0A1o+E
         6nwI1fdvrYwHXW2O2k3sWAst6wJvUKei/AAgxfKu4OVqkCEP3CN0W0WjuLpNY/Giu/ry
         DW9Uzm+WMxKvrO/qOWZjPcngjOeerbppwNdmAHfhq/hCdvrUfWXc0g9WQNOW7b/xHjF+
         BX8P6ZnLco1RdfoSevG5fzfYMX1YXL1CGLV/F+RaubAlhCmXrI/ojVWwtNu9IPeiWjL2
         Z8ww==
X-Gm-Message-State: AOJu0YxB5y2F9xq+uYEIQLFvcbGVwXgX47SNmP8XEMjLh5sMxg9YGVt9
	bkVIWJAmHEgzUn1CCJRoEOrmhfoljnSiuyrSjOlFiQ==
X-Google-Smtp-Source: AGHT+IG6YUYh5bBvnMde2o0Is+53jbog/hQgx1UKgZEExzAYD/oXfO+pI8x0Vj9xF5m8Snle4XjXyvmuRlGhJ220/NM=
X-Received: by 2002:a0d:cc13:0:b0:5e7:fb2e:6f70 with SMTP id
 o19-20020a0dcc13000000b005e7fb2e6f70mr164292ywd.87.1702981511122; Tue, 19 Dec
 2023 02:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219005007.11644-1-quic_tengfan@quicinc.com> <20231219005007.11644-6-quic_tengfan@quicinc.com>
In-Reply-To: <20231219005007.11644-6-quic_tengfan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Dec 2023 12:25:00 +0200
Message-ID: <CAA8EJpoBuUVu00-s6uVJpYWB2Bvn2VnJqV8b9CicMfgvfokxdg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: add base AIM300 dtsi
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fenglin Wu <quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 02:52, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
> AIM300 is a module with QCS8550 SoC, UFS and PMIC chip.
> AIM300 Series is a highly optimized family of modules designed to support
> AIoT applications. The Module is mounted onto Qualcomm AIoT carrier board
> to support verification, evaluation and development.
>
> Co-developed-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi | 371 +++++++++++++++++++
>  1 file changed, 371 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
> new file mode 100644
> index 000000000000..04ca4597f952
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "qcs8550.dtsi"
> +#include "pm8010.dtsi"
> +#include "pm8550.dtsi"
> +#include "pm8550b.dtsi"
> +#define PMK8550VE_SID 5
> +#include "pm8550ve.dtsi"
> +#include "pm8550vs.dtsi"
> +#include "pmk8550.dtsi"
> +#include "pmr735d_a.dtsi"
> +#include "pmr735d_b.dtsi"
> +
> +/ {
> +       vph_pwr: vph-pwr-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vph_pwr";
> +               regulator-min-microvolt = <3700000>;
> +               regulator-max-microvolt = <3700000>;
> +
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +};

Is VPH_PWR regulator present on the SoM or on the carrier board?

> +
> +&apps_rsc {
> +       regulators-0 {
> +               compatible = "qcom,pm8550-rpmh-regulators";
> +               qcom,pmic-id = "b";
> +
> +               vdd-bob1-supply = <&vph_pwr>;
> +               vdd-bob2-supply = <&vph_pwr>;
> +               vdd-l1-l4-l10-supply = <&vreg_s6g_1p86>;
> +               vdd-l2-l13-l14-supply = <&vreg_bob1>;
> +               vdd-l3-supply = <&vreg_s4g_1p25>;
> +               vdd-l5-l16-supply = <&vreg_bob1>;
> +               vdd-l6-l7-supply = <&vreg_bob1>;
> +               vdd-l8-l9-supply = <&vreg_bob1>;
> +               vdd-l11-supply = <&vreg_s4g_1p25>;
> +               vdd-l12-supply = <&vreg_s6g_1p86>;
> +               vdd-l15-supply = <&vreg_s6g_1p86>;
> +               vdd-l17-supply = <&vreg_bob2>;
> +
> +               vreg_bob1: bob1 {
> +                       regulator-name = "vreg_bob1";
> +                       regulator-min-microvolt = <3296000>;
> +                       regulator-max-microvolt = <3960000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_bob2: bob2 {
> +                       regulator-name = "vreg_bob2";
> +                       regulator-min-microvolt = <2720000>;
> +                       regulator-max-microvolt = <3960000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l1b_1p8: ldo1 {
> +                       regulator-name = "vreg_l1b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2b_3p0: ldo2 {
> +                       regulator-name = "vreg_l2b_3p0";
> +                       regulator-min-microvolt = <3008000>;
> +                       regulator-max-microvolt = <3008000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l5b_3p1: ldo5 {
> +                       regulator-name = "vreg_l5b_3p1";
> +                       regulator-min-microvolt = <3104000>;
> +                       regulator-max-microvolt = <3104000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l6b_1p8: ldo6 {
> +                       regulator-name = "vreg_l6b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <3008000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l7b_1p8: ldo7 {
> +                       regulator-name = "vreg_l7b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <3008000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l8b_1p8: ldo8 {
> +                       regulator-name = "vreg_l8b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <3008000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l9b_2p9: ldo9 {
> +                       regulator-name = "vreg_l9b_2p9";
> +                       regulator-min-microvolt = <2960000>;
> +                       regulator-max-microvolt = <3008000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l11b_1p2: ldo11 {
> +                       regulator-name = "vreg_l11b_1p2";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1504000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l12b_1p8: ldo12 {
> +                       regulator-name = "vreg_l12b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l13b_3p0: ldo13 {
> +                       regulator-name = "vreg_l13b_3p0";
> +                       regulator-min-microvolt = <3000000>;
> +                       regulator-max-microvolt = <3000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l14b_3p2: ldo14 {
> +                       regulator-name = "vreg_l14b_3p2";
> +                       regulator-min-microvolt = <3200000>;
> +                       regulator-max-microvolt = <3200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l15b_1p8: ldo15 {
> +                       regulator-name = "vreg_l15b_1p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l16b_2p8: ldo16 {
> +                       regulator-name = "vreg_l16b_2p8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l17b_2p5: ldo17 {
> +                       regulator-name = "vreg_l17b_2p5";
> +                       regulator-min-microvolt = <2504000>;
> +                       regulator-max-microvolt = <2504000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-1 {
> +               compatible = "qcom,pm8550vs-rpmh-regulators";
> +               qcom,pmic-id = "c";
> +
> +               vdd-l1-supply = <&vreg_s4g_1p25>;
> +               vdd-l2-supply = <&vreg_s4e_0p95>;
> +               vdd-l3-supply = <&vreg_s4e_0p95>;
> +
> +               vreg_l3c_0p9: ldo3 {
> +                       regulator-name = "vreg_l3c_0p9";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <912000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-2 {
> +               compatible = "qcom,pm8550vs-rpmh-regulators";
> +               qcom,pmic-id = "d";
> +
> +               vdd-l1-supply = <&vreg_s4e_0p95>;
> +               vdd-l2-supply = <&vreg_s4e_0p95>;
> +               vdd-l3-supply = <&vreg_s4e_0p95>;
> +
> +               vreg_l1d_0p88: ldo1 {
> +                       regulator-name = "vreg_l1d_0p88";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <920000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-3 {
> +               compatible = "qcom,pm8550vs-rpmh-regulators";
> +               qcom,pmic-id = "e";
> +
> +               vdd-l1-supply = <&vreg_s4e_0p95>;
> +               vdd-l2-supply = <&vreg_s4e_0p95>;
> +               vdd-l3-supply = <&vreg_s4g_1p25>;
> +               vdd-s4-supply = <&vph_pwr>;
> +               vdd-s5-supply = <&vph_pwr>;
> +
> +               vreg_s4e_0p95: smps4 {
> +                       regulator-name = "vreg_s4e_0p95";
> +                       regulator-min-microvolt = <904000>;
> +                       regulator-max-microvolt = <984000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s5e_1p08: smps5 {
> +                       regulator-name = "vreg_s5e_1p08";
> +                       regulator-min-microvolt = <1010000>;
> +                       regulator-max-microvolt = <1120000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l1e_0p88: ldo1 {
> +                       regulator-name = "vreg_l1e_0p88";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <912000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2e_0p9: ldo2 {
> +                       regulator-name = "vreg_l2e_0p9";
> +                       regulator-min-microvolt = <870000>;
> +                       regulator-max-microvolt = <970000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l3e_1p2: ldo3 {
> +                       regulator-name = "vreg_l3e_1p2";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-4 {
> +               compatible = "qcom,pm8550ve-rpmh-regulators";
> +               qcom,pmic-id = "f";
> +
> +               vdd-l1-supply = <&vreg_s4e_0p95>;
> +               vdd-l2-supply = <&vreg_s4e_0p95>;
> +               vdd-l3-supply = <&vreg_s4e_0p95>;
> +               vdd-s4-supply = <&vph_pwr>;
> +
> +               vreg_s4f_0p5: smps4 {
> +                       regulator-name = "vreg_s4f_0p5";
> +                       regulator-min-microvolt = <500000>;
> +                       regulator-max-microvolt = <600000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l1f_0p9: ldo1 {
> +                       regulator-name = "vreg_l1f_0p9";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <912000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2f_0p88: ldo2 {
> +                       regulator-name = "vreg_l2f_0p88";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <912000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l3f_0p88: ldo3 {
> +                       regulator-name = "vreg_l3f_0p88";
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <912000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       regulators-5 {
> +               compatible = "qcom,pm8550vs-rpmh-regulators";
> +               qcom,pmic-id = "g";
> +               vdd-l1-supply = <&vreg_s4g_1p25>;
> +               vdd-l2-supply = <&vreg_s4g_1p25>;
> +               vdd-l3-supply = <&vreg_s4g_1p25>;
> +               vdd-s1-supply = <&vph_pwr>;
> +               vdd-s2-supply = <&vph_pwr>;
> +               vdd-s3-supply = <&vph_pwr>;
> +               vdd-s4-supply = <&vph_pwr>;
> +               vdd-s5-supply = <&vph_pwr>;
> +               vdd-s6-supply = <&vph_pwr>;
> +
> +               vreg_s1g_1p25: smps1 {
> +                       regulator-name = "vreg_s1g_1p25";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1300000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s2g_0p85: smps2 {
> +                       regulator-name = "vreg_s2g_0p85";
> +                       regulator-min-microvolt = <800000>;
> +                       regulator-max-microvolt = <1000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s3g_0p8: smps3 {
> +                       regulator-name = "vreg_s3g_0p8";
> +                       regulator-min-microvolt = <300000>;
> +                       regulator-max-microvolt = <1004000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s4g_1p25: smps4 {
> +                       regulator-name = "vreg_s4g_1p25";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1300000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s5g_0p85: smps5 {
> +                       regulator-name = "vreg_s5g_0p85";
> +                       regulator-min-microvolt = <500000>;
> +                       regulator-max-microvolt = <1004000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_s6g_1p86: smps6 {
> +                       regulator-name = "vreg_s6g_1p86";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <2000000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l1g_1p2: ldo1 {
> +                       regulator-name = "vreg_l1g_1p2";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l2g_1p2: ldo2 {
> +                       regulator-name = "vreg_l2g_1p2";
> +                       regulator-min-microvolt = <1100000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l3g_1p2: ldo3 {
> +                       regulator-name = "vreg_l3g_1p2";
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +};
> +
> +&ufs_mem_hc {
> +       reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +       vcc-supply = <&vreg_l17b_2p5>;
> +       vcc-max-microamp = <1300000>;
> +       vccq-supply = <&vreg_l1g_1p2>;
> +       vccq-max-microamp = <1200000>;
> +       vdd-hba-supply = <&vreg_l3g_1p2>;
> +
> +       status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +       vdda-phy-supply = <&vreg_l1d_0p88>;
> +       vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +       status = "okay";
> +};
> --
> 2.17.1
>
>


-- 
With best wishes
Dmitry

