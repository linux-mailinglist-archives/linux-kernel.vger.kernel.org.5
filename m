Return-Path: <linux-kernel+bounces-157636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902C78B13E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22221C23732
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E33613C3C7;
	Wed, 24 Apr 2024 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZnTKSCL"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97D134A8;
	Wed, 24 Apr 2024 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988796; cv=none; b=deIOXer+XyNChm7p96Dxw/Tuoj7qimHn/jJyeHT8HH388k0pMflRBQcV4yuzcdZdEiFtcZgsuuFqDCH+1u6HeoVMQIITZDiSGer7Frxzd0UevJu7WxunCwASXRzYO6qS9uqAAaC8kz7GtPfDppdbN9t+YjsN5vXWnoF1g3Jkub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988796; c=relaxed/simple;
	bh=vi6AkKXBc9c+GYEXIEdFiWP8KbJ7sqIZMgCf/rw5r3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/NnGBfRfYxMBb/Z1EQVnLN4KH/Zqnux9nxIuZmPS+NJSULSHqw2PoCim4mIGd8Z690BIJjTvfvdN+1VLGyH9IxfGvVznBmIRDFQkDw/Vx2+MDeSnJtQCha2yDzcXTv13ccc2NKqr6w3pLeBqBI8IM4oThSQg0272tHDo4MmG4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZnTKSCL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e834159f40so1895265ad.2;
        Wed, 24 Apr 2024 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713988794; x=1714593594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MIzvdFzDODP32w8DOczot1T9bmoGo9OmYm5q0ikidhs=;
        b=HZnTKSCLR+KB/3JoEQErdBSIVmyNz5IO4WwKbQ+1uidIgdVX5+w1nnYyZ6q81mhuDT
         waLRzS21nla7z3fh7BUiYWero1aAnJU5KXvkz3xpLUrQ4+mdFdYgSqaSMtQEQipPAtI1
         CH9tSDH/p9hQvrd/vldSQ7RnQHqvzDVujbj4SRYtO/eWfMPZhiuYq2/qOI7uZeZldMbc
         XVI/GjxfNxiEENT9FWekZS5CUY07/uUti60ptWOVrebCAC/US+xmPsOJNfo5cWk5wRY8
         MYvdA19RzzObsv/DOE39xQIaWMCCRYZEpPZLWvv4dUdCcgPxJi+51rxzVLYk9aSQk0Qz
         ONwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713988794; x=1714593594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIzvdFzDODP32w8DOczot1T9bmoGo9OmYm5q0ikidhs=;
        b=VVAn7iOfb6isRgx5CySgCPFNp3OIoqKbq5S8xh6OQB+hj4PJaUSfdLNpuHkviA5cVD
         UpvLQX0y7Q/E1AW4+FlB5UZN697MdVH3xKMc9HTV0XsMesoIWvG1gSyYl0bc1Z1IV794
         bH5FH6Tx8t+xxBgEOJspW34LaPUQA2dd4ljef9zgK2I4qwFiXc7JHWcck9BBWeCqCSO5
         BzlhOF0XXQRQffRASBj/JY5XPcBFIQhCEz5pfp9TMETx1Md4VM+nMLBkbn4Jpc8F0FAd
         T/RZNk5VbBCr+2W5ThfPYUpI+lei5PhQP4njSlRXdKrdC4nDgUQJZHT9x3bsV3/Ad5Dj
         WRLA==
X-Forwarded-Encrypted: i=1; AJvYcCXHaED6sfJrLOL9D5HwOhq+4VrxuFaMzaiVNSjr4/2u+AGxSKH2DVZyUOp/OYXgnzCrV4TWTikiiug856SKAs9rzRF9bKvojUDdAxkF+ytSxZtdUlSsTNWT7zgw99JST/v+GOrWz+aQ
X-Gm-Message-State: AOJu0YzFm77nvcD65MrrNIwFOZh2ke3xz3sehPTgd+mUy6isyYXWF5x0
	tESa9uiHuaDOn0jBHwL44gVZvFNwKtRMmYKhcn0DLxR6Lmvb/KYz
X-Google-Smtp-Source: AGHT+IG46JS2ISuXZa5cmelECZGUfN6vJslF2KAaKbURG3yvG0on7s7x8zCC1lYBcPjoCJQCQvHEbw==
X-Received: by 2002:a17:902:c40d:b0:1e4:d548:81a0 with SMTP id k13-20020a170902c40d00b001e4d54881a0mr3732923plk.67.1713988794488;
        Wed, 24 Apr 2024 12:59:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001e80154a400sm12286283plg.126.2024.04.24.12.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 12:59:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
Date: Wed, 24 Apr 2024 12:59:51 -0700
Message-Id: <20240424195951.3749388-1-linux@roeck-us.net>
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
v2: Only repeat if the interface is still active

 drivers/usb/host/ohci-hcd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 4f9982ecfb58..bb6b50b4a356 100644
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
@@ -982,6 +983,13 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
 	}
 	spin_unlock(&ohci->lock);
 
+	/* repeat until all enabled interrupts are handled */
+	if (ohci->rh_state != OHCI_RH_HALTED) {
+		ints = ohci_readl(ohci, &regs->intrstatus);
+		if (ints & ohci_readl(ohci, &regs->intrenable))
+			goto again;
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.39.2


