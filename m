Return-Path: <linux-kernel+bounces-83750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F201869E03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A311C214B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA184F1E0;
	Tue, 27 Feb 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MXzxcu70"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2701E524;
	Tue, 27 Feb 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055602; cv=none; b=hJI0EDydVy3TLfAm3B0OPJMNKb5LUY3p1AgM0X0tRlEIquNOkaKzR48lrLSrcZKrlyvwFTg22FvIw4MlmHafmGYik/g9DBrAmL50zc+NCSP+E0v3X63+ol6dHcSz32De0HaOwheW5J+r0rj+UA6J8seelY/Fb6LoJF09LrAnK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055602; c=relaxed/simple;
	bh=J+Qf494lfNq3LePXrKTx2B6PI0N6djHhZDEFsxTP9TQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=mPOuxmEgng/EjWcuWSjPlnkEY1Www0YeIsTSfi4JUo5dVHfhGsTXNmch0RPogg6RTF5WQ1JECXH+WH35T3ppufHQjfckoM8o5iuff/PjAYHZGpK2yjmgBTFKgUdqblOUX48g9mroTRKkCDxz99o3L0ytz2p1aSSuHek6MuwpwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MXzxcu70; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RGZnlS017434;
	Tue, 27 Feb 2024 17:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=ipA
	19ju5YtdseUDDRZCyFMshM2dKIhhzcLfNk1aXXlc=; b=MXzxcu70eJb7gxBJDQk
	OyLodt8pNtgO7ObNih9BLPsJSpYcTIs0s76PkERnJVonPnEEnyYbJo4Q7hg5yQn2
	yT7aKxWDe05tyQcenyNYM53kgF87JNOO4N3pv7MyQq5IKPqKqHzmslC2tVV2XIG2
	QDjzrgSmS0yiHSwTU0Qg7jDFvLr7PVhyaet0FdNnNNqVbiI7UUkVWuFEp4lTjlAh
	1+QlEOTRp/pn6dClzMbtfrZHTQQEwuHpUMh6z2iQB8iU0kU1BqizI4/Swk8rzSxw
	rbZ8HIxgi4klc+fnAHSLwOK6EmNWmq/ZlCpTAoDp81TrKIMmM2qgzniayv5GDXjA
	ztg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whkd5g5cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:39:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RHducF010810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 17:39:56 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 09:39:55 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 27 Feb 2024 09:39:54 -0800
Subject: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Name the regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240227-rb3gen2-regulator-names-v1-1-63ceb845dcc8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGoe3mUC/x3MQQ6CMBBG4auQWTMJjEWEqxgXFX7qJFLIVAkJ4
 e42Lr/FewclmCJRXxxk2DTpEjPqsqDh5WMA65hNUomrRFq25yUgChvC9+0/i3H0MxLf/OA6QeO
 aa0u5Xg2T7v/z/XGeP0UmdlVpAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709055595; l=9390;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=J+Qf494lfNq3LePXrKTx2B6PI0N6djHhZDEFsxTP9TQ=;
 b=PEKMCv/4EnZ+seSXtGsZGGxuz/+ap4JKuM46X/sCeXp+R3uGKUPFGgLu59cuYQNAVxwU2jmcg
 ataHDq8BvhLANFnC8UYFiNkvpI9wT8FnXs/10/VLhvpyZkSb5ryPXG4
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Er_E3ZPMV4mYKrG84nNZ1QLa9rdJ-w65
X-Proofpoint-ORIG-GUID: Er_E3ZPMV4mYKrG84nNZ1QLa9rdJ-w65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=764 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270136

