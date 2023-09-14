Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598EB79F7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjINCQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjINCQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:16:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51C61BCD;
        Wed, 13 Sep 2023 19:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TViEZCmdVNXsj4EVCYeb7CXLzckeu2Pa6/1l/l8LpOFk5yEgokd0TGPa+LLbxWHIZ/gde11k+ISzRWH1RmVSzs5nVgQa853RPDxzzaXwUpz3GhARt0N5wdDo7A5JPCrarmM0UEwHIksvsbc8n1R1OjG1xGAJVWYw3ZD8Zn/VzIacg1VelOy4a454VHGfjFSRp5XwwhZ9bg/zCRAyBmAr5JvjJNt2gOB/e5I3u33/tr7DiWof3rBv0aXPqxdWXWrCnt222+IbpmKRa+7scp5nbyIAih3grzCG3rPCA8ShyRsUPli5ppRYFSXb+TBXzoa8a4ePY2meKSybVu0IgluFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXvTs+TjNVO8uK4NA2JOlFvhHMtDd3XnoOC3ZLO/AU8=;
 b=d7/v5IMbDmYgfKW9NnRcdIDZxyQuw+m3vOLmcB6/nPeGWgwK9Glc7FxQaVsPM52llku1uPZXTAK6DvRcJLZyvpcIkZySvuMjT5rDnd28CpfztohcxN9skOccAI9C4RKHcZ7R1ti5SURq6f2otaQ1h9JARlA83QNcVsEMk0Xh/71zwB2vqOQQUrAOQQb8MyOMs01of4HMK7/jY04DudRa7cNaSQG6tDGY/kW8aOLxnSnOTU5+VaHCiH6RBfla6c3tM60KkrcqqRUUWw1ocVAvdi3MPPfTiZKbacJrWlst9I03Ds5tASx977hAV8G0brCgnSoDuHj2ZC4mg7nTHUcAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXvTs+TjNVO8uK4NA2JOlFvhHMtDd3XnoOC3ZLO/AU8=;
 b=Hnr3uaSKqJ3v/H6VKzSflqqsKWyoxEtq3+QGjgge9nF6E1slJ4oJufOGikyAoIAl3dbQgzLW1GXiDh+U6UbEIs+vGDxMq2+hXbEVdLpi1ad14IDDCQ9cOEschFlr0Dr86xMqY47kQmugD2bj/wkzq/eXBfedsWpOO34cyZ0XaYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7257.eurprd04.prod.outlook.com (2603:10a6:102:93::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 02:16:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 02:16:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Thu, 14 Sep 2023 10:20:57 +0800
Subject: [PATCH 1/5] dt-bindings: gpio: vf610: correct i.MX8ULP and i.MX93
 interrupts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-vf610-gpio-v1-1-3ed418182a6a@nxp.com>
References: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
In-Reply-To: <20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694658075; l=1878;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=fX33GbOupfc1l5ZNjyuO7eo52gumhMQmaomyhmvf9Eo=;
 b=YMfCKZrdzSLouo2rJPtYpJIMhrqvoaplIR5LvJBLWG3mD65WAscPn8/NMBAKvkh6oKkX2Mklu
 m9TyNJWOkApAY7bLRn+dEXfVXGYdHOFDBk7Ij3erkpSZB8r/T9v6BNC
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: f30e333a-40f9-4ced-9dc5-08dbb4c89c2d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzHY47lmSrWs88WaLjwGtlXja+UdUJkdOQ4R1FEKt7Dlcz/nLtdVYNVZrugUqoseUFGc7CEc6b3C2EbsDHMxiJmXJe7VQhrPlVAtBfNCKvjm6dPQl3RTT4sVsL3vULqNbFb0ZoC7jQ0eLgbeoPx7+chu5QQO4wrc5jP1LAYVrqphIoYzt63ekG1ktFZP1SETSvPgKMFXjt9sCIKwjahkeZqvykn/ZBCjYL+Js9Q//czTFMY9WY+h3JBo9HStTAbgpJpUzg07UC4eoAb9E5pukt/sl7Ua8NiNorJr3pIkBfydYyaJBnRRBaUCYjBm/GoOywey6Lz8CWEI36mjWXK7n6daJCedV8662ji2GVkd5d5laXlyDqsGrTdWVLFw4Fd3CZoUv51baKUykrOe5JQYNO5LhVXvnnaF44Hl+q6XJXOep2o8p0FXpMgDb8KGsjdaAk8kyhlHrUByxtHC3rdFwwTa5KdsXubOPtUIbQPx4q1e0GFZjHUVRso+016rRJNk8zpzeFgGdA5MYhoXlEbbr+RytdSgRh+LmMAzTbF95+GBCqt67OEvu+/OheV/k4f9m2yZpT7G6ESiH/hvJ4tD1eSzLv/0zhf1HKpNNKHWVRtvXJe3eIJDZrISrYqP2lw7Dpk3ylTy0oElVHmZv3RD5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199024)(1800799009)(186009)(7416002)(2906002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(66556008)(66476007)(26005)(66946007)(110136005)(316002)(478600001)(52116002)(6666004)(9686003)(6506007)(6486002)(6512007)(83380400001)(36756003)(921005)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1pwZVpIRXlkMjNOYk9kTkhkcllWTkZEeEh4WDVocDcwTXB0SWdyblRaTE9Y?=
 =?utf-8?B?STRnSjIyNVZzaFNsNU5xYThXWEQ1Nk9lWFlnTGxvaDNOa25XMFJVcGl1cVVu?=
 =?utf-8?B?WXpQZ2JtQlNrY0xHR09MZTRjWVRYajIzZlRMaGc2bU5BN1l3VG1PQ2wwRjZy?=
 =?utf-8?B?TGNQMjBQa21aZUVBU3BvZTZrY2xuZVlESjVsYkFnZklFcXpvYThqeEQ3dkZP?=
 =?utf-8?B?eVpFQ1MzRjF0Sy9TM3VLVG9sWmlObjh5dDJ2aUVxOWFIL3liOGhGaFRVNEw0?=
 =?utf-8?B?QUVaVThKQ0hobWNId0NmYlk4MG43ckd0ZC9QeGNBS1JHM0ZrNW91ak1UOXpS?=
 =?utf-8?B?K0hFT0IrTDN3RXNOZXBJM0FHc2p2SzM5S1h5Z0dDdTZIS3pzbXlNTVY1Y2k1?=
 =?utf-8?B?dTJiNk9UL1VtVWNJdktZUExQSm1iZFZ2NkpTcGpiTWg1WENBRkF4VnhGa2FW?=
 =?utf-8?B?cE52bFQwVC8zdTY1ZWZUQTFDOXI2Y2FranNNaGMwanBlOTY2bHFVM3FGeHky?=
 =?utf-8?B?eC90aTRWSXNWbGY2ZUwxbGl1TEVWUUdxOUcwRXh5YXBMU3RVMDhrQ2NoOStV?=
 =?utf-8?B?K3RjVE9YeHR2RzBaZkRKY2REdGhxVXM5YVJkRStYNHR2SFhJYTMxWEZmNmhH?=
 =?utf-8?B?VVE0bUlpSUZyeGRRc2YyRmN0ZDlGcytlQXB2TE85SE5pNG9QUzBmaEVLejUz?=
 =?utf-8?B?a25paWVVOHdsZkI3eXBtamI5VjREVUxEc2JxcncrTEJJaVJnMFdJdFJBcTVP?=
 =?utf-8?B?ckpTcnJyblBoODhpaG94M3FPWXorY0hzYkEvTTA5bHJRbjNuVHBycUZYWVRa?=
 =?utf-8?B?UjFKdCtTUW1WRkJyaDl5STdNa0tYSzZaODNSTUNUUmtqb2VTOGJyUXR2U29s?=
 =?utf-8?B?bHljaEpNYnJsajJmMVJGVVBkcTQ4UVRhZHZPd1BIYnUyODh2RkxHOTNxdjcx?=
 =?utf-8?B?cHFOb1pZc2RBbzV6VUtnRFQzYjY2MVg4RXZaR0N5RVlvaVVXVmRTUVdFMmkr?=
 =?utf-8?B?TXV1b0QvTVFFNUFpTk9aVUwzeGJWWVlsTnJ1SUdHU0MreGdOQlM3MFJjODFn?=
 =?utf-8?B?VHB5ajkzclVOaHpST2xKUVNRSUV5cE1PSDAwRlk0c0F0em56Y1NmNitBWFhp?=
 =?utf-8?B?b3dFbDR0UC83QzQ2b2Z4ZmIyM2w3WXBFZXJ2TkVNRWNXSVp0MC81M29haGJQ?=
 =?utf-8?B?enFPR09ZU3JMdjZ4QysxZVgvRHVnYjBiSGp5eTNvcm4reHNkbTd0bGxmbmFz?=
 =?utf-8?B?OS9RdkZBN2NscFpOWjN2akg4ZlVwYm1ZcEdQT2FZaDZMalFyK1V0MzEwckZK?=
 =?utf-8?B?SC9wbWJabkhRRFVZdEh0cGYxQ3lWNkI3ZVo3WGp5UHNsdE1tOElST0RvMk03?=
 =?utf-8?B?SXBRYnNub0FzK0k5NVA5QU8rZ0ViUmpWc1lsbkFhckR5TlBiRUk4U3RKZ2lz?=
 =?utf-8?B?YXNFdmJpU3N1SkhlUGxXK0VqY1c0ZHU0QlVFdUFTQ3N0UWtzcUN0L3lFUmFs?=
 =?utf-8?B?YWp2MFQ1WXRaZUMyREJac2F6K3JHSTBpeWNCaUlYd2cwdVhSbW90TG5EN1dK?=
 =?utf-8?B?NGRuZ1FWN1poVHRvQ1Qzd1oyazM4UXBtVzFNWWk5Rm03Tm8rclpoUU80N25k?=
 =?utf-8?B?K3hiY0hXdzQ0Z3JPcHd1V09aWmh2cW9ENXRvK01RT1UwSVg1QlZRUTg1TEFP?=
 =?utf-8?B?a25zNjBlWDZuYXQxdE5pMUxkdnRVNHNIUVZxMWNNam1JUDM3a0NldnZoY2dx?=
 =?utf-8?B?SUxUVm84ZXdKQ1JmbE0wY2JoaTJmOSt6VDd3amx3QzJCWlBoTE9GQmJiQVhH?=
 =?utf-8?B?SVduYXU3Y0dkOE5GVWtBTzZQbHBMYTFFT1JtZmdQTzk3a01OT3RqMTA3T2ph?=
 =?utf-8?B?NWtndUFwTmx4bjduYzlxVVZiVFo5cU9WcU9ISk96TG1obW9WRnB4aGhTNWts?=
 =?utf-8?B?L2R3Qk5WNE9PM09Oem9xN0tmUTgvM2pKR3pqd0JGR3JOUzBJTG4vdmtNSlBi?=
 =?utf-8?B?UVhDYml2dlFVQzZ1L1dNSGhYQXdwUFhnNUZ4TE52d0pMZ3FibHJPTGg3QTAr?=
 =?utf-8?B?Z1NRb1dRUVJoSHBhcmtlbDMxcG1LOTY3V09ZZm5oL3kveldwNkdQLy9SNTcy?=
 =?utf-8?Q?GscLrjmGoQYzBHOzFOszqV7AO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30e333a-40f9-4ced-9dc5-08dbb4c89c2d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:16:31.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMhuFdc7ZZfzUfDQWYGHEmSD1AWpw6zeMb8tWSV/oTthE346GcN1MzuJrHUK29u/pGX+4Su69hSq7iLtDWDqCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7257
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP and i.MX93 actually has two interrupts for each gpio
controller, one for Trustzone non-secure world, one for secure world.

And i.MX93 is directly derived from i.MX8ULP, so make i.MX93 GPIO
compatible with i.MX8ULP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/gpio/gpio-vf610.yaml       | 27 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index 7c2d152e8617..2593cc96fcbb 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -20,15 +20,14 @@ description: |
 properties:
   compatible:
     oneOf:
+      - const: fsl,imx8ulp-gpio
       - const: fsl,vf610-gpio
       - items:
           - const: fsl,imx7ulp-gpio
           - const: fsl,vf610-gpio
       - items:
-          - enum:
-              - fsl,imx93-gpio
-              - fsl,imx8ulp-gpio
-          - const: fsl,imx7ulp-gpio
+          - const: fsl,imx93-gpio
+          - const: fsl,imx8ulp-gpio
 
   reg:
     description: The first reg tuple represents the PORT module, the second tuple
@@ -36,7 +35,8 @@ properties:
     maxItems: 2
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupt-controller: true
 
@@ -77,6 +77,23 @@ required:
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
+    else:
+      properties:
+        interrupts:
+          maxItems: 2
+
 additionalProperties: false
 
 examples:

-- 
2.37.1

