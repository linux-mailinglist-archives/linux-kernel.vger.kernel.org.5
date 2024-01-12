Return-Path: <linux-kernel+bounces-24623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E9982BF4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D641C23E81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755CC67E92;
	Fri, 12 Jan 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0aAgev6"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2212628C;
	Fri, 12 Jan 2024 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3e05abcaeso45131865ad.1;
        Fri, 12 Jan 2024 03:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705059399; x=1705664199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sWrCZL0MUf0/v1ldLxEN0HHN9kGNU4cHTH5M1KGPg2Y=;
        b=B0aAgev6CQPlhuBHPYUdg36yaeLaMhZW+YcIyw4+lRf/dVbu4KB8DPosuQaQnP6OLu
         Pzt5ubBPEPx5Vq8FpE1q6SG8WuQYtRkaBEZ7QXdAOeCeZ78seDaVgCjATCfwgYDqEgMU
         NlXJy4yK6MD5QL6gX4o/BgdiMC3gag954kFfeMfEl5vHTpXVOUkBuejGoXcosv7s7jFH
         Ef8Yd/4+WnMh62fe+KXKpbuLzWnosOzVGntMOT2mTduoFPlXd0GwXz7+f0CpFef03GcN
         38dE+Ucf8tS2Dib7MgrD7d3piWe5sUi0EyW+s2/a7tbdwEsG+ABvJLT/C7yurdodKCz/
         sOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705059399; x=1705664199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWrCZL0MUf0/v1ldLxEN0HHN9kGNU4cHTH5M1KGPg2Y=;
        b=ln+M+ESMYoienVBgl0WpN5bmzlxN/Aj29hL4DvD6XnQ5F58dcbM4fUPs3q4q1v/kAx
         3S1jsvqD8g3jMt6WMz2BIr75FETV7xlAZl1zoD1f9x2AtCkpirnE+zXnGbK1wdm4FAvr
         cLOtYFgM3gCWBlqNpprKHiftZggjrfgYopW1O0g2+pIIQaVVkQlnwTW1FPOmmmguGbBp
         EijgcyD3ikhhZt7PJtsd2332qkOdw9Yitc2wkZGSKPpPnv3Za876wsy/KN4G9pILXBQ/
         gLN2AjY99ymBO9IwP6bu/e+r0/6DgqrO6qSkuVpXkxsaqXAE5Bp0+v0ELgJEbgxtOohf
         7y1w==
X-Gm-Message-State: AOJu0YzMK0+/PA6POV6PxCVfMK9rySidY6zq9wGO5zMhMkK84yirYkis
	BMn5e67t4Qz+cuxc5WKZMjk=
X-Google-Smtp-Source: AGHT+IG0HlVO628oe4uOAXLzcwT5UA3yEIByl6cDeOhA2VxZpVQ8/4f58+nvxjk/jyTGB8JR0Lh9sA==
X-Received: by 2002:a17:902:aa44:b0:1d4:914:b38c with SMTP id c4-20020a170902aa4400b001d40914b38cmr628797plr.9.1705059398882;
        Fri, 12 Jan 2024 03:36:38 -0800 (PST)
Received: from g2039B650.. ([2001:da8:203:a502:f7b6:d9a7:52f2:e69c])
        by smtp.gmail.com with ESMTPSA id r18-20020a170903411200b001d4752f540esm2930789pld.198.2024.01.12.03.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 03:36:38 -0800 (PST)
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
Subject: [PATCH v2] serial: core: Fix atomicity violation in uart_tiocmget
Date: Fri, 12 Jan 2024 19:36:24 +0800
Message-Id: <20240112113624.17048-1-2045gemini@gmail.com>
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
    port->ops->set_mctrl(port, port->mctrl);
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

Fixes: c5f4644e6c8b ("[PATCH] Serial: Adjust serial locking")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
v2:
* In this patch v2, we've updated the right Fixes.
  Thank John Ogness for helpful advice.
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


