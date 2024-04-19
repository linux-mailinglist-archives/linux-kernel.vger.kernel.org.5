Return-Path: <linux-kernel+bounces-151319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A3F8AACE1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AEA1F223BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47277EF0A;
	Fri, 19 Apr 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZIrMUT+"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFEA3D62
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522643; cv=none; b=WwKgw9JqCax2zSfcIu/9kKwTQ64SIqeUj3acSuSc969n6Moug/INzGgIHTdRroHaf8pEYaPgzf0DNTHHcKRBG6+YfTxTpoysJ2TRUdN37q9xHm7p961sP+SFIASvpdCyvdI2O93IRmW2wMVWiIftpIjf6kYs8xCEVnGuc4pypa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522643; c=relaxed/simple;
	bh=C+qOn5JTN9zJb5FySGwxd2G4kTU2FmFYAYBmugqPSPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DmHgoismaQJBvDON+pLvkeSy+VUrvK1fPDuRDymbX5EmSpFAMHsiffUuta45W4UacGB87OIQCSlFugyJ0fCm+Ff6PrMld6gUJd+06JwE98iEcKjorAJXhxHhxrIpQcPC4XSJLM8vNZBWXBC55sqbdLy4/Qs2fjcoxzzujREMdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZIrMUT+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41882c16824so15063445e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713522639; x=1714127439; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zXfB1XmyJGycp6o9EvN2dcs3pfRs+qgNDmJ2Wpliu7Y=;
        b=OZIrMUT+//6cXhkvDocEAfhEH1IELAy6u9w1akANGX0tQK1JsF9DyJ2dBETGMKhFBy
         JHe4Kdc6pI9KIb3trnvSsMVNiGmS8iTX4AsLVeAcgHlqHjxwjrQecCV4MHFs9ioPvVOM
         v4PpWCuAW7NnvzksiOooxfWBxEZ0F+ZKf47o2B1uqbgkciCxbADPhJL7a9SVxr0kVcVO
         zVoha0DujNzBfGGVg7sGnGUSf2bv4xnHkOtlSA5MNpTskKzOTfYMWUEQORX3C0ghtJAW
         cgZd8kkZAT2JPuO2tSe/HzmiF6gQWL6HXc/1xo3C1XIfWc8qk9SMO/kryiAvMbM+eyh4
         tC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713522639; x=1714127439;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXfB1XmyJGycp6o9EvN2dcs3pfRs+qgNDmJ2Wpliu7Y=;
        b=HIZEnAOMzsMnHc7gILCePE5dFHv09B19AO2157gqfNQdE+0mRhRgxy4PiU7/gQcTWK
         OzrEMBlxBwX43Kherr/beD6LK23d0qbNxeO0h0kYyjqd+OhLgOzgKqLgHnNEdtNO5KDH
         bMYWjaJM0cWaDbLiiciuNoJcVHa443rRXKKBvFz9w0yqYVxFPeKbtiC/b0fDy6/m/8oj
         h/O9qqmXcG2yhVZcJ1EcOr7Sesnk76gTTleMRPdZH9PF2o/aHXJD2nhdt6RQ94IIrCQe
         LCEjo2xTJBHStla1ZYjZB3tOoArBa0PPXcKyjk1A2btFptqY97CrSp/GT30LYZeBmCfB
         LbTg==
X-Forwarded-Encrypted: i=1; AJvYcCXN37p13eLHSUIkOtdVELYyNAHO+MRs7A3CuIny7GHmljMd5Rz/VYCdUSP9eFEnMavbsJe/Owj66OfajRPCp6q9fZJ77iNtkXcDiVcl
X-Gm-Message-State: AOJu0Yy5Xdc1S8bZFk1oW6hatkzOVohpBmQQT2X745RTBlHK9hGk0V/l
	4nWQOr9rbxHv/1DHtLpnTbFkciyU6Ag2mSWES+PvNyIkJvYN5p4u3I5N4qYlD84=
X-Google-Smtp-Source: AGHT+IGiH7Y+JOa4zFWT4uBG5e0nxTZ7q2bT95W8eY0sXWj0RTRbbUTMVj2Y/lTD0+EbzWnZRuMC8Q==
X-Received: by 2002:a05:600c:3ba3:b0:418:d4a5:b10c with SMTP id n35-20020a05600c3ba300b00418d4a5b10cmr1203298wms.28.1713522639574;
        Fri, 19 Apr 2024 03:30:39 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id jg1-20020a05600ca00100b004183e983d97sm5885615wmb.39.2024.04.19.03.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 03:30:39 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 19 Apr 2024 11:30:01 +0100
