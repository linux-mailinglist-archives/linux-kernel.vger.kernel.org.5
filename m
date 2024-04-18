Return-Path: <linux-kernel+bounces-149493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71BF8A91C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE2DB20C31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B85465B;
	Thu, 18 Apr 2024 04:05:59 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC425537EF;
	Thu, 18 Apr 2024 04:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413158; cv=fail; b=TlraHa1F6UC5chiPqjlxiGmYynTFIWzmIq9bYUa/AzbFlafnj3pd3YiHmIi34i0petl5TtO5WeMDLttuEZMsmo820q5b7WPVJ/yEnUOL2d8JN+mXdU/qAUS3Yl1DDj06tJTdCouFDXHG1ZzNJb3vVyW3rl3+XWpj8uYHYlBSTrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413158; c=relaxed/simple;
	bh=wUpxNct44GGjaCxiXjPB8YPNRruiCvkT72VnJlto0xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=utlBQH3y6T8rynXrDXe287QqOwOoNkC4dj9eQ0FC7gxgfkdjGbNluMhZfkK047UI4Yu+0RRRSqCmCMouCMthdwGtqwyrRFWSaXlr3gqDgFX39jBV88kCwTMMusNUvL8O2RKI9kLb09znSI8h5BE7BUWuIu84pXzUTLjj4tkxpcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yq1q69oUcIHQGaeOwZ2LFHoKY5DFXVwCZCR6FM37YRLFprmWJDYR6Q3AypyEPhdr1gc6xbGMq6c3B2MStY810Jz4WaUAAvHuksyrT6ZMkSdPTg6X1RKZbixEu68r/+NPmhtQKPPqLFHmUpQjME1ZTumihEh2LAqbbOmAcLFlZC9EZXcCDCWvARQ/sZxmgZmcL6iVrm77td8dZc9R3usZENGWT1M0fqv8owRb3LnmhfYmd29yzLlJFvQam7N9bPdtV2NXX0RO76aPGH00N1pLz4JqxpfBbDGhTIPbepIElktFFHYlA+jzFTNd82T3qBlVTYksbhQeL3mPEA7XAWhVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpbv33Qm5JbEyqBAkVoJlNkxqwRsX4nokG26GW9Gtbg=;
 b=EZF5SOCUOAizzJREvq9sRs+uwbU61b5jJnAVp/kDXyVVEZb1MjdwsEAmvkgtiIchNmhZWzd5LJPJKxgmjf68KGYbATTAVXY+aixiCjD8xtXqLq1gCxDYbE4oxFp990xRTRW9Ck8enBKerG0x6G6P8ZD4Nk9X5Gv7141YcOJLa2DF/dJMort9WCL3bsT/dPy1FDj/fTrb/ZfA+I1nnk2GQqS+Q8uwQ9DEXdik7EpFf+QUgSBCWIhJ/WJkJvmH459JVjfLZKTETmATVo9XIUDsi0edIzRa2EA80FTbpyQQX2711GIVQ4gRp/0MIlEJdfw2nYXuEhD2omlUe2zJa3WCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB1071.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 18 Apr
 2024 03:50:34 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::103a:5792:ddaf:4283]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::103a:5792:ddaf:4283%4])
 with mapi id 15.20.7409.042; Thu, 18 Apr 2024 03:50:34 +0000
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
Subject: [PATCH v5 1/2] dt-bindings: phy: Add starfive,jh7110-dphy-tx
Date: Thu, 18 Apr 2024 11:50:19 +0800
Message-Id: <20240418035020.47876-2-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418035020.47876-1-shengyang.chen@starfivetech.com>
References: <20240418035020.47876-1-shengyang.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0036.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::13) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB1071:EE_
X-MS-Office365-Filtering-Correlation-Id: 71299701-1f91-421e-4cf7-08dc5f5ab3ab
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Hjq/6LZrKc/hYMnNyieq/s61X1LMNQh6GYNJrxJedYzJVvavAZnMPqmr0CcgPHI/B+1zkgQILwbKKWxARi0FGUjnp4z7Yilx0Eojmo1xmhiFvKV685gaYtjKt4SDJUXnOeeGSinZ/YGr01YagvT6nwdGL/afq6OPFeaR49r0+7HCo3/UwENbFZxoWCUkSMk8EAZzSY8qysIjSGD1eDBdXzRk86k5cUpbRO/qTiYu+ng7+JD+agckwExTZ817oPIcZ7L16n41Hv5AOi3eZG5DJzGrQMfwUdg51mjC88qijbGS2cEgScJKRST1W8U2kEqW09gqh+u4WbRaFT32RH2rXL5dvuMZUGnp1ZRrRdZizRDaZjDTolSQIWgG8OhzKxfwGTiHfMp5ykTgcfb5c7/CxThjYG2yujBFY2Jyjd4koVNAomL6yRx3rOISuh90hgpd49zhLrhq6YUYn/+ffeQHdkkGc+6qk8/LdGFgWGiM5e/GSkXTJfh4OoYcz4Ygf3SDHQ1TS0CUEQGOhfqxx8FsjOVPFoWlwi4fljO3M5YDwbiJogpwyR49zvoeYdaJ8QNGoZv/ncHc9crVKnOJas3B5GCHgwnoc9xk9QHWDrxAQ/dtqp5QjqZtZ7aAsUq3SRI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YEojOIK9Wr8CxYZMqV8A4laFf0gKDY/9Ypmr6C3wCzrB+IFDTyGX9C6zDqn+?=
 =?us-ascii?Q?/8McJwnrNmaBD40bfGvuncjI3VhRbybiH2K1y/eTqslZw4SGh3xonpo6nEkS?=
 =?us-ascii?Q?4155Umy03CIqgMzz7hmP87G1+GPjHxIp5fsRq8NGz/hNyOAafWLDoT7EwzSx?=
 =?us-ascii?Q?4bjMuhe2QXfX4DPY5U1ZdF/zGhHyr+FOgA07+MpQUAt22gwkTUqmaASfbUqB?=
 =?us-ascii?Q?sw1FN4NsKy8lD6FUdLfskSI7m75AUD9iX9Ogcwetw9pYT5CXikV9gWsMgVIS?=
 =?us-ascii?Q?Az+amN/ow3Gzdt+dCiHzBJSezLgowet3FToukOEHuv9GRBFHrnV/EwF3BBpS?=
 =?us-ascii?Q?lVI9qQ4nGFhkGa1+b8t5RuuPDzdfkbookcdS+RRbZdbk1OHldJdhkni6u8CV?=
 =?us-ascii?Q?uIhDVTBbUyZ+0FCQ+uuElfUPV9/eXCf0FvCr0ixGKUGo/bY4MwFRn+lcbkAw?=
 =?us-ascii?Q?PmzEAqm/YORlsNbC7ewmiyNBIB3KzlukIwv+FEv/I9kPhFEJlLwYOCVEWQg8?=
 =?us-ascii?Q?1FlLnHG00ThNN2YoWQ+b6dYqZsS82P+pJKWYyDw1xlfoAUYlyBWv7oZikZ5B?=
 =?us-ascii?Q?gaMi6odwRereANVMofS8fevDEzqa11SkyXecGyOg1eERdOu6XV+tBlC+X2Lv?=
 =?us-ascii?Q?c9rKRiCpR2mUNVv8zWGyDdEfdEA8N3err+oHU10VGbkwTk5uHIDsykUNiElO?=
 =?us-ascii?Q?j/dojBSyHU6S7sUkKRARHMrMXIkIsKqAbt3fR9fLOyijp1lQ0ZPP8AR9F1sM?=
 =?us-ascii?Q?u16m0Qa47jRmLLcf1LVi8lYaFdIgnlpf0K+jWo3JmYPipWNUP18UxhKDewG2?=
 =?us-ascii?Q?hxzR7mMQw8bDJgFdEhi1soT1B7+Z4zAj/8IZKtiMShqTuUC5vBvoVRuSQveE?=
 =?us-ascii?Q?uJ6aqEvtVVWMWwZFq8JFRygIi+Zrf5btBl+9gG9p6xGNtp8hef6yezAyRuuv?=
 =?us-ascii?Q?HGFXCRffXZ6bu2drZNkMbpVZrPMi+S/rx3MJDu/+iHYqFo6lu2eWRDPA+CO8?=
 =?us-ascii?Q?1qeiyNmSPNjucaOT3Q1O5WlkPvLsq3Z88dBaON1LMjeiboB9PxdVok1kI1zA?=
 =?us-ascii?Q?zDR/rnSvgzX2DjLZrYtm2wZaFNYp+PiJ9RtlYN4hkOetTLpgtIiHVJYQ1IQj?=
 =?us-ascii?Q?bOxgyP01GchQF0MgKKD8qjHdOD/Pg4qFEATTrv+PnJx6gv4a8PFKvyDcWgAX?=
 =?us-ascii?Q?aNJYun8ivQWK/UCgkgih6+knCnTdmK+bRL5q63W9HcPAhDMr7ZXgZshNZS5g?=
 =?us-ascii?Q?gNyfCy7ztQLhxqV8/NVGNv8DII3FXRUZoEc76+9Jf18nJeqOcdaPD6iSVdP7?=
 =?us-ascii?Q?L4qqc+9kLLSqrXhhwBQImy4YhiyQGr8diSGNmYK6afAqMT9m6OoBR3o9y4x2?=
 =?us-ascii?Q?ELMYbfp0qxNTvd9KLW8xozeoSMxs9uwM0GyjrjHpa2NHPx3vAHHhWHjmghce?=
 =?us-ascii?Q?2k4zaDrsjH6jkIAuFraC7ya0bXD86VZJpdcYb50gSdqNwFQnWD5lYsxG9Cnp?=
 =?us-ascii?Q?t+wPggiuuX/8dlz+MISq7nG8bf8+VydmAKUXsUjJBOaR5YEz9AKquUSdC3B6?=
 =?us-ascii?Q?PPA66L/gydYpfO/RpEI6cQcXQe18lQag0rV6kE+CbigToMsc8NIrELNTQ1hh?=
 =?us-ascii?Q?r+ONiVdegHgDx+Ni24RvTlk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71299701-1f91-421e-4cf7-08dc5f5ab3ab
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:50:34.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpgipPBCpYGL3kHSR5oJueMLdLxWvWO60ZzDJ0Z05QV44Bbmv4iC/cksf7VRvMpfaT9n4E68ha53eO5QQ0RRP9uj6cC4O5V3MvmfRVnqw9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1071

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


