Return-Path: <linux-kernel+bounces-877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 860E4814761
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1197B22BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738925566;
	Fri, 15 Dec 2023 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DrUbT47e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D93F2DB6A;
	Fri, 15 Dec 2023 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4mev5+OvCSyds1KUaedJpyk9j2op9DjfdsEVspuoUIrsiPRRryOgnFCGPEvL32T4HMTbubWSJvv0NCP4xRiedBhQ29CcBj8k6GIHA405smfLVnxiN4OPsmhYucBCZRqtW2+lWTzZINDWu3FvlzPRRFn+JCEWS5uWy9O6jkOdRdGvK00Xql01ijaSIqG0YlVNZWxFSCNAW026JCSQLmSfiaflfJ9MfW0eIcjMgovjpM3FQYyFFsnTse1RPdZEHvAo/xtxiM7HXkzFrPQJTtcD0hpJaW5cmAbTUtaQnxvwMurnSc02yqqJSimXZvHS+akQzjdXQMxetz7knBdgDyEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mayGoMU32z5Lhprj4vCaChRqNSIqBj4ti03V5M89934=;
 b=R+5s076OTPo3AwvwJeB9TyyUvI1r+8fhdUF1P4Um0xCs/s/eDie0/TGtQMoi6MM2yWt0CWfK5WEHLbo49LYyYF98Al5Ky39pokiDnZ7nsEx4dUPWHIB0q2s+uiApVsulNkeve31V0d7NVop/FOFuN0738IkLkYbHo9+xVFMNzJMM9UNBNsSToFex2JjcymqZ20lfojHDMLM66jDeGzDEY9rAHKBdEsSb3hi/eFNQvud3nZZDgvKMR9hqDoQj567Na+TntZBfulWRSsILJQ0nDl7ubuvD7gOJbSwHcgdYbBVkgnJjAum4ci8b45hAQH7d9lKokKUb3K6Eqw0fpMFETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mayGoMU32z5Lhprj4vCaChRqNSIqBj4ti03V5M89934=;
 b=DrUbT47eSacAzFC9gl8WoELb+aSm+dtehCfcSLM3cEXO4krolRfOOhElfYnMP8J5pZzKERf46EMCp+Db3cMlUOnj18yi4Sv1YVFvZyPoBZZWPSEZ9mryBTMg//l0I4kvws7zNB/oJBE4TiH/j6dSrUP6zCrfx40PT3TPbdoz5WE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7435.eurprd04.prod.outlook.com (2603:10a6:102:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 11:52:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Fri, 15 Dec 2023
 11:52:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 15 Dec 2023 19:56:32 +0800
