Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356B6809DBA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573380AbjLHH52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573412AbjLHH4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:56:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC941725
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:56:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19223C433C9;
        Fri,  8 Dec 2023 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702022206;
        bh=mBQAP62tN0Pbb1Ba83wHf0wjU7Uik5a9aY0AYwqmwrQ=;
        h=From:To:Cc:Subject:Date:From;
        b=0DsdHeilNTFCzv3WVgkkCfoBs2UfFTP4ouVjgnU7NO5dSAh3qh/T3614OQRq64zHu
         36WFDhpJacnG+KR1XMHMXdvYKDqw6t7pu238A9O5cii9tKBsroMz+5Ns4l76qxJYbu
         Jp+Nfign+vXctdY4X8K5ApvdJ2CcfM0CTHmeeZ98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.203
Date:   Fri,  8 Dec 2023 08:56:42 +0100
Message-ID: <2023120843-vista-ardently-bcc7@gregkh>
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

I'm announcing the release of the 5.10.203 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-usb              |   11 
 Documentation/ABI/testing/sysfs-devices-removable    |   17 +
 Makefile                                             |    2 
 arch/arm/xen/enlighten.c                             |    3 
 arch/mips/kvm/mmu.c                                  |    3 
 arch/parisc/include/uapi/asm/errno.h                 |    2 
 arch/powerpc/kernel/fpu.S                            |   13 
 arch/powerpc/kernel/vector.S                         |    2 
 arch/s390/mm/page-states.c                           |   14 
 drivers/acpi/resource.c                              |    7 
 drivers/ata/pata_isapnp.c                            |    3 
 drivers/base/core.c                                  |   28 +
 drivers/base/dd.c                                    |    4 
 drivers/cpufreq/imx6q-cpufreq.c                      |   32 +
 drivers/firewire/core-device.c                       |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c             |    5 
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c       |    7 
 drivers/gpu/drm/panel/panel-simple.c                 |   13 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c          |   14 
 drivers/hid/hid-core.c                               |   16 
 drivers/hid/hid-debug.c                              |    3 
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c             |    6 
 drivers/infiniband/hw/i40iw/i40iw_type.h             |    2 
 drivers/infiniband/hw/i40iw/i40iw_verbs.c            |   10 
 drivers/input/joystick/xpad.c                        |    2 
 drivers/iommu/intel/iommu.c                          |    2 
 drivers/md/bcache/btree.c                            |    6 
 drivers/md/bcache/sysfs.c                            |    2 
 drivers/md/bcache/writeback.c                        |   22 +
 drivers/md/dm-delay.c                                |   17 -
 drivers/md/dm-verity-fec.c                           |    3 
 drivers/md/dm-verity-target.c                        |    4 
 drivers/md/dm-verity.h                               |    6 
 drivers/media/i2c/smiapp/smiapp-core.c               |    2 
 drivers/misc/pci_endpoint_test.c                     |   12 
 drivers/mmc/core/block.c                             |    2 
 drivers/mmc/core/core.c                              |   15 
 drivers/mmc/core/regulator.c                         |   41 ++
 drivers/mmc/host/cqhci.c                             |   44 +-
 drivers/mmc/host/sdhci-sprd.c                        |   25 +
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c             |   14 
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c         |   11 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c            |   14 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c     |    8 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h     |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |    7 
 drivers/net/ethernet/realtek/r8169_main.c            |   23 +
 drivers/net/ethernet/renesas/ravb_main.c             |   20 -
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c       |    4 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c    |    2 
 drivers/net/hyperv/netvsc_drv.c                      |   66 ++--
 drivers/net/usb/ax88179_178a.c                       |    4 
 drivers/net/wireguard/device.c                       |    4 
 drivers/net/wireguard/receive.c                      |   12 
 drivers/net/wireguard/send.c                         |    3 
 drivers/nvme/target/core.c                           |   21 -
 drivers/nvme/target/fabrics-cmd.c                    |   15 
 drivers/nvme/target/nvmet.h                          |    5 
 drivers/pci/controller/dwc/pci-keystone.c            |    8 
 drivers/pinctrl/core.c                               |    6 
 drivers/s390/block/dasd.c                            |   24 -
 drivers/scsi/qla2xxx/qla_os.c                        |   14 
 drivers/usb/core/config.c                            |   85 ++---
 drivers/usb/core/hub.c                               |   13 
 drivers/usb/core/sysfs.c                             |   24 -
 drivers/usb/dwc2/hcd_intr.c                          |   15 
 drivers/usb/dwc3/core.c                              |    2 
 drivers/usb/dwc3/drd.c                               |    2 
 drivers/usb/dwc3/dwc3-qcom.c                         |   52 ++-
 drivers/usb/serial/option.c                          |   11 
 drivers/video/fbdev/sticore.h                        |    2 
 drivers/xen/swiotlb-xen.c                            |    1 
 fs/afs/dynroot.c                                     |    4 
 fs/afs/internal.h                                    |    1 
 fs/afs/server_list.c                                 |    2 
 fs/afs/super.c                                       |    2 
 fs/afs/vl_rotate.c                                   |   10 
 fs/btrfs/disk-io.c                                   |    1 
 fs/btrfs/ref-verify.c                                |    2 
 fs/btrfs/send.c                                      |    2 
 fs/btrfs/super.c                                     |    5 
 fs/btrfs/volumes.c                                   |    9 
 fs/cifs/cifsfs.c                                     |    1 
 fs/cifs/xattr.c                                      |    5 
 fs/ext4/extents_status.c                             |  306 +++++++++++++------
 fs/inode.c                                           |   16 
 fs/nfsd/vfs.c                                        |   12 
 include/linux/device.h                               |   37 ++
 include/linux/fs.h                                   |   45 ++
 include/linux/hid.h                                  |    5 
 include/linux/mmc/host.h                             |    3 
 include/linux/platform_data/x86/soc.h                |   65 ++++
 include/linux/usb.h                                  |    7 
 include/linux/workqueue.h                            |    1 
 include/scsi/scsi_cmnd.h                             |    6 
 io_uring/io_uring.c                                  |    2 
 kernel/locking/lockdep.c                             |    3 
 kernel/workqueue.c                                   |    9 
 lib/errname.c                                        |    6 
 net/ipv4/igmp.c                                      |    6 
 net/ipv4/route.c                                     |    2 
 net/smc/af_smc.c                                     |    8 
 security/integrity/iint.c                            |   48 ++
 sound/pci/hda/hda_intel.c                            |    2 
 sound/pci/hda/patch_realtek.c                        |   12 
 sound/soc/generic/simple-card.c                      |    6 
 sound/soc/intel/common/soc-intel-quirks.h            |   51 ---
 sound/soc/sof/sof-pci-dev.c                          |   62 +++
 tools/arch/parisc/include/uapi/asm/errno.h           |    2 
 tools/testing/selftests/net/ipsec.c                  |    4 
 tools/testing/selftests/net/mptcp/mptcp_connect.c    |   11 
 111 files changed, 1196 insertions(+), 512 deletions(-)

