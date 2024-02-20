Return-Path: <linux-kernel+bounces-72912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C05385BAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BD91F22306
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C50467A01;
	Tue, 20 Feb 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JY3TL8T6"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5A5657D7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428856; cv=none; b=XePM0/mntOzMaMTk1pWwu5SKST1SwCH3h9EmfiuSXfD5AN2Km9rPJAaDnk5lV/uxBYRN5L09Em0kwnLQn58w+yV5PvJsfkoL54Kj5LI9H1j/y84fms5UsZKru5Vwqjei/cIiKaHMSXD1RnkORHz7bB3QB/NByhh9qErLDyYp2p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428856; c=relaxed/simple;
	bh=wpwueLBxQ8g7CUCfsdr3qWaKkli08BlyZt5JJx5mm44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z0zITqtcIm8L4cWWB5O2SuHyqwH75fbwYB+5G0w2LxKlmz+Z+E5YNZgwBmHhUfGzp5S9zHI3Kyjn9QQ2yapKnV4a5T1ufnvONQy7I0hvoLvqbwMVmvXEsVpUIQCV2zlc7OWnZ3BCnDMPj72WHHIaE3FS9oROjvwa7aHZHza+YGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JY3TL8T6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412718a8ea7so562605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708428853; x=1709033653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z3Pvq3RdfRBYI8uAK+HiNG4SvbmBg/H4jDL+WIUGvTg=;
        b=JY3TL8T6o5kXF3AWKRtemKT3kWNyEr9MsBv20xU0ab+XgBFQfi/7jWFxu3lBe76vCD
         Q0MM1IcSjNTmldkfCKIk+tnE9maiw/lYszVPAhZnW1SpHVMVVycGI8ZzOZ03g0uAhwXP
         aLgMFHqGUvtzWkABiIxZ4G28Z83d54jnROk+Cr4ykALbAHPxwk6muM4DX2hzdnhi3bhG
         1rvvJMFqkiRp1V23nl5VJSNp+JHGd2vPxL8By7VGGxg2bvNeNDuxlvt+qheOBY0KeJcw
         EnOVpSeXQLDE1M33h4r8tATV52BpCzkW8mWjG2CyFFQcoQET5wj2j5z8Rb/28Ym1kkt/
         rzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708428853; x=1709033653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3Pvq3RdfRBYI8uAK+HiNG4SvbmBg/H4jDL+WIUGvTg=;
        b=tgI5mlPi8Q05Ubv1SkAVpzTselNpxDGXSaFEZg9sBCCL2a6dLYYK5GLZZvCOHjKe5t
         zkCgUddBJr3qo+ObOJQc/Xvgy/Q+XkDJWZnksBs35GMcfA4iEd34KIxg7IjOjVcRvCgj
         s3I1wp4nQj5l+qAOXFvcU129GxclUO/8Qt+l6NJHkMNo3a72/5WZ4iBGN8tmf2WBrEvx
         Lly+ip/a1bsRIKU9vElsP4bpDyEDBqDkGr0XPqMXxxrlDbgBYaUntb8jUxDjPIpZZEiq
         zp8tjtmmXOSeosCHFUCjzCzs/KLP8BP+Ykd8fTpcacAkMPglTaQxFBSujH/16LoxfHlx
         tSjQ==
X-Gm-Message-State: AOJu0YxM8oSYYyx/WiJjc4QTLKKk7NGcA4FEKH5lqw2xGrkyEkgIJYPp
	kT9PMJ5D4Dj1MhVEnlaBBKLtrEtT6tXQ/oTsed6EkVD0Ud6cZAvC+Nu2omJCeYg=
X-Google-Smtp-Source: AGHT+IGw3UcTIT75fBKm4X2nkb9oIu2VZFCfSYXoNynHzrGBcjbo7mcmn9zo6bBaGcO1zeNFNAaYPg==
X-Received: by 2002:a05:6000:1843:b0:33d:4fca:a47f with SMTP id c3-20020a056000184300b0033d4fcaa47fmr3907939wri.18.1708428853091;
        Tue, 20 Feb 2024 03:34:13 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c6ce:c6a0:43ac:8f8e])
        by smtp.gmail.com with ESMTPSA id bn28-20020a056000061c00b0033d6fe3f6absm1063006wrb.62.2024.02.20.03.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:34:12 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3] serial: st-asc: don't get/put GPIOs in atomic context
Date: Tue, 20 Feb 2024 12:34:10 +0100
Message-Id: <20240220113410.16613-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Since commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with
SRCU") gpiod_set_consumer_name() calls synchronize_srcu() which led to
a "sleeping in atomic context" smatch warning.

This function (along with gpiod_get/put() and all other GPIO APIs apart
from gpiod_get/set_value() and gpiod_direction_input/output()) should
have never been called with a spinlock taken. We're only fixing this now
as GPIOLIB has been rebuilt to use SRCU for access serialization which
uncovered this problem.

Move the calls to gpiod_get/put() outside the spinlock critical section.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-gpio/deee1438-efc1-47c4-8d80-0ab2cf01d60a@moroto.mountain/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v2 -> v3:
- we only need to change the GPIO configuration for RTS in certain situations
  so use a separate variable for storing that information; if we don't then we
  may end up putting the descriptor when setting a different option
- I dropped Linus tag as the code change significantly

v1 -> v2:
- initialize the 'manual_rts' variable to false as we don't always get to
  the place where it's set

 drivers/tty/serial/st-asc.c | 40 ++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index bbb5595d7e24..a23e59551848 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -465,6 +465,7 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 			    const struct ktermios *old)
 {
 	struct asc_port *ascport = to_asc_port(port);
+	bool manual_rts, toggle_rts = false;
 	struct gpio_desc *gpiod;
 	unsigned int baud;
 	u32 ctrl_val;
@@ -518,25 +519,13 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 
 		/* If flow-control selected, stop handling RTS manually */
 		if (ascport->rts) {
-			devm_gpiod_put(port->dev, ascport->rts);
-			ascport->rts = NULL;
-
-			pinctrl_select_state(ascport->pinctrl,
-					     ascport->states[DEFAULT]);
+			toggle_rts = true;
+			manual_rts = false;
 		}
 	} else {
 		/* If flow-control disabled, it's safe to handle RTS manually */
-		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL]) {
-			pinctrl_select_state(ascport->pinctrl,
-					     ascport->states[NO_HW_FLOWCTRL]);
-
-			gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
-			if (!IS_ERR(gpiod)) {
-				gpiod_set_consumer_name(gpiod,
-						port->dev->of_node->name);
-				ascport->rts = gpiod;
-			}
-		}
+		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL])
+			manual_rts = toggle_rts = true;
 	}
 
 	if ((baud < 19200) && !ascport->force_m1) {
@@ -595,6 +584,25 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 	asc_out(port, ASC_CTL, (ctrl_val | ASC_CTL_RUN));
 
 	uart_port_unlock_irqrestore(port, flags);
+
+	if (toggle_rts) {
+		if (manual_rts) {
+			pinctrl_select_state(ascport->pinctrl,
+					     ascport->states[NO_HW_FLOWCTRL]);
+
+			gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
+			if (!IS_ERR(gpiod)) {
+				gpiod_set_consumer_name(gpiod,
+							port->dev->of_node->name);
+				ascport->rts = gpiod;
+			}
+		} else {
+				devm_gpiod_put(port->dev, ascport->rts);
+				ascport->rts = NULL;
+				pinctrl_select_state(ascport->pinctrl,
+						     ascport->states[DEFAULT]);
+		}
+	}
 }
 
 static const char *asc_type(struct uart_port *port)
-- 
2.40.1


