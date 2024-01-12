Return-Path: <linux-kernel+bounces-24648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA2A82BFAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735292879AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B86A03C;
	Fri, 12 Jan 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW71P7pW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A956A027;
	Fri, 12 Jan 2024 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3f3ee00a2so32698165ad.3;
        Fri, 12 Jan 2024 04:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705061935; x=1705666735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yd21D0eGifp+j/n8JGN2dPwhkSUU626oda0ydbwSyQ=;
        b=SW71P7pW5hLI4E+bJSMN2r2m6kM9aEtEZaF4dewyfYcLAT5TFknIkfM4p7scn+mFkl
         88osPMfUm4aH2cmOJMuq2JqvqmKcx9UyYbMzxCGMLkKy8IGNgaR2mYdsoEHQmasSMnXt
         JrBf7ZTSVtPwSKr6yHvBJ89b9fRe2Q/2ZgI+n338VOxgNzsP/0TRL3Z2RApmWO+wAcL7
         NVV3yQX/yvVvnjdKknoEJfGjCThbWJqriCRX2rBCEhXDCh2UPX4j4fUZU24Vu/AXkUH1
         /8KvLE2rL2DPEF/YY2o//CYseQ0q5hjvOZelWCYNXF4xIaOBCpbjHzpvpuUK6XnyViLy
         eM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705061935; x=1705666735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yd21D0eGifp+j/n8JGN2dPwhkSUU626oda0ydbwSyQ=;
        b=rIc5hupsKzQer4eP2knWFpJlhv7dtX5eIx3RBkUGylWJUk0+WZHwVT9KPrSJWjIOLF
         jL7V1WXK15ef7CKukVGjhlQv05Kn5Ig/0a84w7TplhOBledaXdp/lBkU48uD3/QvCtHl
         G3mipqeBnHLSfvrtIazVdKS2LOtv04b+V6i1WJi79CZNhrB9pjxsA03alvnPWrG+WRcN
         Hp9vOxTQydtCnEWDUBuig1Mba6Un/x/ffwXfJ6C0QLOHLYnVTqogZiV7YKERu7RuyxuI
         gCk0Mz5Sr+rgix9MexIVel52/QCp+jZBf+rLJ3CV/7Be1qrqjv2BCz67L6bhBUCASLKN
         SpMw==
X-Gm-Message-State: AOJu0YyKKrEfp1oTzhLOqjMFkBjBQJ85vVHn4rKO4qcFOxvwUZ15GrnG
	k4Yc5/mKQNVck18niYXBZBc=
X-Google-Smtp-Source: AGHT+IEHMfVQQ88cQ2csk+mi277mca0n5uZ2i1FCKzqjCs8phRCv9fbEzafbgTkoy5C22FjxDF1p8g==
X-Received: by 2002:a17:902:bb16:b0:1d5:8ac6:3cd5 with SMTP id im22-20020a170902bb1600b001d58ac63cd5mr594827plb.56.1705061935170;
        Fri, 12 Jan 2024 04:18:55 -0800 (PST)
Received: from g2039B650.. ([106.39.42.152])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902f70300b001d5a5a5e649sm1254451plo.273.2024.01.12.04.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:18:54 -0800 (PST)
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
Subject: [PATCH] serial: core: Fix double fetch in uart_throttle/uart_unthrottle
Date: Fri, 12 Jan 2024 20:18:44 +0800
Message-Id: <20240112121844.17580-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uart_throttle() and uart_unthrottle():
    if (port->status & mask) {
        port->ops->throttle/unthrottle(port);
        mask &= ~port->status;
    }
    // Code segment utilizing the mask value to determine UART behavior

In uart_change_line_settings():
    uart_port_lock_irq(uport);
    // Code segment responsible for updating uport->status
    uart_port_unlock_irq(uport);

In the uart_throttle() and uart_unthrottle() functions, there is a double
fetch issue due to concurrent execution with uart_change_line_settings().
In uart_throttle() and uart_unthrottle(), the check
if (port->status & mask) is made, followed by mask &= ~port->status,
where the relevant bits are cleared. However, port->status may be modified
in uart_change_line_settings(). The current implementation does not ensure
atomicity in the access and modification of port->status and mask. This
can result in mask being updated based on a modified port->status value,
leading to improper UART actions.

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 5.17.

To resolve this double fetch, it is suggested to add a uart_port_lock pair
in uart_throttle() and uart_unthrottle(). With this patch applied, our
tool no longer reports the bug, with the kernel configuration allyesconfig
for x86_64. Due to the absence of the requisite hardware, we are unable to
conduct runtime testing of the patch. Therefore, our verification is
solely based on code logic analysis.

[1] https://sites.google.com/view/basscheck/

Fixes: 391f93f2ec9f ("serial: core: Rework hw-assisted flow control support")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
 drivers/tty/serial/serial_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 80085b151b34..9d905fdf2843 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -723,11 +723,13 @@ static void uart_throttle(struct tty_struct *tty)
 		mask |= UPSTAT_AUTOXOFF;
 	if (C_CRTSCTS(tty))
 		mask |= UPSTAT_AUTORTS;
-
+
+	uart_port_lock_irq(port);
 	if (port->status & mask) {
 		port->ops->throttle(port);
 		mask &= ~port->status;
 	}
+	uart_port_unlock_irq(port);
 
 	if (mask & UPSTAT_AUTORTS)
 		uart_clear_mctrl(port, TIOCM_RTS);
@@ -753,10 +755,12 @@ static void uart_unthrottle(struct tty_struct *tty)
 	if (C_CRTSCTS(tty))
 		mask |= UPSTAT_AUTORTS;
 
+	uart_port_lock_irq(port);
 	if (port->status & mask) {
 		port->ops->unthrottle(port);
 		mask &= ~port->status;
 	}
+	uart_port_unlock_irq(port);
 
 	if (mask & UPSTAT_AUTORTS)
 		uart_set_mctrl(port, TIOCM_RTS);
-- 
2.34.1


