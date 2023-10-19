Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E917D03A3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346583AbjJSVVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjJSVVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:21:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A28F11F;
        Thu, 19 Oct 2023 14:21:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4088BC433C7;
        Thu, 19 Oct 2023 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697750459;
        bh=F2+TX39olfb2v+ixHoENidFCQvqRdNwTvdN3Iei2uLk=;
        h=From:To:Cc:Subject:Date:From;
        b=W0W7E7F6QsTIMla8A9OGytMWDsWZmzr2Hr9oV02+uhr5Cxjz9Lm0ddxxCa4tkX6ZB
         hAh1OSouNg56i14cvyilDlaHFpALhi+GzmPNZNTBo/fm45JzQreYq8Vadwa78uS3Yc
         HFHP7ZkrxTovfosd7nyuzLH62jm86N5oIJ2Nb9vM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.59
Date:   Thu, 19 Oct 2023 23:20:51 +0200
Message-ID: <2023101952-impart-strangle-cd9d@gregkh>
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

I'm announcing the release of the 6.1.59 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml |    5 
 Documentation/networking/ip-sysctl.rst                                         |   15 +
 Makefile                                                                       |    2 
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts                                   |   39 +++-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                                       |    1 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                           |    2 
 arch/powerpc/include/asm/nohash/32/pte-8xx.h                                   |    7 
 arch/powerpc/include/asm/nohash/64/pgtable.h                                   |    2 
 arch/powerpc/include/asm/nohash/pgtable.h                                      |    2 
 arch/powerpc/kernel/entry_32.S                                                 |    8 
 arch/riscv/net/bpf_jit_comp64.c                                                |   33 +--
 arch/x86/events/utils.c                                                        |    5 
 arch/x86/include/asm/msr-index.h                                               |    9 -
 arch/x86/kernel/alternative.c                                                  |   13 +
 arch/x86/kernel/cpu/amd.c                                                      |    8 
 drivers/acpi/ec.c                                                              |   11 +
 drivers/acpi/resource.c                                                        |    7 
 drivers/ata/libata-core.c                                                      |   90 ++++++++++
 drivers/ata/libata-eh.c                                                        |   54 +++++-
 drivers/ata/libata-scsi.c                                                      |   16 -
 drivers/ata/libata.h                                                           |    2 
 drivers/counter/counter-chrdev.c                                               |    4 
 drivers/counter/microchip-tcb-capture.c                                        |    2 
 drivers/dma-buf/dma-fence-unwrap.c                                             |   13 -
 drivers/dma-buf/sync_file.c                                                    |    9 -
 drivers/dma/idxd/device.c                                                      |    5 
 drivers/dma/mediatek/mtk-uart-apdma.c                                          |    3 
 drivers/dma/stm32-dma.c                                                        |   11 -
 drivers/dma/stm32-mdma.c                                                       |   33 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                                     |    2 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                       |    3 
 drivers/gpu/drm/drm_atomic_helper.c                                            |   17 +
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c                                       |   11 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                                      |   12 -
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                               |   13 -
 drivers/gpu/drm/msm/dp/dp_link.c                                               |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                             |   19 +-
 drivers/gpu/drm/scheduler/sched_main.c                                         |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                                        |    2 
 drivers/hid/hid-logitech-hidpp.c                                               |    3 
 drivers/iio/adc/imx8qxp-adc.c                                                  |    4 
 drivers/iio/addac/Kconfig                                                      |    2 
 drivers/iio/dac/ad3552r.c                                                      |    4 
 drivers/iio/frequency/admv1013.c                                               |    4 
 drivers/iio/imu/bno055/Kconfig                                                 |    2 
 drivers/iio/pressure/bmp280-core.c                                             |    2 
 drivers/iio/pressure/dps310.c                                                  |    8 
 drivers/iio/pressure/ms5611_core.c                                             |    2 
 drivers/infiniband/hw/cxgb4/cm.c                                               |    3 
 drivers/input/joystick/xpad.c                                                  |    2 
 drivers/input/misc/powermate.c                                                 |    1 
 drivers/input/mouse/elantech.c                                                 |    1 
 drivers/input/mouse/synaptics.c                                                |    1 
 drivers/input/serio/i8042-acpipnpio.h                                          |    8 
 drivers/input/touchscreen/goodix.c                                             |   19 ++
 drivers/irqchip/irq-renesas-rzg2l.c                                            |    2 
 drivers/mcb/mcb-core.c                                                         |   10 -
 drivers/mcb/mcb-parse.c                                                        |    2 
 drivers/net/can/Kconfig                                                        |    2 
 drivers/net/dsa/qca/qca8k-8xxx.c                                               |   11 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                                 |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c                      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                              |    3 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c                       |    4 
 drivers/net/ethernet/microsoft/mana/mana_en.c                                  |   18 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c                               |   10 -
 drivers/net/ethernet/netronome/nfp/flower/conntrack.c                          |   19 +-
 drivers/net/ethernet/netronome/nfp/flower/main.h                               |    2 
 drivers/net/ethernet/netronome/nfp/flower/metadata.c                           |    2 
 drivers/net/ethernet/netronome/nfp/flower/offload.c                            |   24 ++
 drivers/net/ethernet/netronome/nfp/flower/qos_conf.c                           |   20 +-
 drivers/net/ethernet/renesas/ravb_main.c                                       |    6 
 drivers/net/ieee802154/ca8210.c                                                |   17 -
 drivers/net/macsec.c                                                           |    2 
 drivers/net/phy/mscc/mscc_macsec.c                                             |    6 
 drivers/net/usb/dm9601.c                                                       |    7 
 drivers/net/xen-netback/interface.c                                            |    4 
 drivers/perf/arm-cmn.c                                                         |    2 
 drivers/phy/freescale/phy-fsl-lynx-28g.c                                       |   27 ++-
 drivers/pinctrl/core.c                                                         |   16 +
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c                                      |    6 
 drivers/pinctrl/renesas/Kconfig                                                |    1 
 drivers/platform/x86/hp/hp-wmi.c                                               |    8 
 drivers/platform/x86/think-lmi.c                                               |   24 ++
 drivers/scsi/scsi_scan.c                                                       |   11 -
 drivers/tee/amdtee/core.c                                                      |   10 -
 drivers/thunderbolt/icm.c                                                      |   40 ++--
 drivers/thunderbolt/switch.c                                                   |    7 
 drivers/thunderbolt/xdomain.c                                                  |   58 ++++--
 drivers/ufs/core/ufshcd.c                                                      |    2 
 drivers/usb/cdns3/cdnsp-gadget.c                                               |    3 
 drivers/usb/cdns3/core.h                                                       |    3 
 drivers/usb/core/hub.c                                                         |   25 ++
 drivers/usb/core/hub.h                                                         |    2 
 drivers/usb/dwc3/core.c                                                        |   39 ++++
 drivers/usb/gadget/function/f_ncm.c                                            |   26 ++
 drivers/usb/gadget/udc/udc-xilinx.c                                            |   20 +-
 drivers/usb/host/xhci-ring.c                                                   |    4 
 drivers/usb/musb/musb_debugfs.c                                                |    2 
 drivers/usb/musb/musb_host.c                                                   |    9 -
 drivers/usb/typec/altmodes/displayport.c                                       |    5 
 drivers/usb/typec/ucsi/psy.c                                                   |    9 +
 drivers/usb/typec/ucsi/ucsi.c                                                  |    1 
 fs/ceph/file.c                                                                 |    2 
 fs/ceph/inode.c                                                                |    4 
 fs/quota/dquot.c                                                               |   66 ++++---
 fs/smb/server/vfs_cache.c                                                      |    4 
 include/linux/dma-fence.h                                                      |   19 ++
 include/linux/libata.h                                                         |    7 
 include/linux/mcb.h                                                            |    1 
 include/linux/quota.h                                                          |    4 
 include/linux/quotaops.h                                                       |    2 
 include/net/macsec.h                                                           |    1 
 include/net/netns/ipv4.h                                                       |    1 
 kernel/bpf/verifier.c                                                          |    6 
 kernel/cgroup/cgroup-v1.c                                                      |    5 
 kernel/workqueue.c                                                             |    8 
 net/can/isotp.c                                                                |   19 --
 net/ceph/messenger.c                                                           |    4 
 net/core/dev.c                                                                 |    8 
 net/ipv4/sysctl_net_ipv4.c                                                     |    9 +
 net/ipv4/tcp_ipv4.c                                                            |    2 
 net/ipv4/tcp_output.c                                                          |   60 +++++-
 net/mctp/route.c                                                               |   22 +-
 net/mptcp/protocol.c                                                           |   28 +--
 net/mptcp/protocol.h                                                           |   35 +--
 net/mptcp/subflow.c                                                            |   10 -
 net/netfilter/ipvs/ip_vs_sync.c                                                |    4 
 net/nfc/llcp_core.c                                                            |   30 +--
 net/nfc/nci/core.c                                                             |    5 
 net/rds/tcp_connect.c                                                          |    2 
 net/rds/tcp_listen.c                                                           |    2 
 net/smc/smc_stats.h                                                            |   14 +
 net/socket.c                                                                   |    6 
 security/keys/trusted-keys/trusted_core.c                                      |   13 -
 sound/pci/hda/patch_realtek.c                                                  |   89 ++++++++-
 sound/soc/amd/yc/acp6x-mach.c                                                  |    7 
 sound/soc/codecs/sta32x.c                                                      |   39 ++--
 sound/soc/codecs/sta350.c                                                      |   63 +++----
 sound/soc/codecs/tas5086.c                                                     |    2 
 sound/soc/fsl/fsl_sai.c                                                        |   41 +++-
 sound/soc/fsl/fsl_sai.h                                                        |    2 
 sound/soc/fsl/fsl_ssi.c                                                        |    2 
 sound/soc/fsl/imx-card.c                                                       |    2 
 sound/soc/generic/simple-card-utils.c                                          |    3 
 sound/soc/intel/boards/sof_es8336.c                                            |   10 +
 sound/soc/intel/boards/sof_sdw.c                                               |   10 +
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c                              |   25 ++
 sound/soc/sh/rcar/ssi.c                                                        |    4 
 sound/soc/sof/amd/pci-rmb.c                                                    |    1 
 sound/usb/mixer.c                                                              |    7 
 sound/usb/quirks.c                                                             |    8 
 152 files changed, 1301 insertions(+), 517 deletions(-)

