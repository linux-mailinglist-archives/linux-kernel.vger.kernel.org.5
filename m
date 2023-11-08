Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBAA7E5A9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjKHP5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjKHP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:57:13 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED61FDC;
        Wed,  8 Nov 2023 07:57:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULhTQQAYVIPPRtwVigrVwmj1AJKtujt3MnjO6gWQ9z1Rxkai/9jGGRXg5HVPt2Qag/C6t8qVS2pS/6hQwI7BPuKH0r6V8Jw3ws5YQmoa3FTxVC8pkZy8SgighQulkOKi9WO5rsTpqX2pbrhJzR7XeIh+7d9t4JT/6LJcguvOmx2aF1Mh41wNTR1F/vlPbAn1bDB9BsZebUvsafWLp/BKxG6IymBQ/VJoi3SuiLbD3/wEPQMSROGIqSI7KCk6iyvMJSLdx4lztm1N92qemlR0OnvvkyYN0oNPHvXvSlp2mkS+jvJlEOp5V+qJ+jTDFZ6FvcBXPT8G3J1JNoHFNjD1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blaP/Z2oHuBtJgixtMv/iFWdaV8dF4z7NhaT3iPjJUs=;
 b=nsdavT3cavCQLozOz9eQkzvf7q0FouWyrmZ9izDK4PC8bPQyfhhwkt3Tkr7oJdN+RREVOLmldZfYPonJ7Q1gVzKumswgwaY6xW5knW1IYhVhZitns67aGRn9rsj8MdJSXvsIpXLDDQQaBMCo3f/eyLYYToX171nw21rYBq8ROblC31ty+O9SiG3YxrjzLiPnMU6f2Yqki0X3fGZktolf5UL/r6rKa3baLXaqSLy7AE0xJwFczpRu2VICr/UKCG3Nlm+WqaLzdIdP3HmKh5X2+kMn7jFHD6V4VboYvlMfMHAq9SpQh16T3oMb/U1R11nwLnDJorMzrNC3efIpAPXs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=linaro.org smtp.mailfrom=2n.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blaP/Z2oHuBtJgixtMv/iFWdaV8dF4z7NhaT3iPjJUs=;
 b=SNYDGH+qKibd2rspBoFJuxdtLl4cGFAFhVXvuRpZEr5IHIIDyATrBhzPl0SVRxQG4zyYg6mTRDBHO1Y5EJlq3Eld4/MJ5D8mgDebtTJWnnV2+JSJON1hdM6I+Y8eBSYSVLni7aSLaKzmBdDFx+joAIuPvvymjNwavt93kXiVoxQ=
