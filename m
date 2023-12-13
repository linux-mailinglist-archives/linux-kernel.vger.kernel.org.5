Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DBC811F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442468AbjLMTLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379292AbjLMTKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:10:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316EEE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:10:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FC4C433C7;
        Wed, 13 Dec 2023 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702494637;
        bh=WbBQZlBfV0vfTkmyLoe/xHMGnSSgB7e+dtYl43dGBLE=;
        h=From:To:Cc:Subject:Date:From;
        b=oX0oWhCHPQuRWBN2u2tOlCD75+R7JL1vMX1n+T0Pc7nVE4N9VlMDnEpTA7tsF9JRG
         YO8FbDW7QzUATxuJDybS+3sKQtmmO8nHRWcjkLlDcltF7spY2hDPLE3RADNc4KktEv
         Gn6hWqviZ2dGXxhcgnkd6jHQjaF/MsGY/4p/b84w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.68
Date:   Wed, 13 Dec 2023 20:06:09 +0100
Message-ID: <2023121310-stoplight-agency-650f@gregkh>
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

I'm announcing the release of the 6.1.68 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-optee-devices                    |    9 
 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml |    4 
 Makefile                                                             |    2 
 arch/arm/boot/dts/imx28-xea.dts                                      |    1 
 arch/arm/boot/dts/imx6ul-pico.dtsi                                   |    2 
 arch/arm/boot/dts/imx7s.dtsi                                         |    8 
 arch/arm/mach-imx/mmdc.c                                             |    7 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                            |    2 
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                            |    4 
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts             |    2 
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts                         |    2 
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts                          |    4 
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts                          |   52 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi               |    8 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                       |   96 +--
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts                      |   12 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                             |  242 +++++-----
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                      |    2 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                             |    6 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                             |    2 
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                             |    6 
 arch/loongarch/net/bpf_jit.c                                         |   12 
 arch/mips/Kconfig                                                    |    2 
 arch/mips/include/asm/mach-loongson64/boot_param.h                   |    9 
 arch/mips/kernel/process.c                                           |   25 -
 arch/mips/loongson64/env.c                                           |   10 
 arch/mips/loongson64/init.c                                          |   47 +
 arch/parisc/Kconfig                                                  |    7 
 arch/parisc/include/asm/bug.h                                        |   36 -
 arch/riscv/Kconfig.socs                                              |    1 
 arch/riscv/kernel/traps_misaligned.c                                 |    6 
 arch/s390/mm/pgtable.c                                               |    2 
 arch/x86/coco/tdx/tdx.c                                              |    1 
 arch/x86/entry/common.c                                              |   97 +++-
 arch/x86/entry/entry_64_compat.S                                     |   77 ---
 arch/x86/include/asm/ia32.h                                          |   23 
 arch/x86/include/asm/idtentry.h                                      |    4 
 arch/x86/include/asm/proto.h                                         |    4 
 arch/x86/kernel/cpu/amd.c                                            |    3 
 arch/x86/kernel/idt.c                                                |    2 
 arch/x86/kernel/sev.c                                                |   11 
 arch/x86/kvm/svm/svm.c                                               |    8 
 arch/x86/mm/mem_encrypt_amd.c                                        |   11 
 arch/x86/xen/enlighten_pv.c                                          |    2 
 arch/x86/xen/xen-asm.S                                               |    2 
 drivers/acpi/scan.c                                                  |    7 
 drivers/android/binder.c                                             |    1 
 drivers/base/devcoredump.c                                           |    3 
 drivers/base/regmap/regcache.c                                       |    3 
 drivers/gpio/gpiolib-sysfs.c                                         |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c                          |   49 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c                       |  119 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                |    4 
 drivers/gpu/drm/bridge/Kconfig                                       |    1 
 drivers/gpu/drm/i915/display/icl_dsi.c                               |    7 
 drivers/gpu/drm/i915/display/intel_crt.c                             |    5 
 drivers/gpu/drm/i915/display/intel_display.c                         |   10 
 drivers/gpu/drm/i915/display/intel_display.h                         |    3 
 drivers/gpu/drm/i915/display/intel_dp.c                              |    5 
 drivers/gpu/drm/i915/display/intel_dp_mst.c                          |    4 
 drivers/gpu/drm/i915/display/intel_dvo.c                             |    6 
 drivers/gpu/drm/i915/display/intel_hdmi.c                            |    5 
 drivers/gpu/drm/i915/display/intel_lvds.c                            |    9 
 drivers/gpu/drm/i915/display/intel_sdvo.c                            |   22 
 drivers/gpu/drm/i915/display/intel_tv.c                              |    8 
 drivers/gpu/drm/i915/display/vlv_dsi.c                               |   18 
 drivers/gpu/drm/i915/i915_reg.h                                      |   46 -
 drivers/hwmon/acpi_power_meter.c                                     |    4 
 drivers/hwmon/nzxt-kraken2.c                                         |    4 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                   |   12 
 drivers/hwtracing/ptt/hisi_ptt.c                                     |    5 
 drivers/i2c/busses/i2c-designware-common.c                           |   16 
 drivers/infiniband/core/umem.c                                       |    6 
 drivers/infiniband/hw/bnxt_re/main.c                                 |    2 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                           |   13 
 drivers/infiniband/hw/irdma/hw.c                                     |   49 +-
 drivers/infiniband/hw/irdma/main.c                                   |    2 
 drivers/infiniband/hw/irdma/main.h                                   |    2 
 drivers/infiniband/hw/irdma/verbs.c                                  |   28 -
 drivers/infiniband/hw/irdma/verbs.h                                  |    1 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                               |    7 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                               |   37 +
 drivers/iommu/iommu.c                                                |   19 
 drivers/iommu/of_iommu.c                                             |   12 
 drivers/md/md.c                                                      |  174 +++----
 drivers/md/raid5.c                                                   |    4 
 drivers/misc/mei/client.c                                            |    4 
 drivers/net/arcnet/arcdevice.h                                       |    2 
 drivers/net/arcnet/com20020-pci.c                                    |   89 +--
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c                      |   10 
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.h                      |    4 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                     |   18 
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c                         |    1 
 drivers/net/ethernet/broadcom/tg3.c                                  |   42 +
 drivers/net/ethernet/broadcom/tg3.h                                  |    4 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                    |   29 +
 drivers/net/ethernet/hisilicon/hns/hns_enet.c                        |   53 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.h                        |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                          |    2 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                       |   12 
 drivers/net/ethernet/intel/iavf/iavf_txrx.h                          |    1 
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h                     |    2 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c                      |   18 
 drivers/net/ethernet/marvell/octeontx2/af/mcs.h                      |    2 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h                  |   31 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                      |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                      |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c              |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                  |    8 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                  |    8 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c                  |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h                  |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c            |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                 |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c               |   20 
 drivers/net/ethernet/pensando/ionic/ionic_dev.h                      |    2 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                      |   16 
 drivers/net/ethernet/realtek/r8169_main.c                            |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c                         |   45 -
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h                         |    4 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c                  |    3 
 drivers/net/ethernet/stmicro/stmmac/hwif.h                           |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                    |    8 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                      |    1 
 drivers/net/hyperv/Kconfig                                           |    1 
 drivers/net/usb/r8152.c                                              |  110 ++--
 drivers/nvme/host/nvme.h                                             |    5 
 drivers/nvme/host/pci.c                                              |   16 
 drivers/of/dynamic.c                                                 |    5 
 drivers/parport/parport_pc.c                                         |   21 
 drivers/platform/mellanox/mlxbf-bootctl.c                            |   39 +
 drivers/platform/mellanox/mlxbf-pmc.c                                |   14 
 drivers/platform/surface/aggregator/core.c                           |    5 
 drivers/platform/x86/Kconfig                                         |    2 
 drivers/platform/x86/asus-nb-wmi.c                                   |   11 
 drivers/platform/x86/asus-wmi.c                                      |    8 
 drivers/platform/x86/wmi.c                                           |    5 
 drivers/powercap/dtpm_cpu.c                                          |   17 
 drivers/scsi/be2iscsi/be_main.c                                      |    1 
 drivers/tee/optee/device.c                                           |   17 
 drivers/tty/serial/8250/8250_dw.c                                    |    1 
 drivers/tty/serial/8250/8250_early.c                                 |    1 
 drivers/tty/serial/8250/8250_omap.c                                  |   14 
 drivers/tty/serial/amba-pl011.c                                      |  112 ++--
 drivers/tty/serial/sc16is7xx.c                                       |   12 
 drivers/usb/gadget/function/f_hid.c                                  |    7 
 drivers/usb/gadget/udc/core.c                                        |    4 
 drivers/usb/host/xhci-pci.c                                          |    2 
 drivers/usb/typec/class.c                                            |    5 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                    |    7 
 fs/nilfs2/sufile.c                                                   |   42 +
 fs/nilfs2/the_nilfs.c                                                |    6 
 fs/smb/client/cifsfs.c                                               |  174 ++++++-
 fs/smb/client/smb2ops.c                                              |    2 
 include/linux/cpuhotplug.h                                           |    1 
 include/linux/hrtimer.h                                              |    4 
 include/linux/hugetlb.h                                              |    5 
 include/linux/iommu.h                                                |    1 
 include/linux/kprobes.h                                              |   13 
 include/linux/rethook.h                                              |    7 
 include/linux/stmmac.h                                               |    1 
 include/net/genetlink.h                                              |    2 
 include/net/tcp.h                                                    |    9 
 include/rdma/ib_umem.h                                               |    9 
 include/rdma/ib_verbs.h                                              |    1 
 include/uapi/linux/netfilter/nf_tables.h                             |    2 
 io_uring/io_uring.c                                                  |    9 
 io_uring/rsrc.h                                                      |    7 
 kernel/cgroup/legacy_freezer.c                                       |    8 
 kernel/cpu.c                                                         |    8 
 kernel/events/core.c                                                 |   61 +-
 kernel/kprobes.c                                                     |    4 
 kernel/time/hrtimer.c                                                |   33 -
 kernel/trace/rethook.c                                               |   23 
 kernel/trace/ring_buffer.c                                           |   23 
 kernel/trace/trace.c                                                 |  177 ++-----
 lib/zstd/common/fse_decompress.c                                     |    2 
 mm/damon/sysfs.c                                                     |    2 
 mm/filemap.c                                                         |    2 
 mm/hugetlb.c                                                         |    7 
 net/core/drop_monitor.c                                              |    4 
 net/core/filter.c                                                    |   19 
 net/core/scm.c                                                       |    6 
 net/ipv4/ip_gre.c                                                    |   11 
 net/ipv4/tcp.c                                                       |   22 
 net/ipv4/tcp_input.c                                                 |    6 
 net/ipv6/ip6_fib.c                                                   |    6 
 net/netfilter/ipset/ip_set_core.c                                    |   14 
 net/netfilter/nf_tables_api.c                                        |    5 
 net/netfilter/nft_dynset.c                                           |   13 
 net/netfilter/nft_exthdr.c                                           |  108 ++++
 net/netfilter/nft_fib.c                                              |    8 
 net/netfilter/nft_set_pipapo.c                                       |    3 
 net/netfilter/xt_owner.c                                             |   16 
 net/netlink/genetlink.c                                              |    3 
 net/packet/af_packet.c                                               |   16 
 net/packet/internal.h                                                |    2 
 net/psample/psample.c                                                |    3 
 net/xdp/xsk.c                                                        |    5 
 scripts/checkstack.pl                                                |    8 
 scripts/dtc/dt-extract-compatibles                                   |   31 -
 scripts/kconfig/symbol.c                                             |   14 
 sound/core/pcm.c                                                     |    1 
 sound/pci/hda/patch_realtek.c                                        |    3 
 sound/soc/amd/yc/acp6x-mach.c                                        |    7 
 sound/soc/codecs/lpass-tx-macro.c                                    |    5 
 sound/soc/codecs/wm_adsp.c                                           |    8 
 sound/soc/fsl/fsl_sai.c                                              |   21 
 sound/usb/mixer_quirks.c                                             |   30 +
 213 files changed, 2292 insertions(+), 1307 deletions(-)

