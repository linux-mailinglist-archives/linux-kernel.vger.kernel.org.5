Return-Path: <linux-kernel+bounces-116735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D661588A31C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FAF1C39ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ED113BC15;
	Mon, 25 Mar 2024 10:32:35 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4FC13CF90;
	Mon, 25 Mar 2024 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357677; cv=fail; b=iKrMOvumAkHXiGq0DDSz99G64QiJ0934JfqJM943WPJfF3T5zixxyc0s8CjQBxl8XwnXu/4GAfslkI751XxZlUixPsUSKEWuQJZVVvdvKr4wUoegEM/LO3Or1NqKjvprSurSmC2zUlpo9DcWEKwdzf2acFjKJ3A+yK2vziMBPXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357677; c=relaxed/simple;
	bh=HvRZu9GWHkNDIFzZ6rE7MX4IMloh5vG1SChEJ9K9zHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VhxPfiCi8PbqzSpGl0VXPgta543Lm22zK6wf416YALvzs96S5+0GB0+UepA4ousZuwubEXNwUjtIBM0cwQDGtlHzbKuOkMIy0UtOQcBcpG3Psuv8Vns6ri8noRnGG2eS30H+gMjpvWON1aIjhfPAMtsta6XZBiDgSWDKXP+Ldiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfmpQ24HzNgd2TbMgwYdnB7kwJR5/a1jnVOOCTC/fmmZ7Ug+47I6Mla/vqfwOWG7sLXj/JWVT8aRzba7kWxjBDR6XPluUnG6JZ4fV6D8rytL4At5ajN02wPqEGmFScBBjJ+lfI2ozzxL+UFZ47Ze0Q9wWZMkYIy0bOCRPAHTVnDIw8rFJkHvl31Rv/eeELyE3YwGXB22VhYPnUbA7M2Yjab4KxHlUAv3jrWNY8Gu4jMN+oU/cu6Iy4Ci8NJhX+ucJmFApEK+ZF6sjSLyHwe0kiMY/1l7V4Ibb/h4IQ+LUcsdjd1ZAJuZjMkt5EKvLNtIBne9DMxJZY5IsO9Chbj0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J47Q3jp5Re6g+8vMEL4EKbZu+hQ5TgZHgD0P7xUT9I=;
 b=KNcVfFdUW+++MZw08XvVEWkmQ8uhijXA4p8zPb8T8hitVlIqGdXiHvCCBlZw09NWz6PbQSXAays4t9mTM/DbtVGzt0fJQBBhLZJITDBSk5JqdCyokcJq94dWds0b6nk0/y+tZ+DBAU2drIXFOxvPiOadFuBwWgvXnnclIfBTiY+UvLNcxktaHOnVVPYpE3fhkTM+XJaACTm8WVVOklfkZUPZA/JhcxVrW5sQH3Q3dfEUhQi4vW2S6+lvlfCRuPCc8aVuSFQNh6kLtQ6HyiYOEI5rNetpMmS0Z3+/lBj9VR4Bk/+Vhq0QmQ51LLqdxNDiTAzhA9IZM6nOrVjbZAeTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0803.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Mon, 25 Mar
 2024 08:51:46 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.028; Mon, 25 Mar 2024 08:51:46 +0000
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
Subject: [PATCH v3 0/1] Add StarFive JH8100 dwmac support
Date: Mon, 25 Mar 2024 01:51:30 -0700
Message-Id: <20240325085131.182657-1-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::14) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0803:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a5f5b2-879b-4fc0-c408-08dc4ca8cd20
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B2kyz0U39qYAn7EdaF41a8kCghd8cDh9oLzgkNlbOZvmYASqRGwsQk4C9qAeEANFyWA+kf6ClNVowIKEzu4xwNg7UqeMYrFsn95FS6LO4wurGmaniFgiK3NAQEmXvQz45g2d+7A6SETDMC0tT3cLYK0C8TNQLwgEka5yTUBj2JZk+kFlovcaZfeToRAdGuGG620obUNf1j0L8d3yoH/yW79IlxcMqzeILUWfqAuelh8F+VoLfcWIRAEQlYtF5xgAvtWCcB06Igl3v0sg640CTqste7gb4SnYOtB2jt62tAOWqjGzziXgo80NsxrDbhLW9QNHm2dUJS0JmL6IXtZYPksqVP7XogX8e7mHjN68XxfwUeUubK1vRgaly7Qv5PqbC2xrFMkl9pccp1/Zs0nSPEiRdOtHULWF8ElUmqWThWVLKDjOVMVtelMDenbtHB/tEf6rkjxGWJy733QbVXXkGRAOalO0VE717DUXc/i3lNbx2zbuMa6riwQpfwBMbd7cJ0kYjYUcy+crZasg4fQBwve4cwgUDGn6EmYnSV28P3EAtKxQokhlPKj+bofTA8hXcgBT2e0Bu+CdQxFuKtSjY5o+xFvBYVzjd9F0a1CHZKVQY3XOIt1dhgZRDA6/lobsfiNogWb9Q85wKxy81QdRbA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(7416005)(41320700004)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I84mOhAp95TlYALKem08z5lsOObH/ZJaZwdpZyQkz77sJ5Fg/RcGteW/6HN2?=
 =?us-ascii?Q?GaLmkiqDO7WqL5ooEzzz4G8Aj+ZZbeWss7vIQLaoyHcB2Ff2fNQIb2BItCFM?=
 =?us-ascii?Q?IHvop6XnEJjhZA1PRhrn+4360MTGOoDY+nc+VzsvGQMXQjdVdM9Dk3MNav7D?=
 =?us-ascii?Q?eptIs5LusjpMGRBHWZP7R9EqHvkaG+xDM4tFEr7VmpCIPghvI1VXmCdd5mmv?=
 =?us-ascii?Q?5yrrEOvKYP815Ejx/qoJH2rKXDC9aQWRpeShfPneVeu470jkGmBBwFg0vFHV?=
 =?us-ascii?Q?PgxbgpdFwHAHyKw9IEPShSAHV75c1tK7OE9jE/jls+mvrumdfBfNUqh2vlYw?=
 =?us-ascii?Q?HJPrdtmDO6IJuB9fn35vxnMK0VSH0Is6hohFSZT+JDh79WmSVnt5Hir3PN3X?=
 =?us-ascii?Q?7RrMGFhynmEKkZ142IUxV8JRQORlk+1ivJ8OMfoeUdipvyloO53r6JH5OkEL?=
 =?us-ascii?Q?tSzvwxpdpyHax62X9bYHF/K6y0smticveJQtkUlK+u+Jd4r5TIFrVWkHjDV1?=
 =?us-ascii?Q?BxXK+pI53FijSTzWzckc3UEdJY80F0MuvbpBxnHWnyCGNEUq+O41toNKvg5E?=
 =?us-ascii?Q?x4jAb/wpu24ByTYDFHZ1SzpoI4O253hihg+oKKjoiRerq4nqcx2xWRjtVLuN?=
 =?us-ascii?Q?ephL4D3Yuz5rEHEeQp7cwaq9K6RiymPlk7o3C2jUvaSRRRP7VhMMs7uzHpJr?=
 =?us-ascii?Q?/IBXj+lLWWmLUebEj4YR9ZRobnRXKPG4XQpCpVOKIJFVgZ5gYcsmNOPShAuK?=
 =?us-ascii?Q?GGJsvQpHhF84E1qEh4hPSOMJAwXq2pFIYr4aeFUYwVc+VG3ICCCIrdD/yY8i?=
 =?us-ascii?Q?aRYhrTSxfF60ZQgeTJlix+X2lAdmBISAs556Y9Cxbm94tTyo0Se5ssGPSEpv?=
 =?us-ascii?Q?gND2WNHC7sSZrSiwUafR3U0PtzcEiHsomUC6FTAEk3JMNKmp3oVpvnB7WD/X?=
 =?us-ascii?Q?uLM/OdR5SVleLYDWRXjXPmkmSywjkFQdsPvpw15Pz4gQs+Wa2xCVIsmEQObU?=
 =?us-ascii?Q?GhZZkbuRzb7/i1YilwVKMHX7i7AUDlheouIAc67LyZqebt2SMzhqSGXSH9WX?=
 =?us-ascii?Q?TJJCVawryEb+mwiLsyvx5Wt74Ka0BwSIljRLnu87W15Vr8aM+lFobOGEtsEM?=
 =?us-ascii?Q?zzbcSpmiRcpx6sEEi6Iw8fYRUADaiWYLAXZ9fn1c4Na5HuMThfkPwI3iaS9V?=
 =?us-ascii?Q?D7AMyxhw+AeY339+Hw9YcFfvWjsS7GVbPctcSxWEDzwOW4nNvPtetjBf7wvm?=
 =?us-ascii?Q?bqehHXuXSrxzz3nute6IEP4wFvqAR7qm2WtlO+JKm/SUv8IAVFnvADIO+mWu?=
 =?us-ascii?Q?QH3gtTYZLZGcm3bYTxBpFF1FYnizmf9Wk9oox/eSkAmqAhIWbPgA74lfVgVW?=
 =?us-ascii?Q?Q9KeNndn3Wt/RMbJMrYhNBLlbek8T7vg3hjc5koYfN91SSstRGZduH1SLK3O?=
 =?us-ascii?Q?A06u3RNdEOx440SiXgs/e879yEpJZvl70LhkQdH9hUQJN3pcbQMOhzYLrAWd?=
 =?us-ascii?Q?73Ld+0ROF7HxY4YOFtsxUYtBBM1CUiOkfRzxtNycPAUYcMqcXajy9es21yG2?=
 =?us-ascii?Q?JCeVJJHANAmKnwL1jPv8c0uD6WgYPAbBRSJ5vmYqffxnAYts3qYtefE2eZmM?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a5f5b2-879b-4fc0-c408-08dc4ca8cd20
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 08:51:46.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5vlzxmuPu6G36occYdkrh2hQV92yFHBbW3cBkswbwjt7fMDlcwZKQwvzZyJ53g5o2UIz5jq4RAMRjc0tlzfQCxpSN7jUaxZN4py4uroTGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0803

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

[1] https://lore.kernel.org/lkml/20231222101001.2541758-2-cristian.ciocaltea@collabora.com

Changes in v3:
- Postpone until the patch [1] is merged.
- Reorganize the content to accommodate all compatibility specifications.

Tan Chun Hau (1):
  dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support

 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 82 +++++++++++++------
 2 files changed, 58 insertions(+), 25 deletions(-)

-- 
2.25.1


