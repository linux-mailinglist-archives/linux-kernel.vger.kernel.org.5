Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A4F75411A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbjGNRs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbjGNRr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:47:56 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF663AAD;
        Fri, 14 Jul 2023 10:47:36 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7872d448c5aso90080739f.0;
        Fri, 14 Jul 2023 10:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356818; x=1691948818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7VrB/uyICw96B5K6NvEYBgGwNedwL6L+mfls+uymQ8=;
        b=E1UtZI/MMZ2+pvGv+j36sGVOxhnV0pyvUeCp6rvvOo3kFrNJsrfY43FRBjjSu0bNpK
         dVRemKPEDNtkAOgYSBhtEIh2saykNPtxFgJtirp84pMtfWYifas1Ngcm6yAR2tk3lSAo
         56dxWl4iP/Q1rip3GenU9czIrKC6cN9Iu9gUbbokkSaBxdQQWUpiea3cRf0CXr5glabm
         W4I0sTc9DRqnvws5Ht5Vp2oFbh4gP1dCm8A36C6TQ1jRBQrsxcJwsOQMmjN7A7PmySJu
         /N7RmlFeRx3ETZvdsajaOVwVATfKT9ZHYOuVVAeSs7oR0cZz9KQfasOPdGmUOgN9BC9z
         d1zQ==
X-Gm-Message-State: ABy/qLYpiJhBTtNofnM7ImZJYIyudGrkZM/iF/nnaSb4g8xqeeIQbP/D
        UzYTyK1cMawbTpp5KlCjtT+RwVG4EA==
X-Google-Smtp-Source: APBJJlHPa7ARnWlzAN+oSyMUyPxH08p9mq7k0HnmtNPaGHWyrvWd0Xaa1kqqGvb4+l55tI35V7nBhA==
X-Received: by 2002:a92:db4b:0:b0:346:7aba:a51 with SMTP id w11-20020a92db4b000000b003467aba0a51mr5353625ilq.28.1689356818427;
        Fri, 14 Jul 2023 10:46:58 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id e11-20020a02a78b000000b0042acf389ac8sm2639495jaj.130.2023.07.14.10.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:46:57 -0700 (PDT)
Received: (nullmailer pid 4058206 invoked by uid 1000);
        Fri, 14 Jul 2023 17:46:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] Input: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:46:31 -0600
Message-Id: <20230714174633.4058096-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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
 drivers/input/keyboard/sun4i-lradc-keys.c | 3 ++-
 drivers/input/keyboard/tm2-touchkey.c     | 1 -
 drivers/input/misc/gpio-vibra.c           | 2 +-
 drivers/input/misc/iqs269a.c              | 2 +-
 drivers/input/misc/iqs626a.c              | 2 +-
 drivers/input/misc/iqs7222.c              | 2 +-
 drivers/input/misc/mma8450.c              | 2 +-
 drivers/input/misc/pm8941-pwrkey.c        | 1 -
 drivers/input/misc/pm8xxx-vibrator.c      | 1 -
 drivers/input/misc/pmic8xxx-pwrkey.c      | 1 -
 drivers/input/misc/pwm-vibra.c            | 2 +-
 drivers/input/misc/sparcspkr.c            | 3 ++-
 drivers/input/serio/apbps2.c              | 2 +-
 drivers/input/serio/i8042-sparcio.h       | 4 +++-
 drivers/input/serio/xilinx_ps2.c          | 4 ++--
 drivers/input/touchscreen/cyttsp5.c       | 2 +-
 drivers/input/touchscreen/ili210x.c       | 2 +-
 drivers/input/touchscreen/iqs5xx.c        | 2 +-
 drivers/input/touchscreen/mms114.c        | 1 -
 drivers/input/touchscreen/pixcir_i2c_ts.c | 2 +-
 drivers/input/touchscreen/ti_am335x_tsc.c | 1 -
 21 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 15c15c0958b0..cb6973e7f1a7 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -21,10 +21,11 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/pm_wakeup.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 75bd3ea51194..0fd761ae052f 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -19,7 +19,6 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
 
