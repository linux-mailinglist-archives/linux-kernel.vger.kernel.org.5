Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0C7C5DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjJKTe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjJKTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:34:55 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7892E94;
        Wed, 11 Oct 2023 12:34:53 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41959feaae2so1457571cf.0;
        Wed, 11 Oct 2023 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697052892; x=1697657692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMhxyW0joTpwkIFPxid1geHzJJshLGm7m/QaYWuizMU=;
        b=GZP7eaK1LSCBBrIRtwcj4r7MfdcSR9WUT5eeOw15PjoCHPkbM/PGPIFy1WAEY01omD
         gR12JCrr9f+49KxklCMJxVU5HTjv+UpLKnbUHBfBNW3e5JD3akJl3d6O9NEadU3mGQu9
         J08qBr2gI9RZ9cEkQwWZbPW0ljl0WLz/qf70fMGv3qgUToiYU4dA9pe0zh04rvay+a3k
         ej4A5RneercEQmsIIjPBHqEhTSPfD5lbDXNV1MtltZNWH2uCnYy1OA0FXUJQ4bmjXGCO
         7jn3opP+H1nugIkvp0MF67wX/Yw7PtvWXFhUUbLEm1agNg/jWBCZewH2bU4HIEcFaQfr
         x4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697052892; x=1697657692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMhxyW0joTpwkIFPxid1geHzJJshLGm7m/QaYWuizMU=;
        b=PG4fr4OybzkM2wourhARgod31RLoeniJDxdTwV8MmVgcCBhKSQ00ohSTj7h0Ga8Rcc
         eI0xBYbWjwXZWWZqIiP1EL2Y3qaspEr/HF7N67rzn1hAcgn/EbGBuoUH8GJLIrBz5l00
         YzVz+SRV9dbA3BGfZwtA+f52p1+tUA9ohfFzBsXEa7C4yugtzyRKEbts06hnbtMfH63g
         HoR1XNe05CWPptYxNbVNn8vcQ3Pjhi9P8mY9tqIN0zV1HQ6OuKQ3KgNN1TmpqnG6npR/
         OXU8Qpz35u1bTI8VtfKJhbgTfM6eL/gi8EulKDCEcVd5rCH1EYgqTvqs7g/PfYSQF5It
         Y0kA==
X-Gm-Message-State: AOJu0YxBCMSQ2vzMe27vsWYEoK85SJgjFgZuIARRaRYabmCBrjyBXn/p
        4K8zGCF/CEPn1rMDHg4O73nXvx0bftk=
X-Google-Smtp-Source: AGHT+IFmmEg2FwIICOSgIOxwowdhvVBGcpvnCukQmxekoza0guKE4aJgLWMK5ehMuf5y7jxrkr8xnw==
X-Received: by 2002:a05:622a:1316:b0:418:a14:9c30 with SMTP id v22-20020a05622a131600b004180a149c30mr26004028qtk.9.1697052891948;
        Wed, 11 Oct 2023 12:34:51 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id g9-20020ac84689000000b00410ac0068d0sm5558667qto.91.2023.10.11.12.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:34:51 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Andryuk <jandryuk@gmail.com>,
        Phillip Susi <phill@thesusis.net>, stable@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH v3] Input: xen-kbdfront - drop keys to shrink modalias
Date:   Wed, 11 Oct 2023 15:34:43 -0400
Message-ID: <20231011193444.81254-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen kbdfront registers itself as being able to deliver *any* key since
it doesn't know what keys the backend may produce.

Unfortunately, the generated modalias gets too large and uevent creation
fails with -ENOMEM.

This can lead to gdm not using the keyboard since there is no seat
associated [1] and the debian installer crashing [2].

Trim the ranges of key capabilities by removing some BTN_* ranges.
While doing this, some neighboring undefined ranges are removed to trim
it further.

An upper limit of KEY_KBD_LCD_MENU5 is still too large.  Use an upper
limit of KEY_BRIGHTNESS_MENU.

This removes:
BTN_DPAD_UP(0x220)..BTN_DPAD_RIGHT(0x223)
Empty space 0x224..0x229

Empty space 0x28a..0x28f
KEY_MACRO1(0x290)..KEY_MACRO30(0x2ad)
KEY_MACRO_RECORD_START          0x2b0
KEY_MACRO_RECORD_STOP           0x2b1
KEY_MACRO_PRESET_CYCLE          0x2b2
KEY_MACRO_PRESET1(0x2b3)..KEY_MACRO_PRESET3(0xb5)
Empty space 0x2b6..0x2b7
KEY_KBD_LCD_MENU1(0x2b8)..KEY_KBD_LCD_MENU5(0x2bc)
Empty space 0x2bd..0x2bf
BTN_TRIGGER_HAPPY(0x2c0)..BTN_TRIGGER_HAPPY40(0x2e7)
Empty space 0x2e8..0x2ff

The modalias shrinks from 2082 to 1550 bytes.

A chunk of keys need to be removed to allow the keyboard to be used.
This may break some functionality, but the hope is these macro keys are
uncommon and don't affect any users.

[1] https://github.com/systemd/systemd/issues/22944
[2] https://lore.kernel.org/xen-devel/87o8dw52jc.fsf@vps.thesusis.net/T/

Cc: Phillip Susi <phill@thesusis.net>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
v3:
Add Mattijs R-b
Put /* and */ on separate lines
---
 drivers/input/misc/xen-kbdfront.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
index 67f1c7364c95..d59ba8f9852e 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -256,7 +256,16 @@ static int xenkbd_probe(struct xenbus_device *dev,
 		__set_bit(EV_KEY, kbd->evbit);
 		for (i = KEY_ESC; i < KEY_UNKNOWN; i++)
 			__set_bit(i, kbd->keybit);
-		for (i = KEY_OK; i < KEY_MAX; i++)
+		/*
+		 * In theory we want to go KEY_OK..KEY_MAX, but that grows the
+		 * modalias line too long.  There is a gap of buttons from
+		 * BTN_DPAD_UP..BTN_DPAD_RIGHT and KEY_ALS_TOGGLE is the next
+		 * defined. Then continue up to KEY_BRIGHTNESS_MENU as an upper
+		 * limit.
+		 */
+		for (i = KEY_OK; i < BTN_DPAD_UP; i++)
+			__set_bit(i, kbd->keybit);
+		for (i = KEY_ALS_TOGGLE; i <= KEY_BRIGHTNESS_MENU; i++)
 			__set_bit(i, kbd->keybit);
 
 		ret = input_register_device(kbd);
-- 
2.41.0

