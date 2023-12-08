Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346EE809DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573478AbjLHH6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjLHH5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:57:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F71BCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:57:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4196AC433AB;
        Fri,  8 Dec 2023 07:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702022221;
        bh=jNba0B+xRzJ8LgixuaZdHSnHzFKXmzAbnz4IsPY5iXg=;
        h=From:To:Cc:Subject:Date:From;
        b=Cwi2bi7HojAFt0iU9cPElqAsaf618zk+1wrKikXsXEMGLAsBwvnMzNV1jA/a7ZlXY
         tUzsmLWO+QeBH22YyvoJ/MUbCY5O2lB/0IrFTbHrP9Pl/eY6NZdycUxk8KPI2v8ROA
         BbQBygypbCy68yKAuhPno5Q7v2Dro3lFVf+L05lo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.66
Date:   Fri,  8 Dec 2023 08:56:57 +0100
Message-ID: <2023120858-implant-detonate-edbc@gregkh>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.66 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/xen/enlighten.c                                   |    2 
 arch/parisc/include/asm/alternative.h                      |    9 
 arch/parisc/include/asm/assembly.h                         |    1 
 arch/parisc/include/asm/bug.h                              |   30 
 arch/parisc/include/asm/jump_label.h                       |    8 
 arch/parisc/include/asm/ldcw.h                             |    2 
 arch/parisc/include/asm/uaccess.h                          |    1 
 arch/parisc/include/uapi/asm/errno.h                       |    2 
 arch/parisc/kernel/vmlinux.lds.S                           |    1 
 arch/powerpc/kernel/fpu.S                                  |   13 
 arch/powerpc/kernel/process.c                              |    6 
 arch/powerpc/kernel/vector.S                               |    2 
 arch/x86/entry/common.c                                    |    2 
 arch/x86/include/asm/kvm-x86-ops.h                         |    1 
 arch/x86/include/asm/kvm_host.h                            |    1 
 arch/x86/kernel/apic/msi.c                                 |    8 
 arch/x86/kvm/lapic.c                                       |    4 
 arch/x86/kvm/vmx/vmx.c                                     |    4 
 arch/x86/xen/enlighten.c                                   |    8 
 arch/x86/xen/enlighten_hvm.c                               |    2 
 arch/x86/xen/xen-ops.h                                     |    2 
 drivers/ata/libata-scsi.c                                  |    9 
 drivers/auxdisplay/hd44780_common.c                        |   10 
 drivers/cpufreq/amd-pstate.c                               |    4 
 drivers/cpufreq/imx6q-cpufreq.c                            |   32 
 drivers/dma-buf/dma-resv.c                                 |    2 
 drivers/firewire/core-device.c                             |   11 
 drivers/firewire/sbp2.c                                    |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                     |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          |    8 
 drivers/gpu/drm/amd/display/dc/dc.h                        |   19 
 drivers/gpu/drm/amd/display/dc/dc_stream.h                 |   11 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c     |   19 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.h     |    1 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |    2 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c         |    6 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c        |    2 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c         |   37 -
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c    |    2 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c         |    8 
 drivers/gpu/drm/amd/display/dc/dml/dc_features.h           |    7 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c       |   15 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c       |    3 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h    |   25 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h      |    9 
 drivers/gpu/drm/amd/display/dc/inc/core_types.h            |    7 
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h          |    7 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                |   14 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c          |    5 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h          |    2 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c          |    5 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h          |    2 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c          |    5 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h          |    2 
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c            |   30 
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_11_0_0_offset.h |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c         |    5 
 drivers/input/joystick/xpad.c                              |    2 
 drivers/iommu/intel/dmar.c                                 |   18 
 drivers/iommu/intel/iommu.c                                |   71 +-
 drivers/md/bcache/btree.c                                  |    2 
 drivers/md/dm-verity-fec.c                                 |    3 
 drivers/md/dm-verity-target.c                              |    7 
 drivers/md/dm-verity.h                                     |    6 
 drivers/mmc/core/block.c                                   |    2 
 drivers/mmc/core/core.c                                    |    9 
 drivers/mmc/core/regulator.c                               |   41 +
 drivers/mmc/host/cqhci-core.c                              |   44 -
 drivers/mmc/host/sdhci-pci-gli.c                           |   54 -
 drivers/mmc/host/sdhci-sprd.c                              |   25 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c           |    8 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h           |    2 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h           |    9 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c        |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c     |    9 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c     |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c         |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h   |   13 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c  |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c    |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c       |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c       |  440 +++++++++----
 drivers/net/ethernet/realtek/r8169_main.c                  |   23 
 drivers/net/ethernet/renesas/ravb_main.c                   |   69 +-
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c             |    4 
 drivers/nvme/host/core.c                                   |    9 
 drivers/pci/controller/dwc/pcie-qcom-ep.c                  |   17 
 drivers/pci/quirks.c                                       |   12 
 drivers/pinctrl/core.c                                     |    6 
 drivers/powercap/dtpm_cpu.c                                |    6 
 drivers/powercap/dtpm_devfreq.c                            |   11 
 drivers/scsi/sd.c                                          |    9 
 drivers/spi/spi.c                                          |   56 +
 drivers/tty/serial/sc16is7xx.c                             |    5 
 drivers/usb/core/config.c                                  |   85 +-
 drivers/usb/host/xhci-plat.c                               |   29 
 drivers/video/fbdev/sticore.h                              |    2 
 drivers/xen/events/events_base.c                           |   22 
 drivers/xen/platform-pci.c                                 |    5 
 fs/btrfs/disk-io.c                                         |    1 
 fs/btrfs/ioctl.c                                           |    1 
 fs/btrfs/ref-verify.c                                      |    2 
 fs/btrfs/send.c                                            |    2 
 fs/btrfs/super.c                                           |    5 
 fs/btrfs/volumes.c                                         |    9 
 fs/iomap/direct-io.c                                       |   22 
 fs/smb/client/inode.c                                      |    2 
 fs/smb/client/smb2ops.c                                    |   13 
 include/linux/dma-fence.h                                  |   15 
 include/linux/irq.h                                        |   24 
 include/linux/mmc/host.h                                   |    3 
 include/linux/spi/spi.h                                    |    1 
 include/scsi/scsi_device.h                                 |   12 
 include/uapi/linux/stddef.h                                |    2 
 include/xen/events.h                                       |    3 
 kernel/irq/debugfs.c                                       |    1 
 kernel/irq/msi.c                                           |   12 
 lib/errname.c                                              |    6 
 net/ipv4/igmp.c                                            |    6 
 net/wireless/core.h                                        |    1 
 net/wireless/nl80211.c                                     |   50 -
 sound/pci/hda/hda_intel.c                                  |    2 
 sound/pci/hda/patch_realtek.c                              |   12 
 tools/arch/parisc/include/uapi/asm/errno.h                 |    2 
 tools/testing/selftests/net/af_unix/diag_uid.c             |    1 
 tools/testing/selftests/net/cmsg_sender.c                  |    2 
 tools/testing/selftests/net/ipsec.c                        |    4 
 tools/testing/selftests/net/mptcp/mptcp_connect.c          |   11 
 tools/testing/selftests/net/mptcp/mptcp_inq.c              |   11 
 132 files changed, 1277 insertions(+), 577 deletions(-)

