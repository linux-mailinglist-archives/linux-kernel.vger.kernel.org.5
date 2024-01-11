Return-Path: <linux-kernel+bounces-23600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC682AEED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9154E28151E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572115E88;
	Thu, 11 Jan 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PnJPJbX6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E714F7B;
	Thu, 11 Jan 2024 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B5Y2HS031912;
	Thu, 11 Jan 2024 12:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=3LdHrEh
	GUI3YAMP4K09Sqr8Sbd/28Gtvb4bJKOFFtmE=; b=PnJPJbX6blkvtMsuDRX64yf
	1pVgOL/nJPnZNNwYMEHeCfRhcRy4K2KDr/K0TE+mZHMpd3ets+3JXjdNkgP1Cx6K
	BJ3D8aHt+bPACmbyYiX9ojpDbJOoskC7diGhjpDY59JmGflJ7yAuQ6OtKwUux8eN
	KwdS6PM3p82FZfUscKuqxW1zbz4iji3NjDaXAyoxaeYnwfPZZwdu7FzZO+c7kWkD
	U+FjW3HCveQgvcfmmny+d7L9ggb3sZjfH9RRicPW9+eMX6qgX7Jqid8uh+/kXFMS
	CTXLz4nkLywDGMVFr80iFp4rOCI2zospJ1jXwwE2+cdBeh1dvhqF97dUOpzeq3A=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vja9y0wtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 12:45:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BCjd67004600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 12:45:39 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jan 2024 04:45:36 -0800
From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <baolin.wang@linux.alibaba.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>, Vignesh Viswanathan <quic_viswanat@quicinc.com>
Subject: [PATCH RESEND v2] hwspinlock: qcom: Remove IPQ6018 SOC specific compatible
Date: Thu, 11 Jan 2024 18:15:21 +0530
Message-ID: <20240111124521.3951775-1-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Lk-VI27hIqYSK9lLkLOVxsdiNGFlrx54
X-Proofpoint-GUID: Lk-VI27hIqYSK9lLkLOVxsdiNGFlrx54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 mlxlogscore=680 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110101

IPQ6018 has 32 tcsr_mutex hwlock registers with stride 0x1000.
The compatible string qcom,ipq6018-tcsr-mutex is mapped to
of_msm8226_tcsr_mutex which has 32 locks configured with stride of 0x80
and doesn't match the HW present in IPQ6018.

Remove IPQ6018 specific compatible string so that it fallsback to
of_tcsr_mutex data which maps to the correct configuration for IPQ6018.

Cc: stable@vger.kernel.org
Fixes: 5d4753f741d8 ("hwspinlock: qcom: add support for MMIO on older SoCs")
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---

This patch was already posted [2] and applied [3], but missing in the
linux-next TIP. Resending with r-b tags so that it can be picked up
again.

[2] https://lore.kernel.org/all/20230905095535.1263113-3-quic_viswanat@quicinc.com/
[3] https://lore.kernel.org/all/169522934567.2501390.1112201061322984444.b4-ty@kernel.org/

Changes in v2:
 - Updated commit message
 - Added Fixes and stable tags

 drivers/hwspinlock/qcom_hwspinlock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index a0fd67fd2934..814dfe8697bf 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -115,7 +115,6 @@ static const struct of_device_id qcom_hwspinlock_of_match[] = {
 	{ .compatible = "qcom,sfpb-mutex", .data = &of_sfpb_mutex },
 	{ .compatible = "qcom,tcsr-mutex", .data = &of_tcsr_mutex },
 	{ .compatible = "qcom,apq8084-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
-	{ .compatible = "qcom,ipq6018-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
 	{ .compatible = "qcom,msm8226-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
 	{ .compatible = "qcom,msm8974-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
 	{ .compatible = "qcom,msm8994-tcsr-mutex", .data = &of_msm8226_tcsr_mutex },
-- 
2.41.0


