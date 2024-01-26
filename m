Return-Path: <linux-kernel+bounces-39758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA7B83D5CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2D81C266A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD03419470;
	Fri, 26 Jan 2024 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n4BcvKza"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBF14ABC;
	Fri, 26 Jan 2024 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257360; cv=none; b=d0gYZGCUz8VSEj+V+AuX1S+kpptV1Y/HJ31t/egw4Itv79BX+orndUvHLnbI7odnIiE9xi4xvRfwW2LEBt+ZRcRX4B+9loX+CGFtRyYCXlpzo6KJ/PAHck9W+iFMxfQnEk/ncpAmi3Nj+/aSnqv1B354sbYhUZCiVoFoWcon2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257360; c=relaxed/simple;
	bh=dipTF7ivFzJBUGuMC5GSS3gGIcrOoM+/+vNV/FLIF4A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cuTk2UGyi6pHtISq3hiRkasmZfHgW0J+0ijU3oG+m9hWw0l5w+DV3VA2cBw/ET54wpwooZ2LMKL/tLltioC2DSDMZ8oWl9h3YpxegKLBEkMbGzJbHMT9oU9ghyJnb8DxtVnrvULyNBquLkoq1HW4i5j52lF/rO7GF1B5kli9PbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n4BcvKza; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q7H2fT003217;
	Fri, 26 Jan 2024 08:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=6NtidV9gxcpV
	E2RdeDp3evY2S/4Fj2EmikvmYaqvksE=; b=n4BcvKzaPm3PTaIIocmrEDXjDnjo
	CzW/Sjt83y5tQdlk1E7CRdEiKYNKC9XnftlfCc6j3mKs/OLiMP4QBpoOENCxpPX8
	AqhbdLEIqAXUUHljgQWOoUB0qDhyXUg4MrjhG1BNDLxEtnQY70CsAxdrRjGqTcOQ
	R0Ij2Zkr5h8JpT2frhUzbM40kWfGTphP+D+MJqhOq4SoN1LY5xVdS9v20Dv6puKH
	ptVn7MXYZE0235xyzYYAFIv9LB+ExyK4pX/jKKUGO9WZ2r10r4uWDIBtRxvV4LnY
	6tYJZFmssl/ajkvrPhEJamwKah5YSAMvmsWWHY9aL+N6nPoEulg9WSDOBw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4f9gmmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 08:22:34 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40Q8MW1T015825;
	Fri, 26 Jan 2024 08:22:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3vr78m35q9-1;
	Fri, 26 Jan 2024 08:22:32 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40Q8MVKZ015820;
	Fri, 26 Jan 2024 08:22:31 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 40Q8MVw7015819;
	Fri, 26 Jan 2024 08:22:31 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 966495844; Fri, 26 Jan 2024 16:22:30 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, quic_qianyu@quicinc.com
Subject: [PATCH] arm64: dts: qcom: aim300: Enable PCIe0 for WLAN
Date: Fri, 26 Jan 2024 16:22:28 +0800
Message-Id: <1706257348-638-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aTc29Clfhlh9iC_oVEU9KJLBZqauo_B9
X-Proofpoint-GUID: aTc29Clfhlh9iC_oVEU9KJLBZqauo_B9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=362 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260060
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

WLAN is connected to PCIe0 on aim300 board. Hence, enable PCIe0 to let
WLAN work.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
This change is tested and rebased on https://lore.kernel.org/linux-arm-msm/20240119100621.11788-7-quic_tengfan@quicinc.com/

 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts b/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
index 20a3c97..d42cfac 100644
--- a/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
@@ -251,7 +251,7 @@
 
 &gcc {
 	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
-		 <0>,
+		 <&pcie0_phy>,
 		 <&pcie1_phy>,
 		 <0>,
 		 <&ufs_mem_phy 0>,
@@ -349,6 +349,23 @@
 	status = "okay";
 };
 
+&pcie0 {
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_default_state>;
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l1e_0p88>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
 &pm8550_flash {
 	status = "okay";
 
-- 
2.7.4


