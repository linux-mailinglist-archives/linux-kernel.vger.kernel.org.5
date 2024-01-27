Return-Path: <linux-kernel+bounces-41447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4A83F1E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FCD1F234BD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CDE200BD;
	Sat, 27 Jan 2024 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N+SLrg2H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785382E83C;
	Sat, 27 Jan 2024 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398009; cv=none; b=BtxVXeXacQLPt4xQ4Da+//oGq/J+Y+CDv3tuVQ25XHbDTRF93JYUxuWakPfh0nc9i6jmEwHhIxV07bvb+hqQ8b/PvzqWfpe3b09sldA4PdqfBWVYTVrDFleeAH3vZVNkiO5NlTfHmfHiz02n6UUlJbDV6dbUvaEqIP8eKS6/DSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398009; c=relaxed/simple;
	bh=9wzF5uhTqyPL+W/7HPPphtIkhNChQKivMp8cg5w8ySc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJdCw5bzW6kwfaLlnt+pHwLYHWXlXlw4KPdOikYpLAor4KL8vSw2vfwWZIxNKab8/IEoiqFnthOTJMqvtXW+RHB33wYGOWne7VoQeN+jr2v3fLr/pY3IJoNMVvL05exAR/Rir1vXioMmmlix3FC8deqhx9CnTGs9fQVbHS/XNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N+SLrg2H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RNAEdr017366;
	Sat, 27 Jan 2024 23:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ofgqnnCuGEgP5vdtT2GLtUEAJxXr9NXRvz9e1DlxJV0=; b=N+
	SLrg2Hvakf7wA50sdYaz9LKgym0T/s2Ndw/UJ6TAh3ZnJOglKlmS8gIXo0Zbwrsw
	sZI7AKtzibSk/NJtt++Ns5+8mv29XtPOUUP9HG6EOiSw+iUaifPXUvd/OuWZzXdK
	e4G0Z7E1ZNcVbSztlsDq3hA8o9ltwH6tMfQDYEgAIRBYVoCvgQMFRS5fq4n4unql
	fNwtxpTkEGVdvmDHqXOMqfmIrHDCJfxOsH8Oy5XWr+DUqeAioupTYUEkzq8mTVDk
	QmUoGOdmEamrt4zVriDX/A7OF6IpuiFktES/hgSHRZ80qk+fO7V0t7hmec1qUcfZ
	tnJrVZCPiK5hN7hjnMOA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvu4cs1s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40RNQOC7005899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:24 GMT
Received: from hu-gaurkash-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 27 Jan 2024 15:26:21 -0800
From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
To: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <andersson@kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <kernel@quicinc.com>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_omprsing@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <bartosz.golaszewski@linaro.org>,
        <konrad.dybcio@linaro.org>, <ulf.hansson@linaro.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <mani@kernel.org>,
        <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>
Subject: [PATCH v4 15/15] arm64: dts: qcom: sm8550: add hwkm support to ufs ice
Date: Sat, 27 Jan 2024 15:14:13 -0800
Message-ID: <20240127232436.2632187-16-quic_gaurkash@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2k26aFdIqI3WWqgfepNTgdZRDIS7y4GQ
X-Proofpoint-ORIG-GUID: 2k26aFdIqI3WWqgfepNTgdZRDIS7y4GQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=723 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270178

The Inline Crypto Engine (ICE) for UFS/EMMC supports the
Hardware Key Manager (HWKM) to securely manage storage
keys. Enable using this hardware on sm8550.

This requires two changes:
1. Register size increase: HWKM is an additional piece of hardware
   sitting alongside ICE, and extends the old ICE's register space.
2. Explicitly tell the ICE driver to use HWKM with ICE so that
   wrapped keys are used in sm8550.

NOTE: Although wrapped keys cannot be independently generated and
tested on this platform using generate, prepare and import key calls,
there are non-kernel paths to create wrapped keys, and still use the
kernel to program them into ICE. Hence, enabling wrapped key support
on sm8550 too.

Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ee1ba5a8c8fc..b5b41d0a544c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1977,7 +1977,8 @@ ufs_mem_hc: ufs@1d84000 {
 		ice: crypto@1d88000 {
 			compatible = "qcom,sm8550-inline-crypto-engine",
 				     "qcom,inline-crypto-engine";
-			reg = <0 0x01d88000 0 0x8000>;
+			reg = <0 0x01d88000 0 0x10000>;
+			qcom,ice-use-hwkm;
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};
 
-- 
2.43.0