Abhinav Kumar (2):
      drm/msm/dsi: skip the wait for video mode done if not applicable
      drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow

Alexander Zangerl (1):
      iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

Amelie Delaunay (5):
      dmaengine: stm32-mdma: abort resume if no ongoing transfer
      dmaengine: stm32-dma: fix stm32_dma_prep_slave_sg in case of MDMA chaining
      dmaengine: stm32-dma: fix residue in case of MDMA chaining
      dmaengine: stm32-mdma: use Link Address Register to compute residue
      dmaengine: stm32-mdma: set in_flight_bytes in case CRQA flag is set

Antoniu Miclaus (2):
      iio: admv1013: add mixer_vgate corner cases
      iio: addac: Kconfig: update ad74413r selections

Armin Wolf (1):
      platform/x86: think-lmi: Fix reference leak

Artem Chernyshev (1):
      RDMA/cxgb4: Check skb value for failure to allocate

Balamurugan C (2):
      ASoC: Intel: soc-acpi: Add entry for HDMI_In capture support in MTL match table
      ASoC: Intel: soc-acpi: Add entry for sof_es8336 in MTL match table.

Biju Das (1):
      irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source

Björn Töpel (1):
      riscv, bpf: Sign-extend return values

Borislav Petkov (AMD) (1):
      x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

