Return-Path: <linux-kernel+bounces-167652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A84138BACC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832AFB21106
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AAC153826;
	Fri,  3 May 2024 12:49:01 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1525153579;
	Fri,  3 May 2024 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740539; cv=fail; b=ADgl1HcIvRwvM1KT0Qv4Za8cCtLzx1BIR71CuFki8mii6wzc7mcNeSalbsnyLOI006EfPOOgIF3CtCCh27o8walofZqNmc74FZYWxZtgnat48/K8f12t7K+RyaemvzBuvPTvHw/XWHQ8e081Kk4BFWvaThdLX+EYzYb29+yFo1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740539; c=relaxed/simple;
	bh=BI+FfsQIEPIHshUTPBPSKFWG7C2aI9uAzyX/w+ON0+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6TbytQF/Js4jMX/F4KilNvbWb0MeQDqGqVzUj/2s7OG6cIJPayh09sWDLc9PaM8QknZanb9xky9XqXV3AHJ28mdzwRzuGq+jZYml7FiuLnFcNHM9UI3B1twIU8f6ReGhjSEZjDtbfu1yHy50AR+8mINbFKmbct3p46Lvmjx5OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmOPBcQXYVeLmoG0Apl6abm4fcQ0C0N0uIOCtLaOA0Nu3F5M/7ERIO1Metxc/vMue9DIOesEqOu6VGkr1BVz4JaB20hkWibSrffIGELmba62lmQkGhYNmv1IqSYD2H/8TZWvue5Kq6iGVNus0B6olFLOYGBBHEl3QhqbEBaOWxtg/Rf6ax6w6XK/Op4K2rGi+YE+wstOzzDqkumOolCEE1eJ1D2SOtOZ56wwI1/2li9nd2+ghyRTPLhrU7BjfbZ7kJtqq+iebfCMiXDs9KeAPlJ+jl4SOHnC/vVGRjd5jyZvhhNyiUz4yCw+QBsvPitFPQrhSa91UKu1m5sCb589dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jzw9HigR3la2YVeYR9LMvbl35xIpK1yS7Q9EmUSg5vY=;
 b=I9c5y2hswdS1MDak03ddjD7HBDNJrw2SK03dVZexdPGoCGvTu4yzwhZCjvEA59bDDez6G/6gKmbbqr+GBrZi2EGH9W7w48E5pCaLiU0GOWDiEkRfaAnWAOk6zgh2vkF+DlvnrQQodfvWSsWlQGd0cmLS+KUUcLcJwX51lQ3ebG9YsL0yqwPINgNEoKCAzejUmwH2gVCO3bOQaPtTQyYe5+NXMeMHQ5UnsOXvrHNQfXq95kOqsYOw4o05h+C7MbJmQNVFkhqEifqteSgpZMHIS4hv9iovIxr4bytzk6ELxV6znx9bDvX8jw9qBXH3tm2u/hnOEsWhJWCfA21HoH2kAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9) by ZQ0PR01MB1238.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 3 May
 2024 11:14:49 +0000
