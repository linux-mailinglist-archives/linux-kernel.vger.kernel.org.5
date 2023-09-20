Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FDA7A8D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjITULI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjITULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:11:01 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2B0CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=8RIrRGujsnsww+/iQckIBpKPuIO
        G6p9i3F7bdsk5O7I=; b=agMesX032pc0Xecq+VevRAaSSZSHAncbr2wQcQ8M5ug
        F+6BUb8ZiOh74GhH3tErKanKqBLQv3lo+rhF8jzHZSC0hONS8mFcokVv5DF/2dCA
        Gs8xnW7r6hs/kf1IrA+xRcbpW3mM4+kX/t4UoJg5H2LANfNjmsBwWZ3YBw9fbuvP
        YHdCIxkFs3cu5fMep0PftdyW0g+dzWdGdlRLLDm6WgsW6FzkdSms36hRQ8D6ueX2
        LPIxZ43ORqcCEnj/+xjUiad/2xpW5wO1/rsDA8A8MWBuwShMwDlUbXBhG96wkjYQ
        2acsRI/3txO3RQ/HVz0NQDtd9tEX7NNErVoIqIgtn2w==
Received: (qmail 720323 invoked from network); 20 Sep 2023 22:10:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Sep 2023 22:10:45 +0200
X-UD-Smtp-Session: l3s3148p1@EHd5+M8FtskujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 5/6] net: cpmac: remove driver to prepare for platform removal
Date:   Wed, 20 Sep 2023 22:10:31 +0200
Message-Id: <20230920201035.3445-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AR7 is going to be removed from the Kernel, so remove its networking
support in form of the cpmac driver. This allows us to remove the
platform because this driver includes a platform specific header.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 MAINTAINERS                      |    6 -
 drivers/net/ethernet/ti/Kconfig  |    9 +-
 drivers/net/ethernet/ti/Makefile |    1 -
 drivers/net/ethernet/ti/cpmac.c  | 1251 ------------------------------
 4 files changed, 1 insertion(+), 1266 deletions(-)
 delete mode 100644 drivers/net/ethernet/ti/cpmac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bdd6e7ce962d..00063d14c70b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5309,12 +5309,6 @@ M:	Bence Csókás <bence98@sch.bme.hu>
 S:	Maintained
 F:	drivers/i2c/busses/i2c-cp2615.c
 
-CPMAC ETHERNET DRIVER
-M:	Florian Fainelli <f.fainelli@gmail.com>
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	drivers/net/ethernet/ti/cpmac.c
-
 CPU FREQUENCY DRIVERS - VEXPRESS SPC ARM BIG LITTLE
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 M:	Sudeep Holla <sudeep.holla@arm.com>
diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 88b5b1b47779..7a99a86888e9 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_TI
 	bool "Texas Instruments (TI) devices"
 	default y
-	depends on PCI || EISA || AR7 || ARCH_DAVINCI || ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3
+	depends on PCI || EISA || ARCH_DAVINCI || ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -176,13 +176,6 @@ config TLAN
 
 	  Please email feedback to <torben.mathiasen@compaq.com>.
 
-config CPMAC
-	tristate "TI AR7 CPMAC Ethernet support"
-	depends on AR7
-	select PHYLIB
-	help
-	  TI AR7 CPMAC Ethernet support
-
 config TI_ICSSG_PRUETH
 	tristate "TI Gigabit PRU Ethernet driver"
 	select PHYLIB
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 34fd7a716ba6..e38ec9d6c99b 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
 obj-$(CONFIG_TI_CPSW_SWITCHDEV) += cpsw-common.o
 
 obj-$(CONFIG_TLAN) += tlan.o
-obj-$(CONFIG_CPMAC) += cpmac.o
 obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
 ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
 obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
diff --git a/drivers/net/ethernet/ti/cpmac.c b/drivers/net/ethernet/ti/cpmac.c
deleted file mode 100644
index 80eeeb463c4f..000000000000
-- 
2.35.1

