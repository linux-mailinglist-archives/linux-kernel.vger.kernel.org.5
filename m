Return-Path: <linux-kernel+bounces-164149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D768B79E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E628934B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7D180A99;
	Tue, 30 Apr 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ftLxwIR3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D8152797;
	Tue, 30 Apr 2024 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487439; cv=none; b=WENa1qnK5WYM1bCUC9K6noKTGBKCgVqKot+brvZRHis2OAPm4BiAzqmmwzKC1zBfppwFVwEzSHPUDYQ+4yLOTX+iEt6DwM2pd2qnah1Oeg3eqm21j/+aOAtT/3IYJ3Kjwu83WsJwI1p57WXdYIsGJiLdF4DcesXxzUSQVEzIYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487439; c=relaxed/simple;
	bh=507ao6veJvos8djQ/vkxSB93Ylf4TIG2MPrbWPIoPeg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIx76JtmYGHr1tE5EaBFYQlaHD3RPJgBoHGUcyN4wOOJ3i1xN4eipafLG8b+kkMswIa+aexnXbmxKfCcTxGT5kf7JGumW047UdrzCnnvqv5qI4/Fe9HCzruDE7T2yhj//NgvsVJ6i0kxax4IJTvbxkxxxCMXQdm9sc13Ea17p6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ftLxwIR3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UDm6CO024573;
	Tue, 30 Apr 2024 14:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=NQg0UhSk2EZ0C6RKEJX8xxVV5b+m49TUFbA2iV97yq4=; b=ft
	LxwIR3fCazztuWaEUZucoj0U8ssR4OTl+nq+9PwIziFFn/cOWvApjjwNGu3USL0G
	59SU8xQvp6eG7pX1aXJUh1mZ3SB5/1XTFF12V8t22w4XD+xEx/l1bGhGLlb3Sm+H
	K/yQqkPglPrwpbZLYUwHsZ1nIcFrKmW1eqwXuT4hdSVHAbo575u+qmXNM/+Inz8p
	WIolr2p+/yi5ef6LJEaN2fQpp/esGeY3WItPmMT0vaP70X10TzO+OLMieP7gSGKD
	UUkfk/VRo74nazlLxUPYX8bYIiRdiz3+pJF7jkiIznMBCjpNMm4Ky7N/acRCrkmG
	VhMXq2Ezz7jH7ba6RNTw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtvf7h1da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UEUXeJ024338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 14:30:33 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 07:30:28 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: [PATCH V3 3/8] clk: qcom: videocc-sm8550: Add support for videocc XO clk ares
Date: Tue, 30 Apr 2024 19:57:52 +0530
Message-ID: <20240430142757.16872-4-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430142757.16872-1-quic_jkona@quicinc.com>
References: <20240430142757.16872-1-quic_jkona@quicinc.com>
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
X-Proofpoint-GUID: GB1ckkfAUYMPR-G461qCFop5mRbmJ4t-
X-Proofpoint-ORIG-GUID: GB1ckkfAUYMPR-G461qCFop5mRbmJ4t-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300103

Add support for videocc XO clk ares for consumer drivers to be
able to request this reset.

Fixes: f53153a37969 ("clk: qcom: videocc-sm8550: Add video clock controller driver for SM8550")
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/videocc-sm8550.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index d73f747d2474..25133cf5a2b8 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -10,7 +10,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
-#include <dt-bindings/clock/qcom,sm8450-videocc.h>
+#include <dt-bindings/clock/qcom,sm8650-videocc.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -380,6 +380,7 @@ static const struct qcom_reset_map video_cc_sm8550_resets[] = {
 	[CVP_VIDEO_CC_MVS1C_BCR] = { 0x8074 },
 	[VIDEO_CC_MVS0C_CLK_ARES] = { .reg = 0x8064, .bit = 2, .udelay = 1000 },
 	[VIDEO_CC_MVS1C_CLK_ARES] = { .reg = 0x8090, .bit = 2, .udelay = 1000 },
+	[VIDEO_CC_XO_CLK_ARES] = { .reg = 0x8124, .bit = 2, .udelay = 100 },
 };
 
 static const struct regmap_config video_cc_sm8550_regmap_config = {
-- 
2.43.0


