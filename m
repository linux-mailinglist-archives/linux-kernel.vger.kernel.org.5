Return-Path: <linux-kernel+bounces-60548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A0850692
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CE81F22902
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1664F5FEF7;
	Sat, 10 Feb 2024 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsqB+9Oi"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2505C022;
	Sat, 10 Feb 2024 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707601964; cv=none; b=bXjcQvBYYbFQzYHHR+SUCFFWxarzfQWeo+/oOgydy9sOp04TiyR8hkdonYTqxvzgv1bzYEl0izkw1fLF5sOHNszCN6FNlQkJL+MUkWIdVhlvxFV0Ja3FwNzVB8UcdeJhBetl4fzU6CbHGN+9K/j+QcwwQU9/6iGZIhz1SqK+NU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707601964; c=relaxed/simple;
	bh=In6AjzUhpjR1wsN2+PVjNyG0mJE7eCf5Z00CO0JRxII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wweh74nH8EGF6Yrh++gR1xWz7jKqDsjjJOz0qKwCz23TR7pgpalkQFbOFx0hFo5FPXKa/EGCQRr/FQDJFhbrktjjb+3IQpCBN6s/c0mwfN/GaeGnyx/lawTEShzF0vOO/i2RsvOm2DAmk7BK2/ylCNmhRxuDkGfIs9+F6Msv1U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsqB+9Oi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso3307012e87.0;
        Sat, 10 Feb 2024 13:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707601961; x=1708206761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bVIdnxLoNAiGQ5a+gFJnwc3L5NJOVMhNajT8rAnKq8=;
        b=QsqB+9Oinb533P77nIIzRpXFmjCEc6hlFgal+J6xVCCfUse5W1NOg8dIJpMvVM8zit
         VKBuF9LtRB4LfG2X4RZnVTJNoPgYeL8tjcaK93Pr+xfaZiG/GKTP0KLRJamY3bW7syfy
         E102SApxg7+h7q9HA4RZzk/qR18HiMrhb2rg7J6tT7NXhGMa1NKUND9AeTxeEHIwWsma
         jnCh5Ez24ts6E8ivsGgB1pWc0YF9dGRJ8qmamQGRU4J6AdNWlf4LrIiPrlALDrX8RSWO
         /BGgI57NMFencl9slV/Q9tNVIfTC/tymrCE8+LlLGDHfOGnaHjfY0dsTTAl6UAjuoMUo
         x33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707601961; x=1708206761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bVIdnxLoNAiGQ5a+gFJnwc3L5NJOVMhNajT8rAnKq8=;
        b=lZzAQMB6MRtC5E4vW/WCEMzuiMgqRxBBS2wwsGNaewwZ4vTicg72gQ9qzNOOyBGd4p
         jOxKSRhipw7mTHLu+wrjOWPghM0EDSBnj6KgfGkpmGVbPTraf1+d7UeT5VF6Sv2jnZvs
         2NIliQlUtU7xC0Fd2L7/wH+b9sQPDQjK8Ir6yIV+a2+/IBc3WfEHoFnNCUTVf3bWx1gT
         7r7ncz0TnfOuDva6GEv2WvWhXMO27hskXbBzqsgzzkdEwYzQvP3kJsJeZpiQu9t8EHhj
         WZOfFhGmQ6wOXChAsWqBuXmMQv+9lJ33B2/xBDHK0AHTrlNC2Yvpf5v1NtIYiurAt1XB
         gaKA==
X-Gm-Message-State: AOJu0Yz88hFol1H76MBSPbEeuWjoxurcZwOyWwOWvBiMM3Pq7RPVid1t
	iYmMGfVMNKAiZBHjjt/6diUAaXSiR0p0x+hKl+7EbIXgW6rVDfUw
X-Google-Smtp-Source: AGHT+IEn1jOg+iTOpFu9b/2Hjj7IPRdaZQgXXTN1f2zVoQ83djjyt75IsgvLhQUcdHCGZQwPHWrZsw==
X-Received: by 2002:a05:6512:3e28:b0:511:737d:661a with SMTP id i40-20020a0565123e2800b00511737d661amr1911687lfv.28.1707601960449;
        Sat, 10 Feb 2024 13:52:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVy15nubP7lErYdPg9hq3DaopTIunsgke2MGdUAKi4yNlfd/emmlZSYH/N99ZLcsLUqZioozu50SjpstyYCfvQy1p08FE9CRNR1SE3RmD/WDbFyzrst9Hci615G2EMsqvtVeGRsPAlRoT5RpInYdmA+FCx+7/69UdV2Xu94EOG8iBVyStLt57cFs/wq2k2jE98FnesnwWCSzIaLDCh/7S6asUkQ9lbm7mHjptJugf1fvmGpnkEo+4aChq/13Mz7eHvQb1qgP7K2SHCZ2HFDI/mMt5iGfWdJ9XNEMT6G27q+dtpaZca8AYl8VLSAzPQYlIhrQ6+IqUx6kbIVotgh3nR8kgCowTkJ/Gj7RjQy0gBY+4e0EsmgiQ==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:52:40 -0800 (PST)
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
Subject: [PATCH v1 01/19] hid-ft260: fix incompatible-pointer-types error
Date: Sat, 10 Feb 2024 23:51:29 +0200
Message-Id: <20240210215147.77629-2-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixed compilation error introduced by "hid-ft260: Add serial driver" patch
https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-quast.de/

  You are using:           gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
  CC [M]  /home/michael/sw/hid-ft260/hid-ft260.o
/home/michael/sw/hid-ft260/hid-ft260.c:1426:35: error: initialization of ‘int (*)(struct tty_struct *,
const unsigned char *, int)’ from incompatible pointer type ‘ssize_t (*)(struct tty_struct *,
const unsigned char *, size_t)’ {aka ‘long int (*)(struct tty_struct *, const unsigned char *,
long unsigned int)’} [-Werror=incompatible-pointer-types]
 1426 |         .write                  = ft260_uart_write,
      |                                   ^~~~~~~~~~~~~~~~
/home/michael/sw/hid-ft260/hid-ft260.c:1426:35: note: (near initialization for ‘ft260_uart_ops.write’)
cc1: some warnings being treated as errors
make[3]: *** [scripts/Makefile.build:251: /home/michael/sw/hid-ft260/hid-ft260.o] Error 1
make[2]: *** [/usr/src/linux-headers-6.5.0-14-generic/Makefile:2037: /home/michael/sw/hid-ft260] Error 2
make[1]: *** [Makefile:234: __sub-make] Error 2

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index cc2cce3698e3..7273d401337a 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1220,8 +1220,8 @@ static int ft260_uart_receive_chars(struct ft260_device *port,
 	return ret;
 }
 
-static ssize_t ft260_uart_write(struct tty_struct *tty, const unsigned char *buf,
-			     size_t count)
+static int ft260_uart_write(struct tty_struct *tty, const unsigned char *buf,
+			    int count)
 {
 	struct ft260_device *port = tty->driver_data;
 	struct hid_device *hdev = port->hdev;
-- 
2.40.1


