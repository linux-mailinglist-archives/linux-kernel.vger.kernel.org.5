Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C127D03A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbjJSVUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjJSVUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:20:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90CF124;
        Thu, 19 Oct 2023 14:20:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F4BC433C7;
        Thu, 19 Oct 2023 21:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697750448;
        bh=1IWa20NSRpfM9OQU5i9J1GMeLLDXGr8iLdR3kG46e1A=;
        h=From:To:Cc:Subject:Date:From;
        b=FNpev1a80ehDVYEGsZsUmwJHKg2taEkLypZtYBpmBLh5NPj90GYQnrWHkXi9rvJ0M
         FzL8xhe9i3CVaL1zwKZnChwZe/5oLwwzMoH9/OAn422D6wiAZr8ELiitquYPglROGC
         iR7pMPkuFuB6Csl3UUscfOK5GmyFC57FtdcQ8Eno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.136
Date:   Thu, 19 Oct 2023 23:20:43 +0200
Message-ID: <2023101944-maritime-crabbing-429f@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.136 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt          |   10 
 Documentation/networking/ip-sysctl.rst                   |    8 
 Documentation/security/keys/trusted-encrypted.rst        |   20 
 Makefile                                                 |    2 
 arch/arm64/include/asm/cpufeature.h                      |    3 
 arch/arm64/include/asm/exception.h                       |   13 
 arch/arm64/include/asm/spectre.h                         |    2 
 arch/arm64/include/asm/system_misc.h                     |    2 
 arch/arm64/include/asm/traps.h                           |   19 
 arch/arm64/kernel/armv8_deprecated.c                     |  572 +++++++--------
 arch/arm64/kernel/cpufeature.c                           |   23 
 arch/arm64/kernel/entry-common.c                         |   36 
 arch/arm64/kernel/proton-pack.c                          |   26 
 arch/arm64/kernel/traps.c                                |  125 +--
 arch/powerpc/include/asm/nohash/32/pte-8xx.h             |    7 
 arch/powerpc/include/asm/nohash/64/pgtable.h             |    2 
 arch/powerpc/include/asm/nohash/pgtable.h                |    2 
 arch/riscv/net/bpf_jit_comp64.c                          |   33 
 arch/x86/include/asm/msr-index.h                         |    9 
 arch/x86/kernel/alternative.c                            |   13 
 arch/x86/kernel/cpu/amd.c                                |    8 
 drivers/acpi/resource.c                                  |    7 
 drivers/counter/microchip-tcb-capture.c                  |    2 
 drivers/dma/idxd/device.c                                |    5 
 drivers/dma/mediatek/mtk-uart-apdma.c                    |    3 
 drivers/dma/stm32-mdma.c                                 |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h               |    2 
 drivers/gpu/drm/amd/display/dc/core/dc.c                 |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                |   12 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                         |   13 
 drivers/gpu/drm/msm/dsi/dsi_host.c                       |   19 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                  |    2 
 drivers/hid/hid-logitech-hidpp.c                         |    3 
 drivers/iio/pressure/bmp280-core.c                       |    2 
 drivers/iio/pressure/dps310.c                            |    8 
 drivers/iio/pressure/ms5611_core.c                       |    2 
 drivers/infiniband/hw/cxgb4/cm.c                         |    3 
 drivers/infiniband/ulp/srp/ib_srp.c                      |   22 
 drivers/input/joystick/xpad.c                            |    2 
 drivers/input/misc/powermate.c                           |    1 
 drivers/input/mouse/elantech.c                           |    1 
 drivers/input/mouse/synaptics.c                          |    1 
 drivers/input/serio/i8042-acpipnpio.h                    |    8 
 drivers/input/touchscreen/goodix.c                       |   19 
 drivers/iommu/intel/iommu.c                              |   16 
 drivers/mcb/mcb-core.c                                   |   10 
 drivers/mcb/mcb-parse.c                                  |    2 
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c          |    1 
 drivers/net/ethernet/amazon/ena/ena_netdev.c             |    4 
 drivers/net/ethernet/brocade/bna/bnad.c                  |    3 
 drivers/net/ethernet/cortina/gemini.c                    |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c           |    5 
 drivers/net/ethernet/marvell/skge.c                      |    3 
 drivers/net/ethernet/marvell/sky2.c                      |    3 
 drivers/net/ethernet/mediatek/mtk_star_emac.c            |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |    3 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c |    4 
 drivers/net/ethernet/nvidia/forcedeth.c                  |    6 
 drivers/net/ethernet/renesas/ravb_main.c                 |    6 
 drivers/net/ethernet/ti/davinci_emac.c                   |    3 
 drivers/net/ethernet/ti/netcp_core.c                     |    5 
 drivers/net/ieee802154/ca8210.c                          |   17 
 drivers/net/macsec.c                                     |    2 
 drivers/net/phy/mscc/mscc_macsec.c                       |    6 
 drivers/net/usb/dm9601.c                                 |    7 
 drivers/net/xen-netback/interface.c                      |    7 
 drivers/of/overlay.c                                     |    2 
 drivers/perf/arm-cmn.c                                   |    2 
 drivers/pinctrl/core.c                                   |   16 
 drivers/pinctrl/renesas/Kconfig                          |    1 
 drivers/platform/x86/hp/hp-wmi.c                         |    8 
 drivers/platform/x86/think-lmi.c                         |   24 
 drivers/scsi/scsi_error.c                                |   17 
 drivers/scsi/scsi_lib.c                                  |   15 
 drivers/scsi/scsi_priv.h                                 |    1 
 drivers/tee/amdtee/core.c                                |   10 
 drivers/thunderbolt/icm.c                                |   40 -
 drivers/thunderbolt/switch.c                             |    7 
 drivers/usb/cdns3/cdnsp-gadget.c                         |    3 
 drivers/usb/cdns3/core.h                                 |    3 
 drivers/usb/core/hub.c                                   |   25 
 drivers/usb/core/hub.h                                   |    2 
 drivers/usb/dwc3/core.c                                  |   39 -
 drivers/usb/gadget/function/f_ncm.c                      |   26 
 drivers/usb/gadget/udc/udc-xilinx.c                      |   20 
 drivers/usb/host/xhci-ring.c                             |    4 
 drivers/usb/host/xhci.c                                  |   35 
 drivers/usb/musb/musb_debugfs.c                          |    2 
 drivers/usb/musb/musb_host.c                             |    9 
 fs/ceph/file.c                                           |    2 
 fs/ceph/inode.c                                          |    4 
 fs/quota/dquot.c                                         |   66 +
 include/keys/trusted-type.h                              |    2 
 include/linux/intel-iommu.h                              |    2 
 include/linux/ipv6.h                                     |    1 
 include/linux/mcb.h                                      |    1 
 include/linux/quota.h                                    |    4 
 include/linux/quotaops.h                                 |    2 
 include/net/macsec.h                                     |    1 
 include/scsi/scsi_cmnd.h                                 |    9 
 include/uapi/linux/ipv6.h                                |    3 
 kernel/bpf/verifier.c                                    |    6 
 kernel/cgroup/cgroup-v1.c                                |    5 
 kernel/sched/core.c                                      |    2 
 kernel/sched/idle.c                                      |    1 
 kernel/workqueue.c                                       |    8 
 lib/test_meminit.c                                       |    2 
 net/ceph/messenger.c                                     |    4 
 net/ipv6/addrconf.c                                      |   13 
 net/ipv6/ndisc.c                                         |   13 
 net/netfilter/ipvs/ip_vs_sync.c                          |    4 
 net/nfc/llcp_core.c                                      |   30 
 net/nfc/nci/core.c                                       |    5 
 net/rds/tcp_connect.c                                    |    2 
 net/rds/tcp_listen.c                                     |    2 
 net/smc/smc_stats.h                                      |   14 
 net/socket.c                                             |    6 
 security/keys/trusted-keys/trusted_core.c                |   48 +
 sound/usb/quirks.c                                       |    6 
 119 files changed, 1024 insertions(+), 754 deletions(-)

