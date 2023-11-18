Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0137EFDF3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 06:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjKRFzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 00:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjKRFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 00:55:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A8DD72;
        Fri, 17 Nov 2023 21:55:43 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI5lcPN003736;
        Sat, 18 Nov 2023 05:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=WpenkMsII3qIgZ0PZfsby4fDSZ5GV1+Bx9nV/9DMTp4=;
 b=dYgGWVuBA1fXJ7AaKQwGK0zyYzphwGLlt/kQZECDEG8IDEefW2Pk7dmkKjLDasc17q8V
 lb6tJRPLnkQwhNBr2mBaR7sgbFbKa22ttJjI0t1kWVMSostWos0G4vbFLeedNI7HSe0U
 6F1hV8/StaDGkpInXT0tP+pMKys336vbbdBTGF8k/M0Lyxnd6WsSNNqDYAfFSBie4dM2
 L803HwIlY+JJYeLO2EyjkkBmDkSoshppD0fcgB1crIzwf4bCi29EpsxlVPIqQtzIsB/V
 D3/zivAeH869438bYD4uOsTHTyZtx461IvN1SY/d31Ceu77zXyZ1tS5khesgUs28UqkW 2g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uejymraqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 05:55:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AI5tW4m000340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 05:55:32 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 21:55:29 -0800
From:   Prashanth K <quic_prashk@quicinc.com>
To:     <stable@vger.kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Tejas Joglekar <joglekar@synopsys.com>,
        <linux-kernel@vger.kernel.org>, <linux-usbyy@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Add 'xhci-sg-trb-cache-size-quirk'
Date:   Sat, 18 Nov 2023 11:24:55 +0530
Message-ID: <20231118055455.249088-3-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231118055455.249088-1-quic_prashk@quicinc.com>
References: <20231118055455.249088-1-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f5Cn5pj67n52Czh9-uIzmGltFIE_8SbU
X-Proofpoint-ORIG-GUID: f5Cn5pj67n52Czh9-uIzmGltFIE_8SbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_04,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=509 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311180041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new 'xhci-sg-trb-cache-size-quirk' DT quirk to dwc3 core
for preventing xhci hang issue while using SG buffers.

Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index ee5af4b..768fdb5 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -459,6 +459,13 @@ properties:
     description:
       Enable USB remote wakeup.
 
+  xhci-sg-trb-cache-size-quirk:
+    description:
+      When set, fixes the SNPS xHC hang issue when the data is scattered across
+      small buffers which does not make at least MPS size for given controller
+      TRB cache size.
+    type: boolean
+
 unevaluatedProperties: false
 
 required:
-- 
2.7.4

