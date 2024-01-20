Return-Path: <linux-kernel+bounces-31769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA98333C1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D87D1F2211D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F76DF4E;
	Sat, 20 Jan 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tSzPk5eU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D203DDC9;
	Sat, 20 Jan 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749047; cv=none; b=f44xn1DZRig0Dql0r2pwx5vPuH3wOsLqCrwOo/gEoeGyXzUs0meML+aWATTenknjOooyPXX3leOtJb63H7hH9yeJO6CZKKkuMWpm32DsS5iluMXCihn225aGa2gAg88AGJmXzlhP6exeydT6IK/BgcCUWTz4MtQWmQTlIpvPOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749047; c=relaxed/simple;
	bh=epuGUo3yhd5k+4y0YoeCSMis//mF6FSyoq8aw1ynefo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkQvcJKm/6SfMD5RM/P/uabsC5dom9vnbW9+EYmGHwAth2onN8EdEiIBhhnLju86v8IANO/qJbI8QmdWreu4GW8nlUWA/nGA6Xn8/+e8HQRxT4HWwL9HoRpfvJop4Amx1fxx2KZP42o6bvNbkRTedxexqUOzy49CphUKvKsX4js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tSzPk5eU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D56C433C7;
	Sat, 20 Jan 2024 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705749047;
	bh=epuGUo3yhd5k+4y0YoeCSMis//mF6FSyoq8aw1ynefo=;
	h=From:To:Cc:Subject:Date:From;
	b=tSzPk5eU6NXnR+8JOJyqtvBIpa2xB1TOvKtL0lR7OveP1HRtoBT9dL7pBMf1tBoPe
	 zHRjbfpKJr59LInZ4nBxm6ae4v7s+FErsG6WHIoqOPGc0F1BmZPbC9pIhnk+wHfXiP
	 r+7FnwJ3eY8ltkI7rIiTRh2P/txVeBPgw1JyAuA4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.7.1
Date: Sat, 20 Jan 2024 12:10:43 +0100
Message-ID: <2024012043-celery-quickly-3928@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.7.1 kernel.

All users of the 6.7 kernel series must upgrade.

The updated 6.7.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.7.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/features.rst                       |    2 
 Documentation/arch/arc/features.rst                          |    2 
 Documentation/arch/arm/features.rst                          |    2 
 Documentation/arch/arm64/features.rst                        |    2 
 Documentation/arch/loongarch/features.rst                    |    2 
 Documentation/arch/m68k/features.rst                         |    2 
 Documentation/arch/mips/features.rst                         |    2 
 Documentation/arch/nios2/features.rst                        |    2 
 Documentation/arch/openrisc/features.rst                     |    2 
 Documentation/arch/parisc/features.rst                       |    2 
 Documentation/arch/powerpc/features.rst                      |    2 
 Documentation/arch/riscv/features.rst                        |    2 
 Documentation/arch/s390/features.rst                         |    2 
 Documentation/arch/sh/features.rst                           |    2 
 Documentation/arch/sparc/features.rst                        |    2 
 Documentation/arch/x86/features.rst                          |    2 
 Documentation/arch/xtensa/features.rst                       |    2 
 Documentation/sphinx/kernel_feat.py                          |   55 ----
 Documentation/translations/zh_CN/arch/loongarch/features.rst |    2 
 Documentation/translations/zh_CN/arch/mips/features.rst      |    2 
 Documentation/translations/zh_TW/arch/loongarch/features.rst |    2 
 Documentation/translations/zh_TW/arch/mips/features.rst      |    2 
 Makefile                                                     |    2 
 drivers/acpi/resource.c                                      |    7 
 drivers/android/binder.c                                     |    2 
 drivers/android/binder_alloc.c                               |   10 
 drivers/bus/moxtet.c                                         |    9 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c           |    4 
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c         |   12 -
 drivers/gpu/drm/amd/display/dc/bios/command_table2.h         |    2 
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h               |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c                |    8 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c            |    7 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h            |    2 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c      |    5 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c    |   16 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c      |   36 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h                  |    3 
 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h           |    2 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c           |   59 +++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h              |   14 +
 drivers/hwtracing/coresight/coresight-etm4x.h                |    2 
 drivers/leds/trigger/ledtrig-tty.c                           |    4 
 drivers/md/raid5.c                                           |   12 -
 drivers/parport/parport_serial.c                             |   64 +++++
 drivers/pci/quirks.c                                         |    8 
 drivers/uio/uio.c                                            |    7 
 fs/f2fs/xattr.c                                              |    6 
 fs/smb/server/smb2pdu.c                                      |   23 --
 fs/smb/server/smbacl.c                                       |   11 
 mm/memory_hotplug.c                                          |    8 
 scripts/decode_stacktrace.sh                                 |   19 +
 sound/pci/hda/cs35l41_hda.c                                  |   25 +-
 sound/pci/hda/cs35l41_hda.h                                  |   12 -
 sound/pci/hda/cs35l41_hda_i2c.c                              |    2 
 sound/pci/hda/cs35l41_hda_property.c                         |  126 +++++++----
 sound/pci/hda/cs35l41_hda_spi.c                              |    2 
 sound/pci/hda/patch_realtek.c                                |   18 +
 58 files changed, 441 insertions(+), 207 deletions(-)

