Return-Path: <linux-kernel+bounces-117373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A192088AA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0F72C5DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037980C12;
	Mon, 25 Mar 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZE8CCiN"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D943E498;
	Mon, 25 Mar 2024 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380889; cv=none; b=B6+kngji055FcEze8AyYrEZSYW+gBjqQMi0meDYE6rNarMVOAyy/Tlj7PtMhDIFxXQyp1xNRoZuxd/MoXlG4+HmgLzf39d30fDXPwmZy50oXX6ZaRtTRpvRw0+eN5J7uQBrrvOCzoBKKE7PBYa0CdJbOPJN3rBTy5/2LjCBoSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380889; c=relaxed/simple;
	bh=SWJPUdbdgBsLocJw9zZUxGwhw9WQL7BJpTcevlbtIPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jh8XQvcNhieQ7fSTd/w1QUGOvz6t0uJfwav8lh6pzB+0rSInomtgOqa5amVEUzw5VqvpYxToOinXZ8dC6cNRTcfTagXckOtbYWs0/9jh2T1pVlnP639kj2AHZZ1SffrACtg3srkcm7869tGvsaF5uViFckESWJVP/YYYSMB0uXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZE8CCiN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46d0a8399aso922828066b.1;
        Mon, 25 Mar 2024 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711380886; x=1711985686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=to0pyQPfxcJtcILU9vgU3qUOhuelSOLbFp6VJfVGk2E=;
        b=OZE8CCiNIBq2/t3jcAecfkX+CFiL6zMoBTwTJHeon0o8aGtk+Xazagj8X1ZnVNXXMU
         UNy3Jcu5H5JDq5GZaa0yLXey9ohZwqaRzvGMOAtwVIXCRwWKm9+kB5y9/D0ExtGPJfwj
         9lEQaXMjpuzzEwAZnFzX8KLux91hpZ1ZWNCM61d6kkUEXWPL54TNPf1lZI3q90LICcyd
         uzYHABIKHby8pWpcgqyoobumf7kE5fTbMlBFEK492cOkxNHD+loIneehYp6NXc1JIErT
         SMCcxIRJpGYjUUe1+gAO81fFVyigsPX1ycOo/466KZ4G1DkaSXPHWTxx5SGIyGB8/jmk
         wXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380886; x=1711985686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=to0pyQPfxcJtcILU9vgU3qUOhuelSOLbFp6VJfVGk2E=;
        b=ZXcoZTNKt5DM+uWQGxJCXa2U5bs5Y2ZKKsh4daulYavda2t+aVyh/BJ9uwXlzBppt0
         5EN1U+jj1NA1AVSxMpbYuUT0WAQi68y23buZW0dk9FR4eipiKSG3Uz85ZnAAe78Wzrjr
         1VzvUbFNY8r65aJXpBABhjtpsq6C/SLADrHRwzX/TaEGnk2UOlu51bBJnp2WsLHVpjD6
         C4lKsPfO+NnLJmlu9nFKZLsLqw51B2LOvmWanA/8MrMtbeLic5bjxO16LexA4mU4OjM1
         T1jH0b+ixnp7bD72H37Srisy+L/N2LDAnO4filDBy6UdvUC0vSJwDFsN7+rQ63+NhN+3
         Sfew==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3F9FJmJ0bo3u2qgnPIBGhwqG6QwcBqXBVF9EbvAky0n09x2hrRr80q3/U3Bw02TObKZhYQwPoQ7N3gxJ43BtMxlCiUP2QcSSN2OCqmkITa4PL+Vz5AqSwNBaGFgweonS486EL3OsGg==
X-Gm-Message-State: AOJu0YwrWH16SLxAzFeS1nL7d4rqKRyl+ghylee4RyoMKefamdYpn1Ug
	sfBPIMkuIIXyvH6RzrMcA/0dF9UAdJxMy7544eNxocmHZ32os/6Y
X-Google-Smtp-Source: AGHT+IFqZwMHFvugb9QsdtsjUYOYi8QnDy/LqS6hxibY50EeL9RebKW4aeHWYPSRQDRgRyvqsgpmxA==
X-Received: by 2002:a17:906:64d:b0:a47:4141:f60f with SMTP id t13-20020a170906064d00b00a474141f60fmr5349239ejb.17.1711380886158;
        Mon, 25 Mar 2024 08:34:46 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090626cd00b00a45200fe2b5sm3142382ejc.224.2024.03.25.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:34:45 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 0/7] iio: accel: adxl345: Add spi-3wire feature
Date: Mon, 25 Mar 2024 15:33:49 +0000
Message-Id: <20240325153356.46112-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass a function setup() as pointer from SPI/I2C specific modules
to the core module. Implement setup() to pass the spi-3wire bus
option, if declared in the device-tree.

In the core module, then update data_format register
configuration bits instead of overwriting it. The changes allow
to remove a data_range field.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
V1 -> V2: split into spi-3wire and refactoring
V2 -> V3: split further, focus on needed changesets
V3 -> V4: drop "Remove single info instances";
          split "Group bus configuration" into separat
          comment patch; reorder patch set

Lothar Rubusch (7):
  iio: accel: adxl345: Make data_range obsolete
  iio: accel: adxl345: Group bus configuration
  iio: accel: adxl345: Move defines to header
  dt-bindings: iio: accel: adxl345: Add spi-3wire
  iio: accel: adxl345: Pass function pointer to core
  iio: accel: adxl345: Add comment to probe
  iio: accel: adxl345: Add spi-3wire option

 .../bindings/iio/accel/adi,adxl345.yaml       |  2 +
 drivers/iio/accel/adxl345.h                   | 35 ++++++++++-
 drivers/iio/accel/adxl345_core.c              | 63 ++++++++-----------
 drivers/iio/accel/adxl345_i2c.c               |  2 +-
 drivers/iio/accel/adxl345_spi.c               | 12 +++-
 5 files changed, 74 insertions(+), 40 deletions(-)

-- 
2.25.1


