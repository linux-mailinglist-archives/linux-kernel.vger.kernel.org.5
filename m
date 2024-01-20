Return-Path: <linux-kernel+bounces-31773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE88333C9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CE1283A55
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB97FC0A;
	Sat, 20 Jan 2024 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xBETeuxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFACFC01;
	Sat, 20 Jan 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749066; cv=none; b=K9ZK27NGuUJl/kLHLkE63l5pnzp1AEkdM3Huhd3pThzH0Pp+1sL484j54f7s6ZUOMqbDmaEelIxzF9ht7asbM79KY3lPVJ8U97ZNjsZwtQWGNtwcoQDoLPTPuV/lDKXV2uw399tR8wxE9EwHa2jwpg5m/bACC3vIUG4kEBErkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749066; c=relaxed/simple;
	bh=JlHqoTvTYv3C+QGZqHaBYjMn5XAkMQZSx3P0YfGDTOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c94MAj5Hv0z9eV8NAD2v+aBbwfvNmvrBaeMhNrD9ZN86waVe0DCqLkx/2qYRzVhHxufi3BS5gsP42wEwJolkCIVNNy7jyjL5pUG3UvvvY7/D6nVvF/W5wRYqKZmIZYjJyr4RTp4uMMNBVWcSYKGgdVhGRHCWg+/IH1fmCu4f/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xBETeuxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACC1C433F1;
	Sat, 20 Jan 2024 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705749065;
	bh=JlHqoTvTYv3C+QGZqHaBYjMn5XAkMQZSx3P0YfGDTOI=;
	h=From:To:Cc:Subject:Date:From;
	b=xBETeuxZj6tfpsi7jfmayNirmX0YzYqzh0Hm6A+oS4ajTnmKl7ls8U5fPoJirJ1U4
	 Rtqk5ZS1vlGrBvojjoRsb4FxuKdo2lF9qEnKYD1K4PpxuAMsbU44uPCr1Hmyx3NL24
	 fbOHWd8ym2zr1ErywnT/L4q65Nyei+kgWGcLzKjY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.74
