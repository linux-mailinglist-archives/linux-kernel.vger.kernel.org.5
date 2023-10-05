Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C327BA074
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbjJEOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbjJEOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3589C83C0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 00:52:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so1090122a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696492373; x=1697097173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2VPo73+NISdMnqKKa8YLMLwOayu51kTHaFGUFFnTf0g=;
        b=boXa7KdYeH3nQN4KhIxwMhS5/tziK1uB0pZsgNFvYhxRXz8o6izYmmHPb5LACVqEKt
         0UamJnFGSbxPHBrtAaez8g05hAmbqPDan6K2geY05jt6gPZyaIcHmhEzhVQM9oIf7FGV
         YEvp2qvbhMF3NntRonWWYwYUFDOzY2gaN9JOdkjdcJit8ODTW8ufXb8SinhBuGswuAu7
         ypqthXfSDwxwAv3/WyLo3x0WF18s79Ay8yi0OCZ/hohQVEPHXQcgvyZvIZsymd/86C/6
         cb0d2iiouwELXoZehhFUut5/f60PGkg42cnzsBNH8GtlUdKwn8nAtvDM1w/RmFcaK2ha
         5xNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696492373; x=1697097173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VPo73+NISdMnqKKa8YLMLwOayu51kTHaFGUFFnTf0g=;
        b=htnv+HAvE/X05hjJ/X8iqDaJ+ac7iF8o7uL16cXCIXpoWNzQ4/mqkhwX/aBsV4/n03
         vrygpHzxuP4X28ABGQ6RXQnSl0qwEifLdcsPjptxHAOMeCTc6sM/lyr5EznnZAJCDceY
         rPAyoqRzgS2Odx2v0gU/zGuCmnB17bw7ikK2O8JkmH1Y8FnKhrvJXWIQHiInhJwPiAyf
         76d4YKSVVKYQpfOFbVupeMmRazReDXM9KiT7/NcttbLFa1Z0pkZx51Mq99PeToQLfKIL
         Xy55z46pZa/sIljKnCibhWZb170y1p8yWDg+iivWk45NJ0kNhA/T9apuT1ZMD/1jsoNO
         YOow==
X-Gm-Message-State: AOJu0Ywu+yLm2gRBOnTgMftUFRsZBhOpE/SZpS5mtRa5xVxtDiZoyMIM
        d6PCj0P2+ZDnwRJRKT3egYhp9g==
X-Google-Smtp-Source: AGHT+IET4gtql0BEhc/DH8ss0kuES1cJOacsuqdH2Pa/FBh564Eq+POI0e557ksJTlua6yohWy5Dcw==
X-Received: by 2002:a17:906:95:b0:9b2:7b89:8199 with SMTP id 21-20020a170906009500b009b27b898199mr3889937ejc.53.1696492373610;
        Thu, 05 Oct 2023 00:52:53 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906078c00b009b94fe3fc47sm722051ejc.159.2023.10.05.00.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:52:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] ASoC: qcom: explicitly include binding headers when used
Date:   Thu,  5 Oct 2023 09:52:49 +0200
Message-Id: <20231005075250.88159-1-krzysztof.kozlowski@linaro.org>
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

Few units use qcom,lpass.h binding headers but they rely on them being
included through a different header.  Make the usage explicit which
allows easier to find the users of a header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 sound/soc/qcom/lpass-cdc-dma.c  | 1 +
 sound/soc/qcom/lpass-cpu.c      | 1 +
 sound/soc/qcom/lpass-platform.c | 1 +
 sound/soc/qcom/sc7280.c         | 1 +
 4 files changed, 4 insertions(+)

diff --git a/sound/soc/qcom/lpass-cdc-dma.c b/sound/soc/qcom/lpass-cdc-dma.c
index 8221e2cbe35c..586f23049447 100644
--- a/sound/soc/qcom/lpass-cdc-dma.c
+++ b/sound/soc/qcom/lpass-cdc-dma.c
@@ -5,6 +5,7 @@
  * lpass-cdc-dma.c -- ALSA SoC CDC DMA CPU DAI driver for QTi LPASS
  */
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/export.h>
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 39571fed4001..d15039bb7f82 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -5,6 +5,7 @@
  * lpass-cpu.c -- ALSA SoC CPU DAI driver for QTi LPASS
  */
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 73e3d39bd24c..5b99b41956ed 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -5,6 +5,7 @@
  * lpass-platform.c -- ALSA SoC platform driver for QTi LPASS
  */
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index c23df4c8f341..095756883050 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -4,6 +4,7 @@
 //
 // ALSA SoC Machine driver for sc7280
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-- 
2.34.1

