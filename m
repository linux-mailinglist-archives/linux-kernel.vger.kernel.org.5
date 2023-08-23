Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A9785D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbjHWQhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjHWQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:37:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A9CEE;
        Wed, 23 Aug 2023 09:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4C31621BB;
        Wed, 23 Aug 2023 16:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A421C433C9;
        Wed, 23 Aug 2023 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692808629;
        bh=PTRKIqJnBkSd0vadXqqpbnlEpZEYFFNSi6p9UQdUSvk=;
        h=From:To:Cc:Subject:Date:From;
        b=aFBS0uLa0bfb4IR69NPBJ07v6AzW5h54n0G1tcPMv96X8KvR67a5Au1hR2VpaY+sV
         KU+IdM6mTsbTxaDDhpjq6rfQ1xh1VwM8gJZ6+vE3WU/gZsrJgsRa11imYb8ffRQJwH
         0jSZ2tRWLbjUnefU2VZSmU1PKW7NPmyTBWdAFmYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.47
Date:   Wed, 23 Aug 2023 18:37:04 +0200
Message-ID: <2023082304-phonics-lucid-affb@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.47 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                |    1 
 Makefile                                                       |    2 
 arch/arm/boot/dts/imx50-kobo-aura.dts                          |    2 
 arch/arm/boot/dts/imx53-cx9020.dts                             |   10 
 arch/arm/boot/dts/imx53-m53evk.dts                             |    4 
 arch/arm/boot/dts/imx53-m53menlo.dts                           |    6 
 arch/arm/boot/dts/imx53-tx53.dtsi                              |    2 
 arch/arm/boot/dts/imx53-usbarmory.dts                          |    2 
 arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi                          |    6 
 arch/arm/boot/dts/imx6dl-prtrvt.dts                            |    4 
 arch/arm/boot/dts/imx6dl-riotboard.dts                         |    4 
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi                     |    6 
 arch/arm/boot/dts/imx6q-gw5400-a.dts                           |    6 
 arch/arm/boot/dts/imx6q-h100.dts                               |    6 
 arch/arm/boot/dts/imx6q-kp.dtsi                                |    4 
 arch/arm/boot/dts/imx6q-marsboard.dts                          |    4 
 arch/arm/boot/dts/imx6q-tbs2910.dts                            |    2 
 arch/arm/boot/dts/imx6qdl-emcon.dtsi                           |    4 
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi                          |    4 
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi                          |    6 
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi                          |    6 
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi                          |    6 
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi                          |    2 
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi                          |    6 
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi                          |    4 
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi                          |    6 
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi                          |    2 
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi                          |    6 
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi                          |    4 
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi                          |    6 
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi                          |    6 
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi                          |    4 
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi                       |   10 
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi                   |    4 
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi                     |    8 
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi                   |    4 
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi                          |   11 
 arch/arm/boot/dts/imx6qdl-rex.dtsi                             |    2 
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi                       |    2 
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi                         |    2 
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi                          |    4 
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                             |    2 
 arch/arm/boot/dts/imx6sl-evk.dts                               |    2 
 arch/arm/boot/dts/imx6sll-evk.dts                              |    2 
 arch/arm/boot/dts/imx6sll.dtsi                                 |    2 
 arch/arm/boot/dts/imx6sx-sabreauto.dts                         |    2 
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi                         |    4 
 arch/arm/boot/dts/imx6sx.dtsi                                  |    6 
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi               |    2 
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                            |    2 
 arch/arm64/boot/dts/freescale/imx8mm.dtsi                      |    7 
 arch/arm64/boot/dts/freescale/imx93.dtsi                       |    2 
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts                       |    2 
 arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts           |    3 
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi             |    6 
 arch/arm64/include/asm/fpsimd.h                                |    4 
 arch/arm64/include/asm/kvm_host.h                              |    2 
 arch/arm64/kernel/fpsimd.c                                     |    6 
 arch/arm64/kernel/ptrace.c                                     |    9 
 arch/arm64/kernel/signal.c                                     |    2 
 arch/arm64/kvm/arm.c                                           |    6 
 arch/arm64/kvm/vgic/vgic-v3.c                                  |    2 
 arch/arm64/kvm/vgic/vgic-v4.c                                  |    7 
 arch/powerpc/kernel/rtas_flash.c                               |    6 
 arch/powerpc/mm/kasan/Makefile                                 |    1 
 arch/riscv/lib/uaccess.S                                       |   11 
 block/blk-crypto-fallback.c                                    |   36 +
 drivers/bluetooth/btusb.c                                      |    3 
 drivers/bus/ti-sysc.c                                          |    2 
 drivers/cpuidle/cpuidle-psci-domain.c                          |   42 --
 drivers/firewire/net.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                         |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                     |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                      |   41 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                        |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                        |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                        |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                         |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |  209 ++++++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h         |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   30 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h              |    3 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c              |    8 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c            |    5 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c        |   20 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c              |   22 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h              |    3 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c             |    2 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h          |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h |    2 
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h                   |    1 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                      |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c        |   14 
 drivers/gpu/drm/i915/display/intel_sdvo.c                      |    2 
 drivers/gpu/drm/nouveau/nouveau_connector.c                    |    8 
 drivers/gpu/drm/panel/panel-simple.c                           |   24 -
 drivers/gpu/drm/qxl/qxl_drv.h                                  |    2 
 drivers/gpu/drm/qxl/qxl_dumb.c                                 |    5 
 drivers/gpu/drm/qxl/qxl_gem.c                                  |   25 -
 drivers/gpu/drm/qxl/qxl_ioctl.c                                |    6 
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c                         |   37 -
 drivers/gpu/drm/rcar-du/rcar_du_drv.c                          |   48 --
 drivers/gpu/drm/rcar-du/rcar_du_drv.h                          |    2 
 drivers/gpu/drm/rcar-du/rcar_du_regs.h                         |    3 
 drivers/gpu/drm/stm/ltdc.c                                     |    4 
 drivers/hid/hid-logitech-hidpp.c                               |    4 
 drivers/hid/intel-ish-hid/ipc/hw-ish.h                         |    1 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                        |    1 
 drivers/i2c/busses/i2c-bcm-iproc.c                             |   11 
 drivers/i2c/busses/i2c-designware-master.c                     |   16 
 drivers/i2c/busses/i2c-hisi.c                                  |    8 
 drivers/i2c/busses/i2c-tegra.c                                 |    2 
 drivers/infiniband/hw/mlx5/qpc.c                               |   10 
 drivers/iommu/amd/amd_iommu_types.h                            |    4 
 drivers/iommu/amd/init.c                                       |   36 +
 drivers/leds/rgb/leds-qcom-lpg.c                               |    8 
 drivers/media/platform/mediatek/vpu/mtk_vpu.c                  |    6 
 drivers/media/platform/qcom/camss/camss-vfe.c                  |    6 
 drivers/misc/habanalabs/common/device.c                        |   15 
 drivers/misc/habanalabs/common/habanalabs.h                    |    2 
 drivers/misc/habanalabs/common/habanalabs_drv.c                |    2 
 drivers/mmc/core/block.c                                       |    7 
 drivers/mmc/host/sdhci_f_sdh30.c                               |   66 +--
 drivers/mmc/host/wbsd.c                                        |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                               |    8 
 drivers/net/ethernet/cadence/macb_main.c                       |    9 
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                     |   16 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                 |   10 
 drivers/net/ethernet/intel/iavf/iavf_fdir.c                    |   77 +++
 drivers/net/ethernet/intel/iavf/iavf_fdir.h                    |    2 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                   |    6 
 drivers/net/ethernet/intel/ice/ice_main.c                      |    5 
 drivers/net/ethernet/intel/igc/igc_base.h                      |   11 
 drivers/net/ethernet/intel/igc/igc_main.c                      |    7 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c            |    2 
 drivers/net/ethernet/qlogic/qede/qede_main.c                   |   10 
 drivers/net/ethernet/sfc/tc.c                                  |    2 
 drivers/net/pcs/pcs-rzn1-miic.c                                |   10 
 drivers/net/phy/at803x.c                                       |   89 +---
 drivers/net/phy/broadcom.c                                     |   13 
 drivers/net/phy/phy_device.c                                   |   13 
 drivers/net/team/team.c                                        |    4 
 drivers/net/virtio_net.c                                       |   26 +
 drivers/pci/controller/dwc/pcie-tegra194.c                     |   13 
 drivers/pcmcia/rsrc_nonstatic.c                                |    2 
 drivers/soc/aspeed/aspeed-socinfo.c                            |    1 
 drivers/soc/aspeed/aspeed-uart-routing.c                       |    2 
 drivers/thunderbolt/nhi.c                                      |    2 
 drivers/thunderbolt/nhi.h                                      |    4 
 drivers/thunderbolt/quirks.c                                   |    8 
 drivers/thunderbolt/retimer.c                                  |   29 +
 drivers/tty/n_gsm.c                                            |    3 
 drivers/tty/serial/8250/8250_port.c                            |    1 
 drivers/tty/serial/fsl_lpuart.c                                |    4 
 drivers/tty/serial/stm32-usart.c                               |    5 
 drivers/usb/chipidea/ci_hdrc_imx.c                             |    5 
 drivers/usb/chipidea/usbmisc_imx.c                             |    2 
 drivers/usb/gadget/function/u_serial.c                         |    3 
 drivers/usb/gadget/function/uvc_video.c                        |   32 +
 drivers/vdpa/mlx5/core/mlx5_vdpa.h                             |    2 
 drivers/vdpa/mlx5/core/mr.c                                    |   97 +++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                              |    4 
 drivers/vdpa/vdpa.c                                            |    9 
 drivers/vdpa/vdpa_user/vduse_dev.c                             |    8 
 drivers/video/aperture.c                                       |    7 
 drivers/video/fbdev/hyperv_fb.c                                |   17 
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c                          |    4 
 drivers/virtio/virtio_mmio.c                                   |    5 
 drivers/watchdog/sp5100_tco.c                                  |    4 
 fs/btrfs/block-group.c                                         |   14 
 fs/btrfs/block-group.h                                         |   18 
 fs/btrfs/extent_map.c                                          |    6 
 fs/btrfs/free-space-tree.c                                     |   10 
 fs/btrfs/tests/free-space-tree-tests.c                         |    2 
 fs/btrfs/volumes.c                                             |    3 
 fs/btrfs/zoned.c                                               |    7 
 fs/ceph/mds_client.c                                           |    4 
 fs/gfs2/super.c                                                |   26 -
 fs/ntfs3/frecord.c                                             |   16 
 fs/ntfs3/fsntfs.c                                              |    2 
 fs/ntfs3/index.c                                               |    6 
 fs/ntfs3/ntfs_fs.h                                             |    2 
 fs/ntfs3/record.c                                              |   10 
 fs/smb/client/cifsfs.c                                         |   28 -
 fs/smb/client/file.c                                           |   25 -
 fs/smb/client/smb2pdu.c                                        |    6 
 include/kvm/arm_vgic.h                                         |    2 
 include/linux/iopoll.h                                         |    2 
 include/linux/virtio_net.h                                     |    4 
 include/media/v4l2-mem2mem.h                                   |   18 
 include/net/sock.h                                             |    6 
 kernel/dma/remap.c                                             |    4 
 kernel/sched/fair.c                                            |  189 ++++-----
 kernel/sched/sched.h                                           |   19 
 kernel/trace/ring_buffer.c                                     |   14 
 kernel/trace/trace.c                                           |    3 
 mm/hugetlb.c                                                   |   75 ++-
 mm/zsmalloc.c                                                  |  113 ++---
 net/bluetooth/l2cap_core.c                                     |    5 
 net/bluetooth/mgmt.c                                           |    2 
 net/core/sock.c                                                |    2 
 net/ipv4/ip_vti.c                                              |    4 
 net/ipv4/tcp_timer.c                                           |    4 
 net/ipv6/ip6_vti.c                                             |    4 
 net/key/af_key.c                                               |    4 
 net/netfilter/ipvs/ip_vs_ctl.c                                 |    4 
 net/netfilter/nf_conntrack_proto_sctp.c                        |    6 
 net/netfilter/nf_tables_api.c                                  |    1 
 net/netfilter/nft_dynset.c                                     |    3 
 net/netfilter/nft_set_pipapo.c                                 |   13 
 net/openvswitch/datapath.c                                     |    8 
 net/smc/af_smc.c                                               |    4 
 net/smc/smc.h                                                  |    2 
 net/smc/smc_clc.c                                              |    4 
 net/smc/smc_core.c                                             |   80 +--
 net/smc/smc_core.h                                             |    4 
 net/smc/smc_llc.c                                              |   16 
 net/smc/smc_sysctl.c                                           |   10 
 net/unix/af_unix.c                                             |    9 
 net/xfrm/xfrm_compat.c                                         |    2 
 net/xfrm/xfrm_interface_core.c                                 |    4 
 net/xfrm/xfrm_user.c                                           |   14 
 sound/hda/hdac_regmap.c                                        |    7 
 sound/pci/hda/patch_realtek.c                                  |   91 ++++
 sound/soc/amd/Kconfig                                          |    1 
 sound/soc/amd/vangogh/acp5x.h                                  |    2 
 sound/soc/amd/vangogh/pci-acp5x.c                              |    7 
 sound/soc/codecs/rt5665.c                                      |    2 
 sound/soc/intel/boards/sof_sdw.c                               |   25 +
 sound/soc/intel/boards/sof_sdw_rt711_sdca.c                    |    3 
 sound/soc/meson/axg-tdm-formatter.c                            |   42 +-
 sound/soc/sof/amd/acp.h                                        |    3 
 sound/soc/sof/amd/pci-rmb.c                                    |    3 
 sound/soc/sof/amd/pci-rn.c                                     |    3 
 sound/soc/sof/core.c                                           |    4 
 sound/soc/sof/intel/hda.c                                      |   12 
 sound/usb/quirks-table.h                                       |   29 +
 tools/testing/selftests/net/forwarding/mirror_gre_changes.sh   |    3 
 tools/testing/selftests/net/forwarding/tc_actions.sh           |   18 
 241 files changed, 1862 insertions(+), 997 deletions(-)

