Return-Path: <linux-kernel+bounces-134586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9873389B348
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F6EB21116
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C993BBC0;
	Sun,  7 Apr 2024 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaQtrqb1"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C48208B4;
	Sun,  7 Apr 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510971; cv=none; b=gHSNVL8XKS6HXGL/SyzHxh4MBXKTLIll98hLTgc09KXmxadnKSL6tu7Rh+FW9Q3OsMttwQU5zVX7Lsn8y5v/z0UXb6lSyAO9eeGbg70AjtMj7MIqcnr1yurrwJP659zqR4oXlzWlG57Uvj7xH5d3nGffe83KYhKPzbow+O/19N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510971; c=relaxed/simple;
	bh=k3GSbfkPnSlKFhNG1YW7geFqEROWFhu2i7hOh0KBaT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b5zU/Wg8RrHUQe/TIi87mqfXnYZCfQ5uIaXcbujBPoZHeTk0kdQ23aSsrHrmXfHL0TGaKG6SzW6PWatTYTSq5w2xyah9fFmA6RGBPg3JMlebpwK+AOtl6Plwa7/ah0AzhVkKCvgDN0S/MydzWymEcFxMW1sJS+d6SuZj9kCbrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaQtrqb1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e6282dd72so67149a12.3;
        Sun, 07 Apr 2024 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712510968; x=1713115768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEflWiDle7vIrR2EbnYfdKCt0Pjx5vmcN03fg7oL+3I=;
        b=VaQtrqb1/u9P92QR5hvlPyG318Cjgej3VpjpNRwp2LyThluyreGYKamn4C1km5vCqa
         UJrP3kKE/g3RhPeYl5MGiRNoyOwIQ6RBMhjqUsZv+nYEOTINe1FcA5DeJZZOLPlrZ2Es
         D6id/RyrM6EQXil+wJfNvvrp1COvhSyP/CapjALBTg3G8Q9hFiuB+gFsx3dDek+qZ9Ak
         ahu43HtUA3/w4hv3Hrd5hJ+BfzoHtUYg5Rmc8EcW5xc8Yjx9zWtEEkZSyoJrj6s8M6sg
         zwQmg/pnpauUA76DSTbJ2sjr/PoyubJTUbI03jYVAbrYzvDBS37Li6zq9MlofnZ3e+ZZ
         Pg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712510968; x=1713115768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEflWiDle7vIrR2EbnYfdKCt0Pjx5vmcN03fg7oL+3I=;
        b=GCkZ1sLIIJJHPl9qzquQOu/iNgSPWlvtyfMNPiSC91J0ahXiJpmHWuV1qfPbubbq5z
         NGlZmJZRhrFLfgHNv7BXjQjj3CgTRwkFU9GeJXfeclJe/ouvbcR3DpFjBvhpinkGp5RM
         0osZBkZqxPuwJycoO9XAdbTUn+siBtGSDlW17y19o64++5O9ekXBUrrbrVQXfckYUXEr
         Yz/56NOLftOlhx1LYUnZvFHVnhzp6uKmpHx8/Q7J97y/Xc2OyZ6JJNP3Y58lX9SJLVcP
         tpSliPgj5tEC1aQrjARudjL2FGGgrzyGyMb86YzG7/Rqg2Ma0zdIYjTrkCg5WIG68cVt
         9uUA==
X-Forwarded-Encrypted: i=1; AJvYcCX+HMrz9YuU/n6Vw0iSS44IZq/Os1o5MOADIFawPGqQTUKE69DTcv5vo0ocKIMuBc7FpXbqiG0MKEOvtFhWj5XKUisS72VdrgfGqWruGsRfQlFEfj0tg2SgdGIDO0bl0syKkGwleRzz
X-Gm-Message-State: AOJu0YxAUdzDcgor6p/d5QtGtxydYc4ScaiE8POwZdmOVPpPcv00bTao
	PnAebNwHUoW0pP8hxqtqHq4Np6EGm1DvC0F1XNEG4fzyvj1tY73M
X-Google-Smtp-Source: AGHT+IHXLJXDjd0ft8ePL2ljMFQLzjIEvjzzhJxfVLSogAvB8MG44PI7gxNcIMENoellz+U8zcplSQ==
X-Received: by 2002:a50:d691:0:b0:56c:3b74:ea4 with SMTP id r17-20020a50d691000000b0056c3b740ea4mr4539222edi.21.1712510967633;
        Sun, 07 Apr 2024 10:29:27 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c509:e54e:6ef:eb0c])
        by smtp.gmail.com with ESMTPSA id j22-20020aa7c416000000b0056e4b9ec1aasm1307134edq.52.2024.04.07.10.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 10:29:27 -0700 (PDT)
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
	u.kleine-koenig@pengutronix.de,
	biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v4 0/6] Driver cleanup and series to add triggered buffer
Date: Sun,  7 Apr 2024 19:29:14 +0200
Message-Id: <20240407172920.264282-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on next-20240405.

Changes in v4:

Patch [1/6]: *new*:
	- Various driver cleanups, no functional changes.

Patch [2/6]: *new*:
	- Split reading functions to not hide the t_fine anymore.

Patch [3/6]:
	- Patch [2/6] of v3, removed dead code due to guard(mutex)

Patch [4/6]:
	- Patch [3/6] of v3, adjusted to the changes introduced by the
	  new Patch [2/6].

Patch [5/6]:
	- Patch [4/6] of v3
	- parts of Patch [5/6] of v3 which is the splitting of the channels for
	  the BMP2xx, BME2xx and the rest of the sensors

Patch [6/6]:
	- Patch [6/6] of v3, adjusted to the changes introduced by the
new Patch [2/6]
	- Change variable to push data to userspace to a s32 with a size of 5
	  to fit timestamp as well.
	- Add buffer_setup_ops to use the power management functions before
	  enabling and after disabling the buffer.
	- parts of Patch [5/6] of v3 which is to add timestamps and
	  scan_index/scan_type in the channels.

[v3]: https://lore.kernel.org/linux-iio/20240319002925.2121016-1-vassilisamir@gmail.com/
[v2]: https://lore.kernel.org/linux-iio/20240313174007.1934983-1-vassilisamir@gmail.com/
[v1]: https://lore.kernel.org/linux-iio/20240303165300.468011-1-vassilisamir@gmail.com/

Vasileios Amoiridis (6):
  iio: pressure: bmp280: Various driver cleanups
  iio: pressure: bmp280: Refactorize reading functions
  iio: pressure: bmp280: Introduce new cleanup routines
  iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
  iio: pressure: bmp280: Add SCALE, RAW values in channels and
    refactorize them
  iio: pressure: bmp280: Add triggered buffer support

 drivers/iio/pressure/Kconfig         |    2 +
 drivers/iio/pressure/bmp280-core.c   | 1164 ++++++++++++++++++--------
 drivers/iio/pressure/bmp280-regmap.c |    8 +-
 drivers/iio/pressure/bmp280-spi.c    |    8 +-
 drivers/iio/pressure/bmp280.h        |   68 +-
 5 files changed, 867 insertions(+), 383 deletions(-)

-- 
2.25.1


