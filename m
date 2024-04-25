Return-Path: <linux-kernel+bounces-158413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75348B1F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA11F23249
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE41224E8;
	Thu, 25 Apr 2024 10:49:19 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2134.outbound.protection.partner.outlook.cn [139.219.17.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41881D53F;
	Thu, 25 Apr 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042159; cv=fail; b=TeKkvhfKGm3aoAh6q4w5Ce5mVsASSbBvJ3GuVGi2w+e1IfnopjQCKKHpCIP02g2l2tWSwefoFinwBNpB1q0VEf/k2+jnsMXFWZua15w1WicL9GvOM/lAmzx/ma1l5CfBTYDBSdGtW1vRrVwNiI7hIWMrwc0UfX1fuODueqyNuqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042159; c=relaxed/simple;
	bh=r/FvD5mzhwtZr3q/59/b2r6HYho0ugaGzs1g/ew49WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M/EvCW7+YnBADs1USkl2NbmLL99S70ZauYF3Q4CRvk1iIBF/NiEe/8i3WI26HchB3A+K/MdDzGNQRBUd0nT6MLBnJNZovb+/vZsk+vTJPBfKIUrxJ222iM65RBQjaGITcjy0j3wkgPoRtPlEUerNzUw77Oy4z9Hi9Z0IdPlUNLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKowYrrvd/MljGiXqHGO1CRUZsY5M/w93VhTZGfnc6H+YkFVrRB6CgteIbCTYlwSleuc2pioYl9CSePK0HOB1Ewi+KrIVzYx6ROPYKe5ZnNNehQAikGQg+hAn0TvVvyKfUPoqxGGT67JTaY87kknwPKKBZEgg5+VeDw6/L/oszFjHgQQk+vhj0rscAb9gjueCENvYKIYYGZyH3G6eukuv8cZqCZXRHMmiLDIbf7ytzbXulYWmQ3wIJGT0TFDrckDKMjheJHLYIeujn0vORuYbMM2NvI0G1CGTVhx8robNhR/aRoGBlLkiKvTp8wrGWR5wm81jOdv+3mVv9UubDluEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxIDl4HLV9bJC7hy01jnyiv1VF4IpHjXIeN+QCog/Hg=;
 b=E9SvDi1unNgBTXlQwgpqxNkfAXMslLs++u6nuaYrQKST7k6n9kgvESdTICbEMStSm7E8ZkqFw/SW3l38W8tVLBglfFUKt1DStp02GwvR6hPeHiVKD6MhCDRTyqPOLFNFkQ++dn7bvBhTCi9QLlBnF5+Uq00rtEJmDouVoGSO4Y2YmYOYySDlAHxQ30OGpvrPnNvSjM2f8lHa8pa9i36rUAYY8pBBlJSDDjiI08yoNfnnLwk3XWXxTnTU6RWKLEs+kPbD4WkuAYePo7Z61eMI7H4P2z3mwR2trRJ4jxf68O/x7xveAj7G1+YSzg4S1xVjiNuW1NfDnM5+2o3PtwfQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0491.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 10:49:12 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 10:49:12 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	conor@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	joshua.yeong@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/2] dt-bindings: cache: Add docs for StarFive Starlink cache controller
