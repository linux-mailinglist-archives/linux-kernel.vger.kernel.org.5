Return-Path: <linux-kernel+bounces-19168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2A826909
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DAB282397
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FA11CAF;
	Mon,  8 Jan 2024 07:58:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2085.outbound.protection.partner.outlook.cn [139.219.17.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46679C13C;
	Mon,  8 Jan 2024 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMnNKv32FjciuGb3gm/Zs44/9L/HRk3a5peRseCDkoHQl6CcDyxLZQSX4JjMkG/iMhnAFLRIbOFdnx70FbfXRyD7T2CT5o6dNW+dQqSYlXqO8QoR2z6mpjDpBX68SegWMo/aT2QzveU+QKZAtbV4qbasIr4UF7FsxZa1zUCA41YbMpx/YVD/9NLjAYzV3FYlHLkILEc4FwDxw5VhtLZHlnXF6PvwnNk3WDhpoR02+B5EQ+BdlWSgl0NrLIS5XojHt17319yvdo7tXa/RWk+rQ7smV54DTv18gq/0RaONrI/J1nQOoqCJpv5O50SpGP2V169qEJaIAOzVnkEpBLv5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCyieCzTlRavi9GHuI4IbkBVIrqJA8fZiMsx95FCsZw=;
 b=dA9mwn6TSrnJyPMLmAX5ZH5wdXS1x+uCns8ZfUI7jJn2drs1/tP2LzDzB+SvPCoPk5phg55uM6LA5k48UX3LKhr1Ud8mUV90JuBvbwexbKAS3OzTD3dvrQrv310gNW5SD47SOudDWrSsC+l9Igijk0COmn87EmALBqM5EgFqC3GxvnAhoXzyxs45Wtq0Klce269ijnGhQXVKbBfPtiikvRQv3A5Kko167Y/Xj5wUYWQ2arUufdUa2xJMgtxZNnZmiYSKBDez6QQ3AD7cTvjLcuYUky2QYroTlRPLrISDM9Dt5bKJNVqWXlVoI14nEqQ5vOTQS7R/ujqFHDUZqSb21A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0755.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 07:58:28 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::aaac:167d:8e0d:3acb]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::aaac:167d:8e0d:3acb%5])
 with mapi id 15.20.6933.032; Mon, 8 Jan 2024 07:58:28 +0000
