Return-Path: <linux-kernel+bounces-13092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E781FF96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E51CB21D73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419F111BF;
	Fri, 29 Dec 2023 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eK9NUZ75"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21393111B5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 562D53F15B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 13:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703855290;
	bh=R+U2uLziDgx+IP4bP4iaMKnlOMS40so+TR+KdlJRETI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=eK9NUZ751EG8XuCqHJjBkaq+ncUXr6PzlYT+zrbvp2ACMCzKJpSx4DvkmFeKL5Q99
	 boW7ZeongFkRMzciT9OS9UVesrn+sn9vWQnNqoqVxpZrkXfiuPBZwd1Obr1yaMLyRt
	 l9q0yqHBFXfz6fX95Tqa8yghJqsqxhTkfjWzizuQu25jyxrcQ1FEwxkvI6Yf4vIwgI
	 oZQ0i+fW9PjPrZ1IKwLBgyaNGiQb/KhnUFAjqgOROalCparTY7u4BpRoxxNxtmOZMY
	 XlBONN9+8eFY1gs8NFvzc5JTZIFxV4iv3n/APR4+1eVB6+HBGFT9KLfvVW3WQcLUbt
	 PEXMMpXwW/ekw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5552470977aso1698378a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 05:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703855290; x=1704460090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+U2uLziDgx+IP4bP4iaMKnlOMS40so+TR+KdlJRETI=;
        b=Znb+TRjziAMqOqLw/SSz+yegYrMco5Xb1RgLwEWIh1dIk41GSzcM9yS5a06ju6qy93
         BvZ60t3vIQxJMFUmb/IOWSdiXGGGsczhN+pBsm56az88Wjri7WmRg2rRKcsDJABleQAB
         3ZSRWustN3RFkx19eW6h7sPT26slrDtqS+Drg0tkGAoZn2F4+TFLzFCGqPB75/LMkUsv
         yuIvw/Ky4ZclosK9sDSIIdmEP1liXQEeWut3KK/tHo5daJBfu57FhBgGyuL78hCACYcY
         cG9PZijxvgX5MwizVWm4xd8NbNx+bep17/KebtnAeIm/p7AI6e/fFhOH+INY9gOQqk7a
         vg7g==
X-Gm-Message-State: AOJu0YzvVK9NGvJZZYw5DQEfsZrthrWdY1izK6jE/QaPrN8712Voylqr
	ZnR0E725m+4fEbm0RPLOTMsORthnpS8I392VFyj+wwOOuf8hXqZsZU90PV5n+jsu0/huZ+u4adC
	Xbh1P8oxrufpDHWRljxVrY6dpqEfJYoRV91JMunFbubLeh6iP
X-Received: by 2002:a17:907:1047:b0:a1f:7298:aa25 with SMTP id oy7-20020a170907104700b00a1f7298aa25mr5908865ejb.45.1703855290046;
        Fri, 29 Dec 2023 05:08:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOl2xY+pSzy8GIwLI8YWCBORZjtn0Q6seBKWUm/MYOhifqEVMnq+cdXs9qSb+TuynSBKEeaQ==
X-Received: by 2002:a17:907:1047:b0:a1f:7298:aa25 with SMTP id oy7-20020a170907104700b00a1f7298aa25mr5908860ejb.45.1703855289728;
        Fri, 29 Dec 2023 05:08:09 -0800 (PST)
Received: from stitch.. ([2001:67c:20a1:1909:b62b:6d4a:f569:ad01])
        by smtp.gmail.com with ESMTPSA id ex1-20020a170907954100b00a26f22dca5asm4359327ejc.0.2023.12.29.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 05:08:09 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v1] gpio: dwapb: Use generic request, free and set_config
Date: Fri, 29 Dec 2023 14:07:51 +0100
Message-ID: <20231229130758.84214-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This way GPIO will be denied on pins already claimed by other devices
and basic pin configuration (pull-up, pull-down etc.) can be done
through the userspace GPIO API.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/gpio/gpio-dwapb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 8c59332429c2..798235791f70 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -416,11 +416,12 @@ static int dwapb_gpio_set_config(struct gpio_chip *gc, unsigned offset,
 {
 	u32 debounce;
 
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
+	if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
+		debounce = pinconf_to_config_argument(config);
+		return dwapb_gpio_set_debounce(gc, offset, debounce);
+	}
 
-	debounce = pinconf_to_config_argument(config);
-	return dwapb_gpio_set_debounce(gc, offset, debounce);
+	return gpiochip_generic_config(gc, offset, config);
 }
 
 static int dwapb_convert_irqs(struct dwapb_gpio_port_irqchip *pirq,
@@ -530,10 +531,14 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 	port->gc.fwnode = pp->fwnode;
 	port->gc.ngpio = pp->ngpio;
 	port->gc.base = pp->gpio_base;
+	port->gc.request = gpiochip_generic_request;
+	port->gc.free = gpiochip_generic_free;
 
 	/* Only port A support debounce */
 	if (pp->idx == 0)
 		port->gc.set_config = dwapb_gpio_set_config;
+	else
+		port->gc.set_config = gpiochip_generic_config;
 
 	/* Only port A can provide interrupts in all configurations of the IP */
 	if (pp->idx == 0)
-- 
2.43.0


