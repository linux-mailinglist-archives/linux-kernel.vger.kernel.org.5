Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D47DC74F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbjJaHaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343679AbjJaHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:30:01 -0400
X-Greylist: delayed 1783 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 00:29:58 PDT
Received: from mx0a-002bf204.pphosted.com (mx0a-002bf204.pphosted.com [205.220.160.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE059EA;
        Tue, 31 Oct 2023 00:29:58 -0700 (PDT)
Received: from pps.filterd (m0207524.ppops.net [127.0.0.1])
        by mx0a-002bf204.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39V54qOn019203;
        Mon, 30 Oct 2023 23:59:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        monolithicpower.com; h=from:to:cc:subject:date:message-id
        :content-type:content-transfer-encoding:mime-version; s=pps1;
         bh=CwZOxCKvbKZIlPgjmeSqV1G7O2DJbFheP9h6n740HuA=; b=afn9jbDJ7qWu
        3gA8ZMkZoODnP7ep2ybaYmjfZ8VBzy+afqUaz7c2q5flzy4qfsIaT0Nn4X2MVTVx
        WS3Qsmt3KXTgESKQu/u9rWLlghPldoDRS5th2Uml5f7dXfRrY2hjFjc22Uos6GnZ
        dY17sQxTGQxhA4o4eHaOMf6BIfC6zSh3csthaPEIv7uQOn0+DI40Z+nn41+utQz0
        /9FvSfK0x/Osyifkjf2DCsQvuFOSWumzXCwrJSfCV4VooveZcFJ7C9KzbmPkskJn
        hDHScPV3dLU3OZgs2n/vwUVB8TZu6CwrtC27rrslGxXMzRFu/V/8cBty6qEQ1myS
        Lgj6apuwog==
Received: from webmail.monolithicpower.com (mps-vpn.monolithicpower.com [12.33.0.20] (may be forged))
        by mx0a-002bf204.pphosted.com (PPS) with ESMTPS id 3u0wqmsc98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Oct 2023 23:59:54 -0700 (PDT)
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 MPS-MSH04.monolithicpower.com (10.10.10.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 Oct 2023 23:59:53 -0700
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 CD-MSH04.monolithicpower.com (10.10.70.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 31 Oct 2023 14:59:50 +0800
Received: from CD-MSH04.monolithicpower.com ([fe80::69c9:32c5:3392:58d]) by
 CD-MSH04.monolithicpower.com ([fe80::69c9:32c5:3392:58d%2]) with mapi id
 15.01.2242.004; Tue, 31 Oct 2023 14:59:50 +0800
From:   "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wyx137120466@gmail.com" <wyx137120466@gmail.com>
Subject: [PATCH 1/2] dt-bindings: leds: add mps mp3326 LED
Thread-Topic: [PATCH 1/2] dt-bindings: leds: add mps mp3326 LED
Thread-Index: AdoLx9OfwuLsri/bSIeT3ozCc+UFaQ==
Date:   Tue, 31 Oct 2023 06:59:50 +0000
Message-ID: <c8bbeb3c3d9b44049d790e90d9738a83@monolithicpower.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.84.127]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: UF1Tq-4cu-Fpw6QULO6Tup98Qc5D2gPg
X-Proofpoint-GUID: UF1Tq-4cu-Fpw6QULO6Tup98Qc5D2gPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310310054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Document mps mp3326 LED driver devicetree bindings.

Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
---
 .../devicetree/bindings/leds/leds-mp3326.yaml | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-mp3326.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-mp3326.yaml b/Docu=
mentation/devicetree/bindings/leds/leds-mp3326.yaml
new file mode 100644
index 000000000000..df03c21ae53a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-mp3326.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds-mp3326.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LED driver for MP3326 from Monolithic Power Systems
+
+maintainers:
+  - Yuxi Wang <Yuxi.Wang@monolithicpower.com>
+
+description: |
+  Monolithic Power Systems MP3326 LED Drivers
+
+  For more product information please see the link below:
+  https://www.monolithicpower.com/en/products/mp3326.html
+
+properties:
+  compatible:
+    - const: mps,mp3326
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  mps,led-protect:
+    description: |
+      LED short protection threshold.
+    enum: [0, 1, 2, 3]
+
+  multi-led:
+    type: object
+
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+
+      color:
+        description: RGB module
+        const: LED_COLOR_ID_RGB
+
+      led_r:
+        type: object
+
+        properties:
+          "#address-cells":
+            const: 1
+          "#size-cells":
+            const: 0
+          reg:
+            description: Index of the LED.
+            minimum: 1
+            maximum: 16
+          color:
+            description: Red.
+            const: LED_COLOR_ID_RED
+          required:
+            - reg
+            - color
+
+      led_g:
+        type: object
+
+        properties:
+          "#address-cells":
+            const: 1
+          "#size-cells":
+            const: 0
+        reg:
+          description: Index of the LED.
+          minimum: 1
+          maximum: 16
+        color:
+          description: Green.
+          const: LED_COLOR_ID_GREEN
+        required:
+          - reg
+          - color
+
+      led_b:
+        type: object
+
+        properties:
+          "#address-cells":
+            const: 1
+          "#size-cells":
+            const: 0
+        reg:
+          description: Index of the LED.
+          minimum: 1
+          maximum: 16
+        color:
+          description: Blue.
+          const: LED_COLOR_ID_BLUE
+        required:
+          - reg
+          - color
+
+  patternProperties:
+    "^led@[0-3]$":
+      type: object
+
+      properties:
+        reg:
+          description: Index of the LED.
+          minimum: 1
+          maximum: 16
+
+        required:
+          - reg
+          - color
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        mp3326@30 {
+            compatible =3D "mps,mp3326";
+            reg =3D <0x30>;
+            led-protect =3D<3>;
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            multi-led {
+              color =3D <LED_COLOR_ID_RGB>;
+              #address-cells =3D <1>;
+              #size-cells =3D <0>;
+
+              rgb_r@1 {
+                  #address-cells =3D <1>;
+                  #size-cells =3D <0>;
+                  reg  =3D <1>;
+                  color =3D <LED_COLOR_ID_RED>;
+              };
+              rgb_g@2 {
+                  #address-cells =3D <1>;
+                  #size-cells =3D <0>;
+                  reg =3D <2>;
+                  color =3D <LED_COLOR_ID_GREEN>;
+              };
+              rgb_b@3 {
+                  #address-cells =3D <1>;
+                  #size-cells =3D <0>;
+                  reg =3D <3>;
+                  color =3D <LED_COLOR_ID_BLUE>;
+              };
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        mp3326@30 {
+            compatible =3D "mps,mp3326";
+            reg =3D <0x30>;
+            led-protect =3D<3>;
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+            led0@0 {
+                #address-cells =3D <1>;
+                #size-cells =3D <0>;
+                reg=3D <5>;
+                color =3D <LED_COLOR_ID_WHITE>;
+            };
+        };
+    };
+
+...
--=20
2.25.1

