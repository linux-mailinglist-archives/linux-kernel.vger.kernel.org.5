Return-Path: <linux-kernel+bounces-19165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627DA826901
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107B8281E91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F79479;
	Mon,  8 Jan 2024 07:58:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2085.outbound.protection.partner.outlook.cn [139.219.17.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A08F44;
	Mon,  8 Jan 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5QEwplgeOnTyf7gf1fvbX4zuCFgUZx1pFb5aryiIYE5XC3HUeQOEjjLgkKI/8hhhUA82v682LzZqzyoqzsKULz/6mUa3OBKYbbJc5YMGmbikfniH75xrppq61WYXSeY6xnLwZ9WAtR8PuEMSVUEm5JAS39kIq2+bMZ8iQ7qidui04mzPgOmu0BZCUbsziNDqxuEl/sqh01+jh8+VQM5MyN42IhDsLa7wW276mQZu14JXtJ6eRGifd9EVUD4jxJFTSZR+1Eikk2f8crTg/hGR2y1YP6+qB90oHIqiEnaB8BMlyXkxNsAcJ/Ggj6My1nNYkN2iwcDzxlyuyILyVphFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17m3MilZ3eTASDMOJEaKM9UA4I44sDV0Ed4F3u8wJAU=;
 b=JLyj+FBhaImGEIV9s+ojTyerPDQzcjRZUXj3gNFXQlMFg3FETTgXzBBumdaDC7LiSTkfWJmsFFMNDzSJg/QnMr+l6/OSENPyLCYPXziAlnJmRPN34GpNB9YizPEtc83Cju8hKhl04CU2Jb+bfqw6XT6ArybJIjbHCrUDGYzci9yfEykaajX9qJsbsHwfOHmjj0x9qgNey7XzyD2K4hqZZLcbvpuwTJ9WXTiykh3iu8oSHifj+JOwtgSfsmVpQdPUxq8Hz5nhAfd2YgnsmBoDUnRXbnA0fp6AErK7HaMh7upNuViM++4/KoSPRvTXYlOFooiKOStZryYUSf2oknSRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0755.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 07:58:21 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::aaac:167d:8e0d:3acb]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::aaac:167d:8e0d:3acb%5])
 with mapi id 15.20.6933.032; Mon, 8 Jan 2024 07:58:21 +0000
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
Subject: [PATCH 0/2] Add StarFive JH8100 dwmac support
Date: Sun,  7 Jan 2024 23:58:08 -0800
Message-Id: <20240108075810.14161-1-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 6dc115e8-d987-457c-eee3-08dc101f94cc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RzItFQFe0UB7dTg7ydaTMpfhR8diVHYVCjdYEW74A0SAEJ3IWewp44ygP0618niYnHUdS0mrz+iXbsTUQD3yXZ8GxUGG6cV+9mXfYXjGiKU5hC4+FMOb3Hzd3IARWAQO8btDnfeh6vwkwYJDPCmofv8w+ESJcdsOsOunyaeLHpPjrTL8kW2MDlZ9vKoqUifYInEd2tD4Ozr9YupQ0sxwUVmixuZVCKMq42MW5sDPWyQM9nuvICy1hUtVnnVi95vlaE/PAQq4Ke7CA7AMvw3qI/ph1m/WrhZT8fjvWlX+hQLia2QKPU8M47bXV5cf1h0MWKVSxy+/4miUPa9BzN8/52Un81tknl9nkAsEU0IxFSehw/IPa76aaThyeD81Afjt/3Ij40tikYoUvpCYHwgoHQaRqkB99DFVZmzr2PQScXd/POF04mnGjOo/avgBuc7sYHdJovZydlkRhHEIS/W39a9ZQGb+oA4nRpQ76AOdfHR8QmRtH+6A3o3P5q5EObL+Gc+AKFCt+XS/2JU4p0J+9RGTA/YDDK8HjZOC7m0aCj71NJPg3S1p44eoZ2Ut9pwZciOvlRt6WRbLWlgwXu8qwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(396003)(366004)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(1076003)(2616005)(83380400001)(38100700002)(41300700001)(8676002)(8936002)(54906003)(110136005)(5660300002)(7416002)(2906002)(4744005)(4326008)(66476007)(6666004)(66556008)(52116002)(66946007)(921011)(508600001)(38350700005)(86362001)(40180700001)(40160700002)(36756003)(41320700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+TJDvCPjFo3QnirsGTZUIoiioof55Nwyoi1gdIdBFEXyUW9rb3ZeT9YTQzwG?=
 =?us-ascii?Q?Mtm2w3LtE4adw8eP8YnT7uPf2BimRDeh3pXZTDdG3hLj9wncFiIuQPgxK8Up?=
 =?us-ascii?Q?aHjxwb5RP07UZc7Qp7GQMHMjClYx4DEldzFZkl5Cq4aYXFTjxWtgrjd3Lz+R?=
 =?us-ascii?Q?ZoyZd//0Xv8vOH9gPxaEXGg7FoIkk32ucnF86n09ArEXGTY1juV3cz48/To7?=
 =?us-ascii?Q?QaP18p27sWgLhzWl/Pjj/LSQDBBjf+DpeMlCODxd7Kd3hPXn4ZZ7DBnLWN3b?=
 =?us-ascii?Q?59HQc6UkwdeujT4w7KdLeFXrhrv8ID71wB9Nl27CkDNBBa2p6df1pkbQO6Uj?=
 =?us-ascii?Q?p5DTutAmGvm0phN12nF5Vvx6Q0riKHlLhwr8KS9oSIYKGdk6SZOaxve+/uLQ?=
 =?us-ascii?Q?JMCJ6TWfjdHdh0E0HP7vu24LhgDhRYQnjZEL2ZtTWAhyovtp4a8TZeIOxq2u?=
 =?us-ascii?Q?VTtSzGoXrzdgXLOKEqQyRLYixO4XVsuw45R3K+QL52YsfUQwIbNPZe3eaXeU?=
 =?us-ascii?Q?X8fs4Ts6BhG7uSz6R38bBnzXeLNaVTwb4d2qqSnYSWZ1Y7RfuYRK7Y5qY5n3?=
 =?us-ascii?Q?zi3zaMD5f0KKpVtEa/zM1Is/8HEhNX/EumfJSYuvb7QGZ4101tbUN6boLgfw?=
 =?us-ascii?Q?/Nlw3oBCA5TUl1uTdKGm4VBsjdgE09uPS3RkaYSQt2Yx7mlQ0qncGKDP0OHw?=
 =?us-ascii?Q?PEhQxen2jJchk3oTtVNv6+2oQVcWxfNMh2MzKc6LvJAvtLUjHEhdHQN4cjbk?=
 =?us-ascii?Q?ihBVEHjAIiGS5Tp5VQDjM25K3jBThTjgcMTwGOWWOSXxfVSAPxyEAJUnL0BW?=
 =?us-ascii?Q?SVv6JS34xvbHqUPgM1P/okMXaWjoaluNn8Alx9JVX3UViHJ29QHGbiBwqmtN?=
 =?us-ascii?Q?24rqyWcXZlDTLVU3rfBQfYV2dRQv0Uv1pbNcEM1uNxVBB22Kc8dKfVAx/pfX?=
 =?us-ascii?Q?gE3Ki6+OxEeFxwURMHtbYJ0S5g9CE4e7I+32x29IksXh4QQD/lF6vXEu8NCM?=
 =?us-ascii?Q?923COML0Kojrqjxal7GWSLpZd/uY5To2o6FjavsEYjVBV7sDEstBw+l/E6Pl?=
 =?us-ascii?Q?3QKT2IgGWHdAW4/NVCuDhQeFIqXsoEM9fAzVxJrYy996i7OJ5UYmfPRVt15g?=
 =?us-ascii?Q?RJwiANdboB3Pyk+AeVqsU6FbTlUGuuOe/ZkFL3L1tZQcPIsPNIbTD7sBwJjZ?=
 =?us-ascii?Q?Delr3hYCWT6dLo8G7X0ZCmdajSEiiq/wWC+vSb17VE8dzA/dlb/mtIfHa2Pn?=
 =?us-ascii?Q?QyWXO93tiOrDvPJxp3wDerfNi0h5wpVLlWZ9f9CPWgW6YzOBnM5aJjllfjNu?=
 =?us-ascii?Q?4d0OwbWat9/DCtEWiREqwzfi06CVq28OTfFNdhqXvk0mUAVedqsnwPNzZMA+?=
 =?us-ascii?Q?IAFzkjDReNEZr1vuAXqw5knpnoChNyfdciMX1Rl0Hpr7FLH+wPbJF5fClTVf?=
 =?us-ascii?Q?/B3C/sUJMfg8Xh2FOLGq93+gdmnJ+uTPij7xXMWNkAmfGneSBZh83uSDdrg9?=
 =?us-ascii?Q?JI/03A5PQiYQwrFKsIhHGgPwwVI5OWQfanOLO/LHggLXF/SA3T9Vc79t31+l?=
 =?us-ascii?Q?wEgnrrh7CgGjHtBcVXr8W/8qeX0wj7m35wtPlp5+x+MD/NSsgjJfj7ck3vM1?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc115e8-d987-457c-eee3-08dc101f94cc
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 07:58:20.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1b7Pmuvb6qIIw5OWOT2Yw4npD/lT8S8WuNYsba0TDCEAbNoP6JAsTkox/QLXJuqnmDbr++J5cob0RXSlB/ZVHd342VNzgN+TjvKeLIiYHMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0755

Add StarFive JH8100 dwmac support.
JH8100 dwmac has one reset signal instead of 2 resets as in JH7110.

Tan Chun Hau (2):
  dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support
  net: stmmac: Add StarFive JH8100 dwmac support

 .../bindings/net/starfive,jh7110-dwmac.yaml   | 28 ++++++++++++-------
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  |  1 +
 2 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.25.1