Abel Wu (1):
      sock: Fix misuse of sk_under_memory_pressure()

Alexander Stein (1):
      arm64: dts: imx93: Fix anatop node size

Alexandre Ghiti (1):
      riscv: uaccess: Return the number of bytes effectively not copied

Alfred Lee (1):
      net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset

Alvin Lee (1):
      drm/amd/display: Apply 60us prefetch for DCFCLK <= 300Mhz

Andrej Picej (1):
      ARM: dts: imx6: phytec: fix RTC interrupt level

Andrew Yang (1):
      zsmalloc: fix races between modifications of fullness and isolated

Andrey Konovalov (1):
      media: camss: set VFE bpl_alignment to 16 for sdm845 and sm8250

Andrii Staikov (1):
      i40e: fix misleading debug logs

Andy Shevchenko (1):
      Bluetooth: MGMT: Use correct address for memcpy()

Armin Wolf (1):
      pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()

Arnd Bergmann (1):
      ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG

Avichal Rakesh (1):
      usb: gadget: uvc: queue empty isoc requests if no video buffer is available

Bard Liao (2):
      ASoC: Intel: sof_sdw: add quirk for MTL RVP
      ASoC: Intel: sof_sdw_rt_sdca_jack_common: test SOF_JACK_JDSRC in _exit

