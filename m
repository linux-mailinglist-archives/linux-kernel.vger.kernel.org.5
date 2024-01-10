Return-Path: <linux-kernel+bounces-22239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB178829B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F08D4B268AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D874A989;
	Wed, 10 Jan 2024 13:32:32 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2051.outbound.protection.partner.outlook.cn [139.219.146.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411EB48CD1;
	Wed, 10 Jan 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9Dhd/RI8nQt3DqPdZrW3hPyipZNmcQSM5gXanyow4H5fpE0um/Tsgf/bqkurGnoTGKDE6SZzrtDAC4Rrq861ZHeJVcLN7xZL+TpZU4Wa890jUAHdxKEFFM2iwebuMAKUMAXrlX8lBILClBE0e42L3Z/4kIyObuL6xlumzd4tS/2wMmnRhIw+F/G5StcuCocEx/Ky6ifDoHPERYcLi9Ib+DXe3nlnLRhQbD3BrRSwqbUPyfOrhKGiW1XLQ028npBPHpqxKkdaxHLvtyy5NnHnTVkpyzg0kD0z5ThdQUdAdpwhQsHruf3lRLo0bcvWatsjcE2GxMZjxZzILroJhxwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU9LGUodSYF8HlW85O3jMRxtjW3fOMhLWffvuLaN/5s=;
 b=CqACe1ayTJbCHUtikSvTMdmP1/t9BcYBsa+tx27vWGDMpm0CwW9oOuQ0MvyqQ/9jsNqB/CASiM7IIDK3AewWfzD44sK4dBye8yrPQ5Se0golEEoAvla3lVKdlK3kxUq+GekklFBMg8/3sV8PCm+Uo/N2GvokZ7bHk1xWV6/lIyEKuAjFSvH6hsf15n37kfXwmQRVHGmwtYX2AqsPg1I72C35jfarjFq1ZUIRrL0Sr7iI1vNkOqoIxfxQyjZe7CsafZAq7Ni/6vmMrHgzz85wrI7m8H1nbiL08o9nt8YHYabtG0wDVVzixiPMPAQWNGaPsDgoAVoXy5ZXprsBPROdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0626.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:23 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:23 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	hal.feng@starfivetech.com,
	xingyu.wu@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	jeeheng.sia@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC v3 11/16] dt-bindings: clock: Add StarFive JH8100 South-West clock and reset generator
