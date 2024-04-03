Return-Path: <linux-kernel+bounces-129524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50814896C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40BC1F27436
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24A81386D9;
	Wed,  3 Apr 2024 10:20:33 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B413666A;
	Wed,  3 Apr 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139633; cv=fail; b=kSoR2VcF7DvG3xXXvniEaxYW8yitb4BBV9OLDmPojvhuSdz5J9SmZpdPodTIweHvKi4vHgniZVbdbR5FpcAEoOnxtUw0mGSOiLs9MBP8B7SdEZRhXsXdokV1gFFL/h1nKpsiuwaBzZowjh8lcRiqiTrNy9W4qYGhzYbV0KJsqfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139633; c=relaxed/simple;
	bh=UQ9Z/037UmvN0Hbjw3vbZXGObAk10/I1chGusJT5+Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEBmP8mjKo6fjYDT6fM0lqCkxB0FQNhWcIHXcyC2we+ZaT9SqR/QvG7TGstFEuerghbUwgqKCggjTzV5a+Q2f7u6kGP5yjUHHgTBUYD+mji5DLIfn7JCCNUdr25hPcUURfCGvJ3OqR0mAqnPEunnNAE2IccUbE72KJGIYm+r3Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAR/1xRVUQletMJRvteiSxd8u8lGfl9vrzrsliXPwokZUB20YhvEwnb6dhRw91wvUFK9cunV3/qhzjXEIz+dyJjNL20kTu8Qt3j9hg0Qv1D74jYAwiigRwGGRkt+wDqbZrJxMH88g78hpLZ9J5Llf2x2phkEE3q5+dh57vDr1llPim9I1AK81J0W5Z0d9ZVxaRbSMS+0BG+RXef9J8bRMSctxN6cjmMckZexTg+hYIHZhJqHjEjXuEeRkodzL8RyaKurc14un4gtfId5b9eAPh3WLhjQY9OpzFzvMguECfP1hpiPfKuDJyZ2AfbNFNbzcbGgCXP1pXZoOVKx4bdQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwoCZbUdbrnOE1UoQBMJSHzpdpGSM/3cm3STufcIBiM=;
 b=OX3s3DJufoYoW0BSDM2gui9oFdGBvcLvIDX0PAliPc0m63oWok/7jp3JZNfNqNDHRWDp9S0A+bWjgy0q2qVM0Ym782gVUxqdvVZvLSCu8s8xPBJ8VS865FIMQV2DLY1EKtJIDvK7EbhAbi/1NEzc48LhL0FdAeFITA8l9Lp+WTidcUfc0MkLkncqeAJfjM9sMcN0qHXVul50Y4RwGFc1tWmIhhfCEQ4brSzOB5TfWszNr56xSukJmDHp9DXEPRH5g7izReNScJwpYwbsZmd3qXh+5x0tH2mEhiCZYQvXC3IckCj/Dxtdvcy40puKRxEW6oapvumdPjC/UhmijU+0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0675.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:06:10 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.042; Wed, 3 Apr 2024 10:06:10 +0000
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
Subject: [PATCH v6 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support
Date: Wed,  3 Apr 2024 03:05:49 -0700
Message-Id: <20240403100549.78719-2-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403100549.78719-1-chunhau.tan@starfivetech.com>
References: <20240403100549.78719-1-chunhau.tan@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2510a23-9c59-4001-55dd-08dc53c5afc4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bcf26wWBaiFXBMsLieOlQ46s4oUovn9r+jQ4yrOI1ZhuZxEa9BXHXMnirpdOXJEQxsPWAXVFdHtcCoR3CNtrP2WpIRRYnD+3it+OD6KkaLC4NbPJcLR4sJYV91TtCBgh7FeGeMih8412O9Y2oDMBJdJib3lsrDedhIx4JRM5YD6XGPCoBZG9DAU7DAN5hwSG0qXrPldWdgfF21WuvJz7L+CAlHWfkknBd3MGYL4zCl3cg29331M2Ge3jzcY0gh9AHRKAJPnscV1g075v3tPyiEsQ5/3+71We6KpM3xqAvm6dt156I2ZmtZv1AfvpdNdsdNEDC/lsXow2GbdauxGqNP2+dEvXHbOwg08wpqpVYSDU3zGvf/wyCgzbRHZ/ZYz2kF6/HHkCLoFKN9Mvva+eyaB9vdL4xv1U8AvEuO/vaLWn5qi9KDConvtb7+mKIbvsLpMRL6pMpQeMq7/4R9Q2I8p0pHr9Ww7O7Dg8Fm11TZjvoPyPG0A/s0A9+dAAVG6wbrLlSxmVSLtMG5vCDyMpyEpv+qlJefZW/sS2u6eDfwUEASaMO6NtF+ycHi12/7LYl7wVbS7u1DOETqamX44zkz9g0pBvxpAOewlxVm8b7lmPmRKJuqmlXHTApv5RFHTFab3EL9c0r2QIWK/R1qZOBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(7416005)(1800799015)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qxotFmP8BLV4aGIyaboBgdkZxMQA/AqjX1ThgzlsEQeGuBqxLFatGe80tLM3?=
 =?us-ascii?Q?TsenInSdMYVGK2YV8wD3xETAmsZLlgroWe0y2CKwURcKkdJlDgnIIyFUmJkj?=
 =?us-ascii?Q?4GphFBTZJoIXbX8fFExtj8LNW2P1ypuGpegxHqSw6BI6Re3SH9B77hLpqoJ0?=
 =?us-ascii?Q?sLnJtUwYM9GCge6YgP4VSuGR2CoF7akLTjDEX+Q2C+uEoeRBz4Bbr4pkoRXx?=
 =?us-ascii?Q?/OhJzMfVr0cq44Z7p9aYmsF4eux98Iobmg9K4TuugeI8haR1Ygz9KnEsl4ty?=
 =?us-ascii?Q?ifKDNsxZJLUgynkID4OAOHj5kVW+MvYSwd2JDpbIejQdtLt7GPL3jWcgLG8v?=
 =?us-ascii?Q?5Vf1pp1F6h6M7lqsIWfDCLpiKJmbRIn2QUHNe8flnKaWv+zj28pOp3ZGU7yP?=
 =?us-ascii?Q?4nPlParhrtZaOGMsh81C3wukyd9Hb1QJ4EP/tL8dQ8mSe/gv+VwEh7KkY3H7?=
 =?us-ascii?Q?ui4cHG8L+emGeGNoxrNLC6kedvvECyPd6vnehOhAbs+UJhuCew1+8+5wKJxJ?=
 =?us-ascii?Q?4UeMiB+8+gBe2tkP+zIUCbCB7BJ1nRNpiXtnHvs8mR8wrfO+3+Y9mjyG8P9I?=
 =?us-ascii?Q?mwX6pNS5mRGIrrEVYFn2DaJq1yeDgJ+pNM9zIYIFj47ZIb+gy15vNnVCvqjG?=
 =?us-ascii?Q?duyn0XETPtLFjfRjM+xLGaTE4b1QwsPAqeekFbCt/jerOJ3+uhDkLwA5LSOK?=
 =?us-ascii?Q?d4+Sd6MsG3BpDM9M6QNhi7thAdlNC/wT1mY2phDrOmYueuUJfPzi7WS/1tLk?=
 =?us-ascii?Q?CkyPn8ont731ZCELyORO8GYYjOjsROuayIiBv1evMjHxR0ON3Nit8AuOCkxp?=
 =?us-ascii?Q?xDgwd9YJQMszorcxclFCxzQbwm9zKg+/YmGQQm9Ud1K0dWyp9XzioIvh/oc6?=
 =?us-ascii?Q?nEj73dv78GNd3s6t/zvDeLHvm+p3Td77FrN5MsUAJcyDbm7umo8OlXbdvbeT?=
 =?us-ascii?Q?ZalSnGPxS5nUwCTfJaeIwcgfSb8Ci/9vkKsstvI59Qzu6oGWOT8zbh03yXuA?=
 =?us-ascii?Q?6mis2CleHgV41+B1MgGHngTlfyAi6TIPGPr8+NwJwJ/RArISpQy1lUPHhyoS?=
 =?us-ascii?Q?RoWxxNBZVfNURNEoskilANF5liHw/FIzT5rGwfu5wUW8buE7Xbx3Ib+nCYBC?=
 =?us-ascii?Q?Zkc1XKe4xff6GzNr+BFatkHQqXxMujIfehdQjCbber1NeDXwL07fX/LxjWEE?=
 =?us-ascii?Q?t/g7cNhPq4yWXlKHDo//fkArbWUVr4oq6DTe2akQ7bHsYC5O6+cbi4a+EvUU?=
 =?us-ascii?Q?J65TqDUNiHcK77PRc9Zih5xnsuPd7PVnHocCzN2xfZQM12VGYZeb+9thTKDL?=
 =?us-ascii?Q?FKBmuk4d6L962f3IfE+TnGtFTO/WVAdCHkTjMaKF1+cFdGyhL192sy2Tb0hP?=
 =?us-ascii?Q?JbeHE09CumQNDeQAVGTdXn/rp9UjIxX3iA0+spBgKpEqxabqJPhvUFUHcDEc?=
 =?us-ascii?Q?MYBdWIa1g1DKYmPoSX91ccqrGrwAURzj3NZBpYLaYgYB4nFYlpHptTMOJxOu?=
 =?us-ascii?Q?5/tMv/mcflgxrcXx8aYxh/XAa5IOstgCXRGYNEDWTInEt0z5QdUow/kTjswD?=
 =?us-ascii?Q?z9gIlAzMzThSJAps/WopeP9nCHPAo/59PlCN1UPucn9BSqLQA6NHV+gid6Ln?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2510a23-9c59-4001-55dd-08dc53c5afc4
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:06:10.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9fxGg63qLIt8Eaar3wgt24Sfo1QZGzGWnTsDqoeFFKJ7cg6a6zBgvZO0PxdM9NuX2yzU7A1q3FbRofLLLb/p/TB8NyCOsJ8nW5VEcalKsg=
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

Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
---
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 0d1962980f57..313a15331661 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -30,6 +30,10 @@ properties:
       - items:
           - const: starfive,jh7110-dwmac
           - const: snps,dwmac-5.20
+      - items:
+          - const: starfive,jh8100-dwmac
+          - const: starfive,jh7110-dwmac
+          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -116,11 +120,25 @@ allOf:
           minItems: 3
           maxItems: 3
 
-        resets:
-          minItems: 2
-
-        reset-names:
-          minItems: 2
+      if:
+        properties:
+          compatible:
+            contains:
+              const: starfive,jh8100-dwmac
+      then:
+        properties:
+          resets:
+            maxItems: 1
+
+          reset-names:
+            const: stmmaceth
+      else:
+        properties:
+          resets:
+            minItems: 2
+
+          reset-names:
+            minItems: 2
 
 unevaluatedProperties: false
 
-- 
2.25.1


