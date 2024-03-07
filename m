Return-Path: <linux-kernel+bounces-95007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F396A87480E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9523282624
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638392134A;
	Thu,  7 Mar 2024 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JePztyu5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393C1CD3B;
	Thu,  7 Mar 2024 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792519; cv=none; b=uJUq1o0flKVPEiesW0AV8J7W5nkIoK5Qor8Rvj5GOYttxh8P39zQIYAm8GAqSGgwxoh5gfStMTBZmBsTvbR4kzepXwvk418rbADXVw/N8KvAdn5JkvLJnHsad0QNR3xVCaKctMw3CXzsimTFj8I22d01antTaynEY3yd9qtkbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792519; c=relaxed/simple;
	bh=/w9DKn0l7UHdt03dLn34YxErTvdkBzxNd+9JA4VwzqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+6eH4xqRbjZ/rrcbxUt5ZhAqDusHco5W0u/WEJZNxAOBtOx+nPqRxxKwE1nnM8dT8l2UJheSLSwykMLF+/Q9aslsoUafEx9ap8xjoWah4/NNL7ati6swpH8gbj2+J2lK7zK9yo8s5Alsi+Tt7AQkf2hN1x/hKKBpeevdxqxua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JePztyu5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4274oc8n031896;
	Thu, 7 Mar 2024 06:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Vv3lTFOdTzMq28SvQCH8AwKvTEwb2YNR73HGrg70dio=; b=Je
	Pztyu54OC57IQIJtX563MQzcuGYKko0bfc1VoSyMIBBUoJvoj2tChNGywCfsPVWk
	95JQyQAIEVzdqVyCfNK8tGBjtHvM+Eiy9Xv9HMfwzFaV6ugxUj6CYg6QZtcncuOr
	MbcA16ghTXTVEKAE7SOnI99A2o/KAQ/BtKU9ZwEWsduOz5TYPT9/GRU/Ci2cspFH
	t0V3DJc84d0RWZU7W1sRcFeJLyCIKhLsnPrpuiEpN0qgWhZz209z51vCSFQkeAwA
	2JN58pk6gSiXZIdPxcQLsF9jHTun6UI5MDt5re37W1KgsgziT6hJpiWAIcTz6Wak
	ULMcnhJKFBf1hhvkZ+gw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq2mfrkjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 06:21:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4276Lp7A031217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 06:21:51 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 22:21:46 -0800
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
	<balbi@kernel.org>, Johan Hovold <johan@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
Subject: [PATCH v16 6/9] usb: dwc3: qcom: Add helper function to request wakeup interrupts
Date: Thu, 7 Mar 2024 11:50:49 +0530
Message-ID: <20240307062052.2319851-7-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: cMNwkghAfTTJ3RwDkRAKAZ19hXtJczYB
X-Proofpoint-ORIG-GUID: cMNwkghAfTTJ3RwDkRAKAZ19hXtJczYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 malwarescore=0 mlxlogscore=777 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070044

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
index f6b2fab49d5e..cae5dab8fcfc 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -501,6 +501,22 @@ static void dwc3_qcom_select_utmi_clk(struct dwc3_qcom *qcom)
 			  PIPE_UTMI_CLK_DIS);
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
@@ -509,54 +525,33 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
 	if (irq > 0) {
-		/* Keep wakeup interrupts disabled until suspend */
-		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
-					qcom_dwc3_resume_irq,
-					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 QUSB2", qcom);
-		if (ret) {
-			dev_err(qcom->dev, "qusb2_phy_irq failed: %d\n", ret);
+		ret = dwc3_qcom_request_irq(qcom, irq, "qusb2_phy");
+		if (ret)
 			return ret;
-		}
 		qcom->qusb2_phy_irq = irq;
 	}
 
 	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
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
 
 	irq = platform_get_irq_byname_optional(pdev, "dm_hs_phy_irq");
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
 
 	irq = platform_get_irq_byname_optional(pdev, "ss_phy_irq");
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


