Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0D77A0256
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjINLS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjINLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:18:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854931FE6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:18:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500c7796d8eso1416919e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690295; x=1695295095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgTaOHBfImHk+QFs8F8yB4KkJMugQjfBX2V5uwaw/P0=;
        b=aTDeko3H2cmVPoDR2YSNl/lLrq7jQ3bzHNc+p6e+gwAxlePJpTicNa0KixqyDLCUEt
         myiUyZWwdMUdgCEL//tSW90A7TushNqjjkK3GESAmQ65a+W6s1x5/hxYAP3LsYoIzyas
         sj4JfWklOIGvByy9PxA8OvM/XKAuhOVePFoqxiRvAl55EEAsrbpY1/0Gn4/d93MFW8Jv
         QN8rxgmyF3rqIQACnpqLFzb60ggP1RryZYRgREBg0C32Ec8VufRyocxgFQfz7cRaHHZY
         qFOYz+QFGyxn6CWTZjvRPG03cbYn+t3pWEgisFwYFS0Z2kdRNHKIf5bcp6Kgt4V6sAzk
         R08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690295; x=1695295095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgTaOHBfImHk+QFs8F8yB4KkJMugQjfBX2V5uwaw/P0=;
        b=iY/03ANlEhcsoo7gvoVXAGh80+myc15qkyriIANIRiyGs0m5/io4a3MWjUE2DnXcnm
         IvIifpgGUONQHyvHbRYUHtvafdGoMHVZ1LyUWxS2tj9lNOR0Kjl2UXnG6Y6tMyt/kxAi
         GF5d272QcMsVw01xrwhannQlrEjw/n2eYmlE3LvHIpbUOs9ytmyGDkLaOf99R1TQizKs
         g/0c3kAP3hYUWN7JjMJSqKtZdtFRuaVrUzSfw2nRy84o7swCtAKD3z4RVEOC6BZoAJmh
         0HaE/DrIioDA9RxagjNOQPILLuP65KTgURlv54FAIZvyJhuKygH5FqBDFr46kML/wMBY
         JyPg==
X-Gm-Message-State: AOJu0Yzq1X/NgRxJKYHpaxw3vxhWe7JwadsRToNXTgZsW6XqMYa85Lu9
        hqJUNn1n6Gu1dt5B7uplJytZzQ==
X-Google-Smtp-Source: AGHT+IHQhK+nElK2gIDtqvOYyMwT+vSbvR3SdvfQ2bS1iSqYmdY9eUO8VZUnxX/es08eft+TEf1dEg==
X-Received: by 2002:a19:651d:0:b0:500:76aa:b962 with SMTP id z29-20020a19651d000000b0050076aab962mr3733875lfb.15.1694690294671;
        Thu, 14 Sep 2023 04:18:14 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id d20-20020ac24c94000000b004fb9536bc99sm233052lfl.169.2023.09.14.04.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:18:14 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 10/17] pmdomain: rockchip: Move Kconfig option to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:18:11 +0200
Message-Id: <20230914111811.586668-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig option belongs closer to the corresponding implementation,
hence let's move it from the soc subsystem to the pmdomain subsystem.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: <linux-rockchip@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig          |  1 +
 drivers/pmdomain/rockchip/Kconfig | 16 ++++++++++++++++
 drivers/soc/rockchip/Kconfig      | 12 ------------
 3 files changed, 17 insertions(+), 12 deletions(-)
 create mode 100644 drivers/pmdomain/rockchip/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index e8181782751c..74066c5daa37 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -9,5 +9,6 @@ source "drivers/pmdomain/imx/Kconfig"
 source "drivers/pmdomain/mediatek/Kconfig"
 source "drivers/pmdomain/qcom/Kconfig"
 source "drivers/pmdomain/renesas/Kconfig"
+source "drivers/pmdomain/rockchip/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchip/Kconfig
new file mode 100644
index 000000000000..b0d70f1a8439
--- /dev/null
+++ b/drivers/pmdomain/rockchip/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+if ARCH_ROCKCHIP || COMPILE_TEST
+
+config ROCKCHIP_PM_DOMAINS
+	bool "Rockchip generic power domain"
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y here to enable power domain support.
+	  In order to meet high performance and low power requirements, a power
+	  management unit is designed or saving power when RK3288 in low power
+	  mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
+
+	  If unsure, say N.
+
+endif
diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index aff2f7e95237..785f60c6f3ad 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -22,18 +22,6 @@ config ROCKCHIP_IODOMAIN
 	  necessary for the io domain setting of the SoC to match the
 	  voltage supplied by the regulators.
 
-config ROCKCHIP_PM_DOMAINS
-	bool "Rockchip generic power domain"
-	depends on PM
-	select PM_GENERIC_DOMAINS
-	help
-	  Say y here to enable power domain support.
-	  In order to meet high performance and low power requirements, a power
-	  management unit is designed or saving power when RK3288 in low power
-	  mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
-
-	  If unsure, say N.
-
 config ROCKCHIP_DTPM
 	tristate "Rockchip DTPM hierarchy"
 	depends on DTPM && m
-- 
2.34.1

