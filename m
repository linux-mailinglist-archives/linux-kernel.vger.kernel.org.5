Return-Path: <linux-kernel+bounces-106854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF187F48A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3871F21A02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA340A29;
	Tue, 19 Mar 2024 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUYDS3E7"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71947363;
	Tue, 19 Mar 2024 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808177; cv=none; b=Ra9BSkkrQ5haBLlfxBEQJWPw5eFCwDTM340IZR4p4Bfbv8DSJuLGeNTsyGacZwvuOsaLvryf1nCKwmN0tfx19KyrLlt79yR4joIWUb9PDptHfZbxiAC0JVE0O3xeb3alu+LFgD6VYtItdFSpALUD1bk7EBZjxaX1Ky5Bkfh7V9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808177; c=relaxed/simple;
	bh=7SQMhToJXVIevHGRudA6WrEHyve1h3fUPRthLx3mW1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cJAhTA1jrcg4MMVVqqZA2vzYD8Sg5y7uNbLSxFlGA9F3i6oiylzjTVH9f3b0tVteoUdh34pc/ZMVb249WmkWuNqIzxMuBtrwIk48FujcR6fboyaCx4mNLNui4wUtIbJs50vJ4z9kUglg0VraUG2Fmy7oP9DhN9BR5gvbKS8NUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUYDS3E7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56b95eb687fso66280a12.3;
        Mon, 18 Mar 2024 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710808174; x=1711412974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrKFOJwh3FiWFz8PnJclBgTo8T3TCygx+u8PGzuODoQ=;
        b=YUYDS3E7k04ovhh4Igmol9MKAK+7JRpKve9/HbZDyI/Ii0szUfNyuLDp2Ax5JG8CJM
         52gj02gO0HTPSYyYo319U41t6wdkYTRKiG+sQVTPA73oiMsJCnCSnhRriY40mIe1OjaI
         rgmOExbOxz8tcNP+JRqYyTvsK8IkV6JqwTEzNhNJEbwMoP9NYanm0vpgb3vcHP/1zCH1
         UqaDxKHikjCWZgkqUta0lWlbwKafa0JoBynwvC8qNjO/dScTe5HOl+2JEOyZoDwAOIRl
         PwVebmPG9UCwR3xNoQjNmVdOWI8ZUkTd+d2f/nmaTOn96rGTAIgDdjsozUrxYhEFVQJm
         eLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710808174; x=1711412974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrKFOJwh3FiWFz8PnJclBgTo8T3TCygx+u8PGzuODoQ=;
        b=rMmsk2poWStIuFTsp0sJkgmI205FXj9o3W0ZYHLPmzsAf9hpozdiFexc3jMFjtE5iF
         EEBC7ZGwVTJLCs7MnR29iGFRP4RkBBX9jT1RQBkLXAC7jmRyCcozaY4PFCBaewX5ftuN
         4mMXUHXoaD8vh7dm7/obiz5lMSMMf/yoMX5kQj0KpxjmI/tTUfCpcvIbfc8CT1puJaF7
         YXUvVlVG+dpP7KGBfr7ymuEK0fG18DhDO5Fs5K/jsZokmnx91S1izpZYp1kmLFiKzRE0
         KtXyW05sTowPPgBUloIkPY29fL76ehF/+X23tw+p3O464oeqYHTskfOi7of8uCIhzh9x
         2G1w==
X-Forwarded-Encrypted: i=1; AJvYcCWA8E0lGAJfaIeZ8nGV7RBuPXhUmbY7FlhZEcXNqluD2D2oHkDTNmK0eIGk3nc5kadDk1APrTNze8WqsFx/JSUTCW/wjzDWhnmiXXv5AhQz1VAPyw12dv9k8vM+vrSMA8yaBXzg0Avm
X-Gm-Message-State: AOJu0YwkLnFWjeUcVu4YVS+ClBeIjl7qL/leU5j7VkjVxhu0U6PnGIHN
	ktyKtREkD4pEkb69C49mdOxLnPNT3Gh7jvVbWPaSng+/78cgXLEQ
X-Google-Smtp-Source: AGHT+IEK3rOMctA1l8OyKcfeERlG+g5vtHULcdOeNylbLFbhwyYvU3kzATfpnZSg996ud9Xa7si3mA==
X-Received: by 2002:a05:6402:ea9:b0:566:a357:d535 with SMTP id h41-20020a0564020ea900b00566a357d535mr7980265eda.27.1710808173330;
        Mon, 18 Mar 2024 17:29:33 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:8c96:c55f:eab0:860])
        by smtp.gmail.com with ESMTPSA id co24-20020a0564020c1800b00568c613570dsm2700227edb.79.2024.03.18.17.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 17:29:32 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Series to add triggered buffer support to BMP280 driver
Date: Tue, 19 Mar 2024 01:29:19 +0100
Message-Id: <20240319002925.2121016-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:

Patch 2: Add guard(mutex) as per request {read/write}_raw() functions.

Patch 3: Patch 2 of v2. Added IIO return value as per request.

Patch 4: Patch 3 of v2.

Patch 5: Patch 4 of v2.

Patch 6: Completely different approach from v2. Instead of leveraging the
functionality of the read_*() functions for the oneshot capture, burst reads
were used in order to read all the values in one single read operation. This
minimizes the number of accesses to the device to just 1 time, which all the
values are being read. Different buffer_handler() functions were implemented
for the different "families" of sensors because there were a lot of differences
in the register configuration and read operation for different sensors.

BMP085 and BMP180 have a very well defined read operation that is kept in the
buffer_handler(). There is no option for a burst read in these sensors.

BM(P/E)2xx, BMP3xx, and BMP5xx have their own buffer_handler() functions.
Registers, endianess and compensation formulas are different in each one of
those 3 categories which doesn't allow for a more generic buffer_handler().

[v2] https://lore.kernel.org/linux-iio/20240313174007.1934983-1-vassilisamir@gmail.com
[v1] https://lore.kernel.org/linux-iio/20240303165300.468011-1-vassilisamir@gmail.com

Vasileios Amoiridis (6):
  iio: pressure: BMP280 core driver headers sorting
  iio: pressure: Introduce new cleanup routines to BMP280 driver *_raw()
    functions
  iio: pressure: Generalize read_{temp/press/humid}() functions
  iio: pressure: Add SCALE and RAW values for channels
  iio: pressure: Add timestamp and scan_masks for BMP280 driver
  iio: pressure: Add triggered buffer support for BMP280 driver

 drivers/iio/pressure/Kconfig       |   2 +
 drivers/iio/pressure/bmp280-core.c | 727 +++++++++++++++++++++--------
 drivers/iio/pressure/bmp280-spi.c  |   8 +-
 drivers/iio/pressure/bmp280.h      |  28 +-
 4 files changed, 570 insertions(+), 195 deletions(-)

-- 
2.25.1


