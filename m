Return-Path: <linux-kernel+bounces-142718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF78A2F47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3FAB23031
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830018288A;
	Fri, 12 Apr 2024 13:20:42 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2094.outbound.protection.partner.outlook.cn [139.219.17.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09F81AC7;
	Fri, 12 Apr 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928041; cv=fail; b=uIGnFhxhIIFYQoEhA/cGQqhK0Atj7BKdqUzTMtols+8rg3R7Gczablmo3/eoLdZfDw+BEllDuT+j0s2xxgBP81cqKCPk7FCXcLVu92hNCIJMKJ4thXGuSYgazdoliIXxVWJcSAWA7QFlquzkbEot4NulAPUXxK4jKhsyoAUr1YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928041; c=relaxed/simple;
	bh=heDuOAEH4hH6Pvg6owmqRjKjqzmjyGj67G3STdt24M0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1uqvwul0BMffeMmG3baP8SbFavNq/5+f2rS68taxqbOQmOyXj28Y06OVIZX3orNbYHajUeI1XcosZ4+bfjhXudVfb9Lpg0azRdrx7nrljq1gb/3g1/d1ru7sie8Rlo2VctkOun8ATiYw2LmGdaiRncDyD/iM9y7B3E1ud8WIw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgYvFRkaYN320/Bky3oSXdHL8IZktU5djLqx5AONOyqLBBANrU+7Oo1B7zwwx7jfNi8r75SG0XOgbwyBdI7xK5PrYpUcdhSyZ9KjvtI9LThbDjn9jOXkt0mXkImfKY/Q+BYPUcq/QdLJz4DIjqFJAE8E6d9NgDsLNJV4GUhsn/PkkH+WZhQdQbGRVsA4b8kO2PCKxmQ3CufWstL49bYV/tPXvI2PQqBXqin8PsqdpOoS+LADfZkmq09cXZUPE7Lum+Y1dN2kob2pZ0k20F8Y0GiuV2HSWdWwr/siQIPjuWEbkdvdhKfTUn/Cy/ahZaPupZuNFS0qwI85eSVQJnGfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpqvJdZvPmycFfRZZCCSg4FFhQ3bjyafbiyaP+KjlYQ=;
 b=PN26FQvJeP9gfY8xh+tzTBNX+zkjExHzVjushfHOsu3y2kJIVe5hT50MWqdS9ITwKMxmE/tDmlcz0gvz2uXQrhGVSSO/ENXoCTK8M6jqaDqrgRhkgKf49QOz5gaTNIBDPM/NJCTasb0Ikwwwyj5yH5m91NTD8sD418o8mhTp4jmvmA6xthinHtky8DE4ehzjjG9UbBOIuoVB9LVzMTCIVcI34lijYNHccYvK+A4lnrHTNsPrCUd/RhxYO/pJInRJ2K5fEj2M3q2HjaYg7b+43jIzIgwUBNxlkiJjBZYPn8/8rwjbiGISOU8s2d/3vreF4nLLlzuFQmlp14K8dv7iNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14) by NTZPR01MB1129.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:45:52 +0000
