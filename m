Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E4A7540D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjGNRo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbjGNRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:44:47 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400563C01;
        Fri, 14 Jul 2023 10:44:32 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-78362f57500so88976239f.3;
        Fri, 14 Jul 2023 10:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356671; x=1691948671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKCJUp4CqCgC2RTMueqPi4f10D3ol+zQTAqiaFzYSUI=;
        b=OH1QJ40p0QRMc78EeWuZHI59DocxOZy5lkyAEkmMt+kUT38YoTeaEoUA1vN1/kCGDq
         qQnDEk2mE7Av5jfXCCU3LDHoahfldmzyHkwKDz05lRY4CB5loNOORMi4Oubre7ZbH+sA
         U8D8qIMyiz8/g3NQIVxcXLQQZIhr4rubL12fCquFMSVzlBv0gfqW4JQbG7IJi+zQthS0
         btluRVdLAEaNs1OjBFQBquRLNRh3Rdpp7NpuzRyJwA3rGLFUFq7I6PQj01G33HSq2Aqa
         3CTjzNpP3k+s0FXHRQ+TyB5JhgvhTMfEFeKT/8SexUR8uVdHRrjai/tlYF82fPl153t6
         Wu9g==
X-Gm-Message-State: ABy/qLab58IX8l21v0uVjZUmMPYq4CCL8fuVUczu+53lgJs+FwzfO5sb
        6zo9gjd9bDboTQfv+bJkKQ==
X-Google-Smtp-Source: APBJJlEyccik+TIwQfOddVchGfwmKZ7WoQdwb497EuKnOfrzKhIDHTtwjajstHQLl9YBsyUSMZLMNw==
X-Received: by 2002:a5e:c010:0:b0:783:58d1:823a with SMTP id u16-20020a5ec010000000b0078358d1823amr5981939iol.9.1689356671351;
        Fri, 14 Jul 2023 10:44:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w11-20020a6bd60b000000b00787496dad4bsm1741226ioa.49.2023.07.14.10.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:44:30 -0700 (PDT)
Received: (nullmailer pid 4054490 invoked by uid 1000);
        Fri, 14 Jul 2023 17:44:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH] devfreq: imx: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:44:25 -0600
Message-Id: <20230714174425.4054393-1-robh@kernel.org>
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
 drivers/devfreq/imx-bus.c         | 2 +-
 drivers/devfreq/imx8m-ddrc.c      | 2 +-
 drivers/devfreq/mtk-cci-devfreq.c | 1 -
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index a727067980fb..86850b7dea09 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -7,7 +7,7 @@
 #include <linux/devfreq.h>
 #include <linux/device.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index 16636973eb10..e1348490c8aa 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -3,9 +3,9 @@
  * Copyright 2019 NXP
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/devfreq.h>
 #include <linux/pm_opp.h>
diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 6354622eda65..83a73f0ccd80 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -8,7 +8,6 @@
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 503376b894b6..4a4f0106ab9d 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
-- 
2.40.1

