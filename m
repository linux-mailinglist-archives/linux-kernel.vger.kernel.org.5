Return-Path: <linux-kernel+bounces-140123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109A8A0BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7159E1C21E15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0785B142E61;
	Thu, 11 Apr 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3b6RpHx"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0513CAA2;
	Thu, 11 Apr 2024 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825742; cv=none; b=FnS1wPB1xw2W6mH9Ym2qtd53W50XwayY+l0lO+YdM+4QZflP1Md8giMAqRxBSjuGudk3wqRXJRgKk2zfoKyNm8/YfElx2+149Y7YckmjFWQ3y23FSCMlJp4Ro4ScuM9ycukDozpSW8AlR5QuuXgQxpAuZIDZo3iVq69THSa4BjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825742; c=relaxed/simple;
	bh=ldw+xs/dWBNbaZ8UjYEKjjEZwNdjPX+4HdpQAyz3ojY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Od5FbntGUlLNy1W41NkK0daHxfEZBPbpNmEqAaN8iVJ+yr+zMIuMQL5DqpIsDJXllvxJkxB8+wyu1E1/jPLfPVUQ8cYsEamxtgJWA7yR6mVWDFDjWjFzN4q/aIRvKPK/fT9RhCYUQlrhq3+HQ/0kjxCUYrcmT9+urPDzJFWhWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3b6RpHx; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so103104211fa.0;
        Thu, 11 Apr 2024 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712825739; x=1713430539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oezm+XeiDrrLKggyC4riCoaNw/6HsqhGMN90b4ZxeZ0=;
        b=C3b6RpHx1Ufo9i+9QnnP05mAinkuaDqmBqDTA+cpwv8ApuorfneVDRahIZvKV2zRve
         fQHmqOFwEwzf5hOEglmlJUV1z40iYd5Y8M5ATHkEnasOoQW2A/wcGZ72+F8ZWNoXSqrL
         N81sUp4GjhrQwyMeYF5rq5ab5xy8VvabiM90OmuicoW7vyhyNj3EH9YJBe/rRV9mXZE8
         sCAOZS0WMiFSpcHfjD0Q5mt2Qw6jqLbfkFsx5AjOyEOf9CxCj7PXrKCvnMixDrWAm0lp
         3nEekBojDQ+Cs2n9Zs6KLQ3InzpDa/xf5EHh/KkwKVPiEra626P7uIek8pXHqyR7uO0x
         fOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712825739; x=1713430539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oezm+XeiDrrLKggyC4riCoaNw/6HsqhGMN90b4ZxeZ0=;
        b=ci4ELd7tw83ZIGKY9Rn/OO2Tf2aigeagCLmcZL48hjVsQ+6GwSgH2xmL3y+JXPh2yT
         EaDDH/ymswmjrNM1yG/PeZ+qcK9iF1THL1JRQr4kcwyg1lO44RMCpA1yvCmk3dYjeg9V
         8hSXls9uOnXP+x/XLnNncFitBfZbCG3pF0eUapxjl4FjUrfYnPIee0nHim1DLtlFh0f8
         E2lsDk0qAMDJvGSSvCb40/dynL5XNW+2EO3REXvKkuL71g06XOcn1WlhcvkVuxu5aw/w
         rcH80MtLFkM2zD5TqbUSjZuvSZFWeK+1Sl7sJDqoGUvVaR0nJi5uB5O8YlKtpx3DSzAf
         qHwA==
X-Forwarded-Encrypted: i=1; AJvYcCVDGTb6d8w5nA9NfX44Sj6WDpQbdQXOBEEsrAzzoBZIYdBa6EiGxlJtta6gtN2Qa8h4GSzrjJUhns2VwmfPQTx6dMiwiuTOSlSGzpSotyI65E4XhMdJ43fZqV078/aUcL3sscJqiqUuQolG
X-Gm-Message-State: AOJu0Yz4IFuAxfEt/cZ+EEekMR/JofTkfM5TRjW00Dmh+zLwgnwr4jwi
	AgcRtJ7w//52pcQvA7E8j0KY4KAGQcYKsfaoQETknURxZny5aaMMuHg0sTIy
X-Google-Smtp-Source: AGHT+IHvRntyLgw9Jk8Ie6LLIReooOxA+Z3S96pjuTbtq5OLGcQZgV/DBtYrLNHVNSBqV9vTs4WRTg==
X-Received: by 2002:a05:651c:1054:b0:2d9:ed7c:7882 with SMTP id x20-20020a05651c105400b002d9ed7c7882mr152415ljm.26.1712825738542;
        Thu, 11 Apr 2024 01:55:38 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c4e9300b00417d624cffbsm1458253wmq.6.2024.04.11.01.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 01:55:38 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] serial: omap: remove redundant assignment to variable tmout
Date: Thu, 11 Apr 2024 09:55:37 +0100
Message-Id: <20240411085537.306020-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable tmout is being assigned a value that is never read, it is
being re-assinged in the following for-loop statement. The assignment
is redundant and can be removed.

Cleans up clang scan warning:
drivers/tty/serial/omap-serial.c:1096:3: warning: Value stored to 'tmout'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tty/serial/omap-serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 9be1c871cf11..d7e172eeaab1 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1093,7 +1093,6 @@ static void __maybe_unused wait_for_xmitr(struct uart_omap_port *up)
 
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
-		tmout = 1000000;
 		for (tmout = 1000000; tmout; tmout--) {
 			unsigned int msr = serial_in(up, UART_MSR);
 
-- 
2.39.2


