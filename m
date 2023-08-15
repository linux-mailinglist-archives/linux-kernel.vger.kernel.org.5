Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2177CB48
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjHOKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbjHOKnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:43:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0781BC5;
        Tue, 15 Aug 2023 03:43:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso701752666b.1;
        Tue, 15 Aug 2023 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692096226; x=1692701026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq29fMSY5Klc/kVuoVBAvAdS2b2iC4pQqEMog/G6NPM=;
        b=CbvqMNyY7dJpa6T8z2Qqb+wixiM3zgNmkWHgfdD/0ZYQzoSaEqkaN6L6Yjl6KPujJE
         nE1c6Cz7BYRjLilWo0BJ7iS9ZbMJ/swLM8UCb6crmpq5KRlfSoh0oUgA89ElUMlFOlu9
         qDud40u775qB39ZPJTa9EzIR8/AwKmM9Djzlaelh447owdP+in3ekyg0SKd1O/jx91Ts
         mnRod+8LV0Eyn7YGAs5B53yFtZwRC9zLXuuH2lMKaAQ413pixHu7aocPiWBtsFYEJRa6
         DKu/YKUbefRUiEmscXIOOTnBQ5a/Vb/8yWXKvrcw5x54BkTb3tLoY93fpeLDTPdvGYgn
         AXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692096226; x=1692701026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq29fMSY5Klc/kVuoVBAvAdS2b2iC4pQqEMog/G6NPM=;
        b=b/jYPu8mO8oZ8hiwSaUkTBcCzaMXCTUb2Vik8zyfy3xuiGnGQgu9V40XdKn1iqyaF0
         XRHVoOmGEf/sI1aQheC9sjpWbTtAP7SYb6qu3UUMaWFP35gDY7tJkj0Gu4Yne6Jesdm9
         A3dE4I6bPVchaI5pcHlxAHRbPaoNXQX1Uu2o0l755E8S52bHy8jieuQumURuW+0MNtb0
         lTJkaR17HLWo1dGkixmxSXoYJSKX0Cj2jQ58F1Sc+iROlKfEyDHRAiAH4J9im2u68Frd
         FG7hBy9dNhguiPX1i6Z2EUd5j+vvW518j9+sXj37teOCyxFUbvL0bNNZElwCpNmFFB9D
         Zttw==
X-Gm-Message-State: AOJu0Ywiq37MgWew1f0cylyTuiaA17XLy+Q0oitrTPn/Pwf/h4ziPX5q
        Mcf5lkW7jazVq24zcmnJ+1tC8wrDRohMqK1k
X-Google-Smtp-Source: AGHT+IH3sqmIl4zZ47TExcrKondXwj9ValS7C5VHObCT317j6Z8uHOOiDk6RxdjC0EmzA7xbcE7oIQ==
X-Received: by 2002:a17:906:2ce:b0:993:f9b2:93c1 with SMTP id 14-20020a17090602ce00b00993f9b293c1mr10763562ejk.9.1692096225834;
        Tue, 15 Aug 2023 03:43:45 -0700 (PDT)
Received: from localhost.localdomain (pd9e9e2b1.dip0.t-ipconnect.de. [217.233.226.177])
        by smtp.gmail.com with ESMTPSA id md15-20020a170906ae8f00b0098d486d2bdfsm6944627ejb.177.2023.08.15.03.43.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Aug 2023 03:43:45 -0700 (PDT)
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
Subject: [PATCH v3 4/4] pwm: imx27: return error, if clean PWM setup fails
Date:   Tue, 15 Aug 2023 12:43:32 +0200
Message-Id: <20230815104332.55044-4-Leif.Middelschulte@gmail.com>
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

Instead of issuing a warning, return an error (as adviced[0]), if the
FIFO cannot be cleanly set up.

[0] https://lore.kernel.org/lkml/20230310174517.rb7xxrougkse2lrc@pengutronix.de/T/#ec9560c1f613d9c0d7b77d72ad9051768812f80db

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
---
 drivers/pwm/pwm-imx27.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 9673e809d212..5fd6d34a7722 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -133,14 +133,15 @@ static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
 		sr = readl(imx->mmio_base + MX3_PWMSR);
 		fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
 		if (fifoav == MX3_PWMSR_FIFOAV_EMPTY)
-			return;
+			return 0;
 		/* if the FIFO value does not decrease, there is another problem */
 		if (previous_fifoav == fifoav)
 			break;
 		previous_fifoav = fifoav;
 		msleep(period_ms);
 	}
-	dev_warn(dev, "FIFO has been refilled concurrently\n");
+
+	return -EAGAIN;
 }
 
 static int pwm_imx27_get_state(struct pwm_chip *chip,
@@ -208,7 +209,9 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 		 * been supplied and a period expired between the call of the wait
 		 * function and the subsequent readl.
 		 */
-		pwm_imx27_wait_fifo_empty(chip, pwm);
+		ret = pwm_imx27_wait_fifo_empty(chip, pwm);
+		if (ret)
+			return ret;
 		val = readl(imx->mmio_base + MX3_PWMSAR);
 	} else {
 		val = imx->duty_cycle;
-- 
2.39.2 (Apple Git-143)

