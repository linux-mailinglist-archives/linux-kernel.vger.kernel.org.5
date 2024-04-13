Return-Path: <linux-kernel+bounces-143716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBDC8A3C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDD41C20C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9134437F;
	Sat, 13 Apr 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U0U5PzLG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C60481AB;
	Sat, 13 Apr 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007581; cv=none; b=ap4CTUKHoHLyV0nfW4pny3/Sv2EmZKiDDMHSnao8Pil9rYIPGMqoK+glmfMENo3q2oX5OKch1/B+ZbefZLXNZZT+g3oLWuQCwgLR9Q+sDlHa+/AnDtSvZgtYFURsbyePkAx/Zfa6NB0RoB6ofapGT5EC9N33mdRo026wQMrhmPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007581; c=relaxed/simple;
	bh=8tokHfWXmpxbfIlDktgzI1eCQzQ8HSR7/p8rDOrc0ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6LBCTz00iZiHsiQHJdthX8CfdJnkonhC2Bm3Jx6NXswsCze/ye2b2/7s+AgSUp9qCG/7mvdeIWnQdmXQUG/lQUMvusW7uuEXTmXeocxdLiazGYAwwMrykwOl2YGfE4M2Skhz+3YOerGGsulIlmJijoQzvh4l7dI6FoP58xYpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U0U5PzLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2AFC2BBFC;
	Sat, 13 Apr 2024 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713007581;
	bh=8tokHfWXmpxbfIlDktgzI1eCQzQ8HSR7/p8rDOrc0ws=;
	h=From:To:Cc:Subject:Date:From;
	b=U0U5PzLGn7LjfMhsePaTU6CVp3RFmU69P5S50NzYIq6ZLJwy6xKuRfTsRNYxbE/m2
	 Q70WfVopCOnbykSmFF3tSdITewJbPaBD4Ykf9hgw/ypHD3zSYQcbmERWjmuaZCG1/n
	 wR8oFvPeCgY0df6CtjBrWcifQsPT6p3ad1/cp9sU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.86
