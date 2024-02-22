Return-Path: <linux-kernel+bounces-77485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A5086063B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33323B233D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB620DE8;
	Thu, 22 Feb 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PiPDXQiK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8670818059;
	Thu, 22 Feb 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643298; cv=none; b=UANWh0B9F9yeGk/3/UKePqbIkp2bDjwBMj3s2p9pFEKYUICoqQ19xayPdO6SWLZmoZx22U8FAePrkd5puDxJQI5XycbCdHWrmDjbebNgehx/dIKUt+rgF1o+2fdpXJjmCZEoIwqaItsfLF/oIEy/pDkoF9NK9iMm0wJAyiEVGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643298; c=relaxed/simple;
	bh=WV7is+GZWotLOyr/LJfdqKxKuPjO3bhLxlur0mKeBeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQq0+03W5xV4kqWjCSJIsPbhg4/TPGHsM+rtF92tE4e97497kjf0tohJ11IPr79evMcFHxAH1nIMmXr49BbyWSseEhuNAN3DIVnaYucSEhuycYzScoDU5EtVxhxwI6gdmOUfKuaUJSbwfTl52NXVdLGPuz3EGZDgU8O5B/7sVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PiPDXQiK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MN6CoO009088;
	Thu, 22 Feb 2024 23:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=XkoTJEI1H9WS/l6Sp9i9Pr6+5+Uqu6NrC2M+bSJ0ppE=; b=Pi
	PDXQiKuPVVL526K2VkjiLlt+j6r+Pw9K+9ztVG9DOJ3352Bmp6l85nG4LU5Ln1q5
	z/2xfkbAThK+zuWeYeVxBvFxhV7x56acV61jLhJuft+CZQsrwgId985mkr+QNSVU
	opipVSW1V5ICNPmrP836KU+EyX2jy6KaNBXbG9RGfI+6maNt2j7xHxJklKMTtquT
	Re7Zlkv97SVLrdg2vsbRQSvOq4TXQ3m0A8KeqK306ezu7Hu2TvrD+oeWaisWYMLN
	O3rUJq/YHtnLj7Ng3HeFgQ+8BAqiBpsT/YMKmlaXiZcyAboWDU1CSVfOIUc+x9b6
	p7HKaLxFoXOhd8fZTv5A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we3231gjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:08:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MN8BOe014137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:08:11 GMT
Received: from hu-uchalich-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:08:08 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
Subject: [PATCH v3 5/5] arm64: dts: qcom: sm8650: Add mapping to llcc Broadcast_AND region
Date: Thu, 22 Feb 2024 15:07:57 -0800
Message-ID: <36fed182281d560050b5d4432aebbd8ff7387934.1708629933.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1708629933.git.quic_uchalich@quicinc.com>
References: <cover.1708629933.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nzTreteax4TBr0_D2hI8lbzbSn3Wp10F
X-Proofpoint-GUID: nzTreteax4TBr0_D2hI8lbzbSn3Wp10F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=609 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220178

Mapping Broadcast_AND region for LLCC in SM8650.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..daa5738b955e 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4735,12 +4735,14 @@ system-cache-controller@25000000 {
 			      <0 0x25400000 0 0x200000>,
 			      <0 0x25200000 0 0x200000>,
 			      <0 0x25600000 0 0x200000>,
-			      <0 0x25800000 0 0x200000>;
+			      <0 0x25800000 0 0x200000>,
+			      <0 0x25a00000 0 0x200000>;
 			reg-names = "llcc0_base",
 				    "llcc1_base",
 				    "llcc2_base",
 				    "llcc3_base",
-				    "llcc_broadcast_base";
+				    "llcc_broadcast_base",
+				    "llcc_broadcast_and_base";
 
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
-- 
2.25.1


