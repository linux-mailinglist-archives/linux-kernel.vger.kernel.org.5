Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5904C7BFAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjJJMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjJJMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:16:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F0FA4;
        Tue, 10 Oct 2023 05:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJyvcr1A7l+HqqJ00grmZTkqe2GSyPvn3lmruOS/T5NLbjxltTp9f27RD+vSXQ9qfJ7Jh7y5LCv/uH7AYCjrXsQir63dhAz1nxOaAH8ox2q8YvCfodiwB/yIj6PIEaykC0tpjOXFBF1jJoISWwz2ERWMEEvMzRhHoG8T4ejcHwxjd3Yoj2wfNADzgv1Cx7dBLr/m51phU+TWo5pv8wzrEtHSajc+XtCOh+ndKQMN3sPJPiXRn7mhebkdhkdvbj9of28TxFs7q0KuChwLoj9S2Pb+J3GbWKvGxt6pVDlu/OlR8tdmDfg4UkPk2P4DjALonfXedDnf6Yed5JQUE1Ktjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiP9OYAokihYsk6mwFuxzU5u73vQxiEPThzkg+/dh7o=;
 b=ZbFdBNypP05IdLrgtQgiV1UDEZs8AFQiP18n8ZIXq9OFiKVMr3WE3B3aJ9HoTYENTifLWtyT7XuOav3uKnQhs5L4b335XnLfrY3oOs8gFMl682xromUGv7o9od8Jpl7ZgtlyEk7vjvUCygx0KW/WnymRpDW7SflP+IM3StdrN16kCT1JLLndIYuW81dC8eyYMOysUirIxTsyG1oLNrjiK6161fPC9dfft+W6sSyk0O7ma2AaiMiJJEVOqiCk079Daf4I5qXPOAQFub8+D1J+ZWNxi8/Mkg+2MUDEsyvYD1BX1cPshx4sxpraLGlvnJbCvlZ2zSIXWIaPccoyoaRABA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiP9OYAokihYsk6mwFuxzU5u73vQxiEPThzkg+/dh7o=;
 b=hiVt8qbY3uAMsnd1+mpvF9kIr9603jC44fEHGx4dR8muO/T9mppjtHkUzsRGRX3YDyWfgJmNNFNQNeFQ7Jgw2Lg0GmofDMElywe5+/SwJ+/Wg9fFjdRn0DSMOdeZRAFqM5+W6EBOTcbH3rInpQK0KbjBLr+ll50AU1NjC8v22OE=
Received: from DB8PR06CA0058.eurprd06.prod.outlook.com (2603:10a6:10:120::32)
 by PAXPR01MB8488.eurprd01.prod.exchangelabs.com (2603:10a6:102:22a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 12:16:27 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::47) by DB8PR06CA0058.outlook.office365.com
 (2603:10a6:10:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 12:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 12:16:26 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Tue, 10 Oct 2023 14:16:26 +0200
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
Subject: [PATCH v4 1/2] dt-bindings: backlight: Add MPS MP3309C
Date:   Tue, 10 Oct 2023 14:16:21 +0200
Message-Id: <20231010121621.3009154-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Oct 2023 12:16:26.0024 (UTC) FILETIME=[972CB280:01D9FB73]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|PAXPR01MB8488:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 78448551-c482-43fc-974e-08dbc98aba1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkIkhLFbwhcAxs+n/736kV49Cqc1ith2aXf2J6KYibZYd5H49sd2QcQircOCO+fGaVnRP0vq2weGlj1ic3MLNSV79Ypsoc6WVY6Cn1cqK3iyTyVWOqMQxTFwZpySbHENjDxuoxqc7kra2ORwtLYcs5u6BooQ2LOtvtT5OfQdDhU8EM+PptUxpt11ajZpGaVUjvEqinvwwJX+nDb+53gxmrnlVl7zdFA+opSUqL9eMgVpol1d/st/2qf0IvFg88tBQfCEaES59HyT2C4Hd4HpHVBsFhAE1vWtA0wZVzRBo8CbfSCI2S08VVYYCwUsxGuuPNFvZuvkqXuoUviqwP0+8ayQAjp+ySRrDd2Xy91DwdZWajHi7WV+dR42Dy2Kp6ToO9QE2wKxutLmAJPPTbFNQq/XLhqkJf1hmPJdqeh8aiYBT7oPu9NEm6mQVQSQbg2SCPQ2VxysFOiZSUxtmWu5SqQunNe0Kw6krNIX4KwE0UN5orExVSYVi746NhEFk8JzE0HW0KYyE+0B/fYLcUR4gHcyrO3FIaOUDXCOeSLKn85j52uxbb77ney+YbbQIfxkoJBPfCtcQ0em8FqjqaVeQIQA9qbnAxAp/POeE4vBaU7uS0vFBsLmqAm9dWpxbeuTNWpMUq5tFrYAARNYq/1RSLXeP80wGstRbmG0HNS8wWDX+RsXEwbA3dB3QyrnlyS3gGpDAncH3Z9p+PFs+H8WVyys+ADJPhPw+NQ5XuzImjs=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(376002)(39840400004)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40480700001)(83380400001)(107886003)(1076003)(336012)(2616005)(47076005)(26005)(70586007)(36860700001)(110136005)(316002)(70206006)(6666004)(4326008)(8676002)(41300700001)(5660300002)(966005)(2906002)(478600001)(8936002)(450100002)(36756003)(356005)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 12:16:26.5844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78448551-c482-43fc-974e-08dbc98aba1a
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR01MB8488
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

v4:
 - remove not more used allOf keyword
 - add brightness-levels and default-brightness properties
 - remove max-brightness and default-brightness from required properties
 - update example, adding brightness-levels and default-brightness properties
v3:
 - add default value for mps,overvoltage-protection-microvolt property
 - fix the example, changing from "mps,mp3309c-backlight" to "mps,mp3309c" in
   compatible property
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

 .../bindings/leds/backlight/mps,mp3309c.yaml  | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
new file mode 100644
index 000000000000..e2f9ae2b3fb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
@@ -0,0 +1,82 @@
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
+  - analog mode, via I2C commands, as default mode (32 dimming levels)
+  - PWM controlled mode (optional)
+
+  The datasheet is available at:
+  https://www.monolithicpower.com/en/mp3309c.html
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
+  brightness-levels:
+    description:
+      Array of distinct brightness levels, in PWM dimming mode.
+      Typically these are in the range from 0 to 255, but any range starting
+      at 0 will do.
+      The 0 value means a 0% duty cycle (darkest/off), while the last value in
+      the array represents a 100% duty cycle (brightest).
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  default-brightness:
+    description:
+      The default brightness (index into the levels array).
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  mps,overvoltage-protection-microvolt:
+    description: Overvoltage protection (13.5V, 24V or 35.5V).
+    enum: [ 13500000, 24000000, 35500000 ]
+    default: 35500000
+
+  mps,no-sync-mode:
+    description: disable synchronous rectification mode
+    type: boolean
+
+required:
+  - compatible
+  - reg
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
+            compatible = "mps,mp3309c";
+            reg = <0x17>;
+            pwms = <&pwm1 0 3333333 0>; /* 300 Hz --> (1/f) * 1*10^9 */
+            brightness-levels = <0 1 2 3 4 5 6 7 8 9 10>;
+            default-brightness = <8>;
+            mps,overvoltage-protection-microvolt = <24000000>;
+        };
+    };
-- 
2.34.1

