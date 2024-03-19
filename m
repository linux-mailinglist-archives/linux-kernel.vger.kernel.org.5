Return-Path: <linux-kernel+bounces-106855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026DD87F48C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F461C21AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A474315CB;
	Tue, 19 Mar 2024 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpnpzWOy"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A7368;
	Tue, 19 Mar 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808178; cv=none; b=MvfuEhA5tAsry4LgFWgB5447JorRv/b3rOffywV4G/eCNVSYmLSt75c7EjkfIk0JJGUt5CAmKfghLlr3u6o40JsEA/iq7R5c5EPXWr7VTqO7No+4TnOFO6FemqzwpWqHaywZWICn55jO3r9rzQYecOdHaX5Z8FBclN+I57McATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808178; c=relaxed/simple;
	bh=6Ouxyk1MFE8oPL5EtYMsLRqOrNWjyubaatGPHGKRHrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHnuEE8EuhRJfUaLIjtfwIWkSuyl+Ml5HsXOYJZW33ICCPgoYKsNWX9N+2BeHGX8vtys85j5JDpkNtcKqdQEAdb8LvwXss1/9VZ5nuM7UQETxC4FXNXG/5kC4b6GesFf3SMtNrvfHQoIZCIOp/OrUWZy2qZfK8xdh6fUTwQj0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpnpzWOy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a465ddc2c09so341981666b.2;
        Mon, 18 Mar 2024 17:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710808175; x=1711412975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6laUTApqd01ANpCuz0jrMfAwGjaFU1xJS3mFm+uw6r0=;
        b=MpnpzWOyh9LrXoELJrwGZQDn7WunxM1jXoDxLOHQ1ypxRN2CiHOurDzruJoHWpzlqx
         SHovbWwmQ0ik4sh1CncbtMLB7Uae/2jDCStau0MNbv6dlu57y+Lr7QPspEJ1k+3/6iMu
         rpQvaGVXYe67UgLkBPgHNSv+KjyMqHO6y7LT6t8p5Fz6V/WiRinBasrMeAxjovkElVjP
         og5taLeNYzGOgLxEOzDCpFnTqaW8WWZMBPdQpcq882Wag8omI137edJcvLVZoTeZxCpA
         sqcGtqtj43v4r9DdkN74B8He/GAuyLdn6P+t5lABKe8jBWdoxOMpz/jKjvtQJ8CH5rRx
         fD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710808175; x=1711412975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6laUTApqd01ANpCuz0jrMfAwGjaFU1xJS3mFm+uw6r0=;
        b=mTvp85T7CTzk1eI1M2We96We9fmMAaIkCGUakpLFt3xfQTdXvQktjUWjpZIVdls46k
         2m2zQuRc9uNGr2P9UIYPkbYmpGpv5pYZJVcZ9XTkT6ckiyIg/InrWwrQqypXfaexx2fH
         PRHl/fgkgtOAP8g9x70Wn/h2QhB54KZ3rZIlBkLSHTjgIo/8B1262YcglJLY8qW6bN5W
         MeOR3R+zE62buLDx26SBIMHSu8sPWHn8360heLfFB1yfpHyj52fcqJSYnfUIbc+usY9n
         h0CQ2NhLRbG+9Y0FHUlzqSe+XsF0XA8jIGAag7uqZmJfyqUT3+/ceWqNjZJmdT+zMguZ
         QW7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwNQnplkmHtIFohDDlkTD8agdy6k+sh/akXG5GUh8F4iMQbwY3p30KGRQLmjl1Hf2fQ0jyIhF1OgT34RSBoGNkszOIfI1QBppOrv4vut8AzGkuuku/A2rXYlbILn0Lbj6OYNRM0KIw
X-Gm-Message-State: AOJu0YxBbs/XR51DqhxnIk74H/Tg8flEzbdw/l+b55RQ9UO4NL0qilVJ
	U0lZa+hlEttNMorQcoDkWanixXvFFRvZWnCUXmPyErMDegPTYw2tw/EKp5eFUYWicug0
X-Google-Smtp-Source: AGHT+IEngGGUNsKhXEFBVV+MUi3yyf+vCtFDkIwVlSbHJ/mp+l7HrM2+CHFIE8wUj93ibSoJjoIGpQ==
X-Received: by 2002:a05:6402:4146:b0:568:abe3:52b2 with SMTP id x6-20020a056402414600b00568abe352b2mr8218087eda.23.1710808174727;
        Mon, 18 Mar 2024 17:29:34 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:8c96:c55f:eab0:860])
        by smtp.gmail.com with ESMTPSA id co24-20020a0564020c1800b00568c613570dsm2700227edb.79.2024.03.18.17.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 17:29:34 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 1/6] iio: pressure: BMP280 core driver headers sorting
Date: Tue, 19 Mar 2024 01:29:20 +0100
Message-Id: <20240319002925.2121016-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240319002925.2121016-1-vassilisamir@gmail.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort headers in alphabetical order.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe8734468ed3..871b2214121b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -27,20 +27,20 @@
 
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/nvmem-provider.h>
-#include <linux/regmap.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/device.h>
 #include <linux/gpio/consumer.h>
-#include <linux/regulator/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h> /* For irq_get_irq_data() */
-#include <linux/completion.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
 
 #include <asm/unaligned.h>
 
-- 
2.25.1


