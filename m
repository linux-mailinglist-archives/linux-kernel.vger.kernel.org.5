Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0037A2072
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjIOOFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjIOOFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:05:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0DD1FCC;
        Fri, 15 Sep 2023 07:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byxp5s74KzQpULehQgGzu49lSYOadqYhIFLBqkXp6HLN9axa6iSETvfAKCe4PCdN+E9GOeXMPZ4ISA1wUf3+cViaGbP7OUXZI/NKFTtOirCVcKMw8NnHa5kA4UL8F/0/7Bq9ZAyU8ljrvamg3SSc2IET8MYwh1w/W6e9JKtDam7EzUULybAmYszBuc+k6p4Hoq+FQYnnTIyHOTXfHHt8NugGNzthqUsC+vTwTSWG577h9RfCv6yT4Y729/xf5zcseZzmgwOtRRgEBVOF+x62fPbU2LIP3N+Mt/H+8xzLerpE/DZa/saq2kLQ3Uy8gc9c9DNOF4wSImyghsjfIGkeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py9fIa4DYNUu9u5VEoQ5z5bqAm59jnw+4sHK1LITt0E=;
 b=cFAR+wvXvPq1XqJdQksdi6/fyAVVx0B4YZC/j/S960nirYis60Jzxe1svtVpERk4G1f1Nva52rlqGK2o3vf3NFZb4aGNcAzIuQwVWdRiOALu6ws0r6IiCC/c5c1YYsLPkzdl6eXVTCuzM5a5yx2OjAnsvQwmKnCUS9th1lVCDkIvp9kg5ubBHH+tkOxDh9E0mbEY+6Aq3mVvZIiS8eb49n9NjQnml+fAsEbm+iDKf/0eN/jSYdYMMHw8PUHMmWrTawXalSj2qoSiOLuORfVAw6HSdbbuW5caEK66qQ6GujWMaW9iHK8g5gldgo28nEhhFgaefC3LMO0QKyYCaqvxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py9fIa4DYNUu9u5VEoQ5z5bqAm59jnw+4sHK1LITt0E=;
 b=l/e2Gk1z8sTHGQKPVWPf4QpyiYZ5eu8k7zlLv0ML2nT5SZTpQie0Gtr+JWOU9gJu0Df9bhKHvhkDiKeqMChVnjpoccFhw9MrCo8YYdqL2a5D+POOLZf0CeIy2c1L4A/CrZiL5dItjK+aaXDOvY2KH6CxcX51VI8ec7H+YQUmU0g=
Received: from AM0PR04CA0095.eurprd04.prod.outlook.com (2603:10a6:208:be::36)
 by AS8PR01MB8603.eurprd01.prod.exchangelabs.com (2603:10a6:20b:44b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.7; Fri, 15 Sep
 2023 14:05:21 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:208:be:cafe::74) by AM0PR04CA0095.outlook.office365.com
 (2603:10a6:208:be::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 14:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.0 via Frontend Transport; Fri, 15 Sep 2023 14:05:20 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Fri, 15 Sep 2023 16:05:20 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v2 1/2] dt-bindings: backlight: Add MPS MP3309C
