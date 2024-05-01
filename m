Return-Path: <linux-kernel+bounces-165285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D29B48B8AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8296B21BAB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1169C12BF3D;
	Wed,  1 May 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QjwVmU/P"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C688248B;
	Wed,  1 May 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567949; cv=fail; b=K4/I7k/MDx/EqVWShZKaALnJOmVZC+Dne2LqdztdzupOEvF8RWEPxU3L7BlNtgAEhz230eOot9rKwUkhYVa4RQrzjdytaCFWUavM7CCu7uVe4+gE1qdr5j5ez5Pjj+XQ8rW7x8kTInj4e+SPirNfxtB2sjUzVtSSt+717mUFX/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567949; c=relaxed/simple;
	bh=XjYcrC4knEYcZi59FiMv3CxGYKeUFr0HCFF+UrzXVqE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C7CS/xyhVJdDIZGXwckRPg+xWeElFQ+tcBHTt1i15JA9jRNc8LtCs4xGzeAtMsloJXA6sqIDmkHh+wZCdkMDjGQcjx1Qc6v8D6faXFvzMjgZ5B+Y+isthRtEeVGBERtuG3DyoZhoWKKiTd6teL8iXLElVx8rgd6P8xGbGvdxHA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QjwVmU/P; arc=fail smtp.client-ip=40.107.13.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5x4I8tO37vTuLowCXhJiaid8AwCOcoxxu/zGp4ZyrGMkxDO6AKX8SUWqory8nsXdpsFEwjGHClK4ZA1ENF1d7rDOcDdcaFWAPJAJRyMlqg0i5g8H+qUB1MB8Ro01CGB1N9RxBkZPemvk5N+nMcDNvUoOC1UtjVjwyhE3Y3CwUSlvw79VaSqUzaCnQ+c8Di3vWfeXupVbUkV7qIy9S7dMQxgh16qJK53j5Q4zu8DL4eINPaQoL5z7V1FUudYvmgXS0V5pC/zcXvFRWuzvcc3/6wvcpE+DInJsRtGhllw+dUGMBg+b4uaD0Z0M9jIgqVNgsai9u+ksdjIRPv+SX8kDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfJwrgHZf+RNEj6PZEelZwXcext4Fk8ZGEAWxpPRGZk=;
 b=Qp7YW/KqOQ1dIuAeuLX9G9mKYCeQKb+ZdgY2Ckhc8HxmDCRJQAlOUzTPolmRrFTOOGn7PcIuVCLfG7U5S2ujSfjhRMzgPptAFeOt15NSFlhjoCMNWET5N6oBIBQQgiHUNdVLQ+dnrZakWh6sgp8vK5qajqhcr5Xv8uzpf79lqfHY4q4HZiaexfu2C1pLRWj3yB9zorFALQsIkeOTickhhqT2hKi2FnOqwgSgqO8dPNzeVlv6KFZCndCXS1nnNtGNXPx+UB1yC9EafPI6OegVC1pDkwATZrILcAqHwoMzz6Tt0YE1d5EGg9wCIk90WhAWwmlu1iHN0MRH+ttQV1NBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfJwrgHZf+RNEj6PZEelZwXcext4Fk8ZGEAWxpPRGZk=;
 b=QjwVmU/P+0pzdS0vwdoB/T96EuMtX/O3xazwcaD85Z/GcJaMJFO/o/vL1T8VCvSnot9UUwnYtXRBugi/l85OhU4qT8T4XznapKMfodEUiRpUhnLZVy5R3zk5Vzs0KAUchXBtiFzgERFIVIdrFy56HfHYX7thUjHtaig/wFaSuVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.38; Wed, 1 May
 2024 12:52:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:52:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 20:56:13 +0800
