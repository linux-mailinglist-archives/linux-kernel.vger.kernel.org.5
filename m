Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4194802162
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjLCGv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjLCGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:51:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229D107
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:51:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C92C433CC;
        Sun,  3 Dec 2023 06:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701586302;
        bh=2zp/I2AWV6BZwriR61rHw9WUQQjjgu2JgvpL9zRWr4w=;
        h=From:To:Cc:Subject:Date:From;
        b=ku15amX4hwQFdQAdzgbZuLaHHFoitPGXYOkq8r4bUmr0aN2c+vDY+GXv+QA7Sjlya
         SeufcAOL3oZP+YqTiyfboTj0BI/me4D9QwBFyG60FhLiKamJls1OJ1t47npdRSG9WP
         4b9ph2UQgVL9mrtth8uaWmCFqu8uBudUGDrZHlS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.4
Date:   Sun,  3 Dec 2023 07:51:35 +0100
Message-ID: <2023120336-magazine-dial-8b62@gregkh>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.6.4 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/usb/microchip,usb5744.yaml |    7 
 Makefile                                                     |    2 
 arch/arm/xen/enlighten.c                                     |    3 
 arch/arm64/include/asm/setup.h                               |   17 
 arch/arm64/mm/pageattr.c                                     |    7 
 arch/s390/kernel/ipl.c                                       |    1 
 block/bdev.c                                                 |    2 
 block/blk-cgroup.h                                           |    2 
 drivers/accel/ivpu/ivpu_hw_37xx.c                            |   54 
 drivers/accel/ivpu/ivpu_hw_40xx.c                            |    8 
 drivers/acpi/acpi_video.c                                    |    2 
 drivers/acpi/device_pm.c                                     |   13 
 drivers/acpi/processor_idle.c                                |    2 
 drivers/acpi/resource.c                                      |    7 
 drivers/ata/pata_isapnp.c                                    |    3 
 drivers/gpu/drm/ast/ast_drv.h                                |   13 
 drivers/gpu/drm/ast/ast_mode.c                               |   62 
 drivers/gpu/drm/i915/gt/intel_gt.c                           |   11 
 drivers/gpu/drm/i915/i915_driver.c                           |    4 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h     |    1 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c                    |    2 
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c               |    9 
 drivers/gpu/drm/panel/panel-simple.c                         |   13 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                  |   14 
 drivers/hid/hid-core.c                                       |   12 
 drivers/hid/hid-debug.c                                      |    3 
 drivers/irqchip/irq-gic-v3-its.c                             |   16 
 drivers/md/bcache/btree.c                                    |    4 
 drivers/md/bcache/sysfs.c                                    |    2 
 drivers/md/bcache/writeback.c                                |   22 
 drivers/md/dm-delay.c                                        |   17 
 drivers/md/md.c                                              |    3 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                     |   14 
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c                 |   11 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                    |   14 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c           |   16 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c      |   20 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c         |    2 
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                   |    8 
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c                |    4 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c              |    4 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c            |    2 
 drivers/net/hyperv/netvsc_drv.c                              |   66 
 drivers/net/ipa/reg/gsi_reg-v5.0.c                           |    2 
 drivers/net/usb/ax88179_178a.c                               |    4 
 drivers/net/veth.c                                           |   46 
 drivers/net/vrf.c                                            |   38 
 drivers/net/wireguard/device.c                               |    4 
 drivers/net/wireguard/receive.c                              |   12 
 drivers/net/wireguard/send.c                                 |    3 
 drivers/nvme/host/fabrics.c                                  |    2 
 drivers/nvme/target/fabrics-cmd.c                            |    4 
 drivers/phy/Kconfig                                          |    1 
 drivers/phy/Makefile                                         |    1 
 drivers/phy/realtek/Kconfig                                  |   32 
 drivers/phy/realtek/Makefile                                 |    3 
 drivers/phy/realtek/phy-rtk-usb2.c                           | 1325 -----------
 drivers/phy/realtek/phy-rtk-usb3.c                           |  761 ------
 drivers/platform/x86/amd/pmc/pmc.c                           |   31 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                 |   24 
 drivers/platform/x86/ideapad-laptop.c                        |   11 
 drivers/s390/block/dasd.c                                    |   24 
 drivers/s390/net/Kconfig                                     |    3 
 drivers/s390/net/ism_drv.c                                   |   93 
 drivers/thunderbolt/switch.c                                 |    2 
 drivers/usb/cdns3/cdnsp-ring.c                               |    3 
 drivers/usb/core/config.c                                    |    3 
 drivers/usb/core/hub.c                                       |   23 
 drivers/usb/dwc2/hcd_intr.c                                  |   15 
 drivers/usb/dwc3/core.c                                      |    2 
 drivers/usb/dwc3/drd.c                                       |    2 
 drivers/usb/dwc3/dwc3-qcom.c                                 |   65 
 drivers/usb/host/xhci-plat.c                                 |   50 
 drivers/usb/misc/onboard_usb_hub.c                           |    2 
 drivers/usb/misc/onboard_usb_hub.h                           |    7 
 drivers/usb/serial/option.c                                  |   11 
 drivers/usb/typec/tcpm/tcpm.c                                |   12 
 drivers/xen/swiotlb-xen.c                                    |    1 
 fs/afs/dynroot.c                                             |    4 
 fs/afs/internal.h                                            |    1 
 fs/afs/server_list.c                                         |    2 
 fs/afs/super.c                                               |    2 
 fs/afs/vl_rotate.c                                           |   10 
 fs/ecryptfs/inode.c                                          |   12 
 fs/inode.c                                                   |    2 
 fs/libfs.c                                                   |   14 
 fs/nfsd/cache.h                                              |    4 
 fs/nfsd/nfscache.c                                           |   64 
 fs/nfsd/nfssvc.c                                             |   14 
 fs/overlayfs/inode.c                                         |   10 
 fs/overlayfs/overlayfs.h                                     |    8 
 fs/smb/client/cifs_debug.c                                   |   16 
 fs/smb/client/cifsglob.h                                     |    2 
 fs/smb/client/connect.c                                      |    6 
 fs/smb/client/sess.c                                         |  112 
 fs/smb/client/smb2ops.c                                      |    6 
 fs/stat.c                                                    |    6 
 include/acpi/acpi_bus.h                                      |    1 
 include/linux/hid.h                                          |    3 
 include/linux/netdevice.h                                    |   30 
 include/linux/pagemap.h                                      |   17 
 include/linux/sched/coredump.h                               |   10 
 include/linux/usb/phy.h                                      |   13 
 include/trace/events/rxrpc.h                                 |    2 
 include/uapi/linux/fcntl.h                                   |    3 
 include/uapi/linux/prctl.h                                   |    1 
 io_uring/fs.c                                                |    2 
 io_uring/rsrc.c                                              |    2 
 kernel/fork.c                                                |    2 
 kernel/locking/lockdep.c                                     |    3 
 kernel/sched/fair.c                                          |  161 +
 kernel/sys.c                                                 |   36 
 mm/page-writeback.c                                          |    2 
 net/core/dev.c                                               |   57 
 net/core/filter.c                                            |    1 
 net/ipv4/route.c                                             |    2 
 net/rxrpc/input.c                                            |   61 
 net/smc/af_smc.c                                             |    8 
 net/tls/tls_sw.c                                             |    3 
 sound/pci/hda/patch_realtek.c                                |   10 
 tools/hv/hv_kvp_daemon.c                                     |   20 
 tools/hv/hv_set_ifconfig.sh                                  |    4 
 tools/include/uapi/linux/prctl.h                             |    1 
 tools/power/pm-graph/sleepgraph.py                           |    2 
 tools/testing/selftests/arm64/fp/za-fork.c                   |    2 
 tools/testing/vsock/vsock_test.c                             |   19 
 126 files changed, 1208 insertions(+), 2686 deletions(-)

