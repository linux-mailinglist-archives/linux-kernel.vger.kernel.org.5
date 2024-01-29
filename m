Return-Path: <linux-kernel+bounces-42119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6A083FC9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D0E2825BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615A910940;
	Mon, 29 Jan 2024 03:14:13 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2064.outbound.protection.partner.outlook.cn [139.219.17.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C91FC08;
	Mon, 29 Jan 2024 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498052; cv=fail; b=txgkV/OpJuucDJKhMhxMb+0IBYehxjnFif09g9HKVHeZpM0w5fVUmRKHzWa1SNg5Ac77+qh0m33mDacoyNKUPqWfpDMrtJlqeHgHpq0fDQELwKXWsAxKdR8kwsh2iugaurdIdL88DymkfoT32oFFk8G2D30iJci2Gob8IjtG0aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498052; c=relaxed/simple;
	bh=xqaaritMvEuHOv9tp1YYV6T9sLGbyxgp7VNmSn7inSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qS+6NUIeVObowLb9ot7OMUV6jcmpwCeDVILjfVE1gAVchkKUJ1Yq0384N0ataAsfFHQeycMbkU+go4MBRO3m+W0s4V+S+HQmr0coR3Dqi1y3w5WKlmSdcXW42A8MVAwCZ2gJsmwleyOWGpIfyV8pqKJKIv7R4Xt/sHOJ0gM4Q2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqxOj3q2szFxcLHIIdjVKsbc6FHSBmzugrpb/xtGQvAJS2hQAvp2nhzsf1RbyJu+KY9BX8v66xpeOxXzBWjtp//x5YC+kGCUeH83zfgcYTkNtJR02B3z4p4s4NSBVkKWSKAllKM1h66+SUlBFt5aiCL9jldAxdcwAoaEq40I/y2Ky9IaAMLN70huENrzJebofRnHRV8iNJ1A8KgjUvF3Ji+Q1wyfrIGOpEUE2g4VYqz/G2ao95eYOoIcZU7v3TsZr7CwVtVlmS63yXSZhAtmthDpoO5nl5H1DWY00j2kUTBtukqfkF1TVhTUOZV1mcrSjHjxId57ojqf0b6a+bn+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUqTSg2Lr5dBOScYgGzdVACwSz+PGqFqgO6ivaqTbXk=;
 b=XCmt0rurJjyARSPzPTRYC2bmSAbEyD3Ub69wWZqNmW0qn5nsobF1iFN1Ie2gbM9gOQGB9hoaANLfK6Af379T8kI2oExUR9ybR5nr/jTyqph5khWqketfhGAU98Jn96fgt2ysO9Bj7N263go9347EP5s/9NY+dkVCXQTWvILFSMgOEwPyPcstO1uoyrT5srVKV6Z5Q/V0Ksyn0JK5R7x7QUDByWma6WLKR8RDAikcCR2v9nYgs6vZ4P8COcFJ4bPgdZzrlaI25f1NNNf1SSacFRy9Chuf840dshzqx6FPwCCbkfO8ZoZuplT0A+Xm9CcOvB7nlzV6m7XkB6dA3YER2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 03:12:56 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::a5c6:9ab0:d20f:cb78]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::a5c6:9ab0:d20f:cb78%6])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 03:12:56 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-can@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v1 4/4] riscv: dts: starfive: jh7110: Add CAN node
