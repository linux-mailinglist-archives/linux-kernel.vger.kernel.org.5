Return-Path: <linux-kernel+bounces-95574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10756874FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D5E2812B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F112BEBA;
	Thu,  7 Mar 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuxjlY04"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFD12BE82;
	Thu,  7 Mar 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816982; cv=none; b=tH/PSAMUmn91RSEtlfPulTfA187/J7toxUhxMPBScUt0qBQa2sZLtvKGBSD3VNLMkI7iZP+edLgvGG7MELj5vIsXcjT3oZuU4U4PfEDsW2MjUXUJXdoseC3GweaOuGVkT3d86XODIqmonwYRCMEWKmxeuNuZGvaQBQY2F7CGk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816982; c=relaxed/simple;
	bh=Yivi+y5+uuW5FmjQUgfsPEIzDhekN7OovGedOH1oDsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAy+ugDfDL9KAjMlfJSM8DFPlw8oVPonJoyT5LN36z7j7sHnYXTiH0AGb3GQ1Yy+9ouN8JyK51viqfoiH4mrC3wdUyBncdKgLOLoDoSwZkYDfvYKVY5zrAqEvoj0KtJylJN5MEf5/zqcymwfNylGQzfYzPPyE51sfhqv5CRGHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuxjlY04; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dd10ae77d8so7494495ad.0;
        Thu, 07 Mar 2024 05:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709816978; x=1710421778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3i96anQwNahB9+NcJld8jx+M1NCXMVBf9l31E5Ub6Og=;
        b=fuxjlY04LSJrEnJbxjyAn/fBGq9KL85E1VRz5EpVvJAs+wy8LwfADe7UGRKbUFTe5V
         +yvPfr5oCTPB5MjMH3L70ahVOuH0cAeM8LTJ04fMm2i03d/3lXbyPUphLp5Xz/IdhPvM
         +L25XueU/1ukjT5gYkN4/6Qb5SmtA/wjtXrlavqd3XpJ7jw8g50H1Uwrep2floNP6PoV
         Y0ms3q5/5id54ljq40xM5ftElAlXos73ECigUcOlj+jm4iZlCvS+2fPaDSU7ym8tCbfg
         dsh6XthJUbmcy9LODomim9iH8wYUldLKezVgnnQmAmNig/HK1H/w3iYUtKbb4jsxD3BQ
         nQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709816978; x=1710421778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3i96anQwNahB9+NcJld8jx+M1NCXMVBf9l31E5Ub6Og=;
        b=LyrMF4DhVT4sJgVlMZKkMp8wDPElS7QpsLAyyC6CYH1lXebAwCteHMo3YOCyF1fzp5
         leyABaXWR+FsYdhLXR68SD1wPSh1/ZrJtRI1haU4E63qdKyT9eNQpFEUgD0NTgU9zGTC
         CbAS+MGZsido62v5Jb4lF162T+qozlUWCOQtMRoZ5AnfsZvwJHLQOTYESXpoU6vHGo2W
         73UgFX+XtdMLwojsEWH3c4hIPLLWLPuyVneWfGjloQO5n3V6T+lQWToHxYqZfR2DAc3G
         Mw+RTeBtaZO3bgYGC9vtMQhDL3ORB30M1zb7fUWuYzP1XDg6Z406NnTqHCRTWFg4qs3J
         xHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Hea2DYC9O26V/z+JlJNEqdFSPul5KBilFnZpF5dNgphpL3iuHBaGY/2NesV1O4qR/IaGRh86GQ2bnvcu3Osk1oC/5r1At1cHYhox
X-Gm-Message-State: AOJu0Yzq6rFF7b5nwNMPCjflfuGgfv/s3rC5a5XGEcHrJQNKzKvx17ys
	QPltsiWWpOu70U5dYco3ovwB9Oz/y5tDaOyJ4l0YtsYH8xPEgz1CiRazFCi+DMQ=
X-Google-Smtp-Source: AGHT+IHAlRDLelQxbU9FZGRGhtpUHesk8lSQUxfBrN/ZrvhKmuF9bGbmNV2lu9Zqc3pcE/otle6jLw==
X-Received: by 2002:a17:902:da85:b0:1dd:37c0:a354 with SMTP id j5-20020a170902da8500b001dd37c0a354mr6623369plx.33.1709816978425;
        Thu, 07 Mar 2024 05:09:38 -0800 (PST)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b001dcf91da5c8sm10718803plx.95.2024.03.07.05.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 05:09:38 -0800 (PST)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-doc@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	corbet@lwn.net,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] docs: w1: Remove w1_gpio_platform_data
Date: Thu,  7 Mar 2024 18:39:26 +0530
Message-ID: <20240307130927.581176-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`linux/w1-gpio.h` was removed in a previous patch and should no longer be
needed for using w1 gpio.

Fixes: 9c0a5b3f9e55 ("w1: gpio: Don't use platform data for driver data")

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
Changes in v3:
- Also remove uses foo_w1_gpio_pdata

Changes in v2: https://marc.info/?l=linux-doc&m=170980615205254&w=2
- Replace mailing list link with commit id

---
 Documentation/w1/masters/w1-gpio.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/w1/masters/w1-gpio.rst b/Documentation/w1/masters/w1-gpio.rst
index 15236605503b..a00b00da0049 100644
--- a/Documentation/w1/masters/w1-gpio.rst
+++ b/Documentation/w1/masters/w1-gpio.rst
@@ -20,7 +20,6 @@ Example (mach-at91)
 ::
 
   #include <linux/gpio/machine.h>
-  #include <linux/w1-gpio.h>
 
   static struct gpiod_lookup_table foo_w1_gpiod_table = {
 	.dev_id = "w1-gpio",
@@ -30,18 +29,11 @@ Example (mach-at91)
 	},
   };
 
-  static struct w1_gpio_platform_data foo_w1_gpio_pdata = {
-	.ext_pullup_enable_pin	= -EINVAL,
-  };
-
   static struct platform_device foo_w1_device = {
 	.name			= "w1-gpio",
 	.id			= -1,
-	.dev.platform_data	= &foo_w1_gpio_pdata,
   };
 
   ...
-	at91_set_GPIO_periph(foo_w1_gpio_pdata.pin, 1);
-	at91_set_multi_drive(foo_w1_gpio_pdata.pin, 1);
 	gpiod_add_lookup_table(&foo_w1_gpiod_table);
 	platform_device_register(&foo_w1_device);
-- 
2.44.0


