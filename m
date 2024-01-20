Return-Path: <linux-kernel+bounces-31771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE8B8333C4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AB11C210E7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4270CDDD4;
	Sat, 20 Jan 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XXTVLM87"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897BADDB7;
	Sat, 20 Jan 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749057; cv=none; b=prtuXrk2jcgCwQdD/PJmCc4G/4aaUHk0/XVcqGNtLBC8jdFSNrGWJ/AbCCoS9hxAV6e8Q3eekOhwbtFAYXsxXspNYsj+eFPSneCA+mayS82JWgcALbrG84EKHzE5sKymhBCrazG7HyY46tYEUBrFOws/bVPtGj1HGWY5aL23Q2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749057; c=relaxed/simple;
	bh=fSafJLNk4s3q9pQBcddxxvGj8ikQxGUfWIshVFBGO0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n93nrGFk7Ovg3xrNMHnNWN3EM5NqS6tcvVJ7bMwPstczGOfBEZNPIQkTcN7SJFS/CT4t3MQu6+JSlNX5oOwItZT3VQWeZfNhMsnw6ky1nYnpCkqhJQGpQaiC5ehzE6aIKIAHm5OOXvofnp/zoHKhpHbOiTUb1AJ2SSdOA0LSIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XXTVLM87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C1BC433F1;
	Sat, 20 Jan 2024 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705749057;
	bh=fSafJLNk4s3q9pQBcddxxvGj8ikQxGUfWIshVFBGO0E=;
	h=From:To:Cc:Subject:Date:From;
	b=XXTVLM875P9P+2aXr2Mwx1y55XNc4o9I/M6JNgC+oOhnn0y98CSWrSibYMGP5v3eT
	 fO3xLtpnTn/c8b/MyDZK9kf4FNH6gEGFGri+Zc+eFAqBUJh3jWWtkHOO9TVdb2gqtR
	 Ov+/vujh8ubXaju3662w197R+Lp+Yuj9IW7Iiqs4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.13
Date: Sat, 20 Jan 2024 12:10:49 +0100
Message-ID: <2024012050-scoff-phonics-d473@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.13 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arc/kernel/setup.c                                        |    4 
 arch/arc/kernel/signal.c                                       |    6 
 arch/arm/mach-sunxi/mc_smp.c                                   |    4 
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi        |    3 
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts       |    4 
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                   |    1 
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                       |    2 
 arch/arm64/include/asm/syscall_wrapper.h                       |    4 
 arch/loongarch/Makefile                                        |    2 
 arch/loongarch/include/asm/efi.h                               |    2 
 arch/loongarch/include/asm/elf.h                               |    2 
 arch/loongarch/kernel/stacktrace.c                             |    2 
 arch/loongarch/kernel/unwind.c                                 |    1 
 arch/loongarch/kernel/unwind_prologue.c                        |    2 
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi             |    3 
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi                      |    3 
 arch/riscv/include/asm/syscall_wrapper.h                       |    5 
 arch/s390/include/asm/syscall_wrapper.h                        |   13 -
 arch/x86/include/asm/syscall_wrapper.h                         |   34 ---
 arch/x86/kernel/cpu/microcode/core.c                           |    6 
 arch/x86/lib/csum-partial_64.c                                 |  105 +++-------
 block/blk-core.c                                               |   14 +
 block/blk-mq.c                                                 |   14 +
 drivers/acpi/resource.c                                        |    7 
 drivers/android/binder.c                                       |    2 
 drivers/android/binder_alloc.c                                 |   10 
 drivers/block/virtio_blk.c                                     |    8 
 drivers/bus/moxtet.c                                           |    9 
 drivers/clk/rockchip/clk-rk3128.c                              |    2 
 drivers/clk/rockchip/clk-rk3568.c                              |    1 
 drivers/connector/cn_proc.c                                    |    5 
 drivers/firmware/efi/libstub/loongarch-stub.c                  |    4 
 drivers/firmware/efi/libstub/loongarch.c                       |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                    |    6 
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c                         |    5 
 drivers/gpu/drm/amd/amdgpu/soc15.c                             |   17 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                          |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c         |   54 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                           |   18 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c      |    6 
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c             |   23 +-
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c           |   12 -
 drivers/gpu/drm/amd/display/dc/bios/command_table2.h           |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |    8 
 drivers/gpu/drm/amd/display/dc/core/dc.c                       |   26 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h                 |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c                  |    8 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c              |    7 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h              |    2 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c    |   16 -
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c             |   36 ++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c        |    5 
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h                    |    3 
 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h             |    2 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c             |   56 +++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h                |   14 +
 drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h    |    2 
 drivers/gpu/drm/drm_crtc.c                                     |    8 
 drivers/gpu/drm/drm_prime.c                                    |   33 +--
 drivers/gpu/drm/exynos/exynos_drm_dma.c                        |    8 
 drivers/gpu/drm/exynos/exynos_hdmi.c                           |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c             |    2 
 drivers/hid/hid-nintendo.c                                     |   71 ++++--
 drivers/hwmon/corsair-psu.c                                    |   18 +
 drivers/hwtracing/coresight/coresight-etm4x.h                  |    2 
 drivers/hwtracing/ptt/hisi_ptt.c                               |    9 
 drivers/i2c/busses/i2c-rk3x.c                                  |   13 +
 drivers/input/joystick/xpad.c                                  |    1 
 drivers/input/keyboard/atkbd.c                                 |   46 ++++
 drivers/input/mouse/synaptics.c                                |    1 
 drivers/input/serio/i8042-acpipnpio.h                          |    8 
 drivers/leds/trigger/ledtrig-tty.c                             |    4 
 drivers/md/Kconfig                                             |    1 
 drivers/md/raid5.c                                             |   12 -
 drivers/net/ethernet/broadcom/tg3.c                            |   11 -
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c           |    5 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                   |    2 
 drivers/nvme/host/core.c                                       |   64 +++---
 drivers/nvme/host/fc.c                                         |    6 
 drivers/nvme/host/ioctl.c                                      |   21 +-
 drivers/nvme/host/nvme.h                                       |    6 
 drivers/nvme/host/pci.c                                        |   14 -
 drivers/nvme/host/rdma.c                                       |   23 +-
 drivers/nvme/host/tcp.c                                        |   27 +-
 drivers/nvme/target/configfs.c                                 |    3 
 drivers/parport/parport_serial.c                               |   64 ++++++
 drivers/pci/quirks.c                                           |    8 
 drivers/pinctrl/cirrus/Kconfig                                 |    3 
 drivers/pinctrl/nxp/pinctrl-s32cc.c                            |    4 
 drivers/pinctrl/pinctrl-amd.c                                  |    9 
 drivers/pinctrl/pinctrl-amd.h                                  |    5 
 drivers/pinctrl/pinctrl-cy8c95x0.c                             |   14 +
 drivers/platform/x86/amd/pmc/pmc-quirks.c                      |   20 +
 drivers/platform/x86/amd/pmc/pmc.c                             |   33 +--
 drivers/platform/x86/amd/pmc/pmc.h                             |   12 +
 drivers/platform/x86/intel/vbtn.c                              |   19 +
 drivers/platform/x86/thinkpad_acpi.c                           |   98 ++++++++-
 drivers/reset/hisilicon/hi6220_reset.c                         |    2 
 drivers/s390/block/scm_blk.c                                   |    7 
 drivers/soundwire/intel_ace2x.c                                |    3 
 drivers/uio/uio.c                                              |    7 
 drivers/vdpa/pds/debugfs.c                                     |    2 
 drivers/vdpa/pds/vdpa_dev.c                                    |    7 
 fs/debugfs/file.c                                              |    8 
 fs/debugfs/inode.c                                             |   27 +-
 fs/debugfs/internal.h                                          |   10 
 fs/f2fs/xattr.c                                                |    6 
 fs/jbd2/commit.c                                               |   10 
 fs/jbd2/journal.c                                              |   24 +-
 fs/smb/client/cifspdu.h                                        |   24 +-
 fs/smb/client/cifssmb.c                                        |    6 
 fs/smb/client/smb2misc.c                                       |   30 +-
 fs/smb/client/smb2ops.c                                        |    6 
 fs/smb/client/smb2pdu.c                                        |    8 
 fs/smb/client/smb2pdu.h                                        |   16 -
 fs/smb/common/smb2pdu.h                                        |   17 -
 fs/smb/server/smb2pdu.c                                        |   23 --
 fs/smb/server/smbacl.c                                         |   11 -
 include/drm/drm_prime.h                                        |    7 
 include/linux/blk_types.h                                      |    1 
 include/linux/device.h                                         |    2 
 include/linux/ieee80211.h                                      |    4 
 include/linux/jbd2.h                                           |    3 
 io_uring/cancel.c                                              |   11 -
 io_uring/io_uring.c                                            |   36 +--
 kernel/sys_ni.c                                                |   14 +
 kernel/time/posix-stubs.c                                      |   45 ----
 kernel/trace/ring_buffer.c                                     |    6 
 kernel/trace/trace.c                                           |   12 +
 kernel/trace/trace.h                                           |    1 
 kernel/trace/trace_events_hist.c                               |   12 -
 kernel/trace/trace_output.c                                    |    6 
 lib/idr.c                                                      |    2 
 lib/kunit/test.c                                               |   42 +++-
 lib/test_ida.c                                                 |   40 +++
 mm/memory_hotplug.c                                            |    8 
 net/core/neighbour.c                                           |    9 
 net/mac80211/ht.c                                              |    1 
 net/mptcp/options.c                                            |    1 
 net/nfc/llcp_sock.c                                            |    5 
 net/qrtr/ns.c                                                  |    4 
 net/wireless/core.c                                            |    2 
 scripts/decode_stacktrace.sh                                   |   19 +
 sound/drivers/pcmtest.c                                        |   13 +
 sound/hda/intel-nhlt.c                                         |   33 ++-
 sound/pci/hda/patch_realtek.c                                  |   16 +
 sound/soc/amd/yc/acp6x-mach.c                                  |   14 +
 sound/soc/codecs/cs35l45-i2c.c                                 |    2 
 sound/soc/codecs/cs35l45-spi.c                                 |    2 
 sound/soc/codecs/cs35l45.c                                     |   56 ++++-
 sound/soc/codecs/cs43130.c                                     |    6 
 sound/soc/codecs/da7219-aad.c                                  |    2 
 sound/soc/codecs/hdac_hda.c                                    |   23 +-
 sound/soc/codecs/nau8822.c                                     |    9 
 sound/soc/codecs/rt5645.c                                      |   10 
 sound/soc/codecs/wm8974.c                                      |    6 
 sound/soc/fsl/fsl_xcvr.c                                       |   14 +
 sound/soc/intel/boards/bytcr_rt5640.c                          |   31 ++
 sound/soc/intel/boards/skl_hda_dsp_generic.c                   |    2 
 sound/soc/intel/skylake/skl-pcm.c                              |    9 
 sound/soc/intel/skylake/skl-sst-ipc.c                          |    4 
 sound/soc/sof/intel/hda-codec.c                                |   18 -
 sound/soc/sof/ipc3-topology.c                                  |    2 
 sound/soc/sof/ipc4-control.c                                   |   20 -
 sound/soc/sof/ipc4-topology.c                                  |   61 +++--
 sound/soc/sof/ipc4-topology.h                                  |   34 ++-
 sound/soc/sof/sof-audio.c                                      |   65 +++---
 sound/soc/sof/sof-audio.h                                      |    2 
 sound/soc/sof/topology.c                                       |    4 
 tools/testing/selftests/alsa/mixer-test.c                      |    2 
 171 files changed, 1572 insertions(+), 769 deletions(-)