Abel Wu (1):
      sched/eevdf: Fix vruntime adjustment on reweight

Alex Elder (1):
      net: ipa: fix one GSI register field width

Alexander Stein (1):
      usb: dwc3: Fix default mode initialization

Andrzej Hajda (1):
      drm/i915: do not clean GT table on error path

Ani Sinha (1):
      hv/hv_kvp_daemon: Some small fixes for handling NM keyfiles

Arseniy Krasnov (1):
      vsock/test: fix SEQPACKET message bounds test

Asuna Yang (1):
      USB: serial: option: add Luat Air72*U series products

Badhri Jagan Sridharan (2):
      usb: typec: tcpm: Fix sink caps op current check
      usb: typec: tcpm: Skip hard reset when in error recovery

Bjorn Andersson (1):
      drm/msm/dpu: Add missing safe_lut_tbl in sc8280xp catalog

Charles Mirabile (1):
      io_uring/fs: consider link->flags when getting path for LINKAT

Charles Yi (1):
      HID: fix HID device resource race between HID core and debugging support

Chen Ni (1):
      ata: pata_isapnp: Add missing error check for devm_ioport_map()

Christoph Hellwig (3):
      filemap: add a per-mapping stable writes flag
      block: update the stable_writes flag in bdev_add
      nvmet: nul-terminate the NQNs passed in the connect command

