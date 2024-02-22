Return-Path: <linux-kernel+bounces-76317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B085F594
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729601F2290A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CD23A8FE;
	Thu, 22 Feb 2024 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fmOnswuF"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F0039861
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597526; cv=none; b=f9srhuNAu2a3v8EUmy1qUxMFlA58/HG8buL8bH0KkwxB+v5nhqckCBvTQzEQbHEnGpom7g9/CCMKrrgbp8SNQZr3G2oitV9Dl6fF7x+LfTs3DrJjx7MSXtbKnVBD83jHVC5cpEDij6MwS98qaxHw/Jo/4UHylPn2CLeXAYiiQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597526; c=relaxed/simple;
	bh=mnxxNFv+0lFpw/SFMfmvyOPBK7dB4yVlBgJH3aPt1as=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XCRHl0HY4p9X+KFHXqeveR8KCMwypaGw0JBMCRh4ucwjivN55jtVBf2sohE8svAWKG93+9SOi8W87tsF+YHaDgMQ2qnFzse5+a1S1LRikA2ovpYXf57sPqKlMP9o7qnIJ6+t68I6YTjgFNbdtA/T+WFWhJWjlatUzBk3E3VdV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fmOnswuF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d23a22233fso49995441fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708597522; x=1709202322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dhl5ESUaDZOx7x5KxkphJWu06MFmNtC2GZwvxBuWor8=;
        b=fmOnswuFbm8IoGvrw7ODFN6iKLGSmRoaeCvT6us1qe6oiEN9vy2/FNVCJBmuHxpx2g
         oPjSVt9P7K7aezjq8aZCMTPCG6bP3bZS+m66juOCbt9Ln+oL8BIe27m19ZWNGWmV036H
         +jn8DMVPyuCAVEz1SAZDNUJ9Tz3W75aWB1X5MFzU9avqXqicgsWeNm5nr6z3B/l9IO7d
         4hz1cnpsvolxibxzCkNmTbG9dgURgDcUVuTd6cqnrJDdvcQdj2D4JD9M8Iud2DW2N40m
         16p9g/o6iGy8lvpcEnRQ9tlr/o4Oo1WBRWOHG4IKtpNSVB0sl6Q+KhcvfRZIXBvTeVBb
         nOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597522; x=1709202322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dhl5ESUaDZOx7x5KxkphJWu06MFmNtC2GZwvxBuWor8=;
        b=wkXRvNKV+9b/aGwpT0fz8pi6g6/1MrxrTkN7sIHZKERhEY1XGZGSk0uAIaV/mvZ8Dx
         zPQz3H70zWR3zU3o0T3YO8drzXmf0b9hZ43xGDzzKtnxXwn5Xa6HihjZBiI/cUjqOyvq
         YnLLHURWxm+tjCHCQe4Yq59gKGAQNKqGOSjuHgU9flvKpqZ4Q3FKi2nlzowAQDYSCXS/
         E1HcnOZra3mjQ570CVO95FIVoDS36krMxUuAHdsZ64Ws9vNxgBgshmLk58AUsTR3vVdi
         BT3xJ7xw8CIWW/i/jB8vh9j1jHpuNjLw57XyHPjNrOd+9CODorx+KDAghMWouRK5XedW
         +NwA==
X-Forwarded-Encrypted: i=1; AJvYcCXuF5ad+msLvnvbGQvoKEjivvT7Wa5kNmM+VrCf+efFRGIpeM414cBzSPsjKsGEel8bncFw/U0mE951IRxTx6zHCv4NrQNjTL964oHQ
X-Gm-Message-State: AOJu0YzHepknTNqO2DQ58LoIwfEuMFijKDvh6pAlFt3vAVVAGqt8jOq6
	O4HlEbkpwTgcrQuZDRkWBYTdMO5YS9jyUxZgAaMzmLe57mERBzgBHJtY3YExu94=
X-Google-Smtp-Source: AGHT+IFOqwxJiGBc2Fme09gX8vKqytLAGdD/ajuD0r/rE1luPnxjk/tot7zNIx7Fsj9Rj2kppY/ECg==
X-Received: by 2002:a2e:3c09:0:b0:2d2:3017:c144 with SMTP id j9-20020a2e3c09000000b002d23017c144mr9167469lja.39.1708597522077;
        Thu, 22 Feb 2024 02:25:22 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:465e:5c78:c1d5:890b])
        by smtp.gmail.com with ESMTPSA id ay3-20020a5d6f03000000b0033d1b760125sm20632623wrb.92.2024.02.22.02.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 02:25:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/2] gpio: provide for_each_hwgpio()
Date: Thu, 22 Feb 2024 11:25:12 +0100
Message-Id: <20240222102513.16975-1-brgl@bgdev.pl>
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
v1 -> v2:
- rename the iterator to for_each_hwgpio()

 include/linux/gpio/driver.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 9c1fbfaebaa8..175129a92656 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -551,6 +551,21 @@ DEFINE_CLASS(_gpiochip_for_each_data,
 	     }),
 	     const char **label, int *i)
 
+/**
+ * for_each_hwgpio - Iterates over all GPIOs for given chip.
+ * @_chip: Chip to iterate over.
+ * @_i: Loop counter.
+ * @_label: Place to store the address of the label if the GPIO is requested.
+ *          Set to NULL for unused GPIOs.
+ */
+#define for_each_hwgpio(_chip, _i, _label) \
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