Date: Sat, 20 Jan 2024 12:10:54 +0100
Message-ID: <2024012055-moonwalk-revival-75bd@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.74 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arc/kernel/signal.c                                       |    6 
 arch/arm/mach-sunxi/mc_smp.c                                   |    4 
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi        |    3 
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts       |    4 
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                   |    1 
 arch/arm64/boot/dts/rockchip/rk356x.dtsi                       |    2 
 arch/loongarch/include/asm/elf.h                               |    2 
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi             |    3 
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi                      |    3 
 block/blk-mq.c                                                 |   14 +
 drivers/acpi/resource.c                                        |    7 
 drivers/android/binder.c                                       |    2 
 drivers/android/binder_alloc.c                                 |   10 -
 drivers/block/virtio_blk.c                                     |    8 
 drivers/clk/rockchip/clk-rk3128.c                              |    2 
 drivers/clk/rockchip/clk-rk3568.c                              |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                    |    6 
 drivers/gpu/drm/amd/amdgpu/soc15.c                             |   12 -
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c             |   19 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |    8 
 drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h    |    2 
 drivers/gpu/drm/drm_crtc.c                                     |    8 
 drivers/gpu/drm/exynos/exynos_drm_dma.c                        |    8 
 drivers/gpu/drm/exynos/exynos_hdmi.c                           |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c             |    2 
 drivers/hid/hid-nintendo.c                                     |   71 ++++---
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
 drivers/net/ethernet/broadcom/tg3.c                            |   11 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c           |    5 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                   |    2 
 drivers/nvme/host/core.c                                       |   12 -
 drivers/nvme/host/nvme.h                                       |    5 
 drivers/nvme/target/configfs.c                                 |    3 
 drivers/parport/parport_serial.c                               |   64 ++++++
 drivers/pci/quirks.c                                           |    8 
 drivers/pinctrl/cirrus/Kconfig                                 |    3 
 drivers/pinctrl/pinctrl-cy8c95x0.c                             |    4 
 drivers/platform/x86/intel/vbtn.c                              |   19 +
 drivers/platform/x86/thinkpad_acpi.c                           |   98 ++++++++--
 drivers/reset/hisilicon/hi6220_reset.c                         |    2 
 drivers/s390/block/scm_blk.c                                   |    7 
 drivers/uio/uio.c                                              |    7 
 fs/debugfs/file.c                                              |    8 
 fs/debugfs/inode.c                                             |   27 ++
 fs/debugfs/internal.h                                          |   10 -
 fs/f2fs/xattr.c                                                |    6 
 fs/jbd2/commit.c                                               |   10 -
 fs/jbd2/journal.c                                              |   24 +-
 fs/smb/client/cifspdu.h                                        |   24 +-
 fs/smb/client/cifssmb.c                                        |    6 
 fs/smb/client/smb2misc.c                                       |   30 +--
 fs/smb/client/smb2ops.c                                        |    6 
 fs/smb/client/smb2pdu.c                                        |    8 
 fs/smb/client/smb2pdu.h                                        |   16 -
 fs/smb/common/smb2pdu.h                                        |   17 +
 fs/smb/server/smb2pdu.c                                        |   23 --
 fs/smb/server/smbacl.c                                         |   11 -
 include/linux/ieee80211.h                                      |    4 
 include/linux/jbd2.h                                           |    3 
 init/Kconfig                                                   |    2 
 kernel/trace/ring_buffer.c                                     |    6 
 kernel/trace/trace.c                                           |   12 +
 kernel/trace/trace.h                                           |    1 
 kernel/trace/trace_events_hist.c                               |   12 -
 kernel/trace/trace_output.c                                    |    6 
 lib/Kconfig.debug                                              |    9 
 lib/idr.c                                                      |    2 
 lib/test_ida.c                                                 |   40 ++++
 net/core/neighbour.c                                           |    9 
 net/mac80211/ht.c                                              |    1 
 net/mptcp/options.c                                            |    1 
 net/qrtr/ns.c                                                  |    4 
 net/wireless/core.c                                            |    2 
 scripts/decode_stacktrace.sh                                   |   19 +
 scripts/pahole-flags.sh                                        |    7 
 sound/hda/intel-nhlt.c                                         |   33 ++-
 sound/pci/hda/patch_realtek.c                                  |   16 +
 sound/soc/amd/yc/acp6x-mach.c                                  |    7 
 sound/soc/codecs/cs43130.c                                     |    6 
 sound/soc/codecs/da7219-aad.c                                  |    2 
 sound/soc/codecs/hdac_hda.c                                    |   23 ++
 sound/soc/codecs/nau8822.c                                     |    9 
 sound/soc/codecs/rt5645.c                                      |   10 -
 sound/soc/codecs/wm8974.c                                      |    6 
 sound/soc/intel/boards/bytcr_rt5640.c                          |   31 ++-
 sound/soc/intel/boards/skl_hda_dsp_generic.c                   |    2 
 sound/soc/intel/skylake/skl-pcm.c                              |    9 
 sound/soc/intel/skylake/skl-sst-ipc.c                          |    4 
 sound/soc/soc-ops.c                                            |    2 
 sound/soc/sof/intel/hda-codec.c                                |   18 -
 tools/testing/selftests/alsa/mixer-test.c                      |    2 
 102 files changed, 840 insertions(+), 283 deletions(-)

Alan Maguire (1):
      bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25

Armin Wolf (1):
      hwmon: (corsair-psu) Fix probe when built-in

Avraham Stern (1):
      wifi: iwlwifi: pcie: avoid a NULL pointer dereference

Ben Greear (1):
      wifi: mac80211: handle 320 MHz in ieee80211_ht_cap_ie_to_sta_ht_cap

Cameron Williams (2):
      parport: parport_serial: Add Brainboxes BAR details
      parport: parport_serial: Add Brainboxes device IDs and geometry

Carlos Llamas (5):
      binder: use EPOLLERR from eventpoll.h
      binder: fix use-after-free in shinker's callback
      binder: fix trivial typo of binder_free_buf_locked()
      binder: fix comment on binder_alloc_new_buf() return value
      scripts/decode_stacktrace.sh: optionally use LLVM utilities

Charlene Liu (1):
      drm/amd/display: get dprefclk ss info from integration info table

Charles Keepax (2):
      pinctrl: lochnagar: Don't build on MIPS
      ASoC: wm8974: Correct boost mixer inputs

Chris Morgan (1):
      clk: rockchip: rk3568: Add PLL rate for 292.5MHz

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

Florian Eckert (1):
      leds: ledtrig-tty: Free allocated ttyname buffer on deactivate

Ghanshyam Agrawal (1):
      kselftest: alsa: fixed a print formatting warning

Greg Kroah-Hartman (1):
      Linux 6.1.74

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

Heiko Stuebner (1):
      arm64: dts: rockchip: fix rk356x pcie msg interrupt name

Hengqi Chen (1):
      LoongArch: Preserve syscall nr across execve()

Inki Dae (1):
      drm/exynos: fix a wrong error checking

James Clark (1):
      coresight: etm4x: Fix width of CCITMIN field

Jani Nikula (1):
      drm/crtc: fix uninitialized variable use

Jensen Huang (1):
      i2c: rk3x: fix potential spinlock recursion on poll

Jeremy Soller (1):
      ASoC: amd: yc: Add DMI entry to support System76 Pangolin 13

