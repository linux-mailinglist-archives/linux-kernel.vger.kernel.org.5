Return-Path: <linux-kernel+bounces-120029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556AD88D07F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09656326E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7FC13DBBF;
	Tue, 26 Mar 2024 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mR4oo1t+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585513DDDC;
	Tue, 26 Mar 2024 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490875; cv=none; b=Dhn+Fee1wIZqkwQpyzOtBdCiTx3AGvfnCka6ZNID0TUMszt28J8Am6p5bJGAinnyqaGUooytDs7LscaZ32nQQv/MeWqQSBEDQBT/7c/3bpfoUVYS4Lfx0LjYSJg5uyjKqqOxzMfzadwftOSSMu8gaNBwMvjPkVVqqD1YnjaBNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490875; c=relaxed/simple;
	bh=Pi/F/81vvlaYSSm6cg3emHZLqW1O3OYtbyEYnE7kWPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xpgy1wK+QIj7+Sw3iWZL5BardQvYfkoL2tj/EmKDLw9a+W33c/Ze/QsC7v4mO/YaFvl0Jm/ip55f+mt5Tm0qODsvIkxtARJdu51RCYUclMeqs4NoebZBBC63KNsdWmQiqIb60H+5Byw0DSJRFnhi9lQqKfxhsjKsHG47JqNS6Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mR4oo1t+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QLueDh012961;
	Tue, 26 Mar 2024 22:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=GIj0M/qSuD9QF74IwoBLlpEsdDLgDNFw4Bb6J7NVLN4=; b=mR
	4oo1t+2hlstvFBYL8GNE+mQmpTfA7/WvJAwJjU72H48tCYHL6ryHE1E3lmrXY+FS
	tuhyLFZeB/JgLeguz7HBOcrl4LMb6X3YKFMGVLdqZ4SpqwShClj6sKkh0qtm62Qp
	rTNWgZJvbcGsFs9Owi01/jKWAxR0KAdNS59tE3Modcht6NrEEE7iRa+fbMd+sw/1
	kTVZ9xsj06SIPKu7XtVt/Td//tWQBZAhkd5o9VkmaWmw3VJ1ckxSg3NFQ4vPg2m+
	yMGOz3aqt75ymGz/CIXvunKCpfMRa3dFxrOVeTzPEHKar8TajoFcyVJuY7dG5rtG
	VAmTGQ3DXr+sVHpqfghA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x43byge8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:07:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QM7ocZ028831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:07:50 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 15:07:50 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v2 3/4] pinctrl: qcom: spmi-gpio: Add PMXR2230 and PM6450 support
Date: Tue, 26 Mar 2024 15:06:29 -0700
Message-ID: <20240326220628.2392802-4-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326220628.2392802-1-quic_amelende@quicinc.com>
References: <20240326220628.2392802-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SbaDedO6MnWFey7DstdVFX7-SYu-eFLy
X-Proofpoint-ORIG-GUID: SbaDedO6MnWFey7DstdVFX7-SYu-eFLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_09,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0
 mlxlogscore=995 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260159

Add support for qcom,pmxr2230-gpio and qcom,pm6450-gpio.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index f4e2c88a7c82..54ffb7e1189a 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1202,6 +1202,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm6150-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pm6150l-gpio", .data = (void *) 12 },
 	{ .compatible = "qcom,pm6350-gpio", .data = (void *) 9 },
+	{ .compatible = "qcom,pm6450-gpio", .data = (void *) 9 },
 	{ .compatible = "qcom,pm7250b-gpio", .data = (void *) 12 },
 	{ .compatible = "qcom,pm7325-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pm7550ba-gpio", .data = (void *) 8},
@@ -1253,6 +1254,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pmx55-gpio", .data = (void *) 11 },
 	{ .compatible = "qcom,pmx65-gpio", .data = (void *) 16 },
 	{ .compatible = "qcom,pmx75-gpio", .data = (void *) 16 },
+	{ .compatible = "qcom,pmxr2230-gpio", .data = (void *) 12 },
 	{ },
 };
 
-- 
2.34.1


