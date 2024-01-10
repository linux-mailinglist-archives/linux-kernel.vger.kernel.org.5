Return-Path: <linux-kernel+bounces-22243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F23829B58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F941289A98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433E48CEF;
	Wed, 10 Jan 2024 13:33:06 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2059.outbound.protection.partner.outlook.cn [139.219.146.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151D248CC3;
	Wed, 10 Jan 2024 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFIvD2c2qR9fRsyC1qPiFYPnk18hDMc/Sirr7dCsdF6UEntr7pU87QzIfW8sCFEZ+QYc9wqIyx3KKQp2wcv0jS2v5FewWqrT0QNUNWE1JTxdvCeqwo7Q32jpyGFzZqImiR8zSR9zfgyewJeBcM40Tkt2JtfMGBNHwPUa+sETxbax8DUzaftAJoFAwa7jGssiiL6lyGWtI2LfR/GNJYI68GA6JaqrVfZUGhWeMDfLrh733U7dhR4o9C9wRtrupTytVBSAJ9xmb5Sgl4cEyfy9zrBFiw8Jiqc7mMF2VSJNuM6RMAsvlysyNEFka9kkqRmCTx+3tuChF6OR7xfEoAO74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op7Qrxn5VO9xATtgrARle3pOBo+Q36v/LDJDpiobQKY=;
 b=d/uXdAG7RCAkXnXTf44nwBxHXqhAGKWc0CIiCcdMY4VNelB0p4/IxoMgsReX3VoyWgirCfgAnDLvgIUb/Q86eZTAYEVVK+1Br5+UYnAtUBZPDHBIPCJQoDAYlx1KNJmzLQgXTMFuFQL5u3ZyNrVnSzrxDKY9yRcaj7AWNfmdVwgSuVAdUfuFtqP0i+VE8iwZgBTDIR7LpzHOAvDH1LE7Y2h59UZX0OPmL9JvDvjfiJzQ7dpOBAz7N1rH/XyWw8emxucBGhOxhSK+iWSykWNtgp01cRlMu6leseXWx3zhgycyUKmztecqkeicMS5ADVll3mu6wXBQg+6LqwolIzbZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0865.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:31:53 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:31:53 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	hal.feng@starfivetech.com,
	xingyu.wu@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	jeeheng.sia@starfivetech.com,
	leyfoon.tan@starfivetech.com
Subject: [RFC v3 03/16] clk: starfive: Rename file name "jh71x0" to "common"
Date: Wed, 10 Jan 2024 21:31:15 +0800
Message-Id: <20240110133128.286657-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0865:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b7d0c7-0a2a-4d2c-817f-08dc11e0820d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pujTy6BB+4wcQhQ2GT5cBG4G6Ol9Jlr9ZpQawV4wWdPY9mX99O7svSUcii+s5HLG/UFjwJT40Yh+GXNS42DD2y8pgWCxsAmCQhN28ni9tP2QyqbhsYfMUoxU+l8giW3Xkl6KgshdkN+UIF4tfsadYCnkVn0KLfjQFa6Z/ajW64/Q2HfIBdPxvCfodZSBwwGaS0vh4eIXhfWG7aZiHIiO+zmBHhbqa9Cv7963Ie7VlA2DUO6r+IYSxU2MzLtcE7KDYuJKRBu/1V8E3bcWiEQRdwvKBu3ow2fb1jMoE8pvmPqyXCYBb0LqF+++49+u/8Ea2vML1aXqqeFonCJFDJUiROEdgbGoaBw5HQmMN+71YkR9HFCGK364cakp/askcU2vn0N1zl3NdBHFii++qOsLHS+sIHZQWwOL9tH1nVcuo9QZAXnSVKTsy8XWN1C9/8dh/CZ5LO3iBy18BZvS3vJZuxITtpAZFJ+zX3pHoxWfgNua+PSfI5xQr5zASirzpqGmqBpZNn2DDb83zt6SpGYArsIWVhFdvFu31bEiYF3Nl8VFDjqa+e3V1SHz7iFBCBUSjJIn+V7LxhU2EACGjOJ62fzD0dJmJ3gzeZd5fhWZmUNBHNq7O+qvl04UsqiIZH5s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39830400003)(346002)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(41320700001)(6666004)(508600001)(55236004)(52116002)(2616005)(107886003)(1076003)(26005)(38100700002)(40160700002)(38350700005)(921011)(86362001)(40180700001)(36756003)(41300700001)(4326008)(7416002)(83380400001)(5660300002)(2906002)(8936002)(8676002)(66946007)(66556008)(66476007)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1chYZtbETLpkxKF9raj2r8I0Fs1WISnyRjp+ROwD0a4YbLCCUyPFvsZjbg59?=
 =?us-ascii?Q?bwI1I6oAnl3jl3QgWYPfi075fGpmvNYZMinRpd3jfS05UC0FKdQz7coXzq1Z?=
 =?us-ascii?Q?VTDffxgJBmpb8giMgrGk5beIzryLjL0z9ZH09ucPXEJ2QNNSjs44dqvZkyyz?=
 =?us-ascii?Q?Gm6nPQW3eTVXQm/99DydPPUwcdFEF46zGKitlCHfeC283bXrIM/KsVzEdmju?=
 =?us-ascii?Q?30qNB8dfnFe7pdwO/olUu6Ge5BOHGuKXAeyh76TWUf5qNuQzkWBi/2AsQQvr?=
 =?us-ascii?Q?mkTn1pcQaD9uIDC8XyBvIKiTehpWbviJ94px3R76YF/qai17ma3Ew+tkzHhk?=
 =?us-ascii?Q?OswYSEIq+Z+iXQwxsI5Ty4yC6Fi/zyT78vmqGjWSmloxbafAZiwsQfh8FYa4?=
 =?us-ascii?Q?M/OJtIJr3HxR+0yrM3iiUX9FaPdt7QXQch1FTMBZCxePNS3Sz+oRbEqB0ucq?=
 =?us-ascii?Q?qq0NaYGgZ22uO9iV8wf1sDDlbmJHWJSKnK+vU/LLtSitbmxNVLnxPa6ZauFf?=
 =?us-ascii?Q?quEtkg35zg/cODy5mCmj9XkDaAR6p7L3TBpO5f27deo+nsZcFhlwTPBCIc9g?=
 =?us-ascii?Q?ZoMrtNtDB0FhU9kjZGKdGFaSl2PGqi1qxZ1mbHb5uiXv6Y55VlwoIy/IXZfp?=
 =?us-ascii?Q?SRlXunAtQ8EoxAYfQwMXaq8NY59rhZqwvq3oaueWoLXrPM4skP+IHx+h2Bgo?=
 =?us-ascii?Q?q07EgWNSlAiUU7XPhS8WycNi3diazKGIEF7r+Tfr9ekCs3EKg6pHr/KTc6jl?=
 =?us-ascii?Q?kw96aTdj4EUsZ5gzwcODzLzJzYi45PbJNspqss+WuwbILfH0Ja/PYMU1pR7B?=
 =?us-ascii?Q?rPEioBZPvdmadOQosgFkCT5eYzCQRYnhMAfWLsuX6JvgEq21bUMj43BNoMU2?=
 =?us-ascii?Q?IY5wazj0zWF0/QzSDwx2n3bxQp4xTDvTof7eDTtYuUvNcGdPdpkLiBrH9LcD?=
 =?us-ascii?Q?v+57FcjuXgbTr+KwGofXMGFYKDblsdBvHwi+P2Q1JnuyfqwA36EXLf/O7ECO?=
 =?us-ascii?Q?37LlFTYpz9O1rfMV6LMT1+bxkp4IdbvTxeLzKRl5dcgr38oIiZ57Q4h8kb74?=
 =?us-ascii?Q?M4kcSL9G1rqyCX+bM/eflM374yy5nVaKIMRL83Y+VjMqmswwCMotT6RRBGUh?=
 =?us-ascii?Q?Wt2XKPtbUHXuIHshs2X1SfqfzfMH+Esz36X/yv+PnPWM2Me6mFSB59HLazdb?=
 =?us-ascii?Q?iId8q8ssEwf7PiZH1PnDdCzIewPDdRsk7BDRAKg/bj6azI6IYylVO8jxnmjR?=
 =?us-ascii?Q?nDxdD18Si+UdNTsD72ub0SkCWva0lWhEy+B3nMEHrEcRp7V3u6l4LrNxW/AO?=
 =?us-ascii?Q?zCX6q5A6l96kMXcxZDB7Mkirp5Defa57Wx9WFYtNpMPnM2GchOEUrAiiub+P?=
 =?us-ascii?Q?ztPUK4GIkT/mIr/HPLp9m9ksZ009j/Xf4Bdq6DlBe8Sw+/QmHskljABkUyc2?=
 =?us-ascii?Q?qI6uqWqF3+GtJYw92V6faNiKVpeKZyWdsSi1ll0vn4xh3l/GvRC+Cz7QLRgK?=
 =?us-ascii?Q?itEJBBTToo2eWdzprj0kZdGPTl42uP9KvZlNFcfHQQ+Hw733y5wCKn/9LsE3?=
 =?us-ascii?Q?Ysyh+d50nVur6awzsBW22uqTac6/jplSS3K9TFmwh38AV5Pgf7B9ou9Ydqpz?=
 =?us-ascii?Q?IPgSrf8fJAVGiYRrkQ5sMQ4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b7d0c7-0a2a-4d2c-817f-08dc11e0820d
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:31:53.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PUIAxRbZiDYBf3/1mMAgQvgre8aTzMyqP9nAsrY3wdeiDR7zK/g1S74DDt1SkVIPQvsu8iRQsswOvSfhen710BTnd7oe9Zq0KdYPnrGQAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0865

