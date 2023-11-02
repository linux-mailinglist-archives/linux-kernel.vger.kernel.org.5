Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646497DEB5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348361AbjKBD3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346757AbjKBD3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:29:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2064.outbound.protection.outlook.com [40.107.255.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6D5123;
        Wed,  1 Nov 2023 20:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUcADIc8+lb/q7bKdaZCwNS6FnLyM4klGEfTaeAint5QQCNy9vDiVmlPk848F+WzD4FG0pQcb5n9GmPMXOKO44fHt/yAlBrdb0cyUGOmVBA+eGeMfi6c5vhOctBnZ3nf4hgqnO05LO+bF46GHBVpwLECUdsV4b12MplrCSCFwy6GS15HfvMb0BFE3l0Uvq2RBoE56Tndxwc/LEDoeGSgW44bSUfjKygLgNqArh84kHKzsaATc0xG2JX7HvCb04j2go7ex+32FP4n8QZunpk5J8ZmwDErclQrlZCrbGc5LFdROpRQ9UHLpNprlA4+bulbE20Hdd5SBWuAxN/dTeXb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEe8KtCVsQG/oRnOaYIPaZejyuib5zC9/ZH5CGkblLQ=;
 b=WVG8v8bpZyauEImfYoHrCR2ZQBGdOcB/d3p+nFVPbX8M3WEpUD3nbQIphgvkxemZhO5hyjuUC6mjKqY2qrqpOKpA/2ilH/em0u28v9y7a+eZMA8EMeJGnR56xb+dOa05yPDrDGLiPdthxiJndj7327PYHmTeKeoXy3ARQj+Jro7mVeyo/QxKso2ZJ1CNsXc6AwrvWc1W5jX4ST7pIlu1pOG3NsIxuV7bOABuPXItrY/g4vkTvpDuwiyPF28m2IDmFJmdUWS9hkiLw1RN7+0XW8M+qS+FEuYIDA/wvxok/Zi40YqEG0qPE4q2s2f+vElDFm8zFM1/vs8AdyUh6hxgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEe8KtCVsQG/oRnOaYIPaZejyuib5zC9/ZH5CGkblLQ=;
 b=SkxmyFcpjga+2iaUWXnlJTVHIaqDYtZvoa9VhlubELqrhc7245W2woeLE2P0hZp9YN0YK//xyg67Tbzjuw0daI20Liobb9mKOuBnIqmiqu5a9WIq5b9rFYgy/rwGVVx6HOJLysFAUU1CaqUFyiDVjP2fg9DzjowuD8wIPyQf8aQfpWz/icoUbdQGSmjaAMH5xE8cPhxxHTHS8Yb6dOIW9gDzjvJ2gfWeFfCwBdYjg/EK5jY+i7bQA6WsMo3Ky68yNV/so7IFsdelnsPzzqlaZO/TLHJqAgrNZakkyXPk1OqLTihilLDTg9Hk1W9SiHB9WBcHds+WLSQAvp+bBv/C5A==
Received: from SG2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:3:17::16) by
 TYZPR04MB7194.apcprd04.prod.outlook.com (2603:1096:400:463::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Thu, 2 Nov 2023 03:28:49 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::9) by SG2PR02CA0004.outlook.office365.com
 (2603:1096:3:17::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Thu, 2 Nov 2023 03:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server id 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 03:28:48
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: hwmon: add MAX31790
Date:   Thu,  2 Nov 2023 11:28:31 +0800
Message-Id: <20231102032834.3827289-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102032834.3827289-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231102032834.3827289-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TYZPR04MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: a339b738-13db-4d09-f5a4-08dbdb53d44b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LCtR8gf6vRjZbL0Oy5rflF+RWnFi6JOLnbly8aAkXzMukNLer7YM7TvR7YRpUs7d5VD68j5v5gnDADZTsp4ssaal4+TBLkcXw1zmo+zSL0AUl2K6PIZnsIipEuHKZvtD43Ket4E2HkZhNIg5M3a9CaKsl/b9JEugJAIN9PrmyjERW7PYqubOczsiH14SiY6s1FqYpuUoS+c5rR/I71exvfEyy92JOj7ggM7o6nR50um7IbDWYJ34Qkhwok3S70s8LGV6lKnPOU9I8uad3FDOLxlvQvvRiuws5TW0BW/ETjWWU6HQKtm6CW3MGRhT9ND1Uigfdp3yt4vewFy6f+npA5/rEsSHPUBnNveVTB4jXJMYUnzLyHdbLlkOjxIPt4EIBdq7k54Ki94+ytXdnY4GR4+qVDpwn6p4NGnGFg81iXxHVQVG/k0KdrS8EyoIerV5CEJ3PyOSlU+4UPZ3Xr+G0exnmiAf4pTE2CnWL2UKEbScIpH7OV02r+Zl7q+1VB0RKtEvRISoXlk4cr24fYY4JojPyxjjMJKSuR6HbFzvu3JmMnuliS2l6XUMHNUFm4SCnujgrEZL4xfbMK/+99HMvAQFXhb4PSlI2p9cnXZHpGme/0+RrnXf866OfM+r5h0rjP9GbIykd6RWjf46nAypELvQt6FjUI88cnb4IHDRNcXhIV12Z4naBaPWbou+mgveJW69b7oW57YSY1gBuvgyczS8owzgNO3xmp6XY++jPY=
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(136003)(376002)(396003)(39850400004)(230273577357003)(230173577357003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(46966006)(36840700001)(336012)(6512007)(70206006)(36736006)(966005)(6486002)(86362001)(26005)(1076003)(8676002)(36756003)(40480700001)(8936002)(4326008)(6506007)(110136005)(6666004)(956004)(316002)(70586007)(2616005)(478600001)(47076005)(5660300002)(36860700001)(7416002)(2906002)(41300700001)(81166007)(9316004)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 03:28:48.6698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a339b738-13db-4d09-f5a4-08dbdb53d44b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for the MAXIM MAX31790.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
v4 - No change.
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
index 43c5ed3c4508..707f1b903f60 100644
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

