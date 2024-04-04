Return-Path: <linux-kernel+bounces-131190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A0898433
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795051C26BD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3402C823DA;
	Thu,  4 Apr 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lOXzeHgv"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149CE77F1E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223218; cv=none; b=W0lUlMh3F6Vrkj7D1IdyjNWSv0fV8BOQQQkNBR5eB1jcxJVC0KcNTsXcUOwj/UnlY5lN/jwp+fqJF9WD8JTkVgKGfhvtaSvDtQfxLRT88nfrm/iYhJTdgAtXAZkQS4Os4qUu332Dt95zbt6akxZ0u1JQVPA1jCxGZm8Ti97/sGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223218; c=relaxed/simple;
	bh=XT8qfTbBDxmpkv3wi9MqFr3mAml1cvbPorzvDz9txyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RfmyEP9d6Ue7tHNV6l8PMgCUKWZenqkO/UyghG0Pglw9SgGfSMvDaU1wePjgTSBrw5znhALbqOSzYfIgU2Mk/ATl8mTL1eXQu5TQv2VOL/zZ+sES8/SwHZBv5TFteTN4hZoA+RgvOm3i8YCwamkkiZlecF/Uzpi658JmejSFRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lOXzeHgv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3437f70078bso528555f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712223214; x=1712828014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwi6HXvg3yM5JJ1Mku4nVoIzxX/h/Bvxo2KK8Xe1bO0=;
        b=lOXzeHgvSp0xNv9xJZ4UNaeDzDNxD8VrAHs4t5WGS8A75vIw33GCvM6nNKJyEgLv4D
         X9OrvdPh9rVmUoz8IclzPE3qi41EYXSGdCEC52rrrbIhVo7jD6J9FNe+bgD1yZhSdoe4
         66maM6YAqIhRpIi0bUfVOFoMmMdGV4PqOwkuh5GID8pr+GcRTT+fqMlTlmgUoL9dawWa
         YDs5tVfRIZWaKbtwheOD8Ip70srh5Mp+Mmh749nY5RcTBpbptYsa+Huei47lL568c3Ub
         gjmbTgf9bpOXBBsnE4o5rU/pVrcFd0lGpkfmAK5QKEG7qFZ77Hx9jypyqiRADi42d9bs
         eM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223214; x=1712828014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iwi6HXvg3yM5JJ1Mku4nVoIzxX/h/Bvxo2KK8Xe1bO0=;
        b=ctSCjcpy6PslpoNVdRoIkOtpu02IvRFEwHkGjzKjMHXU9r8UYy1NXSoUeknMVs1fdc
         QcyR5Z+YgynHeaw3kfeg/QvZqJmigIKmemD0ldV6RygdRPm5PK4UM+ogddA2GBa1Dl6O
         II8/gSe6NW7+CBBsu9PE8jPEHr/+ep+W1fbe2hTG3h9X0/OwLSc+hYpCtpYQw6meIuMk
         mO1MW+4IPau14KDBpcceNrAlprkRq+C+jg2nMsvIDh1C0jexZEZSWUrC/9Ksxpq/41yE
         9TEjd1IupgLH9LlA/Ol9BIhxvHu0+0/QijFOdgWBtwdioD4ojpnkEJUsvCBb98DtALsJ
         3jZA==
X-Forwarded-Encrypted: i=1; AJvYcCWFyyy8kn/hfNQ6Ze0ADC0XIiGweHvZFsT3gw8peodssHGSZwSDGDUXaOpYyviTgsDlyY05pUkLukKus54jQHNovBnBP7q8aRgBgfW2
X-Gm-Message-State: AOJu0YwDmKB3uwmKMhSScw74HzB3m8oVA66W8xN9VjUDebpcH9d3gINd
	l191JmDzkJfrXZLjN17W8TqNQgPwMTsibd7j6oULK6++vLJW5lA1PWFUZ/b5gkw=
X-Google-Smtp-Source: AGHT+IGL0b96w+Q2HwiPsxRXzggO4UGgmu7GjYYzWIr5gtnrvMiTJc1Hq3g5cGUH81UdEC31zK1uDA==
X-Received: by 2002:adf:e48d:0:b0:343:a30e:bd9d with SMTP id i13-20020adfe48d000000b00343a30ebd9dmr1697909wrm.3.1712223214274;
        Thu, 04 Apr 2024 02:33:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:220a:565e:2927:8cf0])
        by smtp.gmail.com with ESMTPSA id dj13-20020a0560000b0d00b0033e9fca1e49sm19436385wrb.60.2024.04.04.02.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:33:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>,
	stable@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 0/2] gpio: cdev: label sanitization fixes
Date: Thu,  4 Apr 2024 11:33:26 +0200
Message-Id: <20240404093328.21604-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This series fixes a couple of bugs in the sanitization of labels
being passed to irq.

Patch 1 fixes the case where userspace provides empty labels.

Patch 2 fixes a missed path in the sanitization changes that can result
in memory corruption.

v1 -> v2:
- switched the order of the patches in order to avoid introducing buggy
  code in one just to fix it in the second

Bartosz Golaszewski (1):
  gpio: cdev: check for NULL labels when sanitizing them for irqs

Kent Gibson (1):
  gpio: cdev: fix missed label sanitizing in debounce_setup()

 drivers/gpio/gpiolib-cdev.c | 46 +++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 15 deletions(-)

-- 
2.40.1


