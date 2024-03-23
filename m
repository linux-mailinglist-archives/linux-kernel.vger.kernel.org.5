Return-Path: <linux-kernel+bounces-112338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227E5887896
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7070FB2418D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F13D0B9;
	Sat, 23 Mar 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjLEVJPQ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290C73B193;
	Sat, 23 Mar 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196442; cv=none; b=n/aGLRu7DR1gX9D/I5y27ubk6no++TkqIYHcjFMLFhR6mYTNl1m7EH9iBLclZ8bGPQT1bfEBawQ9U+db1HY9BXmjbxRqlkJA2aFY1DFBoWsZv5mK+gX1xUOfNiyKDMMDmijPB1iWubLoZ9O63pwshOF+3TszgocrTPV4fWVj2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196442; c=relaxed/simple;
	bh=mhr1GSL3eFbC2H+hd2iN6RdNtiKSBL7v8xeFscpj5e4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VsUqOGHfTwkrp+7JcyxbMGiGdoWOUagsi8QC7WfghvP9vtxmpkF11VUDYoHa5cZjWfxhMluQ1hOQ8Ah0H7s2i9iLz+2uzyFMzfRgvZzcLAmaBJX5/IgQrpoR1aOvVORsbQA5w7cGBr4leSf3Q1ni2nfD10+d54OH9mU3DxOTWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjLEVJPQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso351139366b.1;
        Sat, 23 Mar 2024 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711196439; x=1711801239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ooGuh7xBF/G4N1iw+8MZFTm7X/18XpLCl1peI1pSFg=;
        b=TjLEVJPQjE1sGvgyXGoQO1JrTP5mGfKuxKK76Z3zIN/ZaQUhcWem2F1NvTQYYVo3co
         PE2I+VHBfbTs7MR17FWGFvnHHk4O+qWqlWsddvyNqYJJC8XPlB2FpgkFa4rz2psME+Fg
         p/t/b/SMirI7Yz99rGSk1+9eyG7O8hlBR3M0xKtX6Z2CGyXppaVP0aaBzjzdmLPEjk9+
         g2d7PlPHTTpjvC7NkaSLQPxYey+rd1Wh/S0oFCrGZhEDwONdAHyPJ7sM3CRIb16SvnVo
         4thYSscHrSvZp2y6snECYTs1OQ2DFwqyI3yTwdai8HtQsk6/23/xNbgdpMrPqISjiL/E
         c+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711196439; x=1711801239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ooGuh7xBF/G4N1iw+8MZFTm7X/18XpLCl1peI1pSFg=;
        b=DxaSwgmicwhVFwutpj+EQbf6ZZKCeh8y3pqqhuGpo6DYpsXqHYqetxvUb0W/l9PPG8
         M2NsfZA1ufM5sNiq8X0Aj/waMxXfC1A0HOs6so09eE9of/hizF2aiCzZkNlxdaO1Gbkx
         a63lsQNW4UFfRdJfi3Qi7oLkXrfdy6nafuAQEZHZDIGQWfI5TuQMRwZhk13SymMYOGa/
         06n4GuN5oeML3PbHQctQx2KGLuP4i7ucPGYbzlxej7g6yqBlbuqRoG1VrVBjfepT+Tbq
         1kSAB2LoDyO4B0WoP24Qnkb8X2jrhueZW0qbzHvHaSgJnKmbXfqO/OrJqGzG6+zLamgP
         lZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCXA/AepjE6666L2eFBWwIx7hRg1pXmQIT7Zmgg3pT+3PqogugXsg639Gf1j26DySzoaspeueyN/fb5b/sgE98SVDh3R0X+ki1wAcrbpCG/wxtbUvDe69w6WLo5FzcQB+ODLZ0cGuzz1iA==
X-Gm-Message-State: AOJu0Yz4+gePnBkR0hIlcEoEisHPy/nG962AdCFKz4zCzXbKU0yQNljU
	2qhKo+FPiWtUwrOLEGB0tHBGpn7Sv0VlE5RZ/r4oDjZUfWlr3Jej
X-Google-Smtp-Source: AGHT+IGj/M5V3ZqDG9laogCURap0i/Gb5Ek12zOx6QP8gTVk/D1XeFuWNkd64qM5dlyhmWXffCw+lw==
X-Received: by 2002:a17:906:6d91:b0:a47:669:d0f2 with SMTP id h17-20020a1709066d9100b00a470669d0f2mr1922397ejt.50.1711196439335;
        Sat, 23 Mar 2024 05:20:39 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id gx24-20020a1709068a5800b00a46f0d133b9sm857265ejc.98.2024.03.23.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 05:20:38 -0700 (PDT)
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
Subject: [PATCH v3 0/6] iio: accel: adxl345: Add spi-3wire feature
Date: Sat, 23 Mar 2024 12:20:24 +0000
Message-Id: <20240323122030.21800-1-l.rubusch@gmail.com>
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
to remove a data_range field, remove I2C and SPI redundant info
instances and replace them by a common info array instance.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
V1 -> V2: split into spi-3wire and refactoring
V2 -> V3: split further, focus on needed changesets

Lothar Rubusch (6):
  iio: accel: adxl345: Pass function pointer to core
  iio: accel: adxl345: Make data_format obsolete
  iio: accel: adxl345: Add the spi-3wire
  iio: accel: adxl345: Remove single info instances
  iio: accel: adxl345: Group bus configuration
  dt-bindings: iio: accel: adxl345: Add spi-3wire

 .../bindings/iio/accel/adi,adxl345.yaml       |  2 +
 drivers/iio/accel/adxl345.h                   | 13 ++++-
 drivers/iio/accel/adxl345_core.c              | 48 +++++++++++++++----
 drivers/iio/accel/adxl345_i2c.c               | 22 +++------
 drivers/iio/accel/adxl345_spi.c               | 32 ++++++-------
 5 files changed, 75 insertions(+), 42 deletions(-)

-- 
2.25.1


