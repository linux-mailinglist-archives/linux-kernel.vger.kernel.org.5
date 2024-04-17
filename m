Return-Path: <linux-kernel+bounces-148463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9638A82EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CB81F21C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90614036D;
	Wed, 17 Apr 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jw71Kly7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8D13FD62;
	Wed, 17 Apr 2024 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355810; cv=none; b=iLes8T4Wwr0NUGNkvCjems6RW9/i87i+bzPKU9AkIBmrnNvi8PobK9h17XGY0bJQ2wRxOdfCbnXSazZOY3tKXK0g2NZK5ZuxzSucBc/D5+2S7hLcjnRkkf/vq9hmZF0kf/nkggIIeLI6lgnmocmGE44pnBvEkklCEiRcHJpDJEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355810; c=relaxed/simple;
	bh=1MRuraV/qbFti5UbSkMAzkOSdncZ50DtaMw0L7n7hE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1r+l0+pCIewXXT4uo1ASbrAweh/5ECYly+8WsVYsToyWmQogDlvc9XyEt597HeNgG8LYu49FKhhm1pdh9jEoMEvCUvaxJZaW50QCpCCdejcFDeCvlO3WXa8kwGWpBGw3SlNC0wotjBBJgTRqzQ2PM5NUXyWH9Yn6i/l6ho0l0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jw71Kly7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H9TtR6008057;
	Wed, 17 Apr 2024 12:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=5OczRbPH3Gs+CpeaDL1NMqMqjT/P4/cYJYY2OaU4/2M=; b=jw
	71Kly7MuslCNXSno2mrBRABeDFgnMdZqztMnxN7lkmVgqeW9ad96Ly944rWpYbDc
	98SzY5UVOkRRjm1fkPHMalK9lf+7YmAjxblJW/wr7YRenjUjPhU1Ft+tJRPIfNeA
	m4iDPDj4BIUJsZ/wBS0M8Rq2byIwuu/y/RdoCQMD+jaT1JXAY81IJWCtpSnIWpvW
	bhs6SoxPC/d5ZneamyZewFMo03Zs/DYjaMAg1wbSkE+Mb/LUSXotjEyhIpdirZwG
	uq5eh+x+c6mGq6f7tIPIx+b1KdvmMkkk/25bgzNPv5MRqc42kOqg+W5Ydzl4hTev
	fPIsN1Ctoet7JYGsGnFQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjbt5rbjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:10:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HCA1Ks014664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:10:01 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 05:09:57 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>,
        <quic_tsoni@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v3 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs
Date: Wed, 17 Apr 2024 17:39:28 +0530
Message-ID: <20240417120928.32344-3-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240417120928.32344-1-quic_kbajaj@quicinc.com>
References: <20240417120928.32344-1-quic_kbajaj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2yosNOMY1A2LKepyC_WBtsdKWoLzDzg-
X-Proofpoint-GUID: 2yosNOMY1A2LKepyC_WBtsdKWoLzDzg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_09,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=706 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170084

Enable the ADSP, CDSP and WPSS that are found on qcs6490-rb3gen2.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index c98c41f8f3b1..a085ff5b5fb2 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -17,7 +17,6 @@
 #include "pmk8350.dtsi"

 /delete-node/ &ipa_fw_mem;
-/delete-node/ &remoteproc_mpss;
 /delete-node/ &rmtfs_mem;
 /delete-node/ &adsp_mem;
 /delete-node/ &cdsp_mem;
@@ -617,6 +616,16 @@ &remoteproc_cdsp {
 	status = "okay";
 };

+&remoteproc_mpss {
+	firmware-name = "qcom/qcs6490/modem.mdt";
+	status = "okay";
+};
+
+&remoteproc_wpss {
+	firmware-name = "qcom/qcs6490/wpss.mbn";
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <32 2>, /* ADSP */
 			       <48 4>; /* NFC */
--
2.42.0


