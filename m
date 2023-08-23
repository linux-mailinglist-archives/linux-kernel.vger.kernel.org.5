Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9220785381
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjHWJHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjHWI7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:59:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5CB1BC8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:55:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c353a395cso713391666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692780952; x=1693385752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYGyGHMZwBxdZ1RQTk/EEbCraB4/0nD5+ya3KFYbydA=;
        b=zrywOA/hGJM0tQr04pvblm2mnQ/OoscDLbdDxFolm46XWpN9mcZ2c58rQ5jm+GBSdl
         Pvopgy4l7Ut/PUxHQH05+kbrdIYFeOIGOOTnmp/R8cK0ufiZl2vaAFadbIoPz1LJ9gT0
         yhsVNikPAaObvRiMLhwzU0leI8UY+VHhpds33hpSJ4fSz0BHAO+RXyn1hk98GizB7psq
         AX6aHIMnbjs3S7hfqb+ruPgsK/t2nn0ONjoU7WS3z/p6+h1KHSnd+sYDTrn2hJglswP3
         uwfLxLjDMFSTcHPDTI9fYKG6LL/qHF+v8CcOPtWUgiGsS7qUikI8+QAM4nm3i5FgDTEc
         QL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780952; x=1693385752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYGyGHMZwBxdZ1RQTk/EEbCraB4/0nD5+ya3KFYbydA=;
        b=dp09YROAwlCC73F7m/+nrCA4e0LUAwaYZ+3qkr2sDxiXMMPm3f/L5A/Hmq05ZzpFmV
         g8+PqCr+Z6CFRkZikMq29mE+et1P6GViEXwqY906e39ZVay9apDb1r5cEhOu1Pl7l2Ok
         xSpKVHELhfrNwYAp/fx/EekaUNCi+7Jcvpy9hgatvTTk1cRkUWPzlksiSEWkGgQffVzz
         1aaZe4RXB5b/TBFqYZIDfiQrjjgLFHNmog1+r/tuWrbr0zIyLixldiaC8vYmazPJdilc
         rHrxA5KiwO109FjL1emXehIM5LwsL1uKQ0517jmerEM2eS++cvDgEbrn5GjeITGoxND+
         BHwg==
X-Gm-Message-State: AOJu0YyBNxBzmTaq/9QQ0BMLeAmO+yHtaY2LmQX7GehECOCkSdd46Xxp
        4jf6QASRSHCpRzlptpHQzZzljA==
X-Google-Smtp-Source: AGHT+IEvHUcT/doZpFo+FtdyhmCu2TD96+TXGBsn4uRWu6N2tGNhvyrNls0sicSwD5Dbeg8MvBxR3w==
X-Received: by 2002:a17:906:2250:b0:99b:ed18:7a10 with SMTP id 16-20020a170906225000b0099bed187a10mr9473272ejr.36.1692780952060;
        Wed, 23 Aug 2023 01:55:52 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id j26-20020a170906255a00b009a1e0349c4csm566862ejb.23.2023.08.23.01.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:55:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pinctrl: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 10:55:46 +0200
Message-Id: <20230823085546.116494-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/license-rules.rst and checkpatch expect the SPDX
identifier syntax for multiple licenses to use capital "OR".  Correct it
to keep consistent format and avoid copy-paste issues.

Correct also the placement of SPDX identifier in pinctrl-meson-axg
files:

  WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 3 +--
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c     | 3 +--
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 2 +-
 drivers/pinctrl/pinctrl-mlxbf3.c              | 2 +-
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
index 80c43683c789..ae3f8d0da05f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Second generation of pinmux driver for Amlogic Meson-AXG SoC.
  *
@@ -6,8 +7,6 @@
  *
  * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
  * Author: Xingyu Chen <xingyu.chen@amlogic.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ or MIT)
  */
 
 /*
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h
index aa79d7ecee00..67147ebaef1b 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
 /*
  * Copyright (c) 2017 Baylibre SAS.
  * Author:  Jerome Brunet  <jbrunet@baylibre.com>
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index d249a035c2b9..6667c9d0238f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Pin controller and GPIO driver for Amlogic Meson AXG SoC.
  *
  * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
  * Author: Xingyu Chen <xingyu.chen@amlogic.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ or MIT)
  */
 
 #include <dt-bindings/gpio/meson-axg-gpio.h>
diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
index 3cd86d6a0a60..2c17891ba6a9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Pin controller and GPIO driver for Amlogic Meson G12A SoC.
  *
diff --git a/drivers/pinctrl/pinctrl-mlxbf3.c b/drivers/pinctrl/pinctrl-mlxbf3.c
index d9944e6a0af9..903606b64d2f 100644
--- a/drivers/pinctrl/pinctrl-mlxbf3.c
+++ b/drivers/pinctrl/pinctrl-mlxbf3.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 /* Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES */
 
 #include <linux/bitfield.h>
-- 
2.34.1

