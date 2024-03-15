Return-Path: <linux-kernel+bounces-104169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEB87CA12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E25D1C22575
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91CF17581;
	Fri, 15 Mar 2024 08:40:46 +0000 (UTC)
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021011.outbound.protection.outlook.com [52.101.225.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BD1426B;
	Fri, 15 Mar 2024 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710492046; cv=fail; b=UR3CkkABJiTPdWLtka8kafarYuQmpqvj+JPkGn/moZBGep2vmgXmPjpTCJBBzsK9w5ste17MVhURGMDkDGSqbqy2IWsuTF2H+dEFrY6ZC/5ohY+Tg+DPChapTUDyF3zjGZ02FXEHHGp6hwcCxa2JOXlV8bzsbCJE+65mi6IFQMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710492046; c=relaxed/simple;
	bh=CnKIXqbKzhb2gXcoTg4l9WODKAt6orG0qR6+afKYDKo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DI5Hl+Br5nIH/CGMKUkK4s3Ry1WokK8n3CIFzO/55JV9vSunTtR8e6wcYVgyWtXCAD6O0C0umVWcD+3TKdSqjxhG24pgsQOkcmuEZu5YuM9gjYHVFRDbbiv0wqxyUHOCtpIVE4g456SdNK2l/PkzhQiSqKPLbiY9rksCdxPQvjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3P5UY560uz2BemkQSmkJoee7vwt6mmNn7GoHTudDyvGRjwo5zAM9w6CHnj+ER3b9X/iPE1b4ZznKTpByOcVZQdtrtNFU07K8XdU7y2LYIaHIpNXjxiuXq40bNZIyeFVH9ZUqd4+whWPMJMM8kv+rRewW1gGf4Pgw4Qh04SGdwyyGdP0f8g4oHOOeY5uvmboYQArx5xdL3lD7nSwDE5Y/doIWgkdt8ERzGk2RrTKwZ5mp9HndYs/ywh/3ikCgcVc4K8Jgw2iCjbzdVIvI5UDdwu/6Utq6LtOXnehF0JCwoG8miOskaQWN1bur+3XCk04vD4mPEs+m7BeSELa8HoMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZhf4XDUltdEkVfM+40rDkEtKLi45nQxrOwCpPbOKK4=;
 b=GxjVrwg/NJiokgqPw9S3M5hi1In5E5NmJQac60//k4gEsRGRXg/ZYBsiDPT8JNXruMt8XEBGCnXocRDp4lsvyWdK3ugCDGt6TYsgxSLq05rKgG+Shx3hhHXC+IOsBhqOU/UHy9mCOwXcWGnue7QuM+gGtErTlEHr6EI2KI+NhTVYHHvGF/VbJegjg/R2KMU1Ao2gu3AY4BDKhrx9tPT5C1qMOrvkAF1Zk0R5sXPTL2r1G5DLuwC6m5pd4WFG9QSmHwoXVsFCxJvCPM1RtGPvabiWZvTWR8p3OAAMLs+h4wXuygTZV2Um9nuVABY20NxX7yW434nvBW77SVEyEHSisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1df::8)
 by PN2PR01MB9279.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:113::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 08:40:40 +0000
Received: from PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::ad41:a27c:4185:70f2]) by PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::ad41:a27c:4185:70f2%4]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 08:40:40 +0000
From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: himanshu.bhavani@siliconsignals.io,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Lorenz Brun <lorenz@brun.one>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add &gmac2phy in rk3328-rock64
Date: Fri, 15 Mar 2024 14:10:16 +0530
Message-Id: <20240315084018.2200581-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1df::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB10135:EE_|PN2PR01MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: e73c5066-aa94-40f7-ee12-08dc44cb97f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gYrzx58J23sklLp8bzoGmK/mDTBFYkk05jVSFnvHRPhYZWeOAnLFGlr7f5IfuL/oONBBRDj0S3VIZ62neQWe9QZw+zpKQ+/wA7Em+A/SwUhRP2s5e/7+acUKsCmYLA8yKqIQVt5WQdTon1OAePOcmB6arDoZvLh7cJO8hw9FXmSmr2M5K6JhTdEYfvr2HHvL89rfFPjrx41zmgmsPSiyJvx+O+EJR8z+nTNc59g8oQwdIZW5mHC6mHCMY5O8lcMuFwyWKu/UWoYkZr99UC7ThD17QDLNNs8891MrXGqHl0WaigPcbnA21PxN/K5EVOkQIa1zWMT/OgEPTfwrO6al6KUlHA/Dl/yHmO35I20j0RafInP7wSNrehLsYV91ynXQjisfu18mRmUCqCoLaHw+yNGHIG8yXpg2FXYrnYSt+qmXOIG23QQakA8HBbebxnnxv6DIEt7RdPebj5d3quQvoU2Ghp/5B3BIUsUBjbpDOIP366J3xV+qvywiwnBaBy4UHaT0ndCxLIVssgBr/CqSfsQpeonpQUTrj8EfEfUK68JZfaIZnqSkrELpbzzxknwpD08xeNhU1PXk5uSdmt7PrU5obWEYm9ms1dKLQ+RiYuYaLPBtlaLmyH8wXfnfMC7Pq7GlpLv9xYWjOX80a0wRUVueu4SNcmMGy9A3ku7z5HSJtYPix+lNb1udVOvvGPG1mYMSJLWddwNDGsoQSRCKLFljAiHmRXBNvuid6cK2fh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ITbk3g6p+0V7ixabnkdbcZ7oewIwT78qhARm+E1I6Kj1E7nWHxENxjOAxM+Z?=
 =?us-ascii?Q?K229hCMjmrfNVDAS0Y9eTykL0ua5XijuFl/8HtJYGQAg8K9rRUaHyiK/tJNZ?=
 =?us-ascii?Q?ZfzRL7HURQt+2SJnFbxTArHmhY0JsvvgmwU+2rBdKD1Prr/uQHFgd8m8Paal?=
 =?us-ascii?Q?NNDfrNV+9CDIRq8v53XoyHmyrnMP1it5kuXaNQgPapzH31XPyTLVj+gNmgog?=
 =?us-ascii?Q?1BAEeikYlk3JeJHkn3OE9dsvQMXgEwGlAbzB/z/u+tdNnu3J3pOlEQGNLtuW?=
 =?us-ascii?Q?aBpwpRiuAR9j75NyExYduM42FJwrOt0+Z7FoOH+gPQRRzCidgE81i8OHKJ7O?=
 =?us-ascii?Q?abfHjxPectL/Cx1B0hSQqe7sE7MonzUjwLD9xxwvQt6NL+GZKzGypQUqlJRb?=
 =?us-ascii?Q?R7AKiU6OHrkPgANrLMCTz2pbBIqNh1kz1PHBIESn2NEj765UXa3X9guQRCfB?=
 =?us-ascii?Q?TYXkzO6drjbQl06RaQPeGfxV8iQmLTr6I5iq3zdCUBztYUvHvOUTSJoy0+56?=
 =?us-ascii?Q?Vj4/z0zswYC4JsCtKuqcoG8tBJUr0+PYzdkTRr8ZqLughZ29Zj5n5KFLB7UD?=
 =?us-ascii?Q?sEjgOAaM+qGEUXn7z6kJGcxSeM22o3JPo8BIV+mNDGn4p8MkZZJKKKiRAUyz?=
 =?us-ascii?Q?bD+RN+iMJiz+TrSXl0FEEqWdeZLU0yh0Fe3EHtn7KDz7HnqlUjBAHIyL0Nzf?=
 =?us-ascii?Q?w0vMXG9PSOtFsRFoa0fa225X3wuRQkOlZc6orzXxnZ/TIG1RpsgAV+G3/rhG?=
 =?us-ascii?Q?ZpJEu8z6PGsHiVx+4JbKTthFMKUqXSeZMihEuWtXTgYehNbSLFGcNEP9ryKh?=
 =?us-ascii?Q?Bv3RMBSesbFmH0B5VFv/6ovJmLdC7xE9QuyLUECRWbZFjbZu9+K3yWeNzovA?=
 =?us-ascii?Q?1LRNuVGeUZ0UxahpHULbgOjC1hiDfqQ0bQIQx33kOBBaQ6XlRqUFCiBAmV1N?=
 =?us-ascii?Q?6ojmVonHemu9VANABupd+VsBaKYzEV0Dl3Ly/uwGJgptib+GrOzTsjKzAfSi?=
 =?us-ascii?Q?ZixjVwLLZfJp54zH0Biof8ElWR8WoH6T/9mD+EuVG36P4oluvL1ZEXuZe4+e?=
 =?us-ascii?Q?laEpOZmWCzVt4JOHRVJjOKntirBBGS1M+NRL4k8zRBJeQ6Q9eFbX4rM19XpS?=
 =?us-ascii?Q?eQgTfsXmKiXEugOjHtza1Lm121b6+BOYPScQSTEV3i7X2cYJyyNXVwsLyPjy?=
 =?us-ascii?Q?Z9aD26J1/tR58U3hPlEmfk056oW3dv/DoHPT0TaxWChskey4ROGeDZL3VLeh?=
 =?us-ascii?Q?5RII+wy7TpoanSdvfRgTL/FR79JQHrKm3XE0r8lcNL+sjT/GOm1OVqhNcAq1?=
 =?us-ascii?Q?Yd7tW8YenZU/2lufPemooXJNMEnLCiPlG0AxT9CrQzNaOkQ6LreSSlhNramC?=
 =?us-ascii?Q?RtzoR7RtIqWUIsYvgBABuY6hNAaMqLLpLwj/kv32GI3Sn7d9bTNr71oZ3Aqx?=
 =?us-ascii?Q?EYZSwGWUqeVm+p+QZrEW/8xrCPd2d0pzuD/YFBDy7sBNw+WwhR8/IV3DUkbC?=
 =?us-ascii?Q?rw9FIYIGBYz5yx4+WHE1vPC5NGeWOzDBucWDaxAt75/lV58Wh3QjlcTGr6hj?=
 =?us-ascii?Q?rFmN/F8arNwBvECKHxrbEN2sczKmE1oLPneezjWpEdJsB04TKAryjLklChWQ?=
 =?us-ascii?Q?YaoEJMDoOgo31D5vpUPZRts=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: e73c5066-aa94-40f7-ee12-08dc44cb97f2
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB10135.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 08:40:39.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9nP/ShCC+TCeQXLaJzvQyQxWpgcGjC9JpTlMTaDXQ8uv/A+vtSGqYUEqH72UCKREojjwMxBvXIZVMcsTYMjeBg/tX3v5CetbcJweK/jql/XXnGmRruM5xW/xQgYMusI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9279

Add '&gmac2phy' node to enable ethernet1 on rk3328-rock64

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 229fe9da9c2d..cb919367db54 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -12,6 +12,7 @@ / {
 
 	aliases {
 		ethernet0 = &gmac2io;
+		ethernet1 = &gmac2phy;
 		mmc0 = &sdmmc;
 		mmc1 = &emmc;
 	};
@@ -392,3 +393,7 @@ &vop {
 &vop_mmu {
 	status = "okay";
 };
+
+&gmac2phy {
+	staus = "okay";
+};
-- 
2.25.1


