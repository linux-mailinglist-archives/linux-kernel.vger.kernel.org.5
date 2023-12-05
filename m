Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E8F8053E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442301AbjLEL4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442384AbjLEL4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:56:02 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2019.outbound.protection.outlook.com [40.92.46.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46BDD3;
        Tue,  5 Dec 2023 03:56:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBfRJ2M+YchjIcIxJefLCQsgeJ4sG/Le7dB6nbzzU1VL5TfRZtLNwNFt4+83n4RVLyM6jiTWL+BDVUwFma3xZsA7+/f+0W/4MteJ3lZbD5Ld3h5rNtscVocF+SqnKgg2eEl/ErugAEOvlvPE7MyZqHC/MAIjXMUWw4hUH2EM/WOfAFs21v2EcGdjLfoMsA47RkzhlM2B/lQY7dHuad1V005QdEdQPUpN2Hz+KaAQRCDendJrTiDtZrWU1rLMhEFKtHiCUEkcp2rkxLsnuXRlxG7uwFF24EeOIaZmVEupNfpNIaFXVGoGv3bBwz1jQDmAa4iBWCK+fQG4hO46+CXsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRGWdGJrOwy0Kzglr0wJP+3yrtUaNFEVf9rbWcSCYes=;
 b=YCg0gFr0tggistvfjKkh1u4H/xdvShmTxLqSOpZ4Qkb7FLfcll2v8Gg/D4F9toOIOhdCZXLciMeoQHFMkAo9Vh1uqZCZER0OG0sRXUxPrKwtcTmIbNxUJ3/LF4EBxt97IBXv+7UiPkRn40EvHBC9YopNTGalYShfxyrHkx2i119bCoAAFbuzFJej3Y2dwyldH/zvYruYPjANpatKbJoMhuIXP0Wjs8dydHAOBAkWnZR0rmBRBeH2hlGVouZBZGEs3tR7hVo2tS3GgK36Q1z5WP9HdFvmqG98SecZUYMdADF+RVWJE5ZiQ0CD2KeECalkliYcZirBzf6/3cz6OrK2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRGWdGJrOwy0Kzglr0wJP+3yrtUaNFEVf9rbWcSCYes=;
 b=W+jE4TrbFM50f6wwsnHu6nwqlbBHg35PCXlFgQcHltBsMEINMXKuZDceZuTOgXtGqUzIFks9yu4dMtGnYOJw5qpHaKZ85E736/LmS+wxKpzz8ebPqurp5qHizhT/YONUda3qPXxcVcOwrZlOGekhkQffWzwe5/3/TZLSMV0ijn+SaLLXcA49Hpx4YZ6gpMD/xoJatHoxu38owcY0viNRqtDTEfq0duebozhhFe7xd6w5xCo9d6OCiOEGZ0BM1kR13LwUQMBLIGjTKgG/smaBeTWolbUE60TLpQ1dG1aSmvhYnIwj8oRw3zAv/eBOMhhEyASbk2riHjntkcZY7PuZ1A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB7005.namprd20.prod.outlook.com (2603:10b6:408:1e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:56:02 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Tue, 5 Dec 2023
 11:56:02 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, Inochi Amaoto <inochiama@outlook.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
Date:   Tue,  5 Dec 2023 19:55:52 +0800
Message-ID: <IA1PR20MB495338E03BCEF6D1764613D3BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49532E1A3D8BA71FDBB444BCBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49532E1A3D8BA71FDBB444BCBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [1LzopHneD1s0ElVdW09OaHdpOv9W24NvDHGIa67DkWw=]
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231205115555.1042712-3-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 471b8ee1-eeb9-4b9a-e525-08dbf5892785
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLDl0dveX5cESmc4JMhUES46obPpmtIYFaOmEA8CbF1VJURg6TftT5asrcI4Wsdc9hPqWRr8ctI0pMYHNDIKfwuzw8ERe04qYKeUQsEdr3cnllYKUTl496IU3X1U+t16YVQviXr3N73VB0pHvpR/L2sVFnBvNrDWh2UC/TitWcePR30aZAv3DWlc3ikRUNlJ845YIg89j4f07JACH7MmBdB9isyA4z5vSGDyNavRJCeQa0vd/bUrXj8ZHhumejOByKom9KNdGHdTiJ/Y1tcTNL7Mi4tQw9OHKQwwj8PX2YMsno2mN7UWFiLaWZwpgIlYrxMHF97PIECdalTmWA0/srxS+eUk8hQUV9FZWpL5NnOFqqKSF0T7ojKl7ZkLmAQPRaaNcrWW+l/gbdYsIUMCZT5sO6/Pw0TPXozD25S3wIC77B/WQKbBGT+wy/2EBFvJRN+mJhR3RMC+o6Xp6k3rzCduLuJySaavRZpGy6oaVz14XqkW9f7wY22Wdp88J+6MLkaTzKSyjGcZ3yP5osrtWeKDVhfmq5E6TUTvAPi0+pb6ubxM9a1MoQSs+zyhQItt1xXu3i3BQg8Z3bPCx2/BOu74rW1mrM6gnDqesO+xo6WtRzD6nLtJJm8/tUpVovba
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mu1J4exCZ7HFvNUreLFLju9kCMFXzC608+xfJVB8FDJCaI1+CCBuTntYz7mI?=
 =?us-ascii?Q?T4bauomXpKb+lGnW0pijI1vIJb8GcwhYYfIe0MOxIyNiL1DybAhIMJqnI2Z3?=
 =?us-ascii?Q?w4vIfDjE5ceP/Ws5qS+FQIIMsiejTV27qChQ802DMbo4t1ZfADS4xV8Mt+Vu?=
 =?us-ascii?Q?iCxoohZdMk7FIZG2QaoaO50GsLevQCVMxaWCuR3I+e6M7zBsqpYAtVEP6D1w?=
 =?us-ascii?Q?n5escVx3iZ7Ud/k2N9R6GviHrNDNY7gGGQGwHTIpQhPt8PcwGzNXk2WmmY02?=
 =?us-ascii?Q?Tx1DI8ft/WUR34H23qarJuSEp6zMtYgvRgSpVwvVoh4NJP/flKlLL9So4zOK?=
 =?us-ascii?Q?ShXwU26mxcmswMWZAAj4IeFTnRKQh/xXOcN+WsM+54YtI9TadrQAGIee2eD2?=
 =?us-ascii?Q?bitB6AIZX8zmgzhevcyeReqVkQ48Ms8KgBgf8Ai3YXZUn6OYbNcNaIqQm4IT?=
 =?us-ascii?Q?1I1dwKsCZk3XNN3KxPcMzfj6MTGc/viWyLrCOKmUsuDTsIoQygvEgHw06Ck6?=
 =?us-ascii?Q?IK9V0y3efaKSV7HRiv6p/fpXWBJxrY4TcL9icLV1HSauWbGM2tJpIs6rRmQn?=
 =?us-ascii?Q?q0cOopbWSSsuLrGbUaiK+Am5iJyI+Nl0wjRYBmnNXGfaavCtsLUAO/se7cKb?=
 =?us-ascii?Q?7ti93TNX+b4s2HzUe3R7PafRDM6m7KGrB4MnHDJIQfuhb7+HVWlMZ0HAhsTi?=
 =?us-ascii?Q?NbfOlBfgTNCfU7nS4nzWNKkX0tO4LyDBa41DyycDzmQ8wokS1/sIP9R3x3N9?=
 =?us-ascii?Q?ZaMRtOcSnienKYJoFuWUc1Tw+fb4MrokyvMHjNgo7Ead+jPFNeFWSP+wVQub?=
 =?us-ascii?Q?HpyIxlyU4Y4eO9wBspl3A5mhATUHNIFeCWnz0ybECboBW9MEASkD9y2Gfwgv?=
 =?us-ascii?Q?6rdyKpY0PLNnlkYfyAOJL/QXYh13r0XWsb15ZZE+xEBZI6OtPWhROCwLKqML?=
 =?us-ascii?Q?YzUqhrcjLfr94mATht6DXWxqUuEwKchivXk6L7fGKcX0hrGEdedkG7jSXqmI?=
 =?us-ascii?Q?JGmpn7WvItrmTghCfoU/Z2R0XqB2BEoWzdNqi5LdqEeZtuJdS5IUCgnDztsZ?=
 =?us-ascii?Q?XTJ7dgUAYSmxvDS7X9tFxrzKq3+rbQOKdjNVcUAwNhF6Oy2fZF5IdfE8azBa?=
 =?us-ascii?Q?XmMQWxzFsJ/pH9KjW+DL8cJKKjOKq26kXZWDCHkcf6qoPTpvYRqenP71tzJs?=
 =?us-ascii?Q?mW6q6HlsOY3qVw5a7n9BNwsUBi8TJviJhgfcpNLuzbYT/4YJ90Fk+15ZzYI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471b8ee1-eeb9-4b9a-e525-08dbf5892785
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:56:02.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock generator node for CV1800B and CV1812H.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi | 4 ++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 7 +++++++
 3 files changed, 15 insertions(+)

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
index 9a375935b00c..83243c918204 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
@@ -21,3 +21,7 @@ &plic {
 &clint {
 	compatible = "sophgo,cv1812h-clint", "thead,c900-clint";
 };
+
+&clk {
+	compatible = "sophgo,cv1810-clk";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 2d6f4a4b1e58..c5642dd7cbbd 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -53,6 +53,13 @@ soc {
 		dma-noncoherent;
 		ranges;

+		clk: clock-controller@3002000 {
+			reg = <0x03002000 0x1000>;
+			clocks = <&osc>;
+			clock-names = "osc";
+			#clock-cells = <1>;
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
--
2.43.0

