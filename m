Return-Path: <linux-kernel+bounces-20476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0194827F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEDA288DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919C811CB6;
	Tue,  9 Jan 2024 07:27:51 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2081.outbound.protection.partner.outlook.cn [139.219.146.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89920BE4A;
	Tue,  9 Jan 2024 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBhNNbWrkDW4MWKGRwAWRYJXCfOLfFB65feHGV0IyYR/oNiSu/jmju82XESLLxhXfj+TLy8L9qhtvpOdwNvTnZchICo53Dy/TLqd7aSR3li5B3vMUM567aCESV7+dxIkNpavnQWP4yl3W3bkLDS3NgOoZ4HBEPgLj0vtQGPWZVg83ejS31ZPVgrTrZoCVvQBz8aW0HI63Slodh2o4xlYrpnFzGhd4a/LOoQI54kaoEyESoXfGnghL+Gjnru5HuzPl2ZNs4WHfY8WQQHx+90mjjBwI6daGw2yC1AAHKBFgXwXO14d9UgNEfnwoPrSlIZIDYD6djzN6yTuqPr77QjUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE2XiYaRnQBUedvPGy5YP5cEr4oTSW6m+UtnSv6qHeU=;
 b=KpNGPoByDuR+ZS1LBvs40XJOvBSiCQ2SG/WBZCsT6UTr+pRwVLuHrRJsLwwloGFoZkqXHRzRuF2CFaZ+EUeGmJs1/kNhtB5a6nOfgcxKioetghtvXYpJzBCZ05F/+VN0VQxwHYDALq29OiUtKTKtKXdP4/ZnfYGzKzYJ4YzroM1AtYlZU90+wC/zBcjVjsgT+Mr+ANrA8KNZsr2Yb2IwErF9PMk2Q4qTOiloMt6rLNxDTzVjdVM7N8ArxRJKOpzDjWnSj4MpQpvbs8HG07wpN470I5NIrHvQxxcCgz3rwJHj6k/Wkozax4bYOmQoEE4SZpSQosGfkJAs5l5MVWgNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB0957.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Tue, 9 Jan
 2024 07:12:57 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::85fc:7fb9:8b00:dd88]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::85fc:7fb9:8b00:dd88%3])
 with mapi id 15.20.7135.019; Tue, 9 Jan 2024 07:12:57 +0000
From: Shengyang Chen <shengyang.chen@starfivetech.com>
To: devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	minda.chen@starfivetech.com,
	changhuang.liang@starfivetech.com,
	rogerq@kernel.org,
	geert+renesas@glider.be,
	keith.zhao@starfivetech.com,
	shengyang.chen@starfivetech.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: phy: Add starfive,jh7110-dphy-tx
