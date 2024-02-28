Return-Path: <linux-kernel+bounces-85215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573B086B25C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072751F2189F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D0F15B999;
	Wed, 28 Feb 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D4dJSxj+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77D15B0FD;
	Wed, 28 Feb 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131937; cv=none; b=GUODXqe82BHL+Q6T5b9tXRmIqDd+2lIyge5rWoVLQuv1nbY9Zivn4Q8AH42ys4K6mB0LMBsNvsuWoJucjIl71Ayhsb9ULr/t3AkA3omhfO6vwQ4Q3VWAWoptP8BLvs+SlUdbKGti9VOFEoXsL9t1H8LwpmAQ23w4YbYnqERiNSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131937; c=relaxed/simple;
	bh=q3Q2UP6zP89rWxFQ+tg/38y2pAEqKieqNDxyPJLa/7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WtWM3vdLp2J1qvV8o9yyeAKrZUGUmDCZvn/5313xhaDKLThhovYLKasTTB3nldGI0J1vtelxsePRTVKIqTKTothSfR2QIzINIGFBVHKf9et9186JV5IWFEbkamPjH3l3Vu9Z1wqx//cCqr6yQ3IU0B76YpXBGZfW0k2rKF6qzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D4dJSxj+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S8VgJY003943;
	Wed, 28 Feb 2024 14:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=swSU4Gy420cfmlutzbikR2xcjcRd/gYAUp/iLw5HR24
	=; b=D4dJSxj+Wy/ylQfj4f66mnanWCxR96t0erNOMbQ5EUhZWkGrQ9fi4hqEZjf
	Oc6jZze7OoSVKxSv0QU5K3iavYcUaCM0y+iZPtOj94RmXe4wusx0QescsnaVbm5T
	627/GhPc/9vDlLq4WghKIaYcXNqL4Fg2BOr92HsF9e/iRWkjQhRseEUOt8l51fDt
	+Fa5cieC7D3C5XmqyK3M/ch0OJeGdigW/n0m6+e3inWQwrzz/C9A7iPU0HFmAUhS
	BU9+vIsdCv5C4p7gsIVsFCs+0/llk8gcUEZPXi02aX7oDLiAgUKCKEXcNHdVEC14
	vktWCLEgHgLgqRVb1OGtIoHVYGg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj1d9rwqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 14:52:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SEq92k028085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 14:52:09 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 06:52:05 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Wed, 28 Feb 2024 20:21:50 +0530
Subject: [PATCH 2/3] soc: qcom: socinfo: Add SoC ID for IPQ5321
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240228-ipq5321-sku-support-v1-2-14e4d4715f4b@quicinc.com>
References: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
In-Reply-To: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
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
 Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709131917; l=678;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=q3Q2UP6zP89rWxFQ+tg/38y2pAEqKieqNDxyPJLa/7E=;
 b=2so/yo2IrPEufcXZmPTUvothicp/nPCgYrinpE3VK0bjMZffRqHrAZI6CyZqWT+KNTY4EU1YZ
 VAZwVgCPC9yAVrbuj6MuzUA1uBtl4mPTAPd7RpdPKZzhgOw4TjoIleW
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OVv-vAXXpFwhZntRBj5ga3fv7uVSCjIz
X-Proofpoint-ORIG-GUID: OVv-vAXXpFwhZntRBj5ga3fv7uVSCjIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=888
 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280118

Add the SoC ID for IPQ5321, which belong to the family of IPQ5332 SoC.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index e8ff9819ac47..c6063fd293d0 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -443,6 +443,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(QCS8550) },
 	{ qcom_board_id(QCM8550) },
 	{ qcom_board_id(IPQ5300) },
+	{ qcom_board_id(IPQ5321) },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)

-- 
2.34.1


