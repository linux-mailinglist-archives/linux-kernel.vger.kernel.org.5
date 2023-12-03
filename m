Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC14802158
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjLCGvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLCGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:51:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7BE6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:51:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FF3C433C8;
        Sun,  3 Dec 2023 06:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701586285;
        bh=N+Rh70zsU3qX10WnIguH6nrVBA7TkEs3HeS2DV9AzwA=;
        h=From:To:Cc:Subject:Date:From;
        b=dXEcSOUvlCi8+zsUGyV3e2Ibm8j39Y5tWJ1tQefSnwF/X9jIciU58/4ZrmyJo4NcN
         9vDwNFYL5YpuRPzOOaLbqIz2dEL0+37GwBNxJr8sDGtKuz6kK0vIrmgMVqr8Jt3Ff7
         comNbMpFhOsqYQO4HWWOXGbXNsdT5kW5Ll/DITCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.141
Date:   Sun,  3 Dec 2023 07:51:21 +0100
Message-ID: <2023120321-identify-connected-5156@gregkh>
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

I'm announcing the release of the 5.15.141 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/arm/xen/enlighten.c                                |    3 
 arch/mips/kvm/mmu.c                                     |    3 
 drivers/acpi/resource.c                                 |    7 
 drivers/ata/pata_isapnp.c                               |    3 
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c          |    7 
 drivers/gpu/drm/panel/panel-simple.c                    |   13 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c             |   14 
 drivers/hid/hid-core.c                                  |   16 
 drivers/hid/hid-debug.c                                 |    3 
 drivers/md/bcache/btree.c                               |    4 
 drivers/md/bcache/sysfs.c                               |    2 
 drivers/md/bcache/writeback.c                           |   22 -
 drivers/md/dm-delay.c                                   |   17 
 drivers/md/md.c                                         |    3 
 drivers/media/platform/qcom/camss/camss-csid-170.c      |   65 ++-
 drivers/media/platform/qcom/camss/camss-csid.c          |   44 +-
 drivers/media/platform/qcom/camss/camss-csid.h          |   11 
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                |   14 
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c            |   11 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c               |   14 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c |   20 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c    |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c       |    2 
 drivers/net/hyperv/netvsc_drv.c                         |   41 +-
 drivers/net/usb/ax88179_178a.c                          |    4 
 drivers/net/wireguard/device.c                          |    4 
 drivers/net/wireguard/receive.c                         |   12 
 drivers/net/wireguard/send.c                            |    3 
 drivers/nvme/target/fabrics-cmd.c                       |    4 
 drivers/s390/block/dasd.c                               |   24 -
 drivers/usb/cdns3/cdnsp-ring.c                          |    3 
 drivers/usb/dwc2/hcd_intr.c                             |   15 
 drivers/usb/dwc3/core.c                                 |    2 
 drivers/usb/dwc3/drd.c                                  |    2 
 drivers/usb/dwc3/dwc3-qcom.c                            |   65 ++-
 drivers/usb/serial/option.c                             |   11 
 drivers/usb/typec/tcpm/tcpm.c                           |    9 
 drivers/xen/swiotlb-xen.c                               |    1 
 fs/afs/dynroot.c                                        |    4 
 fs/afs/internal.h                                       |    1 
 fs/afs/server_list.c                                    |    2 
 fs/afs/super.c                                          |    2 
 fs/afs/vl_rotate.c                                      |   10 
 fs/ext4/extents_status.c                                |  306 +++++++++++-----
 fs/proc/proc_sysctl.c                                   |    7 
 include/linux/hid.h                                     |    5 
 include/linux/sysctl.h                                  |    6 
 init/main.c                                             |    4 
 io_uring/io_uring.c                                     |    4 
 kernel/locking/lockdep.c                                |    3 
 net/ipv4/route.c                                        |    2 
 net/smc/af_smc.c                                        |    8 
 53 files changed, 628 insertions(+), 238 deletions(-)

Alexander Stein (1):
      usb: dwc3: Fix default mode initialization

Andrey Konovalov (1):
      media: qcom: camss: Fix csid-gen2 for test pattern generator