Date: Tue,  9 Jan 2024 15:12:45 +0800
Message-Id: <20240109071246.24065-2-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240109071246.24065-1-shengyang.chen@starfivetech.com>
References: <20240109071246.24065-1-shengyang.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::6) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB0957:EE_
X-MS-Office365-Filtering-Correlation-Id: 3109ea15-abbd-409c-13c4-08dc10e267dd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9PP1EiFJ0A5aaIGEARZjQYTLlgTeMoRXZSIrio6GqcuvPL/BMIbHJ+HnwXu6GOWTk18I05lG7PI7RBwYosCnxm5/GkTJIh88oXfHvOcQSHqT2EO5DVvCH4h9d41eSzDjE3vb947if+8e33ayviFACLc18xurh4ZjFc8qeu6RHbK5y2SRXggXu4W0yGlim7hoyiq43Utc6Zr4vQ+mY8cYehaULnYkU/pWBrtnyA8T2Bkk1YPvtzUiKWrpWHeI9s+kYZp16ZlAclC6gxFirYPIGd41mpDJirPzphITJDUmquoAcFh4Bvo1ds0bqCF/WJOnH9cBYHXDP/OW3gHLabCF66lXBNgJNRGN8jTLf3xrVgAtkfkvcaM7SOeUxEl1SAmSTFmrnfURX0lrCsrVEUqxD9BpcodlkdonsS9x6K+jItQLVUh6PoH2IPVESU6QsKEecl2f7wDQRHKrSM1JK7qR1GKubtOgixN/fydbhEJILT6WSqEeDeyn9AcIvlm5BeQIjt0bGGFNpZN8RgaN7TbGn1SlklPJz4FrrVuTxWCOHSjVnBpVEyiOSmqWkg3i0wK8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66476007)(66946007)(4326008)(66556008)(8936002)(44832011)(36756003)(26005)(2616005)(966005)(6666004)(1076003)(508600001)(8676002)(41320700001)(41300700001)(5660300002)(2906002)(7416002)(52116002)(83380400001)(40180700001)(38350700005)(40160700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iPpzU078Ft1r7MrdsoH9ZmTr2C+Tkk/+Pcc7Ue86KxEKf7/+6DwFKtFDhUbh?=
 =?us-ascii?Q?kFJ/r4zKI+GonQufxQ22OUMMIkR0Q8CELheUPbCWJCSbVHFneJRkUaGgJ6eJ?=
 =?us-ascii?Q?Amix4NvfZCUV/MHqRayw+XQ30vw7R1gROwrwgtUKj/VqyrpN10z7nsb3ND0I?=
 =?us-ascii?Q?Rm8GeaGNtF9TFpKLvGQ4bUCIMZhUMrrUP/FTIoLWLq9Xc4Z2a2l8CncozjyN?=
 =?us-ascii?Q?rHHafYdYOSG5HZNXEGCbQS8DXnjosBAHOesgaqTHQLAVBV+aY8dcTei77vHS?=
 =?us-ascii?Q?Jr/kUqWNHbHu1qfd4LUxl80NVC8Tu8IXIbLjTig545fEhrF20fCbcZ4FOBM5?=
 =?us-ascii?Q?soehP0FdMDH/mxxKmcmGhRehIkFv0my6igJdx1Vr1vxhPu1eCDV4kcozV7Kc?=
 =?us-ascii?Q?eW0acnBwomOMoxIFZMdqax3TnGKfjQYwtBLPtcMkI9fpLJJSQPLZSI4WwnMa?=
 =?us-ascii?Q?ER7rs+JPGEh/PDpDYGHrFTPkAkDYmR7FMU3phb8enmMZkAmDlURJkcX+4jl/?=
 =?us-ascii?Q?q4xmdcA+gk+VwE12vgqdtxmfm+8hL9+EgWxKYIazraA1V83+uhCUpksiGL2c?=
 =?us-ascii?Q?9pwQCMHcHjbVZPONtwjPD8Nmr2SHmCscedhlrjqq2Lr2u+ZsOseEQdJaq6XG?=
 =?us-ascii?Q?/oSeLzxWb69OU4Eo6in6JVG1v5abJN256aYeejTD9tQbMFcLleVXINEqFwFU?=
 =?us-ascii?Q?Sp9vdxT0pnUUW9FFcTM+2pcwAUEXkn/5NyRcM86btiLR01yqUBTKDmHAsg2m?=
 =?us-ascii?Q?L8rX4/b/Xv9vl7aCPe7AjM16HMvuJRYB9d5d3XE3rkGZa94QxgTsLROuuq30?=
 =?us-ascii?Q?KbFN/LPumitrmKaJad8/bS8A7ofHd0Iy0EorJqQD8SyuwtFWc0zDMnG9HxWN?=
 =?us-ascii?Q?ybZW5w0nQSj4LXjO9xnl6nGKpepB6KhFrCyH99jK+sbBeET2EobV7ygcsn3/?=
 =?us-ascii?Q?ftIOWvrP6XrbI48r+6PMquWW2LtPh7GvumQZM+cTUdKpzvY6lvj6eYh40QD2?=
 =?us-ascii?Q?hkYzCZ0L/nL4MmBajkhxMqIW9/MuWHQLLY5s5SwA+M0XEc2d36dSbUtPqwnH?=
 =?us-ascii?Q?rWUSlmPCCq2pntbb8wfK3+LtcywVZ2MGw6VnEuvtXsAAFhowfQr0HV0JMQxM?=
 =?us-ascii?Q?NGLkCm/bjVYcqPCBr2ApoSgENJSrRDmDrGBtPJHtmfdXmHcNMK2Cy6zCm/J3?=
 =?us-ascii?Q?k5l4GDDq9V+XsnJY1Z4c7iZOQ4PFXkbaRtW1V73mZ+3zv2eWd9Zeg289OOxb?=
 =?us-ascii?Q?R5MPfKrfmxFpQpEI8ntLSVD4VfW8surid/qqCLNqoW8AUSV/8WQB4Q9+LNIO?=
 =?us-ascii?Q?i3s1HF6P1pCXx+g+v8q7Auqsf4qECHQMx7Jf61YW9s39maxIfO0TuzG6eZG2?=
 =?us-ascii?Q?h+MCBt728hp9Uzj2kjJK/72B400G9/+beFAystxyyKqDdaOFwPBQC9ej3wAb?=
 =?us-ascii?Q?pU8Y6CTNGtBP2Pa8u/srNyyNtcgkgH0q7OJfVLaGbAJwXuLSSJAhEQv49oav?=
 =?us-ascii?Q?A1OU8C5ytv5bqHCO4oGtWicq9OIq+Ut3Ve6ouI8X/kwrin/580jvxzGULBeW?=
 =?us-ascii?Q?N6G5P9dE6apbM/PV2INlrzzrMKzi3kx/DsdeUGrc23VV2mbgtqzXVHSfP0vl?=
 =?us-ascii?Q?pNdogJv/rPiPorI+/PVF1k4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3109ea15-abbd-409c-13c4-08dc10e267dd
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:12:57.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAAq6BKgBUGvUHDWqi7r51kSVDewjaX9HxbJqQobdlDAPYXwtfokB0WJAr60RsKON6/88iznEWZCbzvPg4cw7E1FP0vHR5zCIFg6uFSIzlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0957

StarFive SoCs like the jh7110 use a MIPI D-PHY TX
controller based on a M31 IP. Add a binding for it.

Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
---
 .../bindings/phy/starfive,jh7110-dphy-tx.yaml | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml

diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml
new file mode 100644
index 000000000000..4a06a2642b4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/starfive,jh7110-dphy-tx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Starfive SoC MIPI D-PHY Tx Controller
+
+maintainers:
+  - Keith Zhao <keith.zhao@starfivetech.com>
+  - Shengyang Chen <shengyang.chen@starfivetech.com>
+
+description:
+  The Starfive SoC uses the MIPI DSI D-PHY based on M31 IP to transfer
+  DSI data.
+
+properties:
+  compatible:
+    const: starfive,jh7110-dphy-tx
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: txesc
+
+  resets:
+    items:
+      - description: MIPITX_DPHY_SYS reset
+
+  reset-names:
+    items:
+      - const: sys
+
+  power-domains:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@295e0000 {
+      compatible = "starfive,jh7110-dphy-tx";
+      reg = <0x295e0000 0x10000>;
+      clocks = <&voutcrg 14>;
+      clock-names = "txesc";
+      resets = <&syscrg 10>;
+      reset-names = "sys";
+      power-domains = <&aon_syscon 0>;
+      #phy-cells = <0>;
+    };
-- 
2.17.1