Abhinav Kumar (2):
      drm/msm/dsi: skip the wait for video mode done if not applicable
      drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow

Ahmad Fatoum (1):
      KEYS: trusted: allow use of kernel RNG for key material

Alexander Zangerl (1):
      iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

Amelie Delaunay (1):
      dmaengine: stm32-mdma: abort resume if no ongoing transfer

Armin Wolf (1):
      platform/x86: think-lmi: Fix reference leak

Artem Chernyshev (1):
      RDMA/cxgb4: Check skb value for failure to allocate

Bart Van Assche (4):
      scsi: core: Use a structure member to track the SCSI command submitter
      scsi: core: Rename scsi_mq_done() into scsi_done() and export it
      scsi: ib_srp: Call scsi_done() directly
      RDMA/srp: Do not call scsi_done() from srp_abort()

Björn Töpel (1):
      riscv, bpf: Sign-extend return values

Borislav Petkov (AMD) (1):
      x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

Christian König (1):
      drm/amdgpu: add missing NULL check

Christophe Leroy (2):
      powerpc/8xx: Fix pte_access_permitted() for PAGE_NONE
      powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()

Dan Carpenter (4):
      drm/msm/dsi: fix irq_of_parse_and_map() error checking
      mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type
      ixgbe: fix crash with empty VF macvlan list
      ceph: fix type promotion bug on 32bit systems

