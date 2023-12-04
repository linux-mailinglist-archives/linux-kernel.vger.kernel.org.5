Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192418040F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjLDVXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDVXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:23:17 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D335B2;
        Mon,  4 Dec 2023 13:23:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsqkO/5uC0KW8m4DO4opbbyiol/vKY5nf5mGnERcDglORdkz4LBAAo3HejItJ30/J7lIJpqi876UvzVxd/D9o/RP6EytIBtcfQIGCA/9M2k2/pXjIrjCTfKb4UkorGM6WRgxfKVRM8dv5kNO6G2xshsAqC1yVkrIb1aHgAe2AgarCORhAZ37lHqQ2jlQ68sEQRv+22gubTwEnjWcS90+RzlH9cV/2MvoaOInUSWy/lrRywW1d2lvL26kSbc3lmADIg9ALiz9ZhnW/itL981RgmIZOYNeIwM2dX1t1EwGahpHGjn32Xh52QMUnc9K2rJ7QVxa+oSjO79bFZta2Fs0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=punIIq3b0aAiCx3YFZXHjD2hlnD9QFhoiXQn5tdC+bo=;
 b=giYiKk2KOVjdjbP6F2P1R5kN1ou5cBZz7ccnrTf0NIzhU9vHVxhbqyjaY++ZATQMOna5FlUR7BXLAXgfHYbKV8fBA40p1/X4sD+s4E+Xc2paJCYBMhsCXVAl4TmJD/5v5lC7Ttsd1YJnmQxBTj0s+Kn0ky91eaDBCDThUgGH6Ormt9b1BAaSHBlt2DX62QB3PXYz/JvLCoWsITlL+wzlTeKaO1bEDXlGCeCYu2Qzvw/YQWOdI0faec6Lm/rngzZ0H/JoTy5lRhbpou0vUeo1uIzTVDG9OtxZhf6RxuX8jSgujKs7MbUn8g3b2EKjUs6llEqsaq+SR4AIUXwuUMufJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=punIIq3b0aAiCx3YFZXHjD2hlnD9QFhoiXQn5tdC+bo=;
 b=dXNTjHyA5BfgwS4Wevx2oxEYkvRMTY4EKccp9oj6p/aSVDzP6B9ygYg/XAjhgV8TggzBvcXlbisFHW0/GSSkeIY/M6W30MUFq5M5SnTAXY6mDPemjJrdDGfWzxGyp+NToNAx6HLNdpAH4Ubg/wXKu8lQk2Iwk8FSO59x9HMkOnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by LV3PR22MB5292.namprd22.prod.outlook.com (2603:10b6:408:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:23:18 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::388f:1cd7:191e:21ef]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::388f:1cd7:191e:21ef%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 21:23:18 +0000