Abdul Halim, Mohd Syazwan (1):
      iommu/vt-d: Add MTL to quirk list to skip TE disabling

Adrian Hunter (6):
      mmc: cqhci: Increase recovery halt timeout
      mmc: cqhci: Warn of halt or task clear failure
      mmc: cqhci: Fix task clearing in CQE error recovery
      mmc: block: Retry commands in CQE error recovery
      mmc: block: Do not lose cache flush during CQE error recovery
      mmc: block: Be sure to wait while busy in CQE error recovery

Alan Stern (1):
      USB: core: Change configuration warnings to notices

Alex Sierra (1):
      drm/amdgpu: Force order between a read and write to the same address

Alvin Lee (2):
      drm/amd/display: Include udelay when waiting for INBOX0 ACK
      drm/amd/display: Use DRAM speed from validation for dummy p-state

Bragatheswaran Manickavel (1):
      btrfs: ref-verify: fix memory leaks in btrfs_ref_tree_mod()

Christian König (1):
      dma-buf: fix check in dma_resv_add_fence

Christoph Hellwig (1):
      iomap: update ki_pos a little later in iomap_dio_complete

Christoph Niedermaier (2):
      cpufreq: imx6q: don't warn for disabling a non-existing frequency
      cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Claudiu Beznea (6):
      net: ravb: Check return value of reset_control_deassert()
      net: ravb: Use pm_runtime_resume_and_get()
      net: ravb: Make write access to CXR35 first before accessing other EMAC registers
      net: ravb: Start TX queues after HW initialization succeeded
      net: ravb: Stop DMA in case of failures on ravb_open()
      net: ravb: Keep reverse order of operations in ravb_remove()

