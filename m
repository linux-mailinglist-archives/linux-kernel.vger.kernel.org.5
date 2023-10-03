Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835447B6C51
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbjJCOww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbjJCOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:52:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3956710D2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40651a726acso9921775e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344707; x=1696949507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j3W5gbiwB/5gwTM96ugP2be7g+wEOoUYMu+wXUrQYg=;
        b=Oi1uY050EtQcWyd6td7XCO114xbZxYCsMwdl3dnnxGbsnmDQHhLQYeHpkxOzf7Wgf9
         afRMwRqX/MPFUVgP/UBJL1BL2wDtfHw+RnRGuKqhHgYnKMzwejw10OpaSrKxDBtDQWBy
         oKIvbWjaEMgSv0zfV+JcOP3UxhE9vz7su1wkefzZ3zbMYxceahVhbjCKUIofZ0z1916C
         dSEnWU7diLYwX40cbh2q1t1adjGrXg2awcU0v6nxdNryUBR/eJgcxYGWkgWq2wAGnT+3
         TzZuZjDHpM+rux6rYLMES3yVRJ9UAE9sr8eYTlKPg1uhZstS5Wmj505iLKoozygk0VFh
         Kfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344707; x=1696949507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j3W5gbiwB/5gwTM96ugP2be7g+wEOoUYMu+wXUrQYg=;
        b=ZGOG8Tt7MEh8Kzd6vv1p8kKpy/mSWjE0MXaFbYDLuVskAO3awTOZUlRh4DC5y+Z8UT
         Dc50fGKk0AQkSkWDwSUs7BZx2HxgF9uTscOnFduRpXx2PyLoeEuuepzfHmY2EM/pIpBZ
         HOv55ErzrsiHVJuLzX0HZ7jpUWpugsW3eZOmsPFzpUAYKnVgl6Znb79VcVAHxHumhBjc
         wkMGkDh16pJGbc2zQSzgzv88HhACMhgXRchj9uSoN1hZiw/C77ZWGfZo58OcUGNhAsqK
         5jiiB2LflYuUjkk/HaGmpxMLJkwBWxpCLovUS+nbuhk7m3f/kXaxtDpz+XphsJ0Kb9Bv
         bAhA==
X-Gm-Message-State: AOJu0Yyt1u6aQf97VssaO88HPPq/pPwm6cuWoG6bDYjmDS+glSulkg2E
        W5SpzC9tJhyp9vn49pbmRjPCTQ==
X-Google-Smtp-Source: AGHT+IE9rY8QXd3hX73Q6lwbGcVQvBQsR36SBdXE4r91ckRXTZW8tA0AY76GpxKS6c+NIXmjS4Oxeg==
X-Received: by 2002:a05:600c:3786:b0:405:3ee3:c69c with SMTP id o6-20020a05600c378600b004053ee3c69cmr11960246wmr.15.1696344706839;
        Tue, 03 Oct 2023 07:51:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 29/36] pinctrl: st: use new pinctrl GPIO helpers
Date:   Tue,  3 Oct 2023 16:51:07 +0200
Message-Id: <20231003145114.21637-30-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Replace the pinctrl helpers taking the global GPIO number as argument
with the improved variants that instead take a pointer to the GPIO chip
and the controller-relative offset.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index c1f36b164ea5..ec763572ab3e 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -719,7 +719,7 @@ static void st_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int st_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	pinctrl_gpio_direction_input(chip->base + offset);
+	pinctrl_gpio_direction_input_new(chip, offset);
 
 	return 0;
 }
@@ -730,7 +730,7 @@ static int st_gpio_direction_output(struct gpio_chip *chip,
 	struct st_gpio_bank *bank = gpiochip_get_data(chip);
 
 	__st_gpio_set(bank, offset, value);
-	pinctrl_gpio_direction_output(chip->base + offset);
+	pinctrl_gpio_direction_output_new(chip, offset);
 
 	return 0;
 }
-- 
2.39.2

