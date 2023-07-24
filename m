Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0561A76010A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGXVTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjGXVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E246139
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D04A61418
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1092C433C7;
        Mon, 24 Jul 2023 21:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690233546;
        bh=JGgmPEEqVjTVXg8adHUHdgecWbQUXlBTTTRnprnv5kk=;
        h=From:To:Cc:Subject:Date:From;
        b=rrkET7gMGOg/ZuZ8cp373jMYhDGUbFOGq9JaX5tHrPrKy0HN5rkVk1OVzkERgTtOb
         jYI8WtSo1fi7fJ3XL+kkxEl1GPt1qglRSzs0HHqUyTOUFqhiLEcmvEyaY1f44QRZBO
         DZo33hzMSP7pZLQMdEan4jcqJklHKMvtXpoSkfYlysJbWWLYKskPcKkIwiYp53oQW3
         S6G316S1Jo0uBxp0tsI6c/ErBJcb+lrpqOgySWmr6ZvpyAZ9Ec4rqh4K8mCxlKyJEb
         chzwNRnRl7egmbxq86yr2+UPhqqXQHhEkODLKJMZyyZKSEaWoGhwdZtWqPANeyW0bK
         nJU1I7pxF9IyA==
Received: (nullmailer pid 805596 invoked by uid 1000);
        Mon, 24 Jul 2023 21:19:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        George McCollister <george.mccollister@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] net: dsa: Explicitly include correct DT includes
Date:   Mon, 24 Jul 2023 15:18:58 -0600
Message-Id: <20230724211859.805481-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Split out can, dsa, wireless, phy/pcs to separate patches
---
 drivers/net/dsa/b53/b53_mdio.c             | 1 +
 drivers/net/dsa/b53/b53_mmap.c             | 1 +
 drivers/net/dsa/hirschmann/hellcreek.c     | 1 -
 drivers/net/dsa/hirschmann/hellcreek_ptp.c | 1 +
 drivers/net/dsa/lan9303-core.c             | 1 +
 drivers/net/dsa/microchip/ksz8863_smi.c    | 3 +++
 drivers/net/dsa/microchip/ksz_common.c     | 2 +-
 drivers/net/dsa/mt7530-mmio.c              | 3 ++-
 drivers/net/dsa/mv88e6xxx/chip.c           | 2 +-
 drivers/net/dsa/ocelot/felix_vsc9959.c     | 1 +
 drivers/net/dsa/ocelot/seville_vsc9953.c   | 3 ++-
 drivers/net/dsa/qca/qca8k-leds.c           | 1 +
 drivers/net/dsa/realtek/realtek-mdio.c     | 2 +-
 drivers/net/dsa/realtek/realtek-smi.c      | 1 -
 drivers/net/dsa/sja1105/sja1105_main.c     | 1 -
 drivers/net/dsa/vitesse-vsc73xx-core.c     | 1 -
 drivers/net/dsa/xrs700x/xrs700x.c          | 2 +-
 17 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.c
index 8b422b298cd5..4d55d8d18376 100644
--- a/drivers/net/dsa/b53/b53_mdio.c
+++ b/drivers/net/dsa/b53/b53_mdio.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/phy.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/brcmphy.h>
 #include <linux/rtnetlink.h>
diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 5db1ed26f03a..5e39641ea887 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -19,6 +19,7 @@
 #include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/b53.h>
diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index af50001ccdd4..720f4e4ed0b0 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/platform_device.h>
 #include <linux/bitops.h>
diff --git a/drivers/net/dsa/hirschmann/hellcreek_ptp.c b/drivers/net/dsa/hirschmann/hellcreek_ptp.c
index 3e44ccb7db84..5249a1c2a80b 100644
--- a/drivers/net/dsa/hirschmann/hellcreek_ptp.c
+++ b/drivers/net/dsa/hirschmann/hellcreek_ptp.c
@@ -9,6 +9,7 @@
  *	    Kurt Kanzenbach <kurt@linutronix.de>
  */
 
