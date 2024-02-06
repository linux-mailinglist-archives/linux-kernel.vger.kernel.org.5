Return-Path: <linux-kernel+bounces-54347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F323784ADFD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0B028564E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA0811E1;
	Tue,  6 Feb 2024 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dNBRdqIA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FD7F475;
	Tue,  6 Feb 2024 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196764; cv=none; b=mvMFzLl4V1UQhSRzqo9+xrQtBgiQ2Ql7/hVP99k1OlyJXRxw7BIART+5Fz4/E/yiUikTotGH70+bqHFD6KhhcbHNsVCe6cKdB1s4PolgP+k7xlvXzgkPVcfpesbXUprRS8JGIaxL5YC5VmFdjmqMeztUJddGKSwMCJU8ub9VmeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196764; c=relaxed/simple;
	bh=YipJsSDe/lPGfRmR73HRVJV2NGG9AgcvooI1nopAKCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3+NN7ft+0SpOEoK5l5PxTNhL/D/6Lemx/qQYkui6chXXBktcu0IQRs3Qd0DYxOBF3WL53QLB/HAlXW1VnAn+YiRJWHEUwNcZ/jPypLX1Eg4+SI5WxqMITm0itCNVm/Nsd7TK3lVcEbRj6wm31uqSUQA/E2meojoGryRFHoftUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dNBRdqIA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4165FVhl015623;
	Tue, 6 Feb 2024 05:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=kDGLTcTOyVRHuM55Kj8rxWIFHVxis9XSTF6jj3lAuBI=; b=dN
	BRdqIA8VspUQQ+NnQe+v3KbRCydlcT8JcrxLmrCL9nqWFK1BcBrd75FY0flW2VyI
	3mUi4b+XA7smSN3KKrQEc5yrQi7oKlH3Ek9E9M1nPFn2oSifhSubnYGVwqano2R7
	mM8I/z2Z6lyA1CtJXoWLTMS7sOWXjz277UjflkxpFU3JLyOuTZ6BLpcW+h2uXNE3
	JfH1Hc41sii03bJfOwOxYT7olA1s0DdCero/9upy3GLyApEA2v8guENtEl00NcLz
	BbGcYaZfzW0jOv4Yp6v7yJXRt5dIsxoQSbp1NhRSsrdet6/UqwpGBR4QBSOm0bY5
	iklNatUofqrOAiyFWUdw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3apjgdga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 05:19:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4165JGlM003391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 05:19:16 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 21:19:11 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
Subject: [PATCH v14 6/9] usb: dwc3: qcom: Add helper function to request wakeup interrupts
Date: Tue, 6 Feb 2024 10:48:22 +0530
Message-ID: <20240206051825.1038685-7-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gSzeu4cZQbaww04B3IwS3UuEOAFIggeC
X-Proofpoint-GUID: gSzeu4cZQbaww04B3IwS3UuEOAFIggeC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=517 mlxscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060035

The logic for requesting interrupts is duplicated for each interrupt. In
the upcoming patches that introduces support for multiport, it would be
better to clean up the duplication before reading mulitport related
interrupts.

Refactor interrupt setup call by adding a new helper function for
requesting the wakeup interrupts. To simplify implementation, make
the display name same as the interrupt name expected in DT.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 53 ++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index dbd6a5b2b289..08df29584366 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -535,6 +535,22 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
 	return ret;
 }
 
+static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
+				 const char *name)
+{
+	int ret;
+
+	/* Keep wakeup interrupts disabled until suspend */
+	ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
+					qcom_dwc3_resume_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					name, qcom);
+	if (ret)
+		dev_err(qcom->dev, "failed to request irq %s: %d\n", name, ret);
+
+	return ret;
+}
+
 static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
@@ -545,57 +561,36 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 	irq = dwc3_qcom_get_irq(pdev, "qusb2_phy",
 				pdata ? pdata->qusb2_phy_irq_index : -1);
 	if (irq > 0) {
-		/* Keep wakeup interrupts disabled until suspend */
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 QUSB2", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "qusb2_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_request_irq(qcom, irq, "hs_phy_irq");
+		if (ret)
 			return ret;
-		}
 		qcom->qusb2_phy_irq = irq;
 	}
 
 	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
 				pdata ? pdata->dp_hs_phy_irq_index : -1);
 	if (irq > 0) {
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 DP_HS", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_request_irq(qcom, irq, "dp_hs_phy_irq");
+		if (ret)
 			return ret;
-		}
 		qcom->dp_hs_phy_irq = irq;
 	}
 
 	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
 				pdata ? pdata->dm_hs_phy_irq_index : -1);
 	if (irq > 0) {
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 DM_HS", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_request_irq(qcom, irq, "dm_hs_phy_irq");
+		if (ret)
 			return ret;
-		}
 		qcom->dm_hs_phy_irq = irq;
 	}
 
 	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
 				pdata ? pdata->ss_phy_irq_index : -1);
 	if (irq > 0) {
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 SS", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_request_irq(qcom, irq, "ss_phy_irq");
+		if (ret)
 			return ret;
-		}
 		qcom->ss_phy_irq = irq;
 	}
 
-- 
2.34.1


