Return-Path: <linux-kernel+bounces-102497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A514287B2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73741C23989
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8004176C;
	Wed, 13 Mar 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJBtQez9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E469C1EB31
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710362261; cv=none; b=XkRE02+IYk1+n87ulOfTxeKbvPEBflWl1uHCPNlrCjZUPYLOZbPKdBnkdXB17cs8/RiOjBs/TUwvmTQ619JqCMh+hWoCCSbJU/0ubEYNSmdNod+zhZIo/6uZNzHo/O8IeUIDe9BXA0OdBV9blWQ2amNOM4DvXMA8XnOn94AMQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710362261; c=relaxed/simple;
	bh=FkS9XoH9oAoq7iil98tyf1OpnLIRd5y82JyOV+VOxVA=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=gu9QisoQN+hFR7UH3tVBfCXxL783uJFLRK1yJC07Sj2OcPrBmIMhmbyHzi01b9VKo6Yz6vv7oROyDEAlul/rgHygRJYza7ZFkkoi+PKRpGPPGo9npqNMdpJPesHooAFBb+Uxkl+U4yZN3c5QEwpcxPz3l6B0jjgfCivKKq71/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJBtQez9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2399AC433F1;
	Wed, 13 Mar 2024 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710362260;
	bh=FkS9XoH9oAoq7iil98tyf1OpnLIRd5y82JyOV+VOxVA=;
	h=Date:From:To:cc:Subject:From;
	b=DJBtQez9zV775RdQkjE8kXrjmthGZ20b0utsJHGDPepKGeA/j0yR1zi3pvjDaMIyI
	 J6QYp1rfBhku0kgE5pSjJH8EJi1kNxMpzqyUxzWzczlpXx7hvcb0VM7Mw/HIZJFpyk
	 z6zcCX/xhz27EsIbJry+qiJXgwWizGd6xu2S1S45aP8cuNZ0KOc3FCHdRx0ycroBTI
	 d+AEThLO3ZAH58Bnv3JbA86ZOQxTjXZ1TethW3zsjp6ci5PXJwzr2yV4yRBzJL3WM/
	 5I1/UyB8Rh5XqMsSmR/3pUbwYzQ+ttjMb/Bbh2DYv4sLSUTO51DgLnvYzGdordQn1S
	 KvKe1g4yTlJwQ==
Date: Wed, 13 Mar 2024 21:37:37 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.9 merge window
Message-ID: <nycvar.YFH.7.76.2403132132240.20263@cbobk.fhfr.pm>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024031301

to receive HID subsystem queue for 6.9 merge window.

=====
- support for the following Bluetooth devices from Samsung (Sandeep C S):
            Samsung wireless Keyboard
            Samsung wireless GamePad
            Samsung Wireless Action Mouse
            Samsung Wireless Book Cover
            Samsung Wireless Universal Keyboard
            Samsung Wireless HOGP Keyboard
- second version of code for applying proper quirk depending on firmware 
  version for lenovo/cptkbd (Mikhail Khvainitski)
- lenovo/cptkbd firmware-dependent quirk (Mikhail Khvainitski)
- assorted fixes and optimizations for amd-sfh (Basavaraj Natikar)
- dead code and dead data structures removal (Jiri Slaby, Jiapeng Chong)
=====

----------------------------------------------------------------
Basavaraj Natikar (6):
      HID: amd_sfh: Increase sensor command timeout
      HID: amd_sfh: Update HPD sensor structure elements
      HID: amd_sfh: Avoid disabling the interrupt
      HID: amd_sfh: Improve boot time when SFH is available
      HID: amd_sfh: Extend MP2 register access to SFH
      HID: amd_sfh: Set the AMD SFH driver to depend on x86

Dmitry Torokhov (1):
      HID: input: avoid polling stylus battery on Chromebook Pompom

Even Xu (1):
      HID: intel-ish-hid: ipc: Add Arrow Lake PCI device ID

Jiapeng Chong (2):
      HID: nintendo: Remove some unused functions
      HID: nintendo: Remove some unused functions

Jiri Slaby (SUSE) (7):
      HID: apple: remove unused members from struct apple_sc_backlight
      HID: wacom: remove unused hid_data::pressure
      HID: protect hid_device::bpf by CONFIG_HID_BPF
      HID: hid-lg3ff: remove unused struct lg3ff_device
      HID: hid-multitouch: remove unused mt_application::dev_time
      HID: hid-prodikeys: remove unused struct pcmidi_snd members
      HID: hid-prodikeys: remove struct pk_device

Mikhail Khvainitski (1):
      HID: lenovo: Add middleclick_workaround sysfs knob for cptkbd

Sandeep C S (6):
      HID: samsung: Broaden device compatibility in samsung driver
      HID: samsung: Rewrite rdesc checking code using memcmp()
      HID: samsung: Add Samsung wireless keyboard support
      HID: samsung: Add Samsung wireless gamepad support
      HID: samsung: Add Samsung wireless action mouse support
      HID: samsung: Add Samsung wireless bookcover and universal keyboard support

Tatsunosuke Tobita (1):
      HID: wacom: Clean up use of struct->wacom_wac

 drivers/hid/amd-sfh-hid/Kconfig                    |   1 +
 drivers/hid/amd-sfh-hid/amd_sfh_common.h           |  16 +
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             | 118 +++++-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h             |   6 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |   2 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c      |   4 +-
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c |  10 +-
 drivers/hid/hid-apple.c                            |   1 -
 drivers/hid/hid-ids.h                              |   8 +
 drivers/hid/hid-input.c                            |   2 +
 drivers/hid/hid-lenovo.c                           |  57 ++-
 drivers/hid/hid-lg3ff.c                            |   4 -
 drivers/hid/hid-multitouch.c                       |   1 -
 drivers/hid/hid-nintendo.c                         |  22 --
 drivers/hid/hid-prodikeys.c                        | 115 ++----
 drivers/hid/hid-samsung.c                          | 437 +++++++++++++++++++--
 drivers/hid/intel-ish-hid/ipc/hw-ish.h             |   1 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   1 +
 drivers/hid/wacom_wac.c                            |   8 +-
 drivers/hid/wacom_wac.h                            |   1 -
 include/linux/hid.h                                |   4 +-
 21 files changed, 623 insertions(+), 196 deletions(-)

-- 
Jiri Kosina
SUSE Labs