Subject: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-pinctrl-scmi-v1-4-0fe35e4611f7@nxp.com>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
In-Reply-To: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702641405; l=4331;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=aERjN+xM/kvXQQHZcTB8hrgs9oheX/AnqRYQ4guJAU0=;
 b=9lkchBROWbyDnD0gXjdJANzCarK8MuZe3dZza5Z2eVzVwD0tGcBf7rFhYppeLfYDGcpoiYqHz
 9qggAYGoR/bCN6r6GbRnnGiontxTgxz+ZRKXul968gIiNS1dEbo9biu
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d04d9d-d674-4c7c-51d8-08dbfd645220
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pyHIA+XuLQqmaODk/+HR8djV1Xgknvw9S+r7yfc9wk+47R1wnY7bnEYhFNJZ95ZMT5L325bOTpiyVtg/7STqdKOUO7YFnpdxyGNljRHPyfYZ7etmQmyrOduE7bBJg65jQqo9HN8A4saEy1tpKEyz2dK14kbSuvpfV3qL9Hrc01N/VdWcQ+J18lSDu18CAlXMwuZtfvs284jBWFAaFznpHfdbxr/uMReWxtmHKRegd/TmFbk9gB9+eXxZ0exMJcs3wF2xuOF/vbvXVZgMiqQE4JMefeQAKXvgSA/uNjRhyZfLCfD/VynShHxMXX9OPJZYFEy7jIyQu1PrC0ZMAcNoHaiETL/qA3s552dFPeXmNuXG3M0uaWlMf4T77NgZreif1LPS4/N8DEoWNt+GHw5E3skz7mUoOW/fyCODGkq17AirxXi83rw+y20zOyxYhpMCIlKahItrrn0YnShoS+zNAOxlwvGzzzkbobTdYZV9f4Fv3o2ss1IWIGrJW1ovCNYOR2Jzv6khl4wB0aCFmpK7uUlxJnR5AGiD5LULKz2e2mxynPARMHzQcB/6Kvcem9TPhrB46RFBNfYL5HPbdJCo0n632wsz4aSt+0o0VchgVpN6FqeNXI9Zhvfd54dXN8P8tPlipIqknaPACMsiVg1Xkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(86362001)(4326008)(8676002)(8936002)(5660300002)(7416002)(921008)(38350700005)(41300700001)(36756003)(478600001)(6486002)(26005)(6512007)(9686003)(52116002)(6506007)(110136005)(66946007)(38100700002)(66556008)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnhKR21iOFRCTVRzUkJCbUFUcU0zejFPLzd4Z0owOTdzRWxneUg0SHVHbWwx?=
 =?utf-8?B?bml5S2lJTlFGRXRhYWEzd2RaVnhZTm50VmRNcWdqcUNjalRZZ09haUdzT1Zs?=
 =?utf-8?B?Q2RCQXIwWjRPbndsYXExUVNITTZsM08xUjZrb1Y0dUtCSys0Wjc5dUVaanJ5?=
 =?utf-8?B?MndIZSt0WkdQaXpVd21aQjNRc1pHVUhuVHZPMDlvK3lQajNHY1c1dG9tUUZW?=
 =?utf-8?B?MklJbDhOVkJIV0o2TTZZK3hIRllMSkZiY0FhRVRoSzBNRnpCeUREcEIrTUxw?=
 =?utf-8?B?cHR3UitCSURmN2ZEcGdBdC9kNHE5Ujd5YllPb25McSswSndTOEtMNkY3SzFt?=
 =?utf-8?B?eDFsM3NYTmVHbFg3dXZCeUZwWHFnNjQ0bGhadWFsVkRVQmVySjBCS2lPYzB2?=
 =?utf-8?B?ckVWTUxnMXJ4SlpuemhMRmNwL2xIOCtGRGN3RmtvL1ptblZBYXN1eFZ3WGF2?=
 =?utf-8?B?QnZpc3FrZUtHdWdvQ3UzWVNpcXFtQjIyWDZaWC9mTlo4TGJlejF0ZWFSVkdr?=
 =?utf-8?B?UWhCV2p0RTZjZ1ZGMit5WC91UE9kL0syMTN6cnFtNm5vaHZXRi8wZnF3SlJP?=
 =?utf-8?B?T0g1NWgxMHg3QmVINnhPbTRoTjR4QXVuUkxtL0oxbGwwdGRkdWR5VmtKMXJV?=
 =?utf-8?B?cXBhdExueGRHaExCS1haZUlEdXVJaVZBSnU5eVF3eVJOTkMwSWxvNE1WN1pH?=
 =?utf-8?B?U0FXQ0ZFeWQ0YU43REFWbVZjK2FKclFScnBlRk5RTHRaVDJGWlNiNkNNdmNO?=
 =?utf-8?B?SEVXZzJiamNyUmlmMjFLMGJTTndwQk5pZ2xPMzdxejBOTUxJNldvNUJCb1Q2?=
 =?utf-8?B?UUZIN3l1OFo5encydUJ4b0JOZ2dLTmhKZThpSE94Mmg4N0JrNW0rYnFSNkJz?=
 =?utf-8?B?VE92Rk10Z3d1OGRDK0s0eUFFSTU2Q2ZDM1lxWWwwZTFpaWs3VUMvbDdNRWhX?=
 =?utf-8?B?TlRKeFo5SjVRWU00YTdHVXlzV1drQ1BFYi9SMGdUQ1RPQmk0alpHZG50Ulls?=
 =?utf-8?B?ZHdOUm55VzYzYkN5RjM4alY4QU5QZ2dKM3Z3N0JMOVAzRUZJMTV3RnlCWmlW?=
 =?utf-8?B?eWRHZVBCbENnZ01GUEgveDhwRlBjQWF5cSs5K1lFM1RFRXBOZDNDTUYvSHNv?=
 =?utf-8?B?UVBZWWFwKzBhcHdabUFBKzBOeU0vbkRlTlh2K0FqRE9peDFSc0tSamJyRUp0?=
 =?utf-8?B?VEtyNjdUN0N2NiswbFJVeDhaL0RlWW03ZVBzSVdZdWxIOTFHbkNSdE9pQmVy?=
 =?utf-8?B?emNQY01SRmtEWllOazBaQ29kd05zQkdQQythNWdUOUVkU0k0MU9pRUZuS1U3?=
 =?utf-8?B?NWprU1RGOGw0V3B2TGNqMk40QklxVjZYbEJIRHN1RUUwbGp5eElTL0JIRy9i?=
 =?utf-8?B?RjFtZi9idDEwSzhvUFNSQ0FDdzNMWGdsa2NiZmVZSTEvQm9VYUZ5L2NlR0pL?=
 =?utf-8?B?S0ZWOUU3NTU1MEZza2RVd3VBdUdsQkJOSUtzK1B5MkIvUDRZSkhuT1FPeWUx?=
 =?utf-8?B?TFErYStXUUNHRTVWT0lGanJZUkVzcXhUQ0ZEWmlXM0ZxVStkTnRKYVVDeEMz?=
 =?utf-8?B?eTQzVEsySnk1ZGZuRzQramVRam40M28yOWNaRVZDRjRHeEtzQzZ5UXlZZTYw?=
 =?utf-8?B?aVppcU1xTFJDTmtVRnRocjNRMnFERlJ6cW82S2RneFl5b0JMN2daVTU5V0Nr?=
 =?utf-8?B?bzdDR3cxZFZYUzROZ2hoOUpBcGQ2ekpFRVh5aEZMOGE2S3AvNmI1Ym42TUJ4?=
 =?utf-8?B?UGpyZ1VCUjF1WE1GODRReXhhMVdUUE0yVDRBVEdJQ1pJamdhcHJ6WXJOcGxq?=
 =?utf-8?B?VjQxMHg0OTU2U0JWbWJ2VEhMZmJ3cU5wRkFyMWtuS0ZyQUh0UGJQOFora3Vi?=
 =?utf-8?B?Qmx0Q2xUa1ZJSFJqK2RsdUhoSzMyVk94SmpXVm50Nk45U1hZMWtMd2ErQk00?=
 =?utf-8?B?VTBCUGtwS2dpWSt6YVNIZFQ3ZURwZWQwYVppMmhqNThQdzZvaS8yTFVUcmVj?=
 =?utf-8?B?MXVReXdnZTdEMXA1ZEh1VW5BV1hOTVlqVU5PWWVlN2Y1djkxS0FKMFo3Y3d3?=
 =?utf-8?B?TXZYMFBoQndYeEJYcHRIMldWdHhEUFVSVTVLVUNObGtsL0lJTnlOR2NocEh6?=
 =?utf-8?Q?Wg2IoNfRz1fUk4Q9GUi8TJjgS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d04d9d-d674-4c7c-51d8-08dbfd645220
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 11:52:32.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NkUEzibDXopGKvkuSYGAyfCpX90ZItCE58ZX/SzMzznG1ZH3gXtqT+6hr0N6b5WoePunpqxJeGrSWOyd2RBdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7435

