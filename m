Return-Path: <linux-kernel+bounces-143709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F6E8A3C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE38FB20CF3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525CA4120B;
	Sat, 13 Apr 2024 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1eAxXewU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D363F9C0;
	Sat, 13 Apr 2024 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007548; cv=none; b=UAubMTGuFyX9m6v7OJpEsZuKnygmXnDC846gasUom8x88W115lJjbxpliOW+LyPey0h5kCAzeqXQkUXpJLrFziKk/WgzKtwjs9+eXAVkPdRZd+DgAE0O/O3OiRGCfbiqtkZM0trc48IlY7FYd+juOZYqGi0KeF+FTlZWlaIrJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007548; c=relaxed/simple;
	bh=cSAUPFiBA1lPTn8bAU5ojQTzFfhYUh9iCMLoMB5qB/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LlYwfb8qQ6vQWNn5/XI/YfjvTtzhvJFNcta6ZzRfeIyq4l27fEdqh8UsbON6Fr7Kcs36yYGT1rQJG6NqkuB6d7+wfK69ExkE82IVnL3BswTwPYp+BaXmhp+r9EUaVAppVv3CjNXmdcB+C5qT1ufyvM2jfzhrHi69GZsBB51q92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1eAxXewU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ECAC2BBFC;
	Sat, 13 Apr 2024 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713007547;
	bh=cSAUPFiBA1lPTn8bAU5ojQTzFfhYUh9iCMLoMB5qB/I=;
	h=From:To:Cc:Subject:Date:From;
	b=1eAxXewUjmh24F0v16xEfRls0TY+TOcAQTs1B3aIxTxmWI3pUgDFTIrrqBpI9/Y0X
	 c6u1aDHBbMzOgFQaa/C7K15D72SMm0gbiMcsPzWpNQ0PxRp8Ecy3inlynOsLu1kXms
	 9CQ+B8pmUPjqoXTOXAbhHH04fgErl8SpDQNyoZH8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.274