Alex Bee (1):
      arm64: dts: rockchip: Expand reg size of vdec node for RK3399

Alex Deucher (1):
      drm/amdgpu: simplify amdgpu_ras_eeprom.c

Alex Pakhunov (2):
      tg3: Move the [rt]x_dropped counters to tg3_napi
      tg3: Increment tx_dropped in tg3_tso_bug()

Andy Shevchenko (1):
      serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART

AngeloGioacchino Del Regno (6):
      arm64: dts: mediatek: cherry: Fix interrupt cells for MT6360 on I2C7
      arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names
      arm64: dts: mediatek: mt8195: Fix PM suspend/resume with venc clocks
      arm64: dts: mediatek: mt8183: Fix unit address for scp reserved memory
      arm64: dts: mediatek: mt8183: Move thermal-zones to the root node
      arm64: dts: mediatek: mt8183-evb: Fix unit_address_vs_reg warning on ntc

Ankit Nautiyal (1):
      drm/i915/display: Drop check for doublescan mode in modevalid

Armin Wolf (2):
      platform/x86: wmi: Skip blocks with zero instances
      hwmon: (acpi_power_meter) Fix 4.29 MW bug

Arnd Bergmann (2):
      drm/bridge: tc358768: select CONFIG_VIDEOMODE_HELPERS
      ARM: PL011: Fix DMA support

