Return-Path: <linux-kernel+bounces-153453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF91C8ACE49
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7051F220E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44676150994;
	Mon, 22 Apr 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="budmtEfK"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F9282E2;
	Mon, 22 Apr 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792745; cv=none; b=RAyjbomiHsTNumarnj5U4h6HzKQqAKrXhMpYUokozst7uD7sk3dgjhbb3d5TRh+K3zZxrHKou8zZ50VZ6JUQKgqudYBgtQlx9CSATQpyvb0hahe3uzuxUXtvLwtshg/o8ckvxIDNztxqjjizClZP7aTrOx+67ykHkY8uYQ9SiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792745; c=relaxed/simple;
	bh=TD0Nr7R0rbKpnTkC7WxSdse7cjReHTcsGWkAiAMmT7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HC5ee5jfZwQgusi5rljZ75q62UgVyLJCuurdG/UXgPkCRfZEfbTls+r9BA78Lh2iHuncx3CA7MHhV/bd/OWBSDIsPWUZC2z5X7di42pgcYF69+h9xucsyBrqLplpjOyEZ0K0MKg5MavH5LSOOI40MZC/FcpFQXqDXEKsUOaVHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=budmtEfK; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51967f75729so5034791e87.0;
        Mon, 22 Apr 2024 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713792742; x=1714397542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GP4sJ74Pr9f8yHIahiytzgErpIywlsdSu7yAa7u/Jhg=;
        b=budmtEfK0ywuOk4qGHS+Px51/AWFU6h/PvPJLrNeGKyZA0XN1pfe7BfcwAkY5RKInA
         GWMQUj0pXFxh5f/C0UsPs8zTCq1Ns/JAoUbwwWsbkykb8liXfpcCqHbw+da2/huZSxA2
         2XSgKwYL3i917Z+/wBPN2RWl+PJ/81xYTedFOh+XruZuX/doPSEKV8hSGvPYTg3cLe8B
         wLHdTcq4pKa4jtKLrZWTLqjiv6GsADtHrXk/jYhe9dHKoDRWcRxPiwjHfHJm6I4aFrKk
         rd/9VG1FUqO2zf7F95X+mbdUGwwTKcvZEnhOr/zqYSTJJFmRt5SLm73/kjZJ1tOMJKl5
         hvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792742; x=1714397542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GP4sJ74Pr9f8yHIahiytzgErpIywlsdSu7yAa7u/Jhg=;
        b=FSuthQpNFLF5rwc2crd/Q4GsDUeXWQ/CUMTJ+42OV/zf5HRCApJ0ScgHTX2yNfobpi
         qk8x+wTD1dgbt4XiYAaPcF5ar/4+jgaVaUXCz4UT+8Akt8maI+BCvslm81L+jDRgbi+J
         DgnRjZ6dgdf4dlE1tRUip8VYZGDldqT/wubcIqcf3le78iGalBYI9ttl9nHU1vJ3HjNb
         /RGQb/4VjF7TSOLewV8MLVvc1BrQj2zm5I7UjKpRtJl5N1XnZVqHx3+z/vb6iAqPBHV7
         SDVFQpo+7zOPgVnBXUkJUDCWhN6EbGN7vZBpCuIbBKYqxDkOgfZ7OQSq5UJOMg26w6b+
         elYg==
X-Forwarded-Encrypted: i=1; AJvYcCVDvch7CPfdEiB2uIDvlHUpvZ4ILO8gEjNstTNhyfq1EVqt5xVmXI+XlFoYJQpqBGAdGOa7TDw1ojnyOSD9Ne7RQJ9gmBY4VwYddxzQcoAdwl669KOtwt/AGlJ/4Q017+AMSCiFSGaMnoCj
X-Gm-Message-State: AOJu0YxIHE3QpW9s/94qXhBlEfZ1SVz7BX8BiqUBtTvSLDk3vessh6b3
	6EJ/wkejoN+mHIqzMyA71+uIgksgi2SA2mPDo920diQ9ntwrFRXa
X-Google-Smtp-Source: AGHT+IE7u7y6CGwPjcSkWjSR/F+mMG951zmw9TyKaxfgzFzz0SBlq5cmhp/BRuOVynZnPYI0axZEwg==
X-Received: by 2002:ac2:5963:0:b0:518:ddc3:b3a2 with SMTP id h3-20020ac25963000000b00518ddc3b3a2mr5383160lfp.28.1713792741850;
        Mon, 22 Apr 2024 06:32:21 -0700 (PDT)
Received: from CVSIT-Server.. ([193.232.173.109])
        by smtp.gmail.com with ESMTPSA id d22-20020ac241d6000000b0051327d2f5e5sm1729568lfi.119.2024.04.22.06.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:32:21 -0700 (PDT)
From: Konstantin Pugin <ria.freelander@gmail.com>
To: 
Cc: krzk@kernel.org,
	conor@kernel.org,
	lkp@intel.com,
	vz@mleia.com,
	robh@kernel.org,
	jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com,
	corbet@lwn.net,
	ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v7 0/3] add support for EXAR XR20M1172 UART
Date: Mon, 22 Apr 2024 16:32:12 +0300
Message-Id: <20240422133219.2710061-1-ria.freelander@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
it has additional register which can change UART multiplier
to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
flag to guard access to its specific DLD register. It seems than
other EXAR SPI UART modules also have this register, but I tested
only XR20M1172.
Yes, in datasheet this register is called "DLD - Divisor Fractional"
or "DLD - Divisor Fractional Register", calling depends on datasheet
version.

I am sorry about too many submissions and top post reply. About second -
I do not know how to reply properly to this ML from GMail phone app. About first - I just
get very good feedback from Andy Shevchenko, and want to fix his review picks ASAP.

Changes in v2:
  - use full name in git authorship

Changes in v3:
  - change formatting of commit messages to unify width
  - rework commit messages according to code review
  - add XR20M117X namespace for EXAR-specific register
  - do not use UPF_MAGIC_MULTIPLIER for checking EXAR chip,
    use s->devtype directly
  - replace while loop to fls function and expanded check
  - sort compatibles
  - reformat multiline comment.

Changes in v4:
  - rebase onto tty-next branch
  - added Kconfig mention of the chip
  - used rounddown_power_of_two instead of fls and manual shift
  - used FIELD_PREP instead of custom macro
  - removed has_dld bit from common struct, replaced by check function,
    which checks directly by s->devtype
  - fixed tab count
  - properly apply Vladimir Zapolskiy's tag to patch 2 only

Changes in v5:
  - fixes for tty-next branch
  - address a new code review picks
  - send properly to all participants
  - added Ack tag

Changes in v6:
  - KConfig fixes
  - New code review fixes

Changes in v7:
  - Added missed tag
  - Added missed v5 fixes

Konstantin Pugin (3):
  serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
  dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
  serial: sc16is7xx: add support for EXAR XR20M1172 UART

 .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
 drivers/tty/serial/Kconfig                    |  3 +-
 drivers/tty/serial/sc16is7xx.c                | 63 +++++++++++++++++--
 drivers/tty/serial/sc16is7xx.h                |  1 +
 drivers/tty/serial/sc16is7xx_i2c.c            |  1 +
 drivers/tty/serial/sc16is7xx_spi.c            |  1 +
 6 files changed, 64 insertions(+), 6 deletions(-)


base-commit: f70f95b485d78838ad28dbec804b986d11ad7bb0
-- 
2.34.1