From: Peng Fan <peng.fan@nxp.com>

Add SCMI v3.2 pinctrl protocol bindings and example.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4591523b51a0..bfd2b6a89979 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -247,6 +247,85 @@ properties:
       reg:
         const: 0x18
 
+  protocol@19:
+    type: object
+    allOf:
+      - $ref: '#/$defs/protocol-node'
+      - $ref: /schemas/pinctrl/pinctrl.yaml
+      - if:
+          properties:
+            compatible:
+              const: fsl,imx95-scmi-pinctrl
+        then:
+          patternProperties:
+            "grp$": false
+            "-pins$": true
+        else:
+          patternProperties:
+            "grp$": false
+            "-pins$": true
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x19
+
+      '#pinctrl-cells':
+        const: 0
+
+      compatible:
+        const: fsl,imx95-scmi-pinctrl
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
+      'grp$':
+        type: object
+        description:
+          Pinctrl node's client devices use subnodes for desired pin configuration.
+          Client device subnodes use below standard properties.
+
+        properties:
+          fsl,pins:
+            description:
+              each entry consists of 6 integers and represents the mux and config
+              setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
+              mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
+              be found in <arch/arm64/boot/dts/freescale/imx95-pinfunc.h>. The last
+              integer CONFIG is the pad setting value like pull-up on this pin. Please
+              refer to i.MX95 Plus Reference Manual for detailed CONFIG settings.
+            $ref: /schemas/types.yaml#/definitions/uint32-matrix
+            items:
+              items:
+                - description: |
+                    "mux_reg" indicates the offset of mux register.
+                - description: |
+                    "conf_reg" indicates the offset of pad configuration register.
+                - description: |
+                    "input_reg" indicates the offset of select input register.
+                - description: |
+                    "mux_val" indicates the mux value to be applied.
+                - description: |
+                    "input_val" indicates the select input value to be applied.
+                - description: |
+                    "pad_setting" indicates the pad configuration value to be applied.
+
+    required:
+      - reg
+
 additionalProperties: false
 
 $defs:
@@ -401,6 +480,26 @@ examples:
             scmi_powercap: protocol@18 {
                 reg = <0x18>;
             };
+
+            scmi_pinctrl: protocol@19 {
+                reg = <0x19>;
+                #pinctrl-cells = <0>;
+
+                i2c2-pins {
+                    groups = "i2c2_a", "i2c2_b";
+                    function = "i2c2";
+                };
+
+                mdio-pins {
+                    groups = "avb_mdio";
+                    drive-strength = <24>;
+                };
+
+                keys_pins: keys-pins {
+                    pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
+                    bias-pull-up;
+                };
+            };
         };
     };
 

-- 
2.37.1


