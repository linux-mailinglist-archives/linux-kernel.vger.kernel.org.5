Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE0785CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjHWQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjHWQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D12E70;
        Wed, 23 Aug 2023 09:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21F6C62802;
        Wed, 23 Aug 2023 16:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE819C433C7;
        Wed, 23 Aug 2023 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692806498;
        bh=vOvKWjJbKdlaTfSU+I4CRQJmS1oj1knJbSmT/9mSrXA=;
        h=From:To:Cc:Subject:Date:From;
        b=JAFDhPj/YRL83ILnYs2HQ+KJuIksGcEsyqsHVABmgIP5yaBscI3qoe/ylMLWOqvBs
         Fw/PF7QsW0RvuiwK7V8dLhOV7u8xmt3W0xA5NiM8L8SF+JrgS0///bPYJtCEDKNABL
         1wY/ZXLPNyuRpZZwUNAKLdKUIXvrC+gR6WDknISw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.4.12
Date:   Wed, 23 Aug 2023 18:01:28 +0200
Message-ID: <2023082328-humped-battalion-a9b4@gregkh>
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

I'm announcing the release of the 6.4.12 kernel.

All users of the 6.4 kernel series must upgrade.

The updated 6.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/srso.rst                       |    4 
 Documentation/admin-guide/kernel-parameters.txt                  |    1 
 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml      |    9 
 Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml |    2 
 Documentation/networking/nf_conntrack-sysctl.rst                 |    4 
 Makefile                                                         |    2 
 arch/arm/boot/dts/imx23.dtsi                                     |    2 
 arch/arm/boot/dts/imx28.dtsi                                     |    2 
 arch/arm/boot/dts/imx6dl-prtrvt.dts                              |    4 
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi                       |    2 
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi                            |   11 
 arch/arm/boot/dts/imx6qdl.dtsi                                   |    2 
 arch/arm/boot/dts/imx6sx.dtsi                                    |    8 
 arch/arm/boot/dts/imx6ul.dtsi                                    |    2 
 arch/arm/boot/dts/imx7s.dtsi                                     |    8 
 arch/arm64/boot/dts/freescale/imx8mm.dtsi                        |    7 
 arch/arm64/boot/dts/freescale/imx93.dtsi                         |    2 
 arch/arm64/boot/dts/qcom/ipq5332.dtsi                            |    7 
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts                         |    2 
 arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts             |    3 
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi               |    6 
 arch/arm64/include/asm/fpsimd.h                                  |    4 
 arch/arm64/kernel/fpsimd.c                                       |    6 
 arch/arm64/kernel/ptrace.c                                       |   20 +
 arch/arm64/kernel/signal.c                                       |    2 
 arch/parisc/kernel/entry.S                                       |   47 +--
 arch/powerpc/kernel/rtas_flash.c                                 |    6 
 arch/powerpc/mm/kasan/Makefile                                   |    1 
 arch/riscv/include/asm/insn.h                                    |   15 -
 arch/riscv/kernel/traps.c                                        |    6 
 arch/riscv/lib/uaccess.S                                         |   11 
 arch/um/os-Linux/user_syms.c                                     |    7 
 arch/x86/include/asm/entry-common.h                              |    1 
 arch/x86/include/asm/nospec-branch.h                             |   49 +--
 arch/x86/kernel/alternative.c                                    |    4 
 arch/x86/kernel/cpu/amd.c                                        |    1 
 arch/x86/kernel/cpu/bugs.c                                       |   29 +-
 arch/x86/kernel/kprobes/opt.c                                    |   40 +-
 arch/x86/kernel/static_call.c                                    |   13 
 arch/x86/kernel/traps.c                                          |    2 
 arch/x86/kernel/vmlinux.lds.S                                    |   22 -
 arch/x86/kvm/svm/svm.c                                           |    2 
 arch/x86/kvm/svm/vmenter.S                                       |    7 
 arch/x86/lib/retpoline.S                                         |  137 ++++++----
 block/blk-cgroup.c                                               |    2 
 block/blk-crypto-fallback.c                                      |   36 +-
 drivers/accel/habanalabs/common/device.c                         |   15 +
 drivers/accel/habanalabs/common/habanalabs.h                     |    2 
 drivers/accel/habanalabs/common/habanalabs_drv.c                 |    4 
 drivers/accel/qaic/qaic_control.c                                |   26 +
 drivers/accel/qaic/qaic_data.c                                   |    1 
 drivers/bluetooth/btusb.c                                        |    3 
 drivers/bus/ti-sysc.c                                            |    2 
 drivers/firewire/net.c                                           |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                           |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c                          |   38 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h                          |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                       |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                        |   41 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                          |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                          |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                          |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                          |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                         |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                           |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                |    5 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c     |   27 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c            |    2 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c                |    8 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c              |    5 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c          |   20 +
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c             |   24 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c             |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c   |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h   |    2 
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h                     |    1 
 drivers/gpu/drm/amd/include/amd_shared.h                         |    1 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                        |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c          |   14 -
 drivers/gpu/drm/drm_edid.c                                       |   29 --
 drivers/gpu/drm/i915/display/intel_sdvo.c                        |    2 
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c                      |   22 +
 drivers/gpu/drm/nouveau/nouveau_connector.c                      |   11 
 drivers/gpu/drm/panel/panel-simple.c                             |   24 -
 drivers/gpu/drm/qxl/qxl_drv.h                                    |    2 
 drivers/gpu/drm/qxl/qxl_dumb.c                                   |    5 
 drivers/gpu/drm/qxl/qxl_gem.c                                    |   25 +
 drivers/gpu/drm/qxl/qxl_ioctl.c                                  |    6 
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c                           |   37 --
 drivers/gpu/drm/rcar-du/rcar_du_drv.c                            |   48 ---
 drivers/gpu/drm/rcar-du/rcar_du_drv.h                            |    2 
 drivers/gpu/drm/rcar-du/rcar_du_regs.h                           |    3 
 drivers/gpu/drm/scheduler/sched_entity.c                         |    6 
 drivers/gpu/drm/scheduler/sched_main.c                           |    4 
 drivers/gpu/drm/stm/ltdc.c                                       |    4 
 drivers/hid/hid-logitech-hidpp.c                                 |    4 
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c                          |   16 +
 drivers/hid/intel-ish-hid/ipc/hw-ish.h                           |    1 
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                          |    1 
 drivers/i2c/busses/i2c-bcm-iproc.c                               |   11 
 drivers/i2c/busses/i2c-designware-master.c                       |   16 +
 drivers/i2c/busses/i2c-hisi.c                                    |    8 
 drivers/i2c/busses/i2c-tegra.c                                   |    2 
 drivers/infiniband/hw/bnxt_re/bnxt_re.h                          |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                         |   16 -
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                         |    8 
 drivers/infiniband/hw/bnxt_re/qplib_sp.h                         |    4 
 drivers/infiniband/hw/mana/qp.c                                  |    5 
 drivers/infiniband/hw/mlx5/qpc.c                                 |   10 
 drivers/iommu/amd/amd_iommu_types.h                              |    4 
 drivers/iommu/amd/init.c                                         |   36 ++
 drivers/leds/rgb/leds-qcom-lpg.c                                 |    8 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c             |    4 
 drivers/media/platform/mediatek/vpu/mtk_vpu.c                    |    6 
 drivers/media/platform/qcom/camss/camss-vfe.c                    |    6 
 drivers/media/usb/uvc/uvc_v4l2.c                                 |    2 
 drivers/mmc/core/block.c                                         |    7 
 drivers/mmc/host/sdhci_f_sdh30.c                                 |   11 
 drivers/mmc/host/sunplus-mmc.c                                   |   26 -
 drivers/mmc/host/wbsd.c                                          |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                 |    8 
 drivers/net/ethernet/cadence/macb_main.c                         |    9 
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                       |   16 -
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                   |   10 
 drivers/net/ethernet/intel/iavf/iavf_fdir.c                      |   77 +++++
 drivers/net/ethernet/intel/iavf/iavf_fdir.h                      |    2 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                     |    6 
 drivers/net/ethernet/intel/ice/ice_main.c                        |    5 
 drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c          |    2 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c              |    9 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h                 |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                |    8 
 drivers/net/ethernet/microsoft/mana/mana_en.c                    |    5 
 drivers/net/ethernet/qlogic/qede/qede_main.c                     |   10 
 drivers/net/ethernet/sfc/ef100_nic.c                             |    2 
 drivers/net/ethernet/sfc/tc.c                                    |   70 +++++
 drivers/net/ethernet/sfc/tc.h                                    |    9 
 drivers/net/pcs/pcs-rzn1-miic.c                                  |   10 
 drivers/net/phy/at803x.c                                         |   89 ++----
 drivers/net/phy/broadcom.c                                       |   13 
 drivers/net/phy/phy_device.c                                     |   13 
 drivers/net/team/team.c                                          |    4 
 drivers/net/veth.c                                               |    3 
 drivers/net/virtio_net.c                                         |    6 
 drivers/pci/controller/dwc/pcie-tegra194.c                       |   13 
 drivers/pcmcia/rsrc_nonstatic.c                                  |    2 
 drivers/pinctrl/qcom/pinctrl-msm.c                               |    9 
 drivers/pinctrl/qcom/pinctrl-msm.h                               |    2 
 drivers/pinctrl/qcom/pinctrl-sa8775p.c                           |    1 
 drivers/regulator/da9063-regulator.c                             |   12 
 drivers/regulator/qcom-rpmh-regulator.c                          |    2 
 drivers/soc/aspeed/aspeed-socinfo.c                              |    1 
 drivers/soc/aspeed/aspeed-uart-routing.c                         |    2 
 drivers/thunderbolt/nhi.c                                        |    2 
 drivers/thunderbolt/nhi.h                                        |    4 
 drivers/thunderbolt/quirks.c                                     |    8 
 drivers/thunderbolt/retimer.c                                    |   29 +-
 drivers/tty/n_gsm.c                                              |    3 
 drivers/tty/serial/8250/8250_port.c                              |    1 
 drivers/tty/serial/fsl_lpuart.c                                  |    4 
 drivers/tty/serial/stm32-usart.c                                 |    5 
 drivers/usb/chipidea/ci_hdrc_imx.c                               |    5 
 drivers/usb/chipidea/usbmisc_imx.c                               |   37 ++
 drivers/usb/gadget/function/u_serial.c                           |    3 
 drivers/usb/gadget/function/uvc_video.c                          |   32 +-
 drivers/usb/host/xhci-histb.c                                    |   12 
 drivers/usb/host/xhci-mtk.c                                      |    6 
 drivers/usb/host/xhci-pci.c                                      |    7 
 drivers/usb/host/xhci-plat.c                                     |    7 
 drivers/usb/host/xhci-tegra.c                                    |    1 
 drivers/usb/host/xhci.h                                          |    2 
 drivers/vdpa/mlx5/core/mlx5_vdpa.h                               |    2 
 drivers/vdpa/mlx5/core/mr.c                                      |   97 +++++--
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                |    4 
 drivers/vdpa/vdpa.c                                              |    9 
 drivers/vdpa/vdpa_user/vduse_dev.c                               |    8 
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c                            |    4 
 drivers/virtio/virtio_mmio.c                                     |    5 
 drivers/virtio/virtio_vdpa.c                                     |    2 
 drivers/watchdog/sp5100_tco.c                                    |    4 
 fs/btrfs/block-group.c                                           |   12 
 fs/btrfs/block-group.h                                           |    5 
 fs/btrfs/ctree.h                                                 |    1 
 fs/btrfs/delayed-inode.c                                         |    5 
 fs/btrfs/delayed-inode.h                                         |    1 
 fs/btrfs/extent_io.c                                             |   25 +
 fs/btrfs/extent_map.c                                            |    6 
 fs/btrfs/inode.c                                                 |  131 +++++----
 fs/btrfs/scrub.c                                                 |    3 
 fs/btrfs/volumes.c                                               |    3 
 fs/ceph/mds_client.c                                             |    4 
 fs/gfs2/super.c                                                  |   26 +
 fs/netfs/iterator.c                                              |    2 
 fs/ntfs3/frecord.c                                               |   16 -
 fs/ntfs3/fsntfs.c                                                |    2 
 fs/ntfs3/index.c                                                 |    6 
 fs/ntfs3/ntfs_fs.h                                               |    2 
 fs/ntfs3/record.c                                                |   10 
 fs/ntfs3/super.c                                                 |   98 +++++--
 fs/ntfs3/xattr.c                                                 |    1 
 fs/smb/client/cifs_debug.c                                       |   10 
 fs/smb/client/cifsfs.c                                           |   28 --
 fs/smb/client/file.c                                             |   25 +
 fs/smb/client/fs_context.c                                       |    4 
 fs/smb/client/smb2pdu.c                                          |    6 
 include/drm/drm_edid.h                                           |   12 
 include/linux/iopoll.h                                           |    2 
 include/linux/virtio_net.h                                       |    4 
 include/media/v4l2-mem2mem.h                                     |   18 +
 include/net/mana/mana.h                                          |    4 
 include/net/sock.h                                               |    6 
 include/net/xfrm.h                                               |    1 
 kernel/dma/remap.c                                               |    4 
 kernel/trace/ring_buffer.c                                       |   14 -
 kernel/trace/trace.c                                             |    3 
 net/bluetooth/l2cap_core.c                                       |    5 
 net/bluetooth/mgmt.c                                             |    2 
 net/core/sock.c                                                  |    2 
 net/ipv4/ip_vti.c                                                |    4 
 net/ipv4/tcp_timer.c                                             |    4 
 net/ipv6/ip6_vti.c                                               |    4 
 net/key/af_key.c                                                 |    4 
 net/netfilter/ipvs/ip_vs_ctl.c                                   |    4 
 net/netfilter/nf_conntrack_proto_sctp.c                          |    6 
 net/netfilter/nf_tables_api.c                                    |   44 ++-
 net/netfilter/nft_dynset.c                                       |    3 
 net/netfilter/nft_set_pipapo.c                                   |   36 +-
 net/openvswitch/datapath.c                                       |    8 
 net/unix/af_unix.c                                               |    9 
 net/xfrm/xfrm_compat.c                                           |    2 
 net/xfrm/xfrm_input.c                                            |   22 -
 net/xfrm/xfrm_interface_core.c                                   |    4 
 net/xfrm/xfrm_state.c                                            |    8 
 net/xfrm/xfrm_user.c                                             |   15 -
 rust/macros/vtable.rs                                            |    1 
 sound/hda/hdac_regmap.c                                          |    7 
 sound/pci/hda/patch_realtek.c                                    |   58 +++-
 sound/soc/amd/Kconfig                                            |    1 
 sound/soc/amd/vangogh/acp5x.h                                    |    2 
 sound/soc/amd/vangogh/pci-acp5x.c                                |    7 
 sound/soc/codecs/cs35l56.c                                       |   12 
 sound/soc/codecs/max98363.c                                      |    9 
 sound/soc/codecs/rt5665.c                                        |    2 
 sound/soc/intel/boards/sof_sdw.c                                 |   35 ++
 sound/soc/intel/boards/sof_sdw_rt711_sdca.c                      |    3 
 sound/soc/meson/axg-tdm-formatter.c                              |   42 +--
 sound/soc/sof/amd/acp.h                                          |    3 
 sound/soc/sof/amd/pci-rmb.c                                      |    3 
 sound/soc/sof/amd/pci-rn.c                                       |    3 
 sound/soc/sof/core.c                                             |    4 
 sound/soc/sof/intel/hda-dai-ops.c                                |   13 
 sound/soc/sof/intel/hda-dai.c                                    |    8 
 sound/soc/sof/intel/hda.c                                        |   12 
 sound/soc/sof/intel/hda.h                                        |    2 
 sound/usb/quirks-table.h                                         |   29 ++
 tools/objtool/arch/x86/decode.c                                  |   11 
 tools/objtool/check.c                                            |   45 ++-
 tools/objtool/include/objtool/arch.h                             |    1 
 tools/objtool/include/objtool/elf.h                              |    1 
 tools/perf/util/machine.c                                        |    5 
 tools/perf/util/thread-stack.c                                   |    4 
 tools/testing/selftests/net/forwarding/mirror_gre_changes.sh     |    3 
 262 files changed, 2085 insertions(+), 971 deletions(-)