Subject: [PATCH 15/21] pinctrl: s32cc: Use scope based of_node_put()
 cleanups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-pinctrl-cleanup-v1-15-797ceca46e5c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714568179; l=2925;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=DE1TsODFhZuLZm6pDc3wReEJgqgWx9DxsgygoDyK3OE=;
 b=J8lSkR7Mx7ujJcqpDBCl4JEVNUPzdqXFCjkd8xS7+Ni7wVjQNgUYPHjNQ2ks4qlhJDcJuza8s
 sA8SFL9MSd7BbyS9zzyC4a0S11SP/gFWHH/lRxj4iR9+ll5Jb2h9ei8
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
X-MS-Office365-Filtering-Correlation-Id: a105c504-f42e-4153-e745-08dc69dd8c91
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|7416005|52116005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEVsQi9GUFBaOVhlL2JweUwrZXdzTGRvbHBCRlZDaVJXTzRDU2E2SjRDQ3lW?=
 =?utf-8?B?QXpWMWZGbDYvalNjd21uY1FVK2I4ZURCSWRMazJyTHVHS3BBM01hNlR1UUtW?=
 =?utf-8?B?eVZST1lqVVg2TWo2LzJwUXN1QWpBY2RrL21tYjF0dy9qb3Q5NUhMRHpLRm1q?=
 =?utf-8?B?M1FVMGdXTk1ScE1HaUx4ekRidHpIbWFha1h5bGVFT2FDdUJSU0dlOFMzSi9n?=
 =?utf-8?B?LzVoQUlLL2JzVVBXNzFnWjYraXB4anRBUS95aVlxd0JSUGNqeEJFZWxEUjYw?=
 =?utf-8?B?dXAwam9wQmNScWNHT3pkWnFYN1ZIRmQ0VWRuL3JkbXlwQlpiZUFBNEVmQkg1?=
 =?utf-8?B?Rk4yM2svbFMyVXZ2SitEaHlZdXdxcnVMNzZ6a1FESXdkbzBrcVR5VWpjTmhT?=
 =?utf-8?B?UFZueFlmampMblhNQmRKRzBsUmVsSjlIdDJsdlY3dUFSdyt5VExwSDAxOSsv?=
 =?utf-8?B?eFlDdG43LzdENk9aakgxWHdNUXoyZkZsSUQvampHY21PK2VFak1ncDdVUmp3?=
 =?utf-8?B?Z3c1M2RzRTVlLzZwblcyQVJFdlNIdklnOGdXMFAya0FwUE1UeHNwZ1J5akJR?=
 =?utf-8?B?RFFTdVFBMGFlQnhHQjJlZVlRNWtSbmZSaXJQNnE5dGNmYUFLc0xPZkdOYitI?=
 =?utf-8?B?bUdDdWhCZ2F5NkZvVkpVVVpNQ3hKaTBLb2pXdDZJWGVRUXpyS1U2NE9lYWZ2?=
 =?utf-8?B?YUZMVjNiTGpSenA1Y1VEUDZSTkprOVhHZ3dpTFRhUjJDVzB4MWtUanRtNEM2?=
 =?utf-8?B?Q1k4R2ZNbU9jcE1oV1NBbHJOclRCZmw3NEVkR1hGV0ZtSWVrVjRsWUZuLzQ0?=
 =?utf-8?B?dXRMbGdUT0dmOWlHTUVPQ3FtK0xnVDBPRWdXUXpDK0cvRHd3U09lMWxMcFVh?=
 =?utf-8?B?czRVN3RPTThzdDJpQUpEZVVET1RBVjc5d25QOG5JcHpJVTZUYW1Ud3RTelNt?=
 =?utf-8?B?TTB5N2MvMytyU1Vad1d3dzRramxxSXlmODJHQVppY21qMEdZV1V1V1FiVjJJ?=
 =?utf-8?B?MDNPeTg4YjVpSVdWTWpuTXIyYW9oTjVGUzRPQXR3RFN5WkMvTE5FZFpNNlUr?=
 =?utf-8?B?aTBSTVlEU2lGNTkxRU81SmhpaTEyM2l1RG1YeWRZQWpEYnpnZmNJZ0MxVGFM?=
 =?utf-8?B?by9NbFBoQTUwVHZHRFJsUXRrUVFyZUtwdkc2NUNFbjhBRXZ5TVhrRjdwcGpy?=
 =?utf-8?B?MmY3Rm5kMzhDV3lUVVliMnZMQnI4LzBrcjJPWHY2dWczZFN3L3hSTUo3VElY?=
 =?utf-8?B?UDdsWWF4dFduanJHc1Z3VFBoS2o2ZFRKa3BtYksyTURHbDdwYUVjSlhFQWxq?=
 =?utf-8?B?am5QVE5PeFVnTyt4R1VTMVNibzhWVVZ6ZHRVSXhNWDl3V3BCdkQ0U3ZYOFhS?=
 =?utf-8?B?aFdHNHk2cGtHOEV1M1V2R3lGWHBHQk5sdHd3cDFPS0RBZWtucStQcmZlSytR?=
 =?utf-8?B?REhIK0xUTlhRN3dNUTFKck1nTk55dXFtWU5GN0R4NFBoOUlMckhxYm9jSWw5?=
 =?utf-8?B?Z05tZnZiMkRJR2s1Q00yOXhDRk12SWpmTGlBQW9ha1JRRWlnOEpkejFuSGR1?=
 =?utf-8?B?QmhFMU9FY3U1OTliYzdrUFhaRS9NZGREVlBlY0JUNzFuUVNZdFJ5MzJvdVpU?=
 =?utf-8?B?MlpQZWdJcC9ta01INCtZNzEwaWhPRFM4NUJ2TGJCZ3E0alNFYzJnSkFDMnI4?=
 =?utf-8?B?NkNzbS9EejQvS3liZlNrNTRSMFZsOVZPaE9sa3FQaG4yWDlpSDA5K25RT1RH?=
 =?utf-8?B?N2hlU2NaMnkzcHQ2T2c0VkZ2UWFGcFRXYmNtWktBN1lXdi92RVNlYU1CUURT?=
 =?utf-8?Q?Ds/0XWpe8qkZXxM4dmReSEZEojKxrEaZOMa3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmpwQjVtYnphMDJpMlQ3YW1RVFhOWmpISjNhQmVWZVdZK1Q5cWc2R2JqdG53?=
 =?utf-8?B?NG1mVWhiMWRTZjhIQVFvaTRqNDdsWno2RVJaSnFrK3F6TXRPZ3RxdWRlY0Rx?=
 =?utf-8?B?eExFeDgvR0gwTzNYNXMxVFh4UzhvYnNpTzdXQVc2WUtHVVlFR1hITy9UR013?=
 =?utf-8?B?N2p6WWtHNS9WOW9aTHplNTNIL2EvUmpJbTRqSnp4ekVkNFo5eDJYZVVrQU5o?=
 =?utf-8?B?eUprVFRYZXdOVm56QitUZHhKNXMzRnFSYUg3SU5adnlENWkvb05DdE1FK1l5?=
 =?utf-8?B?MkpoRFNWRGRIK0V1R3RBelNNN2lCdU9YKzlWWHFQY1pacXBhNU1QRjRQNFd2?=
 =?utf-8?B?ZlZKT3M3ZWlEVXFQNVFjcFpQbXRtNXU5VDVhUWlQS25SNHQ4aFprbGxwVVJE?=
 =?utf-8?B?Nkd0dU8yTFhRL28wQnRLM1MzRVMwa3hHZWNIcVBPSEkxS1JRUlpld2xsZGxV?=
 =?utf-8?B?Z3E4SUVMS3gwc2xoT3ZDV050ZU5pVXZqWFdoMTlDay9jUStyZnB3VTR6SWVB?=
 =?utf-8?B?ZDhWcThnVXhwVDhubUllSWNaMjI5SjQ3cDNyT2hDS0lkaXZrck5xbk9Wamdx?=
 =?utf-8?B?eWdDNmVObkQxaXAwOFlpeDR0bWl6eVd1bmU2SWpQbFJJNkhGRnF6VHMrZUJU?=
 =?utf-8?B?ZVNsTC9INWoyTEpTL25aTmdwR2tqUHVzVlhrVVhuM1REM3FqK1FzUkVaOUg3?=
 =?utf-8?B?SkhCZk5ya0U2Z3lLYjNQUy91WXV5TURmVENJS1Mvd2NpaXhCcXI0MXVKQjY1?=
 =?utf-8?B?MVBveXJHeU1aVEl4V016dkh2ODRmM3JTSmlqTUQyQW4vZ1RLY01pVTB1R0Rq?=
 =?utf-8?B?Mk9BYWxQaWRoR2RzbXAxbkZkV2VKamZpQ0oyNHVnQmxTeE5BRTBlb0x1NTA3?=
 =?utf-8?B?cUxiMURlZHlBOTgwU3RqeVBpdlN6cmtJZTRmeUJxeHp3NmZaZEordTU5aXRm?=
 =?utf-8?B?SGlzc1NHTUU3MU5EdVVGMTlyZ294L3hsK24xTHlOU3RyYTJxdEVDOXVFSmtU?=
 =?utf-8?B?T3Jod0VsYzdVKy82T2srNHNETUhJSmMxbDI5RmpGdlpIN1dRRXdEWnNScFQ1?=
 =?utf-8?B?L2V0V0k2eVNxVnhIenNyZzI4elIxbTFIUGhkUFp6OUllT3lUTGhURE03QTQx?=
 =?utf-8?B?NzdMVzdRTGlHaW92UDcxRUN4bTFuSFZleUhzZDFuRGJXVDdFbEtFOTBzT0tW?=
 =?utf-8?B?TmRhNGNTMjgrNEU0VjNmcHUzb0dtZXJWQUt5eWk2UWhnYWw4MkNZNWJUaGRv?=
 =?utf-8?B?czhtNzR2UUFHZ3dTZi9IRHhxZndSRm5Ed29YZVRyZDJDZ1lDTGJBMTRxM1hV?=
 =?utf-8?B?a0s0ZkpMcmZ2c2VrcTFTM1h6Nk1Oc0JjT1BQc2hsL0h5R2NVMUI2M3pCUy83?=
 =?utf-8?B?dFl2d2JMbzlOL2NNRFZaZDhmVkdibFhUaU1OdlFUQ29qeGdkU2Vhb1ZvQVVI?=
 =?utf-8?B?WXg1b01RK2tuMmNnVjV4Z245KzB2QmdHK04xQUwzMmFFdElRZDlXR0EvUEJy?=
 =?utf-8?B?RnhrOW82dEZvL3l5ZTc5bDdaKzhNKzdsVm42VEZZdlBKOHRHVG5XR1hJRlBq?=
 =?utf-8?B?Mk9pSXd2bnZ1aitpNnFiTVQxcThwZUZ6M1hyYnRBYnJud2t4bk9KUlZVT3Ni?=
 =?utf-8?B?bnJWelhSSjh3M05DZnhYUk1FNEpPSngrS2JraFdxN3ptNldCbEhmU0lZNm1y?=
 =?utf-8?B?bjNyZGM4NDJDemtYWGRPR1lJbGNabHBoNXpEM1QrQ0M5SzNLVE05TmxObXRz?=
 =?utf-8?B?VlVtMEVjell5UUMrYzdnZ0NublVKMEZwMmpjNXplNk9sMDhJU0tqcnM2cG9h?=
 =?utf-8?B?eDMveXlmNTFvbE5jV1RvNy82QzVoM1hlS09meGdTN0R5eVcvY2NkRFhhUnF0?=
 =?utf-8?B?NUtIMkdhUzU3UHlydkxxVkN6aitXRytQcUdtckZmakhwbE1tV2N2VDYrcjNk?=
 =?utf-8?B?czVUM1hrdlhxMml3LzdVNWRZSmQwcWRSQ05lYzg0ZHRGMDZ4TzN6SUV1eHFZ?=
 =?utf-8?B?SThqTkNic1kyQ3pTUGpOZEdWNjNmeUxPRTdmSE44eVdWZjJ0KzViTS9oNFRj?=
 =?utf-8?B?UzhlUUl4SkxxeDErNDQ4Q3VBVDRHejIzMkFIbHF4RlFWb3RFMGFJRjQwSVpk?=
 =?utf-8?Q?QG3EVCCc9v+ORrmYmPksMogL/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a105c504-f42e-4153-e745-08dc69dd8c91
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:52:24.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZStkNJGrOCQR6h70iowtdqpuRv0/HE6bewRFs5vat2TN7ogu87qOKaglGCwTHgwSua78d9w2wAeVmvCLtq+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

