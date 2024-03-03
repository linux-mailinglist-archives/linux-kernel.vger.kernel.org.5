Return-Path: <linux-kernel+bounces-89829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798986F635
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7079D28663C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DCE6D52F;
	Sun,  3 Mar 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2r7GcX2"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D51E499;
	Sun,  3 Mar 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484787; cv=none; b=F9jjU+d/7dBD05ow/cXcjKo89prNFZa1xCw1peJ5O0RmT8vk12NloO1VVKb48LAKTpUVDJbu6VXh7Mz5aH9FzB98YXsRd2PnzgdBOCDGhsLy4nrqCmypaBHH+tKQKfq4aR/cXB/QgTP2YGzvO2coOdsb/HrEEIFEku+yDj1eTLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484787; c=relaxed/simple;
	bh=oXsKdi3rqPebjSREb8BNR0oS9KqD6kN+anEhn/voM0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O380zI7a1D93KB62AGXUFEZLA5fhtQInfM4lCqqEPpveXGZAhBYIk6fXBe3yXJ/cRq2xcaWMxnnjtDurfstfLXyEyv6ImGaaGwHHM6WTTl3M4YlVMUYnCLXRMcXhA9/WghvzOieupPCvVqzonWzgmYyP3rhgV0oN41ASYILtnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2r7GcX2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5132181d54bso3905509e87.3;
        Sun, 03 Mar 2024 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709484784; x=1710089584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxPIonyHPpYZBnXEXTpWueHpmlbKwK0yDVa9D3QDR5c=;
        b=T2r7GcX239JlQ3yZa1kQO3oB3xUtVjDc8wJ9MkHm4kgVx+Og19QO7zBJ0n42wKycdE
         kMkGNhyLhtmNspfwb8+Z5mi5DAY0Tq0K3ZplhUrgeHARpHAJ4b7HPXDBSC9u5crCCWlE
         gpTnhmfhwVIoRGZNk/vRwtuJByJacAkczBbMHHySEx3+bxMVAchbZ9HCWtVJ0NwWlczx
         xR5rHgp6g2h81EbBcTghgkmwp5eUqYc+J3xlzBeKOtpANfof8TG708MvueIYtQh57AIL
         kQtb89lMv3WHUanQHEo1zuHokiP+AtX2lUm4eGrwmwLOveBfdpvYggDqrdeasG5465qo
         F9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709484784; x=1710089584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxPIonyHPpYZBnXEXTpWueHpmlbKwK0yDVa9D3QDR5c=;
        b=wcruqfIHsm+LY/KHCLnbr9p3lDPxabIllceglVlgdtxbsmZCbfMZx+D8Ww+ZAFK/YK
         H17zHlcKTTX6tvmgzAcwoUgh6WXDqhGqHAVQOQ5sk1jvEYDr+uBF1qR6X5Ab9OdLmn/X
         uY6CZXLusEO+SuiGzuZDhjYEG0D8Dn6oHI+B5l0dAca8yOT6xp1Id/N6aN1/K5bXZdbq
         TH0oP0WYw9F8x1fH+W5w/5Jk4OMxPSgqMo+qUJ1vZawZ/zYDySDWTeL+haEvs2I+pvXT
         /IhTVEnLxIDSy/M9koK2zvdd6VeHagXF/Fry/EO21/RIB2MUVZ/GzlyH/6Vswm5fGl0a
         ROdA==
X-Forwarded-Encrypted: i=1; AJvYcCU8oyIAg9BDS6hSBs66uogg8VkJ/vF4eDit7fIDK8C+GmdUaALMMu9fDIhOwSrhzHhLUl0k10jtjDGgmZwU7FaZmMJOfRl/iX2naRiE0eK7UHg2iKv6rNca9iv3zB8ImsMh2150shwm
X-Gm-Message-State: AOJu0YzRye3/tVRtrlprBsqHXT6MULa7PyjNPE7NO44/ZG51k9xtehfA
	8WdMxsKCrKk9nHJnh2NMXy508+E5DGAg7Vqt41KXeoaPXS6a2WTI
