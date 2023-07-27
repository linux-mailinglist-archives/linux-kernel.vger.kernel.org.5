Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B87650FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjG0KYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjG0KXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:23:40 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF78F0;
        Thu, 27 Jul 2023 03:23:39 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R9iX43027205;
        Thu, 27 Jul 2023 06:23:36 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s36ahwjrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 06:23:35 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 36RANY8A014075
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 06:23:34 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 27 Jul 2023 06:23:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 27 Jul 2023 06:23:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Jul 2023 06:23:33 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36RANMXL031645;
        Thu, 27 Jul 2023 06:23:24 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] dt-bindings:iio:frequency:admv1013: add vcc regs
Date:   Thu, 27 Jul 2023 13:23:08 +0300
Message-ID: <20230727102309.92479-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 5gRnnmw5ulnk7Kqlep9YziQpsn6YDZj3
X-Proofpoint-GUID: 5gRnnmw5ulnk7Kqlep9YziQpsn6YDZj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270092
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the VCC regulators of the ADMV1013 microware
upconverter.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/frequency/adi,admv1013.yaml  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
index fc813bcb6532..6660299ac1ad 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
@@ -39,6 +39,46 @@ properties:
     description:
       Analog voltage regulator.
 
+  vcc-drv-supply:
+    description:
+      RF Driver voltage regulator.
+
+  vcc2-drv-supply:
+    description:
+      RF predriver voltage regulator.
+
+  vcc-vva-supply:
+    description:
+      VVA Control Circuit voltage regulator.
+
+  vcc-amp1-supply:
+    description:
+      RF Amplifier 1 voltage regulator.
+
+  vcc-amp2-supply:
+    description:
+      RF Amplifier 2 voltage regulator.
+
+  vcc-env-supply:
+    description:
+      Envelope Detector voltage regulator.
+
+  vcc-bg-supply:
+    description:
+      Mixer Chip Band Gap Circuit voltage regulator.
+
+  vcc-bg2-supply:
+    description:
+      VGA Chip Band Gap Circuit voltage regulator.
+
+  vcc-mixer-supply:
+    description:
+      Mixer voltage regulator.
+
+  vcc-quad-supply:
+    description:
+      Quadruppler voltage regulator.
+
   adi,detector-enable:
     description:
       Enable the Envelope Detector available at output pins VENV_P and
@@ -87,6 +127,16 @@ examples:
         clocks = <&admv1013_lo>;
         clock-names = "lo_in";
         vcm-supply = <&vcm>;
+        vcc-drv-supply = <&vcc_drv>;
+        vcc2-drv-supply = <&vcc2_drv>;
+        vcc-vva-supply = <&vcc_vva>;
+        vcc-amp1-supply = <&vcc_amp1>;
+        vcc-amp2-supply = <&vcc_amp2>;
+        vcc-env-supply = <&vcc_env>;
+        vcc-bg-supply = <&vcc_bg>;
+        vcc-bg2-supply = <&vcc_bg2>;
+        vcc-mixer-supply = <&vcc_mixer>;
+        vcc-quad-supply = <&vcc_quad>;
         adi,quad-se-mode = "diff";
         adi,detector-enable;
       };
-- 
2.41.0

