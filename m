Return-Path: <linux-kernel+bounces-143714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24188A3C88
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86862281A0A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F2145979;
	Sat, 13 Apr 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BWgTnGtf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C63D0D9;
	Sat, 13 Apr 2024 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007573; cv=none; b=Pb53uOVm8F3s75/RbQ4pV3cfOT6Fp1zR9wK2SFXdos4or61C7iIVycmmzAMuqrkNEhyUrm7YF/3UZe7FtN1/Z1v2/zu1y0N0exmVRLU/IpHjgLG0KdmzUN3BkypPzmcYaNeHdoWUIWE3nioFWawYDL7lCn47+Kzsv2sbGWjlHnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007573; c=relaxed/simple;
	bh=+axVwe0Os63xnSLMNadrqjCCm0VsjxKoadFiyPwTbi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pyTAwYJpIqFVPFBsJ56wVeA9FEYyBKxdBTyhndWy5Q31RULUWF3sYk6pffmonBlAha4rbQTgFzYNb+fia+VCV5CudaF9nZdOFy9G4Wr28UaGesofd2z9jBfb2pFrJvS93E9T9MvdgWvJ4tOFGurPgDr1NsaxVzcdLQac5TI1rTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BWgTnGtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E1AC2BBFC;
	Sat, 13 Apr 2024 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713007572;
	bh=+axVwe0Os63xnSLMNadrqjCCm0VsjxKoadFiyPwTbi4=;
	h=From:To:Cc:Subject:Date:From;
	b=BWgTnGtf34Sp6AQCGP64EIMC3AU3NHyqvMNed5MJwOW8OZL5WGsY+5bRF/KjAgY4v
	 sCagOTPVvlWIIvAV3DxZrG7fImrm9DAg7wRpV6kfWuZw1sjRUpPqrHeYUNhnX4fan+
	 BtdHm7jr3P+R2Z+nrAU3Ca4pWoDqBDzqk2/VlwD8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.155
Date: Sat, 13 Apr 2024 13:25:59 +0200
Message-ID: <2024041300-twins-siberian-dcdc@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.155 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                        |    2 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                        |   11 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                        |   12 ++
 arch/x86/mm/pat/memtype.c                                       |   49 +++++++---
 block/blk-stat.c                                                |    2 
 drivers/acpi/cppc_acpi.c                                        |   27 -----
 drivers/acpi/sleep.c                                            |   12 --
 drivers/bluetooth/btintel.c                                     |    2 
 drivers/cpuidle/driver.c                                        |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                        |    4 
 drivers/gpu/drm/amd/display/modules/inc/mod_stats.h             |    4 
 drivers/infiniband/core/cm.c                                    |   20 +++-
 drivers/input/rmi4/rmi_driver.c                                 |    6 +
 drivers/media/pci/sta2x11/sta2x11_vip.c                         |    9 -
 drivers/misc/vmw_vmci/vmci_datagram.c                           |    6 -
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                 |    5 -
 drivers/net/pcs/pcs-xpcs.c                                      |    4 
 drivers/net/wireless/ath/ath11k/mhi.c                           |    2 
 drivers/net/wireless/ath/ath9k/antenna.c                        |    2 
 drivers/nvme/host/pci.c                                         |    3 
 drivers/pinctrl/renesas/core.c                                  |    4 
 drivers/platform/x86/intel/vbtn.c                               |    5 -
 drivers/platform/x86/touchscreen_dmi.c                          |    9 +
 drivers/scsi/lpfc/lpfc_nportdisc.c                              |    6 -
 drivers/tty/n_gsm.c                                             |    3 
 drivers/usb/host/sl811-hcd.c                                    |    2 
 drivers/usb/typec/tcpm/tcpci.c                                  |    1 
 drivers/video/fbdev/core/fbmon.c                                |    7 -
 drivers/video/fbdev/via/accel.c                                 |    4 
 drivers/virtio/virtio.c                                         |   10 +-
 fs/btrfs/export.c                                               |    9 +
 fs/btrfs/send.c                                                 |   10 +-
 fs/btrfs/volumes.c                                              |   12 ++
 fs/ext4/mballoc.c                                               |    5 -
 fs/ext4/super.c                                                 |   12 ++
 fs/isofs/inode.c                                                |   18 +++
 fs/pstore/zone.c                                                |    2 
 fs/sysv/itree.c                                                 |   10 --
 include/linux/randomize_kstack.h                                |    2 
 include/linux/sunrpc/sched.h                                    |    2 
 include/uapi/linux/input-event-codes.h                          |    1 
 kernel/panic.c                                                  |    8 +
 kernel/trace/ring_buffer.c                                      |    2 
 mm/memory.c                                                     |    4 
 net/dsa/dsa2.c                                                  |   25 +----
 net/netfilter/nf_tables_api.c                                   |   47 +++++++--
 net/smc/smc_pnet.c                                              |   10 ++
 scripts/gcc-plugins/stackleak_plugin.c                          |    6 +
 sound/firewire/amdtp-stream.c                                   |   12 +-
 sound/firewire/amdtp-stream.h                                   |    4 
 sound/soc/soc-core.c                                            |    3 
 tools/iio/iio_utils.c                                           |    2 
 tools/lib/perf/evlist.c                                         |   18 ++-
 tools/lib/perf/include/internal/evlist.h                        |    4 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c |    1 
 tools/testing/ktest/ktest.pl                                    |    1 
 56 files changed, 321 insertions(+), 145 deletions(-)

