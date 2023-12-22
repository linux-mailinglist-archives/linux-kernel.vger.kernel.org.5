Return-Path: <linux-kernel+bounces-9447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3028681C5AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637C81C25116
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BFB9475;
	Fri, 22 Dec 2023 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AneRBOro"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507B2207A;
	Fri, 22 Dec 2023 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM3x9bR015513;
	Fri, 22 Dec 2023 07:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=6ImjNiS
	I1CFUB7fpLoA7Gqc4wRl1CPubkUKBD/qGQAo=; b=AneRBOroiHo40Q2bNZVc1JF
	DXmyRCYF2cUqsKO1V7/05/IVdhimDIN4UmQMZX16w56Z6cYL6Jk5VdVD9zP5LyOl
	q6IW0RP1aG5FbEhyceFzWOO+9dBqtyZVdr2prAfaSNd827qUcriKPYxro/vhyvEP
	VJj5mU632xssI3ZJpUehpbSNASvfpaIaTSIURKfmGEL+PN5z40F7daG3IDB4rwG6
	mSfKFOqmuoMedy8V+mC371AxHL2GTeHq5osXWvByMfS2fiIjj4SNbARvf8iQVRkO
	4s7mKr+F2mikswTnHZWPAc/73rY3QztAr3wiwpnzjyyv2CdOoR15tBwfPMzWBlw=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v51u08h21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 07:32:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM7VsJi015689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 07:31:55 GMT
Received: from hu-uchheda-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 23:31:51 -0800
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
        <linux-kernel@vger.kernel.org>, <quic_kamalw@quicinc.com>,
        <quic_uchheda@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: qcm6490-idp: Add support for PM7250B PMIC
Date: Fri, 22 Dec 2023 13:01:35 +0530
Message-ID: <20231222073135.2512313-1-quic_uchheda@quicinc.com>
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
X-Proofpoint-GUID: F5uHIJBa8W2kBAz9hMob3ZCh4S5Iq7sb
X-Proofpoint-ORIG-GUID: F5uHIJBa8W2kBAz9hMob3ZCh4S5Iq7sb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=767 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220052

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


