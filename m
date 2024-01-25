Return-Path: <linux-kernel+bounces-38547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC383C15E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A015B246A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3518841742;
	Thu, 25 Jan 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h1B88CGc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9216E405F9;
	Thu, 25 Jan 2024 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183615; cv=none; b=gLpm4a7Q3mfVZciiNBxaJiWD911SBlXo8qkzevXcyGBuk36gTEhuEjWKhAheCP2owCeK3Q26mho7TEE18rHnSNu/XKXFV9BiekATtm0AQ81VGAwjYTwBPPpSffGbg/3xV4A5oYRRxTU1pwTZsmHaEqk2k7dT5Cl9yM6GAjQUgR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183615; c=relaxed/simple;
	bh=t+VQA/syYUhHOkpRPOnOYkh/XE/KeU/nkhfWoM5A9Jw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GlLbfC5TUADVTeSlFd034ogdleMXZLJOM4jWm14mVEM32pwsu7x6M82Yt8MlDifsfwiF0JNmsONL8N+JvP+XrWF+rLH6t3f0Bw0Z1R+NP+aygtifV21SdF05m45Hp6+9MrNzOBXHBNlA4yL18e9wXeuyDJzOW53LmyCB+YWtkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h1B88CGc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PAdbAG018981;
	Thu, 25 Jan 2024 11:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=9KPKt2C
	DE8oGLm2AWBrcsrEbWMl7TgEeWSNHxD36Buo=; b=h1B88CGcsD+d03ArotSOhoY
	VihZg5CwvZX+etDD2aP+H0+Fa8WcJgpIqP4+OT1Z7EtnxRR1LS/OB0wI6ziOuSXD
	A+YsJ1/vQI/qv6yFZmN75gpP95xC6DMsSrRzxDuUEETkVON1F95X72D0bzINPgav
	UAT50ZEVF/FiwTvHsc04JxRVJvAq3e42sX+9aheoKrW2hDkFOEv9fiVlHuu38qgz
	xp7i0jLWls6mFq4E9Wx1uZpYfFxISA4Nr7K3IeTTTdGSStcZiYJCGhwio7QWHiYm
	42I5zdHkGSVsD26QPyGwu72Une92rmOycrCHX5MA/qJ7HM/opvcjBtu1cv6cDcg=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vup2tg78w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 11:53:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PBrH5e010760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 11:53:17 GMT
Received: from hu-uchheda-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 03:53:13 -0800
From: Umang Chheda <quic_uchheda@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_kamalw@quicinc.com>,
        <quic_uchheda@quicinc.com>
Subject: [PATCH v2] arm64: dts: qcom: qcm6490-idp: Include PM7250B
Date: Thu, 25 Jan 2024 17:23:00 +0530
Message-ID: <20240125115300.3496783-1-quic_uchheda@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jr6SBlKuke4e5PX50Bmep-kOLX03c-cP
X-Proofpoint-ORIG-GUID: jr6SBlKuke4e5PX50Bmep-kOLX03c-cP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=746 phishscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401250082

Include PM7250B PMIC for qcm6490-idp.

Signed-off-by: Umang Chheda <quic_uchheda@quicinc.com>
---
Changes in v2:
 - Rephrased commit text.

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


