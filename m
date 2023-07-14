Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624DE7534EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjGNITM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjGNITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:19:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D942134
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:19:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so17608515e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689322746; x=1691914746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v4UNOf4OnfSq8XVP7LewFMWvi4W/OrdiQXVKL6e3Lc=;
        b=Wxn72Byc9QfURzZq95Ooxfv/YMIBLXkxLZ8O1nFDt3poO3870MkNRpNv6Is8RA+0OR
         jyPdscPq8sC5ljqulPCax59eAaqVi8LO8denCt29u2Z1zdi7Seif5G6D2xml8dpSgoFU
         rVq7UcYqgErh8KHW4fbNTcX+b5TJMXzF8m/GwwJ3WyyEAMLSm95ckfq7pYDKBEHytpMe
         1rrXyqqbQ+lfW6PrWoENgHeEgm8705AWNvLDO/JYQpkAua1OwSmnIrYgRItpAdrJ+1Pc
         TCjYGUzM31WcaUUYXBPMz3aP6nguWzlGSat2U2j8U+wdLA9XpvViPP9oNrgsjIWX31vZ
         sxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322746; x=1691914746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3v4UNOf4OnfSq8XVP7LewFMWvi4W/OrdiQXVKL6e3Lc=;
        b=D2LSs5XgCsB5Ge6pj03q0sOoD7YvkVsn6oPczrP3UXwMHgQiU5T2x5oiUePg/vAGM1
         bRnhr+wMk9AgQo+65P7iVvY8hj6XbAbyXGk3q7KhCW/lm+co7t45FBPRzL+rXlZJ7LUD
         RyE4J6lg9o9CnYHXQlsWaZg5A0Q51Af+opMKdv+k5eNuadviUzEwTgeRFmm0DGmZ+6be
         HqjZvkxNmDGaYO6fkjPCcgAq92rzqNbsDCQGc4B6PdDCNeY8Nza451FyunkH92jbV8Ao
         ixxpbuqlZ3p3JObYv7hJ2z6WRv/FRNhxA+/WAQVIPuJ5cYnh3YfY8RIMN9HQTGKU0qfx
         XH3Q==
X-Gm-Message-State: ABy/qLYIUZ2pPTgY7qW8Clr32bOfOFgOhJ2EtR4GwWz5wnm1Za/NTz3L
        b2KJxkbUSt3WkDOOiwMkI2rsz+L8YboF56PUY4v2dA==
X-Google-Smtp-Source: APBJJlEOg8b0p6/5Svcp/0n++cBjdUKbjqgkz0F7zjtfECT1PiuGNFhDNSGHQyv3PHklPZdDkLtjiQ==
X-Received: by 2002:a5d:6a51:0:b0:313:f38d:555f with SMTP id t17-20020a5d6a51000000b00313f38d555fmr1450399wrw.24.1689322745775;
        Fri, 14 Jul 2023 01:19:05 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d6810000000b003144b50034esm10143635wru.110.2023.07.14.01.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:19:05 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] pinctrl: cy8c95x0: Add reset support
Date:   Fri, 14 Jul 2023 10:19:01 +0200
Message-ID: <20230714081902.2621771-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714081902.2621771-1-Naresh.Solanki@9elements.com>
References: <20230714081902.2621771-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

This patch adds support for an optional "reset" GPIO pin in the cy8c95x0
pinctrl driver. On probe, the reset pin is pulled low to bring chip out
of reset. The reset pin has an internal pull-down and can be left
floating if not required.

The datasheet doesn't mention any timing related to the reset pin.

Based on empirical tests, it was found that the chip requires a
delay of 250 milliseconds before accepting I2C transfers after driving
the reset pin low. Therefore, a delay of 250ms is added before
proceeding with I2C transfers.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V2:
- None
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 2ecc96691c55..58ca6fac7849 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -164,6 +164,7 @@ struct cy8c95x0_pinctrl {
 	struct pinctrl_desc pinctrl_desc;
 	char name[32];
 	unsigned int tpin;
+	struct gpio_desc *gpio_reset;
 };
 
 static const struct pinctrl_pin_desc cy8c9560_pins[] = {
@@ -1383,6 +1384,20 @@ static int cy8c95x0_probe(struct i2c_client *client)
 		chip->regulator = reg;
 	}
 
+	/* bring the chip out of reset if reset pin is provided */
+	chip->gpio_reset = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(chip->gpio_reset)) {
+		ret = dev_err_probe(chip->dev, PTR_ERR(chip->gpio_reset),
+				    "Failed to get GPIO 'reset'\n");
+		goto err_exit;
+	} else if (chip->gpio_reset) {
+		usleep_range(1000, 2000);
+		gpiod_set_value_cansleep(chip->gpio_reset, 0);
+		usleep_range(250000, 300000);
+
+		gpiod_set_consumer_name(chip->gpio_reset, "CY8C95X0 RESET");
+	}
+
 	chip->regmap = devm_regmap_init_i2c(client, &cy8c95x0_i2c_regmap);
 	if (IS_ERR(chip->regmap)) {
 		ret = PTR_ERR(chip->regmap);
-- 
2.41.0

