Return-Path: <linux-kernel+bounces-93881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6E873648
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68897288FE6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAED8061D;
	Wed,  6 Mar 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HWwzcODT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC50605DC;
	Wed,  6 Mar 2024 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728023; cv=none; b=E6975rKlUJpYE/dBR6AMj8kxjYexN08YZUQEY5zUMQB2bWhb83h9sNoU+CqQFiSDUrFa3pOGJfAOwUbDjRIRkK12/iMrUFTDJZMqrBjO0N64fKqhjtPQuOwrWPUOUetHahzr99qh8fOQkHvUf7GT+LJrpVmxWppUIX6z2CtAS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728023; c=relaxed/simple;
	bh=HRHHOse+jj1qZRogrh3yEdITFvnyxLXE3Gw7YqtIZcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8EkuEonK5mfAfff4TYQQ54vMKLBMkGV7tRcu/hWN64qBPJQrzNp6GkLn6kWiQVDGL6Uc8/F+oBp830rPrAAljqPTsSBs8I5b1C+BI4VDpLs22snW5wl5rN8dZlJmttT5zViVo+WKm02IGrhd5adGFf337DMuvnDtqEznEmtmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HWwzcODT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426Bpv3i027356;
	Wed, 6 Mar 2024 12:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=12eGUgS86jlEh0W5KN/K
	P1AJH5SnsuUFgdn1opER4Ms=; b=HWwzcODTmS+E59DiZpEvQ7bw9ghRSLWH9XuN
	ZayWmTD53TaJ07FoqxP7qUw59nitNdYxYUIa1tccs6AgHT0AbG027YrpZss8EGzp
	+/QMXeVAtevtQGULg2JqfhhfgZhaDzDR92yVeukTNz+xOn2Eeb7KD0GxGvPl2+8V
	EQviwTyXJLZY3msjC3AkmDNDQsr80ZtvyVw62ghQWcnG2Ov/IVM12FZMZ3ZphmZG
	161Xx3KLUivwMCAVHUNKlMhO0iFGWdQMJMYljrLU7OSrLlOxO9wLAcCPVN4p7pxy
	SXgnpfalKLs3qtRkeoRZTdNZlY/KAhizlE2HiTcv3sMrJZZ2fw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpjy3rqk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 12:26:57 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426CQuCA007036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 12:26:57 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 04:26:54 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 3/3] arm64: dts: qcom: sm8650: Add qfprom node
Date: Wed, 6 Mar 2024 17:56:35 +0530
Message-ID: <1709727995-19821-4-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709727995-19821-1-git-send-email-quic_mojha@quicinc.com>
References: <1709727995-19821-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AebvRVc4EGzLnyhom_O3bg1IV2KkTc-W
X-Proofpoint-ORIG-GUID: AebvRVc4EGzLnyhom_O3bg1IV2KkTc-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_07,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=779
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060099

Add the qfprom node for sm8650 SoC.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 12ba839f215e..221427bb1b22 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4674,6 +4674,13 @@
 			#clock-cells = <1>;
 		};
 
+		qfprom: efuse@221c8000 {
+			compatible = "qcom,sm8650-qfprom", "qcom,qfprom";
+			reg = <0 0x221c8000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		pmu@24091000 {
 			compatible = "qcom,sm8650-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
 			reg = <0 0x24091000 0 0x1000>;
-- 
2.7.4


