Return-Path: <linux-kernel+bounces-73953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFC85CDFF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81382858BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565915AF6;
	Wed, 21 Feb 2024 02:27:16 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2107.outbound.protection.partner.outlook.cn [139.219.146.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD7FBF5;
	Wed, 21 Feb 2024 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482436; cv=fail; b=CFukQzy3KtE0PhH1anbt6noohUBMI9d41VEKhj8/Eze/keFdsK6Izv3v1sIiz0+M1xCdex5B13a5+R0N3SvHtzkh47pUCSnD7HyoYs+eJoM+HLnU8Qr61v/Cbe1NdvnWFjdPapVs2AbZSkJ93O7Hn013zwRLezRJRF/3GZ273QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482436; c=relaxed/simple;
	bh=0yiPhBPD0XmSqNgTotKrvpZyiaRRfpNFEnfcDBEKB/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XTN+kC9ak4CpG0a9fKne0lk3Y+pkRmIizaGaPMBiHf62VNjy0Ica63QCb5biL3CD+v2V4cNWGkXDjZYHdLS52LWNM8ydVK8Yfel3gw+AhnoCf7qOmDFUpPxarwUWtf82PnxxwaTn10tk0ylF9cTFkhv7FlPWIrJDsNvIHtR/FlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYphHt/ZE7/WW4oMho8/nSdDgTuiUXqTL/KirQi1FoMR058jgIzc0BpieXoL+OxLERzI8iqq+HuGa/8KXNEK9xIjwf8uX/wSuFN+z+Ih0gSCMwoZyPvuWKEhFOkgeSIFFL99yadZQbM74K5CIPKp4t0eUz0bPQZTC3FbreUFd0r/Ng6YXDOJdXjgGZcsFHzCG6wN8A1736EoZQR6ByA9MYxCj3MLARqWtb82AsLn/bak4KMctUNDPq5RaRUcqXveX51UIhoUojE+3vh2ZAbyISr5fyXQ4NqVW5o9aBdBln4qR0TI4d4TB0hmdC/nMGO2SVlwrxLCnw30emA/TekJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WITnoB2inaLbaJX02D9zOEJin+aUqaAEOe2KuvSRp8=;
 b=Hu884T8+8lxMoJ5vmreoSi9FzRwH0ODEDDVKYJPMDma4Uo4v2UEc3y5Lw5Xn6C7HhdL2Fs92PM6uchF/68NqOyWnoYzHbv3bLgCeUsHQpuJy6bbdeMkENuEylEmS8lqIIgyRqGG+1sgH5jAgkYf76TUJgryjQiaxQKAyRTbwUl/8JKw6h/pTY9OqQAcmtCQ/WB4jHrVd32Vp3ZmZe53dlQ69OZ4JGBlJQg8oYieIzGTda+GJp99AlrO6nzxeNYQiCdj8Tu9ENxbIUgBHcv1qT9Si0n//4kgpePjPWIW8weUjJo9bnW9w07+JStbKy8aTlktUmQ6Sk17IKdNYclaUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0541.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Wed, 21 Feb
 2024 02:26:57 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Wed, 21 Feb 2024 02:26:57 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: interrupt-controller: Add starfive,jh8100-intc
Date: Tue, 20 Feb 2024 18:26:46 -0800
Message-Id: <20240221022647.5297-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221022647.5297-1-changhuang.liang@starfivetech.com>
References: <20240221022647.5297-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::31) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0541:EE_
X-MS-Office365-Filtering-Correlation-Id: 0698c184-d017-4e57-a605-08dc328493a3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FRc5WpOotvYnCnEYnk5jLIAC0lz8JX/HitHeg4Rs/LaDbd4U7APzS36TJoDRClDCzX4S39ScC7wSVOfrzXXYuJpBzy69TMgpv0B9lv7WlmcAc7ymE3T3MZEvcYxASqu8YOecBVw/v8ahtEb1LAP6rMreVn01sjs7aMTpBMfe+bSbXnG690TkWV5/+573BmDwAMBVgQKjE00CnObQXLgQ6z4gorRxYsmccGMpRZK78lFFrq6kUASr/vQza0Xph33gTUhr+WfKR+3ewiCjEjXlOx5TSb9HKQfP/kZMBaWgK1NbtE02dDocODlBpAbaIq3wTukR3QDmdWZOw6wrwBGoxWYAzNsVkcImzefDecqf6Clim1WTLZQYRbPEiNlCmfkSAXYUzdbjW5S5cSD8j08pZAi8fuRyPA/HVwdXitKCyNfVRMLOoNTGOWgx15Kuie/j6vbmAMz/fqYsuCjaNIkhXDrfX3kOXhRDYpEj2NcfunOCSAUEbvv5X7ddmMpcG08XCMutO2yTPZEbkVsiDrrggFRqbeuB96S0Lab5PaMD1JZHg1XJQ0PEPmwyvCxQgg5f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DVIWLxGACHa1VkGgzINQsXB5ERRI+WtbEBEClutGuphW0MeHOegrKr7bbRqW?=
 =?us-ascii?Q?NQw9KECCkHHQJmDN/WlDX7bhN50gDqE80VM+i4azBQno0JhUV57EVZ3qVjkz?=
 =?us-ascii?Q?/I8RkNhmczsDe7RZHJz4hb8bcmBcv0y01GPgMM6Sla7vDuwW6G7y8BDqarE8?=
 =?us-ascii?Q?YgsRxZWifrrLQgJzi+dDnZcj8bUPzcYDk2Z8Wl6kmC7KChICUyQbVbP6YO8g?=
 =?us-ascii?Q?zrbOmzksueOZyrRo/pGqGtWAmLRHSQFH8R0IXccsbdxMTgDCO/T5GNutux8a?=
 =?us-ascii?Q?KCX8G8+wz1LL8xQ5OfjVZs3Q8/NVJB2EvCuNJCfgPyu4aG/kIdLG+VlewYWM?=
 =?us-ascii?Q?mxzZBNFvoX5c4Jhk7I1oxPfN2RqsrNrJ5k+Ui7cpk+9GeH7Jt0osc+Q4hxwz?=
 =?us-ascii?Q?4bsUE263bbIiQ3vRujnnTlTVCn16gBH4ZmXI+gHdskveAtIlUUbXJjBrtiFc?=
 =?us-ascii?Q?7haYcTYfptFjvOD66DdhVEFCQE38e3YmMfDybiBjFkbVckF2Tt3J9/KrCJC8?=
 =?us-ascii?Q?1gXPmFoblP9u7t/pVL4PV8a9Mer5NwsqSfWIsCoDf1y+yYJDPRvhS24eRGCl?=
 =?us-ascii?Q?Xz1Uq5fV8GGuIHweUYRk6UiuhrPWW7ZWk9XBfjuurZSOWotZeYufY+9v4X2a?=
 =?us-ascii?Q?kZRVNXEL8kSYXQ9fDtxFURd8kW7V1ai8WlPvuljU3m9TLCyrEbqZbLPELBCR?=
 =?us-ascii?Q?R9wCcMtrNBnEBTuog+grmfpMZgIB1uqtQzGgQx5eBt7eHvCZnnuCgwecFG6V?=
 =?us-ascii?Q?AXAiCf7ITKt5yUHP4oQtR+MyTo/49zQcQWHDa64kXEFYDlci0gWRJVgvw/LT?=
 =?us-ascii?Q?kbup3ggWaQvihDcHwyt/Uekfb6/ZO1RXX9sZ6DQSDQS633KCU7pctC1Cq4sU?=
 =?us-ascii?Q?vimzT2sS/T6agJ+WTfoOHkTq3D7n8GtOIG0EKHWYRml2XIB2hbeVlsvkdppv?=
 =?us-ascii?Q?uIQq45JlJYIYQHZTYln6gdDxvHG4WHgy5zXLdQfeq17IzBfvYNm6yExU6QEm?=
 =?us-ascii?Q?5x7FEbV4lNtoIq44qZXgWlkRjBbv3Wm6jPHqj4bPyHMLzAUdbFX3Xe1LZyIG?=
 =?us-ascii?Q?x0+5ESLUuJs3wdkE0t0cjNkxVbHg1Slsnb0Y+CQs15//QUHlkBgCS2RR6YjD?=
 =?us-ascii?Q?/SvcN6PC6/U7mOrt1plG4NBQc/zh3pgd2b15myy/vqG5qk3yaCwHq13c52jH?=
 =?us-ascii?Q?LgTb0WNJH4KOMvl9civMtVD3kIBm3X8Ce8gm8pRHhR+LKbfG9BZyAph2naak?=
 =?us-ascii?Q?2Ze9F4shQXTPK4IJqaD4111p4z2dR6vlAIY4ybfgtUpxSNC+FW97Oqzp/zVm?=
 =?us-ascii?Q?gGsVk9/zmuqtNjWMil5UED0vKkytdjpLE/AklZDR3MjF8fuBX+gDNs4Bw7/B?=
 =?us-ascii?Q?ePStniy54YCW678+W23tH/gnA2YE70Up23n91u6TfR87pggsrcaUKY6GoZ1K?=
 =?us-ascii?Q?/z45QXb5KTNTo+aPuhNB1cIVQi3P/2OHHh0sLxKk2q+Iu+1+qfy2WoN34vw3?=
 =?us-ascii?Q?SOt/gtcXID90/VYKfobBTsCqBkmlmNZSKRjTRckWLCbcnWzvGvKuO4ShBZ9o?=
 =?us-ascii?Q?7QyX1Rq7kFsDaDcoXZzs5LYlJPezGZo9rkheJD8xhQvYMKvroqXBpXZmcSkK?=
 =?us-ascii?Q?3kvrsTJ+ReWOfZo40LMEc0k=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0698c184-d017-4e57-a605-08dc328493a3
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 02:26:57.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ALY7mwbUhGr+4IgZypD/YXXDsXsIJMQAET2f0v+oOdrpVOog94Vzc5XAUwSYY85hDfxf6eBiRTAT+Swg8GWjv3J+K4qKoZZRbzI6F3GcOMiM8M+DH4eYn8uIHgAysP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0541

StarFive SoCs like the JH8100 use a interrupt controller. Add a binding
for it.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../starfive,jh8100-intc.yaml                 | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
new file mode 100644
index 000000000000..ada5788602d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/starfive,jh8100-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive External Interrupt Controller
+
+description:
+  StarFive SoC JH8100 contain a external interrupt controller. It can be used
+  to handle high-level input interrupt signals. It also send the output
+  interrupt signal to RISC-V PLIC.
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-intc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: APB clock for the interrupt controller
+    maxItems: 1
+
+  resets:
+    description: APB reset for the interrupt controller
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@12260000 {
+      compatible = "starfive,jh8100-intc";
+      reg = <0x12260000 0x10000>;
+      clocks = <&syscrg_ne 76>;
+      resets = <&syscrg_ne 13>;
+      interrupts = <45>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+    };
-- 
2.25.1


