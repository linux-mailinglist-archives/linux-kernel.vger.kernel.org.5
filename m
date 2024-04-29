Return-Path: <linux-kernel+bounces-162866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8028B617D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A12C1F2194E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD6913AA5A;
	Mon, 29 Apr 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7A08LjD"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B483CB9;
	Mon, 29 Apr 2024 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417259; cv=none; b=cA9eWjEWomFeFS+0vnahN7FJthjHgfoiw8unCda2WqHwnuWjwwFMe1qD3yuYU9oHYbT3WYMzLoUSw2EB2aN2tFNWUPm1hWk1hgglLCAaA++hoNrZHYYnVY0W1rEIPZj75rGOLJfB1hg/ojIaEqflrno3KKqlZL7EqZxihWHuN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417259; c=relaxed/simple;
	bh=b3FEKNpSxrDy3PsVqhCvok3w3MolMf3qd9XnmZG+cjo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z/yNyy06AP8tWCmTrxBFt9RJDbF2aLTOwqCIsF7E6EVs9VMSRNed2Ek8MeXVy/rFj3wb0qErsLJQfA1X1K2Tp9oFIzoyVMxKr1n5H+rZLlij0yU6SK/8wHt4jAyFl/JfYPNy18A488uw83Oq0Z7cJlVylilpm5lw9DQkOd/kC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7A08LjD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-346b96f1483so2661314f8f.1;
        Mon, 29 Apr 2024 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417256; x=1715022056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0l7nILLeNSy6uxHN63IE1AMr92VIAYzazM0xywn6oM=;
        b=E7A08LjDnRPmUgGzbe6jGK90VZ/V98KhQgjHVSqa6MHJ7Kuix63ZEFojb1cZ4D7+tZ
         Iv5tx9xAWXGCzLC1g7H8x9GPYDJtVIeagAuvuc9ruQLViGwWwxETmBNT2QZFngqjejwH
         Vv60C0hK8Gc9TJHd1H8cy771/h65tbc4W74izpeq5jCrBZTkZ5dDviMEcX9wkXhL3LdV
         em0SDeb5a5DV2Qsv3W5VFQtGvtz8Rv1OG+wem2DeVkoD2GhR75H+W9TfJ9zp7rnNiLi4
         fiWzJw9zmAAJKFL5MbZO5QpH+zeu55BLDAB+a+m1hIAYD/9s3VZTW2zrhpHyXHojY1xd
         AogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417256; x=1715022056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0l7nILLeNSy6uxHN63IE1AMr92VIAYzazM0xywn6oM=;
        b=gtle+Tqoi3nsV8R/t/Y8t0W8DrVpFG8ijmRi3FNII1uiWm4r9r5JmMWCK6kIAxHjFe
         lK7JXiihEm47fCUwg1UIag2a0zT2IBrSZjnFH6fpA89G6+9iVtr92oDClAe+nu/q7oPN
         hOSqyWy6ZQ8yoedxf5RiEc+n19qNSYIXEtiDEyX9wAgGTEglZd1DY//PN63tnVKlXpQj
         WOepBQJeu2GxBjEbs2Z/uXv92rzsS7mo9aqVAPzGhKdL19Nti6zJbk+YCI7PLp1b2Ojj
         cqiEh3r3aPrMlXwsLPW5mb1jbHmkXaKRGseNa+qpJmc3IRmMSkvm3juV1LEBTXVdbT3+
         Imlw==
X-Forwarded-Encrypted: i=1; AJvYcCUQVNwnOnR+iTNz+mZm74uIyVea7Rjex/8xspQ328QJ3vD6R3i09U55IY+6Ixdrt8DWkhozyiQrDOQTONoVR1vDdNNQ/X7crQjE4AqdXMxAXKyWR9+6iIq/SmGQItjsi7ia1vDeSi6m
X-Gm-Message-State: AOJu0YzPjxSu/Lq8tQHBpx8l6EkmIz0P0MH992yXfPgDmI4tRjvWWxw3
	tkHvpMBfs5VIOpnpq18KYpqmx1uXwZQAQNukqHTEfAMREk9Lmc1C
X-Google-Smtp-Source: AGHT+IHImwUjJVhBfu3QnebGI6VAwwkrwUufQXk9SLZdP6i1YmeV24NiC1KL6qcNFwBm67Ye7Wh30Q==
X-Received: by 2002:a5d:6d01:0:b0:34d:750b:aa09 with SMTP id e1-20020a5d6d01000000b0034d750baa09mr66383wrq.1.1714417256117;
        Mon, 29 Apr 2024 12:00:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:abbf:c98a:cf84:d14c])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0034c78bba70bsm8469456wrl.72.2024.04.29.12.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:00:55 -0700 (PDT)
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
Subject: [PATCH v5 00/10] iio: pressure: bmp280: Driver cleanup and add triggered buffer support
Date: Mon, 29 Apr 2024 21:00:36 +0200
Message-Id: <20240429190046.24252-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on next-20240429.

Changes in v5:

Patch [1-5/10]: *new*:
	- Splitted various driver cleanups that were gathered in Patch [1/6] of
	  previous version.

Patch [7/10]:
	- Patch [3/6] of v4
	- Removed extra dead code due to guard(mutex)

Patch [10/10]:
	- Patch [6/6] of v4
	- Fixed comment alignment
	- Fixed struct alignment in order to have timestamp properly aligned.


[v4]: https://lore.kernel.org/linux-iio/20240407172920.264282-1-vassilisamir@gmail.com/
[v3]: https://lore.kernel.org/linux-iio/20240319002925.2121016-1-vassilisamir@gmail.com/
[v2]: https://lore.kernel.org/linux-iio/20240313174007.1934983-1-vassilisamir@gmail.com/
[v1]: https://lore.kernel.org/linux-iio/20240303165300.468011-1-vassilisamir@gmail.com/

Vasileios Amoiridis (10):
  iio: pressure: bmp280: Improve indentation and line wrapping
  iio: pressure: bmp280: Use BME prefix for BME280 specifics
  iio: pressure: bmp280: Add identifier names in function definitions
  iio: pressure: bmp280: Add more intuitive name for bmp180_measure()
  iio: pressure: bmp280: Make return values consistent
  iio: pressure: bmp280: Refactorize reading functions
  iio: pressure: bmp280: Introduce new cleanup routines
  iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
  iio: pressure: bmp280: Add SCALE, RAW values in channels and
    refactorize them
  iio: pressure: bmp280: Add triggered buffer support

 drivers/iio/pressure/Kconfig         |    2 +
 drivers/iio/pressure/bmp280-core.c   | 1336 ++++++++++++++++++--------
 drivers/iio/pressure/bmp280-regmap.c |    8 +-
 drivers/iio/pressure/bmp280-spi.c    |   12 +-
 drivers/iio/pressure/bmp280.h        |   87 +-
 5 files changed, 978 insertions(+), 467 deletions(-)


base-commit: b0a2c79c6f3590b74742cbbc76687014d47972d8
-- 
2.25.1


