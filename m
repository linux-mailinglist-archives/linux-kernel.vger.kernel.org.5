Return-Path: <linux-kernel+bounces-153729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B968AD269
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA391F219A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F52F15530F;
	Mon, 22 Apr 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E0pugaPe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A41552F4;
	Mon, 22 Apr 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804081; cv=none; b=ZD+NAvvRvZWD5n0mmnLK73jrZPPR+P83XwCH+jAEcTkDN3thkP3f23+5Mx4rlXI1idf7D0V+tlEzXlGEk6qIaM9zLJDKr+pC+QFC7g4QfJ90hoDq9sGmBC1z5FQh6HYD8ZFEMVcoNrM7TSZOP9NTHZZrjjG9Pts4WYkgDg1/92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804081; c=relaxed/simple;
	bh=ZIXcHccEKAcfMNW6rufFKC9iRJQuzI8PCX3v0PawTW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV2dhjOzGX49KTgnIDi4gYbe8hE6VcKo0iNCzxk5htbQgKuGgtNw3Z20SPaHAlN7u/sPZSszTwu0qW8FF/4fPNJQtMs1weCBMlEUXEpdIMPTmyp5jhrz5ZCmD3Mh3/uqh87/fT2JU6JBuE0NFRws5LxX7RagYy5lJNtzAz1hFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E0pugaPe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MBTKEp005356;
	Mon, 22 Apr 2024 16:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=MpB17I+IYlXMoFnxi1sky08K9SwsXW0l/l5n98sB8Bk=; b=E0
	pugaPe6eWM+FZV3ObfcB4lydpKrCENpHY7F40ZjHsK86+oNstj7vzqerXYn6isUR
	Dr0wuOt9hm8ecjHi36PNUVYaWIdB/KtcAWpr21r7hUvIcqkUMC8zjKCnoMo2Jqf6
	uMUDdpZ27HwdEtIY9wKx+hpHYa+NN1VVEwLY7O9uDcW8ZkAP8uemO08ZGoNs5OqF
	z3dCFwH3B4avRVaUzM/LbZeyaUEUoTz7KYIgxstEBfswp73RV7akvNxK6mdLco97
	HDWxaASn81tbyJlucsZDdk1l1wW3cA/CePe35OrziIR6blwWl0UVG8OXEC0Deo60
	fITbHAD2ycmU0Y5julFA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnet79v9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:41:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MGfDNp011682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:41:13 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 09:41:07 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>,
        <abel.vesa@linaro.org>
Subject: [PATCH V4 3/5] arm64: dts: qcom: x1e80100: Resize GIC Redistributor register region
Date: Mon, 22 Apr 2024 22:10:33 +0530
Message-ID: <20240422164035.1045501-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422164035.1045501-1-quic_sibis@quicinc.com>
References: <20240422164035.1045501-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4eRElTsoTuX4KyYsVrEi2uSK-_NBM_a3
X-Proofpoint-ORIG-GUID: 4eRElTsoTuX4KyYsVrEi2uSK-_NBM_a3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=881 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220070

Resize the GICR register region as it currently seeps into the CPU Control
Processor mailbox RX region.

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

V3:
* Fix err in calc and add fixes tag. [Bjorn]

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 5f90a0b3c016..c48b3fdc550b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4947,7 +4947,7 @@ apps_smmu: iommu@15000000 {
 		intc: interrupt-controller@17000000 {
 			compatible = "arm,gic-v3";
 			reg = <0 0x17000000 0 0x10000>,     /* GICD */
-			      <0 0x17080000 0 0x480000>;    /* GICR * 12 */
+			      <0 0x17080000 0 0x300000>;    /* GICR * 12 */
 
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.34.1