StarFive JH8100 shares a similar clock and reset design with JH7110.
To facilitate the reuse of the file and its functionalities, files
containing the "jh71x0" naming convention are renamed to use the
"common" wording.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/clk/starfive/Kconfig                              | 8 ++++----
 drivers/clk/starfive/Makefile                             | 2 +-
 .../{clk-starfive-jh71x0.c => clk-starfive-common.c}      | 4 ++--
 .../{clk-starfive-jh71x0.h => clk-starfive-common.h}      | 4 ++--
 drivers/clk/starfive/clk-starfive-jh7100-audio.c          | 2 +-
 drivers/clk/starfive/clk-starfive-jh7100.c                | 2 +-
 drivers/clk/starfive/clk-starfive-jh7110.h                | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/clk/starfive/{clk-starfive-jh71x0.c => clk-starfive-common.c} (99%)
 rename drivers/clk/starfive/{clk-starfive-jh71x0.h => clk-starfive-common.h} (97%)

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index bd29358ffeec..ff8eace36e64 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config CLK_STARFIVE_JH71X0
+config CLK_STARFIVE_COMMON
 	bool
 
 config CLK_STARFIVE_JH7100
 	bool "StarFive JH7100 clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the clock controller on the StarFive JH7100
@@ -15,7 +15,7 @@ config CLK_STARFIVE_JH7100
 config CLK_STARFIVE_JH7100_AUDIO
 	tristate "StarFive JH7100 audio clock support"
 	depends on CLK_STARFIVE_JH7100
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	default m if ARCH_STARFIVE
 	help
 	  Say Y or M here to support the audio clocks on the StarFive JH7100
