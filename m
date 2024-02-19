Return-Path: <linux-kernel+bounces-70730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC84F859B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFD61F2224C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A25F20320;
	Mon, 19 Feb 2024 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LaZ1jS7u"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7F200BA;
	Mon, 19 Feb 2024 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319709; cv=none; b=AYPePpfAN74ZUtZFrOANFxAWBqu6GlHXre+i7AqVxTMuahD67/LzPXBanKMlkrHYWnao7tpiPWMXQRwRLrvpaG3USklavbxa9JJSDGxc2noyRLajyKiTDhz1G9wRJcZdREBxorEV4WtS3MC1/XTpwSCvFAOLUdAOfoc56YaIhAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319709; c=relaxed/simple;
	bh=vgTnlbikClzVzfy0RRZAEyEVyAKBisA5MaYhnDsUA3E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Tm5Fyh615jc42+tS9YO11B1eqAOVreAMUHx5oI2Sy5VoBtLknhHjyDht1QzB1JMkGgIZYFtoJ9H1dEu/Mi1S5ao3g8QnsZg8KMVrteJrE4UqtClXoMbvmY+t98eo+PzMpRO/i/Xl0JTZYoCdlnxNOKMdOD4MayZbXSdy2i3MAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LaZ1jS7u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J4DkCe007159;
	Mon, 19 Feb 2024 05:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=bszPaqpe15iy
	YLqgD3PQ79AynqzwEbCvxtyaIuKDJrY=; b=LaZ1jS7uyylB9JcDYmmklw1DSlUB
	gLvC8yBv6uuLDLAEARIpoba4gFyEP6l7mZrKxOMSIawWXw5D5mfJaS73p6IA2GZ9
	1xB0sXJ22mSQJrE7cBmYCX1PHsXP3NOrVPpkVwAyiJsJojFQeoOYeySEppE8o8oJ
	GkrJb72MOCmbDPDVewBflrjDQtbKfD93ueYwXlcTNIvhjXnB4mjmniuHZrfnOWjx
	pJTNrssJAKUhgZm1Uf0NQiTilR8nylehsbsxqIemlJuiUmWIUQ37MsSY3gK8xAaQ
	Vs7fGzQ5EKijbWiJ/jkpB78fb8XovMbEPIr6j5xvfrX2Ocfn0/jQzDBOJw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3waj5sb0du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 05:15:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41J5ExQq011098;
	Mon, 19 Feb 2024 05:14:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wanvkdwbq-1;
	Mon, 19 Feb 2024 05:14:59 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41J5Ex8D011093;
	Mon, 19 Feb 2024 05:14:59 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41J5EwAh011092;
	Mon, 19 Feb 2024 05:14:59 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id E50225001D7; Mon, 19 Feb 2024 10:44:57 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_cchiluve@quicinc.com, Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v4] arm64: dts: qcom: sc7280: add slimbus DT node
Date: Mon, 19 Feb 2024 10:44:55 +0530
Message-Id: <20240219051455.25927-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8vnnBlxNPgGTB4YX8vo7AdBz6akIbYw0
X-Proofpoint-ORIG-GUID: 8vnnBlxNPgGTB4YX8vo7AdBz6akIbYw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_02,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=595 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190037
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Populate the DTSI node for slimbus instance to be
used by bluetooth FM audio case.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
v3 -> v4:
- Correct email address for linux-arm-msm.

v2 -> v3:
- Fix patch title by adding "PATCH" string.
- Update commit log.

v1 -> v2:
- change 0x0 -> 0 to reg property.
- reorder the DT property.
- change node tag slim_msm to slim.
---
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 581818676a4c..1d6afde915aa 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2672,6 +2672,31 @@
 			status = "disabled";
 		};
 
+		slimbam: dma-controller@3a84000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0 0x03a84000 0 0x20000>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,controlled-remotely;
+			num-channels  = <31>;
+			qcom,ee = <1>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x1826 0x0>;
+			status = "disabled";
+		};
+
+		slim: slim-ngd@3ac0000 {
+			compatible = "qcom,slim-ngd-v1.5.0";
+			reg = <0 0x03ac0000 0 0x2c000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x1826 0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		lpass_hm: clock-controller@3c00000 {
 			compatible = "qcom,sc7280-lpasshm";
 			reg = <0 0x03c00000 0 0x28>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation


