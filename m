Return-Path: <linux-kernel+bounces-30013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB358316DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC18287C14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AC72377A;
	Thu, 18 Jan 2024 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XOu+hpRX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E3B65C;
	Thu, 18 Jan 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575046; cv=none; b=phV3Wc6zqjJETjKK+axXrmUzl5S6cprPwj3E0sE0JCAWefrwVTYfWVpz3uGZj+qKRQtB8mFJvGWP2Gh/gSGlnk/AAH8acwOyUvYwUBtXkAe+6kR13UVCyczryu5ePJWQEY7GT3Yc6YjikcR4poTAFY7cTHTAJOlfZY17TchWGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575046; c=relaxed/simple;
	bh=E3c3GeOas2eJptqXuySnDvNB9Lkv4yrrCUL/618oDwM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:User-Agent:X-stable:X-Patchwork-Hint:
	 X-KernelTest-Patch:X-KernelTest-Tree:X-KernelTest-Branch:
	 X-KernelTest-Patches:X-KernelTest-Version:X-KernelTest-Deadline:
	 Content-Transfer-Encoding; b=RfGSYd5p5nZen8L8JLS6LYtzpUUkTYeK8eKrJ/CSR26RMJu7dhrx1ZwhrAH43GDU1ut3l41L6AN+ERTMGyF3UIl0xniNVKUF0noszr/9G3oBhfIW9ZkH+RjdX6Ob+22gwLOw7rAYXQhmBe/4Ca+yzgzrfmgeSM0CrwhZPCVZLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XOu+hpRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F10EC433F1;
	Thu, 18 Jan 2024 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575045;
	bh=E3c3GeOas2eJptqXuySnDvNB9Lkv4yrrCUL/618oDwM=;
	h=From:To:Cc:Subject:Date:From;
	b=XOu+hpRXBxBTzUoyfGVjSBohGJwhi0s1Dc1CChkSDY0dNry7Q9cmbOaUK7Y6KV+++
	 SsQKlD/CnGgZe9FMs71F4X+PidQP8OvlgaxDXR8fTDR03K3nf9JriErYI6kbT9uTN/
	 eW1A7IpCCYoIvODWKUo+0svjRLYaEbaRWwvbbp98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 6.7 00/28] 6.7.1-rc1 review
Date: Thu, 18 Jan 2024 11:48:50 +0100
Message-ID: <20240118104301.249503558@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.1-rc1
X-KernelTest-Deadline: 2024-01-20T10:43+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.7.1 release.
There are 28 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.7.1-rc1

Sumanth Korikkar <sumanthk@linux.ibm.com>
    mm/memory_hotplug: fix memmap_on_memory sysfs value retrieval

Vegard Nossum <vegard.nossum@oracle.com>
    docs: kernel_feat.py: fix potential command injection

Carlos Llamas <cmllamas@google.com>
    scripts/decode_stacktrace.sh: optionally use LLVM utilities

James Clark <james.clark@arm.com>
    coresight: etm4x: Fix width of CCITMIN field

LeoLiuoc <LeoLiu-oc@zhaoxin.com>
    PCI: Add ACS quirk for more Zhaoxin Root Ports

Florian Eckert <fe@dev.tdt.de>
    leds: ledtrig-tty: Free allocated ttyname buffer on deactivate

Cameron Williams <cang1@live.co.uk>
    parport: parport_serial: Add Brainboxes device IDs and geometry

Cameron Williams <cang1@live.co.uk>
    parport: parport_serial: Add Brainboxes BAR details

Guanghui Feng <guanghuifeng@linux.alibaba.com>
    uio: Fix use-after-free in uio_open

Carlos Llamas <cmllamas@google.com>
    binder: fix comment on binder_alloc_new_buf() return value

Carlos Llamas <cmllamas@google.com>
    binder: fix trivial typo of binder_free_buf_locked()

Carlos Llamas <cmllamas@google.com>
    binder: fix use-after-free in shinker's callback

Carlos Llamas <cmllamas@google.com>
    binder: use EPOLLERR from eventpoll.h

Junxiao Bi <junxiao.bi@oracle.com>
    Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Fedor Pchelkin <pchelkin@ispras.ru>
    ksmbd: free ppace array on error in parse_dacl

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: don't allow O_TRUNC open on read-only share