Date: Sat, 13 Apr 2024 13:25:39 +0200
Message-ID: <2024041340-tutor-concierge-8c48@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.274 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/spectre.rst                   |   18 
 Documentation/admin-guide/kernel-parameters.txt                 |    6 
 Makefile                                                        |    2 
 arch/arm/boot/dts/mmp2-brownstone.dts                           |  332 ++++------
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                        |   11 
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                        |   12 
 arch/parisc/include/asm/checksum.h                              |  107 +--
 arch/powerpc/include/asm/reg_fsl_emb.h                          |   11 
 arch/powerpc/lib/Makefile                                       |    2 
 arch/s390/kernel/entry.S                                        |    1 
 arch/sparc/kernel/nmi.c                                         |    2 
 arch/sparc/vdso/vma.c                                           |    7 
 arch/x86/include/asm/cpufeature.h                               |    6 
 arch/x86/include/asm/cpufeatures.h                              |    4 
 arch/x86/include/asm/disabled-features.h                        |    3 
 arch/x86/include/asm/mmu_context.h                              |    9 
 arch/x86/include/asm/msr-index.h                                |    2 
 arch/x86/include/asm/nospec-branch.h                            |    7 
 arch/x86/include/asm/required-features.h                        |    3 
 arch/x86/include/asm/unwind_hints.h                             |    2 
 arch/x86/kernel/cpu/amd.c                                       |   10 
 arch/x86/kernel/cpu/bugs.c                                      |  117 +--
 arch/x86/kernel/cpu/common.c                                    |   19 
 arch/x86/kernel/cpu/mce/core.c                                  |    4 
 arch/x86/mm/ident_map.c                                         |   23 
 arch/x86/mm/pat.c                                               |   50 +
 block/blk-stat.c                                                |    2 
 drivers/acpi/sleep.c                                            |   12 
 drivers/ata/ahci.c                                              |    5 
 drivers/ata/sata_mv.c                                           |   63 -
 drivers/ata/sata_sx4.c                                          |    6 
 drivers/base/power/wakeirq.c                                    |    4 
 drivers/block/loop.c                                            |  185 +++--
 drivers/bluetooth/btintel.c                                     |    2 
 drivers/clk/qcom/gcc-ipq8074.c                                  |    2 
 drivers/clk/qcom/gcc-sdm845.c                                   |    1 
 drivers/clk/qcom/mmcc-apq8084.c                                 |    2 
 drivers/clk/qcom/mmcc-msm8974.c                                 |    2 
 drivers/crypto/qat/qat_common/adf_aer.c                         |   23 
 drivers/firmware/efi/vars.c                                     |   17 
 drivers/firmware/meson/meson_sm.c                               |   96 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                        |    4 
 drivers/gpu/drm/amd/display/modules/inc/mod_stats.h             |    4 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                        |    4 
 drivers/gpu/drm/exynos/exynos_hdmi.c                            |    4 
 drivers/gpu/drm/i915/gt/intel_engine_pm.c                       |    3 
 drivers/gpu/drm/i915/gt/intel_lrc.c                             |    3 
 drivers/gpu/drm/imx/parallel-display.c                          |    4 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                  |    2 
 drivers/gpu/drm/vkms/vkms_drv.c                                 |    2 
 drivers/hwmon/amc6821.c                                         |   11 
 drivers/input/rmi4/rmi_driver.c                                 |    6 
 drivers/md/dm-integrity.c                                       |    2 
 drivers/md/dm-raid.c                                            |    2 
 drivers/md/dm-snap.c                                            |    4 
 drivers/md/raid5.c                                              |   12 
 drivers/media/pci/sta2x11/sta2x11_vip.c                         |    9 
 drivers/media/tuners/xc4000.c                                   |    4 
 drivers/misc/vmw_vmci/vmci_datagram.c                           |    6 
 drivers/mmc/core/block.c                                        |   14 
 drivers/mmc/host/tmio_mmc_core.c                                |    2 
 drivers/mtd/nand/raw/meson_nand.c                               |    2 
 drivers/mtd/ubi/fastmap.c                                       |    7 
 drivers/mtd/ubi/vtbl.c                                          |    6 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c              |   34 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c                  |   16 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                 |    5 
 drivers/net/ethernet/realtek/r8169_main.c                       |    9 
 drivers/net/ethernet/renesas/ravb_main.c                        |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c               |   40 -
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |   38 -
 drivers/net/wireless/ath/ath9k/antenna.c                        |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c     |    4 
 drivers/nvmem/meson-efuse.c                                     |   45 -
 drivers/pci/pci-driver.c                                        |   23 
 drivers/s390/crypto/zcrypt_api.c                                |    2 
 drivers/scsi/hosts.c                                            |    7 
 drivers/scsi/lpfc/lpfc_nportdisc.c                              |    6 
 drivers/scsi/lpfc/lpfc_nvmet.c                                  |    2 
 drivers/scsi/myrb.c                                             |   20 
 drivers/scsi/myrs.c                                             |   24 
 drivers/scsi/qla2xxx/qla_target.c                               |   10 
 drivers/slimbus/core.c                                          |    4 
 drivers/soc/fsl/qbman/qman.c                                    |   98 ++
 drivers/staging/comedi/drivers/comedi_test.c                    |   30 
 drivers/staging/media/ipu3/ipu3-v4l2.c                          |   16 
 drivers/staging/speakup/synth.c                                 |    4 
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c       |   40 -
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h       |    2 
 drivers/tty/n_gsm.c                                             |    3 
 drivers/tty/serial/fsl_lpuart.c                                 |    7 
 drivers/tty/serial/max310x.c                                    |    7 
 drivers/tty/vt/vt.c                                             |    4 
 drivers/usb/class/cdc-wdm.c                                     |    6 
 drivers/usb/core/port.c                                         |    5 
 drivers/usb/core/sysfs.c                                        |   16 
 drivers/usb/dwc2/core.h                                         |   14 
 drivers/usb/dwc2/core_intr.c                                    |   63 +
 drivers/usb/dwc2/gadget.c                                       |    4 
 drivers/usb/dwc2/hcd.c                                          |   47 +
 drivers/usb/dwc2/hcd_ddma.c                                     |   17 
 drivers/usb/dwc2/hw.h                                           |    2 
 drivers/usb/gadget/function/f_ncm.c                             |    2 
 drivers/usb/gadget/udc/core.c                                   |    4 
 drivers/usb/host/sl811-hcd.c                                    |    2 
 drivers/usb/serial/cp210x.c                                     |    4 
 drivers/usb/serial/ftdi_sio.c                                   |    2 
 drivers/usb/serial/ftdi_sio_ids.h                               |    6 
 drivers/usb/serial/option.c                                     |    6 
 drivers/usb/storage/isd200.c                                    |   23 
 drivers/usb/typec/tcpm/tcpci.c                                  |    1 
 drivers/vfio/pci/vfio_pci_intrs.c                               |  176 +++--
 drivers/vfio/platform/vfio_platform_irq.c                       |  106 ++-
 drivers/vfio/virqfd.c                                           |   21 
 drivers/video/fbdev/core/fbmon.c                                |    7 
 drivers/video/fbdev/via/accel.c                                 |    4 
 drivers/virtio/virtio.c                                         |   10 
 drivers/xen/events/events_base.c                                |    5 
 fs/aio.c                                                        |    8 
 fs/btrfs/export.c                                               |    9 
 fs/btrfs/ioctl.c                                                |   25 
 fs/btrfs/send.c                                                 |   10 
 fs/btrfs/volumes.c                                              |   14 
 fs/exec.c                                                       |    1 
 fs/ext4/mballoc.c                                               |   17 
 fs/ext4/resize.c                                                |    3 
 fs/fat/nfs.c                                                    |    6 
 fs/fuse/fuse_i.h                                                |    1 
 fs/fuse/inode.c                                                 |    7 
 fs/isofs/inode.c                                                |   18 
 fs/nilfs2/alloc.c                                               |   38 -
 fs/nilfs2/btree.c                                               |   51 -
 fs/nilfs2/cpfile.c                                              |   10 
 fs/nilfs2/dat.c                                                 |   14 
 fs/nilfs2/direct.c                                              |   23 
 fs/nilfs2/gcinode.c                                             |    2 
 fs/nilfs2/ifile.c                                               |    4 
 fs/nilfs2/inode.c                                               |   31 
 fs/nilfs2/ioctl.c                                               |   37 -
 fs/nilfs2/mdt.c                                                 |    2 
 fs/nilfs2/namei.c                                               |    6 
 fs/nilfs2/nilfs.h                                               |    9 
 fs/nilfs2/page.c                                                |   11 
 fs/nilfs2/recovery.c                                            |   32 
 fs/nilfs2/segbuf.c                                              |    2 
 fs/nilfs2/segment.c                                             |   38 -
 fs/nilfs2/sufile.c                                              |   29 
 fs/nilfs2/super.c                                               |   57 -
 fs/nilfs2/sysfs.c                                               |   29 
 fs/nilfs2/the_nilfs.c                                           |   85 +-
 fs/open.c                                                       |   38 -
 fs/sysv/itree.c                                                 |   10 
 fs/ubifs/file.c                                                 |   13 
 include/linux/firmware/meson/meson_sm.h                         |   15 
 include/linux/frame.h                                           |   11 
 include/linux/fs.h                                              |    3 
 include/linux/gfp.h                                             |    9 
 include/linux/sunrpc/sched.h                                    |    2 
 include/linux/timer.h                                           |   18 
 include/linux/vfio.h                                            |    2 
 include/net/erspan.h                                            |   19 
 include/net/inet_connection_sock.h                              |    1 
 include/net/sock.h                                              |    7 
 include/soc/fsl/qman.h                                          |    9 
 include/uapi/linux/input-event-codes.h                          |    1 
 init/initramfs.c                                                |   47 -
 kernel/bounds.c                                                 |    2 
 kernel/events/core.c                                            |    9 
 kernel/panic.c                                                  |    8 
 kernel/power/suspend.c                                          |    1 
 kernel/printk/printk.c                                          |    6 
 kernel/time/timer.c                                             |  164 ++--
 kernel/trace/ring_buffer.c                                      |   51 +
 mm/compaction.c                                                 |    7 
 mm/memory-failure.c                                             |    2 
 mm/memory.c                                                     |    4 
 mm/memtest.c                                                    |    4 
 mm/migrate.c                                                    |    6 
 mm/page_alloc.c                                                 |   10 
 mm/vmscan.c                                                     |    5 
 net/bluetooth/hci_debugfs.c                                     |   48 -
 net/bluetooth/hci_event.c                                       |   25 
 net/core/sock_map.c                                             |    6 
 net/ipv4/inet_connection_sock.c                                 |   14 
 net/ipv4/ip_gre.c                                               |  104 ++-
 net/ipv4/tcp.c                                                  |    2 
 net/ipv6/ip6_fib.c                                              |   14 
 net/ipv6/ip6_gre.c                                              |    3 
 net/mac80211/cfg.c                                              |    5 
 net/netfilter/nf_tables_api.c                                   |   74 +-
 net/nfc/nci/core.c                                              |    5 
 net/rds/rdma.c                                                  |    2 
 net/sched/act_skbmod.c                                          |   10 
 net/xfrm/xfrm_user.c                                            |    3 
 scripts/Makefile.extrawarn                                      |    2 
 security/smack/smack_lsm.c                                      |   12 
 sound/pci/hda/patch_realtek.c                                   |    9 
 sound/sh/aica.c                                                 |   17 
 sound/soc/soc-ops.c                                             |    2 
 tools/iio/iio_utils.c                                           |    2 
 tools/objtool/Documentation/stack-validation.txt                |    8 
 tools/objtool/arch/x86/decode.c                                 |    6 
 tools/objtool/check.c                                           |   64 +
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c |    1 
 tools/testing/ktest/ktest.pl                                    |    1 
 tools/testing/selftests/mqueue/setting                          |    1 
 tools/testing/selftests/net/reuseaddr_conflict.c                |    2 
 virt/kvm/async_pf.c                                             |   31 
 208 files changed, 2528 insertions(+), 1429 deletions(-)