Chuck Lever (3):
      NFSD: Fix "start of NFS reply" pointer passed to nfsd_cache_update()
      NFSD: Fix checksum mismatches in the duplicate reply cache
      libfs: getdents() should return 0 after reaching EOD

Coly Li (2):
      bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_coalesce()
      bcache: check return value from btree_node_alloc_replacement()

Cong Yang (1):
      drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02 panel HFP and HBP

D. Wythe (1):
      net/smc: avoid data corruption caused by decline

Daniel Borkmann (2):
      net, vrf: Move dstats structure to core
      net: Move {l,t,d}stats allocation to core and convert veth & vrf

David Howells (6):
      rxrpc: Fix RTT determination to use any ACK as a source
      rxrpc: Defer the response to a PING ACK until we've parsed it
      afs: Fix afs_server_list to be cleaned up with RCU
      afs: Make error on cell lookup failure consistent with OpenAFS
      afs: Return ENOENT if no cell DNS record can be found
      afs: Fix file locking on R/O volumes to operate in local mode

David Woodhouse (2):
      PM: tools: Fix sleepgraph syntax error
      ACPI: processor_idle: use raw_safe_halt() in acpi_idle_play_dead()

Eric Dumazet (1):
      wireguard: use DEV_STATS_INC()

Fang Xiang (1):
      irqchip/gic-v3-its: Flush ITS tables correctly in non-coherent GIC designs

Florent Revest (1):
      mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl

Gerd Bayer (1):
      s390/ism: ism driver implies smc protocol

Gil Fine (1):
      thunderbolt: Set lane bonding bit only for downstream port

Greg Kroah-Hartman (1):
      Linux 6.6.4

Haiyang Zhang (2):
      hv_netvsc: fix race of netvsc and VF register_netdevice
      hv_netvsc: Fix race of register_netdevice_notifier and VF register

Hannes Reinecke (1):
      nvme: blank out authentication fabrics options if not configured

Hans de Goede (3):
      ACPI: video: Use acpi_device_fix_up_power_children()
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA
      ACPI: PM: Add acpi_device_fix_up_power_children() function

Harshit Mogalapalli (3):
      platform/x86: hp-bioscfg: Simplify return check in hp_add_other_attributes()
      platform/x86: hp-bioscfg: move mutex_lock() down in hp_add_other_attributes()
      platform/x86: hp-bioscfg: Fix error handling in hp_add_other_attributes()

Helge Deller (1):
      prctl: Disable prctl(PR_SET_MDWE) on parisc

Ivan Vecera (1):
      i40e: Fix adding unsupported cloud filters

Jacek Lawrynowicz (1):
      accel/ivpu/37xx: Fix hangs related to MMIO reset

Jan Höppner (1):
      s390/dasd: protect device queue against concurrent access

Jann Horn (1):
      tls: fix NULL deref on tls_sw_splice_eof() with empty record

Jiawen Wu (1):
      net: wangxun: fix kernel panic due to null pointer

Johan Hovold (8):
      USB: dwc3: qcom: fix resource leaks on probe deferral
      USB: dwc3: qcom: fix ACPI platform device leak
      Revert "usb: phy: add usb phy notify port status API"
      Revert "phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY"
      Revert "phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY"
      USB: xhci-plat: fix legacy PHY double init
      USB: dwc3: qcom: fix software node leak on probe errors
      USB: dwc3: qcom: fix wakeup after probe deferral