Date: Thu, 25 Apr 2024 18:48:41 +0800
Message-Id: <20240425104841.72379-3-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425104841.72379-1-joshua.yeong@starfivetech.com>
References: <20240425104841.72379-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::19) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0491:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a980ff-09e8-4f92-3d7b-08dc651557d4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RmPgWCmxFy6UozOA/0wyyk4uBIcH4LUmbesa+SoFoNav2cqm2oRb2Lll/mx60uNA8tnoo5jSmfe+OpcRoH+NBdRo8H0VHCwpoWRuXfnfJKqy0NT7uP0wlxaP4LkAkUHR/vZqp79/urEzpy65swxh0oNlk9MR+ctEhzI1tU6VieotS44rQNEyPhlvp9Q3m953n5pkdU3/oEW0geMT5vRv+Z80t3rfH0V4AaHDc6RUPFd0upt8EN36j2cGr8jomWtlnDfmNMYFWC6GUsDywqMwX8JjcZPCmkCWt8BR5sPak5Er9kltylWLo4RUYA8bv2WlmiN/1/Yd5OKbJqa9LjxMJ2LmmjFYK2LKWL/X96uNTbXWrOJf6SZ4oNHmpHG+tEpcyKmghrnRlNDED4FsBgv5UOckLIxVR2p9UYqY5eS0gAOLtla4n5WlGDNr4TuBtHTIL/tQNbNRNGR50CgQuckiezheoODBGVW4N1bSOtOP6wtLQdxC2Oq8UNMt6LblSY7GnC/cW60ojnjiDxO4tS3tYx9sUc72PDoEBDG8y6g2nUDD7vtuCkE/zDeTWjRjfg6SNBvysbny9Diuht6Sw6Qmnmwt4eB0hEDUndDDBFlRl3qT16dwYifNnFfOMaEpeWHM01AnuBtP0XQ03K3KCYHwjA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(41320700004)(1800799015)(7416005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IeLKnNaRUKuZs43fXbG3M42Uu67NMv2LpJ51AtlAtGiMscRlHf6Zac4uT6eg?=
 =?us-ascii?Q?2UggLZK3Qst6QxSWBLlkMO0vq9g+DXDlRS1vcQRkifTdx/pB+GPJDgL/egJ2?=
 =?us-ascii?Q?/5S4nuXkbzNkRORbh9jq04bX3ifUxRi6N7DVVN+0TgLUQH00fuwtjVZphQ/l?=
 =?us-ascii?Q?G8oD+FFxb8Scyx5hDVF8UGtliCe9dcWdgVuA2eRvnwYZugj5968qjCeQ1LYB?=
 =?us-ascii?Q?PAXP7K23UhhdRkDYCrv+cEeshtZzzxwyDNeAqXNyHyy8Z3WYwEjfToc3wPvm?=
 =?us-ascii?Q?zF/es1YwGsEkE+90MWRVbnVR8RETTYDsa2VCY7FEvVySRrcVEyBhj/7r/y+O?=
 =?us-ascii?Q?gSXUuW+S3rx6YR4tWGsZM3tqZ+2/rPUY8eJJ+cF22pero7wqLFmLalvSbG6y?=
 =?us-ascii?Q?+q7A2f5htxJys4kZnWXhKWHi+Zj+GXz1zlb09BwQCDEBIhhpVSo693iaGmFm?=
 =?us-ascii?Q?Z5J2L53KianTzio1DiJxfA25TUgP7QkwhvNDaxoI+MJxqhCnJSLghGvg9A4x?=
 =?us-ascii?Q?NJmyusmX/mH1vZz359XB8y3H5e3mA6yyflyLUPwfrrb3ISGsL424dlciPVJ9?=
 =?us-ascii?Q?N4kXCLANdNn710suFd13kSlMpN3WDSxxpJGSe5lJpkR5XGFXw0ko3V3zrMUB?=
 =?us-ascii?Q?3YUyp3Gpeu2GfoRA/gvWXEseKkVzf8RU6/9NTxizAVlgS8TkKQU0iC1+Qbkr?=
 =?us-ascii?Q?T42DkmwNcuPu5YhD0D8FCcw1iABvscU6N83wwSuh8INtVU1v87jei5/VGw4s?=
 =?us-ascii?Q?eeE6MnYpgWBETvruh07ReCB/I2MQlQy024mvfEmKh2wa1hZ1d4cMEpo5ReRN?=
 =?us-ascii?Q?dle7J4p23XjS83ZFn71voxSjvn2Z+b1Wv9H6VIfgpVwRS8jKI07/0spxzqNS?=
 =?us-ascii?Q?rn62GXJCFXjlVA8qERfj5uavLsSuiLsc6agtufroarF/FmRkLkcO2g4LOR0+?=
 =?us-ascii?Q?uO216LTVwi8+IcVvDLxQUBsmuseJjDpOjnxpDyPhn970NfRheGb9Jrga9za9?=
 =?us-ascii?Q?dbO6p9WwG3xEHQWUCWumndXhbsfveNKO54qRKmwgADgXgBtl7xeRYWGCkHQn?=
 =?us-ascii?Q?Fvhbal1Fq+aFK2igu0RqFiB80S2j8Cy1zaxTDXVQh7QM/BzmGhN+8a3FEEwP?=
 =?us-ascii?Q?p5YDI7sjHDZD2DVZEjYZsSlFnVMzNi1mZMf8U8FYPcSuNIbbZ7ZkZRrhmn/8?=
 =?us-ascii?Q?xJAN+nOFISms1IA4vpFaoAchzOiZqgMnXGNGDsM0PUbP29SQBWiip/gX1rnP?=
 =?us-ascii?Q?2CZ7lDw7D9QGcnSCE/xzMhHrmgnHn9hLs46KHFZxQbNEwUKsmXkzzfRTsFzt?=
 =?us-ascii?Q?27d3L08WDozx6MauIs+gQoQi4I91RkMS59FZujZqMJZ5v87cpMdGYziVbBst?=
 =?us-ascii?Q?11MmIvqkJpVdto5aWIeMgJtoaTQHmETWT7QWKXRcCJJaMeyj/08ex+0UhQEF?=
 =?us-ascii?Q?53WIIQd9Fr1R59pPMm85UY/pGBKbsr33MLT8I7SeeWHRvDmg0ZzPWPMZY8XJ?=
 =?us-ascii?Q?Wpsp4yP/NQhrhCuIEymf9OORfzMjxDOUENrUftgl0idfkkbScxyhLXAwDbs1?=
 =?us-ascii?Q?XcyMh4rjoS4eD1GRuHSkldpNLjmLVDPfIx2BiK2RxrEOav0G/jM1MyTKw9fO?=
 =?us-ascii?Q?Dy0/NK8rj3Q4Ris+C6VUtKg=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a980ff-09e8-4f92-3d7b-08dc651557d4
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:49:12.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/e+yJa3fXDhlR2pWp+jyDvjzTDkAyZnBMaXCkTq6JvEETtXDEbB9TwaZ31uewYQpYaUeqVVgKJPzW3gcdXodk+BL/RqLo6G9js/7S2QMt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0491

Add DT binding documentation used by StarFive's
Starlink cache controller.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../cache/starfive,jh8100-starlink-cache.yaml | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml

diff --git a/Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml b/Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
new file mode 100644
index 000000000000..6d61098e388b
--- /dev/null
+++ b/Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cache/starfive,jh8100-starlink-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive StarLink Cache Controller
+
+maintainers:
+  - Joshua Yeong <joshua.yeong@starfivetech.com>
+
+description:
+  StarFive's StarLink Cache Controller manages the L3 cache shared between
+  clusters of CPU cores. The cache driver enables RISC-V non-standard cache
+  management as an alternative to instructions in the RISC-V Zicbom extension.
+
+allOf:
+  - $ref: /schemas/cache-controller.yaml#
+
+# We need a select here so we don't match all nodes with 'cache'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - starfive,jh8100-starlink-cache
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: starfive,jh8100-starlink-cache
+      - const: cache
+
+  reg:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - cache-block-size
+  - cache-level
+  - cache-sets
+  - cache-size
+  - cache-unified
+
+examples:
+  - |
+      soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        cache-controller@15000000 {
+          compatible = "starfive,jh8100-starlink-cache", "cache";
+          reg = <0x0 0x15000000 0x0 0x278>;
+          cache-block-size = <64>;
+          cache-level = <3>;
+          cache-sets = <8192>;
+          cache-size = <0x400000>;
+          cache-unified;
+        };
+      };
-- 
2.25.1


