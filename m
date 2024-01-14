Return-Path: <linux-kernel+bounces-25397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B182CFAD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D90B21DB1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 04:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9E1FC4;
	Sun, 14 Jan 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eaCQ3oLC"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2019.outbound.protection.outlook.com [40.92.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7917EB;
	Sun, 14 Jan 2024 04:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLjztI1Rto0skkrE1znHj40rQBP9tMTDFyNS1P1qtCGPyUl6eop+klW/aBRXwxSMxExXQI30/zXYgLXLqtwWTX4fiJEXKZuMhUQFhSwDBFtcTNtO+yiLp/EZVwnyFNc5MYa82Mcdc21QKC7ayxMbZsbw3Kh3iWHFhDJHFwuGveV+cyHt1M3oiM+D/fG2/DJJLuUXT4HdKyrfdNNejdBdSzRQ9PwX+HSwBO9sjd3jbyE5mp0DJmxVUUSvFoCMZrUQN+Y1VQXx0LkHxJgtMxvdEzW/HUHF0O6to8GpOHlBT0PqeTmiccyhSIdMFywWeFuWyNjSjKfnUKlw2LoloYVnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17Dd8QdpA37Jpc7mSipR9eXHTYF8toGN16/maDcL1Hg=;
 b=Oy1nwOkudFPYqe0PwTtM7C+ViBRAg8dEGydB/8Dy1JGoUuv3euM7AY251Hm8bixX/9Wts/7JE5HM0iv0l1RSM91CCKk1Qb9ZhgdXzbQ9GCbAOqFWCDqKkvDS7Qf2hmVVnELL70lRoaR8EHTRIToNypDpyZvT3M+NNULYaNswsMAfPIk/W/ml7Y5rcMZeornldtwFC8VSJwDhHkaI1wxxc4AQbCpSylMq5pETLVQskh4CiM1v2ifYyhhrJMTFtRSr0n5X+MPD17KUFJqY6PdATDGv+YVcNtVltzPmFNOwwPRTQVFKcF0KlWHQW9RBvy9jH/jDNG9KUcwxl8TF/9nqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17Dd8QdpA37Jpc7mSipR9eXHTYF8toGN16/maDcL1Hg=;
 b=eaCQ3oLCMQ1KvcYFi/ei4kMeyvdKAgbcBK76/AyVAIf6vs6CAz38lBSdNFIXoyDNYIS1Dxa+peYog9yyj2iVkYOYbeNRmpNNU1rZXxkmZDqUcGY2Spfp3YgGmkZiLqui3MP0L2RMEC7yHcj4PQp1q3HG+12oUkb5EpGpu6eWI2tEi/UKQvKsTxR7TMyJqs8/KWRMIGX1d8WYhZZREnggJdd6jIs+ByEOPhGfXTwtVRtFg9G78MCFIv9rxARjhSw97RX8hA36ONSBTfR4aJgSnfqBZlLuGIVzK1VL6XktqU1b2q07tm0E8iDEkR4IQWkoeMBG1Cz8uLfMRjRukZABmA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN2PR20MB3477.namprd20.prod.outlook.com (2603:10b6:208:265::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sun, 14 Jan
 2024 04:17:35 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 04:17:35 +0000
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
Subject: [PATCH v6 3/4] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
Date: Sun, 14 Jan 2024 12:17:00 +0800
Message-ID:
 <IA1PR20MB4953355805F79ABDD7FE9129BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zMDYVGIIl1o1QqKYb/scl9vRUsBEbU9KkdzikBF7UjIh48GD7tAblqpIqTOwxoxY]
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240114041702.644522-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN2PR20MB3477:EE_
X-MS-Office365-Filtering-Correlation-Id: f3cee96a-7784-4be8-71de-08dc14b7bc69
X-MS-Exchange-SLBlob-MailProps:
	cn60g5V53KP/kCS/T0mZoXNrli/jQ6UVRjP/c438xNbhfkhj8W1HjKXZePxI+WF9N9lAWIazJ61IjwIB9e3CocLrLGcpfpgqSl4Ecpe2HBqAfgFldwvMktAlx/SGhRNGrVAzJgPQBXHZvQQI2KqZJajR3VlOOP6pWOZ4CMW7KH1AnJJYUhhJFSt8xsHMUmmmCAbhzcTiUUwow6WX1irHNO+YkHmK5jzV7KJkW+5a0RuDbIs1m0ZSmxb6SWZJXYTqf9t2tYqy3zgwwOUqDI8Gx5c4eLpOd+PomnB+V6KKTS1/Nb6gnaxsmD0iCuc7EbwbrBnkh76KP121Y2f7U1xu7C4WnPhiPP9PkI/TOu2GENqGd26+dyIF7RgFxscAA1d3tY2DfqnIW/76yLZplJSy2nNBBTIQ7cTu98Sr6Jxksp17YGEo1jZ95pZ0Hz4fIqBQIh+GFyrnr7BOCrZl4zdOZJPRJQv9foFs044tKAQk+02JshFD9EPDLNgu9jH7I6loQlU84Bk+9v4XkL0C8PyCLLBdZHX2unMmcJpWNISbNNV6GiRn9ui80WK6JUoJc/74uWYXx70OrEZ6xFtThjCdy5pDx7BpoRwvLKeETu5rppgltnd+tMiHf1fW7ydxF4O5fOnP02raFPyEEGptaOxAguCwrRl/OM81F0BwBCXIZTx45mDx5p+oXLy1k6v8ZWmozk74+ySRqHAAGzREvAmpIjD9ldnhiiPaVYiOY0iYEcxzFgM9h6TlwS62r2rTB8o5xyUL5mktKNUWvxYBdIHG9+Qm82SOe/1XidY07jzIQxgw6YBIwZg/8NjiT7hnfAMyaDQenpcDjhvWNDI1kYXrdLg9MHxvR2smLDjYf62JLAmu4RGMTpnVxw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w7iAoH1O/vESRe6gbQk1gG1JudTri+xIeBx3Mrs/qPGZ4MGJyNgK0sbChoNAmATr5bo8SXZEjWpfe2z/V0T0cv8kLSv+Y6Xw/BCk7GCTxJ2o0G9Jzkt98LQscLQWs3KypoXqcioFLqmGhv671Cae6BFSXVm3N654CMVsyIENc5QtSwUGpS42bI/LGl2wQCAJMZ0cUEPhywxGyb/tbqyMr2ly8jHDlYizUq1WvgxtsfyMy39amIlrPYC1P9yBpljMavpSCGfPousQ1k3jeX6qd31AuHUrHckDGDq7r4Dmqka5uXyLGf8ntW+1XpYzyDROA3uB1z9xAgMy06LkGIJfbDv8bePqUGftV4CFgv08vj8FZ6qpKe+FJH+nDdOYlyGa0J8LDJyrVWk5eK/0YxA5bZWYelKyNAoHN6z0EoAkpIX5IXJeq0ZOoQgnrLLVCgBg8qtM5xHNU7hbu50gyg2pde3d1kFdywU374aZTa/b5R7buEgZfEOZpeVMJ0aNMmw5TIjaA7OHOhbHVbSB433l5CsM6+sh/Cs/WTvCNTkvL54wGB02tnuTtcdR2W+0vJcVD5Y/JxT4Ya0YgNLDJc4oCjzXao8cNVLmmLL9STUxcXvFWucj8XQycsQcBwjcIbgf5v1fmj2UACcBWAF300qhpIYt4TV21vF0vz7vCKPVczA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tDlMNqzVUCV1oCve6qYTZWzr7cPYqBGOyD9bv9wc34ggoKGwMozQSNomTiXq?=
 =?us-ascii?Q?vZ/2nDc20iX3oX3PsAAjV7zCem5UVDJyj4ETN/T5O3nhMlouOZFyB/lHr+G/?=
 =?us-ascii?Q?K7TY5lRG3weRGusk6gxI9FCodAp8o5cI8xP1pfTDkmPmV3LJK49JDXpY2voX?=
 =?us-ascii?Q?qnfQwVa/werXOdjWe2TuZeqDRAPOWZ19Czte8KCq3zadutr+lZqZR1eFIecY?=
 =?us-ascii?Q?VSMGMr2OXGWAfmb2RT0MIJwY54Ggajchw4iw3ky8H5vPQth8EeRksLm/d0wc?=
 =?us-ascii?Q?fTqmHH5UPV4YJXRqE62Did7/rVUlMd/Vv2mXFYks8OBF7foELdmuJk8AUPKe?=
 =?us-ascii?Q?JJo1N31XlLsHUEVUeAe2xHrukKZ6GRISMjcJQkuwVBuoxFTIuDGLPZizpndS?=
 =?us-ascii?Q?olAChSoYRbsX2miKWr6yObFTy7DiTXrw8XJ5KXtX55qr5i6sjFQuwlJc58gt?=
 =?us-ascii?Q?BoBZwiNj0Ce5X/qeNnKIqa1w815lif8CXpT3Y2y9dyz2EiQ1jLIlwV1ndS5W?=
 =?us-ascii?Q?JtVUQwaipyacwhYur27j3f/nDcPCcSAxDKXOE6TQW5TOteHpZ1DOFdyDrzzO?=
 =?us-ascii?Q?00l7O0KfzyqXNIj7a+QJ2/ny+AkUCWMkzMqyPCTsZgua+Ad1x7AqfjhKci9s?=
 =?us-ascii?Q?NxH2gssqiazynSJVGPJevkx6EjBrj4661XSiY/qObnNdaaLBF6cWcQ5h8xP9?=
 =?us-ascii?Q?Z1mMH3fWUWPnY1yXRbOjGuMHLCQw7sLHLA5YoY+jI0MRF8fQJJmPppFQGDzs?=
 =?us-ascii?Q?eGGiyasAIw7GmcDv4h5COOm4u2jO6vBku1ljDqUd6UEITQGv3k/5WsHYxGMa?=
 =?us-ascii?Q?VmDkhkqC3fC12BhtnGK4vafWEXomVYos0kOJ+m9g/o6PkQIDwAzrI5zVIFGb?=
 =?us-ascii?Q?vf5Zi1JmroMW0XdZkIR3PSlEgRL8Oupp4hnL8V8bCU9/Oo7QfLXQrmjXb1zX?=
 =?us-ascii?Q?08jBu+P+MHRUs0pUpO1LR5vZyAbzyjTTMzqxy3FO2Gent/mQIJeICAzyjw/1?=
 =?us-ascii?Q?l+13OoaPqopFQIBgxUJYBSsfvfvaE91eZAneRDKIoZItHa4NKaH3S9PDgjSz?=
 =?us-ascii?Q?o9GuaK//1cHqISCfdqIe5GFwwi/gB+kYlpUT4VsOIuTEd1fVGn8uA07fTi0R?=
 =?us-ascii?Q?Yt1MHTWYK00eQKd58lWMkEfuCkwm0nOxgTzhtUD/yu7frOU1EViYXLJCgfxR?=
 =?us-ascii?Q?n+z9hmXpNV72DsiLvZ3+GKo3fmxOD64OibcyS5xVoGt4w4dXp/IYMpY8Bdj8?=
 =?us-ascii?Q?ySrkrR8YVePSlZJMcXliferE5FAKVxwQ0gAvXk0NaQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cee96a-7784-4be8-71de-08dc14b7bc69
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2024 04:17:35.4531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB3477

Add clock generator node for CV1800B and CV1812H.

Until now, It uses DT override to minimize duplication. This may
change in the future. See the last link for the discussion on
maintaining DT of CV1800 series.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8df248a19ca70837a3/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
Link: https://lore.kernel.org/all/IA1PR20MB495373158F3B690EF3BF2901BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com/
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi | 4 ++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index 165e9e320a8c..baf641829e72 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -16,3 +16,7 @@ &plic {
 &clint {
 	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
 };
+
+&clk {
+	compatible = "sophgo,cv1800-clk";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
index 3e7a942f5c1a..7fa4c1e2d1da 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
@@ -22,3 +22,7 @@ &plic {
 &clint {
 	compatible = "sophgo,cv1812h-clint", "thead,c900-clint";
 };
+
+&clk {
+	compatible = "sophgo,cv1810-clk";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 2d6f4a4b1e58..6ea1b2784db9 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -53,6 +53,12 @@ soc {
 		dma-noncoherent;
 		ranges;

+		clk: clock-controller@3002000 {
+			reg = <0x03002000 0x1000>;
+			clocks = <&osc>;
+			#clock-cells = <1>;
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
--
2.43.0


