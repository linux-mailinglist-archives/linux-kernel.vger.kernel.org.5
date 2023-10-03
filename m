Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0A47B5F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbjJCDPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJCDPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:15:42 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2084.outbound.protection.outlook.com [40.107.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC2AC;
        Mon,  2 Oct 2023 20:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt6GVMFNIUQlnrEblOyAxo9/NN7IQ7FnzdaIZZR9U8s2jB4I2L2DXDbkZMxQ6be1DCezN1cYjgnSLv4RQr3tBxKOMGCEeJoVngSkL7Rkxq+n8D/a4qBWAhmtN6Cy8O9xlarg5QZQ+DdB4tELUqwtVawfev2i20WXr2N+cU1xr9LA6yUPSYs6bkm+fIz2b96nXBnkevhBQ49uwyfsLW7DTHUgziA1JMycg8+1qblZGvhrAzEliCwl8/ZkAyjxnb3WOSaJZLJTFuz+PtBEmECQ55ax6ld/q0EJYCU3SzQ3sWKwRz8sdQ5KTFuPkCson3De+ByItKKu+fl+qrJGYw1X3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q1SEq+fsPLhWRcGCUvVOTCzWzXrgRGCR56eCQlopzo=;
 b=V+wwIr6OdoREEd2WaUHMXSnavt4EgI5Dcegl8vaeMswh4SMG/FGEIqbRahzyfaRZU9iZsaVVKzVZIXBLehWv5BDmLyJ20ajwG4diW7MaWu98wurO53GHAEF3IB/ooUmFQFqHuge1KyKsRWbYMWcFdr9XLIHXRJualozVXD8qeW6H05OJKb8kFDRidkPjcc3Zu6i3DnbJueD9MoeZ9UpeaErrND6TzVlE503rexN9EVnSqEe0NdqIxAZDf26WSOofTjaJcGOk9N8wLV7h9BmERtvKVwHWE1ztwKH6HCL/byNEsdpjuyei1N4HEgN6RL9dTMiC3WqEsrsmstLEyIeKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q1SEq+fsPLhWRcGCUvVOTCzWzXrgRGCR56eCQlopzo=;
 b=f2uX69f42XOJpVThum6i5STEA9LfI3/uu+pm/tJrj59XDyrxWrFCz/dX9yfIDBUavGWCKbcyIAQdOpXbFHGIzIDDjNxM4j7ybW4LjAiaelcYOqhbVOnVLsX8Gu1Bvt5yqZOePopubs0a/ND7fwgQucPC829Jqjno9tIQZi6cdEW2zZAWT1iKdapYMnrX2YRWNo3ceTQnmSWMbzQIR6nsTLpKnpdok6n++dyzlBGK2FTp6xJb+9Q6+nNwAdL1hH6lANthHU3uFZ+tE5KjKH3/jYUHk1sgULphIimTTCyknqEAuFZa0QwomwjuGES1PEn3vA1P5pDii8MAln6liv9G/Q==
Received: from SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) by
 PUZPR04MB6650.apcprd04.prod.outlook.com (2603:1096:301:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 3 Oct
 2023 03:15:34 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096::cafe:0:0:9b) by SG2P153CA0014.outlook.office365.com
 (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.6 via Frontend
 Transport; Tue, 3 Oct 2023 03:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 03:15:33
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: hwmon: add MAX31790
Date:   Tue,  3 Oct 2023 11:15:18 +0800
Message-Id: <20231003031520.3091047-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003031520.3091047-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231003031520.3091047-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|PUZPR04MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eabd69a-0ad3-44d8-2313-08dbc3bf01d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmBvKPg4vcKggLdb8hGF90GjK7gS2t9J3uGn5Po4KjwKEw1X60Y6oGfOh6LFrFU8URB46CJEuo9rqFU5mj5+WUnshxMooszT9Ubk6YfJ9WNoYXk2M5CJNdVRiU+5vbKim0CVPvn76txg35gN5dcrSnZkWGZcOkruV4ty5A8PtWrodzhVNvT8iZ5/Ruhj3EWtWc78kgOrC+iEkoJw1wQRPHooJsLfh6J+f5q2tcp1FcN/eSAFB0z2u7UGZo/OdqWZuaiS7K/IGqca50b+igerd69RT2aifI9oTiSCoAEFt92PyzkdaFzqJa/SSWuve2xcpCgpeeFhuM2ilMQOz8R3QqVoiMSM0f03F7390UAM4NmW806vqsNTc9L6JiHF60tNVStDEu5ERTK32bzEGH+9QfykdccWIgtJeNEkAnl/+y7cPVTsBvj9GHO0n+2rxQAZuT44nRbLsBNk/yFUJa8VpBcY3TWibpgBTbTvvBCv0XZcdG//aWuIOa45KTATjP6UBPd5vObUhmAcvXh5BGkCtl7LqRpH0+JE5mRkm9r79lSp0mHd2VNukIDPfwE+GnOo3xUrxcLge0C4axLEH9kTCvNgmKfR7o0nfclHvgrkhFgKuiWpQaUAxUqB/25zt1sJbgh8IdSr/Pcy3whcDWBV883Y53x4TwhG/G885aFZ6BA47QSEh7gNWWdMowBW2HQw
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(39860400002)(136003)(376002)(346002)(1800799009)(186009)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40480700001)(6666004)(110136005)(86362001)(316002)(36736006)(36756003)(966005)(70206006)(70586007)(478600001)(2906002)(41300700001)(5660300002)(8676002)(8936002)(4326008)(9316004)(47076005)(2616005)(336012)(26005)(956004)(6506007)(36860700001)(1076003)(356005)(6512007)(82740400003)(6486002)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 03:15:33.3278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eabd69a-0ad3-44d8-2313-08dbc3bf01d3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6650
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for the MAXIM MAX31790.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
v3 - Use 'sensor-type' in 'channel' node to config pwm as tach.
   - Changed the status in MAINTAINERS to 'Maintained'.
