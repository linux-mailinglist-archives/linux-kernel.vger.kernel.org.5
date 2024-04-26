Return-Path: <linux-kernel+bounces-159535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E64B88B2FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844611F224C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2D13AD09;
	Fri, 26 Apr 2024 05:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cqmLeZe/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03913A3FF;
	Fri, 26 Apr 2024 05:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110819; cv=none; b=Ql08D+yY+1XOTsyiaILVRX/l/+EjtzhQRGpchArirYCDVommH+otuMoN+BCBi9ojZKsvlPU3CgS+fFaBu4YTh+IsfBoPaldAb83x+SsaaOnm5PQHcNTxsOgKHc+JtdRTInzxjIe14ssmUjBnfwStlhnd3L9CnHZdeIJrNdEyIQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110819; c=relaxed/simple;
	bh=BDCShVnVSxQX/5jWdJf0HO9GQfz1xJr+HhWqGEepSeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhbTngyi160j9AcypMzr7vx+cU6K/vR+lC6kyFf+UXXM+lAWoayThfM8XCzXzX/sWWYrFpAgAAB1K3TtvPQlIpeAPZyhIcdtan5saHTFUVwfB26gftLtdIXPB01nfKuw7rUFQePE/az03jjWYMBbZmDEJYSSzB5ue0h3NZtBo8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cqmLeZe/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q4WXsd008562;
	Fri, 26 Apr 2024 05:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=zICAh0B
	zMLPRhcPWyI14tQxMFz27tRkAKMfy911XM4w=; b=cqmLeZe/UBIWzeK4ja9be+Q
	SzXps5sPHeMZw32zuZmTHAMYNWtwcWQWlgz89QZWpA50xzuh4Yzu42zKCqwG8PKp
	X7oHYteku8JpHn0Jpr93ef/fLDhcsyVsw7GHb/OiRxa5ERClhsS8WVfC+U2S3qd3
	J1wLm7TOa1TO1WjBBcd1DBt1ahSZBgZoe1HEiYxcoR/ywh5rR2dN321HlNxvyN8l
	65+DYs7p2iC2iUVfQf1O3iHXJOIo+TyQT1d8Rxkff279DzRvEudlODe4cNhgMXxw
	TZnEmZid1xLzShMSC3ILYOhghqAnEKHO4xueWQgZxhhd03Mx/xJCvKWKPOcra/A=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqengmtb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43Q5rUIQ002330;
	Fri, 26 Apr 2024 05:53:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xm6smm8sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:30 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43Q5rUOA002318;
	Fri, 26 Apr 2024 05:53:30 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 43Q5rUZT002315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:53:30 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
	id EC587214E4; Fri, 26 Apr 2024 11:23:28 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, jassisinghbrar@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        lee@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@quicinc.com,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 5/6] arm64: dts: qcom: sdx75: Add TCSR register space
Date: Fri, 26 Apr 2024 11:23:25 +0530
Message-Id: <20240426055326.3141727-6-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
References: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6XZmZZjIBjAWWEmqay9lS8U9GZytiIGX
X-Proofpoint-ORIG-GUID: 6XZmZZjIBjAWWEmqay9lS8U9GZytiIGX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_06,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=896 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260033

Add TCSR register space devicetree node for accessing different
status registers.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index aae4b9ef2bb6..f3f30bbcb37d 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -547,6 +547,11 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		tcsr: syscon@1fc0000 {
+			compatible = "qcom,sdx75-tcsr", "syscon";
+			reg = <0x0 0x01fc0000 0x0 0x30000>;
+		};
+
 		usb: usb@a6f8800 {
 			compatible = "qcom,sdx75-dwc3", "qcom,dwc3";
 			reg = <0x0 0x0a6f8800 0x0 0x400>;
-- 
2.25.1


