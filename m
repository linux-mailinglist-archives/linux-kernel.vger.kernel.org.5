Return-Path: <linux-kernel+bounces-35393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BF6839050
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFE31F2AA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350815F544;
	Tue, 23 Jan 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0sernFO"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01295EE76;
	Tue, 23 Jan 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017144; cv=none; b=jdBbuVFNa7BOa31vWu9DenGL/yR20o/wbWO/sLGfoQJog68FtISAfX+AtkiRqCARu90J/3l6cUB0z0WU84Hp4T3WiaB0uYxgZlPMB+kF6C40WBtzx0EjdiOoHM4SkIwnZ7417WvaUNyVxHV6xQFwRs1jpvYbIw3EmFdo9Ue4EK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017144; c=relaxed/simple;
	bh=WBSKdUgV5cOeoZ1Fffr465L1E5/Iwt0hZoQjjcYdeug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rR3pTVzwyQbyI1Y+X74YaZNkhmA+ZZyc/y9BMjqvXzBOInXouIap0cQ94866b+ASDCdvaEK4A5GYdPsPX8eG9ehBP3jnPYIQZ/q850usDDFkn5ZuztKkzY/Uc5B1PutgOYs1sTdebzUZ6hlMhg6jvONvpOAQ2Wtlh2usgr+9Hjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0sernFO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d730b6943bso9876915ad.2;
        Tue, 23 Jan 2024 05:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706017142; x=1706621942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGyd1fR1SCxmdaNNcPfqGPYdWi8z44bAjGbNFrHnciI=;
        b=k0sernFO6sgNBeAX4fos6xcL5ztr0A+RoZUi+Wx31zMfUB5z7ZOLAkrvifH3yev5an
         ksRwTgFFdv6fN9n3J1+fq6IdESNbwwgA1aAoHM6dNE7qNVRX/asNkk7OvCQq9N6OS1Or
         rceysNgHaTJcsSI6su3EXJ2qcQAs1h+FcyLQeuw2nVXAvEB+9htAoe9H9QaLPEMEaCvY
         XjUxljKJcTW1MoxVpD25c8UDcwEexUZXkCSTAW1zZr7D9HEbpwgAXeyTvwyQ7pclnAcb
         tfgo0qnlUqxNwyV8ezIdew4r6eGp8rTDptAbXvAOCyv08RMmvjKT25IySseqZH00U0qh
         hqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706017142; x=1706621942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGyd1fR1SCxmdaNNcPfqGPYdWi8z44bAjGbNFrHnciI=;
        b=H0YJBAOmldxIc1p1O+ZRpgpOjOvsH2RPIahWxwV7x7XZfzXtL1aRPbcrBGiEU+PM//
         ZgFFwIsTVtf2XngbORCwrgSK+8WXmmVOj4XjYSN8KWY0mfa2gsviYRCJxAvW2H4vjNLM
         ObBiKq85zPh6Y/fdZNDMYri4sNmjAq5WpGAYROG3k2zPlNwa0UUdHlTIjaVGpFrjMhic
         1yRKtIKFwu51SBu+aaQwvcE5D4DeLzL6O6NGBkz1K6/6b/dyZxVaw2xeVrSCLWOQ0wrj
         GRqO7PKSu6rrmtwn40++tJ/fWnwVmTKrF4hg9NnPzTRFDC/PsHf1WvjSt/xpHY81n+6a
         8kKg==
X-Gm-Message-State: AOJu0Yzt034Wjr4AL2t1zTiiXbS2c9QyHNTKAE2y2WUHog0A0+FaeeS+
	pCd4qBbmjulpQ/jNJ4jyvbE6lUgWroonoVFB2dcS4DIWGQTfreOZFPon/zAT
X-Google-Smtp-Source: AGHT+IFbIkbS5S0VRZCs+BwFDqo+Q2c+9UqIndBlUOgUsYXQM/6F6N4Aolqxmb6zlZ0Y0aipv7ehWw==
X-Received: by 2002:a17:903:48b:b0:1d4:be56:888b with SMTP id jj11-20020a170903048b00b001d4be56888bmr2924349plb.1.1706017141496;
        Tue, 23 Jan 2024 05:39:01 -0800 (PST)
