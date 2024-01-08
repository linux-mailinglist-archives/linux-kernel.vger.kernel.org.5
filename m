Return-Path: <linux-kernel+bounces-20091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE882792A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC587B22A58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A347773;
	Mon,  8 Jan 2024 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UYj8xoJc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084914264
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557c188f313so1749614a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704745863; x=1705350663; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F+YTmapdlstnvW0VoOulWHkOEtM5IYtbqGvFbMceXSQ=;
        b=UYj8xoJceRt7eAziXjsRHE2REWkdjOorRJq0A/dYdRGPuCD5w7Lwqbv5IVqWBvXaOB
         7mSTMYwBJkfa+4aBAAuC0eTDHsG+sJiXO6nuQBz/yf6OFLpz6r+5SzGJBEtyz8Qmm8/C
         XqEeObfrJ8tDcpR+UzCqNetrDxqIpoeNyffQ/uRLGHz/zVAsnOLhrhwSKWgDIwD6yt5Z
         2I3HY7aTZtx3L4xEmj9H8nz8daR2je8VAAK2xHLyVuwf0hWdZ5IgBq9iMHn1KjOi0dMg
         edriaETClrHSg+/zJvWufv82Nbsqwqfp2GjqEIYnU/KhtYsUKvBtlDvrKTt+ft9MCMiq
         gLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704745863; x=1705350663;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+YTmapdlstnvW0VoOulWHkOEtM5IYtbqGvFbMceXSQ=;
        b=BdeiRkbLwLe8h8lCfdYIr+jp9Rp7O3NwfZSYCJ6yUdpogXniQ7DswkDW6I54PxHDcq
         ft8ABAIIU3f/FMcLTaD/YnRg15encAmwpSV400Vs4XLmnfJF72kP5EpJii1H9TwdIp+a
         f8mBVk8K/7ZRPVfOcR/O35CRt5jWViiFz5BMDMn+VJU31u00zYrydBBt3/VFGMzfzluV
         +inocjotQ9AIDZ9fptOKYbFzSXRkcH1Tg/h2jUg2+m/8Whl2duVDQOB3L2pi2w/nH/uv
         mO0wKgSljUM4uvI9+f2klM9BCMfd39Iyf5PPTS2O8GiEVPxd4rZUDWAH9TNZrIwrAO3v
         m4yg==
X-Gm-Message-State: AOJu0Yyke8kQ2H1ji6J87N0jahCU9RTY8hD2d+ZKclvYYc3M5cpZymkh
	t+gwu7ysnn2R9VLZGqtpt4QQQFomvn+Eng==
X-Google-Smtp-Source: AGHT+IFjRbOF545mO7sIzX8VJ/06xAixraVlw3xz4yws66UL+kPmOyBPxTqea83XqM5mBQwx1OyKWg==
X-Received: by 2002:a05:6402:7c2:b0:557:7501:4242 with SMTP id u2-20020a05640207c200b0055775014242mr304893edy.12.1704745862831;
        Mon, 08 Jan 2024 12:31:02 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id dm3-20020a05640222c300b0054b53aacd86sm183207edb.65.2024.01.08.12.31.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2024 12:31:02 -0800 (PST)
From: Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date: Mon, 8 Jan 2024 21:31:04 +0100 (CET)
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.8
Message-ID: <nycvar.YFH.7.76.2401082125270.29548@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024010801

to receive HID subsystem queue for 6.8 merge window. Highlights:

=====
- assorted functional fixes for hid-steam ported from SteamOS betas (Vicki 
  Pfau)

- fix for custom sensor-hub sensors (hinge angle sensor and LISS sensors) 
  not working (Yauhen Kharuzhy)

- functional fix for handling Confidence in Wacom driver (Jason Gerecke)

- support for Ilitek ili2901 touchscreen (Zhengqiao Xia)

- power management fix for Wacom userspace battery exporting (Tatsunosuke 
  Tobita)

- rework of wait-for-reset in order to reduce the need for 
  I2C_HID_QUIRK_NO_IRQ_AFTER_RESET qurk; the success rate is now 50% 
  better, but there are still further improvements to be made (Hans de 
  Goede)

- greatly improved coverage of Tablets in hid-selftests (Benjamin 
  Tissoires)

- support for Nintendo NSO controllers -- SNES, Genesis and N64 (Ryan 
  McClelland)

- support for controlling mcp2200 GPIOs (Johannes Roith)

- power management improvement for EHL OOB wakeup in intel-ish (Kai-Heng 
  Feng)

- other assorted device-specific fixes and code cleanups
=====

Thanks.

----------------------------------------------------------------
Basavaraj Natikar (3):
      HID: amd_sfh: rename float_to_int() to amd_sfh_float_to_int()
      HID: amd_sfh: Add a new interface for exporting HPD data
      HID: amd_sfh: Add a new interface for exporting ALS data

Benjamin Tissoires (16):
      selftests/hid: vmtest.sh: update vm2c and container
      selftests/hid: vmtest.sh: allow finer control on the build steps
      selftests/hid: base: allow for multiple skip_if_uhdev
      selftests/hid: tablets: remove unused class
      selftests/hid: tablets: move the transitions to PenState
      selftests/hid: tablets: move move_to function to PenDigitizer
      selftests/hid: tablets: do not set invert when the eraser is used
      selftests/hid: tablets: set initial data for tilt/twist
      selftests/hid: tablets: define the elements of PenState
      selftests/hid: tablets: add variants of states with buttons
      selftests/hid: tablets: convert the primary button tests
      selftests/hid: tablets: add a secondary barrel switch test
      selftests/hid: tablets: be stricter for some transitions
      selftests/hid: fix mypy complains
      selftests/hid: fix ruff linter complains
      selftests/hid: fix failing tablet button tests

