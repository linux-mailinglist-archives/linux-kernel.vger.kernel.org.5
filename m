Return-Path: <linux-kernel+bounces-64889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF364854458
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5151528D971
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801979C1;
	Wed, 14 Feb 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Zeo4ca99"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F09BE49
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900774; cv=none; b=pE6ob/2BaTB+TAiCoQpIyCBVEaNf2VjHOz4fgoltYmC3haKcZ7iOZUkc2Vzasu6Cm0yhsYA769DftsPJXrN2RFVCImjq9jk9tLukAQ3OP8+EWUSbBeCFH6vVNt41svlzMhmqSaFgxtCRnDt9MymO/eRYSKZ7I5fG8RwPG6MA0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900774; c=relaxed/simple;
	bh=hQ9upSJtJJopYunhhTAKlKaEeg0GayiBtpkQagMSQJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bQ5Ag6qpjf/JMu/kvSVhRPm0M/XspDTyfYqt/elC2nISL6vqdYvJ6J2gH8XJyu+ZkeVDcBs8Af3S2Ylo29J/d+VoaUFsDcTvMi0rvf0C3EMUuoy7qCvXyLiF3EMh59Del0Msix2yEngth7f08pARW00yyRtNQdyhkqnNnN6enjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Zeo4ca99; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so2815085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707900771; x=1708505571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2vGwKYokw3i/oEoJO6fwQAxXGHOptGWFu1l6NeZyDeA=;
        b=Zeo4ca99HYQetiv7RIFxNnMb/eINkCVdUq3+35KoRJX3i3Orwd/iRTfeLmT7fKKEgF
         6bvawWgd9bY4PJsz8MTxlbussTOA2Ff8KNEa/zFg+XTGPLnGGADAt1pOqCF0wBuvZkHp
         5C3h46mBpDub2Vw5pfinyMa6O8KESKSzaP5kRKv8f431p5bCECxsZ+0Oz3SMOAaopDyt
         4xfKovkd92+Vgggr7EMjrgQ3b8jACdD+J09hBQE7gF8jpdukf5oNM7BbAISACDCSOXcI
         qZVRURiq2xnyckuqfkBIG0y2vR9Gnq8hUZSPMoy0iJOqIw4uj9Jo13XoF9ZHt27/H76d
         QJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900771; x=1708505571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vGwKYokw3i/oEoJO6fwQAxXGHOptGWFu1l6NeZyDeA=;
        b=bm8nK3nHNIYX8XwX2dSoswqywbtrxtCTCHv8OcJdcmKzK7pt3zSZR+eCDsx/8/6huz
         e84LwTU2vti3cG0X0J3lv2VQf+ZTJLEfoXvxtNVrPXzasCGm3JZwvnpJzMTpJU/+y1V5
         PlPWDuGz//BBUp0UPnfmWuey3nydDY8xZ9pkqpo9rhY1vo/2c8jvnM/SbwtiPmtuNgRd
         DEaUiuYWrU+OLXZNVMm0CoVoM+oN1KlE5fS4Vdx3uaFRelyiktpIcSgyX9HzPJqQsj11
         AX8s9iRpNHdr7nYqVMOrKnhiLDBK1aPbHRDRtueapK3vcN+YNmKmlzajPGzy5aHy3YS4
         g51A==
X-Forwarded-Encrypted: i=1; AJvYcCXO2eZ+AJQH6ES/pLz1BP2WQdjenARgLwVvw4XTGGdWH9tEn2NaXpMO/nWezCZhaAXgpRhB5tDQDGYCm5xqkwzkegFuxZHjoIvUK6l+
X-Gm-Message-State: AOJu0YyaqxTz/tjtOlwikzzcGfVfa1GJDEcNM6v4krmVDCDtIF+Jfms5
	pRuC1pqaEwj1idbW16yIJE4CvDyo7DTCdNPzr77C1wnx3BVaq8OpvFqbKIf5qXw=
X-Google-Smtp-Source: AGHT+IFrFqtfG7itu6rycup1Q87PKnKv6wvTLWd/IQHkcqxYR1jvUiN3YfUXdpoeb7yhU6GzbKNoXQ==
X-Received: by 2002:a05:600c:3d9b:b0:410:c9cf:73d0 with SMTP id bi27-20020a05600c3d9b00b00410c9cf73d0mr959845wmb.13.1707900771447;
        Wed, 14 Feb 2024 00:52:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/3CA+LZTtKSYjuqCrIRzIdEf2vyzkF0EpyyyXtxTgbx+MJaJnlFZ8N+awafRT9NMvoi9FztGD1QkP3piz4zMIvw8DA3KpDl1sq2/Tt2tSPwsJTkCXP7ylh4b7Cl9MxveOysL9wMhNtEZePtPqWToCNZK1PV/afePj/R4CWtI6kJysX33ZILDL0HzphGHYDH1uypOJ5Nr5XdNsysnQopl56e7UcyJXvjdVBKk22d0ZDN8D2ONwxHxt
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:cfee:a5b6:1f9b:9c9b])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c379300b00411c3c2fc55sm1247672wmr.45.2024.02.14.00.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:52:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sysfs: fix inverted pointer logic
Date: Wed, 14 Feb 2024 09:52:48 +0100
Message-Id: <20240214085248.6534-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The logic is inverted, we want to return if the chip *IS* NULL.

Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-gpio/15671341-0b29-40e0-b487-0a4cdc414d8e@moroto.mountain/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 6285fa5afbb1..e4a6df2b317d 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -801,7 +801,7 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	guard(srcu)(&gdev->srcu);
 
 	chip = rcu_dereference(gdev->chip);
-	if (chip)
+	if (!chip)
 		return;
 
 	/* unregister gpiod class devices owned by sysfs */
-- 
2.40.1


