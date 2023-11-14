Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76B77EA7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjKNAo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 19:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjKNAo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 19:44:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2085.outbound.protection.outlook.com [40.92.41.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E444FD57;
        Mon, 13 Nov 2023 16:44:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEuGDaUM4PDxJd1VNdJ3lULZYZdbgspu95Sat3cfjlPspN8CG1udP2v45qOh8pXbjxL9GHxeQA7yc2jr+pIJphD/yXmA6xAYgjNQ8gHV5Q+YbQcUSmf5hwb5wZiQ+60aEjdEFr2djJtni3aAMvV4/4aat7/L8hFjcZGqBYIf/tqKvOJWTZNepzYMQyYCzjaMcJVTi8j6yE3jG5dDr5HEMR0WNxzb2gZgvgBvXW+SDq8FUoZVz1UUFbaZi3ueTX3pIKY4INSU466JiUJ+mYMT6uEUPgGfK/ScuU0akBGUjdJ8Und58vIF6UpAeNn/15HYT1vVmDp+u6i08Az2oyxlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3p2gWsaGfy+eN0wYhaYS9pM5sfYQbyopz4lxiaPD+I=;
 b=Eh69fzCRB8GyNei/JtW2hZSUt9/e1xIygXRXhm44bqUnl1H8eP0Fmzm71lChJ+0KcdJD4BaegOdU9/jSCRvvm3XaARsOV5PV3sfiEddEY++NgOhwE51jalp6Rq/rRv0fjPDMHRV36VyLMNPXdYnOxPMMkyIaXU8p0fVRJxsu7hVYPd9xOQPYuyI6YKIuS+hfHpiqXxrinE2n1W4++/isSN/v9zeSk+H2zDwxfgi0wqIwoEObZSNzMbBhY8JyxBKIFMu/qOGdLKFImSRDEa5c5ZFbya6QadopZHxl5mBDcRdo5Oqk7rdW2waWMUvGUHLlqnNuGphHwz5Wg8gGKP9dNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3p2gWsaGfy+eN0wYhaYS9pM5sfYQbyopz4lxiaPD+I=;
 b=l5RkHVAO38g8Lu9M7h/LBsYK5AOFCifBHvUW6oNLvNiUSUSdV4N59LdDiL0QAlFkRRQLxJeRP+SamIR/5M4WVJv+MkiZ1rb7CmKYWrrX0Ks1rSFo7lYkoosUFBOee41ZTOVoR/o+EykdUNC1VPbzILH/C5GmS1swZv9pNO4xM3IdyOTiEgtRQUxVXZqj2hw2UIo1a8zIrhQ6t0ZNQnvotry6BEQKkhs0Pgo7cTkX0kJGsaBKzTloilukT+U56gbDblmgfI6paUlJB90M0jtU8I88yPtGRmKdaV115KAjExACFVcP2zi6pZ2+usg8TV34tH4JldebWiZeCIBK44P08g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM6PR20MB3492.namprd20.prod.outlook.com (2603:10b6:5:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 00:44:51 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 00:44:51 +0000
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
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Cc:     Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint format
Date:   Tue, 14 Nov 2023 08:45:32 +0800
Message-ID: <IA1PR20MB4953B943AF1B43CD1EFD7BC4BBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <IA1PR20MB4953BB0ABD29F5AE938A54ECBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953BB0ABD29F5AE938A54ECBBB2A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [s1u8kyEb7LUZGOEBX/k+s+0hJ1OmD+0zX/swTeX/NvY=]
X-ClientProxiedBy: TYBP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::31) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231114004534.43833-2-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM6PR20MB3492:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a5bd1d-79ee-4285-c022-08dbe4aae927
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibnJdM95xVjXXLUTasErrmQrkX03kne5f95f0j+oRSxa8XPe4KCsxN+/6keJYmhE6LMm7cZx6FHXwBbD19FBJ5KouAQBZC9i+RvyjKp1STypcproyaND1w3PTIsQrtuzzlMPRwXrw7iJQrJLV6mg1viUcSanwDg/2RqHLPcsgrW/hvmEFovWBqwGXoMlP0uS3DKSu3DZdryGaWRRer7epecQhakgC2YzhXM7KNg7ADPQr3aGSfkox9L9rx+dFBzDLVFcCX8hbAlQ8QRRK70ibEt+dg2yP+VZJV2+W7pHHXO8SC9zcA1G95ZTI46pKjatUJisC1Y+bfmd4sAntKZkBRvZ/TV+A0Ks0XTjUuuu5dYvCOrgKjzkG2U4qM3mjq+Nw8rsfaLiCr2z1EoAWSocQVPsV2PU757TBC5myMJJHrZddlGVevI1OFEa52JOlBfmKSFbOcbV5mrDQuuAi30DzxIWf3038foFO7HMvs3iRdD9LUC4RTbogdwJTXS1T3OkWt9XbGAISMZObSbt0YLSKFEO8Dy+6L7OLmwxUgAuaX1fnYNKrYjihWbLxZLfoIG/cC3S5LvtPPsq/ekVYy84bpBZ5R/1KSNEGyzAsUR3xvf267LLj79AF5oRiyExR+DU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPCSZhlrhYJzo7SeoygTkiAEYmls2FgAOMOxlz4EGlcmtmVjif2ycZYbq53c?=
 =?us-ascii?Q?UnGs3Hj385n57Xp0IAypnz0gb1zua6jSyZjD0Y7sAwpNS5/RsimqzLCApMIB?=
 =?us-ascii?Q?Y8YIO7CWi9Bj1GIefMmZ3eJt8ZtabHZWTG+pb9HG7C5qVzc6Yu88qHbF2AMb?=
 =?us-ascii?Q?5Iq50qdzRIKXg8naRRXhsRYiOY9p9x/1sXIF4aBfAx0YmTFusZEFjhnmfMqF?=
 =?us-ascii?Q?oC0XAcuEiBdpnMnJwqyes4vWNd8L2i02Oy4F2o3bqeFwX41q7rmRN/LWwdNQ?=
 =?us-ascii?Q?LXFfYpI4s4vnzlS6BZ52D6ye/UDDC0UCDERv+mdN3OJY95B+kXhN0qC/sdor?=
 =?us-ascii?Q?+A5uGbCm1AzFaIWRh7i9VremkjsfBLygciV29PA/WMCnrq3IkFG0+4mVXdv4?=
 =?us-ascii?Q?rSVvMHogsPAAwCWD8q1lnGOaSrnudOqV95BBAYhmM4hH3FpOFoDeqSW2y4gz?=
 =?us-ascii?Q?uR1p3Spn05299WzQL56V33ekHoM+EuIgyTXbsHsKMfbjn5LIviWCvkNjFZRZ?=
 =?us-ascii?Q?lxaa5ilEYAkchlUAj0nh/5Iy90OfTL8D7JMOtyWeVFjrJj81rxbaSPrYogdp?=
 =?us-ascii?Q?n3UbZGZY+LGq58TLo7USmIuil7rD47G1aWsOQ19/isAnMLPKinFOqTAYhphq?=
 =?us-ascii?Q?NL5A9z9wg/3HFy6Jr+vfrhp8osR6o19rShy6yZ4G/xPhu7FXjtcbXXUtX0qL?=
 =?us-ascii?Q?uYqjho0cuSV3pCs1hewfiv/aBiQbigwi+x5G8LT17kXH2LvWYGhN0c5FZpKa?=
 =?us-ascii?Q?D3cHa4EWaiO/GRbEpwAJiPUcpQey2UCiYmHy9mri+C+k5rXLMDbyMp6yxkr9?=
 =?us-ascii?Q?XX7AkvDJltCLGR2rt5uiY3BGrkCY5bHw52RRBfXrQrEG+p9NJdu2OX0P9XmZ?=
 =?us-ascii?Q?5KWpueS9NY2tCsk42C3akPCrjYeaufCP8OLLf8xloNgTtNImTegKHd/yAf7K?=
 =?us-ascii?Q?4v7zM1/4Pq+aiVc3Le/VYaX1dgNecycBXIHDM+XCKmdlWgF6tW6KmvgoUlGI?=
 =?us-ascii?Q?LuL+RKRjmidl6NANQFYc4XTnRhLJOiUQjp1qGlBuhJYfPTZ34/rNCuzlMF/3?=
 =?us-ascii?Q?HkX7EB14FQtpGWcyRcauemxrGyKGEyg43vOSMwRavk/vb4x4qKMfodky7PHz?=
 =?us-ascii?Q?AoSS68W1oqfDqoy7jqe1N/JFjxVY286qNlULMmWHZfyk7ACvjmwiN05H+Csm?=
 =?us-ascii?Q?rFVSUcV7AoIK9QM3/gYA2teZEbh03q/vPW6soWJDPcBh8x083cmQaLJ7N1s?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a5bd1d-79ee-4285-c022-08dbe4aae927
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 00:44:51.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR20MB3492
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
index 93256540d078..0b5d93b5c783 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -93,144 +93,160 @@ clint_mswi: interrupt-controller@7094000000 {
 					      <&cpu63_intc 3>;
 		};

-		clint_mtimer0: timer@70ac000000 {
+		clint_mtimer0: timer@70ac004000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac000000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac004000 0x00000000 0x00000000>,
+			      <0x00000070 0xac004000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu0_intc 7>,
 					      <&cpu1_intc 7>,
 					      <&cpu2_intc 7>,
 					      <&cpu3_intc 7>;
 		};

-		clint_mtimer1: timer@70ac010000 {
+		clint_mtimer1: timer@70ac014000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac010000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac014000 0x00000000 0x00000000>,
+			      <0x00000070 0xac014000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu4_intc 7>,
 					      <&cpu5_intc 7>,
 					      <&cpu6_intc 7>,
 					      <&cpu7_intc 7>;
 		};

-		clint_mtimer2: timer@70ac020000 {
+		clint_mtimer2: timer@70ac024000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac020000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac024000 0x00000000 0x00000000>,
+			      <0x00000070 0xac024000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu8_intc 7>,
 					      <&cpu9_intc 7>,
 					      <&cpu10_intc 7>,
 					      <&cpu11_intc 7>;
 		};

-		clint_mtimer3: timer@70ac030000 {
+		clint_mtimer3: timer@70ac034000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac030000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac034000 0x00000000 0x00000000>,
+			      <0x00000070 0xac034000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu12_intc 7>,
 					      <&cpu13_intc 7>,
 					      <&cpu14_intc 7>,
 					      <&cpu15_intc 7>;
 		};

-		clint_mtimer4: timer@70ac040000 {
+		clint_mtimer4: timer@70ac044000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac040000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac044000 0x00000000 0x00000000>,
+			      <0x00000070 0xac044000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu16_intc 7>,
 					      <&cpu17_intc 7>,
 					      <&cpu18_intc 7>,
 					      <&cpu19_intc 7>;
 		};

-		clint_mtimer5: timer@70ac050000 {
+		clint_mtimer5: timer@70ac054000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac050000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac054000 0x00000000 0x00000000>,
+			      <0x00000070 0xac054000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu20_intc 7>,
 					      <&cpu21_intc 7>,
 					      <&cpu22_intc 7>,
 					      <&cpu23_intc 7>;
 		};

-		clint_mtimer6: timer@70ac060000 {
+		clint_mtimer6: timer@70ac064000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac060000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac064000 0x00000000 0x00000000>,
+			      <0x00000070 0xac064000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu24_intc 7>,
 					      <&cpu25_intc 7>,
 					      <&cpu26_intc 7>,
 					      <&cpu27_intc 7>;
 		};

-		clint_mtimer7: timer@70ac070000 {
+		clint_mtimer7: timer@70ac074000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac070000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac074000 0x00000000 0x00000000>,
+			      <0x00000070 0xac074000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu28_intc 7>,
 					      <&cpu29_intc 7>,
 					      <&cpu30_intc 7>,
 					      <&cpu31_intc 7>;
 		};

-		clint_mtimer8: timer@70ac080000 {
+		clint_mtimer8: timer@70ac084000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac080000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac084000 0x00000000 0x00000000>,
+			      <0x00000070 0xac084000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu32_intc 7>,
 					      <&cpu33_intc 7>,
 					      <&cpu34_intc 7>,
 					      <&cpu35_intc 7>;
 		};

-		clint_mtimer9: timer@70ac090000 {
+		clint_mtimer9: timer@70ac094000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac090000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac094000 0x00000000 0x00000000>,
+			      <0x00000070 0xac094000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu36_intc 7>,
 					      <&cpu37_intc 7>,
 					      <&cpu38_intc 7>,
 					      <&cpu39_intc 7>;
 		};

-		clint_mtimer10: timer@70ac0a0000 {
+		clint_mtimer10: timer@70ac0a4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0a0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0a4000 0x00000000 0x00000000>,
+			      <0x00000070 0xac0a4000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu40_intc 7>,
 					      <&cpu41_intc 7>,
 					      <&cpu42_intc 7>,
 					      <&cpu43_intc 7>;
 		};

-		clint_mtimer11: timer@70ac0b0000 {
+		clint_mtimer11: timer@70ac0b4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0b0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0b4000 0x00000000 0x00000000>,
+			      <0x00000070 0xac0b4000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu44_intc 7>,
 					      <&cpu45_intc 7>,
 					      <&cpu46_intc 7>,
 					      <&cpu47_intc 7>;
 		};

-		clint_mtimer12: timer@70ac0c0000 {
+		clint_mtimer12: timer@70ac0c4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0c0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0c4000 0x00000000 0x00000000>,
+			      <0x00000070 0xac0c4000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu48_intc 7>,
 					      <&cpu49_intc 7>,
 					      <&cpu50_intc 7>,
 					      <&cpu51_intc 7>;
 		};

-		clint_mtimer13: timer@70ac0d0000 {
+		clint_mtimer13: timer@70ac0d4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0d0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0d4000 0x00000000 0x00000000>,
+			      <0x00000070 0xac0d4000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu52_intc 7>,
 					      <&cpu53_intc 7>,
 					      <&cpu54_intc 7>,
 					      <&cpu55_intc 7>;
 		};

-		clint_mtimer14: timer@70ac0e0000 {
+		clint_mtimer14: timer@70ac0e4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0e0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0e4000 0x00000000 0x00000000>,
+			      <0x00000070 0xac0e4000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu56_intc 7>,
 					      <&cpu57_intc 7>,
 					      <&cpu58_intc 7>,
 					      <&cpu59_intc 7>;
 		};

-		clint_mtimer15: timer@70ac0f0000 {
+		clint_mtimer15: timer@70ac0f4000 {
 			compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
-			reg = <0x00000070 0xac0f0000 0x00000000 0x00007ff8>;
+			reg = <0x00000070 0xac0f4000 0x00000000 0x00000000>,
+			      <0x00000070 0xac0f4000 0x00000000 0x0000c000>;
 			interrupts-extended = <&cpu60_intc 7>,
 					      <&cpu61_intc 7>,
 					      <&cpu62_intc 7>,
--
2.42.1