Abel Vesa (1):
      regulator: qcom-rpmh: Fix LDO 12 regulator for PM8550

Abel Wu (1):
      sock: Fix misuse of sk_under_memory_pressure()

Alex Deucher (1):
      Revert "Revert "drm/amdgpu/display: change pipe policy for DCN 2.0""

Alexander Stein (1):
      arm64: dts: imx93: Fix anatop node size

Alexandre Ghiti (1):
      riscv: uaccess: Return the number of bytes effectively not copied

Alfred Lee (1):
      net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset

Alvin Lee (2):
      drm/amd/display: Update DTBCLK for DCN32
      drm/amd/display: Apply 60us prefetch for DCFCLK <= 300Mhz

Anand Jain (1):
      btrfs: fix replace/scrub failure with metadata_uuid

Andrej Picej (1):
      ARM: dts: imx6: phytec: fix RTC interrupt level

Andrey Konovalov (1):
      media: camss: set VFE bpl_alignment to 16 for sdm845 and sm8250

Andrii Staikov (1):
      i40e: fix misleading debug logs

Andy Shevchenko (1):
      Bluetooth: MGMT: Use correct address for memcpy()

Armin Wolf (1):
      pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()

Arnaldo Carvalho de Melo (1):
      Revert "perf report: Append inlines to non-DWARF callchains"

