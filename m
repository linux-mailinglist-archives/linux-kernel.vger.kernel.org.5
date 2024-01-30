Return-Path: <linux-kernel+bounces-43976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B21A841BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D6928B02D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F365738384;
	Tue, 30 Jan 2024 06:14:57 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2051.outbound.protection.partner.outlook.cn [139.219.146.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36738DFA;
	Tue, 30 Jan 2024 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595297; cv=fail; b=LK+BZMNAmbfnKBbm6AVFwHFBHubSoGh2JgT7EwcV7vWYMC+a8wHyPrYSzoE8WMhvYr5WKWJn9aOJ9Fv5WeufFI7RlhLfclo8a7EUxpQ25UG7uJumRRwbBoMMDxXCbvMhvp/v8Vs+Ioafg7VENJ3qP4chV9CYiksAgyCc3AItcxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595297; c=relaxed/simple;
	bh=0yiPhBPD0XmSqNgTotKrvpZyiaRRfpNFEnfcDBEKB/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2liyVZYkzJPAYvFmxpeL+xq6oznGPWFK5///8McD5Vh52zkmV77wcXRkl9o95By1m7jhsFmQoLbW2Sffnq3TZp9SeZGewY8tVAjj495gwAKy8sz2ZjiEOTiX+tTjSLn8mDvci8UPJ8QOmq+FYqtzhM8pLC97R8DiUYuc+V21KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7K0g3MQN9ls9iPWS0crvGWHiHE45WruiE3gu00ytar7MU0AA95UmEuXY6rKt4uPtxsVXjAFUXjIaSQVS0TVDFl/t+dsYkYaSAigq9f/8yWXIRPsoUi9C+i2ENY2F/AwlWhaLkNzF0n4vcrthiz0OlxXA4aEOPEKGUkckzngJd/mKRA3K2w0aprf4jHMtz3yzRXXnDkakOxWRcoN651LTN8l67sQ2lKyA2sVNwweUP/FPN5RUkjaj26Sci0Dvu+soh0IHiXyE3K8BNDDXlZswV/peWmqt7NwZxLO9Pwl6lEB0+ckGoXJiBaVlhgPUQMafBQDJGjC9gS6pk6hbQ8QDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WITnoB2inaLbaJX02D9zOEJin+aUqaAEOe2KuvSRp8=;
 b=gK8vmOAK3FLa+GBMRWgco8BNwZHjWfFy/AQ6BBerR/pOLMNIyPG3MSIStU1Abpmnj7yW3SsmDGXFAVTDu3IsM0cCHKjl1nuX743W9m4NQl86oHNC0kiAbNI877YhXvJan/oXa007E9IpZtnTEz7pyWtGK57pFQcKWzon32NZK67VYerVVDRzGfLvzWBxToLfp5YlcHqr9VQc7SsZlxtgm5sKIiCJtlioCItltWilX/zhmKfGjSAlXQwUHtR4wYe4x2MyavG/7hJjUatyho2vL30Jq/i8OkA7DXzHx/CYmWfJ48cQ/b5iQBx6tBUybVcksX/2KxtChqJonTCQi9bwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0878.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Tue, 30 Jan
 2024 05:58:50 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7228.022; Tue, 30 Jan 2024 05:58:50 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add starfive,jh8100-intc
Date: Mon, 29 Jan 2024 21:58:42 -0800
Message-Id: <20240130055843.216342-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130055843.216342-1-changhuang.liang@starfivetech.com>
References: <20240130055843.216342-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::8) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0878:EE_
X-MS-Office365-Filtering-Correlation-Id: 406087dd-c546-4ba2-8524-08dc21588829
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	075SCM2BfAxPxveIG4Eporp41xi5YoMFXPVk34kFSfcfvj1PyDeyG6K0t6LF5XMDzDnDU2zk9UJZYgfSMULeqPwCworOs75zRlfjNADKCgqqVQsYZUPoe57XnGbaA3P3FyYdZ7wwSyR/vMlLQ10S78yqn9FmGX9YPuKc9o+5vLU3GGNDfGlJI0A9RB/Ceg1bW/TOHoSf+N6cnQqN/7UpruGkf//U9qRAla9eDrfxWYlZug8TnH3PhmYLJNLTdjgYUkGMoYRZNYL4yzF6FYYLPkYJIWeAn09k7R7PiKgI9uCX6BVGRs32r9freA7RXTEmZ2ifIAD7pflcoLaOKgzlZ5Ep3I9fp7YQhvTk4y/NSD8OW9gGbIQiFSXUJRG1BCExe/ABZFAZxvQs1gSOtFxEee/4pt8RINmDsBFPxsdjl/9UgSAVRNtLjVpYqdQTiAhZDzRKIBvYNN/DXSIYYIhVccrzf/zwuzWvD4qQ4uuKDMbKPapBh+6hiS8nB4Eykug0QM4PAUN+4op+4U0wb+UNOxoXh2arl8sSfeJxLYdz7GMYanpGCTyVzFHf+v6tnXV1tAxvRbBOJYA+4jP+g67xq1IRU5P4yOxwEU+4DwRvu48=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39830400003)(136003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(41300700001)(1076003)(41320700001)(36756003)(38350700005)(2616005)(508600001)(40160700002)(40180700001)(54906003)(83380400001)(52116002)(6666004)(966005)(38100700002)(8676002)(5660300002)(110136005)(86362001)(66556008)(66476007)(4326008)(44832011)(2906002)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7G3+02eqoec4Vl5lp5BC/oXOF4urikTnYZlWQGi1U+OKuppGYDjhBlT+VUDF?=
 =?us-ascii?Q?zXDuMZ3MlukIdVBDTo8J+Jp57sYI0alo0Au1sNoxEQFgiFnugxpmOSs0YhLe?=
 =?us-ascii?Q?WCH0smi/l8f1WyEItOPLigKYyjzPV9E++X/6nnUrejo3LLlNVwFLA8zNQPQn?=
 =?us-ascii?Q?NHBZEH4ygwSsyZYtree4nM70VnOTXboaYp0wx2HfP+qmoZcUowd6DVATbpuf?=
 =?us-ascii?Q?ItRa9fdu7aATQyGcOv6pkgltwlFlI/wBBRuHyH+APlMrOT1n7H5G+JCh2orH?=
 =?us-ascii?Q?rundexHxuz1/QoJdWX1FDEH46ddJzBngN7TkWFclrDoy7quTCgSAxMMIik5A?=
 =?us-ascii?Q?uRVZY9AN9sjCLVxe3T/uQdQSE+oSzJt52PPycx13xWfwwLuMv4vxYNJKll05?=
 =?us-ascii?Q?EJeohesSHzfNsVLvU+Wu+UayDHwHjB9yVRAzbixGTlv+NlWT1dRY0dr1izk/?=
 =?us-ascii?Q?XnWw2HjgAXXRSo2vMEq9ScsUwaAPTXpXNLNlybiGevP45AEbEcDHZsDYqcCs?=
 =?us-ascii?Q?MuAUduMk/bjdWQCHXHqsQNHGpX6NMSCHyQr6JQF/5XpA8v5HV2ZCCZzLhjnw?=
 =?us-ascii?Q?RQtXl/hxk8rDrTP68xeZtM0YyEyinWN71vJpZ4XeZLcXDbkLeIDbqvL0II9I?=
 =?us-ascii?Q?wIWGNgWIsUb8Hs1aS1zralWkihmX25iIed0p5SR5xMPjFLw21s6eLrL2XS5A?=
 =?us-ascii?Q?ydLCZUfN7Io5kBz66xXR5+nMLkZ6Rya3LSXNZNdNWUxS7MCAhYMyIZpEO1TC?=
 =?us-ascii?Q?r+UnOj6RI3F6s0bl3lj4u4bWQk4CWo7O0dNPiJEtAHTJp+dq5rTACPFL624F?=
 =?us-ascii?Q?7cHKmIAmKtp1djvhizsQDmHMHhkoTltEh5sI/E9e8K6mBmn1XfyjznXDMv0K?=
 =?us-ascii?Q?ki8bwdGlufvzLTAWSgslZT8Ed9Ih3t7M9HHtsLPlOUaoszHaM+0MwE9m3wtP?=
 =?us-ascii?Q?DzcG6KAwAOX/2hEFS6geHSl4TM+CALoBDygL5605QLWNl5yYHRAR8a67ni9P?=
 =?us-ascii?Q?6gQspEVlL9uG8ABY3QbGUx0oFI1nAoyqqDuIT7g+BS1BqkS6UBCt+DHtT2VW?=
 =?us-ascii?Q?gwutEosytRuSsgeOvNfTuT9QBNdB8LwxGahShP20mO4cVQAKjEjx2aFg0V7d?=
 =?us-ascii?Q?/JgR6uom/QdMD+Q2PpwPKyZs4oFO2eM2+O8hNb6r1VadG/GmXxFsM1ENRvSK?=
 =?us-ascii?Q?PXWCi7wS09SIg/FrWnXpvDpHOrZdbwVKTpHnINn4ZDUUBzIyhiJ6qUQkw8SW?=
 =?us-ascii?Q?znRYKcRCvhj5kaSbfhnemUk+wmW2NzwCy5coUYJk3deoj1FuBmFrftNyJcbg?=
 =?us-ascii?Q?OZFy4c21uPeMve5SbthkxhfzYJ7r/fzBmf1vsw80bRdyAB98B6+0SJ0OMP2F?=
 =?us-ascii?Q?di/KHj483nEYtbp/H3sMXkYXYO6Zbb56KGIoPaZMMPLVUbE7ZcVKG9MoHvBV?=
 =?us-ascii?Q?mhUUvYCedjko+d26vMaRJlY4OmSxVxQ6/NqSyKg4KhXIlVo4gvQ0EXHGp/90?=
 =?us-ascii?Q?5kGWSu/cXTxJG6ZkozoMaf40Xzi+Znzj2TczxiO8qUrKs3qVoX5TbwJdKB/b?=
 =?us-ascii?Q?aIh9t9SjDDDiaOjRKPM23hHTZND/oXYa98lA7o66t1vJs+NSf1cdcqoxJTA+?=
 =?us-ascii?Q?0BFvJM5Rwz7m5sQwMvdwqmY=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406087dd-c546-4ba2-8524-08dc21588829
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:58:50.6182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQE8kAgjBUkic6TIcAjUSq7OistxClxjw8dkSdX/gN0i7tbtOgcoGMeqzaQwELYfpAS4FVhSx98lEqy3xH/XaEtsL/30tC7dENS9ZZDXyD3zdQx4q2cRCqYrEvlPdApV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0878

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


