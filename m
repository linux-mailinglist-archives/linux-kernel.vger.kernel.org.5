Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90017A09F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbjINP77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241340AbjINP7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:59:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B7F1BE5;
        Thu, 14 Sep 2023 08:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJnVslQthzMQh85CPt/f5d2MxmoVK/7qhP2R2N/Y60XMI6bseAA/qykwfxdt2r2yKqI+zFcAouLeC8csMTiloah//GGm9fxkLau35gf6SjjAFa8ZgZxjGlg31CBpIZu7uvuBpsyIv2w37hiVcduIUsM+PlATo7GeSWAMNspv6el+lEKTsQELrgVKVkJOM2DhEAa/q+a2OiBRNU7mlsPkDPu1kkO9geYo9j4AqwYbPwOGuf0OduNob1aWmmxoKfSObW3y9O9WG6cYbwNSOrgyptu4b5mozmTeivMEK79uv89L1yASdZo+3mRh03wonGbUeBTWtlgw0pc11hV7Wino6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9cbve8qlac+P0ILRQ5BQp+id45dtyB+w9b1nxh42kM=;
 b=kgq7UHcxtt61dMigswHoS/F3ro/+Tg7RYGjJ+rIpBfH44LQbQHWxM3HdurGZsY6leemiSnldcborSziAyiUeekZuytMa3xmbv42R+sfRx6IW1+Gtp6Aq/mD9FGhQH1f6mLkmVIB5t1FN71MGaBCkIbbOq0J24pUn7jNOz0FLzKr4Z85H1bit0gEwoY8IsuF57EfDqhjYbtNl20IULdKGNxUlm9l6clESOdCdOZzH7djIiH3aMsAg23DximUtwE1zgufM6u/xPM5IgmoM7yLr1uC2+veomLkbpumUoUCcTsEcD4QbWyVsCB8rFuaoeHaa79Ue2/JMtMPIBE/ewew/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9cbve8qlac+P0ILRQ5BQp+id45dtyB+w9b1nxh42kM=;
 b=Tk3DPGK6SAouCj+hzOVC023l9pCNuABspf4mW0D8+fE/kU5B0wtMYPpAcp+UOdASweqOUQC12ynLfMGdDr4ZAtpS8406A8YJtkHsCBN5oYKnZp9QlEeSYm17IarCBeoJV+iMVoS7pXlXE2vJpolj8wnIDb3jds6KNJKMgEpsd1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 15:59:44 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 15:59:44 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2] arm64: dts: ls208xa: use a pseudo-bus to constrain usb dma size