Benjamin Gray (1):
      powerpc/kasan: Disable KCOV in KASAN code

Chen Lin (1):
      ring-buffer: Do not swap cpu_buffer during resize process

Chengfeng Ye (1):
      i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue

Christophe JAILLET (1):
      net: phy: at803x: Use devm_regulator_get_enable_optional()

Christopher Obbard (2):
      arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
      arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+

D. Wythe (1):
      net/smc: replace mutex rmbs_lock and sndbufs_lock with rw_semaphore

Daniel Miess (2):
      drm/amd/display: Enable dcn314 DPP RCO
      drm/amd/display: disable RCO for DCN314

Daniel Vetter (1):
      video/aperture: Only remove sysfb on the default vga pci device

David Sterba (2):
      btrfs: convert btrfs_block_group::needs_free_space to runtime flag
      btrfs: convert btrfs_block_group::seq_zone to runtime flag

Davide Caratti (1):
      selftests: forwarding: tc_actions: cleanup temporary files when test is aborted

Dmitry Baryshkov (1):
      arm64: dts: qcom: qrb5165-rb5: fix thermal zone conflict

Dragos Tatulea (2):
      vdpa/mlx5: Fix mr->initialized semantics
      vdpa: Enable strict validation for netlinks ops

Edward Cree (1):
      sfc: don't unregister flow_indr if it was never registered