Christian König (2):
      drm/amdgpu: add missing NULL check
      dma-buf: add dma_fence_timestamp helper

Christophe Leroy (2):
      powerpc/8xx: Fix pte_access_permitted() for PAGE_NONE
      powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()

Christos Skevis (1):
      ALSA: usb-audio: Fix microphone sound on Nexigo webcam.

Damien Le Moal (2):
      scsi: Do not rescan devices with a suspended queue
      ata: libata-scsi: Disable scsi device manage_system_start_stop

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

Dmitry Baryshkov (1):
      arm64: dts: qcom: sm8150: extend the size of the PDC resource

Dmitry Torokhov (1):
      pinctrl: avoid unsafe code pattern in find_pinctrl()

Duoming Zhou (1):
      dmaengine: mediatek: Fix deadlock caused by synchronize_irq()

Eric Dumazet (2):
      net: refine debug info in skb_checksum_help()
      net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()

Fabian Vogt (1):
      ALSA: hda/realtek: Add quirk for mute LEDs on HP ENVY x360 15-eu0xxx

Fabrice Gasnier (1):
      counter: chrdev: fix getting array extensions

Greg Kroah-Hartman (1):
      Linux 6.1.59

Haiyang Zhang (1):
      net: mana: Fix TX CQE error handling

