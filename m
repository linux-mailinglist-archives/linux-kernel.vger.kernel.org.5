Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B177B7EDEF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345067AbjKPKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbjKPKxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:53:37 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CF81B5;
        Thu, 16 Nov 2023 02:53:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6dX/GRSQtb06Ykg8uhBHLel5PKR++fW3Q6V1QSEsHlRopSJFZdRuMFakR7CfAh9lL0cQ3dAkltfpvp5IgQcrXp94liJEMdmOEDuIe8kvQhZzXajaMm9/T9AXS9wmvl4NaAvuNh5/e+1AV6QG8NJZxrHgUsCF29N1vhaxMfNwLIFzSAbEJsiu4eeK2ippDm7e0a+FCkM0M0kEOyRoMRS1v5lmYkDjeXgLUtRMwkJa6YH1lRPPAAokc6EoYK5wISk9dysni0Ff7lYpFyI+xUvImzAlAOgOzWXZCzJHr/gTWDoH6a5g74uoV8FlxqoqkUdRtMO59685s6aK8XN/D4k7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXGX5/3lV8ls++zZ8s81a873PdqAXsZCi8zrTLpHNn8=;
 b=UyYr4P/tFAxoRbp9CPUYO8K6JzTL+VSg7lEI04fUXBqGEdnUzBCPMpCeT4qXfi95OqzlSqqxMWsH88m8aqntTzGEgJR+D1Qh5PJE/VVf9f8ihMDTvlITa7yfvSIVP1lUCioiSss02YE7o0Twzo94M3HyC6nzDvPF5UBZ6uP+U5KXypuylc8ziMecJNOtbL2Ji3yPA+E4hYRM/FojaGztQ9M8jdYAYsQA1cCK1XF0UJN9IASzoTewsRHRNYd2KWAa5JAn7EnRgSV09TGjd+lc/feWqwzDA3LTibpsN93o+GiTRqP/Ci8MxeCnOuFjZAhPWuHIZlZdqSn1QSKMCMaTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXGX5/3lV8ls++zZ8s81a873PdqAXsZCi8zrTLpHNn8=;
 b=UytH6+ZlMF3FwS2/ib7d5186NeA3iqiaSbzZln+4s3DMJSoYkbiTH8OgXikAG6iTrUV7fOJMWQwrGI912QtvVknWYF0B8OKYnPDlGPBmstiXM4V2b8nW/1QEYQeTC3qLCuQ31QnmwfHJa9Pl8oHgN7zZuNoO3Ef0fQNz+BbkFEA=
Received: from AS4P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::17)
 by VI1PR01MB6384.eurprd01.prod.exchangelabs.com (2603:10a6:800:15e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 10:53:29 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5db:cafe::f3) by AS4P189CA0030.outlook.office365.com
 (2603:10a6:20b:5db::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Thu, 16 Nov 2023 10:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.19 via Frontend Transport; Thu, 16 Nov 2023 10:53:29 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Thu, 16 Nov 2023 11:53:27 +0100
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
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/2] dt-bindings: backlight: mp3309c: remove two required properties
Date:   Thu, 16 Nov 2023 11:53:18 +0100
Message-Id: <20231116105319.957600-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116105319.957600-1-f.suligoi@asem.it>
References: <20231116105319.957600-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Nov 2023 10:53:27.0512 (UTC) FILETIME=[2108CD80:01DA187B]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|VI1PR01MB6384:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2ed9ce19-98ac-4ab8-91c0-08dbe692448a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNEujeBblg5xvqNb8PW6EcI1AWyC5LMXig2cuiKnj5lx2fSyO7XDIFJJ0FVW4WVVqiDGpTV/57bEy7wLUIMdz+Q2ncwwxmtvzIvnyGJT1gDdSy2IsCm9CDlMsfgxkY75hy+PrVWUaxtTFynhos6+WtBENR4Oaon1vFfFZKvb81+nGb0NhhaQLdbfnTjbmjuUPzQlMgSRRBsLosBiWTRfSeuuauB9depm7/j0T9Z6vY6HfNzD4U94fodKgrK8HSCrC5wghgbeVcfmSUG8zZb41kqo2SVr9Ggyehh8UmGkA6VRLyGz0Mw8WzkdlNYCUT1NPENyTUulnGqTepNUWn++ZIN/cKA1jYQrOXQNWX5P1BQzvpRn9YVNbiH0gtT6K/7qH2BKEe6RgIW4nW5BaWLXz5ro9Sa7HWeImIDbuEDMb8eOmB2S/SiRu2LW1dYxcb/9XM+YndbvA3rDh1tRSYdxVKMpU/Tb6WyM66vvu3YhK81y5+6ztkAEnEzlRusf/9a4NCWl1Yutz6xuVTMgBfUFE9a/IfUb5XAEB5PFvBdjIqwxdxQUhiQ4f6l3S4JcNDyjueWmVBLbeJhz3BsQBZbnZY9x9LJDH9NgQTQrQt4eVD9qXtB4TKo2MDYRg83PExSVqmdX7XyRD73fuWiXKpye2QlrxF6FKvfBpiWuaRTzu3JGytxcRr0SXm2Y4AIqjaNQvwVhBu+TceSiexE5PsGtsK2s10YAT/3aZqgABTMaGrs=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39840400004)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(86362001)(70206006)(966005)(316002)(110136005)(54906003)(36756003)(70586007)(450100002)(8676002)(83380400001)(4326008)(8936002)(6666004)(336012)(2906002)(47076005)(26005)(1076003)(36860700001)(41300700001)(107886003)(2616005)(5660300002)(40480700001)(478600001)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 10:53:29.0727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed9ce19-98ac-4ab8-91c0-08dbe692448a
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR01MB6384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two properties:

