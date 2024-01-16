Return-Path: <linux-kernel+bounces-27162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370482EB60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A602854C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01C212E40;
	Tue, 16 Jan 2024 09:18:08 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2048.outbound.protection.partner.outlook.cn [139.219.17.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B312B6E;
	Tue, 16 Jan 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTEFIME37rOhmS9vOuHzyUEy+aqsO2kPies8C0WZBndgB6I8CKq/LQ+OoRdMkP5o/PDwBcF8gnxF/3oBOH/8VXk9jimgjXGqn5HbFVibchLlhjxu/7ZfKPBsuzYYXsoH4lUlOWG4zC0/TT5dncyVq1DdzHIB2VyTB+oxNPezr7jMkxYXiXOTR/vztYE2dcs8+izElk/E0+roBY4+A0g0NbV/knW1qF9z+38e1yr6mQqZYub/ra4coKu8j3KNiiLKEcFoWsE2Fu55iRc7HBAkyWCdQgkEQs1B1KI+W4i4HoqPViHTKH7VlHxdzN3I13QxTbv9bXeekZBWungpJ56OEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnJhRO5PMt7EqU6VplgYfUhbqmDpVZItpn7+/T7tDXc=;
 b=eKAgrlTOU7mvP9/A8YHbb09VR73tcGtkgMEP5z630ASb4auzvC945m3kpEDY1/ewl1sBg7ag3agMuem4P9Dm7mDnrNbcjjvZl8y0PBmAp+FdMH/IyViiK98MhX3ihIpWWmKdivDtnGzAWIxO+WI6KQTdYD2ZSzL1kfW3ZgwZ38DTYSr8x9zmveGwzK2wm2ckyfoKt/S8PjDx32URpBDHHFrHGkYBThUlJQ98u+k/KmWgKdMKFGyvDNd5ywQ5qaKkkwWDanwF5NvQ5YBrgK9SA9fGXssl4Rl6YlonNEjZXH5qJGGnHHJWKc4vS4+abTD18kgos1n4sTNv/2fzO/Iaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0640.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 09:01:48 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::cf5e:3b9:7295:1ff6]) by SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::cf5e:3b9:7295:1ff6%7]) with mapi id 15.20.7135.032; Tue, 16 Jan 2024
 09:01:48 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: crypto: starfive: Add jh8100 compatible string
