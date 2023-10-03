Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786127B5DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjJCAMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJCAMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:12:22 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2786CC;
        Mon,  2 Oct 2023 17:12:18 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3af8b498d30so226388b6e.0;
        Mon, 02 Oct 2023 17:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696291938; x=1696896738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm7hq6cTECoBLZpFvDj16bGHkwPq1hmdasgTEM8lHeg=;
        b=njGp0tr5SZSsfU9fxFGH7bz7L6WCRt7BbpKrcMTJfB8omS25kfRJ75progo8IXZut6
         EoirAQvUz7eZI4IyQjReUUJGdMGVdbc2dkWMKCMKTMyPJPZPEwqhLeDdPnYhrX5YK8Lg
         NOg9+KgqW5YUqh4dHGUQMOHzWMjYMSr/e4ZIVfSMHvYE49uem2hKXo9XYHrjJtKlwd5M
         C8FAKYqw1/uH2YYyQlMtB9qB2hn2cXwCHXg1+aOKd+060wLpwo5DkDqw4czDDZ+otU13
         v83l0sU3L5RxnKBfAF/RjZXHz4IraO/Qd+YzbF+iVzaDhF2KIGlObAGJQW8TfTYKeWb4
         Siog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696291938; x=1696896738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bm7hq6cTECoBLZpFvDj16bGHkwPq1hmdasgTEM8lHeg=;
        b=c+xiY0iQK/f3LjMV5p5VH7HBrfnhGgI1Tpf57mpYZmBfDlaCLn5djuOzQHSxrYsAjl
         e9rcb7hHEga1Q4/ItD8swlUG7S5l6ze6oEpbFuuGETA0fTJIzZxS4GtU+F1ninBNKwU2
         lnoP9w8jKKNEZLEZqHR7FU2PCD0tohmMY7aq/H4KTitPa/4EVIwCQpFFegdng9O2tOty
         MpJS8MrVsuiKBCdywB8QHzp6hgl15TFdCs3IkY0y65La4Na/K+qvEC4zEh9ybv0iPqfB
         piwIQ501Tq/Wuj5NeoNWtGDUzrK6YwZ7HJH4o/2VcSOH4bXopaz0y/ImToPdrTgYAUMc
         xyvg==
X-Gm-Message-State: AOJu0YyzYQcc6hdmxR8R5IT+dOPOjKFejyp76/V37zTyaloEnFzHT72Y
        6U95kRSa7X7LjPANOGqXySw=
X-Google-Smtp-Source: AGHT+IEBrbMGL0Ht5TAu9DNDKPv4BfTUS/Uj6l2v76pNr+fDG2CY53moeLMRpQja/KB6fohFqvyUIg==
X-Received: by 2002:a05:6808:14c9:b0:3ab:9afd:8efd with SMTP id f9-20020a05680814c900b003ab9afd8efdmr15230659oiw.40.1696291937951;
        Mon, 02 Oct 2023 17:12:17 -0700 (PDT)
Received: from GTR7940.witekio.dom (207-109-71-206.dia.static.qwest.net. [207.109.71.206])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a199700b0026801e06ac1sm59683pji.30.2023.10.02.17.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:12:17 -0700 (PDT)
From:   Stan Bertrand <stanislasbertrand@gmail.com>
X-Google-Original-From: Stan Bertrand <sbertrand@witekio.com>
To:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Stanislas Bertrand <stanislasbertrand@gmail.com>
Subject: [PATCH] USB: serial: ftdi_sio: add ftdi serial to gpiochip label
Date:   Mon,  2 Oct 2023 17:11:35 -0700
Message-Id: <20231003001135.2713961-1-sbertrand@witekio.com>
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

From: Stanislas Bertrand <stanislasbertrand@gmail.com>

Use ftdi serial number on gpiochip label.
Allows to interface with gpiod utils using the serial number:

$ gpiodetect
gpiochip5 [ftdi-cbus-FTRelay2] (4 lines)
gpiochip6 [ftdi-cbus] (4 lines)
gpiochip7 [ftdi-cbus-A106TPEC] (4 lines)

$ gpioget ftdi-cbus-FTRelay2 2
0

Signed-off-by: Stanislas Bertrand <stanislasbertrand@gmail.com>
---
 drivers/usb/serial/ftdi_sio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 1bf23611be12..3e1b1c3194a2 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2094,6 +2094,8 @@ static int ftdi_gpio_init(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct usb_serial *serial = port->serial;
+	struct usb_device *udev = serial->dev;
+	const char *label;
 	int result;
 
 	switch (priv->chip_type) {
@@ -2116,6 +2118,15 @@ static int ftdi_gpio_init(struct usb_serial_port *port)
 	mutex_init(&priv->gpio_lock);
 
 	priv->gc.label = "ftdi-cbus";
+
+	if (udev->serial) {
+		label = devm_kasprintf(&udev->dev, GFP_KERNEL, "ftdi-cbus-%s",
+					udev->serial);
+		if (label) {
+			priv->gc.label = label;
+		}
+	}
+
 	priv->gc.request = ftdi_gpio_request;
 	priv->gc.get_direction = ftdi_gpio_direction_get;
 	priv->gc.direction_input = ftdi_gpio_direction_input;
-- 
2.34.1

