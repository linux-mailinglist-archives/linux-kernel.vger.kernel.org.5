Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3557AE420
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjIZD3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjIZD3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:29:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C496D9;
        Mon, 25 Sep 2023 20:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHsBYBPXnYOqeFAxHg3Plztory2FpikWip+pi6Gx1d3qbXu52eGsmXZJp02Rz4WG1U7yHiKF50j4y8C7wvXc0Ovrh+c3t+QQx8vn3kXr8DXWS5W3m4nXqoLd0wfBX1UWuixomukcq86vh+rZXCADkV0NYryFdYxSrWMDmDKeQd0X7tcM7lYOLX6RWRQ6TUhHGntt55VcJeYs44VmSVjc5Hq/H8s6WOzKYT0x6hqj1QiqWmc8yHUch4yjMyPCW1efiOXLfQ0uleIC7xKmqpxKFY6id7yfAuOUaJl5l6fFu1Oml2+aXbDtAOaQlzThwj/CTRe2jBdBbmt0shXruRNUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iooyrluRxDVjQuFNC/Tj7Kvrta68Xomy5qNtRjr9KAM=;
 b=b18VWQZTIJ6Y9a3lBCxPk14ylIZlwRWVZ3uBGkQXHlclciqSXWkyLMQ0pybIxrnc2nMORX4SvQdiVl+nmHy9h1ThF4t27whdwUiJrOYeXfvIZhwj9a3EtyXGpgLYr1knsRDbU5HPzaKUmdjjisGhEdEN61pdBQdBk+HIg6VcdNGTpQzfptUBC2rca0YSeiYAn5h30cKrwowooj34DnacE7D+FKakpuId66mGGA+A9+0OITHNDZbvFM1Hhf7S5vk9FAr6AwVoy1CgA9HDixIhH2bcX32aT9DjN0U79+2TeUfmIXyVwtkvthuEKmB0HKo8Cn2TJxRS0tLwaR8p7i8h4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iooyrluRxDVjQuFNC/Tj7Kvrta68Xomy5qNtRjr9KAM=;
 b=lFxzayxUttsPuvkNOq6mSgLXcT6AwQaLCAFCJ5smMh6LYf+/1tAMca+D0Ir+uZzeDQjEzV/SYxtgxyAiX3SOcqt2cEWxpBvezDb0RUT33IfBNKjV7wJfnwq7NjpEm/1kpjc7HuWvp0pZocrSu+7CIGFAjcyuWj1u5x3iVVWuwks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 03:28:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 03:28:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 26 Sep 2023 11:33:18 +0800