Date: Wed, 10 Jan 2024 21:31:23 +0800
Message-Id: <20240110133128.286657-12-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0626:EE_
X-MS-Office365-Filtering-Correlation-Id: 004116c4-307d-422c-197c-08dc11e093fd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+BzRyYS/whqGOfR8sjmardiJ9+LYHzwhO3ITNa7KP7Gh8iUzKE3WjYE8KfhzuiRy/RSNDL8pLPdkM8prImixsKzf2xRMmhsmuh/QpM61/A1yAWAQ0Ct0aMe93rAiOJKosE0CXLih8j007KhIEbmd/nKQLfyPpjE22J0jkjtBDv1Txeafbq+P4AgLwag3bj/9KIJGCECGYWc146ZLU9Ru1V7R3iEcdyOwhhz7adkD7TT5J+jYuW/rA9TWtCyR3oGMdszfqtsKMWIWfg2FGeKjvA9WgO3vNpNPStjMV2Bg0BnvZhBjW0TCx1JWHYG6WXMTWje0TTz49sjk17le2nHKBpu+Tk9m8wPw7g8R239u7JC4tSRtIi9iPtuGUgsRM6t4UsyJ1lWPnBLQTZok1F0X3WAEhDUzDjJQcK2NsJmB7+3DTmJuj/4AVt74qZuvwo9HvpmXSU3JRn/rRdeEZj6MjewjJFo9v40rA9AbQnL7X/0M4O8wKujB9tiEvYqE8tN9T9q3XFIS9hegTU81C4ipsedGftqabOHAu5QKdQrLjBa9x8bgCXu8sCxGlYXKqPnX6jKISY+DWy695fFGqT+WHQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(921011)(26005)(52116002)(2616005)(41320700001)(83380400001)(1076003)(86362001)(40160700002)(40180700001)(38100700002)(36756003)(38350700005)(5660300002)(7416002)(4326008)(55236004)(6636002)(66556008)(66476007)(66946007)(41300700001)(2906002)(8936002)(8676002)(966005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vaFNxaqH13U1H9C+6ns4QeLFVkza7IOKNOxq8kKa0oGQ68WMMt3uH224Rq1U?=
 =?us-ascii?Q?pRp2181b1PZs3dzWLO96wiMjKX9Mt6qvfVoapDsY524vDtizY4xCOyWMTC2F?=
 =?us-ascii?Q?bYbGsBroTNU1t9sd5Kzw/sMvELTlF4U2CQkWxl5B0gxRxci7XDxXd64IYmhp?=
 =?us-ascii?Q?LQYDNqPWP/KRM/Z2pPgSGVf0Bj4CyRreaQmM4Jv7Grgze2Ym6MCr6O0pAV6h?=
 =?us-ascii?Q?BEPL/XAD1YWcEm9CR8QfM1BEpgpP6uNUwLJPQ43l4NvQefsogBYobjEcVXNV?=
 =?us-ascii?Q?uiETibp+ogi5WqtcgMDKG3/EKgl3EKroXXJJ7o0/3GgVHvgMSv7GhmDQtUmk?=
 =?us-ascii?Q?VJ322sx1rwGs7xRCoC2nFVlUFMT///TY9sIyePR72lCwcDtLYzm5GQkihzJS?=
 =?us-ascii?Q?5Mvb4WofrZXQAha8EvJ3twj4p3m1VsqFodTdJmanVeykS4SVVc1gsixhY5dZ?=
 =?us-ascii?Q?mkeQgQ4BQBrpojM9U5jmeNgbJpit5uZPVFEDIpRKWzXV3u5DAYz9blK22F2w?=
 =?us-ascii?Q?6wGe4seUhYDB3E3rF/zHY4ptblkMajp6oQoTPw0hACQsBnlVfq0Zv7jl1zyi?=
 =?us-ascii?Q?lWEq8sPOLtE4stiU0FdvE72tfao+FzFmuFjFFHdMJNnjCA2SFZIqy9jMYZsV?=
 =?us-ascii?Q?jP0fUW15xoKNjUvNmrJ9DlakEHcTJndj2LIqOQTSRP96P2T442PfGXxnAIV4?=
 =?us-ascii?Q?fMcNjiQ0uZFQmMGp07moGgoPwCs0DYxT/fC7q9GXrd9Vlzl+Y05NYDvEjA3b?=
 =?us-ascii?Q?kcT4u61ZPLoYmMN69kmGwJiP8u7nDpxOLsZ8Ru/Pk8nL7W+yVPePg4DRp8L0?=
 =?us-ascii?Q?2LWfyjBn3rcQPj0A2ZLjH8sCHHZWDsue9Wh+t3+vjk8zXgYPkIS/9Jp96z+f?=
 =?us-ascii?Q?U0A5paYZCqGBFQOH5W1SMgisJ8TtOZntE7UofwozvBpMQ/iT6saCGEai6WfW?=
 =?us-ascii?Q?oulCoUj5y1EB/FLQRYwSnQZe6tylBD1U16XkEgvHZwyWv0LigRvv8tZM7fn6?=
 =?us-ascii?Q?fy+8h4XPzASR8LPm81lvHAKTihoz0frtSEftEZpbzm1AIBdvpoeeTAbLD61t?=
 =?us-ascii?Q?mnHfdcwu9obYi/yxPFckyCM1FEZ4kcSv0ExFZqAUcMDqpN4cjf81neZpOukD?=
 =?us-ascii?Q?yUw/q8ZqxN9gFSjRfEu73iskXL14EQanK4ScmAQevPnkX+Nw7Hem7DMY3dzJ?=
 =?us-ascii?Q?qsOsIZaFlzhknklUAMIx6PB/aConw0Vy4rvPMMhfDISQBKRIG8CxyzDf0Muw?=
 =?us-ascii?Q?0TocHF+NINR3TkyjG1MSCHLla04I+KrLpGm9T4aIR/PHL32QlsracifIHQZq?=
 =?us-ascii?Q?DApZDMNkIXXC6NlYCixUw3L8UmNmeZtSfqXW0G42FlUuD1U9pcUY7rB4vJ48?=
 =?us-ascii?Q?bYOphsGhmiXCj/EgXv0e3QqQRG++nAfiIq8WHYoWG0MWdn1NWTxzrfmEsrjw?=
 =?us-ascii?Q?AovXJlG75z4ku1xa6t/Z4kGpv8JmyK5exVlxpSaPzHJoXrLqD1N/375tss88?=
 =?us-ascii?Q?SJOcsBI3gM4ZpQeiVI3Rs9KbZSrFzM7Hf4usG31o/B6vU7AZCkzCdTwquNKf?=
 =?us-ascii?Q?05y1QPLe2kSWbSGa9ZzrheVRXPcdrBD4WiNKCdrqPBTirsBXszGC01XSKWO0?=
 =?us-ascii?Q?N2Ify6dVJkBQegOInKCNieM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004116c4-307d-422c-197c-08dc11e093fd
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:23.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuXB0g0EY/684ohXJ6xvPu1DYNeawsMN9P6+zhKDwfHWHuPWG5tov/u/XTxnI9ubhBAQnPnkZFtsMGsk1c5g8hpDfz8xicHl4qz8lah3PBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0626

Add bindings for the South-West clock and reset generator (SWCRG) on
JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/starfive,jh8100-swcrg.yaml | 64 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 12 ++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   |  8 +++
 3 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-swcrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-swcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-swcrg.yaml
new file mode 100644
index 000000000000..287dff7e91e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-swcrg.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-swcrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 South-West Clock And Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-swcrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB_BUS clock from SYSCRG
+      - description: VDEC_ROOT clock from SYSCRG
+      - description: FLEXNOC1 clock from SYSCRG
+
+  clock-names:
+    items:
+      - const: apb_bus
+      - const: vdec_root
+      - const: flexnoc1
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh8100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive,jh8100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+    clock-controller@12720000 {
+        compatible = "starfive,jh8100-swcrg";
+        reg = <0x12720000 0x10000>;
+        clocks = <&syscrg JH8100_SYSCLK_APB_BUS>,
+                 <&syscrg JH8100_SYSCLK_VDEC_ROOT>,
+                 <&syscrg JH8100_SYSCLK_FLEXNOC1>;
+        clock-names = "apb_bus", "vdec_root", "flexnoc1";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt-bindings/clock/starfive,jh8100-crg.h
index c37b42f3eacd..7b337c1495be 100644
--- a/include/dt-bindings/clock/starfive,jh8100-crg.h
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -339,4 +339,16 @@
 #define JH8100_NECLK_CAN1_ICG_EN					173
 #define JH8100_NECLK_SMBUS0_ICG_EN					174
 
+/* SWCRG clocks */
+#define JH8100_SWCLK_JPEG_AXI						0
+#define JH8100_SWCLK_VC9000DJ_AXI					1
+#define JH8100_SWCLK_VC9000DJ_VDEC					2
+#define JH8100_SWCLK_VC9000DJ_APB					3
+#define JH8100_SWCLK_VDEC_AXI						4
+#define JH8100_SWCLK_VC9000D_AXI					5
+#define JH8100_SWCLK_VC9000D_VDEC					6
+#define JH8100_SWCLK_VC9000D_APB					7
+#define JH8100_SWCLK_JPEG_ICG_EN					8
+#define JH8100_SWCLK_VDEC_ICG_EN					9
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt-bindings/reset/starfive,jh8100-crg.h
index 30a99c78341a..de4f25dc301d 100644
--- a/include/dt-bindings/reset/starfive,jh8100-crg.h
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -91,4 +91,12 @@
 #define JH8100_NERST_SYS_IOMUX_E				48
 #define JH8100_NERST_DUBHE_TVSENSOR				49
 
+/*
+ * SWCRG resets: assert0
+ */
+#define JH8100_SWRST_PRESETN					0
+#define JH8100_SWRST_VC9000DJ					1
+#define JH8100_SWRST_VC9000D					2
+#define JH8100_SWRST_DDR_TVSENSOR				3
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
-- 
2.34.1


