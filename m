Return-Path: <linux-kernel+bounces-12665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C142081F8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B5DB20CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D8579D7;
	Thu, 28 Dec 2023 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="P85RShTK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2107.outbound.protection.outlook.com [40.92.23.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D279C1;
	Thu, 28 Dec 2023 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JewDPyeeseLiMuYquwKy9mWWopUgv8wbcJpLcyc49kg04hEBO9YL8T0KuGA4KiMcQzLZPBWdWxUVhLZ+XlbqNPW/jc8wTWfngCrSTqVtU5ewFs6nNhPWCdW1Vcc0LZCaDDPPc9x0i+/XMVgoRzPrSz+xVdV+3e5OeoVzdsAPHE/Nhlo1Mlaky4TsrKujwHii2eMqpqxPr5DAj5OAaOHfAsccS8F3TrivjKpatzb5yYjrdpZUcdy6LUIEXf45tMlwkYLxwanq0KJvz3YdAv32YhB197CFBDoWcechL8di+CZ/zMLeoeCv+qIS4LGu//pY763qPynGdn32t4/Oe8mfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCHsPgi4GTv072AI4IBbeCiw0gmX74qqF/ZtmjLvgsM=;
 b=Ad2yzu+EAai/NKo5wjM3ZMTrZ39JRlpKhZbhWO4JpWkuLA5FYovIQUhbSXZ0VhcK0MXCK3e+xytjLzneRYcYxGtEnsZCcOHmzmp8MKono5Rp9AESBWr9AETkqykvwNKD/MZEcUPsJ8DdaDR9mFGH4kRG8bPn44KIsY7mPFUtylJ6mV38hmurWHMRfohK+Z6tymPfr/yqVArsjwAZJeWsAcm/zhiHmm4Px41BisQZQdQV/rRyu/sGirIMK2U5wKbtOlA5tz0FZRHvBLmxlJHPnGTKrZeb1pCutylv+y5bTSSeEeHYJ6OAmNqLJyM/AlYNahDnDtr06LiDQ7nD5s5Djg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCHsPgi4GTv072AI4IBbeCiw0gmX74qqF/ZtmjLvgsM=;
 b=P85RShTK7UWGz6MLWt8kuW4XWwzLTnRmt3NtAGl2A9jM++ayHt0Gb5L2eGkXZZf8ZnvL4EmQsM4UEFzasOHPLmKR0SApQmjkuuPV3pmNNAkA9aK8xPoGE3WZkjQ1pFjuvTC2JSZEOgvhgs6F3B5c/SCcdRNMWicl3VL+aK1/YnO/xp9bMT5aWbm2BGj2lSsEbsrMSG0oIQK92ord1uSFaO/EM1XEvbWDTm62yqyuqDBtyOXLEPC2QrizZUviC9prfiI+eeVAGcsZa8kngO2V0eNpZmf50cxQ75h1+4yFE/wxV3oHJUpGvwIFOK6VZfiaYt/4clwowH4y7jTUm/Svcw==
