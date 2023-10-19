Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1311F7D03AD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjJSVVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbjJSVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:21:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7305187;
        Thu, 19 Oct 2023 14:21:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA623C433C8;
        Thu, 19 Oct 2023 21:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697750467;
        bh=sqA41iagf5vabdfI54u9wkkAVHaCQ+qJDjMP6Y8hNfw=;
        h=From:To:Cc:Subject:Date:From;
        b=imc/ymE+77OClODq5kmhX6Oh7+rD0NdbnPDzeXZ8ckBihEm5fZ1dBqP0xz8R3psHG
         nsaA2Swez8ewX/39mxtPh8Rv36tCwpNMaSIaveIFRh3pndqd1vpVsy2uc1mgGNahit
         vqhcy0vSRQAz7RayBxK+OPHcRXby+08MPq0YcHYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.5.8
Date:   Thu, 19 Oct 2023 23:20:59 +0200
Message-ID: <2023101900-arise-clunky-c873@gregkh>
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

I'm announcing the release of the 6.5.8 kernel.

All users of the 6.5 kernel series must upgrade.

The updated 6.5.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.5.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml |    5 
 Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml                      |    1 
 Documentation/filesystems/overlayfs.rst                                        |   12 
 Makefile                                                                       |    2 
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                                       |    2 
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                                      |    2 
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts                                   |   39 ++-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                                       |    1 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                           |    2 
 arch/arm64/include/asm/acpi.h                                                  |   20 +
 arch/powerpc/include/asm/nohash/32/pte-8xx.h                                   |    7 
 arch/powerpc/include/asm/nohash/64/pgtable.h                                   |    2 
 arch/powerpc/include/asm/nohash/pgtable.h                                      |    2 
 arch/powerpc/kernel/entry_32.S                                                 |    8 
 arch/powerpc/platforms/pseries/hvCall.S                                        |    4 
 arch/riscv/Makefile                                                            |    1 
 arch/riscv/include/asm/kprobes.h                                               |   11 
 arch/riscv/include/asm/uprobes.h                                               |   13 -
 arch/riscv/kernel/irq.c                                                        |    4 
 arch/riscv/kernel/signal.c                                                     |    7 
 arch/riscv/kernel/traps.c                                                      |   28 +-
 arch/riscv/net/bpf_jit_comp64.c                                                |   18 -
 arch/s390/net/bpf_jit_comp.c                                                   |   25 +
 arch/x86/events/utils.c                                                        |    5 
 arch/x86/include/asm/msr-index.h                                               |    9 
 arch/x86/include/asm/smp.h                                                     |    2 
 arch/x86/kernel/alternative.c                                                  |   13 +
 arch/x86/kernel/cpu/amd.c                                                      |    8 
 arch/x86/kernel/smp.c                                                          |   39 ---
 arch/x86/kernel/smpboot.c                                                      |   27 --
 block/fops.c                                                                   |   21 +
 drivers/acpi/ec.c                                                              |   11 
 drivers/acpi/processor_idle.c                                                  |    3 
 drivers/acpi/resource.c                                                        |   26 +-
 drivers/android/binder.c                                                       |    2 
 drivers/ata/libata-core.c                                                      |   90 +++++++
 drivers/ata/libata-eh.c                                                        |   54 ++++
 drivers/ata/libata-scsi.c                                                      |   16 -
 drivers/ata/libata.h                                                           |    2 
 drivers/ata/pata_parport/pata_parport.c                                        |   10 
 drivers/counter/counter-chrdev.c                                               |    4 
 drivers/counter/microchip-tcb-capture.c                                        |    2 
 drivers/dma-buf/dma-fence-unwrap.c                                             |   13 -
 drivers/dma-buf/sync_file.c                                                    |    9 
 drivers/dma/idxd/device.c                                                      |    5 
 drivers/dma/mediatek/mtk-uart-apdma.c                                          |    3 
 drivers/dma/stm32-dma.c                                                        |   11 
 drivers/dma/stm32-mdma.c                                                       |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c                                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                                     |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c                   |    4 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c                   |    4 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                       |    3 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                              |   35 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h                                  |  106 ++++++++
 drivers/gpu/drm/drm_atomic_helper.c                                            |   17 +
 drivers/gpu/drm/drm_gem.c                                                      |    6 
 drivers/gpu/drm/i915/i915_gem.c                                                |    9 
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                                      |   27 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                                               |   13 -
 drivers/gpu/drm/msm/dp/dp_link.c                                               |    4 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                             |   19 +
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c                                 |    4 
 drivers/gpu/drm/scheduler/sched_main.c                                         |    2 
 drivers/gpu/drm/tiny/simpledrm.c                                               |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                                             |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                                             |   17 -
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c                                        |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                                            |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                                        |   12 
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                                            |   18 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                            |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c                                        |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c                                       |   12 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                                         |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                                        |   31 --
 drivers/hid/hid-logitech-hidpp.c                                               |    3 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                                |   24 +
 drivers/iio/adc/ad7192.c                                                       |   29 +-
 drivers/iio/adc/imx8qxp-adc.c                                                  |    4 
 drivers/iio/addac/Kconfig                                                      |    2 
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c                      |    6 
 drivers/iio/dac/ad3552r.c                                                      |    4 
 drivers/iio/frequency/admv1013.c                                               |    4 
 drivers/iio/imu/bno055/Kconfig                                                 |    2 
 drivers/iio/pressure/bmp280-core.c                                             |    2 
 drivers/iio/pressure/dps310.c                                                  |    8 
 drivers/iio/pressure/ms5611_core.c                                             |    2 
 drivers/infiniband/hw/cxgb4/cm.c                                               |    3 
 drivers/input/joystick/xpad.c                                                  |    4 
 drivers/input/misc/powermate.c                                                 |    1 
 drivers/input/mouse/elantech.c                                                 |    1 
 drivers/input/mouse/synaptics.c                                                |    1 
 drivers/input/serio/i8042-acpipnpio.h                                          |    8 
 drivers/input/touchscreen/goodix.c                                             |   19 +
 drivers/irqchip/irq-renesas-rzg2l.c                                            |    2 
 drivers/mcb/mcb-core.c                                                         |   10 
 drivers/mcb/mcb-parse.c                                                        |    2 
 drivers/md/dm-crypt.c                                                          |    3 
 drivers/media/v4l2-core/v4l2-subdev.c                                          |    7 
 drivers/net/can/Kconfig                                                        |    2 
 drivers/net/can/sja1000/sja1000.c                                              |    8 
 drivers/net/dsa/qca/qca8k-8xxx.c                                               |   15 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                                 |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c                      |   13 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c                       |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c                      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                              |    3 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c                       |    4 
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c                               |   10 
 drivers/net/ethernet/netronome/nfp/flower/conntrack.c                          |   19 +
 drivers/net/ethernet/netronome/nfp/flower/main.h                               |    2 
 drivers/net/ethernet/netronome/nfp/flower/metadata.c                           |    2 
 drivers/net/ethernet/netronome/nfp/flower/offload.c                            |   24 +
 drivers/net/ethernet/netronome/nfp/flower/qos_conf.c                           |   20 +
 drivers/net/ethernet/renesas/ravb_main.c                                       |    6 
 drivers/net/ethernet/renesas/rswitch.c                                         |   12 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                              |   30 --
 drivers/net/ieee802154/ca8210.c                                                |   17 -
 drivers/net/macsec.c                                                           |    2 
 drivers/net/phy/mscc/mscc_macsec.c                                             |    6 
 drivers/net/usb/dm9601.c                                                       |    7 
 drivers/net/xen-netback/interface.c                                            |    4 
 drivers/perf/arm-cmn.c                                                         |    2 
 drivers/phy/freescale/phy-fsl-lynx-28g.c                                       |   27 +-
 drivers/pinctrl/core.c                                                         |   16 -
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c                                      |    6 
 drivers/pinctrl/renesas/Kconfig                                                |    1 
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c                             |    2 
 drivers/platform/x86/hp/hp-wmi.c                                               |    8 
 drivers/platform/x86/think-lmi.c                                               |   24 +
 drivers/power/supply/qcom_battmgr.c                                            |    8 
 drivers/s390/net/Kconfig                                                       |    2 
 drivers/scsi/scsi_scan.c                                                       |   11 
 drivers/tee/amdtee/core.c                                                      |   10 
 drivers/thunderbolt/icm.c                                                      |   40 +--
 drivers/thunderbolt/switch.c                                                   |    7 
 drivers/thunderbolt/tmu.c                                                      |    2 
 drivers/thunderbolt/xdomain.c                                                  |   58 +++-
 drivers/tty/serial/8250/8250_omap.c                                            |   25 -
 drivers/tty/serial/serial_core.c                                               |   15 -
 drivers/ufs/core/ufshcd.c                                                      |    2 
 drivers/usb/cdns3/cdnsp-gadget.c                                               |    3 
 drivers/usb/cdns3/core.h                                                       |    3 
 drivers/usb/core/hub.c                                                         |   25 +
 drivers/usb/core/hub.h                                                         |    2 
 drivers/usb/dwc3/core.c                                                        |   39 +++
 drivers/usb/gadget/function/f_ncm.c                                            |   26 +-
 drivers/usb/gadget/udc/udc-xilinx.c                                            |   20 -
 drivers/usb/host/xhci-hub.c                                                    |   19 -
 drivers/usb/host/xhci-mem.c                                                    |    4 
 drivers/usb/host/xhci-ring.c                                                   |   16 -
 drivers/usb/host/xhci.h                                                        |    2 
 drivers/usb/misc/onboard_usb_hub.c                                             |    1 
 drivers/usb/misc/onboard_usb_hub.h                                             |    1 
 drivers/usb/musb/musb_debugfs.c                                                |    2 
 drivers/usb/musb/musb_host.c                                                   |    9 
 drivers/usb/typec/altmodes/displayport.c                                       |    5 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c                            |   12 
 drivers/usb/typec/ucsi/psy.c                                                   |    9 
 drivers/usb/typec/ucsi/ucsi.c                                                  |    2 
 fs/ceph/file.c                                                                 |    2 
 fs/ceph/inode.c                                                                |    4 
 fs/file.c                                                                      |    3 
 fs/fs_context.c                                                                |   46 +++
 fs/ioctl.c                                                                     |   10 
 fs/kernel_read_file.c                                                          |   12 
 fs/namei.c                                                                     |    3 
 fs/open.c                                                                      |    4 
 fs/overlayfs/ovl_entry.h                                                       |   10 
 fs/overlayfs/params.c                                                          |  126 ++++------
 fs/overlayfs/super.c                                                           |   18 -
 fs/quota/dquot.c                                                               |   66 +++--
 fs/smb/server/vfs_cache.c                                                      |    4 
 include/linux/acpi.h                                                           |    9 
 include/linux/dma-fence.h                                                      |   19 +
 include/linux/fs_context.h                                                     |    2 
 include/linux/libata.h                                                         |    6 
 include/linux/mcb.h                                                            |    1 
 include/linux/quota.h                                                          |    4 
 include/linux/quotaops.h                                                       |    2 
 include/net/macsec.h                                                           |    1 
 include/uapi/linux/if_packet.h                                                 |    6 
 kernel/bpf/verifier.c                                                          |    6 
 kernel/cgroup/cgroup-v1.c                                                      |    5 
 kernel/workqueue.c                                                             |    8 
 net/can/isotp.c                                                                |   19 -
 net/ceph/messenger.c                                                           |    4 
 net/core/dev.c                                                                 |    8 
 net/devlink/health.c                                                           |   30 +-
 net/ipv4/tcp_output.c                                                          |    1 
 net/mctp/route.c                                                               |   22 +
 net/netfilter/ipvs/ip_vs_sync.c                                                |    4 
 net/nfc/llcp_core.c                                                            |   30 --
 net/nfc/nci/core.c                                                             |    5 
 net/packet/af_packet.c                                                         |    7 
 net/rds/tcp_connect.c                                                          |    2 
 net/rds/tcp_listen.c                                                           |    2 
 net/smc/Kconfig                                                                |    1 
 net/smc/smc_stats.h                                                            |   14 -
 net/socket.c                                                                   |    6 
 net/xdp/xsk_queue.c                                                            |   10 
 security/keys/trusted-keys/trusted_core.c                                      |   13 -
 sound/pci/hda/cs35l41_hda.c                                                    |  115 ++++++---
 sound/pci/hda/patch_realtek.c                                                  |   89 ++++++-
 sound/soc/amd/yc/acp6x-mach.c                                                  |    7 
 sound/soc/codecs/hdmi-codec.c                                                  |    5 
 sound/soc/fsl/fsl_sai.c                                                        |    9 
 sound/soc/generic/simple-card-utils.c                                          |    3 
 sound/soc/intel/boards/sof_es8336.c                                            |   10 
 sound/soc/intel/boards/sof_sdw.c                                               |   10 
 sound/soc/intel/common/soc-acpi-intel-adl-match.c                              |   12 
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c                              |   25 +
 sound/soc/sof/amd/pci-rmb.c                                                    |    1 
 sound/usb/mixer.c                                                              |    7 
 sound/usb/quirks.c                                                             |    8 
 216 files changed, 1870 insertions(+), 830 deletions(-)