Edward Lo (1):
      fs/ntfs3: Enhance sanity check while generating attr_list

Eric Dumazet (1):
      net: do not allow gso_size to be set to GSO_BY_FRAGS

Eugenio Pérez (1):
      vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary

Even Xu (1):
      HID: intel-ish-hid: ipc: Add Arrow Lake PCI device ID

Fabio Estevam (1):
      arm64: dts: imx8mm: Drop CSI1 PHY reference clock configuration

Filipe Manana (1):
      btrfs: fix use-after-free of new block group that became unused

Florian Westphal (2):
      netfilter: nf_tables: fix false-positive lockdep splat
      netfilter: nf_tables: deactivate catchall elements in next generation

Geert Uytterhoeven (1):
      iopoll: Call cpu_relax() in busy loops

Gerd Bayer (1):
      net/smc: Fix setsockopt and sysctl to specify same buffer size again

Greg Kroah-Hartman (1):
      Linux 6.1.47

Guchun Chen (1):
      drm/amdgpu: keep irq count in amdgpu_irq_disable_all

Hans Verkuil (1):
      media: platform: mediatek: vpu: fix NULL ptr dereference

Hawkins Jiawei (1):
      virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG case

Hersen Wu (1):
      drm/amd/display: fix access hdcp_workqueue assert

