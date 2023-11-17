Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0444E7EEBDB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 06:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbjKQFHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 00:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345678AbjKQFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 00:07:22 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2108.outbound.protection.outlook.com [40.92.43.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB551AD;
        Thu, 16 Nov 2023 21:07:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9GKGDl+zY8GjgsYUNfhmQUfXhjgIIrUMdHVb1OBhddtU5KiAYm6hpHqf8CCSC49oU7aQp7Y68KUsohIOFclI4if5Xg4KNdXD5MfWaKcKVzz3AMQ4f2E7gjac6IYqB1RE3M3X52PZucaftWBjHxJoqOM87s5V5j1+N4lFHW9k1ncpmBK7eloAOlAVzHZgQAvuC0k2C4xwRZ/D0b6mU4Wb7mKDfHdEiqiZlVilI9UQNj7Qz5ROcxhTr0eNaU/m2p34iNU7N8n1ywhyRk0SEEulRa5VKt8h8Ofce+kO88eXG9USV3Z9lC7fnKAaYvgs1fq+fMVVTg2xkl+bsgRHRGa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBBd0hiRl1kC/4CnV0dwx/zTn7/DG0Ghrwu95ZdJb3M=;
 b=JuWQFmbkv0OHYFGJfzqWv1FcA/ukcFyPu4BGchMiORHsfVGchrGQ3ocWCZGcVz+ddUHwBwxZjv1eCW7eXY30U4DJUMn8kM7uNzXlytbcnGGnfOVjfPswsxkWH7eiwUEj5f/tXUHdyM4dj/HUxOX7uPZubdBLBmfa1jd7r9HXAqM3Hjc374pwuroxWSTjctujKmzVZb/ZQ0wQRk/EJznCshIPy1uJpQF67paP7Xz1+2B8kIW1Kti+behHNLuhjgVzcj/5/tNl5ZzVr2dP5xhMLOiUFSFopTqPV6pIX0N5KSJqxs6wDKeCfvrZAv2SnqMcBCzrc5KKQnw7rSgzTKNk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBBd0hiRl1kC/4CnV0dwx/zTn7/DG0Ghrwu95ZdJb3M=;
 b=PKCnmi2eK1Q7QVvCrGcvVlmkNs4CcDmfjkWdtmxG0NxdzL2CjHDHTFi40I1Fp+o7HsKdLk/kqHy2fIaH/5Vpe1E6+DueDu2jO1TkCuhtb4ZOcvODpU2yu5dCP/FRlK2aKxR4Ms2wSFlih3jLlg1y+sk91+5Sv+DXPdD6dG27AnlV3o0j5+MOx766LFLhaFLO7Fr3mmFfQhbfp/MAvsqf65XyNyh3HVeGHzTy6DtqQ4fjyODspMQUHMUrm8VL6c/Exsc8j1NyXycfRHfyyDcx6ZeLj6/OBsSomXsFCB9Cz9LSqK4Cu5dh++mPWHeKdxnav4An+KwDm4iJLd2rhjl/IA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB6394.namprd20.prod.outlook.com (2603:10b6:510:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 05:07:15 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6977.029; Fri, 17 Nov 2023
 05:07:15 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint format
Date:   Fri, 17 Nov 2023 13:07:52 +0800
Message-ID: <IA1PR20MB4953104293CCDC29B08343CCBBB7A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <IA1PR20MB49533488308F7317C28AA6BDBBB7A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49533488308F7317C28AA6BDBBB7A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [mkQOPn6RrDr/EOxQVts4RJAiUvtU04Jxjg5wcZU7Oxk=]
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231117050753.870596-2-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2b5128-b0d9-46af-c819-08dbe72b10df
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1WDU9CPleeGB7ELLtyKs2wNjKertzMkrvqRwMpDfI+KG9RjjTQQyLk6+hw3M6ci2wMnD4AmnZeRKnXbRPxiRY9Ej4qwEu35qWX6E2GU3wyzYGVj/SvhmpR941NYqVnFZb3RULP7Glm+6dmkf7ibiNpm0gxm0dSUm3JJ5zrsGuSaEOHgu7FnP2nglx7n9cASyXuRIdkP3yYceBrbHR9HZcgb5LczMEgN9AjomuATkU6dHLm6z4ikFBWaA1C0Y3tzKQ2p22XQ9lriwAfKo6PS8F4Y3hHJaWD5Z7dZO7/fXBETr/TCa5usbgUXzy0tF8tV3DKyDjiAdA4wtvtXePXJ57jNhulQXui41/YBqCLfYpnpJSz9mTr8EdzW1GZViYjCfM2tA0BC64nHN20tb+qKiJ5okgCVUgy8IrVlGtFx+p33NNyOZ1ji1S6VE8B8icQz+eBOku8QGWF4KLnz6m1n8wJA3INcp/11XXTsRZHylRadBdosHZOAyzQGPtuqqCFjc3S5dG3BpaoO3UYcZpmchtOKcsN/0JrnkeZbnfL2yzzK+JGoSUFkXVJ2lRvZb9pf0i3GMgJ1zYuMsF2gvDfLkVSCBD1UPSK8qi+Wb9YaVgah3Bmcsrr939Zvi8/ii52O
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g5K3mnjhMnxAPQ5EznO6zGhbqW+PQjNCM/5VDZsnanwqdD+57TmwyKw1VGeO?=
 =?us-ascii?Q?r1rfKT05j4jDEM8jXsxIv4fcmWjXwc+W8JfluGL3UuaqzV1JsqQRRi6r3LCw?=
 =?us-ascii?Q?R3EzZ/O+HpuVioZAdA5veAIBJqUg58atVw0SYAxxs0ydy48Cm7CaCfFlzUzw?=
 =?us-ascii?Q?MO5+KGHnywDmR2eqY8IMovb6FmJc8wCTgLqAtYFQR3ahoW4MbdSZmvxcBjVL?=
 =?us-ascii?Q?RE5BUmFNiSmMym89QSM/EFl/FiaI9AgQmkzdEbhvXFgvt2m5FspyioBf0xXr?=
 =?us-ascii?Q?WOejSsVubyCoW9EeveTRmyf47BIp90YN/p4RTQlp2YaEQFhhMEUHtapzaZQr?=
 =?us-ascii?Q?uQ9ulKmt3g37VtpZajQXq/JAPAnglLcHauPbccLzuo9hZbYOOaYqA+OZYCDr?=
 =?us-ascii?Q?FMtDT5w8DGVw6/n8WIxN02lejHZovScdNI60G1cfNADVIDV0khLgQl/Mq0uP?=
 =?us-ascii?Q?QZu1f+XItbniXP8YB03pkNBPq+9EIpKUbEEEKS/K7bzxBLcK81XiNYyCXNjd?=
 =?us-ascii?Q?D/sYcZJE+N50yWlB9WGJxxSjRNYFafAe9EohnQLdAMjNeoomqIcA/79xGcSH?=
 =?us-ascii?Q?++K3oI4mKrGMra2M0uXwYTNmkoOjk2K3WwnmayVh1WjM/bGShEKhJcNDr1Ib?=
 =?us-ascii?Q?LsSTqzr/IIjSDAmzXmk8CmHsCuG7/Geaon4NBXYrcL5JpF2K2tuQB10aD0Vz?=
 =?us-ascii?Q?WUOfN/oQvA1914LIRnPV3dYJNTNXIjSmBxTKg9pb7DstDJ9GLPaQlIdco73x?=
 =?us-ascii?Q?2GBe2IWUI77TRDpo3Ccceg+EfBS338g7MmVYK5IigBQIYWFxt86cYYiI424O?=
 =?us-ascii?Q?Fmiae6YlrSBgho5j2MFUuyvQSHDITPM+RyMd0uCVSD7JCUWz1Bj+qCANvmdA?=
 =?us-ascii?Q?Ae97Yq72/17+fP+vZJTgbsSZCFfIt7UpTXvJntiehMI72oKEI6fNZzajwK3h?=
 =?us-ascii?Q?kTV9eTKB/xlJMVi4IGk7XPop6QK/9ScPwdOvIFmkvxDOH8rrdXMS+2dTA1MB?=
 =?us-ascii?Q?Kj907VOqhK44tgv6l/J2E5zNHHQfHjxdR1PR/xM/tfhoD8+eKTzAfWwLw7ND?=
 =?us-ascii?Q?RPL9oLjPwJhhMKNsyfEXuoHhWbqHd6BGvkuHJ2E1mwsjI2R9B/78IA85Ssaq?=
 =?us-ascii?Q?byQ40f8KZ7ISZF8J9B7M3u4p1WAnUA9LXTl7fOytd4HfVEczTcswJMcLr4n1?=
 =?us-ascii?Q?Ge69AdOBFknFl0Pm7sUe5Jm6M7Oeg+YbGCjvptb/hZr6RelDnBj7GQTJgFw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2b5128-b0d9-46af-c819-08dbe72b10df
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 05:07:15.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB6394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the timer layout in the dtb to fit the format that needed by
the SBI.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Fixes: 967a94a92aaa ("riscv: dts: add initial Sophgo SG2042 SoC device tree")
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 80 +++++++++++++++-----------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 93256540d078..ead1cc35d88b 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -93,144 +93,160 @@ clint_mswi: interrupt-controller@7094000000 {
 					      <&cpu63_intc 3>;
 		};

-		clint_mtimer0: timer@70ac000000 {
+		clint_mtimer0: timer@70ac004000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac000000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac004000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu0_intc 7>,
 					      <&cpu1_intc 7>,
 					      <&cpu2_intc 7>,
 					      <&cpu3_intc 7>;
 		};

-		clint_mtimer1: timer@70ac010000 {
+		clint_mtimer1: timer@70ac014000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac010000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac014000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu4_intc 7>,
 					      <&cpu5_intc 7>,
 					      <&cpu6_intc 7>,
 					      <&cpu7_intc 7>;
 		};

-		clint_mtimer2: timer@70ac020000 {
+		clint_mtimer2: timer@70ac024000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac020000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac024000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu8_intc 7>,
 					      <&cpu9_intc 7>,
 					      <&cpu10_intc 7>,
 					      <&cpu11_intc 7>;
 		};

-		clint_mtimer3: timer@70ac030000 {
+		clint_mtimer3: timer@70ac034000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac030000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac034000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu12_intc 7>,
 					      <&cpu13_intc 7>,
 					      <&cpu14_intc 7>,
 					      <&cpu15_intc 7>;
 		};

-		clint_mtimer4: timer@70ac040000 {
+		clint_mtimer4: timer@70ac044000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac040000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac044000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu16_intc 7>,
 					      <&cpu17_intc 7>,
 					      <&cpu18_intc 7>,
 					      <&cpu19_intc 7>;
 		};

-		clint_mtimer5: timer@70ac050000 {
+		clint_mtimer5: timer@70ac054000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac050000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac054000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu20_intc 7>,
 					      <&cpu21_intc 7>,
 					      <&cpu22_intc 7>,
 					      <&cpu23_intc 7>;
 		};

-		clint_mtimer6: timer@70ac060000 {
+		clint_mtimer6: timer@70ac064000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac060000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac064000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu24_intc 7>,
 					      <&cpu25_intc 7>,
 					      <&cpu26_intc 7>,
 					      <&cpu27_intc 7>;
 		};

-		clint_mtimer7: timer@70ac070000 {
+		clint_mtimer7: timer@70ac074000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac070000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac074000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu28_intc 7>,
 					      <&cpu29_intc 7>,
 					      <&cpu30_intc 7>,
 					      <&cpu31_intc 7>;
 		};

-		clint_mtimer8: timer@70ac080000 {
+		clint_mtimer8: timer@70ac084000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac080000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac084000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu32_intc 7>,
 					      <&cpu33_intc 7>,
 					      <&cpu34_intc 7>,
 					      <&cpu35_intc 7>;
 		};

-		clint_mtimer9: timer@70ac090000 {
+		clint_mtimer9: timer@70ac094000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac090000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac094000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu36_intc 7>,
 					      <&cpu37_intc 7>,
 					      <&cpu38_intc 7>,
 					      <&cpu39_intc 7>;
 		};

-		clint_mtimer10: timer@70ac0a0000 {
+		clint_mtimer10: timer@70ac0a4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0a0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0a4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu40_intc 7>,
 					      <&cpu41_intc 7>,
 					      <&cpu42_intc 7>,
 					      <&cpu43_intc 7>;
 		};

-		clint_mtimer11: timer@70ac0b0000 {
+		clint_mtimer11: timer@70ac0b4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0b0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0b4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu44_intc 7>,
 					      <&cpu45_intc 7>,
 					      <&cpu46_intc 7>,
 					      <&cpu47_intc 7>;
 		};

-		clint_mtimer12: timer@70ac0c0000 {
+		clint_mtimer12: timer@70ac0c4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0c0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0c4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu48_intc 7>,
 					      <&cpu49_intc 7>,
 					      <&cpu50_intc 7>,
 					      <&cpu51_intc 7>;
 		};

-		clint_mtimer13: timer@70ac0d0000 {
+		clint_mtimer13: timer@70ac0d4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0d0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0d4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu52_intc 7>,
 					      <&cpu53_intc 7>,
 					      <&cpu54_intc 7>,
 					      <&cpu55_intc 7>;
 		};

-		clint_mtimer14: timer@70ac0e0000 {
+		clint_mtimer14: timer@70ac0e4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0e0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0e4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu56_intc 7>,
 					      <&cpu57_intc 7>,
 					      <&cpu58_intc 7>,
 					      <&cpu59_intc 7>;
 		};

-		clint_mtimer15: timer@70ac0f0000 {
+		clint_mtimer15: timer@70ac0f4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0f0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0f4000 0x00000000 0x0000c000>;
+			reg-names = "mtimecmp";
 			interrupts-extended = <&cpu60_intc 7>,
 					      <&cpu61_intc 7>,
 					      <&cpu62_intc 7>,
--
2.42.1