Date: Sat, 13 Apr 2024 13:26:08 +0200
Message-ID: <2024041309-imminent-spousal-c099@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.86 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                        |    2 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                        |   11 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                        |   12 +-
 arch/x86/events/amd/lbr.c                                       |    6 -
 block/blk-stat.c                                                |    2 
 drivers/acpi/sleep.c                                            |   12 --
 drivers/bluetooth/btintel.c                                     |    2 
 drivers/bluetooth/btmtk.c                                       |    1 
 drivers/bluetooth/btmtk.h                                       |    1 
 drivers/bus/mhi/host/init.c                                     |    1 
 drivers/bus/mhi/host/internal.h                                 |    9 +
 drivers/bus/mhi/host/pm.c                                       |   20 +++
 drivers/cpufreq/cpufreq.c                                       |   17 ++-
 drivers/cpuidle/driver.c                                        |    3 
 drivers/firmware/tegra/bpmp-debugfs.c                           |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                        |    4 
 drivers/gpu/drm/amd/display/modules/inc/mod_stats.h             |    4 
 drivers/gpu/drm/drm_panel_orientation_quirks.c                  |   12 ++
 drivers/gpu/drm/vc4/vc4_plane.c                                 |    5 
 drivers/infiniband/core/cm.c                                    |   20 +++
 drivers/input/rmi4/rmi_driver.c                                 |    6 -
 drivers/input/touchscreen/imagis.c                              |   20 +--
 drivers/media/pci/sta2x11/sta2x11_vip.c                         |    9 -
 drivers/misc/vmw_vmci/vmci_datagram.c                           |    6 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                 |    9 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c             |    2 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c                |   14 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                   |    9 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.h                   |    9 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                 |    5 
 drivers/net/pcs/pcs-xpcs.c                                      |    4 
 drivers/net/wireless/ath/ath11k/mhi.c                           |    2 
 drivers/net/wireless/ath/ath9k/antenna.c                        |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c          |    9 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                   |    1 
 drivers/net/wireless/realtek/rtw89/pci.h                        |    2 
 drivers/nvme/host/pci.c                                         |    3 
 drivers/pinctrl/renesas/core.c                                  |    4 
 drivers/platform/x86/intel/vbtn.c                               |    5 
 drivers/platform/x86/touchscreen_dmi.c                          |    9 +
 drivers/scsi/lpfc/lpfc_nportdisc.c                              |    6 -
 drivers/scsi/scsi_lib.c                                         |   52 +++++-----
 drivers/scsi/sd.c                                               |    4 
 drivers/soundwire/dmi-quirks.c                                  |    8 +
 drivers/thermal/thermal_of.c                                    |   12 +-
 drivers/thunderbolt/quirks.c                                    |   14 ++
 drivers/thunderbolt/tb.c                                        |   49 +++++++++
 drivers/thunderbolt/tb.h                                        |    4 
 drivers/tty/n_gsm.c                                             |    3 
 drivers/usb/gadget/function/uvc_video.c                         |    3 
 drivers/usb/host/sl811-hcd.c                                    |    2 
 drivers/usb/typec/tcpm/tcpci.c                                  |    1 
 drivers/video/fbdev/core/fbmon.c                                |    7 -
 drivers/video/fbdev/via/accel.c                                 |    4 
 drivers/virtio/virtio.c                                         |   10 +
 fs/btrfs/export.c                                               |    9 +
 fs/btrfs/send.c                                                 |   10 +
 fs/btrfs/volumes.c                                              |   12 ++
 fs/ext4/mballoc.c                                               |    5 
 fs/ext4/super.c                                                 |   12 ++
 fs/isofs/inode.c                                                |   18 +++
 fs/orangefs/super.c                                             |    2 
 fs/pstore/zone.c                                                |    2 
 fs/sysv/itree.c                                                 |   10 -
 include/linux/randomize_kstack.h                                |    2 
 include/linux/rcupdate.h                                        |    4 
 include/linux/skbuff.h                                          |   11 ++
 include/linux/sunrpc/sched.h                                    |    2 
 include/scsi/scsi_device.h                                      |   51 ++-------
 include/uapi/linux/input-event-codes.h                          |    1 
 io_uring/io_uring.c                                             |   25 +++-
 kernel/dma/direct.c                                             |    9 -
 kernel/panic.c                                                  |    8 +
 kernel/trace/ring_buffer.c                                      |    2 
 net/mpls/mpls_gso.c                                             |    3 
 net/netfilter/nf_tables_api.c                                   |   47 ++++++---
 net/smc/smc_pnet.c                                              |   10 +
 scripts/gcc-plugins/stackleak_plugin.c                          |    2 
 sound/firewire/amdtp-stream.c                                   |   12 +-
 sound/firewire/amdtp-stream.h                                   |    4 
 sound/soc/intel/boards/sof_sdw.c                                |   11 ++
 sound/soc/soc-core.c                                            |    3 
 tools/iio/iio_utils.c                                           |    2 
 tools/lib/perf/evlist.c                                         |   18 ++-
 tools/lib/perf/include/internal/evlist.h                        |    4 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c |    1 
 tools/testing/ktest/ktest.pl                                    |    1 
 87 files changed, 544 insertions(+), 224 deletions(-)

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

David Hildenbrand (1):
      virtio: reenable config if freezing device failed

David Sterba (3):
      btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
      btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
      btrfs: send: handle path ref underflow in header iterate_inode_ref()

Dmitry Antipov (1):
      wifi: ath9k: fix LNA selection in ath_ant_try_scan()

Duje Mihanović (1):
      Input: imagis - use FIELD_GET where applicable

Edward Adam Davis (1):
      Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Eric Dumazet (1):
      net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()

Florian Westphal (2):
      net: skbuff: add overflow debug check to pull/push helpers
      net: mpls: error out if inner headers are not set

Geert Uytterhoeven (1):
      pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs

Gergo Koteles (1):
      Input: allocate keycode for Display refresh rate toggle

Greg Kroah-Hartman (3):
      Revert "scsi: sd: usb_storage: uas: Access media prior to querying device properties"
      Revert "scsi: core: Add struct for args to execution functions"
      Linux 6.1.86