Without explicitly specifying names for the regualtors they are named
based on the DeviceTree node name. This results in multiple regulators
with the same name, making debug prints and regulator_summary inpossible
to reason about.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 97824c769ba3..63ebe0774f1d 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -153,129 +153,151 @@ regulators-0 {
 		vdd-l14-l16-supply = <&vreg_s8b_1p272>;
 
 		vreg_s1b_1p872: smps1 {
+			regulator-name = "vreg_s1b_1p872";
 			regulator-min-microvolt = <1840000>;
 			regulator-max-microvolt = <2040000>;
 		};
 
 		vreg_s2b_0p876: smps2 {
+			regulator-name = "vreg_s2b_0p876";
 			regulator-min-microvolt = <570070>;
 			regulator-max-microvolt = <1050000>;
 		};
 
 		vreg_s7b_0p972: smps7 {
+			regulator-name = "vreg_s7b_0p972";
 			regulator-min-microvolt = <535000>;
 			regulator-max-microvolt = <1120000>;
 		};
 
 		vreg_s8b_1p272: smps8 {
+			regulator-name = "vreg_s8b_1p272";
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1500000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_RET>;
 		};
 
 		vreg_l1b_0p912: ldo1 {
+			regulator-name = "vreg_l1b_0p912";
 			regulator-min-microvolt = <825000>;
 			regulator-max-microvolt = <925000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l2b_3p072: ldo2 {
+			regulator-name = "vreg_l2b_3p072";
 			regulator-min-microvolt = <2700000>;
 			regulator-max-microvolt = <3544000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l3b_0p504: ldo3 {
+			regulator-name = "vreg_l3b_0p504";
 			regulator-min-microvolt = <312000>;
 			regulator-max-microvolt = <910000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l4b_0p752: ldo4 {
+			regulator-name = "vreg_l4b_0p752";
 			regulator-min-microvolt = <752000>;
 			regulator-max-microvolt = <820000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		reg_l5b_0p752: ldo5 {
+			regulator-name = "reg_l5b_0p752";
 			regulator-min-microvolt = <552000>;
 			regulator-max-microvolt = <832000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l6b_1p2: ldo6 {
+			regulator-name = "vreg_l6b_1p2";
 			regulator-min-microvolt = <1140000>;
 			regulator-max-microvolt = <1260000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l7b_2p952: ldo7 {
+			regulator-name = "vreg_l7b_2p952";
 			regulator-min-microvolt = <2400000>;
 			regulator-max-microvolt = <3544000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l8b_0p904: ldo8 {
+			regulator-name = "vreg_l8b_0p904";
 			regulator-min-microvolt = <870000>;
 			regulator-max-microvolt = <970000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l9b_1p2: ldo9 {
+			regulator-name = "vreg_l9b_1p2";
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1304000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l11b_1p504: ldo11 {
+			regulator-name = "vreg_l11b_1p504";
 			regulator-min-microvolt = <1504000>;
 			regulator-max-microvolt = <2000000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l12b_0p751: ldo12 {
+			regulator-name = "vreg_l12b_0p751";
 			regulator-min-microvolt = <751000>;
 			regulator-max-microvolt = <824000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l13b_0p53: ldo13 {
+			regulator-name = "vreg_l13b_0p53";
 			regulator-min-microvolt = <530000>;
 			regulator-max-microvolt = <824000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l14b_1p08: ldo14 {
+			regulator-name = "vreg_l14b_1p08";
 			regulator-min-microvolt = <1080000>;
 			regulator-max-microvolt = <1304000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l15b_0p765: ldo15 {
+			regulator-name = "vreg_l15b_0p765";
 			regulator-min-microvolt = <765000>;
 			regulator-max-microvolt = <1020000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l16b_1p1: ldo16 {
+			regulator-name = "vreg_l16b_1p1";
 			regulator-min-microvolt = <1100000>;
 			regulator-max-microvolt = <1300000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l17b_1p7: ldo17 {
+			regulator-name = "vreg_l17b_1p7";
 			regulator-min-microvolt = <1700000>;
 			regulator-max-microvolt = <1900000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l18b_1p8: ldo18 {
+			regulator-name = "vreg_l18b_1p8";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <2000000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l19b_1p8: ldo19 {
+			regulator-name = "vreg_l19b_1p8";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <2000000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
@@ -304,109 +326,128 @@ regulators-1 {
 		vdd-bob-supply = <&vph_pwr>;
 
 		vreg_s1c_2p19: smps1 {
+			regulator-name = "vreg_s1c_2p19";
 			regulator-min-microvolt = <2190000>;
 			regulator-max-microvolt = <2210000>;
 		};
 
 		vreg_s2c_0p752: smps2 {
+			regulator-name = "vreg_s2c_0p752";
 			regulator-min-microvolt = <750000>;
 			regulator-max-microvolt = <800000>;
 		};
 
 		vreg_s5c_0p752: smps5 {
+			regulator-name = "vreg_s5c_0p752";
 			regulator-min-microvolt = <465000>;
 			regulator-max-microvolt = <1050000>;
 		};
 
 		vreg_s7c_0p752: smps7 {
+			regulator-name = "vreg_s7c_0p752";
 			regulator-min-microvolt = <465000>;
 			regulator-max-microvolt = <800000>;
 		};
 
 		vreg_s9c_1p084: smps9 {
+			regulator-name = "vreg_s9c_1p084";
 			regulator-min-microvolt = <1010000>;
 			regulator-max-microvolt = <1170000>;
 		};
 
 		vreg_l1c_1p8: ldo1 {
+			regulator-name = "vreg_l1c_1p8";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1980000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l2c_1p62: ldo2 {
+			regulator-name = "vreg_l2c_1p62";
 			regulator-min-microvolt = <1620000>;
 			regulator-max-microvolt = <1980000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l3c_2p8: ldo3 {
+			regulator-name = "vreg_l3c_2p8";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <3540000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l4c_1p62: ldo4 {
+			regulator-name = "vreg_l4c_1p62";
 			regulator-min-microvolt = <1620000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l5c_1p62: ldo5 {
+			regulator-name = "vreg_l5c_1p62";
 			regulator-min-microvolt = <1620000>;
 			regulator-max-microvolt = <3300000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l6c_2p96: ldo6 {
+			regulator-name = "vreg_l6c_2p96";
 			regulator-min-microvolt = <1650000>;
 			regulator-max-microvolt = <3544000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l7c_3p0: ldo7 {
+			regulator-name = "vreg_l7c_3p0";
 			regulator-min-microvolt = <3000000>;
 			regulator-max-microvolt = <3544000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l8c_1p62: ldo8 {
+			regulator-name = "vreg_l8c_1p62";
 			regulator-min-microvolt = <1620000>;
 			regulator-max-microvolt = <2000000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l9c_2p96: ldo9 {
+			regulator-name = "vreg_l9c_2p96";
 			regulator-min-microvolt = <2700000>;
 			regulator-max-microvolt = <35440000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l10c_0p88: ldo10 {
+			regulator-name = "vreg_l10c_0p88";
 			regulator-min-microvolt = <720000>;
 			regulator-max-microvolt = <1050000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l11c_2p8: ldo11 {
+			regulator-name = "vreg_l11c_2p8";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <3544000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l12c_1p65: ldo12 {
+			regulator-name = "vreg_l12c_1p65";
 			regulator-min-microvolt = <1650000>;
 			regulator-max-microvolt = <2000000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l13c_2p7: ldo13 {
+			regulator-name = "vreg_l13c_2p7";
 			regulator-min-microvolt = <2700000>;
 			regulator-max-microvolt = <3544000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_bob_3p296: bob {
+			regulator-name = "vreg_bob_3p296";
 			regulator-min-microvolt = <3008000>;
 			regulator-max-microvolt = <3960000>;
 		};

---
base-commit: 22ba90670a51a18c6b36d285fddf92b9887c0bc3
change-id: 20240227-rb3gen2-regulator-names-8ac492e54567

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


