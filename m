Return-Path: <linux-kernel+bounces-28651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2D83015B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16C51C243B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413D11C86;
	Wed, 17 Jan 2024 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="puUYeqkd"
Received: from outbound-ip8b.ess.barracuda.com (outbound-ip8b.ess.barracuda.com [209.222.82.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218B11184;
	Wed, 17 Jan 2024 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480489; cv=fail; b=qIm606ErbZJm0zLZFwxdIOuSFNrptiZ39vk7aV7NJUD0JR/1vTOjVaPNieSLQS43ZlQGn5lYHoqcZPR4f1RR5nxQ+tJPOnUFdW6fgMXvmcFRE9w6LKhsA4593QHLy+MrUSb/ZivFyVrtHtjE27SWhXigjrLH4FKOPeqyY5cNfl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480489; c=relaxed/simple;
	bh=pXDBHRevEql/IeA5iatwabWIlzO7mvprZrqFBYbdktQ=;
	h=Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
	 X-BESS-ID:X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=emwLXeQCdI6OyxAw03uUX1RowlkJkT8NiOPxoxviwf11aaIvUmYhzWbodW9+bXQOiiJ0iVqii8N0tOjwk+7u9YePOXIejBFFxTi3zjexwivD1fJncRO7ZnWIS9awmVwcPUdn19MTvk8lYTHibNXa09GFhTbAY1bStUz/uqoMtXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=puUYeqkd; arc=fail smtp.client-ip=209.222.82.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101]) by mx-outbound45-159.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Jan 2024 08:34:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADD1ptL5zcrsS9MPXOdJDAdt924y63ro4yJKcAVbJcN7lq5hako53GeUHlTKfPRPR9IU4H8PO3CflFXdzZheo/7N3Ue5rjzOz1zfYoLnFT1jdnl8FYcBEXDPoDT3BPSB8JSMi776knH/PE6PhQEXAwZzbqnOCo6ov9mTl03L3Ibfbfbw3g8OnXRVsXv8YN657eC4hH0CqH6xELHjVDX1X1Q/W6gFlyPAlnwbv69JIk8NzYCYB/+nKjETPxy59B7DBbdD5bsxOIq6DMJ5fGqduQwqNxkJTIyWgLUfeUBpHMCgq9SAdh/ByW2Q+QQvzwT07m9EX52OLOLbJDg8nYaJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U66kNV+nxEwPq6JzmRc7XVuiSHyrKSzuiysTkD3mYJ4=;
 b=LMfHNrBki0IdKVAoe/MFljAoD18mUVrKajUVoyFYWpv9C9X1WzYLSFMXfVsC8q+P2i0a936cF37/a/EX/+eaKYNuJj8gDCq9bcc7KsT/KU4Cl+AzKxx+gl19mYzjafnj5aIjisbgDsYYLE8DTBMTRMEIi4Yvc3+UhfMntdJxllWTOmvXROASRbOqSj1ZlYJu1ojmnhPnXRVOYOoc8LLh4iGpt2SxGo0HQJ/FZMaq4GD6Vx8cQ+Sceql/ar4U4pRlIwmRvj3glOPWhkfqRfa863SCk3nKeNDu1GdOGwkP+LZo/puMX5BobwUbe/SS0BRmIMr3fx5ntaKFG9T0lEjW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U66kNV+nxEwPq6JzmRc7XVuiSHyrKSzuiysTkD3mYJ4=;
 b=puUYeqkd/5tU1XsNwVzlzl0Krf69rCobGtthPFw7z/tyso7nuNju/RLuMv0FKKlU2ViyNa2a9IpNDuYhy+NUW2RF0pUp/PTLwYlOQq0eperU8+ObgNMpQH+iwV/Mjzlm+yh40CSvMMCJe8SeoHu+jD+78tN1yh4fRMN2u04rQdCVveHPfmbsiFiozX2LnoG6W5cCrLWH74Qb7GjfGrh5LzTBvmnyIZNHMRMkE3mZf44RjmM2o9g98JBFlctCFIfx3CtT/b+ODm3ZYP42ttzHb1h9izcaNaC3F+GY3yMMOD8BIdsD/Yl+0uY+fCKq5KJYWyWARitIJAuNltYywihPmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by IA1PR10MB7143.namprd10.prod.outlook.com (2603:10b6:208:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 17 Jan
 2024 08:33:49 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 08:33:49 +0000
From: Hector Palacios <hector.palacios@digi.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	stefan@agner.ch,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hector.palacios@digi.com
Subject: [PATCH v3 3/3] arm64: dts: imx93: specify available 'ngpios' per GPIO port
Date: Wed, 17 Jan 2024 09:32:51 +0100
Message-Id: <20240117083251.53868-4-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117083251.53868-1-hector.palacios@digi.com>
References: <20240117083251.53868-1-hector.palacios@digi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::17) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|IA1PR10MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bf65c5-779b-44e4-92c9-08dc17370712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jnBUGm6z7W32GNtpKnTrkBM5aHY0ySxhakK+mNljOBDuRTjcXSKiirYlT5k1lQnZMZZZ7z5Fks3M9WVsg8QsvRBMZvQET19mq0+SlvjeCMYF7NtfWhNQaPHTsZVjrVdDsU2VdC1gRM5V1hF5Q6aCd2/29gDpAJPr4H2SCc/tFf2UcjOZmnLSDuJ88TwdH0Bioq7wzZTdrbKgNAD6/GIIOwzOysyJJK0l07gZhfJH+lZ+c4JbAyPxG4aQ+tqiRaNpkfKKQDvdKjeeQk8hp4m85WQQ+P1JxLtEErRSQp7OCHI4oX3ggeOPjVc6S1G0jYqp9LNpgex26B6VrWTcr7pU6GDu9q95P2hiOEmUolDVtqm5RRwdmPGyWOFJkNX6378TYw+NZoGuYgKPE5q7YSjEGNEvCruk6bS1nPJLfxBjOAzifuyvO+MDInClHW6HAGZJS3V0EgHYq4ZjfF/292aL/kH8fZ5MXh8bo/VInDwXeRehaFPXz+4dlNXS5kFb7Nu8gAmvuVzXZPv7EGxTm/dV7n8dIe3oclslunu8OT5LjiQNxBDX3UQd0ZVtVHWbH7A++harpCGlrX+tffPhGD/7S/vPmWfUjr4uiiQiXsn/uBG3PXYhHfpcSyy5vZTI2dHr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(136003)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38350700005)(4326008)(66556008)(66946007)(66476007)(5660300002)(7416002)(316002)(86362001)(8936002)(44832011)(8676002)(107886003)(6486002)(36756003)(2906002)(41300700001)(6512007)(38100700002)(83380400001)(2616005)(52116002)(26005)(6666004)(478600001)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLVQDsHsLvyE3nxKWrQK8/eqMU8Hh5LahCARJYxiCvFNRjoXu4rqNgl7DJXU?=
 =?us-ascii?Q?eKNWvNsi+aGaHWYXD4Yqkoeh93A0rvSYvTXNpdKbYDneVkFM4OsS4Jq9w6V2?=
 =?us-ascii?Q?7NnBW7zj/0g+pHIYR7KLGqlceoqUA1C21gx49FXt3Wat20EHJkZWdNWDh6L7?=
 =?us-ascii?Q?FDR22YG81d44eJLLIIfKHsSzX/MODeJ+jz4CpHoerxwgSanUWBrlWVs7LLFU?=
 =?us-ascii?Q?hJLuvOKzBEDzVJ2V2a/MxrbsuzyBSh4axo5H6RIQaJ7dE10mnZTEARkTpdIU?=
 =?us-ascii?Q?lPWFCLB4nNssh9BoV511FvtJ3XZOn/euOajCSv/gj8gdtSVKtS7IjoObZzsp?=
 =?us-ascii?Q?2UHS5XDmfW3svistObk7nXBFmF0uzGyyN7EtGXSXS50HDCmNAOCINrf7dT+y?=
 =?us-ascii?Q?f0ChxMhI1PYaWo04251jYSvdEqhhywl2ToFTMJa4uRDKPOUQUKKjObv0IoLw?=
 =?us-ascii?Q?M+rVEWpRwMtC2pdhkAuEJtNEK2OKYFaBbDpIgyoUN56Jex5YrDdFB8xy+hq3?=
 =?us-ascii?Q?h1KeCJJOv7UuZ9OXlKKo1wHRVJjOV4YarWxX9xdLlTR19xV73NLYbHrTOQxJ?=
 =?us-ascii?Q?IhYXT57yRkqihMS93EV+q8Q7K6Tv9wb+5+HNn0NtxmyJPPkDMDVsEdWnIzjk?=
 =?us-ascii?Q?RfITK7HDtuOJu8htSSvrhbPncDZMnOhd32IGAN77SETBcojba0rpHitHrgkk?=
 =?us-ascii?Q?ALD83mo7tMF71F6IzlPPu1TEN9iCqvVDbHtGAotvOrjSHUA/HS0H1OgBOT8Z?=
 =?us-ascii?Q?TE5t67aLSh3ZgrpyQa2bL92l5zqc3a7Z0vtkckcTe8eXzj8AE0iUNT7Xajw2?=
 =?us-ascii?Q?Dv0A+khsWrvczemV3EPtKMgBqU+yY2c7bUTS0SiIr30trOZwaeOX8IOeNbrp?=
 =?us-ascii?Q?DO+ZG7d3IJpDJlHrV1k53KqnZNoBkM2sF8aTOQDvRTWjjCqZjw8sME7oN0Hm?=
 =?us-ascii?Q?RiBgnmV6zb0c0CdobC6Du8awKW4BQinSh9VFUyiyVQoRBGrAamTk+6yQCeCX?=
 =?us-ascii?Q?LA98YQKbah4olsJ35gAe8nVE0Ts4hdGndXTi7j7Lt8HTFHZgc8Nt9beZSKBF?=
 =?us-ascii?Q?tGwGTDd/MJnVoHveXxfGgm9BrXj9CIzkT3j7SnY+nSpk2zKAVlPPZGdDn9Mi?=
 =?us-ascii?Q?MeDHBZF+Gu/sthlQeGSFN5noe2IiYMKGSPf3L9W8izfLta28hbH4dibPOlTb?=
 =?us-ascii?Q?M38/5MFBsJV7mwDJdfkYm/n9wFfmWfJas1okUToIloiZkurVkGSvZye0AWNk?=
 =?us-ascii?Q?PmCmpFnjOGQPQbENc88vZv4nOIyHOsyaXrnJ1gJYD8tPVU72JlIu2iUMejr8?=
 =?us-ascii?Q?jTWsVlkuuHy8MmF6yIXNDuIoRqEbIul12ALNuXzJf/zpToJRphBN9bdbyOm7?=
 =?us-ascii?Q?k5Xfne+F4Pp/vDCzU1itXjgifVAuFi6H697BAkXprRipyqvoh6IqWDD29WiO?=
 =?us-ascii?Q?LHafwTRG3GL00y+Hske6sm3nFzmly04zy5f+oQJ47wYVD6i+UwNooXEvWKRX?=
 =?us-ascii?Q?3+1gSY5RC0Uo1OJ0dizgVpQwBd/Z9BZtx20g00UhCL6mNN6qXbKbGcoGweGG?=
 =?us-ascii?Q?ZTUP3Od/IFTUO5K+1f/6MXH9Fi4U9EwZgUw572tT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bf65c5-779b-44e4-92c9-08dc17370712
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:33:49.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESl3nrp5gT4/YrQrlvEz0LZX/BmP/N/rO4njiSVnosVBWT0NrXLIdS0YlKWIqTU1egtmjD7RJwWeuoCnld2yOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7143
X-OriginatorOrg: digi.com
X-BESS-ID: 1705480448-111679-12553-156555-2
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.70.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmhsZAVgZQ0NQixdLI1DDR0M
	DS3NTQ0tQkNdk0EQQNE1MNTZItlGpjAVpic8VBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253575 [from 
	cloudscan14-58.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

According to NXP HRM for i.MX93, the following GPIO pins are available:
- GPIO1: 16 pins (0..15)
- GPIO2: 30 pins (0..29)
- GPIO3: 32 pins (0..31)
- GPIO4: 30 pins (0..29)

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 34c0540276d1..7eb2cab7c749 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -970,6 +970,7 @@ gpio2: gpio@43810000 {
 				 <&clk IMX93_CLK_GPIO2_GATE>;
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 4 30>;
+			ngpios = <30>;
 		};
 
 		gpio3: gpio@43820000 {
@@ -986,6 +987,7 @@ gpio3: gpio@43820000 {
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 84 8>, <&iomuxc 8 66 18>,
 				      <&iomuxc 26 34 2>, <&iomuxc 28 0 4>;
+			ngpios = <32>;
 		};
 
 		gpio4: gpio@43830000 {
@@ -1001,6 +1003,7 @@ gpio4: gpio@43830000 {
 				 <&clk IMX93_CLK_GPIO4_GATE>;
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 38 28>, <&iomuxc 28 36 2>;
+			ngpios = <30>;
 		};
 
 		gpio1: gpio@47400000 {
@@ -1016,6 +1019,7 @@ gpio1: gpio@47400000 {
 				 <&clk IMX93_CLK_GPIO1_GATE>;
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 92 16>;
+			ngpios = <16>;
 		};
 
 		ocotp: efuse@47510000 {

