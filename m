Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB59809DA8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573387AbjLHH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjLHH43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:56:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CAA1730
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:56:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD36C433CB;
        Fri,  8 Dec 2023 07:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702022193;
        bh=axKI+FyWX/i7vyxWFu42mxCyPv71fJawAlwNMyHu18Y=;
        h=From:To:Cc:Subject:Date:From;
        b=u8E9xoGvCvxueBlhNSt7j1wIQVkmkSGQClHvjJm+dI5kVnBswa3rQ0nwAkodpro1r
         KxGhtwQ98rP2SnA4wPgnFWcpnN666TLT7P1uCJempeBASdnEFTT9tD1Qg6Qpb2MuJu
         1JzAaBhCSHzkn24qRwXglCI7hPn+fxJ1fcjMxu+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.263
Date:   Fri,  8 Dec 2023 08:56:26 +0100
Message-ID: <2023120826-plexiglas-sitting-f280@gregkh>
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

I'm announcing the release of the 5.4.263 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/arm/xen/enlighten.c                          |    3 
 arch/arm64/include/asm/cpufeature.h               |   23 +
 arch/arm64/include/asm/sysreg.h                   |    6 
 arch/arm64/kvm/sys_regs.c                         |   10 
 arch/mips/kvm/mmu.c                               |    3 
 arch/powerpc/kernel/fpu.S                         |   13 
 arch/powerpc/kernel/vector.S                      |    2 
 arch/s390/mm/page-states.c                        |   14 -
 drivers/acpi/resource.c                           |    7 
 drivers/ata/pata_isapnp.c                         |    3 
 drivers/base/dd.c                                 |    4 
 drivers/cpufreq/imx6q-cpufreq.c                   |   32 +-
 drivers/firewire/core-device.c                    |   11 
 drivers/gpu/drm/panel/panel-simple.c              |   13 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c       |   14 -
 drivers/hid/hid-core.c                            |   16 -
 drivers/hid/hid-debug.c                           |    3 
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c          |    6 
 drivers/infiniband/hw/i40iw/i40iw_type.h          |    2 
 drivers/infiniband/hw/i40iw/i40iw_verbs.c         |   10 
 drivers/input/joystick/xpad.c                     |    2 
 drivers/md/bcache/btree.c                         |    6 
 drivers/md/bcache/sysfs.c                         |    2 
 drivers/md/dm-delay.c                             |   17 -
 drivers/md/dm-verity-fec.c                        |    3 
 drivers/md/dm-verity-target.c                     |    4 
 drivers/md/dm-verity.h                            |    6 
 drivers/mmc/core/block.c                          |    2 
 drivers/mmc/core/core.c                           |   15 -
 drivers/mmc/host/cqhci.c                          |   44 +--
 drivers/mtd/chips/cfi_cmdset_0001.c               |   29 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c          |   14 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c      |   11 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c         |   14 -
 drivers/net/ethernet/renesas/ravb_main.c          |   20 +
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c    |    4 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c |    2 
 drivers/net/hyperv/netvsc_drv.c                   |   41 ++
 drivers/net/usb/ax88179_178a.c                    |    4 
 drivers/nvme/target/core.c                        |   21 -
 drivers/nvme/target/fabrics-cmd.c                 |   15 -
 drivers/nvme/target/nvmet.h                       |    5 
 drivers/pci/controller/dwc/pci-keystone.c         |    8 
 drivers/pinctrl/core.c                            |    6 
 drivers/s390/block/dasd.c                         |   24 -
 drivers/scsi/qla2xxx/qla_def.h                    |    3 
 drivers/scsi/qla2xxx/qla_isr.c                    |    5 
 drivers/scsi/qla2xxx/qla_os.c                     |   39 +-
 drivers/usb/dwc2/hcd_intr.c                       |   15 -
 drivers/usb/dwc3/core.c                           |    2 
 drivers/usb/dwc3/dwc3-qcom.c                      |   17 -
 drivers/usb/serial/option.c                       |   11 
 drivers/video/fbdev/sticore.h                     |    2 
 fs/afs/dynroot.c                                  |    4 
 fs/afs/super.c                                    |    2 
 fs/afs/vl_rotate.c                                |   10 
 fs/btrfs/disk-io.c                                |    1 
 fs/btrfs/send.c                                   |    2 
 fs/btrfs/super.c                                  |    5 
 fs/btrfs/volumes.c                                |    9 
 fs/cifs/cifsfs.c                                  |    1 
 fs/ext4/extents_status.c                          |  306 +++++++++++++++-------
 fs/io_uring.c                                     |    2 
 fs/overlayfs/super.c                              |    5 
 fs/sync.c                                         |    3 
 include/linux/fs.h                                |    2 
 include/linux/hid.h                               |    5 
 include/scsi/scsi_cmnd.h                          |    6 
 net/ipv4/igmp.c                                   |    6 
 net/ipv4/route.c                                  |    2 
 security/integrity/iint.c                         |   48 ++-
 security/integrity/ima/ima_api.c                  |    5 
 security/integrity/ima/ima_main.c                 |   16 +
 security/integrity/integrity.h                    |    2 
 sound/pci/hda/hda_intel.c                         |    2 
 sound/pci/hda/patch_realtek.c                     |   12 
 77 files changed, 752 insertions(+), 314 deletions(-)

