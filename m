Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF7E77C00C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjHNSv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjHNSu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:50:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B123C10E3;
        Mon, 14 Aug 2023 11:50:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EIklhB028805;
        Mon, 14 Aug 2023 18:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=aIysoS/8R7Z5ctCrhf6Xs/DRiVF93Lb2vxn41WhEfZw=;
 b=fGTeH8YgUcaXtWTzIaytgJpK/jAsj6mnLf3rYDBtMzf4vKs3KgJcyKAec2eavbAxuLg4
 SrTtKe+5JwDBFOD+vpAwS9fufNUD2BUJHmWqXCzE5eM9GymeTrlFRy2iD3fWJYyqcqd+
 9lq254yCrdcLZ7Nm6cY7b+4Q9U/V/6zMIJqZ/zckxu3cRa4XVy4/0+aPcSNGNFpzuSU5
 YXyg2gIpJ6ZiFMFMTL25RZDSzmy0EzCQtAY5vTUaWClD5cYaBp75sxYy91jlZDBqbO28
 9l2jpBb6LRBe6F0b4NRJSEUn64B8erB3M2efzC0ryuH52eKJmimQDSmRlf01z2cb3C55 0A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3j94mvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:50:50 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37EIondQ016196;
        Mon, 14 Aug 2023 18:50:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 3se35kvwe8-1;
        Mon, 14 Aug 2023 18:50:49 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EIomIu016184;
        Mon, 14 Aug 2023 18:50:48 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.27])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 37EIomuS016182;
        Mon, 14 Aug 2023 18:50:48 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 464172)
        id B7C7C5005B1; Mon, 14 Aug 2023 11:50:48 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        rogerq@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add runtime-suspend-on-usb-suspend property
Date:   Mon, 14 Aug 2023 11:50:42 -0700
Message-Id: <20230814185043.9252-3-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814185043.9252-1-quic_eserrao@quicinc.com>
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ObAlKbWgcICJ-RcnvbLEGPj-MT-CBy6z
X-Proofpoint-GUID: ObAlKbWgcICJ-RcnvbLEGPj-MT-CBy6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=4 spamscore=4 malwarescore=0
 priorityscore=1501 mlxscore=4 adultscore=0 mlxlogscore=135 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140174
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property allows dwc3 runtime suspend when bus suspend interrupt
is received even with cable connected. This would allow the dwc3
controller to enter low power mode during bus suspend scenario.

This property would particularly benefit dwc3 IPs where hibernation is
not enabled and the dwc3 low power mode entry/exit is handled by the
glue driver. The assumption here is that the platform using this dt
property is capable of detecting resume events to bring the controller
out of suspend.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index a696f23730d3..e19a60d06d2b 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -403,6 +403,11 @@ properties:
     description:
       Enable USB remote wakeup.
 
+  snps,runtime-suspend-on-usb-suspend:
+    description:
+      If True then dwc3 runtime suspend is allowed during bus suspend
+      case even with the USB cable connected.
+
 unevaluatedProperties: false
 
 required:
-- 
2.17.1

