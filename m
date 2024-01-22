Return-Path: <linux-kernel+bounces-32370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263AD835AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BACD1C23685
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46020DED;
	Mon, 22 Jan 2024 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aOJjOfMQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC51BF5A;
	Mon, 22 Jan 2024 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903083; cv=none; b=raNMoU+g4XkHB0eL+4UQVsIEXK+tlSKq7Ccjqt6GyFxWWuY16vZSIbKwXj3hShGToU6OWvRREnNp8SSE3BWaFuwAsN9gFzZqiJDxPB/s1sT/+izHfluXuwfdqiS1T2jqg1S2W/BI0/rIk7hJuYw6JWr15hsJmBwYWjsPtOtlY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903083; c=relaxed/simple;
	bh=ZFABy3wIGKe3WczwJSJD/soDh+HH9XDqDnCkZkz6nb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hf80tKpZqg49IOBfN/ThJZwJlnryj0I8nZEf6mgK+gueDMo4GzbGkQHDoPJs6n5ITsK2s5LsLUAdOyLPZS3s1JeaMPRpWwEhRXApOzhpuGG209OaiNKCxAf9ng8Z2pZz+OfVN/NNEb/6rBBQUjqmFxGtACaWEED8wVOD7uvmURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aOJjOfMQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M4HQbx007791;
	Mon, 22 Jan 2024 05:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=QYtlvNtzfyCM7Q2609BVYr0EXpFpXbxBU7URO7azmew
	=; b=aOJjOfMQ9mF1AfNS4zh3RDhNDmu7c6DGDk3+B33vy8DWTWOOTCTSoE1Qtnv
	PQ8vUZoeuYNUNdqTCo91ctkJ+ETxYvim8j4OugB54WMBZItrVYAgWKCBl/g3Dkfg
	PbR7yUq6Yw2QyQuseDROv1Z12lnURH70pY8HIvGKBfAMN8EoYWi2KxWPQykGE3sx
	vpmjYrz5Ja6x2Av1lGisM1lTSW0C1SS9Fa0YexxwkMKK95pngedaBagVqNTW7M6K
	T8tqMPMzXLzU+YN2EN2uEBE9NmNoGM1HPggvcW9ihsell23eIRlBDIkZx0521pC1
	dNrNcdIuS5aQRRVOPyLd4VTBTjQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr68x31wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M5vqa9017533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 05:57:52 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 21 Jan 2024 21:57:47 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Mon, 22 Jan 2024 11:27:04 +0530
Subject: [PATCH v4 8/8] arm64: defconfig: build NSS Clock Controller driver
 for Qualcomm IPQ5332
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240122-ipq5332-nsscc-v4-8-19fa30019770@quicinc.com>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
In-Reply-To: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan
 Thirumoorthy" <quic_kathirav@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705903023; l=764;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=ZFABy3wIGKe3WczwJSJD/soDh+HH9XDqDnCkZkz6nb4=;
 b=Er8T19v/OG+zquhGt6CcUjIxg7XkWtCTnIdzKYJ1qTLKCfDKaxZbKdH2ixBVRNxW4Fioo7Rsc
 c5Uyhj+n2IaAT43okb9qyrt8JQOpsx8YoEBF/W7s9x7ctaYPOTK7TR7
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b0rG0eE1UTB8zFdquSdBvbXtGwb_GhBX
X-Proofpoint-ORIG-GUID: b0rG0eE1UTB8zFdquSdBvbXtGwb_GhBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=733
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220041

NSSCC driver is needed to enable the ethernet interfaces and not
necessary for the bootup of the SoC, hence build it as a module.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..c49ec1f618fc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1255,6 +1255,7 @@ CONFIG_IPQ_GCC_5332=y
 CONFIG_IPQ_GCC_6018=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_9574=y
+CONFIG_IPQ_NSSCC_5332=m
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_MMCC_8994=m
 CONFIG_MSM_GCC_8994=y

-- 
2.34.1


