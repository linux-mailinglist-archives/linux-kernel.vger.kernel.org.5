Return-Path: <linux-kernel+bounces-22984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A664182A60D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1919F28A6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265810E8;
	Thu, 11 Jan 2024 02:32:29 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2089.outbound.protection.partner.outlook.cn [139.219.146.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B421815;
	Thu, 11 Jan 2024 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Guvw9+rCzufBYPgUqT9z+6NSj7r/K2kAnB0pdS1B2UdB1+Z2eoFkMguwfpMDR3pcSYCzxVum5htvNH1s+CD0F6v8oZflSsNZ/971QtO1OOzfMEgpYdicZrFVIKoS4qOWHoPvjMvpHI6+7QorXGDoKKKehquLWdkXgTXcrr4MrIK+4c7y2f1J0E5mmTvlC4dgAHlo1YTaMU4b8nLcN680h4KcsfPttxhBJEFnKicYXJ891JDQh3NukHfKEbgonqeDCRZxbgryuC8g9maclg7KUB9v6wwKaC+yOS1O15U3Uoho0lluXOmXJR5JFz8/AzXeu1ya76XSn/9SxvUu52zj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcXTFRQUzyJPStxFJu9Id1doUpi/V8L0x2lNt0CEomc=;
 b=WVKjy6nKHIlE88ADkVro7UR77TXi7T4/oe+dYtzoClUaLK19rscYwPEecnhMK2kOo7jstYeqrBtGjtIhYzEVtxOMcpbKqF4fL2uG5wKsKYK+1Qo3W5prljR5rReQuxBFskSLelBlDXFJhsP6WGdDSprfFUTm4aHqE41v7sThs7HMb7Fyct/ZGZjaNNQA0cUcEOb0XtkwXdRKZpm2Faby8BTgpG8n81hD4tKibKGkjQKIqYfId9yBJAYuhfnyeG7Enwve5H0/4nHkcIMHdkZoSUR4pi4CFEhwFrONrch9LbUbiyxrNiZ6z2bAdC3NyE+PL+m0e4rAIDlxI6MihNgCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0859.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Thu, 11 Jan
 2024 02:32:10 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 02:32:10 +0000
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
Subject: [PATCH v1 1/2] dt-bindings: interrupt-controller: Add starfive,jh8100-intc
Date: Wed, 10 Jan 2024 18:32:00 -0800
Message-Id: <20240111023201.6187-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111023201.6187-1-changhuang.liang@starfivetech.com>
References: <20240111023201.6187-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::22) To SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0667:EE_|SH0PR01MB0859:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb5a4c6-212b-43a6-735a-08dc124d837f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YTfq4srm9VcsskVRa8nBKmCnLmEgE8iMWK0KiK9kUvV2MDpUr3yh8iTOP811Jtx8Rg4QDlCwiSyEbRemcjyB0Tlv4af1mFs2WqsCoW1iDnyAbj+3O4QQdyJMfNdHil9c3+cFcVmeoYIw36dwT9Cf+7Kf4Wg6p2j/COa9V/WkBzo0Dcl338BIZ2LREtDrtJJh+ZbeVBh0y+bXfDe29WgXNaUaD+xu2jAy+71BuK7foA/Rjuz5eLuA2XqJ3ifabLeGDVTAXcD7P7wEr2rKzELbUQg3eD/piSjXWWi3KYanVAE80orVu0NiDhUvK2/CCXkyQEs4lOBsB4A4A46A//zu+GTe2lzUFRCiAans5ESDlpuiJhfYMZmSMNzup9G5jd83rItaN8CXmKS1x2Rze7HljcqAeC5JY603xspPAZCOHkcNXmxTnpKA605V2tm+U6l36DAsteuEc5WWfZiXBQ0xc5pFRpM426FZkutjRG40ARInKRmueIbb4Amin6JvhWZc2yVVhBMWLt2vZCndaaI53e/aOhm1evvgfr02G09Z21rJVlo768NL5mZouiY9YkdFkWc99L/52uhso1eK2No87YUZTK2CdUE3CfTzd12geZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39830400003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(1076003)(38100700002)(40160700002)(36756003)(38350700005)(86362001)(2616005)(6666004)(66476007)(66946007)(54906003)(83380400001)(52116002)(966005)(508600001)(110136005)(66556008)(26005)(40180700001)(41300700001)(2906002)(4326008)(8676002)(5660300002)(44832011)(41320700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YrAKd8cxSSfCYFVhrcCInpv0lFfRbrlz6p15IOiOJZvrukXjyZhLqjGimpZg?=
 =?us-ascii?Q?ngo6wBA9GPcZfJfHOCh2BfBYCSQq5UUcPR3kvIWiBgeqO3OifOisYyo/3tTK?=
 =?us-ascii?Q?O8uX5eRcky006nzRLZi9ryEqpEj0spiQfTRWpkBqpd5wlz5aXzE5AFrNehLQ?=
 =?us-ascii?Q?uKkMUD98cZmR9nVPVg5X/3u6kAxBmKXpjc8/O4v0H885kMElmwzWuf6WE6DZ?=
 =?us-ascii?Q?MWpkuKTu3A7p6JDLat6jOm3ZflXZshJTUyzz24YcPvQY3h+FirjWNsDmFmxW?=
 =?us-ascii?Q?1qkG6++20qn25r52JIiq0ZTeWWLkDyK3InE5uffD3rvHd0xzqxDoNiGbl6RV?=
 =?us-ascii?Q?m2V+wstNQkMobcdR5/K+Rd7dlLjln/O3X7ZsxgLsGCg/lehjzMiPfAmhAr5x?=
 =?us-ascii?Q?/Hm3aaLhA2S7K8RYAFdquIyouSHzR3iVr58jsPj/IOQXdpyPCjaLSPrSwTPB?=
 =?us-ascii?Q?gcCymwRIgf5Ah5qtNqcxcVlfO9LIHqC13KnYPuzK3qtzyJ37++qn0z+5FEtC?=
 =?us-ascii?Q?9kJ+P5Gr8yCmNGcubFoY1OJgGW1EKMjfBuU08kXTSHRM00DjpV0lM7S5JrEv?=
 =?us-ascii?Q?bV3sUxWaNjRwoBibtedmnuOrF9fOc3/vm3XKVTPodrhm6TDmGZJRrj6Hy6ye?=
 =?us-ascii?Q?hOMEtMtG/xg3Ck3loigywUs6IAjUF9Bn4U1LL0YKpiE26aE77OhOzpN/KfUa?=
 =?us-ascii?Q?Kv0pWJAGwRzEkesWajr3zt9on/K5Fews2T9tZD0fecYPyk3BvDUMIaYgyOYq?=
 =?us-ascii?Q?g4V2HpRAjPUHE5LdG+qczU/Nwjy7wIwVWkdCcyiCBPyOIS9QGeZfDj/7UhdA?=
 =?us-ascii?Q?JvpQowZqWur8BGMJGFnb9fG7unpJGx/xN50HrovS1LYWwiJ/j0zq2i6qh7H/?=
 =?us-ascii?Q?R3xuc57OWo57S1daQfADfScLzmwd9MUY38eTIrFatq4sSiUcdernayS1JpNr?=
 =?us-ascii?Q?RKwhyd4Csq1Kh87+H8UZpYZZbTwDbf7rkPKhsT9JooFw03j8L1UYO2k3q+qY?=
 =?us-ascii?Q?urVaw+ov8kV0Eqdv04j/QqeP9xqJYOCPNYcAY1X0m7RpTNP7kp9YNMCMnZTh?=
 =?us-ascii?Q?sGF2X0qsDuK3euPLOXh5nR+02MY4ypEBDoP+qHFx9I9vKrEiVVjYYlwPHWlW?=
 =?us-ascii?Q?EUKlqXXK3MGxzJDZhdwjxTw5fuW84sXEpGlu487LauVsWtuQGy3NLaL6Pf3m?=
 =?us-ascii?Q?t0m7m2CmCNE+o3+d0OKMiScauKs2gljj5wPGwFXWPwa5HESij5nYEPDyIusr?=
 =?us-ascii?Q?Djlxgs3SaC82iTIWbStB9Wb5vmkyPnk68p5XJ2rXDC5OqI94Uj+iNL+zEdNv?=
 =?us-ascii?Q?TRvazETbq/HaBtjV5uAlUP40UDq2m6FfVaK+diWc+DbnaxLYBEooZb7mimpv?=
 =?us-ascii?Q?3tC0xCkwg70WZVrXrCTow/pzWRwjiD/ZBVrirJfO+5UX4J70lT0KrAxsK7MN?=
 =?us-ascii?Q?/IT7EbEcfcAar1M/m5H4XL/N+PafdkBM4nuaIzWOtPnsr0EBXX6mQi5Jz0no?=
 =?us-ascii?Q?iGYkLUbuquc1j411yYBgOkEGR+W1rHNuTGHjQeoYqprK4+FR6z2qY6XCx/pO?=
 =?us-ascii?Q?Jac9uDMVAWLJvJMNvJQHpNelP5MWR5aPbyfLYh9KOfot5Ic+UdkqFIjG0dCO?=
 =?us-ascii?Q?+PDUtHi8Zx09I53IVd6LV+M=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb5a4c6-212b-43a6-735a-08dc124d837f
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 02:32:10.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tHK7afkii4Kr0fce7lV33yvv/JOB/1tYHgaXZdQ3Xg+wDJ4ZUMmZVm29zU+jvilpmDgoRxoeDNtbWsgtO/ba+J4jruq/3ltCNlLDsn/m5AiZVCKqMuZXrzlb1sPqSo/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0859

StarFive SoCs like the JH8100 use a interrupt controller. Add a binding
for it.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
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