Received: from DM6PR20MB2316.namprd20.prod.outlook.com (2603:10b6:5:1a8::28)
 by IA1PR20MB6432.namprd20.prod.outlook.com (2603:10b6:208:454::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 13:07:08 +0000
Received: from DM6PR20MB2316.namprd20.prod.outlook.com
 ([fe80::1d59:b3c8:8763:a672]) by DM6PR20MB2316.namprd20.prod.outlook.com
 ([fe80::1d59:b3c8:8763:a672%4]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 13:07:08 +0000
From: AnnanLiu <annan.liu.xdu@outlook.com>
To: chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	AnnanLiu <annan.liu.xdu@outlook.com>
Subject: [PATCH] riscv: dts: sophgo: add timer dt node for CV1800
Date: Thu, 28 Dec 2023 21:06:54 +0800
Message-ID:
 <DM6PR20MB23167E08FCA546D6C1899CB1AB9EA@DM6PR20MB2316.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [FZcb8sp6ZVtinXhxXjQ72aB2YRAr4unhFRBjEJCLz+o=]
X-ClientProxiedBy: TYAPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::35) To DM6PR20MB2316.namprd20.prod.outlook.com
 (2603:10b6:5:1a8::28)
X-Microsoft-Original-Message-ID:
 <20231228130654.182008-1-annan.liu.xdu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR20MB2316:EE_|IA1PR20MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d2b8be-928c-4ace-c5ba-08dc07a5e568
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	evsK0Wm0DQOA8B979pCBw+JAQSxqa4pkeSv4+P+aoK6j6M+L8UO/317TDjz5vGExdCJFGzelMz0EwAqTKQciMhCQv/X88HiZco74vLlgt7C/9cnBIoBO6J87S+4HxERT9ZE6HrRu6QBkAgyMTusMdT09Gzac46wtu5Y96BW39mqOGpa3+r/kU4+wmnS4cdFBQ4nnxL5/j2ydqQtWqLcqb5muwyYWxEDxBjtxpA27RlKdpmB+eZTZLJZVs6pfPEoNpTedpqKTH2EgHaNr4eLY8cP82TDXSHtbvKyzpjbowq0bXmKjNg9lAs0DoKaF/m+yGAeXuRDNwUtOkiTl/acM+5xcx9TjFDcKSaqPirRviS1wDSdQ9V8/RVwKvlJy9Net7wT9hQYSAYF6TzJEj9WwqzD8N+3vSuxBmmeSOSS9pO8uw8poRPza8CsfRiWjeN4fxMYp9v7eKdGEiMItZYBkzlLkaWRHbY2nLFVg7Ow2S75Fj4uT0BVm/zgTXYMdHaybEqrmm1SBWP7TDhxuHx0Hg1MvAbq/Kpv8jJ0VuR/tqh8aMXRkb9Mao4RZyEhregG/ETMfg5IqaHw2FAyWCDL0bznxjY4c+4YoG0wbE8fHxKLu9unfyGrvJk6wxG1efxGm2X7jESU8OPusXDwr3zZLePDO/7FUCf5SO1FNUy6w1TQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9S19RgWdrSJ1wAzwP3kVJdNGjMwnNPdNavQDHOWgxInUturKVoAKuLmmptVm?=
 =?us-ascii?Q?nUfl8txbExPUIuciBC+hmQgKGyu6KQ737Ztb1cJt29Woq5lgmK+bvlaeqfDM?=
 =?us-ascii?Q?tDATvSO2fzep3b8Q9HbHNZLB0EghBMZgHCbP62ynnl6mOWi+eJ2207pg42H+?=
 =?us-ascii?Q?XemM+mmhFtL+lUwtgnkM2IuYrG3V0J1O3NO58DHHpQm74+43QLh4Z/5nN7sl?=
 =?us-ascii?Q?DSvp3k4yhL1aq6NOaWAzKYVv4ZzHb9fmEzXlqVu4x3djLsgmAdZrunvHsM7y?=
 =?us-ascii?Q?3zG10Wv6U99QNj+J6X58T/PJMwJTYRYtqTVo4TyL9jRZUoYAtECqza0jP1Ea?=
 =?us-ascii?Q?Txl2Bc2DqWejRIU2T6zSEWJ87zCcwVzz+SmHzy7nrgGPl2GCOPuRRAZChgs1?=
 =?us-ascii?Q?OEMcbA0fIaqxA2RDxEfhAh/Zdp8SGpqM3mCfVWsCCmygIHznXmCmCFwlMcNP?=
 =?us-ascii?Q?M/eZ/+mUoqn//Q7gh1GtUqICoCtQJ56DYTYH6hFDgSEw+0S985tpgFet02Ps?=
 =?us-ascii?Q?Zjy6zC7l5pPDtcH4oHYuuO+qnFBAgd4GFF1XoTQOQwA8XncM9pWWDGdFsISQ?=
 =?us-ascii?Q?1uPUMN/yep24lb95xIOQsLLfqSXT7aejJh2aPsiHtX/pF2fBcHX7MbWaW7HM?=
 =?us-ascii?Q?Zv/JDwU9skoOUtABxvpklr+IUpLKH/a/o1sLXZszDKpqKu4gcQD5xMUtxLC1?=
 =?us-ascii?Q?4OyIf2ECsNfAcdnKAHDIxjVQy+GAiD5OuOB/GIWbDTHH39vdAK83XhvKhBMm?=
 =?us-ascii?Q?pfODuvrft/Wx+/88rVZPi4VHGGJNS/pPZgotGP4WSoeiTDASjY3ilx6Vy+3Y?=
 =?us-ascii?Q?zASkCbKzSCfQpUOpFX3jmfG3MlVEWQrLjjL+s9dS7MCxMp1kmJIVsvZ4xBXo?=
 =?us-ascii?Q?+kdLxPi9XypuNOCR1jeHfzs3Sk93lYpYan8rkO+dpn5X0UkN+QN6XZRJNbUY?=
 =?us-ascii?Q?vmCDRlD86xClL0aIFq0l9j8stQS0SyPlz86uWghtdFWm6O85CTmvJd1LqrDu?=
 =?us-ascii?Q?Anf6SQJ/8pdPoVNDmson+F+Lm1/1c6ldTxOlcKfa3dQI+SDtsrxBsX9NeHBp?=
 =?us-ascii?Q?fgad7WNwAumwXzlPJnIOAkUifKE+fdbNNjpW4uPFKJUotgxwZpH3EpjrhBnD?=
 =?us-ascii?Q?mbrmWKJ1kry4RNGC4PYAcPRYd0pYlMTF7ft7cTyjMm5Yx/kKlQqzrTpiMB/s?=
 =?us-ascii?Q?ehxdOo4KV5VvsbTJGtbO5VqwUgLmF20yvaBZhY/+F102xIc3U8NW0pqwW2Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d2b8be-928c-4ace-c5ba-08dc07a5e568
X-MS-Exchange-CrossTenant-AuthSource: DM6PR20MB2316.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 13:07:08.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6432

Add the timer device tree node to CV1800 SoC.
This patch depends on the clk driver and reset driver.
Clk driver link:
https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/
Reset driver link:
https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/

Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 72 +++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index aec6401a467b..34a1647cc51b 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -113,6 +113,78 @@ plic: interrupt-controller@70000000 {
 			riscv,ndev = <101>;
 		};
 
+		timer0: timer@030a0000 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0000 0x14>;
+			interrupts = <79 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER0>;
+			status = "disabled";
+		};
+
+		timer1: timer@030a0014 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0014 0x14>;
+			interrupts = <80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER1>;
+			status = "disabled";
+		};
+
+		timer2: timer@030a0028 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0028 0x14>;
+			interrupts = <81 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER2>;
+			status = "disabled";
+		};
+
+		timer3: timer@030a003c {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a003c 0x14>;
+			interrupts = <82 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER3>;
+			status = "disabled";
+		};
+
+		timer4: timer@030a0050 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0050 0x14>;
+			interrupts = <83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER4>;
+			status = "disabled";
+		};
+
+		timer5: timer@30a0064 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0064 0x14>;
+			interrupts = <84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER5>;
+			status = "disabled";
+		};
+
+		timer6: timer@030a0078 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a0078 0x14>;
+			interrupts = <85 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER6>;
+			status = "disabled";
+		};
+
+		timer7: timer@030a008c {
+			compatible = "snps,dw-apb-timer";
+			reg = <0x030a008c 0x14>;
+			interrupts = <86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+			resets = <&rst RST_TIMER7>;
+			status = "disabled";
+		};
+
 		clint: timer@74000000 {
 			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
 			reg = <0x74000000 0x10000>;
-- 
2.34.1


