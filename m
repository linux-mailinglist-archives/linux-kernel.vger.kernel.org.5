Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159CF7CACED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjJPPGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjJPPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:06:04 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E8FA;
        Mon, 16 Oct 2023 08:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ucm8jSmz1FNhfhvYRcE9DlzdytQO5wobFyGgWzxHrJbuUuLrp0i6YaP4PDMdBpCRkwVxf604LswKWS3cgy/CxjDIpcleJ6wTCZkSF2Q0l8fF1XoUnr7Vl5WWf4K4TOOuwVpW4ocbX7jyDvIE6KQ+K7hXrc2CkXX6R2RTUs/HqDRCXVj0az9xKJTCbWdFTehyrgh6KOUhCJio2QijY2YhfqT0O03Q9ayJ7M0O6fPSEU1v9urE92/arLN5zwprWFbCqkVVHAhe4oLyG2hw7GUy6Ud8c7GcVb4lrmaHpC87lwqfeFTP8DBDaw/JW2nXfWIubawQ6Pt4+wMjmpSDWHrwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Sf04cX8xj6HqeOX4705suelc72pKv+ouylBGyQLNTY=;
 b=OZoM7RfrXdRCMGiLn415YDBMKY5HOPOtObY9JogpMXdyZRbEAZvDQLKbaqbQIMmPQfssbKWv0Pmo6YurYfl8VLSGa4ezixDgSTMHNQqrUPmPlMzRfRYXF32Nf1T56oRj942WfPsA3nTJcucYOvE9sE8aiq7/V7zo8SvtVdKWthaYvK6lRyDpFewe+QTH+QhrIRfIUAo2tnFlUF0/mXEOwqbSch+N4JABvQ+OaJkarRA33E7GHU+ER868EEgaP2J3u/H1kxpx0kIAgllP9NyyARG2PEgUEZq3tPb/74AuQifsh2pGBC16ytwnl5zyR8cO4nq+kynWeAhvn3Bk6q+6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Sf04cX8xj6HqeOX4705suelc72pKv+ouylBGyQLNTY=;
 b=PNiu14tTNHQeOV3x3hPWIWpdnRP97/zO2JRA1jsHbTZOK9e1GOjl0h5KDngw6N2bkYGRi+E7/6HFAvOoiPQkeUAc0dFwOgmRda5N765A88azCZ0NhpHWDFg08UEPbpVOx4IFRM6le3lAPFbONkZ8G52iM4v8i92USxSk2h/xRgQ=
Received: from AM4PR05CA0033.eurprd05.prod.outlook.com (2603:10a6:205::46) by
 VI0PR01MB10583.eurprd01.prod.exchangelabs.com (2603:10a6:800:209::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16; Mon, 16 Oct
 2023 15:05:57 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:205:0:cafe::16) by AM4PR05CA0033.outlook.office365.com
 (2603:10a6:205::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 15:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 15:05:56 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Mon, 16 Oct 2023 17:05:56 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1] dt-bindings: backlight: add brightness-levels related common properties
Date:   Mon, 16 Oct 2023 17:05:54 +0200
Message-Id: <20231016150554.27144-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Oct 2023 15:05:56.0419 (UTC) FILETIME=[43AE5130:01DA0042]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78D:EE_|VI0PR01MB10583:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a87df133-30bc-4875-8a6f-08dbce596698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDu5mRmzq2NO0le5hcdqDcUP1WtCg2W0RrRUTHi0sijngwNmcqXchNbAprM8sI8CzrHE6ezNh98WrGVsDfBLt1fTfQU7K8taxhlxVcPO2k5DP2/x2JFLrUgQU8xRf+Vse8YxbD9K9iHplnLF5L2rIKIb+H9KY3jIsZajBml+J//Uavj4W5XLWQfoNUr+jNS83w4KcjCS1q52rgMH/oaCp41Q1DVr/T98gqG9sU+uu2fekVhjJN510M1zPsOTYyEOR+ipl69sOaJt3Kf+piHJwDj9nttr1gNXbKmNc5ehI0A6wTPSYmBI2dfOMAHLLUJ6GKY0Y5iP5a7IpF4GEhiOTvwBuvRRR3SYlnLcsVd4ydB2ZodhD8FzRrh+3JF7ztE12dUZfViq+5alPNrH82iBLFLpKgr/WjS3r5+kFL5aVVNqXgi2WMW8/T1ErQxyrO0+52RnHWau+3a1LOsUjpuhwEbwD7yzgr9RUyyw+FiJviRCPucPwr0Sou6QYIrZygh/qlBqug1PRkbMEqKukrFsr/dTq9DsXA2f0b28lgZlAjelXVAcd4+6AUEguEhia0aeCRJy9o0BezI3XOKl7r4CWbLPSjaKpvPF0dPw4KxnOOYNktdlnICuMcDK6K6+y7e5CCXA+Arzetp6mP89GD/GEnscYqtK+dr5O2sw3kjzbsj62Y32znR3w99geGpaoS3CxTXbu13nVixe4nJ9qJE+27zfxvzLuhOt54KWufNo+pEgWyvgHCu9E66H8NPxxR0n
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40480700001)(8936002)(8676002)(4326008)(450100002)(5660300002)(2906002)(41300700001)(86362001)(36756003)(82740400003)(356005)(107886003)(81166007)(1076003)(2616005)(26005)(83380400001)(478600001)(336012)(36860700001)(110136005)(47076005)(316002)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:05:56.9866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a87df133-30bc-4875-8a6f-08dbce596698
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR01MB10583
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both files pwm-backlight.yaml and led-backlight.yaml contain properties
in common with each other, regarding the brightness levels:

