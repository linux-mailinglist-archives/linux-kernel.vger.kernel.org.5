Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D0A7A2D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbjIPCAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjIPB7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:59:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72CB189;
        Fri, 15 Sep 2023 18:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIOnlD14ZFK4kegTAx6zAqRUiuOX8892gMu2wZEE/uup/D9bIoIQSxsSlVvVWIVsmg7jO5nvl/KoZnot57LOMaHJtWThBjAhoKyBFjO3Hq62Dtbv22+9/eYeiqjmlvg3HPlt+OyMYix/Q1ESyWYA9OXEkW6bT6k8brjaI1dD4uZbYsLlBPLrMp+++bgdVh3YNbqObavNoaER5tWKK8GLRAjeElzdr6DUEQZa6suUEkn/LaPuEIQnRNEDpQDDcYmxocSUNkrQuwq55x3ddIAxC5TBPQ9AfjGoPK/SvYyCWZtc0iAMYCG4tAVfPfjawkaSTO/eHhUEAeNRUXngTwVqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmHYrHs5iCRDyTsOifNno2hhwB84PFpVes/JVIp6qrI=;
 b=M+Fd9uJFJVlw7NbEFm7KA5GOBJg2AVMs84vMHfN4nT/pzOov/cQaL8+pbt71VGBm4ATTCB4btFwwLilhKjrPKifLDjxtO+BuyJyR/BJZrBmHJgqHOCYtIV8Wo3wrqHipoS6JaNtgQkcV8KBWB9fDM/1lG7GLGNoo7oZBvMflqT6blbPi3mzUtSioQNyP66o63CA9hRsm6yAF+ipKQ6bed8brikTuc6+oFXFhjJXk6RM7AV2AvEkRVjbrS8h357YBUfzl6D4lijo4SL6R49lsDqVxCwsa2xJdFtLS8ATYxX854fLGCG1FLFclE0jkBpb/iT/LkyPxBoYRBU4oRmE6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmHYrHs5iCRDyTsOifNno2hhwB84PFpVes/JVIp6qrI=;
 b=MNgHHntjuaMduVYOBnpEvJXYIfXj983UholnGaiRX8qkPubEnaB+FJH4E5szISoKKOpek5eA/h59PGKfZsFwo8/O9mpis9qW4vHzXixc3mn57vWxNUk9CdF2wvC0TMy2qdlubN+S+lAdsFQIhTZ2xS0RrdRTkyPr+ZchWUmC620=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 01:59:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.023; Sat, 16 Sep 2023
 01:59:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sat, 16 Sep 2023 10:03:58 +0800
