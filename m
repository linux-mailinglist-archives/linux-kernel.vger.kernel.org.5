Return-Path: <linux-kernel+bounces-34939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E16A83897B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CFD1F2B829
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C7C58228;
	Tue, 23 Jan 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5xHQR+E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160857896;
	Tue, 23 Jan 2024 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999767; cv=none; b=ZGPUDbtF90X7RZHEqJN7vQJXWNHaFtsuM5i/CAGrcwl93D0WIsVH+kQbbYcWt7GDcaRNKWi4S8Jeo8Z8tne58o9b7WguR5RjgkGZHfn4+jUajZue9rBvb529TO2YKxSinYEvp4eE4q/tbqv2Pf3EDKaNlry+G7c3JG+NeAmS2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999767; c=relaxed/simple;
	bh=1z0TD2HxnCY4ip8bo4pCWg3cQC9dj4FCVWWjokiXC0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eNh0ltfT2rzVYZCOsueGVbQ7YVZkc4/fTHvw3+YXjhCfNSc6OLnwHxWLMry517vh53KnYFpJW0mDSQoNtYv+PAUt8HzXaFWmQBPZwldGhhbtd22EXZv4FjdeyUwgSFJhv+ghB9SJ3POb2YBHa54gp+396ElwCTI2+xgVnE27YwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5xHQR+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B890C43609;
	Tue, 23 Jan 2024 08:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705999767;
	bh=1z0TD2HxnCY4ip8bo4pCWg3cQC9dj4FCVWWjokiXC0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X5xHQR+Ei+Af1S67Vs2ZDSISSw1LmSsfbizjy9OVRkn4ISqa7SqWnWDDIBZjfWxEh
	 wdTU2m1Lc1GfZKG0tUu0LVZ2vs3qVbC8F/2OUZiH4155GYn7QIOUHScGb7uX6EGP0J
	 ueJAMpPRDWqvgRdxdRlG6jVLuzY8EJgKNl6tpHftKgFyp/mpCdjJNc+tTXJ9DS4ldC
	 S0XpBT33Ygm3ylEZ0vqRx1p4wRfngkO1OQ2HuV1zOtSZ6ZIPvUGvCQ3xh/Y2MJ+rOF
	 zB0PUxJc394DJL3JplBzqwvdvXGrGpO0HzSLB1N9NfZ01h1Rr8TsN1zRFqxrkUxW/k
	 eO+V1eNutKylA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201D6C47258;
	Tue, 23 Jan 2024 08:49:27 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Tue, 23 Jan 2024 16:49:24 +0800
Subject: [PATCH v2 1/2] arm64: dts: qcom: sm8650-mtp: add PM8010 regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-sm8650_pm8010_support-v2-1-52f517b20a1d@quicinc.com>
References: <20240123-sm8650_pm8010_support-v2-0-52f517b20a1d@quicinc.com>
In-Reply-To: <20240123-sm8650_pm8010_support-v2-0-52f517b20a1d@quicinc.com>
To: kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com, 
 Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705999765; l=4167;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=wnrLBlakA+25sff7egCXfN/0ljBwsmb5q7P8MR4LEuo=;
 b=qNxpZlF/38+tu3RtLE78VSN/UW8ppSFANxcW5ywqw0JvOm26sSiM2/l5yqiw2qzuSciijZNTs
 C8bWSUV8l01Bne/QM40UX/sWWu1IXsXEANJ8L4lytjNsrJj5DibPvvT
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received:
 by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Add PM8010 regulator device nodes for sm8650-mtp board.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 118 ++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index 9d916edb1c73..3791971efee6 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -428,6 +428,124 @@ vreg_l3i_1p2: ldo3 {
 						   RPMH_REGULATOR_MODE_HPM>;
 		};
 	};
+
+	regulators-6 {
+		compatible = "qcom,pm8010-rpmh-regulators";
+		qcom,pmic-id = "m";
+
+		vdd-l1-l2-supply = <&vreg_s1c_1p2>;
+		vdd-l3-l4-supply = <&vreg_bob2>;
+		vdd-l5-supply = <&vreg_s6c_1p8>;
+		vdd-l6-l7-supply = <&vreg_bob1>;
+
+		vreg_l1m_1p1: ldo1 {
+			regulator-name = "vreg_l1m_1p1";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1104000>;
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
+		vreg_l6m_2p8: ldo6 {
+			regulator-name = "vreg_l6m_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7m_2p96: ldo7 {
+			regulator-name = "vreg_l7m_2p96";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-7 {
+		compatible = "qcom,pm8010-rpmh-regulators";
+		qcom,pmic-id = "n";
+
+		vdd-l1-l2-supply = <&vreg_s1c_1p2>;
+		vdd-l3-l4-supply = <&vreg_s6c_1p8>;
+		vdd-l5-l6-supply = <&vreg_bob2>;
+		vdd-l7-supply = <&vreg_bob1>;
+
+		vreg_l1n_1p1: ldo1 {
+			regulator-name = "vreg_l1n_1p1";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2n_1p056: ldo2 {
+			regulator-name = "vreg_l2n_1p056";
+			regulator-min-microvolt = <1056000>;
+			regulator-max-microvolt = <1056000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3n_1p8: ldo3 {
+			regulator-name = "vreg_l3n_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4n_1p8: ldo4 {
+			regulator-name = "vreg_l4n_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5n_2p8: ldo5 {
+			regulator-name = "vreg_l5n_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6n_2p8: ldo6 {
+			regulator-name = "vreg_l6n_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7n_3p3: ldo7 {
+			regulator-name = "vreg_l7n_3p3";
+			regulator-min-microvolt = <3304000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
 };
 
 &dispcc {

-- 
2.25.1


