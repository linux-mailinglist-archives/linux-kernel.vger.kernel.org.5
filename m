Return-Path: <linux-kernel+bounces-102282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0C587B028
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6676B28AA73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51A364CF8;
	Wed, 13 Mar 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwEEFn8S"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA94AEFD;
	Wed, 13 Mar 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351617; cv=none; b=CLNYWq4AcOeyn3G1v5I8AhiUaBuCPzx6PFmDgUxXb/Bo6pUEfhCYb1Y+AN4A9h7LXNOIGeGRINumVgsKlGuKoTgTzc8gU00OGOuYQxutMKMQwdZTcCO5Tp2HErDxyeLHQJaHTczUJal/2YIh6pp4loxKl3q9qNndeYGFMfcREUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351617; c=relaxed/simple;
	bh=Ns5xfy/sbPNx6F1ycRVcX57JMl8ewV0mTqKIsYm8wwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LSBVLY4rpjgU/+St2q5p+To0HGfqO3LJhpLomqCOmYUe9fMec6L/akWlOJNEBkS76DA5fSMe8OMobyRVDLrBmLekFP/l03suURUbtiZMRy0WAxvgMua6X37cJdxBBHCp6manCSX54VzQ/iT1HQM/rXS6/Q431qU9CteOh/lzgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwEEFn8S; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513b16bb739so130663e87.3;
        Wed, 13 Mar 2024 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351614; x=1710956414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zllk/wuhCWwtewos2WrOxr/iwLLxz8oG0dapHF1TNaE=;
        b=MwEEFn8Sv5JP0waMzdNVx0AvStVvzs6ljrVcN6KXTMQtFFNUjP5wH/3H6+auvHN6Yx
         hfSiWGTlf3ZMi4SyQNVrVaF27jEbv0S1wda5gEGEZtQ4WQpeiptutZWUYR4kRxVrfIG/
         d3DL5axqc9nn6e1X3CAJVnUOctJcibozphS8iRmxv8P6Os+s87XTzV+wYcaLdwsO8D3v
         xTOZNRqaUWr887aPwW9BCuJyDwtjuGVk0WccDfbUBXnI36N5LXZd2NbSrxhbScH6coEY
         SL1qqLpjYMOdyCUiKK9eW4ZxS7C7XpfzmucwFal6x4+0pqEbQuGgepzI59Iotk2YCCtk
         Rmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351614; x=1710956414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zllk/wuhCWwtewos2WrOxr/iwLLxz8oG0dapHF1TNaE=;
        b=dPNu/7u49d6Gz7Kr2tDo+yKz96i7TzRu7e4QDqulx1bqYO/qHW3Qntnu9lDJT8REIV
         pd/Z6MsINc116WOQQnrORA+Sk7JfwPbT94/nu8E0TNpHSawiEziwXZvGTdl7SWwapdn6
         TChtvtrFhbOrRLZjLuneYk6Dd6wNZCMMVMG6iH8PlPiQ+T2QwdR+FuU9vfL1tfPKtTUt
         rvk0hJ7osb+EF7ybjPtV8HEY5hm4i+oTtsCeGXF9dqbJdJk3+R3bLdpOSxpKxF1XNLCE
         LWXH9ePNhXuwpE3pU2LNBwavEiQox+tr+MbOAhtoqX50DCIgUdjbnLbdOMT0PjbfqVkn
         mZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc3aYfWKDfyuyUv3VW9NrXY3tJD9G9fevbgovQT9tR2ZNJMjZGYfyUlFUIThAKqIELRXDpl47ArffqSxyt7DWu/MnBWsqi32qEIB8DN3KeTr0uHFxTOGSMgm/alnJ99bTuNHMP7d5/
X-Gm-Message-State: AOJu0YyEVNclyq7yzAexiFmIFl7/doEqh/Gfi2mrqAdiHz9UUiJEbjh0
	Jvge3rb4j9zUz3lAXK1syOaqDGouNMg2mFqki+AfVJ1CkedYZhe/X1nAwhqJtVkU49xT
X-Google-Smtp-Source: AGHT+IFY53Z1HU32RMopggwHU72J4n/dn2jOLl4GM0poV8p1TlGKJR2+N1p1ls7fnUYeItcc28EGXA==
X-Received: by 2002:a19:f815:0:b0:513:c0de:307b with SMTP id a21-20020a19f815000000b00513c0de307bmr3638430lff.28.1710351613371;
        Wed, 13 Mar 2024 10:40:13 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709061ed100b00a449076d0dbsm5028215ejj.53.2024.03.13.10.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:40:12 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	linus.walleij@linaro.org,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 0/6] Series to add triggered buffer support to BMP280 driver
Date: Wed, 13 Mar 2024 18:40:01 +0100
Message-Id: <20240313174007.1934983-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the proposals were implemented, and 2 extra patches were added (Patch 2 and
patch 4) in order to have better logical split between patches.

Changes in v2:

Patch 1: Sorted and removed headers as per request.

Patch 2: *NEW* Patch, adds coefficients for IIO units in the chip_info
structure as per request, remove them from the read_* functions.

Patch 3: Patch 2 of v1. Added RAW values as well, as per request.

Patch 4: *NEW* Remove the temperature reading from inside read_* functions so
the addition of a buffer for userspace is facilitated + make the code much more 
intuitive.

Patch 5: Patch 3 of v1. No logical change, only minor typos as per request.

Patch 6: Patch 4 of v1. Previous commits allowed for much cleaner approach as
per request. Dropped filling of extra buffer in the read_* functions.
Patch 4 allows to put extra buffer in the union of the chip_info and fill
the buffer in the buffer_handler function.

[1] https://lore.kernel.org/linux-iio/20240303165300.468011-1-vassilisamir@gmail.com

Vasileios Amoiridis (6):
  iio: pressure: BMP280 core driver headers sorting
  iio: pressure: Simplify read_* functions
  iio: pressure: add SCALE and RAW values for channels
  iio: pressure: Simplify and make more clear temperature readings
  iio: pressure: Add timestamp and scan_masks for BM280 driver
  iio: pressure: Add triggered buffer support for BMP280 driver

 drivers/iio/pressure/Kconfig       |   2 +
 drivers/iio/pressure/bmp280-core.c | 431 +++++++++++++++++++++--------
 drivers/iio/pressure/bmp280.h      |  18 +-
 3 files changed, 326 insertions(+), 125 deletions(-)

-- 
2.25.1