Date: Tue, 16 Jan 2024 17:01:31 +0800
Message-Id: <20240116090135.75737-2-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
References: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0054.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::21) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0640:EE_
X-MS-Office365-Filtering-Correlation-Id: 651068f4-f0c2-4bc1-5570-08dc1671c577
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Trv0UX75ShpBDez+AeQDTN1ROkHUVGkKePZ02CpM4herEWmz32TKrlDuvjb5+JVRvgkGuAFFQyY01BWnkpM5zbJlVi12GdwAOsTOzkJXpz72sf0RjMI6OwpCxYDK7htaV0QMlcWvb8Rob8b3bQELPJXiVFbQUBHp3gNtB0mD8LUJtUZdj6juOluP/iednqo9eaUp/aQtYnKwc2cf/dHfjMK0hX/OJxZfNvqK6ROZGy9iHPL1KT6gWMBzkAeXgL7rOUyrDLHSl+CVIUIJJHu7AODannRl2VfkfNWbwTQZi85Wf5bmy1rfxAqHzRMxpYRPc1JOqDIStw4es9o2bB2OaVvqfN6V/ENgVGUMyflYJ6GGZH0pn1X27tY2EGqJ8Ql8xEYqwOKUaekBUMwdrApqtlv7On7rNG0xrEbprt7WAZGKFLEbc6JVUC6Xf12MfC7splSGDgnZY3R//8HihBOZ3gf2nLAmnsqMX11CJIjNOCW/rmG8y/Igx6kWhLgaq7SxxfHOGHiU96yRhOqP04gB2cHo4kWfYSdeRHhllMJ2oX25nVFMzzol68dz2H1QuHB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(41320700001)(4744005)(2906002)(5660300002)(36756003)(40180700001)(8936002)(8676002)(86362001)(41300700001)(38350700005)(83380400001)(26005)(40160700002)(508600001)(66476007)(110136005)(66946007)(66556008)(1076003)(2616005)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NGyobNErMw1hGh5HLV+c8gQDaR3sUPRGqa76Fa8zEkFvvXmtKDgeZdS4jVZM?=
 =?us-ascii?Q?FLr5Y3KpcUxamxWrOZcq+8jMmaufN3IEhxGxiYzqpp/Qb4rED9F6VS+lqKlk?=
 =?us-ascii?Q?RUm+gdT5BYw66tgsi3GohloBCoM2gGGEr3LmOWXQIEBYI3rJnloFItvPYCf/?=
 =?us-ascii?Q?gGVXuDxqxdgFzVr3rWXYT/DWX084adqsdd2fu57+UlXdD/IXqK4MUQtUabez?=
 =?us-ascii?Q?NskSc+HCLltiVELs5G/E7JWgiMZ8cqeE5nAbNNsdXOaEexpum0RUxBfiN9Ox?=
 =?us-ascii?Q?/r7oqjmoDktM4NT+ViYesJkTpaUmc1tUljGlMIaHjJMl/WpAicqUe1nRzF3y?=
 =?us-ascii?Q?0bTxLLnDUivztao1KfjFayywtk2qHkWimdQXSJJPOdmgRGyelmKOM7dUaV0M?=
 =?us-ascii?Q?4BLjE9ITNUPRItHDac4DbBj1QO2KVXHAjuFqJ1D7SN6peVwFU+4YgR2NZxF/?=
 =?us-ascii?Q?f1MLD9S2IXwdrXJzSqKlI/wOn507vFfHbeSh3i+YTJpCGBz9odULiZ4fROo4?=
 =?us-ascii?Q?HKweGGefnzTtqOd6ZqGeJiSYYxOC4yHm10WPITF+/X3PQV945mEGoSJum68Y?=
 =?us-ascii?Q?4JrvuFCPCGOGVTK8gr8DxZwET/Q3lmbL7oJArTa9BUQ6079haPGDxUFL1kJJ?=
 =?us-ascii?Q?PCu1FHe5MI9ToQEnY8YEE6W22nVzp5mOtodCN+Ivk4pGf2TfBDkJnkhgEvkF?=
 =?us-ascii?Q?v+/yy3doP7F4c5rSs4hwmUAO6bDk5k2ecddSiMHwhima/J2McIt4C4C2R6F0?=
 =?us-ascii?Q?OKS+2B+wCgcdZ4Dm5uuo3iNndNrmdyBHUTTBKsKg6e6LyeQrmR+JAa4PKV4y?=
 =?us-ascii?Q?su5iiHyckVdZNN6uScWknjV7iCtWr0bDWB14vcP75xhpHwO0IsAlPX84EkGU?=
 =?us-ascii?Q?DemLvW5wGLOn60gUjSFZYk5QFffHqLvQkDJf4mn3Ds6Ep0zE20QmsQspp4ln?=
 =?us-ascii?Q?Uaazo15CWQdSTFQmWNR17UdJmMud4PvqB2RfNyZTTVRSLKHZr+kc/DbYQ/Cl?=
 =?us-ascii?Q?ncdUTiBY6GYOqIYE3KteN42+DulFv3bBXylX0b82zd3iTqcyM3J0eNRZ/ign?=
 =?us-ascii?Q?S9cIJZuW13LyAXuKnEeEYB5ejpGZvmaGrq2M7ZWQ1dVIDdAJZZmYbbs1qYcd?=
 =?us-ascii?Q?JoTZJbSi6NrKXxmukVyY0ktQ+MUxxY6fS9WF2ZpLSnw1IYW2cPA7Yqmo5oj3?=
 =?us-ascii?Q?aXrw1WtduGGfxiFZX5r1N9vqruZoqnqTBglMAow6hPeuoeQLmch5n4bOGaak?=
 =?us-ascii?Q?JOBxJOISHJ3zcUDq3g+cScQykH9hU4fz46JXVGbPyHshUL8QYevWCbaN+S73?=
 =?us-ascii?Q?8ihqeltw8ApAls4Nhc9R98wMUvhHFKHw9XZzAhUcK9pipsRqrN+vlKvDetgj?=
 =?us-ascii?Q?ST8dhG0B72XHktWum/SzsRb+5IPm6S7VbnEscqCrjxTfgiThsD9eFZFHW6nK?=
 =?us-ascii?Q?vmAgSUOwJy3PmL9xRKZiDA3W5bCy4+ssEIiEofcuu7cCXD5CkAysN5BW/iRi?=
 =?us-ascii?Q?LJZbGEFCnQZPJZ6Zh2tXgQnUfzJAl3NUbP0Emjahm/aVvHsGYnPwcMkW6fTd?=
 =?us-ascii?Q?xgnNIP91CyYv3JSWkYUZVLAQMGtYEBJ2aOYy5+WFcR2OWtvSZomisHmdrpM8?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651068f4-f0c2-4bc1-5570-08dc1671c577
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 09:01:48.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nM3LJlByn6GislHsdtgStrSiM4VpAIJz65ujXhdIWo9d+mnTSquGYOIWpuEJh66m0r4nKif7aZj9SjsYkd6X6OasJYpAp2+kCOgPz80NYoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0640

Add compatible string for StarFive JH8100 crypto hardware.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/crypto/starfive,jh7110-crypto.yaml  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
index 71a2876bd6e4..3b14320a107f 100644
--- a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
@@ -12,7 +12,11 @@ maintainers:
 
 properties:
   compatible:
-    const: starfive,jh7110-crypto
+    oneOf:
+      - items:
+          - const: starfive,jh8100-crypto
+          - const: starfive,jh7110-crypto
+      - const: starfive,jh7110-crypto
 
   reg:
     maxItems: 1
-- 
2.34.1


