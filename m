Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2C57BCEA7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344799AbjJHN4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:56:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD558F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 06:56:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b2cee40de8so806362666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696773390; x=1697378190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9nZ3UEZX/H5fd+AnU4563AsWAEhqsNM6T83YJUnEb/g=;
        b=APjUPt80kukyRaCmTqO7nIuG/x+j6GbTT2zuhH9njaMDntlRTT6YcD021S4UTphe5p
         Lg88h0En6XiLldnqsIC/PUZILndfu5WPZODvN+11tsTK2FX+PlhIvwfIqeC4TZYufOph
         P0lFf3KlCjDYYh9hsDM8+x+2/qV2OUy2PEsY5KCYs4ybfQiPpL/+FypeOr9GWpK8uurl
         98qWVltyRAOLZccyJYtUL1PsMmeh1K0un2H5zGKHV1v0XR/O6qflWjHNAs/9XsfVTstK
         nEhJh6dW7EnVp57JNHv+u84XSJ2D4b3ciXEG7YNXg/vv2SOQFjiRU7dVEJFqz9jKtIoY
         KUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696773390; x=1697378190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nZ3UEZX/H5fd+AnU4563AsWAEhqsNM6T83YJUnEb/g=;
        b=HsYEGy9vJVFhfGexywC3Tj5PyOPFbIF2pfexcqt9x6EUfhV3MVZ5Rcf36GXiBpMa0V
         aG9WkMxemLfPLe0eiEBW4oAVpMJ+4JLUFoMOSvRYfxYY9kicn5y++VW8YjLzFy2TSWHa
         zIccjtkc4LCqiB6wUZCxTFzwgbG8UJYehPOhXro+2nHil83xc60eRyGMB54hzxLt6igi
         0jwXT80NzDBb8oEnNol+RYA+dZDX99rNb9j71XGmpuAI95fWSxLoR2qSSz0/MyFoy1re
         gEEy7QGeVhblMrNsZEo/DMWRV+TfjR8ed2Q+UmOrH19afyNGozpZmsqopEurxbDrcY1i
         f6KA==
X-Gm-Message-State: AOJu0YzhAEKPNIFeH/wlUcRMuX8sigHD0IK94kGUa9rjYY0iIx0r67jK
        zJ1VX/0b79AvFEqJ+jdP9vI=
X-Google-Smtp-Source: AGHT+IG8Rly7FzpbJ/g1gH4vMA56Ssf7FxPsRBhdP2hwm1MPeAcX9KH+JQVvGbdQ+SP+Lw+vGqvBBw==
X-Received: by 2002:a17:907:2d8c:b0:9ad:93c8:c483 with SMTP id gt12-20020a1709072d8c00b009ad93c8c483mr7845988ejc.2.1696773389834;
        Sun, 08 Oct 2023 06:56:29 -0700 (PDT)
Received: from dell.intranet (77-255-201-154.dynamic.inetia.pl. [77.255.201.154])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b00992ea405a79sm5513503ejb.166.2023.10.08.06.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 06:56:29 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ASoC: ti: ams-delta: Allow it to be test compiled
Date:   Sun,  8 Oct 2023 15:53:10 +0200
Message-ID: <20231008135601.542356-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is now built only when MACH_AMS_DELTA is selected, which
requires a very specific selection of ARCH settings.  As a consequence, it
gets very little attention from build-bots, if not none.

Drop the driver dependency on <asm/mach-types.h>, no longer required since
conversion to snd_soc_register_card() and drop of machine_is_ams_delta().
With that in place, allow the driver to be built in any environment as
long as COMPILE_TEST is selected.  Take care of not selecting
SND_SOC_OMAP_MCBSP if COMMON_CLK is not selected.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 sound/soc/ti/Kconfig     | 5 +++--
 sound/soc/ti/ams-delta.c | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 593be22503b5..e22e41af3226 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -125,8 +125,9 @@ config SND_SOC_OMAP_ABE_TWL6040
 
 config SND_SOC_OMAP_AMS_DELTA
 	tristate "SoC Audio support for Amstrad E3 (Delta) videophone"
-	depends on MACH_AMS_DELTA && TTY
-	select SND_SOC_OMAP_MCBSP
+	depends on MACH_AMS_DELTA || COMPILE_TEST
+	depends on TTY
+	select SND_SOC_OMAP_MCBSP if COMMON_CLK
 	select SND_SOC_CX20442
 	help
 	  Say Y  or M if you want to add support  for SoC audio device
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index 371943350fdf..7436cca2d2e0 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -16,8 +16,6 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 
-#include <asm/mach-types.h>
-
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap-mcbsp.h"
-- 
2.42.0

