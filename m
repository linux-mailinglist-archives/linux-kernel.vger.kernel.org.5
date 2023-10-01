Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C17B462C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjJAIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjJAIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:23:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD386D8;
        Sun,  1 Oct 2023 01:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaI6sOKIcqKzhLVVcUQCtXq1ZvzuTRUo8RmPz3bPi4bwRbvPy+rcfuqAom8JaN6eNcrOkoBiUhR+aQBA10L7ci7M1zLOvGYPRs8J/d/QGgUC/rJo5IQxjorek0KOF1NIMV/Xyd9fIfYMU6XIxuROxVvf9zRCt5wI+2dd/jCwBhrCBCL2wOAfmGETufRy0eBSB6ZY5wYAPTgwoaHSXIXEnSkfUi43iWOnRDYtKYtnp0XAfuWnBcgOVI3fN+FJ2I0Mv1G3hvwK4fK5kh0uTMvGZ9b2wly+jxU5ATchKy/RFAr4NjrOnjQaZ88Qm3RJWCPuWn0ml9fFG/iYO7opKPxQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28jPXzv6dUyo0xSYsJVGYd3iGRtKKN7Lz8CKd7fIDQ0=;
 b=TUF6FrgTXfVJVP8pHBMuH3c0AqbSA4qZ3Gp8VosOqwCDebX0gqmsYeE7EjiMf9bPpsHc3Hu1cTnKp+eH2GA2SEI/4nOexVwX1AOF5PHvQwZf1gxA4Q/qdwmUNtbxsyb+HCFQYA9pMB8jHXI4v/eSBeA4voYIH9gtElsEgq75Ut3sSHKhoDAebH20hwvEqSbTEdZOdhFRglGGUTjUu9m5SWuVLHBLVeIpAeq/aylcHDfor4Pah52Iak4CHTuDGmMco95R+43Z9RHl4k3v4Y9f0Be1JO71w1uIrZeEWxDF4iHNf3Ln0iOGWtrEWA5fMtQhXmblIKundYP4Od4yKtp72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28jPXzv6dUyo0xSYsJVGYd3iGRtKKN7Lz8CKd7fIDQ0=;
 b=T+7TIh0ltvZj1nIlGGwj3itrdR/WOczEhaa0ydBqAjSqvWdewwe0UIgtRdvMfmFHVSO5gSlIfrEgoHCYGcFRQeG1Jvsro4UhWzq7/zx0vD+w+TjYiZnY7Z/H7TO7M05xuGG355CBt31cWyGGHogj7IJ6RBZXPBEdXgupy1ZlTRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 08:23:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 08:23:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 01 Oct 2023 16:27:53 +0800
