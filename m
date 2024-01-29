Return-Path: <linux-kernel+bounces-42316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAAE83FF87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140DF282447
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5951C34;
	Mon, 29 Jan 2024 08:00:20 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2072.outbound.protection.partner.outlook.cn [139.219.17.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2151C30
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515220; cv=fail; b=NtBjqzFTYIHyqAdicb/jEY4Ujonl34s50jgpySGu5TayS2Vyk4HQ6jz61burBI3SMhnWAt17DPWYQhsCMI6+C2zvVFh1WrAyErl1SI1WSy3FuSgoT1dHxgUIyBornp0deb0kyUV8JefFjMGDPtlrTrg5BJ/gPjEA34LFC/UzAxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515220; c=relaxed/simple;
	bh=G+QgHjLfHcgxovujMrep8fNReVGWpGA/U9HgEWVWJRM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MbEqeUlVI+YaPO2UxPMpfy7qoXYBIlU6azmgduEQUEpYjL/wXrkHANF5HZCqZKMpPJDwlyKofWaHHQTsOeBvTBquQiugUDJ5toVGOnMN44l0V3TKzEX+3M3zDtdjQDP8GxAa9BhVOu0U0fgLLraTT8953mXIRo0juwGfvU+YnG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtydzpydC67w2+2b5kxo5cI85x8GABKqG00pUkg3upyTjEoXqwrtFOul4mcF4CqcTphv16qbi6wGWwigc+ELsRGbeX4FY8UztaubQuQRJ3RSqan6DCniawal6EPeKF2s9gH93D1CMrHYqy4Ok56ga4jDP8wqwfb43fspjozJsfhvrDyTqG0jQlzgTUJDXwXibp5Qoq24lP7qGNISjFwwK3yEZzjHI+e7JoTqQFpztsvYSLt71779qSoZKAzPABUuk3+SCdhqDoV+2LJAZEYK6D3Mva7JE9pIRGHTTgXxouMqk4P669X5UfcygMf+zwmGU7LETFUBGj/2a1zKzt72ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5Kysgtyxp4+qbmp7//2aa4z76FOF5vjIwdzS1aoCd0=;
 b=EM4kZGRtXliYp0mk/i6wBUaBzECT1Ad4946jTIQJdJc6iwcGwwMFEbbjYsby9LsQBrBNz0fmE2ruVKKEBe6ci29HZGEgaAQYvx/RCUujcElv7Ezttc/pS1MEnIzNs9mUsFECoOMsIEVd1GJpcmp/Gife09KvIMS21wTmcBdfMuWvOrTNdacei4rTfX3HtqmM7IFcx7Nr9tu/FS9Wqk8BMdypzhBEDAo0XsKg8vgh3vbrbxUVaoLRJEOfinSkxg53V1LUACbikAXQCXo0CKdOh/H4BOIwVMWuyvUXDkiYetBE5MQZ3dztiNfJaGh/RCbvL6DiUON/aMXKoBXMOmW9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0545.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Mon, 29 Jan
 2024 08:00:11 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 08:00:11 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	sudeep.holla@arm.com,
	jeeheng.sia@starfivetech.com,
	robh@kernel.org,
	conor.dooley@microchip.com,
	suagrfillet@gmail.com
Subject: [RFC v1 0/2] riscv: Cache Population Code Refactoring for ACPI and DT Support
Date: Sun, 28 Jan 2024 23:59:55 -0800
Message-Id: <20240129075957.116033-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0545:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1cc644-a72c-4827-0668-08dc20a05176
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A5aCdvHbj2WkGva4BV1eDzuD3IoFxUCY1IQPBUwBt3yT/O4rycaKy+wEaMpCmMSzws+PUMBv2dfZ9ZayxFPR8HyG38MUed1zwbYA3LqGltWhndrfS/3HNBt9cm0oWvyzm6KgBAwHDWpcYddspaotRU6W/QMANEoI7T+Q/gvuBxki8V5H5C5zm4CRKP+2EpUOwOC2o53YBYXVi8YDOpSShmhJnYhMdBSL9ryLGvf7MzcfgroTnud6uzJd8b24zUMNeDenojE53uKsI8J+OC1ITeWaZ2qUhmydOH2sqGBFZO2/+elXAiQwlgwK4avbionD75tP1Udg94YOywKO/M8dzbYolSrQOP4Km56TJO9BmpV94Xl3oFeTcXRHfiBoLgkLiq3h7XT6P44Wolt0Gfwvm5Qu9zFE5z9m6e5pIPxJ0gqyZZRj80Q2r/tAcOqHqJBfkqz+GlEu0Ba0djRwYWDYSIqGo1YowZzP/EMMY7YEDvSC64oqWPjXcvRmhrf5YjLfYC/aYwwscaqmrNUVnRA9dXRrbe+9xxoylv8D7D1hdqstBjSX2GNu4VcyeXL2mwp+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39830400003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38350700005)(41320700001)(2616005)(2906002)(4744005)(52116002)(5660300002)(6666004)(66946007)(66556008)(4326008)(26005)(1076003)(66476007)(8676002)(8936002)(38100700002)(83380400001)(508600001)(41300700001)(40180700001)(86362001)(40160700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PiZSZej23dVmjBGISYYlusxZexu13GIHXiMzT2rqDR1kcFBFGZ0S0Xh+tbYH?=
 =?us-ascii?Q?VXOtXBZfVx5t6OsErOaiwLkQGuILWIVzk87XNeInoJV+tkGV/4p3tNsY5dSm?=
 =?us-ascii?Q?5J0jI3/AedAUPuKzN5Gzfx1eJhBlIppm1Z7ju1rEsrFncN1pUmHBDGADaBWN?=
 =?us-ascii?Q?iG6d+XKPcmpKlpVNkey/rPxPOqeFc38FqCKqpNXWu+pGChMz5s73523SVajH?=
 =?us-ascii?Q?F1OSV1lfzyq6bQmfTcEcLeIgjI/BjkU6xHy1cfsI61obCuNq6JEPnT4euc9g?=
 =?us-ascii?Q?PRHil9aPNKdH4iuhgcvlxI3Xas2HAPdVAacU+bFFD+oWRz3yeymqb5TLKpi5?=
 =?us-ascii?Q?p0f1wbSFygL01hjtvyrTSvZUi1Ck/h5dU212OMVKxU9knp27hmIF8zVdJRiD?=
 =?us-ascii?Q?urgOddYCYNg7xmCP/svBHJpHk47EzVCPXiUE+4iyUPfwWGPvNYDLmAtvgFXQ?=
 =?us-ascii?Q?6ZxTfHxKOiTpIgyT5c/InX/oatgLYPPmfrEkdAn3LNKPbW9h5UCNV/S/Dr0+?=
 =?us-ascii?Q?KI0/Bz28jlmXTv8KsMt3CxthIv2fq/Apv2OPoVRlO3Ngaxm8fE8/YxQhWs7k?=
 =?us-ascii?Q?idnZRINm7IC3sVmdYIm1f47XgsS4WOHhD1phEXS7FJIqloGe+SJdA1O/l7KM?=
 =?us-ascii?Q?J08YplSNgSKaYgA1mNuGrEBF1HlbNVQwl6MSMGWnVO8TiLP5TeeatUvejozu?=
 =?us-ascii?Q?K8VyX1MyPiJOhBJr6yRkVknwk4nI9pVv4Tr1mkkCZbrl+jMCG4lKQ4/uSL/H?=
 =?us-ascii?Q?vjtDVeWf7rLPsmGWkUhiYwBibCXc0rn6CAutU6tC/9LIBpcEofytRhRA0/Wd?=
 =?us-ascii?Q?WZnjqP497Nln7kA+YnQACCy881sR8GaWY0xIMn8ZOPk6bxQIBk9gMCBC7MLP?=
 =?us-ascii?Q?RCvomvuidvumDaGZshTlWRwQ9VrPVi4hUzL58xQkPgxB23EkXeanm27dG7oX?=
 =?us-ascii?Q?UxQoiEAwHPwt/GPE9WMf6B87URslZLib8C+Xc1yhSGTRA+90ZVFSOOdA+JD4?=
 =?us-ascii?Q?Yd6XE5MuwctmMg9sjbReUEM+HUJazOFLR3vf7/uSxp0RoMJQCOlP7boebsOt?=
 =?us-ascii?Q?aYxt9UTBoBWHOtwdWcBhn4eBZVXkrH4loohekqJjJbI9QGz0QDdPfoaFIZbv?=
 =?us-ascii?Q?njeuTbLFHPgV7NOO8mYjFTHHiqnc2Xn8FmY9pxjgyoGTJCPe4vWyRt6TGmXZ?=
 =?us-ascii?Q?PDVz06/2xKB8iajgh+nrPmNx5nN4gGXp/qA+cIj+UWdVqDECMGb4ykyCjM/F?=
 =?us-ascii?Q?Bs0EgTqFH/SXTm/tECFEIGAy/Tg414J8eOzT3rpoI1u4Cv7VtCluL+KEFHsW?=
 =?us-ascii?Q?+81WjgwLlnEJymtJ4pi0hgfo7BCsSLnU8F6Qr6D7wqEcRL+8v0Y+1q9t4V16?=
 =?us-ascii?Q?tCPL99G5za13Dk3/hssYIhErVfY3Xqkn0XcDHF/oEIzMlfDD0vOhjzZID1Ox?=
 =?us-ascii?Q?3WqpFpudrhgFB5SoW9USRlGncznXqT2fYeAqGOf+/asIBg52O1iFIucasPpN?=
 =?us-ascii?Q?gZi/QW4xuhjKvXIB2y3yJqhQVzT0e6WD87KnwNXy6IYB9d18JqzHqqUN9Pjx?=
 =?us-ascii?Q?SrGPB2jmYbjAMYe/P0YfqQBtA/nc2As5qjwZywAD9iOOPpQalMympEKr/Zrn?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1cc644-a72c-4827-0668-08dc20a05176
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 08:00:11.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dS+ffQ+K/xUshACSmXdgyfYandCVnYlOMFOF8j6jXSFDH4z2VU46D4YpvlYAyfKULmXeC/qMF9Wx2Io50a7aoWyLJzdjmFRh8zwrpxLLLHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0545

This series of patches refactors the cache population function to
seamlessly accommodate both DT and ACPI-based platforms. Additionally,
to streamline the code, the unused parameter in the ci_leaf_init()
function has been removed.

Sia Jee Heng (2):
  riscv: cacheinfo: Remove unused parameter
  riscv: cacheinfo: Refactor populate_cache_leaves()

 arch/riscv/kernel/cacheinfo.c | 50 ++++++++++++++---------------------
 1 file changed, 20 insertions(+), 30 deletions(-)


base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.34.1