Subject: [PATCH v4 2/7] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-vf610-gpio-v4-2-b57b7f6e8368@nxp.com>
References: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
In-Reply-To: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695699209; l=2533;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NcuQgKZ9VjEAm4CbrSNdX7G24Z9K7oP6QDSwjwWVyeg=;
 b=Ji+O/diOm9uZpTiC3m2J6yzCTfJ9UyLRfrZCQxqY1v5BLuebn2IoDATJVK9y1cK6OCVOfNkcN
 blhwkiypM7FC2C/ODnc3DeRZ/mSGfdsUlzgiPtQsCFosI0UXoM2XtTO
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ac91f5-460c-4ee4-08bb-08dbbe40b62c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wu1HKJZ7PGG3V9HuB9vgYd/HLULWP5zzcWa7gKHlVPPYyyF5Nc1ac0TfsHzRi8RmsxYzrIK3gZOv5o9lTqkt2e5cJW11hD6toR5+msEXhGa8gbePNyhlYKcuZtT1AIJ59o74KUHT5F1t/T49OfvGsMofaIIdgWCyUHjSx6UhzkQ9IDGNoYIoeYH52YtJFmFbwST23jAg7twm1tfX3f8ef5pojGc7lB6i5KckPKodamLR32jrpp4XY4/m3T9vC7/GQGcJtQZvkqaFNf+cg7kOlxUnmoF/jH23JZK2g4ZnWBRraXuTbSBEc400P3ICTETWarZQlFqbnsbhELHtoTjAI6cpcANSUmtAhg7RaF3PZWKfUnUZcH49UdJeNDVNBHMjuWlSZBY4VJR9n7z6Q5/A/KTUtDSm2zuMv5NPPKN1QFkbtZ4l9YjePHUEblp3EBagr3KSuDRvLbcbNkfPZXkftPYnLbCUGSlNGP/tJxSy9IvloVP7EKJndpwKWG2Uq6TGXsrs/saSwmB/Rs7D2LAqF1SDsUPlTeihBJBUg1J3Cztvzi5Q8aD+t7TJi4yQK1K5BFl+3IyNpWSv3QLeMBE6HAW++1O9lNZGkBKD+4wZ+KZ5rk8Pr1LxGKAJb4lVs9nPlJRt5crXYllJAbXLmDF5bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(8936002)(4326008)(8676002)(7416002)(66476007)(66946007)(66556008)(316002)(26005)(110136005)(86362001)(2906002)(921005)(6486002)(478600001)(38350700002)(83380400001)(36756003)(52116002)(38100700002)(6666004)(6512007)(9686003)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bit1L0FvNUc0UU1oRVN3SDJqTTM1eXhHMnpsZGJqMDJCWDlzUnVuN3ovUU1l?=
 =?utf-8?B?MDMzQzRwWjBkY0tiMHdJRjZmaXcvQVVHNVB3U01kUnZHaHRRNERLTkh0VjBx?=
 =?utf-8?B?dW8xYnlyMnp1MC9ZN0pXMWNXNXRpekIvN2FSbnRaMGwzR0FvQ2JqOU5WVG9R?=
 =?utf-8?B?b1NmSXpLUlRhdkxzSWVhcXZyNlVHTk5OdjFFZ0YxelZzLytIaG5DU2pCc25H?=
 =?utf-8?B?QjhGUUx2TEZ0NnErejkzT3pDK3dqYkFXV0xiVFRvUXdzb1AwekR4cDN5RjZX?=
 =?utf-8?B?dUJ5SUdkNG9waHh0NjBLZTJjNVVoSkhwcEZWRjJFZ2twRGdXRVJDQnBpZ3Zk?=
 =?utf-8?B?eFBWaTBya1JCYndkZ2VwR0V5VkRmcnBqSzFVdDBxN0dYU1kzdklyZmhUM1lB?=
 =?utf-8?B?ckNSZXFCY0RuSXdEMkxtTHQ5T0pDZlNkdXA2QUJlazRqNTFWVEFFTzRnVC81?=
 =?utf-8?B?N1llWkVxS240SGh2c2htamRNdythMTZlaTV1SHhZakl3ZVpzbTdqN1NFSVFJ?=
 =?utf-8?B?NHJGRUdlKzIyZmZRTCtEQUUrOXZibEFMRTVwTE00RkNPUUJ5empsNzVYUzVN?=
 =?utf-8?B?ZnJQQzYvaEZrbDZESDlxSjRtczRKMmtseUgxeElpallnQjYzTVB1cVpzMW5Y?=
 =?utf-8?B?TFpsOTlJTHNtQ3A5S0FLVEdvNTU0MXJqd3hjMm1SZmtuaTAycEw0dzR4bkNa?=
 =?utf-8?B?T0ZxSEswT09uU2hTZ0JlV2RIalNsMjg1RVJMNkNUdCt2czJvMDFUL0tuOEUv?=
 =?utf-8?B?MEJtRnVDTTR1OXZRLzRtMCtiYjhQV0NaWVdTR3JDSTdOajJINkVJWjhLcGhG?=
 =?utf-8?B?WVRDVWg5TmM2UlNibHp6WmJNQVJWZkhPLzlRVU1BVUFYd2VuY3N5eTMxL2Jy?=
 =?utf-8?B?VG9yTW5QOTI1aEhOSjdsUEYrV3lUaDVCTS9Rcy9MTzB5WG5LbFlHcG85UDZ2?=
 =?utf-8?B?bEpWL0ZnQVBGbzdmRFJOQjlpa3ZlOUNyVTZhQ2FnWmRoWjlKcXlDZzFyNFpu?=
 =?utf-8?B?RFBlaDcyRVJKYXRuMUVXdjBTQlNpQTkzTS85NlBCa1RWcG9mMUx1VWk3bmhs?=
 =?utf-8?B?Y1ZjK1lqQkZHZkd6eWtLcTNLYnlsSDRSNllvN0NFOWljZ2xpOUUyMW1rUHdq?=
 =?utf-8?B?UEFGUStPS3R0WnNqalBCK3ZqN3NkT1hFU3dNbjZrSEQ2NkEvSVU2M3kyRU9F?=
 =?utf-8?B?RW5xUUdiSUcxREdKLzF3R2N0U2wrc2p0RTdCQUFmbExsdURtOFF6TzF6N2sz?=
 =?utf-8?B?Uy95SDVBRER5OHV2N2FIdEc2Vkl6SHN0eVZPVERnZGwrZGt3VUIzVHViNE5Z?=
 =?utf-8?B?WDEydTZjVUgrOWlMVEF3VytPTFNPTytlL1JaTUtyNW1XRW9Ga3RzaXZVVGhi?=
 =?utf-8?B?STRTc0gyUUVuZXM1RnVqUjBPdFJwUkdaRTYxTWRHdHRrcnVwVlhpcGw5U1JM?=
 =?utf-8?B?d01yaWlTRUp4OE5taEZKdkJRUzNZc293MUlrNHlvbkd4bjlVVDV0aUNCNXA4?=
 =?utf-8?B?M1VNeWlTb09VQk9Fa1UrdjFUVEd4d0JUMHZ6OWkzUE9Bc2ZQTncvbnJNU1Zh?=
 =?utf-8?B?TFBPMDFFZWRiK25HVHBreDNWZVQ1Y054T3Ruc0wzY1NSMjc4NFZYSW94WEFZ?=
 =?utf-8?B?dGQzSGtyU2ZmTytiRGVRUC9xcmVFOHc5Z1V2SzZZWkR2c01kUEJpcWRnUGdW?=
 =?utf-8?B?RXU2UXg5VXZEZ2tFRk9obm5MVjI4dDhxWnJoQXVTaHpzbEhpaWFzUGZLenV5?=
 =?utf-8?B?QWNYcXU5RHpBVVhjZlFqZ00xQVlnaFNzWTBiL254akdNQVJZclFuTzhpVkJK?=
 =?utf-8?B?dnZ0dDM5MTZ1dnBWTXZLUi9ZMEd3OFg0dlFvb3NmdCtyeHVmUjZ6cVd4VFFJ?=
 =?utf-8?B?VFV4Y0Z3YURmVkoxL3pPK2VrcmlDRUF3NUI3bjIvbWNRSDFSYk1uYWU5R1NI?=
 =?utf-8?B?eDJkaElaRUhLd2hyMytxcUJCRm9VTGV6YisyY0Z1U21DcFFmeTFxZk83Z3I1?=
 =?utf-8?B?dk9DMDBLOE9lWVhSc3gzZnNXN1VQK3VWTWI5cjNqbHZOTnZYVkhRKzdmL2V1?=
 =?utf-8?B?M0dyelZVbzk0UG5ZOC90NWFNMUowbTZrZGcxUCtwYUhZUThnV3k5ckRoM05L?=
 =?utf-8?Q?gd1KfBOAL6dpXA3RPU24yLVCP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ac91f5-460c-4ee4-08bb-08dbbe40b62c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 03:28:54.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFsSW7nXnMLh10SlFszvmMakPhaiivpusgNqlXHPDwsZMjMRyMY9LYBZ1ob3KAnY4nGQI58HIer49F5RYDgr4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP and i.MX93 actually has two interrupts for each gpio