Alan Stern (2):
      USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command
      USB: core: Fix deadlock in usb_deauthorize_interface()

Aleksandr Burakov (1):
      fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2

Aleksandr Loktionov (1):
      i40e: fix vf may be used uninitialized in this function warning

Alex Henrie (1):
      isofs: handle CDs with bad root inode but good Joliet root directory

Alex Williamson (6):
      vfio/platform: Disable virqfds on cleanup
      vfio/pci: Disable auto-enable of exclusive INTx IRQ
      vfio/pci: Lock external INTx masking ops
      vfio: Introduce interface to flush virqfd inject workqueue
      vfio/pci: Create persistent INTx handler
      vfio/platform: Create persistent IRQ handlers

Alexandre Chartre (2):
      objtool: is_fentry_call() crashes if call has no destination
      objtool: Add support for intra-function calls

Amit Pundir (1):
      clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd

Andrey Jr. Melnikov (1):
      ahci: asm1064: correct count of reported ports

Aric Cyr (1):
      drm/amd/display: Fix nanosec stat overflow

Arnd Bergmann (6):
      dm integrity: fix out-of-range warning
      staging: vc04_services: changen strncpy() to strscpy_pad()
      ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit
      scsi: mylex: Fix sysfs buffer lengths
      ata: sata_mv: Fix PCI device ID table declaration compilation warning
      media: sta2x11: fix irq handler cast

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix scrambling mode value in command macro

