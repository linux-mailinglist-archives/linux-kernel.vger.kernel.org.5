Return-Path: <linux-kernel+bounces-60556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E3B8506AA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595B92810E8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C952605D8;
	Sat, 10 Feb 2024 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR//btsk"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1882605B7;
	Sat, 10 Feb 2024 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602010; cv=none; b=bhS20jVm9PdI9ZvZkWpCfBkL8kxgNTzKwS1AeX//aCA/bCWSmSPyviDlmcq10+qqLUTcz+ERuT2+Z1UYuRx5SlyogSQ4hAS94vi5kY3bOEwXRqGyZTLNVE2wd26eV2NCRpC5nGUTsajC4K2GS0AHRuN635q2xfD11gnKKlbGRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602010; c=relaxed/simple;
	bh=j9Y4Ee2XnyCp19O67N0N+PzpLOj8tGQB3EHMYWxJ/sY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KFgYE6BfmzntkvFWN6Lxg2k+tT5tBCN4cV8scyYlZWMfHerkPQibaamHbN12yb1kBinKNyyTgYhg+eGSu0T1G4G1Q1BTcchD9oWmjZ4v7hjM1B2zl2kmBWImnPjgX6q0zLbRL+3zBT2T+62aVRe6Xt4VmnFunZtmSPuX4nZk1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR//btsk; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116b2dbd16so1896344e87.1;
        Sat, 10 Feb 2024 13:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602006; x=1708206806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmNBPg3VhiKxOz/cULC4NqhIweOs07gq4ld1aCJ07ik=;
        b=eR//btskc3xYMI32WmF2j4WJAmcIPQhmJyqI//tFcDwba+ucp8z4GWQgV47+xygtqS
         fFZHT8EUKLwbR7Fj8CGk6d3tUsupZJjIZUFNbAJ8y9Fb3kvP5elowQX+tbUsWRFE24Ir
         L3MW63/4TVDdpu2SFwwkisA2HjqDMtowTmonA3PJZSZgmpSR4hOt/UXycN1aDusky49k
         M0d8rZPyOLU/kybEk/62u757D3AklBLfqhJZfJeBcbWRUK+fDhT7vNECoE7I9ePQKVk7
         UGnLUy0Dydog3j0b4rKx0taZ3iJhocu/k8CEw1nLlY8xLWCMzqiyMu04+/LwSL0sCciu
         /OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602006; x=1708206806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmNBPg3VhiKxOz/cULC4NqhIweOs07gq4ld1aCJ07ik=;
        b=tG5uMqD7hCEXB7EmIgyt+RVe/UYtAI1pPWA9BaedwFw1ZsptW4zPgoZALX+eoNfUKR
         eDtVNMRe+zO7X+M6SURrOKYGOarA9DTjQd1vCpRRnlzvUMvFNralitJwmoakme64GFy+
         UxMZYkeBDuFAK7905ouWjKigz9LKWJ6i2OjAUWCXcorVjM5SNKY9O2H1f4PzxOzpB2aI
         R4JPTo29mwttlWAzbdglLxyymZF+Z9b1vDYuh4ABCQ7n1GQuLUOoGIWaGzzi+kcrm+Mm
         W4F/Re4+c3brF1iJCYY4PdiwxnX4ePzOejDG1nH24ugfBF9YRYDqQ/AmPV3btTtJ+Yhp
         aKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/cJV+MAY9aJnlWuFyA1rPChCEo2OtPxZG40cbVbSnIAPI/Xsd8i7YbymwPMxXjqDyWPhUaogZ8v0ubmRXgaY9tBYESKujdm+RpCp+0l0wvLhAG5XgA2RL0LT6G8ylnIx3ETQWdtAwYwI=
X-Gm-Message-State: AOJu0YxdFtMkVYaPpKWC8yq68DWZyeZc95aL5fPfu1zLjsgAmXKjAsBi
	TUWaJeuJwy7Jg0//qSOpV7onLyxaFKsH/uGX9jsgdz0KrEm4GV+Y/JpcxDQr6MM=
X-Google-Smtp-Source: AGHT+IH1MkC8JlAa6ok/Ho3gydGYTceQL7WsLWlITu0ssxcyQuJf3Jc+ddV0yuuKdyKBLFlh0OltjA==
X-Received: by 2002:a05:6512:104f:b0:511:6ef0:33d1 with SMTP id c15-20020a056512104f00b005116ef033d1mr1893615lfb.13.1707602005668;
        Sat, 10 Feb 2024 13:53:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpRR7HJZqaXevIfw6iIyhAwY/evQBQmdJ5JdA89zOvE6c8S4ZXVucky6TT2udu6PhZLAC2xaSQDSWsMwYQQVLk8uHWhGdfNmbVRA4r0suNeC6y0B/6T6+Nj2xGy9zDyUYUsymrPs9AEHHPrtp5Wk6IZ3pPdm2RkTQMCjBq+o/ED0QAhiHB55t76LI94E+zjYkdkfoLWSsh7qWVi4IHWSWSgfZyIewvuRbdRTy9sA34y+jWd2v+rpBVcpKRgQ+izYavgQLieMF8iX+4ebJV9qbDTB2D7oUhMKgABgoVGXo/FeAsiSYuAt65kbbTg5lm+afOD0Nkj6pfrhduFdWFJv3xOBudtjUiDKjI+ravAFkoCJ2NX81W1w==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:25 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 09/19] hid-ft260: uart: wakeup device early to not lose rx data
Date: Sat, 10 Feb 2024 23:51:37 +0200
Message-Id: <20240210215147.77629-10-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Waking up the ft260 device from power saving mode earlier reduces the
probability of incoming data loss.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index ccd20f590720..6266e4f1100d 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1285,8 +1285,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 	bool wakeup_workaraund = false;
 	int ret;
 
-	ft260_uart_wakeup(port);
-
 	memset(&req, 0, sizeof(req));
 
 	req.report = FT260_SYSTEM_SETTINGS;
@@ -1529,6 +1527,9 @@ static int ft260_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 	ft260_uart_change_speed(port, &tty->termios, NULL);
 	clear_bit(TTY_IO_ERROR, &tty->flags);
 
+	/* Wake up the chip as early as possible to not miss incoming data */
+	ft260_uart_wakeup(port);
+
 	if (port->reschedule_work) {
 		mod_timer(&port->wakeup_timer, jiffies +
 			  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
-- 
2.40.1