Daniel Miess (1):
      drm/amd/display: Don't set dpms_off for seamless boot

David Vernet (1):
      bpf: Fix verifier log for async callback return values

Dharma Balasubiramani (1):
      counter: microchip-tcb-capture: Fix the use of internal GCLK logic

Dinghao Liu (1):
      ieee802154: ca8210: Fix a potential UAF in ca8210_probe

Dmitry Torokhov (1):
      pinctrl: avoid unsafe code pattern in find_pinctrl()

Duoming Zhou (1):
      dmaengine: mediatek: Fix deadlock caused by synchronize_irq()

Eric Dumazet (1):
      net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()

Geert Uytterhoeven (1):
      of: overlay: Reorder struct fragment fields kerneldoc

Greg Kroah-Hartman (3):
      lib/test_meminit: fix off-by-one error in test_pages()
      Revert "kernel/sched: Modify initial boot task idle setup"
      Linux 5.15.136

Hans de Goede (3):
      HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA
      Input: goodix - ensure int GPIO is in input for gpio_count == 1 && gpio_int_idx == 0 case

Hongyu Xie (1):
      xhci: Keep interrupt disabled in initialization until host is running.

Jakub Kicinski (2):
      eth: remove copies of the NAPI_POLL_WEIGHT define
      eth: remove remaining copies of the NAPI_POLL_WEIGHT define

Jan Kara (1):
      quota: Fix slow quotaoff

Javier Carrasco (2):
      net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read
      Input: powermate - fix use-after-free in powermate_config_complete

Jeffery Miller (1):
      Input: psmouse - fix fast_reconnect function for PS/2 mode

Jeremy Cline (1):
      nfc: nci: assert requested protocol is valid

Jing Zhang (1):
      perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7

Jordan Rife (2):
      net: prevent address rewrite in kernel_bind()
      libceph: use kernel_connect()

Jorge Sanjuan Garcia (1):
      mcb: remove is_added flag from mcb_device struct

Kirill A. Shutemov (1):
      x86/alternatives: Disable KASAN in apply_alternatives()

Konstantin Meskhidze (1):
      drm/vmwgfx: fix typo of sizeof argument

Krishna Kurapati (1):
      usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call

Kuogee Hsieh (1):
      drm/msm/dp: do not reinitialize phy unless retry during link training

Lakshmi Yadlapati (1):
      iio: pressure: dps310: Adjust Timeout Settings

