Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41BA7A0240
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjINLRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjINLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:17:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE63C1A5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:17:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5007616b756so1355424e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694690226; x=1695295026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JMk7fcL+OM7TMTCrC+x1UWkNtvLf41klCSKq8e0KE7Y=;
        b=GmqdCGshZlWFY58PPp8zx1oeSt2zroYraJhpBBpM+i57p3/7W2vIvdi2CGgcSVWyeV
         nOEH84ulKPZNM2FvOZTI0H/L/0mE71ISAjUkorXep7l0JIopurLfyf8H+F8OLkQhPoQT
         BU3XzLd7Zp2/EKn+NmT2BuDYFxCHeVkMsMQsST06vYn0DtOD77T8TWbPFt9ZDNcZteiz
         g9o9j5NeNmg93dv7094v0x0tfOqWH3M2TaaP3A9vXa7I1eRKh2G/RQRSdUBxc9y0DWg4
         cxj52aGb+50cLlhPTJvL5S2r+oPxuviUWaAwGfhf54NkwtglVCoTwk0hJai+kub/EGIi
         hkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690226; x=1695295026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMk7fcL+OM7TMTCrC+x1UWkNtvLf41klCSKq8e0KE7Y=;
        b=FPmjpheiqqZ/d7qBEX9Piaz+s9Eu63s3Um4kWjXMAzSIUUpqJ7aM/lGRNHFsghWjT1
         8HOr0F+a2VXsWMt+OqBGit1EGH6V6Mg+/TciNghZSW7o6HFA43YHfpXZMRlAVhUkPCkX
         cXBvaLpgIKoXc3RzMgO84Rit261jZdU5+BXUhR7suqpg7ALx6ezgGD8siXHvXgWzdgGN
         +pS971/GeCNKcb7NkTufrP/QaHPIWdqIjFD3rJjyF29cARHsB+8qP3DecLYziiaYwJNf
         fdUbNX1OfIZKVUPFqptyKs8JUCsSk67QFHFE2ikummQekLRUGSe5tSqJRrIq2HC6gku2
         YnkA==
X-Gm-Message-State: AOJu0YxywOcvuPNK3tD3HV7WK7OFWgMZiisaGWFU8OeK2GVxR0S019Ta
        IB91KFz2J52IUks1rxLGc48zfA==
X-Google-Smtp-Source: AGHT+IEHCRZ8RnlKrel3ZKeQ/pul7iLzreILlx20wrdZdHBApccysL2Xr01SwAAI3n4m5UV7sCVJ3Q==
X-Received: by 2002:a19:6918:0:b0:4fb:9f93:365f with SMTP id e24-20020a196918000000b004fb9f93365fmr3772353lfc.38.1694690226095;
        Thu, 14 Sep 2023 04:17:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id c5-20020a197605000000b004edc72be17csm235958lff.2.2023.09.14.04.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:17:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 03/17] pmdomain: amlogic: Move Kconfig options to the pmdomain subsystem
Date:   Thu, 14 Sep 2023 13:17:02 +0200
Message-Id: <20230914111702.586501-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig options belongs closer to the corresponding implementations,
hence let's move them from the soc subsystem to the pmdomain subsystem.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: <linux-amlogic@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig         |  1 +
 drivers/pmdomain/amlogic/Kconfig | 39 ++++++++++++++++++++++++++++++++
 drivers/soc/amlogic/Kconfig      | 35 ----------------------------
 3 files changed, 40 insertions(+), 35 deletions(-)
 create mode 100644 drivers/pmdomain/amlogic/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 8acb10bcdec9..07d2f8165abe 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -2,5 +2,6 @@
 menu "Power Domains Support"
 
 source "drivers/pmdomain/actions/Kconfig"
+source "drivers/pmdomain/amlogic/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/amlogic/Kconfig b/drivers/pmdomain/amlogic/Kconfig
new file mode 100644
index 000000000000..ee1affffbce6
--- /dev/null
+++ b/drivers/pmdomain/amlogic/Kconfig
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Amlogic Power Domains"
+
+config MESON_GX_PM_DOMAINS
+	tristate "Amlogic Meson GX Power Domains driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on PM && OF
+	default ARCH_MESON
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  Say yes to expose Amlogic Meson GX Power Domains as
+	  Generic Power Domains.
+
+config MESON_EE_PM_DOMAINS
+	tristate "Amlogic Meson Everything-Else Power Domains driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on PM && OF
+	default ARCH_MESON
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
+	  Generic Power Domains.
+
+config MESON_SECURE_PM_DOMAINS
+	tristate "Amlogic Meson Secure Power Domains driver"
+	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
+	depends on PM && OF
+	depends on HAVE_ARM_SMCCC
+	default ARCH_MESON
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  Support for the power controller on Amlogic A1/C1 series.
+	  Say yes to expose Amlogic Meson Secure Power Domains as Generic
+	  Power Domains.
+
+endmenu
diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index 174a9b011461..d08e398bdad4 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -26,41 +26,6 @@ config MESON_GX_SOCINFO
 	  Say yes to support decoding of Amlogic Meson GX SoC family
 	  information about the type, package and version.
 
-config MESON_GX_PM_DOMAINS
-	tristate "Amlogic Meson GX Power Domains driver"
-	depends on ARCH_MESON || COMPILE_TEST
-	depends on PM && OF
-	default ARCH_MESON
-	select PM_GENERIC_DOMAINS
-	select PM_GENERIC_DOMAINS_OF
-	help
-	  Say yes to expose Amlogic Meson GX Power Domains as
-	  Generic Power Domains.
-
-config MESON_EE_PM_DOMAINS
-	tristate "Amlogic Meson Everything-Else Power Domains driver"
-	depends on ARCH_MESON || COMPILE_TEST
-	depends on PM && OF
-	default ARCH_MESON
-	select PM_GENERIC_DOMAINS
-	select PM_GENERIC_DOMAINS_OF
-	help
-	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
-	  Generic Power Domains.
-
-config MESON_SECURE_PM_DOMAINS
-	tristate "Amlogic Meson Secure Power Domains driver"
-	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
-	depends on PM && OF
-	depends on HAVE_ARM_SMCCC
-	default ARCH_MESON
-	select PM_GENERIC_DOMAINS
-	select PM_GENERIC_DOMAINS_OF
-	help
-	  Support for the power controller on Amlogic A1/C1 series.
-	  Say yes to expose Amlogic Meson Secure Power Domains as Generic
-	  Power Domains.
-
 config MESON_MX_SOCINFO
 	bool "Amlogic Meson MX SoC Information driver"
 	depends on (ARM && ARCH_MESON) || COMPILE_TEST
-- 
2.34.1