Armin Wolf (1):
      hwmon: (corsair-psu) Fix probe when built-in

Avraham Stern (1):
      wifi: iwlwifi: pcie: avoid a NULL pointer dereference

Ben Greear (1):
      wifi: mac80211: handle 320 MHz in ieee80211_ht_cap_ie_to_sta_ht_cap

Bitao Hu (1):
      nvme: fix deadlock between reset and scan

Cameron Williams (2):
      parport: parport_serial: Add Brainboxes BAR details
      parport: parport_serial: Add Brainboxes device IDs and geometry

Carlos Llamas (5):
      binder: use EPOLLERR from eventpoll.h
      binder: fix use-after-free in shinker's callback
      binder: fix trivial typo of binder_free_buf_locked()
      binder: fix comment on binder_alloc_new_buf() return value
      scripts/decode_stacktrace.sh: optionally use LLVM utilities

Chao Song (1):
      soundwire: intel_ace2x: fix AC timing setting for ACE2.x

Charlene Liu (1):
      drm/amd/display: get dprefclk ss info from integration info table

Charles Keepax (2):
      pinctrl: lochnagar: Don't build on MIPS
      ASoC: wm8974: Correct boost mixer inputs

Chester Lin (1):
      pinctrl: s32cc: Avoid possible string truncation