- brightness-levels
- default-brightness-level

These properties can then be moved to backlight/common.yaml.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 .../bindings/leds/backlight/common.yaml       | 17 ++++++++++++++++
 .../leds/backlight/led-backlight.yaml         | 19 ++++--------------
 .../leds/backlight/pwm-backlight.yaml         | 20 ++++---------------
 3 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/common.yaml b/Documentation/devicetree/bindings/leds/backlight/common.yaml
index 3b60afbab68b..e0983e44934c 100644
--- a/Documentation/devicetree/bindings/leds/backlight/common.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/common.yaml
@@ -33,4 +33,21 @@ properties:
       due to restrictions in a specific system, such as mounting conditions.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  brightness-levels:
+    description:
+      Array of distinct brightness levels. The levels must be in the range
+      accepted by the underlying LED device. Typically these are in the range
+      from 0 to 255, but any range starting at 0 will do, as long as they are
+      accepted by the LED.
+      The 0 value means a 0% of brightness (darkest/off), while the last value
+      in the array represents a full 100% brightness (brightest).
+      If this array is not provided, the driver default mapping is used.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  default-brightness-level:
+    description:
+      The default brightness level (index into the array defined by the
+      "brightness-levels" property).
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
index d7b78198abc2..f5554da6bc6c 100644
--- a/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
@@ -16,6 +16,9 @@ description:
   can also be used to describe a backlight device controlled by the output of
   a LED driver.
 
+allOf:
+  - $ref: common.yaml#
+
 properties:
   compatible:
     const: led-backlight
@@ -26,25 +29,11 @@ properties:
     items:
       maxItems: 1
 
-  brightness-levels:
-    description:
-      Array of distinct brightness levels. The levels must be in the range
-      accepted by the underlying LED devices. This is used to translate a
-      backlight brightness level into a LED brightness level. If it is not
-      provided, the identity mapping is used.
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-
-  default-brightness-level:
-    description:
-      The default brightness level (index into the array defined by the
-      "brightness-levels" property).
-    $ref: /schemas/types.yaml#/definitions/uint32
-
 required:
   - compatible
   - leds
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
index 535690288990..b71f6454a4ac 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
@@ -11,6 +11,9 @@ maintainers:
   - Daniel Thompson <daniel.thompson@linaro.org>
   - Jingoo Han <jingoohan1@gmail.com>
 
+allOf:
+  - $ref: common.yaml#
+
 properties:
   compatible:
     const: pwm-backlight
@@ -39,21 +42,6 @@ properties:
       Delay in ms between disabling the backlight using GPIO and setting PWM
       value to 0.
 
-  brightness-levels:
-    description:
-      Array of distinct brightness levels. Typically these are in the range
-      from 0 to 255, but any range starting at 0 will do. The actual brightness
-      level (PWM duty cycle) will be interpolated from these values. 0 means a
-      0% duty cycle (darkest/off), while the last value in the array represents
-      a 100% duty cycle (brightest).
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-
-  default-brightness-level:
-    description:
-      The default brightness level (index into the array defined by the
-      "brightness-levels" property).
-    $ref: /schemas/types.yaml#/definitions/uint32
-
   num-interpolated-steps:
     description:
       Number of interpolated steps between each value of brightness-levels
@@ -69,7 +57,7 @@ required:
   - compatible
   - pwms
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

