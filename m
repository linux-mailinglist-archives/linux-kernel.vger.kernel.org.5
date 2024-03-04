Return-Path: <linux-kernel+bounces-91370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C923A871033
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681B2285972
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE07BB1B;
	Mon,  4 Mar 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UeEgay1a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA218F44;
	Mon,  4 Mar 2024 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592109; cv=none; b=cJo0Lr70liu+uNSrbndjdXc4eOnospkFFAoNC6RQ4hiLEYg6uxsFlMgyXKlS4IlEAb80ngu5dSzjk0vVGpu8jR1FMcUFom5m1M5Jo61PyC2fYOCYWzvDEcQEIab7Qd2IlMO4IYsEnNWylkUaqGoTAeuJEVCk12Q0olI4210S/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592109; c=relaxed/simple;
	bh=HWFANnbfyh550S/G6W+HjyeNPbThbmyjuPz5MkKe0IE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=r6HBlYKvX9Gcw4m6oUTGgebMElzIxnrhHVETvZUNZ3syCYuILr/Sx7y8hE5BQhaRJXZ9f2OpzbRNdnhqBMYL7VCmzJ+NIg16aR9IeNmIW/zflGP9twS1uwnqpoxUl9xXzub5S8mAiGJwO49+D0xvfZ0z6wSKXEKquYZptrWhLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UeEgay1a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424MP7Zt014327;
	Mon, 4 Mar 2024 22:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=esL
	Cy/asd2qFbuOcZUlzDM/SjCHIES7hirGA2lXMTyk=; b=UeEgay1a9CGAIv1KRLY
	Ni2AtnFSFXSLd/94H6LdSMLUDDQb6j9hSBBEIABSR/+TScVvYpOPqeUcF+od00MN
	OfA6S39MbV4S/EKONr3ssExQmpU99KizElfBACRbW/BR1rgBq6StKr7ePOv/0+5U
	IDLL2rnenSgAVFdobVKl4ZkTHyZZSWQYjPjuniMSkMAIzpbUCkBYdjD1tHYJBKWt
	k4E2A38GZTS4O+jVs4mc5oSwbZo4qbl3XOLn8rqltn4L2bFqYb8FGYn1cUPqw5F7
	sszaghO2qc/CjcUEVIQtw+w4OHugT2NOTMh352EKRLl8SRA084NlgOcnKO9uA71E
	SsA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn8fxt355-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 22:41:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424Mfgjb011510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 22:41:42 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 14:41:42 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Mon, 4 Mar 2024 14:41:15 -0800
Subject: [PATCH] arm64: dts: qcom: sm8650: Add missing reserved memory for
 chipinfo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240304-sm8650-missing-chipinfo-region-v1-1-8a0b41dd8308@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAApO5mUC/x2NOwqAMBAFryJbuxCD/6uIhcY1vsIoWRBBvLvBc
 oqZeUglQpT67KEoFxRHSFDkGbltCl4YS2KyxpbG2pZ1b+vK8A5VBM9uw4mwHhzFJ5UXV1fz3E1
 NWTSUImeUFfc/GMb3/QBQM84PcAAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Patrick Daly <quic_pdaly@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rgYwrrmCIzi8zUlWTUUE6oIb8ZJvFvr7
X-Proofpoint-ORIG-GUID: rgYwrrmCIzi8zUlWTUUE6oIb8ZJvFvr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_18,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=821 clxscore=1015 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040176

Add missing reserved memory for chipinfo region.

Cc: Patrick Daly <quic_pdaly@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 12ba839f215e..a8f2bd7fd1ff 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -485,9 +485,9 @@ aop_cmd_db_mem: aop-cmd-db@81c60000 {
 			no-map;
 		};
 
-		/* Merged aop_config, tme_crash_dump, tme_log and uefi_log regions */
+		/* Merged aop_config, tme_crash_dump, tme_log, uefi_log, and chipinfo regions */
 		aop_tme_uefi_merged_mem: aop-tme-uefi-merged@81c80000 {
-			reg = <0 0x81c80000 0 0x74000>;
+			reg = <0 0x81c80000 0 0x75000>;
 			no-map;
 		};
 

---
base-commit: f6265e31fc717283224752dde476128191737d69
change-id: 20240228-sm8650-missing-chipinfo-region-dc65bb9a7417

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


