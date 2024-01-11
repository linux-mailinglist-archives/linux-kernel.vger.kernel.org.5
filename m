Return-Path: <linux-kernel+bounces-23095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50D782A798
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927B22884B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76232594;
	Thu, 11 Jan 2024 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BQG5HhLs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31327F9;
	Thu, 11 Jan 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B5SNMd032044;
	Thu, 11 Jan 2024 06:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=ccmGKm86GpZ6Fq
	5Uw5JYt8QY72ZfravmrIVbyepEw/c=; b=BQG5HhLsi4MSh96Pz0uUtMKzCfhTEk
	SYigs/bEGp1Oleb7p/1i2b1JnGPHAm2GIovosvCXjgcg0D005W5elYgXE2+aW7o0
	28pLU0KApWb5c0I/qt4zjnQNQbZHDJegbW3Ea819QHswpXzRuohmnou6xW8gPdTq
	VZ6z6ec5N0ftXJpy3TKESgjT4uRfCw31Oc619oEqiY3KUhxVgGbkzYk5yPex+MJh
	TZexHaTElUDJgG2XNQRkWOGeEagk6MUMeLUkyp6TpGhSuYuB8z8csuVGz4W9HOCt
	wQ2BtFRITHN+d1EY/h31fy7YHc7K9Cadg2UkmurlSeLRZy49/P2eE9NA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhuak254n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 06:32:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B6WbYj023430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 06:32:37 GMT
Received: from hu-skakitap-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 22:32:32 -0800
From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH v2 0/3] clk: qcom: Add dfs support for QUPv3 RCGs on SM8150
Date: Thu, 11 Jan 2024 12:02:27 +0530
Message-ID: <20240111-sm8150-dfs-support-v2-0-6edb44c83d3b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHuLn2UC/32NQQ6CMBBFr0Jm7ZhOgUBceQ/DAsogs4BiBxoN4
 e5WDuDyveS/v4NyEFa4ZTsEjqLi5wT2koEb2/nJKH1isMYWhkyBOtVUGuwHRd2WxYcVTV05pqr
 Kqc4hDZfAg7zP6KNJPIquPnzOj0g/+zcXCQ22JXM39I46svfXJk5md3V+guY4ji+vxiFUtgAAA
 A==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
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
X-Proofpoint-GUID: YNFYFgaqpkUgHs84X3jCl2A7jsD8bfmW
X-Proofpoint-ORIG-GUID: YNFYFgaqpkUgHs84X3jCl2A7jsD8bfmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=764
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110051

Add dfs support and missing resets for SM8150 global clock
controller.

Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
---
Changes in v2:
- Use dev_err_probe instead of dev_err.
- Remove Fixes tags as there are no bug fixes, but just updates.
- Link to v1: https://lore.kernel.org/r/20240104-sm8150-dfs-support-v1-0-a5eebfdc1b12@quicinc.com

---
Satya Priya Kakitapalli (3):
      clk: qcom: gcc-sm8150: Register QUPv3 RCGs for DFS on SM8150
      dt-bindings: clock: qcom,gcc-sm8150: Add gcc video resets for sm8150
      clk: qcom: gcc-sm8150: Add gcc video resets for sm8150

 drivers/clk/qcom/gcc-sm8150.c               | 352 +++++++++++++++++-----------
 include/dt-bindings/clock/qcom,gcc-sm8150.h |   3 +
 2 files changed, 215 insertions(+), 140 deletions(-)
---
base-commit: ab0b3e6ef50d305278b1971891cf1d82ab050b35
change-id: 20240104-sm8150-dfs-support-087ce1773183

Best regards,
-- 
Satya Priya Kakitapalli <quic_skakitap@quicinc.com>