- max-brightness
- default brightness

are not really required, so they can be removed from the "required"
section.
The "max-brightness" is no longer used in the current version
of the driver (it was used only in the first version).
The "default-brightness", if omitted in the DT, is managed by the
device driver, using a default value. This value depends on the dimming
mode used:

- for the "analog mode", via I2C commands, this value is fixed by
  hardware (=31)
- while in case of pwm mode the default used is the last value of the
  brightness-levels array.

Also the brightness-levels array is not required:

- in "analog mode", via I2C commands, the brightness-level array is
  fixed by hardware (0..31).;
- in pwm dimming mode, the driver uses a default array of 0..255 and
  the "default-brightness" is the last one, which is "255"

NOTE: there are no compatibility problems with the previous version,
      since the device driver has not yet been included in any kernel.
      Only this dt-binding yaml file is already included in the current
      v6.7.0-rc1 kernel version.
      No developer may have used it.

Other changes:

- improve the backlight working mode description, in the "description"
  section
- update the example, removing the "max-brightness" and introducing the
  "brightess-levels" property

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

v7:
 - add missed patch history
 - add missed "Acked-by" added in one of the previous version
v6:
 - check and resend for updated kernel 6.7.0-rc1 (nothing changed compared
   to the previous versions)
 - add this patch to the same patchset of the MP3309C device driver
   Note: the patch related to this file was previously a separate patch and
          sent in two versions (v1 and v2).
          It has now been included in this patchset, starting with the
          version v6.
v5...v3:
 - non-existing versions (the last was v2, the next is v6)
v2:
 - add more explanations in commit message, about the the non-existence of
   compatibility issues with the previous versions of the yaml file
v1:
 - first version

 .../bindings/leds/backlight/mps,mp3309c.yaml           | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
index 4191e33626f5..527a37368ed7 100644
--- a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
@@ -14,8 +14,8 @@ description: |
   programmable switching frequency to optimize efficiency.
   It supports two different dimming modes:
 
-  - analog mode, via I2C commands (default)
-  - PWM controlled mode.
+  - analog mode, via I2C commands, as default mode (32 dimming levels)
+  - PWM controlled mode (optional)
 
   The datasheet is available at:
   https://www.monolithicpower.com/en/mp3309c.html
@@ -50,8 +50,6 @@ properties:
 required:
   - compatible
   - reg
-  - max-brightness
-  - default-brightness
 
 unevaluatedProperties: false
 
@@ -66,8 +64,8 @@ examples:
             compatible = "mps,mp3309c";
             reg = <0x17>;
             pwms = <&pwm1 0 3333333 0>; /* 300 Hz --> (1/f) * 1*10^9 */
-            max-brightness = <100>;
-            default-brightness = <80>;
+            brightness-levels = <0 4 8 16 32 64 128 255>;
+            default-brightness = <6>;
             mps,overvoltage-protection-microvolt = <24000000>;
         };
     };
-- 
2.34.1

