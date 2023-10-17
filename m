Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845C47CCE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQUeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjJQUeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:34:06 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D293BA;
        Tue, 17 Oct 2023 13:34:05 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6c7bbfb7a73so4174738a34.3;
        Tue, 17 Oct 2023 13:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574844; x=1698179644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRrz5g1aSnyLW5lEPOvcNKexij9vwV1ZcmYt4LIdaa0=;
        b=QSsBa4Wb/oU29C7OdwCQCT8FNQW773dUe90tRb1sT6lGRkutXAjwwJOGbpJFQpjbdl
         VIzI+pge+8PYBrtjVyR6ZXPBdEmbd+Fzt9p3Zs/h6y8jEnMCWQv2qRy/9Sh97J7GM6p1
         gRmjML69cyWxaV13YlXvGn9EpIWLRkZlnyj0pCiFkbrP9PiFJPCqh42iO13L7ZhYbIQi
         49wGWrpVRo4E+YW53ixfGIlFTXkxEX1/EjjVcDJgYNzDnc6qx+wJjg+fzMnpUeU8Ete2
         kYmCfg5ohsH3iSNH9sw4oJ+UgmZqu6RSmZNWeEtqgKlmJd++xXTIWoVjI4Fj4JOSw3cy
         Cd0w==
X-Gm-Message-State: AOJu0YzRyyeoXVFbPZ9eTECEn/4uw6OZTVXMpv3w+nT5igySbf74mc0O
        boGH9KBrXXRCiUMPmtjEiw==
X-Google-Smtp-Source: AGHT+IFQaKQoaiOWi29VFPHOmrVG3na2dpNZRIZ/gBXhMeGnZwm9Ellq+8oszZwYDp/iCkEXOL2NCA==
X-Received: by 2002:a05:6830:71a6:b0:6c0:ef3c:5ab4 with SMTP id el38-20020a05683071a600b006c0ef3c5ab4mr4003506otb.0.1697574844449;
        Tue, 17 Oct 2023 13:34:04 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g20-20020a9d6b14000000b006b99f66444bsm380588otp.71.2023.10.17.13.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:34:03 -0700 (PDT)
Received: (nullmailer pid 2698572 invoked by uid 1000);
        Tue, 17 Oct 2023 20:34:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] spi: stm32: Explicitly include correct DT includes
Date:   Tue, 17 Oct 2023 15:33:51 -0500
Message-ID: <20231017203352.2698326-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Acked-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/spi/spi-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ef665f470c5b..e6e3e4ea29f9 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -13,7 +13,8 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
-- 
2.42.0