Received: from NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::8dad:760b:621:c490]) by NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 ([fe80::8dad:760b:621:c490%4]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 08:45:52 +0000
From: Ziv Xu <ziv.xu@starfivetech.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Walker Chen <walker.chen@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH v10 1/3] dt-bindings: timer: Add timer for StarFive JH7110 SoC
Date: Fri, 12 Apr 2024 16:45:41 +0800
Message-Id: <20240412084543.7243-2-ziv.xu@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240412084543.7243-1-ziv.xu@starfivetech.com>
References: <20240412084543.7243-1-ziv.xu@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::21) To NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0986:EE_|NTZPR01MB1129:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f49b89-df80-4e3c-caa3-08dc5accf5f8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KMNpS7ooGXQCdJi/hphkTNRJugve8LIAVVfthk0OCDRI5V0aqQVcfx3rlnyWMtb24Q87Ia2SXIsaA6IQLWQ1e7EOz0oWt9PU6lqXPiknSVsnBx0MBbEICADR+NdgRNHdCOZo7wW46AYxVaVBYjy+vikg3gitym82YyUga3k3yRYT7JCui6Zz/O3YJBeCn9qKPT4LKqz3y20bZEOH54lA5+zxlwESMw9ml7puaa+gVmUOwp38/pu57wvztta5FKR/++43iLsRk7z3Ot6K2BaBZE7zjsQT6LywQc6tVyK+tVYguTRuNanhFrm46clXNAxH1EKRZkiNV8mB6DaYvdHk/zGmqgKfQal/DpNeuIi5xOYBh2Y3yyrKRHqdlICLdPyq2CXOdyoCKpEM7OjNsRWkn7EkGsPvegjzcwiwn/jxJxHj4GOOg6B5M4pNoR2QC+EFfshvsRbLXAFwkD4B7S0+z+4blsGjpnCrzb9L67TonV+dTjql6856F4Y2pVZzRFrtiph96cUZYeXToChwxLsNZp5RXMTITJuUwXJ4EoCfcxLQu0Q+fXhbphXR0BaQ80sBrWO358/b4JSYrWFgvL7EZF46bo1HCSZlRiMor2B/I1+TEsugGT9784dQ0jhBTJV5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(366007)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LW165sseLx9INDVgQEkLsoTAl/sjyPnz81vnGrhVfnOweR2oqEx+aPrCJCUn?=
 =?us-ascii?Q?lsnX06/TaPsPjm+oARUfFvTHA1195ivuNjbjPFhIKQD/hV21/s47y+XbC2wl?=
 =?us-ascii?Q?kn7cz6z3hGSbCVONnhPW7S3asegGnvq4YgVI8E2WcorISVF2uePIFCwtkhL2?=
 =?us-ascii?Q?HMhzHQvDJm7o65SVFRLl8CbZl7N216dMGRaQg7MtIWwp6qHHN25IlF+g8y6M?=
 =?us-ascii?Q?4qxFkzcOK64vmiCIzuhgUSmCAh8V2mRj2jyhWbmUTsxzv5YPXs91J9KL4QaN?=
 =?us-ascii?Q?YUbg4Ph2cKYggfQ+mYEcxNclzFHEFDNx8gq6j51S7Bmvw54uquueD8tZ7Mfj?=
 =?us-ascii?Q?q2dINhonm2YBdcVFCKMC9pvrUYwvnY+UAnPy+5oQM+iq2HGnKHDlBrP0SXQu?=
 =?us-ascii?Q?r8GPP70DDCZqmh8PeorPPSS6UmUEibZZBoL4xYGbReSH7IXd8ODLwGhEWBik?=
 =?us-ascii?Q?GbyAQPTgwJyjULlMLOZZJOYmQpb2C25qof9LeZireeaKWtM4FWecSWzdZ8Ri?=
 =?us-ascii?Q?n/yvA0t8ecuX67NJZOWXZa0U3EoeSAuiKqCRCMMkCk0eAxb5KkL4WQ6Tz+i8?=
 =?us-ascii?Q?47nnZ6dRuxtUZjfUM4XHOkBQR0XVOQw8UyonMmO2ITCwTRlmrP88Loq4NK6t?=
 =?us-ascii?Q?x8oePZfv+nutgh6AE952xofZlqD60S03sncu1Rvzz2dx/rwyODRVsmzyR0qv?=
 =?us-ascii?Q?o0XOc84n6ZL7SYX7Hr/76MV6HcXmTYaZaB6v6foNwFzEU1evt5IRV0LiKQyD?=
 =?us-ascii?Q?BnMPQVb+4RKDxy5UCz8kT+xsq57zhlvHaCspFCVsTj9GCwj4aM8feIG/Jdq4?=
 =?us-ascii?Q?+M1qQAOItiiRkuZagiSZ60kHnE51c9EBkqiNEAaE+A/w3X1D2A8Y/1qB0Rp3?=
 =?us-ascii?Q?VckdMT2tv1SJmfmYDQa56QVojrWXXAI0KaHQ57mkG6rqWvUoveRpq8rmZSb5?=
 =?us-ascii?Q?URmMXxfySOyEP47LaKg2W2B6ayRUj5BXexzsr4l/G3JbwRSJXNl4ijshaQE8?=
 =?us-ascii?Q?6wqCwszgiYrXxzRek13+TE0yH3t3QKjzxGSWDpio5VyaKHXq48u/EdkIrqTm?=
 =?us-ascii?Q?sHw+6QzG5QcI3HMeyJkIyB1+/Sm/AuMWYyLH2OxVJJF0QQI77FYRAdWtKmRe?=
 =?us-ascii?Q?f0pa8MFxJNFZ3qQHWlR8Xb7OJ9Es2iu3+FedVwDfWrD9BAf+R3PO/uyMOIKQ?=
 =?us-ascii?Q?25Lw1GKiNKPmJsAg/m+/Jzmg0GGizWbTeYNVhs2zKE1l8dsmepYcTYv8VgpG?=
 =?us-ascii?Q?oc5CT8irRK2MJH7hdaG9sigr0+n0VZ/flwg9abh++g4lhXsnkbLF5POeyqIs?=
 =?us-ascii?Q?AWyRACKfwH+UN9EWCnXm6XNuCuotm0lfRQQtninqs7I86Fw+w5nlpvbg3jHV?=
 =?us-ascii?Q?H8L34nX4+Tu4DJM3OmT7XstAem8fnMUIHNdaqRdVXq7sxnVLzS0wELVQU2ZJ?=
 =?us-ascii?Q?yMSK+rxFsid+8vpR2HJzg0EGrFnee7t+Ek/zpllK1n1ItGfceFR4Y8/XmU1u?=
 =?us-ascii?Q?/QvX2P4XpL1Soelk98qwOj88O5uSZIXuQbM37jjyEgtCsBQLkz3ijS82vid2?=
 =?us-ascii?Q?iNQ7jnluhtUKz8Vc2NCOWvqEe4/eF+a5JDn3HnR9f0L6XsPWuUrger/6B4Fv?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f49b89-df80-4e3c-caa3-08dc5accf5f8
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:45:52.7315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYthbWD+PpCPdYVhNWhwv8Vc4em/qEJbS+xjKQuoQ9xl9zAm06uZGsh7pfoGSxu05nbOR1OM1n2QlMoR5ramDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1129

