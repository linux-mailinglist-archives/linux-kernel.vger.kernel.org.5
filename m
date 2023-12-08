Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59046809DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjLHH43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbjLHH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:56:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DF1731
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:56:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB6FC433CA;
        Fri,  8 Dec 2023 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702022187;
        bh=kPx/xAA1D6oH0uZG8XP/jO0E8ivAgdCgGBnHdrZ3pLE=;
        h=From:To:Cc:Subject:Date:From;
        b=skm7Q3/EkJurt/mZ4TSVFbYqFPMWmK/WgcCT6Q6r77HRrvbYkK5skuY8LNqEw7NIk
         KYLqhRiEQSyYUzjXkbzYY5j7Z5yLhrOQ6HMAgcxxCmiX06LZdV/b4TQ7I4QXiIA0K0
         mpKkD6WC6WrxnE51zTrxWnTp4hnj+famjYvbJdXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.301
Date:   Fri,  8 Dec 2023 08:56:20 +0100
Message-ID: <2023120821-superbowl-baggy-51b5@gregkh>
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

I'm announcing the release of the 4.19.301 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/arm/xen/enlighten.c                          |    3 -
 arch/arm64/include/asm/cpufeature.h               |   23 ++++++++++
 arch/arm64/include/asm/sysreg.h                   |    6 ++
 arch/arm64/kvm/sys_regs.c                         |   10 ++++
 arch/mips/kvm/mmu.c                               |    3 -
 arch/powerpc/kernel/fpu.S                         |   13 +++++
 arch/powerpc/kernel/vector.S                      |    2 
 arch/s390/mm/page-states.c                        |   14 +++---
 drivers/ata/pata_isapnp.c                         |    3 +
 drivers/base/dd.c                                 |    4 -
 drivers/cpufreq/imx6q-cpufreq.c                   |   32 +++++++-------
 drivers/firewire/core-device.c                    |   11 +----
 drivers/gpu/drm/panel/panel-simple.c              |   12 ++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c       |   14 +++++-
 drivers/hid/hid-core.c                            |   16 +++++--
 drivers/hid/hid-debug.c                           |    3 +
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c          |    6 ++
 drivers/infiniband/hw/i40iw/i40iw_type.h          |    2 
 drivers/infiniband/hw/i40iw/i40iw_verbs.c         |   10 +++-
 drivers/input/joystick/xpad.c                     |    2 
 drivers/md/bcache/btree.c                         |    6 +-
 drivers/md/bcache/sysfs.c                         |    2 
 drivers/md/dm-delay.c                             |   17 +++++--
 drivers/md/dm-verity-fec.c                        |    3 -
 drivers/md/dm-verity-target.c                     |    4 +
 drivers/md/dm-verity.h                            |    6 --
 drivers/mmc/core/block.c                          |    2 
 drivers/mmc/core/core.c                           |   15 ++++--
 drivers/mmc/host/cqhci.c                          |   44 ++++++++++----------
 drivers/mtd/chips/cfi_cmdset_0001.c               |   29 +++++++++++--
 drivers/mtd/nand/raw/brcmnand/brcmnand.c          |    5 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c          |   14 ++++++
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c      |   11 +++--
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c         |   14 +++++-
 drivers/net/ethernet/renesas/ravb_main.c          |   15 +++++-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c |    2 
 drivers/net/hyperv/netvsc_drv.c                   |   41 +++++++++++++-----
 drivers/net/usb/ax88179_178a.c                    |    4 -
 drivers/pinctrl/core.c                            |    6 +-
 drivers/s390/block/dasd.c                         |   24 +++++------
 drivers/usb/dwc2/hcd_intr.c                       |   15 +++---
 drivers/usb/dwc3/core.c                           |    2 
 drivers/usb/dwc3/dwc3-qcom.c                      |    8 +--
 drivers/usb/serial/option.c                       |   11 +++--
 drivers/video/fbdev/sticore.h                     |    2 
 fs/btrfs/send.c                                   |    2 
 fs/btrfs/volumes.c                                |    2 
 fs/cifs/cifsfs.c                                  |    1 
 fs/overlayfs/super.c                              |    5 +-
 fs/sync.c                                         |    3 -
 include/linux/fs.h                                |    2 
 include/linux/hid.h                               |    5 ++
 net/ipv4/igmp.c                                   |    6 +-
 net/ipv4/route.c                                  |    2 
 security/integrity/iint.c                         |   48 ++++++++++++++++------
 security/integrity/ima/ima_api.c                  |    5 ++
 security/integrity/ima/ima_main.c                 |   16 ++++++-
 security/integrity/integrity.h                    |    2 
 sound/pci/hda/hda_intel.c                         |    2 
 sound/pci/hda/patch_realtek.c                     |    9 ++++
 61 files changed, 433 insertions(+), 170 deletions(-)

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

Benjamin Tissoires (1):
      HID: core: store the unique system identifier in hid_device

Charles Yi (1):
      HID: fix HID device resource race between HID core and debugging support

Chen Ni (1):
      ata: pata_isapnp: Add missing error check for devm_ioport_map()

Christoph Niedermaier (2):
      cpufreq: imx6q: don't warn for disabling a non-existing frequency
      cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Christopher Bednarz (1):
      RDMA/irdma: Prevent zero-length STAG registration

Claire Lin (1):
      mtd: rawnand: brcmnand: Fix ecc chunk calculation for erased page bitfips

Claudiu Beznea (1):
      net: ravb: Start TX queues after HW initialization succeeded

Coly Li (2):
      bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_coalesce()
      bcache: check return value from btree_node_alloc_replacement()

Filipe Manana (1):
      btrfs: fix off-by-one when checking chunk map includes logical address

Greg Kroah-Hartman (1):
      Linux 4.19.301

Haiyang Zhang (1):
      hv_netvsc: Fix race of register_netdevice_notifier and VF register

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

Johan Hovold (1):
      USB: dwc3: qcom: fix wakeup after probe deferral

Jonas Karlman (1):
      drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix failed operations during ax88179_reset

Kailang Yang (1):
      ALSA: hda/realtek: Headset Mic VREF to 100%

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

Marek Vasut (1):
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

Oliver Neukum (1):
      USB: dwc2: write HCINT with INTMASK applied

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

Zheng Yongjun (1):
      mmc: core: convert comma to semicolon

Zhengchao Shao (1):
      ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