Date:   Fri, 15 Sep 2023 16:05:15 +0200
Message-Id: <20230915140516.1294925-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Sep 2023 14:05:20.0279 (UTC) FILETIME=[A9912270:01D9E7DD]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|AS8PR01MB8603:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a7d04cf5-8ae5-4f69-7cfb-08dbb5f4cc93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5Dl+jch3IoJzEVXlELOpfLsFJuCEgkQsowD7rDcgFQWoywZZWe8mz+9vNxjtqCrYjOPdtVGDlPG1/ksPsg4Nx4qw948RjB0tvQ6DMDpaAd8copdYhWjSZGmad6uoEkpfFcVN+1EEGvo837jvxWze115Q7J0Dwmu4wU/bUO3C3BCQziRVCOSxbcmQZAElqQBpqfCW8TNxUkNoYGmB7fB5f8d8AcFcN7JTFVLN0OoVx3ecE21GSnkHGCiU8eu2B6qQU7Nbg/RC/vSwCz/3pGpfD0FQcaMfrJdjRZHa9s8yCi3q8vu6wvXN1RtPX2LX2jrH7Yg2OP+gYWSIaz9kEttbHcGUXYVqwWFOKBA6yGAXSO6XgK5iYRTya0uXTLnbH8S1E/wCP+6qH1pvASoS+dADU4OXpirJtVjfWmi4h6Wu+wqyaBbpRMnVZfjzGg9BG72CpoRAClqCioa1yltLM4kAdqGY+Bhb+Afew6vvGhymkoEaMbNd4fkou3J/bIIW06m1Sy21q7Bwqcvy8MvkqXUcuHC3ajxAaBnB6edYmLEysk1ULuPDNtHoB5iHIExaTUPf6saHrK5DeunJUNyQKNeKSCFjST6A4tn1My8LuY+tBEiuQwTsY9UjHcmiR/VV9A3+yKL09o+he6R+muQ3ovYEMZwzB4ogQcOQVTauaBNCuyFFvDO36jRzIa+3rF86Eek36fCz1z6MB5VE2vae/0PbpbF0HlO6/tTGoEJxrqzx6s=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39850400004)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(36756003)(8936002)(110136005)(5660300002)(86362001)(36860700001)(40480700001)(8676002)(450100002)(41300700001)(82740400003)(6666004)(2616005)(26005)(336012)(1076003)(107886003)(356005)(47076005)(4326008)(70206006)(70586007)(81166007)(478600001)(2906002)(966005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 14:05:20.9735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d04cf5-8ae5-4f69-7cfb-08dbb5f4cc93
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB8603
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Monolithic Power (MPS) MP3309C is a WLED step-up converter, featuring a
programmable switching frequency to optimize efficiency.
The brightness can be controlled either by I2C commands (called "analog"
mode) or by a PWM input signal (PWM mode).
This driver supports both modes.

For device driver details, please refer to:
- drivers/video/backlight/mp3309c_bl.c

The datasheet is available at:
- https://www.monolithicpower.com/en/mp3309c.html

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v2:
 - remove useless properties (dimming-mode, pinctrl-names, pinctrl-0,
   switch-on-delay-ms, switch-off-delay-ms, reset-gpios, reset-on-delay-ms,
   reset-on-length-ms)
 - add common.yaml#
 - remove already included properties (default-brightness, max-brightness)
 - substitute three boolean properties, used for the overvoltage-protection
   values, with a single enum property
 - remove some conditional definitions
 - remove the 2nd example
v1:
 - first version

 .../bindings/leds/backlight/mps,mp3309c.yaml  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
new file mode 100644
index 000000000000..99ccdba2c08f
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/mps,mp3309c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MPS MP3309C backlight
+
+maintainers:
+  - Flavio Suligoi <f.suligoi@asem.it>
+
+description: |
+  The Monolithic Power (MPS) MP3309C is a WLED step-up converter, featuring a
+  programmable switching frequency to optimize efficiency.
+  It supports two different dimming modes:
+
+  - analog mode, via I2C commands (default)
+  - PWM controlled mode.
+
+  The datasheet is available at:
+  https://www.monolithicpower.com/en/mp3309c.html
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: mps,mp3309c
+
+  reg:
+    maxItems: 1
+
+  pwms:
+    description: if present, the backlight is controlled in PWM mode.
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO used to enable the backlight in "analog-i2c" dimming mode.
+    maxItems: 1
+
+  mps,overvoltage-protection-microvolt:
+    description: Overvoltage protection (13.5V, 24V or 35.5V). If missing, the
+      hardware default of 35.5V is used.
+    enum: [ 13500000, 24000000, 35500000 ]
+
+  mps,no-sync-mode:
+    description: disable synchronous rectification mode
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - max-brightness
+  - default-brightness
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Backlight with PWM control */
+        backlight_pwm: backlight@17 {
+            compatible = "mps,mp3309c-backlight";
+            reg = <0x17>;
+            pwms = <&pwm1 0 3333333 0>; /* 300 Hz --> (1/f) * 1*10^9 */
+            max-brightness = <100>;
+            default-brightness = <80>;
+            overvoltage-protection-microvolt = <24000000>;
+        };
+    };
-- 
2.34.1

