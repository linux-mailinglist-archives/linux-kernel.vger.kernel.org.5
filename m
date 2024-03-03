Return-Path: <linux-kernel+bounces-89935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F8C86F777
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65628281620
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B83F7AE56;
	Sun,  3 Mar 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+cdH9y/"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC017BAE6;
	Sun,  3 Mar 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505309; cv=none; b=P5wDC1YECZ1oNGuwvF+HrBmUgP7/uGICY1E2ua9dPCEuHn1umgoAwM9Xx2Lo9uhKS5v6fl2sNk0CNQWj1JDxNgMLMJOw7Lgw5VQZ6jJ5ujR96RXPMbKNev38A7PT5WNEENFEB3fvVOpFEXyA0UVcCsI4WwsOJisAWRvIIWJGH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505309; c=relaxed/simple;
	bh=+uTL/LbOPyfNXQRIPhdSYdU7wF14JkHFEOUHQzNgiFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qr0btRph1gzvhcIBU9K+1D7RVlfCwryQa9/tXliMYbcL5YlrnDQwPrS9vvCIVn1HdCLKMx23ugSrYi3eY+6suTkI2MPJIsLvK7UzghErz1q8xJwmADB3RrN/j6t8kAx5+HJkDKRZ6SUzEVdTIY2bDB7AVc8E8pBZIySjcByuHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+cdH9y/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so4543195e87.0;
        Sun, 03 Mar 2024 14:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709505305; x=1710110105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwrxwMBHKXGt91HOfjt4Q+TK1KpcsaOeqgsWIhDoN/A=;
        b=U+cdH9y/pwsTERn/ATVm0TqxB0XmBlvXxccMLsd2ojjx63COgOzoWpzw4dooyOpnYG
         waofyuPeJbxkN+uoX6VlOMZN4ymxJSna02O8J+3/OwYCTDVjJJ7zku6omgE3eUROOGKk
         NY3Mb3rY3mFsk1iFjxkzF0BOer990n3vdzV8AaG6eP/mBhHtMoJ641zYvCHjCXQbRrhD
         YhCc8D8gwkWdL9pnkDJwzJZils6vLB4zpkEncD38uH32IkMpk/e8fQYy0JsvdzcTpPwR
         MvEezwj/uu3YLf8V7e8EXNA9YcOe7Z3+3PfWCy8ifa14PHETADjB7zK4+b73WcEpdos/
         5nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709505305; x=1710110105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwrxwMBHKXGt91HOfjt4Q+TK1KpcsaOeqgsWIhDoN/A=;
        b=mLrVZXe6AdhmxPFxDSZOeMlEPoEhfqbcU6wUD0otkcLbF4+45d0yIaegCilERXwOrt
         zb6ghAdvdBmgsIkGEutnmRPw9JpVGCPFnYByoIgUTzuPGuMhqpKCoZvHaNxlwLW/s5lT
         NlL+s4AuFYb1LsCoVaq3Meu/S3FDokuz3kxrw3l/XPahC7OvSFnjAJ9RyMMvXaHbaEG8
         vnTl49yhpCXychbuN80Dzi/HiTfJdn9yrIivXVNF0NeeRGmKFSShQ2PorrGmTF3U41p5
         jVytZPndskOlElaS0Cq7Xvx9jvY79GasQw/alJmF9hACaG8Gy1okKTX/rgderyRRZDpR
         BsFA==
X-Forwarded-Encrypted: i=1; AJvYcCVs/xmMmjr0El4jSHi5oUnSO2fYSWAZ5CF/93mnC5MA5GMsPYmZO1o1/NQ7A+1oiWc/U+V+MKcRhpp6CRsrYj/Dh2DtTjzg/83tiVJqfQmhbNO1cI6nEoQ+8xdtsHEv4IPbesd7v8Km
X-Gm-Message-State: AOJu0YyCEmwwhZjvu1M0GUgFYTEu/lF3IqtnbE00ZoFyYFgH57m7AzLH
	x7ANXnhsX270X8iZjkkIL88mgHuzPw00R7Qo3V+ZsQvggzvgJbZ7BFtC3O+oloRZVw==
X-Google-Smtp-Source: AGHT+IGaO5ACvlXUfMGCRGS+B4/MIKQWnaOwtzuv+k3Szi1muf9X7VTGMTuiNgYUa9K+5Q5+zH193g==
X-Received: by 2002:ac2:5b85:0:b0:512:bed5:3d87 with SMTP id o5-20020ac25b85000000b00512bed53d87mr4650358lfn.23.1709505305399;
        Sun, 03 Mar 2024 14:35:05 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b3d8-5b4b-5188-4373.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3d8:5b4b:5188:4373])
        by smtp.gmail.com with ESMTPSA id v23-20020a170906565700b00a455ff77e7bsm82204ejr.88.2024.03.03.14.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 14:35:05 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 03 Mar 2024 23:34:42 +0100
Subject: [PATCH 4/4] iio: imu: st_lsm6dsx: drop casting to void in
 dev_set_drvdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-void_in_dev_set_drvdata-v1-4-ae39027d740b@gmail.com>
References: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
In-Reply-To: <20240303-void_in_dev_set_drvdata-v1-0-ae39027d740b@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709505298; l=886;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=+uTL/LbOPyfNXQRIPhdSYdU7wF14JkHFEOUHQzNgiFU=;
 b=X7Yt/mnEDq6mQ3tlL2qC7oXey3xLGYsPQNc1pRKacu9QuHEYQ6sqINEtiNFIMFB2LKmi6EBsy
 mItfn3z5YzIAHIGvODxEP77CuhRZaD3yisx6ToLnfCBmiZhg7GRva1B
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The C standard specifies that there is no need to cast from a pointer to
void [1]. Therefore, it can be safely dropped.

[1] C Standard Committee: https://c0x.shape-of-code.com/6.3.2.3.html

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b6e6b1df8a61..5bd1295c05ff 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2705,7 +2705,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 	if (!hw)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, (void *)hw);
+	dev_set_drvdata(dev, hw);
 
 	mutex_init(&hw->fifo_lock);
 	mutex_init(&hw->conf_lock);

-- 
2.40.1


