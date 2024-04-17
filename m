Return-Path: <linux-kernel+bounces-148580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B348A84B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC583B28BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E504142636;
	Wed, 17 Apr 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JjAjVgY5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B74140E30;
	Wed, 17 Apr 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360590; cv=none; b=LNQjn6RrSDBXPXWAOqctLSqtEo4ow1HRaIT6Gg1mNQ5k1TZEWqa7o08yEBvaBHSd+co8922Dk5JvYKuK8YkvjuxXi56zSbRqByYJrSnoqZ1XGuMJAl+hbVMGb1hddci+LpaXw2rFiEkoM0FUY7Fpge7lOLF7DdSIAMOrFlFvF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360590; c=relaxed/simple;
	bh=AC+N+z8QOY8wGk1pkwPNR1R/KVpTDm+PmlCVbyxl/gs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPlzCnTGfQTV/mr8U/ko6upjFKqsMHewZyPF/KOhzyKtjfxXxc4YCtfbVyWgK81wSCxfM1v9lBBEGdVjYL5GRFZuYjygvoQuJbF2Cggs7jzrPKGXqIlO4KMlZHl6Efi8b9q3JNRZsbWAH5e4Pd4RRi0/5sIw2vmiInYJz7GNzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JjAjVgY5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HAAVtV020383;
	Wed, 17 Apr 2024 13:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=KQNM54+Tex53wMVRhe3D3uJkQGMTc61dxcaRKIPc2q4=; b=Jj
	AjVgY50ISILeNf9qNmDG/uW7p6gMVi+hgNNp0tbNIGZEXP6tFETQHTQZFU+oElxa
	YgoM9hj+/VBraATLjMdCwlsaAMPOezzshrxN7qRTEO0uAij67nOLJyUqDrtzOG3y
	hgZFckxDeSOWf40NLiK8VsNOW+2Ot+qE2X5IWO7kvujwLNCZewu3W+U1+JWd9aFN
	1w8NJgIg+GagNgndl5rdZPgDJUBv7WhnxgFTV2izu1Dg5Ee2PmEH9LUdLL6v57Bd
	TPHQROWhtA4CNay0I787UvcOOonEOdzxSskxnhULo0XmB2QVFfaz72NRe3PK7A6j
	xLD+e9ZZVM3mItirLg7A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjceh0etf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:29:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HDTdZU007464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 13:29:39 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 06:29:34 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>
Subject: [PATCH V3 3/5] arm64: dts: qcom: x1e80100: Resize GIC Redistributor register region
Date: Wed, 17 Apr 2024 18:58:54 +0530
Message-ID: <20240417132856.1106250-4-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417132856.1106250-1-quic_sibis@quicinc.com>
References: <20240417132856.1106250-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xzwm1NL8Xck3vap7rrhnP0HnrXLHMVRV
X-Proofpoint-ORIG-GUID: Xzwm1NL8Xck3vap7rrhnP0HnrXLHMVRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=753 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170092

Resize the GICR register region as it currently seeps into the CPU Control
Processor mailbox RX region.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Pickup Rb from Dimitry.

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index f5a3b39ae70e..28f65296781d 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4949,7 +4949,7 @@ apps_smmu: iommu@15000000 {
 		intc: interrupt-controller@17000000 {
 			compatible = "arm,gic-v3";
 			reg = <0 0x17000000 0 0x10000>,     /* GICD */
-			      <0 0x17080000 0 0x480000>;    /* GICR * 12 */
+			      <0 0x17080000 0 0x380000>;    /* GICR * 12 */
 
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.34.1


