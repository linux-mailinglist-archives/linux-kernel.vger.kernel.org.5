Return-Path: <linux-kernel+bounces-54371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F73B84AE58
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFFE1C239CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C22083CC8;
	Tue,  6 Feb 2024 06:19:43 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1783CA8;
	Tue,  6 Feb 2024 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707200382; cv=fail; b=b5IZrQ6fc/QPiF7wLWlwEIO70eu0wepGGk/WldGN/Pl7d7Rii/nooLMzgnncycNdLJwITLozY/ro1Qgg4VI8wk696GGDAyGvHTs7c/RuJbBPsSB7rRYG8f37AjQEPVZ+gqn1+1Pcz+Yav9vyzCiDr3/BBDfKnrA0hDBUzUOjHaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707200382; c=relaxed/simple;
	bh=wUpxNct44GGjaCxiXjPB8YPNRruiCvkT72VnJlto0xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEWdOzAJcmkBUbooip9cfg8qZSeg2h+iC3l2Rxt7XHuAYMvJLHurmEgPJN0iwvSllG87JHDK5DmFE+GrF+rZp4jODiyKdq9K0/2oTTLuePoDOc4Tb7JC6zdy2AxZUGGSdIOgFCZeAfbMPqLwR0Ha/hSwI/U7SZFhhwpQC9LU3CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjj0sRtkwqKfafmvBYvGthM0n8G06oEmG9p4tk7cmCWSwSJ5HV4C7ymkiVjy31tcGaHUEpBQakmYEmYKdv1KxnJl1/6AAjO+D49C/WNzmn4Qw47o4VmwXWHK8jrh9EIe5kezeCCn8Lb2Ypcxi1D82O5O507BAcrzVpLTSxsbWirK6yz0hykMTkYIBx2inSoimE3f7azjCo/l3J59rCtl90DiIaZl7LIhWmTrPRSKLoKAJK2zJYtNnkdqS84OddhN0GcyVwjm6cmj2qpi+9ZyYktdhK+hq9AVeDgKfpWO3nvSFxRgo3nNXr3ipD2Mblz28bRdzMxbxUvrGeV1k/TJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpbv33Qm5JbEyqBAkVoJlNkxqwRsX4nokG26GW9Gtbg=;
 b=lpQEdd4as55WFAq+5rIioktGdk2FVibZ5b5bbH2T4HuBxEuuvMRQVngxwtzSLWyCvM1+1vS2fkvnn5dwq5dAprZfoUsQ14UGAzhv1T9a2Ro2FqZaWa3JeGTRUhF5uLqKeAPKxFnBj6ISVl9Uj+OaTUo2Rc5I5uibKpJ9WoQwwep0YeoPZfkqDoP7KdIovQhkMJHYsJGg41zhLHCkCBhp3ucBluMTjmVtp1zrO49LKx/BZchhIfD1vVZ/HyWcXcJJMcl2WhLV4nmzdk4Bqp2tXCxPykhdwC1VACGaL+LU733NdqTvdJIXW2IYDfztyv0gawiGPCjg0ORA8WGzYaU/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB0976.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Tue, 6 Feb
 2024 06:19:30 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::57c1:eb9d:c4e0:71af]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::57c1:eb9d:c4e0:71af%4])
 with mapi id 15.20.7249.017; Tue, 6 Feb 2024 06:19:30 +0000
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
Subject: [PATCH v3 1/2] dt-bindings: phy: Add starfive,jh7110-dphy-tx
Date: Tue,  6 Feb 2024 14:19:20 +0800
Message-Id: <20240206061921.107372-2-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240206061921.107372-1-shengyang.chen@starfivetech.com>
References: <20240206061921.107372-1-shengyang.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB0976:EE_
X-MS-Office365-Filtering-Correlation-Id: e77f4a63-7469-41d9-079d-08dc26db93ed
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WPstaQ3vwLhVqnksA4w8Xc69sCB3FJfvoM1/4Bp9btReSGG1bQrDGTX28aek/qQlNlYNK1pGhx/Q7u8IIi1oQletXOPBX5NIXF68Tv1lE6BRZNYLgelyfwN+cAs3WkkYbvkZeYPqZvzJB5RFAM/m5RuGflJMH9qTJigVl3XGc/lrAkH0bv223ZMUMOFYNp0KPs4DQiNscanQtJX4sQMHQbN+zxUlBT7cdvBBsUchDOeQkKUoZ8cytv7NikPeu+wa/n9eCx/uUFQ/AUJOIBG8UOk1OfRYVnSUoYE93PCNBgAj64iBHJcsypcEKnYQhCdjSacwn9reetb0+6DdAFDxTF1PkaIU95nwbp7XDIw45/8cuOrgeXCZEPYXu8Jo5HoxFHQm1eU5kVp1kKgJpdcRF+I0ur7becXSzVbCtVWTaRUbehujU8ErT43xAohWBUpS5RVSfbQ3kpxJxRpAypVTMo3gQm2Gkxqh9eLVDa2M8fUENauF3gxdxAN3HTH1mAEpXZ7OdTSl8uveM7z17/r1aOhgkTlC0misn/cCdnWtLfbW3qV82pfIn2hGxlEgd2hA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41320700001)(41300700001)(86362001)(5660300002)(36756003)(40180700001)(38350700005)(40160700002)(2906002)(52116002)(966005)(26005)(66556008)(1076003)(4326008)(508600001)(2616005)(44832011)(8936002)(66946007)(6666004)(66476007)(8676002)(38100700002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JjB3fWGlZVSu9LtfSuXp8HhaI5Eahzim8LW8uEB53RxSDAA5qosUVTLnuQ6C?=
 =?us-ascii?Q?BQNUmBHqjzQR/xL7je7PBHCSvPYFYxzc6wvSr0dklBASg7MrezdXGxu73rS6?=
 =?us-ascii?Q?iI5CEf2jap4UIuoDASgaXfOzY79wT9kKHoglhtPOVih4cbnykZTixHR/wjrw?=
 =?us-ascii?Q?N/4gaq824W56O7zsiHs5AaNChhKmqBjnklUX1snCs3d0hb60Ya9ncNg6XnFF?=
 =?us-ascii?Q?I5k/V0I8QvqAxqErqDOsxb9wS0alyTAJVMTFVeuChOizwM77nC2F0nQg5rs0?=
 =?us-ascii?Q?/DApsbn/r95VFinVoTihEO4kXXERU6jA9dyH5CZvWOh2AEveE6J1r/VJ2OZm?=
 =?us-ascii?Q?wvl8xdbsaVmr1M2wn812LIa0/r3oCmDGq1H1Gy8pJyup8qUo5gsX8Yz5T72j?=
 =?us-ascii?Q?C3P61eWfLFgypwoz8vRz0wmOQ/4h1QZsCZtytIXmviqNXiClMmNbdyUJBw9R?=
 =?us-ascii?Q?ZBN/j8GfQK9bhmYlokXGOcZSdvS/J3fRDp9xvmoXTCyiO2gr1XOdXK0mElLZ?=
 =?us-ascii?Q?A5b5zc7Twqw7fwRcxOjhqwNFjD84KGUe0l76klTtRdSAPnsFZn6xbOeFtn86?=
 =?us-ascii?Q?jIh1UKbb9nArac+ch9tFg5oyHgIVwHqWhIp2SCM7/GxI/qz9ujDu3+GSi/ul?=
 =?us-ascii?Q?v7thbuc5D2L0evakoqhV7JxM22uo9coint29ELlQ37CL8Yz8DZ7Ys7nyVGx6?=
 =?us-ascii?Q?AePzYqndBZpYYrPYfMDkTLNY6MkAK4np8dwmub9J1ncXBocuUyGBu4z/t8wC?=
 =?us-ascii?Q?tp43Hfy/e06WFS4J8GFPLIz3Fxc8PCMM168rB0LkaC4X6IprOu9Q47UB+FDn?=
 =?us-ascii?Q?MMyTi4fR/MUasUApOHy4HUyyguXbViLSpEFxPK1S0V7qYf96i4itR9cDQiy/?=
 =?us-ascii?Q?Ihq7JG1nKlLjZCLeMUklvmu2CvSpgyjy7F+ZqHMjktIGkD0nqW5lOCtmOmu2?=
 =?us-ascii?Q?Gj6deICLPnFr75/2SKYTTbkGCDhtC5TQSAX4qIthBIbFlhnV18wSnM2BqQux?=
 =?us-ascii?Q?dC4j+C+3wFFshBnQr+cHgt1qSyOXOFINzA2FYQrvKqxt/leR48bt+1nWFtGB?=
 =?us-ascii?Q?YNmah/RfiQOPNUzfEsswyZGQjk+mmQFBRXsyi4bceMbMBHNaCxA8L8yjJWUy?=
 =?us-ascii?Q?ILZVI76wQolE9XXFR5JOZe1kkY4a8N11QkMhdZrWqJDKomJ306oJh0p6K0Ph?=
 =?us-ascii?Q?lWVvkiF0wPU87NqXFrUTUmW3bbJZzG3HLFIwXGqj3TQrTyqkKv9XzyjaogI3?=
 =?us-ascii?Q?AWy+qSAQNBQjqf82e0Fp9ThehMch/KEddp9PIyg4li3IU4sR9QScr5WqYiML?=
 =?us-ascii?Q?Qb0MUVOxQWmyEPLR7ja0QU51e3OuGoI915m1Kb6s/Fe3nQxLSpotmrwfwJSW?=
 =?us-ascii?Q?RrTntuxhjJ9SkHIZIKIouFkc8hmUtYSZo8oiz18htowPDPyGAc9fCd0x2mke?=
 =?us-ascii?Q?PxrWn+z8kQuqbcpxKDW2yDQ2PgHB8HTXGVVG4x4aWymMXA2Yv9sMe04tL8EF?=
 =?us-ascii?Q?NYUw5xnxkRibBXzvCYYUqEF38Pmv7HRRYxIQuWnRNv5fO3prwtGZk6k4R1Z7?=
 =?us-ascii?Q?UZuRA+JqYZH3orm4FaMnAn7ua4Ux+SWS10RcxwfG7TeKn9/G5CxiaLsVQEhZ?=
 =?us-ascii?Q?ifQWthxPpOXKOQSCmClBzkY=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77f4a63-7469-41d9-079d-08dc26db93ed
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 06:19:30.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0XU+uG37FG+Tap1v04KvhWHzlLfPXThymoq7oRs9yoKYJ/NNs/C31P+KWNMcd2T75OywxXyNniYwYQDxScewjCU2sS9tu4l7G93z4yw6zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0976

StarFive SoCs like the jh7110 use a MIPI D-PHY TX
controller based on a M31 IP. Add a binding for it.

Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


