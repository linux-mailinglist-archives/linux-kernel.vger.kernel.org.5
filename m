Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57E37CB8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjJQDMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjJQDLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:11:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C187F0;
        Mon, 16 Oct 2023 20:11:38 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H2ocp4005020;
        Tue, 17 Oct 2023 03:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=fyPGAmgz8ro8JypxxMa1lsplEbutTRleN+Fq64X2rA4=;
 b=OpTCSNHHIugRAOVJ/8b/A15yhc3LfQlkMwE1RWbDHdoPHOY8Tbc7gFrqWWSB5odV97kd
 jfKnFYLujr9/gJtMOSeBvZo7wsG3/5PPG03uK0p5qQzxR9BGfmj5CbX3gg7g3wUj3EyS
 SnC17IT7BdTmLSv/b4mGCPvKNjZKVXLAsGgII0dN4eDda77aFrkGse1XCQMtJUx2K3Ev
 OwAaSxnphghim6CrvbKgnk8VMbyjsAFk+iTQJhXMAY9yuzEpmpoR6CyiTspBtNkOadbo
 1A819e1TEvaXOwtEKre5dppQpVbYiooY5ljB9dtDAEaGnXDc14ccMl6jivwnziAPywPd fQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsaky0w80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3BRNd024762
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:27 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 16 Oct 2023 20:11:26 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Mon, 16 Oct 2023 20:11:10 -0700
Subject: [PATCH 02/12] usb: dwc3: qcom: Rename dwc3 platform_device
 reference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231016-dwc3-refactor-v1-2-ab4a84165470@quicinc.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
In-Reply-To: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697512286; l=5698;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=jpItE/oiQ5lzRTBEnM+OfbFHs1It/qN8d+P7OUiUKwI=;
 b=8OnhwtupUJaaqKFxdmaggnHcmeyt8BMe7aZH18q8xLQ18ZHVmacAzbJbnVFKj+m2l4pyf9G4ye5+
 BrNw1yewD4cna9jnz1/PvgOTzJhfNLHWsAqPu2JygSPtXag3wqTh
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R5dezczVtotQCwAsTLh8DJl0b41bFinl
X-Proofpoint-ORIG-GUID: R5dezczVtotQCwAsTLh8DJl0b41bFinl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=870 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the introduction of a direct reference to the struct
dwc3 in the dwc3_qcom struct, rename the generically named "dwc3" to
reduce the risk for confusion.

