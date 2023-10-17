Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353597CB911
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjJQDMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjJQDLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:11:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773BF3;
        Mon, 16 Oct 2023 20:11:39 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H2b1Cb025606;
        Tue, 17 Oct 2023 03:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=fx4xtxVwN4Z566gKPg89gZrubiQWVMpE6BfSA+5s/9s=;
 b=HOaSAlRZe8eP6HU2iPiqFHMczEuzAVNB6DCU6ht0LBdI9Ib6vzOZl2uG+EnXOnA8iI65
 zuLjOPTawVhYJGqtUHrQY1yq1WNJ6P37aFfpGZDDRIPJjlScqp4oMm07TNx+h8BDy8RW
 oqlssxoNzdqhS/cbO5RypwZYls1PrelN0OJebcIPEFLRyCrvMgBtP9CGZnEqKzEKzBnK
 Zzpg7XMy+yhs+GJC/QJuRt/5F0AUeUTkOf2JLCZ25eBfoxeWSdU2r7Qlpzfd/3j4OmDw
 2/uNF7AwmnW4cZ79IdZO28YkGAZ/G4xubrQxhb2Rv2ThAW+TAnuj6u160juZIqn+x/6W DA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsd1rrgxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H3BSJO015405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:11:28 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 16 Oct 2023 20:11:28 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
Date:   Mon, 16 Oct 2023 20:11:16 -0700
Subject: [PATCH 08/12] usb: dwc3: qcom: Inline the qscratch constants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231016-dwc3-refactor-v1-8-ab4a84165470@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697512286; l=2163;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=L1kK2fUf5Rn/vZXCX0NeCyiaCBnCEmlx2o6BBxpn6QI=;
 b=LJCbOys0u/1w3P3LDWUmh9vZ3hXEUgk0qg2UMMoSU4/STuPvM49qTJ30qQCvYyF4F3BCxlOPg6b9
 8yu3GgbuAxo59z8EIxVqs9BbjVmSc1j13S0lqr+PZ+KIkM03Z1RY
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fuOoExNnlDcZJVeekv8muwSO2EwtFi4B
X-Proofpoint-ORIG-GUID: fuOoExNnlDcZJVeekv8muwSO2EwtFi4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two constants for the offset and size of the qscratch block within
the DWC3 region has the same value in all supported variants, so they
don't necessarily need to be picked dynamically.

By replacing the lookup with the constants it's possible to reuse the
same code path without the ACPI pdata structure in the upcoming commit.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index cc0fe010ee8c..cf6c391ba498 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -54,8 +54,6 @@
 #define APPS_USB_PEAK_BW MBps_to_icc(40)
 
 struct dwc3_acpi_pdata {
-	u32			qscratch_base_offset;
-	u32			qscratch_base_size;
 	int			hs_phy_irq_index;
 	int			dp_hs_phy_irq_index;
 	int			dm_hs_phy_irq_index;
@@ -859,10 +857,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		memcpy(&local_res, res, sizeof(struct resource));
 		parent_res = &local_res;
 
-		parent_res->start = res->start +
-			qcom->acpi_pdata->qscratch_base_offset;
-		parent_res->end = parent_res->start +
-			qcom->acpi_pdata->qscratch_base_size;
+		parent_res->start = res->start + SDM845_QSCRATCH_BASE_OFFSET;
+		parent_res->end = parent_res->start + SDM845_QSCRATCH_SIZE;
 	}
 
 	qcom->qscratch_base = devm_ioremap_resource(dev, parent_res);
@@ -1073,8 +1069,6 @@ MODULE_DEVICE_TABLE(of, dwc3_qcom_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
-	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
-	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
 	.hs_phy_irq_index = 1,
 	.dp_hs_phy_irq_index = 4,
 	.dm_hs_phy_irq_index = 3,
@@ -1082,8 +1076,6 @@ static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
 };
 
 static const struct dwc3_acpi_pdata sdm845_acpi_urs_pdata = {
-	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
-	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
 	.hs_phy_irq_index = 1,
 	.dp_hs_phy_irq_index = 4,
 	.dm_hs_phy_irq_index = 3,

-- 
2.25.1