Arnd Bergmann (1):
      ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG

Aurabindo Pillai (1):
      Revert "drm/amd/display: disable SubVP + DRR to prevent underflow"

Avichal Rakesh (1):
      usb: gadget: uvc: queue empty isoc requests if no video buffer is available

Bard Liao (3):
      ASoC: Intel: sof_sdw: add quirk for MTL RVP
      ASoC: Intel: sof_sdw_rt_sdca_jack_common: test SOF_JACK_JDSRC in _exit
      ASoC: max98363: don't return on success reading revision ID

Benjamin Gray (1):
      powerpc/kasan: Disable KCOV in KASAN code

Borislav Petkov (AMD) (4):
      x86/srso: Explain the untraining sequences a bit more
      x86/CPU/AMD: Fix the DIV(0) initial fix attempt
      x86/srso: Disable the mitigation on unaffected configurations
      x86/srso: Correct the mitigation status when SMT is disabled

Celeste Liu (1):
      riscv: entry: set a0 = -ENOSYS only when syscall != -1

Chen Lin (1):
      ring-buffer: Do not swap cpu_buffer during resize process

Chen-Yu Tsai (1):
      media: mtk-jpeg: Set platform driver data earlier

Chengfeng Ye (1):
      i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue

Chris Mason (1):
      btrfs: only subtract from len_to_oe_boundary when it is tracking an extent