Ashwin Dayanand Kamat (1):
      x86/sev: Fix kernel crash due to late update to read-only ghcb_version

Bin Li (1):
      ALSA: hda/realtek: Enable headset on Lenovo M90 Gen5

Boerge Struempfel (1):
      gpiolib: sysfs: Fix error handling on failed export

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Check vendor in the AMD microcode callback

Brett Creeley (1):
      ionic: Fix dim work handling in split interrupt mode

Cameron Williams (1):
      parport: Add support for Brainboxes IX/UC/PX parallel cards

Candice Li (4):
      drm/amdgpu: Update ras eeprom support for smu v13_0_0 and v13_0_10
      drm/amdgpu: Add EEPROM I2C address support for ip discovery
      drm/amdgpu: Add I2C EEPROM support on smu v13_0_6
      drm/amdgpu: Update EEPROM I2C address for smu v13_0_0

Carlos Llamas (1):
      binder: fix memory leaks of spam and pending work

Christophe JAILLET (1):
      hwmon: (nzxt-kraken2) Fix error handling path in kraken2_probe()

ChunHao Lin (1):
      r8169: fix rtl8125b PAUSE frames blasting when suspended

Claudio Imbrenda (1):
      KVM: s390/mm: Properly reset no-dat

Clément Léger (1):
      riscv: fix misaligned access handling of C.SWSP and C.SDSP

