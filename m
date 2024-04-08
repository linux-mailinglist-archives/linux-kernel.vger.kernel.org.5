Return-Path: <linux-kernel+bounces-134708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E0189B5CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF83B214A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365C4C63;
	Mon,  8 Apr 2024 02:03:30 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2114.outbound.protection.partner.outlook.cn [139.219.17.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F654A2F;
	Mon,  8 Apr 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712541809; cv=fail; b=bSkugxrP/NVlVMQGMxC+uFSiRfXPidatSAaSP2LF8MWZ1xLlI2xInE61UqbpQEdOxbnyrgaVLk1QsYXwUvJQMi0zgkDmYf7iGExi4Sg+U0BFwhd3vm+37MwmersPy54264jJirX56O4N6gqL/HHynKjhezHM9UDjO+gVAl5nyOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712541809; c=relaxed/simple;
	bh=7u6hG+PKFcrWF6fZ9EmjYm3eEbSfWE8EkfZzRQ1DjQw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PYWT+YOtnJ8c5AFwLbzRZhGuU8QzejfwnADwN2dV8YG0ZOp7JW/+9aPEcpEx7mrDlZOYdjb5+BRpNfIuonyQqRu83yurBKd6kFQ3Osg0PzoaJ4McfZmgzKKDIO2hY6RWKfc578bRAeqrggAd0ndE0qcYIHj+6KaNyBWYZM1oRmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYwJG9F9LfK/tl5HFMYVfjrnWxaUFpCD6cPYwOVQgzM9tK9uFmHzKYdzwcTMYEMOqXlZqIPCg2sl/d8Yb64muTo0JZr3sEkr+CQNRNGXwyvsNmmH8e/BeahTk4tE3Onjvdhb2nJLkDr7zRsm3NrJjpkCeNkJ/vWWouo6OqWKuVMeI2vFaOS2nH47oYHmVHaLPujk5LpJCz7K6cUsYuuaZO3hcrbJrVli4/kHjvbbZsJKjP/VhmRdV387wSC+MVxVbXJvlOid9rjMYD2baZfVitEEgUbV8wQvjIgeR2nZGVJNayQIh6FtE/Z0IGf7d5pHhAsk0cR3SOxwMrjneh4m7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxgVjA5KaTC4OoSw6OnQaHUm9phsQKfNlcUIy7azWCQ=;
 b=d1ctRxsxva2tPpRU4dScQw7WTPEnAKR1mDjE6DTgLMXZCictlFyb3orQZySli77DB5qyzsNkQ5HPFrbus0hC7bDPOnYzHG2kgURwZ48GvZTODVmL9hImOxw+EPWTsDJY9nvG6Dh96XOhDkqSz2ta5aiXQWA4hivvi8MUUoYn/hhYltouD5HT/n9Vbi3zIhLexLG9PJv3i4+ocG/S3J2RAVbvk3B2Nog9r8cY0wAUMcUx/H+zB1C9crYpOaxdlbnV1x9LPP+DihUKD0DqVD1sGOuMB57mEiUWINeSOAG/5Twygo1FAvB10Uf4v04HwI2wlqUrVsW7RULYH2AXWCkQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0605.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 01:30:15 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::a137:b8e5:8a0e:ca9f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::a137:b8e5:8a0e:ca9f%4])
 with mapi id 15.20.7409.053; Mon, 8 Apr 2024 01:30:15 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add missing mmc statistics in DW GMAC
