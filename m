Return-Path: <linux-kernel+bounces-80588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEEC866A01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796871F22BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0C1BC56;
	Mon, 26 Feb 2024 06:23:51 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07CC8C7;
	Mon, 26 Feb 2024 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928630; cv=fail; b=jpyufh3yRlW/PE27yPS92Vqwh2EqHzrYwmYGaUapnZAHUzLtNK7kJH2cL/boXGf0nTN7EMZ/Q1PpYOctX31i3Vsncnqbioh4A5b2J5zFFWWWQmBPr3YD27YuR6J6xJa6lOUcC06FRcE/6saRaRO82XOHXf/jIF81jlVwlXQNgzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928630; c=relaxed/simple;
	bh=0yiPhBPD0XmSqNgTotKrvpZyiaRRfpNFEnfcDBEKB/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWEMbnDPiy3GC5ulPInS1IrPQPC1pUoEfER3ETL2OKmovQ1XyARhhdFeAg7A3k8chQzGecOiSAYpnzYVOwtlDMVWgcJJeB5/JlXlrbRgZZ8hZFrSIGSqpztd6Dk8FuV1jFUrcQuqlZ6Dk6Z5jgcQJMP8QF9oBJgcU7+XWip4njY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnWIW8aVZrmj4YRHJxxZq/4cJqPNcDePYVlO+u7G6k8WgnLa08yFIeKi9PHcCt4laTXsCgO81lKHyAigWNSrDfJWbbKOD6SHmyTOE9b7gssdjKIExn6sRmaWW8VlO0k82D4YX4As7uUJ98bjzx+o8EOajNWBBgzQeFjbSGOCM42vmrdVIIi+9UHgCWr/KIKOb4RMUSYt+cN5chAvOexy7N8i9ZU97WFXCt0u9ZuL+nVKsWwJkI/u/+Bre1h00zpLSdiYclGaCKsZHFsm3z+CdrSu23FCb57Z+cfIJiTYZe7H+8fsn17q5TjjuLf9dNiuLgOF/9IUhIz0BHsAW/+8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WITnoB2inaLbaJX02D9zOEJin+aUqaAEOe2KuvSRp8=;
 b=DCrNe0KCMvAVOcXEoiCnxUu/rZTpMB7JCfObXbYpqfwdrzEPfvv/UcB83LzJJhWJwuZFPnj1iQoVXG0p1GRVMuycMSHQzAO3DTa2/cwi4IM8FDewHSTO8HeUwk+UQylu/cxKQBqBHsyOCZ3FSdDVgQe34bWqiHWgxx7jRrsIsoxvHgo+c5VxOgwTRdmXXqGJRL41d8rw1fsWGALfiDLqnrO9p81NRgmTkFdfaKcHUIC323PAkAAnv6I+I98AtyCshKsZxWnyVHY15f/b+2PAzGBD40/qAZp4EUVg2nbr4/PlmWcauRmYrzkoh0TtK5kcS5RxjLXn2Nrb6nIpoSb75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Mon, 26 Feb
 2024 05:50:33 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Mon, 26 Feb 2024 05:50:33 +0000
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
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: Add starfive,jh8100-intc
Date: Sun, 25 Feb 2024 21:50:24 -0800
Message-Id: <20240226055025.1669223-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240226055025.1669223-1-changhuang.liang@starfivetech.com>
References: <20240226055025.1669223-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0006.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::18) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b016a4a-93f8-4a82-5625-08dc368ed924
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LBRAdOlNbW3i/hLg/jOWACJ4MRKxAQIkJsX9dbFlIYoUEjNEcOdVoJTNeLSsTO0gk0eUKTaUPc4IPJM0K9eiTMy5tmOOWRWMRAn8s+EUKftvpQkn/0IfEiCRqeuKB7zXIlXgRlUJUc26Pt4kzLeEdblqYF70OTJ0SwTaek0INVIl3QhwEeGPJZJafRFrfQW+T4wTQxZkbsYeZkydNkDukHt42UlofuH5ZKI7zurTJcwrLWDpcbv6CRUMWdI4s3OmrCkzw73E8K9BXmN0syhaL4z5RjlX3TFbhBPVimJYR5HHMAZgzeJ//AU6IGIb6opfhtckdZ0scwkLhNnCUX2ILtt/iSCFl1Y8nmkMEi51enlvsyHZweLH2HSprtSGx6IppQacA6IYPKWz5eBh1E7olKC3nHe8WUH0g+2CWm/9YeCXpXwKjOjNK8aPtVUXC9Xiaf/UA/zstWgPHerEJ2lTCpAugplRP9uyTb2xQbL87I5acDPsLuO3b16HfAPLKEb0Ge3Wl1e0jjkNiTf57DZR2dS0fx5x3woOpuPkMEewaX64q498u4QK+Z6BjX6gBYrOKL0NPF34uariLTvy58wWmr+L50HzvXwx5ylxAkAHxHKO4mc7XODXZ/6sNvCxNT9U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CLLR9CvHZL8oLLT9tBHlrvUUt4n9UGau7OHDg2oxSggK22itybpfQ/ChLQ9b?=
 =?us-ascii?Q?H2dgrpO7irGYqyTRX6PwzCVKscY4ZEKAZlLXMgZ02lNhxavsVDb1+N6P5ilB?=
 =?us-ascii?Q?adiIl7yzv+tZo36aLAY8LQtAtT2OlQjfamvqHowABbXemmuGs1iPG5E630x6?=
 =?us-ascii?Q?1XF4Vefk9Q/CjNsX9PrB8UnqfbWvK2x+Cm0l+B0Ac7TwpS1FBZrgJume3jo9?=
 =?us-ascii?Q?2ldQxQhmBbjFafnJwAc/NPoRQoJGElkqKMcTt7xZ4jjp1+oahgsfUz81efyD?=
 =?us-ascii?Q?Ep2GvjDMOBJjym5qT6JF1XEDZCh0frSppOKfwRmUVn7BTVkOGSZ2bbc0orlK?=
 =?us-ascii?Q?hSSurNvylfkV0ZHw3RJhvddTUfDnrm9oOjKSYw+sCy99FioAFqN5K4WFb1FL?=
 =?us-ascii?Q?jpTXmzg1VxyukwfP2138O8X6dP1HEfUtgRb6/G5joarHOd59khaEnZjTm8Ie?=
 =?us-ascii?Q?7P7cnoUM2f0Rl/2wBevQJHiD1Uq6dqYodei8AVvw1rcPZ08+wv3QSAnEYHVh?=
 =?us-ascii?Q?z90ee6FN9Inn1ixWIVKmBalyKBOGP/PPxHDOPTkpXgkQFzC9p6/OuQZY5CFd?=
 =?us-ascii?Q?lKOSkR3uUdtTWjRksIAozuWLIeh8/G3/63EROmep7Zerid8Sr053DI6BcI3h?=
 =?us-ascii?Q?GU2/tUrxZ1iRhNOWFsLLDPtiVmI+aNV6D3HY0TNPDXo+atVpjJRIjGodEaQI?=
 =?us-ascii?Q?F+vGk9geGw1WsZYWvOKfdLyDf/oondQG0IRhMEnFwLSC7Y7n1kTJ9aDYK24b?=
 =?us-ascii?Q?2KFu2CQLz/kUAAknjMoJZFN1/CdYCNkPDn9BEzjmq2Kq58/11xuMkg9KfAqn?=
 =?us-ascii?Q?dsgX5HRi2TmAwA0pGTU1+yBf/w4O8hKbqiJK+JLTE6FjK5meLCNM0DGRyqE/?=
 =?us-ascii?Q?THjGnWg+dPRglQXAZ62aS+j+YpUKtBNG0y5oAs207s2cjHejCPOvyJpUKdek?=
 =?us-ascii?Q?iCtYAKTMoEzOpo3NFu5ERzFaeVCzxJyrWs58OY8uhLf/eYc5HM5Gtw8BTF5f?=
 =?us-ascii?Q?poDAKzO322Hl23+6Q6C7jYFK+lgpFUL1yKrvcQbBs47XToP2NBVPEUU9UcD6?=
 =?us-ascii?Q?mulRaplKq10uA8YjqJPgYevPDrKLysqkAITuDl27JEcCz6qq+H1fAzXTt3lu?=
 =?us-ascii?Q?4IY0JytScUTKaGw18e4k1AVcX8L6fZl6Ad15whdQAntboBB4fpRx02QNG+C4?=
 =?us-ascii?Q?9N0oBp9twgcgyMtQFbkvb+ktgym9UtcYHUbE/q6ltH3LQlXUPVvrITNxai+W?=
 =?us-ascii?Q?c3uhzRT4cBeM23DJzi91EtrmqjZlxujUG9k7Bg1Si1tYCCWIcY/sQ878utHu?=
 =?us-ascii?Q?oD5DgjEw1pzD1K9QWlpZYLHOoALL3qiF+ygR5qPlzY6vUxVNwVdJPYkWKegp?=
 =?us-ascii?Q?hGaZuhjNHaw2/qtnqSnOS6DqU0rfwB+2M1d9bds8s8sr06TTdUJVGFxzg+E/?=
 =?us-ascii?Q?dT7qBXWUa7HlHm62f3zRWwMu/SORnbURnL1baGWqq4fCW2tUGSP/Tr2i308k?=
 =?us-ascii?Q?Z6MbI9p2AZdiGA+US0CVNP/exn6pUNB7OCq5AIvBqyfMvsW7QNUi7GOpPs42?=
 =?us-ascii?Q?B1+uKYqa/oloXrRY/L0KCOqmgdlvcJVxe9rDmfYaHIId9X0l/0esjj5o/GOG?=
 =?us-ascii?Q?tWwBXQEZEbKNzmNj1YzGEWI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b016a4a-93f8-4a82-5625-08dc368ed924
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 05:50:33.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccqN39Wz2FIU7E6eRP02+XA5Z436pHUvTQXVeUbsIOWmsy8MBXZ6GMWq8XtZ9iHrW6rzvOS52eyFRTp2T9vYcac64Xoy0hyEoT99NaG9mU665gZsPAPo0xL3o3tSIkSI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0671

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


