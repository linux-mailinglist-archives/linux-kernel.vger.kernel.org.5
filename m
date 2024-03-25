Return-Path: <linux-kernel+bounces-117410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A86888AAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3521F66E92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105B148839;
	Mon, 25 Mar 2024 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W3DAbnLh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFD1487DC;
	Mon, 25 Mar 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381814; cv=none; b=BwSNIbtL6gGATUUCa8XQTe3zfN+shyjZeX05sFqO8FrVYQ7jPjldualM8MHoJDcCf4nGjYCXXSkWxSwhXZO855aXlKRGCYQIHKp5mtAFOmJE3nQEpplSjQFWApuCRwbywn4t5hJGNEqb4ugkdr7V9Khq5ZjztFWiunIdlNFEJ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381814; c=relaxed/simple;
	bh=2LWwOZjvHP2/sfUN4uoeUm+NXZOF5ohDQK1bBJMhGug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=p37pUM7YZVROnH0rQh8zstDrhMFEvvpEZsNXBGrP0sXPe7gYPASwSB0AaFi38weIYoiNBTJZ/ngz+N2SDcMGZg/+28aOGe76F8o6XMyhuQzF6rJEXSC3U63lhkcta5snrsFqUTRPRH2UZwWk5ckPi6vF7rqjusmaHTGjUHuYU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W3DAbnLh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PArl5a025965;
	Mon, 25 Mar 2024 15:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=TSoEdYEDUTM4r3y25qHcAkGXxmu5+SDo3tNcbUmyOBA
	=; b=W3DAbnLhGgErU3ClWygw+YOgd6zy6heXlzUfeVBKTvhiK7PGhFxPXqNHkO/
	j74p2JDep1fyREwx5pJeEq2Nhsj5T7C8bbThBHjPdK8LpkYxYdwAbqaS2HLgC5Zg
	UOUHhRpahzhcUol9PG+Oj1rP/fQ03X/ZIPHqJxV2gz5YCzArAJWBO5QD1brP+7Mr
	yzi/KcNroWXCa/SnDAfaWVaHUkYOLkD2BltwvdMvHwL9LOTVXJDla9OJ9u48/peE
	2LJZ4mU3gLshiAjVR0/3W7ID0IVDrx7sqlnAOS5NIJCLOinX/DSXVnTtRJw6zeQc
	xyp5CuFGJMS4LnDZKxY9fKfFY0A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x35eah4vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:50:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PFo8hX000658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:50:08 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 08:50:04 -0700
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Mon, 25 Mar 2024 21:19:48 +0530
Subject: [PATCH v2 1/3] dt-bindings: arm: qcom,ids: Add SoC ID for IPQ5321
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240325-ipq5321-sku-support-v2-1-f30ce244732f@quicinc.com>
References: <20240325-ipq5321-sku-support-v2-0-f30ce244732f@quicinc.com>
In-Reply-To: <20240325-ipq5321-sku-support-v2-0-f30ce244732f@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Kathiravan
 Thirumoorthy" <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711381799; l=772;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=2LWwOZjvHP2/sfUN4uoeUm+NXZOF5ohDQK1bBJMhGug=;
 b=g89eP1TGtqOjel3oZyN2SqVa2voWKEhU7oG/uDpDV2Vs5/U1mqhe8aE6yhMTf2QqJTxMl2GHQ
 FZ5V87TFdO4A1fn9zYKQB/zXLJ3Abg+RjFnhXPL1EGS4Apz8h6akfLM
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BZGL9h1UrPq8vPKmwwx38DiMWeJR6DwB
X-Proofpoint-ORIG-GUID: BZGL9h1UrPq8vPKmwwx38DiMWeJR6DwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=775 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250087

Add the ID for the Qualcomm IPQ5321 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index d040033dc8ee..a2958952a9ec 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -272,6 +272,7 @@
 #define QCOM_ID_QCS8550			603
 #define QCOM_ID_QCM8550			604
 #define QCOM_ID_IPQ5300			624
+#define QCOM_ID_IPQ5321			650
 
 /*
  * The board type and revision information, used by Qualcomm bootloaders and

-- 
2.34.1


