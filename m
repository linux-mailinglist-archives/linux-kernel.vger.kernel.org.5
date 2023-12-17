Return-Path: <linux-kernel+bounces-2788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0C8161DC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DCA1C218CE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4FD481AF;
	Sun, 17 Dec 2023 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL929++I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27404481A0;
	Sun, 17 Dec 2023 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e389473fcso251559e87.2;
        Sun, 17 Dec 2023 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702842956; x=1703447756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YqwD9ZP1yBAmVRI8A0HzSQfZ9nKesVuzEsxqwxMz5Lw=;
        b=VL929++IYGIMwrLkJpPskQUar2rs7SOE7A4p8pls1vCp8aHTg366+wwwdTINMXNpGP
         ogOL8Z20azdHrbMIywp4X4Rf40JHwHau4rp6yKKyo9mmTZ8aGV5baR7eKCBjZXAsA5Yo
         tDbxBK37QcGWoix3cBNiuw7ymVXpggRlNhJk0gatKUIWhxACNNTHLaiAo3Ys8jq1cTHu
         F35p+Zu/YLr+n1O3jRkhgl/nz0V0KmDoF0/EJKxtYk/seWBx8GKldckZDkxWDUronhg/
         Idv5yEfUYltY8kq8klVuicCTgUIhlsLZVj/zQLyjGUIpxgcg6JdRru6J3McBj6Dv3V9t
         HcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702842956; x=1703447756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqwD9ZP1yBAmVRI8A0HzSQfZ9nKesVuzEsxqwxMz5Lw=;
        b=AiQnsNiU9NVbcUT9Yo8Aby/xuP7wzpzzTG6zzPY54jPtmL1TvS8W7Oto1BJRnOndef
         8mrQwR2cNG1tfBJTqdMhbd23dGrytoJ4dvYeJaPLTZ9l0ECzca9D1o4ZFjj3r/kx8ZTp
         UPM8NtxJmYAZ/wKD98R+fcTJgyc7RAg0khNucBzWbq+PPIk/UzoDgnW2YD/xyQo/o8A9
         TiEJKsDkIBF+c95PjsLEVFM1sKd+b/PYv8E+xd4ryNoLQQw2opDt96bL+UxI8T5jmQ2C
         kyIlVfNhtR4MzbLOYafY7ZxaxjSpzcuKMHOiAmcK6cXUD0GV7xzhtsx2vOdlT9R0DVfd
         gCHw==
X-Gm-Message-State: AOJu0YyPCfdNKeKFVOFdqWRU2Ua0CAN2Eqlm51degeLBff+VHKoL499h
	tg3zKuHPQN6sk+OFCsNuZSwFj28OZW0=
X-Google-Smtp-Source: AGHT+IEVfKEALqPMNDPPxJZC/BFAW8UVFhZbPGl2/HFfv/89yQnH02j5RYLgyu6+BJ2fs2KUeepdyw==
X-Received: by 2002:a05:6512:33c7:b0:50e:1ed9:cb41 with SMTP id d7-20020a05651233c700b0050e1ed9cb41mr2098057lfg.35.1702842955932;
        Sun, 17 Dec 2023 11:55:55 -0800 (PST)
Received: from cinco.. (109-252-3-142.nat.spd-mgts.ru. [109.252.3.142])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24bcb000000b0050d1672f104sm2630426lfq.173.2023.12.17.11.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 11:55:55 -0800 (PST)
From: Antony Pavlov <antonynpavlov@gmail.com>
To: Tobias Klauser <tklauser@distanz.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH] tty/serial: altera_uart: use more informative labels in /proc/interrupts
Date: Sun, 17 Dec 2023 22:56:01 +0300
Message-Id: <20231217195601.236002-1-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to this patch:

~# cat /proc/interrupts
...
 40:        123          0     GIC-0  72 Level     altera_uart
 41:          9          0     GIC-0  73 Level     altera_uart

After this patch:

~# cat /proc/interrupts
...
 40:          6          0     GIC-0  72 Level     ff200100.fpga-uart0
 41:         28          0     GIC-0  73 Level     ff200200.fpga-uart1

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 drivers/tty/serial/altera_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 77835ac68df26..7e28928e58787 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -305,7 +305,7 @@ static int altera_uart_startup(struct uart_port *port)
 		int ret;
 
 		ret = request_irq(port->irq, altera_uart_interrupt, 0,
-				DRV_NAME, port);
+				dev_name(port->dev), port);
 		if (ret) {
 			pr_err(DRV_NAME ": unable to attach Altera UART %d "
 			       "interrupt vector=%d\n", port->line, port->irq);
-- 
2.39.0