Christophe JAILLET (1):
      net: phy: at803x: Use devm_regulator_get_enable_optional()

Christopher Obbard (2):
      arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
      arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+

Dan Carpenter (1):
      accel/qaic: Clean up integer overflow checking in map_user_pages()

Daniel Miess (3):
      drm/amd/display: Remove v_startup workaround for dcn3+
      drm/amd/display: Enable dcn314 DPP RCO
      drm/amd/display: disable RCO for DCN314

Danilo Krummrich (1):
      drm/scheduler: set entity to NULL in drm_sched_entity_pop_job()

David Howells (1):
      crypto, cifs: fix error handling in extract_iter_to_sg()

Dmitry Baryshkov (1):
      arm64: dts: qcom: qrb5165-rb5: fix thermal zone conflict

Dragos Tatulea (3):
      vdpa/mlx5: Fix mr->initialized semantics
      vdpa: Enable strict validation for netlinks ops
      net/mlx5e: XDP, Fix fifo overrun on XDP_REDIRECT

Edward Cree (3):
      sfc: add fallback action-set-lists for TC offload
      sfc: don't unregister flow_indr if it was never registered
      sfc: don't fail probe if MAE/TC setup fails

Edward Lo (2):
      fs/ntfs3: Enhance sanity check while generating attr_list
      fs/ntfs3: Return error for inconsistent extended attributes