Abhinav Kumar (3):
      drm/msm/dsi: skip the wait for video mode done if not applicable
      drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow
      drm/msm/dpu: fail dpu_plane_atomic_check() based on mdp clk limits

Alexander Zangerl (1):
      iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

Alisa-Dariana Roman (1):
      iio: adc: ad7192: Correct reference voltage

Amelie Delaunay (5):
      dmaengine: stm32-mdma: abort resume if no ongoing transfer
      dmaengine: stm32-dma: fix stm32_dma_prep_slave_sg in case of MDMA chaining
      dmaengine: stm32-dma: fix residue in case of MDMA chaining
      dmaengine: stm32-mdma: use Link Address Register to compute residue
      dmaengine: stm32-mdma: set in_flight_bytes in case CRQA flag is set

Amir Goldstein (5):
      ovl: temporarily disable appending lowedirs
      fs: factor out vfs_parse_monolithic_sep() helper
      ovl: fix regression in parsing of mount options with escaped comma
      ovl: make use of ->layers safe in rcu pathwalk
      ovl: fix regression in showing lowerdir mount option

Andrew Kanner (1):
      xdp: Fix zero-size allocation warning in xskq_create()

Andy Chiu (1):
      riscv: signal: fix sigaltstack frame size checking

Antoniu Miclaus (2):
      iio: admv1013: add mixer_vgate corner cases
      iio: addac: Kconfig: update ad74413r selections

