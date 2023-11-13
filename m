Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3E7E9476
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjKMCXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMCXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:23:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2096.outbound.protection.outlook.com [40.92.21.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F02B11C;
        Sun, 12 Nov 2023 18:23:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwyqAbt7/ort9PDNLC/XfyEB8O+bEQU1nNexukyXXJ5yNfIwIlxSxhY8uoYcyZI+ZtTJVHcCcYEtHSQ+7d4agQJjkSKPVSHrsk5zV4MMfLvYwsbWDwQYGQ4rMvftUYxS4ZLhqj9PBLBVkbxM+95vYkwyS5wQ6rZSiIztf3urqrtPEkKIGgyfI2MUGIw8Q+awVDDLUE/EJS0C1WqO22y4WO60uZAHzd854dGX5mnOv7NfRXkmEC/DA/2QJz7ZDBuAC6XcknuX54/ntFLbMOSVXJD9RvZlbiQJtWz4shCn28LS/ldycd4P1B2PegatSc8oYtzvvxFbc3JVs92fm2zo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3p2gWsaGfy+eN0wYhaYS9pM5sfYQbyopz4lxiaPD+I=;
 b=TkEPO3e4VtsVgHUtbA2zMYRjWE8n3NrXdti8an8r4YVymvnHx4RxnKGfBJyeDMRlpLzUhStK08RSjtjQWWOSi4+mewGYL6g6cXjYlBnDeSUnnDFaT82z34O4iXqxYzqITRYcaWQ8hyir+GZh3eyrZKaqTSSnwSlA0qvYhDttHR7pdOLw2pTzZ1dRu1LfzFN9mMm8twdBaAqSVdmpaqDHDNL5AuNFGWUEmc2rxiXXMdeuhdXSiBdBJXcYmSJiGnnKu8o1aRaIWnkC/MAm50zMJ/6Uz1a5Cqbr56X9hEub4s2bJ7ymmspmgw6Dm3S2iKZtbLLye+ZKmVwGH/nzVgPucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3p2gWsaGfy+eN0wYhaYS9pM5sfYQbyopz4lxiaPD+I=;
 b=vT97LCILGkBC36UZV6196WRYxxuQ7EJaqoom7UdZ8MKNCWssE/LOh+PV/gaM9YbpM/jZOYz6ZLDFDie+yiJZst6Mlx/+okr/3u58aeFR0EQKln6T/FnMaT+C5aZmjkqXQ+sC4Z3+eBnnHjrBGF/kkCKDJLuy8Rk2iHvG4bK3oLukT+bF6Ht+ENYFtJe8tF5xiUeOAPiwYhMAUqnq1ZPFFZwzXwRPZNO19PhYvpOZfqy/b/ujt8+7kGbDP8p7Qx0MGKpH3Fvtr9DHq2DgqY+/k+pcjfXbhWjSKSzZCisvYw2AiavIuGlzWHduHope7bKcsCKZJcWW99BwVuvJqCUdSg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW5PR20MB4404.namprd20.prod.outlook.com (2603:10b6:303:199::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Mon, 13 Nov
 2023 02:23:25 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.6933.029; Mon, 13 Nov 2023
 02:23:25 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint format
Date:   Mon, 13 Nov 2023 10:24:00 +0800
Message-ID: <IA1PR20MB49535B8B71095E00C1033F5FBBB3A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <IA1PR20MB49538304E99DABF0208C00A0BBB3A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538304E99DABF0208C00A0BBB3A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [H6mLKybWizIlvpgKA6DLJNArxrqbrZyJ+GwCDSA/dmY=]
X-ClientProxiedBy: BY5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::40) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231113022400.36203-2-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW5PR20MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad70593-5636-4299-88a5-08dbe3ef8401
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TdttWWzNy6qd+nyu40jKhQG28u9yHPI0V87bZuOtP/HYTQJyUpHk7TfRYVviHJlyGT9glfyABekVZ3fnNvmKW8tsQ5Bd8UF/XTIKBrxtAc+lXsQcRuLo3kB/1yjWHduORKBaxRhtC+TeWMcCeTbZ2626N81oh/c7tZjSaGAlyoGTjPwLPMgZ88Mc9tqzBatqEBv4s4Ba8YqE9Gw5Bm4/lu4+Odgft5xhTg6TsQEAb4ec9RlL/LO5ZQIPVVXoueYNIwsnowDUkZx4spEZn0Z/RqlpKIumNmXR4EwmoQ9E/KUKcSYHK1Srpo3+U86mOYBbnzR7DKpY8i/5LMxzm2bD2NDVXhXUDwlpQ9gqsTxeJ3zbgXcpxLH2K0lVDpiw+bB6/LyfPJm9aLuy0JWD33nwfVGAk+DENSKa4+T2AtHFmPLlL4khmdx2bC4Z5Zyxe8fdumXF63Fd5GE17/nyuAjoFIYbC2NWCB5pL9gE0r1zjYlL7yP5DBgE0eTbmebfKUgGVJ1fPW6gwJ5e/9ym2gK1H2smWtGnb4jjwvOFDG4hM45jSrX/JyAOTjPcxwhoPD0Pan2aww8qB51/u/r99GGyoPnVHWt6O5uDuFMOiiRL0NGMQL3w1biDrTWlkAJ/bcN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VTmX/lTrC9FSIR3RwhcKKPHCBNzUbjVVc6Lr9yfzMJ/OEnEmsaNqhRS7EJP/?=
 =?us-ascii?Q?JnNhfXwA2pHKc2WU8Ny7kBI0vlTami4iLLzvpmIU+ol9Z/CIvdg8YcHuoKk4?=
 =?us-ascii?Q?NCOaId5qPYLz6S55Ktt2YffBdfT4MAU81a3jadX3tg7KGvbFiVB3pIY/gGrG?=
 =?us-ascii?Q?+3Yu2wBvxMjTUJbFGLV51bQmfFQWb5xEedCpFzHRLlMwO/gH69lMFkn4DUfg?=
 =?us-ascii?Q?MBYDwcQTj1R7XPCXyNfTmYD4JAjZnZDk/b9GeIj47TtqVPmLKZ0C5Ja+TJaG?=
 =?us-ascii?Q?rS7CJm0Awe2JgzUuKFb85utaj1s2TkIyThLEx53FBgih0BtsjsKkc7TGaovw?=
 =?us-ascii?Q?HUE69TGLPqDXjPjSKtQgJm4T2NH8IWgrnj2+VYUSWq7uToEFn6cD8V2Gjqch?=
 =?us-ascii?Q?YmD1vSVjfdInDj6NBuOG2xerxbenOgflZSmAz9ZGm1WUk09rA5xXJmhIMN2P?=
 =?us-ascii?Q?iulJyf7+Go8vwuWQYaOg/92TuMwzf+ODjlhkN9o4LbteBB4AO3AuPWXBhq77?=
 =?us-ascii?Q?eYgRGSa0qQu9GaLMTTFXL/oVuF3dZ6/S3PinN2iRI8Y1zSgln722FLGjoetA?=
 =?us-ascii?Q?dngjQsbYsrcn7MmGB8qkN1ug2EU2XfG7cjQ6NzFOpuJzHLP6pcqQHM46xXtY?=
 =?us-ascii?Q?pmH/yEBAuEYwX+b5KpMQESU45iWP0cruoT3HIkhgHVKlK6rnvAfdL3lzMPsX?=
 =?us-ascii?Q?IlBi6lTMcHrQZN9pn1RtTEseuKkTiFBHToYNf6b5mAgRy4chxRSPtei/a1Pt?=
 =?us-ascii?Q?zP1O7RWloI6mPYUSv4QeqcFWhlJiPOt9KBjeUmGLnlCj3hf0fW/zbuX9iIk8?=
 =?us-ascii?Q?vz+x/4mlXBSNA8k6szKXjge5yAzd3V04RMhDFu84kYpuSib4SSIzJipFwNFW?=
 =?us-ascii?Q?nKG+92VgHWwzP5K9K0alADqZmhTcelMdjThjHSTvqNJKL9gH2ZKe842gn22h?=
 =?us-ascii?Q?y3nY1v9697DuubcwBmPbr2F9uXliOYUZkWDCMMK6IOFLp8V+OaBCzNZZskPW?=
 =?us-ascii?Q?6fe9ybAsgSLkdgnT4d7RiXc/xooOH1JWEjTj11vl5kaxnCWzzee5tBA3QrY2?=
 =?us-ascii?Q?YkG0Lro9iDqp/k+RRfV1BARP3aRnOrtwjCBO4i1tXPB2aTJDQtpe6yEJpBvs?=
 =?us-ascii?Q?T84VKbXsthInrBFDriozmMDgUABZuqiUP4qFDQetzpMxWwE59MGc98IZd08B?=
 =?us-ascii?Q?Iw6sqDe9EItrmtXB7FtlA12NGuLtLZRGXoHcm/HFFVGaRs91LlLrddxs6k0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad70593-5636-4299-88a5-08dbe3ef8401
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:23:25.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4404
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