Johannes Berg (2):
      wifi: cfg80211: lock wiphy mutex for rfkill poll
      debugfs: fix automount d_fsdata usage

José Pekkarinen (1):
      Input: psmouse - enable Synaptics InterTouch for ThinkPad L14 G1

Judy Hsiao (1):
      neighbour: Don't let neigh_forced_gc() disable preemption for long

Junxiao Bi (1):
      Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Kamil Duljas (2):
      ASoC: Intel: Skylake: Fix mem leak in few functions
      ASoC: Intel: Skylake: mem leak in skl register function

Keith Busch (2):
      nvme-core: check for too small lba shift
      nvme: introduce helper function to get ctrl state

Krzysztof Kozlowski (3):
      stmmac: dwmac-loongson: drop useless check for compatible fallback
      MIPS: dts: loongson: drop incorrect dwmac fallback compatible
      reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning

LeoLiuoc (1):
      PCI: Add ACS quirk for more Zhaoxin Root Ports

Lijo Lazar (1):
      drm/amdgpu: Add NULL checks for function pointers

Lu Yao (1):
      drm/amdgpu: Fix cat debugfs amdgpu_regs_didt causes kernel null pointer

Luca Weiss (1):
      Input: xpad - add Razer Wolverine V2 support

Maciej Strozek (2):
      ASoC: cs43130: Fix the position of const qualifier
      ASoC: cs43130: Fix incorrect frame delay configuration

Martin Rodriguez Reboredo (1):
      btf, scripts: Exclude Rust CUs with pahole

Matthew Wilcox (Oracle) (1):
      ida: Fix crash in ida_free when the bitmap is empty

Maurizio Lombardi (1):
      nvme-core: fix a memory leak in nvme_ns_info_from_identify()

Michael-CY Lee (1):
      wifi: avoid offset calculation on NULL pointer

Mike Snitzer (1):
      dm audit: fix Kconfig so DM_AUDIT depends on BLK_DEV_DM

Ming Lei (1):
      blk-mq: don't count completed flush data request as inflight in case of quiesce

Namjae Jeon (1):
      ksmbd: don't allow O_TRUNC open on read-only share

Nitesh Shetty (1):
      nvme: prevent potential spectre v1 gadget

Patrick Rudolph (2):
      pinctrl: cy8c95x0: Fix typo
      pinctrl: cy8c95x0: Fix get_pincfg

Paulo Alcantara (1):
      smb: client: fix potential OOB in smb2_dump_detail()

Peter Ujfalusi (4):
      ALSA: hda: intel-nhlt: Ignore vbps when looking for DMIC 32 bps format
      ASoC: Intel: skl_hda_dsp_generic: Drop HDMI routes when HDMI is not available
      ASoC: hdac_hda: Conditionally register dais for HDMI and Analog
      ASoC: SOF: Intel: hda-codec: Delay the codec device registration

Rob Herring (1):
      arm64: dts: rockchip: Fix PCI node addresses on rk3399-gru

Ryan McClelland (1):
      HID: nintendo: fix initializer element is not constant error

Sarannya S (1):
      net: qrtr: ns: Return 0 if server port is not present

Shuming Fan (1):
      ASoC: rt5650: add mutex to avoid the jack detection failure

Srinivas Kandagatla (1):
      ASoC: ops: add correct range check for limiting volume

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

Thinh Tran (1):
      net/tg3: fix race condition in tg3_reset_task()

Tom Jason Schwanke (1):
      ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP Envy X360 13-ay0xxx

Vasiliy Kovalev (1):
      ALSA: hda - Fix speaker and headset mic pin config for CHUWI CoreBook XPro

Vineet Gupta (1):
      ARC: fix spare error

Vineeth Vijayan (1):
      s390/scm: fix virtual vs physical address confusion

Vishnu Sankar (1):
      platform/x86: thinkpad_acpi: fix for incorrect fan reporting on some ThinkPad systems

Weihao Li (1):
      clk: rockchip: rk3128: Fix HCLK_OTG gate register

Xiang Yang (1):
      drm/exynos: fix a potential error pointer dereference

Ye Bin (1):
      jbd2: fix soft lockup in journal_finish_inode_data_buffers()

Yicong Yang (2):
      hwtracing: hisi_ptt: Handle the interrupt in hardirq context
      hwtracing: hisi_ptt: Don't try to attach a task

Zhang Yi (2):
      jbd2: correct the printing of write_flags in jbd2_write_superblock()
      jbd2: increase the journal IO's priority

Zheng Yejian (1):
      tracing: Fix uaf issue when open the hist or hist_debug file

Ziqi Zhao (1):
      drm/crtc: Fix uninit-value bug in drm_mode_setcrtc


