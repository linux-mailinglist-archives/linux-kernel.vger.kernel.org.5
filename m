Return-Path: <linux-kernel+bounces-52533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C284995D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42C91C2299A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0D1B949;
	Mon,  5 Feb 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AYcqcTDO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8461B802;
	Mon,  5 Feb 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134303; cv=none; b=sxyjt/+oORih4yUeLk9GtnoaRoMrRWqDJH8rVrXc4pZzwHMYBe/2yd0bOmbRVm4J+4GA9xfe7WZrex8F5jj4A1f1nVoQkgMWJXy+87Sp86Jq6b0EWQUHEeyfBvzxEKnGPEtE1OF5n2e2ZwvIRhu88TeHRNHc3riDa+yqwR/ad2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134303; c=relaxed/simple;
	bh=wU57fJ2WKACeApjVt9T/gTXYvdWp98v7QTeUYlS7ONY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBz9IKgjDCYpAnjVeLzuuFonpXNq+GdRwroKqqlyo5NTR3qnfwbF64i6k1N6peqXk/GRFRdt9jC4Zkx7sRv/w2KxKoGigO7Esthroh2Ev4sGDoRK629tZSiAXj29Hr1pYWX7bxf/VQNHX2t9uukiNfg/qguScu3wU+ZguKX0a9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AYcqcTDO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4155TFJb022829;
	Mon, 5 Feb 2024 11:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=GfE8TGQiFDs1RZ3QOaIRQUHhIiJCP2C5GbgovzIE/lI=; b=AY
	cqcTDO+cmK6KaJ0j/78CcP8qs4X5bDaiKeeMedOZ12HtNc5s9hN90h1Z7kHB0JEb
	UrVkI5NdlAfL7S+DlN7tYMJ1AnuPDu0hVNYvUxIG6oNfzZPqlmMzeyLZp3KwTz51
	dsSS80+e61tMVQKJXOFuqpwbIeigVpYtrBqNkSfKAce61oxiBHrNKE7MhJWG6QCX
	+GF+YldTiwamfanvrDA93lNWwrdkdTYS4h945AwCOiwIaiJs7J7WpnLAnPmN6Tqq
	FKHev2GiLO4go1OzpDqYcHXvT1jFthg1EHEev7V0nUrLMtwVx0ObdwFHe2M3yjcm
	M3RYC5ooZIjoY3mkt2fw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2rjtrry2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 11:58:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415BwGrx030023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 11:58:16 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 03:58:11 -0800
From: Jingyi Wang <quic_jingyw@quicinc.com>
To: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <quic_jingyw@quicinc.com>, <kernel@quicinc.com>
Subject: [RFC PATCH 2/6] dt-bindings: arm: qcom,ids: Add SoC ID for SM8650P
Date: Mon, 5 Feb 2024 19:57:17 +0800
Message-ID: <20240205115721.1195336-3-quic_jingyw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2HOiNR0Z_pRPAHNNKwy83r_znLFx2Kqn
X-Proofpoint-GUID: 2HOiNR0Z_pRPAHNNKwy83r_znLFx2Kqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=434 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050091

Add the ID for the Qualcomm SM8650P SoC.

Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index dc7ba87b50d7..22559fe3891f 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -257,6 +257,7 @@
 #define QCOM_ID_QDU1000			545
 #define QCOM_ID_SM8650			557
 #define QCOM_ID_SM4450			568
+#define QCOM_ID_SM8650P			577
 #define QCOM_ID_QDU1010			587
 #define QCOM_ID_QRU1032			588
 #define QCOM_ID_QRU1052			589
-- 
2.25.1