Subject: [PATCH v5 2/7] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-vf610-gpio-v5-2-8d873a8f224a@nxp.com>
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
In-Reply-To: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
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
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696148883; l=2577;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=2G5DMJkzLlHXSAmcU3iHyFirqvadU3w5xYuX/5C/fWU=;
 b=kg0UiW+lEjhGSCSrRi/sDz8hpHbhy0AS02ccUUztrUlDUjEcyRZp5Ln9XcqwgMPEOz5OuP9Bw
 cJB+7kzV9uQA2GxDTqTwgu7AoURoOO4afitb0CzLqyD1p89OMuwXF0v
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: b97e40c7-647d-4b4e-ddcf-08dbc257b075
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wvCicGRWF7f08XkH2AmDzKpGt6ofDroVjsVXobibJIFMDyUaY4AojXYkd1uTOSllCQDM+TgEYcqsa9S30SFvSotVXkuJfuCBIKgbKSR22pfnVMrWmfC0O+WHEYLefeZIxfRk/ijJuODZAg4ZH1UM0hSIAepvDrs7tmj8JkXigvCLfBojal2ak2YvlWhKu3pzJcUKsaBPmOEYKFyCUuor8s0LNdW+84slDmtbLFFvzWHaKVrn/1XR1AUx1aIB/pNXpvoajBEjdxdsxI+KPLuwOn+ezjFsnd+SgcfAK+k2TjNQM5spTH3Ofa4Qvu9HMVATEJjc85FobSdGKlU9/KPxqNf8KKEAUSXnX3yoG3/9pFDcL5btOfoVnCRzDZ2BZcCmIriaySIzBEhLHNQ3+MJparnDd2YIiBu/JzzvInDaTH7dTN/r0hObwMLQN74cT7iKLuIN9bhfbZLySz44iZA0FyVJ59rCo4NCGlABmstSWsc8AHCAjIb2W8b1gkmxMnHug6q3PnWOqZE80DZrmaRfU4OBzPjzNqZpTp21jbXNYa17QAN4C0XLFHAhJ11FSQMn/THfNrO+G8eegxi2grmx0Nnj2nStjQ6k0LSmaV4IfTBO8ZQQBI2eDLsXDQJh1V5bCG6f3bFvpQtRS5dObqdUWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(41300700001)(316002)(26005)(2906002)(110136005)(7416002)(8676002)(5660300002)(66556008)(66476007)(66946007)(8936002)(4326008)(478600001)(54906003)(6666004)(6486002)(52116002)(6506007)(9686003)(6512007)(36756003)(86362001)(83380400001)(38100700002)(38350700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWlVellqT3RYNlNnOTYzVWRpczFleTFoc2hHcnp6MjF5U0xuU3IrcjdXNktM?=
 =?utf-8?B?ak1ZckpIL1ZRK0tNaFc5Wm9NVzVuOGtpMkNiN3QvQkpBekZGWVVtbGdXajdi?=
 =?utf-8?B?UHdwTjVWTnlxT2hUazNCazg4LzNWY1ZpRDBhNE5SSkJTbHVGWlpMRkxOQ1NW?=
 =?utf-8?B?b29HelgzNkpsOFkzVEpsZGJMTnZ0Skt5d24zUmhqMlVFY0tsWXMwZ3orZUlm?=
 =?utf-8?B?cCtudGVjcVhSVk9qY0o3NGlYcnlTWnJBUzN3Vjc3b1RRR2Nkc25HNmpRZ2xV?=
 =?utf-8?B?eitHZzZ5cVZnTjBvMU91RzZ6eUZ3WXB6TTdST2FsL1RGaVVLR2VUa1hXdGZU?=
 =?utf-8?B?MWZVUWM1cHBtV1RISzFoTGY3cVkwaTRCT2xmR1JhUkEzN3U3cFBTVzFESjZl?=
 =?utf-8?B?d2h1ckNCNVRwTEJzWHo5cWhTV3hDQWhPWUp2NUFNQSt0NHpIVkhCTUNqWVVt?=
 =?utf-8?B?Q3NUUElqYW5Ga0FGWVdSR2RDYnIxRU42bU1hQWdEdWJteUdlS0hnVVdZaGVr?=
 =?utf-8?B?eUJ1SXFSeit2a0VsT05PUCtVN3hsTmZUUTNUY21SOENuV1dEcHp0cEFsMjNF?=
 =?utf-8?B?dHROMnJETVdEZ21zcjBuZW1ScTN3VTBOdXlwTzVZLzNBQm9PcGhGeXFnWlRm?=
 =?utf-8?B?MFIwZWtJaUpKYWc5ajhGTWpndUdMcEdubW9Fb0J2RnE2dW1lL0xDMlhQRjI2?=
 =?utf-8?B?aUlhYTdIZFRmVjdKMUV2ajEzNGVxWVJ5aWJSZXJtS1l0Y2VlSUNRNXRIeDhk?=
 =?utf-8?B?ZVAyMlBOVkhuZERxL3U1WjB4Qm96Q1N6SHMwZTRKcUt5YVhhUDhYd1M5Rmd4?=
 =?utf-8?B?OU92MSs4akxBc0xwYk1BWFlESkNwK2YxWms1d3hDR2dzZmpKaXByZXhUeFEw?=
 =?utf-8?B?bkRsOTdPdlAyMS9Sbk9jVE00UGRDNW5IZ1RsM0UxVVVTMFVKYTcvVUt1SGYw?=
 =?utf-8?B?ZTlQbWNJU2NZNitYVk41Y05mNENmb1FOd0IvNDJDZ3lsSlYzRUJxS0hGYzFw?=
 =?utf-8?B?S0lLb0pDQXA3UzBvMjl6UVZxVVJqVmFxb1dQbFZ4S2xOWUZLTGp6dWZidkYy?=
 =?utf-8?B?SUMwNzkwVUVaWTVDbGhKMjZzcEpKUTQxQnpNRm9pNGRXRDAxUXlDVmZ6Z2x2?=
 =?utf-8?B?S1NwMndGTXdRVnpBdHhUZTEyUkFQbWt2QWgxRlM5OUJ0bHRzTUhjNzloVysr?=
 =?utf-8?B?TFUwNVZCYXpjQUZTRlIzcUFMTWpHREFZSWhoQnQ1VG9RdTZoNkxkWDhGc1J1?=
 =?utf-8?B?ZlpJcmM5d1MxR2ZBL1BVTk5ZakJYcndkZUU5LzJLdzFwQzNYMVF4eFFmMFF5?=
 =?utf-8?B?OGJYc0FMTG56RVNBandRNDBCYUxVL01GaFpJcHM0Z0FieEdjMGI3YjFVNzJp?=
 =?utf-8?B?aTNjT3lMbDZjYlpPZDJsc0FzNm5WZlJlSlhNNUpXaFRQQXRqNmVWYkJmUkd6?=
 =?utf-8?B?MDN0M2drak9NNXdiRnFvblNpcElXQ3NwTGszcjlRQWhXM2J6Q2x0MGprU1Vm?=
 =?utf-8?B?bmpiVGJTV3oxVzZOY2M2ZHhhRkplT0VFQkhYS25WOFpUUTBETTc4amNydkNL?=
 =?utf-8?B?TldmSkFqSTBaZ2JpQ3VmQkVmRE9kemhKZlNWWXZhNWplR0pVZW5GbTNWT0hM?=
 =?utf-8?B?b21IMlgvYUZTZHJtaVMxL0xMY1BLMkg2S084VWhrdFNMSzduRVM5cGNxV1gr?=
 =?utf-8?B?dzB5VUNIYjZneU1ZaWRONUxOV3pkV1J6ZzJhSnNDR3RhZVpQMW1Sc0FkYzhw?=
 =?utf-8?B?K2FZenJWL1YvRlRNMENjVEIxb3VvdEMwUUxES1NNNS9aVU0zc2VGcUNzeGht?=
 =?utf-8?B?cXNpazNGT2xEMTNhSkhiZTJwSFhQK1ZyaGdWVHVtUWJTQ2EyV3M4c1p4eXYx?=
 =?utf-8?B?Sy9EVEFtYlNFRVJyTGU2eUhlUjlqSGpHR0NMK0ZyQ29xa1dzN0ttSXNka1pk?=
 =?utf-8?B?Rlp3M3JlWDI0aXlZSGlUbWJjV2NHN1RKVnJsVEtSUUhTSW5WK3RIT051Ukl3?=
 =?utf-8?B?dTMzaDk4UGFqaUZXUDAyNjBUWXhaelhjVUNGWEE0WE1BREJPejVPeUtyQTBp?=
 =?utf-8?B?dmdiOElZcVFOSGgwR0JWd216eHFlcndHa2ViZkx6ZzNJTysxR1RFbzF6cE9n?=
 =?utf-8?Q?tWGLWybpCQjnALmUzzM6yrxx1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97e40c7-647d-4b4e-ddcf-08dbc257b075
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:23:28.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y4inoFb5FValuZy0sZSkpaQTiBFA/Wu4Akd+ER3q2rbG0gw/o2FT5SbC8zsIs6zdK0a034cRR6uTDxbm0ymHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7417
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Reviewed-by: Rob Herring <robh@kernel.org>
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

