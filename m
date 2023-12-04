Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE5802FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjLDKKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjLDKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:10:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02516119;
        Mon,  4 Dec 2023 02:10:23 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B48c1jm010166;
        Mon, 4 Dec 2023 10:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Xz2M59ieAFor/9owuqYUdU72NKnfZG4bEZsBY5+JxAk=;
 b=BBtjchCF7JQSA4hwGUQFwzpUi5ipodPqMeTEcRJTx1zqHNh8cHOcVahtxTdpr18ZyQ6w
 GC7iLFL5TG0oZNScRnxohWCtS8JlxbVZtATX0AUBKLDSZ9Q/2Bwh8RL02Ylo1cMZXmkW
 lO70d290LFnkx1e0SRe8kOsOz7/czN4BWrvj0Wh0ATrFaIMzFia0VFf29Y4t+6vH1kkf
 fmD/1R3dlKijU5mhOie+feyrGpz2HU9fa0inNRq5nukPdvvpDENsVw98Iu2qxHShv9ii
 nYdESq9An+2H06SQDu24CowoZ02nNmdl+lP/vzBW1z6fKZRifTbJaMiLDfqiDAUcbImX Gg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqt9q3tgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 10:10:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4AAH0E028864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 10:10:17 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 02:10:11 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2 2/6] usb: dwc3: qcom: Rename hs_phy_irq to qusb2_phy_irq
Date:   Mon, 4 Dec 2023 15:39:46 +0530
Message-ID: <20231204100950.28712-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204100950.28712-1-quic_kriskura@quicinc.com>
References: <20231204100950.28712-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pEfKGH6EonrAwhNhO-7AOYxatt2mWgFB
X-Proofpoint-ORIG-GUID: pEfKGH6EonrAwhNhO-7AOYxatt2mWgFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1011 impostorscore=0 mlxlogscore=722 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040077
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
happening on th DP/DM lines. On QUSB targets, this is identified by
qusb2_phy whereas on SoCs using Femto PHY, separate {dp,dm}_hs_phy_irq's
are used instead.

The implementation incorrectly names qusb2_phy interrupts as "hs_phy_irq".
Clean this up so that driver would be using only qusb2/(dp & dm) for wakeup
purposes.

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