Received: from ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 ([fe80::feb4:a4b4:1132:58f4]) by
 ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn ([fe80::feb4:a4b4:1132:58f4%5])
 with mapi id 15.20.7472.044; Fri, 3 May 2024 11:14:49 +0000
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH v3 1/7] dt-bindings: pinctrl: starfive: Add JH8100 pinctrl
Date: Fri,  3 May 2024 19:14:30 +0800
Message-Id: <20240503111436.113089-2-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
References: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::20) To ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1176:EE_|ZQ0PR01MB1238:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc3104f-2770-4983-d3ab-08dc6b623f8d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5lSK7Nkln4jUzi+/6t4Zb9Arr+DjBLlBLLL6Npw46vtj2XYIydUQRkZwca5qndIma2RdOfNOWw3IFSEWE+HIxCHmmS6L8G+ihDSqpLMiuyLnaCD0S7FlVO4yFyVEON5WNMel8RZ1VWIx4CJ62zvkHcaqhxl2wkgcOYUdUGxdVZ5oZhAGh8K19IM0S8eTkjwHXHVn1vB06nlqxpPGTwgSJMazpUNsakrGPHZ1ADM8jrK9jvVYT/mfbZv/KyuJucU2jT26fVckSudrJgGTIp7w5WajNE5g2jBQmstnFIOIujTRv01WDrzdG56Mpjo3v0GyAJupl60ozwWywH4xC2uKqq3k3p/OR8fSOYh8RCBcsfltjohfVOIh9q26RRd/sKNqX4ql+emFePyBOltIrPCOh/+WgPUINiGiVrU3O1Q2e0rNJRCJf0cl1Lk/yLiNyLfs1kqOgFPOlhBqCb3QKAS3t9sX0rQ+n1AMOh/wnag0tlO67ftk7T2938PRXmCZQFxfYjSbNmXbDKWzKf+6p/PAin1Mor2ipqECH1MdzZ37eWRwNWB1UH345VqNInJjb//BgTlduYL4jXCVlFEj1a75zZiOO4MDAAE8u+AMVlR7aZfcw4BqQjgKgit/YmmMZPzMoEgD2Tb3Xgs5wNxySCgILw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(41320700004)(7416005)(366007)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SbcmLPMBSgl1htdXDq9Ddw1cMj2EQsuOKvIcHk205G94bQikc5vs+VVJ9tgl?=
 =?us-ascii?Q?ID81pcc7hm7h9ka5s5TWZTtcdYLlQXHIeLyhDhxIzFoopdAwuP4aRB8sN91P?=
 =?us-ascii?Q?Q0YJhWntYJsaHOhKeRQojJwKlt2tDTqZs73BVjYOXH3Jhwb0pRWQPeJbax2+?=
 =?us-ascii?Q?TIJYjrFIeMUWHfAhvzMON+dv51pnZJQDKok6/NrM2SnuMxe7og3uRGvMjeZx?=
 =?us-ascii?Q?ySW8cd/lQT6Ly5zQdWzagwArfJfrdloF25+lGPBZHiVFLaet6zn2z1MnmyG4?=
 =?us-ascii?Q?WC8pIotQzQRFJr2TZ2wplx21Q8gwuVARCiNq9kw+VwldRiSQ5JU7yOsMtAXp?=
 =?us-ascii?Q?oZ8eZdXtW99sqb1n+rJKLTyjSqcWlPe8IvOX10y6nqtlFVyKjhXUCv5uAFqb?=
 =?us-ascii?Q?4KN8JpLFE19drxNuVXAd4gJcJ6UXyjBcunWH1zYJ40sE7UZ6T7an06vWHJqJ?=
 =?us-ascii?Q?wrEvk4rLgUh2H524OtdagmhdRntX5UgRM0vSPznxzGOmqWEp8GhF8fVyp6vX?=
 =?us-ascii?Q?Rj0LntU8sYOj0nV9rtd1axGawcrbTQOs3Y0SLxlDQ5EZwa10ec7mhSIUl391?=
 =?us-ascii?Q?ayM4aYByHy2yjxwFR0MH6NL9H4QAolqBgt56xvTknI5Mt5h3KGnwS5VPmLHI?=
 =?us-ascii?Q?TmztrBahztfTklR1VjOx06FNhUINGVIWV+eOnYa5hhcYAXD/dshNhIt8w+DQ?=
 =?us-ascii?Q?ODEF/3d38D425ty/qj6zDX4Ywth0z47WheEtn3yhxG78JwT80BEF4fB3ZyUp?=
 =?us-ascii?Q?vTgIrggKH3yTGTcw5abFRMx+5vauSryTyd9l48QzZ/2d6by0JvhYZJtsPAK3?=
 =?us-ascii?Q?IaGw1t1D5c2aEQvl0NfxYW8F53bpmhBWh4p6/GL3KbbAJ3oNF1y6tF+TFZLP?=
 =?us-ascii?Q?1SvsgDBFcZV5dagAKC4Shj+4L6jbStBCwQHv9etby8iqc3wGI4812cYpz7fI?=
 =?us-ascii?Q?+kq/7VIbLoU9+sH+GhmFHZbTrWsgWKwuS5jTJD1tkmtS+SN1rDXT3wxJpcTa?=
 =?us-ascii?Q?l3tCdrYMcrpkShVQfeou8oQyCqJfyShnOkZS5SmkmavGZyDCErEf6ZboPuAf?=
 =?us-ascii?Q?4i6WCyFLmRPRONCM4y9BjiRTuMAacBTrEdBC7v/hXDyzdxfhaZm8nApoQwew?=
 =?us-ascii?Q?ytWqHGDaD1BV3g6bdB5oiMggGb1O3sMnn86BVYdS+iQ57kXa5sO+36J3gUSd?=
 =?us-ascii?Q?RIjGAbDQfTLUWoTYcTa3+imEm9d5q00K8HXpbZspRD+zb5+gUv+39RXGgzbs?=
 =?us-ascii?Q?Wo2t6Fdh7mPmYk3LeeV+iKPKk4VWnk0G7083icwwRSQf/bAZLYFk3pVSYB3D?=
 =?us-ascii?Q?ALFNIadHwJ+Yk+g0RflEu5lkERTK64mmNqXqb6cIau+s/hDrcNbwGxdulKn1?=
 =?us-ascii?Q?c1EqE8nfgJQLwLnIyniC9hHrAh0N8PKEEuEsZBlDMV8fDtygyUhNGp6jOUPo?=
 =?us-ascii?Q?GkY4arK7Khlk/xEpb3onwAfl2Xwh9LJ9IBzLYkIBA7H3zL5+9HXsIbbdH+lh?=
 =?us-ascii?Q?/Zow8d2RrRwn7mAlapl1+nz+QqEWilHhJnzz4vxZzCOGUp61aYVtJVYlLiFM?=
 =?us-ascii?Q?g/y/jyDszpMDwIPemBgpG+OSe3oLoBx5Ahq8fhVbAf0dPeuJFKAIvLklK1Bj?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc3104f-2770-4983-d3ab-08dc6b623f8d
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1176.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 11:14:49.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgSbwjZOzeqG3TdZvXvttGOs0hsPQAMhPPJkpD45fDuU3zzpCHVSqGFMCqk//jdPSG5RIQy28QpC9/SCeh+pk+4oBqPYbyUPMnAeddJgmxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1238

