Return-Path: <linux-kernel+bounces-149707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415E8A94D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E0A1C20C19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15EB12DD85;
	Thu, 18 Apr 2024 08:23:22 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2125.outbound.protection.partner.outlook.cn [139.219.17.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507315FEED;
	Thu, 18 Apr 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428602; cv=fail; b=arTjhTXrZMq78sbd16jEgjHSbK6Uv0RgR4PLO7GrrWVijf6GcbnB9Id/EaVFnxdCQB3mxmFf4aC+DhphhWvNo1NRUGuafbSs7t4K/fZQdfNbaAaR+QFcEeJVg1WsfrrhS3wuqJmnRODK5qf67Cheqlp6LMi/e9iLJ12D/JPX8P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428602; c=relaxed/simple;
	bh=xJjltQkq6/OjxpJgmseY9RTa2sNkk3Csbr85pW1+CUA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sPsBBhlPLiG9dUiwznJigH2nX+Ao6f5zbT9ar6ecf1EkWnWbDlNxCULJ1E5tobCb+I1NA+JrvQa7SK6uaeIficVzilOFgjzgfuxKJifGxKm80W2sQCOc3kyVhHfg243MD/ER6NhAGOT+v52UF8deEy51XDPdCuim7sp1xJIgkek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUBB046rlaxVvdgLb2v3XB1zoZolfUX2IFvwJDKlWiugru2iolwtoo2zApdNOL4/mFrVXTFJfWYEjQppUgE8PpWLGd+Ivlqz6LaInicT+r06nmOSJBRhsKCYacHUIwLOOrnCn1kS+7czs9TYFfUNWvqztl74QKtVxLpD6Y+ccYsSRRsQ9abWaW539HEI/gP+hFilBqkN9Zo38RKQHsYBGO+vyvo5Bf9GbTyjMIhHBPG71xGaNZlzh2UbxjXc8CXgnoBNHYnWH8rkNrMIKWXwrE4M48Zchj4biKJqIciTiTE9qzBGrgcIaDRGD2tiF4KZTUY2zzxrDMhzmVkHQ6GmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNv0XYTAuK2gbD9fA/WE+fPExIotgIFv66Pt2Y4CS5Y=;
 b=khAfQ8PGaAaqI6WzhIrTjmj9u6K4dyi64gEUw83R/Om6CAjvBH/MKPGXqKI5ePAyuzdv348+C4zZdxup7AbyKcQpRH8PX+uj4WtRgKIgdpRs0TsKAX7CSWKdnHwDH/3ZnXXwlsaTW/KYjG2gUSSCoknNL0nw4b1qVmH14lDd/mjlHrJAn1ahTddkbY1MKihZJh5pKsfoZs+uVZy47nmeXTm00jpAsjL3e59nMr+zzgmgmamxTmnYeOGtBvKUQI0v8kLW+MXvcBodL9U74pBDTDjSA8khc42LRnWni/AQDz82oa+cfQYIBOGNvdr4W6bF/9iytc01HsuORJ7xeLd8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB1071.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 18 Apr
 2024 03:50:34 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::103a:5792:ddaf:4283]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::103a:5792:ddaf:4283%4])
 with mapi id 15.20.7409.042; Thu, 18 Apr 2024 03:50:33 +0000
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
Subject: [PATCH v5 0/2] Add JH7110 MIPI DPHY TX support
Date: Thu, 18 Apr 2024 11:50:18 +0800
Message-Id: <20240418035020.47876-1-shengyang.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0036.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::13) To NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1070:EE_|NT0PR01MB1071:EE_
X-MS-Office365-Filtering-Correlation-Id: a963dd02-07d2-4d1f-38df-08dc5f5ab32f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mpCSgAXvFu3VvauFTAOFlrD1N/i7M90duS9SHruQIgAve//Jh7zgYzSZjpHtTTpWa2WdoMnaJVpAYtwOVJPv6jVEEqGFEqk4XV5K26ovquw8OwWUIzcW+yJXjEtZvxSW67JXtmO7jIkr0zsPhOLgLTmZTWzqXmHJjkE1SvJYau56n5NkoRJIJEu/DQPKM4AxudtbeiwQ5VAYXdNHZde/NrjqDIQGggC8Vc0aloXwWC/cApkq7ppSauDSfT8hJ2KN5AsEjJ4Y5iAmSNBMHBKPCcIysMIP3jmtXCD/BeeuxuCdp/jd+aIJagnYrWzEvD1T/bVDcI/ha/YFycLoPiriEy5r5THziQfJUV6I+0ICGOM15Oy0SGIVavPrQdXgdII7dQMYJH+sIunAAJGFpq/UPULnPU8grLXjN+qnTFt6VDUdwwEiVqBbuDyOmNoU7hBBpOsSN+EFUfVcuN4H97ZRDVS4YJQASTd8au8YWqnh7gdvn8jkGkHSV6V0+5otfRvMbm4L45QxSW4T3IxSZTV8Ce2jmFsmglr6QmoCpXRCcBX5wg0aTGPG0N2ToE6GcU/dZjuRAV52HMjAhE1aISyu9BwCrSU9c9Kcp34OoRjA6q84aQAzua8EvtbectUqBzsE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NDxPCyKFshGTRQSaqFSit5GBO7O8x903KMiYFvH/K/XD5BPdz4DUxpattV+h?=
 =?us-ascii?Q?8trCD4ih6g2tObZwqFiSevbDzXNDY+dkuzxyhf706c9+CR5sAQekV5BAe1/M?=
 =?us-ascii?Q?NUMHQHTBcq0rcSqk1qlTYiY+xBNjSyl6CDCX3w5mJ4Q8wXvHN6BKHMwb9Med?=
 =?us-ascii?Q?Fna2NJk7PSfE1iqc03UVFPsSGjLlZB4+kX7KwfVIR+IA2fdaSOQEdOJaI5jM?=
 =?us-ascii?Q?i8YV2/e8QtXCIo9Q40SdzsfiTUn7nj4GagHCO/JRzhJtwRAzDO+x3XaDphCs?=
 =?us-ascii?Q?IKIRVtU5jweePLUobEj+FFxV07XYSbmGd0J/VDEStkaRw/rfnn6KS+9mkkdO?=
 =?us-ascii?Q?d5ta/Oiq7w/HjdJxqEUvFCDBvgbzyR3SiNPAAI4xJ8DOjt8Y9af3Ci8SxAuy?=
 =?us-ascii?Q?dBcJvutbk8vmmpQTHKC8kHIWLPLVmmbNgeK+s2ZV2KhUlQBcDR7hIG92k05N?=
 =?us-ascii?Q?dgHworIXRZtpEmQ8La6xYgjub1LZ6B0DfUEpyXnUjwzRlgnlwhmApLlBypCx?=
 =?us-ascii?Q?fN6rFFnQT232UhVJYtLBVopTSUmuo0eqy5JclSX1RgiWpameLgQ5Kp8q3RJ7?=
 =?us-ascii?Q?62FUWA+wf0mHQlNsQGJTmQ6fCan+gn6JPkjRDxDnHfRCgzIccjPWv4AvGcI0?=
 =?us-ascii?Q?WErZvh4VDIGWjETC6UgOMmSmakvD5PtkY8zMA+2YXF/aUDnHWT8A5C5NJF4c?=
 =?us-ascii?Q?eBxdv4KOUyGGqsb/yXqpN0fXdBurT2FeCHrd5T1ijQcb7jlLT3tSDIjbCrqc?=
 =?us-ascii?Q?VORpiwlECUi4EaUCC4s/HjVZR014Yr1kb8VkYHX7HFHmLrDvprSS7HIcRRgW?=
 =?us-ascii?Q?XWI0dUUQLWG3QDbN6ZWpGXmquJi47h/rvP2lVebstlNkPs30oja/UB5J1HME?=
 =?us-ascii?Q?mpC9XwgVUensGRPY7daiG1ClzSf8QYO6IBBwP2PmS+sjtfUqegV/sDokQuW5?=
 =?us-ascii?Q?dhqQAgj6zDqQb534HsT9vXdgrdMSq0dIBCfHHzkO06fStyohC+HdJPsHhiRP?=
 =?us-ascii?Q?gTuIM6S0ZbSjS2dQ7wAMvPQhIfDrZpGabuXwHLrSPyIhFwlRBdFi0PwncvOp?=
 =?us-ascii?Q?pgzYNYHlacs1tzoXJRblrFoVq5blNPRj3ZsaBYFyQOlfHN0aonqYMRjugjL+?=
 =?us-ascii?Q?y8MWiG3sjXEsCDHPF3WSTg0XMYjC6a2+FIU7CXmr+B5192PLOpNZa1zqcnjS?=
 =?us-ascii?Q?M3O20wiY+0nrh/M0z0dRvxvaxdozkZaHv85CB+C9j9H5slUKVXhjIzSCYdOa?=
 =?us-ascii?Q?o1yF2BCMkwkkQxqkHv5bqPqb1z9QhjHCuofHcku2jFDa5E9FrYpL2M+kNjE7?=
 =?us-ascii?Q?w1Ef0U9eu4Q5ighj/m8pvtV3nGCLpkh0JoNKxqLnIM4LVJ0DDhFjRBkydjKC?=
 =?us-ascii?Q?di3wYJ7VFHuahEajW3bMJVM++9IkgfrOKohA4/cj6Ryl80t3wTGRC03SmnDe?=
 =?us-ascii?Q?/gkjof/m86IijoNiqbsZ5Ppbw1pKtcQEHpinAChY1KUfROG7REUgOf3RIlHf?=
 =?us-ascii?Q?6ycVFwgS94KV2s0b4g7681/c/7w25HUCS4r0B1IZvu87BsVxQNAOqRXT2407?=
 =?us-ascii?Q?Z1iBii8Quwaq1c+nsJc4ImbmMmET7xDNxaYkZJv4XPFMPDnR8RMIRqkt+z5G?=
 =?us-ascii?Q?KGSoZHvdoACEFhKtjT7yoI8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a963dd02-07d2-4d1f-38df-08dc5f5ab32f
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:50:33.9022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usdba8WN/cqxzbJ4qYT37ZRPcYBFsXgDWzyM20bWR4V/TIg05YcPgNgtgZxNeXrkGjvzkxULUBwkeQYo07PUNY4PRUdBCp/d0mHNseDT0+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1071