Date: Mon,  8 Apr 2024 09:29:41 +0800
Message-Id: <20240408012943.66508-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::6) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0605:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b900b8-a726-491f-0b27-08dc576b7107
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zAqGoFPuM38DppD/2tbZRfYDrS4wTum3z8HZfszs6rPGcoXYdWpbgYe5q06RQUDKhKhaQs3zqa2QZAr9OY0ZOCP59TTGY8AJdcg/7RUiztTmDAnEtTo9jvvnSuEwgBAGUY+/fwM/yiOlklS8GufR1Xtxz/cZOHD/sbk51FZqhIO53FRjAVTljobXEggUWLrRctgBewJOAV95iceViuKnZ+hENTweKe0814G11M7TE+7Fyq1jYL3/5AhAljAm1CI8EhHHLqTu7PXHEz2hMdrIt37Fzqjh6ea8IGVH7R1wLQHZbJKTUcBF0CGz7s3d1geBqN5LmLyhMEO8PMmfhHZsg+HXXqrOaZB+Yv7nQDJn08CjNwTgkoEI8aN7KwjngIQJ2qD4R7W69NdooYs35fuZsiieMflf6r8RiBFRG5XYE40DFybe7fYzLwRqFtNq8sj0KYpYQ95E0d7GPOY0VN3aGdPs8MfmGPZgtglNvHlWnGAzouGorMrboLKshmYM1nwlMTW//f8wTEkbB7Kk340JKwsK/jVyUjc/Wyr5N1vXC63hIAcQMhQhOCxne3GpT7kiHJEZCYaN4+ecSklpG3SMQzax4WCZAG/p14AGVCpicBZsTUQ7yoJm9vAhXVYsd5YK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uGhjy47e+407yJVCB5QYyxKNQS0Ibc2e1tzl7eXdAYS0r0rFSyzMVATzT0GH?=
 =?us-ascii?Q?12H2n4FpM60CSUVW2Bb3xgh6hwyHwTMz7EvYUY7vOsKImNFs6p1k+/HLd559?=
 =?us-ascii?Q?etg5WpY0ZQiA5twe/fspmljDo4RLprq72X1JETPFhcl1Y80CMuVjKqyHBkev?=
 =?us-ascii?Q?2G7HaLmtI69e3SDz8F5g42BzdLECsDyJEX3sW02V78Nvsthu3wNfD83lxIBn?=
 =?us-ascii?Q?7OjZFxDYTdQXn0gid1OT3p2xMl8cmS8gEcLLK0KIUb8ccFKxJ0hPArvcFUeX?=
 =?us-ascii?Q?GZAHk/Kzesv8pkZjDawLRVwnoWkcRQYBj35Cr3MVVjPl7S68nfrP2eWjhD2F?=
 =?us-ascii?Q?aBV5n7aETL5rXV6JH3+HUO/icSqQe0gQHaWI0h7Rdj/zt1zj+HewQEJ0KsX4?=
 =?us-ascii?Q?TCYbeuukbmbb7MfRqnL3g9m44uMS6LUuEd3FOLSU06oUKxEp4LBsh2wflzP4?=
 =?us-ascii?Q?nLzzu/yuKoXEXlucGhteJhhrOHCf5JLFMe5niUj8DC7DbaKY+bbXCMyU4Zh+?=
 =?us-ascii?Q?oTw/K0J68JBQQHKcH1oU46Ejy4X6MGeR0FRXxgFtHTPKDY7y98PdpJ1z9vVf?=
 =?us-ascii?Q?UNFGmMPNUIZccPH2t1FNpKhGk1fNRNvqF/FTGCy38lefYDjs3UUYRDbpi4AX?=
 =?us-ascii?Q?in46qXoBayv2M8LYOniX8Fw8MXFDBoF6eX2FHKJff4cmTGjgRjrVrKgwxusW?=
 =?us-ascii?Q?Cq6CbhSeTxyUAqtCnTUQWxpiN/0hFykQPxSBY/zR+L9SOCXgZPBzW1BF7aSe?=
 =?us-ascii?Q?THR9JvMx1Wd4BxCcCyoEudWGI54m3hRbTQTBJNxzzcl0aRrrYsa2MJQdKIjY?=
 =?us-ascii?Q?pei/KErfI8+aEttvE7pUmz2xV2oZBAKxDUDJAPMljarI51lF3bZ/vs/fcflz?=
 =?us-ascii?Q?aJ4/VAzZur3GLkfhi8a6jpwyaQDKbbSXCueHyGXEsAKnxZYdWd5gA5UvGPYW?=
 =?us-ascii?Q?1kb+cWTjC3xa9thElVBYLH4/okLXIW/3fGDGcnBI+hoc3wKTZSmZ2cxxzEah?=
 =?us-ascii?Q?I9p4OdwjNlVxxlqxkqbGPzdP2RXAl//z70ZqH4HRr7XZz7kJ4WuJrGvkshHP?=
 =?us-ascii?Q?7aJL0s3uJQeSNhpdCbObvVd/lt+jfsjI499GizFLHglmVVyU1O/jroaL0yxp?=
 =?us-ascii?Q?a0d0jlB39O8EVX/cQEYnle25iiimUbSefMRUoAQOz4bM6hREotfNVkEfM62d?=
 =?us-ascii?Q?KSmuzyMdFv0oOqgbFurRBliTUMkvcQCfONYAjuHpYURs1GgEJ3Zlst/DTGIu?=
 =?us-ascii?Q?zsyrGOFGKu4lPk4Q2v7vxq2Wt6Jq9dyxsGcSfCxvBuO/174XXfhglK4tua9N?=
 =?us-ascii?Q?hJIItKglMCm2SUw0zBkp7Oavw2ZulbNCZcpSPtbXLPHybyL1f/t64exlsFfD?=
 =?us-ascii?Q?yYHZTwgCUb/rqZebb3vKA/H4pXa5RESuUM2HgyJVHRqbEA1DpeNiixTnHEia?=
 =?us-ascii?Q?fjSbU7qhE0z4tVhdiXm4tKKiA9kqpoPiRL6gnjDfpFySkQ335ymlnLAhzPz6?=
 =?us-ascii?Q?81btHct7iSS3YHNeVDshszeCldUHBh8q9FtHu0KkX5PnbDGVj+mY2PruCYH4?=
 =?us-ascii?Q?qhES7mlmjrv0vZjs40HkgQXT0zyFX7+E4N5SDk0Fv7swin+8pNw7yshlBRtV?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b900b8-a726-491f-0b27-08dc576b7107
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 01:30:15.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/byCmzNmLdvbnkS7YAfM+4SqT4Nk7A8qrJ0bShJDcASzDUFGX4fjqvRFpD9vidFw3iNSvFiIizxqPe5dXpQcLt/HrSXJF5UD3+Y6RbCxyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0605

Add miss MMC statistic in DW GMAC

base on 6.9-rc1

changed
v2:
   patch2 : remove mmc_rx_control_g due to it is gotten in
ethtool_ops::get_eth_ctrl_stats.

Minda Chen (2):
  net: stmmac: mmc_core: Add GMAC LPI statistics
  net: stmmac: mmc_core: Add GMAC mmc tx/rx missing statistics

 drivers/net/ethernet/stmicro/stmmac/mmc.h         |  2 ++
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c    | 15 +++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c  |  2 ++
 3 files changed, 19 insertions(+)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.17.1


