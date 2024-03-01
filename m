Return-Path: <linux-kernel+bounces-87787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10F86D903
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7251F227BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197037708;
	Fri,  1 Mar 2024 01:39:30 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBC376F8;
	Fri,  1 Mar 2024 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257169; cv=fail; b=XSPYRaVpq02AV/zVuZi4Rh7xa7q3d0WyUuT7ywNEgBTdhZWu9yek+LbMoDvEl6EL6rzR1mzbe0FGTj5L12ZgzP/n1yJKi62aEaZDbxtyxryLzykwvexGk8hVYiwlowMziZM0KsF1t6D/UPpI9Hst/FfmjmMAesrhcrNBheqJ7T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257169; c=relaxed/simple;
	bh=wUpxNct44GGjaCxiXjPB8YPNRruiCvkT72VnJlto0xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gJalOmxgRcWze7Jy070OpM0L1uR5NcPAWalRSG2jPnWz8tpNWtzu8HSMlm2yLkJRW01KNGNlZIG66pgazmk4DcrV0MQ0AweGMU4o7GoHlS5iGLuRInOF83bzEAS7bspMQBaYOhoURuyzRtp9/wjq4uSE55s1F+sMD9Us0V3GPF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/FCKf29dkTEUd/2WQWM3ARdmB4kE760Ou3DLKbFAquSjWGoSVgl5lhAUMgoOPFMIPkOfGU1x92YPCfrYSIlyuZ0iFllzfK63O5zMBAj4V+QO0SoQ2imlgKfPgi4Pi9X4qvYjwTKcu0JzZKoFzLh2oaCAXzf3QLX/hvQ77ZI2ONkXylq3q7YHoj9L3b/AzEI25sbd4sAynog2/kvNI3ToF/MuyDwcxozefIXPNkinXOA7qzT6Rcn/cl+4xOeLeGSXeCh/ta+oOsBrbovbrgC7NzTESnNXCSi+GA0GCjjBw8jqJY7DB4PIU4zCkjC3H9BP6cfnZVkaPLJnfYapet+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpbv33Qm5JbEyqBAkVoJlNkxqwRsX4nokG26GW9Gtbg=;
 b=mJEY3YeWcKqh2KlvsRhvogjbKt2a43ZBg4JJgnErJJgHISiGhtLOSRr59zZ8cj4mpptK417NQrCRycOWCFDNVjmISQo7CZKQFZ6VlShYNYdgiXYhJC8Ab1yh80r4Q9qLr0IW4tIlu9Dl4oofHLxlOMXz72F70e0pQE9Z7hYhaOZbZMtl8OKMHcPcdPpOE622I65fCsZM6fTmfclRvk01WV+7NG25/iUfMJbkJcJdV6Kb/u0q+4TvfxEfTM9Q8wQRsq5tHxXDiTCJ5OWLBV4Ex1hEIJS8Cm8XpKUwP7RNAcPA7S8eqSOJSAsCDwe8N6WQAZt8iq3a0ajUpkq+uEx2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 01:24:27 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::db9a:cc7:56ae:de5a]) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::db9a:cc7:56ae:de5a%3]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 01:24:27 +0000
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
Subject: [PATCH v4 1/2] dt-bindings: phy: Add starfive,jh7110-dphy-tx
Date: Fri,  1 Mar 2024 09:24:05 +0800
Message-Id: <20240301012406.92589-2-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240301012406.92589-1-shengyang.chen@starfivetech.com>
References: <20240301012406.92589-1-shengyang.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB1325:EE_
X-MS-Office365-Filtering-Correlation-Id: 66acb179-b1c5-416c-2215-08dc398e55f5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hI5rw1f6PQxt2fIX96SNbloC1MCeNNEfe5l3LJyvVPksxbDI7w4OaHPP0l3ALju/L6Ih53+eUk7+Rh83BdovSontx0899X+ivyEzDLoa2jqyBSVvgkaC57+dA8t7y527KiEPMRGYVYGPnslp5ChZW89JMvHPO53GJQrkSFj53tFDLswr6j7rXESWJKFyCs22YyE+b5k9v3S4yRElkDB4VXrZs+3IiHtXAZL7rMwIKguV7xGpBYQVETlrQUBsIU2/doHBwGcS5oJ9S7lvy4ytKrO6P3tSOBs9k7Q0Nnv7GNTkMnVhA/4GEKvkcubU3jnLkuQ/npxpDxGdYgsV+d78M5zBhiCgrsBEk2wikKMhTsm8pypSt1elZqJffAhggApLM5fM5TBeRrHyUNI116auL+caWjbM2jJgbISTRTqcoHLzMMLLHVI/yzB5aFswwcUkfQHoDGNU2vYHyZ+/2oaRiQkdN9GSJA7VP/9DJgllnJ5NltSH5snMgDVg92+HJS9ZiP3fFo8cMxkCsmKQd3EftNRUz9p4J3sIk1fXYEKvL9B7/Ve+/LHlNWuj01a8LXLDQd73rwCjTIhOkcyFrCsGWnz1dA+ySmTdcTXS2QdlPNzqAd8yyREcm5qwVH8rAMrL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fAAfnR0VrvqKG/PoVX70SaTK7iF/mXOxjSPBUKY4N+AMxB9KX5kZZLljrDuk?=
 =?us-ascii?Q?rYPQ8Fg88IZWRgCRD0GqedGOozE4nmc4jox0ZrfBMnez9fpb6dTXrSaw2/TD?=
 =?us-ascii?Q?kbGu98rrfJOMLewV+10/LWtqBst3RGINSkZ1wdriUHzh1jfBT1t2hbjZEcJG?=
 =?us-ascii?Q?A/VNyUgw4AEwm1W9yLXwvN7jrlSE+OxrljqRLpPoD3D4kxZNtvnC6CHFyAWB?=
 =?us-ascii?Q?bnNvo9yc4K9uEhBt5nSc5Ox8jPGfNHthC7YzJ3abuBWOIEEDlwueLtxX6Mvm?=
 =?us-ascii?Q?mqpX80C5zSb/+WHk8l55fax7AeNk26Xc2TYHDYqyV1ZXqfcutUJF64UfPDL+?=
 =?us-ascii?Q?OjbK17H373pwsr5RIS/6c7ADXzQlYX+t3WMe0oK6ymtB3l8QA9LUy+DWoQvQ?=
 =?us-ascii?Q?wuPNeIEF0lXomcRI51ByrpqQCq2XsXRL5vVlbXGElGPw+SNKsRz31d7wFURG?=
 =?us-ascii?Q?7vnWc8DP7W+BSwgpDPPHRatfVca+1OlQ+RxTk5lLjczxhHDc/Ue/GfcLAJ10?=
 =?us-ascii?Q?nCZh6vXios9qp7HYM8tlF0CBIFazoA3LyGs9RDH5QivNzJRc4q/sdruoyv+3?=
 =?us-ascii?Q?XIsrdlVrb+IC4SelC0zK4cmW2+/o8L94N3JE1ot1fJYVDk5wYVr3YWDAZSxJ?=
 =?us-ascii?Q?2kfLlMLAKx5e0OLk8WdoFNTwT/56y7cLkYACMAne4hVkYIucWkevSnplFxrL?=
 =?us-ascii?Q?l+NPL8o2oDja38a+64oMiPw825acgE9cidFbcUQtAAVfJIz9EkylX/0Un60B?=
 =?us-ascii?Q?rztz8DHOHHPsa3I/+3ppQEO2yx5H08FnzgWDT/NGr6gzJj4wz2ULzNQOXBap?=
 =?us-ascii?Q?YgLYQAdRLUtoBrLjCm73ENx5bbY+UXYc7CMTPybiIbYHb6CkjhSjH7B43xEc?=
 =?us-ascii?Q?yB7hdpBOP0bFBxhqzaHYI+9cbi/5/WHw75QHy85uC0iXDkPR7rEfqutlmixW?=
 =?us-ascii?Q?J4YXCn4I9LWPbA/rwzxu8uWOoj4FjCMOZ7qET/ytvuKzNmA+aTjy7MiKkNj1?=
 =?us-ascii?Q?LptCH8dqKHTWY0xEdggGWXDz6YcZ8KxFqnposkXFvAtamjVZIwrDgy4pijhz?=
 =?us-ascii?Q?bOt8RbEwlgNi8sMBfo3xgbobXWXhykbMMygFkXDp11EtQm8//kBMBVxzRJLc?=
 =?us-ascii?Q?/k0T3M2I2kL1gRKrkWyi2GW7DYZ7OXZMqMDexAuQT82K6OCwb9TS+nY7JIZy?=
 =?us-ascii?Q?yYWJJfoNbuYn1OuGE4OrX8XV/kRtAb5/LY9r3MkvZkh+8n3ZruKoepy+SzcY?=
 =?us-ascii?Q?tCRt7xoKfZHxVJNV9OPKwPut9svFr9ZUBxYTILKt9vs3/z6hiJ28yEvNC8G0?=
 =?us-ascii?Q?wj7pCDP1pd6gpjqXbVqSYCnWuF0wH4ErC7JSwxnr++70HureIJ6SyXHlpES2?=
 =?us-ascii?Q?qhpWxa/SIHDszGf+5+5N4tokjZFiFSnlCYXboz5k3wkbgaTYyXsSwx3kvxGB?=
 =?us-ascii?Q?EGSbuG5MM5cxagpCi3mug0G7FRhlGlPd73j4vDoEope0YVPOW3FAGFPP3vow?=
 =?us-ascii?Q?22r01mtA32OyQNSjN6qLjPYjBOyXJAXCpI/EBdau02oZ6RYXTTUfwnudP1AK?=
 =?us-ascii?Q?kfBaZX9VfJ7UKWgpLd2g092V0ZiZ9kFb/OkPtDrGcl1O8a+xusj/0I3ypzqh?=
 =?us-ascii?Q?VeNt1cajvxXFXWDci9/uaUk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66acb179-b1c5-416c-2215-08dc398e55f5
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 01:24:27.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCsSm3hQy7b06vKmXUz54VQfMruqZUXPF/Vi6c1zYS7P+2N9T4bBoniFXRXmjRcxOVlEiDWjuTlourlvJK7xqEnxcr5sodYCgwcKSCjZUHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1325

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