This patchset adds mipi dphy tx support for the StarFive JH7110 SoC.
It is used to transfer DSI data. The series has been tested on
the VisionFive 2 board.


change since v4:
- Rebased on tag v6.9-rc4.

patch 2:
-Drop shift macro definitions.
-Drop useless member variables of config array.
-Drop stf_dphy_set_reg() and  stf_dphy_get_reg().
-Add readl_poll_timeout_atomic() for delay in stf_dphy_hw_reset().
-Rewrite register configure logic with FIELD_PREP()/FIELD_GET() and writel()/readl().

v4: https://patchwork.kernel.org/project/linux-phy/cover/20240301012406.92589-1-shengyang.chen@starfivetech.com/


change since v3:
- Rebased on tag v6.8-rc6.

patch 2:
- Lower case for hex value.
- Replace bit shifts operation with macro definitions.
- Drop delay in stf_dphy_hw_reset().
- Change variable declarations order in stf_dphy_configure().

v3: https://patchwork.kernel.org/project/linux-phy/cover/20240206061921.107372-1-shengyang.chen@starfivetech.com/


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

 .../bindings/phy/starfive,jh7110-dphy-tx.yaml |  68 +++
 MAINTAINERS                                   |   7 +
 drivers/phy/starfive/Kconfig                  |  10 +
 drivers/phy/starfive/Makefile                 |   1 +
 drivers/phy/starfive/phy-jh7110-dphy-tx.c     | 459 ++++++++++++++++++
 5 files changed, 545 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-tx.yaml
 create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-tx.c

-- 
2.17.1


