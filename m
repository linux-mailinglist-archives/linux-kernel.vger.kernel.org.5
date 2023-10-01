Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6297B46E8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjJAKe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjJAKeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:34:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFCADA;
        Sun,  1 Oct 2023 03:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+r+4qeAdur1DG3WrsZmt+9Um2nVAaFx7T4yYs1E1WZqcfQPwypNeF4ydPSbCDB1doDSxJmk0TBQDkl06dDua2lfhhXbfC/8EQTeaAdmjxqSgSKjEI2VxRbBbeieoNA47JWq57FW7pB1InwWIi96PHrS5kx7hp/4mbFIxy7s2Tk8H3YlKWmUJSK448dwqNb/DF9Q9TiVEuoKgSdND6lPW5udEtNIrePfi/FjQ25la9jw27Xn8jv3GNZzhsNxKBfhJkpiG+eRLmgeCQMd4WAcuvly/DLu+tZpmnosiPHqBloMbvV7W/s+KQlEwa6QNrRK7m8zVhBQEATIJWmNi8z1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GmMsdzUstslTgZukiVVEKvG8ODIonypsUKhOtnwYEU=;
 b=D5/1dE97nngzbpf+VtlVv5kSznMhYVaZyz3WH/6WZI1zPGnEBBeou1/Hvq/4EIgVQtytvQjF5SHWrnWOkry7gr50J8hyYt/FXZFzlQnCBmGajKS62HVnylQWaPrKHZKas6xfa8NTdL/+71IjOATlL2cNspF3nV55TEBevEeJTsDhMARJhRMA6SaChgIw8AVqFVUYh2BoEyhn3ctTws6wCYbfrFPtLU0oHB0lJZwEWkTJrn7rZmFCzCiPxTwCPP9LKdDG7V+pRAaNStLSW817o8cKb4b5P2N4PApxTJ7GIf5T/nVpv5VQfFy4pKL6ANbXD5KQhZg6PrNmL8ORYzBVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GmMsdzUstslTgZukiVVEKvG8ODIonypsUKhOtnwYEU=;
 b=k4aSXOd7TvX6txT6geEzvz0GevXz9VTUIS52CFOCNZsaqhM58p4BDvlj6bTCifr/vJo3QqcvsPXD38suEPhSacVlGoAMtWaS173cA5fyb8PwtR0SIlwG+YIfb9v3f01u6MV9C7r6+sq9Be/q3bsAxIQLHYTf6wpLu4wLtACDeIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB7584.eurprd04.prod.outlook.com (2603:10a6:102:ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 10:34:19 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a%7]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 10:34:18 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [v6 1/4] arm64: dts: lx2160a: describe the SerDes block #2
