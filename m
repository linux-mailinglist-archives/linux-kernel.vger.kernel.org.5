Return-Path: <linux-kernel+bounces-19167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFD2826906
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959E728170F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4FEC2E6;
	Mon,  8 Jan 2024 07:58:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2085.outbound.protection.partner.outlook.cn [139.219.17.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39F9465;
	Mon,  8 Jan 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXScslhls6FvC4xD56NHAfCDwIDsUtnP6ddG85T7wTgfuajEoHiqdCZJBTV6B5uiEFRKnP/C80j8KmMcBKcu+F1NjboTNV7YKXAPL6/g/i+DdHqxkv4Mq0r8dDXjp4XIaItP6VYscAz76GBl1drED70Y3qu54QH2atrAsLtgFjOciChEXM20NH9Jw25plBIyPqyns/MSInPRI5OxLIKWZqyOX9M30CMtqr5fwHTx/64Y1eB8Rca7vjCOjaFJXJfW//Oobk8kc3p4Aell7PiXOoNRqnIxw8E1stYW2AwgMAJCJccOBPsHbjIs3PRChaHbF5rXFUmglDSxyB3lS/SmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK94xN9AQ/lqYfbefucmPNmp0jrrmLEUKefe5NaBudA=;
 b=M49mO2zFoNEpVCBz4UIPmoBx6cThVD0AH798WXjGKBp4rdtTDQcEdWfw5lyQQd+QkVrdd6DsdEXxYzCUYs4wLR7kTV+byvYl118rsNfGaglHdcRcnYDT0crN7hTSE6wkee/IdQCUIa2KJVpzshFBsYvFahdk9rVkf2AfVTgWP5VicQeT5DowXGlrMB8+3luTBWcPpJyErOdpc1Iopk3V2ulP/yMfAJH5jDLTHMHpaH5brP6bpdDtvd2J0Z8nx3/Z6q0vBWL5dGCXveMXfStCke1T1OgbWXC9N1Ug/BbwEI9h2h5GakiuRpCbUBZwy+B0I7b9gD9eTltSltutv+eyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0755.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 07:58:24 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::aaac:167d:8e0d:3acb]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::aaac:167d:8e0d:3acb%5])
 with mapi id 15.20.6933.032; Mon, 8 Jan 2024 07:58:24 +0000
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
Subject: [PATCH 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support
Date: Sun,  7 Jan 2024 23:58:09 -0800
Message-Id: <20240108075810.14161-2-chunhau.tan@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 921d1e00-1e77-4008-b92d-08dc101f9706
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4cL+9c+VhF8ExEKukhRljI8rLTtxV8r8ZVTeiFEpSh8w2zEN6TYqZn6FLEhScA5mbsvlKwWn6ArZNcIShH8qaGcri02gC9qGnekGRBeF0kJlqo+s7nC7+07F8DIe/L5VpIBPzYbNg3t9AzesKjMKbZXSPHH97M+RKCrGRvNhWfo3QT3QzWOaj1jtDVz2QbaMWE5W9dcFSlEwI8sP2mbhK9OhuksRMzs+mpQlcz/x3M18ESFCvRL72CXKtS35w1nRzfXJCSXEhqu51dtTxTR/AWeGiRMbaNO6UZhfL3UOh1TqC/lK81iEstPM9ippxIZj/nDdM6APi7xlbYhpkBBucrPIjn+dVoSRPdEdu84/rBVHkun0fljoLsX8HP1zbaednTmg/ykEQZP215ToUg5qefbuX5wirLWjzMSVAZembtDXUFF7TY+Yg6Le2HTqgRxU7WwH71Sg5fQULMLT0WrhUKV86RWTx4N8s6SZ+gCRdNwv1upPuGPGdFGLPw2FPPlSKJLOdhaDpCdsXGtefi6VvxP4feMlW6hIQc0TDlpVusiRL1TnU1TfImWiOH0f5UoLDGk/fu5wxdwEgbLpSzZyYohvjFuwkTzjylSAkIzoLRFQLwuEHnlHltkHW8JXCLmd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(39830400003)(396003)(366004)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(26005)(1076003)(2616005)(83380400001)(38100700002)(41300700001)(8676002)(8936002)(54906003)(110136005)(5660300002)(7416002)(2906002)(4326008)(66476007)(6666004)(66556008)(52116002)(66946007)(921011)(508600001)(38350700005)(86362001)(40180700001)(40160700002)(36756003)(41320700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/p1TYCJv+9vMHwX+EMJOY5dKmrN9uo461UgjA0xFKBzECE5S+7+7IZiGDa3?=
 =?us-ascii?Q?KPlLEkL341uwAJb6t6R5HNsi/w8QPvl/+reiobl3VPxTUCI+owd17CZwaKzp?=
 =?us-ascii?Q?cvcl9jN9sG/7H2aIieKbxFXq2/io6vzOcOnlLKCbpMPyfPIeeXQ/QSefxdTE?=
 =?us-ascii?Q?qAVO8o10LANlhXo9ox7407BZRp1kRz0HW52Hiq69TthccVEp8I2nRhcZsqil?=
 =?us-ascii?Q?+dEWwjAx0MHGIlKG5vbci+w5W5rJQl3A2CZrjKKAKnK73nMWkFkI1MvbfLMf?=
 =?us-ascii?Q?iOPhOIfCsDoQ7K8aYcWQ8O80I8B7pAeb+P51aLtL25iYyaO8haG/oJud2ScK?=
 =?us-ascii?Q?aLktRJeGU0IVj9L42BSpvA3bSBCFRKseEpSxNbhT0UgJR75gFqlxDIagkM4P?=
 =?us-ascii?Q?uone/UbolbvrGP+DjYgvGP9N0EtpjA/qdDjx60Dy93UQu7O/JHZc7CultVX5?=
 =?us-ascii?Q?JmFOb1JBvPzc6LOVpOpjl8ojOk4Bst42Ld5kqPQtfKPmBO88Zt0Qf7gYNIOP?=
 =?us-ascii?Q?mvHkGO0hAX0OL+OCgY3A3a7XMWpubr4kLELGcTw9Cvf3L5/tO1anFKop4Gw7?=
 =?us-ascii?Q?By1XPULAAtRu82oUpK41/45i2zoTsrNysk01LdFBkbKoOOFzBp+HAeDSUFi/?=
 =?us-ascii?Q?E9C7LrLUGkPGNzbrMKGp1Td+VLzvj8+1UAZWFk5rcdOqV8lgHUqMCR3xii00?=
 =?us-ascii?Q?/1mRGywdizU/yTUJsfhdA/sag1kxlBp0aglY569O4xsn2vXsKUwgf0qTGqJO?=
 =?us-ascii?Q?iKugWh8I78rLRlZnPwwJEJN/LQ++YLuRGzjA8AdsFSNa8JHe19DLs+qOLhu/?=
 =?us-ascii?Q?aU52UU8IOpaeqMmuk+t9v+0COYJdsVdxScsxS7cbxZwoh32tkbsA6TjWFYSt?=
 =?us-ascii?Q?Lcv+a3vHI+C/skR5FpENVbp5WM7Ju4GzeVVoolkXcmHX5qAfHvUiFypkg2Oh?=
 =?us-ascii?Q?2cSyksnsBn8gE5/UlJeKv0A6asHwamj7Dh/e4cP61EpVB/NF8MAfPstO6MMF?=
 =?us-ascii?Q?4P3JZvw419kEfDcaIQaFr23FanUvQ2mTaEREVDNlKhsxZWGK+mzPZd0zgBjD?=
 =?us-ascii?Q?fhwoEQ9XhVEZTbyG5H5fv373VUk/+E7H2HYvS+Ehs2cxCqnRcrSF/5oE2E82?=
 =?us-ascii?Q?DFzCKUq60xmqqyE8zjJ1h4nOZJwQMzOFyC7M59ThrXmrTr8xhm4vv2EAABPz?=
 =?us-ascii?Q?xdBSQJ4rYVbRVKC7g3GHS63FldBoeFps7wSb3Zw21K5mkCpDEzO1J9ZQI8AK?=
 =?us-ascii?Q?jDxCSrh7VDrmhoIO0y0ZDjT7LTgDqsnrZtCXNInYJRaBYPpP8yF5jYSCbhl8?=
 =?us-ascii?Q?D3LYdW0uIa/IZf4qz4chJ86m3B8jPhg8i3Csr0OIBb4V2K+TTjB5GxserO92?=
 =?us-ascii?Q?Eh0jj6xie2bBTPwvdm1+tRq9pNdmgZI5i4X+nbA2k1Za0NDsgP70JBj2oSvH?=
 =?us-ascii?Q?2QqjU1/sw/8IclvIFDPpnvRQ/qaSiU37a/0dP+rZ/wuvNlDR/oSONgFNyfwd?=
 =?us-ascii?Q?rmhLvuTcHCkK1AgKXFBL0+BnKKWiLtfp3L86sy7mjO3ZWF3dMduuyjUv+jC7?=
 =?us-ascii?Q?GsQWR6aUSkw6D7HbcrorHV1daR0PFpaOBVL66ZvJbY1qVErODs7Nx7WvcWc2?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921d1e00-1e77-4008-b92d-08dc101f9706
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 07:58:24.6189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIYY0u/BF8gq/86C8uI/LA1KaakfNJ6beqyoADsUAsAnJgDACo7TkUtUVbjsAZAsoaO5OE4rrlpL/xWvpteks46DB6n6xlMKdCwo1yKFWoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0755

Add StarFive JH8100 dwmac support.
JH8100 dwmac has one reset signal instead of 2 resets as in JH7110.

Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
---
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 5e7cfbbebce6..3d0447726902 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -17,6 +17,7 @@ select:
       contains:
         enum:
           - starfive,jh7110-dwmac
+          - starfive,jh8100-dwmac
   required:
     - compatible
 
@@ -25,6 +26,7 @@ properties:
     items:
       - enum:
           - starfive,jh7110-dwmac
+          - starfive,jh8100-dwmac
       - const: snps,dwmac-5.20
 
   reg:
@@ -54,16 +56,6 @@ properties:
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
@@ -93,6 +85,22 @@ required:
 
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - starfive,jh7110-dwmac
+    then:
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