Damien Le Moal (2):
      scsi: Change SCSI device boolean fields to single bit flags
      scsi: sd: Fix system start for ATA devices

David Howells (2):
      cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if EOF moved
      cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF moved

David Sterba (1):
      btrfs: fix 64bit compat send ioctl arguments not initializing version member

David Woodhouse (1):
      xen: Allow platform PCI interrupt to be shared

Dinghao Liu (1):
      drm/amd/pm: fix a memleak in aldebaran_tables_init

Dmitry Antipov (1):
      uapi: propagate __struct_group() attributes to the container union

Elena Salomatkina (1):
      octeontx2-af: Fix possible buffer overflow

Ewan D. Milne (1):
      nvme: check for valid nvme_identify_ns() before using it

Filipe Manana (2):
      btrfs: fix off-by-one when checking chunk map includes logical address
      btrfs: make error messages more clear when getting a chunk map

Furong Xu (1):
      net: stmmac: xgmac: Disable FPE MMC interrupts

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Fix the return value of amd_pstate_fast_switch()

Geetha sowjanya (1):
      octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64

Greg Kroah-Hartman (1):
      Linux 6.1.66

Haitao Shan (1):
      KVM: x86: Fix lapic timer interrupt lost after loading a snapshot.

Hamza Mahfooz (1):
      drm/amd/display: fix ABM disablement

Harry Wentland (1):
      drm/amd/display: Fix the delta clamping for shaper LUT

Heiner Kallweit (4):
      r8169: prevent potential deadlock in rtl8169_close
      mmc: core: add helpers mmc_regulator_enable/disable_vqmmc
      r8169: disable ASPM in case of tx timeout
      r8169: fix deadlock on RTL8125 in jumbo mtu mode

Helge Deller (9):
      parisc: Mark ex_table entries 32-bit aligned in assembly.h
      parisc: Mark ex_table entries 32-bit aligned in uaccess.h
      parisc: Use natural CPU alignment for bug_table
      parisc: Mark lock_aligned variables 16-byte aligned on SMP
      parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes
      parisc: Mark jump_table naturally aligned
      parisc: Ensure 32-bit alignment on parisc unwind section
      parisc: Mark altinstructions read-only and 32-bit aligned
      fbdev: stifb: Make the STI next font pointer a 32-bit signed offset

Hugo Villeneuve (2):
      auxdisplay: hd44780: move cursor home after clear display command
      serial: sc16is7xx: add missing support for rs485 devicetree properties

Hui Wang (1):
      serial: sc16is7xx: Put IOControl register into regmap_volatile

Ilya Bakoulin (1):
      drm/amd/display: Fix MPCC 1DLUT programming

Ioana Ciornei (1):
      dpaa2-eth: increase the needed headroom to account for alignment

