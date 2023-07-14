Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F66754248
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbjGNSKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjGNSKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:10:13 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7D30E3;
        Fri, 14 Jul 2023 11:09:43 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-403a7066d9bso14486211cf.3;
        Fri, 14 Jul 2023 11:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689358090; x=1691950090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUGvrZ4SNzSbcOr0/Bv9oR2pfXE6QplZ6flVtj8X1o4=;
        b=bxB9dPwCpabbnw9/Pk9UODE7SpjG9mLiber2JH969XN9DNR21jon+SyYV5fBU6J5CP
         hM+r7D4UKzllOpziK9atFXLxq1JIp3hlSgPub2n8hmKx8YbaXXLBPtd8gWiu+CI0WGzp
         CvnppowZAcWhgeCX8a68O95REBPC3QQdb9eX0lK/xVMTDQWobVvCftel2nQ4PXgNHWfR
         dF+TqE1y/0AGqtwFMm9In9Dk2xe6926QNzosBICBLJrcNWuGKVtqGk1F5oTcuGIxFcUa
         0c6n9ZiLLZguej3AaI80qOrQ5KzcfiOCOMH9AQ3haOBDRE6yixqYaddCFvrJ3EGMQVk9
         ZRQA==
X-Gm-Message-State: ABy/qLa7j+SGuah0u+VoKGRCXXDLC5PxS55gPgcf0rfzxPWAjc1Ps450
        YwIio0taQaiMJ8jnyMlTWjHlffAHpXwk
X-Google-Smtp-Source: APBJJlEye8ahqaN5k4RFFRcqcmMtxTr6BroCabiANYEE10xONTgVediAHw+dhnaL+ixFAcKf/lFP9Q==
X-Received: by 2002:a92:d952:0:b0:33a:a6de:65be with SMTP id l18-20020a92d952000000b0033aa6de65bemr4775196ilq.21.1689357038778;
        Fri, 14 Jul 2023 10:50:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c3-20020a92d3c3000000b003460b456030sm2906739ilh.60.2023.07.14.10.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:50:38 -0700 (PDT)
Received: (nullmailer pid 4065092 invoked by uid 1000);
        Fri, 14 Jul 2023 17:50:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ufs: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:50:18 -0600
Message-Id: <20230714175018.4064957-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/ufs/host/ufs-mediatek.c | 1 +
 drivers/ufs/host/ufs-renesas.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index e68b05976f9e..aceb3747f7b8 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
diff --git a/drivers/ufs/host/ufs-renesas.c b/drivers/ufs/host/ufs-renesas.c
index f8a5e79ed3b4..49f7bafc7d55 100644
--- a/drivers/ufs/host/ufs-renesas.c
+++ b/drivers/ufs/host/ufs-renesas.c
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <ufs/ufshcd.h>
 
-- 
2.40.1

