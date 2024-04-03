Return-Path: <linux-kernel+bounces-129526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178A896C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521031C22FF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8A136E2E;
	Wed,  3 Apr 2024 10:21:53 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58854135A6A;
	Wed,  3 Apr 2024 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139712; cv=fail; b=kiKEvneFUqAXH13U5XfZUVQ4eLTz/urglOtm+lLgP2AB+lr36uT5YGr/4oMTBrOp+TsOst/9y/Z5TF+RSfJjz9h1EhJgv5/zpGLVs8Xwwt2RtaIb22xhstyXEsmLJ/ueMpasD95ePLepINmikmJZIbo9zyfjcnDemFXWAaXQiGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139712; c=relaxed/simple;
	bh=/v/u2S9EUffNpZkb2/0vzfN/t3CGblBSo829BrbDz5s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R2LLzadp+DXibsoVm66EmR95Ixre+QUDus8nABtlKTBt3iyjk4z/JwqcpjgjC0ovBZ7dMX653x20N4roehigLH34oczCXINszkRmNbPkIFmNfcR3XN2FqVQTERqZ4pL66p59OWLLlmy8oUui5VOgviD4uLfGkPMQMzEQUnnxgI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbiDNWR3i+ryAkBjHphgzfIZwFDo3ydnzTTrc4aBgL25OgP7DMDvewLMnZulWwXSStabqz0pw2mzne3oZCmZrgBHPptduiE3cUpv2XxJgobhk24aiRQ06e1Ykhf6G2iWfuNmMLM3CLCmEzWwjN1c5l1otM5TYQCJW2GpMn4bxySeDrDv2QdKi6kTXmLmI3MN2pp4QwgsKt7b12k6T31gxyhdHU+LhZN124J/OE1MZiqK590E6Xln47iSfJay69L/Yxcx2uQJBMCvLjG3wlTzexlyny5bKCz9FxspxbHwfDnBfAqhIZgsi6FneBDcW01KVA9XTU9uH+jg2wkgy2DZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwm7Yj1rJiKXjQ3qngQdNPFDVu+bsIFE5QcYP1PAZSY=;
 b=Wltd5dod1JaG9nbkd7sguX0Ocn/ORwg7eGNwywW4ETwjwTAZN3gwHznS1kV3CbH5BDdTCSbn1FdCDRhe0GawPTeTmB/COW7LXaV9YzLnt8yAD50Q9bjp7IVtdH7hFvubf9ZyGpa1GejZIa19grCj5SLloWBdhlDhO7jvtmcF3nKcgf7Mxl40ldn21SpUvQWvg/Y53mD4wzZ6DUgQc2U6qctd18aFWu38enhEF+C+pevK1UK9ivnZGTsfw9ZnpwhNDhett0n0/E+ovRgtM2Vk/qt/MZtfggtisWV/tBm1A3okbVGRBDXn4xOXEMLpEiz0JyRYK4Tja1X+Pk3IVD9maw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0675.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:06:06 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.042; Wed, 3 Apr 2024 10:06:06 +0000
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
Subject: [PATCH v6 0/1] Add StarFive JH8100 dwmac support
Date: Wed,  3 Apr 2024 03:05:48 -0700
Message-Id: <20240403100549.78719-1-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::9) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0675:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c63ce0c-943f-47b9-7cbd-08dc53c5ad29
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q9C2VbeiJZlOIhkJj28trMIye2qahyrDBHfJ4AwzlvLwWNC1MXx4NrWV7KJ9baKAmV2V8yTKb1AaTHHVC8I2ulDeFQQSC1ZgQEhs7+FdkDE3s+9acB3glTrJin75hdUgMLKSLrbY1RfAZqizHLfkLbEvWI+141KbvP21tBBsQvCuSJpldMymXPpJWW7WGUhKJj3OmhBmvU1+cFGIjvlchW/SgApRfjCdR7lmEnxaJa7FJ9BGtTJIMynbnuw8T01s9qHY26zaxiYpoNuOEUz9eZ38wDO32Mqp1D5jQk3l0RNo9jgU8ri6rmjSJEP9xS+FRvoKw3Anj4CiWbwoxIwa2ZOISSoqT/GzGmUN1MkfqI67E/nnTKqmGBsx/WzbvDUFKaidimu3TLqFIioAgTWr9Dbg1RCnDCs6CvOXN+GCWqCSUiY0lAYy/CI6lNfGI8ULmSdRk9ddB8ZiTDv/nnMnOLAV4lSOT5hHZRDHvabRbKfrSAEFF4vRd+V0za26LziBqTnh7nr47Yg0SiV/THu13dtm087Q9MJK7q+/vfS3pIoHdd1ttb0vQsveBA3UQuxkcao9ifrDhR6j6vp5QK+BoMACHP2sQjq1OQsVDvHur6ptTP9HNR63NdxzVdZyLjq+y5L3YcCrox1sRfLxwNO8eA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(7416005)(1800799015)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hBhU2EtEB/3Zsf5Hgx05tBbWrOGKkEwvJgF+MiaK8uporgb5HylFVGq44gde?=
 =?us-ascii?Q?vRdeqoUZP0TWB/WZB3FuCbtc+bzvk7exy6FbA5OfM/d5S5PWMGoyrtWHWEVF?=
 =?us-ascii?Q?ZVBe0t2+llmPi317hWp5Skzw8MmmtInyKMFy22ArTmktIEoV3ZXe7odx2vvL?=
 =?us-ascii?Q?19ypVHUpnCJFLN4TsV5ZXABDRXFan8X3ES8yr6WuZuiGO0E+ck+H2vGCTQqn?=
 =?us-ascii?Q?p0Ftvm0Bx03YFAEfJDWOcOg3mknGXhMKoGTvrVeCXj2MA2WHCijjGltXuj+9?=
 =?us-ascii?Q?s0LiIeycFtPcegOQ9I789RZQiPXaoQlf5/EjHqQFn9vJju6gu285A4bHGOUw?=
 =?us-ascii?Q?AxIo1mig4b4awhj4KUT1ske714vM2+TgdLX8lKD/Knegk3IbCrpRMrIk9JXX?=
 =?us-ascii?Q?9oSJwG55LevJ5I9Xw3ZZvqkeJnYv1fQK5tmT51o2FBRKlfyBd/EaAWpntzh1?=
 =?us-ascii?Q?7RgOuIN2Cj2yJVtrWYCeBx3fz5vGlixyERDZOzBpwu/OB4Texw+zOGqYw/+t?=
 =?us-ascii?Q?5yvcOQdefUIeyqtN15abYu0iTNBu8NZJoR3wLHueOCYh3ZsBwawutQCTfLNG?=
 =?us-ascii?Q?OFfdtm+rGNhEDz+RIcGw5CPcDfSwcvbZ+KrmsevEZuEaNe5e3GtIzKmk6+u3?=
 =?us-ascii?Q?3+A/TAz2Da4G+uXkQ8oIhwl+u2sBTKQpTBrvUtuap5EG90q6A90jbIZXiKy4?=
 =?us-ascii?Q?AeVPQWqTQpakrGflpwNwMDe+Oi1dYsVV8mi/fSfreeazSFI1en9NKgGy/ZYv?=
 =?us-ascii?Q?0YvbXX7uDUL9xQBjx0hunFCAHcfbnCSBQhcEnDvLm2C2ayynB3PY+ZucZZ1B?=
 =?us-ascii?Q?wmT8vG/7i/3pCJI9yiM+SCtx47dYnSzitF04zQSazpKYwCeRunUMrdVfl7QX?=
 =?us-ascii?Q?zMdpgru9uD2bDEmBJub5t83AD7rGebA27MxpTebNGvvT/sdR9p3VwN9JsuVd?=
 =?us-ascii?Q?jOXOs7ehxlXjN+I16aOADJajKf9BeQFrRw7nc2O1L2JCeYAFPGQi3uG5uUer?=
 =?us-ascii?Q?3fV/9/ACTgYa55IH99U7wum4ajUf04zp9D0cCPG1rdGULRSk8OdAzZ41DPfz?=
 =?us-ascii?Q?bJvUU1u4ArGxQuy8GrsrKBfyrg4Jd5xXqDIwhrV/8/ih2T/ZbjQdYdsjGK65?=
 =?us-ascii?Q?KHTBmvX+f2ZHpvub/RuqzUwnJdlezZY8b+pItHfWyhaJM/3Fyy8cTL3iuo28?=
 =?us-ascii?Q?07y9Vd26ZOboJlAC59qvIpMrn+jUCax1jNnI7ScgV2LQZHRQVSLRxH8b2u+E?=
 =?us-ascii?Q?1XM5N9LH/lKwH0a34uSkA7B/e8ReL5r7rUCRB+KozX9X0Iq8txjj9Dictqej?=
 =?us-ascii?Q?s9hNIkXxBzbTGHlqHAI6bM+5aeNPY29nBljMqI31JlLAhMeRN23pq+FWW6+I?=
 =?us-ascii?Q?Wl3iE8M8oUSJFZqwAmqkqjdDBzQMovlrcWr5ehE1JCmHo+AwppYtgv+tVLAm?=
 =?us-ascii?Q?ecMk0DSymt9CFb0/GKt3mJv88aR1FP8/aQnj3HCP30N//b5Kxk0OU0alAj4g?=
 =?us-ascii?Q?e0hp/mNmMV+iAQ5svN6nRSZhgVasGvSJdGI2uI9QiKHf4vQq3CGpo1fnHa/L?=
 =?us-ascii?Q?cD7tA4pb6BjaNFuGyHS4a8oJNMUFUc8aVLShAYFG/0fB3DIkZ4ZlpRRkXIlJ?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c63ce0c-943f-47b9-7cbd-08dc53c5ad29
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:06:05.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxEqWtCX/FEvar5n/BW0a3ZbuEaMl/xqM3jzh6oT8Wvah2mfSvMVc/36CKUtCkZHYZ3VQkuaVOfobNolFzBmjpxTCqTS4AZe3uLD18HHULc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0675

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

Changes in v6:
- Removed unnecessary enum "starfive,jh8100-dwmac".

Tan Chun Hau (1):
  dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support

 .../bindings/net/starfive,jh7110-dwmac.yaml   | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

-- 
2.25.1


