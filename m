Return-Path: <linux-kernel+bounces-156328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E958B0142
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B5A1F23FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D861315687A;
	Wed, 24 Apr 2024 05:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lqXq62DI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1E13CFAD;
	Wed, 24 Apr 2024 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937576; cv=none; b=k9ee/JWn4aRpzEB2yimx0EukBFjFxkLwZ+sCRUA+n6z6oyWvgbMQcDhtc655d4Zd5LUjNbRjOu/mBKRZ8txoeeDx4WSkuIowunuJU8SJ1MjfPrg5D/OW9ah5vI5fdRKcYufvq6PNaWoulB9xdIAqPYz3lVceVMr5/6s816k67dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937576; c=relaxed/simple;
	bh=uwxUJBzuUS3WaFJagRhqzdd7FDplM881l5RFTKnaqg0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B9IUBGmk/lFaDeVgtjEHfQFeYudTiMVJCb/CKeJxuGcgK0bYXaTBPNXPqLKJMcR7ODmPyxNzOXxeTjnPl6+LLubtFmdEQArII6/jlKrBDr9idghM9JAQOf86Z48lbawepICQGtgvGagOZF8OyiIp4sIBNhekEebxV3/apEc6tRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lqXq62DI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0jCrE006734;
	Wed, 24 Apr 2024 05:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=b2Nj9uwekS1C
	wRhb+sjbn8p7cNsJyk7FOMTsrfPdKQM=; b=lqXq62DIOSklUMrt8xjk12ZU5/Qt
	ukSrXHCZiQxvqF3+M7w/pTcM7SzhvtE/WIJo8m8xQ1JIlzJPu5hOdsgtiybjA9av
	80+3B2kIWw2Rf6jE3/LdBLsKXtaV2ywPBzT1nPKWq7ACHG0w5OoRd7EYNpD0F14L
	uY4+IjWQjA1YgFrHQ+P8rCh+HcsVyU8qQjFC0LpwI93C1RAVW02g40S8IXmvOp5z
	0WWdi2O1AUUY4ZqykO8hLrlir6RrKtWrhKKHBQllcIEt/aoZyWlZRlVejp3QdzVf
	w09ECN8aATA+uR+/a+Zr6N1gQdJj8zWaV3NteAQh1Zp+8/KDcK8XpNnSKQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpcxejhx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 05:46:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43O5k5Q9000560;
	Wed, 24 Apr 2024 05:46:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3xm6skt5p9-1;
	Wed, 24 Apr 2024 05:46:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43O5k5Nf000526;
	Wed, 24 Apr 2024 05:46:05 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 43O5k5s1000518;
	Wed, 24 Apr 2024 05:46:05 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id C66C55001C1; Wed, 24 Apr 2024 11:16:04 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v2] arm64: dts: qcom: qcm6490-rb3: Enable gpi-dma and qup node
Date: Wed, 24 Apr 2024 11:16:02 +0530
Message-Id: <20240424054602.5731-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vQNICJ2goF1RpE3nOSfzfWeW_hxx8-Am
X-Proofpoint-ORIG-GUID: vQNICJ2goF1RpE3nOSfzfWeW_hxx8-Am
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_03,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=774 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240024
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Enable gpi-dma0, gpi-dma1 and qupv3_id_1 nodes for
buses usecase on RB3gen2.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---

v1 -> v2:
- Move gpi node to correct place.
- Update commit log.
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index a085ff5b5fb2..577bf8560d1e 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -530,6 +530,14 @@
 			   <GCC_WPSS_RSCP_CLK>;
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -606,6 +614,10 @@
 	status = "okay";
 };
 
+&qupv3_id_1 {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/qcs6490/adsp.mbn";
 	status = "okay";
-- 
2.17.1