Asuna Yang (1):
      USB: serial: option: add Luat Air72*U series products

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Skip hard reset when in error recovery

Baokun Li (8):
      ext4: add a new helper to check if es must be kept
      ext4: factor out __es_alloc_extent() and __es_free_extent()
      ext4: use pre-allocated es in __es_insert_extent()
      ext4: use pre-allocated es in __es_remove_extent()
      ext4: using nofail preallocation in ext4_es_remove_extent()
      ext4: using nofail preallocation in ext4_es_insert_delayed_block()
      ext4: using nofail preallocation in ext4_es_insert_extent()
      ext4: fix slab-use-after-free in ext4_es_insert_extent()

Benjamin Tissoires (1):
      HID: core: store the unique system identifier in hid_device

Bryan O'Donoghue (1):
      media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater than 3

Charles Mirabile (1):
      io_uring/fs: consider link->flags when getting path for LINKAT

Charles Yi (1):
      HID: fix HID device resource race between HID core and debugging support

Chen Ni (1):
      ata: pata_isapnp: Add missing error check for devm_ioport_map()

Christoph Hellwig (1):
      nvmet: nul-terminate the NQNs passed in the connect command

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

Greg Kroah-Hartman (1):
      Linux 5.15.141

Haiyang Zhang (1):
      hv_netvsc: Fix race of register_netdevice_notifier and VF register

Hans de Goede (1):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA

Huacai Chen (1):
      MIPS: KVM: Fix a build warning about variable set but not used

Jan Höppner (1):
      s390/dasd: protect device queue against concurrent access

Johan Hovold (4):
      USB: dwc3: qcom: fix resource leaks on probe deferral
      USB: dwc3: qcom: fix ACPI platform device leak
      USB: dwc3: qcom: fix software node leak on probe errors
      USB: dwc3: qcom: fix wakeup after probe deferral

Jonas Karlman (1):
      drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix failed operations during ax88179_reset

Keith Busch (2):
      swiotlb-xen: provide the "max_mapping_size" method
      io_uring: fix off-by one bvec index

Krister Johansen (1):
      proc: sysctl: prevent aliased sysctls from getting passed to init

Kunwu Chan (1):
      ipv4: Correct/silence an endian warning in __ip_do_redirect

Lech Perczak (1):
      USB: serial: option: don't claim interface 4 for ZTE MF290

Long Li (1):
      hv_netvsc: Mark VF as slave before exposing it to user-mode

Marek Vasut (2):
      drm/panel: simple: Fix Innolux G101ICE-L01 bus flags
      drm/panel: simple: Fix Innolux G101ICE-L01 timings

Mikulas Patocka (1):
      dm-delay: fix a race between delay_presuspend and delay_bio

Milen Mitkov (1):
      media: camss: sm8250: Virtual channels for CSID

Mingzhe Zou (3):
      bcache: fixup multi-threaded bch_sectors_dirty_init() wake-up race
      bcache: fixup init dirty data errors
      bcache: fixup lock c->root error

Oliver Neukum (1):
      USB: dwc2: write HCINT with INTMASK applied

Pawel Laszczak (1):
      usb: cdnsp: Fix deadlock issue during using NCM gadget

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

Shuijing Li (1):
      drm/panel: boe-tv101wum-nl6: Fine tune the panel power sequence

Song Liu (1):
      md: fix bi_status reporting in md_end_clone_io

Souptick Joarder (HPE) (1):
      media: camss: Replace hard coded value with parameter

Stefano Stabellini (1):
      arm/xen: fix xen_vcpu_info allocation alignment

Suman Ghosh (2):
      octeontx2-pf: Fix memory leak during interface down
      octeontx2-pf: Fix ntuple rule creation to direct packet to VF with higher Rx queue than its PF

Victor Fragoso (1):
      USB: serial: option: add Fibocom L7xx modules

Xuxin Xiong (1):
      drm/panel: auo,b101uan08.3: Fine tune the panel power sequence

Zhang Yi (1):
      ext4: make sure allocate pending entry not fail

