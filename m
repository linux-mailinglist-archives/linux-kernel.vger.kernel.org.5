Return-Path: <linux-kernel+bounces-21973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EA982975B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4E528C9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDC53FE29;
	Wed, 10 Jan 2024 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYBshhb/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20C40BFA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e585ec8ebso2401905e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704882073; x=1705486873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwqnqS/wycxZAhr2uerf+qQVYpnKiVk2U9Lnh+3LXKA=;
        b=FYBshhb/YFgpGgyC0oFjH3SM7b/iaSx6vx50RqqOq6x0orsdHw54YLi1vwuMLWub6U
         oO3oP3A1hC7RPucRt7tTtFJxBPldQr8gAnUhy1RQYE/uouf/UpIK6w5o9VjzvOSecqSI
         gGA8cbBTZ/Il8dAE//cZSq7CDB/ws5/YZ7iQu5YQX9KVkd88Bo6Ul2puSJ7ZAWAKdpOx
         kbEnCGZp+7f0Y5uyQBOo1UoAjvW9XD/NvrATBim4X6zxd2EK/kcx1T0HNkYfco/FOtDX
         F1a9M8UX8a3/acHKtLgE/Dc2oxCKZ17OU3bSPyj8maRJHMZNT/TkzVTn28vDgiTKR0PO
         Rc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882073; x=1705486873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwqnqS/wycxZAhr2uerf+qQVYpnKiVk2U9Lnh+3LXKA=;
        b=EsBNBlbRaMYyaV9HY4OEyoJTtIhHGq3WdhrewN5I7UmOql5ufzwW2kbHtUuvXDDYA/
         okyeIvQjmEPfrC+dzL1CdBwLH3L+3J4xCRGNlFlGdqQsJY2qyWrteY7ZRznOEncsczZx
         XrVq/PLQ7KbVac+W8RD4KZnjwP5i6kLl9M+Y7nRpt+Mwata/z4EaH1JYOC5hIbHVnA4V
         TX9u8sHv+buxS+RCRjcyxqA2T//usX1OsRtUWwry6dogkID790Hw8b/TDf2BT9Mbd1ck
         pRDOuqJFt0FPnOtxoXh8RpXx+MnDqjEEMYjvk7fqTnCvZW5Y+58Gh83Kz6hi1NQgX+ea
         q2GQ==
X-Gm-Message-State: AOJu0YwzhVGGcm0Iyrc/DZF9c2y0Dm9MdkssWuvsVOYX/xEYB/ieMrQe
	QtWU2w527JG1BZq6eXHCiE97ylnKpzrh1w==
X-Google-Smtp-Source: AGHT+IGcQBbhMHK+EKOMon1hp4+KGJv3InwLXWLO1SrdmS31XEWMZkMTbvJjozVPLu3hLFnAqJN0FA==
X-Received: by 2002:a05:600c:519b:b0:40e:49b2:2c9e with SMTP id fa27-20020a05600c519b00b0040e49b22c9emr439607wmb.34.1704882073274;
        Wed, 10 Jan 2024 02:21:13 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm1625302wmq.29.2024.01.10.02.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:21:12 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 07/18] tty: serial: samsung: remove braces on single statement block
Date: Wed, 10 Jan 2024 10:20:51 +0000
Message-ID: <20240110102102.61587-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240110102102.61587-1-tudor.ambarus@linaro.org>
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Braces {} are not necessary for single statement blocks.
Remove braces on single statement block.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d5f9bec24b8e..11ae3a1dcdc3 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2062,9 +2062,8 @@ static void s3c24xx_serial_remove(struct platform_device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(&dev->dev);
 
-	if (port) {
+	if (port)
 		uart_remove_one_port(&s3c24xx_uart_drv, port);
-	}
 
 	uart_unregister_driver(&s3c24xx_uart_drv);
 }
-- 
2.43.0.472.g3155946c3a-goog