Gwendal Grignou (1):
      platform/x86: intel-vbtn: Update tablet mode switch at end of probe

Hans de Goede (1):
      wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro

Harshit Mogalapalli (1):
      VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()

Ian Rogers (1):
      libperf evlist: Avoid out-of-bounds access

Jacob Keller (1):
      ice: use relative VSI index for VFs instead of PF VSI number

Jeffrey Hugo (1):
      bus: mhi: host: Add MHI_PM_SYS_ERR_FAIL state

Jens Axboe (1):
      io_uring: clear opcode specific data for an early failure

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
      bnx2x: Fix firmware version string character counts
      randomize_kstack: Improve entropy diffusion

Konrad Dybcio (1):
      thermal/of: Assume polling-delay(-passive) 0 when absent

Kunwu Chan (2):
      pstore/zone: Add a null pointer check to the psz_kmsg_read
      Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails

Luiz Augusto von Dentz (1):
      Bluetooth: btintel: Fixe build regression

Ma Jun (1):
      Revert "drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()"

Manjunath Patil (1):
      RDMA/cm: add timeout to cm_destroy_id wait

Marco Felsch (1):
      usb: typec: tcpci: add generic tcpci fallback compatible

Markus Elfring (1):
      firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()

Markuss Broks (1):
      input/touchscreen: imagis: Correct the maximum touch area value

Martin K. Petersen (1):
      scsi: sd: usb_storage: uas: Access media prior to querying device properties

Maíra Canal (1):
      drm/vc4: don't check if plane->state->fb == state->fb

Michael Grzeschik (1):
      usb: gadget: uvc: mark incomplete frames with UVC_STREAM_ERR

Mika Westerberg (1):
      thunderbolt: Keep the domain powered when USB4 port is in redrive mode

Mike Marshall (1):
      Julia Lawall reported this null pointer dereference, this should fix it.

Mukesh Sisodiya (1):
      wifi: iwlwifi: pcie: Add the PCI device id for new hardware

Pablo Neira Ayuso (3):
      netfilter: nf_tables: release batch on table validation from abort path
      netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path
      netfilter: nf_tables: discard table flag update with pending basechain deletion

Paul E. McKenney (1):
      rcu-tasks: Repair RCU Tasks Trace quiescence check

Petre Rodan (1):
      tools: iio: replace seekdir() in iio_generic_buffer

Ping-Ke Shih (1):
      wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX descriptor

Ricardo B. Marliere (1):
      ktest: force $buildonly = 1 for 'make_warnings_file' test type

Rick Edgecombe (1):
      dma-direct: Leak pages on dma_set_decrypted() failure

Roman Smirnov (2):
      block: prevent division by zero in blk_rq_stat_sum()
      fbmon: prevent division by zero in fb_videomode_from_videomode()

Samasth Norway Ananda (1):
      tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()

Samuel Dionne-Riel (1):
      drm: panel-orientation-quirks: Add quirk for GPD Win Mini

Sandipan Das (1):
      perf/x86/amd/lbr: Discard erroneous branch entries

Serge Semin (1):
      net: pcs: xpcs: Return EINVAL in the internal methods

Shannon Nelson (1):
      ionic: set adminq irq affinity

Srinivasan Shanmugam (1):
      drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()

Takashi Iwai (1):
      Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922

Takashi Sakamoto (1):
      ALSA: firewire-lib: handle quirk to calculate payload quadlets as data block counter

Tetsuo Handa (1):
      sysv: don't call sb_bread() with pointers_lock held

Thadeu Lima de Souza Cascardo (1):
      tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc

Vasiliy Kovalev (1):
      VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()

Viresh Kumar (1):
      cpufreq: Don't unregister cpufreq cooling on CPU hotplug

Ye Bin (1):
      ext4: forbid commit inconsistent quota data when errors=remount-ro

Zhang Yi (1):
      ext4: add a hint for block bitmap corrupt state in mb_groups

linke li (1):
      ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment

mosomate (1):
      ASoC: Intel: common: DMI remap for rebranded Intel NUC M15 (LAPRC710) laptops