Armin Wolf (1):
      platform/x86: think-lmi: Fix reference leak

Artem Chernyshev (1):
      RDMA/cxgb4: Check skb value for failure to allocate

Athira Rajeev (1):
      powerpc/pseries: Fix STK_PARAM access in the hcall tracing code

Balamurugan C (2):
      ASoC: Intel: soc-acpi: Add entry for HDMI_In capture support in MTL match table
      ASoC: Intel: soc-acpi: Add entry for sof_es8336 in MTL match table.

Biju Das (1):
      irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source

Björn Töpel (3):
      riscv, bpf: Sign-extend return values
      riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values
      riscv: Only consider swbp/ss handlers for correct privileged mode

Borislav Petkov (AMD) (1):
      x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

Carlos Llamas (1):
      binder: fix memory leaks of spam and pending work

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

Eugen Hristev (1):
      arm64: dts: mediatek: fix t-phy unit name

Fabian Vogt (1):
      ALSA: hda/realtek: Add quirk for mute LEDs on HP ENVY x360 15-eu0xxx

Fabio Estevam (1):
      media: dt-bindings: imx7-csi: Make power-domains not required for imx8mq

Fabrice Gasnier (1):
      counter: chrdev: fix getting array extensions

Gerd Bayer (1):
      net/smc: Fix dependency of SMC on ISM