Cameron Williams (2):
      parport: parport_serial: Add Brainboxes BAR details
      parport: parport_serial: Add Brainboxes device IDs and geometry

Carlos Llamas (5):
      binder: use EPOLLERR from eventpoll.h
      binder: fix use-after-free in shinker's callback
      binder: fix trivial typo of binder_free_buf_locked()
      binder: fix comment on binder_alloc_new_buf() return value
      scripts/decode_stacktrace.sh: optionally use LLVM utilities

Dorian Cruveiller (2):
      ALSA: hda: Add driver properties for cs35l41 for Lenovo Legion Slim 7 Gen 8 serie
      ALSA: hda/realtek: enable SND_PCI_QUIRK for Lenovo Legion Slim 7 Gen 8 (2023) serie

Eric Biggers (1):
      f2fs: explicitly null-terminate the xattr list

Fedor Pchelkin (1):
      ksmbd: free ppace array on error in parse_dacl

Florian Eckert (1):
      leds: ledtrig-tty: Free allocated ttyname buffer on deactivate

Greg Kroah-Hartman (1):
      Linux 6.7.1

Guanghui Feng (1):
      uio: Fix use-after-free in uio_open

Hans de Goede (1):
      ACPI: resource: Add another DMI match for the TongFang GMxXGxx

James Clark (1):
      coresight: etm4x: Fix width of CCITMIN field

Junxiao Bi (1):
      Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

LeoLiuoc (1):
      PCI: Add ACS quirk for more Zhaoxin Root Ports

Lewis Huang (1):
      drm/amd/display: Pass pwrseq inst for backlight and ABM

Lorenz Brun (1):
      ALSA: hda: cs35l41: Support more HP models without _DSD

Namjae Jeon (1):
      ksmbd: don't allow O_TRUNC open on read-only share

Sjoerd Simons (2):
      bus: moxtet: Mark the irq as shared
      bus: moxtet: Add spi device table

Stefan Binding (3):
      ALSA: hda/realtek: Add quirks for Dell models
      ALSA: hda: cs35l41: Support additional Dell models without _DSD
      ALSA: hda: cs35l41: Prevent firmware load if SPI speed too low

Sumanth Korikkar (1):
      mm/memory_hotplug: fix memmap_on_memory sysfs value retrieval

Tom Jason Schwanke (1):
      ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP Envy X360 13-ay0xxx

Vegard Nossum (1):
      docs: kernel_feat.py: fix potential command injection


