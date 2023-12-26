Return-Path: <linux-kernel+bounces-11360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C6F81E51F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC841C21C20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F99F4B5CD;
	Tue, 26 Dec 2023 05:39:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D444B5AD;
	Tue, 26 Dec 2023 05:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id B98868043;
	Tue, 26 Dec 2023 13:39:22 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:39:22 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:39:16 +0800
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<emil.renner.berthing@canonical.com>, <hal.feng@starfivetech.com>,
	<xingyu.wu@starfivetech.com>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [RFC 03/16] clk: starfive: Rename file name "jh71x0" to "common"
Date: Tue, 26 Dec 2023 13:38:35 +0800
Message-ID: <20231226053848.25089-4-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
References: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

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
 .../{clk-starfive-jh71x0.c =3D> clk-starfive-common.c}      | 4 ++--
 .../{clk-starfive-jh71x0.h =3D> clk-starfive-common.h}      | 4 ++--
 drivers/clk/starfive/clk-starfive-jh7100-audio.c          | 2 +-
 drivers/clk/starfive/clk-starfive-jh7100.c                | 2 +-
 drivers/clk/starfive/clk-starfive-jh7110.h                | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/clk/starfive/{clk-starfive-jh71x0.c =3D> clk-starfive-com=
mon.c} (99%)
 rename drivers/clk/starfive/{clk-starfive-jh71x0.h =3D> clk-starfive-com=
mon.h} (97%)

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index bd29358ffeec..ff8eace36e64 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
=20
-config CLK_STARFIVE_JH71X0
+config CLK_STARFIVE_COMMON
 	bool
=20
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
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefil=
e
index 199ac0f37a2f..012f7ee83f8e 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+=3D clk-starfive-jh71x0.o
+obj-$(CONFIG_CLK_STARFIVE_COMMON)	+=3D clk-starfive-common.o
=20
 obj-$(CONFIG_CLK_STARFIVE_JH7100)	+=3D clk-starfive-jh7100.o
 obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+=3D clk-starfive-jh7100-audio.o
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/sta=
rfive/clk-starfive-common.c
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
=20
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
=20
 static struct jh71x0_clk *jh71x0_clk_from(struct clk_hw *hw)
 {
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/sta=
rfive/clk-starfive-common.h
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
=20
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/c=
lk/starfive/clk-starfive-jh7100-audio.c
index ee4bda14a40e..dc4c278606d7 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -15,7 +15,7 @@
=20
 #include <dt-bindings/clock/starfive-jh7100-audio.h>
=20
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
=20
 /* external clocks */
 #define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END + 0)
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/sta=
rfive/clk-starfive-jh7100.c
index 69cc11ea7e33..6bb6a6af9f28 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -15,7 +15,7 @@
=20
 #include <dt-bindings/clock/starfive-jh7100.h>
=20
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
=20
 /* external clocks */
 #define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h b/drivers/clk/sta=
rfive/clk-starfive-jh7110.h
index 0659adae4d76..6b1bdf860f00 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110.h
+++ b/drivers/clk/starfive/clk-starfive-jh7110.h
@@ -2,7 +2,7 @@
 #ifndef __CLK_STARFIVE_JH7110_H
 #define __CLK_STARFIVE_JH7110_H
=20
-#include "clk-starfive-jh71x0.h"
+#include "clk-starfive-common.h"
=20
 /* top clocks of ISP/VOUT domain from JH7110 SYSCRG */
 struct jh7110_top_sysclk {
--=20
2.34.1