Jann Horn (1):
      btrfs: send: ensure send_fd is writable

JinZe.Xu (1):
      drm/amd/display: Restore rptr/wptr for DMCUB as workaround

Johan Hovold (1):
      USB: xhci-plat: fix legacy PHY double init

Johannes Berg (1):
      wifi: cfg80211: fix CQM for non-range use

Juergen Gross (2):
      xen: simplify evtchn_do_upcall() call maze
      x86/xen: fix percpu vcpu_info allocation

Kailang Yang (2):
      ALSA: hda/realtek: Headset Mic VREF to 100%
      ALSA: hda/realtek: Add supported ALC257 for ChromeOS

Koichiro Den (1):
      x86/apic/msi: Fix misconfigured non-maskable MSI quirk

Kornel Dulęba (1):
      mmc: sdhci-pci-gli: Disable LPM during initialization

Lu Baolu (5):
      iommu/vt-d: Omit devTLB invalidation requests when TES=0
      iommu/vt-d: Allocate pasid table in device probe path
      iommu/vt-d: Add device_block_translation() helper
      iommu/vt-d: Disable PCI ATS in legacy passthrough mode
      iommu/vt-d: Make context clearing consistent with context mapping

Lukas Wunner (1):
      PCI: Lengthen reset delay for VideoPropulsion Torrent QN16e card

Lukasz Luba (1):
      powercap: DTPM: Fix unneeded conversions to micro-Watts

Manivannan Sadhasivam (1):
      PCI: qcom-ep: Add dedicated callback for writing to DBI2 registers

Maria Yu (1):
      pinctrl: avoid reload of p state in list iteration

Mario Limonciello (1):
      drm/amd: Enable PCIe PME from D3

Mark Hasemeyer (1):
      spi: Fix null dereference on suspend

Markus Weippert (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Max Nguyen (1):
      Input: xpad - add HyperX Clutch Gladiate Support

Melissa Wen (1):
      drm/amd/display: clean code-style issues in dcn30_set_mpc_shaper_3dlut

Mikulas Patocka (1):
      dm-verity: align struct dm_verity_fec_io properly

Nicholas Kazlauskas (3):
      drm/amd/display: Remove min_dst_y_next_start check for Z8
      drm/amd/display: Update min Z8 residency time to 2100 for DCN314
      drm/amd/display: Guard against invalid RPTR/WPTR being set

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: Fix KVM_RUN clobbering FP/VEC user registers

Niklas Neronin (1):
      usb: config: fix iteration issue in 'usb_get_bos_descriptor()'

Paulo Alcantara (1):
      smb: client: report correct st_size for SMB and NFS symlinks

Qu Wenruo (1):
      btrfs: add dmesg output for first mount and last unmount of a filesystem

Rodrigo Siqueira (1):
      drm/amd/display: Expand kernel doc for DC

Subbaraya Sundeep (1):
      octeontx2-pf: Restore TC ingress police rules when interface is up

Suman Ghosh (2):
      octeontx2-af: Install TC filter rules in hardware based on priority
      octeontx2-af: Initialize 'cntr_val' to fix uninitialized symbol error

Takashi Iwai (1):
      ALSA: hda: Disable power-save on KONTRON SinglePC

Timothy Pearson (1):
      powerpc: Don't clobber f0/vs0 during fp|altivec register save

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Willem de Bruijn (4):
      selftests/net: ipsec: fix constant out of range
      selftests/net: fix a char signedness issue
      selftests/net: unix: fix unused variable compiler warning
      selftests/net: mptcp: fix uninitialized variable warnings

Wu Bo (2):
      dm verity: initialize fec io before freeing it
      dm verity: don't perform FEC for failed readahead IO

Yang Yingliang (1):
      firewire: core: fix possible memory leak in create_units()

Yoshihiro Shimoda (1):
      ravb: Fix races between ravb_tx_timeout_work() and net related ops

Zhengchao Shao (1):
      ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

