Return-Path: <linux-kernel+bounces-11784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C05181EBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9241C22161
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD2522C;
	Wed, 27 Dec 2023 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="luuE8kD2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2055.outbound.protection.outlook.com [40.92.19.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155B440E;
	Wed, 27 Dec 2023 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUjzw0FRKdbtCYKawtig43DEC17PfW8659ggnWkisPTnPwM14GNPUQoSw1PWA2nUE8pWpOf0Uy9HyzUk6TL33sEi/z5dQ1wlieOEJoOPt5MYWEIp3iC7Tb2ecnSQBf/a1xQk1meYjmdz/x264LTWwMkNRs61zXoh18PjgGLXCsORwZ7OQCEUIvcfEwjgc3LJQmhK55yoqhQ1d9hRjuJMGB3WHmYjx4YzD9NQmxv+iWMXyU7zbOYbdk+60tp+N6dvt71GI7e10ZbRXf7rNrYyx8ih+bfT1tP7rItJCY5HbySFKmhDNONM2JTRtEG98DtK7QlzqGkhPsxl9p7t12P5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cor42z0n//rFJE8KJb9aLxI19y8bM26Khqn4WDnZiok=;
 b=Ib1gIHvnY+/me8T/O9UG5cgbgpI23LvP73T4lIxil9meVcvIBpGUAHlgvrvZrzIKiMt38sp+zan7cb+WCr6PwRvdd7Iqr4+EnIydVOpjsBGvuWAU5NPTii6gHIkSYSDm8xEXMh9wvrSp8WxpuC6Kr+Vvnim+cxrZs/S7rJ9WINg7qG4Ci0QJPhc5/9Ikdt6PM4nlO9B+dLIqkW8BqVhsN3eQ1zagUbWoATmWEVllPIHC9sAse1/qKwsq6N/0JxasJz/Cw67n3EI8V3HKfdRdm+9JfxrXQg3nniMzzF1u/hKfowYjtr7Klo9cf1QimmEdNBHKBj6SlnxzLaCeNBOUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cor42z0n//rFJE8KJb9aLxI19y8bM26Khqn4WDnZiok=;
 b=luuE8kD2zT+DRPFcALvuoQrfJsCotYckSEvCstw9k5xZLloXnX/YZw37y0xVPfmz0b83CcP4QzyzlOWg6lAhmcOFIXOF/o218M49+KxbAdi5w7FQkrQfvTEID2zlEG+7RWgTsy6St+GKc2/rKBHeSEiZLGCY1tdBzo+hbrZgnD/3OImkqR9L13oB3HrNTeEPeyDM/7GZTOaEg+9ien4owRkCchf5rTNyXH9A56fADumVPeNBbhumYlDX+OY0V0dqY3CqD9HgLWaHC1AIY02JN2u6TYLuIV5+479PUXXzRtdG2N0a/A3xNox7kfEftk8vZ1ytt4SMN5Q0Ywr4yIwqbQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB3754.namprd20.prod.outlook.com (2603:10b6:610:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 02:54:34 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7113.026; Wed, 27 Dec 2023
 02:54:34 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 3/3] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
Date: Wed, 27 Dec 2023 10:54:20 +0800
Message-ID:
 <IA1PR20MB495323278233ADBC02C55791BB9FA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [EppCvTBWfpceL7EOTXLs+rC7Ei1sxh9XBd3F9adlFZE=]
