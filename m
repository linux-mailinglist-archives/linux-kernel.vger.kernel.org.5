Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3483E80C91C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjLKMLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjLKMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:11:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A7CF;
        Mon, 11 Dec 2023 04:11:58 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBBuWVl023588;
        Mon, 11 Dec 2023 12:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=BMcIK6+tF1WzlJAS4gMMrCiHhLdtiy0eQaT/jyXeihI=; b=O2
        Dgnx5NFv6UxXMoOKACJutyLqG3l4k17gpP0pqxmpPx4viUOkD5phYnIY9W5mIfAg
        1QIfRR3KLhOOeL5g6DvPVYMzbb+RCy2oaH/pBaQmEU84Pa4UF9Zr7u9FbWUxl7ye
        ezxScdyw6IGmziURwHEaeclGGpvqA7ip/jxBdDEH5VyFRpyAOSBjN5rWKBBvmNy4
        0NOPmarXBz3Qw+sf+jhrd7J8UXf4ujk1mRmgwG3o3uuyenjFbs0domLCjuN0kyRE
        Ydl/KO1oEf1YX7IkqIt7G8Gela5Oh2kwkywxhE/+VS1cjIO20VevbbqMqiuuQH7i
        Tb6Gzrl8/VTxCg4Ra/Eg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uwjyjshes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 12:11:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBCBqpV005898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 12:11:52 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 04:11:47 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v3 2/2] usb: dwc3: qcom: Rename hs_phy_irq to qusb2_phy_irq
Date:   Mon, 11 Dec 2023 17:41:24 +0530
Message-ID: <20231211121124.4194-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211121124.4194-1-quic_kriskura@quicinc.com>
References: <20231211121124.4194-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0U5SbUCJBZ6u8knha8K-oE2_sjwNtww8
X-Proofpoint-ORIG-GUID: 0U5SbUCJBZ6u8knha8K-oE2_sjwNtww8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=722 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312110098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For wakeup to work, driver needs to enable interrupts that depict what is
happening on the DP/DM lines. On QUSB targets, this is identified by
qusb2_phy whereas on SoCs using Femto PHY, separate {dp,dm}_hs_phy_irq's
are used instead.

The implementation incorrectly names qusb2_phy interrupts as "hs_phy_irq".
Clean this up so that driver would be using only qusb2/(dp & dm) for wakeup
purposes.

For devices running older kernels, this won't break any functionality
because the interrupt configurations in QUSB2 PHY based SoCs is done
by configuring QUSB2PHY_INTR_CTRL register in PHY address space and it was
never armed properly right from the start.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index fdf6d5d3c2ad..dbd6a5b2b289 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -57,7 +57,7 @@ struct dwc3_acpi_pdata {
 	u32			qscratch_base_offset;
 	u32			qscratch_base_size;
 	u32			dwc3_core_base_size;
-	int			hs_phy_irq_index;
+	int			qusb2_phy_irq_index;
 	int			dp_hs_phy_irq_index;
 	int			dm_hs_phy_irq_index;
 	int			ss_phy_irq_index;
@@ -73,7 +73,7 @@ struct dwc3_qcom {
 	int			num_clocks;
 	struct reset_control	*resets;
 
-	int			hs_phy_irq;
+	int			qusb2_phy_irq;
 	int			dp_hs_phy_irq;
 	int			dm_hs_phy_irq;
 	int			ss_phy_irq;
@@ -372,7 +372,7 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
 
 static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(qcom->qusb2_phy_irq);
 
 	if (qcom->usb2_speed == USB_SPEED_LOW) {
 		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
@@ -389,7 +389,7 @@ static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq, 0);
+	dwc3_qcom_enable_wakeup_irq(qcom->qusb2_phy_irq, 0);
 
 	/*
 	 * Configure DP/DM line interrupts based on the USB2 device attached to
@@ -542,19 +542,19 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	irq = dwc3_qcom_get_irq(pdev, "hs_phy_irq",
-				pdata ? pdata->hs_phy_irq_index : -1);
+	irq = dwc3_qcom_get_irq(pdev, "qusb2_phy",
+				pdata ? pdata->qusb2_phy_irq_index : -1);
 	if (irq > 0) {
 		/* Keep wakeup interrupts disabled until suspend */
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
 					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 HS", qcom);
+					"qcom_dwc3 QUSB2", qcom);
 		if (ret) {
-			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
+			dev_err(qcom->dev, "qusb2_phy_irq failed: %d\n", ret);
 			return ret;
 		}
-		qcom->hs_phy_irq = irq;
+		qcom->qusb2_phy_irq = irq;
 	}
 
 	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
@@ -1058,7 +1058,7 @@ static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
 	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
 	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
 	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
-	.hs_phy_irq_index = 1,
+	.qusb2_phy_irq_index = 1,
 	.dp_hs_phy_irq_index = 4,
 	.dm_hs_phy_irq_index = 3,
 	.ss_phy_irq_index = 2
@@ -1068,7 +1068,7 @@ static const struct dwc3_acpi_pdata sdm845_acpi_urs_pdata = {
 	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
 	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
 	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
-	.hs_phy_irq_index = 1,
+	.qusb2_phy_irq_index = 1,
 	.dp_hs_phy_irq_index = 4,
 	.dm_hs_phy_irq_index = 3,
 	.ss_phy_irq_index = 2,
-- 
2.42.0

