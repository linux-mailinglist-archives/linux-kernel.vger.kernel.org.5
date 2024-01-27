Return-Path: <linux-kernel+bounces-41458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A607583F224
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE30284948
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C742E835;
	Sat, 27 Jan 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U54o7f9B"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F364200BD;
	Sat, 27 Jan 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398184; cv=none; b=Msdlqi0Tllfhc4Ted7XZZgEYVNSHm5EqnLohapk3/TUgSnRVX3eekN7JD7oJeFswS5SjyHPw6Q6tgC35mTcfgvyrLNKBs7b7MhdZzUqv3pto362cRb5BPazuNwPuMeZoDwcLvpkvOOjwLmXkKpKrFob942t7zyRiwxppH0Hlnek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398184; c=relaxed/simple;
	bh=potbFclKfnBq3j0GUJ+P4wlLfgbpq1NvSB/gWrUhxYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2tF7z8CBRdcvRNMPy4Rh8Yn2sGnPuWsUjLAezZqpKPH578cLXaUj0RrvFxCwO+Qenw3TopDRU9FZcgDCYM+REOyq+n64819MbuRAqZagNP8KD0v7wfkmdvuaoRtPsoyYxPsgXmQNO0D1m1Ly/IULRn+Bo+Y7GbXt5u4iSEyWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U54o7f9B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RNDZqF003351;
	Sat, 27 Jan 2024 23:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9n5q1g0UwaFVCc2WjJgGkUUt2Q5/PH1F2MWmA0Uawms=; b=U5
	4o7f9BlMyTRRfw8RqfJ/YNWjchE9r8nCie6/GRcUF/8/9THLJDrNlvOGnWxd0E6o
	gvsvb/vsOH+y1siEfYlm7IINl/GN+Tz7WfwdD1QEkavWL6ZVjyKE7OS+lJT5vL6c
	9DpjEjeH+VZ+LJ6b2tSZT+g9LFehrzrMBHCNU8wjQ8Rl+R6R07nj2ZQJuHBS+rnY
	bZ0gm32CxGImIk+yYJOFqCA72xgYNnXyRIGGh7F3NMQ17DephzU5q4KWbVuKlf1o
	30odD6HKWM+38aX+MPCuZJfgcsUz+RUM0hl5eN426yT7s7THUZD2fnih9+EqhYGx
	A+pTW14WDAJlm3H8A1yA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvrub95r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40RNQOLu030323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 23:26:24 GMT
Received: from hu-gaurkash-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 27 Jan 2024 15:26:20 -0800
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
Subject: [PATCH v4 14/15] arm64: dts: qcom: sm8650: add hwkm support to ufs ice
Date: Sat, 27 Jan 2024 15:14:12 -0800
Message-ID: <20240127232436.2632187-15-quic_gaurkash@quicinc.com>
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
X-Proofpoint-ORIG-GUID: N49R5dCBw9SrZqO1oH6F2jv-W7B6gbrG
X-Proofpoint-GUID: N49R5dCBw9SrZqO1oH6F2jv-W7B6gbrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=943 spamscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270178

The Inline Crypto Engine (ICE) for UFS/EMMC supports the
Hardware Key Manager (HWKM) to securely manage storage
keys. Enable using this hardware on sm8650.

This requires two changes:
1. Register size increase: HWKM is an additional piece of hardware
   sitting alongside ICE, and extends the old ICE's register space.
2. Explicitly tell the ICE driver to use HWKM with ICE so that
   wrapped keys are used in sm8650.

Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..c27daf576af5 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2524,7 +2524,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 		ice: crypto@1d88000 {
 			compatible = "qcom,sm8650-inline-crypto-engine",
 				     "qcom,inline-crypto-engine";
-			reg = <0 0x01d88000 0 0x8000>;
+			reg = <0 0x01d88000 0 0x10000>;
+			qcom,ice-use-hwkm;
 
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};
-- 
2.43.0


