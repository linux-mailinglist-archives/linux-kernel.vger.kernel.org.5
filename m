Return-Path: <linux-kernel+bounces-68499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7ED857B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72EA1F221B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5E958ABE;
	Fri, 16 Feb 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uRLKV7C1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBB558201
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081713; cv=none; b=ScrL1uUhr/Msx7b9auPaPZRfVt0HusIib6nGG7hd8L8YOgryOPil1151j9GKnIfnlppN9YfahYZb68uPuelKa59jRxE8PkqdONceiJx/hqfmygmpW/S7TXt4CIWOcJSFibcgC7wFvN0bzldM60I0d3Wn4w9bKoljWo4hh65xcGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081713; c=relaxed/simple;
	bh=OprIDaPfMCHTrZGtzB7FNvr1ioR2TZWLJ6gWaxHzNCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ow1R742ptkGAOCNzRqk9javGN1+JFWFvb8rOSXc17wzgAs4XdBcJoEpIFIeMGp542GqOJPfIP5LQP+Lh5kxymV3aFvmO6LZCmIT4/q6vIHW1XzeljKazuRoafU0ZQMTS8bbjCKwYgHgsJ1PPbUiKt81H4rX0KvnsTe4qdvtHHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uRLKV7C1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41243d19ecaso3295175e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 03:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708081710; x=1708686510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EszBtn+jIheCOSLeYTHssTg9bKih2RCDj7mGXuxi30s=;
        b=uRLKV7C1tka+OPOtcefryDzYiwY8AZV/WjgELsxghjlQC+daxEERptABks3qUFTjbg
         MYJ+yY+jTRb0zi4wjco6i9Kb0GL3hPgbKSFy+QcQaygmZTEBHtxlI39BQ4K5748eYmy4
         s5Aru84a9GpwNe4QjK7F0zKB2hfxhdXzK66h2aXY4yjOEUSFXratBWJO+GcX+umkO7Nv
         jRtF6g6SaECsgAt6ne5ypBEXqosu1pVz2JE4LBEvr7wTPATdvhpCcU1SU9pjBLZ0QKGy
         E8TJSCRRq+EnpdNeiexxNN2taIPAyXbiOg6MUegAnJ0QN/A9EbWz+MQkEHoVmIwKI8LZ
         D9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081710; x=1708686510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EszBtn+jIheCOSLeYTHssTg9bKih2RCDj7mGXuxi30s=;
        b=he4ZMlsAUF9qTnnGJ8m2wsQm4cyr+ZCUQmLF0ZaflBhfTqG9V2NQ2jIT050WGkw7eU
         rVJvh5mpZu0+QAxOAw8SVesYmisybRDkfwC7n98sM6TAe7VF6OgapiSnyu8Q7uzkkN2z
         KFasHVJ5M/ZALBVNMSJOAb5FJg+3CATCRGDrklsP1efmdipcFDQbtVYY9OH2iUJ6WDwa
         eapyOQ467b9nAXM0d0454zLGIFrbvBrK1tFCl08RPgU/TF6xdXhcLFHJWKHrn5nPdF4U
         c3d9jVoAdyrJaDjd0eJyR4JCRtKaP/e4dmZQPnnb3hFmHRTs7NWVezOh3vtcPiJtpX2F
         QEPw==
X-Forwarded-Encrypted: i=1; AJvYcCUL15aFLW2c9gHJeWlHP8+Yk2FtwgWu152rIhO8sVYJ9vwrBOdGvXqiuT12AvKyvKuXmDZL82dPLVtQyRlaaYBO4MWCIQ2JJ5VBYymh
X-Gm-Message-State: AOJu0YzuOU+oVJXE3iLglN/FvEmuQEIN4xANNMs3lW6xzDvcR+i29xHn
	6gsrAB82uNbB2SwPIS1JlLaer+ysDyJw8irZjwEPb0odISYmmMaIbj1GGrp2Mot3op5//Xu4rLI
	l
X-Google-Smtp-Source: AGHT+IGL3+BGpCfUXj33fuIZnvOkJJ7Z9V9jcvb5acLLTv95N8YEYsCPGLn9NsotNVH3Oj0dvrdDZA==
X-Received: by 2002:a05:600c:4588:b0:411:e0f0:7a71 with SMTP id r8-20020a05600c458800b00411e0f07a71mr3655646wmo.33.1708081710360;
        Fri, 16 Feb 2024 03:08:30 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id fc13-20020a05600c524d00b00412157dc70bsm2033110wmb.30.2024.02.16.03.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:08:30 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.8-rc5
Date: Fri, 16 Feb 2024 12:08:27 +0100
Message-Id: <20240216110827.16793-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following fixes from the GPIO tree for the next RC.

Thanks,
Bartosz

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc5

for you to fetch changes up to 2df8aa3cad407044f2febdbbdf220c6dae839c79:

  gpiolib: add gpio_device_get_label() stub for !GPIOLIB (2024-02-13 11:02:53 +0100)

----------------------------------------------------------------
gpio fixes for v6.8-rc5

- add missing stubs for functions that are not built with GPIOLIB disabled

----------------------------------------------------------------
Krzysztof Kozlowski (3):
      gpiolib: add gpiod_to_gpio_device() stub for !GPIOLIB
      gpiolib: add gpio_device_get_base() stub for !GPIOLIB
      gpiolib: add gpio_device_get_label() stub for !GPIOLIB

 include/linux/gpio/driver.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

