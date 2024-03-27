Return-Path: <linux-kernel+bounces-120190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A4788D422
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5F71F3630A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413002209D;
	Wed, 27 Mar 2024 01:58:21 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2098.outbound.protection.partner.outlook.cn [139.219.146.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C720315;
	Wed, 27 Mar 2024 01:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504700; cv=fail; b=oW3N8eh+9kCohfLPi5FGRyXkCGExvKRWzR/7C2Q24zd6xec9d3cuiyjCLXkvC6iJnAeaJeS+AwuBbQUV7xn9Xcsl7LbzK44ZUfcD+UkJtVvUJV19mqLyTZ3O/W/kK7nIA1khjdhtRvIsK2+b2Q1VYmVAj6MWWnxTITziWcnwSsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504700; c=relaxed/simple;
	bh=lyGG1DK55pgj+96h7yFtdMzfeTo3OT6xUvOppUxD5wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aWWtmjydAY66BMe8awYrbfREWVe9ZHyUT8XP9IbMMOWZNwJNRiHRf3gphCluvZOIQrlE9/+YWjlIfeg8s4yYb+ZGFgJy6ZmMR2FviCY9zRT73kvs1gNLhFiQ1AxCtk8e44JFri1Q/mNXh10oWf4h7CY7v2z/yEwfJSeFRdfkkko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af+F+NKNSHKAbawOz87NXe2HXFRO04uCH93Xfke3Y0jfaapwi/mdhJf9ZDCqHYfJxf4smNHjWaz/RXi4ZwlksXV0hPJpRI2xTzn6Vizewq45Ho2xtSp04MhkyA+xKw3p6uIa10x5foEpXfTbaUyThMcR/I18QfgncPIotnFw0Gw9ZsWMMF70ZcD3V4k/oR6LjRhmH6XN+1IMc+GA3lhjEGOnGpUy5RBzB47DGZ/KqJMESqrIB96/hQXDEa78TO1MpdlGZy4YBYb/rchqKjvf806kC/uQlBSoos5bZgLh3SBRCZzz/pnD4cwenONH+pj6/t/4/z0JYa8whGIGbIaBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVO2b8MpkVzSugA06++JUw/8hDdjOhuzg1alu2ZXec4=;
 b=Os6i6qiT1xq9ZGXAOQ0LSz05YCLk2WMyRZIzDWB4qosXJRIadlOyuuItYMwCQvfM35Uzp/S0pSyofX5lMdcdn0nTHBM+6vVnuavi8y+IhplRDTCD9iapdDBH8iH8xp9L44cTAv5UOpfvUQgd4NGPQxBSH5Y6DehmhrgDc3SrCgmNr9fNbhpJh8/NRWTeRMGLsY1Hc8lIRifJ9wJ0u99bCCwL6xMxF40dPXEH77q6BdSiASyJdzkPFERohLhmp/I0Dby4NYOP0ySbKXOR9XDTGpA3oCVY7FD2UJ0iu8blBxis3fXX1+4ZM/o8tNKbq90xDI55C1f01g2PGAEtJkhP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0689.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 01:58:09 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Wed, 27 Mar 2024 01:58:09 +0000
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
Subject: [PATCH v5 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support
Date: Tue, 26 Mar 2024 18:57:50 -0700
Message-Id: <20240327015750.226349-2-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327015750.226349-1-chunhau.tan@starfivetech.com>
References: <20240327015750.226349-1-chunhau.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0001.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::12) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eeef66a-dcbe-420a-6601-08dc4e0159ec
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vXo7HM+1DNNJUlq+nZmVey5HfHObBtvQ3LDp/Yj3kNKt0Yo6IlmEcMhYz3qejTD54AfWnQbtfgyJmXZeN1eGQVNv4IP4Nrq2Nd9eeAPF1x0d2P28ZxxVR83B4XGKZ/GIvw1isq+kSrGUzmStIyiZ4C1hj8S6Y56r/2+5ZcuKwUlPCvAHjKt6iLw32tzHFC3edqnZYQIguhaehU7mdfL4YeeEwOqZ+/KXjqlKTw/zotZ8XEvofKRyQp1M18W9Pw+KuVCQirZWcXBSRZZkIIuib5l9bsNt53onCRRwSsandIspqVay9iMJELCz65UdOid/m1Sv5gZJLvL+s2xmN6U5XmIQaAoMJvzNz/HGiWiIIOEd5wVg0N3AQnZteuCai5zLwHXpc1SEc86GaIZGO4I9V7mI71hZeRoZFkJ3IoBazsZw5dxkA+37yQi5xnnhMfaKioqQhY/CgnFPRDQ/nCjOKh79Xh9NprqvQsJdv1p+NBkleGbhZ0/qz6KobmJpk0P6dWqKb3LjyIow97N3HLO9ovRidGMUmOQIJg5Mi6bAPpeqS0BIvG33cbh8ao7VCiOA3yiaSMCsQxJoy3EZI4jlgv6fV7K2PjMyP6nIbiwrPlA9PLco6mf4Qu9dkVmAqzYZwP4Ydwm4sY2f15eTAD7lHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(52116005)(41320700004)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPM581ecglcZ0Y4i94jCP/c6etyhOn8itVzT847HcRmIR0yMdUxi4cO9qUtm?=
 =?us-ascii?Q?nwvXJTjWIM2soygWE/AVHr7XwSM5TPVUjJz1QvUF9fU+t0RIrfz4cFiG0WYe?=
 =?us-ascii?Q?4sUs9xC/b3ou776BDDeIDYzqkIe9BWSISromb3axksZB6+2ShGjBqH07+3+d?=
 =?us-ascii?Q?Lz+Kt7fCDxv0X+C0z6oPcNvhke9m10zsAos6LtfPiPu7v2e7gE6fIhcJV6dr?=
 =?us-ascii?Q?7IsWqvTsGLWo7Jkp4gAjU/LFvnA25hzqoyk8PsN98v/oGWVa8+FrtLdVyZUT?=
 =?us-ascii?Q?29G1+DbvYNWAWbZoUXnJ8Tv+r2GuTR/sbi/GePBu57EWeQUy2gYSEeJLsUgd?=
 =?us-ascii?Q?IcxaFwEOxp7xPo1lSDOYiB/FkhB0YypUfuvf+fknosfi6mHjmP6zJ6VOG7yU?=
 =?us-ascii?Q?BN0fZBxcO9LWO7lAjQqoB9+essbDPF8TA26ydIfl1TE1MImEhM0tlWwF2GYh?=
 =?us-ascii?Q?aWln3Oe8IAszvkCY2c0MNVCDuz7rEclK9gp0DxyeQPFI2D+8XmuI9JjVWAQM?=
 =?us-ascii?Q?ZBKcmtD88sRe1CkOnOPKzzI4G8DwSjITGx14meMQfCFULoAmEC83bf35LvaK?=
 =?us-ascii?Q?dZG13Dr3/VBB4oyd88AItdtpUFVYXhNjbp7aEfit4b3aqosnymSNoTglSmbn?=
 =?us-ascii?Q?Bq2gzWxEySlJdnsSn1YmJmcwps7LRojtgaFRAGcj+h71RmEDp3HQyQfuulbO?=
 =?us-ascii?Q?9Krcf7wb9WXgH+4F0QqfbdTODV4UN+vnFuFdcht0xXeCyTJqksClWkdhm4KL?=
 =?us-ascii?Q?jY7bHbpVuBwKmCI5y322jvP3ENluiiW21BJ98r90V2atSDv5uAT4nGWywvtZ?=
 =?us-ascii?Q?0NDFpFBSmHZlHWKSb5+KrmkUDHQhrpwPKCOxPNfLK0dWH1pmiVQ8swkVci3n?=
 =?us-ascii?Q?bu0kGBfdAgkvgCGiGPctqbioLMdJrakpuYo/Fhh8cpne2Gt8Sk4oWFvFA+dK?=
 =?us-ascii?Q?A8ldbFwsjUtq4tkq0j9575gjTq1eqUOqDUaRxqCe0BNh74m/kL49yI8fJJ6Y?=
 =?us-ascii?Q?EHWg052swBjfLREToA2JCRmwB28taQ+icptG5Tp9tq4nXTeAXhSx9E7P3PXX?=
 =?us-ascii?Q?/g4BIiNVWbDROM6OMheLusMbXbfWFWullBOpaGNa4j+hLWRa0bhefhANMvIu?=
 =?us-ascii?Q?gZT1R8Ptt29kLXDr7dogesv707ZbOuQfl1Mdv+zkCt+JGZvhGLisAZKdmTy2?=
 =?us-ascii?Q?5I0TGtQ3AWvQ2DFttJHz3OxFdV950PzYXGJyNWY+ND0SAk2Dx2EVmzTj5fG/?=
 =?us-ascii?Q?W8pXti+bbfalRM/f8dm260K9OQQbs72s+ByLa9MunAS4ZDTbJ/ZCarjZLt5b?=
 =?us-ascii?Q?s2+NXZYVmS5gHYbLcGlPwlUOrRGdTA7bWqwCnLgElXwDmB7AJb9uqlgQNYgp?=
 =?us-ascii?Q?KnLZN4qBDJbp8PDWsSYBf2y2k1klaV8iqRMZP5uEvau68yVWh2VUIns+vh5W?=
 =?us-ascii?Q?MVM99V6u+zV7Kmjx+UdEYzTNLRRJdnxuf5ftzTwRtcohaSPnHLx3qH0gpKsX?=
 =?us-ascii?Q?ZzjpKDV1FmbF6bPwrLPHPxuYT95FQsGko0lR8RkkRkOlhQy3sMGmivUJu3sH?=
 =?us-ascii?Q?4D+i2bLtH38D8FVYyqGRDHLvJujljQPJkcVColHmzHB6iFi3qtNjxwsMikoG?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eeef66a-dcbe-420a-6601-08dc4e0159ec
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 01:58:09.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRoQlVV80LdqYmFUS4Me40F7PgBkarMkqIPXcOpXwkoSHTAMMGcz+0RHoIl4I5tlmVHdXFORAhSl4pRNfd0YzmLjByFcTBBc5KOZmONgh5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0689

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
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 29 +++++++++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

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
index 0d1962980f57..5805a58c55d1 100644
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
@@ -116,11 +121,25 @@ allOf:
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