Eric Dumazet (1):
      net: do not allow gso_size to be set to GSO_BY_FRAGS

Eugenio Pérez (1):
      vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary

Even Xu (1):
      HID: intel-ish-hid: ipc: Add Arrow Lake PCI device ID

Fabio Estevam (1):
      arm64: dts: imx8mm: Drop CSI1 PHY reference clock configuration

Fei Shao (2):
      dt-bindings: input: goodix: Add "goodix,no-reset-during-suspend" property
      HID: i2c-hid: goodix: Add support for "goodix,no-reset-during-suspend" property

Filipe Manana (2):
      btrfs: fix use-after-free of new block group that became unused
      btrfs: fix infinite directory reads

Florian Westphal (3):
      netfilter: nf_tables: fix false-positive lockdep splat
      netfilter: nf_tables: deactivate catchall elements in next generation
      netfilter: nf_tables: don't fail inserts if duplicate has expired

Gal Pressman (1):
      virtio-vdpa: Fix cpumask memory leak in virtio_vdpa_find_vqs()

Geert Uytterhoeven (1):
      iopoll: Call cpu_relax() in busy loops

Greg Kroah-Hartman (1):
      Linux 6.4.12

Guchun Chen (1):
      drm/amdgpu: keep irq count in amdgpu_irq_disable_all