From: Xingyu Wu <xingyu.wu@starfivetech.com>

Add bindings for the timer on the JH7110 RISC-V SoC
by StarFive Technology Ltd.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../bindings/timer/starfive,jh7110-timer.yaml | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml b/Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
new file mode 100644
index 000000000000..9a2dac11eb06
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/starfive,jh7110-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Timer
+
+maintainers:
+  - Xingyu Wu <xingyu.wu@starfivetech.com>
+  - Samin Guo <samin.guo@starfivetech.com>
+
+description:
+  This timer has four free-running 32 bit counters in StarFive JH7110 SoC.
+  And each channel(counter) triggers an interrupt when timeout. They support
+  one-shot mode and continuous-run mode.
+
+properties:
+  compatible:
+    const: starfive,jh7110-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: channel 0
+      - description: channel 1
+      - description: channel 2
+      - description: channel 3
+
+  clocks:
+    items:
+      - description: timer APB
+      - description: channel 0
+      - description: channel 1
+      - description: channel 2
+      - description: channel 3
+
+  clock-names:
+    items:
+      - const: apb
+      - const: ch0
+      - const: ch1
+      - const: ch2
+      - const: ch3
+
+  resets:
+    items:
+      - description: timer APB
+      - description: channel 0
+      - description: channel 1
+      - description: channel 2
+      - description: channel 3
+
+  reset-names:
+    items:
+      - const: apb
+      - const: ch0
+      - const: ch1
+      - const: ch2
+      - const: ch3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@13050000 {
+        compatible = "starfive,jh7110-timer";
+        reg = <0x13050000 0x10000>;
+        interrupts = <69>, <70>, <71> ,<72>;
+        clocks = <&clk 124>,
+                 <&clk 125>,
+                 <&clk 126>,
+                 <&clk 127>,
+                 <&clk 128>;
+        clock-names = "apb", "ch0", "ch1",
+                      "ch2", "ch3";
+        resets = <&rst 117>,
+                 <&rst 118>,
+                 <&rst 119>,
+                 <&rst 120>,
+                 <&rst 121>;
+        reset-names = "apb", "ch0", "ch1",
+                      "ch2", "ch3";
+    };
+
-- 
2.17.1


