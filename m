Return-Path: <linux-kernel+bounces-4529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F30817EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343AFB23C17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4C15A5;
	Tue, 19 Dec 2023 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFu9mAeE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B232915B1;
	Tue, 19 Dec 2023 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59148c1ad35so2827263eaf.2;
        Mon, 18 Dec 2023 16:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702946535; x=1703551335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=otPd7l+Z7prrbMamvFTywA1HhQfFLfdVkZWrd8gdbx8=;
        b=EFu9mAeEguZ4yoHC79AGKcuGW+haDJre3Rc7D/YDA/XYtOvkg0ZOO7msXr5frgDdmP
         Lic03qX8O+PRcNBZ0LaH2jndqNGjc2hkFJ+2BK14WrqlKeRk7sjvYna49+N1YlhuHGJ4
         p6Rr+SWUZUTXyW5z+sl5o8ImUuovxXtti/55tj30zuFo81t2ypnCpnaDzvB1pu8z+YmA
         Yh42wyXhwdYj380ksAWBGX6j9P5Xx6mOv2joYtZ8lO64xiMUCG0uKnEfgnF6b/Ozzo1h
         Lo5BK7ow4UC6BqFPJPmjP2ygx0F/GxRixt0mue3vApoVtxXIxh+FP0AeAcHAi2mouRZh
         +bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702946535; x=1703551335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otPd7l+Z7prrbMamvFTywA1HhQfFLfdVkZWrd8gdbx8=;
        b=TNujlkBCQEevTe+xD9LnsN3KWIoZ0Dd0ce2YD+UqnujHFLOBv7VitabSsnCbNWnwvQ
         2LJK6nOQLx6wKj4WF3WS2KIARDDllvglolTk4JEfRxqsmzxE+R09KQ95emVsqLOcTeVO
         V/dduywFvKGQq0CsSINXWpZbhqdS0PDNwFP3Idc0rNU+YXAOISIEybE3KjHwnGcQZ8Qt
         Vu3K420Vm0pskKgNyzEKkJvauNjW/l8TMxRWxIipazkEhrrA1u/FRVeiZmJxzTYuGhf0
         5Yw7F3alAIY4rzv5PZizmqcant0Dksam2ncNSeoVJNnRulZOkTbAqX5cyTW9EzWTTjGk
         ZX2A==
X-Gm-Message-State: AOJu0Yyo8rYHbrNZT5kJR6dsEUBnK5rEA/6SKGykmiyEQy23SVYa9y6M
	74G2vvGboWQuGU76DR/F+7kFommNo40=
X-Google-Smtp-Source: AGHT+IEmoQNpvp10pB7v3mWpik1K8gDMdP4krlNDC3HqwEwgvt9d616adVZqb4o0LLfmc0Il8yXXgQ==
X-Received: by 2002:a05:6358:4320:b0:172:f644:647f with SMTP id r32-20020a056358432000b00172f644647fmr102467rwc.53.1702946535379;
        Mon, 18 Dec 2023 16:42:15 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a3f0900b0028ae3b5dde9sm173484pjc.12.2023.12.18.16.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:42:14 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v5 0/5] gpiolib: cdev: relocate debounce_period_us
Date: Tue, 19 Dec 2023 08:41:53 +0800
Message-Id: <20231219004158.12405-1-warthog618@gmail.com>
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

Changes v4 -> v5:
 (all changes are to patch 1)
 - rename line_is_supplemental() to line_has_supinfo().
 - document line_set_debounce_period().

Changes v3 -> v4:
 (changes other than using --histogram are to patch 1)
 - use --histogram to generate patches.
 - include cleanup.h.
 - make supinfo_lock static.
 - immediately return from supinfo_to_lineinfo() if line not found.

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

 drivers/gpio/gpiolib-cdev.c | 402 +++++++++++++++++++++++-------------
 drivers/gpio/gpiolib.c      |   3 -
 drivers/gpio/gpiolib.h      |   5 -
 3 files changed, 256 insertions(+), 154 deletions(-)

--
2.39.2


