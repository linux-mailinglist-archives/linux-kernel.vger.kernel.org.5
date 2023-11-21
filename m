Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2367F32BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjKUPxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjKUPxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:53:14 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A99184;
        Tue, 21 Nov 2023 07:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAIEyHa4Rnquer1d26cFa2njzXHVUlIVw+5wNl+0VVjw5mIUbXpCEXcxLFVOJaIMkM7kxnjIotyKiUqlwEJZVzphwf4DBnrZv35uyQpl4zd4uYgeK/pe/cJxEqkOtcbruPMdV3ctgKF9tNQqUzi1OwQtGrNpDaktxPJR06iuQ/HaFgkCL/ysdm3s8IrYc9sqdZ5t8vEqh+D7yeHisbkLwSHM+W2g2SznOjBw/Jmf1GYEhAsqqBbHYT+agCv7WXHFDOKKqwAkT/ui6RPIrWtu3jsXuYEMLontrVDQ2tJQy7VfnBH5L89bWl4PbfA93JVdntnWYBMPObf3BebBki+6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfgVlD47gOe8RlGGn2dI+P679o+yEXzOwGvp4YlkyAg=;
 b=BLTvdaBwr9Qw2XizIpjSmXkv7i6ZnfD2iPhjwIzSYFhft8HF9/8cI/MH2EIwGc1FGiiUinuDVITMLGSIs2+KzPIVSFOyZuURpuqsIXfYlsWlJR52RvoM5My/kiaLrtW+xuN/uCEPBwY7EYiQo3oGPuXY0Mjnz4yFeT2a9G7cERN9OpPBrzyA70vhg4TU+YOxjqGvUt+Y4bM1zbDdmqLV942J+Uxm9MklUkKBoZSMwpbFlBocpvzEjgHA7YvCV7D2BCoZmB6cHx/vpkZyWCHvrMU7LgIqCRBbcSCSReqzkfwI96QcF7Jfo1BrkR+N1GAxtekfsbu/6sFCsX4kY2XJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=2n.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfgVlD47gOe8RlGGn2dI+P679o+yEXzOwGvp4YlkyAg=;
 b=ojhr9EyWVkZy9up0K45gc9wYZXpEgIcxRhVHhSMCzHyumV3Rv9hRiEjXbBMEtJUbW1AfxW9DrIvONoaQeeOgu2UUJc5o9tGW8tMkXzsZLysxbdL3G4UG4HGmPUqc2EmSAm0KEUENBgSS/DmfG8yGU4lqorAMzK6JGDpxMoHZ/Is=
Received: from AS8P250CA0005.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::10)
 by GV1PR02MB8756.eurprd02.prod.outlook.com (2603:10a6:150:8f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 21 Nov
 2023 15:53:06 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:330:cafe::6b) by AS8P250CA0005.outlook.office365.com
 (2603:10a6:20b:330::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 15:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of 2n.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Tue, 21 Nov 2023 15:53:06 +0000
Received: from lap5cg227217h.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Nov
 2023 16:53:05 +0100
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v6 1/2] dt-bindings: input: microchip,cap11xx: add advanced sensitivity settings
Date:   Tue, 21 Nov 2023 16:52:49 +0100
Message-ID: <20231121155250.613242-2-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121155250.613242-1-jiriv@axis.com>
References: <20231121155250.613242-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|GV1PR02MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1a37dc-4953-4071-fb18-08dbeaa9f3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYfXlPkcp05+FjG1bOnW9AwVmEXF4VZCO+FtctD59KFsPSo3+1hM9JIXRiWzaj0bX+dW1Bl18CEF/gY1+7GCqksEoD0qrNKFwssQbSCtjuVjn4qBYRJNCq/aIFfZZ+R3k8QG8/OaQ8TPeyKmCa/6nALOd6o4RW9OieeVQjUIcpM39QzZ4pZlDd7vR3LfXUmeTFzhE8Mg6H/1j2kMw3zUHDJPU6S6s9k292i37JC3rIo3Bx6UE9JruX/qz8dYwdtPN5YGTkgFyn5Fdofw6rNbM5d3Qtw6AQDZda2OVkAbLMsPHGBhMgCeUYk8eM7bY4kUPbEbmoHeaQiePeT27aeo9xULz9RFFajtuc55CldOcUvww0E2eOXkachiDYcIEHjJA3gsp1W1savtbNwbsXHixJauKg6Ko6tQFBZCMZp4AsCUNdHbQUN5l7w8NHBdxolsdXpUsm+Mwgo8Zs2yfpvqY4qDlIb8LiIg6Bp+odusf+L9VivOwTs/jWt6HaG3a6NLf2yGVGp8ItK6bAJ5KczyyW9A8E7cOkVVXsl87UVtz2t6mxpo3hvOc2hQbBIT/k/G/oWzS3d6T786cf79bwBMg8uznw195/j8+QF0f94YkoV3RPCuNtuQjLwWvX7aW9Y4M9EqPSsRgStq0SQ6A9vj285MGMhqh097xwbg0lZxrEjbtnhg4jOXjwyd1MoOptbnJxNVzxRK8aPL9Z8u5Gjk3NR0mSeN3uoABZe6iiM8IDtJ1k3QkUzwKP2ivMAsQQl9b2xPVRomxNRp9bBydizdRQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(40470700004)(46966006)(36840700001)(110136005)(83380400001)(42882007)(40480700001)(40460700003)(83170400001)(478600001)(7696005)(5660300002)(2906002)(6666004)(47076005)(82740400003)(36860700001)(356005)(81166007)(2616005)(70586007)(1076003)(426003)(336012)(8936002)(70206006)(41300700001)(16526019)(4326008)(8676002)(316002)(54906003)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 15:53:06.4200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1a37dc-4953-4071-fb18-08dbeaa9f3d8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8756
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for advanced sensitivity settings and signal guard feature.

Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
 .../bindings/input/microchip,cap11xx.yaml     | 80 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 5b5d4f7d3482..7f20c2cd53a8 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -45,13 +45,13 @@ properties:
       Enables the Linux input system's autorepeat feature on the input device.
 
   linux,keycodes:
