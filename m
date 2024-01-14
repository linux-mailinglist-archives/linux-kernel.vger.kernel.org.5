Return-Path: <linux-kernel+bounces-25398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F682CFB0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5957B21DC6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 04:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB6123C2;
	Sun, 14 Jan 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fhjtoc+F"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2069.outbound.protection.outlook.com [40.92.15.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E61FCC;
	Sun, 14 Jan 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr9PLZl+W5VzHvp+ASv60sBFvnVr3NHyAiKCsbYYrwEty5M58TXEYjdHYmYwN0+ZskZWMZHc7fWKMCo/3haqfBGKRoG3zRfDE1msG8NGcJm50WjbHabzytuNFAOkNTGMF4dCQjKrR5Vqm9YBrD9gnks6u2nAyOxFyemysbN6PB+RsniQGkr/0RaFf4zBxp/d4PL2Y8v12rBQXPFFCNEvHAd9Pa+yynu+bZLGAVqgfPIIwQIn+mwmNiDdeEJQ/bcmVPe1fT9wmyBF9sSDuT0LDgMwmcaM5A2ONoBSfgyswLEgZRqZYREylIPgBr7VHVmLQjSqCuQCAWngc8QKryPFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cor42z0n//rFJE8KJb9aLxI19y8bM26Khqn4WDnZiok=;
 b=RbzfmYrvUUDUtgT8ucGjxtPh2Og2WOBto8sUhngGd0RN1PsquwG2GAsSVN3BT1gEWuE8cPJfeYgN8ajXG8UunVF8BttR1pWEoQjQifdNwh6AnhdTOQRSgjgA7yUJbJYNngLW4dFUjYapwsx+jWKGv3DQCjtKhJiwWOtPxGBRGVk7PTYoQsj3U+8HkpO/43V7APc3X6p86IUYsUqU9ICx40sfcWetRk3upI+DTDMfEUyRjGoZ0ZfCG4X29ovH0Zi7iaKZ+yfKtOqFIQK/Oc7LSj1/XA8+Ue5FoVL9ugAp/9SL4HyK74AeguJUnmPPFi5EW9fYtiZSfdT7EmdrSK7B7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cor42z0n//rFJE8KJb9aLxI19y8bM26Khqn4WDnZiok=;
 b=fhjtoc+FJzCpxcw8Z/oLkVsIcgnlU0n7iW1h37BLIv7YaTpe+JfDgB1J25TkNkwvI37L/FVroR7k/tmsk8MrH5roN6q3gimW3azaD+LFtKAZV+MtJglYXPh9kf0ZCT5XOGQ9CeUDy+7YxofF2MHfNC4rKMJJ/OAqCQeBh868Crk1Xcs0oqfPcG+/MD2TuH6YGabm+10k6E9Ua058AQJ37xOJaqD3s3tRmQzwhF1UTmgwDVzbSMEROZnTfTiw32YMGhqyOt2jNoVNLJdT7RGjxD1olkwN/HwyQ+Eqw80yvAmjgB3oMVnGITLdaQqJF8Cp54tM1+u86XGkuWvC1kgNIw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN2PR20MB3477.namprd20.prod.outlook.com (2603:10b6:208:265::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sun, 14 Jan
 2024 04:17:40 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 04:17:40 +0000
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
Subject: [PATCH v6 4/4] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
Date: Sun, 14 Jan 2024 12:17:01 +0800
Message-ID:
 <IA1PR20MB49537ED3211A94684EA7E9A7BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [iKgEvI2wucQG1bzboi7iwFBYi8cDOYmpP8Gg/66QzUhc6XB52fCsxWfjgPiJehBJ]
X-ClientProxiedBy: TYCP286CA0351.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::20) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240114041702.644522-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN2PR20MB3477:EE_
X-MS-Office365-Filtering-Correlation-Id: b8908361-8afb-45c2-e722-08dc14b7bf76
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TXV24TVZ8EiknFmWQa4Fqp015K6lbLmsS9m1llCIx0lj8pPZr3ulPApJfRyooPx4HlpSQ9jX5Ldnfl22hJgS6QrzOBowv2HzaZFgF3Nr4q87mHYxzbRqEHcSJogJNmc7H7vVXhogFDMsox0JuC1IW6N6MTcoZbJCGeTrB+8pfw0QEfzgjqag1cmgU6sccaW86MQPiki50E6U6h8ffAZUBSNgokg39oWKg9OT4mBrpaaplXB0yD8PCe2disjlh1AV+vKMfNJ1/tBm8I0AqyquVlNs+0aK5KNTE3P7NKA8ixwHVW8m5A+pwpIE0BJFFC251wumV4ZGwvjZvcs7j6EfAAIkzeP8pSCLMmFzgHCZhGXBTiuPim+xRxDERk46DH3cBdeMB80lu3Ga8urs4qRNMnM4pdyk5/KvMuG7lJYBLPrVHXKUZZNEwHVcC6hNv06XcbfkdPNZM9f2wDHdxq3uf3pwUfVwpbYEFvVSGMXQzAZ3bUTda0GUr8JQZGI67trgNaEL32qPTSXDOtLszzcIg9ap+rBY4oXuPrIVndct4XX7J74qkPwIf9poVYbzMPCLwq0rxkWisYgb/HFa6lWlZYEgpeJZ3XNAeLEMk85rkjXt+wNXVAgSkmC7vhcWOMDs7Jg/9XShql+kheRXDytVUsK25srQeE9zJmQz4zGqlLRd1Sqpn6wzMYzyr0qLmcv+ZSw6IckT05dkJ5O5yVL6k7OPd1hsju12If+qh/i8pKjeojMvpmhv2QX5p01bs3Q0Tbij2B8VfqzrWYpvdMOAQlsfMhCPFht1Nk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0F843biAHWHzBytmo+eJtnUNwCh+8FJfORElu8E63QBWwPv6ksxfwGAXNXJcTYgmCepKxOueTHi8v3UL7ayPrxxErQYtk0oBrXv6TkMD8CBID5ow7Ka3Li3bVB1dpVyu2K8u5h5gVTjGsFFr52xBzxXIOIvauk1hjPTOAw2po7QDkV6Wabl3xap7P3hLnSl9ZmmrngQlZOc5hG2fNnbvz9uRFa586jdX02uaRYEH9efWDZ7XxZDnUBCkSJSu9HQbSKvNKqWXsY+1DtTP25zOYzBHPDwV5xQ8NMswWbGCTJk0jGK1qt3qwg0Q5KT9GvuWcyzMIXJvuxPdG0fYIRxd+iLrhfuDaR0RzFRyhy7c324ywH2IWWtNT6FLjgYkUuJrkWh3yREoW9MbET6PupS/zsIMr2vqJKomHB6C+mPzPEdkgS5/AX2ts7l5rgqr2a8A/Zft4PqeU9YHch4ILyyFS4z+HSqvK4WzuiAU1s7gQI1Y2/RP4UKRJJ2C8ZyqqpqlWxica7gYyYackuEyIogdzPWlCWXlbjBk7j+h+FhWKaJbCfNcd5kKkAoxZBxgSioraEiCmZy22neYMGyncy7UecT9xZaLAkc505ckaFjqXM0HP5KNk+SV+S64uqTICkys
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?COx1WGKiIi1uYzfLKYDxWgDng1iSrS34Ii71RJPYsbXmXfI5JCfGGxdUyVyZ?=
 =?us-ascii?Q?79MsXJBP3NYmqX/xmaHLgfTXLVlCJUJlMvU6Q5gS3qsyxvxeTeviu1OGZNro?=
 =?us-ascii?Q?M/r8LOeX8IAFTlSgcFwhP9nPFo8fhQ2H/fkk712Uf0mEDtG3EgPmjk18pLNu?=
 =?us-ascii?Q?Y2nO/3W6O6FBvbF2mRc6tz4Tg705ipuvVE25K7Rr8nI4lfCiSnwO9/IxeKFP?=
 =?us-ascii?Q?B+/77/MhbTKnKuBcIp4VtNuVjKN18X8aWjUynCAHNog7MoxG/63Q19D15k+4?=
 =?us-ascii?Q?FU3NjlYkg1Txy6BanTRtX82/EkuCRtzD1Wjpkw7aGm0ObVk5Qjv9yp9CFXs2?=
 =?us-ascii?Q?EsX5MffXsjmOV19ZVnHBe4d989Uik2IskVJ/E1lvYcRkXu0F4bAiTnqMCSSq?=
 =?us-ascii?Q?8h8/7ZhPAA2u8ubZA7ku3DaGUOzhokuBUttYJKacAO1ONDNo3hEf4dxPq3Cu?=
 =?us-ascii?Q?x1eHaxDBvA44O9eT6MSG1lcEL6c9cVmZGjTXe+x4JKI/X3KlBhQaCml/ET5C?=
 =?us-ascii?Q?ffRn66HsTD56S+mzBskKqCTXmj9y+O8O7WkcErrBVRvWzroMaIzx7UZFyeGU?=
 =?us-ascii?Q?xy6lzQ0qswYAlBCAsZmo9GRvpLsOsmB21DC1TzEQ7P3Yh74SYGculYbpK6mv?=
 =?us-ascii?Q?oQpVGYmElLQzJQ+Z643eXecu3WtTErIXNkrAjewrqM0eBknBQBMwB5mqPJ9U?=
 =?us-ascii?Q?DD8pkyGr5DBBNdTNUCLlxSsqc2mnX50CwRWVgzPpoCEZXVPELDAeGhgEqWkb?=
 =?us-ascii?Q?vKNALA9wHdXKjkWR7GvTqPvGrslRafTDyKFHnCFSBi0WqGg2Ab+C3HxN50ly?=
 =?us-ascii?Q?jPgxjS8+2J3QPEZ+8rCUmfPUQzi8m8+jQujiBOCSVWOnoZ6QT0Ttmts6daV8?=
 =?us-ascii?Q?ydBO/KgNAC8mBaWjS/R1Jakb8rh1aFT65rHjLfUXNpaEj044qILcfE677r/J?=
 =?us-ascii?Q?ehak192UEF6TYO0Q1RpNd3ag5Zj5jtLWVgzRCCCO4MUpJDvTVx1cjz4rmFZN?=
 =?us-ascii?Q?MXaoHBiep8t35Djo5f90PVD/5FkV3sD7PoNtPetQ44z6CNaQfWucfgb330WV?=
 =?us-ascii?Q?BCy+2ZGt23Na22+BQdLK/EBRw+eXl0CQT55gFSCtU1CuhvMHC+ttTUW9tdm5?=
 =?us-ascii?Q?R5bq2yXOEzzvtotC8gfAmQd35IH79SX5CJHiSJx0GQCnzwXwStufol9lo9oz?=
 =?us-ascii?Q?04oO9tEBXOubhUHTtQQzUwOCEJUfszAeHoC74Y1aDc5SQk7nrhwQB4qfxQ7U?=
 =?us-ascii?Q?bwXaXUNQMfYLIH7bxoZw4g08gUuPO7N8FhnTqiMZxQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8908361-8afb-45c2-e722-08dc14b7bf76
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2024 04:17:40.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB3477

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


