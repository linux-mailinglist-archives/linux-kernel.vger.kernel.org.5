Return-Path: <linux-kernel+bounces-24670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E1282C037
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF861C21BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0602F6BB37;
	Fri, 12 Jan 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9sgU9YS"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B059B4E;
	Fri, 12 Jan 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-598699c0f1eso2457143eaf.2;
        Fri, 12 Jan 2024 04:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705064295; x=1705669095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKCP4kSmi8Znay+ncNnEwwM69gACCAM8H97RoLluFSU=;
        b=i9sgU9YS4bbT/hL35ORVlh7BSyMLzDm4VYmgEcS2w8+k4SlBGyEUtmQQA5p+MoLY5m
         o0pH/usAbtSngmVqc1e53QGetkcOQ9e2TKDXtSVfkW+eKSA4PQhvZBqtG8pFSk02iClO
         iPgx5vVrMj5t0qTuMCGvRH937H51AtiGu0lK/OAV2JzGTJPUW/WwRZA7PDuPRQYNt5wM
         BpZdUlJjrcahzzjxVqlF8uvDnWYxoWh0tMI1evcd5RmGlSkAk3V9z496xjKcon2/8XsK
         Kp7S8UtQwv2ouqKPi+1i8ODiVu8cDatmvkO2IQqkfIMzsj46H62SeTXbCAgqp5e8HOVq
         g/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705064295; x=1705669095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKCP4kSmi8Znay+ncNnEwwM69gACCAM8H97RoLluFSU=;
        b=TJw7c5kNHIMih9HNNyYOmPPpwAxft0+mv877XxDmXkuzu2GSKMF4uCz233PH3r8+l7
         +k61fjhxjy03W6YNGH1/ZnfJVfeYPqm1X/gVcusO7YvqupudlsnyNJfs/bT6+b66uKQk
         GaWbp8BUf7/nvEbSA151Z0CK2rKesf554pUEo4ykbCfLDKBIGZkBFrkAFr5ID/XYB1c/
         Ede/QQQjaGQKCsF1iX3oiR2EcepaHSjBbyu7PvfFSa+T54dUaSnQL3owv6CHw6z7dhpi
         ke3ySCOBIC1eVuggZGPcOBZb351psxWSq1Ei7t1cFfx+as/QoM0gkawsIPmPtEVFjaC2
         AjJQ==
X-Gm-Message-State: AOJu0YxCJyL6QKus+ne/TqCwveemwoA6+vdEGOXU9+SeH2p0mLy7890A
	y4fhthPY0UYiPiAzcfiVDw0=
X-Google-Smtp-Source: AGHT+IFyWL6bt24i5tSo2BMxGDGJWVKgM4GucDENZVqsHtJAJBXAYskf/llxHwOfhtIMdDRmCxXWaA==
X-Received: by 2002:a05:6358:4d83:b0:172:ae2a:2256 with SMTP id cc3-20020a0563584d8300b00172ae2a2256mr1350395rwb.27.1705064294552;
        Fri, 12 Jan 2024 04:58:14 -0800 (PST)
Received: from g2039B650.. ([106.39.42.152])
        by smtp.gmail.com with ESMTPSA id fd14-20020a056a002e8e00b006dad4c91e8fsm3103080pfb.205.2024.01.12.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:58:14 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tty: fix atomicity violation in n_tty_read
Date: Fri, 12 Jan 2024 20:58:01 +0800
Message-Id: <20240112125801.2650-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In n_tty_read():
    if (packet && tty->link->ctrl.pktstatus) {
    ...
    spin_lock_irq(&tty->link->ctrl.lock);
    cs = tty->link->ctrl.pktstatus;
    tty->link->ctrl.pktstatus = 0;
    spin_unlock_irq(&tty->link->ctrl.lock);
    *kb++ = cs;
    ...

In n_tty_read() function, there is a potential atomicity violation issue.
The tty->link->ctrl.pktstatus might be set to 0 after being checked, which
could lead to incorrect values in the kernel space buffer
pointer (kb/kbuf). The check if (packet && tty->link->ctrl.pktstatus)
occurs outside the spin_lock_irq(&tty->link->ctrl.lock) block. This may
lead to tty->link->ctrl.pktstatus being altered between the check and the
lock, causing *kb++ = cs; to be assigned with a zero pktstatus value.

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 5.17.

To resolve this atomicity issue, it is suggested to move the condition
check if (packet && tty->link->ctrl.pktstatus) inside the spin_lock block.
With this patch applied, our tool no longer reports the bug, with the
kernel configuration allyesconfig for x86_64. Due to the absence of the
requisite hardware, we are unable to conduct runtime testing of the patch.
Therefore, our verification is solely based on code logic analysis.

[1] https://sites.google.com/view/basscheck/

Fixes: 64d608db38ff ("tty: cumulate and document tty_struct::ctrl* members")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
 drivers/tty/n_tty.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f252d0b5a434..df54ab0c4d8c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2222,19 +2222,23 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 	add_wait_queue(&tty->read_wait, &wait);
 	while (nr) {
 		/* First test for status change. */
+		spin_lock_irq(&tty->link->ctrl.lock);
 		if (packet && tty->link->ctrl.pktstatus) {
 			u8 cs;
-			if (kb != kbuf)
+			if (kb != kbuf) {
+				spin_unlock_irq(&tty->link->ctrl.lock);
 				break;
-			spin_lock_irq(&tty->link->ctrl.lock);
+			}
 			cs = tty->link->ctrl.pktstatus;
 			tty->link->ctrl.pktstatus = 0;
 			spin_unlock_irq(&tty->link->ctrl.lock);
 			*kb++ = cs;
 			nr--;
 			break;
+		} else {
+			spin_unlock_irq(&tty->link->ctrl.lock);
 		}
-
+
 		if (!input_available_p(tty, 0)) {
 			up_read(&tty->termios_rwsem);
 			tty_buffer_flush_work(tty->port);
-- 
2.34.1


