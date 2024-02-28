Return-Path: <linux-kernel+bounces-85011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA286AF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294B71C22579
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B22F3BBED;
	Wed, 28 Feb 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ43tQhY"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200C62560F;
	Wed, 28 Feb 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123211; cv=none; b=GsuMyZMnTYFY1dxb/i4JzHpTV2ZfhtCz4pRRHiyu6d7qQArK6UKRGjDX/opfiaEPjym/s27NM6HVKLyFAX2QtWErYKisoviaRfVfam80cmU06YcJ8USecnDZ/5kzUyPw5x55GUFfRKtiBZJwfhAe+oN7pozYxLX4cXu1fVBRt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123211; c=relaxed/simple;
	bh=3IjWu3Yep1Fc37oVIZxv5/O//hB4sEq92h1HmZ62hXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qpCZr8KjOEOWhaT7/1ptwmfv/8SiPuVGy59cWNphBpcjY9E/mnAvmwnhI5vj2jYJy/uBTooneAgreFDSH+1qwaM7TETtRacS/Xtw0pGSduYVMAxej1HIONnLU4sT+tZJtywGYcFo+izxnyzcGPLPFuIyZjW2nBiMH6/33O+SQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ43tQhY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a441882f276so32530866b.2;
        Wed, 28 Feb 2024 04:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709123208; x=1709728008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUAUFRo6Db/I179VDysZN3yGTARRx3lO0nGFpMCQGh8=;
        b=OJ43tQhYfOIgVrGeSeDuLLpcYRO301XtEXBz8HPYrdgWyLCD+2xKDRc5oWuCTXaVRQ
         B1dibNfK/tZTcUoRyvM8yORvhDraRlhtsa61eMK4KxJpl2IhadOW/KCoOlBnHLEnpEPD
         WYcWLvQTEfI7fuH1xz8qambQGva0rm1n/CLPZnNhv6fyqOm1eIsucIq9lgcImUlkKgsV
         4oZ1OR5qG6fEqn6aFMxa6m+/ogtCL4OtHDuo17uyjVX++fATaWzg/4vy1o/pd73H6UPi
         a+HbioPqmbo1SX4Ga/hI/LCGaclqS9h612epvsa1Dv/9TtAdoKnNQzWQfFEQdiIWBU8G
         FxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123208; x=1709728008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUAUFRo6Db/I179VDysZN3yGTARRx3lO0nGFpMCQGh8=;
        b=u5+zDQchcgCuc6L23ZeAMTryMzoQcBOsoIzuBLfk940szNkN5FRkY+DO1Uxi81k8B9
         uNCfsg9Z/yHJnnRU00zO4n0qQvs8ANIYVeH0LDuTs6HS7QHZU/Q2vFGunIYG3sECZIZv
         BSja8LMWNN5jtYzSI6HfPGURL8wbGtBe2AFmIjNh/b/MZRar1Q97TqvnCadHWBeTzKUp
         W9LjIyrVll9agDpVlE0WV6amzos+mX5O6wXyWkw7nXrkHTsI3huMxQp0itJrWrXj4yKI
         RIIqV63a6ole9s1DsToesIV7yglkrWvZkgBp1C4dmYTMY5OlzDNr75OJuYUt8HGg/wXH
         LHEg==
X-Forwarded-Encrypted: i=1; AJvYcCUVTLdEwUD4YUh2hifOn021NOGvUGhxKxM5TB6lMV3dG330yEmeqa55zwC8IWZJj87xNHjh55GjWTkduwvTVlt77dOmpR6WwiQGB23gPCcH819efsq5RXS9DM/O7snVjFJDObknKSYVAlr8R5ceBnFcO7RRD4xSdcyfzpjHPqF4pHRTgg==
X-Gm-Message-State: AOJu0YzbQgDVM8fhOYyX96sQKynje+9s8RhBnOS6YAhYIviIGzREi//O
	+vbBUSib3AYlmaKJwPntJdrNeBW2Jj+oZyyX2WFlW92z2KbpQ7uv
X-Google-Smtp-Source: AGHT+IEYkg42StgdNbl6kvxcA5erZ9pA2GDw9h5tyDk0+ULWZFy6mmrpv6fwJ4lFWwm/+PJ1XaNoag==
X-Received: by 2002:a17:906:d042:b0:a3f:86ca:ed2f with SMTP id bo2-20020a170906d04200b00a3f86caed2fmr9123966ejb.49.1709123208300;
        Wed, 28 Feb 2024 04:26:48 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906c08300b00a3d1c0a3d5dsm1800417ejz.63.2024.02.28.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:26:47 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com,
	alisa.roman@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v4 0/4] iio: adc: ad7192: Add support for AD7194
Date: Wed, 28 Feb 2024 14:26:13 +0200
Message-Id: <20240228122617.185814-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: romandariana <alisa.roman@analog.com>

Dear maintainers,

Thank you all for the feedback!

I am submitting the upgraded series of patches for the ad7192 driver.

Please consider applying in order.

Thank you!

v3 -> v4
        - drop device properties patch, changes already applied to tree
        - change bindings and driver such that for AD7194 there are 16
        differential channels, by default set to AINx - AINCOM, which can be
        configured in devicetree however the user likes
        - corrected mistake regarding positive and negative channel macros:
        subtract 1 from the number corresponding to AIN input

v2 -> v3
	- add precursor patch to simply functions to only pass
	  ad7192_state
	- add patch to replace custom attribute
	- bindings patch: correct use of allOf and some minor changes to
	  the ad7194 example
	- add ad7194 patch:
		- use "ad7192 and similar"
		- ad7194 no longer needs attribute group
		- use callback function in chip_info to parse channels
		- move struct ad7192_chip_info
		- change position of parse functions
	- drop clock bindings patch

v1 -> v2
	- new commit with missing documentation for properties
	- add constraint for channels in binding
	- correct pattern for channels
	- correct commit message by adding "()" to functions
	- use in_range
	- use preferred structure in Kconfig

Kind regards,

Alisa-Dariana Roman (4):
  iio: adc: ad7192: Pass state directly
  iio: adc: ad7192: Use standard attribute
  dt-bindings: iio: adc: ad7192: Add AD7194 support
  iio: adc: ad7192: Add AD7194 support

 .../bindings/iio/adc/adi,ad7192.yaml          |  75 ++++++
 drivers/iio/adc/Kconfig                       |  11 +-
 drivers/iio/adc/ad7192.c                      | 218 ++++++++++++++----
 3 files changed, 250 insertions(+), 54 deletions(-)

-- 
2.34.1