Lewis Huang <lewis.huang@amd.com>
    drm/amd/display: Pass pwrseq inst for backlight and ABM

Sjoerd Simons <sjoerd@collabora.com>
    bus: moxtet: Add spi device table

Sjoerd Simons <sjoerd@collabora.com>
    bus: moxtet: Mark the irq as shared

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Lorenz Brun <lorenz@brun.one>
    ALSA: hda: cs35l41: Support more HP models without _DSD

Tom Jason Schwanke <tom@catboys.cloud>
    ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP Envy X360 13-ay0xxx

Dorian Cruveiller <doriancruveiller@gmail.com>
    ALSA: hda/realtek: enable SND_PCI_QUIRK for Lenovo Legion Slim 7 Gen 8 (2023) serie

Dorian Cruveiller <doriancruveiller@gmail.com>
    ALSA: hda: Add driver properties for cs35l41 for Lenovo Legion Slim 7 Gen 8 serie

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda: cs35l41: Prevent firmware load if SPI speed too low

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda: cs35l41: Support additional Dell models without _DSD

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add quirks for Dell models

Eric Biggers <ebiggers@google.com>
    f2fs: explicitly null-terminate the xattr list


-------------

Diffstat:

 Documentation/admin-guide/features.rst             |   2 +-
 Documentation/arch/arc/features.rst                |   2 +-
 Documentation/arch/arm/features.rst                |   2 +-
 Documentation/arch/arm64/features.rst              |   2 +-
 Documentation/arch/loongarch/features.rst          |   2 +-
 Documentation/arch/m68k/features.rst               |   2 +-
 Documentation/arch/mips/features.rst               |   2 +-
 Documentation/arch/nios2/features.rst              |   2 +-
 Documentation/arch/openrisc/features.rst           |   2 +-
 Documentation/arch/parisc/features.rst             |   2 +-
 Documentation/arch/powerpc/features.rst            |   2 +-
 Documentation/arch/riscv/features.rst              |   2 +-
 Documentation/arch/s390/features.rst               |   2 +-
 Documentation/arch/sh/features.rst                 |   2 +-
 Documentation/arch/sparc/features.rst              |   2 +-
 Documentation/arch/x86/features.rst                |   2 +-
 Documentation/arch/xtensa/features.rst             |   2 +-
 Documentation/sphinx/kernel_feat.py                |  57 ++--------
 .../translations/zh_CN/arch/loongarch/features.rst |   2 +-
 .../translations/zh_CN/arch/mips/features.rst      |   2 +-
 .../translations/zh_TW/arch/loongarch/features.rst |   2 +-
 .../translations/zh_TW/arch/mips/features.rst      |   2 +-
 Makefile                                           |   4 +-
 drivers/acpi/resource.c                            |   7 ++
 drivers/android/binder.c                           |   2 +-
 drivers/android/binder_alloc.c                     |  10 +-
 drivers/bus/moxtet.c                               |   9 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   4 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |  12 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |   8 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c  |   7 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h  |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_panel_cntl.c    |   5 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  16 +--
 .../drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c    |  36 ++++--
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h        |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h |   2 +
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |  59 +++++++---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  14 ++-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   2 +-
 drivers/leds/trigger/ledtrig-tty.c                 |   4 +
 drivers/md/raid5.c                                 |  12 --
 drivers/parport/parport_serial.c                   |  64 +++++++++++
 drivers/pci/quirks.c                               |   8 +-
 drivers/uio/uio.c                                  |   7 +-
 fs/f2fs/xattr.c                                    |   6 +
 fs/smb/server/smb2pdu.c                            |  23 ++--
 fs/smb/server/smbacl.c                             |  11 +-
 mm/memory_hotplug.c                                |   8 +-
 scripts/decode_stacktrace.sh                       |  19 +++-
 sound/pci/hda/cs35l41_hda.c                        |  25 +++-
 sound/pci/hda/cs35l41_hda.h                        |  12 +-
 sound/pci/hda/cs35l41_hda_i2c.c                    |   2 +-
 sound/pci/hda/cs35l41_hda_property.c               | 126 +++++++++++++++------
 sound/pci/hda/cs35l41_hda_spi.c                    |   2 +-
 sound/pci/hda/patch_realtek.c                      |  18 +++
 58 files changed, 443 insertions(+), 209 deletions(-)



