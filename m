Return-Path: <linux-kernel+bounces-118437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF06188BADB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED921C2A93B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4E12DDAE;
	Tue, 26 Mar 2024 06:59:26 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74041862F;
	Tue, 26 Mar 2024 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436365; cv=fail; b=HJ2iV2KLYg9kddHsbn2eB5yYRSVr9AG8SKcjF2Qt4LP2OvUu9ykBvlx/jzjo5aWXTc63nKakUzb0oD8v6R8b6FyRutywJfIGsyrgTd8U/i+WJrJZyggYb2sl0kD2lM++kVGxLwICggyTe/yPS3wSwsfXOP36qmUBfxo6O69VLbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436365; c=relaxed/simple;
	bh=mqC2mpW70pffSGuor3ZdEj2Z66AItOQoBrHOrmtcYSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YUYAsJnL1B/0Dw5gg3ClNWQ2kok7AYnsLPRcwJOP6R58j5mMVmh+jRF4APNL2zhefm4x3ISGu/qc7UWpvSaLz/0KMQFp+sZ3pf3kI2EGZVTbHRaz39Sv/VNbBQmmjGPeCxjkwmhxEAdJgsA135DWChPhJ6Y9awjxzflCDGD2zd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwRzjKSYOaALOS3IkNMyNHK7HA/Bhho2C4Dkyqz3YPu8vm8Yxuu1KUXycEbBLHLMUUwmNNAqbNgfjYh4j8qeKsPZVnaCr3A3QCCHLDRE5E6DMyU/QIh+lqBF/TAU7NMbZ3++4vrEQQgVoOMusATqJEZaROSjQXp2zcplDrSXVZV5b0cgO9EZ2pjw/JcfTiOeOcd7+wPqTLM3s630uWK2yoFNf4yUL9wFHYVvvwEURsEQ2cx2i+zu4/3Q1Za6NL1/zUQnkQLbHq0UZkJXwCuvR1uNnm0clY39ymPGvxY+lvNBSzCcZJTtAsXnHmYSKTtkrnCUkvYN50pYF8s9fOOiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6mZgOjnFzZVrdG0UtJT/K3Amj51WZRg/lhQXzjrVI8=;
 b=FQfosByYNeXkeFekeK6z4XGN2gj/gFc2Bz+HObVoKHKl8zr0SPg7DB/9kfNKrVLEkZk6soff9SuC/nv3lX4mRpyVFgl4JRWJzxx1oOxkl3ByA6SV4Qb5xDW5RNwAbo8ytOHWoAa4RV5TrOJQiRR7VbaTTlBjaWvQI18i+KCsAWSG1TmQWpVoVBSZ1UvMJlUBuYuu/zuYc1sDcfU+6WX4LQQCT4QqmougAivGkg9ORTAOA35BH0dq1aqF18tLmvyr97xkxK+jtZPU1BKI14XYzrsOuMCG1i/4mWBp8kQmhfYKCPRnvdj+zqz4Zwe5z+mPbcOQYssG7KLaFyHPq7sWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0883.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 05:25:24 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Tue, 26 Mar 2024 05:25:24 +0000
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
Subject: [PATCH v4 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add StarFive JH8100 support
Date: Mon, 25 Mar 2024 22:25:05 -0700
Message-Id: <20240326052505.197408-2-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326052505.197408-1-chunhau.tan@starfivetech.com>
References: <20240326052505.197408-1-chunhau.tan@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c6dacbda-229e-4087-830d-08dc4d552391
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/BlYOt+2GCyEB8SU3pG0ZtSOFOuhCajAoa+ij2qqpU9IQqm0V9FK3BsVvlIae2D57JxqsnE5bORKM49joI0psvE7xDxjgE6kSyTwK0CcAqnMu/8U44e58AIDdCn4Ph83a0znre6jGB3VWFMq2KAHLsTG9zRuU2evpW4r7yTUCJ9Lmp9XSJWDiZKfjwoK+WWf7diGujTmBXblHHbExrlRBxbDW4k8VN1+9UdQayJzq1IqfQtRJZVxJFY927dTTJzuSGI+6UEZ7f5cbVU2M5uJiaDgxQl35XVRUZe1TOtZWJQwPxFj2OCS6dHiFs2V8N6BT6BY6F+uVZOvXSyM7AP+FBqdAareFEcYkv8jYhMX+ioTrVIkAyHS3eTVDyzUInt+QTV9YyIH0TvCDdrJvR+AwybzCrY0QI5k4M/fsQN85ew4ZFVlu3SsS/hoS804DnVyUXlOc61sZZVkFlXE9/m8hJGvTbMIekjhYKoO/9dczsJiZ22izrL8ej2EU1g+OfiZv/Kn9ufeCHGTbqKVvlMH/DGE0MNozTnBEmPJqQMQANPpikJ7MgehiVG6gIQk23rBqPw32Ijn50e3PDAxdYH/7iTnVtVFQzJZrxH6zQ62fW6A0S8VOjPjlGl4adUWAc46PwI5efBuDq1sbIHt5/2Now==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(1800799015)(52116005)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f+iR05w0GIludgpUEz1GsH1+/HncBFXNpLGyJm8t0fWS1UwjNb19K7KyuDRa?=
 =?us-ascii?Q?uIMTp1CMl4onzkN1yu7faDzSseAqbfInaBKYiL8nZ0wMEgfz01347AAizRi6?=
 =?us-ascii?Q?qZdlsMISbOcrDGjq/W221MBWTRAormuUNs3D5efXqijcqIWNkVZ702glruS4?=
 =?us-ascii?Q?CiRbYrIaVs1f2361x7XnNOHkwHbHrp3XnAXDP5/F2faY9eHkvpzeFwZAgCYc?=
 =?us-ascii?Q?B49fPZlYNWbKfgToiTcCOan1XqIqKE15rmvQUZhCziXBUxBc8SyZq/cxlobp?=
 =?us-ascii?Q?hHA+5PJ4Gmwpszi+nLBM3LjHcXgikrHlr826CE6w99dz8EGGdgk11ho7bqS9?=
 =?us-ascii?Q?oFw9q8A1GffNS0jEDHeIv/mMDULCcsFC/NtPkEWKuAdf9b2fAfK+vd3D+dGD?=
 =?us-ascii?Q?8NlzQvdleHS7WXNyh9nVmoLaLwjSvytXOWHnl5ICc6xD66edsZA/0ClLbL+1?=
 =?us-ascii?Q?YxNlIIkaxvmpb03Pj/uB68s3P/W0yDBZrHmuqqewzLrkUt7dzLmfkjqExTgY?=
 =?us-ascii?Q?7P5iU2tqJUNSM3/ArqfazIv0gtM2veCFchs0hixUA5sr56pTmOYK9/gQ+VMp?=
 =?us-ascii?Q?py+//bRQQPB1H//OiUzU8WygMFwdgPfW2GeI4gxegJ+8fV6L7jFXE/k/f3wq?=
 =?us-ascii?Q?PC7kxRcx+puS8XTbgqLKiDPEAMN/6sCY1xBM+yRR0nwxkmPW1FkA5r8f8HG9?=
 =?us-ascii?Q?GBEeVa1mv3uVodABplnLjFVvbOZpWTz3oDas1ZgnCFeHHVrQx4U6tVeakGyi?=
 =?us-ascii?Q?IpI+U09jojaj260szqACjRbc+4FwGJCN+0BMHRn+242fQeIl6CtJaSwqMucU?=
 =?us-ascii?Q?Y0iVArcaVdODWZ82X6J7aXeiNdhlJmAiTL7mfz45XKtJ7XnFB7AWWMrv3BwY?=
 =?us-ascii?Q?nCCuLjg6mGURab52rTbB2/I0SvV2Dh0yWH5Jmg6ia8bVYdEa1mRXgLe+LTDj?=
 =?us-ascii?Q?t8zATxZzadRHWi3Nlho5AJqKoG30EtvsN7MpHKMtad8ejtuu5N593y/oK8uF?=
 =?us-ascii?Q?a3K32kB5votMdp7nC7dBQxnrkefDDKk3KnA2erj/jLNn0KhSVGR3h4nghGi9?=
 =?us-ascii?Q?4c1qWL7/KQEJGkMczhpRf8bx+qbgKW5wZzA7KF+cmClsSD0r1oOmsM0CPHtM?=
 =?us-ascii?Q?FgjoMoB5+7InOyP5AbdJ4Ptr/56tp8C4DIlnIK+kqUD0UIfLOv3+cOF98PPS?=
 =?us-ascii?Q?zPHKZICVMlRajgfssM+OgdAz1/DtsCYDkkqufH8C2DdpoUjONoqGuj6xIapG?=
 =?us-ascii?Q?b088LrMTkRaLSogtTrQQfhSCrKxSzL869oB1wRZX5WrOdbIKSf/sD7oS+zk3?=
 =?us-ascii?Q?tIzdzI4bA4CyOwbZxghOU5uhrminsOHjbJ3EcIrhRBTvJUi1owFZEOKEv6KC?=
 =?us-ascii?Q?HlYrOHX+vjA2hTb1uEClEuNkdYDgtO/BypNi1a9qHeJgD3wLdem4j0S8liPx?=
 =?us-ascii?Q?4YNz2Ql27WNkFmsJeMfoEDyoWT11xyCK+Cn6vZ6Fkh7uHT3g7yBzRP9ynAJ5?=
 =?us-ascii?Q?0b88XTQCHtlGOtgAOIeWz0txeG5w69ZRLWPNmOkNCmgQi0wzTIEMmWEbrxaK?=
 =?us-ascii?Q?2oibgZbN7p4ZFiNT9ibcxT+jyO+JmPcT1GJmpFP0xGTrgAVj/2RL6kmS8cFJ?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dacbda-229e-4087-830d-08dc4d552391
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 05:25:24.6275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1iUsN5DgbggrYtBqbZ3nj7wgalL8FXKkQ/+Jo/kMGdQyGjXWrmmD7M+7ZLjZ0OQ4luBDsQNIgGyB5y2DTE8OA+bxztpbfad3kc8Gf4B0F4=
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

Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 54 ++++++++++++++-----
 2 files changed, 41 insertions(+), 14 deletions(-)

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
index 0d1962980f57..ce018e9768d2 100644
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
@@ -107,20 +112,41 @@ allOf:
           contains:
             const: starfive,jh7110-dwmac
     then:
-      properties:
-        interrupts:
-          minItems: 3
-          maxItems: 3
-
-        interrupt-names:
-          minItems: 3
-          maxItems: 3
-
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
+          interrupts:
+            minItems: 3
+            maxItems: 3
+
+          interrupt-names:
+            minItems: 3
+            maxItems: 3
+
+          resets:
+            maxItems: 1
+
+          reset-names:
+            const: stmmaceth
+      else:
+        properties:
+          interrupts:
+            minItems: 3
+            maxItems: 3
+
+          interrupt-names:
+            minItems: 3
+            maxItems: 3
+
+          resets:
+            minItems: 2
+
+          reset-names:
+            minItems: 2
 
 unevaluatedProperties: false
 
-- 
2.25.1


