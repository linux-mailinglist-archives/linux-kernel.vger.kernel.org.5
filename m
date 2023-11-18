Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621277F00B8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjKRPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjKRPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:53:05 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72561FD2;
        Sat, 18 Nov 2023 07:51:47 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a84204e7aeso33080057b3.0;
        Sat, 18 Nov 2023 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322706; x=1700927506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wZmOHN/Mg2WsccYCg7xC7qQhfAqQUan5w/+E5l83yM=;
        b=cioG4iq440S8UbfRh0/MZWlkYyGhkicQn7v7zVRG+6tK6pFqDhQXlCb3/U8Axte3nu
         nhoGZb0O4z4D9XcEMxWHkks53RfHl2N2inPX5H3K+3ZY4cO3O9bR8nsbWMAOKzvUl7m4
         bp7nrP4mQ23b7742UAG6wQUQMkb9VzNV9sTijPlxOm680tpPlauMRaK3wg039To86Iii
         6lVkJ+4KkYI5K8LzhFU//cOCRK/qO1eceR6oawjQj5tSL+zxyboPsGi5ub312TMS1MEB
         FOxI4zFhncEw0O2kSbIeUysYeeJYmLWwvtVQRAjV7fb0yZVpV+s/pM29qz9zQMy0BaZv
         5pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322706; x=1700927506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wZmOHN/Mg2WsccYCg7xC7qQhfAqQUan5w/+E5l83yM=;
        b=TZFdpTxEA7HZI+e1/e8+/xaNziTNx1yxHA9+xxMvNisafaSa/0HQTvqKo1BbkeXqsj
         /Yx+DG3JBwDKsLGMXWuwuPYDFm1nZiQ+wyFs6m7XGcZW3/cI0hSqiIXQD/lOipOMhdVa
         jLMLYT/BKWj/RxcQro6NZGvD68R/BiIlKgN2oCC+LvAEfIBY7pA+SokALX9RxpG//XN2
         yITM5HZE5EWM+lMJAM9/35qAHQRKauVR7Z5WWxldz6uQ5csOTQqLl7DEcPrHWd854IAd
         yBnWEhRCqTqW6OfgkmhT6hsYsy19406p6yWDwCYjUVN13HI4BkOt0j9UrcVMR79V6ZVy
         45tA==
X-Gm-Message-State: AOJu0YxzF9Te+udH47+rGExGLbPlS+U0Wq2Y+VuS5G/rT1uqpOmRTsSt
        9aUrCTdrtZRAydkGEeN9w0Qk1vXQmCTIGGgM
X-Google-Smtp-Source: AGHT+IGmbeF69W2mApLtp2TFzllWj55CQ7MKd/oTUsvyCnOVTANukMUN2r2bgNvuI8ZjHjDNDSI/Gg==
X-Received: by 2002:a0d:d48a:0:b0:59b:5d6b:5110 with SMTP id w132-20020a0dd48a000000b0059b5d6b5110mr2902658ywd.21.1700322706091;
        Sat, 18 Nov 2023 07:51:46 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id m2-20020a819c02000000b0057a44e20fb8sm1163887ywa.73.2023.11.18.07.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:45 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-media@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 25/34] media: em28xx: cx231xx: fix opencoded find_and_set_bit()
Date:   Sat, 18 Nov 2023 07:50:56 -0800
Message-Id: <20231118155105.25678-26-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions in the media/usb drivers opencode find_and_set_bit() by
polling on a found bit in a while-loop.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/media/usb/cx231xx/cx231xx-cards.c | 16 ++++------
 drivers/media/usb/em28xx/em28xx-cards.c   | 37 +++++++++--------------
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-cards.c b/drivers/media/usb/cx231xx/cx231xx-cards.c
index 92efe6c1f47b..b314603932d7 100644
--- a/drivers/media/usb/cx231xx/cx231xx-cards.c
+++ b/drivers/media/usb/cx231xx/cx231xx-cards.c
@@ -1708,16 +1708,12 @@ static int cx231xx_usb_probe(struct usb_interface *interface,
 		return -ENODEV;
 
 	/* Check to see next free device and mark as used */
-	do {
-		nr = find_first_zero_bit(&cx231xx_devused, CX231XX_MAXBOARDS);
-		if (nr >= CX231XX_MAXBOARDS) {
-			/* No free device slots */
-			dev_err(d,
-				"Supports only %i devices.\n",
-				CX231XX_MAXBOARDS);
-			return -ENOMEM;
-		}
-	} while (test_and_set_bit(nr, &cx231xx_devused));
+	nr = find_and_set_bit(&cx231xx_devused, CX231XX_MAXBOARDS);
+	if (nr >= CX231XX_MAXBOARDS) {
+		/* No free device slots */
+		dev_err(d, "Supports only %i devices.\n", CX231XX_MAXBOARDS);
+		return -ENOMEM;
+	}
 
 	udev = usb_get_dev(interface_to_usbdev(interface));
 
diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 4d037c92af7c..af4809fe74a8 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3684,17 +3684,14 @@ static int em28xx_duplicate_dev(struct em28xx *dev)
 		return -ENOMEM;
 	}
 	/* Check to see next free device and mark as used */
-	do {
-		nr = find_first_zero_bit(em28xx_devused, EM28XX_MAXBOARDS);
-		if (nr >= EM28XX_MAXBOARDS) {
-			/* No free device slots */
-			dev_warn(&dev->intf->dev, ": Supports only %i em28xx boards.\n",
-				 EM28XX_MAXBOARDS);
-			kfree(sec_dev);
-			dev->dev_next = NULL;
-			return -ENOMEM;
-		}
-	} while (test_and_set_bit(nr, em28xx_devused));
+	nr = find_and_set_bit(em28xx_devused, EM28XX_MAXBOARDS);
+	if (nr >= EM28XX_MAXBOARDS) {
+		/* No free device slots */
+		dev_warn(&dev->intf->dev, ": Supports only %i em28xx boards.\n", EM28XX_MAXBOARDS);
+		kfree(sec_dev);
+		dev->dev_next = NULL;
+		return -ENOMEM;
+	}
 	sec_dev->devno = nr;
 	snprintf(sec_dev->name, 28, "em28xx #%d", nr);
 	sec_dev->dev_next = NULL;
@@ -3827,17 +3824,13 @@ static int em28xx_usb_probe(struct usb_interface *intf,
 	udev = usb_get_dev(interface_to_usbdev(intf));
 
 	/* Check to see next free device and mark as used */
-	do {
-		nr = find_first_zero_bit(em28xx_devused, EM28XX_MAXBOARDS);
-		if (nr >= EM28XX_MAXBOARDS) {
-			/* No free device slots */
-			dev_err(&intf->dev,
-				"Driver supports up to %i em28xx boards.\n",
-			       EM28XX_MAXBOARDS);
-			retval = -ENOMEM;
-			goto err_no_slot;
-		}
-	} while (test_and_set_bit(nr, em28xx_devused));
+	nr = find_and_set_bit(em28xx_devused, EM28XX_MAXBOARDS);
+	if (nr >= EM28XX_MAXBOARDS) {
+		/* No free device slots */
+		dev_err(&intf->dev, "Driver supports up to %i em28xx boards.\n", EM28XX_MAXBOARDS);
+		retval = -ENOMEM;
+		goto err_no_slot;
+	}
 
 	/* Don't register audio interfaces */
 	if (intf->altsetting[0].desc.bInterfaceClass == USB_CLASS_AUDIO) {
-- 
2.39.2

