Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9B7AD802
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjIYM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYM07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:26:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A0ACE;
        Mon, 25 Sep 2023 05:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyS34+UL77Hgr9CMvKTBL3OvwM8PC4nZsEUCeei7jhpuiAoE6pRmb/xniahCgRkjFv/EuyDpKNVh0cPd+50aT0S8vA9/U+nYEUrul+kZ10gDb4FgK+gls07kzSqKf/1w5mz5qJ6bOz0kUixQHd9Fdp5QG/584o79vJ29ZB5oD7Vzss9a6rJX2/ScOTeTrVgwCWvT8n+26uiZD09N+Dg6d1RaMqA12qRsHf43zBce0XGISc5CArpu1R1Ea1ZO/mHGw1ZjWPe/mAWGgwojXSw6d0g3LsYfuBPeSjxry15+K+kTs3rhlZxGR9wHpBKkXLT+d27qd0KF+7p8vDYJOum5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uyd0o4JvcjRjUAoyozcpPdzoVoil7+iWwK4OY683CF8=;
 b=e8Gv3oLMTjl3NjzFjtSHR0Qi1uoA5R0UJVtMbxjzLil8XUXBogOEsrX1Qt68D9z/ODHzyhp906/ciWZM6IUBmmiCGsVfFaX1VGxmBta9rra4C/jG3pazXknLg7MsctW2fXhqi0e3y865P9294nnONZVLsHL6Mi6WiOjSK6RZq1bRM7BEoeJuzfKHE2N7H8KVciwWE7r7Hu7dBUMNoBXOgbfLfJP6DhWQvAhoLu1HRrY3B79AF1MPNYGrAW0AWW0fElC+PgFrRP546qcyNwsw8vLmdkuWKJT2Fcb//YjrD+UiF2yYUbqBq0q4D9iuYD8QrUv9JvhfbuGy9gZGoc923g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uyd0o4JvcjRjUAoyozcpPdzoVoil7+iWwK4OY683CF8=;
 b=KOXHQdASZIIIQ2PrczIowdeXlxIlkYXJfOaExtaH5oWJBO28icn2r44ZKZpsUGBCISLAQeWOxrizkJAB9IRLqiKi8Lvkra0GdHyH5OMk7NNDzdp54f5cN0baStHNQDWA47SP+QG8mrxC2HyKjXQLS2eubONtRzTfY73cr3gcTXg=
Received: from AS9PR06CA0223.eurprd06.prod.outlook.com (2603:10a6:20b:45e::11)
 by PAXPR01MB9147.eurprd01.prod.exchangelabs.com (2603:10a6:102:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.18; Mon, 25 Sep
 2023 12:26:47 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:45e:cafe::1e) by AS9PR06CA0223.outlook.office365.com
 (2603:10a6:20b:45e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 12:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 12:26:47 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Mon, 25 Sep 2023 14:26:46 +0200
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
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: backlight: Add MPS MP3309C
Date:   Mon, 25 Sep 2023 14:26:08 +0200
Message-Id: <20230925122609.78849-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 25 Sep 2023 12:26:46.0637 (UTC) FILETIME=[8CE479D0:01D9EFAB]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|PAXPR01MB9147:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dd9efa45-51e0-477f-eedc-08dbbdc2afc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVZlxzJn6sWGaThX4Qxv00unpHhn8IRpCqnFae+ayMJ0EuGOGZAFK1cvXcJCYaHBQJiPIAMgYBA2z84osD5qbwDTXdt12WVBGqBhTtuQg3byxmgaN305VTEy0VaJGaMne2qmLi88N+WLpYHE0dYqEvgOMEXiqAogm5rPQv0c0w0URIWlrATAD/pKXXg0AW+8XVjPw9UrtY+dYtB9DASQm/1I146YTUr5VKmS8GDxAGNVRbGV8+UgzYEciBINR84bomJFjNgSY043emVYdpMPQrRP3urSQLEz4IYE35U5FTn7iWLPg6saH9saJW67KXtCLU7j2ZwhmAp6nSDxaTjGdozBJfo+sCoki7JOmBrsjFKL8PzNZA3KTZTFfhZZLBoc8IEyS/AuXaiDvknXC4fNjDPiZ3W+VLpPtPsIVQYUXGmdtttr98QpgeQHiqhBeAA3ofDI8RTey6DK5e3hZUz66CcKIU8a9ai78HpCIps1DymsUAkKWuylHhZZQ2rWC06BebadvTXtyr+Jsj1+cZgZ3mQBrar1T1suOplao0YYugnLWefsDg4YC/evNHfB8Qx8Hw9cPwdw7jEaKZy+eWBW7eJxV12VHeFryu85dLNFB6B5ZnbdVqoA2JkZTZ3DmtOSHJ5bUNgnzEEO0MG1+/2hfxQDkJ6SrmabRFHJJU28Sgz51fuTjYUoPJGRKKrUxzIisOHvug/xTxzeFg6qdEhAg2k1ruxKYi9+KqxU7Mc97oc=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(6666004)(70586007)(82740400003)(26005)(336012)(1076003)(2616005)(70206006)(86362001)(110136005)(966005)(478600001)(47076005)(36860700001)(81166007)(356005)(54906003)(2906002)(8936002)(8676002)(4326008)(36756003)(5660300002)(40480700001)(450100002)(316002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 12:26:47.1537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9efa45-51e0-477f-eedc-08dbbdc2afc6
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR01MB9147
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

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

 .../bindings/leds/backlight/mps,mp3309c.yaml  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
new file mode 100644
index 000000000000..4191e33626f5
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
+            compatible = "mps,mp3309c";
+            reg = <0x17>;
+            pwms = <&pwm1 0 3333333 0>; /* 300 Hz --> (1/f) * 1*10^9 */
+            max-brightness = <100>;
+            default-brightness = <80>;
+            mps,overvoltage-protection-microvolt = <24000000>;
+        };
+    };
-- 
2.34.1