Subject: [PATCH v2 2/6] dt-bindings: gpio: vf610: correct i.MX8ULP and
 i.MX93
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-vf610-gpio-v2-2-40823da788d7@nxp.com>
References: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
In-Reply-To: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
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
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694829858; l=2827;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=UoeweoP4E6/hplm45jahX9OZJSkM06KJeabRlNSyjXY=;
 b=JtmsVE6ldKrSecMWqQ3FZTerJRlUG+rrOVh1f5CoO1qZrqpU0ZxJYeMykqeTSzHRLk1g6EBlX
 kIBGw+zwdJlBGzaKb+4kXgivq9Fg38tzeaC6696fmIqgFxsuIK7Igse
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: ddda650e-092a-4227-58f2-08dbb6589672
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMi2U8+j8zon57PGEbKulB6D4O4y4psx9cY4RchEKx9/0KKLYslYxl95LQBqB3arl1DiJVY3hDOVYKkkTr0DO2D+prjnNh2m+mzLJWzsDaTZBEkHjZxQu574rmNUrFd5Qp0I+pTT4bZ4CruTTkqoJirNfCTEg/rbmNe4+jcfmB3zYvvbggcXfw2F9vMMflqXC12nUT/Shccg4sCM2P/BO9cTQVIjAavrihm7kEWn9p9N6Hy0y5NDC3QUrT+rvSt8Px7gIv7w4eY6azRqsB1nhGzeb3QR8PKX2QcOdrLen/xILGdH6WDkEjXKBah1IaiXh0G8NJjV0ID4ZShW6LmKngpYo5P0MGAoh5/J06q8+pIpjJW899DKgrW2pdB9015sLkEHWDj+zbBQkViwm9cgtZ2xmZA0Nm/5OJgj4qKn+XCc+touYk4ZLXtXFsHGTW15OAf/JYPxHAb9T/C8BLpe1/XNZLHn6Mem7oFwaL3dRzwFELVhDLPbwrlimAD7tBC0kz1T0wIWLyyfMPE1gKRcLbjI/lvcxV+kH8cVsh0D719v943eIb5rJYsVh30SahbG93DfunjaddPMXCc3DY4CFAKi193tMkTpJ3PjEa3ZfI6fXQkcjkyQjBbv+nKbydDGNwJ10/MnauULy74obz0Dfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199024)(186009)(1800799009)(6666004)(6512007)(6506007)(6486002)(5660300002)(66476007)(66556008)(66946007)(110136005)(316002)(26005)(52116002)(9686003)(41300700001)(921005)(8936002)(8676002)(4326008)(478600001)(83380400001)(2906002)(86362001)(7416002)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3hRN1oxYnE3cFNzdVo4bDZaTkdsVjRaWXFMeGt3THphZEpVcDluMXExT29Z?=
 =?utf-8?B?S0xXS1BONS9YMk83YTNwMDJWUnRPa1pYMkRJK3B4SGJTQzUwSkVxbmgvV2lv?=
 =?utf-8?B?QWhqQVJkOTZjaWtrK1dvRUMxbnZzNW15UnNzbk5qdklsSkpOT01ic3Nsb1Vz?=
 =?utf-8?B?M0JJdEJodFFNb3MrUGdGTzc0SnhjOEY1SXAxVzdHSCt1QnRSa1VIanV4dEcw?=
 =?utf-8?B?RC9nNXp2NnJMUVZnZWhwNEpGWWZCRG0remdPM3p4NDFycGF4ekZnMnpqQysr?=
 =?utf-8?B?R240akdZazZuSkpURi85ZVMrR1VBZVJLK1A4Snk1TmRYQ3kyMlZMOWtKVHNm?=
 =?utf-8?B?M0hPRVNQc2d4aGVLVmdUbGltUTI1ajB2MHNqaGpJRWRCWEgycTB4UVJSdEtH?=
 =?utf-8?B?UFNYdHdpTTA5bWF2cGRBUGg4L2pvWTVYSWYvZmNXZmYzQkQzeWNJSTBuaGsy?=
 =?utf-8?B?YTFYUy9MZUhQMzhpV1hHbDhhaUZjTmVzME9IM3RmMStxS2dVN2t3SjlhdEdG?=
 =?utf-8?B?enlVRjc4My9laDhsSFVHNWVrZThmQVg0WDBCcS81QmNQUFlqSHdjZ0Q3aU1F?=
 =?utf-8?B?VlVSK1Byc1diY3piQVdjK2VqdllnVStKV04yRFlISGVpODcxb054bDBTTC9j?=
 =?utf-8?B?NFEzWkNGYXFaR3JzQjBxWWYxaGtlVDJZbVcwWmEvdkFFNWhpRmgyZk1nVzhR?=
 =?utf-8?B?Ly9xc1hhaHdFUEJqMTVQekdIckFoa2hyVHhsSi8za0NHS3dJMVdHTTBIUmV3?=
 =?utf-8?B?WjZTd3pnQ2VzcFgxSkVPS1dDQXMzM3hvRUZTYmVMMTVRYU5Sa09oay9PU2pa?=
 =?utf-8?B?RE51bVF4WG1UM3l0QUlKOWludkhNTlByakkxaUxWN0dKZVJlUWNBU014aE9M?=
 =?utf-8?B?dEhzemdhbTBRdmZ3VmVFdUl6TUdmVm1sZWdaemUxbE1tTXNka3NNNkcrK1d2?=
 =?utf-8?B?S0h3anV2RkYyaFNISnBiRy93Ni90YlIyblArY0FveXluRmZ2SDNBWmFzZ2ZJ?=
 =?utf-8?B?cEJWQ2hGa3pXQnpFWXppOEFJREQxdFVwdjY1czV6K0ZnQ0JnOHZKZkZ3cm9v?=
 =?utf-8?B?a0QyUjJzL01NRUlJZFoyWlZ3aUxIblBDQmtkcDhvMHBjREZHcm4xS0hxaDQr?=
 =?utf-8?B?a28rM212R0VkVUNVWHZLYkdWNTdQeWc0TDBUb01PMjJEcmdncDBlbEtCRnpI?=
 =?utf-8?B?MnE1RVhaRGhWZ3VsRWYydnpZMXFRc2VVT1RreVpTbGdCa3FuOGdnb0MxbnEr?=
 =?utf-8?B?U1FKNTlHV2xuZTRMSlIzd3k2V2M4S0JuU0xvdXBlcVhjUHBJSElOUkNUZTh6?=
 =?utf-8?B?MG9ENEdHUEFGaDJLbWQzbnppcTdDZkNSY0xidDlTMW8zY1hvWEIrVjVhSDh5?=
 =?utf-8?B?dUpRaVZ3bUFyQ3NDeUhwN1MvN3pMUWJkUUs5TGwrYlVaN3BkMlNjbkFKbURn?=
 =?utf-8?B?dG1Tai9FSHB3dnNsUXNkdGpDOVJJVWpzYTg0WHBTRTJiOG1KMFo4Q09ka0RI?=
 =?utf-8?B?eVpjQ094MzJlNzN5LzhSN2hyd1BaTE50dTduUzJCMlN5RERSN2pTbWMzYk1H?=
 =?utf-8?B?MEdWczYwNGUxTDVaUi92UGZYajhlUTMxVnlINUxvbitwaEJTMmE3TFVESnUz?=
 =?utf-8?B?dU5oRDhrejZ5bVk2cWZDZ1JZUnhHaS9TMllxaXdhdzR0OTNnS1lvUnlvUUtm?=
 =?utf-8?B?VkIzVXRjK3dkNUFWVUR5VTZ1TmRhQzByUDAwZW9FVk5kRy96WVdmRTc5MmM4?=
 =?utf-8?B?cmw2OE1xc0FMZExtZ05ZOXQ2OGV1ZXlTd0NyWjYzaVhqdlpGYlU2d3psU3po?=
 =?utf-8?B?aytOdFZOQnowK2RHNzU1OUE5MzdQc3BUbnVkdnFTUElFc0xtZmIzVHdFK2dO?=
 =?utf-8?B?QVFSbjBlVHVCZ2I3R0p6ZDE2VHgwRk94eWN0ZmZpdEVUOXZIQTMwZlovNndq?=
 =?utf-8?B?a1Z2a0FTVGdQR0RaMTA5M3FyZTVyQTFHdjVtcE05MDZiem5PSGhWUmhWd1NG?=
 =?utf-8?B?STJnUzRrWC9ieDY2aWhmQnFqdE5nZHpqQy9vTURZMTFadEZNUkwyZ1F3WnM1?=
 =?utf-8?B?N2pSTUo1TnU0QWUxeStsdUdoRnJkRVZzN29NcndRYzFrdmk3YjBEdUZ1RGhP?=
 =?utf-8?Q?TZia4qxNKp8or+bTvaG5mw3fW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddda650e-092a-4227-58f2-08dbb6589672
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 01:59:40.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdXwy+QCZ9OvSsZKVmA7gEPRgJd5PG7Qbppu2rVs9Lhwh02fLpiKMxzaTPtcFqn2y7JH5iq8Iv/mXj5ms1EZ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142
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
 .../devicetree/bindings/gpio/gpio-vf610.yaml       | 41 +++++++++++++++++++---
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index 59427d97adf5..8c1f87a1a393 100644
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
@@ -27,16 +28,21 @@ properties:
       - items:
           - enum:
               - fsl,imx93-gpio
-              - fsl,imx8ulp-gpio
-          - const: fsl,imx7ulp-gpio
+          - const: fsl,imx8ulp-gpio
 
   reg:
     description: The first reg tuple represents the PORT module, the second tuple
       represents the GPIO module.
-    maxItems: 2
+    items:
+      - description: PORT register base address
+      - description: GPIO register base address
+    minItems: 1
 
   interrupts:
-    maxItems: 1
+    items:
+      - description: GPIO Trustzone non-secure interrupt number
+      - description: GPIO Trustzone secure interrupt number
+    minItems: 1
 
   interrupt-controller: true
 
@@ -78,6 +84,33 @@ required:
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
+          items:
+            - description: GPIO interrupt number
+        reg:
+          items:
+            - description: PORT register base address
+            - description: GPIO register base address
+    else:
+      properties:
+        interrupts:
+          items:
+            - description: GPIO Trustzone non-secure interrupt number
+            - description: GPIO Trustzone secure interrupt number
+        reg:
+          items:
+            - description: GPIO register base address
+
 additionalProperties: false
 
 examples:

-- 
2.37.1

