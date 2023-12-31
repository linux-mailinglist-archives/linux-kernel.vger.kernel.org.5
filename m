Return-Path: <linux-kernel+bounces-13780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B993820C79
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 19:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51BF1F21B23
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290F59471;
	Sun, 31 Dec 2023 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arNfgIfm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5B944B
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e8d2c6903dso132192257b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704047398; x=1704652198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uMZVz/UW8puWfXdgiZf80krGZeVv7b49r1xaHw6OLh8=;
        b=arNfgIfm9fkWd0ejpTGVDw0Kx0hy9DrnPCRk/+7MGupRfHCBdUxLMwCGqy7NPeK+As
         rFhiswAoF9Urs2tOFa2TzNGVIaDjl6fwm/FMg8T4Up4iIqQQZhmKzXvxKXWLe8OAR4fV
         lCYhwm4HTcJoD1ZHoM/ZKc+IEAyzoQ/jH5BVHe4c705HqUG4A8lVDRnk6wGOnilAhtB8
         zEMwBUaoRUwf8vAXTizvkfNGfPbWJg8zmxzCc6gi+cWrQClHGuN15XOS+7+xryOxMJu/
         GdDEY70RIZdoHuE4pjDQRwlCegDf+1pP6KMVyBM2t/Bfyc5Uyepu0l1m3P3PHlWgGF5q
         Tftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704047398; x=1704652198;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uMZVz/UW8puWfXdgiZf80krGZeVv7b49r1xaHw6OLh8=;
        b=u5ba3SYIxvCcbE/pSlRLXKiFKpLE2hdvKzz+PJ8r2GuEoVv0LUwz6X950kVH3sNJA7
         lr5a/Z76soXDxFf5f29po8EspAQGbHUoRzi2KWTt7XKOiDs8RkLJ5ANVd1rF4VKTMzr+
         XrVOmEStgs/u6OXdhcp3CXXQ/xLmyG7d7pRZRuJNelHIaMyUbvI9H7vV6uYv1oQm7bue
         BKanl2f9yX6I94XOimZpyvh0Zi3XyLPOvCQ00s01gSrnL8FEHO3AZrPnoVc9qaAIhWDZ
         l0jXlC+AHRux87gwTMl8d+aagZJB0g157VEAC0JWh4j+VDynl2WMVzKpSEIRL9akhH+f
         s1qA==
X-Gm-Message-State: AOJu0YyRMxU3QlE3GrsaqYby81oGTVIsj+JLgaHzdgew5aDOuK32Qoky
	QP068Bb3HNjFhl6cDBJUrcAyc1PtY/qNKhRBinZRxoywR2Y=
X-Google-Smtp-Source: AGHT+IEnE32X76P7Izi1WqjwmXwc8RSLGP5pb3wwKbUQr/o9QMgvchl1KpiYQMWEwjUlPqvx/isabCmpM+96eTNAJ8GA
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:3509:b0:5e8:bea4:4d37 with
 SMTP id fq9-20020a05690c350900b005e8bea44d37mr7440280ywb.7.1704047398192;
 Sun, 31 Dec 2023 10:29:58 -0800 (PST)
Date: Sun, 31 Dec 2023 23:59:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231231182951.877805-1-vamshigajjela@google.com>
Subject: [PATCH] serial: 8250_dw: Do not bailout on UCV read returning zero
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	ilpo.jarvinen@linux.intel.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	manugautam@google.com, Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

Designware UART has optional feature FIFO_MODE to implement FIFO.
Encoding FIFO capabilities through Component Parameter Register CPR is
optional and it can be enabled using parameter UART_ADD_ENCODED_PARAMS.

Driver can exercise fifo capabilities by decoding CPR if implemented
or from cpr_val provided from the dw8250_platform_data otherwise.

dw8250_setup_port() checks for CPR or cpr_val to determine FIFO size
only when Component Version (UCV) is non-zero. Bailing out early on UCV
read returning zero will leave fifosize as zero and !UART_CAP_FIFO,
hence prevent early return and continue to process CPR or cpr_val for
the driver to utilize FIFO.

Non-zero UCV implies ADDITIONAL_FEATURES=1, preventing early return
will not be an overhead here.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 136ad093c5b6..3e33ddf7bc80 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -271,16 +271,10 @@ void dw8250_setup_port(struct uart_port *p)
 		p->set_divisor = dw8250_set_divisor;
 	}
 
-	/*
-	 * If the Component Version Register returns zero, we know that
-	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
-	 */
 	reg = dw8250_readl_ext(p, DW_UART_UCV);
-	if (!reg)
-		return;
-
-	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
-		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
+	if (reg)
+		dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
+			(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
 	reg = dw8250_readl_ext(p, DW_UART_CPR);
 	if (!reg) {
-- 
2.43.0.472.g3155946c3a-goog


