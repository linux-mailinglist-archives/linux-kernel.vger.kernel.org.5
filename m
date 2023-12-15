Return-Path: <linux-kernel+bounces-364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A825814010
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3251F22CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E792D110C;
	Fri, 15 Dec 2023 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHImCsV6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2A1C16;
	Fri, 15 Dec 2023 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6cebbf51742so113413b3a.1;
        Thu, 14 Dec 2023 18:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702607909; x=1703212709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4CZ/cRhlCWB3eQZmrv5D9nr6zmIGzao1x0U408OV93s=;
        b=aHImCsV6xopsyHH4kXTdOxKiY3RX/nG86YKrJ4BJqGpL2YMZM7edx1cMMdfj9VJvQi
         oFM10czIoRH+f32e1dDUKHw1HgVx9I30oZhBpeki1YfBD9vFjqJg+b3wf2bqzWyevus8
         VIRi379NnxeluiqM3bsIzf8e4dbik68bG+yQdm4cS/bP5iZ2BuK0NcVNDJakRvnWEyen
         iTmPLeMXsnj3h7jECQyd9323NNl7P/i6l775H1u3sGRv0KkKZAmWZul0dDAP1x+ffRqg
         AYI10qS565xzOwVjCr0kk8PEpga6xnrl5WEci17R+QUcMjOIPWrcSKKNPAlIyE32xtuj
         UZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607909; x=1703212709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CZ/cRhlCWB3eQZmrv5D9nr6zmIGzao1x0U408OV93s=;
        b=HRSFtlt/CgeG8ukuAUXJ2kCInBAtRi/HNg5xa/k9sRkhgEcbHuMIy5pY56naxeKV5G
         GiSZ4ds0PUCf0mKw2B6TVofwtOr/3+Hq3fAiBtkiLYigo/MWI5Hbe4kofobSw66uGLj6
         67iRLzxiYj5ZTax3JWzX/8u5Sd+kHqXMLQXfsOn7C5bbVI8QcmHuPno0DheTNmCvPpuq
         1d4lb5o50+r7aaHJQZrfD2bOLCTm+OHRhFed1zCavIREc0r6KJ/6PInsLSsp17k22mNq
         VklCVUum03s911SZFBQ8+Dh7tnyNuJ76RU9QsUIR9zdA15XNIELqldF1J2u1OoMQk7tl
         mj7A==
X-Gm-Message-State: AOJu0YxYXWDGMsx3sS2hwiMfhZn4QOIUYVyNJThwT8QxzGz6YNQ5wy8A
	F5COlFOysaepeJO0zaFQORILNYlt3ds=
X-Google-Smtp-Source: AGHT+IGdwjacbv0ghNcPKWzEfqd/cIDDEcvGUK1FF3yil/iKVjycoNxJvgHh1MibykRy5JWDS9tVFg==
X-Received: by 2002:a05:6a00:3097:b0:6d0:d43f:1907 with SMTP id bh23-20020a056a00309700b006d0d43f1907mr3476678pfb.21.1702607908765;
        Thu, 14 Dec 2023 18:38:28 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id fk16-20020a056a003a9000b006d26920a11dsm1437987pfb.0.2023.12.14.18.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:38:28 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 0/5] gpiolib: cdev: relocate debounce_period_us
Date: Fri, 15 Dec 2023 10:38:00 +0800
Message-Id: <20231215023805.63289-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains minor improvements to gpiolib-cdev.

The banner change is relocating the debounce_period_us from gpiolib's
struct gpio_desc to cdev's struct line.  Patch 1 stores the field
locally in cdev.  Patch 2 removes the now unused field from gpiolib.

Patch 3 is somewhat related and removes a FIXME from
gpio_desc_to_lineinfo().  The FIXME relates to a race condition in
the calculation of the used flag, but I would assert that from
the userspace perspective the read operation itself is inherently racy.
The line being reported as unused in the info provides no guarantee -
it just an indicator that requesting the line is likely to succeed -
assuming the line is not otherwise requested in the meantime.
Given the overall operation is racy, trying to stamp out an unlikely
race within the operation is pointless. Accept it as a possibility
that has negligible side-effects and reduce the number of locks held
simultaneously and the duration that the gpio_lock is held.

Patches 1 and 3 introduce usage of guard() and scoped_guard() to cdev.
Patch 4 replaces any remaining discrete lock/unlock calls around
critical sections with guard() or scoped_guard().

Patch 5 is unrelated to debounce or info, but addresses Andy's
recent lamentation that the linereq get/set values functions are
confusing and under documented.
Figured I may as well add that while I was in there.

Changes v2 -> v3:
 - reorder patches to move full adoption of guard()/scoped_guard() to
   patch 4.
 - use guard() rather than scoped_guard() where the scope extends to the
   end of the function.
 - split supinfo into supinfo_tree and supinfo_lock (patch 1).
 - rename flags to dflags in gpio_desc_to_lineinfo() (patch 3).

Changes v1 -> v2:
 (changes are to patch 2 unless otherwise noted)
 - adopt scoped_guard() for critical sections, inserting patch 1 and
   updating patch 2 and 4.
 - move rb_node field to beginning of struct line.
 - merge struct supinfo into supinfo var declaration.
 - move rb_tree field to beginning of struct supinfo.
 - replace pr_warn() with WARN().
 - drop explicit int to bool conversion in line_is_supplemental().
 - use continue to bypass cleanup in linereq_free().
 - fix typo in commit message (patch 4)

Kent Gibson (5):
  gpiolib: cdev: relocate debounce_period_us from struct gpio_desc
  gpiolib: remove debounce_period_us from struct gpio_desc
  gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
  gpiolib: cdev: fully adopt guard() and scoped_guard()
  gpiolib: cdev: improve documentation of get/set values

 drivers/gpio/gpiolib-cdev.c | 393 ++++++++++++++++++++++--------------
 drivers/gpio/gpiolib.c      |   3 -
 drivers/gpio/gpiolib.h      |   5 -
 3 files changed, 246 insertions(+), 155 deletions(-)

--
2.39.2


