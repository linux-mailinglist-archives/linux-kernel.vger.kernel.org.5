Return-Path: <linux-kernel+bounces-23001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA1C82A641
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917751C232D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D236139;
	Thu, 11 Jan 2024 02:55:58 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2084.outbound.protection.partner.outlook.cn [139.219.17.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D9EC4;
	Thu, 11 Jan 2024 02:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af/+2rkbzCPORC2PLJixD617P/EVsDxV6C+5myuYIbNxZAkuzlI3tcwob0GhLL5HyGlLqDQaAqwu5m/DEIAXyX0s6fLyfBONasA9PIzhEK0VPB0LNSaVLAPMKCsR99kNiLK5v8hgo8RZRlxSnT2pQbu+UDT+kO9JceU5WzN6wWHJcYRgVzAUHU59UMw01Ms4lRmJ1+3KRj0o6cYhBnDaGXEyOym8D+8nuS36eO0ouwswlFeVhH0TY8wQMQSDVFMPTEjgjzJPkXzT3uu/efViN4rjVG4g7S2qQO2KSfmmI89dhj+2yzoVUCy6+J/86hbKbLH4BnmjolutCKz/vwe1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5C7fXcc5/xoz1o5mDbxfzZ01KRU11HK/v8e/O8SQlBw=;
 b=E2GiiyFWDyecrnm86F4t0bR/52NRyu8USxYW9z1T/PikQgs/giOe9orrpI7fxG28gRrSUu5ZWU9/9TPEXJiSUCM6BbxEvojFmhJY+kz9p2T1xHwikAX8RQCVTMZ9w25JgQAthEO6IbiStee2g+cTigjiSoFgb4jjsYHZQVrd3MJNwXEThMsQ2jYzQBEmLj6eWrQOpDS1XH0hNO4rq0d642VoNSuyXKFUXCFN2GxQS9+92M6TEhdVp+rIG6DFRGLo5EJBDdx8lw7/GVwXdkMJC4rcF7p8ToAYQ6qWH3Rhsx97tEC+8brdAADMRlEH7rFIpoaa6f78SkNKlCL5Qsv2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 02:55:47 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::9fb5:b2ec:ed6f:b0a4]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::9fb5:b2ec:ed6f:b0a4%3])
 with mapi id 15.20.7135.032; Thu, 11 Jan 2024 02:55:47 +0000
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
Subject: [PATCH v2 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support
Date: Wed, 10 Jan 2024 18:55:31 -0800
Message-Id: <20240111025531.2875-2-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111025531.2875-1-chunhau.tan@starfivetech.com>
References: <20240111025531.2875-1-chunhau.tan@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: a0907861-d30c-47ee-01aa-08dc1250cfaa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B55cUnE2eXWZs/M5Le5EYcfM15/IF8/uK1cc5u6ivCcCuIT87XZR42bGBpZhXG19SB/aLvI6L6NalMquhUzAXw3UAP89wN1d2dCEUPJiHQ2DCCpI1QA/Z9DgynXoYKy8DGK/vVDsrhoT67RLQnK/fvZfkrIk1HBZ8HheC4ex/jOKVBM0n1acsy2UU4TKQ1OQpwvNKS3AtOa+YekHnYviHoDDAR/NlqS+vHnsb42cDA/t8ibYQKIMBKaJmylxzGr2nT78Qub3+0/NshHTsXwEkCXx1eeehIIJVyuK7QPpxNkEtA1jq8KCo+S73HC1EdoxCSwCYQ9b8Y2YkUst3Oxyl9mmpqn6XwO68dorCXjN0wJjs+8QAMjwbwivwKzaBT6amsmnFeCoxzSoJFBjvhGMBL95sMpwyWZu3HnpzmLT01L8vQLulwq45rf2HABPw+0Qz485x0gFn1NdYULuMArj0GaMTb3tyNuG/sazuCdydXjA2iikSYCZLPdOR00FLup6X2ZFmtfbBHT4tuGMeKYywFyrVXCBuBlmpXmrFLNDjvtB9+aiPGX8aI5lUg05XQ/Xa2czf0NkNBRILuAFJUplSKwlCeK5IpCGxG6AMvtUWDC0KXdP3haRbOnjB8PKvSK5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39830400003)(396003)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(921011)(38100700002)(8676002)(8936002)(6666004)(508600001)(4326008)(26005)(2616005)(1076003)(66946007)(66556008)(40160700002)(110136005)(54906003)(66476007)(52116002)(83380400001)(41300700001)(2906002)(86362001)(7416002)(5660300002)(40180700001)(38350700005)(36756003)(41320700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hrUqtO2Xv9eLkR7fwzv0InkvfVHufr+C1vpTp3H4tRQ1YqD/gUQ2ykIJZTiC?=
 =?us-ascii?Q?S5vgX8HGVzFMSmpbV/Za8E7NTptGG3rBtiucf3l54QVhuM74/bDgMtKOZ+uB?=
 =?us-ascii?Q?GSU7xesZ8KOXLtpLJ+XhxjuTSOlrXikjwoLBlvW+jTABq5ZHosaYywQcjIz9?=
 =?us-ascii?Q?Aupjv9MRxaDL07SyEY2IYPkkUSwUJC0fknhegIJdnCaP54ZeEF8nyRXFcEmg?=
 =?us-ascii?Q?i9fhRCQkvq79xHIKqqywL248ivGBeUMPufKYM0I5pJFfuGC8gmnsHBZK8AQW?=
 =?us-ascii?Q?8blh0ddVwAvzeXfxb+BgQ6WKkc/b9HD1DDkps83fZf5JP9pk9NUUkNug6JVy?=
 =?us-ascii?Q?w1/Gdy/eR8f4vcamQiJidxCAo9rEssU3Z91uR4M4qNDSygZZbSE+Yvu/+hnR?=
 =?us-ascii?Q?B4kBNj8ufgyC5YpG5SsJWGzyMwgi+65naipYFjwTho7jYq7ez3zJ2LgNcVmJ?=
 =?us-ascii?Q?7SooX8MUAVdW+7BgFHdpwPCpIqixVTWtNi0whRxhgNAWilRvtrA3nJ7UVPiW?=
 =?us-ascii?Q?c+m9Kco5CO9xZSg/uFa/rc2LwTZGsKl7bPc/J+yq1rMTttfthyrT+Nn5Fw8a?=
 =?us-ascii?Q?dIATlteGXH0uTYLVTg66SuTrwI3/vcB2AMEM2PRZvzXqAXsZUektheYvekP2?=
 =?us-ascii?Q?wlVksNdAJG3YlR/C/gFH/7LY9EFTSmpv9rVkI4dbJqqrLmEtVYgvZ/TgPduf?=
 =?us-ascii?Q?UXcw8VOMCvuAECZaBgqMTxb8EFoRMnWZT86x/+eY3ZmWBDw7XLY0VxYNEWEt?=
 =?us-ascii?Q?CQBNpfrG2ytTwvxAdzeiiJww1L8kgaMsNCvT9MuZEHYIXj9uGK39YsTgYuBi?=
 =?us-ascii?Q?Ll73UJMTsxPFqUi3UYaEEkwP+IcMWXHJzIJfC3eSYJKPdje9BJxkx0Ibee16?=
 =?us-ascii?Q?32diJeUINJs9AK6YzZ0ntP8BAk6GdG5P6WeB3d1YU6b5/CYKiZnVh76FweAY?=
 =?us-ascii?Q?7qG9W8g4KEl/itKWhjFAO0CHGUENsxkwIDBpSbPdKCEx7F8XJFS+fdWQoHtV?=
 =?us-ascii?Q?KuEqMG481JKCpEl9XwCNlJ1SuHRI+3rsTZzbZG/pzG6OsJCFutNUeFftQcrV?=
 =?us-ascii?Q?dCdg5OLpQgV3a0SduLQpT4LeWtaabx2v/YastH46kN7ZgRwWw8s6WyFBqYZh?=
 =?us-ascii?Q?GXVJj6gGIITL2EQlAoIKjEo1rF2CDogyJBUgS0b7Aq5/elVLcIUUslP93r22?=
 =?us-ascii?Q?RroGRDYs3uSu1VQLXtUthThN7m0iY81050H0UGYg6j6gkou8Pbj7bYOWwoPX?=
 =?us-ascii?Q?9UkeFBcKH/YieJQwKc7ruttzQTYP9NqKZUWkxMESUkYgsMDmfrTpd7YKit6m?=
 =?us-ascii?Q?JzQ1eLLoFPbhTO6/Ybuoo0XQD72YPGlwPpvbVapvcMppB7zKkLOUwQXcdQSm?=
 =?us-ascii?Q?quKXRviP42GrNG3szuRhVassJ/iRjz4H2QdbHjOpCGi0SIFRGTsTRa/iaaK0?=
 =?us-ascii?Q?3zHosOtBrO901FhOWtyrumqUA2uU/1I0J2lyMJrpNfdu31vs4dTbXFvMHATl?=
 =?us-ascii?Q?PnQrauM/wZ5yB6GXGBMeKbwOIkDSaPu+mfMJ0fI3jX1Uoc3xqQsLwIqMYIJg?=
 =?us-ascii?Q?wGcmYsVNNlkWft879rCmxdF+FKV2faOAGpV6aPYnI2rvabwDddPNUSZcmd+z?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0907861-d30c-47ee-01aa-08dc1250cfaa
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 02:55:47.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /biaylpyOB4uP/6MCD4kReVjit6/ggXAXLPbt6/8ybyV+sx5gRS8WwBuaPs1QuZD7O5jEpjtyyJLbNL9xhdottVXKGuc4FJ0YI4PvUsuQ1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0561

Add StarFive JH8100 dwmac support.
JH8100 dwmac has one reset signal instead of 2 resets as in JH7110.

Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 50 +++++++++++++------
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..350b3d76630f 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -96,6 +96,7 @@ properties:
         - snps,dwxgmac
         - snps,dwxgmac-2.10
         - starfive,jh7110-dwmac
+        - starfive,jh8100-dwmac
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 5e7cfbbebce6..7e4547961bab 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -17,15 +17,23 @@ select:
       contains:
         enum:
           - starfive,jh7110-dwmac
+          - starfive,jh8100-dwmac
   required:
     - compatible
 
 properties:
   compatible:
-    items:
-      - enum:
-          - starfive,jh7110-dwmac
-      - const: snps,dwmac-5.20
+    oneOf:
+      - items:
+          - enum:
+              - starfive,jh7110-dwmac
+          - const: snps,dwmac-5.20
+
+      - items:
+          - enum:
+              - starfive,jh8100-dwmac
+          - const: starfive,jh7110-dwmac
+          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -54,16 +62,6 @@ properties:
     minItems: 3
     maxItems: 3
 
-  resets:
-    items:
-      - description: MAC Reset signal.
-      - description: AHB Reset signal.
-
-  reset-names:
-    items:
-      - const: stmmaceth
-      - const: ahb
-
   starfive,tx-use-rgmii-clk:
     description:
       Tx clock is provided by external rgmii clock.
@@ -93,6 +91,30 @@ required:
 
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - starfive,jh8100-dwmac
+    then:
+      properties:
+        resets:
+          items:
+            - description: MAC Reset signal.
+        resets-names:
+          items:
+            - const: stmmaceth
+    else:
+      properties:
+        resets:
+          items:
+            - description: MAC Reset signal.
+            - description: AHB Reset signal.
+        resets-names:
+          items:
+            - const: stmmaceth
+            - const: ahb
 
 unevaluatedProperties: false
 
-- 
2.25.1