Abdul Halim, Mohd Syazwan (1):
      iommu/vt-d: Add MTL to quirk list to skip TE disabling

Adrian Hunter (5):
      mmc: block: Do not lose cache flush during CQE error recovery
      mmc: cqhci: Increase recovery halt timeout
      mmc: cqhci: Warn of halt or task clear failure
      mmc: cqhci: Fix task clearing in CQE error recovery
      mmc: block: Retry commands in CQE error recovery

Al Viro (1):
      nfsd: lock_rename() needs both directories to live on the same fs

Alan Stern (1):
      USB: core: Change configuration warnings to notices

Alex Deucher (1):
      drm/amdgpu: don't use ATRM for external devices

Alexander Gordeev (1):
      s390/mm: fix phys vs virt confusion in mark_kernel_pXd() functions family

Alexander Stein (1):
      usb: dwc3: Fix default mode initialization

Amir Goldstein (1):
      ima: annotate iint mutex to avoid lockdep false positive warnings

Andrey Grodzovsky (1):
      Revert "workqueue: remove unused cancel_work()"

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

Bart Van Assche (2):
      scsi: core: Introduce the scsi_cmd_to_rq() function
      scsi: qla2xxx: Use scsi_cmd_to_rq() instead of scsi_cmnd.request

Benjamin Tissoires (1):
      HID: core: store the unique system identifier in hid_device

Bragatheswaran Manickavel (1):
      btrfs: ref-verify: fix memory leaks in btrfs_ref_tree_mod()

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

D. Wythe (1):
      net/smc: avoid data corruption caused by decline

David Howells (4):
      afs: Fix afs_server_list to be cleaned up with RCU
      afs: Make error on cell lookup failure consistent with OpenAFS
      afs: Return ENOENT if no cell DNS record can be found
      afs: Fix file locking on R/O volumes to operate in local mode

Eric Dumazet (1):
      wireguard: use DEV_STATS_INC()

Filipe Manana (2):
      btrfs: fix off-by-one when checking chunk map includes logical address
      btrfs: make error messages more clear when getting a chunk map

Furong Xu (1):
      net: stmmac: xgmac: Disable FPE MMC interrupts

Geetha sowjanya (1):
      octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64

Greg Kroah-Hartman (1):
      Linux 5.10.203

Haiyang Zhang (2):
      hv_netvsc: Fix race of register_netdevice_notifier and VF register
      hv_netvsc: fix race of netvsc and VF register_netdevice

Hans de Goede (2):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA
      ASoC: Intel: Move soc_intel_is_foo() helpers to a generic header

Heiko Carstens (1):
      s390/cmma: fix detection of DAT pages

Heiner Kallweit (4):
      r8169: prevent potential deadlock in rtl8169_close
      mmc: core: add helpers mmc_regulator_enable/disable_vqmmc
      r8169: disable ASPM in case of tx timeout
      r8169: fix deadlock on RTL8125 in jumbo mtu mode

