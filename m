Return-Path: <linux-kernel+bounces-118375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9A88B9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7446A1C2F767
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2A12AADE;
	Tue, 26 Mar 2024 05:39:49 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2102.outbound.protection.partner.outlook.cn [139.219.17.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27F84D0D;
	Tue, 26 Mar 2024 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711431588; cv=fail; b=IDAeb/DlXZQNXzu8HeduG6JEWRzEmjPPR48oYMt0EMtHiHNwqJD50KLQqDadiXyBpyvA4TuO4fFups/iadrvFkMLbAO/dOMpNmrUDDKCYbnpeFoPATWCBYHzqzZLFUzvFRaCUNm9sYFGsIQ3NVJlVMCBbILxENIN66Z4hlg2axI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711431588; c=relaxed/simple;
	bh=MMN/ZPPKEsrjd3JhDmwRBdNOyFiWtcZuHUegx6EbT40=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nt+whQrd3w5qyDrkJLj2ypBxBasDIjMx2J0vCls48BbZuzoFulFAe60Sy4AeRTiWnMAxiVUYrbYyBuSsI0xn3zvdsE5MWaxPGxeX31mOwdd6Unn200nyrXDp4RaISl40GnKueKkv42itAP7NB14BSouOAAophoFY5J6tMTRF+Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9xjUXLaRZ95DXk/n+DenLHYjnozbR6E+eCgYzFsfd/5AAueupH5uP/0qaXlphxK2eeoFy1c78FWgARbEAUxv/IFPCw87VWxua22bpEfRWpMl1FnF9XY/Gk7hQiieXT1iy15v7PcFLgolKbMlCXlHL5w9gc7RoTxpO84Lv2G8IoMKE0jPSi8y2jwCK/WAmwsxkqJY34YB2xg4AyuHMrXwtpbR7pz/k3Tk4HG6m8ZSUC3dairZsVUblz/7Iv1sOP30Jzgu18JjjcAekRCoY5ba2v+C/j43qFM8ePq9c389T/tz8Hy9IhYO4OGBGWdQkladF4Y7NJsn+SXIA2WMOy+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu481GbDQOAMUI/Txk4dV0C3QaN3pcCTWtAMwHbcPY8=;
 b=KmfyM6Mweq91yXkide6uUDe58M132xrO14G0xi5NEmFvZp946FUlkOKOwIGLM1/byeYcUa4rka551AA6f3YkFaauXJkY3gADTwIrn0k+2qgxueCtwhstBJadqHcgPXsx30mLzz13h6mIEoztv9QROOCVoVnoYHy+QSm3NGAItqSQQhAgPK/1iZfifMwDD3exSVH4Z2kXxssWhzUiiipLBWiac1qmh7/S/445jnk/b5KevgdVUKdPEF0gnyGimXS4aQdasPEFjT+xpjpcwRyiUgO/LBMyq8c7UrmaUP7fywIuP1Hrst0gSOgpQAkP9vX9NP3WYSJX1Rxr/XlHLtgSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0883.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 05:25:20 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Tue, 26 Mar 2024 05:25:20 +0000
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
Subject: [PATCH v4 0/1] Add StarFive JH8100 dwmac support
Date: Mon, 25 Mar 2024 22:25:04 -0700
Message-Id: <20240326052505.197408-1-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::7) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0883:EE_
X-MS-Office365-Filtering-Correlation-Id: 866495e5-f201-48cb-628c-08dc4d55213e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UMIuReW/lplZFzxZK/1v0lFZFyoFOORr3FKjThxGMcxkA8hX3ljfrCZQ/aKEGGFoMzsnT60LnUmJFaY9lWKvqTJVF1em7QZ/KFOc7Ip5+K9flU1FrwucV38rRq0AZN60S0ozrtbK6PxYITdpbJkGKVbIO87stwHE8g05h4yg0JP0ollXYwZiiR9aLgBi+UjoulUNSAKKIGGq+6vr74QiEHYNZ9vA+d8cshdvAEbBvkqfa7DieSF/VgvgRzlUY585hQ2hBZqg79yFeSWBPqXwdsD8lz3yHfSUuUBkDXLKJpF6ebajYE+Rmbliw2aELm9zMC0vst7Dugyh/qB/A3HQFKL1xk0Nz0oJchQtZnhrgfIZPQ76UZOmn/FSpqFyQ05Dtp2IIaBomy5yvb5KHc9gFjD1h1tXCvuJCdG7alCmCWiPMLzwLYgg8cKpzNtEVoEUCzH+DyohM45e3Q2weYUTkglGaun4wLn82nJukHd5abprwkbW2w0vpytmlWe1ODdPNAyI6zjCbnQ7Fah9aX3fY0mBmGJ7Qpxs1REHWBNe1H5a/8OXoCU4OoNBlRQhUiDKBGZTTqc+JrokESRKClm2KZIUvpNfNunjLbiKfx7AKzPJkFoEEwhZa6QQrMPLtrYTLATNrrERTUARCBbVmDpMrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(1800799015)(52116005)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3HnbofnJKYnfoj2T/AySI1BuVlmxiHHwQJh/ey/IrLVec8RjZlmZ2J5vwuZ?=
 =?us-ascii?Q?2OuoTGFOGTqJdOqLnp4PCObuq3IPep2JIWeA52zW+IR2XjITMo0yRzc0/q9R?=
 =?us-ascii?Q?EoHOByJpq2VV/BsXxnt24K7gtACGtXPB6fL8f5741424hoH7kGUUOoEKgUwI?=
 =?us-ascii?Q?ot/9SaP0Gw3lzzClijC4ZvA6LdT/cYF6icoEWGKSEh4aSk5UObJfEiZerBPb?=
 =?us-ascii?Q?wEBgJ5ayAUBLM+KuOjGy0iY2wya2xvvkULfsk5vXH+XKJuW5YW25FwrqHqzq?=
 =?us-ascii?Q?+8knZ01/TOrNbGbLX3bZ2/mXjRhuZHWBZUN8+vh3Kdb2HK6140Qu5TvaDPPA?=
 =?us-ascii?Q?47Lk5mtzknin2vWZCkAcgc5nDBFkGFiWXhN4ZgMzkOMoTVhwy+7fZRfvSpma?=
 =?us-ascii?Q?Mbplq5Xsy+4CazC/ceLB7LfMfm0WsV4czrbiQDuHHa4YmyjRQzT0hRbpV91R?=
 =?us-ascii?Q?zK+vUUxMWar/kYz/E57UwuaGPpT4uHU64XgXBemrootkQN285d45u2nWpypI?=
 =?us-ascii?Q?UPQK+NrZKyG/72pjza9id9YQXzL8zH75FMO10dE+MiBBp+WprGZHNP/7PSxK?=
 =?us-ascii?Q?im2Hc5C5F+kFbjPsIHHUsNwgPe/SFYF4a0WwC/ddTV8KzGeBuXAR0tTBfMyH?=
 =?us-ascii?Q?dwI0P+gMmQnc8ABEqynVi+XAr21oxJizBVv78FGGXYlCU0z38mo2qn/5Ft4S?=
 =?us-ascii?Q?o4AIqleSAfZOoyMTk1DeNeii9Ss4k08237oUxBHaqXg/f0cGgx4j7FQ+jnKJ?=
 =?us-ascii?Q?t0Pc5YxFjIN86hxrSN/C01k6DOU1/ALqnqTRA3+pgTd9wYzK4sRukAF11zu6?=
 =?us-ascii?Q?2anKhEaV8r1edMrWBwOJJc/yyuyeubHYdssPE6Rhq+NTiJNM+3Nj+IIHqVak?=
 =?us-ascii?Q?zPf2fvb8KXUS201CEEOHxmJsHbsAI+JI1iWhfVTAUeUkpaYqf1snF654GkaT?=
 =?us-ascii?Q?PIKaYufnTFXDaFUnXlsjy2N44sTFep1Qu9q8sYpywEPGUxUzYZuz/deLbA8h?=
 =?us-ascii?Q?CVd/Dj5U7lwSVfEcRXueS5XKf8EQmkSJuvVVppqi1F1STKQwUFExNHSlq0GA?=
 =?us-ascii?Q?k6mdowQok8cjS8D6nB0TLZfhKKT87ksXNclONFMHzx7CE79jx2IkWRQkoKzM?=
 =?us-ascii?Q?PA8NnDgd8JqWlEY348+HSx99490UM8Ge0MmAsKA2Wo3krnCbrSqPBgaBxYi7?=
 =?us-ascii?Q?eK7J4AwCAWWS5LkIb/ztIclXwO2T4dh3rMTCBVUOnxRgdriDxACdMk6R4/Dz?=
 =?us-ascii?Q?4J2Gyhaa1/Ab7hNAq5AnL0KjuliCfc17Cv+CaHnyYUpPzmnxZCzpZ++q6zN7?=
 =?us-ascii?Q?PLW2DVFlM1IZmgi2yb9VkMzkR3j1/hG2Pdal3f6eyOHBNlJRncT5ikQKu+5U?=
 =?us-ascii?Q?7nhJ56QuqpwVdPIjMW6+uMPk8BZmse2fQGNu49Lsun3lxl3L52cTCVlUkZ1Y?=
 =?us-ascii?Q?1z8PHYHxdr7A6PJTSPeWjpXcUkmMgjFnj0dlVw2maC3Us3fARO1GPSlnFeOQ?=
 =?us-ascii?Q?+JIDoOuiFbErFw29dLEF9zlyxMGAJAP7MuCjJObYAAHDjiauGFc9jCfxkDPR?=
 =?us-ascii?Q?HjoR/Uk4T54jS57t+l3ChF+05ehMvzYvbB3WnoXUQyTbbOlRVPIXcyb9Iely?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866495e5-f201-48cb-628c-08dc4d55213e
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 05:25:20.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4up83wgePzvVhLatXBM466xKqPjfZ+D8i4cpsEjcGIj/1U8O4AkULNx7bomd8RJ74Y7+M0Dm4x5oyrvFPgL1sUlF4FwdDFCW04AtOUH1q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0883

Add StarFive JH8100 dwmac support.
The JH8100 dwmac shares the same driver code as the JH7110 dwmac
and has only one reset signal.
    
Please refer to below:
    
  JH8100: reset-names = "stmmaceth";
  JH7110: reset-names = "stmmaceth", "ahb";
  JH7100: reset-names = "ahb";
    
Example usage of JH8100 in the device tree:
    
gmac0: ethernet@16030000 {
        compatible = "starfive,jh8100-dwmac",
                     "starfive,jh7110-dwmac",
                     "snps,dwmac-5.20";
        ...
};

Changes in v4:
- restructure content based on feedback received.

Tan Chun Hau (1):
  dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support

 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 54 ++++++++++++++-----
 2 files changed, 41 insertions(+), 14 deletions(-)

-- 
2.25.1