diff --git a/drivers/input/misc/gpio-vibra.c b/drivers/input/misc/gpio-vibra.c
index 134a1309ba92..9bc054fdc492 100644
--- a/drivers/input/misc/gpio-vibra.c
+++ b/drivers/input/misc/gpio-vibra.c
@@ -18,7 +18,7 @@
 #include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
index 1272ef7b5794..c0a085639870 100644
--- a/drivers/input/misc/iqs269a.c
+++ b/drivers/input/misc/iqs269a.c
@@ -17,9 +17,9 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/input/misc/iqs626a.c b/drivers/input/misc/iqs626a.c
index 50035c25c3f7..0dab54d3a060 100644
--- a/drivers/input/misc/iqs626a.c
+++ b/drivers/input/misc/iqs626a.c
@@ -19,8 +19,8 @@
 #include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/input/misc/iqs7222.c b/drivers/input/misc/iqs7222.c
index 096b0925f41b..923f63f8c9e1 100644
--- a/drivers/input/misc/iqs7222.c
+++ b/drivers/input/misc/iqs7222.c
@@ -15,8 +15,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
index 76a190b2220b..662b436d765b 100644
--- a/drivers/input/misc/mma8450.c
+++ b/drivers/input/misc/mma8450.c
@@ -11,7 +11,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 
 #define MMA8450_DRV_NAME	"mma8450"
 
diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 74d77d8aaeff..ba747c5b2b5f 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 04cb87efd799..5c288fe7accf 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -7,7 +7,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index 89fb137e3715..c406a1cca5c4 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -12,7 +12,6 @@
 #include <linux/regmap.h>
 #include <linux/log2.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #define PON_CNTL_1 0x1C
 #define PON_CNTL_PULL_UP BIT(7)
diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 2ba035299db8..ce83bf42e233 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -15,7 +15,7 @@
 #include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/pwm.h>
diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index cdcb7737c46a..e5dd84725c6e 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -9,7 +9,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include <asm/io.h>
diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
index 513d96e40e0e..3f6866d39b86 100644
--- a/drivers/input/serio/apbps2.c
+++ b/drivers/input/serio/apbps2.c
@@ -14,11 +14,11 @@
  * Contributors: Daniel Hellstrom <daniel@gaisler.com>
  */
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
 #include <linux/module.h>
 #include <linux/serio.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/device.h>
 #include <linux/delay.h>
diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index c712c1fe0605..b68793bf05c8 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -2,7 +2,9 @@
 #ifndef _I8042_SPARCIO_H
 #define _I8042_SPARCIO_H
 
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 
 #include <asm/io.h>
diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 960d7601fbc8..f3d28da70b75 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -14,10 +14,10 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #define DRIVER_NAME		"xilinx_ps2"
 
diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index b461ded946fc..db5a885ecd72 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -18,8 +18,8 @@
 #include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <asm/unaligned.h>
 
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index f7cd773f7292..ad6828e4f2e2 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -8,8 +8,8 @@
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscreen/iqs5xx.c
index 0aa9d6492df8..b4768b66eb10 100644
--- a/drivers/input/touchscreen/iqs5xx.c
+++ b/drivers/input/touchscreen/iqs5xx.c
@@ -23,8 +23,8 @@
 #include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
 
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index ac12494c7930..6109cf7e779a 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -7,7 +7,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/i2c.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 554e179c2e48..c4f0d0210599 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -13,8 +13,8 @@
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 
 #define PIXCIR_MAX_SLOTS       5 /* Max fingers supported by driver */
diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index decf2d24a115..9aa4e35fb4f5 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -25,7 +25,6 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/sort.h>
 #include <linux/pm_wakeirq.h>
 
-- 
2.40.1

