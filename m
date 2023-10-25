Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6CC7D7141
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbjJYPvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343793AbjJYPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:51:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E36181;
        Wed, 25 Oct 2023 08:51:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/G+qUC26zlq6J02PywNHWr1V4UdY/B6m1VzOzde9qj4cmNA6Oj3m8Hf3ohuZjn5SqjmoN2CmSRZGb5l8IlxfBq97f4sic4HSL9LKQHQIT13kkPP4w3L6Inpk1LzlrBt7qEHcFV89qqgXhrBJYY5LlelAwdSSBFC+QeW+1JZpfjMBd7XFzDoEATr/1DQvAv2/rqjEs7K8dGLJhwuFdcsf2rv0OXqL7f/TQhM9xIrjW7jxa7PTqS+8jKC319NEXD1B4uD5hPMPx9UyZH5l2dQnRPr8WhdwVkLdsvtXUyWN8RSiXmZ8KQdGmMu+SZ5m17TfU1icDPptZaY7dizmvqCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSp4jKkSMfpcjolSYpdKkatFmnOUaRkI76ONWOefzII=;
 b=iKRHrQ7S7eInGJ8X/yQKJqszHIr+pMN3xcD9uKKcXw7fMS17sSOxeJUXi61Y8SfdxS57YVO77AHUC3hC5qBX6ATmcxbi+hT1LAZFwObg5rKVtRUn7nEWmQQKhe6NP0y6IbYfcuI1lZbc4NIq/NkAE1iIuZxD4IBGzd7Ox5VHpvnv9Pa0g4ySTc7w87u1yfOSY7XRPyrKUD+MYtqAA7/ik6vO2vHwzFAHv+eiwEvLjE3D7eAulLzPpJmoHCEmzcUBrpGrWu3YZ9ohJ+EYzemJRZMqXLlSTiF/+s0WvHbKVFiGPxo6bQ1i7XO1MVEasEB1hQN7UHWqMl6GH5d1uuP9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSp4jKkSMfpcjolSYpdKkatFmnOUaRkI76ONWOefzII=;
 b=Ukg4he58bSqakZEmB6NAZSEKWRE85AjCmMVQKiCwNlyvAkEVhuY20kc6IwaA8kz7TCF3IO2l1fT3H7xaoNNGwfO7huC0b+/r1GIraGR269U3QYf++/FHrqDq78U6lFT26s4E66iCJDL/XmSudnPULg8hRkojO5WUqssN1MBMhf0=
Received: from AM6P195CA0018.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::31)
 by AM8PR01MB8004.eurprd01.prod.exchangelabs.com (2603:10a6:20b:322::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 15:51:07 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:209:81:cafe::6f) by AM6P195CA0018.outlook.office365.com
 (2603:10a6:209:81::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 15:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 15:51:06 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Wed, 25 Oct 2023 17:51:04 +0200
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
Subject: [PATCH v2 1/1] dt-bindings: backlight: mp3309c: remove two required properties
Date:   Wed, 25 Oct 2023 17:50:57 +0200
Message-Id: <20231025155057.886823-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025155057.886823-1-f.suligoi@asem.it>
References: <20231025155057.886823-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 25 Oct 2023 15:51:04.0528 (UTC) FILETIME=[0F8EB500:01DA075B]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|AM8PR01MB8004:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d185f5c7-cffc-482e-a811-08dbd5723391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7fTf7EI5F6+sdKKe1/B+OPLFr7x2fas9O5Nk0lAIqhJtjfKHp2mfbDJEqmcbJWWg4AdRmXXsKJ2i6Cbn+slpNfM+LIv73F6hC/JhJfVHmajTL76eOzNd9Kl9Q8JROHVCdLQZxJwVrh1CsolIYpVEPnJgh+ibyFHE69xq+5MQta95TIVQrMwCAICnrRIlUjnPgbvboFSoZqnMQvlWQ7Mpcl/o4WzIWenuXM+a+FP4DH7jXYFu/s4TzMNFaCT9Gj/k+vc1LbRIPDWncT1OzjX9jNpn1x7071ktAWdqrh+EXOeFhH9wYBixDpqVdfFqYAAShzKlIHIXx2QJ/TWQJiAzs+szG1TWspuKPUFVBJH9WLXSK8JG9q9nQ00sO7t5xfqlaxUWwPvYbBnxubW9Z23FNT0XJAqZ5P1jfckU7LzZTpyBjf6kfcmViAagJWUjYtbxPn3Xn1VliTlvdoKgyPhGSwZpjJJAmV2gd77gL2UUc0tFXAOQDmY/arr87c336Y4cXm45sbfuJ0eTe7UyaSpavVyR34z7Aa9PXlUgPH5cIsRYIAam/6S9GUx/1QMyI1KcyHvLvnmhal4cQz/Q6eAZJ8fQGyKMSeLweTbggob5wzhTO/8eYqByGv2UFmS/MsIwn0wLa9jj4ZPwUAz1aqAAKRvdHkTbkT/YEB4m3L2bhGNrf53nelIluB0ed2T2TOwPlsRdXJclboZf7ip6/Tfoo+bvliDtyHa6MWFMExRhlA=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(376002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(82310400011)(46966006)(36840700001)(8676002)(40480700001)(450100002)(4326008)(8936002)(86362001)(6666004)(26005)(70206006)(70586007)(316002)(107886003)(1076003)(356005)(36756003)(110136005)(966005)(478600001)(47076005)(36860700001)(81166007)(336012)(82740400003)(83380400001)(2616005)(5660300002)(2906002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:51:06.9354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d185f5c7-cffc-482e-a811-08dbd5723391
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR01MB8004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
      Only this dt-binding yaml file is already included in the
      "for-backlight-next" branch of the "backlight" kernel repository.
      No developer may have used it.

Other changes:

- improve the backlight working mode description, in the "description"
  section
- update the example, removing the "max-brightness" and introducing the
  "brightess-levels" property

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
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