+#include <linux/of.h>
 #include <linux/ptp_clock_kernel.h>
 #include "hellcreek.h"
 #include "hellcreek_ptp.h"
diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index ff76444057d2..02e93559d536 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -8,6 +8,7 @@
 #include <linux/regmap.h>
 #include <linux/mutex.h>
 #include <linux/mii.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
diff --git a/drivers/net/dsa/microchip/ksz8863_smi.c b/drivers/net/dsa/microchip/ksz8863_smi.c
index fd6e2e69a42a..5711a59e2ac9 100644
--- a/drivers/net/dsa/microchip/ksz8863_smi.c
+++ b/drivers/net/dsa/microchip/ksz8863_smi.c
@@ -5,6 +5,9 @@
  * Copyright (C) 2019 Pengutronix, Michael Grzeschik <kernel@pengutronix.de>
  */
 
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+
 #include "ksz8.h"
 #include "ksz_common.h"
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b18cd170ec06..a91c1a3a70a0 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -18,8 +18,8 @@
 #include <linux/if_vlan.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/of.h>
 #include <linux/of_mdio.h>
-#include <linux/of_device.h>
 #include <linux/of_net.h>
 #include <linux/micrel_phy.h>
 #include <net/dsa.h>
diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index 1a3d4b692f34..0a6a2fe34e64 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c7d51a539451..8cde36626b79 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -23,7 +23,7 @@
 #include <linux/list.h>
 #include <linux/mdio.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_mdio.h>
 #include <linux/platform_data/mv88e6xxx.h>
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 1c113957fcf4..dce3548dcd05 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -16,6 +16,7 @@
 #include <net/pkt_sched.h>
 #include <linux/iopoll.h>
 #include <linux/mdio.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/time.h>
 #include "felix.h"
diff --git a/drivers/net/dsa/ocelot/seville_vsc9953.c b/drivers/net/dsa/ocelot/seville_vsc9953.c
index 15003b2af264..8f912bda120b 100644
--- a/drivers/net/dsa/ocelot/seville_vsc9953.c
+++ b/drivers/net/dsa/ocelot/seville_vsc9953.c
@@ -2,13 +2,14 @@
 /* Distributed Switch Architecture VSC9953 driver
  * Copyright (C) 2020, Maxim Kochetkov <fido_max@inbox.ru>
  */
+#include <linux/platform_device.h>
 #include <linux/types.h>
 #include <soc/mscc/ocelot_vcap.h>
 #include <soc/mscc/ocelot_sys.h>
 #include <soc/mscc/ocelot.h>
 #include <linux/mdio/mdio-mscc-miim.h>
+#include <linux/mod_devicetable.h>
 #include <linux/of_mdio.h>
-#include <linux/of_platform.h>
 #include <linux/pcs-lynx.h>
 #include <linux/dsa/ocelot.h>
 #include <linux/iopoll.h>
diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index 1261e0bb21ef..e8c16e76e34b 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <net/dsa.h>
 
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 5a8fe707ca25..4310e7793e58 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -20,7 +20,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/overflow.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 1b447d96b9c4..c2bd8bb6c9c2 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -31,7 +31,6 @@
 #include <linux/spinlock.h>
 #include <linux/skbuff.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 3529a565b4aa..b74300d38943 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
-#include <linux/of_device.h>
 #include <linux/pcs/pcs-xpcs.h>
 #include <linux/netdev_features.h>
 #include <linux/netdevice.h>
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ef1a4a7c47b2..4f09e7438f3b 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/bitops.h>
 #include <linux/if_bridge.h>
diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
index fa622639d640..753fef757f11 100644
--- a/drivers/net/dsa/xrs700x/xrs700x.c
+++ b/drivers/net/dsa/xrs700x/xrs700x.c
@@ -7,7 +7,7 @@
 #include <net/dsa.h>
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/netdev_features.h>
 #include <linux/if_hsr.h>
 #include "xrs700x.h"
-- 
2.40.1

