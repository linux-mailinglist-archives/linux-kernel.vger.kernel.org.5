Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B06804E44
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbjLEJof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjLEJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:44:10 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2032.outbound.protection.outlook.com [40.92.42.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55D4D5E;
        Tue,  5 Dec 2023 01:44:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAU+erkpiBQ5QfQJRSvTrnyP1A5Ky2B8BgnmumtqLU+RpOJo/Om1Q+LRr2lqnqjAUIu5mJRuQO0AeWCwe/A3eZtyfnXDJd47DDHJv1tx7rTBfXGtZVEli21qKDBe/GFBRHLqda9qldVphfdX7m55+wsQy8vmQfEgvLGQukrlh4fQ8zNPlHVlJSPWv+DbMEp+7EotzURIemSkE96567hnn1+rbgaJuJ90BadwHQSg/QzrFP6Vp4REavhtUbx3p5uA3gsYrlWYasZN8wU41dAqYXE4b01yk+bCz31UtS5k2defw8TAm7BxAAlWwAbKdckZHlOzuUMlGI4GQVl2c87qVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRGWdGJrOwy0Kzglr0wJP+3yrtUaNFEVf9rbWcSCYes=;
 b=lqKSEQqCgLn/cEBmFDYfx8je0hon61l2ZwEOkkpTWHRRYHsyDG/XxlUti6wntlS67GcHZgiaDGcLCKFaGMMuP1LgZ/WRT+aDAInN1+yvI//+vvqNaAH5w5pCzb1gFf5GDDO7FuvzpIyBqfPWYp+WnXX16tFOjYaMwipHtqIFvyzWjYhCoY9d3zVJiLDGLsinphE2XASkl0d5sjItBOWvcuzMGcLWewreolBwdNBxxWFFcST6QIX2I7OsXEAN4JAlgFMAps8fc4npluKgKnZQuXvuA4g9niuA/nWDOAwucr7xBKcT7ohbHc8SLNnWhTv0n2RCg6UW8h1QNW9LIeCVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRGWdGJrOwy0Kzglr0wJP+3yrtUaNFEVf9rbWcSCYes=;
 b=FaRHjmbeahPbK/XxeyI/OI9tksiAdeNSOBXRU1vCVkm0U9g+faEYRwVkew+4t5SHlyHzDHFhOzZxMobou4uvYPtd5T5CnzhGTVWZDqOgyR7thLJrBWtb/Gxt4h9CodzK+bhXxztnSMpCRo/OohWBpGL7R4GOBEp676ijGahwPbbyX6n9w5P3C4v4KAe+/7FVKULYE2ViWyChDwdMmEg6jJV1dCxgAGpLrxLMVMeFIG9061mt1qaNxhCrkf3tA+wAKlk/UUHfjzFX2eAe+Bvk9ncXU6viyYKFBgWYGaWewpuC9N8xbvxC7NnELg0oA4ISNkXXiIDGWvRgrA8/0oxPmw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5247.namprd20.prod.outlook.com (2603:10b6:806:25e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:44:03 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Tue, 5 Dec 2023
 09:44:03 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, Inochi Amaoto <inochiama@outlook.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
Date:   Tue,  5 Dec 2023 17:43:39 +0800
Message-ID: <IA1PR20MB495306C6E5A64FAB082F6B94BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB495382B725AFF6FC2C336BA6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495382B725AFF6FC2C336BA6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [jGZx5RFcas5Oa2QNoN90a9y5h+YDb/Gx8dOA/12mKk8=]
X-ClientProxiedBy: BY3PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::24) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231205094341.943713-3-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e84466-1c35-4437-03f5-08dbf576b6c9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjnGycwRqU2OAp6bzlZz6KjQ73OMib9PjkmNOULmGIxuzR0eZEy9n9NeQpf4P47KK7eZAFmpt9om4B8EOuVe1EVH8eBimkKOiFOSWLSGbn+5bJz4EjsY5QZrf35bZw5AF0568J4dS2o6TD2E+OC9TqCjjyzAlrxKfv7S3NRNuuZebkR/v8kAcAM/txLIng2Jpf2NcsycBFb9VNeA0PgiAp/8538koPSDjs5VFNCSg1HDwnHZYmT+Pg5eBtvqF4wp9J2fETm56Afm2AwMW6wwtvbz+WQUrOUznb+tI7EBGGGQ+p0gPlgbhhaV1MQGLYWJNDaWjyXb16f7H8LZ+k+bM74JT1Sm714ME+NSdo2onxURibM1XgV7c4R8CrDj2y8b6+lzLCkZxMAMDswqH5UL1tVoVLmo64n9ln7kXCEw5m9j/faOMCyrL/iNHAUGOdbv3dztGpZX7RN91hgNlBWiD9VNaGsbs4xYdT27MflLr4MJXqC/pIxElVwpl1ld4a0nsJwOVSDxIEOfE6ZQjSU+BFjrJcKJNDtqo//xBYBdCfDGH7bv/EBDvifzp64P2iJA6JDZWk9ka537y0wOr1U1zxWmW9LmlcqEONNdgQLv+0xt+b0XxyMM3CGIcBjlQBRr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/izUtgnWGmKuSeaCiHBnlhDfRQUESL4Gew9pDsmJxuGdBlMj+Z6OKyXfBwaF?=
 =?us-ascii?Q?q0yht9beZAUHgZP/dAYCpfPOuK6js3mbuJ93RRHQRsRX8WMnbF6OOUlmNG37?=
 =?us-ascii?Q?+kzQCtoKL2bcM3NAd56RvZ3Isu0Xcqm5vKLpHdXkowoYAYHjH05Qy7JC2Aw2?=
 =?us-ascii?Q?Vfu1+DgH1UBczNe7xV36XUcYQWH/kATrGZe8WMagJ+iZ6P6UZuPcmdGLAt8Z?=
 =?us-ascii?Q?IwhYOoHJ3foIbp9ZN08r0cU8HZEOqWiI0lTP88S6KG5WeDkAG0gTfnFf04QS?=
 =?us-ascii?Q?uv2Uy8iC/k4hmNnwwSVot3q3aTX14SIbT8Xn7/elxA79HS9dv5ql0mBGpU7A?=
 =?us-ascii?Q?aZysPFLwo/UMgflr9q9DeYZJpO6ECVeWjb8B30QCIfC4V/Vs9FCWowxdL2lw?=
 =?us-ascii?Q?Ath33CmaQ3AGJnVLNg8c9I30rwn1GU/BN/q30TNXxTKKlsZiXJTPlRCVoCZH?=
 =?us-ascii?Q?MCiM048exG7OB1uFXstjmEqbdWS2GJW3TPCaZ7Yi8+SqRNvd404fOdhLQ3/n?=
 =?us-ascii?Q?RbS9T9WiGWEAqaUwzHZVkQnoyS2Ac56m7NTO4ec5fSv49/nVxPXgVCLVHo2X?=
 =?us-ascii?Q?XtgR2Vp7cmBOCEm5EMxKWdVVxY1c64ohr7jMNFsSBt/KqpU+9YaYjDI3FnHZ?=
 =?us-ascii?Q?lfIPrVqKYcqGixUKzvkYpVxbt4+9nkXWEm1zRTWuq4hP9rm7xM55p2ORNLMq?=
 =?us-ascii?Q?jaNH6YTz8Gqp/bmMUnVPMNEmKWf9qMv5rUQx5s4GxLsF44jxMM5+Esy+O6/r?=
 =?us-ascii?Q?ybNsJP/cUihPKeVvinusmoUwW5QLe44JHtlKYSsX5losHrTGiXBe77jZZCR6?=
 =?us-ascii?Q?EFNpqgh7cOWwE6BmZoI323Qx1w2cX7dEosi+1OmkEvd8xxzQeb4MMx5CX844?=
 =?us-ascii?Q?PrpWOxqFHaAztm/S7wDrz7HPt2bYzhRMSbXlyCHk3GETtfnIB1u5++uVicSw?=
 =?us-ascii?Q?m8A4fPhFViZAyWFT6jES3oZX/KCCl4uzwCvvHVSdZXplWSArCg3A5194dLnN?=
 =?us-ascii?Q?x7AKHYfuvmnEQh9U0mRZFwCGkcuEZk9ccua8JWH5dv4LFuFQn9u0UzHOulKy?=
 =?us-ascii?Q?FDIK0VYMjNchPlGqcIO7zOPNFrgyBvgF6bUMoyRP22Rf6y/+6qN0pA2fE/+l?=
 =?us-ascii?Q?u1A51DRm3Ij6M1WKCtgkdAdHohEWAyt7AbqNUaWOp5BG1k3X7FcGsoYhs7Dk?=
 =?us-ascii?Q?2245ZUL3YbI68agPVjlRJTG9LxhQYEs3xPOQ7YzgZJlYVAQdtjCwX0CO5v8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e84466-1c35-4437-03f5-08dbf576b6c9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:44:02.9380
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