From: Peng Fan <peng.fan@nxp.com>

Use scope based of_node_put() cleanup to simplify code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index f0cad2c501f7..df3e5d82da4b 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -268,28 +268,23 @@ static int s32_dt_node_to_map(struct pinctrl_dev *pctldev,
 			      unsigned int *num_maps)
 {
 	unsigned int reserved_maps;
-	struct device_node *np;
-	int ret = 0;
+	int ret;
 
 	reserved_maps = 0;
 	*map = NULL;
 	*num_maps = 0;
 
-	for_each_available_child_of_node(np_config, np) {
+	for_each_available_child_of_node_scoped(np_config, np) {
 		ret = s32_dt_group_node_to_map(pctldev, np, map,
 					       &reserved_maps, num_maps,
 					       np_config->name);
 		if (ret < 0) {
-			of_node_put(np);
-			break;
+			pinctrl_utils_free_map(pctldev, *map, *num_maps);
+			return ret;
 		}
 	}
 
-	if (ret)
-		pinctrl_utils_free_map(pctldev, *map, *num_maps);
-
-	return ret;
-
+	return 0;
 }
 
 static const struct pinctrl_ops s32_pctrl_ops = {
@@ -786,7 +781,6 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 					struct s32_pinctrl_soc_info *info,
 					u32 index)
 {
-	struct device_node *child;
 	struct pinfunction *func;
 	struct s32_pin_group *grp;
 	const char **groups;
@@ -810,14 +804,12 @@ static int s32_pinctrl_parse_functions(struct device_node *np,
 	if (!groups)
 		return -ENOMEM;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		groups[i] = child->name;
 		grp = &info->groups[info->grp_index++];
 		ret = s32_pinctrl_parse_groups(child, grp, info);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 		i++;
 	}
 
@@ -831,7 +823,6 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 {
 	struct s32_pinctrl_soc_info *info = ipctl->info;
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	struct resource *res;
 	struct regmap *map;
 	void __iomem *base;
@@ -889,7 +880,7 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 		return -ENOMEM;
 
 	info->ngroups = 0;
-	for_each_child_of_node(np, child)
+	for_each_child_of_node_scoped(np, child)
 		info->ngroups += of_get_child_count(child);
 
 	info->groups = devm_kcalloc(&pdev->dev, info->ngroups,
@@ -898,12 +889,10 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 		return -ENOMEM;
 
 	i = 0;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = s32_pinctrl_parse_functions(child, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;

-- 
2.37.1