Aurélien Jacobs (1):
      USB: serial: option: add MeiG Smart SLM320 product

Baokun Li (1):
      ext4: correct best extent lstart adjustment logic

Bart Van Assche (1):
      fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Bastien Nocera (1):
      Bluetooth: Fix TOCTOU in HCI debugfs implementation

Borislav Petkov (1):
      x86/bugs: Use sysfs_emit()

Borislav Petkov (AMD) (2):
      x86/CPU/AMD: Update the Zenbleed microcode revisions
      x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()

Cameron Williams (1):
      USB: serial: add device ID for VeriFone adapter

Carlo Caione (1):
      firmware: meson_sm: Rework driver as a proper platform driver

Chris Wilson (1):
      drm/i915/gt: Reset queue_priority_hint on parking

Christian Häggström (1):
      USB: serial: cp210x: add ID for MGP Instruments PDS100

Christoph Hellwig (3):
      fs: add a vfs_fchown helper
      fs: add a vfs_fchmod helper
      initramfs: switch initramfs unpacking to struct file based APIs

Christophe JAILLET (1):
      slimbus: core: Remove usage of the deprecated ida_simple_xx() API

Colin Ian King (1):
      usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined

Conrad Kostecki (1):
      ahci: asm1064: asm1166: don't limit reported ports

Dai Ngo (1):
      SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int