Received: from rigel.home.arpa ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f2d300b001d5f1005096sm8933818plc.55.2024.01.23.05.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 05:39:00 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] Documentation: gpio: describe uAPI behaviour when hardware doesn't support requested config
Date: Tue, 23 Jan 2024 21:38:28 +0800
Message-Id: <20240123133828.141222-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing uAPI documentation does not adequately describe how the kernel
handles the case where the underlying hardware or driver does not support
the requested configuration.

Add a Configuration Support section describing that behaviour to both the
v1 and v2 documentation, and better document the errors returned where the
requested configuration cannot be supported.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---

My bad for this not being part of the recently applied documentation series,
but it didn't occur to me that this wasn't described until about the time
that was being applied.  OTOH this patch is far smaller than a respin of
that series would've been.

I've kept it as a single patch as it is all related, even if it spans v1
and v2.  There is also a trivial typo fix in gpio-handle-set-config-ioctl.rst
that I noticed while I was there that in my eyes didn't warrant a separate
patch.

Cheers,
Kent.

 .../userspace-api/gpio/error-codes.rst        |  3 +-
 .../gpio/gpio-get-lineevent-ioctl.rst         |  6 ++
 .../gpio/gpio-get-linehandle-ioctl.rst        | 39 +++++++++++++
 .../gpio/gpio-handle-set-config-ioctl.rst     |  5 +-
 .../gpio/gpio-v2-get-line-ioctl.rst           | 57 ++++++++++++++++++-
 .../gpio/gpio-v2-line-set-config-ioctl.rst    |  3 +-
 6 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/Documentation/userspace-api/gpio/error-codes.rst b/Documentation/userspace-api/gpio/error-codes.rst
index edf01f2cf9d2..6bf2948990cd 100644
--- a/Documentation/userspace-api/gpio/error-codes.rst
+++ b/Documentation/userspace-api/gpio/error-codes.rst
@@ -65,7 +65,8 @@ GPIO Error Codes
 
     -  - ``ENXIO``
 
-       -  No device corresponding to this device special file exists.
+       -  Typically returned when a feature requiring interrupt support was
+          requested, but the line does not support interrupts.
 
 .. note::
 
diff --git a/Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst b/Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst
index 7d0b932925c6..09a9254f38cf 100644
--- a/Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst
+++ b/Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst
@@ -48,6 +48,12 @@ to its default state.
 
 Requesting a line already in use is an error (**EBUSY**).
 
+Requesting edge detection on a line that does not support interrupts is an
+error (**ENXIO**).
+
+As with the :ref:`line handle<gpio-get-linehandle-config-support>`, the
+bias configuration is best effort.
+
 Closing the ``chip_fd`` has no effect on existing line events.
 
 Configuration Rules
diff --git a/Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst b/Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst
index c8256afe306e..9112a9d31174 100644
--- a/Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst
+++ b/Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst
@@ -76,6 +76,45 @@ If no bias flags are set then the bias configuration is not changed.
 
 Requesting an invalid configuration is an error (**EINVAL**).
 
+
+.. _gpio-get-linehandle-config-support:
+
+Configuration Support
+---------------------
+
+Where the requested configuration is not directly supported by the underlying
+hardware and driver, the kernel applies one of these approaches:
+
+ - reject the request
+ - emulate the feature in software
+ - treat the feature as best effort
+
+The approach applied depends on whether the feature can reasonably be emulated
+in software, and the impact on the hardware and userspace if the feature is not
+supported.
+The approach applied for each feature is as follows:
+
+==============   ===========
+Feature          Approach
+==============   ===========
+Bias             best effort
+Direction        reject
+Drive            emulate
+==============   ===========
+
+Bias is treated as best effort to allow userspace to apply the same
+configuration for platforms that support internal bias as those that require
+external bias.
+Worst case the line floats rather than being biased as expected.
+
+Drive is emulated by switching the line to an input when the line should not
+be driven.
+
+In all cases, the configuration reported by gpio-get-lineinfo-ioctl.rst
+is the requested configuration, not the resulting hardware configuration.
+Userspace cannot determine if a feature is supported in hardware, is
+emulated, or is best effort.
+
 Return Value
 ============
 
diff --git a/Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst b/Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst
index 8f1e748dccc8..d002a84681ac 100644
--- a/Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst
+++ b/Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst
@@ -41,12 +41,13 @@ line or introducing potential glitches.
 
 The configuration applies to all requested lines.
 