Ido Schimmel (1):
      selftests: forwarding: tc_actions: Use ncat instead of nc

Jack Xiao (1):
      drm/amdgpu: fix memory leak in mes self test

Jakub Kicinski (1):
      net: openvswitch: reject negative ifindex

Jani Nikula (1):
      drm/i915/sdvo: fix panel_type initialization

Jason Wang (1):
      virtio-net: set queues after driver_ok

Jason Xing (1):
      net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled

Jerome Brunet (1):
      ASoC: meson: axg-tdm-formatter: fix channel slot allocation

Jia-Ju Bai (1):
      fs: ntfs3: Fix possible null-pointer dereferences in mi_read()

Jiasheng Jiang (1):
      soc: aspeed: socinfo: Add kfree for kstrdup

Josef Bacik (1):
      btrfs: fix incorrect splitting in btrfs_drop_extent_map_range

Justin Chen (1):
      net: phy: broadcom: stub c45 read/write for 54810

Kailang Yang (1):
      ALSA: hda/realtek - Remodified 3k pull low procedure

Karol Herbst (1):
      drm/nouveau/disp: fix use-after-free in error handling of nouveau_connector_create

Konstantin Komarov (1):
      fs/ntfs3: Mark ntfs dirty when on-disk struct is corrupted

Krzysztof Kozlowski (1):
      ARM: dts: imx: align LED node names with dtschema

Kunihiko Hayashi (1):
      mmc: sdhci-f-sdh30: Replace with sdhci_pltfm

Kuniyuki Iwashima (1):
      af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Lang Yu (1):
      drm/amdgpu: install stub fence into potential unused fence pointers

Laurent Vivier (1):
      virtio_net: notify MAC address change on device initialization

Li Yang (1):
      net: phy: at803x: fix the wol setting functions

Lin Ma (8):
      vdpa: Add features attr to vdpa_nl_policy for nlattr length check
      vdpa: Add queue index attr to vdpa_nl_policy for nlattr length check
      vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check
      net: xfrm: Fix xfrm_address_filter OOB read
      net: af_key: fix sadb_x_filter validation
      net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
      xfrm: add NULL check in xfrm_update_ae_params
      xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH

Longlong Yao (1):
      drm/amdgpu: fix calltrace warning in amddrm_buddy_fini

Lu Hongfei (1):
      led: qcom-lpg: Fix resource leaks in for_each_available_child_of_node() loops

Luca Ceresoli (1):
      drm/panel: simple: Fix AUO G121EAN01 panel timings according to the docs