Chris Morgan (1):
      clk: rockchip: rk3568: Add PLL rate for 292.5MHz

Dan Williams (1):
      driver core: Add a guard() definition for the device_lock()

Dave Airlie (1):
      nouveau/tu102: flush all pdbs on vmm flush

David Lin (1):
      ASoC: nau8822: Fix incorrect type in assignment and cast to restricted __be16

David Rau (1):
      ASoC: da7219: Support low DC impedance headset

Dmitry Antipov (1):
      smb: client, common: fix fortify warnings

Dmytro Laktyushkin (1):
      drm/amd/display: update dcn315 lpddr pstate latency

Edward Adam Davis (1):
      mptcp: fix uninit-value in mptcp_incoming_options

Eric Biggers (1):
      f2fs: explicitly null-terminate the xattr list

Esther Shimanovich (1):
      Input: i8042 - add nomux quirk for Acer P459-G2-M

Fedor Pchelkin (1):
      ksmbd: free ppace array on error in parse_dacl

Felix Kuehling (1):
      Revert "drm/prime: Unexport helpers for fd/handle conversion"

Florian Eckert (1):
      leds: ledtrig-tty: Free allocated ttyname buffer on deactivate

Ghanshyam Agrawal (1):
      kselftest: alsa: fixed a print formatting warning

Greg Kroah-Hartman (1):
      Linux 6.6.13

Guanghui Feng (1):
      uio: Fix use-after-free in uio_open

Guilherme G. Piccoli (1):
      HID: nintendo: Prevent divide-by-zero on code

Hans de Goede (5):
      platform/x86: intel-vbtn: Fix missing tablet-mode-switch events
      Input: atkbd - skip ATKBD_CMD_GETID in translated mode
      ASoC: Intel: bytcr_rt5640: Add quirk for the Medion Lifetab S10346
      ASoC: Intel: bytcr_rt5640: Add new swapped-speakers quirk
      ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Hawking Zhang (1):
      drm/amdgpu: Do not issue gpu reset from nbio v7_9 bif interrupt

Heiko Stuebner (1):
      arm64: dts: rockchip: fix rk356x pcie msg interrupt name

Hengqi Chen (1):
      LoongArch: Preserve syscall nr across execve()

Inki Dae (1):
      drm/exynos: fix a wrong error checking

Ivan Lipski (1):
      drm/amd/display: Add monitor patch for specific eDP

Ivan Orlov (1):
      ALSA: pcmtest: stop timer before buffer is released

James Clark (1):
      coresight: etm4x: Fix width of CCITMIN field

Jani Nikula (1):
      drm/crtc: fix uninitialized variable use

Jens Axboe (1):
      io_uring: use fget/fput consistently

Jensen Huang (1):
      i2c: rk3x: fix potential spinlock recursion on poll

Jeremy Soller (1):
      ASoC: amd: yc: Add DMI entry to support System76 Pangolin 13

Jinyang He (1):
      LoongArch: Set unwind stack type to unknown rather than set error flag

Johannes Berg (2):
      wifi: cfg80211: lock wiphy mutex for rfkill poll
      debugfs: fix automount d_fsdata usage