Jonas Karlman (1):
      drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full

Jonathan Marek (1):
      drm/msm/dsi: use the correct VREG_CTRL_1 value for 4nm cphy

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix failed operations during ax88179_reset

Keisuke Nishimura (1):
      sched/fair: Fix the decision for load balance

Keith Busch (2):
      swiotlb-xen: provide the "max_mapping_size" method
      io_uring: fix off-by one bvec index

Kunwu Chan (1):
      ipv4: Correct/silence an endian warning in __ip_do_redirect

Lech Perczak (1):
      USB: serial: option: don't claim interface 4 for ZTE MF290

Long Li (1):
      hv_netvsc: Mark VF as slave before exposing it to user-mode

Lorenzo Bianconi (1):
      net: veth: fix ethtool stats reporting

Marek Vasut (2):
      drm/panel: simple: Fix Innolux G101ICE-L01 bus flags
      drm/panel: simple: Fix Innolux G101ICE-L01 timings

Mark Brown (1):
      kselftest/arm64: Fix output formatting for za-fork

Mikhail Zaslonko (1):
      s390/ipl: add missing IPL_TYPE_ECKD_DUMP case to ipl_init()

Mikulas Patocka (1):
      dm-delay: fix a race between delay_presuspend and delay_bio

Ming Lei (1):
      blk-cgroup: avoid to warn !rcu_read_lock_held() in blkg_lookup()

Mingzhe Zou (3):
      bcache: fixup multi-threaded bch_sectors_dirty_init() wake-up race
      bcache: fixup init dirty data errors
      bcache: fixup lock c->root error

Niklas Neronin (1):
      usb: config: fix iteration issue in 'usb_get_bos_descriptor()'

Oliver Neukum (1):
      USB: dwc2: write HCINT with INTMASK applied

Pawel Laszczak (1):
      usb: cdnsp: Fix deadlock issue during using NCM gadget

Peilin Ye (2):
      bpf: Fix dev's rx stats for bpf_redirect_peer traffic
      veth: Use tstats per-CPU traffic counters

Peter Zijlstra (1):
      lockdep: Fix block chain corruption

Puliang Lu (1):
      USB: serial: option: fix FM101R-GL defines

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

Shyam Prasad N (3):
      cifs: distribute channels across interfaces based on speed
      cifs: account for primary channel in the interface list
      cifs: fix leak of iface for primary channel

Shyam Sundar S K (1):
      platform/x86/amd/pmc: adjust getting DRAM size behavior

Song Liu (1):
      md: fix bi_status reporting in md_end_clone_io

Stanislaw Gruszka (1):
      accel/ivpu: Do not initialize parameters on power up

Stefan Berger (1):
      fs: Pass AT_GETATTR_NOSEC flag to getattr interface function

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for ASUS 2024 Zenbooks

Stefan Eichenberger (2):
      dt-bindings: usb: microchip,usb5744: Add second supply
      usb: misc: onboard-hub: add support for Microchip USB5744

Stefano Stabellini (1):
      arm/xen: fix xen_vcpu_info allocation alignment

Stuart Hayhurst (1):
      platform/x86: ideapad-laptop: Set max_brightness before using it

Suman Ghosh (2):
      octeontx2-pf: Fix memory leak during interface down
      octeontx2-pf: Fix ntuple rule creation to direct packet to VF with higher Rx queue than its PF

Thomas Zimmermann (1):
      drm/ast: Disconnect BMC if physical connector is connected

Victor Fragoso (1):
      USB: serial: option: add Fibocom L7xx modules

Vitalii Torshyn (1):
      ALSA: hda: ASUS UM5302LA: Added quirks for cs35L41/10431A83 on i2c bus

Will Deacon (1):
      arm64: mm: Fix "rodata=on" when CONFIG_RODATA_FULL_DEFAULT_ENABLED=y

Xuxin Xiong (1):
      drm/panel: auo,b101uan08.3: Fine tune the panel power sequence

