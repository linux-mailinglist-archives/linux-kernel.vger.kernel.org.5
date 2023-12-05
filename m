Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD8804E45
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjLEJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjLEJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:44:12 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2032.outbound.protection.outlook.com [40.92.42.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F032BD72;
        Tue,  5 Dec 2023 01:44:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG/ct5KVU8LWpO50BlvuJ4/3oDMhH+baR4XyMYwxC0ntgtuLfFniehZvMgXXkvhgPPIiZM7X2SbQl7zlz48T1jjLnH7Ol6LOU2AcE8/zfwBx0KQM7GXwGYmMt7i21ShKVapQsFOtI9ByzXTPZyZVUmDs0G/0J6gY8pWLtOw1XV2scsN1vf9Hvy/a5fa03EDRVxFh8c/g0Siwkmc2kh3hF6D4fTfgogAkRTbeOIxtLIdECzAGbNJyJ0OOrEodgEC7BpHOPZG85SMxm25nne3sJ5gWhNzeAS3OZPy8dyULxlJfxCXHXYPREWn5fTdkhXvPUDBmD3Xdm9XOhrMP52af7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O3UgkxluQ+ROHJTMui1BkCI9cCAFSFZvDB6rVEvXLk=;
 b=edxgpJKdDBh6LddlJgMqIs+Lvw7RIwMox6B8TCgJjstVMV71ixIkkpmWqlxxACfAb0SYyJrUNpG72FpNjqebPeLOAEby6DhuhIoPtAPlA8k7sOC3xt53ZQGoBsjrZw+ejoWFy67DCCGRK2IrqChRF3+YFps/8qKf3ebV/tahL9FOTX7jRpcRyCr2fVtiLNn3I31Xd1JPBP8ESM5HCtb1PayXo6S/6rtEjSyq3b5tNhGnCcLqEIcADnZnu5f1IhOHwDtGKHVdn8Iv7A0Jn9+EDh4QMaLn7RJ3MbElMfEWiZbuEr9BFOJLv/jkPC68nxGDOpS8xrwjUxZCTIgyywLhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O3UgkxluQ+ROHJTMui1BkCI9cCAFSFZvDB6rVEvXLk=;
 b=pabDCcdHDAVUY2R3kJZlClb0PerwKNLRm/oF4iYFVQB7c7mgeMaD1Ez+4JZaViNV8CxbJL+jy4vYcZObdeRh1OmWcIGh3mY09/Mjn767rUnyfecnwqBhNQR/1MyJF0zO6GUwdawXRelJDr3Tus7Tp7dTNVr3cYm5Ic+JX1ojPKFa30Mr8atqjKycjD3eT74k4/f0kRHYui9SZoxmg5Ov3tJYrFa3Cb/kjofEsAR1tjBunfyoblwJ8xJIfMGUh3pp7mRzXdoxLjALCxxgMy0es9+gY3UMxmQ6hR3Bmuiik9R7eqfNDyFtU5K8ZMSm3KW/VbZMUm+rVsNureiFUrZl8A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5247.namprd20.prod.outlook.com (2603:10b6:806:25e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:44:07 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Tue, 5 Dec 2023
 09:44:07 +0000
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
Subject: [PATCH 4/4] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
Date:   Tue,  5 Dec 2023 17:43:40 +0800
Message-ID: <IA1PR20MB4953EF6EC4F5498DF1A39908BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB495382B725AFF6FC2C336BA6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495382B725AFF6FC2C336BA6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [l49USsWAJmOZS/CpMpkr35jk7T4qSIJ22B1fmnDUzTk=]
X-ClientProxiedBy: BYAPR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::22) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231205094341.943713-4-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: c831f81d-cead-45a1-f8dd-08dbf576b9c3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuiPlAkEHKgZBq28vphtDapFpyWddKlPR1t5SQavGtYZsiDRtuqKqdrXfHqRv7QHJ7UQfzYgZOS/txu3tL5hNNAojbvkvkkIyw2u1jD18tLKyxmMNN/M/tO25ab6XU0Yw6CbRjuWALN0tkk2HOQfa+llFUeYWRnLYA/m86OEipdeK0xVt66pX/86ese5vGp60G21BDGKuOB18LDvdMF12NqM5EfN/TQfOfGZSzktbi6F3bRVGOIFSAHn8hBF+HqT2d/QYjQh+TnqAlo6z+2rQhuf286ocIftnXLl3Ccwdo217HTk2IUZdcmGXp+Avv+E+bKhjVQfc2GdxsJw6J3TOHBeYN6FLFoiNcTdBlfhsWTE/JKf6v5IJSE2Q2qP5IoAGff7Jumn3xM6LiiB3iaSGbCeKdDTWxJCIukt48VcvhLQ6pK5EfozLsroyKX9X+6t2soQT7gKn6AJTu3NXS2Q5RKehThN+0XECuHp1ngzctuFpJgqCUP0S3zskf9NzL65gp423vt7i4mETr5BQjsOY70rMIQvVhAp0sRg7CI8BElwWviyIhrjjjngoopiWN0hhfBZ4v1AqbuhbGDSgMnfWp4EPtPTCJeh/fkhgNzPFo0dZcvyaPek74419aFZir1E
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pn7TTH9aE29YJZY7BfJxH2svimTIho17CVtA4oBzYazS6xKN66K8K6CeT+B+?=
 =?us-ascii?Q?Iu5wW/p4kLOxJETnXBfXY7qnc1+OBixZLXEvm0uii7BS6nuBGay8D95wRM1q?=
 =?us-ascii?Q?3ixc9+vgYc6oJLGYyV34+8HIy5vwef8v/wUqjyRwVf56+JPm/pLgWK1AkFla?=
 =?us-ascii?Q?rIXdlp9HWlvXuF8tStYTaw1cPFfTPi7y8s3qLtUEV6mwyYkU6YNa0QQ7bjr4?=
 =?us-ascii?Q?K1+qGvKehSTEgTqji8TipW/Rq9E+BOHXPnIOq8FdQeyBGk/NRp1yG07TeSIu?=
 =?us-ascii?Q?iS3zf7mv0fsLxPLn1yumLZVkYWkEvgtE15lxiWmGkzSnEeYcTgbzafPiSQ77?=
 =?us-ascii?Q?uvJaCh0KkGjABqEmLrY0auPh68xDXfB99ct0dtv8PCoZXZ06ah9IZuoGVw0h?=
 =?us-ascii?Q?xgW0hQxhD66EIfsJwYAJ1qEW9Quthd4BrvGxeTspI1WAmSOMzDqWvtnRdtuD?=
 =?us-ascii?Q?r5ToiFNkTgFDWZmLAH5U5iKqvDdoofVggiDL41rv1/bnZOciUcHQlkioicjN?=
 =?us-ascii?Q?Pa2sAeaf+jriPL7mrdWxXMiaUt0hb7njw7UadG/Czwe3Re93u+WsCF2/6HCz?=
 =?us-ascii?Q?L3g1S3V1j581N4fsDFk065N9ldLaOp+pk/+YBt/biCp6IakOVm/dJOg3ZWWr?=
 =?us-ascii?Q?PyIfs27+62msPtHaohl0Uzw/rVBlO1CSTM1Xz7S2T75n69LQPpV5w6RTKEmG?=
 =?us-ascii?Q?zx/eK0YQIyNcRRQptDQzoR+iFtbkj+sL2avzXsnXQfm0tSdgzPlFm8eh1Bym?=
 =?us-ascii?Q?MuGtXQJ7xelRJocyyf59HN0LuQ1xMR0Burw6bw4utde42MxMfA0/KRwRJg5B?=
 =?us-ascii?Q?QnZk9sGrxF/Ax9pAjY5f+IqoPiXcQnIbQP0+KdvzVjIgPBTeq7A8U3WoF2Cd?=
 =?us-ascii?Q?syqzSHndz9QEPkmMeXztuzcNGojXsAFYYstzofZOfoFnGWXYTJArl0YeeKWV?=
 =?us-ascii?Q?Xt6XOakzdbXKaRxttq3N3J4INOkcOmLsMKx+olOJ7pOgluvNujv5gFJPdPaa?=
 =?us-ascii?Q?ATXc/HCctF5C+URAFqryAFoZin60skBPu+cGphadA/ofpbyrfVAtgoWG+pW3?=
 =?us-ascii?Q?Xwa7BDr5Hddfy7WxxR/uxRi6/puvv5zbaoLW4v/t2cnS29k7bIIeJ4E+gplq?=
 =?us-ascii?Q?gmLY6edNAEt+/keyUOfb7hjRTtD23DCxpEtsx+awbb9l7UNlewa8HtUooLgp?=
 =?us-ascii?Q?iaKgidO9QJtZg/FSjnhI1nMRoD52Iyu1vs6gb+nx0PJfOQPzubOiVUwUgGU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c831f81d-cead-45a1-f8dd-08dbf576b9c3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:44:07.8474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5247
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clocks of uart node for CV1800B and CV1812H.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index c5642dd7cbbd..3f290a515011 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -5,6 +5,7 @@
  */

 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo,cv1800.h>

 / {
 	#address-cells = <1>;
@@ -136,7 +137,9 @@ uart0: serial@4140000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04140000 0x100>;
 			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clock-frequency = <25000000>;
+			clocks = <&clk CLK_UART0>, <&clk CLK_APB_UART0>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -146,7 +149,9 @@ uart1: serial@4150000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04150000 0x100>;
 			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clock-frequency = <25000000>;
+			clocks = <&clk CLK_UART1>, <&clk CLK_APB_UART1>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -156,7 +161,9 @@ uart2: serial@4160000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04160000 0x100>;
 			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clock-frequency = <25000000>;
+			clocks = <&clk CLK_UART2>, <&clk CLK_APB_UART2>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -166,7 +173,9 @@ uart3: serial@4170000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04170000 0x100>;
 			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clock-frequency = <25000000>;
+			clocks = <&clk CLK_UART3>, <&clk CLK_APB_UART3>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -176,7 +185,9 @@ uart4: serial@41c0000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x041c0000 0x100>;
 			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clock-frequency = <25000000>;
+			clocks = <&clk CLK_UART4>, <&clk CLK_APB_UART4>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
--
2.43.0