X-Google-Smtp-Source: AGHT+IF7iUIANlKYFkE/7Vmc0ayt40lgye0L702fs0aVdThJehECOg+gS6Td7FaMTDFsvnKPJK+pAw==
X-Received: by 2002:a05:6512:2114:b0:512:fe1f:da5b with SMTP id q20-20020a056512211400b00512fe1fda5bmr3863730lfr.57.1709484783663;
        Sun, 03 Mar 2024 08:53:03 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:82:7577:d4e3:724b:4d69:34b2])
        by smtp.gmail.com with ESMTPSA id lh15-20020a170906f8cf00b00a44f14c8d64sm1413992ejb.135.2024.03.03.08.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 08:53:03 -0800 (PST)
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
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH 0/4] Series to add triggered buffer support to BMP280 driver
Date: Sun,  3 Mar 2024 17:52:56 +0100
Message-Id: <20240303165300.468011-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series aims to add triggered buffer support in the BMP280 driver.
The patches have been separated in a way that a single functionality is added
with each commit. The 1st commit is independent but the others not. Commit
no.3 needs commit no.2 and commit no.4 needs both commit no.3 and commit no.2.
More details below:

PATCH 1/4: Sort the headers of the bmp280-core.c file before adding new ones.

PATCH 2/4: The scale value for every channel is needed in order to be able to
calculate the final value in userspace. Every measurement from every device
requires a different scaling in order to apply to the IIO measurement unit
standards.

PATCH 3/4: This commit adds a channel for a soft timestamp. The indexing of
temperature and pressure channels is changed and temperature comes first. This
is because the temperature measurement is always needed for a measurement so
it is better to have it as first for the available_scan_masks. The values have
already the CPU endiannes and are already compensated. As mentioned before,
only the scale value to convert them to IIO measurement unit standards is
missing.

PATCH 4/4: This commit is adding the actual triggered buffer. An extra buffer
is added to hold the values of the measurements. This buffer is not inside the
union but rather an external buffer. The reasons for that are presented below:

i) The sensor is built in a way that first you read the raw values out of the
sensor, then you have to compensate those values in software and then you have
to convert them in IIO measurement units. This means that the values of the
data->buf (which is in the DMA safe union) cannot be used directly to push data
to userspace because even though we can have the SCALE value to convert to IIO
measurement units, we still need to compensate first. Only the latest version
of the BMP58x sensor returns directly compensated values.

ii) In order to have a pressure or a humidity measurement, a temperature
measurement needs to happen first so the t_fine variable is filled/updated.
The read_press() and read_humid() functions contain the read_temp() measurement
inside their bodies. This means that if we use an extra buffer inside the DMA
safe union in order to push data to userspace, the first 3 bytes of that buffer
will always be overwritten by a read_press() or read_humid() operation.

In order to overcome the above 2 problems the following things need to be done:

a) Remove the read_temp() function from the inside bodies of read_press/humid()
and call it before you call them.

b) Modify all the read_temp/press/humid() functions and instead of returning
the IIO measurement unit (with *val, *val2, and return IIO value) just return
the compensated value so it can be used with the SCALE value in userspace for
buffer reads and for oneshot captures just do the extra calculations for *val,
*val2 and return IIO value in the bmp280_read_raw() body.

If the solution that I have already sent in the commits is acceptable it's OK.
If it is necessary to have this iio_buffer structure that I used, inside the
union which is also DMA safe then I can immediately implement the a) and b) 
solutions and resend the patches for discussion.

Vasileios Amoiridis (4):
  iio: pressure: BMP280 core driver headers sorting
  iio: pressure: Add scale value for channels
  iio: pressure: Add timestamp and scan_masks for BMP280 driver
  iio: pressure: Add triggered buffer support for BMP280 driver

 drivers/iio/pressure/Kconfig       |   2 +
 drivers/iio/pressure/bmp280-core.c | 352 ++++++++++++++++++++++++-----
 drivers/iio/pressure/bmp280.h      |   8 +
 3 files changed, 311 insertions(+), 51 deletions(-)

-- 
2.25.1


