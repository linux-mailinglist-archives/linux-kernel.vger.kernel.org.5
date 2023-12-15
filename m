Return-Path: <linux-kernel+bounces-574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA76C814327
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768DB282665
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5159711717;
	Fri, 15 Dec 2023 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6PIm06U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56D171BA;
	Fri, 15 Dec 2023 08:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62412C433C9;
	Fri, 15 Dec 2023 08:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702627318;
	bh=8uAsM3n6TCGakpnmtj6m+RXkjDCi7HZAZ82cuw4AZqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P6PIm06UzTXSz4oy0Kaeyd18Er3HIsme/3lySkqUaAQpQD6F4HgkUyQQnAhk9+OKB
	 f/hi7sJZaukfVYPvf+DlUhWOv/COhgLNdsuBELqePM6e05qrc2CW/TaUdh75mhoezz
	 WwUJwdUI/EG+EhC3Gp2qEZw4oPUhNWEu0xM1dcr8P0gjUj2nARWUqC3UXpPw9gxiGe
	 OiUalihUXs/7t7EA7jt7rFNDzyNGktEHsmFMUBWso2BKS+PYX4KpUZJQjNc5GaBSc0
	 +OZGdVrJR4ZQsP1H/Oexq7OMtHaaxcOiYOrcE7UQ8YmY22PfdDmQ6NBfB/kfIOwgRs
	 SkHWfS38jhdaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47414C4167B;
	Fri, 15 Dec 2023 08:01:58 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Fri, 15 Dec 2023 16:01:45 +0800
Subject: [PATCH v3 1/2] arm64: dts: qcom: sm8550-mtp: Add pm8010 regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-pm8010-regulator-v3-1-1bfc4b7ee5ab@quicinc.com>
References: <20231215-pm8010-regulator-v3-0-1bfc4b7ee5ab@quicinc.com>
In-Reply-To: <20231215-pm8010-regulator-v3-0-1bfc4b7ee5ab@quicinc.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, quic_collinsd@quicinc.com, 
 quic_subbaram@quicinc.com, quic_jprakash@quicinc.com, 
 Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702627316; l=4260;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=Pl6rsx3JbPVYZOCnH4C+O9HbCyqDCL6cCDwhlR0Ts0s=;
 b=JsbDbAp+Bg8yVP1MbNYx+oK7Z7Z0e671aYoiA8QHEZekqw4R07jCgGesH/SWrTjkb+ksiSttm
 WSxdLikn9iYDOILT01Ld9Gcf5vjDOb2xoAn3T5qMN1VPveyhcn+R0/F
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received:
 by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Add PM8010 regulator device nodes for sm8550-mtp board.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 120 ++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 9a70875028b7..8395d363d18d 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -510,6 +510,126 @@ vreg_l3g_1p2: ldo3 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 	};
+
+	regulators-6 {
+		compatible = "qcom,pm8010-rpmh-regulators";
+		qcom,pmic-id = "m";
+
+		vdd-l1-l2-supply = <&vreg_s4g_1p3>;
+		vdd-l3-l4-supply = <&vreg_bob2>;
+		vdd-l5-supply = <&vreg_s6g_1p8>;
+		vdd-l6-supply = <&vreg_s6g_1p8>;
+		vdd-l7-supply = <&vreg_bob1>;
+
+		vreg_l1m_1p056: ldo1 {
+			regulator-name = "vreg_l1m_1p056";
+			regulator-min-microvolt = <1056000>;
+			regulator-max-microvolt = <1056000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2m_1p056: ldo2 {
+			regulator-name = "vreg_l2m_1p056";
+			regulator-min-microvolt = <1056000>;
+			regulator-max-microvolt = <1056000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3m_2p8: ldo3 {
+			regulator-name = "vreg_l3m_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4m_2p8: ldo4 {
+			regulator-name = "vreg_l4m_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5m_1p8: ldo5 {
+			regulator-name = "vreg_l5m_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6m_1p8: ldo6 {
+			regulator-name = "vreg_l6m_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7m_2p9: ldo7 {
+			regulator-name = "vreg_l7m_2p9";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-7 {
+		compatible = "qcom,pm8010-rpmh-regulators";
+		qcom,pmic-id = "n";
+
+		vdd-l1-l2-supply = <&vreg_s4g_1p3>;
+		vdd-l3-l4-supply = <&vreg_bob2>;
+		vdd-l5-supply = <&vreg_s6g_1p8>;
+		vdd-l6-supply = <&vreg_bob1>;
+		vdd-l7-supply = <&vreg_bob1>;
+
+		vreg_l1n_1p1: ldo1 {
+			regulator-name = "vreg_l1n_1p1";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2n_1p1: ldo2 {
+			regulator-name = "vreg_l2n_1p1";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3n_2p8: ldo3 {
+			regulator-name = "vreg_l3n_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4n_2p8: ldo4 {
+			regulator-name = "vreg_l4n_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5n_1p8: ldo5 {
+			regulator-name = "vreg_l5n_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6n_3p3: ldo6 {
+			regulator-name = "vreg_l6n_3p3";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7n_2p96: ldo7 {
+			regulator-name = "vreg_l7n_2p96";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
 };
 
 &i2c_master_hub_0 {

-- 
2.25.1


