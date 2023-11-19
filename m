Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D031C7F0577
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjKSKpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjKSKpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:45:30 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE86D56;
        Sun, 19 Nov 2023 02:45:26 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-32d9d8284abso2269940f8f.3;
        Sun, 19 Nov 2023 02:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700390724; x=1700995524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uy7JYUOTRdSJldSNKwdRHiPwhZnAINoOplh1pqVKi5s=;
        b=KyC2okvCCG//0R562kJPpV+yY+8n4UTRXfvJL/vub5BaG16KVpO3qoOz6pkDktgDFc
         24G0S5ZN2+QIcHL6wdNCDqGj0MzXb56KsDvAj0J21Ymx1y8bzZlSPuXjQHMgy/7nkkc+
         kQ36ufZ1BfbZItk3+6hUa0nDKycPozrbse0yw49qllRw4TnL8MD+Ej//ig/ltfm4esrK
         pthdDHJucRCiOG3IjEaycdtm8X0+ic8B2zTUAFv+iR/xxKL66XsGTjlJaPfu0CeD24XZ
         GEvfE98tflhnzHF/ev4ryu2onFdsqaEqY4Bnr63coifzKVbvDEjgbej8uugsi46AwAy9
         fRag==
X-Gm-Message-State: AOJu0YyBuYssfFAdduLBaD3hKW83nsIXmdQoX4Yf4hbWQIP7MSoO2zxU
        yxg59TECp9TdnmJhYGZpDdU=
X-Google-Smtp-Source: AGHT+IEC7OHQQ63+OIiNP/Y2msXT2JNv/AQECBNiGuXXWvbCMXs8Ertliu/zFXa6ljnqxG8GsPh0NQ==
X-Received: by 2002:adf:d1c6:0:b0:332:c6be:f327 with SMTP id b6-20020adfd1c6000000b00332c6bef327mr127636wrd.61.1700390723581;
        Sun, 19 Nov 2023 02:45:23 -0800 (PST)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id az30-20020adfe19e000000b00332c36b6563sm1502211wrb.101.2023.11.19.02.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:45:22 -0800 (PST)
From:   Lucas Tanure <tanure@linux.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH] ASoC: fsl_mqs: Remove duplicate linux/of.h header
Date:   Sun, 19 Nov 2023 10:45:14 +0000
Message-ID: <20231119104514.25536-1-tanure@linux.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/of.h as is included more than once.
Reported by make includecheck.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 sound/soc/fsl/fsl_mqs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index f2d74ec05cdf..86704ba5f6f0 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -10,7 +10,6 @@
 #include <linux/moduleparam.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
-#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/pm.h>
-- 
2.42.1