@@ -33,7 +33,7 @@ config CLK_STARFIVE_JH7110_SYS
 	bool "StarFive JH7110 system clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
 	select AUXILIARY_BUS
-	select CLK_STARFIVE_JH71X0
+	select CLK_STARFIVE_COMMON
 	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
 	select CLK_STARFIVE_JH7110_PLL
 	default ARCH_STARFIVE
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 199ac0f37a2f..012f7ee83f8e 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+= clk-starfive-jh71x0.o
+obj-$(CONFIG_CLK_STARFIVE_COMMON)	+= clk-starfive-common.o
 
 obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
 obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-common.c
similarity index 99%
rename from drivers/clk/starfive/clk-starfive-jh71x0.c
rename to drivers/clk/starfive/clk-starfive-common.c
index aebc99264a0b..a12490c97957 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.c
+++ b/drivers/clk/starfive/clk-starfive-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * StarFive JH71X0 Clock Generator Driver
+ * StarFive Clock Generator Driver
  *
  * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
  */
@@ -10,7 +10,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 static struct jh71x0_clk *jh71x0_clk_from(struct clk_hw *hw)
 {
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-common.h
similarity index 97%
rename from drivers/clk/starfive/clk-starfive-jh71x0.h
rename to drivers/clk/starfive/clk-starfive-common.h
index 34bb11c72eb7..1f32f7024e9f 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CLK_STARFIVE_JH71X0_H
-#define __CLK_STARFIVE_JH71X0_H
+#ifndef __CLK_STARFIVE_COMMON_H
+#define __CLK_STARFIVE_COMMON_H
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
index ee4bda14a40e..dc4c278606d7 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -15,7 +15,7 @@
 
 #include <dt-bindings/clock/starfive-jh7100-audio.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* external clocks */
 #define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END + 0)
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 69cc11ea7e33..6bb6a6af9f28 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -15,7 +15,7 @@
 
 #include <dt-bindings/clock/starfive-jh7100.h>
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* external clocks */
 #define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h b/drivers/clk/starfive/clk-starfive-jh7110.h
index 0659adae4d76..6b1bdf860f00 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110.h
+++ b/drivers/clk/starfive/clk-starfive-jh7110.h
@@ -2,7 +2,7 @@
 #ifndef __CLK_STARFIVE_JH7110_H
 #define __CLK_STARFIVE_JH7110_H
 
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
 
 /* top clocks of ISP/VOUT domain from JH7110 SYSCRG */
 struct jh7110_top_sysclk {
-- 
2.34.1


