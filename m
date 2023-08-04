Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04B876FF38
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjHDLI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHDLIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:08:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DC2195
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:08:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c4e426714so54858266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 04:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691147295; x=1691752095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIJ0wZyKm1oHflFxZiewsCGjiwbu4yH0OOsxMNtlRQA=;
        b=sb2OsCJg8rCGJP8ARVMIpqDdFxuEh/lmMRim5Tgv0J7OpP61Zf/j6HcfRydESLJ8kp
         O5KcX23un2JKdBMXiJVRyPBq2l7pFFBEii1FNpA5/6PuUSIJLYOunL+8cxF1H+rcx1Sq
         WhryHozOCkNhQKCMpNlz93T28ixJu02X94LB8/VF/cAv8zZShlRk9/vT4w5y2F38xktU
         eeEGRMzoL4yDny6/fIzJQKewUy7PrBDOdyjkjujfrb0Yr/recHXCPQa2TktcE28y5iW3
         MJP3FfG/XM6tYdlm/oLtv6DMEEIagQSh2zgM/SNOQwZIG6rVPWrirP9w0VSu5561y9Y5
         wUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691147295; x=1691752095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIJ0wZyKm1oHflFxZiewsCGjiwbu4yH0OOsxMNtlRQA=;
        b=UJZhEOD+si36JLschx+1dxJx7SrwPi8rs5F4uOS8aVffj0oBCMY8mJp3zqcbmmwEG7
         JYt4LW7eBLo8EhzrGquuUIorNJiv0p8+3sjKGmbSTzAqSGi5vgzHMuGJ8JG7ADLRn/3g
         v1luuhWhSheJdnZmgZQeE1ZbrSUI3nnSGqitdbcUTcTuQ7LyrXdw8F13cXIesbb47JX1
         4rBqMvFZe5DhR6cs8nQbEqw2nhvRiY3nS6DkqHuPhfua6EwVppkMRhIwekRQAsprO/MF
         YVoy0f4ju1XEimfU/02jJSb99DJyYaSq0WC+9BfcRMxRJi55Vq3DThZplgnj/sBz2aKp
         Ageg==
X-Gm-Message-State: AOJu0YzxCWErQGqBbhpSmSCBhscEf6Uj86jLrxv9JhmgVjHJvQQQ+Dzh
        w9+zA4+bScDdZmB93dvSl5M=
X-Google-Smtp-Source: APBJJlFn3bAfpeUS7bFYzuP6M36OObpUhU8sV+Ubp+nPBglgSjjoO/M81TcUo5jlFHzdz8R+3q9F4g==
X-Received: by 2002:a17:906:51d6:b0:99c:5711:3187 with SMTP id v22-20020a17090651d600b0099c57113187mr4463468ejk.6.1691147295122;
        Fri, 04 Aug 2023 04:08:15 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id bn10-20020a170906c0ca00b00992b0745548sm1149478ejb.152.2023.08.04.04.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:08:14 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ALSA: pcmtest: Remove redundant definitions
Date:   Fri,  4 Aug 2023 15:07:40 +0400
Message-Id: <20230804110740.9867-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804110740.9867-1-ivan.orlov0322@gmail.com>
References: <20230804110740.9867-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant definitions of DEVNAME and CARD_NAME, as they're not
useful. The former is not used anywhere, and the latter is used only
in module parameters descriptions.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Split changes in the patch into two different patches

 sound/drivers/pcmtest.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index dc7c9c758537..7f170429eb8f 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -41,8 +41,6 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 
-#define DEVNAME "pcmtestd"
-#define CARD_NAME "pcm-test-card"
 #define TIMER_PER_SEC 5
 #define TIMER_INTERVAL (HZ / TIMER_PER_SEC)
 #define DELAY_JIFFIES HZ
@@ -74,11 +72,11 @@ static u8 ioctl_reset_test;
 static struct dentry *driver_debug_dir;
 
 module_param(index, int, 0444);
-MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard");
+MODULE_PARM_DESC(index, "Index value for pcmtest soundcard");
 module_param(id, charp, 0444);
-MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard");
+MODULE_PARM_DESC(id, "ID string for pcmtest soundcard");
 module_param(enable, bool, 0444);
-MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
+MODULE_PARM_DESC(enable, "Enable pcmtest soundcard.");
 module_param(fill_mode, short, 0600);
 MODULE_PARM_DESC(fill_mode, "Buffer fill mode: rand(0) or pattern(1)");
 module_param(inject_delay, int, 0600);
-- 
2.34.1