José Pekkarinen (1):
      Input: psmouse - enable Synaptics InterTouch for ThinkPad L14 G1

Judy Hsiao (1):
      neighbour: Don't let neigh_forced_gc() disable preemption for long

Junxiao Bi (1):
      Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Kamil Duljas (3):
      ASoC: Intel: Skylake: Fix mem leak in few functions
      ASoC: SOF: topology: Fix mem leak in sof_dai_load()
      ASoC: Intel: Skylake: mem leak in skl register function

Keith Busch (4):
      nvme-core: check for too small lba shift
      nvme: introduce helper function to get ctrl state
      nvme: ensure reset state check ordering
      nvme-ioctl: move capable() admin check to the end

Krzysztof Kozlowski (3):
      stmmac: dwmac-loongson: drop useless check for compatible fallback
      MIPS: dts: loongson: drop incorrect dwmac fallback compatible
      reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning

LeoLiuoc (1):
      PCI: Add ACS quirk for more Zhaoxin Root Ports

Lewis Huang (1):
      drm/amd/display: Pass pwrseq inst for backlight and ABM

Lijo Lazar (2):
      drm/amdgpu: Use another offset for GC 9.4.3 remap
      drm/amdgpu: Add NULL checks for function pointers

Linus Torvalds (2):
      posix-timers: Get rid of [COMPAT_]SYS_NI() uses
      x86/csum: clean up `csum_partial' further

Lu Yao (1):
      drm/amdgpu: Fix cat debugfs amdgpu_regs_didt causes kernel null pointer

Luca Weiss (1):
      Input: xpad - add Razer Wolverine V2 support

Maciej Strozek (2):
      ASoC: cs43130: Fix the position of const qualifier
      ASoC: cs43130: Fix incorrect frame delay configuration

Mario Limonciello (5):
      pinctrl: amd: Mask non-wake source pins with interrupt enabled at suspend
      platform/x86/amd/pmc: Move platform defines to header
      platform/x86/amd/pmc: Only run IRQ1 firmware version check on Cezanne
      platform/x86/amd/pmc: Move keyboard wakeup disablement detection to pmc-quirks
      platform/x86/amd/pmc: Disable keyboard wakeup on AMD Framework 13

Matthew Wilcox (Oracle) (1):
      ida: Fix crash in ida_free when the bitmap is empty

Matus Malych (1):
      ASoC: amd: yc: Add HP 255 G10 into quirk table

Maurizio Lombardi (1):
      nvme-core: fix a memory leak in nvme_ns_info_from_identify()

Maxime Ripard (1):
      kunit: Warn if tests are slow

Michael-CY Lee (1):
      wifi: avoid offset calculation on NULL pointer

Michal Wajdeczko (1):
      kunit: Reset suite counter right before running tests

Mike Snitzer (1):
      dm audit: fix Kconfig so DM_AUDIT depends on BLK_DEV_DM

Ming Lei (1):
      blk-mq: don't count completed flush data request as inflight in case of quiesce

Mukul Joshi (1):
      drm/amdkfd: Use common function for IP version check

Namjae Jeon (1):
      ksmbd: don't allow O_TRUNC open on read-only share

Nitesh Shetty (1):
      nvme: prevent potential spectre v1 gadget

Noah Goldstein (1):
      x86/csum: Remove unnecessary odd handling

Paolo Bonzini (1):
      x86/microcode: do not cache microcode if it will not be used

Patrick Rudolph (3):
      pinctrl: cy8c95x0: Fix typo
      pinctrl: cy8c95x0: Fix regression
      pinctrl: cy8c95x0: Fix get_pincfg

Paulo Alcantara (1):
      smb: client: fix potential OOB in smb2_dump_detail()

Peter Ujfalusi (6):
      ALSA: hda: intel-nhlt: Ignore vbps when looking for DMIC 32 bps format
      ASoC: Intel: skl_hda_dsp_generic: Drop HDMI routes when HDMI is not available
      ASoC: hdac_hda: Conditionally register dais for HDMI and Analog
      ASoC: SOF: ipc4-topology: Correct data structures for the SRC module
      ASoC: SOF: ipc4-topology: Correct data structures for the GAIN module
      ASoC: SOF: Intel: hda-codec: Delay the codec device registration

Philip Yang (1):
      drm/amdkfd: svm range always mapped flag not working on APU

Ranjani Sridharan (2):
      ASoC: SOF: ipc4-topology: Add core_mask in struct snd_sof_pipeline
      ASoC: SOF: sof-audio: Modify logic for enabling/disabling topology cores

Ricardo Rivera-Matos (3):
      ASoC: cs35l45: Use modern pm_ops
      ASoC: cs35l45: Prevent IRQ handling when suspending/resuming
      ASoC: cs35l45: Prevents spinning during runtime suspend

Rob Herring (1):
      arm64: dts: rockchip: Fix PCI node addresses on rk3399-gru

Ryan McClelland (1):
      HID: nintendo: fix initializer element is not constant error

Sarannya S (1):
      net: qrtr: ns: Return 0 if server port is not present

Shannon Nelson (3):
      pds_vdpa: fix up format-truncation complaint
      pds_vdpa: clear config callback when status goes to 0
      pds_vdpa: set features order

Shengjiu Wang (2):
      ASoC: fsl_xcvr: Enable 2 * TX bit clock for spdif only case
      ASoC: fsl_xcvr: refine the requested phy clock frequency

Shuming Fan (1):
      ASoC: rt5650: add mutex to avoid the jack detection failure

Siddh Raman Pant (1):
      nfc: Do not send datagram if socket state isn't LLCP_BOUND

Sjoerd Simons (2):
      bus: moxtet: Mark the irq as shared
      bus: moxtet: Add spi device table

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for ASUS Zenbook 2022 Models

Stefan Hajnoczi (1):
      virtio_blk: fix snprintf truncation compiler warning

Stefan Wahren (1):
      ARM: sun9i: smp: fix return code check of of_property_match_string

Steven Rostedt (Google) (3):
      tracing: Have large events show up as '[LINE TOO BIG]' instead of nothing
      tracing: Add size check when printing trace_marker output
      ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI

Sumanth Korikkar (1):
      mm/memory_hotplug: fix memmap_on_memory sysfs value retrieval

Thinh Tran (1):
      net/tg3: fix race condition in tg3_reset_task()

Tom Jason Schwanke (1):
      ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP Envy X360 13-ay0xxx

Vasiliy Kovalev (1):
      ALSA: hda - Fix speaker and headset mic pin config for CHUWI CoreBook XPro

Vineet Gupta (2):
      ARC: fix spare error
      ARC: fix smatch warning

Vineeth Vijayan (1):
      s390/scm: fix virtual vs physical address confusion

Vishnu Sankar (1):
      platform/x86: thinkpad_acpi: fix for incorrect fan reporting on some ThinkPad systems

WANG Rui (1):
      LoongArch: Apply dynamic relocations for LLD

Wang Yao (1):
      efi/loongarch: Use load address to calculate kernel entry address

Wayne Lin (1):
      drm/amd/display: Add case for dcn35 to support usb4 dmub hpd event

Weihao Li (1):
      clk: rockchip: rk3128: Fix HCLK_OTG gate register

Xiang Yang (1):
      drm/exynos: fix a potential error pointer dereference

Ye Bin (1):
      jbd2: fix soft lockup in journal_finish_inode_data_buffers()

Yicong Yang (2):
      hwtracing: hisi_ptt: Handle the interrupt in hardirq context
      hwtracing: hisi_ptt: Don't try to attach a task

Yu Kuai (1):
      block: warn once for each partition in bio_check_ro()

Zhang Yi (2):
      jbd2: correct the printing of write_flags in jbd2_write_superblock()
      jbd2: increase the journal IO's priority

ZhenGuo Yin (1):
      drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit

Zheng Yejian (1):
      tracing: Fix uaf issue when open the hist or hist_debug file

Ziqi Zhao (1):
      drm/crtc: Fix uninit-value bug in drm_mode_setcrtc

wangkeqi (1):
      connector: Fix proc_event_num_listeners count not cleared


