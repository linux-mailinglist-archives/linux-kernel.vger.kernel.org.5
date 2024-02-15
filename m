Return-Path: <linux-kernel+bounces-67385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D25D856AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47ED928B8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CA13667D;
	Thu, 15 Feb 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWANoxYD"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1513399E;
	Thu, 15 Feb 2024 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017475; cv=none; b=uFJwldy4fYPQMvMiZAgdV+SNLd3SylGcKzWB+SPJ5/fNCUgnMRPs/ZvFJmxplX2/QRh7IH+RHVNwSgLR1ncy5ew3jf02vVx+lbMcfTNDOuNM6W9wKoDNCmteBNg+fSdBXrLjxDE4ZF5GYEegkL1KQlZhAzUwvUBwiI8NUNk6HnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017475; c=relaxed/simple;
	bh=tfaViPks8NnM283/X+IeiZHNZJ7mRUXnXQTI9qhFnNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t4Izb1BCIRI+vzw8a/VV+TJ31eVG2QRD+L076X8lthc6iwPd604bT4cOHEpwaKecvNoBOsXCZqIvcoX9kXD0JS/sA0ZJXxSdaXAsXY41CTfGPRVu4VztJPfiM7WP9L87NIgzZ9FP+8/Hof1S0D4hN2tdE8Tz0rviIXpQnaT2f0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWANoxYD; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511a4a1c497so1245138e87.3;
        Thu, 15 Feb 2024 09:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708017471; x=1708622271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H34U5Vbhdh0VVX7V6tBXcBBMhZVVWdzHO2tS/G9vxsA=;
        b=aWANoxYDdxSHqOZ4/dmVvI+NsM8jhc8P8oGIIawFFnH6+mIBZ2UIypvbdJr2vnedBJ
         OGsYDrOd44IUBoxLQa3jXEHpahtMx4sbBCmqHLR8hmf47QmLVRgwsTUHumEo9QqxeYKv
         fVu5zEo/u9jsRsubL5CtWdaljD1Y0IEnMBJS1AmuwG17YYP2Yr38NEqCjKuPwo0zGrje
         b5JfTkmP1oprbymcGtpYqyCT7c9wpYwGLyChDi6aale7rQ9Mv3lYPns9yc01PSxy4hg0
         NM36Cth8NrYzSIpw1VGRAv+wGzeOa782aUm2wQY+J1jjHCsIoqfl9gg9zBD+3vsghCmN
         vyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017471; x=1708622271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H34U5Vbhdh0VVX7V6tBXcBBMhZVVWdzHO2tS/G9vxsA=;
        b=A/HL3yUxy99jWPaSdhLYTn97tkmu+JLsHVQ6zdZ4lBONEuz6yCuLgUD0bTETFHEMYO
         mdPe7EjNB1zxSJhKxpozOSgaArlxAk3HHhmcHkIChfhzL0iyekEz5Ct0qvG0FbEcnWui
         m10cwuDUsC0/l9iUG/QtWzyx5GgBliRMrkfnguaTCjcYHntiIY3TEgfsx777dbFc9kCh
         J+w+YSMk1EeK5Oth6xVvcfabbYZ4/PmaiWl7JA6G7aOm8M6C4QRGoYcHiEhWPlTZeBBi
         7+EuY/YpANmGqZyj8nJ0gdBkgVOJkPpjXeGkocwHT/xdIyEK30CcQ73rg+ErqjZ32XLZ
         9OZw==
X-Forwarded-Encrypted: i=1; AJvYcCVXRq/Zw/CSIWM0wnJJryoAPwSAFGOrE5tTmGay84bES+Zc1+dcQepqGwllM1LPZdtloAYIVoPsKDcuY741Kk1LGbujxhcE7ik71keEOnKI1SY7zGRWszfzuuM1bleh8IKN2BxjuziMhoGTtZUSGxW84ZQ/n74r9XpaM4g++DhpkMHh4qNtCQ==
X-Gm-Message-State: AOJu0YyQ4NaRJZoZ8y8YHxOatLayRcnQywhlFMJZAU9roTpmzbB2tmCm
	u7tHmxos0kiS7yon1gseIFeBsz4W2dtfPNev5znw1T7WVlO6hrTC
X-Google-Smtp-Source: AGHT+IHHcZ1//S93h4fbmeMpKxoOUOaImluG4dEHXvLHUuc5pEbhKBnFGfiMd6XylvzjlNMhDqLQ0w==
X-Received: by 2002:a05:6512:31d1:b0:512:8d6d:4804 with SMTP id j17-20020a05651231d100b005128d6d4804mr934022lfe.15.1708017470617;
        Thu, 15 Feb 2024 09:17:50 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m26-20020a05651202fa00b00511a289c0c9sm308209lfq.306.2024.02.15.09.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:17:50 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Stephen Rothwell <sfr@rothwell.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] MIPS: Fix missing proto and passing arg warnings
Date: Thu, 15 Feb 2024 20:17:25 +0300
Message-ID: <20240215171740.14550-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After getting my local tree rebased onto the kernel 6.8-rc3 the MIPS32
kernel build procedure produced a couple of warnings which I suggest to
fix in the framework of this series.

A first warning is of the "no previous prototype for `<func>`" type. In
particular my arch-specific code has the mips_cm_l2sync_phys_base() method
re-defined, but even though the function is global it' prototype isn't
declared anywhere. Fix that by adding the method prototype declaration to
the mips/include/asm/mips-cm.h header file. A similar solution was
provided for the methods:
__mips_cm_l2sync_phys_base()
mips_cm_phys_base()
__mips_cm_phys_base()
too (Please see the patches 1/4 and 2/4 notes section for an alternative
suggestion of the way to fix the warning).

One more case of the denoted warning I spotted in the self-extracting
kernel (so called zboot) with the debug printouts enabled. In particular
there are several putc() method re-definitions available in:
arch/mips/boot/compressed/uart-prom.c
arch/mips/boot/compressed/uart-16550.c
arch/mips/boot/compressed/uart-alchemy.c
All of these files lacked the prototype declaration what caused having the
"no previous prototype for ‘putc’" printed on my build with the next
configs enabled:
CONFIG_SYS_SUPPORTS_ZBOOT=y
CONFIG_SYS_SUPPORTS_ZBOOT_UART_PROM=y
CONFIG_ZBOOT_LOAD_ADDRESS=0x85100000
CONFIG_DEBUG_ZBOOT=y

The second warning is of the "passing argument <x> of ‘<func>’ from
incompatible pointer type" type which I discovered in the
drivers/tty/mips_ejtag_fdc.c driver. The problem most likely happened due
to the commit ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character
pointers").

That's it for today.) Thanks for review in advance. Any tests are very
welcome.

Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Stephen Rothwell <sfr@rothwell.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (4):
  mips: cm: Add __mips_cm_l2sync_phys_base prototype declaration
  mips: cm: Add CM GCR and L2-sync base address getters declarations
  mips: zboot: Fix "no previous prototype" build warning
  tty: mips_ejtag_fdc: Fix passing incompatible pointer type warning

 arch/mips/boot/compressed/uart-16550.c   |  2 ++
 arch/mips/boot/compressed/uart-alchemy.c |  2 ++
 arch/mips/boot/compressed/uart-prom.c    |  2 ++
 arch/mips/include/asm/mips-cm.h          | 16 ++++++++++++++++
 arch/mips/kernel/mips-cm.c               |  2 +-
 drivers/tty/mips_ejtag_fdc.c             |  2 +-
 6 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.43.0