Dan Carpenter (1):
      mm/damon/sysfs: eliminate potential uninitialized variable warning

Daniel Borkmann (1):
      packet: Move reference count in packet_sock to atomic_long_t

Daniel Mack (1):
      serial: sc16is7xx: address RX timeout interrupt errata

Daniil Maximov (1):
      net: atlantic: Fix NULL dereference of skb pointer in

David Howells (3):
      cifs: Fix non-availability of dedup breaking generic/304
      cifs: Fix flushing, invalidation and file size with copy_file_range()
      cifs: Fix flushing, invalidation and file size with FICLONE

David Jeffery (1):
      md/raid6: use valid sector values to determine if an I/O should wait on the reshape

David Thompson (1):
      mlxbf-bootctl: correctly identify secure boot with development keys

Dinghao Liu (3):
      net: bnxt: fix a potential use-after-free in bnxt_init_tc
      ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate
      scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()

Douglas Anderson (5):
      r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
      r8152: Add RTL8152_INACCESSIBLE checks to more loops
      r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
      r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
      r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()

Eric Dumazet (2):
      ipv6: fix potential NULL deref in fib6_add()
      tcp: do not accept ACK of bytes we never sent

Eugen Hristev (2):
      arm64: dts: mediatek: mt7622: fix memory node warning check
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary cells properties