Damian Muszynski (1):
      crypto: qat - resolve race condition during AER recovery

Dan Carpenter (1):
      staging: vc04_services: fix information leak in create_component()

Daniel Drake (1):
      Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"

Daniel Vogelbacher (1):
      USB: serial: ftdi_sio: add support for GMC Z216C Adapter IR-USB

Dave Airlie (1):
      amdkfd: use calloc instead of kzalloc to avoid integer overflow

Dave Stevenson (2):
      staging: mmal-vchiq: Allocate and free components as required
      staging: mmal-vchiq: Fix client_component for 64 bit kernel

David Hildenbrand (2):
      virtio: reenable config if freezing device failed
      x86/mm/pat: fix VM_PAT handling in COW mappings

David Sterba (3):
      btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
      btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
      btrfs: send: handle path ref underflow in header iterate_inode_ref()

Dmitry Antipov (1):
      wifi: ath9k: fix LNA selection in ath_ant_try_scan()

Dominique Martinet (1):
      mmc: core: Fix switch on gp3 partition

Duje Mihanović (1):
      arm: dts: marvell: Fix maxium->maxim typo in brownstone dts

Duoming Zhou (1):
      ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Edward Adam Davis (1):
      Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Eric Dumazet (3):
      tcp: properly terminate timers for kernel sockets
      net/sched: act_skbmod: prevent kernel-infoleak
      erspan: make sure erspan_base_hdr is present in skb->head

Felix Fietkau (1):
      wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

Filipe Manana (1):
      btrfs: fix off-by-one chunk length calculation at contains_pending_extent()

Gabor Juhos (3):
      clk: qcom: gcc-ipq8074: fix terminating of frequency table arrays
      clk: qcom: mmcc-apq8084: fix terminating of frequency table arrays
      clk: qcom: mmcc-msm8974: fix terminating of frequency table arrays

Genjian Zhang (1):
      Revert "loop: Check for overflow while configuring loop"

Gergo Koteles (1):
      Input: allocate keycode for Display refresh rate toggle

Goldwyn Rodrigues (1):
      btrfs: allocate btrfs_ioctl_defrag_range_args on stack

Greg Kroah-Hartman (1):
      Linux 5.4.274

Guenter Roeck (4):
      parisc: Fix ip_fast_csum
      parisc: Fix csum_ipv6_magic on 32-bit systems
      parisc: Fix csum_ipv6_magic on 64-bit systems
      parisc: Strip upper 32 bit of sum in csum_ipv6_magic for 64-bit builds

Gui-Dong Han (1):
      media: xc4000: Fix atomicity violation in xc4000_get_frequency

Guilherme G. Piccoli (1):
      scsi: core: Fix unremoved procfs host directory regression

Guo Mengqi (1):
      drm/vkms: call drm_atomic_helper_shutdown before drm_dev_put()

Hangbin Liu (1):
      ip_gre: do not report erspan version on GRE interface

Harald Freudenberger (1):
      s390/zcrypt: fix reference counting on zcrypt card objects

Harshit Mogalapalli (1):
      VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()

Heiner Kallweit (1):
      r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Helge Deller (1):
      parisc: Do not hardcode registers in checksum functions

Hidenori Kobayashi (1):
      media: staging: ipu3-imgu: Set fields before media_entity_pads_init()

Hugo Villeneuve (1):
      serial: max310x: fix NULL pointer dereference in I2C instantiation

Hui Wang (1):
      Bluetooth: hci_event: set the conn encrypted before conn establishes

I Gede Agastya Darma Laksana (1):
      ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone

Ian Abbott (1):
      comedi: comedi_test: Prevent timers rescheduling during deletion

Ingo Molnar (1):
      Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Jakub Kicinski (1):
      selftests: reuseaddr_conflict: add missing new line at the end of the output

Jakub Sitnicki (1):
      bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Jan Kara (1):
      fat: fix uninitialized field in nostale filehandles

Jani Nikula (3):
      drm/exynos: do not return negative values from .get_modes()
      drm/imx/ipuv3: do not return negative values from .get_modes()
      drm/vc4: hdmi: do not return negative values from .get_modes()

Jerome Brunet (1):
      nvmem: meson-efuse: fix function pointer type mismatch

Joe Perches (1):
      nilfs2: use a more common logging style