Date:   Sun,  1 Oct 2023 12:32:56 +0200
Message-Id: <20231001103259.11762-2-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231001103259.11762-1-josua@solid-run.com>
References: <20231001103259.11762-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PA4PR04MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf8004d-7c33-4f4a-ce92-08dbc269f799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFV9OWdID2Z4mh/8LVW5xeQpNI1HZAIPmOXv3FHpH1GBXsAcfn0sgNCQx/GyH4bpMncJNU6c0oYRHKLjJLWkpjmfcnY4dua8Ou7s7r/K+4aa/c+AKpXzPX08F99Co1jxq8XcOcDBSsUnbiAFlNkjiGstOGgIikTdCA8xEvAvWLBZg2zH/grIT5JYpKTPylpDQAOCxhsmu027bnAl5tl4Syda72hn3IXWErdllV23W+NvUTzwy3ApKEE1J+EDAmuMppQTXO6l/qJRVwd1yZhmyr2QWQqncWU6cxozcI26dO4y30R8txbHtV/tYuQsNJFzZhNVi+YBGhO43qmuRxkMbj0crlwbDl/42Xf+W73DEtY9XKjz5J/l0eD9RsRtZ21jXsWQaoRMeZ7LijmExkPa4qjdSpv95a2Ynw1VdK63Gu1mT1zPdGM4lmeZ4bWGFYEHvgcONDsFbkzTxxdt5bTFbERl3drs8oF0iydh9Xcd8CIkd99psVsfTII31v+EolL/HSvIhCpd2pO5mF1WpEKyj6/kMGgllxmTlSb5o2HMexRtIX3PZ1SzhbNJOqZXSg+Gv0lU5pR67Z6cKGUr+6p0wib1OmKyxrxPni4f7w8tsD+vGjTexoVXLVLQF2FzyqMS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(52116002)(6506007)(26005)(5660300002)(8936002)(54906003)(2906002)(8676002)(4326008)(316002)(36756003)(86362001)(1076003)(83380400001)(6512007)(6486002)(2616005)(66946007)(66556008)(478600001)(38350700002)(38100700002)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rMr2AU+vkfF0Lc+sRvNF932sN8j/XLjoUHJqcr1w66wNyTAwKcUTkL7HdGVe?=
 =?us-ascii?Q?NIhEOwUFBjHvO7/tspbwvCSCfhl9HPatmb9YhHqW40gJVYBXouOyFwJWQ8Me?=
 =?us-ascii?Q?KqmEbiT4fKPvvEmhZCuq10OKj5NovA1Fd6jLD4mJmytb8aBdR1Cpzfj6zFQW?=
 =?us-ascii?Q?iFdZR7JcINylgKNFbf+Y0klY25KaP9APaWfGsO8o+FFAQK3W0l+4BQz5M+qf?=
 =?us-ascii?Q?N8hN6gMDjYd74WIwdgOlQ/c8h1b61v6Y3QGQhVY2cbpRnWWKB+9VyV9fGXvl?=
 =?us-ascii?Q?dtZX/3sJtyA826ozba4zRp+0atk8ryIpwxiXInV4DakiItB0EknCIhCpN6Ys?=
 =?us-ascii?Q?ikKzPaxkbJ5GqxPc8/n1Mixd1z/UROvrkPgcS1xLQDcCVv0LPjByBXCGmD2O?=
 =?us-ascii?Q?7Fe5TWKDs+vJeMTDToUsXvRBlI4UfGfV9EPbv0vFyv9SXHSF3xz4j3TrA7eX?=
 =?us-ascii?Q?AAazzJJZYHVsBWkLcBeK43fgl6lOc4MgoimV5dWQ+TRPf/prgzypn+qn8LtD?=
 =?us-ascii?Q?IS5Z1I9014sdhOepwaW8D2yvtm2RhSpMn/t3aplgTcngVAf2xn7UdaCwpnOQ?=
 =?us-ascii?Q?V42sV/cYDwbU+j9tqM4XKLspEc0oefVQ8Hnj1CJqvcv7pR2IQeDCuT7PkjpG?=
 =?us-ascii?Q?74EWNjSWHGqPTyeM60X/Y6zZt0NIHNjS9PBZQkez6DGzDbmiiRBN4OXj0idL?=
 =?us-ascii?Q?EHW8uc9ru/M5o9x95h/2e5B50ZXvFjmiJxoKQnKtwbEOB+Pe/OY/rGgCe26L?=
 =?us-ascii?Q?cyCZWTMrMs4T5SesrY9DKC/VHPf3qzQ9HeczTgHab/5oRooJmBmCsi+Kh3lK?=
 =?us-ascii?Q?3oZ4tSjzMimmStUJH/EiS9+FompbkTpY56bVRytZTMRDFdvbKdqNYji857Gk?=
 =?us-ascii?Q?Sade2JT+1zDnhV8r9zrw2cPrXlhSiQVZATIYs08KBUQ7TOW+/diGwV5QYlDg?=
 =?us-ascii?Q?pIo9wbJ9+jwUytCfMxhIHf/qHNn6/iP8WHIUGHqhNOl+kf2W8Ajd7ZUkgIhQ?=
 =?us-ascii?Q?fJ0PYk2h+aVj157SqBbCYdQzzoNSl9/L3B+uy1I27ju0ArWpkdZwVAkKlWkP?=
 =?us-ascii?Q?znvX6nPu9VkEsqvvM3HVx3mkVzVMIcaN2F2laS8lV+ljmgOt3NR2oUGmGHgl?=
 =?us-ascii?Q?zYUCMxKez7q3VhfRbK302pKmhWcCCPBkKmvEoJdmlPeJxhrrf64Z7rxpS1A6?=
 =?us-ascii?Q?2ydUHKQNs0RwkxclAm9YVKh/nhaEBRDxmWxlXij5aZqqmD3R1vO/albP2cZs?=
 =?us-ascii?Q?Mt5uMxG1uJtuosr5XzX/FYwt55xT8yT1+QViBbz6jD3Ja7t8yUGE3OZZP3si?=
 =?us-ascii?Q?eKU+d+mKPtlgl95ETc21Fx2K3/uxzZxl8yli//fnDuqgPcIHTWGOrtsDv670?=
 =?us-ascii?Q?XOvrWSLBix8OLl1o1o3HblEv/d0veOS8iDskmHpHFXS/iXRxoqTgpCv3oviu?=
 =?us-ascii?Q?WQZROHw+UfRfCrSOvxpw6qOdVzEl5er6VyoGe2smzPbf/I1AIAnZyVZmd+ic?=
 =?us-ascii?Q?3dxPUM/5TdOtq8+ohkJWSaG2b0QzCXAugrDu7OXyFIhdf/Ql1lxjW4V4ijwk?=
 =?us-ascii?Q?xtau/aquqGxrPHJEVjD3slF8W/E8qiO/IImvaFOt?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf8004d-7c33-4f4a-ce92-08dbc269f799
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:34:18.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO7x8n5UIjI8pAq+O0DxookzlAHUA6lK3sfWYzS3c7ehpU0JQJXhKRy+lGpnhHR16C9FqQPY9V55Z0KsG46QGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7584
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for the LX2160A second SerDes block.
It is functionally identical to the first one already added in
commit 3cbe93a1f540 ("arch: arm64: dts: lx2160a: describe the SerDes
block #1").

The SerDes driver currently updates the registers of all 8 lanes by
default during probe. Because currently this driver only supports
configuration of network protocols, this can lead to problems with
certain configurations.
Set status property to "disabled" by default so that existing boards are
not impacted.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
V4 -> V5: expand commit hash reference in commit message
V5 -> V6: status disabled by default

 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index ea6a94b57aeb..f176ca2e244e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -626,6 +626,13 @@ serdes_1: phy@1ea0000 {
 			#phy-cells = <1>;
 		};
 
+		serdes_2: phy@1eb0000 {
+			compatible = "fsl,lynx-28g";
+			reg = <0x0 0x1eb0000 0x0 0x1e30>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
 		crypto: crypto@8000000 {
 			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
 			fsl,sec-era = <10>;
-- 
2.35.3

