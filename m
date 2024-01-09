Return-Path: <linux-kernel+bounces-20929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22FC828785
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464051F257B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4922739853;
	Tue,  9 Jan 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3vbjFF3"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33D39843;
	Tue,  9 Jan 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9344f30caso2073205b3a.1;
        Tue, 09 Jan 2024 06:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704808813; x=1705413613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdNOUjhcUm61EnvzTbmFie9LkXLSVC7UX8qXNfNPVYQ=;
        b=E3vbjFF3LIJsp2H6v5P99Y7nXG6nDkfQHYfufRVVB7nAlOH7l4jz/StGSdgO4kg6pl
         VylL/XVHG8eVCK21sLjBMoPYT64DJwbO7v0KTUjU0AhVci8h1B4snwbyZCy+fK1peNb+
         OQhD3SQXBnGZDwczw8Yui3YSm+U81bJ2odEPP2zYfju7WlC9zU22Dy1J2Vzzbz0w6Vxr
         VxxsRLLE3tTxhxwlhoI8OV+0QIOxo3zNVX1CWGrvaI+DY+Z44NnKqYQMNBRD+knZyLa7
         G8kjIbBNop1WsjKCgjvAFDo7vNOlDwy3TGCgc5IC+utGJJ9hUhDtKsMAV75zSZtul01N
         iqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808813; x=1705413613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdNOUjhcUm61EnvzTbmFie9LkXLSVC7UX8qXNfNPVYQ=;
        b=qWVaiYDRZg7EP6CGNFgMUkB+Y8u8WogVtdzqdaerNJXrQOxhuuks8MR8Re8ThT80AY
         jeDmGdeEh633ZngxwoFgaYR9VvQxHGS2Ro9KN29f8L+7KcBsSI99H+DZR9GXnqMIA8yy
         ldLjHF209a2+x5XY63dJtmSMr4u3pMvr13EzJdY9KswCi9ETem/UB5V1paKF7F9emdo6
         Mc7TnSByFx58UpV1nfzF7Dc4Bdl1p91rrkrMSewqXuq/t/BlGBkHPUxXuj/cHBdBSf8A
         HWc6LK4oYU/e0YhGbywGFduM8l6ZVGkA+sMl7gnQqU7KtG+WlQ9R0E2nOarqU7lZqnad
         +j6g==
X-Gm-Message-State: AOJu0Yy+HJxoo3zrXGhax8TbHUgU4dyIkbcrLbD9Vy7wJYSK7tlK2E3N
	RQPEUqZgmcg5+QwBCrHJMHM9rAd3Yy3mDQ==
X-Google-Smtp-Source: AGHT+IHWFPHuyzlrV9Ll7F3SUYjrYc91iqGY6MboY+X+eSfmsqVWZmpj81pBYAsAXG7j+HDRiyvE3A==
X-Received: by 2002:a05:6a00:2401:b0:6d9:c0a4:67eb with SMTP id z1-20020a056a00240100b006d9c0a467ebmr760230pfh.35.1704808812612;
        Tue, 09 Jan 2024 06:00:12 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d9accac5c4sm1673697pfh.35.2024.01.09.06.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:00:11 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 0/7] Documentation: gpio: add character device userspace API documentation
Date: Tue,  9 Jan 2024 21:59:45 +0800
Message-Id: <20240109135952.77458-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My new year's resolution was to improve the documentation of the
character device API and gpio in general, so here we are.

Wrt the formatting and file breakdown, I've taken inspiration from
the userspace-api/media documentation.

Patch 1 adds documentation for the current chardev uAPI. I've added
it to the userspace-api book, as that is the most obvious place a
reader would look for it, but have also provided links from the
admin-guide book where the gpio docs currently reside.

I realise MAINTAINERS should be updated with
Documentation/userspace-api/gpio/, but the split out of GPIO UAPI
hasn't made it into gpio/for-next yet, so I was unsure of how to
handle that.

Patch 2 relocates the sysfs API doc to stress its deprecation by
moving it to a new deprecated section, again in userspace-api but
with a similar section in the admin-guide. The deprecated section
also provides a placeholder for subsequent changes.

Patch 3 updates the sysfs API doc to reference the chardev
documentation rather than gpio.h.

Patch 4 adds documentation for the deprecated v1 version of the
chardev uAPI.  It is deprecated, but still useful to have, if
nothing else to help identify the differences between v1 and v2.

