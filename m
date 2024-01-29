Return-Path: <linux-kernel+bounces-42180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB7283FD87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B201F21608
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4321F4C60F;
	Mon, 29 Jan 2024 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lS/VhMQs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE442040;
	Mon, 29 Jan 2024 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505120; cv=none; b=rUzoinv2BT/ZK8LlP2hZzc4niZuCqS4ZgB0mKDAyraAdnkvpbOWO7qh6udft9gr364VkQIIAAyF21hItUTJNG4FWBKi8KZKbe7P37g+eVuMLeTVSfdElyVQTVDt7WsTAwLx4azCPNdbxmXxt48B004QI/v6X8K6XxD0P62sfoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505120; c=relaxed/simple;
	bh=f9TcKYkkf/z/yoCeEfzmTw3EPsUdgLijhbssXt1XUdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruubRBrxauIBBPBlXEm+fbZF1B5lBZ5lywnVkszVQB6/3US5KaiNtq2eqSuegC7Ho6V51ho3AtIh6JvA6b4RWENyI/vPr/5+aXbkPx8Wa/107s487FO158fP6W3izHLeFEe3QUw82GPExVFcOWdEJpRi732ize85oF4JhyXGvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lS/VhMQs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T3hBOW006158;
	Mon, 29 Jan 2024 05:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=nq75HA+fK1Pl8uqJrSzFdntjodrF5a/53JwQ1wAwz2I=; b=lS
	/VhMQsGOBj6mizKiBD43My+bmy6RZfnbuHy4DJ7rVs5VtQ1qmAH28+n8LInPSo/Z
	furRRZxmOd6myjgfEF8pgCYWY9fdmYgmMzGgpcEZYFNAL867emhL2PtkguzD+tjA
	zI/TmjqbmkocqER1w6EsWohTW3HGKBFP+JgLFsY7Xf9X71c6DZXULRstqsPX2Zll
	DTnazu/5NsJTV0Zold2ISpndY1WRce5kyD6OUOggJOhCnrS7DUDEFxDPKts4qLD+
	WS6q8UIXumqVoBGrYhoReIBTrXwxv6HynCmg5aPH8wfvuEqlSuk0tgunXTr/nDZi
	elJKo6roquMBLfNKuUSA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvrubaucu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:11:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T5Bdqm021711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 05:11:39 GMT
Received: from hu-devipriy-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 21:11:32 -0800
From: Devi Priya <quic_devipriy@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <p.zabel@pengutronix.de>,
        <richardcochran@gmail.com>, <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V3 2/7] dt-bindings: clock: gcc-ipq9574: Add definition for GPLL0_OUT_AUX
Date: Mon, 29 Jan 2024 10:40:59 +0530
Message-ID: <20240129051104.1855487-3-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129051104.1855487-1-quic_devipriy@quicinc.com>
References: <20240129051104.1855487-1-quic_devipriy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O-5t4atiUpw9ytgtqNLayFzyAAhtLFq-
X-Proofpoint-GUID: O-5t4atiUpw9ytgtqNLayFzyAAhtLFq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290034

Add the definition for GPLL0_OUT_AUX clock.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
  Changes in V3:
	- Picked up the Acked-by tag

 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 08fd3a37acaa..f5749bf53898 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -216,4 +216,5 @@
 #define GCC_CRYPTO_AHB_CLK				207
 #define GCC_USB0_PIPE_CLK				208
 #define GCC_USB0_SLEEP_CLK				209
+#define GPLL0_OUT_AUX					210
 #endif
-- 
2.34.1


