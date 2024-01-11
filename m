Return-Path: <linux-kernel+bounces-23000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4079D82A63E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955E7B2728F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34FF10E8;
	Thu, 11 Jan 2024 02:55:56 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2084.outbound.protection.partner.outlook.cn [139.219.17.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0325663;
	Thu, 11 Jan 2024 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ww4igYk6QENc6wCtfajSrI0F1Q4/NL2iaVXvEjsfM9CG/5aITYYVuCGDsdHuR6m3JJ6s2wSWH5tVOyOn7OmONM5FhTbrJlfRgKW7ilz5cGtIptG57QCWRXKyW+yln3v2tbY/K3eUHvcMLv+MD0ZbqVJyAFtWNwpQ1ROq/Q0lpnaN56CQxi0k8mIUcNnG50UVAfih9BV828MZeQLfOt80p3A1kwT4XED4h2TO8h6nTshIzFEzhYkyKdGBlYKfW7TEegtZ+Y+kevFn0JP4L7yhFriMPX0WtoNzHC50FvPN5dgOla6JeZKlSD2mfqYfwN0mPTk9x5l9ECxOW4+mSK8aXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwwDBu0gXSi7M/F3xxe9Thhq9p3oLgAJoRlVEKQgPJA=;
 b=RawMjEYiC8qGZRTdeNr6RcvAeVWrHOJa0fS5oi4y2tqTLdJU/jqS+BCG1lisV6NFsLIq7T9WItGOiMfFOnuYhkNsk0JL4Qvcuo0OoYQJO0Pcyup2PPnpPIjEZSXSNojdzp2cvYPvXH/bdBEfoxvvYBKp/kqMoShYs6JNF0Zqdd6npBJ1SqFNwkEo8trWwcX974UkhPc2qDJS1QYCaSPDunAj8fx/93RzkWGbPIu+zGrI7bhsZ0uB4TAVXNtXQJ8ccvQxVYW6GLVy/HXy6taeX7BRmro4Ne9XXpqfSKwG2itBldf1ELA0iWbsKo8W7JYvjRAf1QFvjbrrb4ir9bPtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 02:55:43 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::9fb5:b2ec:ed6f:b0a4]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::9fb5:b2ec:ed6f:b0a4%3])
 with mapi id 15.20.7135.032; Thu, 11 Jan 2024 02:55:43 +0000
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
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/1] Add StarFive JH8100 dwmac support
Date: Wed, 10 Jan 2024 18:55:30 -0800
Message-Id: <20240111025531.2875-1-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0064.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::31) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0561:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8d7af1-5342-4f3a-28e3-08dc1250cd1f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VCwKSiEpkl5zZeCr4l6L29KBI83xVHGRZ7vAeTFnVhLDICL39/CbLN6XT2pzyFDfgoU1EQAIvBEkqJjwgEA96wXwG2wxBcx9H7E+opXawWbW77wb1PqbANkm9Ns+MbmBKCj19Khb19v699TlX0SjckXmI0we5sEJenPlPSD+wEsuWRhQ0SRGURr6FxvN+VoHmLYEqxliapkV3soD5NjG6nVDE5kizsj1unkooZ/00DBUmR6RTPGsQwRAFUQoWHBwHrYQZlGNkXEsN52DqESA5ApvvJJAJTI+m9saE4n0HmcV8kQuLCO/Z/pZp6gVwLdVeFXPfJ5kl2H1GuQWt8NiF+kppNZldLwkTawxgxDcUOxzVIzWwf4OsDvtCrcQTEPELfe9p8eQsxO7ijR9E2ihiJkB4wSSUZNthDRyJvQ+2jfaQn9hWpKlIUI3STqfRATgFpZRUicvJzu/quCxqmXIKW5N0ZhtI1FIr+83Su8VqKN+lObDFH+JvkMgChe2NNv9t85G166hgJ5wuU/UG/RSSma/mbK9n2q0YrVn6aRQvpZS76mQ0XuzIbdVgaDvMsWy+xqm1e5+nqWU7wu9vQ4dpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39830400003)(396003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(921011)(38100700002)(8676002)(8936002)(6666004)(508600001)(4326008)(26005)(2616005)(1076003)(66946007)(66556008)(40160700002)(110136005)(54906003)(66476007)(52116002)(83380400001)(41300700001)(2906002)(86362001)(7416002)(5660300002)(4744005)(40180700001)(38350700005)(36756003)(41320700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bRKKB0PNmIM1k2pc1kvGixo8Tx1YYxsonn4BdcvipIxOMz4OwhZczm2ypSx1?=
 =?us-ascii?Q?ID5i8i7gCvgT79Z0QwY0j2ZLEn7LQoOAIeadZwzlXuM5U5pT5znn8O816kKZ?=
 =?us-ascii?Q?TE47a5CVnxv67yw64mWpVuvS9PTZbIw3BHqtDTlb0ekKQ5BwVBNh+LAVzAzE?=
 =?us-ascii?Q?UKYQqrphGfI7mfBD8jdmgM+hX5R/BfzD2llRgGrJLMLh4YhfyLv19H1tFhv9?=
 =?us-ascii?Q?/YDXaUZ1rS8G8risKRnEIbFBUcvDssWslggmJdnpN/uI1a15eXbrQYn4SeqL?=
 =?us-ascii?Q?/SZ1xwwbNp20huZfeHUklsFZdhuH8j0qMM4E8ybe/0Yst5i7ytS+QLbycmNr?=
 =?us-ascii?Q?jcJBTeIwP5ziStCuHjjR/8JYodFI9PENcJvBkBb7lOTL2CaswokLVDuEP1yN?=
 =?us-ascii?Q?ZwEzTg6Xug6ZTg/TiZDYkVrLo/y7e2MWWYbrPpjEPwyxwstjXy6D0RQY/weP?=
 =?us-ascii?Q?1/qisnXokfocG6EGJDkctIhnZff75pg3IDTb26/MApGlqvr1AsWf6RqXz+iH?=
 =?us-ascii?Q?WxUkPciJeFAPvy7oMw4gjVFtQVqeM8+3oA/6781dPr/hIQM6ek4ZmCkjSZ33?=
 =?us-ascii?Q?s6MW1DpppepAuRaVqBg8McN/D2Fcaj6mU0jGFr9OVFIr8hNxJO91rne4v4Hd?=
 =?us-ascii?Q?qrlXBJ5bM+kA8eFoZ937Ob8hyLXWw+/iHCRNt1y3jECrRD+2u4l5spqLja7A?=
 =?us-ascii?Q?+fYbVO55kiNBIwptX+Bl3MFe2thIiTBO2y2cT1e1YPBenCsouKly6REgstyn?=
 =?us-ascii?Q?nfpwJqhkBAFEavFQFnPSNJu1ZgosymHoFUQq9Ti9K2+BDWlaerADLbxmxKoA?=
 =?us-ascii?Q?J/uVTmmp8fbuDd1p4GJpT/ehcwU+wA+Uayu1NIPaLfQ+Cfinn7wJQfhA8uQh?=
 =?us-ascii?Q?o45xdnuZB7Ei99BYQ1x/HDy/gV8//vD4n3p59j4Vs3p5YXcD2/28Z/Cbpx63?=
 =?us-ascii?Q?GL8pTVk9eo71MFbECYOySzfSYSN5PuINAbJYGuacJUDSTmNT3wWHYNGeDcf+?=
 =?us-ascii?Q?hDkwmJQhAp88d0FDQiqk1V+gIH3MBCqQC2zW2zUu9+1CvTrg3yGHKxDNXqDd?=
 =?us-ascii?Q?yfbH4qDQw1b7dEIpP05TATLYpHnflGF95uWhykviGVNEMzLcCauJ6R3VSuz5?=
 =?us-ascii?Q?BThNQPNwpsDpzIyvOdT29c7PXdID2qFbbF5SInNhKHKRhN0kWW5pVPWy3VFM?=
 =?us-ascii?Q?7CMw+ILqrXYv/sUwFPn77mYW9D/uIEE7i+iFSrwaFaRtxxnhPGfjYZjIrS3c?=
 =?us-ascii?Q?WBBJ0P675/j8FN4KoeHiXQOwi6mTXwVTFcqkk8qn5BO0lvM/n+wSw0cgK349?=
 =?us-ascii?Q?GBPrZqqvmwXUHf4UmDOUTJ0Ja5YRrrzod1sghaanENjV7ZgOouWsYAAWiPw4?=
 =?us-ascii?Q?KYrrBUhGIahNSvQGOWUs5m2MScuyBHhKmSh/r60ff7C0+3t0ZRvk6nw+ajfl?=
 =?us-ascii?Q?/LW08EqRwfkXEjSrCNve18qwttHkRO2wG577RKe8xKTlDGkNfxo2GRPptAe1?=
 =?us-ascii?Q?0GocD0zzjomLGk2/K+WXC5KUJo+sVqwv9NwTc6Ta8rVt8Ce4QU7M2B84tgm0?=
 =?us-ascii?Q?LNjImjmKlAn7DCmD11WtiC4cuDOjvQF+ec+beJC0R/+BJ5RMU26tcyK5umU0?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8d7af1-5342-4f3a-28e3-08dc1250cd1f
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 02:55:43.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVdMeuuvY2FBAeRuZn8H4s4yFxMfmHTgpwXjwDEuOJFHwQVAlfzY4vG5cNaL30YtXfDl/ts04vCYUS2RD+l72isL0l1Z2hJOtfo+2OTHsIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0561

Add StarFive JH8100 dwmac support.
JH8100 dwmac has one reset signal instead of 2 resets as in JH7110.

Changes in v2:
- Drop driver patch.
- Add missing "starfive,jh8100-dwmac" to snps,dwmac
- Add handling resets for starfive,jh8100-dwmac and provide an else condition for others.

---
Tan Chun Hau (1):
  dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support

 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 50 +++++++++++++------
 2 files changed, 37 insertions(+), 14 deletions(-)

-- 
2.25.1


