Return-Path: <linux-kernel+bounces-11783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A609A81EBA4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2BC28208C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767B3C2C;
	Wed, 27 Dec 2023 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="k2rSFnLW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2083.outbound.protection.outlook.com [40.92.19.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DEB2563;
	Wed, 27 Dec 2023 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ntt8+tyUyhekCNODB44hyJYXcI0QiBvRwHk9bdfySjJTgr6hVurnzIuOEJ4+z82Y1vWGW03UsZ5pegrKOIB5Z7T0lFgMSkNCs7yuyDu6Vl9hGLLxwJUzAVzxvy4jVWs7Ns76TXtLa1H9/eMNTjFvgaxdDDVhQdqZRxZqJmpTAgRxzP8HrIJ3z7nxWS+jqBeA9ai6wF/Fd4FZgi+WpR2OU3RP+SNXhfKM4k6vLinZ4AX8ZaS+ID12MbO8QQO/kF5eF990fZ8/ZvtzxkrunSieOpn/MSNlF9obkzGElKnQSu/MSXt1tVux3PKZUEzivpg4l2Kac1Uk4NNJtHSB4S6kHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50hvAZdcs2ODPgRiFq0wkhBT0l2oSjrihHYYJ76TFPo=;
 b=h+qzs31NmTZ/untoWE+PGdLjMHnat11m39v8a146EH49KFtdWQt9OB0F2/auuynegNtVXSo66I4j6R+R00V0sGsQZq1gZE7mrtsoGjdNW3GzGJ86PesJeNYId+AJqJYK/mB1WHuevMJPJcJVdgbHJprkEecDLBByqBWeDRt/cDtv8AzjfqGfhQ0W4h6LZsVOl1NTZXrMkmBPGEhUxqz+S+p9sT75dQt7yx5xYoUT+Tq3WniqInHE9+FlEpe17ILRPcZCZJ9YoFhkmFH9FLjkNiABrImc8o+h4HX8KqpY/0CVWkTzfYLKmu/ggXVusy8WX/c+EohrcAIiqBcjZK+rpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50hvAZdcs2ODPgRiFq0wkhBT0l2oSjrihHYYJ76TFPo=;
 b=k2rSFnLWdzrn957NrXrrYBpGn65H3Y5vgU3RjUiVuEyoAek3Mgka0ZImnXmMdj4PSXimYu/O3IBDarddcIGZsQGV/5dxixOwPGs5Nj85SbFQPe1aZAa+0LGDQjBXN8fzqFRNxv0fQzssoyQC3kAEzLeiiPCiBUYfXsJuXpgt3iciUjSMKDTCoveg+mlov8En5TbJRiaVH9U4wJQ9ofEDf3IlBCvXrHpqW4eAEHRo3AVxWyYTQaqeas97+GN8DmfFQynfDiTNVIR/zSDrRzK2G+UOF/FA+AbuxGCDs7cZb6D04Cz/5q9DYPOP4olSqFYm3ilPHNGg3Gf1zdHBU9URLQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB3754.namprd20.prod.outlook.com (2603:10b6:610:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 02:54:30 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7113.026; Wed, 27 Dec 2023
 02:54:29 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
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
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 2/3] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
Date: Wed, 27 Dec 2023 10:54:19 +0800
Message-ID:
 <IA1PR20MB4953D80681BDFCFD910C56C6BB9FA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [X9pBE5BPwwZwOOmF9XwAvdJQEmS3fC1N8ExFnmUvE60=]
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20231227025420.296265-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB3754:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f38bca-e25c-41cc-4520-08dc0687255a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/STSIgfUjEVWgG4X9/bVX2o8pQZPBY5GNhUrilIa/E5yLmCOIMQw4/nEF7g8hi6tvTN5f7mKZbDIeJS8mRfaMeordrjFzWsSKJgy+vawiPYnvKCqX0btH3c0YIxr/NLHD3gvgKFEJd1l2Po1f3dlV1kCXrKTEjq16brJW4ZbtNgNoGyjWXiIDyTqtFujMUWo9CmGH+k+DxmxPXCHOMd3VLjNpOkyAylu6Iaqtd1KQUPFD+B7dkfkmPv5NVa9bgHVrrNb0JhrxE5r/+GEWfMWuwgaS2uPWlJ8kct4r2cAhsElwpjMRWLVLDnPs4qjmWNcyie9Cxbr8wG7JoMvqeDE9cfNxe7DIxVBCReDR77Cnds90cT3laNyV7sByK/RgV1iT8bXs3Ud/MFZDeOqxmbE1tBnNA5sxW2byJxaJ5pqKnRObWqrzUh1wSCd++5O/NGH0r36czo4ggN7H1NEs64YonKY8m2EaqwFq8DTEw7BPEBNXmjKtjDQtI4mAirfyH7JseHE5xd072XXPvWYIiJnDVdVusCekdhxaVvCx2opcsaOPVgTaCfiqbIJ8FHqRtQaL3ma8ynZCF6mOl/+xdIs/KfHMYaO6WAq1w+uNE456vGzrctsMHOzau3DF0Fp6GbksKPZp0Teg6+rbiLv1AIsZ21N71I5GTiQ54nroAzJAg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pY/rSgrJfn16itwtfxnG6/862AY5SJWl2XWvE+XMGGMO0oy+EyHi4RTxwy2H?=
 =?us-ascii?Q?Ye2xgz0tPKni+tbifH8gR+x9oVClAj1q1Yr6D2f3GQU/c7WvSPiG7n3Pl8Uh?=
 =?us-ascii?Q?l6LLz94bUiQwQb9BWEhG31gJ8Vg2MuQFZ4owe0Wpr5CEcALbhdjiCd7MWKsb?=
 =?us-ascii?Q?8GbQ/V2GHZwBjhy09zGA5+LRTnACY9vKYj7uRTelcCjkl1mNE0+rnms6Uivh?=
 =?us-ascii?Q?9bOrihLC6PwTgsBGfUdWfXb/q352U2iYmSiUWFS+jaPblkbQm7EzsS4noDLv?=
 =?us-ascii?Q?4rCFbdtp7/Qa4yNd4fzIH7Sf0Go5rr1vNL49SCsqlh5wPc3t4JpAFYqF3hsM?=
 =?us-ascii?Q?GP95sEW42lT9QwZI7R/2lzqTQazpKNIMLq8LcGm9bhEbC8hT9fxHUIytAk+h?=
 =?us-ascii?Q?W/e7KMX7nWCcn+aB3BQzAaOqrdp13pz+QrKuLz/Akz+AoVcctA/FVkG9ACQY?=
 =?us-ascii?Q?D++61qlyobVolDv9VS406ee/TJ9bhiW/iCqmK7vhEY3i3kn0GGA0uULjdEi1?=
 =?us-ascii?Q?Wzw3LpOTh20qDB4e854gSJQmLcV3rzQCApMsudvLnSfVFVCvT3TIxX4gDtHT?=
 =?us-ascii?Q?E/1rjuLqegY58+JXpe12nmjiQyw3tFm8skTRm17AJ3WDrrVsPn+/mD7EIiV3?=
 =?us-ascii?Q?My+giWvyHgPLtzAgYKglFYr8gKPyK/qRCksE17u5JXZ4W5El5W1DFJLT/Ajo?=
 =?us-ascii?Q?GV9VVgIzF9Dxrp5Js0q/rs1/NDbkMvnV7kAe3FhS7nPG0iXdyhKy2WPtp1uU?=
 =?us-ascii?Q?tJAvMDBoac5MteN9ACx0r+hWbkekNoFfuQlkidcSow/pSD5IlNVo0cm7cEC+?=
 =?us-ascii?Q?yAHog7IVdPi3Mg1SdtOb/u+bFb0Y/AcsgDruun8/GXU2Ck43gOo2CWlFDHzt?=
 =?us-ascii?Q?YcBCNUG7qWx2m/aHWyISiFvj8gdzaE4uKXIVBCJ3uvdaXD7Pu2Rp6TVNjtl3?=
 =?us-ascii?Q?qt/7coZEc82W5zVJE9oZhHoZU1TPOZB995+tXyX+BVUls5Tgni0FDwa3WIeY?=
 =?us-ascii?Q?SlDK8QCmY1P3O05vciW3cbOnoqnj+jXeYGprxulXb76jysUm8YPPGeHZzswH?=
 =?us-ascii?Q?RQYr3OV43pkbZ/rU6/cGspC3LOPt2ij1O527yOzCZbV1sl0PEHvZr7bseuBd?=
 =?us-ascii?Q?u97urSH6cBtH7nMW7wXSFR1AsvtRzU7Kvzl6MZA5ST3ZIPetlkKn8bv3cc5Q?=
 =?us-ascii?Q?qkl3jOnbe+zPjzauY8FiqVYodSy/b/lIXYa34CrHTljikFQxxsSSrHk0YZo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f38bca-e25c-41cc-4520-08dc0687255a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 02:54:29.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3754

Add clock generator node for CV1800B and CV1812H.

Until now, It uses DT override to minimize duplication. This may
change in the future. See the last link for the discussion on
maintaining DT of CV1800 series.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
Link: https://lore.kernel.org/all/IA1PR20MB495373158F3B690EF3BF2901BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com/
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


