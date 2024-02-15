Return-Path: <linux-kernel+bounces-66423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012AA855C88
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3416E1C21DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4D14002;
	Thu, 15 Feb 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rgiRJp+Q"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEDA13AF0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986021; cv=none; b=pZ9EaPFIUSyBY3l7+fqHtdnHp+5x0gjwDSRhHdtlR8L8YtwTzZQg/xai23Hi73Ug9EFmsnt4FPlli53DeMuiN4hYRX2PLLPEPiMROr1RUyuimMG+imO4t7/Hbe/jS43qub7SZN28iObSHItKnu+bL6iUxaNJFJkKPAlV4M8FLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986021; c=relaxed/simple;
	bh=xT5dfURtGIxff62raqt0jG+pcsjp7uhfEREhWd31PRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LUwrjpno27SnMJqECb/CFR5kLEJuQwOJR7QzYHs4twFLVHcYXs9r/Ajdetut0lKxElp2y7lwvG4GtUT8BF8J+yD5xL8do2aJ7AwuoMFJy+moEn2ViSDqFcUQeW9v9HtNWHgjbQLAke8YVrz1Ke0ADade0L6ARKwMW/x2Yswksn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rgiRJp+Q; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d09cf00214so7781951fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707986017; x=1708590817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez9xOpn3UTLsU+b3iGm2vmX6gqE6PZNq2Dof+USHQP0=;
        b=rgiRJp+Qem11c2HuaMFORjMJWUhH42bl3u6IkuCAVxIVmcHdhSrqrYI4ii3zb3yGjk
         4Zgq6t+jLUt8A8cDulRb84EYI/N8iUT8gRr12o/3I3bF2T7mCiUXG4PvZQcOcK3khmRJ
         kZOC5kzYPOtiAdM3sNd0lf9iIaVCiTca/MCY97XxUFXy/L9gX6NNN9ByOBktVaLhQiWI
         iNRKfWCIQlHTKiFr2F90RC0ledaQfI5f50LU+BALeuPGkJa5ktf0EXlu6bCUdb6Tija9
         wSvU5n2IH/yr9v1Uopaj281PKZODFMssAVI6lEr69ZXwx/4KYa+uinI6E5LuYKglssKS
         BDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707986017; x=1708590817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ez9xOpn3UTLsU+b3iGm2vmX6gqE6PZNq2Dof+USHQP0=;
        b=D5YgeKW8W4Hb681gK1Mpmffxg01AdGAm281hRVurTqqEY8nis5kvZgsQVJDgsTL7WH
         866GlOc0oKnCtkwqb5DEJbHHZWyLxvrYncp7tjwAwVi3eiyaNIP1Muk5SFuZL2k31VPD
         KKy4rwxdcPbqPztzOPMIwRUBVvEKv2HwFAQOG/T0W/InKrLrikAAOCjmQlRmwG1utWfm
         NLkPF9HWL7BjwcIDsCMBE98bxOY5ITRjzqma/JsG0LWVyeEgFW2QoC0LXdkoXbpZFJbU
         6K6aW9pIh+wZaz2b/FifFbf+r7IBV+3svjescmLyf+bxH90aikzZaFH0JbzqH5rlb/GF
         PK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEiL+w65zuhIvUCJv4GlS01bnObAZ25fQD05k5CtnAcfTmHjASZv2jM1pe47EWa4uqduRTrgDCJqaCn+ZGaSdl03UOntMjxNWD06qg
X-Gm-Message-State: AOJu0YzTRQtUSi8DEDRCC+ql1AyvjbXfQRJ2521m1yh+km3k7cYY1Q/N
	6+9lY72aiFzmcrOGZn/2dEA+mGaEbfSdkHlgdpaFgH++A2cTbEZlRTjEOq9TntzwIev+XVK29of
	3
X-Google-Smtp-Source: AGHT+IFQV7OKQsTQ/UxE3IWZlRvegLax6f9smfnoepWKpuD0SsrBm4RCPyfQCitdXEojv+hB5o6haQ==
X-Received: by 2002:a2e:9c58:0:b0:2d0:a8fe:4263 with SMTP id t24-20020a2e9c58000000b002d0a8fe4263mr760447ljj.25.1707986016884;
        Thu, 15 Feb 2024 00:33:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:20b3:d902:bf8e:897])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c211600b0040fddaf9ff4sm4286906wml.40.2024.02.15.00.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 00:33:36 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpio: provide for_each_gpio()
Date: Thu, 15 Feb 2024 09:33:27 +0100
Message-Id: <20240215083328.11464-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We only provide iterators for requested GPIOs to provider drivers. In
order to allow them to display debug information about all GPIOs, let's
provide a variant for iterating over all GPIOs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 9d0023f83a57..5f915b653548 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -551,6 +551,21 @@ DEFINE_CLASS(_gpiochip_for_each_data,
 	     }),
 	     const char **label, int *i)
 
+/**
+ * for_each_gpio - Iterates over all GPIOs for given chip.
+ * @_chip: Chip to iterate over.
+ * @_i: Loop counter.
+ * @_label: Place to store the address of the label if the GPIO is requested.
+ *          Set to NULL for unused GPIOs.
+ */
+#define for_each_gpio(_chip, _i, _label) \
+	for (CLASS(_gpiochip_for_each_data, _data)(&_label, &_i); \
+	     *_data.i < _chip->ngpio; \
+	     (*_data.i)++, kfree(*(_data.label)), *_data.label = NULL) \
+		if (IS_ERR(*_data.label = \
+			gpiochip_dup_line_label(_chip, *_data.i))) {} \
+		else
+
 /**
  * for_each_requested_gpio_in_range - iterates over requested GPIOs in a given range
  * @_chip:	the chip to query
-- 
2.40.1


