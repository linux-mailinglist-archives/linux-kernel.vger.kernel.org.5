Return-Path: <linux-kernel+bounces-117411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB888AB03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D356A1C3F5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193AB14A62E;
	Mon, 25 Mar 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FtxMNu9b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4D1494C9;
	Mon, 25 Mar 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381818; cv=none; b=oe6orBgEFhWRhVdrLTA3Jd+YJwD42WjInzyApqvyIgBqNgoW1dLIHuLaMBLifqOfNZNMBLuhdjOVsQ981w9zFH/YS7hk8nLhSkNskLRGLe8XtUGbIiMTn/+MCcL+LUkzY03mjb41xtOWN1kv7v6tZp6L+v2jRUoTFrEaKfHQEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381818; c=relaxed/simple;
	bh=EwOpezQ2pothZpjOt4xuL/Pb96Y2uEcCvIgHjARKhZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=st63V3kUQ/jpvqYgS6RDhU7/wFaUBrEBLNT6r/U9ze/3JYZfrYxIkVJcxNP2z/LjgI4fG3TGX2mM1KzbVzOzUF4egF7p3DkWAh7kzTkgh8wjyG1CLuEM3EnExWJJA1mRDh9HWun/XOPbyhozCk1WASVCWtPgC97cf/JiSEt1Ol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FtxMNu9b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PEHw6h000694;
	Mon, 25 Mar 2024 15:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=eyrXz1JNwHD6xR3M+hnFxRPVw0WoB+VC9URZ8Fygnxk
	=; b=FtxMNu9bngAGaCG8Q0rCvozbGSPzse4psHO7GCwp1r580grsCsy9kTphN21
	8ve1wVnNvXpx+ZMoHl2befS9PjdU4obcY4RBPPlH15QljWDkHgTOlLcYoVS5a8Fw
	yKKG9sM8x1Fikblyw6VvSDz1iH6l6nxi87wNXy4U5TG5qVwxrFklsZMLfmyuBk81
	csIiknb7Tj1TSGHEUBz9J+gu/l2HGduwhr3ralEOCWHdViLwIGASvTtGYq2XjOra
	4gKKa7Pproa5bh4qK5gBR0TJO7QgC7MVXeLH/V7sm05Sd+t13DlxVnzRn+GRU0+p
	pnUsyrsADMGjbr5Vh4uIiMV2R3A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x31wssg1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:50:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PFoCon026200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 15:50:12 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 08:50:08 -0700
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Mon, 25 Mar 2024 21:19:49 +0530
Subject: [PATCH v2 2/3] soc: qcom: socinfo: Add SoC ID for IPQ5321
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240325-ipq5321-sku-support-v2-2-f30ce244732f@quicinc.com>
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
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711381799; l=796;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=EwOpezQ2pothZpjOt4xuL/Pb96Y2uEcCvIgHjARKhZ8=;
 b=9EN+wYTDK/m+7E4mfOzaeBDFSqTrLEs8QZQPX/wVGpw0PsujvSOx+EtEf0oIAVXRzjGumwg6c
 UjNFF3um/9BCz1W9Me0knKdoO8rR4rIJBCTeGdGL+/qrshEvA56/jIN
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KgDIX-upGuolhrUZWe0KK9p6cC-gCqHj
X-Proofpoint-ORIG-GUID: KgDIX-upGuolhrUZWe0KK9p6cC-gCqHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=929 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250088

Add the SoC ID for IPQ5321, which belong to the family of IPQ5332 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 277c07a6603d..287139f0cb1c 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -445,6 +445,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(QCS8550) },
 	{ qcom_board_id(QCM8550) },
 	{ qcom_board_id(IPQ5300) },
+	{ qcom_board_id(IPQ5321) },
 };
 
 static const char *socinfo_machine(struct device *dev, unsigned int id)

-- 
2.34.1


