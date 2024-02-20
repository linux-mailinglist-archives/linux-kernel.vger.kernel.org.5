Return-Path: <linux-kernel+bounces-72459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4707185B3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED639283664
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086E5A788;
	Tue, 20 Feb 2024 07:16:56 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD05A119;
	Tue, 20 Feb 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413414; cv=fail; b=Wc59ZLjPIRdw40VmvQ/iE4rFS/IExrSGZDH+FSq+l1ChVK3OEkJNwuFTZDOXAlCHvttyc5A8B82dV0GSg66KUd5+LdMR3I3eO2Gha5ddei6CXS9eKz+v4zzHPdIM4BDb2qbV8g7SisRD8xD8LXLgeTO/T6OFg5GY4svdc5B3cVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413414; c=relaxed/simple;
	bh=bahf6wdYoLOPP8d8+9WosO1bbQAYz2BHbx2F7sK7vns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ghBJeazzgVE6KXqvikfQv5dYkTCntq1I0oLMYeFi2Hsgdrf15yOw5ueSjG9Q4/AMnnyvX71P1/Oax1ZaQMoylRlUJOzUwUBMl0yJcqwOA2YSNP0RWZFPS4g0TV7CnBdS4DitlV1M7pvUQfWFfvNs2CIqjJ/sbU415z+r+M9g8Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNAjHe5X4pyiDMEbtk4TyRKlb/wW4gxq+K5U/wBQ8lhp42j964g2+YtmkeqaElq/tGrymKStEoWtQ6RJHFNl5Oh4x4igKlaXW9xXLuEqPFy+AnYM3oRKc5IRL/enrMRwF8xgN5at7UwApwXDrX2FcOS+Cp7HvkTr/g08nc97b7bVrHcSILiZ0P5PKerRGmihztkBjUs/jGoX4FxWxz7urCiUOHIrE73EsQO1vhdQjY6UhidT48nOua0hNyYqH+gRmtMvOvEeOQ9Iht3uve7ctEe0g5bkyNJ/GR6uX9zyPYi0pWENZK3gLNCf6S53GD0NitXXS7hvCWt/4Drew8ZKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m707WKCzg4oC2tVoc5csl1vgaGbxNvwE9rhPrMvzzs=;
 b=hhkWfb00DihgvOhal5HjHh8JJiiZkshNBvX4umk4nE2AVQUkg4gErble74UqO3NSExmzOzDBtFRFJaZXR1JV1170SOk054HO9vSlh4rdvjJ1aL11cJzjHnDoSTOyeNiedx1aeDb1HtFWkeOKtM+Wt/xB7tqD5D5Nn64wdSf5y8xHxKpBvISegEgVtiMyL7n5/8imdEu1SDi+KLTukBgMCQTrxsT4um69VWa49i1aPHt2mVKLLWguKo04PQUFOipP3cm7D+qyyXhnCT7vhIRi7bWj6hdeo2M563JG2EFuMTjixZQuhrN2pPJsUy5ehDw0hc2ZJw7KpJGHJSJvhKyUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 20 Feb
 2024 06:43:01 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::9d68:58f1:62cc:f1d3]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::9d68:58f1:62cc:f1d3%4])
 with mapi id 15.20.7270.047; Tue, 20 Feb 2024 06:43:01 +0000
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
Subject: [RFC PATCH v2 1/6] dt-bindings: pinctrl: starfive: Add JH8100 pinctrl
Date: Tue, 20 Feb 2024 14:42:41 +0800
Message-ID: <20240220064246.467216-2-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::22) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1239:EE_
X-MS-Office365-Filtering-Correlation-Id: 637624e5-0f14-4641-9fb9-08dc31df2e99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tdtQNYDwOfj/SavflfiqyV5quuDII2TJHV6sZ5t98g2GnbpDUPumQ+6RCP3gnl+DI47i/dyAkMPtlaAVlfybPaBvLP7YVLL4CRVUoaS4kpnjXn8SZ+hkMhNx2Po4Jo7CLghJgqG1MQ8WN8dnHiPC5Nj8u4DWMBUq0XADUCfb6swerCGkVNI8empR2ZiSDABuSK0coqAhh8PZaDqYb3geOXttjQtoR/n3UCcfL5kdMWEFCCUkS6ru3G2eiycLumiBwRQEUokfc7weMuF5xj1QVRY7We6YZd0cCRBvShxoDLVpLKdHks7wds5TqUqzn/fuWnWdTVBQsrt8ouprgume7rnWcGTOGHyJ25HHTLUh4Zj0lB1bJNA5i0MvkiCIctgqZJ79preSb5oOcVLXC3SEmHzWCoz0z4kwyCarK0KkUvla9uiDlO8vUjFXolbWlTTLo3xfd9tsCObgRrHuaV4ITpiwfwrWvIhk7OWc/PIwGPWkbagk0XanUHTQpR2VZTwsU6lPhUKAaxrPsNtlxtO/YoHy1xEN0apO8fI+gfPsH3wMWilOJ7nEfFAyPhyrxI73KAHZe4G26xCR5yltJ0sopQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8KWDZcN9BrWx/xabV9snfdC2UQOpI4l4L2JsS+BmCwfAXR+82fUlPHkBMcu?=
 =?us-ascii?Q?SEdSI8LNf8cd2TPCk370MP937Rw7UW+9qkNDTbWRHOGBTwFJXw+QoLVCYxs5?=
 =?us-ascii?Q?psEiNVjw8WVU1plh5J499VQKjsA7Nv5OEvcZvE0HcbSAAuQ6emurZrlVyFAf?=
 =?us-ascii?Q?eASOMQItu8ai5fDrv11/rJkNEHJcuTKnfYR+uH+Jx6ked9D6bzoSadxNiZ9C?=
 =?us-ascii?Q?PPmIZ5elpozZVCGgkt1tMp1WSgGYHireLsqhqHDFq3HX+tlZRir54Tp20kmH?=
 =?us-ascii?Q?RfVF2roHB35zaEAmI1Rw5J8o67mI3fLZcBNKKswywSWoe7yWtGJ0uR7YGcMz?=
 =?us-ascii?Q?Gopj6fNNiZx/RPpUlKq3jN+H2oxUlPDksWp6j9bgAAtjzuevLgqjHaN6oAme?=
 =?us-ascii?Q?owl6AP5gBOBtheGmVGlJdWMZHYV6GlQBrd2C4DM66qA4a44qoPG4Lk/pllOx?=
 =?us-ascii?Q?Vo/yOhngKnf6nSeXcOJ88Nqz1/2pndIiDZzkrtY56ln3m0XraCeBCE6n1JF9?=
 =?us-ascii?Q?W+raB6sLukG6ekDy7ma24FNvbGC25/+mNOIS32SVVG2LfYhPbZ5jIe53brSX?=
 =?us-ascii?Q?F61uFk00suwlH2Dl318ETXB3ozI9NntAC3TXrR1JRaxZQOOWlamMwXqmiOAh?=
 =?us-ascii?Q?8CmIPS561Ihjd2epG5VAiMdLzbyoLS3CJ5wQbXQLCkW6xa0AV1kyjKGvqZXJ?=
 =?us-ascii?Q?P8fqN2fnYjn4qeG8UszBqf2ujvyuRlb6BsqSjVDnZG3V1OIWC7IYObmMvZi5?=
 =?us-ascii?Q?eXWQeKIJY7CSw0Bsgx8WpqtTw5jkyoddTC9qpcPylpliXBqWlx1dFlCaVPbJ?=
 =?us-ascii?Q?XqdNW3x8nZaDaMjBYlJ9ZCws4c8xnsssqe2HBypAbxlMMGpTCqlmeTGTXXsV?=
 =?us-ascii?Q?5Z3ooDf8n6G57k1jLYXozEwfX6hjRP3Y1+NYZqmUqV67yk1ti6tW1AbNsxL5?=
 =?us-ascii?Q?Yxt1b29fFOIn+BPow4yWm4FpmZ8/iD8NE6qwdaMYJC7PT4udzvpabnrT2rp+?=
 =?us-ascii?Q?x0tp9mPUYQ5+uWXwIvB5UIfpFUcgRLKLF9HDb/7KUmZ5LrNeC3SqH/xmWfWS?=
 =?us-ascii?Q?6WOPvX4V0OrN+0JlKdIzsjoSqEbaaTxk+kcadBp1vCPCsHaupXJiQv7HT2jl?=
 =?us-ascii?Q?okNoBQ1EQDcRs5rWEr4YqpeSr6KJQ92Vr81hJc7hH1b4x0aKeiUPhinR15dS?=
 =?us-ascii?Q?D7lghQVFHiLpPhiOqUnWKHc4PmzoHCh9uvd5zbASjwU+CLO7yCpZMZNV+hgS?=
 =?us-ascii?Q?/L8b3H5a54u7yLnfxl5whiwV1SEio36IbfaVwslto2NHeUwJWuRKIzVT8+XT?=
 =?us-ascii?Q?NUuHnpysj0pGJpoFalcZcjxAQY4ktY3dMAANvktBMqn7bzPfp7T08efOL/IO?=
 =?us-ascii?Q?iJ4vcwd0Em+kFSYqCrh595l14sIJulAG7hSRkzGOgzvsz7lEaDwoiZlbifhY?=
 =?us-ascii?Q?+VP+4G4Mk/QIAGPqofkidDX1QxCFu4hLeqdl9SvbonUDgKj81/X+xBZyUAEE?=
 =?us-ascii?Q?jiShjh95Zcywd3NeTJm93mk2TPGIz5zXVU3S+/u+DL6xtFwPGGaQOB8L0wZu?=
 =?us-ascii?Q?SdfDbS/hL8b1tZfMlZunjTIcTMKKd/Gp09M+TDmepBfD8h371YrUr8K08Prx?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637624e5-0f14-4641-9fb9-08dc31df2e99
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:43:01.2451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RVlBFz/kFU3vP7Jyza0DiCKIH244PRO1Vn6IP//AVn2srZW3E5YQNmIYjlrJzXOp4wvckbMRS07mgy4kxT00/mSdbCYLqVSrmBA59vR9CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