Hans de Goede (4):
      HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA
      ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
      Input: goodix - ensure int GPIO is in input for gpio_count == 1 && gpio_int_idx == 0 case

Ioana Ciornei (1):
      phy: lynx-28g: cancel the CDR check work item on the remove path

JP Kobryn (1):
      perf/x86/lbr: Filter vsyscall addresses

Jan Kara (1):
      quota: Fix slow quotaoff

Javier Carrasco (2):
      net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read
      Input: powermate - fix use-after-free in powermate_config_complete

Jeffery Miller (1):
      Input: psmouse - fix fast_reconnect function for PS/2 mode

Jeremy Cline (1):
      nfc: nci: assert requested protocol is valid

Jeremy Kerr (1):
      mctp: perform route lookups under a RCU read-side lock

Jing Zhang (1):
      perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7

John Watts (1):
      can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set

Jonathan Cameron (1):
      iio: imu: bno055: Fix missing Kconfig dependencies

Jordan Rife (2):
      net: prevent address rewrite in kernel_bind()
      libceph: use kernel_connect()

Jorge Sanjuan Garcia (1):
      mcb: remove is_added flag from mcb_device struct

Kailang Yang (4):
      ALSA: hda/realtek: Change model for Intel RVP board
      ALSA: hda/realtek - ALC287 I2S speaker platform support
      ALSA: hda/realtek - ALC287 merge RTK codec with CS CS35L41 AMP
      ALSA: hda/realtek - Fixed two speaker platform

Kirill A. Shutemov (1):
      x86/alternatives: Disable KASAN in apply_alternatives()

Konstantin Meskhidze (1):
      drm/vmwgfx: fix typo of sizeof argument

Krishna Kurapati (1):
      usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call

Kuninori Morimoto (1):
      ASoC: simple-card-utils: fixup simple_util_startup() error handling

Kuogee Hsieh (1):
      drm/msm/dp: do not reinitialize phy unless retry during link training

Lad Prabhakar (1):
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update description for '#interrupt-cells' property

Lakshmi Yadlapati (1):
      iio: pressure: dps310: Adjust Timeout Settings

Lukas Magel (1):
      can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Macpaul Lin (2):
      arm64: dts: mediatek: mt8195-demo: fix the memory size to 8GB
      arm64: dts: mediatek: mt8195-demo: update and reorder reserved memory regions

Marcelo Schmitt (1):
      iio: dac: ad3552r: Correct device IDs

Marek Behún (1):
      net: dsa: qca8k: fix potential MDIO bus conflict when accessing internal PHYs via management frames

Mario Limonciello (1):
      usb: typec: ucsi: Use GET_CAPABILITY attributes data to set power supply scope

Matthias Berndt (1):
      Input: xpad - add PXN V900 support