Alban Boyé (1):
      platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet

Aleksandr Burakov (1):
      fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2

Alex Henrie (1):
      isofs: handle CDs with bad root inode but good Joliet root directory

Ard Biesheuvel (1):
      gcc-plugins/stackleak: Avoid .head.text section

Aric Cyr (1):
      drm/amd/display: Fix nanosec stat overflow

Arnd Bergmann (1):
      media: sta2x11: fix irq handler cast

Baochen Qiang (1):
      wifi: ath11k: decrease MHI channel buffer length to 8KB

C Cheng (1):
      cpuidle: Avoid potential overflow in integer multiplication

Chancel Liu (1):
      ASoC: soc-core.c: Skip dummy codec when adding platforms

Colin Ian King (1):
      usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined

Dai Ngo (1):
      SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int

Daniel Drake (1):
      Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"

Dave Airlie (1):
      amdkfd: use calloc instead of kzalloc to avoid integer overflow

David Hildenbrand (2):
      virtio: reenable config if freezing device failed
      x86/mm/pat: fix VM_PAT handling in COW mappings

David Sterba (3):
      btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
      btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
      btrfs: send: handle path ref underflow in header iterate_inode_ref()

Dmitry Antipov (1):
      wifi: ath9k: fix LNA selection in ath_ant_try_scan()

Edward Adam Davis (1):
      Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Eric Dumazet (1):
      net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()

Geert Uytterhoeven (1):
      pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs

Gergo Koteles (1):
      Input: allocate keycode for Display refresh rate toggle

Greg Kroah-Hartman (2):
      Revert "ACPI: CPPC: Use access_width over bit_width for system memory accesses"
      Linux 5.15.155

Gwendal Grignou (1):
      platform/x86: intel-vbtn: Update tablet mode switch at end of probe

Harshit Mogalapalli (1):
      VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()

Ian Rogers (1):
      libperf evlist: Avoid out-of-bounds access

Jiawei Fu (iBug) (1):
      drivers/nvme: Add quirks for device 126f:2262

Johan Jonker (2):
      arm64: dts: rockchip: fix rk3328 hdmi ports node
      arm64: dts: rockchip: fix rk3399 hdmi ports node

John Ogness (1):
      panic: Flush kernel log buffer at the end

Justin Tee (1):
      scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()

Kees Cook (2):
      gcc-plugins/stackleak: Ignore .noinstr.text and .entry.text
      randomize_kstack: Improve entropy diffusion

Kunwu Chan (2):
      pstore/zone: Add a null pointer check to the psz_kmsg_read
      Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails

Luiz Augusto von Dentz (1):
      Bluetooth: btintel: Fixe build regression

Manjunath Patil (1):
      RDMA/cm: add timeout to cm_destroy_id wait

Marco Felsch (1):
      usb: typec: tcpci: add generic tcpci fallback compatible

Pablo Neira Ayuso (3):
      netfilter: nf_tables: release batch on table validation from abort path
      netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path
      netfilter: nf_tables: discard table flag update with pending basechain deletion

Petre Rodan (1):
      tools: iio: replace seekdir() in iio_generic_buffer

Ricardo B. Marliere (1):
      ktest: force $buildonly = 1 for 'make_warnings_file' test type

Roman Smirnov (2):
      block: prevent division by zero in blk_rq_stat_sum()
      fbmon: prevent division by zero in fb_videomode_from_videomode()

Samasth Norway Ananda (1):
      tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()

Serge Semin (1):
      net: pcs: xpcs: Return EINVAL in the internal methods

Shannon Nelson (1):
      ionic: set adminq irq affinity

Takashi Sakamoto (1):
      ALSA: firewire-lib: handle quirk to calculate payload quadlets as data block counter

Tetsuo Handa (1):
      sysv: don't call sb_bread() with pointers_lock held

Thadeu Lima de Souza Cascardo (1):
      tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc

Vasiliy Kovalev (1):
      VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()

Vladimir Oltean (1):
      net: dsa: fix panic when DSA master device unbinds on shutdown

Ye Bin (1):
      ext4: forbid commit inconsistent quota data when errors=remount-ro

Zhang Yi (1):
      ext4: add a hint for block bitmap corrupt state in mb_groups

linke li (1):
      ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment


