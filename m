Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC67EFAB8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbjKQV1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjKQV1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:27:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BB62694;
        Fri, 17 Nov 2023 13:19:22 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHJfpuH014495;
        Fri, 17 Nov 2023 21:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Htbdv88IS9eq2U2jJwbMHr4a41BZkkF3H5nOOl1ZvJw=;
 b=fBFi1GRWABnppf9rpmps3e36mqLNGqH9EB4TGRKmQxiCJ6thyDhTNUhdp5YuDLD/6iqN
 S5vLvyDHgn/sJK0T5CTAdrw2n1koyVnNh8hCj13n3Lriv13RMCcLjY6cfL/FYVxjujoh
 L6xWJp3DNPFUL8ywYmRbYi3xWpLIbLz0EuLQ+BwdByrqk6svL5zUAaVXVVYSWZlfMWKV
 igwh3ZsW5d8EpBPT1FyHbCGpsZNS3Vy47LuOQR51Y2ycRIJq+vjY+wNRVehdILNBAGT/
 RFZdhAeziYCXgtC/bPLyIiOh5e2lXkv6de+QxBnikl9C0c/q91aZKCfCB1JGguCQxYdK Xw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udmw43qvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 21:19:09 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHLJ7aX031500
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 21:19:07 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 13:19:07 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
Date:   Fri, 17 Nov 2023 13:18:46 -0800
Subject: [PATCH 1/3] dt-bindings: power: reset: Convert mode-.* properties
 to array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231117-arm-psci-system_reset2-vendor-reboots-v1-1-03c4612153e2@quicinc.com>
References: <20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com>
In-Reply-To: <20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0maRuJ7ZtQWirJRb2X0gLs3Bu8ubYjNy
X-Proofpoint-ORIG-GUID: 0maRuJ7ZtQWirJRb2X0gLs3Bu8ubYjNy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_21,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=910
 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170159
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSCI reboot mode will map a mode name to multiple magic values instead
of just one. Convert the mode-.* property to an array with default
number of items limited to 1.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/devicetree/bindings/power/reset/reboot-mode.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
index ad0a0b95cec1..2c786e783464 100644
--- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
@@ -28,13 +28,16 @@ description: |
 
 properties:
   mode-normal:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: "#/patternProperties/^mode-.*$"
     description:
       Default value to set on a reboot if no command was provided.
 
 patternProperties:
   "^mode-.*$":
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    # Default to one value. Bindings that reference this schema could override.
+    minItems: 1
+    maxItems: 1
 
 additionalProperties: true
 

-- 
2.41.0

