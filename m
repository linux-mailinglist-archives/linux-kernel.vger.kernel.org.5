Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0213C7EFE3A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjKRHJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjKRHJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:09:54 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2062.outbound.protection.outlook.com [40.92.40.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522D710CE;
        Fri, 17 Nov 2023 23:09:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuPfV/eOMGUQonIPgpy5M1SqZc+iGIPP08PX3o32Jxu9kHn1TTM1uuN4EBMKM5DF2LesPmMgtNsBpk3p99TTEAv0X9T6EP0/HRcxoIDs/hmSWQSV0qykfQXcAsCYgrUcPOiAACIFskWcYIGp9DRWXaYdmFpBbQLz2qzOcIM+utvq90hzK+7xSan2ePDihWGRjuxAVVoV0t3x6oAcCZUPRlsARphzEuEjyLdDU5aabhls/1B6IxCKmKdiiAYnKgqppsXkaPiCb4wPRcDheY6/hDcNIvYXR3DGXGhkpa5PmjEGeV2AFdeSI7QzbXRN1NZKWxUi8tbr5gs2EwDD+U7iJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBBd0hiRl1kC/4CnV0dwx/zTn7/DG0Ghrwu95ZdJb3M=;
 b=lCvwJmex1yrl8pbyCpUuzqioZ2UUe5M0yq9JtxoBGAG8zyQ3gtEqK5klwcEgV6Az3Q6zuklQ/iFJIM0HQweFmGw1+vsxgUqqNLOnMGWcAo9u8ppQo6/qBy5DuZUpLczU2UUwFkZ4EldxTTGbQzNNBeKoLFrUOJMvkKusgSLmxYTUBiUy0LlG61QJtNmb1589oOJTV4W65mcz+8+r1KTswbRJu35/EoOsLKuwdL80g9ZfhrU521fubxjCFZQ/EFyHHUzR/+Q35FkOL1O9yxNClYpiQQuKCtubjYftj+LuHzqkPggiraOznfgZQ6lXk4YS1zX26gEI/5P5YwILoccbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBBd0hiRl1kC/4CnV0dwx/zTn7/DG0Ghrwu95ZdJb3M=;
 b=TG3xChjkU8xbbB3Oj5C983C06uL6lTx6tHYlRqzcWs3UOIpYZEbsk6T+k3uYj+oOB9xD0ahOmBusUFRPSgdOvQ38w0+d/wvAksssMoHtBwRQWiU+duwOoRpRd4Hxl+UVQQ7IuG5+o8ClmoSWHUtUh53EC6m/twGzodfFX330ixo6lIK07mpyg0QXSyU2gC5BSqTXDAJ0imaKuXQxMucgt3+rK5Wip7D2O8XpSqjQ5FFD+xwaJD0dTojdCrslbMwYPnBrADLk6B73yiKgwFHxrwyGQ3wYDcmRIyPEKj7e3UV9Uv8jo37IgCC/Fn0sMxjPGTAuN6xotgaVnMAemoswJQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5788.namprd20.prod.outlook.com (2603:10b6:8:148::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Sat, 18 Nov
 2023 07:09:48 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 07:09:48 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint format
Date:   Sat, 18 Nov 2023 15:10:27 +0800
Message-ID: <IA1PR20MB4953C6D3C913E4D18B3E6344BBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <IA1PR20MB4953C82499C5D81D2C6A020BBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C82499C5D81D2C6A020BBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wuBQ/QR0YUDu4LA55bZmXDV/XV/X183yKeFnFCW3dOY=]
X-ClientProxiedBy: BY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::12) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231118071028.248483-2-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 749a449c-5e2d-4435-a1ac-08dbe805598a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEFcn2Zl6n6v+1asEm54Bnp8IWfAx4XkBEx3RYsIS8oIThxfV2gdkVlXxZ7rZ1001eJh4C46xXBXXtSlgrHV4ZsRNo3ZnxEBZR0WiqKPnW0eJGOwlFqKChipQqFbdF1dsCnA3QMK5YfKiwWMEWknnAMvAx5YW5h0bytfTO8tuuqnZEMnwPi+XmbhtlnUlaoACE4sDKRypoCcF48eTEqyGMSUIRe8JelXQxF+GOFuNkQVj4v6002dM1/4rljAtpFCY5IiT9HuoNeJsTcxHgY928ZInd7sHptSEpuuJYTvf7ApZZAYbf50V3bIKCqpj2E3UDgz6RXAGlRs414x3ceGU8kECj3/OBErLQRgatcyYpdzV2L/jiI1N6XliIHki9nnAXikG1ozbkH32uPKFAjQ96n9KLWxo5beRuX2Xi3P3BUHjWBsiTIEXm71KVvRe2ytEH3XZ6x+LXbwhYQpDb77rsd1tldipqcd4K3EA4GdkHN52CbH5bi3vpPJwBtzf3BNGWj91NF8nX66talJ1nAidNNYIQGEDKlMe/kBXoGEfi7XLJyunkhMpeTPe6VmgMuj8t8vlywQQfz18fYGe7/5n9W84JKrheIjBd5iUTE6MhgeN2zQ0yu+Bz7b022n++dQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0npT54EXViEZTFDzmDQwCYDiJUEgypjLttlE2FcPxpQlJFd9HIWfjVojU28w?=
 =?us-ascii?Q?7O+NxXFAtXlBAx6cznVFdsKOfWODUyd2vUMtGZYygPaX5a0uZYM7jg7CywzA?=
 =?us-ascii?Q?EpaAylYP3k9BWloQbbAIZltMK/xlP3cd5OoFXCACGBnHVNUCAph57YNTdB7j?=
 =?us-ascii?Q?A1B9EcPYKZhR2A5i7Io23yI3aPzxzKJ9u6HS4caEEoMDMeXGRCRbABX/N2g3?=
 =?us-ascii?Q?+JMenlMv+icrgnu18GglLBpgvVTiFLk3+iQWSUbEoTdH/eihpAeWS0+5Teq7?=
 =?us-ascii?Q?3s0oMIuO4lIXXPLqFWwQgDHvhEHyCG5ANM5BE+PhgV20aBQtaNR7IMdUs11K?=
 =?us-ascii?Q?dZQu6xwrSI63P7kotkyhlNDRgbMp58T1IRpt/fOh1BDjZ4q3Qp9B/AXHRye9?=
 =?us-ascii?Q?WHliGCJ/9D5JKaU0VnvzJ9tiKosphFVApGU5CFfrTn639DnsNJF2/p8qX0wK?=
 =?us-ascii?Q?i67W9awGApcUwg0hXyvKQ1Wg+IkKblNXVolBYix3/SIiql122R0Pg/bgkvuR?=
 =?us-ascii?Q?r0WSw13dSdRmKUD+UY49waoe+rkUFsH8oLPjR72BWaKv5+WEzR5Fe8MwCQNm?=
 =?us-ascii?Q?M5uRF9wdYtj8WeAc95aLmi6ZLz55jDCKgf8GABJe3gkHlPPzHFpsEbjABCCk?=
 =?us-ascii?Q?hQqbCw/A4quQIk0ZM0tXUbokQk1z1BSHt1+VgQbvmQ32c8XI3nst6IWh1zox?=
 =?us-ascii?Q?IcFoAdhEMFfCopv/v0aibgx1jLEh/rZ9hjTxfUpDZ2jqHhSqOVIEgBLlVY3q?=
 =?us-ascii?Q?lCu8NBg5kDfiBAgOkKiZWOuvbqsvq+aPlOGtm65W/S6/GvIRMQDdQS/H/McZ?=
 =?us-ascii?Q?7zE0PaF1Dh+7UtlG2V960CBpfMmwE77UA74xMMC2fusUwox1u7e4+q68bWZw?=
 =?us-ascii?Q?KqF1D3LMGgTUVq5QTcthCL/o4OVwg3CsVuKwX3LzOpL2kByBXLTRZtesA/8k?=
 =?us-ascii?Q?5K/IOmIwgFl6yzrfykVWdJmlvP78BnXTDMUsKxE5V0kLjzr9Q7AP3d/oCmkl?=
 =?us-ascii?Q?yR8Ehd7qPj3OVTtyJGrmAgFRQyHtr/LfQanGd/22++ifSSAr6yJCTA8ypQdb?=
 =?us-ascii?Q?m+GQDcz+sBcGcbylIjVxNTY2hRM56NiUZgKT5J0UH7pnz50qlrLVqkN334DC?=
 =?us-ascii?Q?D/dV0NbBTs3NwFGKGil/fldtLESMI0tjD2ln3h85W7ew+OqaHGFmQXGtQGd9?=
 =?us-ascii?Q?hJyAVFNiARIKDO4orqLKsMRveK0mz3izYXEkjKgk9AWNNqXJm97o2Z5AnvA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749a449c-5e2d-4435-a1ac-08dbe805598a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 07:09:48.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5788
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

