Return-Path: <linux-kernel+bounces-85217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC3186B265
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B9FB2757F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815A15D5A7;
	Wed, 28 Feb 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gglpHa51"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64315B113;
	Wed, 28 Feb 2024 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131945; cv=none; b=MFuWEVGS0JeYqAxbIUHmpb2C8Pj3tOLSKkSNxQ3xXxe7HE8DJWhSePYGmzZs1tIpk0D0YzOHwrz2pyz8WbE3ztnaELGIrwF9rWG/p030IuEcXOl8MgiyjK27T75Vn5dvAZCsVOitZFfiJd5FsTDRcIuAMCeDkcSeYyPO+o0poOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131945; c=relaxed/simple;
	bh=+Bh/rzOUQYQjoRBz1tCM6eJd5AX3o0mJIXpOYRL1V3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D97IJwtfMGN3TNuCr8SyADZXdOK2wInMnj4BVuh1omLL00THfZvzRH8CjZsBQsJ2peTi1hMV8yjaFxX0mTOfHC4yfZ1W1XE50Ntpqnghhq0mAA03xk+zirp62TRtPzt6IW544A42PNVY6wDuBdMlprzuOy10M0/G5/mF7ZOzrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gglpHa51; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SDWDum011876;
	Wed, 28 Feb 2024 14:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=cd0MKC/SARQEghTf3CVRPtwVClnow0+J4u81o5zMyMA
	=; b=gglpHa511U2lM6Op6hs4GgkW+ZdijK5T57JsL1g/ZZOZphRKXVzgKGNfRYm
	E6zkvdNwJ2b8XVWF34/is4BwoFv2RkUO1KmxWlRtdZm68sQzg+m4R5H7Mc2TOTAo
	pwZMD59i7hBSGvttjbMlcTMpHgCGGxhG2vXi2JB0UZcyY4gbS96mgETbJjHFBSK2
	b9Z1bMH5pftXdCYGNolN2v73qXRwRm+9Qy1rD7aOKpc7VB1ywLMqLlsbMP1Hw8AG
	bsecX/JOMGVUFwbpphrDqxx7UeXqn6Lz1PeTYaqBr/XNRuRgIckhZQ6z7o166mSW
	0MPyaVT9AJju0vJyQxTrMwiub9g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj5t1877h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 14:52:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SEqDj4015107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 14:52:13 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 06:52:09 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Wed, 28 Feb 2024 20:21:51 +0530
Subject: [PATCH 3/3] cpufreq: qcom-nvmem: add support for IPQ5321
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240228-ipq5321-sku-support-v1-3-14e4d4715f4b@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709131917; l=806;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=+Bh/rzOUQYQjoRBz1tCM6eJd5AX3o0mJIXpOYRL1V3U=;
 b=iQHn7SORR7fGJbg7G2BFTZJe9rFJ48raS8QEcKkbbtL4w8zOq/HbRMuqC/UkGV4kINrckGNFc
 Lev3JcSsvlyAXArfUiQ9FZOhYXEAlT8QdFWCbrjgqsd3ad0zdD+Sv2l
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y4rOsiHSEyVHLkdbF5bME0o4lqjsj-zB
X-Proofpoint-GUID: y4rOsiHSEyVHLkdbF5bME0o4lqjsj-zB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280118

Like all other SoCs in IPQ5332 family, cpufreq for IPQ5321 is also
determined by the eFuse, with the maximum limit of 1.1GHz. Add support
for the same.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index ea05d9d67490..0a46b5d49d32 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -191,6 +191,7 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	case QCOM_ID_IPQ5312:
 	case QCOM_ID_IPQ5302:
 	case QCOM_ID_IPQ5300:
+	case QCOM_ID_IPQ5321:
 	case QCOM_ID_IPQ9514:
 	case QCOM_ID_IPQ9550:
 	case QCOM_ID_IPQ9554:

-- 
2.34.1