Luke D. Jones (3):
      ALSA: hda/realtek: Add quirk for ASUS ROG GX650P
      ALSA: hda/realtek: Add quirk for ASUS ROG GA402X
      ALSA: hda/realtek: Add quirk for ASUS ROG GZ301V

Manish Chopra (1):
      qede: fix firmware halt over suspend and resume

Marc Zyngier (1):
      KVM: arm64: vgic-v4: Make the doorbell request robust w.r.t preemption

Marcin Szycik (1):
      ice: Block switchdev mode when ADQ is active and vice versa

Mario Limonciello (1):
      drm/amd: flush any delayed gfxoff on suspend entry

Mark Brown (1):
      arm64/ptrace: Ensure that SME is set up for target when writing SSVE state

Matthew Anderson (2):
      ALSA: hda/realtek: Add quirks for ROG ALLY CS35l41 audio
      Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally

Maulik Shah (1):
      cpuidle: psci: Move enabling OSI mode after power domains creation

Maxime Coquelin (1):
      vduse: Use proper spinlock for IRQ injection

Michal Schmidt (1):
      octeon_ep: cancel tx_timeout_task later in remove sequence

Mika Westerberg (3):
      thunderbolt: Read retimer NVM authentication status prior tb_retimer_set_inbound_sbtx()
      thunderbolt: Add Intel Barlow Ridge PCI ID
      thunderbolt: Limit Intel Barlow Ridge USB3 bandwidth

Mike Kravetz (1):
      hugetlb: do not clear hugetlb dtor until allocating vmemmap

Naohiro Aota (1):
      btrfs: move out now unused BG from the reclaim list

Nathan Lynch (1):
      powerpc/rtas_flash: allow user copy to flash block cache objects

Nhat Pham (1):
      zsmalloc: consolidate zs_pool's migrate_lock and size_class's locks

Nicholas Kazlauskas (1):
      drm/amd/display: Skip DPP DTO update if root clock is gated

Ofir Bitton (1):
      accel/habanalabs: add pci health check during heartbeat

Oleksij Rempel (1):
      ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related warnings

Pablo Neira Ayuso (1):
      netfilter: nft_dynset: disallow object maps

Parker Newman (1):
      i2c: tegra: Fix i2c-tegra DMA config option processing

Patrisious Haddad (1):
      RDMA/mlx5: Return the firmware result upon destroying QP/RQ

Paulo Alcantara (1):
      smb: client: fix warning in cifs_smb3_do_mount()

Peter Ujfalusi (2):
      ASoC: Intel: sof_sdw: add quirk for LNL RVP
      ASoC: SOF: core: Free the firmware trace before calling snd_sof_shutdown()

Petr Machata (1):
      selftests: mirror_gre_changes: Tighten up the TTL test match

Pierre-Louis Bossart (1):
      ASoC: SOF: Intel: fix SoundWire/HDaudio mutual exclusion

Piotr Gardocki (1):
      iavf: fix FDIR rule fields masks validation

Prashanth K (1):
      usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push

Quan Nguyen (1):
      i2c: designware: Correct length byte validation logic

Radhey Shyam Pandey (1):
      net: macb: In ZynqMP resume always configure PS GTR for non-wakeup source

Raphael Gallais-Pou (1):
      drm/stm: ltdc: fix late dereference check

Russell Harmon via samba-technical (1):
      cifs: Release folio lock on fscache read hit.

Russell King (Oracle) (1):
      net: phy: fix IRQ-based wake-on-lan over hibernate / power off

Saaem Rizvi (1):
      drm/amd/display: Implement workaround for writing to OTG_PIXEL_RATE_DIV register

Sergey Senozhatsky (1):
      zsmalloc: allow only one active pool compaction context

Sherry Sun (1):
      tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms

Sishuai Gong (1):
      ipvs: fix racy memcpy in proc_do_sync_threshold

Song Yoong Siang (1):
      igc: read before write to SRRCTL register

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for HP G11 Laptops

Steve French (1):
      cifs: fix potential oops in cifs_oplock_break

Sumit Gupta (1):
      PCI: tegra194: Fix possible array out of bounds access

Suravee Suthikulpanit (1):
      iommu/amd: Introduce Disable IRTE Caching Support

Sweet Tea Dorminy (1):
      blk-crypto: dynamically allocate fallback profile