From:   Garrett Giordano <ggiordano@phytec.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        r-gunasekaran@ti.com, w.egorov@phytec.de
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: [PATCH] arm64: dts: ti: phycore-am64: Add R5F DMA Region and Mailboxes
Date:   Mon,  4 Dec 2023 13:23:04 -0800
Message-Id: <20231204212304.1736306-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::25) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|LV3PR22MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: 771ae1b8-a73b-405d-f236-08dbf50f3bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AZeM7zy+nVqoJNGz2o/zMdR2lotBNq0csKyOflE6jl4PBOgj8cQ3IkOUFnVKkaqCSi2MgdWdXqLriOzEvX43uoobYggvCm+jqDa5nSfvtWY/+Ty1Nx7ZIePzyY9JbkwddBc1am+VWmtzWqvq+DGxwzwcY0acaBCkbZJdXO+3f2r3Yljm85eJo0rSNwvuGar9yLDa9ShQ8FG+8Qb5y44ar0KqAi3IACmc80sL1f8MDmo23ApeTXS8fffV4kerjrrnXIQv/Wa3r3qRz0LYkvqTHRknj9UEPjLqhyZmih0JD4VkK1LWq0bbCjf5gulfkPNO3SLwn+wPNeaiKP/blg5B5buFqeiDb+3HlYRt4vslBvGOFCDZDxpkI32+Y9vMSQ+Q14VR1zM/cz/yryN5vDUVB/5A1lOj2l2F2gcSUWrIAJuoLGWVxAcX17STCpMR7wUrUzcZeRKek/nLCtDx9NVD7GzrnJi1MOpZgnZdEMZYfbc9QEBkzKwrTGEXcSCOB3lAAYhzCIu+5yz/a+ZdqpykbOcFO9yinuEE8/tDNUfaTlGFh8fOgsBMbPefH8mewBG4t7VoRYzYc4QB8vc5UZZx3ww9VCMhdRTTv9Cs6ei3r5ZZIhs2OaKluNtyyR9q6Cp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39830400003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(316002)(66556008)(4326008)(86362001)(8936002)(8676002)(66946007)(66476007)(478600001)(6486002)(41300700001)(36756003)(38350700005)(7416002)(15650500001)(2906002)(5660300002)(38100700002)(1076003)(2616005)(26005)(6506007)(6666004)(52116002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r1i5Qb3Bg1Rl1Q/012Ssu1Y1JyMyEhxYnTi+q11Bv83egiLJIpG39yw5ybOr?=
 =?us-ascii?Q?q++v3njpJ15U4YSyUuhSwf1UIPlne/uIibMSg2nDPcIvtxxZLGMOAEMUa/pW?=
 =?us-ascii?Q?a3D/wpErTCPWwG8PSAwQYQGnU4OjoNFW+T14ZztmlQcTgu9KXrS4ILd0SIz5?=
 =?us-ascii?Q?wbjd+X40LOo9PsSXowhlb6RaH84OYmd8cZT3QvesRpN608507YK4tzURJqP6?=
 =?us-ascii?Q?XGn7smncxz8LORGtq2WFZ1JwEKY2YgQSe9SNYmuvy9VHWEaJQEFj74hpRMFG?=
 =?us-ascii?Q?2BlJQkfQEXguPwS5yp5Yfie8Wfi2H9/dJGB6wGU6f+ggPfh5gZKptrB5tJCs?=
 =?us-ascii?Q?K3oHWO6UCIrgN2feOYoQoTS/hHNfv85G6ZkE3AYZSI5TLPZqFKpa6ncbWMPN?=
 =?us-ascii?Q?zXvaTNb8r7JTFP+9b1TNQlYUuuQWyVJVPyOy785vP/rzSwIrFxBAM2VH+nrW?=
 =?us-ascii?Q?yCaRYxbWkTSkNiiteJF9PMl14LYDhMkw2T7Wh2N8sKa/3/+OBaBwNnhXOr4V?=
 =?us-ascii?Q?2W6poa5v31msr6gU7aI9qH5zGxVz229D7p7H6wDOW9vnhYeoVulA6g1iopav?=
 =?us-ascii?Q?uMl96FNVZ8U31xdSk3MO1ORjkC9CHWUeV+PwF2fyj7CIGJxwzX//A8awCLbj?=
 =?us-ascii?Q?EGB/FPXun4kkLj3ZX05KfQQed7QMj9uQ2BDvswEpfS208ely4CRkL2oZUSCV?=
 =?us-ascii?Q?a+JqXg38pVb2gAMjOrjx9Uvn24BjYGIizfUwchDR1nGJ03YYYmwIlj86JwLQ?=
 =?us-ascii?Q?/TSePQs+FptxDiQwDleiGqy2d6vsXk60hYivrYnrSrps8K6BsNzpy1GFtJWw?=
 =?us-ascii?Q?ZdLle59gkYrh3r5UiGFN7x5bd/87CUssHbNHhdy31vxRIWSO5vXGbB0p+2Bi?=
 =?us-ascii?Q?gwugNyYce6mnd+/o9GavZtswqn+F7ZVurDNMnfPDCwH0Y9ZskHU+RgCh1sRY?=
 =?us-ascii?Q?4JjD7gBCviUOfHiAw3d8ORS6wq46KUX8hODsBL92Pc+JdJNFmuQMbUZ38itm?=
 =?us-ascii?Q?D8NE5NDZ+g9RVwqSKbHQq15btLeeVw2eOmEjcSMM6tPYo2AS04T+tlJVlGQx?=
 =?us-ascii?Q?1INOSz4C1ySEpAL1XV2VtHqr0fL0WrEgdedsQI7OC4KDuuqtN9QApF10VRjB?=
 =?us-ascii?Q?qjRsx8JV+o7GFnCjmLrFMBkykHcKeAvt4g+C8eycWEDFOzrgMvIyfv8Himcw?=
 =?us-ascii?Q?Hk/YkkPk4+mrGyMECUMCrvdRJzywo+1GI/io/L/PVtlsf9TrWZ9G7BvOzLRq?=
 =?us-ascii?Q?KNBUnLwUstf3DqZRTrs2gfdqD8uQ3yWeuqPq5PyMhmkCBQiN+oZLT4b7DPgo?=
 =?us-ascii?Q?dsJEun7Vx/vkxW6RyCszcLs1PZxKXJzKsl4+dIh/XXBSNwq50d9TT8G/i5fz?=
 =?us-ascii?Q?iM2ARRpzGw0WE+38ECsxOaOlgDt9oBGEGHEJzMv5NgNatRDDD0TjvtZgh3Us?=
 =?us-ascii?Q?4iOho6eBu5DAXeVnrWqS3iS99MtBJPPiktz+Rcg2NoA0yOKNVgvkeRjZrP0+?=
 =?us-ascii?Q?RenVdImZRq4SDgTf6fd4XrIuPQ5wRxiu3tQfgYiyY1U7BRuPmqLRMUXrRuZr?=
 =?us-ascii?Q?LFGdcbEufzBP/V9TNfPgdQpoddEmk3vB+Lj5cWxD?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771ae1b8-a73b-405d-f236-08dbf50f3bb3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:23:18.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEYFwIfPBh9orC69Qg7HRC/kT0fspMRPtF+7cM95aj/8xCW4liFNn3Q6fw6BDokVP5llUQCTDmOUXiXBqKuY4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5292
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Communication between the R5F subsystem and Linux takes place using DMA
memory regions and mailboxes. Here we add DT nodes for the memory
regions and mailboxes to facilitate communication between the R5
clusters and Linux as remoteproc will fail to start if no memory
regions or mailboxes are provided.

Fixes: c48ac0efe6d7 ("arm64: dts: ti: Add support for phyBOARD-Electra-AM642")
Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 102 +++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 1c2c8f0daca9..37a33006c1fc 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -29,7 +29,7 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
@@ -39,6 +39,54 @@ secure_ddr: optee@9e800000 {
 			alignment = <0x1000>;
 			no-map;
 		};
+
+		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3100000 0x00 0xf00000>;
+			no-map;
+		};
 	};
 
 	leds {
@@ -160,6 +208,34 @@ &cpsw_port2 {
 	status = "disabled";
 };
 
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&mailbox0_cluster4 {
+	status = "okay";
+
+	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
 &main_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -180,6 +256,30 @@ i2c_som_rtc: rtc@52 {
 	};
 };
 
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+};
+
+&main_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
+};
+
+&main_r5fss1_core0 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
+};
+
+&main_r5fss1_core1 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
+};
+
 &ospi0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1

