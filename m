Return-Path: <linux-kernel+bounces-163160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638088B667A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75323B20F00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6942194C68;
	Mon, 29 Apr 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n3CE4WKF"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F50194C7E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434038; cv=none; b=ZhZ88lRGBiKraiFQSCM8nWT0BxGDoFC3tEprnYOvWPeA0vti1FuJeh6ENp5A8he2z1zkXaKaKiD9o/gZcdt4v0XE8JmQtJ5cjiF17Y5aqeGcAi9VCLRwMvzPMaqlalhW3vw3wA5j0uoyC3xzU/S/ijDbUwEcaJdI4Rf1uz8txUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434038; c=relaxed/simple;
	bh=lue8tGKQodCQW7f9Ah8mLVDqX/DjwpQuD96ROdxcrKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XdNJgLUItmLYC6LO6Z2JQxsyDjNl7QypaKEjuQ6mhtTZN21+ukO8+CrFnExTXeD46YCcX0sxjII4TvX3DgtoTXEaYIVH9iGKtpsg0SwmRZdUatkQHVhWA0cEe5NHVm/8ozvO4uf4V1Lfjj5/rzgAW8A3Zr1ImMrJr/gYvLULoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n3CE4WKF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23319017c4cso3290510fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714434034; x=1715038834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RbyRopVLlo3z9muP6tADTHE5XtuugaNtZZWMLb0Jpk=;
        b=n3CE4WKF3ND/TUY3+9YxfL3fys9TCoaqxOAoU2s5yl/wugLbbqjrmzy7hFZ97Glvmk
         JyGNcQusHWdmW2pWMlEmf7dMRtSAIE5sqGVXlB4Z5DbOcXPYsvkkCqbLGYvlZxCnqScL
         EgJYtYOJ/NNBhJDq+u88rCVD2EiUhU0R4MXeJxBQNmx57OIJBNrzhVKXJO4XuQGLr9P2
         4yA1AKRkzUNft0nZGrH/PWcbFFCFE7+Nz+uA3/pbu6io5P/gxUqCgV70Y1ylzoK+QNrJ
         MP8jLCPuqy+bKrkFUyYzafcI1oVYKyBNzyN48Axsc0+bgOP1kpCDNeofqGBvqT0z7JeJ
         CHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434034; x=1715038834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RbyRopVLlo3z9muP6tADTHE5XtuugaNtZZWMLb0Jpk=;
        b=j65TntN2ZoWKmZ0UDWeDAqDE6rfbQ+S1rvfbrrcT0CczIHZ2xo26trN6yz6qrSNJBm
         0b3uiS23Fe8pYTg94XkKaq6WKyAz05ftc8N8ghqhk2cc+oNA9c189GIF29mQRGSP/ITq
         RitHSPfO02cm1x3eIcEjlenYSek1vBV1M9GA6pH45jfDQ64/5UgRH2Wgy7oKYpTJXs3A
         UTv4Hs9Ti8yi8D5mrYJ/DipMkr+EqB+u5Hqi5+vFqOEBg6sLVNaFjMezBUwsl2yu1NoC
         xYLvHlVEEUxWo9q0hLJZzNdSWEuNiOLzwiLDbPClVFdnqzvY86i2+B3IHmWHXCz/Mfnt
         SW7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYa1j0OvgiRzhxVK5cEuXLTpwAiiDYqtQMyEC+slbnXqQisZpIZowbLXoQ1z7vtMnCqrFh+2Ms4oH/4m3fvuKLSZ/yq1q8fVc14BiZ
X-Gm-Message-State: AOJu0YzIWdsfF8OlKl896isZqruUyrDdVfUCpVU00PObfXLho92ypKIL
	REersnvMt7A8Z7hEce4HOALTi8UXPsXLc0J+yc6sn6vwG/54GAKHkf22cZSwNCtfZEvSds6JEZw
	Q
X-Google-Smtp-Source: AGHT+IGP5WuztYu6eAOehmTgcCwU3XFCxmv4osL3pF9V/oN2vHxn21J6GhNMYPv+HR2qW2NPzbUEJw==
X-Received: by 2002:a05:6870:f22a:b0:22e:c787:5fa2 with SMTP id t42-20020a056870f22a00b0022ec7875fa2mr12446265oao.58.1714434033950;
        Mon, 29 Apr 2024 16:40:33 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id hp22-20020a0568709a9600b0023b58aa20afsm2144508oab.25.2024.04.29.16.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:40:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-input@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 0/7] regulator: new API for voltage reference supplies
Date: Mon, 29 Apr 2024 18:40:08 -0500
Message-ID: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

In the IIO subsystem, we noticed a pattern in many drivers where we need
to get, enable and get the voltage of a supply that provides a reference
voltage. In these cases, we only need the voltage and not a handle to
the regulator. Another common pattern is for chips to have an internal
reference voltage that is used when an external reference is not
available. There are also a few drivers outside of IIO that do the same.

So we would like to propose a new regulator consumer API to handle these
specific cases to avoid repeating the same boilerplate code in multiple
drivers.

As an example of how these functions are used, I have included a few
patches to consumer drivers. But to avoid a giant patch bomb, I have
omitted the iio/adc and iio/dac patches I have prepared from this
series. I will send those separately but these will add 36 more users
of devm_regulator_get_enable_read_voltage() in addition to the 6 here.
In total, this will eliminate nearly 1000 lines of similar code and will
simplify writing and reviewing new drivers in the future.

---
Changes in v2:
- Reworked regulator patch to remove dev_err_probe() and properly unwind
- Combined two proposed functions into a single function
- Renamed function to devm_regulator_get_enable_read_voltage() everywhere
- Fixed other feedback on consumer patches (see individual patches)
- Picked up Jonathan's Reviewed-bys (hopefully changes were trivial enough)
- Link to v1: https://lore.kernel.org/r/20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com

---
David Lechner (7):
      regulator: devres: add API for reference voltage supplies
      hwmon: (adc128d818) Use devm_regulator_get_enable_read_voltage()
      hwmon: (da9052) Use devm_regulator_get_enable_read_voltage()
      iio: addac: ad74115: Use devm_regulator_get_enable_read_voltage()
      iio: frequency: admv1013: Use devm_regulator_get_enable_read_voltage()
      staging: iio: impedance-analyzer: ad5933: Use devm_regulator_get_enable_read_voltage()
      Input: mpr121: Use devm_regulator_get_enable_read_voltage()

 Documentation/driver-api/driver-model/devres.rst |  1 +
 drivers/hwmon/adc128d818.c                       | 57 +++++++----------------
 drivers/hwmon/da9052-hwmon.c                     | 38 ++++-----------
 drivers/iio/addac/ad74115.c                      | 40 ++++++----------
 drivers/iio/frequency/admv1013.c                 | 40 ++++------------
 drivers/input/keyboard/mpr121_touchkey.c         | 45 ++----------------
 drivers/regulator/devres.c                       | 59 ++++++++++++++++++++++++
 drivers/staging/iio/impedance-analyzer/ad5933.c  | 26 +----------
 include/linux/regulator/consumer.h               |  7 +++
 9 files changed, 124 insertions(+), 189 deletions(-)
---
base-commit: 84c1815e46bdcb8bb0259db3d6cdd934cb70a0e9
change-id: 20240326-regulator-get-enable-get-votlage-5dedf40ff338

