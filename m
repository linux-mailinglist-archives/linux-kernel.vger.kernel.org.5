Return-Path: <linux-kernel+bounces-16786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F48243C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922A8285C39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2C322EFC;
	Thu,  4 Jan 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IEB/+bGv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1E241ED;
	Thu,  4 Jan 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404E01EN026938;
	Thu, 4 Jan 2024 14:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=C4eC814GmPEtEFPN+OlM7TiAaskuBpnOkF9UFumXED8
	=; b=IEB/+bGvPcQQDNkK8nnwGZ0R4sP3lrf17yW2F00V/uRxS5m/W4qnqqUwIp/
	BBDXfYV/XEqaziF0RHYh50LK8ug+TA/KILDUW5mys8a93k8wnLsOe5HztEm7TpmV
	11ZKgHYRo67hdHvycUwd+SPTgw2J1Is/gl4uIu/KQczyWo5hNkhGy9qjTQVEQD90
	s1HewSxi6qZVaO7dtc3cksGoemU47YTC7OGT/kdnrEMDy7dENBgNBT8PsbMoVA9h
	FvOUzW57T/lChVjiVLGyvliIKTQqjDIoCM48FkzOc31UzD+oZ8Rfok1oXFvoQfEU
	3p8uvAViaD1V8R16g1NSeww+GhA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vdx28024d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 14:23:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404ENd1i011620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 14:23:39 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 06:23:34 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Date: Thu, 4 Jan 2024 19:53:06 +0530
Subject: [PATCH 3/3] clk: qcom: gcc-sm8150: Update the gcc resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240104-sm8150-dfs-support-v1-3-a5eebfdc1b12@quicinc.com>
References: <20240104-sm8150-dfs-support-v1-0-a5eebfdc1b12@quicinc.com>
In-Reply-To: <20240104-sm8150-dfs-support-v1-0-a5eebfdc1b12@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Deepak Katragadda <dkatraga@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UdK7BLfOJYq5U9ywj3RJpE5aIpf8MN_p
X-Proofpoint-ORIG-GUID: UdK7BLfOJYq5U9ywj3RJpE5aIpf8MN_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=778 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040113

Add all the available resets for the global clock controller
on sm8150.

Fixes: 2a1d7eb854bb ("clk: qcom: gcc: Add global clock controller driver for SM8150")
Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
 drivers/clk/qcom/gcc-sm8150.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 6d76fd344ddf..833e64b61e6b 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -3778,6 +3778,9 @@ static const struct qcom_reset_map gcc_sm8150_resets[] = {
 	[GCC_USB30_PRIM_BCR] = { 0xf000 },
 	[GCC_USB30_SEC_BCR] = { 0x10000 },
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+	[GCC_VIDEO_AXIC_CLK_BCR] = { 0xb02c, 2 },
+	[GCC_VIDEO_AXI0_CLK_BCR] = { 0xb024, 2 },
+	[GCC_VIDEO_AXI1_CLK_BCR] = { 0xb028, 2 },
 };
 
 static struct gdsc *gcc_sm8150_gdscs[] = {

-- 
2.25.1


