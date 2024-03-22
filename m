Return-Path: <linux-kernel+bounces-110828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D07B688646B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51207B2168D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D744416;
	Fri, 22 Mar 2024 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zin8zpDE"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62210FA;
	Fri, 22 Mar 2024 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067848; cv=none; b=CViGpdohUh5TpSDcpEbDbeHR5kfd52HmFP+luJQ7XNhJXUHtSMcjkMXFTZcYjIeCepmVy6dRv4l+onFhIQdzNpYOrR1sRlZrZqcHEISNz+qur+SO9+OQMGjzkD5fiSob4RSFu7FJcQM3spZ+IbCIm/eq9hBhRAcoBOnqkzhjchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067848; c=relaxed/simple;
	bh=cZRKpREq1+mSTdHJ2+dKnJk+wXA+G7FnsX/QltF9LoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VNhVhjWzmqxeLd6Fwr5ce4zOGb0c/6rnyCAjGmcOKFbNLGd2VoUtVyy4cyjQ2OG5d/IngIs4fGaYV/uoN7RXmF2eAcEGVHX7gK9JJuX54J1JeKDtagR2KcTK0IUCJKc8N6HZg5jB090jIJvAGhAk4n3J7UwY1e6Ts0AW4v4Mbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zin8zpDE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso164209566b.1;
        Thu, 21 Mar 2024 17:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711067845; x=1711672645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2uqHc9ouvoPNaqDwbwGS4nnzEWfppAeWb4n/QR3EZE=;
        b=Zin8zpDE9ynn1ZIeXvHATJmD4YL78SRZXpom4hHmVSA/W8MjNixZRUCrQ2Q8G8QpHo
         VoHgHEX4D1DVWyP1J5Nt9zJ/eEvkNq1SK+BHB8yoikrOqTTLH1VWxpok1VDmdnpDTUsY
         G4Tg2b+ir2j+Ljta2YXn5llwikllQV1tY6WON5PbDExfYZXJDyxLjaqVBdcyBaW01qOb
         A5nnDfdeCEPV88YQHab3oQjRlqPLkbzi4PMUrlpxaod8ZaPpdfaJ6uOElklgDeF6RCms
         pv8OEk6VktxwR9t3Soe4qI5B/6Kr3CWbvWngN4449XBgQtMkGrV1x8hYs+d6f61tsp52
         yZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711067845; x=1711672645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2uqHc9ouvoPNaqDwbwGS4nnzEWfppAeWb4n/QR3EZE=;
        b=kO5FqcGqCjWiHXxepoFe+QeF66z4+ffyRQ0hBg06mjjaBp0T8eOa9MItoRPo3JVSJH
         U2q3j7emkZm+R7QwjN9xcPjK+uAQvhWN1/kIFtuFHndDSCFbegFCJykGG2l1wo6/ShHQ
         1xDNWen4OmZdjb9nNIs99L33t3RBKPqy6D67tkRij9K4Lck675dLgCxG9q8kIynNIJSw
         jnaczdpvbq+aPubt5gAThfwc5Lcm1rgSbWxnHWrstDKlBiDH0YT8FvvtOAe4O7woITMa
         Bm8k5yqXXqJ1QZiO8BUeRjPPCOxr5wgsAyuQolBRLgSvGPEnY0gSY40w20A0VI6Jv7z+
         W+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKOh2sxZNMQq2E3xCB6ac/87Z9EvOCLORQmXmJ661gs0b8JdIRpgwfkobQnScD3gdK3E0miGEdt3CTeov/PMWcuM9FPq5GhShxzDVZfhgEBO30oLdbkDon9QWyMUJmbn3iP/DYDA2BMQ==
X-Gm-Message-State: AOJu0YzDzzSq7T1CVZYMVXEn88sn+Ys2ofKN8vso9BrlEuPMbr1SK1iR
	dND/3GMV4lZENHZdDHJUaEnq/2yFt/fMZCFy++lLEzbNKAX/QIDnkFle/SQUADRvlA==
X-Google-Smtp-Source: AGHT+IE9F9LofvqrJFkW07VZDpYiLFIMl/PfrORIa1sQYA5F+od94OpRg4nR/XnDMp/LSOleot+SGQ==
X-Received: by 2002:a17:906:e290:b0:a46:f018:3f1d with SMTP id gg16-20020a170906e29000b00a46f0183f1dmr599310ejb.73.1711067845388;
        Thu, 21 Mar 2024 17:37:25 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906774b00b00a46af0fbf5dsm439950ejn.103.2024.03.21.17.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 17:37:25 -0700 (PDT)
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
Subject: [PATCH v2 0/3] iio: adxl345: add spi-3wire
Date: Fri, 22 Mar 2024 00:37:10 +0000
Message-Id: <20240322003713.6918-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move driver wide constants and fields into the header. Reduce
redundant info struct definitions. Allow to pass a function
pointer from SPI/I2C specific probe, and smaller refactorings.
Apply regmap_update_bits() in the core file replaces the
regmap_write() to format_data.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
V1 -> V2: split into spi-3wire and refactoring

Lothar Rubusch (3):
  iio: accel: adxl345: Update adxl345
  iio: accel: adxl345: Add spi-3wire feature
  dt-bindings: iio: accel: adxl345: Add spi-3wire

 .../bindings/iio/accel/adi,adxl345.yaml       |   2 +
 drivers/iio/accel/adxl345.h                   |  44 ++++++-
 drivers/iio/accel/adxl345_core.c              | 117 ++++++++++--------
 drivers/iio/accel/adxl345_i2c.c               |  30 ++---
 drivers/iio/accel/adxl345_spi.c               |  38 +++---
 5 files changed, 146 insertions(+), 85 deletions(-)

-- 
2.25.1