Adrian Hunter (5):
      mmc: block: Do not lose cache flush during CQE error recovery
      mmc: cqhci: Increase recovery halt timeout
      mmc: cqhci: Warn of halt or task clear failure
      mmc: cqhci: Fix task clearing in CQE error recovery
      mmc: block: Retry commands in CQE error recovery

Alexander Gordeev (1):
      s390/mm: fix phys vs virt confusion in mark_kernel_pXd() functions family

Amir Goldstein (1):
      ima: annotate iint mutex to avoid lockdep false positive warnings

Andrew Murray (2):
      arm64: cpufeature: Extract capped perfmon fields
      KVM: arm64: limit PMU version to PMUv3 for ARMv8.1

Asuna Yang (1):
      USB: serial: option: add Luat Air72*U series products

Baokun Li (8):
      ext4: add a new helper to check if es must be kept
      ext4: factor out __es_alloc_extent() and __es_free_extent()
      ext4: use pre-allocated es in __es_insert_extent()
      ext4: use pre-allocated es in __es_remove_extent()
      ext4: using nofail preallocation in ext4_es_remove_extent()
      ext4: using nofail preallocation in ext4_es_insert_delayed_block()
      ext4: using nofail preallocation in ext4_es_insert_extent()
      ext4: fix slab-use-after-free in ext4_es_insert_extent()

Bart Van Assche (3):
      scsi: qla2xxx: Simplify the code for aborting SCSI commands
      scsi: core: Introduce the scsi_cmd_to_rq() function
      scsi: qla2xxx: Use scsi_cmd_to_rq() instead of scsi_cmnd.request

Benjamin Tissoires (1):
      HID: core: store the unique system identifier in hid_device

Chaitanya Kulkarni (1):
      nvmet: remove unnecessary ctrl parameter

Charles Yi (1):
      HID: fix HID device resource race between HID core and debugging support

Chen Ni (1):
      ata: pata_isapnp: Add missing error check for devm_ioport_map()

Christoph Hellwig (1):
      nvmet: nul-terminate the NQNs passed in the connect command

Christoph Niedermaier (2):
      cpufreq: imx6q: don't warn for disabling a non-existing frequency
      cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Christopher Bednarz (1):
      RDMA/irdma: Prevent zero-length STAG registration

Claudiu Beznea (2):
      net: ravb: Use pm_runtime_resume_and_get()
      net: ravb: Start TX queues after HW initialization succeeded

Coly Li (2):
      bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_coalesce()
      bcache: check return value from btree_node_alloc_replacement()

David Howells (3):
      afs: Make error on cell lookup failure consistent with OpenAFS
      afs: Return ENOENT if no cell DNS record can be found
      afs: Fix file locking on R/O volumes to operate in local mode

Filipe Manana (2):
      btrfs: fix off-by-one when checking chunk map includes logical address
      btrfs: make error messages more clear when getting a chunk map

Furong Xu (1):
      net: stmmac: xgmac: Disable FPE MMC interrupts

Greg Kroah-Hartman (1):
      Linux 5.4.263

