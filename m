Return-Path: <linux-kernel+bounces-66494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E82855D72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398B41F223FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10E13FE0;
	Thu, 15 Feb 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YmjWyekN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247EC17541;
	Thu, 15 Feb 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988170; cv=none; b=BigxMxtzBwXj03w/QYY9yU715l8s0RDmUKx2wep3jUpuSSFCJi0w4N+oNlHz2zoyl+L4M+QaMDGxWz4Ulq0OXwQk1c4j/zTd3RNVTUGyWEprxl8LaNeEgXh3r5y7+GFSBItIX7OWK7HMlNT47yxSkgnZpFr89AqTvf4aBv8agnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988170; c=relaxed/simple;
	bh=SC0DzMXmL6wuTpB4rilsajqsgZ9EI3IMipGogrhDtKk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s9pqyx23v/bY+Z/xIH8vSLk8aoZe6zj/2lBrjaNxrsc9sRWuXjP6g8Ic/luj+2/sAqRMYLWl2kYegZC1rMBOuUNfcsvE2AKH+ZgVyWQ/suzo7l+cnGfS0fxX14FZgsR4LgfcRT2yljkl455xaq3IWhlwg+qWbReIbeiZPfC1bvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YmjWyekN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F7KMrx007362;
	Thu, 15 Feb 2024 09:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=RKA2a9gsGXfy
	QaESlXIv15mxArU0v+5pfEqdlas7Wew=; b=YmjWyekNDZPXvEIYRluZjSYW6mo/
	iNKzQBpeKMK9WkVzs9DGwZasDcqTnv0nEPKDfw7NG3W2n/OKJur8PZpyeR/q02Lt
	QH4ZDp5p47xbmRgAH03iFwiPvL3G9t1/hjZ78YKWN0lRXJmx4N7amoFb/4cd7Trq
	T4Ut/kAFUwMAyd7N5IHmdqjky7XrDD8jeZUuG+SQBckPABTRfDQylYT0pWkoLKOJ
	7Q6KkkUSkkVnzRJ41r9qNs/oHInVmNlQApiJuh5vhX2KjzgKN4LFs8Z0T7Rk8Zv1
	6xQRnW1ZJkpmyd2XzgL3sfFYLRZuNhFMoxchj39uGDCYlHt7K6OrpEYWww==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9e4h06n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 09:09:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41F99Fvi019027;
	Thu, 15 Feb 2024 09:09:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3w627ku661-1;
	Thu, 15 Feb 2024 09:09:15 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41F99E1g019022;
	Thu, 15 Feb 2024 09:09:14 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 41F99EnP019021;
	Thu, 15 Feb 2024 09:09:14 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id 7F5DD5001D9; Thu, 15 Feb 2024 14:39:13 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-sm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_cchiluve@quicinc.com, quic_anupkulk@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v3] arm64: dts: qcom: sc7280: add slimbus DT node
Date: Thu, 15 Feb 2024 14:39:10 +0530
Message-Id: <20240215090910.30021-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iIGYpERGTgyR4VtHhQIXV7BtkSmwYoRB
X-Proofpoint-ORIG-GUID: iIGYpERGTgyR4VtHhQIXV7BtkSmwYoRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=440
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150071
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Populate the DTSI node for slimbus instance to be
used by bluetooth FM audio case.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
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


