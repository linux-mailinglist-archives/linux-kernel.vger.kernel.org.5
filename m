Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57F078DFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbjH3TKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbjH3JXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:23:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA576B0;
        Wed, 30 Aug 2023 02:23:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401b0d97850so52140365e9.2;
        Wed, 30 Aug 2023 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693387410; x=1693992210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t/81QQGv6+7ZEp2Cu2UEv1g4xNamuWwLFUQrjsypzac=;
        b=VILH0twbl9+ZTUNDRUEe5oqi++HJ4GV2X1BQn6OU2rF2+/YiBJSWbIflugfzauHbyh
         w8qD1wqpDe8tDFo6bGhTNSqtxwIN0O34sebyeaBNeNxUBMdNqYtXF30Au6Vzg6GTpoSX
         bEYidWutc1oLrrkR/tZS9bRlKk+Hi5CE5mGbIIZPhqT1u18C7fzabpHjyez8fTPFPthd
         5qMi14MA996nfVMlheRi1G+YN1zkqIIQcccwpF+hUJ7cJS7WvjWwlxJAM+XYhejiqf06
         pgcgkw5hEI7NEeEPtn0u7c03hOPVAahWSLMBRVSRbeFvvCBPSMqoFPH/3k4OSHflkd6d
         a17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693387410; x=1693992210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/81QQGv6+7ZEp2Cu2UEv1g4xNamuWwLFUQrjsypzac=;
        b=K89ALcVyvlTeyipZku+QOXWnW13diniRV5vs550MXx/wk8tuJWI2/e2kOlS71QFhoN
         jOD2u5uv/rd6+nxHlSDr+9btbXV6zNjtxRk/6ZUAPFKHtZHlODGRJYJG/hUZhO9EnvzO
         frTlrmrjZ2bZbM/K0jcAq5HSmQKDizwYkFHRVgUT9kLeCzoMF/PiePwjxr1USz9pkZFr
         sLNIXYR52HNvWlBsv9N974QYflTKXJPn04DYcRd8FV2vboL5RJ0X2nXNrE0yjpkJRXrj
         RKXmon5rNOBtYCP7GHPqPAD5/14G7w5czKqT9mkEUp7tbbgUD712xYlqT7MmufwG+CVe
         Ofcw==
X-Gm-Message-State: AOJu0YxqTXPS2coy5Li4dz0tS9iP/myLzg8PdBJzXmEod30SnWMYUK/J
        r1eRhB8MabTzN2CXQ85HfF/zy/sKDRQNMA==
X-Google-Smtp-Source: AGHT+IHtj4ByG/r/IQgNm1JKGqbW9lPk50KHeW15cvf2mdpCbUSgOA4+5UHSmOOIOWyB+U6lZ6Pbhg==
X-Received: by 2002:a7b:cb8a:0:b0:401:b2c7:349b with SMTP id m10-20020a7bcb8a000000b00401b2c7349bmr1358248wmi.7.1693387410198;
        Wed, 30 Aug 2023 02:23:30 -0700 (PDT)
Received: from latitude-5411.. (elsys-cachan-ftto-main-190-130.fib.nerim.net. [194.79.190.130])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc858000000b003feef5b0bb7sm1631028wml.40.2023.08.30.02.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:23:29 -0700 (PDT)
From:   mathieu <mathieu.moneyron@gmail.com>
To:     ludovic.desroches@microchip.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     Mathieu Moneyron <mathieu.moneyron@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: Fix force card detect in sdhci
Date:   Wed, 30 Aug 2023 11:23:14 +0200
Message-Id: <20230830092314.624212-1-mathieu.moneyron@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Moneyron <mathieu.moneyron@gmail.com>

On the ATMEL at91 when using the non-removable flag in device tree and not
using the card-detect pin inside the device-tree pinctrl, the card detect
pin is physically still used which can cause unknown behaviour when this
pin is used for other purposes.

From my interpretation this seems to be caused by a hardware design flaw
and the real hardware is not working as intended by the documentation.

Signed-off-by: Mathieu Moneyron <mathieu.moneyron@gmail.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 69fef88e7..4fd6bfbf6 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -51,10 +51,15 @@ struct sdhci_at91_priv {
 static void sdhci_at91_set_force_card_detect(struct sdhci_host *host)
 {
 	u8 mc1r;
+	u8 ctrl;
 
 	mc1r = readb(host->ioaddr + SDMMC_MC1R);
 	mc1r |= SDMMC_MC1R_FCD;
 	writeb(mc1r, host->ioaddr + SDMMC_MC1R);
+
+	ctrl = readb(host->ioaddr + SDHCI_HOST_CONTROL);
+	ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
+	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
 }
 
 static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
-- 
2.25.1

