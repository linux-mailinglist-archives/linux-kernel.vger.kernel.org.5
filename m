Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84DD80833E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378416AbjLGIhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378367AbjLGIhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:37:41 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BBBD5C;
        Thu,  7 Dec 2023 00:37:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+/trpxvupJ3fA9gFhJIgiTQesIsA5eG7msyIM+m3SCV5fX3lSA0QGpUBj/t+AKpW4h7h86rr3t445oVFj7qKhxrv8UScYWEHxreyvtqRiGUv8y+zjKT1tlAr+3GCMxGs90/ZyzCXFKGQdTCLsTJ4O93ctDXZEPhCMkUWmiG90h8/CzWaEsbE3UgzLVH6JB527/b8v6omWZ+EwvCXinTCywAU5LmvNJXNnoVSVVMMy3Wi2jlluwK8QpfxDilyld0EgUwcwS+XJSVy28h4eDmOkvfXzxp3PXCj1q5syE/nZIiuOBBqa4wJaPOSCGO/y0qDsDP3aSeQFs0p6lr/kw3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTgy8H1C1fuHRUBmFVOhWrHYTv60QgZF2tb45HQv6QM=;
 b=MZc2wOuhCOuYUXLnO+J2N/q1FNkmjDIK55lNJB1OxnMiGTdWGafFahXDM7iZF9hIorOjc/xTpo2C7/S/46qhYnZjiQ0otPC5EOo4rwMT9gJYk24L1YO4X6yhUAIzVYfofUXuJYc50mdjgMg8LuX+Ow7korLhsj2p6E7ivOKNqAQXxMbyxoU7JWAzRSSVbpcvRa++kOTmFjXKW2mzOk9RA+C5N+7avz1RizpU5H76asAmntmZkwWElUNFGx+xbn5DEa0LiHDzEJIaDY92QMWtWoewDe3a3IKhEqDu2HHCu5t63eU5R7JVtfyMqRGvDAPc7hrVXjg7TJXZ4AZfQt9qJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTgy8H1C1fuHRUBmFVOhWrHYTv60QgZF2tb45HQv6QM=;
 b=UUU3QwETgwks7B9y1QytmQHWMmETSpqEnM4/VWbzmA4nabfDWFgePua3eWBdKMaMC4jATcR3ZOJe/1LN1h6cgSGjfZGZrZYCM7KArbtkV/sfx0ZOM2ZS/rIvutm3VIZOAlGg2rfCKGFPgA0ds6oPqNYeEoewI5HySfnJrMncf/Z1npiyNuOypvv+Wwp9ZMpBY1C20RuAkw+T2HdNP/uYiM0FR+u1CvHYQSSGWfTjRc1KagLXi9oYCYVNCjn1ABGJIflTJbNjwhK9zc4ph0uXFFuxoL7P138QE2hEowCv+YGl65psYKRzx+Ea/A6JjCbdvwWJcESJtCo2Td5XaFszvQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV2PR20MB4582.namprd20.prod.outlook.com (2603:10b6:408:17e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 08:37:42 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 7 Dec 2023
 08:37:42 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
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
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Liu Gui <kenneth.liu@sophgo.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        qiujingbao.dlmu@gmail.com, dlan@gentoo.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 3/4] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
Date:   Thu,  7 Dec 2023 16:37:28 +0800
Message-ID: <IA1PR20MB495373158F3B690EF3BF2901BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB495376DBED8EE897FE11A2B7BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495376DBED8EE897FE11A2B7BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [kD5v6N99tlapV7aaaqcQtmE+DlDXxfAL6W3yTtsTSjU=]
X-ClientProxiedBy: TYCP286CA0175.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231207083730.874690-3-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV2PR20MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e31a256-0c87-4032-69fb-08dbf6ffc747
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pfrs6ndXXRk/RsM+Cq058O1f/ffZuUpNACBemIx5g6R/u8WZ9JV8y4j1HEXMaQN+gKf8Uf/E5SK9Csyyz030cypwJUrdC9w84p6vrxhbDp1b6WgM0i7thhPv3V4Wgul/jzzcqM6X2gV2PlOgCwJ5EF4akeIedfFw+c+g4XzcwS9xXgQ1PlaRwM7KNxF0dVb+pEQK9ZLu9t425HVC2B6vi5ULbuH2eGiuRVQCceWFcn532E2IkDI8VNVCkPNH4eP3yRvb/Mu/KQu0DdxOk3LH/tKsjyNGQ83DqTCrnmf7NQA8yQV118Y/JidpU2d08cSCS3K7wKToQOGBxDAWIPqzJEbHjsaCCABGnbZ21pPZYVMknkReo+uoykYm/DNJbKOB1PoUm4VoO92bB0IhLDDhMkWauJUcf+GEfZWETIHlukyVdIslwQN/CNFTQdxtR978AdtgVg+wnL3QzBEmnrYEvFFoN8IHLQH5m5iUy6avc20o2llsDEMUniKHwD/2K4yCHun+zqHV0F+ElrEHCo3qJhDJOrmPg+j7ILmNQnI2d7AI4RkTtnoO6tAx0YTK8P8J8tewhdaacY/6JDzxB8mMldT8nWWxDhDTTDN3h+QBbNtCazlaj7E7Hb1tlCgMBI5P
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xjOt6rFqmC32JHUoHixo8StaZhAgBsuuBWyEs0ilVf3Yfgj/hTuDNfk3oAB0?=
 =?us-ascii?Q?pIQ4DKE1R5Ul0ZtrJqvBwQ4D0frLLCTzz4SFhpuJEfruQi0fIZtAhKGv7Oon?=
 =?us-ascii?Q?IHf34L3ox/tMRQrI914qB4Od9ab8musCz3o7rLlMosdFnIfAD6csh14ZYJll?=
 =?us-ascii?Q?vYOhZwAcOXj9D17XtexDSQ83AEGrA9aANW9KR+VZc05JCPojvl/YjaKo1VdF?=
 =?us-ascii?Q?k7s9GjFYHplKUwCj1qA1kzNZOMBeuO8+3U205RO09sSzSYhy0fLY0C7U/phh?=
 =?us-ascii?Q?1hxpIKGt+6YGtqanBNXECqbqKeN2dJO5utP8ULdK6oRetg8YuiA/wV9HMnrp?=
 =?us-ascii?Q?SjWAoGIbDYjqIRtgLqe7jvzrfvm317AXO0+fJHenHNWsLD5Uh0oLjwxLYndb?=
 =?us-ascii?Q?RuxETfJ/iKfnNbXKHW4wfloRS6+mD6aq4iCNI5w2w2ci8TpeqHlLmAPHVOP6?=
 =?us-ascii?Q?QD0QbpVQcy/NO9myn6oeUFAtHaqvgw/oISvyozhtpqUrVN8iUt4FDgsanBN2?=
 =?us-ascii?Q?/Ho495m1TyT+EeZzikH6UFlWUQLlT8fvGKk30A/SYLMOkYbHumSjBEZ172G+?=
 =?us-ascii?Q?SFDNvH+wILt1Wv7fQcculs9CAkcvZ/Dnm4fjEwTOvwL5q/vvYz2aSq3GfhlZ?=
 =?us-ascii?Q?sOj+6fA6iJ6r27JI6OHsx3azrHBFrhqxQNVREAhh3J3Mj2udaHc19k/Rb+nq?=
 =?us-ascii?Q?Nb+ApNym80wnWS5MxPrMVT0LoP5fqKwmq5T+mZTAgdtm+q0tWEJ5c0fgRRIy?=
 =?us-ascii?Q?SCVdaGcP7G0HNBPBYKlkg6pwodZGJPfZxzRLBokokEQzluhU8KRsDLKWY+sI?=
 =?us-ascii?Q?33vo64gk711ojPbiEXeGOHvsHIBAvKvApDZmf5UlNLPDGCXxsvJrJa+6eYtH?=
 =?us-ascii?Q?uvF6olptk4WPo00Aiga6VBqfDJnI3lRtXWMbDfbOEXaU6goax+Cu7Er8Bv/g?=
 =?us-ascii?Q?jgvoub5sxPnwcYv3qjzoz0PrfxYeHKieCGEMHvh0k3UsKHf2NAfy+DCPjKAi?=
 =?us-ascii?Q?xhDwKDIL/IW/lAmQg63UqkwJq6MdvolaSVAR21Rn2WZUEg5ulrDP3DWoFEts?=
 =?us-ascii?Q?Ie5ghMktrfIPa2Nvm/zdt09FpZ3hWSkNRZJ6FZ2plphNswwQG53oxuZgen4l?=
 =?us-ascii?Q?PSRLVaxNhgBWjZyUu9jBGDdyZdlaTOb+acg1XHlfCB1X7bhsHBND8ZMFRWiG?=
 =?us-ascii?Q?J7v7ZxzCQw2cVdr3wD0Ip4Dz6VByubwdJikHJrrpH0E0TxTuyPHJCFCZzL4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e31a256-0c87-4032-69fb-08dbf6ffc747
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 08:37:42.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR20MB4582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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