Fabio Estevam (2):
      ARM: dts: imx6ul-pico: Describe the Ethernet PHY clock
      ARM: dts: imx28-xea: Pass the 'model' property

Florian Westphal (2):
      netfilter: nf_tables: fix 'exist' matching on bigendian arches
      netfilter: nft_set_pipapo: skip inactive elements during set walk

Francesco Dolcini (1):
      platform/surface: aggregator: fix recv_buf() return value

Geetha sowjanya (3):
      octeontx2-af: Fix mcs sa cam entries size
      octeontx2-af: Fix mcs stats register address
      octeontx2-af: Add missing mcs flr handler call

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Kingston drives

Greg Kroah-Hartman (1):
      Linux 6.1.68

Hans de Goede (1):
      platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi code

Heiko Carstens (1):
      checkstack: fix printed address

Helge Deller (2):
      parisc: Reduce size of the bug_table on 64-bit kernel by half
      parisc: Fix asm operand number out of range build error in bug table

Hengqi Chen (2):
      LoongArch: BPF: Don't sign extend memory load operand
      LoongArch: BPF: Don't sign extend function return value

Hsin-Yi Wang (1):
      arm64: dts: mt8183: kukui: Fix underscores in node names

Hugh Dickins (1):
      mm: fix oops when filemap_map_pmd() without prealloc_pte

Ido Schimmel (2):
      psample: Require 'CAP_NET_ADMIN' when joining "packets" group
      drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Ivan Vecera (1):
      i40e: Fix unexpected MFS warning message

JP Kobryn (1):
      kprobes: consistent rcu api usage for kretprobe holder

Jack Wang (4):
      RDMA/rtrs-srv: Do not unconditionally enable irq
      RDMA/rtrs-clt: Start hb after path_up
      RDMA/rtrs-clt: Fix the max_send_wr setting
      RDMA/rtrs-clt: Remove the warnings for req in_use check

Jacob Keller (1):
      iavf: validate tx_coalesce_usecs even if rx_coalesce_usecs is zero

Jan Bottorff (1):
      i2c: designware: Fix corrupted memory seen in the ISR

Jani Nikula (1):
      drm/i915/sdvo: stop caching has_hdmi_monitor in struct intel_sdvo

Jason Zhang (1):
      ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Jeremy Sowden (1):
      netfilter: nft_exthdr: add boolean DCCP option matching

Jia Jie Ho (1):
      riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE

Jianheng Zhang (1):
      net: stmmac: fix FPE events losing

Jiaxun Yang (3):
      MIPS: Loongson64: Reserve vgabios memory on boot
      MIPS: Loongson64: Handle more memory types passed from firmware
      MIPS: Loongson64: Enable DMA noncoherent support

John Fastabend (1):
      bpf: sockmap, updating the sg structure should also update curr

Jonas Karlman (1):
      arm64: dts: rockchip: Expand reg size of vdec node for RK3328

Jozsef Kadlecsik (1):
      netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test

Junhao He (1):
      hwtracing: hisi_ptt: Add dummy callback pmu::read()

Junxian Huang (1):
      RDMA/hns: Fix unnecessary err return when using invalid congest control algorithm

Kalesh AP (1):
      RDMA/bnxt_re: Correct module description string

Kirill A. Shutemov (2):
      x86/coco: Disable 32-bit emulation by default on TDX and SEV
      x86/tdx: Allow 32-bit emulation by default

Konrad Dybcio (1):
      dt-bindings: interrupt-controller: Allow #power-domain-cells

