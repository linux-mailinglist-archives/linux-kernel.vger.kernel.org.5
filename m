Return-Path: <linux-kernel+bounces-35089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5FF838BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4941283F33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805BA5BAF8;
	Tue, 23 Jan 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JcZdCYmL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63B5A0F9;
	Tue, 23 Jan 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005720; cv=none; b=Ei/mf06uFMMUeip003V1Hyq3evjrk6TWQTpbbeOCkmUlqRUUtbfPEQfOX1mRLJSmfXrrju+vOQgPfh6pmXfmPwznhh8Y5PloyCn75+2Ixx0JrMJLau0t3Rfi+9mAiPBEn5npyVYyktKvvN/eMPZvhK+oBNbN52bl4JVm9LbCR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005720; c=relaxed/simple;
	bh=bxXPELcFHBY4/flGsm0AoN4/P4JvVKb2C8NSQ8JGZLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uEbaZoh44Rp5DcB/D5sTRK1UC+zZaxj7YmN67aN9rPi9vbz9ztRU8NXDdRR4AVOm8fSi+NYG4b0fWfjr3GF9AgSjBIn+XfGQLisdoRSOLq/RGkNB7oLN0XcLypb/kx+u59gjNsMvAsEMouW3CdgvVxiraLhStKDog7BYrtm/zGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JcZdCYmL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N8V05c001087;
	Tue, 23 Jan 2024 10:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=6ImjNiS
	I1CFUB7fpLoA7Gqc4wRl1CPubkUKBD/qGQAo=; b=JcZdCYmLimosUKW+I1RxtPr
	rWtFgGhYNup1Mk8zRjZqk3srAE+KLLidpvY7De7WsxEzafftK5Oh2Hv73Wt9qg/7
	2SV5PWgHG2CsHPE21vlxVq5XTThrwzHLfmHQE2Aa70a2PFgnMfl8THq/qhnK14Yr
	+T0oFMqyFuaoQLziV++CQ6y4cRQok04rgAtIPpE6hYdeShMbxbFCAnGQSDFTJn6p
	/SdmdJNK9t0u0yLoowwVxcWlVGnNBf1TwOMKOwoTJTRstcH8m5Efzq2K8A9N8cp9
	vN4zjHl4GYIYcLqqnv/Ur9V7yB3qABYP5HsGgCiaAdeaQC+QIodN3dC0WxAyTSw=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vssw9jchg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 10:28:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NASYa5014633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 10:28:34 GMT
Received: from hu-uchheda-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 02:28:31 -0800
From: Umang Chheda <quic_uchheda@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Umang Chheda <quic_uchheda@quicinc.com>,
        Kamal Wadhwa <quic_kamalw@quicinc.com>
Subject: [PATCH RESEND] arm64: dts: qcom: qcm6490-idp: Add support for PM7250B PMIC
Date: Tue, 23 Jan 2024 15:58:17 +0530
Message-ID: <20240123102817.2414155-1-quic_uchheda@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: wNbCJZuV5-n6GUVYhtBe0OOmTK9_w22m
X-Proofpoint-ORIG-GUID: wNbCJZuV5-n6GUVYhtBe0OOmTK9_w22m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 suspectscore=0
 mlxlogscore=767 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230076

qcm6490-idp platform supports PM7250B PMIC as well.
Add support for the same.

Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 03e97e27d16d..2a6e4907c5ee 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -5,8 +5,13 @@
 
 /dts-v1/;
 
+/* PM7250B is configured to use SID8/9 */
+#define PM7250B_SID 8
+#define PM7250B_SID1 9
+
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sc7280.dtsi"
+#include "pm7250b.dtsi"
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi"
 #include "pmk8350.dtsi"
-- 
2.25.1


