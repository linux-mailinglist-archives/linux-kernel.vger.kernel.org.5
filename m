Return-Path: <linux-kernel+bounces-165279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C79D8B8A85
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67618B22AA0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2321C12A152;
	Wed,  1 May 2024 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dj2Y1hA5"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F3286130;
	Wed,  1 May 2024 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567884; cv=fail; b=Fuo4cb5qeqeE1OHHu4V68xSKkuf8rPKEtIa3SbI4G/xsaJpe67APUGbsQlndumC8j86ztynpxGQUr8DQcYb9hZXDEA1x5Jac3JkMKvKJi5DC2b3MLtzgKuOWMzN7R/00ZOsw1SgnQLXLEU65Zv2ZoVV1cxQx51TsLBKd0NHDe/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567884; c=relaxed/simple;
	bh=sxadJ9Jx/Jbpg1I1XOHOXDtWzle1Y4bjmwEu0knRlXo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ESRTCQ3qyMDraMQ86hu1ImhNfF6U2h3hj5oaxJnjqoal0KeJnu/P1PZqxuTlM9NG5z8J4+FL7gYplAVQLoGJ70dCxlPJYp4BxpaZczfcPjP9cFCGtHAVQCI/hbkhDMrUocgOgK1HBrUAuCH9M+Hlg9qDWWw1o+Th4K/sAGKizxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dj2Y1hA5; arc=fail smtp.client-ip=40.107.13.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMjFbsIiXq1LHEgsA3ixI/2sBjf75yy+EGoA+16wr0ZgFR9rJwfPZo4RxFBTJAWxVrBN8S0Dt+p7fz6mxajEl+WMfG551SNEyG47qfspe8FdPKen7f0nIeO+kF1aeS+hHxz93F3/cByOckwEil9YkR3A6JZpPp/S6Oid3ZtnAG1BTiHDayQGWjkFbtpDGBmXYxn0h9WFCC0AT4tjUeZHZnBrcUeMIC6gKdCcUQGfcgpWROHfU1rgoQhXpNB4ycXpo7jE8jhRWHsozUztvyzCKz1oYZsrBhWB+TYgMcyoPelBmxjg2cMCdgO1Fixc8zuQlFak53Xu14vRVlm/Pd0ZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbEJJaKpKS6weuAiMZixNk2OarOHo1VXIEj/qtenGtk=;
 b=QTla+OcFnSCdxck/L1CmKTle95eTf3otVhk9thvnmFz4muwbNDDFC7Rw45tUc/ViSpCh3E1zSkHODoxfDrhKeMqCJ3+YHb1x+nRvd++lFl+ysrQnCgUMuf2yvRrFWEH+p/YCTdByNyxIKFd6OmDAudicMat1sUDZUMMrdT0VkbejHtedWgyi48v99c+TUEmz19IsgPwHteoxVDOzPOS1Zt9k8QHdKrweH+aViMKaRCOS2WqZMEL7H3+jUpXrtmUXMcaHilzPaVPl+JlvJA6OQe9TPsAmcDZjSaL+hS3WtoFuwUALQ36JkVPMKzgORNP3QQHLECTG8td60mTsg/qhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbEJJaKpKS6weuAiMZixNk2OarOHo1VXIEj/qtenGtk=;
 b=dj2Y1hA5TvwIt1YXYlyAtPCWArlY3X22BcqJTyzgqjHvGQGpk3Jhd0IOOauzRmaC/urZ9KcYRolsLJwiKWc7ECxxWuzMpU9wWlnBoMnUg5iuB2OyYEzEzNSnZwigNJsddfxqqt8jy+/BsNgKmRCcV/Cy5NGSvOfTZTp4P5B+lpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:51:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:51:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:09 +0800