-    minItems: 6
-    maxItems: 6
+    minItems: 3
+    maxItems: 8
     description: |
       Specifies an array of numeric keycode values to
       be used for the channels. If this property is
       omitted, KEY_A, KEY_B, etc are used as defaults.
-      The array must have exactly six entries.
+      The number of entries must correspond to the number of channels.
 
   microchip,sensor-gain:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -70,6 +70,59 @@ properties:
       open drain. This property allows using the active
       high push-pull output.
 
+  microchip,sensitivity-delta-sense:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+    description:
+      Controls the sensitivity multiplier of a touch detection.
+      Higher value means more sensitive settings.
+      At the more sensitive settings, touches are detected for a smaller delta
+      capacitance corresponding to a "lighter" touch.
+
+  microchip,signal-guard:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 8
+    items:
+      enum: [0, 1]
+    description: |
+      0 - off
+      1 - on
+      The signal guard isolates the signal from virtual grounds.
+      If enabled then the behavior of the channel is changed to signal guard.
+      The number of entries must correspond to the number of channels.
+
+  microchip,input-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 8
+    items:
+      minimum: 0
+      maximum: 127
+    description:
+      Specifies the delta threshold that is used to determine if a touch has
+      been detected. A higher value means a larger difference in capacitance
+      is required for a touch to be registered, making the touch sensor less
+      sensitive.
+      The number of entries must correspond to the number of channels.
+
+  microchip,calib-sensitivity:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 8
+    items:
+      enum: [1, 2, 4]
+    description: |
+      Specifies an array of numeric values that controls the gain
+      used by the calibration routine to enable sensor inputs
+      to be more sensitive for proximity detection.
+      Gain is based on touch pad capacitance range
+      1 - 5-50pF
+      2 - 0-25pF 
+      4 - 0-12.5pF
+      The number of entries must correspond to the number of channels.
+
 patternProperties:
   "^led@[0-7]$":
     type: object
@@ -99,10 +152,29 @@ allOf:
           contains:
             enum:
               - microchip,cap1106
+              - microchip,cap1203
+              - microchip,cap1206
+              - microchip,cap1293
+              - microchip,cap1298
     then:
       patternProperties:
         "^led@[0-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,cap1106
+              - microchip,cap1126
+              - microchip,cap1188
+              - microchip,cap1203
+              - microchip,cap1206
+    then:
+      properties:
+        microchip,signal-guard: false
+        microchip,calib-sensitivity: false
+
 required:
   - compatible
   - interrupts
@@ -122,6 +194,8 @@ examples:
         reg = <0x28>;
         autorepeat;
         microchip,sensor-gain = <2>;
+        microchip,sensitivity-delta-sense = <16>;
+        microchip,input-threshold = <21>, <18>, <46>, <46>, <46>, <21>;
 
         linux,keycodes = <103>,	/* KEY_UP */
                          <106>,	/* KEY_RIGHT */
-- 
2.25.1

