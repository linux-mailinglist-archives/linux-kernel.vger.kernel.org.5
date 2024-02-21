Return-Path: <linux-kernel+bounces-74534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA04B85D598
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6811C20FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D48525B;
	Wed, 21 Feb 2024 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hLtTYC54"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC155228;
	Wed, 21 Feb 2024 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511559; cv=none; b=Axy9AxMeYKuBIiPl/5MRKJX86hT7BYJN7J3lRAztu+sRwvNQOU5jO6ydevjhlIrUNQVEGcW5VRcG39kJVPFQ3LWu74nL63YXyZzx4S81oAEZp5erezKFVlWFJXISbbTAiWCsKsw+MSvV9X1r20dD5xynPY0vsbLrJ03GTtLDrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511559; c=relaxed/simple;
	bh=iyWQZCqhvtBUlqMeMmC15jBSDMJBqRuhKvoFlNVbKMk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H8nVONk5Q3dWGKw0X5X22NjwyagNq7kyxihWjgkIMxSnLW57210gWCzJoGowGiw3W1UZoDj+brQ5q+PUu8tUTN+a2hlG6FD2fqjO9KiQGkig+NU0ywp8n30Hem39GlL4FlBkThhT/8ZKgSuym5R/DqgVXWIj0Kq41K58w/yYJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hLtTYC54; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L8u5ve027957;
	Wed, 21 Feb 2024 10:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=v1jmQry
	fga9BZDoQxP6DhwrR5DcM0MPSb+kne+KjKSc=; b=hLtTYC54cQt9nrspGJZ2D3L
	y4hGqkbm4l+ASafkylcWSBiJ2u7/LeZ3s1OFP3WNHkqEvx7DlJq83UnRvk4wozMk
	tmwsxX1m6sV2iU6IwjUPV09uMw2zp8bfFLWkMth7djaegCS5zZect+G/6OlYbuxM
	krGhHv9hz+8eIIzFxYUOcAoaqMpPqdFeXJan4QmYtoiyXhE3eWfIiypQ8U2X8WxG
	Qu10uyAfMGVzL0Nx4sdjuBUB7pHD0LQO7iImv1fS7M2J2P70N7tiiUAxSoeVuzwP
	pJpak36EzD/+iCgd+sDVh98N2M90KSdx/mGzD4fkw3N7X0j8xtPW4lzYI2KtpxA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21usmvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:32:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LAWFqg005694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:32:15 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 21 Feb 2024 02:32:11 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay
 Abraham I" <kishon@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH] phy: qcom-snps: Fixed order of enabling regulators
Date: Wed, 21 Feb 2024 16:02:02 +0530
Message-ID: <20240221103202.3628142-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: ILJFmlSJuSNWEwVZkyXON1nVzbmAYsHt
X-Proofpoint-ORIG-GUID: ILJFmlSJuSNWEwVZkyXON1nVzbmAYsHt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210081

The SNPS Femto phy has 3 supplies, vdda-pll (0.88V), vdd18 (1.8V),
vdd33 (3.3V). The driver enables these in order of 0.88 -> 3.3 -> 1.88.
But on phy instances which have EUD attached, it is seen that not enabling
the regulators in the order of (0.88 -> 1.8V -> 3.3V) is causing the EUD to
reset the phy (issue seen rarely) thereby disturbing enumeration.

This change doesn't disturb operation of phy's where EUD is not present.
According to the some of the applicable power-supply ramp scenarios present
in data book: (DVDD is 0.88V, VDDH is 1.8V)

a) VDDH<#> and VDD33<#> held to 0 V (cannot be left floating) with DVDD
ramped to a valid level
b) VDD33<#> held to 0 V (cannot be left floating) with DVDD and VDDH<#>
ramped to their respective, valid levels

Modify the driver to power up the phy regulators in order of:
0.88 -> 1.8 -> 3.3 respectively.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---

Downstream kernels on QC targets use this sequence to power up
the phy and this has been tested extensively on multiple targets.
This change has been tested with upstream kernel on QCM6490-IDP
without EUD to ensure there is no loss or breakage of functionality.

 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index eb0b0f61d98e..e86d221b7397 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -79,7 +79,7 @@
 #define LS_FS_OUTPUT_IMPEDANCE_MASK		GENMASK(3, 0)
 
 static const char * const qcom_snps_hsphy_vreg_names[] = {
-	"vdda-pll", "vdda33", "vdda18",
+	"vdda-pll", "vdda18", "vdda33",
 };
 
 #define SNPS_HS_NUM_VREGS		ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
-- 
2.34.1