X-ClientProxiedBy: BYAPR07CA0105.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::46) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20231227025420.296265-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB3754:EE_
X-MS-Office365-Filtering-Correlation-Id: a499dc28-a103-430e-2877-08dc06872823
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FvDuUXhkjQCNMsfL8WCxq1mbf9Nmw0a1jZuln8l5QwhdvmB7b7vip2NJsP7QTGiQUZIJ9eydUWUdQzQXDV2DnCaO3aWLZeZS4evEdeVFJXUUiuK5hS+7l61EWkZDzAF7EVqzNO4PF0QHh+CJSNDJp5NgspZRLvvseNPGtdPHojEgOuuGR5xht08M/qZ0p7Kwzczv2b1PxIooB8MrnVPerdlgmRtj6Vb50zcanlfN0abRszrm/K3+LBcmT1R5zRNYTEdM2j9U27OII5TXGmnFiIBw2JHY7BH3D+Hplhl8/rpyvFTf9ml+/GLOwA2urlu+MzWiQO+SDoVo3JXBYxzt3dDLFgzM3N8wXhvCGhBfzWkE50+BWMdlmn4IGF21FpNG5bw+b+6qCtLCkap1NJ38mF6e5d/lRzUs3ItaRiJAZ6gt+JmnADgAk1dpt1D9ALkE/qPYBE1fCW/IMnm55TB8eJh/tj4DLwewnw98X4bCg3xROgnh9aHbxSupHiLwACBmRRV7q1b0ZeCC08NJ3wmAFwJuGbyGrJMEDCrPO641q7PGmjIN41QQ9/eqbDenZr6ACt3xnK545onQTQvw1609XBxZLwGUA76PElUYbv0XlBLy5jxHBx1L7yxg7jI+eO+R
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oeYcwqTDHIRi23WNT2P8TJoFEqI3pYdcpRSR8pAVeuaPMQgrxnwEjOSEaKH8?=
 =?us-ascii?Q?o8Nk7XnXiS3C8F89CCmD+QMQTvSmrxwW6hwRe1TYRPeVDCqzBT3Red/rYuc+?=
 =?us-ascii?Q?FOj6Ve4C89RSrwyYBvYU/NFiDrD/7pmNGaog2o2rUFwf0vW0toaEPcvC/3zt?=
 =?us-ascii?Q?v8UcD0i0kUY7/4isG7fpiH19b6U7SBCyv5OSt+8apo6XzbhX2lgRdkC8y3sg?=
 =?us-ascii?Q?XfdyEVoq+fdzRSbys1ojSerEySUPeFMlJ8xm/ss5zvDjFqkaG4CaYY6i7H08?=
 =?us-ascii?Q?JpKQ0O4CaGZ3leGKY9UqTuSuWtDXnNmPTjNNEj5jNCggvw2TMtN1r/ZzaKyI?=
 =?us-ascii?Q?zPYuAHdgSdP1kz8xLZcQkU2CsIVj81QnncNQ5lw83aK9rDhI8HV3AxAJoodQ?=
 =?us-ascii?Q?ydObwuOOxdoffvRyjdby0uHXze2QShtDBs4SQ/aAJaXqLHC0sci/AbVI65i7?=
 =?us-ascii?Q?5SqcW1zzCh+s/E9wjqvMAuSB0Ek/94CodCyGIAkW1HbHvevXPLDUCBhTyqTu?=
 =?us-ascii?Q?6/xPI+BU4G2Pat+d1vGeqK0h+boqdQMluqqyO66vBnNgnf0WNXLDTRwsVziS?=
 =?us-ascii?Q?DehlpSAfm4UTkS6b8aItORdYwnw4akUKNd4ZNL9lOSrk0e3tsfBfQBW+3m3i?=
 =?us-ascii?Q?zcLeCnEtiPZsACXygZupyn7qx4MvRCSDbFK/JwvPi/5JcmUGtqQg7JDun9N9?=
 =?us-ascii?Q?WOXSh7QkaUbRkITxZg+1kxJsXg+ikXO5uf4mwBqI8RJPjSIWjPJ8Zkh33/oX?=
 =?us-ascii?Q?qd75ie+uOHcByf+UrQiqU9H6+0B80s1pcZlIWE3UixHlW0W+egKa3P4ZBvpM?=
 =?us-ascii?Q?Z52IT4Pc/GgqezdzAtQnopheYZtwENLQhlRFibv0jTP9mFJkU/DUcFCKDDHa?=
 =?us-ascii?Q?EfcGiS6Dfmgj7g0Cd1IOd7mqlXqJRLmw3bz+/mZxQjeM1bfchTO95Zbt42O/?=
 =?us-ascii?Q?hSKE/LkiWcKfKmQXjR1OHsG2zbUQFpwpn8oKSVxLhsRIJ9H5+iGZYNxjbz8Z?=
 =?us-ascii?Q?aYqKgX9fLgFwQGwKiCHGKa6pK0V5SwuIC8Kem8IyzJ+XrCIjlDu3YSvXkKZn?=
 =?us-ascii?Q?1ZSasZJz6UieHnRLBMYxWXjzC94svlQlYxG/hX1QXvEzh/3PHHnz+H80BpqC?=
 =?us-ascii?Q?sj9tQ0OGxq/lRlmzf4Yh+b0oH0WOJcTAN4llxOOiG1SbilbR9rDB0uDKRWtX?=
 =?us-ascii?Q?+NVg42rVq8a5IAq3YeHOl2wQRyTHdR1KTsI10CvB4ETLa/7dFQ3jjWkZwBY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a499dc28-a103-430e-2877-08dc06872823
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 02:54:34.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3754

Add missing clocks of uart node for CV1800B and CV1812H.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 6ea1b2784db9..7c88cbe8e91d 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -5,6 +5,7 @@
  */

 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo,cv1800.h>

 / {
 	#address-cells = <1>;
@@ -135,7 +136,8 @@ uart0: serial@4140000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04140000 0x100>;
 			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART0>, <&clk CLK_APB_UART0>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -145,7 +147,8 @@ uart1: serial@4150000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04150000 0x100>;
 			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART1>, <&clk CLK_APB_UART1>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -155,7 +158,8 @@ uart2: serial@4160000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04160000 0x100>;
 			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART2>, <&clk CLK_APB_UART2>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -165,7 +169,8 @@ uart3: serial@4170000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04170000 0x100>;
 			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART3>, <&clk CLK_APB_UART3>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -175,7 +180,8 @@ uart4: serial@41c0000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x041c0000 0x100>;
 			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART4>, <&clk CLK_APB_UART4>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
--
2.43.0