Date:   Thu, 14 Sep 2023 18:59:35 +0300
Message-Id: <20230914155935.6042-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::30) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|PA4PR04MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b3da23-02a9-4453-f281-08dbb53b9d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cs4jDEqFJm7K2C2OgcRz0OYWaaY1nVgwpOGAn2PKFNoH//1eNKKySgvnDUKWIkm3XrsUeoc2CR1gcPpM8yXoVTEW+UqHkxHvXtqeAZZ2zt+IWuOwYEQeAnmyQMbabg/ZqH5l0+bPsLhSmnU2gQP3hI+//zApVWp2/dzweD/V0SGcDC0GtjOvcA1WCSFxQV5Uj9fYt2Pb6edSvlRH6X9xc1Bex26YtkoX8oUwYqvskxcah/kXldVVg+ae3h92o9fMz+GWVPVTX/KzYUfMyimje8JhZfBGPscctlxFmnJg/9PnsL+k04qIJ75Nmv8db+hXz1Wz3F3b4tBaUFEfqJn3KEv2fqqplaD0G9+MR14ZYAXVjPo/V0mX4BI/QV7/iLv7fsWk/0oXZ/viD5axMldUSvYtqCJVCc+0zQA3YOOgRDYYWyQ0N0EoaV9g0R1HacYiS1m9Cidu4ZgF+vJFrUbfd5yukCSdIpAV6WxEaNtJB9Ot0FS6OxAbMw6bxFS5poFsZIfy4fu5jZCbi1zMuygys1CnYYVoTpHQY+qAOPeE6xEiumVR6IHKIXNS/frpGW4uaTkPGPYXt35vwnnf+jgG/zKZ7CO/iPEHeZwnhRSIBEYysdfyE5nC+c9KpW/4I+6I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(186009)(1800799009)(451199024)(86362001)(44832011)(8936002)(8676002)(4326008)(2906002)(5660300002)(52116002)(6506007)(6512007)(6486002)(6666004)(26005)(1076003)(38100700002)(38350700002)(478600001)(2616005)(36756003)(83380400001)(316002)(66476007)(41300700001)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qWvxcsTd97gguW6AGP3PiVqqEpJItT/D15ZfmtUWr5NYkqq2Y+KC/ygQaGsw?=
 =?us-ascii?Q?r8UJhJcB3M3AYiGCGt6iVPpKI1Udb/YhGHMfnll9o4Uv8l65WyTjY2b1PksH?=
 =?us-ascii?Q?qKx15W9pykXamqXiK39MtEydPdxpusOqWQ93e28tKRPSxUxhGlh32ksKMsSl?=
 =?us-ascii?Q?KR2VJiEcZ0hRuwDp3yuDKd6RDHGYOJHpSmL5z7FfS0iAtiF3k2tyy0ttxWB9?=
 =?us-ascii?Q?c/J13eLwTXVm+iydS4r5Pgt5JAG2f2khxUO8BQlnf+q39AHrdGkCKrxd+C9L?=
 =?us-ascii?Q?tbSFQVe8jaKtQ01qh4A7ks2IqhbgAk3durF/PYK+BzXbtqWbgnPoGUWTSw7u?=
 =?us-ascii?Q?YNjnIa0peAunfXFv8+0L4VmeOIdrJOuqpE9LUu/IYf8VLdurkEuxfKM8o9MV?=
 =?us-ascii?Q?/rHK0BWreVP83Sf8f/41EG/OfSIvPIdlZAnS+PhTHeY61sLLFKVOrrSUF0ye?=
 =?us-ascii?Q?wRE9/eVULy0WVPmpHOj8jOxuLAFFqR9VoLAJkDr+iULx0ujfARQmVs3x4ssR?=
 =?us-ascii?Q?kj5GRTqgXDsPncAhUATaaN7en+5oC+OGS7CaqgPirMkCAic2i58dfCOf7azd?=
 =?us-ascii?Q?sv5lTLR5vJIVQMEngoKWuYBTUraD5sya7FrvRuQMnCYg9YTIS6XxeqmgaLm9?=
 =?us-ascii?Q?KDlcmtJRNuPWhX9VPXzMGbTekvigZRsUp8CCZJWD7yfRXnd1+TnHd4Crrvwo?=
 =?us-ascii?Q?H5DrM7bb0okNYlEj7tlkjm6WINpB3UPgHZ5TYOA6nnHL2OCFPnwZ2lUEPlPi?=
 =?us-ascii?Q?e3cZmISbgUEC5g4Izc8PUhKk/JjtKhTY/IZNuTaaWVjCkfncDZHphiuBO2g+?=
 =?us-ascii?Q?LZ4ZcCZ42F02TTWEANNPLd+rvhJDRwzpUbkJihIQMXtBvFatb/HYtBsCaQ1e?=
 =?us-ascii?Q?h1CrXH9NiAyBSyCwGTkwpWf6fv1NnPbYvS+Y/B4EZZ/Yh+Pi0A0UjeDOj4Gb?=
 =?us-ascii?Q?rfa7ovti+WW1JbInKRVqqZilwCaS2WTXbT6lV787zE0o+ZlV3Npzmr9VuKFw?=
 =?us-ascii?Q?YaZcWHGUNiEskPuIX79N28MHVfut0ihbWQoOl856th7Ig6locQeXTz6uNodq?=
 =?us-ascii?Q?FvhoYlASF6HTsqjUxznGXN6Yk5ug+pgBA47cGoI8KfcRDnYxq2hSZsqYAhhj?=
 =?us-ascii?Q?vxoMzpfy4rkgFS6F0N3+BQ8wKo3UQ1rgd+0kbI3f1hgNiLSdcWszxejL7QUM?=
 =?us-ascii?Q?utOTPxLLjbl8WxB1+glSREj8N1yh1qRhRfcDrp6nJPDLhxldFdM8653ESroG?=
 =?us-ascii?Q?kv9HwaICHuyU6QaL7mBfOI3YEei0sFc7HgiTufVKDq1dDkkHGPlfrFG6HhpT?=
 =?us-ascii?Q?71ep+87y7OQ4fsxAL/v4JwRK/NaQg8F1uG22/fsStlu/SnwA2iJggWyba1aP?=
 =?us-ascii?Q?mntKFSLdqgF8mUimXYb9ov4YlMPPRrpK65b3tJsPUayLeKwlnaXo+2ENm3Hf?=
 =?us-ascii?Q?5fzqXrR2q8+RUPxAv7pjRKZA17QEfnvtrXT8MkPidPBM2pd+ICcF+B4QaT66?=
 =?us-ascii?Q?FQUAtDMon1Tp+4NxXHQzLDPmgU2lXirL+jQgpAf9NwqLLsVOeXNTIA9hHX0W?=
 =?us-ascii?Q?FtIB7M8BpWg4bBj6WuQsALCDOTRsqB8bNRtLesmT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b3da23-02a9-4453-f281-08dbb53b9d1a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:59:44.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QL+uyTWzWwQDiD+wpcLiAMcMmTb/XOWJiaPdkGjqsIMMeiHD3lZXLeqp+zlwtnunWeUWOlvubw6g0qTG2TLiSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the usb controllers in an intermediate simple-bus and use it to