Received: from AS9PR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::12) by AS8PR02MB6616.eurprd02.prod.outlook.com
 (2603:10a6:20b:23b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 15:57:07 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:540:cafe::a5) by AS9PR01CA0007.outlook.office365.com
 (2603:10a6:20b:540::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 15:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of 2n.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.17 via Frontend Transport; Wed, 8 Nov 2023 15:57:07 +0000
Received: from lap5cg227217h.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Nov
 2023 16:57:05 +0100
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v5 1/3] dt-bindings: input: microchip,cap11xx: add advanced sensitivity settings
Date:   Wed, 8 Nov 2023 16:56:45 +0100
Message-ID: <20231108155647.1812835-2-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108155647.1812835-1-jiriv@axis.com>
References: <20231108155647.1812835-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|AS8PR02MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 2447152e-4b0e-4f79-bbae-08dbe0735be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kU/q0oIwwHRbOgezL5cHjrmzfv2egzXsNuHL7ly3G31hBdlqMCc20ANPTroKvQphgHRnPaSBgpl2CcINevoy+qyE9MQFcUv5XNXXWLSe2dKE7i5qmw57mcHeElQtRWzsq592LWtSGHvi8Vn5pV/t+RqdiK4n7GNwwBQCkrz/hN+kvkechq+p33SyCstitbB6RV4zcVLjlgF1LLAlaT0fr9XPn/9bryAW0qtVCaLmzPomi628AeAKJM36wGm9TkIjHJZZCMIiDOmr8f0NAo8QmKnM9R27rZWjWuA6vPUpQ4RV2ZfbPravfB+12oxZ3qee0H9jYzmSRmCbQeKVTMCufob4QXCPi7tiWFZX4RQtPnQmBgAwJXwgcfPB1b/sJSTG1uMbBhEzjhH8zNK9cJRttVzATVttiwhweJoLT0CMVJ/3VPa4uZkPIDDpIPZ6IhqkjF0KO+f08kpMCCLx0X/7zOihdsnDUWLQuDF/4gPzyJJMlforsky7dKQP23laLRUYOrLv2KwHWw0ubmT2ULoAVbEjH/S/ilUN7liQCVP0RmmMVRDojVCdNf4krVW8NVZovTd9Y/HG+eBW5jlGoNpOUQUq2K7XVPrJBisO3Aab7ceLzEWZMTSDBNo9KlI5hQoFYTDhZLMY7tO18BGEPPEgH6VUGeS2vJvZKcGzXZQRcyIk+g2Pq91yqvA6c0tag1J1SB0zxYBez0Kuy2CXgrUm0gkaVDxJSXcdgD9g8Oa7Zimt85klMba9ytH8EZzxW2/veMAE9P7bEvPVIfHGlx8UGw==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(40470700004)(36840700001)(46966006)(41300700001)(478600001)(47076005)(7696005)(2616005)(6666004)(8936002)(336012)(42882007)(83380400001)(426003)(54906003)(8676002)(26005)(5660300002)(2906002)(36860700001)(1076003)(16526019)(110136005)(316002)(70206006)(70586007)(81166007)(83170400001)(356005)(4326008)(82740400003)(40480700001)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 15:57:07.0256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2447152e-4b0e-4f79-bbae-08dbe0735be3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6616
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for advanced sensitivity settings and signal guard feature.

Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
 .../bindings/input/microchip,cap11xx.yaml     | 76 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 5b5d4f7d3482..aa97702c43ef 100644
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
@@ -70,6 +70,55 @@ properties:
       open drain. This property allows using the active
       high push-pull output.
 
+  microchip,sensitivity-delta-sense:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+    description:
+      Optional parameter. Controls the sensitivity multiplier of a touch detection.
+      At the more sensitive settings, touches are detected for a smaller delta
+      capacitance corresponding to a “lighter” touch.
+
+  microchip,signal-guard:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 8
+    items:
+      minimum: 0
+      maximum: 1
+    description: |
+      Optional parameter supported only for CAP129x.
+      0 - off
+      1 - on
+      The signal guard isolates the signal from virtual grounds.
+      If enabled then the behavior of the channel is changed to signal guard.
+      The number of entries must correspond to the number of channels.
+
+  microchip,input-treshold:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 8
+    items:
+      minimum: 0
+      maximum: 127
+    description:
+      Optional parameter. Specifies the delta threshold that is used to
+      determine if a touch has been detected.
+      The number of entries must correspond to the number of channels.
+
+  microchip,calib-sensitivity:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 8
+    items:
+      minimum: 1
+      maximum: 4
+    description:
+      Optional parameter supported only for CAP129x. Specifies an array of
+      numeric values that controls the gain used by the calibration routine to
+      enable sensor inputs to be more sensitive for proximity detection.
+      The number of entries must correspond to the number of channels.
+
 patternProperties:
   "^led@[0-7]$":
     type: object
@@ -99,10 +148,29 @@ allOf:
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
@@ -122,6 +190,8 @@ examples:
         reg = <0x28>;
         autorepeat;
         microchip,sensor-gain = <2>;
+        microchip,sensitivity-delta-sense = <16>;
+        microchip,input-treshold = <21>, <18>, <46>, <46>, <46>, <21>;
 
         linux,keycodes = <103>,	/* KEY_UP */
                          <106>,	/* KEY_RIGHT */
-- 
2.25.1

