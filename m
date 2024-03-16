Return-Path: <linux-kernel+bounces-105157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A187D9D4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE51B2142B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA212B9A;
	Sat, 16 Mar 2024 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEelWBxY"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A811718;
	Sat, 16 Mar 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587272; cv=none; b=VXK3yYgc60/BkbZb2+/l9X1FNx4MDdMfFbwUELRdgtlj+TTIaEOmCMADtwEulfEIlEg2sddXLldRKI35CRrupk6o1lBPNPmoXBA5FybH4v11FmeFgfHlozHTcQDX6tlZtTEzy2WysZ8ggHgPTpbbtj1nMiHc/yMghzhknlzLigY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587272; c=relaxed/simple;
	bh=uMg84p5+nt6ugDqCF7JHXR2Th62mx9I5zVbGYPmIOr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CpgLqM//F+NC3xwy5CBBQQaftQvA+8o9w2cC8eGp+OOIcV5tVs8+dEvx9pqa1KAOAFx9D9CuPOV8NMMue5GdKQI657006mYBnbCNi3PcNHmh2i8a+Qdbj1XqcbHjeUp6Lti8m3xP9l+ySQo+fvfqCmpRkCmoQxV312PosCJ74TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEelWBxY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44f2d894b7so332639366b.1;
        Sat, 16 Mar 2024 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710587269; x=1711192069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsFP+etcqLUu10G7NFk8DiLWUaSTl/LDHWMJOOX2Hfw=;
        b=nEelWBxYjxWTE5lgdYOu0sqpNcxLqPKtS2NsDNqAq5pnEl8jdDSHIuxr4e4zkyNwg/
         QVJZ3RrfBbdacTOpjP/J1ZTjH/yjSXwIh6jZMgjloMWRlwJQ1pMnaiGc5UgHOkzeAQjL
         1LY+HuH8PWKfk61t4HEd2v2jblydbqROchlzsCTMPehZh3DPVtAwpYX0Rff/l4tBY0Jt
         JOqOjcab27nL871QYFtDG5xnO7sgboYcuyHQ01z3v8q78/0CYRxk3GifePwUXIMpxPjb
         zPSjrF2QK+RM3MZDv+eck2FGmRTdzmQEBr8HofIDjI4VYnDzs4sA+pbG3Ed2ryt5HElR
         USew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710587269; x=1711192069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsFP+etcqLUu10G7NFk8DiLWUaSTl/LDHWMJOOX2Hfw=;
        b=Ur7tMRGE39+WnQyHcvxWC5S57ZiIVYdVvwWKsrHZC6bQyiPmf5+6IRG4bwC0co5yDQ
         7MHCvnApS4hc/CNb9Qj0t324IBJXgzhMnx4fJnGDL9vRFzuzv7S/GJzdocTs6/GL46Xk
         RyUw9XQFfK3oqFJSpHquA/ksCFcSgnKdCL4EBiq7cTtG7fXYiyM+qd9c4epBVl/Nb9Ne
         T0wGDRWN2q8zUmwcZ13ZACB3+sgq1hcBrF0xxyuYhUKMmlJTBfUuIolx0fShYM5oaMQF
         gEj0D70RwYH4X01HQXEdn1Cs9OkqIRulQhGGL64cE4WocITKPygagPubJHAGVLDrzJVJ
         Em2g==
X-Forwarded-Encrypted: i=1; AJvYcCVPEIvatlDMQ+xEagSl4RVgdxwsMlXZ+8oL5x+06Ys3hM8BbkqEUVvpZOCr6C2QhfQZ02Yzt3uzTSh2Wn3AH2CxK0ETvCBzc8M7h1gSKFvqJsWcogzz26VOmmtGyBt8uJAV9JDI/V4c
X-Gm-Message-State: AOJu0Yz1UXF8dMptndtOzT50MzMtedaLsyNPJ21HJF5zhOEEDqUGyrRI
	KgVYoC6QW4TU+Ui0R/TBjK5lO9z518YYrGD1Cr03qcQ47V7gPF0M
X-Google-Smtp-Source: AGHT+IFmaJyZfS7GyEeUKjIdP38X2inpLZLDhhKFLw5pw+RwkqKbf29tlRoQr82LFhag2kDAvWEOYQ==
X-Received: by 2002:a17:906:97c3:b0:a46:7d05:202e with SMTP id ef3-20020a17090697c300b00a467d05202emr3785979ejb.4.1710587268893;
        Sat, 16 Mar 2024 04:07:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c0f3:8008:e41a:ce01])
        by smtp.gmail.com with ESMTPSA id bx21-20020a170906a1d500b00a4655976025sm2627223ejb.82.2024.03.16.04.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 04:07:48 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 0/2] iio: pressure: Fixes in SPI support of BMP280 driver
Date: Sat, 16 Mar 2024 12:07:41 +0100
Message-Id: <20240316110743.1998400-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PATCH 1/2: Fix BME280 SPI driver data structures as it was assigned
to the struct for the BMP280 and not the BME280.

PATCH 2/2: Fix identification of BMP3xx devices in order to use
different SPI regmap.

[1]: https://lore.kernel.org/linux-iio/20240311005432.1752853-1-vassilisamir@gmail.com/

Vasileios Amoiridis (2):
  iio: pressure: Fix BME280 SPI driver data
  iio: pressure: Fixes SPI support for BMP3xx devices

 drivers/iio/pressure/bmp280-core.c |  1 +
 drivers/iio/pressure/bmp280-spi.c  | 13 ++++---------
 drivers/iio/pressure/bmp280.h      |  1 +
 3 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.25.1