constrain the dma address size of these usb controllers to the 40b
that they generate toward the interconnect. This is required because
the SoC uses 48b address sizes and this mismatch would lead to smmu
context faults [1] because the usb generates 40b addresses while the
smmu page tables are populated with 48b wide addresses.

[1]
xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
xhci-hcd xhci-hcd.0.auto: hcc params 0x0220f66d hci version 0x100 quirks 0x0000000002000010
xhci-hcd xhci-hcd.0.auto: irq 108, io mem 0x03100000
xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
arm-smmu 5000000.iommu: Unhandled context fault: fsr=0x402, iova=0xffffffb000, fsynr=0x0, cbfrsynra=0xc01, cb=3

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes in v2:
 - renamed pseudo-bus from 'aux_bus' to just 'bus'

 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 46 +++++++++++--------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d2f5345d0560..6c311c61c5bc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1186,26 +1186,34 @@
 			dma-coherent;
 		};
 
-		usb0: usb@3100000 {
-			status = "disabled";
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3100000 0x0 0x10000>;
-			interrupts = <0 80 0x4>; /* Level high type */
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-		};
+		bus: bus {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			compatible = "simple-bus";
+			ranges;
+			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
+
+			usb0: usb@3100000 {
+				status = "disabled";
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3100000 0x0 0x10000>;
+				interrupts = <0 80 0x4>; /* Level high type */
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			};
 
-		usb1: usb@3110000 {
-			status = "disabled";
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3110000 0x0 0x10000>;
-			interrupts = <0 81 0x4>; /* Level high type */
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			usb1: usb@3110000 {
+				status = "disabled";
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3110000 0x0 0x10000>;
+				interrupts = <0 81 0x4>; /* Level high type */
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			};
 		};
 
 		ccn@4000000 {
-- 
2.17.1