Mark Rutland (14):
      arm64: report EL1 UNDEFs better
      arm64: die(): pass 'err' as long
      arm64: consistently pass ESR_ELx to die()
      arm64: rework FPAC exception handling
      arm64: rework BTI exception handling
      arm64: allow kprobes on EL0 handlers
      arm64: split EL0/EL1 UNDEF handlers
      arm64: factor out EL1 SSBS emulation hook
      arm64: factor insn read out of call_undef_hook()
      arm64: rework EL0 MRS emulation
      arm64: armv8_deprecated: fold ops into insn_emulation
      arm64: armv8_deprecated move emulation functions
      arm64: armv8_deprecated: move aarch32 helper earlier
      arm64: armv8_deprecated: rework deprected instruction handling

Matthias Berndt (1):
      Input: xpad - add PXN V900 support

Michal Koutný (1):
      cgroup: Remove duplicates in cgroup v1 tasks file

Mika Westerberg (2):
      thunderbolt: Workaround an IOMMU fault on certain systems with Intel Maple Ridge
      thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding

Nils Hoppmann (1):
      net/smc: Fix pos miscalculation in statistics

Patrick Rohr (3):
      net: add sysctl accept_ra_min_rtr_lft
      net: change accept_ra_min_rtr_lft to affect all RA lifetimes
      net: release reference to inet6_dev pointer

Pawel Laszczak (1):
      usb: cdnsp: Fixes issue with dequeuing not queued requests

Phil Elwell (1):
      iio: pressure: bmp280: Fix NULL pointer exception

Piyush Mehta (1):
      usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Pu Lehui (1):
      riscv, bpf: Factor out emit_call for kernel and bpf context

Radu Pirea (NXP OSS) (2):
      net: macsec: indicate next pn update when offloading
      net: phy: mscc: macsec: reject PN update requests

Ralph Siemsen (1):
      pinctrl: renesas: rzn1: Enable missing PINMUX

Ren Zhijie (1):
      arm64: armv8_deprecated: fix unused-function error

Rex Zhang (1):
      dmaengine: idxd: use spin_lock_irqsave before wait_event_lock_irq

Ricardo Cañuelo (1):
      usb: hub: Guard against accesses to uninitialized BOS descriptors

Rijo Thomas (1):
      tee: amdtee: fix use-after-free vulnerability in amdtee_close_session

Roger Pau Monne (1):
      xen-netback: use default TX queue size for vifs

Sumit Garg (1):
      KEYS: trusted: Remove redundant static calls usage

Szilard Fabian (1):
      Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table

Thinh Nguyen (1):
      usb: dwc3: Soft reset phy on probe for host

Uwe Kleine-König (1):
      platform/x86: hp-wmi:: Mark driver struct with __refdata to prevent section mismatch warning

Waiman Long (1):
      workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()

Wesley Cheng (1):
      usb: xhci: xhci-ring: Use sysdev for mapping bounce buffer

WhaleChang (1):
      ALSA: usb-audio: Fix microphone sound on Opencomm2 Headset

Will Mortensen (1):
      net/mlx5e: Again mutually exclude RX-FCS and RX-port-timestamp

Xiaolei Wang (1):
      usb: cdns3: Modify the return value of cdns_set_active () to void when CONFIG_PM_SLEEP is disabled

Xingxing Luo (2):
      usb: musb: Get the musb_qh poniter after musb_giveback
      usb: musb: Modify the "HWVers" register address

Xiubo Li (1):
      ceph: fix incorrect revoked caps assert in ceph_fill_file_size()

Yoshihiro Shimoda (2):
      ravb: Fix up dma_free_coherent() call in ravb_remove()
      ravb: Fix use-after-free issue in ravb_tx_timeout_work()

Zhang Rui (1):
      iommu/vt-d: Avoid memory allocation in iommu_suspend()

Zheng Wang (1):
      media: mtk-jpeg: Fix use after free bug due to uncanceled work