From: Tan Chun Hau <chunhau.tan@starfivetech.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jee Heng Sia <jeeheng.sia@starfivetech.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] net: stmmac: Add StarFive JH8100 dwmac support
Date: Sun,  7 Jan 2024 23:58:10 -0800
Message-Id: <20240108075810.14161-3-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240108075810.14161-1-chunhau.tan@starfivetech.com>
References: <20240108075810.14161-1-chunhau.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::15) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0755:EE_
X-MS-Office365-Filtering-Correlation-Id: a94bdfaa-2dae-4b24-5a9b-08dc101f9958
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BMF4lN2zyFS7+TLxuueGctvRat5JaYDOop61a9ic+Zs6lhPaiu17O4tJ47ezNZHuYxblvVtpjpoR8/ebIn0ZJhqX3wWUNkp8EyiIM/AczeR1/WsaChnyuILi0QJEb3CQtZnd8mmcDAuLxXjmfSqncJdU6p00XLLYYi/JG0hbB6XmcTfldQqTCdX2UxAKD/Rl4nm8t45it/GOKx+Sdg5eukzgIhTxcnqYr5iD462fKSrcKJW0nPPnU17QI0dHTt7Qmk8MlHCMxOOvcCLNBkuRezjDKAuK95r1L8R8Dqe/8Uieh6uPPDoEwPFi3zmmmfoQdgnmEzCWhjTJd4KIO5Uhxdm8TKR/OMqKuPuPQDMZxZI+QE8kDfrnWNm399uijkqVMZm/DijJYOSuNF5hiBPmJUwRtrN5UCf1l2j/mtvY+WJEld7G87nfwhU03Y1Ciege9S9JLMB2zVbgSjkDnZiYWcyFGjZQwt5EOIMFGeivLnL31SUn1z5WBjaf400LGlfQmeAYiJo2O2rhMiaIQt6Yz4AKapJOLlWcLG9mK5lp4SIsPCJdExNnd8FbPKrqSua1LgPz7+bjwYn4vmiGwH5CHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(396003)(366004)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(1076003)(2616005)(38100700002)(41300700001)(8676002)(8936002)(54906003)(110136005)(5660300002)(7416002)(2906002)(4744005)(4326008)(66476007)(6666004)(66556008)(52116002)(66946007)(921011)(508600001)(38350700005)(86362001)(40180700001)(40160700002)(36756003)(41320700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdAg+F0Em9jokxoc4/Zme+K+McKdHUPbiFcpBbcnuPFMA1tnlUTu/jy+UiZ1?=
 =?us-ascii?Q?vNBLhSX/ZXZArPZSv6puq6k+uJcKfCdJWa8CLJi1QfJxDdIfkUla4unSFqnz?=
 =?us-ascii?Q?wRLbAsoFAGxidawUeN4wZW+2yE6K6UvAM5pEXY0ch52PwqLcabc/SM+E9Gdt?=
 =?us-ascii?Q?SLW8XbtybOotrn0hC7NsdSGWLqX3Y3UijNi5CMQc+l+Wob6aaMr3n9i0mkwW?=
 =?us-ascii?Q?2xk5iWe+KjR7K51BcHWE42Jqrt4m117bq1gdq6OwVlCXMD8sX+sYO953kQ3R?=
 =?us-ascii?Q?4kF4Fyl45Jn0f83Er5605ccOJbcihUD00jbqqydqOLQRmiRGe25no60xSJRd?=
 =?us-ascii?Q?zhCGWQm+OD+JTBv3g3UAzk5P+JyShDymFc4/SBxaojTzNaRRW1Sc1MU3QowD?=
 =?us-ascii?Q?gyZIYwiM4zyeX1DoyfzhdvtaHxIlfr5OJlF32Ymyd4gr6HwY3rGsudKJqyDP?=
 =?us-ascii?Q?oOKh9RLmr9UX4ZjTolLr6FiKHygMk5cAupiQLAINV3wloD5GgydjGQ4MLNe9?=
 =?us-ascii?Q?PQwN3DWCOq5N99NT4z60P+LeTbXrRAbzEpjEa5Gm/Vju89S+rRc8M528tjY1?=
 =?us-ascii?Q?vbk9GBhB8MCQDpB4LCkmXOb+Ho727CPz1cxQWsQEy6SoFqOjdWHKYaUrkPgF?=
 =?us-ascii?Q?1gKLTqqFt+SId2SIPBAihoeBis4jGH0Et4gMs3J1cEua0q1mOYkEol4NthPJ?=
 =?us-ascii?Q?XQg0FJzaRDY9oUAETIEHhQqs3z3q0bKkr6lUbXXMnyKoxdd+4wn0czZsQFpu?=
 =?us-ascii?Q?mU3pfu9VHRtD/cF+LpoEcwDKDw4rGeZuupP6HEnyuaTYaR1y8eFF23BSVk6v?=
 =?us-ascii?Q?9xawZpXC4wC5vKISq4NNcAP6dni6q7pG+dH9SeYu0Es9nvgb/I++Gw6RLLql?=
 =?us-ascii?Q?gbMnYgUEY+wFDtbMym0Jf67JRKS0hMUXbuE7RymGV5oGFYcZJYz77AQq7S2a?=
 =?us-ascii?Q?JKjTdeH1GixtJmfGaE5Fb2M6HtVVd2gFquS/T4iawFYCHVJZTEBYGvFAjcLm?=
 =?us-ascii?Q?OJOVHQ+e190qZhLWZR31IesRxfeNWp8hwFyDwZVd4DGfR5CFj1ONtTBlSjk7?=
 =?us-ascii?Q?AIFjYDgo0+PQtDgdd+5lpTzTHximyzXNHghb8HeTPhyF09DogVmShCrtPaXB?=
 =?us-ascii?Q?xDY8IyQZPGrls/+Eam1QrYeWaLLdKAkaf+LtH7O4rf/lmXCe3RQ2ytWoYuVv?=
 =?us-ascii?Q?etFLo7U0s5+jGnVvvz3OQQ8posBGubdN0R3kyONrFp6eDqLUaewUGlQH2Tn6?=
 =?us-ascii?Q?nGJsNySN5H+L+i2RCPPiBF/9083XiAEE230/26zF2BuDvEJtJoum7oCKn1XK?=
 =?us-ascii?Q?OJztXFQLVC1VYNVf1RPD/nnQUR8sX2XO2acurVOhkaXX9cLRKPlMAeIPM5q8?=
 =?us-ascii?Q?xnm/j0YOEEkVUV/GET1pitG2nRTXF9VUjx2c9QkqSpTmsRndzXS+HxKjZxv5?=
 =?us-ascii?Q?J7oJH90zqU00QZegMbdEid5kvXv74a5NbjrWgBokOI/2XWDAB8j9XJJW59SK?=
 =?us-ascii?Q?+Ioy+QKuLCOr/fds3AWLIkiaUi9/WBDEAQhkVeT1MiS0YU5v4rC0ky4gWZcj?=
 =?us-ascii?Q?vpTL+gUqUeEcr+rIGqC+OWJEJExbkN7TEjGiV5qo1gwyNpqEws7o+DdH323O?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94bdfaa-2dae-4b24-5a9b-08dc101f9958
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 07:58:28.3533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bHayFfxRGyTD/3d3II1JhLJ/P1eubIi8T0JWPFH4e4yjbzh56emBba0w+cSOjKyyhD9v4kpwbAS2vY9uMdjt1MQFL8sXsIPmXJQF+WWPmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0755

Add JH8100 dwmac support.

Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 5d630affb4d1..373714f6e382 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -146,6 +146,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 
 static const struct of_device_id starfive_dwmac_match[] = {
 	{ .compatible = "starfive,jh7110-dwmac"	},
+	{ .compatible = "starfive,jh8100-dwmac"	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
-- 
2.25.1


