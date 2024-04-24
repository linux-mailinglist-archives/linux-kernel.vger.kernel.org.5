Return-Path: <linux-kernel+bounces-157367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322428B1096
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AA91F21F51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DDF16D31E;
	Wed, 24 Apr 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbb7uZqu"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2116C450;
	Wed, 24 Apr 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978176; cv=none; b=W1sAl3NaUqf2VaZN5NXWGW3fDMc1bZg3LYce6yaMHf5bY/pzlI33Far0U9XGtCng0vi5zY8EFcq9nYBPmPMnyFG6fDIYghdGNerPJ7BoaC9e8PAkahutbSmzFCU9fM++Riohg0bmO1+ICbpgv2e75Hw7G9n/9OMHm/GEa5hY04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978176; c=relaxed/simple;
	bh=sVJO/BKaSzrNDK1BuUol9EaOvF6F24rNvwFG2KMaPIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MM0q4jlkGKwu7i4oyDREIEnR4OkBObNDBxdBzg8pfXh85Iwc9wEIBlHTiC6SqTP101myMGfLO263XPNakmOt3UPdc6STw7Qb9peyNOSXlFmPfQswm5+RWh6lsb0l2qMAcFC00szdb/SehBMWvlMn/f0Y8wzOAxabaask5A6r+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbb7uZqu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e8fce77bb2so365525ad.0;
        Wed, 24 Apr 2024 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713978174; x=1714582974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=d7bcMFCKOE077QNcsobA/coMeuJl5x7tICqaNKYUnZk=;
        b=Vbb7uZqu1Twk6KCV/bMpVt20bvaa0IR915wiF+42Z0DSg7FStTz9j0xJhGcHLI8jRY
         /lK+4NbmTZdWpqrOiweAvhCcq9y6rM9YaTCoD7kWOSADlr5O9rmKUVoH8uGmcXH909Tp
         vXvWWjYT4o3R6yotVNs6NTCxB8kddM/M2GwfqcDfHeqX7Xe8jkQIF1jW/QZ67iTGZPqH
         +NTcJc9vh3qmWOnvFAHSUU37o4TS5dZPThMzukCX6ppQcmCGhVSkgGMnfWx7Eo6iAFbY
         yh43K7mMy0x3h07EzjO/DPpfYmZNxTUzHkKWkqShuJPxK8FKtY9BoVko05hUO3MERQ3+
         W/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713978174; x=1714582974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7bcMFCKOE077QNcsobA/coMeuJl5x7tICqaNKYUnZk=;
        b=JWQr3BgPDaSoQpzE07jx756y2vwGteeI4azGaGs6JjGryGl9GXTYHdUqnbyWcxdca7
         7rDrCwc8wk5e3Q7WF2DlIMZeMYssQniBlJ87+LLTnAKBUZVChS6cpX8lgsq3f+MYS1Sj
         TNjDMAJXLJ12kq1TZEMtUqi3jyhde8pbUGU8idYbkTE2JHtMoELZABD/q4587TIqS/7f
         i2kBWLZqcAYaab5FyS6Ot6BsKq1hpHbL7aaXiiZayXQ62OmLnTjI8vRtWTruP34KHhkV
         heRuELr83nqNevmiRsPHbAD9cwLu33KLqp9hvacWBu5ZE5dBSsD0Au/yrTvBNqTzW/Sh
         BV/A==
X-Forwarded-Encrypted: i=1; AJvYcCXMnZ0DR2jkNZTMqxBTHjMYyYHa7SDrFHCE0bnsQD9dA387w2YI9Iz1KWkbi7cjkktGZhDo6voEikY6wkRYQxbx8Onz1n/nRb9o36N2ZKxNxB8R/AKbw/eYoo0ZvzGGf4J594PBBhjI
X-Gm-Message-State: AOJu0YyaY3qSvxHh+KbXuj+ve/1bdW19kxJhMqe8mMeQDSUqv7JEqLhp
	KDbDopa/wVfAVIjcAEKaYPgAWFqIh9xTb6iAhuwFaPo0c2pg5IKG
X-Google-Smtp-Source: AGHT+IEaEHo9pgGHRcWg/itteSiVblxaDrpFI/q2gwnHa4l7jE5PauAW4U8fYv0zqQjHHQ1gHflcww==
X-Received: by 2002:a17:903:2a8b:b0:1e2:d4da:6c72 with SMTP id lv11-20020a1709032a8b00b001e2d4da6c72mr4133171plb.0.1713978174346;
        Wed, 24 Apr 2024 10:02:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e0f5034e95sm12102466plh.288.2024.04.24.10.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 10:02:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] usb: ohci: Prevent missed ohci interrupts
Date: Wed, 24 Apr 2024 10:02:50 -0700
Message-Id: <20240424170250.3738037-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing ohci functionality with qemu's pci-ohci emulation often results
in ohci interface stalls, resulting in hung task timeouts.

The problem is caused by lost interrupts between the emulation and the
Linux kernel code. Additional interrupts raised while the ohci interrupt
handler in Linux is running and before the handler clears the interrupt
status are not handled. The fix for a similar problem in ehci suggests
that the problem is likely caused by edge-triggered MSI interrupts. See
commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
edge-triggered MSI") for details.

Ensure that the ohci interrupt code handles all pending interrupts before
returning to solve the problem.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/host/ohci-hcd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 4f9982ecfb58..4d764eb6c1e5 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -888,6 +888,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	/* Check for an all 1's result which is a typical consequence
 	 * of dead, unclocked, or unplugged (CardBus...) devices
 	 */
+again:
 	if (ints == ~(u32)0) {
 		ohci->rh_state = OHCI_RH_HALTED;
 		ohci_dbg (ohci, "device removed!\n");
@@ -982,6 +983,11 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	}
 	spin_unlock(&ohci->lock);
 
+	/* repeat until all enabled interrupts are handled */
+	ints = ohci_readl(ohci, &regs->intrstatus);
+	if (ints & ohci_readl(ohci, &regs->intrenable))
+		goto again;
+
 	return IRQ_HANDLED;
 }
 
-- 
2.39.2


