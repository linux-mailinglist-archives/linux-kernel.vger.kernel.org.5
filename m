Return-Path: <linux-kernel+bounces-121882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A1A88EEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BCA29C4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3730E152524;
	Wed, 27 Mar 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu0HaW/Y"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83F152501
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566620; cv=none; b=t9azNi6clozTiZ8Hg2aWMZPvT0+0RBfOmd3u/aqxgaRU9lQIKnafy9CR5FiWWENp/b6QWu+SFVTJLAB/Rseol+ihPI3Z1v4Najwxk2YB1B2Qh055UdBm5a/CTmxm4O2Zu7WMhvCVz7ZHHWR5WfLW2sPtZJJzqNn/cc6o1PKkzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566620; c=relaxed/simple;
	bh=MTdEjm1D0/qfOUg6cYn6umc0lnlr1h8xueLvXHiRnPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IX5S6oqkz+ia7+tunasPKfaRqgBsOc2WHwBfGIa1u1n9Yrf2ok9CpSvZcvj/dr5i72OwlzKHbKZ0QAZtUhfo9iz0RzwtH7SZnAzg1QOeC/jaz7t+5iLL7Sdtfo6Z0OGpGXycD9vR4rgWmZqkj3V36Hat/BUZMITkzXt4MhzGMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu0HaW/Y; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a3ca01301so6861785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566618; x=1712171418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/twuRh0ETjmablTSqJuv3fOjHccwwgmOmFpCl7pqqQ=;
        b=Hu0HaW/YEAcjKf1tfTIZ3AcrjLa8qIjIcVNLfwaueuhidr4P8R8x+NDdF24OHUPlbC
         0wFrYzmXAl/diqMeqskshkjG/lNJqTM01RobvD0ucuboCCIco50+glgrb+7MvpmdkTJQ
         rP/wxFNYUgx7/vWFXTCympTxBK9RJc/WOLjK1SlCGOSx2Li+0uEGB3B3BzQa7V3qZWOm
         b4KBBh/Bz8ZP4Epxlw62l5fzpa0GBkxldin4SOkibz+tQNYrKbr0A2WLK8VO9YyfRwp4
         GJe/v94OnfUDcmHDkI7S61iWLfeqkSoJ9X/UEBsEXZfQMuVeXQHPV8a3gUhkC67BCJv7
         sGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566618; x=1712171418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/twuRh0ETjmablTSqJuv3fOjHccwwgmOmFpCl7pqqQ=;
        b=Wtl7bs1yfM0K+nGBpwxywknn+7PujJu7wugao2MZRiFPj6mepa3A+taD2peMxfuvyP
         LVmpPhZkq58OdQTXviCo7V08/iBj7Y1PF5TqBjqiKkjNtKV3PeqxsUnd7KaA51sBJmAQ
         avPEC1YPUliy2tiPXX+dZosReRLYhca2rXdxOJBeOep+25imgspCZGYoM5TPFN6xjs8E
         SnfnczGfX5C/W6SxkyuP2c+RDKjOwQ2yplweXXiuoABiwtYXp2uuA7RxEliz6Np0ZUEx
         bQEgiBiv/Gn+3hKPIHVvo/d+EnrBBd3mOI5UzC3cDuGofXsHGLrxYFWkpcRLtgeGvNqc
         nVlw==
X-Forwarded-Encrypted: i=1; AJvYcCXymdh4XS3WIS+OHWGx/C/0hzIYa74EBwSgSgiPFzfFGFW66ie1U29EWN0GhsIVmoIrsJi9w2TQ4ZNOfuMImHl0v7LdQgtzVlM9ROIV
X-Gm-Message-State: AOJu0YxYHA0HmMCr4qP8WzXqQ4sqDvGokUeDJ1JtBekAuS3D5f684bi8
	DWUpvPgv9vsPUmLa4d7Bf8fRLbXwyZpCzzHgOQqHMA8RWKkPuP+x
X-Google-Smtp-Source: AGHT+IE7JAxxL25TeM7aqNrXRdLtjlqymQo3Q6QG0/xIfJgEB8sxYSZxlmv0Xnp5rIHt2GSzSS0xnA==
X-Received: by 2002:a05:6214:4c09:b0:696:b2a9:a2ae with SMTP id qh9-20020a0562144c0900b00696b2a9a2aemr475829qvb.6.1711566617988;
        Wed, 27 Mar 2024 12:10:17 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:f38a:32d3:e6f6:959])
        by smtp.gmail.com with ESMTPSA id 10-20020a05621420ea00b00696a1f5dd18sm1784789qvk.116.2024.03.27.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:10:17 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] staging: pi433: Make use of spi mode macro instead of magic number.
Date: Wed, 27 Mar 2024 21:10:04 +0200
Message-Id: <20240327191004.619748-4-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327191004.619748-1-ikobh7@gmail.com>
References: <20240327191004.619748-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use SPI_MODE_0 to setup spi mode.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
v2->v3:
        Restore Reviewed-by tag.
 
 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index ec9f07a4f769..8c513ac62156 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1164,7 +1164,7 @@ static int pi433_probe(struct spi_device *spi)
 	struct dentry		*entry;
 
 	/* setup spi parameters */
-	spi->mode = 0x00;
+	spi->mode = SPI_MODE_0;
 	spi->bits_per_word = 8;
 	/*
 	 * spi->max_speed_hz = 10000000;
-- 
2.34.1