Johan Jonker (2):
      arm64: dts: rockchip: fix rk3328 hdmi ports node
      arm64: dts: rockchip: fix rk3399 hdmi ports node

John Ogness (2):
      printk: Update @console_may_schedule in console_trylock_spinning()
      panic: Flush kernel log buffer at the end

John Sperbeck (1):
      init: open /initrd.image with O_LARGEFILE

Josua Mayer (1):
      hwmon: (amc6821) add of_match table

Juergen Gross (1):
      x86/alternative: Don't call text_poke() in lazy TLB mode

Justin Tee (1):
      scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()

Kailang Yang (1):
      ALSA: hda/realtek - Fix headset Mic no show at resume back for Lenovo ALC897 platform

Kim Phillips (2):
      x86/cpu: Support AMD Automatic IBRS
      x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Krishna Kurapati (1):
      usb: gadget: ncm: Fix handling of zero block length packets

Kuniyuki Iwashima (1):
      ipv6: Fix infinite recursion in fib6_dump_done().

Kunwu Chan (1):
      Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails

Lin Yujun (1):
      Documentation/hw-vuln: Update spectre doc

Liu Shixin (1):
      mm/memory-failure: fix an incorrect use of tail pages

Lubomir Rintel (1):
      ARM: dts: mmp2-brownstone: Don't redeclare phandle references

Luiz Augusto von Dentz (1):
      Bluetooth: btintel: Fixe build regression

Mahmoud Adam (1):
      net/rds: fix possible cp null dereference

Marco Felsch (1):
      usb: typec: tcpci: add generic tcpci fallback compatible

Martijn Coenen (5):
      loop: Call loop_config_discard() only after new config is applied
      loop: Remove sector_t truncation checks
      loop: Factor out setting loop device size
      loop: Refactor loop_set_status() size calculation
      loop: Factor out configuring loop from status

Mathias Nyman (1):
      usb: port: Don't try to peer unused USB ports based on location

Matthew Wilcox (Oracle) (2):
      ubifs: Set page uptodate in the correct place
      bounds: support non-power-of-two CONFIG_NR_CPUS

Maulik Shah (1):
      PM: suspend: Set mem_sleep_current during kernel command line setup

Max Filippov (1):
      exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Maximilian Heyne (2):
      ext4: fix corruption during on-line resize
      xen/events: close evtchn after mapping cleanup

Michael Ellerman (1):
      powerpc/fsl: Fix mfpmr build errors with newer binutils

Mikko Rapeli (2):
      mmc: core: Initialize mmc_blk_ioc_data
      mmc: core: Avoid negative index with array access

Miklos Szeredi (1):
      fuse: don't unhash root

Mikulas Patocka (1):
      dm snapshot: fix lockup in dm_exception_table_exit

Minas Harutyunyan (4):
      usb: dwc2: host: Fix remote wakeup from hibernation
      usb: dwc2: host: Fix hibernation flow
      usb: dwc2: host: Fix ISOC flow in DDMA mode
      usb: dwc2: gadget: LPM flow fix

Muhammad Usama Anjum (1):
      scsi: lpfc: Correct size for wqe for memset()

Nathan Chancellor (3):
      kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1
      xfrm: Avoid clang fortify warning in copy_to_user_tmpl()
      powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

Nicolas Pitre (1):
      vt: fix unicode buffer corruption when deleting characters

Oliver Neukum (1):
      usb: cdc-wdm: close race between read and workqueue

Pablo Neira Ayuso (9):
      netfilter: nf_tables: mark set as dead when unbinding anonymous set with timeout
      netfilter: nf_tables: disallow anonymous set with timeout flag
      netfilter: nf_tables: reject constant set with timeout
      netfilter: nf_tables: disallow timeout for anonymous sets
      netfilter: nf_tables: flush pending destroy work before exit_net release
      netfilter: nf_tables: reject new basechain after table flag update
      netfilter: nf_tables: release batch on table validation from abort path
      netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path
      netfilter: nf_tables: discard table flag update with pending basechain deletion

Paul Barker (1):
      net: ravb: Always process TX descriptor ring

Petre Rodan (1):
      tools: iio: replace seekdir() in iio_generic_buffer

Piotr Wejman (1):
      net: stmmac: fix rx queue priority assignment

