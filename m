Return-Path: <linux-kernel+bounces-146671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C660E8A6908
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD771F21D80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38AC12839E;
	Tue, 16 Apr 2024 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X9j2ipqP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DEA1E87F;
	Tue, 16 Apr 2024 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264690; cv=none; b=C0X6kk4cI3V725U970kPDycHRqEAAKDfl6kXFkGu/G//z2Kg13McWzRCFlvXBTkTpn7+jtqaWWResz1lZfBrnuwGHwk9mzlarxcrQQUypCNXvNTQ9IoQoVPQCgatwbDzjmcGtOlOjy5109TxJQmC1Aj2UjHyJuv5KX1ylSOSnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264690; c=relaxed/simple;
	bh=Eg2d6DSO7vljcimSjm9nh5yaJmrhsxpma7PRC2x1+Uk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=de82p2OUzfnKoZL46LQLzPJILIby2FZdsjAbO87sBXsbr+xX0rg9skNUW/VgG0eawb5TkN10akrcXNIeo+Gs+f4jTPmkdHyc0yPFlaJbB3IYUyz7Jr6PGSxaZQ6zHBvQDJUlgNlC8U2Zu0iv07vT4HvhgPpMnPiE4mcTPXuLwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X9j2ipqP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43G4ua7f014191;
	Tue, 16 Apr 2024 10:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=W38VflJdgyZa
	byOkm+lr02s/pUISBOkObcSb0K+i7bQ=; b=X9j2ipqPlt+WPrW8AdhWiCgCqYcb
	P/DVqEPFCLiwV/TLtSEcCRg26hSh8EEzhXs7k1GLLwfIZ3hljU5ByIwHggcVFjIR
	XVac8UxZOJqgRhzgJvAT6HDWB18qCJBUUl+bZIIi6RwyGgwWgMoTr6vJk2EOqh29
	zdBzAkBw5lNVJ9ONCiKFEK5OfZ+k1dwpMmylhWc0hM0jASbGTkRJ63ekj3E29wu7
	mBGY1ssIN9Oi+lYVMArIb7pErobrDUJe7t4gtSzfcE9Jk8NGfu0gMGgwxDBfG9xV
	uk3QUYLIPef9RMGRrzccV2tLgis0zjKywFiqKGWKiPMrPy1r9NtbzFAGbw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh5jxausv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 10:51:24 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43GApK32010446;
	Tue, 16 Apr 2024 10:51:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3xfk4kqq7g-1;
	Tue, 16 Apr 2024 10:51:20 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43GApKZE010441;
	Tue, 16 Apr 2024 10:51:20 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 43GAp4CQ010374;
	Tue, 16 Apr 2024 10:51:20 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id 0CC93500C6C; Tue, 16 Apr 2024 16:21:02 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v1] arm64: dts: qcom: qcm6490-rb3: Enable gpi-dma and qup node
Date: Tue, 16 Apr 2024 16:20:59 +0530
Message-Id: <20240416105059.1167-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a4IMRRPdpsUnI5-S7oRZatyBk4xq9Lbi
X-Proofpoint-ORIG-GUID: a4IMRRPdpsUnI5-S7oRZatyBk4xq9Lbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_08,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=756 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160066
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Enable gpi-dma0, gpi-dma1 and qupv3_id_1 nodes for
busses usecase on RB3 platform.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index c98c41f8f3b1..811033592bab 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -603,10 +603,22 @@
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
 &qupv3_id_0 {
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