Hans Verkuil (1):
      media: platform: mediatek: vpu: fix NULL ptr dereference

Harshit Mogalapalli (1):
      mmc: sunplus: Fix error handling in spmmc_drv_probe()

Hawkins Jiawei (1):
      virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG case

Helge Deller (1):
      parisc: Fix CONFIG_TLB_PTLOCK to work with lightweight spinlock checks

Herbert Xu (1):
      xfrm: Silence warnings triggerable by bad packets

Jack Xiao (1):
      drm/amdgpu: fix memory leak in mes self test

Jakub Kicinski (1):
      net: openvswitch: reject negative ifindex

Jani Nikula (2):
      Revert "drm/edid: Fix csync detailed mode parsing"
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

Kashyap Desai (1):
      RDMA/bnxt_re: consider timeout of destroy ah as success.

Kathiravan T (1):
      arm64: dts: qcom: ipq5332: add QFPROM node

Konstantin Komarov (2):
      fs/ntfs3: Mark ntfs dirty when on-disk struct is corrupted
      fs/ntfs3: Alternative boot if primary boot is corrupted

Kuniyuki Iwashima (1):
      af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Lang Yu (2):
      drm/amdgpu: install stub fence into potential unused fence pointers
      drm/amdgpu: unmap and remove csa_va properly

Laurent Pinchart (1):
      media: uvcvideo: Fix menu count handling for userspace XU mappings

Leon Romanovsky (2):
      xfrm: delete offloaded policy
      xfrm: don't skip free of empty state in acquire policy

Li Yang (1):
      net: phy: at803x: fix the wol setting functions

Liang Chen (1):
      net: veth: Page pool creation error handling for existing pools only

Lin Ma (8):
      vdpa: Add features attr to vdpa_nl_policy for nlattr length check
      vdpa: Add queue index attr to vdpa_nl_policy for nlattr length check
      vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check
      net: xfrm: Fix xfrm_address_filter OOB read
      net: af_key: fix sadb_x_filter validation
      net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
      xfrm: add NULL check in xfrm_update_ae_params
      xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH

Long Li (1):
      RDMA/mana_ib: Use v2 version of cfg_rx_steer_req to enable RX coalescing

Longlong Yao (1):
      drm/amdgpu: fix calltrace warning in amddrm_buddy_fini

Lu Hongfei (1):
      led: qcom-lpg: Fix resource leaks in for_each_available_child_of_node() loops

Luca Ceresoli (1):
      drm/panel: simple: Fix AUO G121EAN01 panel timings according to the docs

Luke D. Jones (5):
      ALSA: hda/realtek: Add quirk for ASUS ROG GX650P
      ALSA: hda/realtek: Add quirk for ASUS ROG GA402X
      ALSA: hda/realtek: Amend G634 quirk to enable rear speakers
      ALSA: hda/realtek: Add quirk for ASUS ROG G614Jx
      ALSA: hda/realtek: Add quirk for ASUS ROG GZ301V

Manish Chopra (1):
      qede: fix firmware halt over suspend and resume

Marcin Szycik (1):
      ice: Block switchdev mode when ADQ is active and vice versa

Mario Limonciello (1):
      drm/amd: flush any delayed gfxoff on suspend entry

Mark Brown (2):
      arm64/ptrace: Ensure that SME is set up for target when writing SSVE state
      arm64/ptrace: Ensure that the task sees ZT writes on first use

Martin Fuzzey (1):
      regulator: da9063: better fix null deref with partial DT

Masahiro Yamada (1):
      Revert "[PATCH] uml: export symbols added by GCC hardened"

Mathias Nyman (1):
      xhci: get rid of XHCI_PLAT quirk that used to prevent MSI setup

Matthew Anderson (1):
      Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally

Maxime Coquelin (1):
      vduse: Use proper spinlock for IRQ injection

Michal Schmidt (4):
      octeon_ep: fix timeout value for waiting on mbox response
      octeon_ep: cancel tx_timeout_task later in remove sequence
      octeon_ep: cancel ctrl_mbox_task after intr_poll_task
      octeon_ep: cancel queued works in probe error path

Mika Westerberg (3):
      thunderbolt: Read retimer NVM authentication status prior tb_retimer_set_inbound_sbtx()
      thunderbolt: Add Intel Barlow Ridge PCI ID
      thunderbolt: Limit Intel Barlow Ridge USB3 bandwidth

Ming Lei (1):
      blk-cgroup: hold queue_lock when removing blkg->q_node

Moti Haimovski (1):
      accel/habanalabs: fix mem leak in capture user mappings

Nam Cao (1):
      riscv: correct riscv_insn_is_c_jr() and riscv_insn_is_c_jalr()

Naohiro Aota (1):
      btrfs: move out now unused BG from the reclaim list

Nathan Lynch (1):
      powerpc/rtas_flash: allow user copy to flash block cache objects

Nicholas Kazlauskas (1):
      drm/amd/display: Skip DPP DTO update if root clock is gated

Ninad Naik (1):
      pinctrl: qcom: Add intr_target_width field to support increased number of interrupt targets

Ofir Bitton (1):
      accel/habanalabs: add pci health check during heartbeat

Oleksij Rempel (1):
      ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related warnings

Pablo Neira Ayuso (3):
      netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path
      netfilter: nf_tables: GC transaction race with netns dismantle
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

Peter Zijlstra (11):
      x86/cpu: Fix __x86_return_thunk symbol type
      x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
      objtool/x86: Fix SRSO mess
      x86/alternative: Make custom return thunk unconditional
      x86/cpu: Clean up SRSO return thunk mess
      x86/cpu: Rename original retbleed methods
      x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
      x86/cpu: Cleanup the untrain mess
      x86/cpu/kvm: Provide UNTRAIN_RET_VM
      objtool/x86: Fixup frame-pointer vs rethunk
      x86/static_call: Fix __static_call_fixup()

Petr Machata (1):
      selftests: mirror_gre_changes: Tighten up the TTL test match

Petr Pavlu (2):
      x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG
      x86/retpoline,kprobes: Skip optprobe check for indirect jumps with retpolines and IBT