Przemek Kitszel (1):
      ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Qiang Zhang (1):
      memtest: use {READ,WRITE}_ONCE in memory scanning

Qingliang Li (1):
      PM: sleep: wakeirq: fix wake irq warning in system suspend

Quinn Tran (1):
      scsi: qla2xxx: Fix command flush on cable pull

Rafael J. Wysocki (1):
      PCI/PM: Drain runtime-idle callbacks before driver removal

Randy Dunlap (2):
      sparc64: NMI watchdog: fix return value of __setup handler
      sparc: vDSO: fix return value of __setup handler

Ricardo B. Marliere (1):
      ktest: force $buildonly = 1 for 'make_warnings_file' test type

Richard Weinberger (1):
      ubi: Check for too small LEB size in VTBL code

Roberto Sassu (2):
      smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
      smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()

Roman Smirnov (2):
      block: prevent division by zero in blk_rq_stat_sum()
      fbmon: prevent division by zero in fb_videomode_from_videomode()

Rui Qi (1):
      x86/speculation: Support intra-function call validation

Ryosuke Yasuoka (1):
      nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Ryusuke Konishi (2):
      nilfs2: fix failure to detect DAT corruption in btree and direct mappings
      nilfs2: prevent kernel bug at submit_bh_wbc()

Samasth Norway Ananda (1):
      tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()

Samuel Thibault (1):
      speakup: Fix 8bit characters from direct synth

Sandipan Das (1):
      x86/cpufeatures: Add new word for scattered features

Sean Anderson (4):
      soc: fsl: qbman: Always disable interrupts when taking cgr_lock
      soc: fsl: qbman: Add helper for sanity checking cgr ops
      soc: fsl: qbman: Add CGR update function
      soc: fsl: qbman: Use raw spinlock for cgr_lock

Sean Christopherson (1):
      KVM: Always flush async #PF workqueue when vCPU is being destroyed

SeongJae Park (1):
      selftests/mqueue: Set timeout to 180 seconds

Shannon Nelson (1):
      ionic: set adminq irq affinity

Sherry Sun (1):
      tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled

Siddh Raman Pant (1):
      loop: Check for overflow while configuring loop

Song Liu (1):
      Revert "Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d""

Stephen Lee (1):
      ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Steven Rostedt (Google) (2):
      ring-buffer: Fix resetting of shortest_full
      ring-buffer: Fix full_waiters_pending in poll

Sumanth Korikkar (1):
      s390/entry: align system call table on 8 bytes

Svyatoslav Pankratov (1):
      crypto: qat - fix double free during reset

Tetsuo Handa (1):
      sysv: don't call sb_bread() with pointers_lock held

Thadeu Lima de Souza Cascardo (1):
      tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc

Thomas Gleixner (3):
      timers: Update kernel-doc for various functions
      timers: Use del_timer_sync() even on UP
      timers: Rename del_timer_sync() to timer_delete_sync()

Tim Schumacher (1):
      efivarfs: Request at most 512 bytes for variable names

Toru Katagiri (1):
      USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M

Uwe Kleine-König (1):
      PCI: Drop pci_device_remove() test of pci_dev->driver

Vasiliy Kovalev (1):
      VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()

Vlastimil Babka (1):
      mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations

William Tu (2):
      erspan: Add type I version 0 support.
      erspan: Check IFLA_GRE_ERSPAN_VER is set.

Wolfram Sang (1):
      mmc: tmio: avoid concurrent runs of mmc_request_done()

Yang Jihong (1):
      perf/core: Fix reentry problem in perf_output_read_group()

Yangxi Xiang (1):
      vt: fix memory overlapping when deleting chars in the buffer

Yu Kuai (1):
      dm-raid: fix lockdep waring in "pers->hot_add_disk"

Zhang Shurong (1):
      firmware: meson_sm: fix to avoid potential NULL pointer dereference

Zhang Yi (1):
      ubi: correct the calculation of fastmap size

Zheng Wang (1):
      wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

Zhong Jinghua (1):
      loop: loop_set_status_from_info() check before assignment

Zi Yan (1):
      mm/migrate: set swap entry values of THP tail pages properly.

Ziyang Xuan (1):
      netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()

yuan linyu (1):
      usb: udc: remove warning when queue disabled ep


