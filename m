Return-Path: <linux-kernel+bounces-56297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE9284C86C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3482E28348C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1398B25613;
	Wed,  7 Feb 2024 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkrn/6Ah"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4D2560C;
	Wed,  7 Feb 2024 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301118; cv=none; b=WYQoH/zY2swSQcgyYIpaMHcUW8wqYspRHjjb8nL8fe8AH2Tv3FPHa4LLPJniEyxRsPWMpPAPfBuiYys22IY4IfX319RAoVcUv51it1BRr6Mf8FmS+JpPBS5XnftDyhJ8UkXkxksgwwsoMJsW/uAzTKlnpwFMFSHZoeBmApaB6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301118; c=relaxed/simple;
	bh=rYCzRom9fn/h+G7iLC9GyFKbGOK0LFNpk4LSplc7INs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pEoKX4FxGIkA306nuiPrRwL0/ZEp2EdOfkwlHury6Uw9mTEi+p3WH8nsV/MakOhsYnPuYwcCtDGtOqwKzzRAQSzvXUpw+SJDWY0B/zbVMA6Fq1gyFQ0LVdhSsOCpS82AoJyTW2+kg4JEclo+3sbspI4wSH0F1pOmeKmnfboqKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkrn/6Ah; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4101d096c92so595725e9.1;
        Wed, 07 Feb 2024 02:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707301115; x=1707905915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DuqJU1WwYzrM0YOnFnIci0yeB3MaXmMpyMCTJ0LMXCk=;
        b=kkrn/6AhsAMps0totkND93sr9qejKCPAIV8MEyHqw6oY82MPgHwGR4hngAT2tklYWr
         Qf94qAR7c7913GSpzpR7oNgIoHNwUiEIII2I+p5KPz8X2ttpZJ50TrpHTvUXrtJQmQHR
         U2hjvRs7WORQYrp3Q9IOhqsb1RO3BTf1SOA1yFeP9B8k3ONgWCBCHzIGvuLpuea+F57O
         QuPEpwp1C/YybPUW/YCwv67foeolJpP0qacN0W6PaBPou1zuA+euBA1stDZaxyAw3CZf
         o/hFwIKx2BzYNQA1zL9ylAM/xj2ZlRvluIpgVLR7yupcK28pQQ7GX2pS7XqakmCnUnYw
         i/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301115; x=1707905915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuqJU1WwYzrM0YOnFnIci0yeB3MaXmMpyMCTJ0LMXCk=;
        b=TXttT2VswnQuo18L6BPmFYft19l0yyLDX7tZa/Sm/FP7TQXH4X5Z3vLT7IdrZJ0zrU
         O4kPnxWXW6Kx1HH6Zj4YlKQ0eiJSPJoGauct23TLmBY8G05ZyAe2tSUciRxXW23yXzFl
         7HcZdHKsrxqtEX1o7ftCgTPefw/Vce9S3unvW6tfBWYKvhwND1pq7GTGTQnyf3LAwWKd
         5MXRlyVnL8SLHT6nbIFij322jT7MKgELJkTuYvk3HoO7ql17Juu8O3C/1khRNnuy+QyB
         mUYVOMBIzZvcWqQjAeRWkIhd6j57QEiKyRpo1J2OR9YJe6notJmChIJdlU/IpMKRZwYh
         pUCg==
X-Gm-Message-State: AOJu0YwmWrkekG0eoxooX4OT6n5ezSePL7yIJBVm4KfnqOijABDzerjE
	2DnWFspQ8yYUeBq1OEQ1onigzBtcru3xEcAW9tsMcMdoObCTRkPxGGKkWFDZzhY=
X-Google-Smtp-Source: AGHT+IHe3M6vD+bjtr4ODMUp4ueyRrD+kN8Hr9V8XPA+ISSpcZuJVCdXEXadlMx21kpnFRwhEYHHMQ==
X-Received: by 2002:a05:600c:468f:b0:40f:bad2:72ed with SMTP id p15-20020a05600c468f00b0040fbad272edmr3953733wmo.4.1707301114581;
        Wed, 07 Feb 2024 02:18:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzqfBJGahtWOsT0vua+jRnCDjn6edUptEoU7HQaQlhjo0xttUqNtZ3DUSyJ1EkyhGYdj43ZF2CtLVyUA3yXofoqhTzCIpY8pFhq/gQnD/Y3Er5RM0ZS+Ra5hZ7+5lqTTSZyQd45c5+F/lo2tciAIv/TdPAkq2ejbbh1l7OK6bic2NGVULUMeuKBRrRunY5t9IzKuMsqSjBvjGC8w==
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b0040efbdd2376sm1559430wmo.41.2024.02.07.02.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:18:34 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] USB: serial: oti6858: Remove redundant assignment to variable divisor
Date: Wed,  7 Feb 2024 10:18:33 +0000
Message-Id: <20240207101833.2440799-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable divisor is being assigned a value that is not being
read afterward, it is being re-assigned later in both paths of an if
statement.  The assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/usb/serial/oti6858.c:412:2: warning: Value stored to 'divisor'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/serial/oti6858.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/oti6858.c b/drivers/usb/serial/oti6858.c
index 6365cfe5402c..fa07f6ff9ecc 100644
--- a/drivers/usb/serial/oti6858.c
+++ b/drivers/usb/serial/oti6858.c
@@ -409,7 +409,6 @@ static void oti6858_set_termios(struct tty_struct *tty,
 	cflag = tty->termios.c_cflag;
 
 	spin_lock_irqsave(&priv->lock, flags);
-	divisor = priv->pending_setup.divisor;
 	frame_fmt = priv->pending_setup.frame_fmt;
 	control = priv->pending_setup.control;
 	spin_unlock_irqrestore(&priv->lock, flags);
-- 
2.39.2