Add documentation and header file for JH8100 pinctrl driver.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 .../pinctrl/starfive,jh8100-aon-pinctrl.yaml  | 261 ++++++++++++++++++
 .../starfive,jh8100-sys-east-pinctrl.yaml     | 223 +++++++++++++++
 .../starfive,jh8100-sys-gmac-pinctrl.yaml     | 163 +++++++++++
 .../starfive,jh8100-sys-west-pinctrl.yaml     | 220 +++++++++++++++
 .../pinctrl/starfive,jh8100-pinctrl.h         | 103 +++++++
 5 files changed, 970 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml
 create mode 100644 include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h

diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml
new file mode 100644
index 000000000000..ada40deca993
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-aon-pinctrl.yaml
@@ -0,0 +1,261 @@
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
+    oneOf:
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
+        additionalProperties: false
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
index 000000000000..3ea336cb7563
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-east-pinctrl.yaml
@@ -0,0 +1,223 @@
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
+    oneOf:
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
+        additionalProperties: false
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
index 000000000000..879b096f61f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-gmac-pinctrl.yaml
@@ -0,0 +1,163 @@
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
+    oneOf:
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
+        additionalProperties: false
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
index 000000000000..431dd540d32c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh8100-sys-west-pinctrl.yaml
@@ -0,0 +1,220 @@
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
+    oneOf:
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
+        additionalProperties: false
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
index 000000000000..055bac7eb2a6
--- /dev/null
+++ b/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2023-2024 StarFive Technology Co., Ltd.
+ */
+
+#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_JH8100_H__
+#define __DT_BINDINGS_PINCTRL_STARFIVE_JH8100_H__
+
+/* sys_iomux_west pins */
+#define PAD_GPIO0_W				0
+#define PAD_GPIO1_W				1
+#define PAD_GPIO2_W				2
+#define PAD_GPIO3_W				3
+#define PAD_GPIO4_W				4
+#define PAD_GPIO5_W				5
+#define PAD_GPIO6_W				6
+#define PAD_GPIO7_W				7
+#define PAD_GPIO8_W				8
+#define PAD_GPIO9_W				9
+#define PAD_GPIO10_W				10
+#define PAD_GPIO11_W				11
+#define PAD_GPIO12_W				12
+#define PAD_GPIO13_W				13
+#define PAD_GPIO14_W				14
+#define PAD_GPIO15_W				15
+
+/* sys_iomux_east pins */
+#define PAD_GPIO0_E				0
+#define PAD_GPIO1_E				1
+#define PAD_GPIO2_E				2
+#define PAD_GPIO3_E				3
+#define PAD_GPIO4_E				4
+#define PAD_GPIO5_E				5
+#define PAD_GPIO6_E				6
+#define PAD_GPIO7_E				7
+#define PAD_GPIO8_E				8
+#define PAD_GPIO9_E				9
+#define PAD_GPIO10_E				10
+#define PAD_GPIO11_E				11
+#define PAD_GPIO12_E				12
+#define PAD_GPIO13_E				13
+#define PAD_GPIO14_E				14
+#define PAD_GPIO15_E				15
+#define PAD_GPIO16_E				16
+#define PAD_GPIO17_E				17
+#define PAD_GPIO18_E				18
+#define PAD_GPIO19_E				19
+#define PAD_GPIO20_E				20
+#define PAD_GPIO21_E				21
+#define PAD_GPIO22_E				22
+#define PAD_GPIO23_E				23
+#define PAD_GPIO24_E				24
+#define PAD_GPIO25_E				25
+#define PAD_GPIO26_E				26
+#define PAD_GPIO27_E				27
+#define PAD_GPIO28_E				28
+#define PAD_GPIO29_E				29
+#define PAD_GPIO30_E				30
+#define PAD_GPIO31_E				31
+#define PAD_GPIO32_E				32
+#define PAD_GPIO33_E				33
+#define PAD_GPIO34_E				34
+#define PAD_GPIO35_E				35
+#define PAD_GPIO36_E				36
+#define PAD_GPIO37_E				37
+#define PAD_GPIO38_E				38
+#define PAD_GPIO39_E				39
+#define PAD_GPIO40_E				40
+#define PAD_GPIO41_E				41
+#define PAD_GPIO42_E				42
+#define PAD_GPIO43_E				43
+#define PAD_GPIO44_E				44
+#define PAD_GPIO45_E				45
+#define PAD_GPIO46_E				46
+#define PAD_GPIO47_E				47
+
+/* aon_iomux pins */
+#define PAD_RGPIO0				0
+#define PAD_RGPIO1				1
+#define PAD_RGPIO2				2
+#define PAD_RGPIO3				3
+#define PAD_RGPIO4				4
+#define PAD_RGPIO5				5
+#define PAD_RGPIO6				6
+#define PAD_RGPIO7				7
+#define PAD_RGPIO8				8
+#define PAD_RGPIO9				9
+#define PAD_RGPIO10				10
+#define PAD_RGPIO11				11
+#define PAD_RGPIO12				12
+#define PAD_RGPIO13				13
+#define PAD_RGPIO14				14
+#define PAD_RGPIO15				15
+
+#define GPOUT_LOW				0
+#define GPOUT_HIGH				1
+
+#define GPOEN_ENABLE				0
+#define GPOEN_DISABLE				1
+
+#define GPI_NONE				255
+
+#endif
-- 
2.43.0