Subject: [PATCH 11/21] pinctrl: rockchip: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-11-797ceca46e5c@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
In-Reply-To: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dvorkin Dmitry <dvorkin@tibbo.com>, 
 Wells Lu <wellslutw@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, Damien Le Moal <dlemoal@kernel.org>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 imx@lists.linux.dev, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=2432;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6jcg28TPgcdPG2SX4SEdUQ95I6NxhvMbPnDkkfvsxtU=;
 b=MtxL5cVJ07UCK4MpPHQZwS4C9+vMA6NCki7BU+bDlc/KaaY6OQpFbx6ZDRJWhn8VS3WCdSOUO
 5P+3Uc+nHCnBaBLYibo6kG7o4MFExBczK4qA7vKY7lOtXIWARL51rRi
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9a488b-1fde-4588-576a-08dc69dd65e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnE3U0w0c1NPa1ArUU5GSUhVOWtUbnZVS3hYdjJ5WGFaTFVsejVzYzFpL0J5?=
 =?utf-8?B?YjNLcXNDVG41RHBJL3BVaFlCMmozNGNLRlpOL05KTmh3MVNHcU42bnhnRWtP?=
 =?utf-8?B?UU81dERXKzhiUjV1Q1QwZ3haVGtZcWsyTTMzaFRKWmtWbVVVeUcvZHEzQWpk?=
 =?utf-8?B?aHdxSUk1QlI3alNIQmo3N3gxQytQeFp2bEU4MGM1akdMYVh3V1IyOCsrN1My?=
 =?utf-8?B?dURBWGRMQTdMQ1hMTkJVU2laMWRsRXd6SGYrbzdXeDcrcGQ1Um4wWXl4NTZs?=
 =?utf-8?B?U29XcWVRbXdncUJ0N2xpWU1GZXVpNFcvSU04VWZHVHNHMi9ZclhZemMzMkNI?=
 =?utf-8?B?a3dHOWZ1RGRtZ2lyeFYzUnNjNXAwUmRMOXBaOFZDcVV5SXpzVmRSN1MyN0RC?=
 =?utf-8?B?ZnNWZGs4dkcxTUdVbFdBNEJkSlNnM1V6dHZGdHlmQ29tVlJTUFZpcGpTOStI?=
 =?utf-8?B?Q1JxNzBrVXpkdUhYMlh0OWtPcUM5ZXlpRGVJc09vK3dWQ1VDeUZoU1BVZ1RG?=
 =?utf-8?B?QWZXVGtwcFpCNmFveFRsWDZTTm43TndsRXFhRCtmZGdCa2czdk9vYkFHaGFo?=
 =?utf-8?B?aU5RUFBTVmFmMXpuLzh0S3dLTU1QdmVoMWlDdG9iei9CU1h0Nm5oTWpDQXV0?=
 =?utf-8?B?RjdhMjRzTUNtOUlIZ3VTQk44VCt4YS9RanJwTmpWMGhHMkh5YTRrTUFCRWta?=
 =?utf-8?B?MW9zaVBLZm0ybDdYdWJ3TVlOZjhQR0JxNEJUYWtrb3lQYVJMMGVqTzZIdTRw?=
 =?utf-8?B?NkpRRStkQXUrTHpHRFZyZEg3enVKTGRmUzR0Z1UwbjBwY0xWR3ZVdTNzQm90?=
 =?utf-8?B?ekl1ekNkTjdUS3JkakNrdzZXY1V5SEFnTHNMbVRrMzNxZmVRSTB4U1I0Ukh6?=
 =?utf-8?B?a3hOZzIwazZGeXZmMWgrSDlPaUxEUjgzbHZDdXp3amlIK0VBTldjcHpFRVEz?=
 =?utf-8?B?d1FoTmhYQWplNHNndlhnWlpWcjJUTjBLTm5ubFp5RSsyU0JZZDZKc2ZqcFMx?=
 =?utf-8?B?R2YwQk84c2hsOTBwdUxUdjBzRmxCSnFmeGdHVW5ITXZTRy9vQk51TnhkZElU?=
 =?utf-8?B?cXpHNFFwdTNVdWtzR2QwT2Y5SVhYZWpXWGpOSEdhVGkydVBkdUsrMy9Uem93?=
 =?utf-8?B?dk1KbDdMcGtHbHRFdGtISmlaaTdYVmJ1OWJqYTlqblVlTndDb01HeWViZWdH?=
 =?utf-8?B?N2JHczRLcm1Uc1BhTlNPb0NvQjRFTUMwNzRqb0xwYzk3MGp3NjZYQ1lyeTVR?=
 =?utf-8?B?dEN3OWdXUkZscGRIeE5QQU52M1FqdEJLLzJYdHN5OVRHZTk1ZUFVNnA0dFBL?=
 =?utf-8?B?VU9jMjNncXZmTEtYaWtwSFlGQlRnOG52U1FDeWFLcFBubnpRQU1YRVVEZWRH?=
 =?utf-8?B?eWgwdnYzOHNuekU3UHlaT3R6N3JXTXkwUnV5ZUcrUDhSMEdqVjNlZEluTWZq?=
 =?utf-8?B?U2U0NGJOdittdnMvUW9DUG5EWHFOMHVIbEFIVktoYUlxYTc2aDNveVNnakx6?=
 =?utf-8?B?alEwVlA1ZjA3a095Ny9BLy9lbkF0b0NWT2puZlRRVmRNZXpzYzZNbmJ5czZ0?=
 =?utf-8?B?VElJQmNkc2ZaKzZYaWw5UW9qeldZSnlYQmYxb0hscjc3eDRTak1mVWNMcGJC?=
 =?utf-8?B?VHNheDh6RTZZclRBMnFFcXB2TU81UlpWQ3FTVEFQS1pJZXE1emluSXEzZkts?=
 =?utf-8?B?TGhPQWlya2VPbFYwUFhkVGQ1QWx3RnRmODdGeXIrWXZYTlJwa016ckg1QWZV?=
 =?utf-8?B?N0Q1dGVXZ25xZUI5eEI4cWlKT21HRlVSUXJ6UHltSllmb3pGMEJvQ1lEUFRi?=
 =?utf-8?B?SFcvVkhqTEdEY2VPdFExQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2swL3k5RkdvbXVScVYybm5DanRrSkFCektPSWpDalFkSHFWTW92VHg2SnNK?=
 =?utf-8?B?L2J6bE5vQmhJejI2ZWFwMnZQRkRxeU1zTGd0UVlSUmtzUEsyQ3p5QnREa0Zh?=
 =?utf-8?B?NXR3UXd4WU9OR1hoSldrdWUzN3QwOGZPdmdkZVpmbVV1ZFdmRXN0aldlcE9S?=
 =?utf-8?B?azJ6bDFFMnhoellKQVd5SkFqTzRwRzRNaFJJeDY5ekdrT09mVG1Cb1EzN2da?=
 =?utf-8?B?elZ6OGxHSDl2VmtDVFU0UmlFSVFhWFhmL0tGS1FvelpXTk9ra3NsV2FaMklj?=
 =?utf-8?B?ZVZNZWJDZnlQSU9JK2V6bkdlbTFHY0hwdDVXYnh5OVg2Q1F4cDFsclo4T2dU?=
 =?utf-8?B?WGw2Y1Q1K2tpT3RtYUNNTWhjSkFyM2NEd1pZQnQ2N01BKzlKbVQrTTNRTXRI?=
 =?utf-8?B?d3VuV0trb2JYaWg2TVFSWk11U1REOGRHd29JL0ZNTjg0a1YvaFpjUk81TEpQ?=
 =?utf-8?B?T0hWVFBXbnZTNEpJM0poVmdDTHN1UVNzN1lKY3dqYTBrWlEvYlZuS1A4YXd4?=
 =?utf-8?B?S3BuWStRREpLSzRvNFR1NlRYM0R3WkpKZGhwZUdPKzUzY3JOVUpTSkp6a3hs?=
 =?utf-8?B?aTRETzQyUDhGUzExVnpYZ25oYm8wbjdhbmdoVm5rcEYyZzRiblZwQWpVU2Nm?=
 =?utf-8?B?elYzWFpPZ3JJcDMvcHJ6U2Z0STVxZVpRRytzMU1FbzJHMCtPeGpFSHJNK1Vv?=
 =?utf-8?B?T2pSaG55alNGU0RrL3Vzb2ZYODRDa0xIRXk2Q0ZZV2ZuSFZRUlhrOFVud0sz?=
 =?utf-8?B?cEZsanprR1dBQU9mMkFnMjJpdlNBZlg4YzJVRjlDSWdZbGR3a2dXb2c2eDNo?=
 =?utf-8?B?V0Q4SUUvU2tVQWg3ZnVRS1QyV0ZtaGhyM2RNamVWYUsyUmpaYkh6RTFXWVNv?=
 =?utf-8?B?SWhELy9VZ2RkclpObVpJdHJNd25udFBpUkVmL0VOa1VjVmxHU0xVYTZCRFpa?=
 =?utf-8?B?UnEvTU5XNzBJVUFpMFRidzYwNGZlaGFnVmtQallKRjNZTWt3d2VTOXVKdlNu?=
 =?utf-8?B?M0tlSkZ3cHNvZzM4NlVRZmxJWEZHN2RQVVp1SXVXdnJiZGVtaHgwOEozbmJJ?=
 =?utf-8?B?cFYwaGUvaUF6TjIwRXBQem1XdmtEdHVxSlA2WldiN2dPRU9DYTc3QUYzcUo4?=
 =?utf-8?B?SlUvTEExN0Y4YUNoczg0Z0wwUVJuSkV0OWJGVk5ESHBmYmExaDZPejlhdFhE?=
 =?utf-8?B?eUJqMVkvb0psUXNrTTQrc1lJN3ZnR1FIMjhmWVd4S2dCbkxUN1dDSkN0THhU?=
 =?utf-8?B?Nk5hZEcyV3FqUGxUSS9vTXkvcFpJZkRkdFJRMThCK1NFNFpHU05pWUFKbUZ0?=
 =?utf-8?B?b2YwZVVKRVAvNnUwSmlWcDBOdUkrWHBzYnlNTmxtY1FLV2t5YWplaVJFNHVh?=
 =?utf-8?B?enByOEtKcjlVdHZQY29lOTh6TVU1dzkwMXFyeDZtRWxPc3ZsL1ZtbW9SZUxL?=
 =?utf-8?B?NWp6V2o1V3NnTHl1Ry9xNnk2V0tnbjB5Tk50NjlCQU9lMnpJd1dBRnBXWWV0?=
 =?utf-8?B?WFZzQy9WYjVNeGdkNnBTUDVwL21kTFFzOEdpa3E5b0orQWR6cHQzV0NrNGcv?=
 =?utf-8?B?bkxOSm5aclJQQzJHa2c4cWZQQTFneVdvODJ5OWwyU2FPSmpHaTdhVmR1bjQr?=
 =?utf-8?B?QWN2cG9xUU5tSkFnd2xjam1TT3UxT1laa3RSTHpSRnlreUNJYjUwQ0ZEVTF3?=
 =?utf-8?B?MkV0UFhaTHVHNkdraXdvQndiN0tjNU8xa3NNQW1CMVdQV3FJRVdITkQ4NHZh?=
 =?utf-8?B?dGtHWXdnQW9seWtaUFZyTHFQK3ZlMnlYVjFLNnp3eENiWENnN3VBbmZhdzFw?=
 =?utf-8?B?LzZVcisydm1JNVFDOFFySm93L0ZiV05RSnQ4UnU5T1Bvc09IUmtMSnNwUkZ3?=
 =?utf-8?B?ZEdxZzFiMmw3TGlqLytyK29xU1dsd1htNHpSQU5xYnE5WEw0RmVKMVFNQnRJ?=
 =?utf-8?B?SWJzeUxsV0hRWVo0MzVRbmhORE1OUFROZXBpaEFDVXhvRW9DWVRyRlhnUUVQ?=
 =?utf-8?B?SUMwT1c5Q25YZjJDMmZiNHUyNm1vK3NrbEEvejdqQUszamZOa2JDNmdwdTNq?=
 =?utf-8?B?MXJVc01waVN0YkhZbXBMbjZ0U2s1Ym0veVZ6YmdYcnV6QWVZRzRsWWRIZUhL?=
 =?utf-8?Q?kwwsONjE4TCSyhA87APg9jrq0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9a488b-1fde-4588-576a-08dc69dd65e5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:51:19.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmREWTxOjqZbA+hijFAivyO/qvvvjM9OO3ILcZmr6eG3JlpsS6rQp70tf6pynNEjzQFHJhBH34gnn98AhHV9FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 3bedf36a0019..5c09469c84d7 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -326,7 +326,7 @@ static int rockchip_dt_node_to_map(struct pinctrl_dev *pctldev,
 	const struct rockchip_pin_group *grp;
 	struct device *dev = info->dev;
 	struct pinctrl_map *new_map;
-	struct device_node *parent;
+	struct device_node *parent __free(device_node) = NULL;
 	int map_num = 1;
 	int i;
 
@@ -358,7 +358,6 @@ static int rockchip_dt_node_to_map(struct pinctrl_dev *pctldev,
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
 	new_map[0].data.mux.function = parent->name;
 	new_map[0].data.mux.group = np->name;
-	of_node_put(parent);
 
 	/* create config map */
 	new_map++;
@@ -3057,7 +3056,6 @@ static int rockchip_pinctrl_parse_functions(struct device_node *np,
 						u32 index)
 {
 	struct device *dev = info->dev;
-	struct device_node *child;
 	struct rockchip_pmx_func *func;
 	struct rockchip_pin_group *grp;
 	int ret;
@@ -3078,14 +3076,12 @@ static int rockchip_pinctrl_parse_functions(struct device_node *np,
 	if (!func->groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
 		ret = rockchip_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -3096,7 +3092,6 @@ static int rockchip_pinctrl_parse_dt(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int ret;
 	int i;
 
@@ -3115,14 +3110,13 @@ static int rockchip_pinctrl_parse_dt(struct platform_device *pdev,
 
 	i = 0;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_match_node(rockchip_bank_match, child))
 			continue;
 
 		ret = rockchip_pinctrl_parse_functions(child, info, i++);
 		if (ret) {
 			dev_err(dev, "failed to parse function\n");
-			of_node_put(child);
 			return ret;
 		}
 	}

-- 
2.37.1


