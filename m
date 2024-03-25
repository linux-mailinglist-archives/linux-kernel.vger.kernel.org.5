Return-Path: <linux-kernel+bounces-116720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F17A88A2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131192E0867
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76C1272A1;
	Mon, 25 Mar 2024 10:29:37 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162213776B;
	Mon, 25 Mar 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356723; cv=fail; b=jLA15Crvq8CbJAxKYEjcTy0vELBwoNQ89rpmn49/TxXomNJ9dluRMaCxD/KlA0T0tH3ZUyJ8cyqEupwCmIJKOTRhpYZIhTr3DTm1fZg1IaOetXTnk5v3Ue8Yt8zz7/kjpfc42vXVNo2TZZsTrtNJ7m8PRdd7k+dvX5FjCuikgCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356723; c=relaxed/simple;
	bh=xfVqAnJnXQhNQY+7/9+xW7boZuOLbLGlQ+2l8hpABsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PXvV2fYdjZtBWiB6lvW/JcbdPBNW06FQtU7E4q2BrgSRXCpv1DQ6c/PgcLWAIuq+WLc38oS7gvbl//b+r6RVng94I1brVlJoBsfhieOhOWGzywIC0PhOQN3H/eXVsmyyIGn2h+OVKpEscNSiniBov5h8aqYyEPqodABzZglvuWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv7V+0siv9MmLD8qd4e3ToRkX4s/CgUoPyTR8FN9xbLTpGrj3MmS7m49A3Dda8/gAwJedw2PY6N+IBNIUX3X62SQRwrZbXqE7vjS1CDIhCL9R1J2iH1RfdOIPXW8wpTfABa53JT1y3mMJQ4uj0FxQ6XGaINe9amkWIZ3XfcqhXnQUgNzrhMBiHoYcPve6NeXjk699yQuEqOrZCwUQLxp/Ir7EAxqaCjqeKoAfE0rsbhD624sL2XIpJ3GdjPDHbyQKNPLzrRVJdS4XeRDIcRtT4q/ELuH07x91sV+qTpwYShQPzv6eKAWBk2trSEyBv1TIkwmXlJFakn5+LI/La3VdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRJ7ol/QflDOrJxK3kbJ/VLH32Zx9yhLkXArOZkVLyI=;
 b=YXlvr7yw3n0G/uetPybW0YOC77ozzB09rR3lYYJAOtgikTb1M0zlE9LmK705T86xfhuKkR9ZdAhtdDirpD5GwsoDwTlSbZfHNXVFu6GpuOue47nQjLe+6pnJJC8jpADx8UI8pd7YeRdfOHrZjLrfg/GHPbscxUg82T8OrCxQHn1hVZvI/LWVUyG319ntybkMLubAl25rHNmJja7aubfZBNxFrfo5G2TNd7VHm/0RGVCPxPsG1ticJt0Ja3Ikde9U2et7loBJLR9uC5ZqIJMlG+R26C29miPmEOwbjkwfejyiYY+l+UwBOpbW0L3dTQR+mggBvxoyL1QAvdD0uxVq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0451.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 08:51:50 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.028; Mon, 25 Mar 2024 08:51:49 +0000
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
Subject: [PATCH v3 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support
Date: Mon, 25 Mar 2024 01:51:31 -0700
Message-Id: <20240325085131.182657-2-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240325085131.182657-1-chunhau.tan@starfivetech.com>
References: <20240325085131.182657-1-chunhau.tan@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0451:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3a83e1-dc35-41f5-b2af-08dc4ca8cf53
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uSFSbun4ILwVoOTkpjxVATph4sVvZ20YlShmk+tcpgx7+FklMuXH17M63Kx/hdEAm7lXvaRwmugugAh4PhbQufyYRtT6BOLZ8ObCkiQMbiSOuca2SABi0Ij2T8rv2ItdE8oTOYynZoNB8HQfUaWOwQsiugTyFaQG3Y2gPQFrbeXYD2esHdBqQxqQ1tubDMuNY2KB+vIImXVmbtuREEIdoSJs+jWA0GVN20IOZcLZRYUT0VQt1j9LrAssmV83wuT7d3S1HNKTHoLF8E4N0UqdIQfaVDYqaBuskIRoojm6uC9RX0gwMmaYiAhPLYfk5tSm6FPGK5N2h2jsGDauUTtG1GYA5KQ7kOV/2m/PdhkakI9lODijhWiafAlUNufLwNy0B/y6EiR8T/vcV8/3Yh+IR6vmxAivy5ynu1BDEWvvyEnJS0Mp097fhoC7rJXh172TDbQH5XEHTQwL6MNuyN3StATeVsnW4mtWglfZJu4NDpDAIi77Cn2nKVnoPxAbGZvbVrgIPVrBk5EuXEMTzd3/131Wcpz2dDyI8/ISCUaKnU3/8nRd7JtSaFRR9PJJDc63zjulDmCfGlH1uK2y7BlyBVgf3D0Ame7TJ3xgBWjAUH7CngDf9s7G7lLPdU8DwV9zlcJoHOMFVVEFa4D9+lchzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(52116005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x4WxwfWhu9u+FRb4kWgBfbFhYBt1Za5h5oiAu/oSmiaIn/wNE5do0WqU2A//?=
 =?us-ascii?Q?9TODh5ItY4HSk1DTUenJnmiN7UOPWaEKc8YZANksBXf0G9KJq/tgYO3hj/yJ?=
 =?us-ascii?Q?gtrPfLCkXzRJlJ5ZdPKG2IWlm+/xowAHorf0/PwF3VPRBVnLCUo3UrmJRuoB?=
 =?us-ascii?Q?Z2H+kIz3kLQVH0hKaKmPN5LBiC11CWcU0uiRrcE9pAaRPdsVE5prBsdOkG5G?=
 =?us-ascii?Q?CGkBTO+3hDAvvjIUU2ZeF7/WHxr9yi8D0X1SamDfObOmf6lGJxyBzQDUoavu?=
 =?us-ascii?Q?EJxr9jNpXnYIRPaIQnx2L21bSyXwfiQ3vbAwX+YBuJ8EV3y1BdRndVn6f/pj?=
 =?us-ascii?Q?azaPtSxWMD5JbMWtl6OIuCxnyIrWe5G30WYG6UQlkt5Tc+43L3cnlEI9pY9Q?=
 =?us-ascii?Q?7cbtH5AEwKz3jV1hyC+0vxh41gfTxs554Ok8mq8WQuCwdd5HbAAaW3gaDENa?=
 =?us-ascii?Q?0Hh8QKpnFeFKq3p/PX2LEDgmDdV8Jd0TC7ULu1FcTGFZl3oeDZrXjG3vHjfw?=
 =?us-ascii?Q?bcvwwhrA6Z6YoCVjJ5L3CRLXj4IpV2E1VrjVdKv79LyJ1qfnUgCpQFAKZmFh?=
 =?us-ascii?Q?KnMK+dGWVSecD9D8k3FrGGDu1Sv3jkZhNtAJMyMIWxn59VY3VNTQ4K9MH++u?=
 =?us-ascii?Q?MvT6CJdpWY+YWb7mKL1jhUhNiw58bEDaE60Sp4cVeAfN2YZCWeSTgOYVZTxV?=
 =?us-ascii?Q?0TvZikSjiuQdG2QgrKg/9sx9VwYkP43Stb749zSsR50SsFWxDV/2pkiciq8q?=
 =?us-ascii?Q?NHCmjpnSb6BvCbkFApznZ7m1eNBHwFL/JBXMSGOJGA6wSRqxNdgS0NJWEuOD?=
 =?us-ascii?Q?pIa/D1GkmS34bTPk+4L3X1a+IWvQVRq8QtY0M5UzZRGTuFrpHpi+eicubFN8?=
 =?us-ascii?Q?VtMCY69Pd/lnVYcPJ29umQaZ9fGsntzFcmp5nuRG2zIr27CrdA3zJPbsR19U?=
 =?us-ascii?Q?9uXD8Zv3eWhJnpwOPGZfxMpiqdAAHDBC7P6sdexIt1TiT9y9K5CKqBGNtENY?=
 =?us-ascii?Q?eczIUUMnH3Krt/PG6XUL0apmh3nWxH6NrAKwAz0aiyR1BGKcH2/wvgNHAmJN?=
 =?us-ascii?Q?W1AxMSjizwXwXm9qUmfdCkgVFR04k1J+lJxJQtabGjUplIux/PXK+QsJZuGF?=
 =?us-ascii?Q?sazR9SEbahZwxCRG9jKS5dpYh/ErXfLWwSdDbqk7822aKm4xmAoGpInLU4ww?=
 =?us-ascii?Q?yzYuZBSS0ifCzleib4uqPjAkgFXr2e6hk1lJHyxdZNqaEOvR2PgYRgMA1eZq?=
 =?us-ascii?Q?dcXezn4mfVn7jA+o9h9FShtAOO4FWBCmRQTd7tzAZcbQGGooveqCqRcS69dW?=
 =?us-ascii?Q?SScp8qcEj8wkaHdpK39/8aAU5cp36wCBU+mWST7Ky+Tr2UErpZB0wVrzZhGJ?=
 =?us-ascii?Q?bx094lFQb//ClCc3WnJQEk0xQtF8OhKfkKIuo/3gRjesZ2E0HZ+ymY5UYolt?=
 =?us-ascii?Q?rVctxiJtQRXy4jaKab7rUl/lLfHUe9jdJU6UUh2fhe94D2RvWLrRxjkNj3dB?=
 =?us-ascii?Q?x4c9YeCgp5V/KQS1f7GzXsTUTVnhacFNTVk99KpKlmiYUYlGDY8Ow+ffnI2Y?=
 =?us-ascii?Q?PB8PQ48RiirUWNfU9bvIp+R59JOTFv0nZnUWiG9eDYYUim30g5Oqp4Ot7H1q?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3a83e1-dc35-41f5-b2af-08dc4ca8cf53
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 08:51:49.8581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkUOMn3qh/n7guxPgMCX2REGoeolOo3dUZwlZbRO6FQya8jKQibHKCfbqvAOoXUofx26mfBsY1IvJ2jy9jSXx1e0WBWU1BmJK+WNm+ynXh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0451

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
 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 82 +++++++++++++------
 2 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 6b0341a8e0ea..a6d596b7dcf4 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -97,6 +97,7 @@ properties:
         - snps,dwxgmac-2.10
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
+        - starfive,jh8100-dwmac
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 0d1962980f57..da3cc984fec9 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -18,6 +18,7 @@ select:
         enum:
           - starfive,jh7100-dwmac
           - starfive,jh7110-dwmac
+          - starfive,jh8100-dwmac
   required:
     - compatible
 
@@ -30,6 +31,10 @@ properties:
       - items:
           - const: starfive,jh7110-dwmac
           - const: snps,dwmac-5.20
+      - items:
+          - const: starfive,jh8100-dwmac
+          - const: starfive,jh7110-dwmac
+          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -83,29 +88,13 @@ allOf:
   - if:
       properties:
         compatible:
-          contains:
-            const: starfive,jh7100-dwmac
-    then:
-      properties:
-        interrupts:
-          minItems: 2
-          maxItems: 2
-
-        interrupt-names:
-          minItems: 2
-          maxItems: 2
-
-        resets:
-          maxItems: 1
-
-        reset-names:
-          const: ahb
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: starfive,jh7110-dwmac
+          allOf:
+            - contains:
+                enum:
+                  - starfive,jh8100-dwmac
+            - contains:
+                enum:
+                  - starfive,jh7110-dwmac
     then:
       properties:
         interrupts:
@@ -117,10 +106,53 @@ allOf:
           maxItems: 3
 
         resets:
-          minItems: 2
+          maxItems: 1
 
         reset-names:
-          minItems: 2
+          const: stmmaceth
+
+    else:
+      if:
+        properties:
+          compatible:
+            contains:
+              const: starfive,jh7100-dwmac
+      then:
+        properties:
+          interrupts:
+            minItems: 2
+            maxItems: 2
+
+          interrupt-names:
+            minItems: 2
+            maxItems: 2
+
+          resets:
+            maxItems: 1
+
+          reset-names:
+            const: ahb
+
+        if:
+          properties:
+            compatible:
+              contains:
+                const: starfive,jh7110-dwmac
+        then:
+          properties:
+            interrupts:
+              minItems: 3
+              maxItems: 3
+
+            interrupt-names:
+              minItems: 3
+              maxItems: 3
+
+            resets:
+              minItems: 2
+
+            reset-names:
+              minItems: 2
 
 unevaluatedProperties: false
 
-- 
2.25.1