Tam Nguyen (1):
      i2c: designware: Handle invalid SMBus block data response length value

Thomas Zimmermann (1):
      fbdev/hyperv-fb: Do not set struct fb_info.apertures

Tim Huang (2):
      drm/amdgpu: skip fence GFX interrupts disable/enable for S0ix
      drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU v13.0.4/11

Tony Lindgren (2):
      bus: ti-sysc: Flush posted write on enable before reset
      serial: 8250: Fix oops for port->pm on uart_change_pm()

Tuo Li (2):
      gfs2: Fix possible data races in gfs2_show_options()
      ALSA: hda: fix a possible null-pointer dereference due to data race in snd_hdac_regmap_sync()

Uday M Bhat (1):
      ASoC: Intel: sof_sdw: Add support for Rex soundwire

Ulf Hansson (1):
      cpuidle: psci: Extend information in log about OSI/PC mode

Umio Yasuno (1):
      drm/amdgpu/pm: fix throttle_status for other than MP1 11.0.7

Uwe Kleine-König (1):
      serial: stm32: Ignore return value of uart_remove_one_port() in .remove()

Venkata Prasad Potturu (2):
      ASoC: SOF: amd: Add pci revision id check
      ASoC: amd: vangogh: Add check for acp config flags in vangogh platform

Vincent Guittot (2):
      sched/fair: unlink misfit task from cpu overutilized
      sched/fair: Remove capacity inversion detection

Wander Lairson Costa (1):
      drm/qxl: fix UAF on handle creation

Winston Wen (1):
      cifs: fix session state check in reconnect to avoid use-after-free issue

Wolfram Sang (2):
      drm: rcar-du: remove R-Car H3 ES1.* workarounds
      virtio-mmio: don't break lifecycle of vm_dev

Xiang Yang (1):
      net: pcs: Add missing put_device call in miic_create

Xiaolei Wang (1):
      ARM: dts: imx: Set default tuning step for imx6sx usdhc

Xin Long (1):
      netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

Xiubo Li (1):
      ceph: try to dump the msgs when decoding fails

Xu Yang (3):
      usb: chipidea: imx: don't request QoS for imx8ulp
      usb: chipidea: imx: add missing USB PHY DPDM wakeup setting
      ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Yang Yingliang (1):
      mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Yangtao Li (1):
      mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove

Yi Yang (1):
      tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux

Yibin Ding (1):
      mmc: block: Fix in_flight[issue_type] value error

Yicong Yang (1):
      i2c: hisi: Only handle the interrupt of the driver's transfer

Yogesh Hegde (1):
      arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4 boards

Yuanjun Gong (1):
      fbdev: mmp: fix value check in mmphw_probe()

Yuechao Zhao (1):
      watchdog: sp5100_tco: support Hygon FCH/SCH (Server Controller Hub)

Yunfei Dong (1):
      media: v4l2-mem2mem: add lock to protect parameter num_rdy

Zev Weiss (1):
      soc: aspeed: uart-routing: Use __sysfs_match_string

Zhang Shurong (2):
      firewire: net: fix use after free in fwnet_finish_incoming_packet()
      ASoC: rt5665: add missed regulator_bulk_disable

Zhengchao Shao (3):
      xfrm: fix slab-use-after-free in decode_session6
      ip6_vti: fix slab-use-after-free in decode_session6
      ip_vti: fix potential slab-use-after-free in decode_session6

Zhengping Jiang (1):
      Bluetooth: L2CAP: Fix use-after-free

Ziyang Xuan (1):
      team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

dengxiang (2):
      ALSA: hda/realtek: Add quirks for Unis H3C Desktop B760 & Q760
      ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.

gaoxu (1):
      dma-remap: use kvmalloc_array/kvfree for larger dma memory remap

hackyzh002 (1):
      drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1

hersen wu (2):
      drm/amd/display: save restore hdcp state when display is unplugged from mst hub
      drm/amd/display: phase3 mst hdcp for multiple displays

shanzhulig (1):
      drm/amdgpu: Fix potential fence use-after-free v2

stuarthayhurst (1):
      HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard

xiaoshoukui (1):
      btrfs: fix BUG_ON condition in btrfs_cancel_balance