-The same :ref:`gpio-get-linehandle-config-rules` that apply when requesting the
+The same :ref:`gpio-get-linehandle-config-rules` and
+:ref:`gpio-get-linehandle-config-support` that apply when requesting the
 lines also apply when updating the line configuration.
 
 The motivating use case for this command is changing direction of
 bi-directional lines between input and output, but it may be used more
-generally move lines seamlessly from one configuration state to another.
+generally to move lines seamlessly from one configuration state to another.
 
 To only change the value of output lines, use
 gpio-handle-set-line-values-ioctl.rst.
diff --git a/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst b/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
index d76e614c8343..56b975801b6a 100644
--- a/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
+++ b/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
@@ -74,7 +74,8 @@ If no bias flags are set then the bias configuration is not changed.
 
 The edge flags, ``GPIO_V2_LINE_FLAG_EDGE_xxx``, require
 ``GPIO_V2_LINE_FLAG_INPUT`` to be set and may be combined to detect both rising
-and falling edges.
+and falling edges.  Requesting edge detection from a line that does not support
+it is an error (**ENXIO**).
 
 Only one event clock flag, ``GPIO_V2_LINE_FLAG_EVENT_CLOCK_xxx``, may be set.
 If none are set then the event clock defaults to ``CLOCK_MONOTONIC``.
@@ -86,11 +87,61 @@ The :c:type:`debounce_period_us<gpio_v2_line_attribute>` attribute may only
 be applied to lines with ``GPIO_V2_LINE_FLAG_INPUT`` set. When set, debounce
 applies to both the values returned by gpio-v2-line-get-values-ioctl.rst and
 the edges returned by gpio-v2-line-event-read.rst.  If not
-supported directly by hardware, the debouncing is performed in software by the
-kernel.
+supported directly by hardware, debouncing is emulated in software by the
+kernel.  Requesting debounce on a line that supports neither debounce in
+hardware nor interrupts, as required for software emulation, is an error
+(**ENXIO**).
 
 Requesting an invalid configuration is an error (**EINVAL**).
 
+.. _gpio-v2-get-line-config-support:
+
+Configuration Support
+---------------------
+
+Where the requested configuration is not directly supported by the underlying
+hardware and driver, the kernel applies one of these approaches:
+
+ - reject the request
+ - emulate the feature in software
+ - treat the feature as best effort
+
+The approach applied depends on whether the feature can reasonably be emulated
+in software, and the impact on the hardware and userspace if the feature is not
+supported.
+The approach applied for each feature is as follows:
+
+==============   ===========
+Feature          Approach
+==============   ===========
+Bias             best effort
+Debounce         emulate
+Direction        reject
+Drive            emulate
+Edge Detection   reject
+==============   ===========
+
+Bias is treated as best effort to allow userspace to apply the same
+configuration for platforms that support internal bias as those that require
+external bias.
+Worst case the line floats rather than being biased as expected.
+
+Debounce is emulated by applying a filter to hardware interrupts on the line.
+An edge event is generated after an edge is detected and the line remains
+stable for the debounce period.
+The event timestamp corresponds to the end of the debounce period.
+
+Drive is emulated by switching the line to an input when the line should not
+be actively driven.
+
+Edge detection requires interrupt support, and is rejected if that is not
+supported. Emulation by polling can still be performed from userspace.
+
+In all cases, the configuration reported by gpio-v2-get-lineinfo-ioctl.rst
+is the requested configuration, not the resulting hardware configuration.
+Userspace cannot determine if a feature is supported in hardware, is
+emulated, or is best effort.
+
 Return Value
 ============
 
diff --git a/Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst b/Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst
index 126c2626ba6b..9b942a8a53ca 100644
--- a/Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst
+++ b/Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst
@@ -37,7 +37,8 @@ line or introducing potential glitches.
 
 The new configuration must specify the configuration of all requested lines.
 
-The same :ref:`gpio-v2-get-line-config-rules` that apply when requesting the lines
+The same :ref:`gpio-v2-get-line-config-rules` and
+:ref:`gpio-v2-get-line-config-support` that apply when requesting the lines
 also apply when updating the line configuration.
 
 The motivating use case for this command is changing direction of
-- 
2.39.2


