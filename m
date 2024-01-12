Return-Path: <linux-kernel+bounces-24404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3AB82BC1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D72F283369
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D45D743;
	Fri, 12 Jan 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ4VUlhU"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7A5D8E0;
	Fri, 12 Jan 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3e416f303so26204095ad.0;
        Thu, 11 Jan 2024 23:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705046272; x=1705651072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1zgSO6gdbHTTWvN7qp5pJTd1aLnPZ/lO5bfOXL9xEyU=;
        b=VJ4VUlhU9TyiNT5zC6TewmmfeL/bpvtO3pviO7z14701Z3m/mtMFPeHRCPbrTj+tsL
         qat8Pj8eYuKvNytFVfHXMUm4uP1Ml17zHoY/eupe0QR8S6EIROsCsBJBM/wIIOUmy0HI
         Jxr0Q958BaZxmbz9HjVsuUqKgTTwTFU8GUwbJ3YDFnSONkbwyQlR6Dixh/ZAHvMLrJHF
         Tk8Pl31G3lKBqLDhAW9scJIev++jXuIBmTFdLXSRrSFu4toa9GcgU+paaZj6IBiqgarK
         dUXjxYba93YGwwO2O8ufkt4WjNccBeGmjiMJ9t14aKce+eFjxgfYHQzCuzb3ZOW62E3m
         iC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705046272; x=1705651072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zgSO6gdbHTTWvN7qp5pJTd1aLnPZ/lO5bfOXL9xEyU=;
        b=mjVAA5ujWv8qEUvOAdfe5XWIG0lwMe20VlzwVR9lYfINq1dA40HzpkCAEk8IE3pbUC
         Kw5VnBlla7MZlDeIOKHxFVg4bKXTTmMgk0O01o6ARpZuhvhHjKf2SzLNiPT5XtVUGqEm
         rOI/lcX4dYYL28BnFmIU1eU7zhV21PV4GhCXc6pbnOSERmRhLFxl38aqQSXiHGoIcNQ6
         hSIhg+oayNPMVpjdgs+v/33e5zUOW+ciOGle0zDc0ceX21krwMhQc3FplMRossHwmORH
         xWg2nX9H9TIsRxRkiIh2anbmH93q9agCJTzhEkdjvwPp/6bTh0ysktQi6vMWwVDA6nHM
         yNew==
X-Gm-Message-State: AOJu0YzIgjThc9ajuLsR0n2UaHwNVWVgYnC5CWf8+QpEuyJTjEpUVYgH
	G1zMhrEZhBCX+WYy5liJop0=
X-Google-Smtp-Source: AGHT+IHe33Y/uheKihjZM9nRKDUPf7PYrG/DOFV1Ag5i+kukZ3cQlRtp0Ayv6V3BBWOjwgLBz/v8cQ==
X-Received: by 2002:a17:902:c18d:b0:1d4:9c06:1815 with SMTP id d13-20020a170902c18d00b001d49c061815mr434195pld.59.1705046272109;
        Thu, 11 Jan 2024 23:57:52 -0800 (PST)
Received: from g2039B650.. ([2001:da8:203:a502:f7b6:d9a7:52f2:e69c])
        by smtp.gmail.com with ESMTPSA id lo13-20020a170903434d00b001d3a371cd24sm2496117plb.53.2024.01.11.23.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 23:57:51 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony@atomide.com,
	l.sanfilippo@kunbus.com,
	john.ogness@linutronix.de,
	tglx@linutronix.de,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] serial: core: Fix atomicity violation in uart_tiocmget
Date: Fri, 12 Jan 2024 15:57:32 +0800
Message-Id: <20240112075732.16730-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uart_tiocmget():
    result = uport->mctrl;
    uart_port_lock_irq(uport);
    result |= uport->ops->get_mctrl(uport);
    uart_port_unlock_irq(uport);
    ...
    return result;

In uart_update_mctrl():
    uart_port_lock_irqsave(port, &flags);
    ...
    port->mctrl = (old & ~clear) | set;
    ...
    uart_port_unlock_irqrestore(port, flags);

An atomicity violation is identified due to the concurrent execution of
uart_tiocmget() and uart_update_mctrl(). After assigning
result = uport->mctrl, the mctrl value may change in uart_update_mctrl(),
leading to a mismatch between the value returned by
uport->ops->get_mctrl(uport) and the mctrl value previously read.
This can result in uart_tiocmget() returning an incorrect value.

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 5.17.

To address this issue, it is suggested to move the line
result = uport->mctrl inside the uart_port_lock block to ensure atomicity
and prevent the mctrl value from being altered during the execution of
uart_tiocmget(). With this patch applied, our tool no longer reports the
bug, with the kernel configuration allyesconfig for x86_64. Due to the
absence of the requisite hardware, we are unable to conduct runtime
testing of the patch. Therefore, our verification is solely based on code
logic analysis.

[1] https://sites.google.com/view/basscheck/

Fixes: 559c7ff4e324 ("serial: core: Use port lock wrappers")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 80085b151b34..a9e39416d877 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1085,8 +1085,8 @@ static int uart_tiocmget(struct tty_struct *tty)
 		goto out;
 
 	if (!tty_io_error(tty)) {
-		result = uport->mctrl;
 		uart_port_lock_irq(uport);
+		result = uport->mctrl;
 		result |= uport->ops->get_mctrl(uport);
 		uart_port_unlock_irq(uport);
 	}
-- 
2.34.1