Greg Kroah-Hartman (1):
      Linux 6.5.8

Hal Feng (1):
      pinctrl: starfive: jh7110: Fix failure to set irq after CONFIG_PM is enabled

Hans de Goede (6):
      HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect
      media: subdev: Don't report V4L2_SUBDEV_CAP_STREAMS when the streams API is disabled
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA
      ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q to irq1_edge_low_force_override[]
      ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
      Input: goodix - ensure int GPIO is in input for gpio_count == 1 && gpio_int_idx == 0 case

Heikki Krogerus (1):
      usb: typec: ucsi: Fix missing link removal

Herbert Xu (1):
      dm crypt: Fix reqsize in crypt_iv_eboiv_gen

Hui Liu (1):
      usb: typec: qcom: Update the logic of regulator enable and disable

Ilya Leoshkevich (2):
      s390/bpf: Fix clobbering the caller's backchain in the trampoline
      s390/bpf: Fix unwinding past the trampoline

Ioana Ciornei (1):
      phy: lynx-28g: cancel the CDR check work item on the remove path

JP Kobryn (1):
      perf/x86/lbr: Filter vsyscall addresses

Jakub Kicinski (1):
      net: tcp: fix crashes trying to free half-baked MTU probes

Jan Kara (1):
      quota: Fix slow quotaoff

