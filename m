Return-Path: <linux-kernel+bounces-117412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182C288AB08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB1E1C3BDF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A2314D299;
	Mon, 25 Mar 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YcSz9C4W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8114AD0F;
	Mon, 25 Mar 2024 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381823; cv=none; b=ouEEZ0zw/Wqym8m1v23jhgvPUkuzj4uB8fFtPpO2iONHovA+NRTKKaD5HQGYYs5ebeda/vB57Ie6m68XUwJwkdenyxOtNOwpvGKoA2ekym9GNo2ElXEVICDg1Z9IEh0VoOz+1yTeJwxtQnXwIqgz1n6gzcZgmHqMAZI33AYSPl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381823; c=relaxed/simple;
	bh=L6eAQT01UwjooOaRaAv+MlN39/Mt+Kq8bgG92V4Ywuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hFwahHdRVA3v91zn1zECXDexw+cN9obkJSWVXVCzR3LinuHO9fwQ5s40Alwm0FxRSuzF3RCzSvmxIegW6WzuuzYHBgEiURxoWBgp35h14MOD74HmFqzMLZ/dsyTCkqnWJgm9IqfAaSgZVoPcqV6gP/YZq1eUKIW45mxOLjmZQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YcSz9C4W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PF0TAv010542;
	Mon, 25 Mar 2024 15:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=oiq3itImfZFjYsnbUThxlqIuSDzh3zeTFUr1Rt52iYk
	=; b=YcSz9C4W40rq/BbG/OIdrctOnFNzXi8vfzABy4vDR1Z1BiKG8IkFBaz5sBJ
	w4+KzA01u3IIh9FkHH0L4vaorAOnOdl74NZI3eqiBQUYLTbH3JvI5t3LLyYKxjao
	1DZScpw6HvN8PoAy2k2mSecuG0eTuoDQbIHJsDp2bBxna2/W7HnMj7GERDbQXulT
	HDs3cJ3wi3c1PIkFlQnbJazjmubYzBL5FcCB56Ydb7otOBjlztIyfoMzvyXO7lpK
	rjuXaY5O8y6o+0Rhlemsq6Bi7b/gvui4FUJON10gjhPxWISUCI0aNzP3lasfgX/Z
	lSusss9qOowQswOpv5DWADLNyMw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x381e8q7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:50:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PFoGuj000817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:50:16 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 08:50:12 -0700
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Mon, 25 Mar 2024 21:19:50 +0530
Subject: [PATCH v2 3/3] cpufreq: qcom-nvmem: add support for IPQ5321
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240325-ipq5321-sku-support-v2-3-f30ce244732f@quicinc.com>
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
        Mukesh Ojha
	<quic_mojha@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711381799; l=907;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=L6eAQT01UwjooOaRaAv+MlN39/Mt+Kq8bgG92V4Ywuk=;
 b=+TDJMyKV3mdy/WhoAWGHrT5yqsuDW/rYxHbZuDEVwqrX0nNUszRFfyafB/0NRNdr2TaPw3kRW
 tFFx2Z8Q9IgAYRkMhY6MN2tEKqrHWf2qAFY2qcIggEx8MotzBMvO2HY
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7BfQUIoP1k9Xx0b7ENunZjmIw29ZBrpu
X-Proofpoint-ORIG-GUID: 7BfQUIoP1k9Xx0b7ENunZjmIw29ZBrpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403250087

Like all other SoCs in IPQ5332 family, cpufreq for IPQ5321 is also
determined by the eFuse, with the maximum limit of 1.1GHz. Add support
for the same.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
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


