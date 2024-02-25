Return-Path: <linux-kernel+bounces-80127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068B6862AF6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380371C20B41
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC114A9F;
	Sun, 25 Feb 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVJebiD7"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E91401C;
	Sun, 25 Feb 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874081; cv=none; b=GQ/FSUCnnh2vhMM7G12q+vXbjua5Z8QbxmkLwLpEGjER2NB9MFs1vcmTwharFMM4sHIh/XSymvAdl7KEXRxd5thKPrKOmWoZ4US0Z8jaGJgZls2m98tnwvBmbdR9VVSpueisj9LfoXpxkRVEYWqC5iqNtlsjBGbsQCgUqFEEbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874081; c=relaxed/simple;
	bh=vIKsCCNlA2ZnRDQ7xikBE41S9NfcNPFJ+Cbs46XztqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZENuaMqGzWov/Br7eMVyA4jwE8PHy5L2+4YgHuPUV0CzRhqks1Ir52lNCd2DKX9RwiDYzIBfNI2AQS81dPVwUnie/FHt2QRdQUnEJPj9w4/oX/vTFmWeF8TqhIiZqHOEsfjwj4JV/cV15qiXtZmmDc58bV6eGsD9541GcdGFfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVJebiD7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512f5484a37so1008275e87.3;
        Sun, 25 Feb 2024 07:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708874078; x=1709478878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cKFGsI4XaMR+5dCCv63udFhft6EyPcLc+uriJaHY5I=;
        b=XVJebiD7gImTK7SWDWL9v/+e/XbP5aRrhrAW8n3gkZvkCYklukgyeznp7iMVgBqnrX
         4k4O1zGikO2JpIr2JXJ6ncabFH7C0EEnj/QRpkFAA1i2NxdlE4sH+5eckssFeyeKaqNw
         mF8xfOf/Q89LCYPN/LQEtecDknfgQU0UMCflXUYjPAG1aPKdUKqdlb1isTbPyo02TBK9
         ZugY/gBfC6RcpIk1JinYFM8vwUwFRZ5+4zkBPIG9EfTSkFbd9XqpKjQZCj7Tg4XVuuFA
         hZbUbF0K78yYlXK6f918DxIHIdVIb2VAbkY+/rLRX9wcbgvWUimqDADx3jDfuHpeyTHn
         g7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708874078; x=1709478878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cKFGsI4XaMR+5dCCv63udFhft6EyPcLc+uriJaHY5I=;
        b=O32xYAjOFSLRVGHQxTCS/Yb8Zw9lS01uAjAl/8tPc90TB0bZUKh7uXI4L2BJ186Xt+
         /MF5xZDABrR3/4RgW+2hVw268PNyaPQwzooEvai0ipw1gFRbpChkl1A9QJD4XexdOdHl
         EkJ7z//gXqIMrY/hJGZXfm6CYr7kruOdpRCcXK6S0LXnVYq+HeB4U+IC9otbNd/r891t
         VAEOGQ1nKS9+bXi3mRTD4Up9yuIkkP8PKyV3NS692OmJi5PqP/4zB64mmFyyYAwwvvDl
         Rs4VYPRIc9abH/Qusw3QeSODjeOcrloDQB9gdG0/tAyviNAn9c5wLp7aqAVoRSH4ReIT
         H1tA==
X-Forwarded-Encrypted: i=1; AJvYcCW5QKAGK9gC5gVPyDsYZbRH0wrFDYtxbcoKIqmxr0hk8Px+ThI1p/wybLwrT0XJlm6YpmB1PrYwwz3LY0YEnKcCQIqc9co4VsXHovYk
X-Gm-Message-State: AOJu0YwYpadJQO7V6o3hhp5tMEq8xAUzS8MXeQsvEiz8pIcE9WqPS5x8
	5xWJeElxrxk2RqOeQB43AKST0ivi3oLjn/8q8O8abTtLVIjiarwfoY2RbJw0
X-Google-Smtp-Source: AGHT+IEWwm4ZP1OImkLJzbEQbCbalLsyYkWvn5afQwHorbDRp0hd+b4vl84B0EAVRDR5AzBM2YRz7A==
X-Received: by 2002:a05:6512:3052:b0:512:fd90:b4dc with SMTP id b18-20020a056512305200b00512fd90b4dcmr503220lfb.33.1708874077559;
        Sun, 25 Feb 2024 07:14:37 -0800 (PST)
Received: from localhost (dslb-002-205-020-122.002.205.pools.vodafone-ip.de. [2.205.20.122])
        by smtp.gmail.com with ESMTPSA id ga13-20020a170906b84d00b00a3d5efc65e0sm1556313ejb.91.2024.02.25.07.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:14:36 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 2/2] serial: bcm63xx-uart: fix tx after conversion to uart_port_tx_limited()
Date: Sun, 25 Feb 2024 16:14:26 +0100
Message-Id: <20240225151426.1342285-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225151426.1342285-1-jonas.gorski@gmail.com>
References: <20240225151426.1342285-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bcm63xx-uart was converted to uart_port_tx_limited(), it implicitly
added a call to stop_tx(). This causes garbage to be put out on the
serial console. To fix this, pass UART_TX_NOSTOP in flags, and manually
call stop_tx() ourselves analogue to how a similar issue was fixed in
commit 7be50f2e8f20 ("serial: mxs-auart: fix tx").

Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index a3cefa153456..259fe5895032 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -309,8 +309,8 @@ static void bcm_uart_do_tx(struct uart_port *port)
 
 	val = bcm_uart_readl(port, UART_MCTL_REG);
 	val = (val & UART_MCTL_TXFIFOFILL_MASK) >> UART_MCTL_TXFIFOFILL_SHIFT;
-
-	pending = uart_port_tx_limited(port, ch, port->fifosize - val,
+	pending = uart_port_tx_limited_flags(port, ch, UART_TX_NOSTOP,
+		port->fifosize - val,
 		true,
 		bcm_uart_writel(port, ch, UART_FIFO_REG),
 		({}));
@@ -321,6 +321,9 @@ static void bcm_uart_do_tx(struct uart_port *port)
 	val = bcm_uart_readl(port, UART_IR_REG);
 	val &= ~UART_TX_INT_MASK;
 	bcm_uart_writel(port, val, UART_IR_REG);
+
+	if (uart_tx_stopped(port))
+		bcm_uart_stop_tx(port);
 }
 
 /*
-- 
2.34.1