v2 - Add dt-bindings for the MAXIM MAX31790.
---
 .../bindings/hwmon/maxim,max31790.yaml        | 89 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
new file mode 100644
index 000000000000..7f717ab4caac
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim max31790
+
+maintainers:
+  - Delphine CC Chiu  <Delphine_CC_Chiu@wiwynn.com>
+
+description: |
+  The MAX31790 controls the speeds of up to six fans using
+  six independent PWM outputs. The desired fan speeds (or PWM duty cycles)
+  are written through the I2C	interface.
+  The outputs drive “4-wire” fans directly, or can be used to modulate
+  the fan’s power terminals using an external pass transistor.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
+
+additionalProperties: false
+
+properties:
+  compatible:
+    enum:
+      - maxim,max31790
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@[1-6]$":
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      reg:
+        items:
+          - enum: [1, 2, 3, 4, 5, 6]
+
+      # There are 6 PWM output channel in MAX31790 that allows to be configured
+      # as a TACH input by setting the Fan Configuration register.
+      # The default setting will be PWM output.
+      sensor-type:
+        items:
+          - enum:
+            - PWM
+            - TACH
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pwm@20 {
+            compatible = "maxim,max31790";
+            reg = <0x20>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@3 {
+                reg = <3>;
+                sensor-type = "TACH";
+            };
+
+            channel@6 {
+                reg = <6>;
+                sensor-type = "TACH";
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c8fdd0d03907..21be46200343 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1371,6 +1371,12 @@ F:	Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
 F:	Documentation/hwmon/max31760.rst
 F:	drivers/hwmon/max31760.c
 
+ANALOG DEVICES INC MAX31790 DRIVER
+M:	Delphine CC Chiu  <Delphine_CC_Chiu@wiwynn.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
+F:	drivers/hwmon/max31790.c
+
 ANALOGBITS PLL LIBRARIES
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 S:	Supported
-- 
2.25.1

