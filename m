Return-Path: <linux-kernel+bounces-4526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B627817EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0FF28645E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65061FB6;
	Tue, 19 Dec 2023 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cChgV8Hq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE1B10E4;
	Tue, 19 Dec 2023 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BINRMOe013290;
	Tue, 19 Dec 2023 00:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=jIBTrLv32vcYJw3993Rl
	QGZR8z18Fa3gfNnJv4IQetU=; b=cChgV8Hqy57DI1cEv6Gj+WtOiKkQrmOWNRw4
	NFJm3SZYqz56yj8qgeodIxsH6uRPLmbe61mtmmP87qsvw6uWh4OC1+lWBzF2TcrH
	VuXaq58GIb9N44zhxH/4s6G5DLlCJDh18ocqXYEcHt10QWa3D26rdEOOQNka2E2P
	UnwvFqaBinhkMMtSHvfnQhbMU5ubVnkToB0s5+LnL0eeBMxTphB/7xf66nJOOH+d
	6XplFWy+TcEUEeIWCE4EheJ/8noIgEKqE1R8Q+L9xQAV+hcpz2LdasO0c0VMn0RD
	mCd/p/aB7wUYTnYVZSx4fa4nONxkjda4q6g7vKFkJ/675/wsyA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mjfsuv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:31:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ0Vmcf009491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:31:48 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 16:31:42 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>
Subject: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove address/size-cells from mdss_dsi1
Date: Tue, 19 Dec 2023 08:31:06 +0800
Message-ID: <20231219003106.8663-2-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231219003106.8663-1-quic_tengfan@quicinc.com>
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: neyr8p-jISzTJHcMG6PkyRd3HgGQqY2H
X-Proofpoint-ORIG-GUID: neyr8p-jISzTJHcMG6PkyRd3HgGQqY2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=597 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312190002

The address/size-cells in mdss_dsi1 node have not ranges and child also
have not reg, then this leads to dtc W=1 warnings:

  sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
    unnecessary #address-cells/#size-cells without "ranges" or child "reg" property


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d707d15cea5b..cce3e63a2599 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2967,9 +2967,6 @@
 				phys = <&mdss_dsi1_phy>;
 				phy-names = "dsi";
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				status = "disabled";
 
 				ports {
-- 
2.17.1