Even Xu (4):
      HID: Intel-ish-hid: Ishtp: Add helper functions for client connection
      HID: intel-ish-hid: ishtp-hid-client: use helper functions for connection
      HID: intel-ish-hid: ishtp-fw-loader: use helper functions for connection
      platform/chrome: cros_ec_ishtp: use helper functions for connection

Greg Kroah-Hartman (3):
      HID: make hid_bus_type const
      HID: make ishtp_cl_bus_type const
      HID: bpf: make bus_type const in struct hid_bpf_ops

Hamish Martin (3):
      HID: mcp2221: Set ACPI companion
      HID: mcp2221: Don't set bus speed on every transfer
      HID: mcp2221: Handle reads greater than 60 bytes

Hans de Goede (7):
      HID: i2c-hid: Fold i2c_hid_execute_reset() into i2c_hid_hwreset()
      HID: i2c-hid: Split i2c_hid_hwreset() in start() and finish() functions
      HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling
      HID: i2c-hid: Move i2c_hid_finish_hwreset() to after reading the report-descriptor
      HID: i2c-hid: Turn missing reset ack into a warning
      HID: i2c-hid: Remove I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV quirk
      HID: i2c-hid: Renumber I2C_HID_QUIRK_ defines

Jason Gerecke (2):
      HID: wacom: Correct behavior when processing some confidence == false touches
      HID: wacom: Add additional tests of confidence behavior

Jiri Kosina (1):
      HID: magicmouse: fix kerneldoc for struct magicmouse_sc

Johannes Roith (1):
      HID: mcp2200: added driver for GPIOs of MCP2200

Kai-Heng Feng (1):
      HID: intel-ish-hid: ipc: Rework EHL OOB wakeup

Ryan McClelland (1):
      HID: nintendo: add support for nso controllers

Tatsunosuke Tobita (1):
      HID: wacom: Remove AES power_supply after extended inactivity

Vicki Pfau (7):
      HID: hid-steam: Avoid overwriting smoothing parameter
      HID: hid-steam: Disable watchdog instead of using a heartbeat
      HID: hid-steam: Clean up locking
      HID: hid-steam: Make client_opened a counter
      HID: hid-steam: Update list of identifiers from SDL
      HID: hid-steam: Better handling of serial number length
      HID: hid-steam: Add gamepad-only mode switched to by holding options

Yauhen Kharuzhy (1):
      HID: sensor-hub: Enable hid core report processing for all devices

Zhengqiao Xia (2):
      dt-bindings: HID: i2c-hid: elan: Introduce Ilitek ili2901
      HID: i2c-hid: elan: Add ili2901 timing

 .../devicetree/bindings/input/elan,ekth6915.yaml   |   5 +-
 drivers/hid/Kconfig                                |  22 +-
 drivers/hid/Makefile                               |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_common.h           |   6 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |  28 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      |  20 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c |  59 ++
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h |   2 +
 drivers/hid/hid-core.c                             |   2 +-
 drivers/hid/hid-ids.h                              |   6 +-
 drivers/hid/hid-magicmouse.c                       |   3 +
 drivers/hid/hid-mcp2200.c                          | 392 +++++++++
 drivers/hid/hid-mcp2221.c                          |  72 +-
 drivers/hid/hid-nintendo.c                         | 897 +++++++++++++++------
 drivers/hid/hid-sensor-hub.c                       |   2 +-
 drivers/hid/hid-steam.c                            | 547 +++++++++----
 drivers/hid/i2c-hid/i2c-hid-core.c                 | 137 ++--
 drivers/hid/i2c-hid/i2c-hid-of-elan.c              |   8 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |  67 +-
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c        |  60 +-
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       |  63 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c              |   2 +-
 drivers/hid/intel-ish-hid/ishtp/client.c           | 185 ++++-
 drivers/hid/wacom.h                                |   1 +
 drivers/hid/wacom_sys.c                            |   8 +
 drivers/hid/wacom_wac.c                            |  44 +-
 drivers/hid/wacom_wac.h                            |   1 +
 drivers/platform/chrome/cros_ec_ishtp.c            |  74 +-
 include/linux/amd-pmf-io.h                         |  50 ++
 include/linux/hid.h                                |   2 +-
 include/linux/hid_bpf.h                            |   2 +-
 include/linux/intel-ish-client-if.h                |   3 +
 tools/testing/selftests/hid/tests/base.py          |   7 +-
 tools/testing/selftests/hid/tests/test_mouse.py    |  14 +-
 tools/testing/selftests/hid/tests/test_tablet.py   | 764 ++++++++++++------
 .../selftests/hid/tests/test_wacom_generic.py      | 282 ++++++-
 tools/testing/selftests/hid/vmtest.sh              |  46 +-
 37 files changed, 2834 insertions(+), 1050 deletions(-)
 create mode 100644 drivers/hid/hid-mcp2200.c
 create mode 100644 include/linux/amd-pmf-io.h

-- 
Jiri Kosina
SUSE Labs


