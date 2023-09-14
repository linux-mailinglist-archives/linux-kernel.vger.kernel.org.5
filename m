Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353217A0264
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjINLTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbjINLTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:19:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74C31FD3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500c37d479aso1376390e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690371; x=1695295171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3KM4mPZd+qqdQiD2rn9oFHhMiK2AO9uYvTlNg8D3ph0=;
        b=kAgjV/Sm0ZJSSeejx+pR8ZEO/9Fd8I/D6ClkZeHK3sNo+G4royQctIHKTkx7HrraWV
         V3xTAbM4Hag0T+X6s0fKjH0WZkthWTzcQjE6l5/wDoSBgkh9ghJCSiVw2ZlGt3Zy8t+2
         DOHPVU1VidAAQJJrU1uyLsF2TQma0whIXf2zTObP+bwnWzRry8CmzfoKkJPnkjpNGfGd
         Tp/Qt6NrPbl0UKijaWnY8pVhhMeIWzW1bz2VAwe5ItpLAUeNtvTD+D1UD90lixJES7RY
         NGVwuk9fY2poHF600kvotrdB2ga/c3O2+D4r64IC7TMagKG5SX5MGQ7Vt2pmE8s0eIsh
         OWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690371; x=1695295171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KM4mPZd+qqdQiD2rn9oFHhMiK2AO9uYvTlNg8D3ph0=;
        b=WxW9TXsk7D9rFIUYoqo56nVA6i8GY40lrdYOs/FtZrdTixM/nywQ3eJspJ+oLOIm2l
         x7wDLdPLfEo28cqT/6ntkGxfNO8OAE6aNt5YmlzEVh2Kx3TnRx1cmkTGfIcohcrihb87
         kzkahRYkwLtVwFV26t6jUzp1GFAbGKCWBedsmjXFnxomxydLgBcLbJUaR+3xN1IhYVHQ
         CTgSKNVSB/OfqWlJsOUh8vAtx7KMhkkLfM+nvHmeCAskfz8CIZghbxluUEHpyH/WGbpa
         PCtLTa2o+74IjHLRFLEnr3kpV8GdHKlW7C1oZBor8upbTvntKnVHPMtZbrf65P4jGAqL
         JwLA==
X-Gm-Message-State: AOJu0Yz9Ivj8Xm+R/9MR+mhjrZQpvlC+bWYLjw59lCE3cz/roY/wROWk
        022obifaup8lT9nXUzuB19xWIA==
X-Google-Smtp-Source: AGHT+IECqMBho28Duuu16/mg7efrXmaic13mRC0RWXhvTwikNjeVVVzG7pitDe8XRgpx3IGrnF79yA==
X-Received: by 2002:a05:6512:e83:b0:4fd:faf0:6591 with SMTP id bi3-20020a0565120e8300b004fdfaf06591mr5084981lfb.10.1694690371089;
        Thu, 14 Sep 2023 04:19:31 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u19-20020ac25193000000b004fe5688b5dcsm233315lfi.150.2023.09.14.04.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:19:30 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/17] pmdomain: ti: Move and add Kconfig options to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:19:28 +0200
Message-Id: <20230914111928.586804-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI_SCI_PM_DOMAINS Kconfig option belongs closer to its corresponding
implementation, hence let's move it from the soc subsystem to the pmdomain
subsystem.

While at it, let's also add a Kconfig option the omap_prm driver, rather
than using ARCH_OMAP2PLUS directly.

Cc: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig     |  1 +
 drivers/pmdomain/ti/Kconfig  | 22 ++++++++++++++++++++++
 drivers/pmdomain/ti/Makefile |  2 +-
 drivers/soc/ti/Kconfig       | 12 ------------
 4 files changed, 24 insertions(+), 13 deletions(-)
 create mode 100644 drivers/pmdomain/ti/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 08a7d43cb884..785d177b0ad7 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -15,5 +15,6 @@ source "drivers/pmdomain/st/Kconfig"
 source "drivers/pmdomain/starfive/Kconfig"
 source "drivers/pmdomain/sunxi/Kconfig"
 source "drivers/pmdomain/tegra/Kconfig"
+source "drivers/pmdomain/ti/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
new file mode 100644
index 000000000000..67c608bf7ed0
--- /dev/null
+++ b/drivers/pmdomain/ti/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config OMAP2PLUS_PRM
+	bool
+	depends on ARCH_OMAP2PLUS
+	default ARCH_OMAP2PLUS
+
+if SOC_TI
+
+config TI_SCI_PM_DOMAINS
+	tristate "TI SCI PM Domains Driver"
+	depends on TI_SCI_PROTOCOL
+	depends on PM_GENERIC_DOMAINS
+	help
+	  Generic power domain implementation for TI device implementing
+	  the TI SCI protocol.
+
+	  To compile this as a module, choose M here. The module will be
+	  called ti_sci_pm_domains. Note this is needed early in boot before
+	  rootfs may be available.
+
+endif
diff --git a/drivers/pmdomain/ti/Makefile b/drivers/pmdomain/ti/Makefile
index 69580afbb436..af6cd056c158 100644
--- a/drivers/pmdomain/ti/Makefile
+++ b/drivers/pmdomain/ti/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_ARCH_OMAP2PLUS)		+= omap_prm.o
+obj-$(CONFIG_OMAP2PLUS_PRM)		+= omap_prm.o
 obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 2cae17b65fd9..1a93001c9e36 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -50,18 +50,6 @@ config WKUP_M3_IPC
 	  to communicate and use the Wakeup M3 for PM features like suspend
 	  resume and boots it using wkup_m3_rproc driver.
 
-config TI_SCI_PM_DOMAINS
-	tristate "TI SCI PM Domains Driver"
-	depends on TI_SCI_PROTOCOL
-	depends on PM_GENERIC_DOMAINS
-	help
-	  Generic power domain implementation for TI device implementing
-	  the TI SCI protocol.
-
-	  To compile this as a module, choose M here. The module will be
-	  called ti_sci_pm_domains. Note this is needed early in boot before
-	  rootfs may be available.
-
 config TI_K3_RINGACC
 	tristate "K3 Ring accelerator Sub System"
 	depends on ARCH_K3 || COMPILE_TEST
-- 
2.34.1