Pierre-Louis Bossart (2):
      ASoC: Intel: sof_sdw: add quick for Dell SKU 0BDA
      ASoC: SOF: Intel: fix SoundWire/HDaudio mutual exclusion

Piotr Gardocki (1):
      iavf: fix FDIR rule fields masks validation

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Fix slicing memory leak

Prashanth K (1):
      usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push

Qingsong Chen (1):
      rust: macros: vtable: fix `HAS_*` redefinition (`gen_const_name`)

Quan Nguyen (1):
      i2c: designware: Correct length byte validation logic

Radhey Shyam Pandey (1):
      net: macb: In ZynqMP resume always configure PS GTR for non-wakeup source

Ranjani Sridharan (1):
      ASoC: SOF: intel: hda: Clean up link DMA for IPC3 during stop

Raphael Gallais-Pou (1):
      drm/stm: ltdc: fix late dereference check

Russell Harmon via samba-technical (1):
      cifs: Release folio lock on fscache read hit.

Russell King (Oracle) (1):
      net: phy: fix IRQ-based wake-on-lan over hibernate / power off

Scott Mayhew (1):
      smb: client: fix null auth

Sean Christopherson (1):
      x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()

Shazad Hussain (1):
      dt-bindings: pinctrl: qcom,sa8775p-tlmm: add gpio function constant

Sherry Sun (1):
      tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms

Simon Trimmer (1):
      ASoC: cs35l56: Move DSP part string generation so that it is done only once

Sishuai Gong (1):
      ipvs: fix racy memcpy in proc_do_sync_threshold

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for HP G11 Laptops

Stefan Wahren (1):
      ARM: dts: imx: Adjust dma-apbh node name

Steve French (2):
      cifs: fix potential oops in cifs_oplock_break
      smb3: display network namespace in debug information

Sumit Gupta (1):
      PCI: tegra194: Fix possible array out of bounds access

Suravee Suthikulpanit (1):
      iommu/amd: Introduce Disable IRTE Caching Support

Sweet Tea Dorminy (1):
      blk-crypto: dynamically allocate fallback profile

Tam Nguyen (1):
      i2c: designware: Handle invalid SMBus block data response length value

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

Umio Yasuno (1):
      drm/amdgpu/pm: fix throttle_status for other than MP1 11.0.7

Uwe Kleine-König (1):
      serial: stm32: Ignore return value of uart_remove_one_port() in .remove()

Venkata Prasad Potturu (2):
      ASoC: SOF: amd: Add pci revision id check
      ASoC: amd: vangogh: Add check for acp config flags in vangogh platform

Vinay Belgaumkar (1):
      drm/i915/guc/slpc: Restore efficient freq earlier

Wander Lairson Costa (1):
      drm/qxl: fix UAF on handle creation

Wei Chen (1):
      mmc: sunplus: fix return value check of mmc_add_host()

Winston Wen (1):
      cifs: fix session state check in reconnect to avoid use-after-free issue

Wolfram Sang (2):
      drm: rcar-du: remove R-Car H3 ES1.* workarounds
      virtio-mmio: don't break lifecycle of vm_dev

Xiang Yang (1):
      net: pcs: Add missing put_device call in miic_create

Xiaolei Wang (2):
      ARM: dts: imx: Set default tuning step for imx7d usdhc
      ARM: dts: imx: Set default tuning step for imx6sx usdhc

Xin Long (1):
      netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

Xiubo Li (1):
      ceph: try to dump the msgs when decoding fails

Xu Yang (3):
      usb: chipidea: imx: don't request QoS for imx8ulp
      usb: chipidea: imx: turn off vbus comparator when suspend
      usb: chipidea: imx: add missing USB PHY DPDM wakeup setting

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

shanzhulig (1):
      drm/amdgpu: Fix potential fence use-after-free v2

stuarthayhurst (1):
      HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard

xiaoshoukui (1):
      btrfs: fix BUG_ON condition in btrfs_cancel_balance