No functional change.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3de43df6bbe8..a31c3bc1f56e 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -67,7 +67,7 @@ struct dwc3_acpi_pdata {
 struct dwc3_qcom {
 	struct device		*dev;
 	void __iomem		*qscratch_base;
-	struct platform_device	*dwc3;
+	struct platform_device	*dwc_dev;
 	struct platform_device	*urs_usb;
 	struct clk		**clks;
 	int			num_clocks;
@@ -264,7 +264,7 @@ static int dwc3_qcom_interconnect_init(struct dwc3_qcom *qcom)
 		goto put_path_ddr;
 	}
 
-	max_speed = usb_get_maximum_speed(&qcom->dwc3->dev);
+	max_speed = usb_get_maximum_speed(&qcom->dwc_dev->dev);
 	if (max_speed >= USB_SPEED_SUPER || max_speed == USB_SPEED_UNKNOWN) {
 		ret = icc_set_bw(qcom->icc_path_ddr,
 				USB_MEMORY_AVG_SS_BW, USB_MEMORY_PEAK_SS_BW);
@@ -312,7 +312,7 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 	/*
 	 * FIXME: Fix this layering violation.
 	 */
-	dwc = platform_get_drvdata(qcom->dwc3);
+	dwc = platform_get_drvdata(qcom->dwc_dev);
 
 	/* Core driver may not have probed yet. */
 	if (!dwc)
@@ -323,7 +323,7 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 
 static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
 {
-	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
+	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc_dev);
 	struct usb_device *udev;
 	struct usb_hcd __maybe_unused *hcd;
 
@@ -486,7 +486,7 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 static irqreturn_t qcom_dwc3_resume_irq(int irq, void *data)
 {
 	struct dwc3_qcom *qcom = data;
-	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
+	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc_dev);
 
 	/* If pm_suspended then let pm_resume take care of resuming h/w */
 	if (qcom->pm_suspended)
@@ -672,19 +672,19 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 	int			irq;
 	int			ret;
 
-	qcom->dwc3 = platform_device_alloc("dwc3", PLATFORM_DEVID_AUTO);
-	if (!qcom->dwc3)
+	qcom->dwc_dev = platform_device_alloc("dwc3", PLATFORM_DEVID_AUTO);
+	if (!qcom->dwc_dev)
 		return -ENOMEM;
 
-	qcom->dwc3->dev.parent = dev;
-	qcom->dwc3->dev.type = dev->type;
-	qcom->dwc3->dev.dma_mask = dev->dma_mask;
-	qcom->dwc3->dev.dma_parms = dev->dma_parms;
-	qcom->dwc3->dev.coherent_dma_mask = dev->coherent_dma_mask;
+	qcom->dwc_dev->dev.parent = dev;
+	qcom->dwc_dev->dev.type = dev->type;
+	qcom->dwc_dev->dev.dma_mask = dev->dma_mask;
+	qcom->dwc_dev->dev.dma_parms = dev->dma_parms;
+	qcom->dwc_dev->dev.coherent_dma_mask = dev->coherent_dma_mask;
 
 	child_res = kcalloc(2, sizeof(*child_res), GFP_KERNEL);
 	if (!child_res) {
-		platform_device_put(qcom->dwc3);
+		platform_device_put(qcom->dwc_dev);
 		return -ENOMEM;
 	}
 
@@ -708,29 +708,29 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
 	child_res[1].flags = IORESOURCE_IRQ;
 	child_res[1].start = child_res[1].end = irq;
 
-	ret = platform_device_add_resources(qcom->dwc3, child_res, 2);
+	ret = platform_device_add_resources(qcom->dwc_dev, child_res, 2);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
 		goto out;
 	}
 
-	ret = device_add_software_node(&qcom->dwc3->dev, &dwc3_qcom_swnode);
+	ret = device_add_software_node(&qcom->dwc_dev->dev, &dwc3_qcom_swnode);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add properties\n");
 		goto out;
 	}
 
-	ret = platform_device_add(qcom->dwc3);
+	ret = platform_device_add(qcom->dwc_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add device\n");
-		device_remove_software_node(&qcom->dwc3->dev);
+		device_remove_software_node(&qcom->dwc_dev->dev);
 		goto out;
 	}
 	kfree(child_res);
 	return 0;
 
 out:
-	platform_device_put(qcom->dwc3);
+	platform_device_put(qcom->dwc_dev);
 	kfree(child_res);
 	return ret;
 }
@@ -754,8 +754,8 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 		goto node_put;
 	}
 
-	qcom->dwc3 = of_find_device_by_node(dwc3_np);
-	if (!qcom->dwc3) {
+	qcom->dwc_dev = of_find_device_by_node(dwc3_np);
+	if (!qcom->dwc_dev) {
 		ret = -ENODEV;
 		dev_err(dev, "failed to get dwc3 platform device\n");
 	}
@@ -906,7 +906,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (ret)
 		goto depopulate;
 
-	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
+	qcom->mode = usb_get_dr_mode(&qcom->dwc_dev->dev);
 
 	/* enable vbus override for device mode */
 	if (qcom->mode != USB_DR_MODE_HOST)
@@ -919,7 +919,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
 	device_init_wakeup(&pdev->dev, wakeup_source);
-	device_init_wakeup(&qcom->dwc3->dev, wakeup_source);
+	device_init_wakeup(&qcom->dwc_dev->dev, wakeup_source);
 
 	qcom->is_suspended = false;
 	pm_runtime_set_active(dev);
@@ -953,7 +953,7 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i;
 
-	device_remove_software_node(&qcom->dwc3->dev);
+	device_remove_software_node(&qcom->dwc_dev->dev);
 	if (np)
 		of_platform_depopulate(&pdev->dev);
 	else

-- 
2.25.1