Javier Carrasco (3):
      net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read
      Input: powermate - fix use-after-free in powermate_config_complete
      usb: misc: onboard_hub: add support for Microchip USB2412 USB 2.0 hub

Jeffery Miller (1):
      Input: psmouse - fix fast_reconnect function for PS/2 mode

Jeremy Cline (1):
      nfc: nci: assert requested protocol is valid

Jeremy Kerr (1):
      mctp: perform route lookups under a RCU read-side lock

Jiexun Wang (1):
      RISC-V: Fix wrong use of CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK

Jing Zhang (1):
      perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7

Joey Gouly (1):
      drm/tiny: correctly print `struct resource *` on error

Johan Hovold (1):
      power: supply: qcom_battmgr: fix enable request endianness

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

Kuniyuki Iwashima (1):
      af_packet: Fix fortified memcpy() without flex array.

Kuogee Hsieh (1):
      drm/msm/dp: do not reinitialize phy unless retry during link training

Lad Prabhakar (1):
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update description for '#interrupt-cells' property

Lakshmi Yadlapati (1):
      iio: pressure: dps310: Adjust Timeout Settings

Linu Cherian (1):
      coresight: Fix run time warnings while reusing ETR buffer

Linus Torvalds (1):
      Revert "x86/smp: Put CPUs into INIT on shutdown if possible"

Luben Tuikov (1):
      drm/amdgpu: Fix a memory leak

Lukas Magel (1):
      can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Lukas Wunner (3):
      xhci: Clear EHB bit only at end of interrupt handler
      xhci: Preserve RsvdP bits in ERSTBA register correctly
      serial: Reduce spinlocked portion of uart_rs485_config()

Macpaul Lin (2):
      arm64: dts: mediatek: mt8195-demo: fix the memory size to 8GB
      arm64: dts: mediatek: mt8195-demo: update and reorder reserved memory regions

Marcelo Schmitt (1):
      iio: dac: ad3552r: Correct device IDs

Marek Behún (2):
      net: dsa: qca8k: fix regmap bulk read/write methods on big endian systems
      net: dsa: qca8k: fix potential MDIO bus conflict when accessing internal PHYs via management frames

Mario Limonciello (1):
      usb: typec: ucsi: Use GET_CAPABILITY attributes data to set power supply scope

Mathias Krause (1):
      drm/i915: Register engines early to avoid type confusion

Mathias Nyman (1):
      xhci: track port suspend state correctly in unsuccessful resume cases

Matthew Wilcox (Oracle) (2):
      drm: Do not overrun array in drm_gem_get_pages()
      fs: Fix kernel-doc warnings

Matthias Berndt (1):
      Input: xpad - add PXN V900 support

Matthias Reichl (1):
      ASoC: hdmi-codec: Fix broken channel map reporting

Max Nguyen (1):
      Input: xpad - add HyperX Clutch Gladiate Support

Michael Ellerman (1):
      powerpc/47x: Fix 47x syscall return crash

Michal Koutný (1):
      cgroup: Remove duplicates in cgroup v1 tasks file

Mika Westerberg (4):
      thunderbolt: Workaround an IOMMU fault on certain systems with Intel Maple Ridge
      thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding
      thunderbolt: Correct TMU mode initialization from hardware
      thunderbolt: Restart XDomain discovery handshake after failure

Mikhail Kobuk (1):
      pinctrl: nuvoton: wpcm450: fix out of bounds write

Miquel Raynal (1):
      can: sja1000: Always restart the Tx queue after an overrun

