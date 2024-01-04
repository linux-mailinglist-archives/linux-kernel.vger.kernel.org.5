Return-Path: <linux-kernel+bounces-16783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED66C8243B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86255285722
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2222322F11;
	Thu,  4 Jan 2024 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kb7SQSY6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B822F14;
	Thu,  4 Jan 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404DTST1015771;
	Thu, 4 Jan 2024 14:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=RSiX/nlv3LYAiV
	eziNiiqDW6FTFfdI/6EMRMpkIGZcE=; b=Kb7SQSY6/AwgbcE0dqjiH3Hxv9vvc2
	SaVsS6k1iibVq+zSRDhzPUoSf6c1AGGzJ+wS9KNOaKaw/oHTiDrbxzxSQaDorzLl
	+k/VXbihdjb/n1kwA5qxjeL7JnrtU0ZfAGEWHfumcUlCM/bzo879DlAwC1vipdRi
	leNXd/B25LP8q5g4y82VXw/fmA8Kfbj6AeNIBJuvlkpkaVzj5ykleKSQkW3HFjoa
	Kmf/7qFUjhpb6o1W+LMjjbPzlfYdYDh0R/b9BJO7UdKywYVWEvVLl0lEVicc1aG1
	xQi7pXea8F0H6uhtGIHbkj2+Ms5kqhpxOzrvYYvhkNgO4Q7lCuNgtFFQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vdqb1s4yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 14:23:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404ENNb5021241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 14:23:23 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 06:23:18 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH 0/3] clk: qcom: Add dfs support for QUPv3 RCGs on SM8150
Date: Thu, 4 Jan 2024 19:53:03 +0530
Message-ID: <20240104-sm8150-dfs-support-v1-0-a5eebfdc1b12@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEe/lmUC/x3MPQqAMAxA4atIZgOJP7R4FXEQjZpBLY2KIN7d4
 vgN7z1gElUMmuyBKJea7lsC5xkMS7/NgjomQ0FFRUwV2uq5JhwnQztD2OOB5N0g7FzJvoQUhii
 T3v+07d73AxdjZ/RkAAAA
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
X-Proofpoint-GUID: vu4WSVYwThloEeMVgG2NDWL8Sb06w45T
X-Proofpoint-ORIG-GUID: vu4WSVYwThloEeMVgG2NDWL8Sb06w45T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=785 clxscore=1011
 malwarescore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401040113

Add dfs support and missing resets for SM8150 global clock
controller.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Satya Priya Kakitapalli (3):
      clk: qcom: gcc-sm8150: Register QUPv3 RCGs for DFS on SM8150
      dt-bindings: clock: Update the gcc resets for sm8150
      clk: qcom: gcc-sm8150: Update the gcc resets

 drivers/clk/qcom/gcc-sm8150.c               | 354 +++++++++++++++++-----------
 include/dt-bindings/clock/qcom,gcc-sm8150.h |   3 +
 2 files changed, 217 insertions(+), 140 deletions(-)
---
base-commit: ab0b3e6ef50d305278b1971891cf1d82ab050b35
change-id: 20240104-sm8150-dfs-support-087ce1773183

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>


