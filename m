Return-Path: <linux-kernel+bounces-16526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A9C823FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939A42863BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A602111F;
	Thu,  4 Jan 2024 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XnZ1/9AU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2051.outbound.protection.outlook.com [40.107.241.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379A2110E;
	Thu,  4 Jan 2024 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUZA5ViqP0swAaKRqlYwYLug5XQsrkl5VIKXa72D6RNgLmK5BLf4kP1z2u5ooob1xvaBmxf+1Hy2MpwEFfn1cvbDSWFDdG7p4BoHsKQkNY9h7xQWCt7t91ESf8A5fgYlZax5CtgGl8ul7s56tmtGFN64vToAKwJVce0RRjwbbwWTDMECpfXEEy+VkN72lUI9dzBMXSS0sw2YPhrLv1uI4fgcWxTXhZdrkneaQZ7lRaDEueqHyS8Bi+o/cexZ5GDcfRzXICEQ++uxuj9lbJIVb8eUo+mlW4elc8i8fw4Ox8FlrgFeai5eF/8JPdiPlk9zbSZZmdwbEbvApr9jLpq9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TeAOLAWJPpeQL55Zv+G3UCSTYmfxkGW6A62IaXCW9I=;
 b=YPQkELJgFDPiUhJzCpXRtrfT5YDHII2Gq7ESUipkZa7Qku9tKyF1xblMRVJ/xh894cc5IN22DHwLg9KnWVRKMcCOPnrppq6/hhn9r5TKvk5T+frPJDYj4ohfjCQZgp070F9xb7BE1G8mhEE1ndPW0TVpJEKE88OSqrl1p5QwJvm/UUbPjGPUGN7jX+ysAGkObIc8ViE8uskX84md+RmIeDet7eV/Qpp7F7j3AuBLA5z+Owuldt2tMjjfm20rS/NxTmv0uEWUZ0iCWOSW2Tec31XPGAQJjEehXM5gejB6w/X4AG5FcEbGL8SRKb1G8UqkUTojq5IWcjhgRb0RGkWpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TeAOLAWJPpeQL55Zv+G3UCSTYmfxkGW6A62IaXCW9I=;
 b=XnZ1/9AUHz3kLf8M8QA33vtP+Zqa7Beu4TlA+JWOkPhIi6PvaiIJ3L9843FJ6RRfa2dEYDTLoSXVWBICt2x21s0nJSzNFuTDSUoBaY7SbFesYaXQ4Q6fMzYekrU3Vf8SbilXGyutz8asUFr0UFrH3OOomuN6gsrthJDsD6TlHnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 10:44:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 10:44:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 04 Jan 2024 18:48:46 +0800
Subject: [PATCH v2 2/6] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-pinctrl-scmi-v2-2-a9bd86ab5a84@nxp.com>
References: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
In-Reply-To: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704365357; l=2276;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=BeunIXuoC9ojxhc94JLz5YEyvI/486KOwO+7ZGw6L4w=;
 b=vYbFJOSCLSbZthRGxRcwIkpgzxSoxy6EWRZkq9/tcqqnFR6M6BNw5iRP9KFC0mgYdrAFy3GzV
 uaF3fi7yGTABq5JDPsBD0a+w8AEsWoDVFhBfTpTt76AEZYl745315Uu
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: d4764564-1bf9-4778-49ac-08dc0d12312b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vddey871izLmp4AVHuPoCTkBBdsWmBDLQs5VpG+f2oAEhh+wP0DIoNtOTsd08uKfY7dpkR2vI0ztxjebcqUb2lIqxTqlfR//B8LxircmuiUpImxPJZh7WghQdR81cQvaYzdwW5cbs28RxsPRjT+gsa/+sr0xsKCXQJYe9v6C/FMeqCBYlaovw0SRY9Fen6tgoZOVrcXuzTev6RwELWBDX7IeQbYycY1ZT+vokJdEW+esoYvkXhxo0JTWJ8hDX3+hW9+drIqDMH6qE1U7vzy5loGI/JWlf55PjK/HepCQPKhA26SFZycs1ewoqT5doOgYOEy7R4XD19se7hBq4o9Od49SaztLI/ARXj+yiRr6V1kPn0fOPR/Urjy2elw2HvdN7qEXkfonZciH2A5BWU/ABaEUDcF6ROg4/Oex7+GDWHW7vJQgspNQfH4AEeurgXIjhZMCutaWBrRlMnVhREG/6hLH6uNbp4z/L5GQgF5KHzrURVQ+8g3h9UXwd5+u+eIH/k2dCuaayKgQFwbG9OAWlq6eewFliCkZ8L222CmQrEVmoqPV9DM7EZwtiOGkm4M/Thfjozkf/YtvBSZSFYwg0Mw6WRyZzOfYRETX8DqyEW608wMLih3E2+6qwY0DJLiCylWNAjsg8jQ37/9J+jTmGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(66946007)(66556008)(6486002)(4326008)(8936002)(8676002)(26005)(54906003)(110136005)(316002)(6666004)(478600001)(52116002)(5660300002)(41300700001)(2906002)(7416002)(6506007)(6512007)(9686003)(38350700005)(921011)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU9KcFI3UFQyaThibnJ1WGl1SXdoMWFuWTR0cFRCanB0Y1VXMSs0VEdnWjFT?=
 =?utf-8?B?UGpvc0dad0xnL1p3RWltM1Q4RW9LWDRtV0ZoejBJQS9kWmJHNEpndHRqbHYr?=
 =?utf-8?B?MU9lSkNyTyt6RWYxQXN4RldnYjlIVU1adTR6WDlBcG5wQklRLytKMDFBTXoy?=
 =?utf-8?B?d0FYZUVOeGVFWHJjdkI0WW03WExqQk5HQnJyQjRSWmMzTnBUbjUxbEpHZGxW?=
 =?utf-8?B?S2twaTlqRDNOZngwZnEzS25DK25WRkthWXhqRHhkZGFWUEdpUkxTbGNBaVdx?=
 =?utf-8?B?Y2ZSY04wemdNMHF0U1d5NWRuUTNGNlg5YlNEV0t2QzRjbC9DNHkvMUVxR3FY?=
 =?utf-8?B?S3hKNDdxWitLdnIyODM2L0JHN3Uya0pxcXpTN2ZjSHM3N1hDbC9QNVk4OVdk?=
 =?utf-8?B?bHQ0dk55RXdxOHdMUWlKdFFidVR4MWRYYVBwT3NzUm4yTjRiOW1vQmtFWDZ6?=
 =?utf-8?B?UWptM1BDYUxhL0REcC9nUVlEZnRhVytlYUNrMHdSc0lNTm5pTDM1TlpMdU9H?=
 =?utf-8?B?SUJLTE1FVEZpQlZIY0FERzRwMXlPSk83a1NQa0FFaGl0TWhQTElKc0xZWW9r?=
 =?utf-8?B?ZXZ4ckhuOTJ6bWlVZzNxQ0dHTFFOQmJGQm1hTkZudDVIeVRNVWFRcmMwNlpM?=
 =?utf-8?B?MUNjOGdwWTdKS25oTFBuQVJmT0JoZ0RKVnM5ZjJEWmRSOW4vOFYzUjhnSkZ6?=
 =?utf-8?B?aCtvb01PdXFMdUdQUnFEeUdZbU5EWVA4a3pWVWF2VEN4a2VxSTVaNjEyTTRp?=
 =?utf-8?B?WUFYWGdhbm9XTkhZV0JEWTMremowOVpHQkdkNDl2VmkvMXlyYVYwem1PekdG?=
 =?utf-8?B?c3o2aFhicnc4bnRxRlEvMEFPM2ZZS1UyelBiS0NMN2wyRDRqcWVPbFYxbmNJ?=
 =?utf-8?B?RFk2WW1UY0c5Z1MweHh5WVVzNm5LWFBYak5qQVhWWElSbGlFMy9nRWk3OWZq?=
 =?utf-8?B?ODh3aGlXWTRlejBHaURRcmU0aVd3SDBkN1ZPNWFZRU0xTnd2NHNVdnVhZEdR?=
 =?utf-8?B?dERzTEpwbzRLWTZSYktwOVJEVnM5clFobXFBVGhnWTRQbDNjZWppMWQvS09E?=
 =?utf-8?B?cHk4eFV1ZEl5c1hIYzRvVFQ0S1RrajI4TStnRER1OVpFUE94WElxTndnVVUr?=
 =?utf-8?B?dGRJMWlVckNuQ0QyVDBKbjg1b3lIN0JBQ0h1VmpXbjZRenVVSEl6Tmswb3NF?=
 =?utf-8?B?WjRVaXF1L2p4Y3V5amtSbW8xYWl6UW5Md25FNUVSRnVpQ1hndi9uS015QWFw?=
 =?utf-8?B?Zy96QmFCODJCbklZTGU2MmJ5MGYrQmphSWhPYlJzRWFKaGUvMkE1UHQ5U2lx?=
 =?utf-8?B?VVNNdnFOakNzT083TTNvU2EzUU0vN3IrMkxkd1AxTy9pWldDd1VCWGZwOGxr?=
 =?utf-8?B?TldSRFlsbVBWcmRpTFR5QmcyYThSMDNscVU5MDQvek80elBJVkFZT0laQmQ1?=
 =?utf-8?B?aERHREhDM3Yzb212SW50dzFxeXZ0RW1rdmttbTdYNlZoaVduZm5pMDUydkxS?=
 =?utf-8?B?RFNYdmJLakZETUdUR1lmOW9Rd3E4eVpOeXU3QmZVdWdBemF2TWZNSmtFUTVX?=
 =?utf-8?B?NElYVWNCVFlxZDJsNERzQXdhbW55UjFacXlZa2M1Sy92QTFkVDA2UFFoTkZJ?=
 =?utf-8?B?NmdNSXV4R3RENmpKSlRLcXpvRnk4WWhaUXlNaGRsdHNudjMreXJBTDU4OURy?=
 =?utf-8?B?aG43eC9aY1d1RlJrU2E0cG9IUW51dUNJazdycVVzdmRmQ1JvcG40dTdQQ1NS?=
 =?utf-8?B?bXBJZWVRQkk5eGg0c3VPcm5IcHRIejMvUlZtK1hxVUR4ZUpCYWswWlU4eXdw?=
 =?utf-8?B?eTdoNnBaR05aTHJldllsVGxLR09iK1VoVGJQeUdLekVWR0pRQzB2NzkyU0dH?=
 =?utf-8?B?aHVObkhiNlBKZUZxTTg2Q1ZuR3V2YXU3N1VLODNtR1VMT3ZaSC9nWUIyZFpj?=
 =?utf-8?B?Ym12WVdDaFVSNnVZb0lHRjZrNlBtcGszWEJ6bXE2SkMwR3pIL2FiOGRVQUpV?=
 =?utf-8?B?OFBReCtlNjk4N3pXMjN5Mjd5M09yMGwrNGJGLzVscUNMNzVWV1RBaTNLTWhM?=
 =?utf-8?B?WEdKVE5LblRzeHRtYWtzaFBhQXdYUlFsQloxMkxyaER4QStjR3J5MU5wU0xM?=
 =?utf-8?Q?UUH/Z/4r22GjUhfJAp+1CvoWL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4764564-1bf9-4778-49ac-08dc0d12312b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:44:56.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lf8FE82Vvnn7tiDYbOazopD3hSaPeNCN3CaPQLSmIJAHy/zvCg8AqaSBs0JOZiu7vtxrH/E/Fg0VMmYbVtG1SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847

From: Peng Fan <peng.fan@nxp.com>

Add SCMI v3.2 pinctrl protocol bindings and example.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4591523b51a0..bba4a37de6b4 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -247,6 +247,37 @@ properties:
       reg:
         const: 0x18
 
+  protocol@19:
+    type: object
+    allOf:
+      - $ref: '#/$defs/protocol-node'
+      - $ref: /schemas/pinctrl/pinctrl.yaml
+
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x19
+
+    patternProperties:
+      '-pins$':
+        type: object
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml#
+          - $ref: /schemas/pinctrl/pinmux-node.yaml#
+        unevaluatedProperties: false
+
+        description:
+          A pin multiplexing sub-node describe how to configure a
+          set of pins is some desired function.
+          A single sub-node may define several pin configurations.
+          This sub-node is using default pinctrl bindings to configure
+          pin multiplexing and using SCMI protocol to apply specified
+          configuration using SCMI protocol.
+
+    required:
+      - reg
+
 additionalProperties: false
 
 $defs:
@@ -401,6 +432,25 @@ examples:
             scmi_powercap: protocol@18 {
                 reg = <0x18>;
             };
+
+            scmi_pinctrl: protocol@19 {
+                reg = <0x19>;
+
+                i2c2-pins {
+                    groups = "g_i2c2_a", "g_i2c2_b";
+                    function = "f_i2c2";
+                };
+
+                mdio-pins {
+                    groups = "g_avb_mdio";
+                    drive-strength = <24>;
+                };
+
+                keys_pins: keys-pins {
+                    pins = "gpio_5_17", "gpio_5_20", "gpio_5_22", "gpio_2_1";
+                    bias-pull-up;
+                };
+            };
         };
     };
 

-- 
2.37.1