Moshe Shemesh (1):
      devlink: Hold devlink lock on health reporter dump get

Namjae Jeon (1):
      ksmbd: not allow to open file if delelete on close bit is set

Nils Hoppmann (1):
      net/smc: Fix pos miscalculation in statistics

Nícolas F. R. A. Prado (1):
      arm64: dts: mediatek: mt8195: Set DSU PMU status to fail

Ondrej Zary (2):
      ata: pata_parport: fix pata_parport_devchk
      ata: pata_parport: implement set_devctl

Oza Pawandeep (1):
      cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer

Pawel Laszczak (1):
      usb: cdnsp: Fixes issue with dequeuing not queued requests

Peter Wang (1):
      scsi: ufs: core: Correct clear TM error log

Phil Elwell (1):
      iio: pressure: bmp280: Fix NULL pointer exception

Philipp Rossak (1):
      iio: adc: imx8qxp: Fix address for command buffer registers

Pierre-Louis Bossart (2):
      ASoC: Intel: soc-acpi: fix Dell SKU 0B34
      ASoC: Intel: sof_sdw: add support for SKU 0B14

Piyush Mehta (1):
      usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Prashanth K (1):
      usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command fails

RD Babiera (1):
      usb: typec: altmodes/displayport: Signal hpd low when exiting mode

Radu Pirea (NXP OSS) (4):
      octeontx2-pf: mcs: update PN only when update_pn is true
      net: macsec: indicate next pn update when offloading
      net: phy: mscc: macsec: reject PN update requests
      net/mlx5e: macsec: use update_pn flag instead of PN comparation

Ralph Siemsen (1):
      pinctrl: renesas: rzn1: Enable missing PINMUX

Ratheesh Kannoth (1):
      octeontx2-pf: Fix page pool frag allocation warning

Remi Pommarel (1):
      net: stmmac: remove unneeded stmmac_poll_controller

Rex Zhang (1):
      dmaengine: idxd: use spin_lock_irqsave before wait_event_lock_irq

Ricardo Cañuelo (1):
      usb: hub: Guard against accesses to uninitialized BOS descriptors

Rijo Thomas (1):
      tee: amdtee: fix use-after-free vulnerability in amdtee_close_session

Roger Pau Monne (1):
      xen-netback: use default TX queue size for vifs

Ruihai Zhou (1):
      drm/panel: boe-tv101wum-nl6: Completely pull GPW to VGL before TP term

Samson Tam (1):
      drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to master OTG pipes only

Sarthak Kukreti (1):
      block: Don't invalidate pagecache for invalid falloc modes

Sebastian Reichel (1):
      power: supply: qcom_battmgr: fix battery_id type

Shengjiu Wang (1):
      ASoC: fsl_sai: Don't disable bitclock for i.MX8MP

Simon Ser (1):
      drm/atomic-helper: relax unregistered connector check

Song Shuai (1):
      riscv: Remove duplicate objcopy flag

Stefan Binding (1):
      ALSA: hda: cs35l41: Cleanup and fix double free in firmware request

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

Tony Lindgren (2):
      serial: 8250_omap: Fix errors with no_console_suspend
      serial: core: Fix checks for tx runtime PM state

Tzung-Bi Shih (1):
      iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()

Uwe Kleine-König (1):
      platform/x86: hp-wmi:: Mark driver struct with __refdata to prevent section mismatch warning

Vijendar Mukunda (1):
      ASoC: SOF: amd: fix for firmware reload failure after playback

Vladimir Oltean (2):
      phy: lynx-28g: lock PHY while performing CDR lock workaround
      phy: lynx-28g: serialize concurrent phy_set_mode_ext() calls to shared registers

Waiman Long (1):
      workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()

Wenjing Liu (1):
      drm/amd/display: implement pipe type definition and adding accessors

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

Yoshihiro Shimoda (4):
      ravb: Fix up dma_free_coherent() call in ravb_remove()
      ravb: Fix use-after-free issue in ravb_tx_timeout_work()
      rswitch: Fix renesas_eth_sw_remove() implementation
      rswitch: Fix imbalance phy_power_off() calling

Zack Rusin (1):
      drm/vmwgfx: Keep a gem reference to user bos in surfaces

