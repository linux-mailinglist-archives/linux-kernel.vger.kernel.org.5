Return-Path: <linux-kernel+bounces-54370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5950D84AE56
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDC21C235F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443EE83CA7;
	Tue,  6 Feb 2024 06:19:38 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BC82D9C;
	Tue,  6 Feb 2024 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707200377; cv=fail; b=AlocJ99Nawed0Rqc+1GOzx4HofWgeHQM1yrwKhfAucI64Kf57/m5WWZSdAw/WIfkoBvie/Yigqa++f2SqDYM8jiQEG3ZNrH0GUDDW6VfOq0K1TcGJ5r7lM9dL+itNipiM3qI/FpDxDGak04UfpWKMU4WK8LRMFuGDazpmxLmAwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707200377; c=relaxed/simple;
	bh=4gv2Xd9CrEIRCBvSz/Vx3/OrtXwLqIZ4h7pknGy73uo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Im3dsogSDE+JG+mJjXaZNzL7/kTXv7oaooTZ9oqryOpMWYtV+5hapJSDOaZgawY47bkD2do8KZaOxSqBez3JSSrYte/ZHnGnY0CtcqG0Ef2lH9DivfNFT/RVHWFCJdF1DL8J5BUOcS/qOigntejKHCUYoTWDR0P3WVP5DowWfEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1hJEMMhYuD1bUEJ6WTJVHlPQ+I7sjZp6oEmwl61qME4jzeZPBCCk6f2mGBl0WK+3bUdqi+DPA2ErN1fuWi3jdrOYpuZid2ECF/XkHc2l5dZ22DFoz/Ou8FjWtd0vh2/YGB3RDR3VAm0XM4aq+YFxRWeFVOqG93dO5mV2mWPqnExknLm/VvLNE2sjlEviymEXtJ3wA465ejPAv4bc75huVC6Y4RIsrxBDBAi7v7+wfl7DGqv02c5CycxD2opMIo3z4BZcJch25/y8dEwSX6ebPTVMY3XLusQ4vZ8GwwpI+bvZVhtIcSE0D6lgxRUzBDubeHw0YtzoxY44evIFmc7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4GT6VsSu828rQ1Dq98eakGBa+/7X0aTdpZ5+ebzXvU=;
 b=f2aoJibFu+i6N4SjJVLZNyEO1qBDE9gQbTsrixwPrSZEwjdLovhtG3nb0JMlmwS9cDCGRq13/wFyk24KptCLZctaui3gmsgSIvoBM/UxoStaVhsxalXoIESGv/4lUQiFgRxlleJq7LMFHmq9NP3CG2hOsx64st/eWAtKUvTA+QdqyCb5/hooZ3D4FhJfyX2/JcFcwI2MY2vqN2cSprQPdHFZyqfccfvmtdTrP/fm0uVnyVWpzW/cnEVPLR/6BzT0fsi7IHDnd9/umGyPQ8DOILtSLkrgf3PkWIBy+gymwBxgQKV0VldET0K5KWCuag1XqTvmTz3s1n05fJAWnTyKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB0976.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Tue, 6 Feb
 2024 06:19:29 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::57c1:eb9d:c4e0:71af]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::57c1:eb9d:c4e0:71af%4])
 with mapi id 15.20.7249.017; Tue, 6 Feb 2024 06:19:29 +0000
From: Shengyang Chen <shengyang.chen@starfivetech.com>
To: devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	minda.chen@starfivetech.com,
	changhuang.liang@starfivetech.com,
	rogerq@kernel.org,
	geert+renesas@glider.be,
	keith.zhao@starfivetech.com,
	shengyang.chen@starfivetech.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add JH7110 MIPI DPHY TX support
