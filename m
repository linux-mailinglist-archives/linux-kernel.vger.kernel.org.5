Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7046E77CB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjHOKoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjHOKnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:43:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F93199A;
        Tue, 15 Aug 2023 03:43:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-986d8332f50so712457766b.0;
        Tue, 15 Aug 2023 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692096225; x=1692701025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sduk85jgb4Rzoi+0BThhCqf7BU7Lkg9hkmERzbD9sNs=;
        b=LUDpqjmagiSq84kwsybeyWQZDC7l+URGFNMSBVRzkJYuR95dgNCI9rbrT7CAbtEhZk
         03X4hMXJITjpUsBQNQ6WonRjOuglXzrBKso7gAhLdtwxQhUyG5jZJ9zOVHaBA5pyf1SZ
         EnLEKgsx5l7MWGkmoj6FCruDQU38cyVcxnvPgCa2QIyKz8nckkNVZ1xMifIYJbm3bi+E
         FSLCYs123CBBYQr+QOQvT5BTOCIf43+7MvcT44qgMxEQ4K67p/rjYim/iqp1ld9V4rR4
         OfCm8VUSxLsfjMqCS5HcvhzXqtBHvj2MxcJQiynzGG95908KFZpfKp+LToZMmnrE5rLr
         Cj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692096225; x=1692701025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sduk85jgb4Rzoi+0BThhCqf7BU7Lkg9hkmERzbD9sNs=;
        b=mIM46WTGTwaOZM0080cGxWnqVO94xM6G1WS0XGeaYKO7efwXT7wjhw+VNn7ZewnmS7
         MiVYsVcxtL+MM7/oXUPu89Mxxp5FuiC0HGgf1MJvhPn2H0kFRccHvsv+ojN/OL6R5Ogf
         D0E5xLmuINyZmCIoDMgyg3cmTiN68hkyXKxWiRA34Z70AeVmwmo2fO8v3O/lwqzjDvRD
         Fuaykyooz/iDSNWT5Q9rukgx14W2oSRzcL1i2tB1TjVhmaxdkjqeHHsS8QNgREwAK/5t
         v57haUF+3sWNRQiD9DdEG0QM2sRL3esCWC+2lw900BreHNSxOsHz3Z1eA/8z0Ae14ZOm
         /07A==
X-Gm-Message-State: AOJu0YweJZHhR64fUItYvLzn+xl4dpIBp4csaoHFI1QZ7vKeoLuHpeIm
        VlXZHsQSTjMyH6eofwA+0oA=
X-Google-Smtp-Source: AGHT+IFHzcS38HnEee+VxY8yfIsaZCs/wKTJxbsgsL3GPtyM5JlHWnLE3Va5K1Voj/9n8TDkfi5wKw==
X-Received: by 2002:a17:906:3196:b0:99c:6518:ce77 with SMTP id 22-20020a170906319600b0099c6518ce77mr8581512ejy.54.1692096224703;
        Tue, 15 Aug 2023 03:43:44 -0700 (PDT)
Received: from localhost.localdomain (pd9e9e2b1.dip0.t-ipconnect.de. [217.233.226.177])
        by smtp.gmail.com with ESMTPSA id md15-20020a170906ae8f00b0098d486d2bdfsm6944627ejb.177.2023.08.15.03.43.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Aug 2023 03:43:44 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
X-Google-Original-From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Leif Middelschulte <Leif.Middelschulte@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] pwm: imx27: verify decreasing PWM FIFO av value
Date:   Tue, 15 Aug 2023 12:43:31 +0200
Message-Id: <20230815104332.55044-3-Leif.Middelschulte@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230815104332.55044-1-Leif.Middelschulte@gmail.com>
References: <20230310174517.rb7xxrougkse2lrc@pengutronix.de>
 <20230815104332.55044-1-Leif.Middelschulte@gmail.com>
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

Avoid unnecessary sleeps as adviced[0], if the FIFO cannot be emptied.

[0] https://lore.kernel.org/lkml/20230310174517.rb7xxrougkse2lrc@pengutronix.de/T/#ec9560c1f613d9c0d7b77d72ad9051768812f80db

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
---
 drivers/pwm/pwm-imx27.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index c2a1e2030072..9673e809d212 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -126,7 +126,7 @@ static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
 	struct device *dev = chip->dev;
 	unsigned int period_ms = DIV_ROUND_UP_ULL(pwm->state.period, NSEC_PER_MSEC);
 	int tries = MX3_PWM_FIFOAV_EMPTY_LOOP;
-	int fifoav;
+	int fifoav, previous_fifoav = INT_MAX;
 	u32 sr;
 
 	while (tries--) {
@@ -134,6 +134,10 @@ static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
 		fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
 		if (fifoav == MX3_PWMSR_FIFOAV_EMPTY)
 			return;
+		/* if the FIFO value does not decrease, there is another problem */
+		if (previous_fifoav == fifoav)
+			break;
+		previous_fifoav = fifoav;
 		msleep(period_ms);
 	}
 	dev_warn(dev, "FIFO has been refilled concurrently\n");
-- 
2.39.2 (Apple Git-143)