Haiyang Zhang (1):
      hv_netvsc: Fix race of register_netdevice_notifier and VF register

Hans de Goede (1):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA

Heiko Carstens (1):
      s390/cmma: fix detection of DAT pages

Helge Deller (1):
      fbdev: stifb: Make the STI next font pointer a 32-bit signed offset

Huacai Chen (1):
      MIPS: KVM: Fix a build warning about variable set but not used

Jan Höppner (1):
      s390/dasd: protect device queue against concurrent access

Jann Horn (1):
      btrfs: send: ensure send_fd is writable

Jean-Philippe Brucker (1):
      mtd: cfi_cmdset_0001: Support the absence of protection registers

Johan Hovold (2):
      USB: dwc3: qcom: fix resource leaks on probe deferral
      USB: dwc3: qcom: fix wakeup after probe deferral

Jonas Karlman (1):
      drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix failed operations during ax88179_reset

Kailang Yang (2):
      ALSA: hda/realtek: Headset Mic VREF to 100%
      ALSA: hda/realtek: Add supported ALC257 for ChromeOS

Keith Busch (1):
      io_uring: fix off-by one bvec index

Konstantin Khlebnikov (1):
      ovl: skip overlayfs superblocks at global sync

Kunwu Chan (1):
      ipv4: Correct/silence an endian warning in __ip_do_redirect

Lech Perczak (1):
      USB: serial: option: don't claim interface 4 for ZTE MF290

Linus Walleij (1):
      mtd: cfi_cmdset_0001: Byte swap OTP info

Long Li (1):
      hv_netvsc: Mark VF as slave before exposing it to user-mode

Marek Vasut (2):
      drm/panel: simple: Fix Innolux G101ICE-L01 bus flags
      drm/panel: simple: Fix Innolux G101ICE-L01 timings

Maria Yu (1):
      pinctrl: avoid reload of p state in list iteration

Markus Weippert (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Max Nguyen (1):
      Input: xpad - add HyperX Clutch Gladiate Support

Mikulas Patocka (2):
      dm-delay: fix a race between delay_presuspend and delay_bio
      dm-verity: align struct dm_verity_fec_io properly

Mimi Zohar (1):
      ima: detect changes to the backing overlay file

Nathan Chancellor (1):
      PCI: keystone: Drop __init from ks_pcie_add_pcie_{ep,port}()

Oliver Neukum (1):
      USB: dwc2: write HCINT with INTMASK applied

Puliang Lu (1):
      USB: serial: option: fix FM101R-GL defines

Qu Wenruo (1):
      btrfs: add dmesg output for first mount and last unmount of a filesystem

Quinn Tran (1):
      scsi: qla2xxx: Fix system crash due to bad pointer access

Raju Rangoju (3):
      amd-xgbe: handle corner-case during sfp hotplug
      amd-xgbe: handle the corner-case during tx completion
      amd-xgbe: propagate the correct speed and duplex status

Rand Deeb (1):
      bcache: prevent potential division by zero error

Ricardo Ribalda (1):
      usb: dwc3: set the dma max_seg_size

Samuel Holland (1):
      net: axienet: Fix check for partial TX checksum

Saravana Kannan (1):
      driver core: Release all resources during unbind before updating device links

Stefano Stabellini (1):
      arm/xen: fix xen_vcpu_info allocation alignment

Steve French (1):
      smb3: fix touch -h of symlink

Takashi Iwai (1):
      ALSA: hda: Disable power-save on KONTRON SinglePC

Timothy Pearson (1):
      powerpc: Don't clobber f0/vs0 during fp|altivec register save

Victor Fragoso (1):
      USB: serial: option: add Fibocom L7xx modules

Wu Bo (1):
      dm verity: don't perform FEC for failed readahead IO

Yang Yingliang (1):
      firewire: core: fix possible memory leak in create_units()

Yoshihiro Shimoda (1):
      ravb: Fix races between ravb_tx_timeout_work() and net related ops

Zhang Yi (1):
      ext4: make sure allocate pending entry not fail

Zheng Yongjun (1):
      mmc: core: convert comma to semicolon

Zhengchao Shao (1):
      ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

