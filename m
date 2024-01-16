Return-Path: <linux-kernel+bounces-27367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E1482EEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6800B285545
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB331B97B;
	Tue, 16 Jan 2024 12:10:57 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354C1B961;
	Tue, 16 Jan 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ddf73f0799so1097692a34.1;
        Tue, 16 Jan 2024 04:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705407054; x=1706011854;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJxJbQrhjLUsbQrSI34rLi8y9pfUfCcNo/+s+asS57g=;
        b=GW41LcoF8wHyTdvLPOSBH2IOx/bZ7n9rnFuprV7FQfxNJs2+zKQwfS4sZxpSCjh/Es
         8ORBtB6PuiGOY7z3KJwYyXL/vBYZmSgExUAJVKVMNEMhbInMR87BEZ1jAg2Y9ru2cLlC
         eQRCHYBjxZuSXHs8j7Eq5J+WgVTxHNe3nYtjX4kON5iNPZgdkYObkR0SKtzkwCwljlVY
         l/12XpM5Uwp8+/5ZZ7fcFgLlb4Lj55UYtZgApgbwUT8DAQKALHBh3tX43sKiX2GM1S7S
         9GSkFfBtIUpanplnHAWMdzFUsXYzBhYVprQXPJiANw0xitIWWJQWg4NbSZbXswfM/fee
         iNxA==
X-Gm-Message-State: AOJu0YzT/+uQpenalY274kfCnUuGYBt4DG0NwQ9QJPsv4gxqzZPFVED5
	TuoLVUH/TUmkccAMP5Q24XBPfeH498nYfll+uEQ=
X-Google-Smtp-Source: AGHT+IGwy2IZP49o+Gun+KoKpqFEjx2TudG5WVv2dwpAPmt4lRu/tbTe8ZN2tYUTwxaGa5W4N90zWIgO/TwLA9SRXaw=
X-Received: by 2002:a4a:dd8f:0:b0:598:b2d7:2499 with SMTP id
 h15-20020a4add8f000000b00598b2d72499mr10076731oov.0.1705407054402; Tue, 16
 Jan 2024 04:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jan 2024 13:10:43 +0100
Message-ID: <CAJZ5v0j6AXAw2igWvHZN+GybT1pgjkg4_tDVMZwLEbuj7zHsEA@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v6.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.8-rc1-2

with top-most commit dd75558b2d0b5e2b36ec0ef7e494d2763517d801

 Merge branches 'thermal-core' and 'thermal-intel'

on top of commit 17e8b76491b007698cf63bc10093bc8991e45001

 Merge branch 'thermal-intel'

to receive more thermal control updates for 6.8-rc1.

These add support for debugfs-based diagnostics to the thermal core,
simplify the thermal netlink API, fix system-wide PM support in the
Intel HFI driver and clean up some code.

Specifics:

  - Add debugfs-based diagnostics support to the thermal core (Daniel
    Lezcano, Dan Carpenter).

  - Fix a power allocator thermal governor issue preventing it from
    resetting cooling devices sometimes (Di Shen).

  - Simplify the thermal netlink API and clean up related code (Rafael J.
    Wysocki).

  - Make the Intel HFI driver support hibernation and deep suspend
    properly (Ricardo Neri).

Thanks!


---------------

Christophe JAILLET (1):
      thermal: core: Use kstrdup_const() during cooling device registration

Dan Carpenter (1):
      thermal/debugfs: Unlock on error path in thermal_debug_tz_trip_up()

Daniel Lezcano (2):
      thermal/debugfs: Add thermal cooling device debugfs information
      thermal/debugfs: Add thermal debugfs information for mitigation episodes

Di Shen (1):
      thermal: gov_power_allocator: avoid inability to reset a cdev

Rafael J. Wysocki (6):
      thermal: netlink: Pass pointers to thermal_notify_tz_trip_change()
      thermal: netlink: Pass pointers to thermal_notify_tz_trip_up/down()
      thermal: netlink: Drop thermal_notify_tz_trip_add/delete()
      thermal: netlink: Pass thermal zone pointer to notify routines
      thermal: netlink: Rework notify API for cooling devices
      thermal: helpers: Rearrange thermal_cdev_set_cur_state()

Ricardo Neri (1):
      thermal: intel: hfi: Add syscore callbacks for system-wide PM

---------------

 drivers/thermal/Kconfig               |   7 +
 drivers/thermal/Makefile              |   2 +
 drivers/thermal/gov_power_allocator.c |   2 +-
 drivers/thermal/intel/intel_hfi.c     |  28 ++
 drivers/thermal/thermal_core.c        |  38 +-
 drivers/thermal/thermal_core.h        |   1 +
 drivers/thermal/thermal_debugfs.c     | 839 ++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_debugfs.h     |  28 ++
 drivers/thermal/thermal_helpers.c     |  21 +-
 drivers/thermal/thermal_netlink.c     |  95 ++--
 drivers/thermal/thermal_netlink.h     |  75 ++-
 drivers/thermal/thermal_trip.c        |   8 +-
 include/linux/thermal.h               |   9 +-
 13 files changed, 1026 insertions(+), 127 deletions(-)