Patch 5 capitalizes the title of the admin-guide/gpio to match
the other subsystems and the userspace-api book.

Patch 6 adds a deprecation note to the gpio-mockup, as it is
obsoleted by the gpio-sim.

Patch 7 moves the gpio-mockup doc into the deprecated section.

I've got some minor updates for the kernel doc in gpio.h as well,
but they make sense on their own so I'll send those separately
keep the cross-posting to a minimum.

I realise the only thing less exciting than writing documentation
is reviewing it, so my apologies and thanks in advance if you
have the fortitude to attempt such a scintillating endeavour.

Cheers,
Kent.

Kent Gibson (7):
  Documentation: gpio: add chardev userspace API documentation
  Documentation: gpio: move sysfs into a deprecated section
  Documentation: gpio: update sysfs documentation to reference new
    chardev doc
  Documentation: gpio: add chardev v1 userspace API documentation
  Documentation: gpio: capitalize GPIO in index title
  Documentation: gpio: document gpio-mockup as obsoleted by gpio-sim
  Documentation: gpio: move gpio-mockup into deprecated section

 Documentation/admin-guide/gpio/deprecated.rst |  13 ++
 .../admin-guide/gpio/gpio-mockup.rst          |   8 ++
 Documentation/admin-guide/gpio/index.rst      |   6 +-
 Documentation/userspace-api/gpio/chardev.rst  | 114 ++++++++++++++++
 .../userspace-api/gpio/chardev_v1.rst         | 129 ++++++++++++++++++
 .../userspace-api/gpio/deprecated.rst         |  11 ++
 .../userspace-api/gpio/error-codes.rst        |  78 +++++++++++
 .../gpio/gpio-get-chipinfo-ioctl.rst          |  41 ++++++
 .../gpio/gpio-get-lineevent-ioctl.rst         |  76 +++++++++++
 .../gpio/gpio-get-linehandle-ioctl.rst        |  84 ++++++++++++
 .../gpio/gpio-get-lineinfo-ioctl.rst          |  54 ++++++++
 .../gpio/gpio-get-lineinfo-unwatch-ioctl.rst  |  47 +++++++
 .../gpio/gpio-get-lineinfo-watch-ioctl.rst    |  72 ++++++++++
 .../gpio-handle-get-line-values-ioctl.rst     |  56 ++++++++
 .../gpio/gpio-handle-set-config-ioctl.rst     |  60 ++++++++
 .../gpio-handle-set-line-values-ioctl.rst     |  48 +++++++
 .../gpio/gpio-lineevent-data-read.rst         |  84 ++++++++++++
 .../gpio/gpio-lineinfo-changed-read.rst       |  85 ++++++++++++
 .../gpio/gpio-v2-get-line-ioctl.rst           |  99 ++++++++++++++
 .../gpio/gpio-v2-get-lineinfo-ioctl.rst       |  50 +++++++
 .../gpio/gpio-v2-get-lineinfo-watch-ioctl.rst |  67 +++++++++
 .../gpio/gpio-v2-line-event-read.rst          |  83 +++++++++++
 .../gpio/gpio-v2-line-get-values-ioctl.rst    |  51 +++++++
 .../gpio/gpio-v2-line-set-config-ioctl.rst    |  57 ++++++++
 .../gpio/gpio-v2-line-set-values-ioctl.rst    |  47 +++++++
 .../gpio/gpio-v2-lineinfo-changed-read.rst    |  81 +++++++++++
 Documentation/userspace-api/gpio/index.rst    |  18 +++
 .../gpio/sysfs.rst                            |  10 +-
 Documentation/userspace-api/index.rst         |   1 +
 29 files changed, 1621 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/deprecated.rst
 create mode 100644 Documentation/userspace-api/gpio/chardev.rst
 create mode 100644 Documentation/userspace-api/gpio/chardev_v1.rst
 create mode 100644 Documentation/userspace-api/gpio/deprecated.rst
 create mode 100644 Documentation/userspace-api/gpio/error-codes.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-chipinfo-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-watch-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-get-line-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-set-line-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-lineevent-data-read.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-lineinfo-changed-read.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-watch-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-event-read.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-get-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-set-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-lineinfo-changed-read.rst
 create mode 100644 Documentation/userspace-api/gpio/index.rst
 rename Documentation/{admin-guide => userspace-api}/gpio/sysfs.rst (94%)

-- 
2.39.2