controller, one for Trustzone non-secure world, one for secure world.

And they has one register based, not two as i.MX7ULP or VF610.

Although the Linux Kernel driver gpio-vf610.c could work with
fsl,imx7ulp-gpio compatible, it is based on some tricks did in
device tree with some offset added to base address.

So actually i.MX8ULP/i.MX93 is not compatible with i.MX7ULP.

Last, i.MX93 is directly derived from i.MX8ULP, so make i.MX93 GPIO
compatible with i.MX8ULP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/gpio/gpio-vf610.yaml       | 36 +++++++++++++++++++---
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index 59427d97adf5..21199bf221ef 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -20,6 +20,7 @@ description: |
 properties:
   compatible:
     oneOf:
+      - const: fsl,imx8ulp-gpio
       - const: fsl,vf610-gpio
       - items:
           - const: fsl,imx7ulp-gpio
@@ -27,16 +28,17 @@ properties:
       - items:
           - enum:
               - fsl,imx93-gpio
-              - fsl,imx8ulp-gpio
-          - const: fsl,imx7ulp-gpio
+          - const: fsl,imx8ulp-gpio
 
   reg:
-    description: The first reg tuple represents the PORT module, the second tuple
-      represents the GPIO module.
+    minItems: 1
     maxItems: 2
 
   interrupts:
-    maxItems: 1
+    items:
+      - description: GPIO Trustzone non-secure interrupt number
+      - description: GPIO Trustzone secure interrupt number
+    minItems: 1
 
   interrupt-controller: true
 
@@ -78,6 +80,30 @@ required:
   - "#gpio-cells"
   - gpio-controller
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,vf610-gpio
+              - fsl,imx7ulp-gpio
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+        reg:
+          items:
+            - description: PORT register base address
+            - description: GPIO register base address
+    else:
+      properties:
+        interrupts:
+          minItems: 2
+        reg:
+          items:
+            - description: GPIO register base address
+
 additionalProperties: false
 
 examples:

-- 
2.37.1