Add documentation and header file for JH8100 pinctrl driver.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 .../pinctrl/starfive,jh8100-aon-pinctrl.yaml  | 260 ++++++++++++++++++
 .../starfive,jh8100-sys-east-pinctrl.yaml     | 222 +++++++++++++++
 .../starfive,jh8100-sys-gmac-pinctrl.yaml     | 162 +++++++++++
 .../starfive,jh8100-sys-west-pinctrl.yaml     | 219 +++++++++++++++
 .../pinctrl/starfive,jh8100-pinctrl.h         |  13 +
 5 files changed, 876 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml
 create mode 100644 include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h

diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml
new file mode 100644
index 000000000000..abd2a7570a54
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml
@@ -0,0 +1,260 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh8100-aon-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 AON (always-on) Pin Controller
+
+description: |
+  Pinctrl bindings for JH8100 RISC-V SoC from StarFive Technology Ltd.
+
+  The JH8100 SoC has 4 pinctrl domains - sys_east, sys_west, sys_gmac, and aon.
+  This document provides an overview of the "aon" pinctrl domain.
+
+  The "aon" domain has a pin controller which provides
+  - I/O multiplexing for peripheral signals specific to this domain.
+  - GPIO pins which support external GPIO interrupts or external wake-up.
+  - syscon registers to configure device I/O reference voltage.
+
+  In the AON Pin Controller, the pins named PAD_RGPIO0 to PAD_GPIO15 can be
+  multiplexed and have configurable bias, drive strength, schmitt trigger etc.
+  Only peripherals in the AON domain can have their I/O go through the 16
+  "PAD_RGPIOs". This includes I2C, UART, watchdog, eMMC, SDIO0, XSPI etc.
+
+  All these peripherals can be connected to any of the 16 PAD_RGPIOs in such a way
+  that any iopad can be set up to be controlled by any of the peripherals.
+
+  The pin muxing is illustrated by the diagram below.
+                          _____________
+                         |             |
+    RGPIO0 --------------|             |--- PAD_RGPIO0
+    RGPIO1 --------------| AON I/O MUX |--- PAD_RGPIO1
+      ...                |             |       ...
+    I2C8 SDA interface --|             |--- PAD_RGPIO15
+                         |             |
+                          -------------
+
+  The AON Pin Controller provides syscon registers to configure
+
+  1.  reference voltage of
+     - eMMC I/O interface
+         supported voltage - 1.8V
+     - SDIO0 I/O interface
+         supported voltage - 3.3V, 1.8V
+     - PAD_RGPIO bank
+        - 16 PAD_RGPIOs (PAD_RGPIO0 to PAD_GPIO15)
+        - all devices attached to PAD_RGPIOs must use I/O voltage 3.3V.
+     - XSPI I/O interface
+         supported voltage level - 3.3V
+
+     Regulator supplies the device voltage, and each device has a corresponding syscon
+     register bit [1:0] that must be configured to indicate the device voltage level.
+
+     +--------+--------+-------------------+
+     | Bit[1] | Bit[0] | Reference Voltage |
+     +--------+--------+-------------------+
+     |   0    |   0    |     3.3 V         |
+     +--------+--------+-------------------+
+     |   0    |   1    |     2.5 V         |
+     +--------+--------+-------------------+
+     |   1    |   x    |     1.8 V         |
+     +--------+--------+-------------------+
+
+  2. reference voltage and slew rate of GMAC0
+
+     Voltage level on GMAC0 interface is dependent on the PHY that it is pairing with. The
+     supported voltage levels are 3.3V, 2.5V, and 1.8V.
+
+     GMAC0 has 2 set of syscon registers -
+
+     2.1 PAD_VREF_GMAC0_syscon - bit [1:0] must be configured to indicate the voltage level on
+     GMAC0 interface. The default setting is 3.3V.
+
+     +--------+--------+-----------------------------------+
+     | Bit[1] | Bit[0] | GMAC0 Interface Reference Voltage |
+     +--------+--------+-----------------------------------+
+     |   0    |   0    |        3.3V                       |
+     +--------+--------+-----------------------------------+
+     |   0    |   1    |        2.5V                       |
+     +--------+--------+-----------------------------------+
+     |   1    |   x    |        1.8V                       |
+     +--------+--------+-----------------------------------+
+
+     2.2 PAD_GMAC0_<SIGNAL_NAME>_syscon - each GMAC0 pad has a corresponding syscon bit [0] set
+     to 0 by default. When GMAC0 mode is RGMII and voltage level is 2.5V, the bit [0] must be
+     set to 1.
+
+     +-------------+-----------------------+---------+
+     | GMAC0 Mode  |  GMAC0 Voltage Level  |  Bit[0] |
+     +-------------+-----------------------+---------+
+     |             |        3.3V           |    0    |
+     |             |-----------------------+---------+
+     |   RGMII     |        2.5V           |    1    |
+     |             |-----------------------+---------+
+     |             |        1.8V           |    0    |
+     +-------------+-----------------------+---------+
+     |             |        3.3V           |    0    |
+     |             |-----------------------+---------+
+     |   RMII      |        2.5V           |    0    |
+     |             |-----------------------+---------+
+     |             |        1.8V           |    0    |
+     +-------------+-----------------------+---------+
+
+     the bit [2] can be used to configure GMAC0 signal slew rate,
+
+     +--------+-----------+
+     | Bit[2] | Slew Rate |
+     +--------+-----------+
+     |   0    |   Fast    |
+     +--------+-----------+
+     |   1    |   Slow    |
+     +--------+-----------+
+
+  Under any circumstances, the syscon register's reference voltage setting must not be
+  lower than the actual device voltage, otherwise, the device I/O pads will get damaged.
+
+  Follow the guidelines below when configure reference voltage -
+
+  To increase the device voltage, set bit [1:0] to the new operating state first before
+  raising the actual voltage to the higher operating point.
+
+  To decrease the device voltage, hold bit [1:0] to the current operating state until
+  the actual voltage has stabilized at the lower operating point before changing the
+  setting.
+
+  Alternatively, a device voltage change can always be initiated by first setting syscon
+  register bit [1:0] = 0, the safe 3.3V startup condition, before changing the device
+  voltage. Then once the actual voltage is changed and has stabilized at the new operating
+  point, bit [1:0] can be reset as appropriate.
+
+maintainers:
+  - Alex Soo <yuklin.soo@starfivetech.com>
+
+properties:
+  compatible:
+      - items:
+          - const: starfive,jh8100-aon-pinctrl
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+  wakeup-gpios:
+    maxItems: 1
+    description: GPIO pin to be used for waking up the system from sleep mode.
+
+  wakeup-source:
+    maxItems: 1
+    description: to indicate pinctrl has wakeup capability.
+
+patternProperties:
+  '-grp$':
+    type: object
+    additionalProperties: false
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representing the
+          pinctrl groups available in the domain. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to
+          muxer configuration, bias, input enable/disable, input schmitt
+          trigger enable/disable, slew-rate and drive strength.
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml
+          - $ref: /schemas/pinctrl/pinmux-node.yaml
+        unevaluatedProperties: false
+
+        properties:
+          pinmux:
+            description: |
+              The list of GPIOs and their mux settings or function select.
+              The GPIOMUX and PINMUX macros are used to configure the
+              I/O multiplexing and function selection respectively.
+
+          bias-disable: true
+
+          bias-pull-up:
+            type: boolean
+
+          bias-pull-down:
+            type: boolean
+
+          drive-strength-microamp:
+            enum: [ 2000, 4000, 8000, 12000 ]
+
+          input-enable: true
+
+          input-disable: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+          slew-rate:
+            enum: [ 0, 1 ]
+            default: 0
+            description: |
+                0: slow (half frequency)
+                1: fast
+
+required:
+  - compatible
+  - reg
+  - resets
+  - interrupts
+  - interrupt-controller
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pinctrl_aon: pinctrl@1f300000 {
+            compatible = "starfive,jh8100-aon-pinctrl", "syscon", "simple-mfd";
+            reg = <0x0 0x1f300000 0x0 0x10000>;
+            resets = <&aoncrg 0>;
+            interrupts = <160>;
+            interrupt-controller;
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-ranges = <&pinctrl_aon 0 0 16>;
+
+            i2c7_pins: i2c7-grp {
+                i2c7-scl-pins {
+                    pinmux = <0x23265409>;
+                    bias-pull-up;
+                    input-enable;
+                };
+
+                i2c7-sda-pins {
+                    pinmux = <0x2427580a>;
+                    bias-pull-up;
+                    input-enable;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml
new file mode 100644
index 000000000000..6ad518e9bee2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 SYS_EAST Pin Controller
+
+description: |
+  Pinctrl bindings for JH8100 RISC-V SoC from StarFive Technology Ltd.
+
+  The JH8100 SoC has 4 pinctrl domains - sys_east, sys_west, sys_gmac, and aon.
+  This document provides an overview of the "sys_east" pinctrl domain.
+
+  The "sys_east" domain has a pin controller which provides
+  - I/O multiplexing for peripheral signals specific to this domain.
+  - function selection for GPIO pads.
+  - GPIO interrupt handling.
+  - syscon for device voltage reference.
+
+  In the SYS_EAST Pin Controller, the pins named PAD_GPIO0_E to PAD_GPIO47_E can
+  be multiplexed and have configurable bias, drive strength, schmitt trigger etc.
+  Only peripherals in the SYS_EAST domain can have their I/O go through the 48
+  "PAD_GPIOs". This includes CANs, I2Cs, I2Ss, SPIs, UARTs, PWMs, SMBUS0, SDIO1 etc.
+
+  All these peripherals can be connected to any of the 48 PAD_GPIOs in such a way
+  that any iopad can be set up to be controlled by any of the peripherals.
+
+  The pin muxing is illustrated by the diagram below.
+                                 __________________
+                                |                  |
+    GPIO0 ----------------------|                  |--- PAD_GPIO0_E
+    GPIO1 ----------------------| SYS_EAST I/O MUX |--- PAD_GPIO1_E
+    GPIO2 ----------------------|                  |--- PAD_GPIO2_E
+      ...                       |                  |      ...
+    I2C0 Clock interface -------|                  |--- PAD_GPIO9_E
+    I2C0 Data interface  -------|                  |--- PAD_GPIO10_E
+      ...                       |                  |      ...
+    UART0 transmit interface ---|                  |--- PAD_GPIO20_E
+    UART0 receive interface ----|                  |--- PAD_GPIO21_E
+      ...                       |                  |       ...
+    GPIO47 ---------------------|                  |--- PAD_GPIO47_E
+                                |                  |
+                                 ------------------
+
+  Alternatively, the "PAD_GPIOs" can be multiplexed to other peripherals through
+  function selection. Each iopad has a maximum of up to 3 functions - 0, 1, and 2.
+  Function 0 is the default function or peripheral signal of an iopad.
+  The function 1 and function 2 are other optional functions or peripheral signals
+  available to an iopad. The function selection can be carried out by writing the
+  function number to the iopad function select register.
+
+  The "sys_east" domain has 4 PAD_GPIO banks -
+  E0 - 16 PAD_GPIOs (PAD_GPIO0_E to PAD_GPIO15_E)
+  E1 - 16 PAD_GPIOs (PAD_GPIO16_E to PAD_GPIO31_E)
+  E2 -  8 PAD_GPIOs (PAD_GPIO32_E to PAD_GPIO39_E)
+  E3 -  8 PAD_GPIOs (PAD_GPIO40_E to PAD_GPIO47_E)
+
+  Each PAD_GPIO bank can be set to a voltage level 3.3V or 1.8V. All devices attached
+  to the PAD_GPIOs must use the same I/O voltage level as the bank voltage setting.
+  This allows user to select different I/O voltages for their devices. For instance,
+  the UART have 3.3V/1.8V requirement, the UART devices that use 1.8V are attached
+  to a PAD_GPIO bank which is configured to 1.8V.
+
+  Regulators supply voltages to the PAD_GPIO banks, and each PAD_GPIO bank has a corresponding
+  syscon bit [1:0] that must be configured to indicate its voltage level. The default setting
+  is 3.3V.
+
+  +--------+--------+-------------------+
+  | Bit[1] | Bit[0] | Reference Voltage |
+  +--------+--------+-------------------+
+  |   0    |   0    |     3.3 V         |
+  +--------+--------+-------------------+
+  |   1    |   x    |     1.8 V         |
+  +--------+--------+-------------------+
+
+  Under any circumstances, the syscon register's reference voltage setting must not be
+  lower than the actual device voltage, otherwise, the device I/O pads will get damaged.
+
+  Follow the guidelines below when configure reference voltage -
+
+  To increase the device voltage, set bit [1:0] to the new operating state first before
+  raising the actual voltage to the higher operating point.
+
+  To decrease the device voltage, hold bit [1:0] to the current operating state until
+  the actual voltage has stabilized at the lower operating point before changing the
+  setting.
+
+  Alternatively, a device voltage change can always be initiated by first setting syscon
+  register bit [1:0] = 0, the safe 3.3V startup condition, before changing the device
+  voltage. Then once the actual voltage is changed and has stabilized at the new operating
+  point, bit [1:0] can be reset as appropriate.
+
+maintainers:
+  - Alex Soo <yuklin.soo@starfivetech.com>
+
+properties:
+  compatible:
+      - items:
+          - const: starfive,jh8100-sys-pinctrl-east
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+  gpio-line-names: true
+
+patternProperties:
+  '-grp$':
+    type: object
+    additionalProperties: false
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representing the
+          pinctrl groups available in the domain. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to
+          muxer configuration, bias, input enable/disable, input schmitt
+          trigger enable/disable, slew-rate and drive strength.
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml
+          - $ref: /schemas/pinctrl/pinmux-node.yaml
+        unevaluatedProperties: false
+
+        properties:
+          pinmux:
+            description: |
+              The list of GPIOs and their mux settings or function select.
+              The GPIOMUX and PINMUX macros are used to configure the
+              I/O multiplexing and function selection respectively.
+
+          bias-disable: true
+
+          bias-pull-up:
+            type: boolean
+
+          bias-pull-down:
+            type: boolean
+
+          drive-strength-microamp:
+            enum: [ 2000, 4000, 8000, 12000 ]
+
+          input-enable: true
+
+          input-disable: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+          slew-rate:
+            enum: [ 0, 1 ]
+            default: 0
+            description: |
+                0: slow (half frequency)
+                1: fast
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - interrupt-controller
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pinctrl_east: pinctrl@122d0000 {
+            compatible = "starfive,jh8100-sys-pinctrl-east", "syscon", "simple-mfd";
+            reg = <0x0 0x122d0000 0x0 0x10000>;
+            clocks = <&syscrg_ne 153>;
+            resets = <&syscrg_ne 48>;
+            interrupts = <182>;
+            interrupt-controller;
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-ranges = <&pinctrl_east 0 0 48>;
+
+            smbus0_pins: smbus0-grp {
+                smbus0-scl-pins {
+                    pinmux = <0x1122480b>;
+                    bias-pull-up;
+                    input-enable;
+                };
+
+                smbus0-sda-pins {
+                    pinmux = <0x12234c0c>;
+                    bias-pull-up;
+                    input-enable;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml
new file mode 100644
index 000000000000..567ff0d9fd6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 SYS_GMAC Pin Controller
+
+description: |
+  Pinctrl bindings for JH8100 RISC-V SoC from StarFive Technology Ltd.
+
+  The JH8100 SoC has 4 pinctrl domains - sys_east, sys_west, sys_gmac, and aon.
+  This document provides an overview of the "sys_gmac" pinctrl domain.
+
+  The "sys_gmac" domain has a pin-controller which provides syscon registers to
+  configure device reference voltage and slew rate.
+
+  The SYS_GMAC Pin Controller does not have any PAD_GPIOs, therefore, it does not
+  support the GPIO pad I/O Multiplexing and interrupt handling.
+
+  The SYS_GMAC Pin Controller provides syscon registers to configure
+
+  1. reference voltage of SDIO1
+
+     The supported voltage levels are 3.3V and 1.8V
+
+     The bit [1:0] must be configured to indicate the SDIO1 voltage level.
+
+     +--------+--------+--------------------------+
+     | Bit[1] | Bit[0] |  SDIO1 Reference Voltage |
+     +--------+--------+--------------------------+
+     |   0    |   0    |       3.3 V              |
+     +--------+--------+--------------------------+
+     |   1    |   0    |       1.8 V              |
+     +--------+--------+--------------------------+
+
+  2. reference voltage and slew rate of GMAC1
+
+     Voltage level on GMAC1 interface is dependent on the PHY that it is pairing with. The
+     supported voltage levels are 3.3V, 2.5V, and 1.8V.
+
+     GMAC1 has 2 set of syscon registers -
+
+     2.1 PAD_VREF_GMAC1_syscon - bit [1:0] must be configured to indicate the voltage level on
+     GMAC1 interface. The default setting is 3.3V.
+
+     +--------+--------+-----------------------------------+
+     | Bit[1] | Bit[0] | GMAC1 Interface Reference Voltage |
+     +--------+--------+-----------------------------------+
+     |   0    |   0    |        3.3V                       |
+     +--------+--------+-----------------------------------+
+     |   0    |   1    |        2.5V                       |
+     +--------+--------+-----------------------------------+
+     |   1    |   x    |        1.8V                       |
+     +--------+--------+-----------------------------------+
+
+     2.2 PAD_GMAC1_<SIGNAL_NAME>_syscon - each GMAC1 pad has a corresponding syscon bit [0] set
+     to 0 by default. When GMAC1 mode is RGMII and voltage level is 2.5V, the bit [0] must be
+     set to 1.
+
+     +-------------+-----------------------+---------+
+     | GMAC1 Mode  |  GMAC1 Voltage Level  |  Bit[0] |
+     +-------------+-----------------------+---------+
+     |             |        3.3V           |    0    |
+     |             |-----------------------+---------+
+     |   RGMII     |        2.5V           |    1    |
+     |             |-----------------------+---------+
+     |             |        1.8V           |    0    |
+     +-------------+-----------------------+---------+
+     |             |        3.3V           |    0    |
+     |             |-----------------------+---------+
+     |   RMII      |        2.5V           |    0    |
+     |             |-----------------------+---------+
+     |             |        1.8V           |    0    |
+     +-------------+-----------------------+---------+
+
+     the bit [2] can be used to configure the GMAC1 signal slew rate,
+
+     +--------+-----------+
+     | Bit[2] | Slew Rate |
+     +--------+-----------+
+     |   0    |   Fast    |
+     +--------+-----------+
+     |   1    |   Slow    |
+     +--------+-----------+
+
+  Under any circumstances, the syscon register's reference voltage setting must not be
+  lower than the actual voltage, otherwise, the device I/O pads will get damaged.
+
+  Follow the guidelines below when configure reference voltage -
+
+  To increase the device voltage, set bit [1:0] to the new operating state first before
+  raising the actual voltage to the higher operating point.
+
+  To decrease the device voltage, hold bit [1:0] to the current operating state until
+  the actual voltage has stabilized at the lower operating point before changing the
+  setting.
+
+  Alternatively, a device voltage change can always be initiated by first setting syscon
+  register bit [1:0] = 0, the safe 3.3V startup condition, before changing the device
+  voltage. Then once the actual voltage is changed and has stabilized at the new operating
+  point, bit [1:0] can be reset as appropriate.
+
+maintainers:
+  - Alex Soo <yuklin.soo@starfivetech.com>
+
+properties:
+  compatible:
+      - items:
+          - const: starfive,jh8100-sys-pinctrl-gmac
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+patternProperties:
+  '-grp$':
+    type: object
+    additionalProperties: false
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representing the
+          pinctrl groups available in the domain. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to
+          muxer configuration, bias, input enable/disable, input schmitt
+          trigger enable/disable, slew-rate and drive strength.
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml
+          - $ref: /schemas/pinctrl/pinmux-node.yaml
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pinctrl_gmac: pinctrl@12770000 {
+            compatible = "starfive,jh8100-sys-pinctrl-gmac", "syscon", "simple-mfd";
+            reg = <0x0 0x12770000 0x0 0x10000>;
+            clocks = <&gmac_sdio_crg 16>;
+            resets = <&gmac_sdio_crg 3>;
+        };
+
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml
new file mode 100644
index 000000000000..ecff5656ecc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml
@@ -0,0 +1,219 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 SYS_WEST Pin Controller
+
+description: |
+  Pinctrl bindings for JH8100 RISC-V SoC from StarFive Technology Ltd.
+
+  The JH8100 SoC has 4 pinctrl domains - sys_east, sys_west, sys_gmac, and aon.
+  This document provides an overview of the "sys_west" pinctrl domain.
+
+  The "sys_west" domain has a pin-controller which provides
+  - I/O multiplexing for peripheral signals specific to this domain.
+  - function selection for GPIO pads.
+  - GPIO interrupt handling.
+  - syscon for device voltage reference.
+
+  In the SYS_WEST Pin Controller, the pins named PAD_GPIO0_W to PAD_GPIO15_W can
+  be multiplexed and have configurable bias, drive strength, schmitt trigger etc.
+  Only peripherals in the SYS_WEST domain can have their I/O go through the 16
+  "PAD_GPIOs". This includes I2Cs, HD_AUDIO, HIFI4, SPIs, UARTs, SMBUS1 etc.
+
+  All these peripherals can be connected to any of the 16 PAD_GPIOs in such a way
+  that any iopad can be set up to be controlled by any of the peripherals.
+
+  The pin muxing is illustrated by the diagram below.
+                                 __________________
+                                |                  |
+    GPIO0 ----------------------|                  |--- PAD_GPIO0_W
+    GPIO1 ----------------------| SYS_WEST I/O MUX |--- PAD_GPIO1_W
+    GPIO2 ----------------------|                  |--- PAD_GPIO2_W
+      ...                       |                  |      ...
+    HIFI4 JTAG TDO interface ---|                  |--- PAD_GPIO10_W
+    HIFI4 JTAG TDI interface ---|                  |--- PAD_GPIO11_W
+    SMBUS1 Data interface  -----|                  |--- PAD_GPIO12_W
+    SMBUS1 Clock interface -----|                  |--- PAD_GPIO13_W
+      ...                       |                  |      ...
+    GPIO14 ---------------------|                  |--- PAD_GPIO14_W
+    GPIO15 ---------------------|                  |--- PAD_GPIO15_W
+                                |                  |
+                                 ------------------
+
+  Alternatively, the "PAD_GPIOs" can be multiplexed to other peripherals through
+  function selection. Each iopad has a maximum of up to 3 functions - 0, 1, and 2.
+  Function 0 is the default function or peripheral signal of an iopad.
+  The function 1 and function 2 are other optional functions or peripheral signals
+  available to an iopad. The function selection can be carried out by writing the
+  function number to the iopad function select register.
+
+  The "sys_west" domain has one PAD_GPIO bank -
+  W0 - 16 PAD_GPIOs (PAD_GPIO0_W to PAD_GPIO15_W)
+
+  The PAD_GPIO bank can be set to voltage level 3.3V or 1.8V. All devices attached
+  to the PAD_GPIOs must use the same I/O voltage level as the bank voltage setting.
+  This allows user to select different I/O voltages for their devices. For instance,
+  the UART have 3.3V/1.8V requirement, the UART devices that use 1.8V are attached
+  to a PAD_GPIO bank which is configured to 1.8V.
+
+  Regulator supplies voltage to the PAD_GPIO bank, and the PAD_GPIO bank has a
+  corresponding syscon bit [1:0] that must be configured to indicate its voltage
+  level. The default voltage setting of each PAD_GPIO bank is 3.3V.
+
+  +--------+--------+-------------------+
+  | Bit[1] | Bit[0] | Reference Voltage |
+  +--------+--------+-------------------+
+  |   0    |   0    |     3.3 V         |
+  +--------+--------+-------------------+
+  |   1    |   x    |     1.8 V         |
+  +--------+--------+-------------------+
+
+  Under any circumstances, the syscon register's reference voltage setting must not be
+  lower than the actual device voltage, otherwise, the device I/O pads will get damaged.
+
+  Follow the guidelines below when configure reference voltage -
+
+  To increase the device voltage, set bit [1:0] to the new operating state first before
+  raising the actual voltage to the higher operating point.
+
+  To decrease the device voltage, hold bit [1:0] to the current operating state until
+  the actual voltage has stabilized at the lower operating point before changing the
+  setting.
+
+  Alternatively, a device voltage change can always be initiated by first setting syscon
+  register bit [1:0] = 0, the safe 3.3V startup condition, before changing the device
+  voltage. Then once the actual voltage is changed and has stabilized at the new operating
+  point, bit [1:0] can be reset as appropriate.
+
+maintainers:
+  - Alex Soo <yuklin.soo@starfivetech.com>
+
+properties:
+  compatible:
+      - items:
+          - const: starfive,jh8100-sys-pinctrl-west
+          - const: syscon
+          - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+  gpio-line-names: true
+
+patternProperties:
+  '-grp$':
+    type: object
+    additionalProperties: false
+    patternProperties:
+      '-pins$':
+        type: object
+        description: |
+          A pinctrl node should contain at least one subnode representing the
+          pinctrl groups available in the domain. Each subnode will list the
+          pins it needs, and how they should be configured, with regard to
+          muxer configuration, bias, input enable/disable, input schmitt
+          trigger enable/disable, slew-rate and drive strength.
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml
+          - $ref: /schemas/pinctrl/pinmux-node.yaml
+        unevaluatedProperties: false
+
+        properties:
+          pinmux:
+            description: |
+              The list of GPIOs and their mux settings or function select.
+              The GPIOMUX and PINMUX macros are used to configure the
+              I/O multiplexing and function selection respectively.
+
+          bias-disable: true
+
+          bias-pull-up:
+            type: boolean
+
+          bias-pull-down:
+            type: boolean
+
+          drive-strength-microamp:
+            enum: [ 2000, 4000, 8000, 12000 ]
+
+          input-enable: true
+
+          input-disable: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+          slew-rate:
+            enum: [ 0, 1 ]
+            default: 0
+            description: |
+                0: slow (half frequency)
+                1: fast
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - interrupt-controller
+  - gpio-controller
+  - '#gpio-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pinctrl_west: pinctrl@123e0000 {
+            compatible = "starfive,jh8100-sys-pinctrl-west", "syscon", "simple-mfd";
+            reg = <0x0 0x123e0000 0x0 0x10000>;
+            clocks = <&syscrg_nw 6>;
+            resets = <&syscrg_nw 1>;
+            interrupts = <183>;
+            interrupt-controller;
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-ranges = <&pinctrl_west 0 0 16>;
+
+            smbus1_pins: smbus1-grp {
+                smbus1-scl-pins {
+                    pinmux = <0x1014300d>;
+                    bias-pull-up;
+                    input-enable;
+                };
+
+                smbus1-sda-pins {
+                    pinmux = <0x1115340c>;
+                    bias-pull-up;
+                    input-enable;
+                };
+            };
+        };
+    };
diff --git a/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h b/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
new file mode 100644
index 000000000000..153ba950c062
--- /dev/null
+++ b/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2023-2024 StarFive Technology Co., Ltd.
+ */
+
+#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_JH8100_H__
+#define __DT_BINDINGS_PINCTRL_STARFIVE_JH8100_H__
+
+/* Pad Slew Rates */
+#define PAD_SLEW_RATE_FAST		1
+#define PAD_SLEW_RATE_SLOW		0
+
+#endif
-- 
2.25.1