Date: Tue,  6 Feb 2024 14:19:19 +0800
Message-Id: <20240206061921.107372-1-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB0976:EE_
X-MS-Office365-Filtering-Correlation-Id: e35195ec-8a61-4c40-3a10-08dc26db9378
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VDkzkQjCTcqYBz9Kv8X6Zerf0A7TH70smjOaPSvBGDXXnIozZsTGI6IkNJP/6kU/Z9P9fAzVt+2rctmDnb+C+J0+6klhAd6irR8DmeD9YHkXdw372Jn2Lm2yA4PFFkPWtVd4HLr0eA0Z2GW/Fhcz5nyCe/8W34hSLyOO4bSH8OoqcvcdCbye141Wo/GPKk0zCjAy5Ux7FDgqnVcWHN/t6a8KY6fo7ZxL0goWCViEYznPIG3TWtT7NeU3oRo54ejWY2KPnOnf6ApibH2zAHfQD7gOGo54J/RR+SVlynZ8VlAuJGk1LJ7IqiW/E2hXCCpVMuy+iE2lQ4AbeCEiHJkrjWDFSFNCkixLHhgulKweTq3zbHAYlVs0kYj7tjyeGlXWZbS2jJi0o1pRKbTRWEF2dbrBVmjknAIAeSEokTkv/nMwJ0nefD6qtbJ4Os9Z+2kN+tdhlM9HsutM3kdQbzm+MnflLub5bn8F+/7L3KM2w2ZbkU341MklggrJyFrNP8XTnAOGfnonBO3EsefGrG481eyPFVhpJs1Oiw4aksRHubyj5RJ74uC11b9YBDi96W8F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41320700001)(41300700001)(86362001)(5660300002)(36756003)(40180700001)(38350700005)(40160700002)(2906002)(52116002)(966005)(26005)(66556008)(1076003)(4326008)(508600001)(2616005)(44832011)(8936002)(66946007)(6666004)(66476007)(8676002)(38100700002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mVlln02zPE2I6MWzpFVrNoUg5q1syWSLAPbZTJJQmpyuQ45TkNulvCSSaFSJ?=
 =?us-ascii?Q?2XIGMiQn//Qqo1oFQL9pgzMbXN1IpUgGA1aQOB4dpLtKQtiWalDyKTIhGaXI?=
 =?us-ascii?Q?ovIZmcke7XE1oB0pGpO9HY3uTLXG7KoHUOkSdj7aYyNiph6yCy63XscjLApW?=
 =?us-ascii?Q?q1hRI92yCNicjUG15c6f5nXPuUNfhGL13+gU+o2RDs8F66fbDs9zK/l2sM4G?=
 =?us-ascii?Q?oYohoNUIbvUhlhKzpZYrhAh9m3CrZnDVVJab4Q3Hvxr7lfnmadifYPQRD6lx?=
 =?us-ascii?Q?T+2oEHU0DvY/vj7FtAozSmwmrIPQx/tB2fqZISN1OSIpAHSJq9ScSdqlDotw?=
 =?us-ascii?Q?tHGH3i6IUAwwHQ96LmUMcVydybWqsuTkJolNskxnAscHH2wY0y3kBPc8olUp?=
 =?us-ascii?Q?W87hfLagm3gQlblpp7R0WzU8f8whY3nCydqrQe7jgWMyBBKRTGi1gYbpau4M?=
 =?us-ascii?Q?2Wirw5iP8QxQKjl8v8OOfFRhM5aIaH/Yz/f3nqtt2YwPrA1va1HPp+mfHsHF?=
 =?us-ascii?Q?F8Gr0fP099ieoPVfOmC7Ts/jPXJmoK2E2h5lKj4BuVgtxGjkf0N2aAVDAnsw?=
 =?us-ascii?Q?SV1M1hlvphNDXn2EIGsqvjJYrxGT+3qz/osJNwAsKiqyCFW8XFJYyXjS/8bU?=
 =?us-ascii?Q?/qIveNsxuNIhpOEA+RVJ01urhu78OSltW33POdLq0e4J6eb2FCM9HoQ8xz7A?=
 =?us-ascii?Q?kPj9cQ0DvfsIKZkc++A3gDPd7fz+ai/kJytxov2v8/fDh4lMRscnUUiXsDrY?=
 =?us-ascii?Q?ZIoR+AVSwST5q0Wl0rEg2j3OB7gZNOIiRSj/cUMSuy7nFadO7gRE/Z1BpoqB?=
 =?us-ascii?Q?BzvRkkbARItvxEtCbeWmxvPNixiUd3DHSbAhcEvL/jJtvw5HFGXwgE/V59ub?=
 =?us-ascii?Q?jGLWpQkw8x115rQzPN1dRtDMO/n6aTeH2+r/tEst6fuRiGrLozDls3LH03NG?=
 =?us-ascii?Q?HzS8etW5DYUeJBYuJAwoug2cg3ciQKydsyv763o4WpPP0Tqz5FE1ys7+VYyY?=
 =?us-ascii?Q?F7Z27trZC/Xrr/UQIfiMrQ19qklK1nc0danki7vLjScqCL445MKtDO/8wtSk?=
 =?us-ascii?Q?xCvTy/pauWABi5QQ5pVs8xhILBnjDp6kQPMQozbGNGUWccKhfZyC5ygFPiqH?=
 =?us-ascii?Q?07AfKy18NagzibQrFA3cKMJx5MG6B8kETIeunxhtmC7nLY+gsmj5zxNOpfrF?=
 =?us-ascii?Q?GRBU5EKGy+vDGbYs4hWv1epvWeNBFXZVqJ2Er0xNlHMN/i6obRq8AHmWjqet?=
 =?us-ascii?Q?zOwwnVB872HBtbGRKSCxcNqGXHGj1VmSgosHRgcxBIZlIJUFsyAHh9F5NoHG?=
 =?us-ascii?Q?OdlupHA4Kf8jbkVF25onvPMfBBKqRVwHiymVKUq+KoCGG03lcw3eHK6LHDFE?=
 =?us-ascii?Q?WMYFX2J86o9Wf9RgJs2J5eVjrYynBxvz+u/dNBQtEGkvcQwy/nFPj2Xhc7X5?=
 =?us-ascii?Q?RJO506TFkpP1nB9MCC0CIZcC19FiFJyFN27jW2r5NqseHp0S7MmJ5ZN0CIkv?=
 =?us-ascii?Q?C9uLvQ5xDQmi+caSNMfotmbgrPy9g9mrxJONbu9hBW5F/ldhWU7IeT0Is2sV?=
 =?us-ascii?Q?C9kWWtxT0FQiENkqeYATCR+0jQDqJesFH7OFBy9df6hgUHkb0VgdbtD0PJt5?=
 =?us-ascii?Q?vuqXIH4s124txf0p/XO0Nxc=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35195ec-8a61-4c40-3a10-08dc26db9378
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 06:19:29.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ov90fBPD7KdKMAk93L1nCYjzuO8bofjaQWazyDZp22yazqz3MFFDsCQWO1XV+u/4aHAmhT9qfVlT8BSeCBBRudSBHspYX8l9TcDaxJWJx8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB0976

This patchset adds mipi dphy tx support for the StarFive JH7110 SoC.
It is used to transfer DSI data. The series has been tested on
the VisionFive 2 board.


change since v2:
- Rebased on tag v6.8-rc3.

patch 2:
- Drop regulator operation.

v2: https://patchwork.kernel.org/project/linux-phy/cover/20240109071246.24065-1-shengyang.chen@starfivetech.com/


changes since v1:
- Rebased on tag v6.7.

patch 1:
- Drop 'dphy_'prefix.
- Drop DSI reset.
- Drop unnecessary resets.


patch 2:
- Changed the commit message.
- Use dev_err_probe() and PTR_ERR() in probing.
- Drop DSI reset operation.
- Drop unnecessary resets operation.
- Add configs in array for full support of the module
- Changed 'void *io_addr' to 'void __iomem *io_addr'.

v1: https://patchwork.kernel.org/project/linux-phy/cover/20231117130421.79261-1-shengyang.chen@starfivetech.com/


Shengyang Chen (2):
  dt-bindings: phy: Add starfive,jh7110-dphy-tx
  phy: starfive: Add mipi dphy tx support

 .../bindings/phy/starfive,jh7110-dphy-tx.yaml |  68 ++
 MAINTAINERS                                   |   7 +
 drivers/phy/starfive/Kconfig                  |  10 +
 drivers/phy/starfive/Makefile                 |   1 +
 drivers/phy/starfive/phy-jh7110-dphy-tx.c     | 635 ++++++++++++++++++
 5 files changed, 721 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml
 create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-tx.c

-- 
2.17.1