Konstantin Aladyshev (1):
      usb: gadget: f_hid: fix report descriptor allocation

Krzysztof Kozlowski (1):
      arm64: dts: mediatek: add missing space before {

Kunwu Chan (3):
      platform/mellanox: Add null pointer checks for devm_kasprintf()
      platform/mellanox: Check devm_hwmon_device_register_with_groups() return value
      ARM: imx: Check return value of devm_kasprintf in imx_mmdc_perf_init

Luben Tuikov (5):
      drm/amdgpu: Remove redundant I2C EEPROM address
      drm/amdgpu: Decouple RAS EEPROM addresses from chips
      drm/amdgpu: Add support for RAS table at 0x40000
      drm/amdgpu: Remove second moot switch to set EEPROM I2C address
      drm/amdgpu: Return from switch early for EEPROM I2C address

Luca Ceresoli (1):
      of: dynamic: Fix of_reconfig_get_state_change() return value documentation

Lukasz Luba (1):
      powercap: DTPM: Fix missing cpufreq_cpu_put() calls

Malcolm Hart (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA

Mario Limonciello (1):
      ALSA: hda/realtek: Add Framework laptop 16 to quirks

Masahiro Yamada (1):
      kconfig: fix memory leak from range properties

Masami Hiramatsu (Google) (1):
      rethook: Use __rcu pointer for rethook::handler

Mathias Nyman (1):
      Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"

Matthias Reichl (1):
      regmap: fix bogus error on regcache_sync success

Md Haris Iqbal (3):
      RDMA/rtrs-srv: Check return values while processing info request
      RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
      RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight

Mike Kravetz (1):
      hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write

Mike Marciniszyn (1):
      RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz

Mukesh Ojha (1):
      devcoredump: Send uevent once devcd is ready

Mustafa Ismail (2):
      RDMA/irdma: Do not modify to SQD on error
      RDMA/irdma: Add wait for suspend on SQD

Nathan Rossi (1):
      arm64: dts: imx8mp: imx8mq: Add parkmode-disable-ss-quirk on DWC3

Naveen Mamindlapalli (1):
      octeontx2-pf: consider both Rx and Tx packet stats for adaptive interrupt coalescing

Neil Armstrong (1):
      ASoC: codecs: lpass-tx-macro: set active_decimator correct default value

Nick Terrell (1):
      zstd: Fix array-index-out-of-bounds UBSAN warning

Nikolay Borisov (1):
      x86: Introduce ia32_enabled()

Nithin Dabilpuram (1):
      octeontx2-af: Adjust Tx credits when MCS external bypass is disabled

Nícolas F. R. A. Prado (2):
      dt: dt-extract-compatibles: Handle cfile arguments in generator function
      dt: dt-extract-compatibles: Don't follow symlinks when walking tree

Pablo Neira Ayuso (2):
      netfilter: nf_tables: bail out on mismatching dynset and set expressions
      netfilter: nf_tables: validate family when identifying table via handle

Paolo Abeni (1):
      tcp: fix mid stream window clamp.

Paulo Alcantara (1):
      smb: client: fix potential NULL deref in parse_dfs_referrals()

Pavel Begunkov (2):
      io_uring/af_unix: disable sending io_uring over sockets
      io_uring: fix mutex_unlock with unreferenced ctx

Peng Fan (1):
      arm64: dts: imx8mq: drop usb3-resume-missing-cas from usb

Peter Zijlstra (1):
      perf: Fix perf_event_validate_size()

Petr Pavlu (3):
      tracing: Fix a warning when allocating buffered events fails
      tracing: Fix incomplete locking when disabling buffered events
      tracing: Fix a possible race when disabling buffered events

Phil Sutter (1):
      netfilter: xt_owner: Fix for unsafe access of sk->sk_socket

Philipp Zabel (1):
      ARM: dts: imx7: Declare timers compatible with fsl,imx6dl-gpt

Prike Liang (1):
      drm/amdgpu: correct the amdgpu runtime dereference usage count

RD Babiera (1):
      usb: typec: class: fix typec_altmode_put_partner to put plugs

Rahul Bhansali (1):
      octeontx2-af: Update Tx link register range

Randy Dunlap (1):
      hv_netvsc: rndis_filter needs to select NLS

Robin Murphy (1):
      iommu: Avoid more races around device probe

Ronald Wahl (3):
      serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit
      serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
      serial: 8250_omap: Add earlycon support for the AM654 UART controller

Roy Luo (1):
      USB: gadget: core: adjust uevent timing on gadget unbind

Ryusuke Konishi (2):
      nilfs2: fix missing error check for sb_set_blocksize call
      nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Sarah Grant (1):
      ALSA: usb-audio: Add Pioneer DJM-450 mixer controls

Sean Christopherson (1):
      KVM: SVM: Update EFER software model on CR0 trap for SEV-ES

Shannon Nelson (1):
      ionic: fix snprintf format length warning

Shengjiu Wang (1):
      ASoC: fsl_sai: Fix no frame sync clock issue on i.MX8MP

Shifeng Li (2):
      RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
      RDMA/irdma: Avoid free the non-cqp_request scratch

Shigeru Yoshida (1):
      ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

Sindhu Devale (1):
      RDMA/irdma: Refactor error handling in create CQP

Srinivasan Shanmugam (1):
      drm/amd/amdgpu: Fix warnings in amdgpu/amdgpu_display.c

Steve Sistare (1):
      vdpa/mlx5: preserve CVQ vringh index

Steven Rostedt (Google) (5):
      ring-buffer: Test last update in 32bit version of __rb_time_read()
      tracing: Always update snapshot buffer size
      tracing: Disable snapshot buffer when stopping instance tracers
      ring-buffer: Force absolute timestamp on discard of event
      tracing: Stop current tracer when resizing buffer

Su Hui (2):
      misc: mei: client.c: return negative error code in mei_cl_write
      misc: mei: client.c: fix problem of return '-EOVERFLOW' in mei_cl_write

Subbaraya Sundeep (2):
      octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam
      octeontx2-af: Check return value of nix_get_nixlf before using nixlf

Sumit Garg (1):
      tee: optee: Fix supplicant based device enumeration

Thomas Bogendoerfer (1):
      MIPS: kernel: Clear FPU states when setting up kernel threads

Thomas Gleixner (3):
      hrtimers: Push pending hrtimers away from outgoing CPU earlier
      x86/entry: Convert INT 0x80 emulation to IDTENTRY
      x86/entry: Do not allow external 0x80 interrupts

Thomas Reichinger (1):
      arcnet: restoring support for multiple Sohard Arcnet cards

Tim Bosse (1):
      ALSA: hda/realtek: add new Framework laptop to quirks

Tim Huang (1):
      drm/amdgpu: fix memory overflow in the IB test

Tim Van Patten (1):
      cgroup_freezer: cgroup_freezing: Check if not frozen

Uwe Kleine-König (2):
      coresight: etm4x: Make etm4_remove_dev() return void
      coresight: etm4x: Remove bogous __exit annotation for some functions

Ville Syrjälä (2):
      drm/i915/lvds: Use REG_BIT() & co.
      drm/i915: Skip some timing checks on BXT/GLK DSI transcoders

Ye Bin (1):
      md: introduce md_ro_state

Yewon Choi (1):
      xsk: Skip polling event check for unbound socket

Yonglong Liu (2):
      net: hns: fix wrong head when modify the tx feature when sending packets
      net: hns: fix fake link up on xge port

Yu Kuai (1):
      md: don't leave 'MD_RECOVERY_FROZEN' in error path of md_set_readonly()

YuanShang (1):
      drm/amdgpu: correct chunk_ptr to a pointer to chunk.

Zheng Yejian (1):
      tracing: Set actual size after ring buffer resize

Zhipeng Lu (1):
      octeontx2-af: fix a use-after-free in rvu_npa_register_reporters

