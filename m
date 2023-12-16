Return-Path: <linux-kernel+bounces-1859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18E8154E4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2BFAB22918
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F1437B;
	Sat, 16 Dec 2023 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCTlkieo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22B7E;
	Sat, 16 Dec 2023 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2031b9c8389so813565fac.1;
        Fri, 15 Dec 2023 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702685825; x=1703290625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=flXnXhNzYj5bQT+Vtb1f16zrrFTB81Pqcpw5aYSnuoc=;
        b=hCTlkieoc41uSpFVZzNEWmhZJRYuAqCSBdTRw8o6kboINv/58KGL00vcdQIS7GWwvV
         zc4buU6WQcY64r6wEVfahQl6BLhjn6j9O40e6/JmoTd/anRjHtMfMH0yrri/4WcK179N
         ykMNS/WFo1lQjYsSfGUwHcSzQlaCIpSBiUUzd+NriWo28m63Sg22mMKqwVqNlFBn6Z2x
         EkHJIMQy3nQlv+QUf4HpE41wKM2msNiPiymt7WhBvXI4N5IzZoV165/c83iEP7Cfnw0v
         1RrtrWE/80irVg1kdHkJSY8NiYiG/tmEl3AosROpfT/eYr1KYmomtZzcPep0srJtdUlY
         WsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685825; x=1703290625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flXnXhNzYj5bQT+Vtb1f16zrrFTB81Pqcpw5aYSnuoc=;
        b=eJzfJqjPEknwtIpcAtcw0M2QQ65SioSo1oTcupJkuf5rr9qMWufvdRoGQTA0L2xCtG
         O11jxPig28EHtBRUT43kRo/md2kf710rHsDdwXA0MFQix/R/UJDJRvZhZJnhj/f1vUzR
         m1bIIP7cA/qIRy/lqp+rDv2FZn6UHhH3nXBpJ6KYy/QZmMjwTQvg24iNsyaCfEvkzuNO
         rd5wIlrdzpApw1Yee2WnfjOYESk3kgUsAolLtMiY0q8Cig07dykRu0jXiDBAlGQ2zSin
         BA59MgmtrbV9QfwByzB9KMpUQ79OburxlIFGlLMvolkOf8yFQkW23KANeNFftNzC3WjW
         z8Fw==
X-Gm-Message-State: AOJu0YyHCXC6jlFuEQNYtq1spwF4LUTdKz7ZOlDk6SG1AGdlEUohOHwV
	E1IKhn94EhNM1CniIOGeX8BvCXz3j4E=
X-Google-Smtp-Source: AGHT+IFiH2Va1bq91PF0SJLnOe7zL/EkoQ+GjsOM0C/r0rgtv9ubuSWnaxVAATbtLd8T6CE7qdoUIw==
X-Received: by 2002:a05:6870:8926:b0:203:521f:7611 with SMTP id i38-20020a056870892600b00203521f7611mr3944369oao.4.1702685824405;
        Fri, 15 Dec 2023 16:17:04 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id ei39-20020a056a0080e700b006cbef269712sm14176124pfb.9.2023.12.15.16.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:17:04 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v4 0/5] gpiolib: cdev: relocate debounce_period_us
Date: Sat, 16 Dec 2023 08:16:47 +0800
Message-Id: <20231216001652.56276-1-warthog618@gmail.com>
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

 drivers/gpio/gpiolib-cdev.c | 391 +++++++++++++++++++++++-------------
 drivers/gpio/gpiolib.c      |   3 -
 drivers/gpio/gpiolib.h      |   5 -
 3 files changed, 246 insertions(+), 153 deletions(-)

--
2.39.2