Helge Deller (2):
      parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes
      fbdev: stifb: Make the STI next font pointer a 32-bit signed offset

Huacai Chen (1):
      MIPS: KVM: Fix a build warning about variable set but not used

Ioana Ciornei (1):
      dpaa2-eth: increase the needed headroom to account for alignment

Jan Höppner (1):
      s390/dasd: protect device queue against concurrent access

Jann Horn (1):
      btrfs: send: ensure send_fd is writable

Jeff Layton (1):
      fs: add ctime accessors infrastructure

Johan Hovold (3):
      USB: dwc3: qcom: fix resource leaks on probe deferral
      USB: dwc3: qcom: fix ACPI platform device leak
      USB: dwc3: qcom: fix wakeup after probe deferral

Jonas Karlman (1):
      drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix failed operations during ax88179_reset

Kailang Yang (2):
      ALSA: hda/realtek: Headset Mic VREF to 100%
      ALSA: hda/realtek: Add supported ALC257 for ChromeOS

Keith Busch (2):
      swiotlb-xen: provide the "max_mapping_size" method
      io_uring: fix off-by one bvec index

Kishon Vijay Abraham I (1):
      misc: pci_endpoint_test: Add deviceID for AM64 and J7200

Kuninori Morimoto (1):
      ASoC: simple-card: fixup asoc_simple_probe() error handling

Kunwu Chan (1):
      ipv4: Correct/silence an endian warning in __ip_do_redirect

Lech Perczak (1):
      USB: serial: option: don't claim interface 4 for ZTE MF290

Long Li (1):
      hv_netvsc: Mark VF as slave before exposing it to user-mode

Marek Vasut (2):
      drm/panel: simple: Fix Innolux G101ICE-L01 bus flags
      drm/panel: simple: Fix Innolux G101ICE-L01 timings

Maria Yu (1):
      pinctrl: avoid reload of p state in list iteration

Mark Hasemeyer (1):
      ASoC: SOF: sof-pci-dev: Fix community key quirk detection

Markus Weippert (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Max Nguyen (1):
      Input: xpad - add HyperX Clutch Gladiate Support

Mikulas Patocka (2):
      dm-delay: fix a race between delay_presuspend and delay_bio
      dm-verity: align struct dm_verity_fec_io properly

Mingzhe Zou (3):
      bcache: fixup multi-threaded bch_sectors_dirty_init() wake-up race
      bcache: fixup init dirty data errors
      bcache: fixup lock c->root error

Nathan Chancellor (1):
      PCI: keystone: Drop __init from ks_pcie_add_pcie_{ep,port}()

Niklas Neronin (1):
      usb: config: fix iteration issue in 'usb_get_bos_descriptor()'

Oliver Neukum (1):
      USB: dwc2: write HCINT with INTMASK applied

Peter Zijlstra (1):
      lockdep: Fix block chain corruption

Pierre-Louis Bossart (3):
      ASoC: SOF: sof-pci-dev: use community key on all Up boards
      ASoC: SOF: sof-pci-dev: add parameter to override topology filename
      ASoC: SOF: sof-pci-dev: don't use the community key on APL Chromebooks

Puliang Lu (1):
      USB: serial: option: fix FM101R-GL defines

Qu Wenruo (1):
      btrfs: add dmesg output for first mount and last unmount of a filesystem

Quinn Tran (1):
      scsi: qla2xxx: Fix system crash due to bad pointer access

Rajat Jain (1):
      driver core: Move the "removable" attribute from USB to core

Raju Rangoju (3):
      amd-xgbe: handle corner-case during sfp hotplug
      amd-xgbe: handle the corner-case during tx completion
      amd-xgbe: propagate the correct speed and duplex status

Rand Deeb (1):
      bcache: prevent potential division by zero error

Ricardo Ribalda (1):
      usb: dwc3: set the dma max_seg_size

Sakari Ailus (1):
      media: ccs: Correctly initialise try compose rectangle

Samuel Holland (1):
      net: axienet: Fix check for partial TX checksum

Saravana Kannan (1):
      driver core: Release all resources during unbind before updating device links

Shuijing Li (1):
      drm/panel: boe-tv101wum-nl6: Fine tune the panel power sequence

Siddharth Vadapalli (1):
      misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP device support

Stefano Stabellini (1):
      arm/xen: fix xen_vcpu_info allocation alignment

Steve French (2):
      smb3: fix touch -h of symlink
      smb3: fix caching of ctime on setxattr

Takashi Iwai (1):
      ALSA: hda: Disable power-save on KONTRON SinglePC

Timothy Pearson (1):
      powerpc: Don't clobber f0/vs0 during fp|altivec register save

Victor Fragoso (1):
      USB: serial: option: add Fibocom L7xx modules

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Willem de Bruijn (2):
      selftests/net: ipsec: fix constant out of range
      selftests/net: mptcp: fix uninitialized variable warnings

Wu Bo (1):
      dm verity: don't perform FEC for failed readahead IO

Xuxin Xiong (1):
      drm/panel: auo,b101uan08.3: Fine tune the panel power sequence

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