Date: Mon, 29 Jan 2024 11:12:39 +0800
Message-Id: <20240129031239.17037-5-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129031239.17037-1-william.qiu@starfivetech.com>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::23) To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b795a98-d339-4be3-94a2-08dc20783067
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g6FbwVVqsv5dYinb5qOBdHsrocUd2ukHeWUZXck+g4/S/WrwczUExNYRAZy1Ykx7w/XZ6Px6Fm5jMUz0TNO4stthABcaN/KnwEHSgLxMYHu5vIpA7feTjV4Bn/ANy2DAuC3ywlJtk8HCnuqYHE34rnPFm5bA1SJ/cAWbtTl/bM+8ywOsZb0on/tmokbUy3KT5LC995/tckYlusi5ajJbEJfYRQd1mX8NJrf1OV5DyFCojEJNBm9KXSaRl839uX1BhhN0hlvU0bUWp51vOFhSkeFlwf8Ev/984nPfmjqGJtbc8Gh6lhCK7784La6DTTYGuLsxrZ3U17NiUD+QVBqkk9ROIXZffvi02XvDq6D6W7hpdOoNh5qZJUl/4jgX32S2u92Uq7aCr6Gm8YLtQStezs4wEKDD03coph79A4JRlMf03+JkxhSPlx7ueDx6NqgfPT1AeW7nOdGq9xjATR7IT9y3QTKAC/WFUAzxW60sNdpg9Yzeu+h25HU2brk3PONtxnsUIBeD3JRtiaZYFlSpnwn4R1208KXeQTS7CLzwtMVB2OxLg5LuDyNDS1rzK5rW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41320700001)(4326008)(8936002)(8676002)(7416002)(5660300002)(44832011)(86362001)(54906003)(66946007)(66556008)(66476007)(38350700005)(2906002)(40180700001)(41300700001)(36756003)(38100700002)(52116002)(508600001)(6666004)(2616005)(83380400001)(1076003)(40160700002)(107886003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HlkAh32VuEPjlJmJlWRek2tJSUJWa7EhrTG2iRb6GKPiE9GHOP8D/M0Q4UEK?=
 =?us-ascii?Q?uteDvzsPJ/L9bOU8edC4j/DvYaskViKzsilGrCM4TYRPu5DLNSSmTMoPAsZ4?=
 =?us-ascii?Q?s+WTjvm+9PoRSgBw41IjnHX/9nOYT+Kf46QjwgFkpyxQEFpHqeZmfuyBOMAI?=
 =?us-ascii?Q?ptDTJF3kjlhI0JpLTifOyAuhKlNSZeutWvcdBlzntqgZ/5RPg9M5612HyEz7?=
 =?us-ascii?Q?Cq0swADAcbqsPiml2B+g+5qFmZzqjDOPhesFp3q5svZKjyGBamLFqltHiswN?=
 =?us-ascii?Q?JpBtNWo2nJWmt4bFQ7zeJiw9AuCWXZwatQMzGW76hVmAK7QE1wxlucz/vGPD?=
 =?us-ascii?Q?c2V/vbRONfOX9beU30Ri8m4GyJwj0AF297Vwo5uy+MNmLqZnqccIX73C8PaQ?=
 =?us-ascii?Q?UYxGvMfnOP5aeGeCv9ufS4g2gW0/9kRQTWs4nApSVJisVljZFa5DpC2pNOkT?=
 =?us-ascii?Q?JKdrzWvFcMTUuVRLdgPV45NmFugSjdeK/EtC+drzI1ub09yRVykbtN7wy0LY?=
 =?us-ascii?Q?aQA46aVj0XJvk5FaidFuK3I65NIxdovzH9FSYMd3PJVAQlrbUVe697Kb3LO5?=
 =?us-ascii?Q?XxZrhEwftC0wXUHmpeqKapG3DceC7jo+AxHtD9+UcH8cPbTg4yV6HqqhjwjF?=
 =?us-ascii?Q?CFM0b+4qP2VEbirrl3JhLUC4kNbxEwKIfHqmjUFFMEvhhyBQfxVGs3e/6sxy?=
 =?us-ascii?Q?rg5MvkPoV1BtcamxeScXY2RXdUWMnkhTNfAC7RnBwk1Nh9cvUv/l2os5DLCI?=
 =?us-ascii?Q?dY9fchwtnf7N/eiaGZueJVtDbmSJXvy8LVa2MnsFhpRGLyVfLNZ45uhG/ZMt?=
 =?us-ascii?Q?2BynaJdDBFPFufbH6hqEvnrCfM0QeBIPGNd9SZCXmDoy82FJFaZLxVWxxgIw?=
 =?us-ascii?Q?V5rqKsMmQmfUcU2iw44ibF0KSOl20OhPctdjN8NZouYQ8XM31PE/NAWzkSiY?=
 =?us-ascii?Q?5BJ0lvsjoJ7J0+s519jIU9EFiousDDCOXrh304bn79qdBJAc5R/ujPbSfzjm?=
 =?us-ascii?Q?tw6xfEGTZJ4x+2pEeA1h8fkb0hFEYCcLtuXMJoHUQpozitaifbAgunqLOtIH?=
 =?us-ascii?Q?UJ5sQiKylFaOMFmUGLTl9/4egu+5FT7wvH0M56EIoQ17kcJhClTxMx8EiFCJ?=
 =?us-ascii?Q?XQPTD0b/km3fYS+XCo2G6HkWPbSg7JQjGRZ4EOhPkPxXxDU/R2w1PjtyK5UL?=
 =?us-ascii?Q?PX8sCbBjjCJFI84EVmRc9ZmdUIyeB7wY4X2FH5BXAWU9pzFG3ZIfld8QtgQf?=
 =?us-ascii?Q?Mvk30zGcx6IaE6/c9lJFRDKak+KbV9rbGO6XjvpybnEAAHR5SVe/G8W23mWt?=
 =?us-ascii?Q?wBvpdXvQOpXmLESAqgvT5ifQlYWIKENfKAUbvqourJdAu5EsVM2n4wT0/GFb?=
 =?us-ascii?Q?LZpoAjr1oviM54sE8ylhLQnjDjlB+cK8v0GbeX1H7XsjsIheLsWdnUNB9Z/8?=
 =?us-ascii?Q?x/cbuuE+Kmjwxd3Dtkmrt4dUheQwXAFQ3jRqa831AjuYAwIIuo19xfs0bw8R?=
 =?us-ascii?Q?7IqkQkCxI+owfb8bxXf5i6FEqZjVBCE0zHbu55HX2py0fo66y0K/L8afEAgg?=
 =?us-ascii?Q?RDVrb75srA0xy+6kPbza5wBHXVY70sOT+KuY2Zc12pnxe0MnLHdDKFzKVISG?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b795a98-d339-4be3-94a2-08dc20783067
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 03:12:56.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVLE4Hcs2sFOK+QrEAjtcqwWQWo4DgsRTjyBLaz8MyaNFa8Jj93bLBQRfiGbYGsdT5g0IXIVDlhOwKRyR9VKfb6SySBkHB2Tlc0Ev2OPUi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1253

Add CAST CAN controller node in JH7110 SoC.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 45213cdf50dc..4d0469cb8ca9 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -914,6 +914,38 @@ watchdog@13070000 {
 				 <&syscrg JH7110_SYSRST_WDT_CORE>;
 		};
 
+		can0: can@130d0000 {
+			compatible = "starfive,can";
+			reg = <0x0 0x130d0000 0x0 0x1000>;
+			interrupts = <112>;
+			clocks = <&syscrg JH7110_SYSCLK_CAN0_APB>,
+				 <&syscrg JH7110_SYSCLK_CAN0_TIMER>,
+				 <&syscrg JH7110_SYSCLK_CAN0_CAN>;
+			clock-names = "apb_clk", "timer_clk", "can_clk";
+			resets = <&syscrg JH7110_SYSRST_CAN0_APB>,
+				 <&syscrg JH7110_SYSRST_CAN0_CORE>,
+				 <&syscrg JH7110_SYSRST_CAN0_TIMER>;
+			reset-names = "rst_apb", "rst_core", "rst_timer";
+			starfive,syscon = <&sys_syscon 0x10 0x3 0x8>;
+			status = "disabled";
+		};
+
+		can1: can@130e0000 {
+			compatible = "starfive,can";
+			reg = <0x0 0x130e0000 0x0 0x1000>;
+			interrupts = <113>;
+			clocks = <&syscrg JH7110_SYSCLK_CAN1_APB>,
+				 <&syscrg JH7110_SYSCLK_CAN1_TIMER>,
+				 <&syscrg JH7110_SYSCLK_CAN1_CAN>;
+			clock-names = "apb_clk", "timer_clk", "can_clk";
+			resets = <&syscrg JH7110_SYSRST_CAN1_APB>,
+				 <&syscrg JH7110_SYSRST_CAN1_CORE>,
+				 <&syscrg JH7110_SYSRST_CAN1_TIMER>;
+			reset-names = "rst_apb", "rst_core", "rst_timer";
+			starfive,syscon = <&sys_syscon 0x88 0x12 0x40000>;
+			status = "disabled";
+		};
+
 		crypto: crypto@16000000 {
 			compatible = "starfive,jh7110-crypto";
 			reg = <0x0 0x16000000 0x0 0x4000>;
-- 
2.34.1