Michael Ellerman (1):
      powerpc/47x: Fix 47x syscall return crash

Michal Koutný (1):
      cgroup: Remove duplicates in cgroup v1 tasks file

Mika Westerberg (3):
      thunderbolt: Workaround an IOMMU fault on certain systems with Intel Maple Ridge
      thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding
      thunderbolt: Restart XDomain discovery handshake after failure

Mikhail Kobuk (1):
      pinctrl: nuvoton: wpcm450: fix out of bounds write

Namjae Jeon (1):
      ksmbd: not allow to open file if delelete on close bit is set

Nils Hoppmann (1):
      net/smc: Fix pos miscalculation in statistics

Nirmoy Das (1):
      drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval

Nícolas F. R. A. Prado (1):
      arm64: dts: mediatek: mt8195: Set DSU PMU status to fail

Paolo Abeni (1):
      mptcp: fix delegated action races

Pawel Laszczak (1):
      usb: cdnsp: Fixes issue with dequeuing not queued requests

Peter Wang (1):
      scsi: ufs: core: Correct clear TM error log

Phil Elwell (1):
      iio: pressure: bmp280: Fix NULL pointer exception

Philipp Rossak (1):
      iio: adc: imx8qxp: Fix address for command buffer registers

Pierre-Louis Bossart (1):
      ASoC: Intel: sof_sdw: add support for SKU 0B14

Piyush Mehta (1):
      usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Prashanth K (1):
      usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command fails

Pu Lehui (1):
      riscv, bpf: Factor out emit_call for kernel and bpf context

RD Babiera (1):
      usb: typec: altmodes/displayport: Signal hpd low when exiting mode

Radu Pirea (NXP OSS) (3):
      net: macsec: indicate next pn update when offloading
      net: phy: mscc: macsec: reject PN update requests
      net/mlx5e: macsec: use update_pn flag instead of PN comparation

Ralph Siemsen (1):
      pinctrl: renesas: rzn1: Enable missing PINMUX

Rex Zhang (1):
      dmaengine: idxd: use spin_lock_irqsave before wait_event_lock_irq

Ricardo Cañuelo (1):
      usb: hub: Guard against accesses to uninitialized BOS descriptors

Rijo Thomas (1):
      tee: amdtee: fix use-after-free vulnerability in amdtee_close_session

Rob Herring (1):
      ASoC: Use of_property_read_bool() for boolean properties

Roger Pau Monne (1):
      xen-netback: use default TX queue size for vifs

Shengjiu Wang (2):
      ASoC: fsl_sai: MCLK bind with TX/RX enable bit
      ASoC: fsl_sai: Don't disable bitclock for i.MX8MP

Simon Ser (1):
      drm/atomic-helper: relax unregistered connector check

Stephen Boyd (1):
      drm/msm/dp: Add newlines to debug printks

Sumit Garg (1):
      KEYS: trusted: Remove redundant static calls usage

SungHwan Jung (1):
      ALSA: hda/realtek: Add quirk for HP Victus 16-d1xxx to enable mute LED

Sven Frotscher (1):
      ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM

Szilard Fabian (1):
      Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table

Thinh Nguyen (1):
      usb: dwc3: Soft reset phy on probe for host

Uwe Kleine-König (1):
      platform/x86: hp-wmi:: Mark driver struct with __refdata to prevent section mismatch warning

Vijendar Mukunda (1):
      ASoC: SOF: amd: fix for firmware reload failure after playback

Vladimir Oltean (2):
      phy: lynx-28g: lock PHY while performing CDR lock workaround
      phy: lynx-28g: serialize concurrent phy_set_mode_ext() calls to shared registers

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

Yanguo Li (1):
      nfp: flower: avoid rmmod nfp crash issues

Yoshihiro Shimoda (2):
      ravb: Fix up dma_free_coherent() call in ravb_remove()
      ravb: Fix use-after-free issue in ravb_tx_timeout_work()

mfreemon@cloudflare.com (1):
      tcp: enforce receive buffer memory limits by allowing the tcp window to shrink