Subject: [PATCH] serial: kgdboc: Fix NMI-safety problems from keyboard
 reset code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-kgdboc_fix_schedule_work-v1-1-ff19881677e5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKhHImYC/x2MSQqAMBDAviJztlB1BPUrIqXLqINipcUFxL9bP
 AaSPBApMEXosgcCnRzZbwmKPAM7620iwS4xlLJEiUUrlskZb9XIt4p2JnespC4fFjFKaxBNo6s
 aIeV7oCT963543w83lr0YagAAAA==
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Liuye <liu.yeC@h3c.com>, 
 stable@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3694;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=C+qOn5JTN9zJb5FySGwxd2G4kTU2FmFYAYBmugqPSPE=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmIke9ZVMNfK8Mz+OrFbqaCdj672YT4w8UQ6ueq
 XBwtvN/r82JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZiJHvQAKCRB84yVdOfeI
 ofNLD/0Umjj+W7GAbBqQ40IwzKkdPszIlUlf+waYzWOInyWrpl4sPA64fuVxOM2OiIaMG76D5wZ
 TaHUmY75/p8yYCvxnDmCImLbbfksCTqMWW6U4OIg/Smf2j04Qr11sM8bjhpZsS7yDBZK6wCdFec
 ixKLPDfcJLWujuojN8mgtzUD5HDdNTytJFS7HsMTNC9sZHHUN0quVcTU3P6AaqYApXoBzQN2H6B
 HtDoEBSNjeeq/LrZCcrLHNTgWTQ9xlnZVOHFdlzCmSSMKaonGBK2Q57W3yOgcdGUqkL3fTmM97+
 EebnbAIuqfIHzbeHkFJNDThEsUCqyg4GXpHi/De94YHJoab9H8DazLfa5p1BqmVM7obUOK+4z4v
 nLTeji+w4KrvcAqxGu5y4IHL3rwd7c14dD0USQqNS32p1mnzrkJN95l7SV2MwyeBjiAFJ6j8dd7
 NEOqHbly54qnGxAKN2NNAjo6b7upiB3zBnvKB8smcKodgoNxiqDzXWmRlXWrSymGVUidj/WQBpq
 343NQhA3JUChjQXwvXUONWV/Vka8QXMflolG+vVdOGfXbjfWyXlkWVMtNuOBFZR/1ChTcqAWYls
 1BuHcD+sywGdEzXvb2qP7Fbc4S47aYDSAy+T2fX4aDz5z+9qpjG+EvMJniaR7tceykHS3GzOOMi
 v/BaL26UzkgkwSQ==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently, when kdb is compiled with keyboard support, then we will use
schedule_work() to provoke reset of the keyboard status.  Unfortunately
schedule_work() gets called from the kgdboc post-debug-exception
handler.  That risks deadlock since schedule_work() is not NMI-safe and,
even on platforms where the NMI is not directly used for debugging, the
debug trap can have NMI-like behaviour depending on where breakpoints
are placed.

Fix this by using the irq work system, which is NMI-safe, to defer the
call to schedule_work() to a point when it is safe to call.

Reported-by: Liuye <liu.yeC@h3c.com>
Closes: https://lore.kernel.org/all/20240228025602.3087748-1-liu.yeC@h3c.com/
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/kgdboc.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7ce7bb1640054..adcea70fd7507 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -19,6 +19,7 @@
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/input.h>
+#include <linux/irq_work.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -48,6 +49,25 @@ static struct kgdb_io		kgdboc_earlycon_io_ops;
 static int                      (*earlycon_orig_exit)(struct console *con);
 #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
 
+/*
+ * When we leave the debug trap handler we need to reset the keyboard status
+ * (since the original keyboard state gets partially clobbered by kdb use of
+ * the keyboard).
+ *
+ * The path to deliver the reset is somewhat circuitous.
+ *
+ * To deliver the reset we register an input handler, reset the keyboard and
+ * then deregister the input handler. However, to get this done right, we do
+ * have to carefully manage the calling context because we can only register
+ * input handlers from task context.
+ *
+ * In particular we need to trigger the action from the debug trap handler with
+ * all its NMI and/or NMI-like oddities. To solve this the kgdboc trap exit code
+ * (the "post_exception" callback) uses irq_work_queue(), which is NMI-safe, to
+ * schedule a callback from a hardirq context. From there we have to defer the
+ * work again, this time using schedule_Work(), to get a callback using the
+ * system workqueue, which runs in task context.
+ */
 #ifdef CONFIG_KDB_KEYBOARD
 static int kgdboc_reset_connect(struct input_handler *handler,
 				struct input_dev *dev,
@@ -99,10 +119,17 @@ static void kgdboc_restore_input_helper(struct work_struct *dummy)
 
 static DECLARE_WORK(kgdboc_restore_input_work, kgdboc_restore_input_helper);
 
+static void kgdboc_queue_restore_input_helper(struct irq_work *unused)
+{
+	schedule_work(&kgdboc_restore_input_work);
+}
+
+static DEFINE_IRQ_WORK(kgdboc_restore_input_irq_work, kgdboc_queue_restore_input_helper);
+
 static void kgdboc_restore_input(void)
 {
 	if (likely(system_state == SYSTEM_RUNNING))
-		schedule_work(&kgdboc_restore_input_work);
+		irq_work_queue(&kgdboc_restore_input_irq_work);
 }
 
 static int kgdboc_register_kbd(char **cptr)
@@ -133,6 +160,7 @@ static void kgdboc_unregister_kbd(void)
 			i--;
 		}
 	}
+	irq_work_sync(&kgdboc_restore_input_irq_work);
 	flush_work(&kgdboc_restore_input_work);
 }
 #else /* ! CONFIG_KDB_KEYBOARD */

---
base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
change-id: 20240419-kgdboc_fix_schedule_work-f0cb44b8a354

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>


