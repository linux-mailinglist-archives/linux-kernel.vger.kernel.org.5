Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F294A764861
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjG0HUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjG0HUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CC95FD0;
        Thu, 27 Jul 2023 00:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C070661D67;
        Thu, 27 Jul 2023 07:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EECC433C8;
        Thu, 27 Jul 2023 07:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690442004;
        bh=6cpL/KXIEw/mPxDdJO1RBe8pfdk33MhIDGNt+9Usou0=;
        h=From:To:Cc:Subject:Date:From;
        b=aTYoPcQJ78QiUJaibVMmTtNCKSwOpWNwkwIhBHL+t/C5FS2m/GecJAHSkRnj7EOyC
         ELpo4DtXBQAaRSbuIA4DN4lZFnP0isEfZiwBSjy+EGFcAap9AgDk8jCcMr121iOfV5
         FjVlgG0EAU1q3ZiNvrmcBwGhs+O0WyYRwzUsoS/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.251
Date:   Thu, 27 Jul 2023 09:13:18 +0200
Message-ID: <2023072719-subtract-grain-8e2b@gregkh>
X-Mailer: git-send-email 2.41.0
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

I'm announcing the release of the 5.4.251 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/directory-locking.rst         |   26 
 Documentation/networking/af_xdp.rst                     |  268 +++++++-
 Makefile                                                |    2 
 arch/arc/include/asm/linkage.h                          |    8 
 arch/arm/boot/dts/bcm5301x.dtsi                         |    1 
 arch/arm/boot/dts/omap3-gta04a5one.dts                  |    4 
 arch/arm/mach-ep93xx/timer-ep93xx.c                     |    3 
 arch/arm/mach-orion5x/board-dt.c                        |    3 
 arch/arm/mach-orion5x/common.h                          |    6 
 arch/arm/probes/kprobes/checkers-common.c               |    2 
 arch/arm/probes/kprobes/core.c                          |    2 
 arch/arm/probes/kprobes/opt-arm.c                       |    2 
 arch/arm/probes/kprobes/test-core.c                     |    2 
 arch/arm/probes/kprobes/test-core.h                     |    4 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                   |    2 
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi                |    3 
 arch/arm64/mm/mmu.c                                     |    4 
 arch/powerpc/Kconfig.debug                              |    2 
 arch/powerpc/Makefile                                   |    8 
 arch/powerpc/mm/init_64.c                               |    2 
 arch/s390/kvm/kvm-s390.c                                |    4 
 arch/s390/kvm/vsie.c                                    |    6 
 arch/sh/drivers/dma/dma-sh.c                            |   37 -
 arch/sh/kernel/cpu/sh2/probe.c                          |    2 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                  |   36 -
 arch/x86/kernel/smpboot.c                               |   24 
 arch/xtensa/platforms/iss/network.c                     |    2 
 block/partitions/amiga.c                                |  104 ++-
 drivers/base/power/domain.c                             |    6 
 drivers/block/nbd.c                                     |    3 
 drivers/char/hw_random/imx-rngc.c                       |    6 
 drivers/char/hw_random/st-rng.c                         |   24 
 drivers/char/hw_random/virtio-rng.c                     |   88 ++
 drivers/char/tpm/tpm_vtpm_proxy.c                       |   30 
 drivers/clk/clk-cdce925.c                               |   12 
 drivers/clk/keystone/sci-clk.c                          |    2 
 drivers/clk/tegra/clk-emc.c                             |    2 
 drivers/clocksource/timer-cadence-ttc.c                 |   45 -
 drivers/crypto/marvell/cipher.c                         |    2 
 drivers/crypto/nx/Makefile                              |    2 
 drivers/crypto/nx/nx.h                                  |    4 
 drivers/extcon/extcon.c                                 |    8 
 drivers/firmware/stratix10-svc.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                  |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c         |   13 
 drivers/gpu/drm/drm_atomic.c                            |   11 
 drivers/gpu/drm/drm_atomic_helper.c                     |   11 
 drivers/gpu/drm/drm_client_modeset.c                    |    6 
 drivers/gpu/drm/drm_panel.c                             |   14 
 drivers/gpu/drm/i915/intel_uncore.c                     |    3 
 drivers/gpu/drm/panel/panel-arm-versatile.c             |    5 
 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c   |    5 
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c            |    5 
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c           |    5 
 drivers/gpu/drm/panel/panel-innolux-p079zca.c           |    5 
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c          |    5 
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c      |    5 
 drivers/gpu/drm/panel/panel-lg-lb035q02.c               |    5 
 drivers/gpu/drm/panel/panel-lg-lg4573.c                 |    5 
 drivers/gpu/drm/panel/panel-lvds.c                      |    5 
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c            |    5 
 drivers/gpu/drm/panel/panel-novatek-nt39016.c           |    5 
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c      |    5 
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c        |    5 
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c      |    5 
 drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c    |    5 
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c   |    5 
 drivers/gpu/drm/panel/panel-raydium-rm67191.c           |    5 
 drivers/gpu/drm/panel/panel-raydium-rm68200.c           |    5 
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c      |    5 
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c            |    5 
 drivers/gpu/drm/panel/panel-samsung-ld9040.c            |    5 
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c           |    5 
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c           |    5 
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c        |    5 
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c           |    5 
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c           |    5 
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c             |    5 
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c         |    5 
 drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c         |    5 
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c         |    5 
 drivers/gpu/drm/panel/panel-simple.c                    |   33 -
 drivers/gpu/drm/panel/panel-sitronix-st7701.c           |    5 
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c          |    5 
 drivers/gpu/drm/panel/panel-sony-acx565akm.c            |    5 
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c            |    5 
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c            |    5 
 drivers/gpu/drm/panel/panel-tpo-tpg110.c                |    5 
 drivers/gpu/drm/panel/panel-truly-nt35597.c             |    5 
 drivers/gpu/drm/radeon/ci_dpm.c                         |   28 
 drivers/gpu/drm/radeon/cypress_dpm.c                    |    8 
 drivers/gpu/drm/radeon/ni_dpm.c                         |    8 
 drivers/gpu/drm/radeon/rv740_dpm.c                      |    8 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c             |    8 
 drivers/gpu/drm/sun4i/sun4i_tcon.c                      |   19 
 drivers/hid/wacom_wac.c                                 |    6 
 drivers/hid/wacom_wac.h                                 |    2 
 drivers/i2c/busses/i2c-xiic.c                           |   39 -
 drivers/iio/adc/meson_saradc.c                          |    2 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                |    5 
 drivers/infiniband/hw/hfi1/sdma.c                       |    4 
 drivers/infiniband/hw/hfi1/sdma.h                       |   15 
 drivers/input/misc/adxl34x.c                            |    3 
 drivers/input/misc/drv260x.c                            |    1 
 drivers/irqchip/irq-jcore-aic.c                         |   11 
 drivers/mailbox/ti-msgmgr.c                             |   12 
 drivers/md/bcache/btree.c                               |   10 
 drivers/md/bcache/super.c                               |    4 
 drivers/md/md-bitmap.c                                  |   17 
 drivers/md/md.c                                         |   23 
 drivers/md/raid0.c                                      |   62 +
 drivers/md/raid0.h                                      |    1 
 drivers/md/raid10.c                                     |   38 -
 drivers/media/usb/dvb-usb-v2/az6007.c                   |    3 
 drivers/media/usb/siano/smsusb.c                        |    3 
 drivers/memory/brcmstb_dpfe.c                           |    4 
 drivers/memstick/host/r592.c                            |    4 
 drivers/mfd/intel-lpss-acpi.c                           |    3 
 drivers/mfd/rt5033.c                                    |    3 
 drivers/mfd/stmfx.c                                     |    2 
 drivers/mfd/stmpe.c                                     |    4 
 drivers/misc/fastrpc.c                                  |    2 
 drivers/misc/pci_endpoint_test.c                        |   10 
 drivers/mmc/core/quirks.h                               |   14 
 drivers/mmc/host/sdhci.c                                |    4 
 drivers/mtd/nand/raw/meson_nand.c                       |    4 
 drivers/net/ethernet/broadcom/bgmac.c                   |    8 
 drivers/net/ethernet/broadcom/bgmac.h                   |    2 
 drivers/net/ethernet/broadcom/genet/bcmmii.c            |    2 
 drivers/net/ethernet/broadcom/tg3.c                     |    1 
 drivers/net/ethernet/intel/iavf/iavf_main.c             |    5 
 drivers/net/ethernet/intel/igb/igb_main.c               |    5 
 drivers/net/ethernet/intel/igc/igc_ethtool.c            |    2 
 drivers/net/ethernet/intel/igc/igc_main.c               |    1 
 drivers/net/ethernet/marvell/mvneta.c                   |    4 
 drivers/net/ethernet/microchip/lan743x_main.c           |   21 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c         |   57 -
 drivers/net/ethernet/ti/cpsw_ale.c                      |   24 
 drivers/net/gtp.c                                       |    2 
 drivers/net/ipvlan/ipvlan_core.c                        |    9 
 drivers/net/wireless/ath/ath9k/ar9003_hw.c              |   27 
 drivers/net/wireless/ath/ath9k/htc_hst.c                |    8 
 drivers/net/wireless/ath/ath9k/main.c                   |   11 
 drivers/net/wireless/ath/ath9k/wmi.c                    |    4 
 drivers/net/wireless/atmel/atmel_cs.c                   |   13 
 drivers/net/wireless/cisco/airo.c                       |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c            |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c            |    2 
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c      |   13 
 drivers/net/wireless/intersil/orinoco/spectrum_cs.c     |   13 
 drivers/net/wireless/marvell/mwifiex/scan.c             |    6 
 drivers/net/wireless/ray_cs.c                           |   36 -
 drivers/net/wireless/rsi/rsi_91x_sdio.c                 |    3 
 drivers/net/wireless/wl3501_cs.c                        |   51 -
 drivers/ntb/hw/amd/ntb_hw_amd.c                         |    7 
 drivers/ntb/hw/idt/ntb_hw_idt.c                         |    7 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                      |    7 
 drivers/ntb/ntb_transport.c                             |    2 
 drivers/ntb/test/ntb_tool.c                             |    2 
 drivers/pci/controller/dwc/pcie-qcom.c                  |    2 
 drivers/pci/controller/pci-ftpci100.c                   |   14 
 drivers/pci/controller/pcie-rockchip-ep.c               |   65 --
 drivers/pci/controller/pcie-rockchip.c                  |   17 
 drivers/pci/controller/pcie-rockchip.h                  |   11 
 drivers/pci/hotplug/pciehp_ctrl.c                       |    8 
 drivers/pci/pci.c                                       |   10 
 drivers/pci/pcie/aspm.c                                 |   21 
 drivers/pci/quirks.c                                    |    2 
 drivers/pinctrl/intel/pinctrl-cherryview.c              |   15 
 drivers/pinctrl/pinctrl-amd.c                           |   41 -
 drivers/pinctrl/pinctrl-amd.h                           |    1 
 drivers/pinctrl/pinctrl-at91-pio4.c                     |    2 
 drivers/platform/x86/wmi.c                              |   81 +-
 drivers/powercap/Kconfig                                |    4 
 drivers/powercap/intel_rapl_msr.c                       |    1 
 drivers/pwm/pwm-imx-tpm.c                               |    7 
 drivers/pwm/sysfs.c                                     |   17 
 drivers/regulator/core.c                                |   30 
 drivers/rtc/rtc-st-lpc.c                                |    2 
 drivers/scsi/3w-xxxx.c                                  |    4 
 drivers/scsi/qedf/qedf_main.c                           |    3 
 drivers/scsi/qla2xxx/qla_attr.c                         |   13 
 drivers/scsi/qla2xxx/qla_bsg.c                          |    6 
 drivers/scsi/qla2xxx/qla_def.h                          |    1 
 drivers/scsi/qla2xxx/qla_inline.h                       |    5 
 drivers/scsi/qla2xxx/qla_iocb.c                         |    5 
 drivers/scsi/qla2xxx/qla_nvme.c                         |    3 
 drivers/soc/fsl/qe/Kconfig                              |    1 
 drivers/spi/spi-bcm-qspi.c                              |   10 
 drivers/spi/spi-bcm63xx.c                               |    2 
 drivers/spi/spi-geni-qcom.c                             |    2 
 drivers/tty/serial/8250/8250.h                          |    1 
 drivers/tty/serial/8250/8250_omap.c                     |   20 
 drivers/tty/serial/8250/8250_pci.c                      |   19 
 drivers/tty/serial/8250/8250_port.c                     |   11 
 drivers/tty/serial/atmel_serial.c                       |    4 
 drivers/tty/serial/fsl_lpuart.c                         |    1 
 drivers/tty/serial/samsung.c                            |   14 
 drivers/usb/core/devio.c                                |    2 
 drivers/usb/dwc3/dwc3-qcom.c                            |   12 
 drivers/usb/dwc3/gadget.c                               |    4 
 drivers/usb/phy/phy-tahvo.c                             |    2 
 drivers/usb/serial/option.c                             |    4 
 drivers/video/fbdev/au1200fb.c                          |    3 
 drivers/video/fbdev/imsttfb.c                           |   36 -
 drivers/video/fbdev/imxfb.c                             |    4 
 drivers/video/fbdev/omap/lcd_mipid.c                    |    6 
 drivers/w1/w1.c                                         |    4 
 fs/btrfs/qgroup.c                                       |    3 
 fs/ceph/caps.c                                          |    9 
 fs/dlm/plock.c                                          |    4 
 fs/erofs/zdata.c                                        |    2 
 fs/erofs/zmap.c                                         |    6 
 fs/ext4/indirect.c                                      |    8 
 fs/ext4/inode.c                                         |   10 
 fs/ext4/mballoc.c                                       |    4 
 fs/ext4/namei.c                                         |   17 
 fs/ext4/xattr.c                                         |   14 
 fs/f2fs/namei.c                                         |   16 
 fs/f2fs/node.c                                          |    4 
 fs/fs_context.c                                         |    3 
 fs/fuse/dir.c                                           |    2 
 fs/gfs2/super.c                                         |    8 
 fs/inode.c                                              |   42 +
 fs/internal.h                                           |    2 
 fs/jffs2/build.c                                        |    5 
 fs/jffs2/xattr.c                                        |   13 
 fs/jffs2/xattr.h                                        |    4 
 fs/jfs/jfs_dmap.c                                       |    6 
 fs/jfs/jfs_filsys.h                                     |    2 
 fs/namei.c                                              |   25 
 fs/nfs/nfs4proc.c                                       |    1 
 fs/nfsd/nfs4xdr.c                                       |    2 
 fs/notify/fanotify/fanotify_user.c                      |   22 
 fs/pstore/ram_core.c                                    |    2 
 include/drm/drm_panel.h                                 |   13 
 include/linux/etherdevice.h                             |   12 
 include/linux/netdevice.h                               |   18 
 include/linux/netfilter/nfnetlink.h                     |   27 
 include/linux/nmi.h                                     |    2 
 include/linux/pci.h                                     |    1 
 include/linux/sched/signal.h                            |    2 
 include/linux/serial_8250.h                             |    1 
 include/linux/tcp.h                                     |    2 
 include/linux/workqueue.h                               |   15 
 include/net/netfilter/nf_tables.h                       |   14 
 include/net/netns/nftables.h                            |    6 
 include/net/nfc/nfc.h                                   |    4 
 include/net/pkt_sched.h                                 |    2 
 include/net/sock.h                                      |    1 
 include/net/tcp.h                                       |    7 
 include/trace/events/timer.h                            |    6 
 include/uapi/linux/affs_hardblocks.h                    |   68 +-
 include/uapi/linux/videodev2.h                          |    2 
 kernel/bpf/bpf_lru_list.c                               |   21 
 kernel/bpf/bpf_lru_list.h                               |    7 
 kernel/kexec_core.c                                     |    5 
 kernel/sched/fair.c                                     |    2 
 kernel/time/posix-timers.c                              |   31 
 kernel/trace/ring_buffer.c                              |   24 
 kernel/trace/trace.c                                    |    2 
 kernel/trace/trace_events_hist.c                        |    9 
 kernel/trace/trace_probe_tmpl.h                         |    2 
 kernel/watchdog_hld.c                                   |    6 
 kernel/workqueue.c                                      |   13 
 lib/debugobjects.c                                      |    9 
 lib/ts_bm.c                                             |    4 
 net/bridge/br_if.c                                      |    5 
 net/can/bcm.c                                           |   12 
 net/core/devlink.c                                      |    5 
 net/core/rtnetlink.c                                    |  104 +--
 net/core/sock.c                                         |   17 
 net/dsa/tag_sja1105.c                                   |    4 
 net/ipv4/inet_hashtables.c                              |   17 
 net/ipv4/inet_timewait_sock.c                           |    8 
 net/ipv4/tcp.c                                          |   31 
 net/ipv4/tcp_fastopen.c                                 |    6 
 net/ipv4/tcp_input.c                                    |   12 
 net/ipv6/addrconf.c                                     |    3 
 net/ipv6/icmp.c                                         |    5 
 net/ipv6/ip6_gre.c                                      |    3 
 net/ipv6/udp.c                                          |    2 
 net/llc/llc_input.c                                     |    3 
 net/netfilter/ipset/ip_set_core.c                       |   17 
 net/netfilter/nf_conntrack_helper.c                     |    4 
 net/netfilter/nf_conntrack_netlink.c                    |   77 --
 net/netfilter/nf_conntrack_proto_dccp.c                 |   52 +
 net/netfilter/nf_conntrack_sip.c                        |    2 
 net/netfilter/nf_tables_api.c                           |  513 +++++++++-------
 net/netfilter/nf_tables_offload.c                       |   29 
 net/netfilter/nf_tables_trace.c                         |    9 
 net/netfilter/nfnetlink_acct.c                          |   11 
 net/netfilter/nfnetlink_cthelper.c                      |   11 
 net/netfilter/nfnetlink_cttimeout.c                     |   22 
 net/netfilter/nfnetlink_log.c                           |   11 
 net/netfilter/nfnetlink_queue.c                         |   12 
 net/netfilter/nft_byteorder.c                           |   14 
 net/netfilter/nft_chain_filter.c                        |   11 
 net/netfilter/nft_compat.c                              |   11 
 net/netfilter/nft_dynset.c                              |    6 
 net/netlink/af_netlink.c                                |    5 
 net/netlink/diag.c                                      |    7 
 net/nfc/core.c                                          |    4 
 net/nfc/hci/llc_shdlc.c                                 |   10 
 net/nfc/llcp.h                                          |    9 
 net/nfc/llcp_commands.c                                 |   59 +
 net/nfc/llcp_core.c                                     |   93 ++
 net/nfc/llcp_sock.c                                     |   21 
 net/nfc/netlink.c                                       |   20 
 net/nfc/nfc.h                                           |    3 
 net/sched/act_pedit.c                                   |    1 
 net/sched/cls_flower.c                                  |   36 -
 net/sched/cls_fw.c                                      |   10 
 net/sctp/socket.c                                       |    4 
 net/sunrpc/svcsock.c                                    |   27 
 net/wireless/scan.c                                     |  213 +++---
 net/wireless/wext-core.c                                |    6 
 net/xdp/xsk.c                                           |    5 
 samples/bpf/tcp_basertt_kern.c                          |    2 
 scripts/mod/modpost.c                                   |   26 
 scripts/tags.sh                                         |    9 
 security/integrity/evm/evm_main.c                       |    2 
 security/integrity/iint.c                               |   15 
 security/integrity/ima/ima_modsig.c                     |    3 
 security/integrity/ima/ima_policy.c                     |    3 
 sound/core/jack.c                                       |   15 
 sound/pci/ac97/ac97_codec.c                             |    4 
 sound/soc/codecs/es8316.c                               |   23 
 sound/soc/fsl/imx-audmix.c                              |    9 
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh |   77 ++
 tools/perf/util/dwarf-aux.c                             |    2 
 tools/testing/selftests/net/rtnetlink.sh                |    1 
 tools/testing/selftests/tc-testing/settings             |    1 
 333 files changed, 3025 insertions(+), 1725 deletions(-)

Ahmed S. Darwish (1):
      scripts/tags.sh: Resolve gtags empty index generation

Alex Dewar (1):
      wl3501_cs: Remove unnecessary NULL check

Alexander Aring (1):
      fs: dlm: return positive pid value for F_GETLK

Amelie Delaunay (1):
      mfd: stmfx: Fix error path in stmfx_chip_init

Amir Goldstein (1):
      fanotify: disallow mount/sb marks on kernel internal pseudo fs

Andy Shevchenko (8):
      wifi: ray_cs: Utilize strnlen() in parse_addr()
      wifi: ray_cs: Drop useless status variable in parse_addr()
      pinctrl: cherryview: Return correct value if pin in push-pull mode
      extcon: Fix kernel doc of property fields to avoid warnings
      extcon: Fix kernel doc of property capability fields to avoid warnings
      platform/x86: wmi: Replace UUID redefinitions by their originals
      platform/x86: wmi: Fix indentation in some cases
      platform/x86: wmi: Break possible infinite loop when parsing GUID

Aneesh Kumar K.V (1):
      powerpc/mm/dax: Fix the condition when checking if altmap vmemap can cross-boundary

Arnd Bergmann (6):
      ARM: 9303/1: kprobes: avoid missing-declaration warnings
      memstick r592: make memstick_debug_get_tpc_name() static
      ARM: ep93xx: fix missing-prototype warnings
      crypto: marvell/cesa - Fix type mismatch warning
      usb: hide unused usbfs_notify_suspend/resume functions
      ARM: orion5x: fix d2net gpio initialization

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix unaligned DMA buffers handling

Artur Rojek (1):
      sh: dma: Fix DMA channel offset calculation

Baokun Li (1):
      ext4: only update i_reserved_data_blocks on successful block allocation

Barnabás Pőcze (3):
      platform/x86: wmi: remove unnecessary argument
      platform/x86: wmi: use guid_t and guid_equal()
      platform/x86: wmi: move variables

Bas Nieuwenhuizen (1):
      drm/amdgpu: Validate VM ioctl flags.

Benjamin Berg (1):
      wifi: cfg80211: rewrite merging of inherited elements

Bikash Hazarika (2):
      scsi: qla2xxx: Fix potential NULL pointer dereference
      scsi: qla2xxx: Correct the index of array

Bob Peterson (1):
      gfs2: Don't deref jdesc in evict

Brian Norris (2):
      drm/atomic: Allow vblank-enabled + self-refresh "disable"
      drm/rockchip: vop: Leave vblank enabled in self-refresh

Cambda Zhu (2):
      ipvlan: Fix return value of ipvlan_queue_xmit()
      net: Replace the limit of TCP_LINGER2 with TCP_FIN_TIMEOUT_MAX

Chao Yu (1):
      f2fs: fix error path handling in truncate_dnode()

Chengfeng Ye (1):
      sctp: fix potential deadlock on &net->sctp.addr_wq_lock

Chevron Li (1):
      mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.

Chris Wilson (1):
      drm/i915: Initialise outparam for error return from wait_for_register

Christophe JAILLET (13):
      wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()
      wifi: orinoco: Fix an error handling path in spectrum_cs_probe()
      wifi: orinoco: Fix an error handling path in orinoco_cs_probe()
      wifi: atmel: Fix an error handling path in atmel_probe()
      wifi: wl3501_cs: Fix an error handling path in wl3501_probe()
      wifi: ray_cs: Fix an error handling path in ray_probe()
      fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()
      usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
      mfd: stmpe: Only disable the regulators if they are enabled
      rtc: st-lpc: Release some resources in st_rtc_probe() in case of error
      firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk

Chunhai Guo (1):
      erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

Claudiu Beznea (4):
      clk: cdce925: check return value of kasprintf()
      clk: keystone: sci-clk: check return value of kasprintf()
      ASoC: imx-audmix: check return value of devm_kasprintf()
      pinctrl: at91-pio4: check return value of devm_kasprintf()

Cristian Ciocaltea (2):
      ASoC: es8316: Increment max value for ALC Capture Target Volume control
      ASoC: es8316: Do not set rate constraints for unsupported MCLKs

Dai Ngo (1):
      NFSD: add encoding of op_recall flag for write delegation

Damien Le Moal (3):
      PCI: rockchip: Set address alignment for endpoint mode
      misc: pci_endpoint_test: Free IRQs before removing the device
      misc: pci_endpoint_test: Re-init completion for every test

Dan Carpenter (4):
      modpost: fix off by one in is_executable_section()
      w1: fix loop in w1_fini()
      scsi: qla2xxx: Fix error code in qla2x00_start_sp()
      serial: atmel: don't enable IRQs prematurely

Daniel Vetter (1):
      drm/atomic: Fix potential use-after-free in nonblocking commits

Daniil Dulov (2):
      drm/amdkfd: Fix potential deallocation of previously deallocated memory.
      media: usb: Check az6007_read() return value

Dario Binacchi (1):
      drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H

Davide Tronchin (1):
      USB: serial: option: add LARA-R6 01B PIDs

Ding Hui (3):
      PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free
      SUNRPC: Fix UAF in svc_tcp_listen_data_ready()
      iavf: Fix use-after-free in free_netdev

Dmitry Antipov (1):
      wifi: ath9k: convert msecs to jiffies where needed

Douglas Anderson (2):
      watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config
      watchdog/perf: more properly prevent false positives with turbo modes

Duoming Zhou (1):
      media: usb: siano: Fix warning due to null work_func_t function pointer

Edwin Peer (1):
      rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO

Ekansh Gupta (1):
      misc: fastrpc: Create fastrpc scalar with correct buffer count

Eric Dumazet (9):
      netlink: fix potential deadlock in netlink_set_err()
      netlink: do not hard code device address lenth in fdb dumps
      tcp: annotate data races in __tcp_oow_rate_limited()
      udp6: fix udp6_ehashfn() typo
      tcp: annotate data-races around tp->tcp_tx_delay
      tcp: annotate data-races around tp->linger2
      tcp: annotate data-races around rskq_defer_accept
      tcp: annotate data-races around tp->notsent_lowat
      tcp: annotate data-races around fastopenq.max_qlen

Eric Whitney (1):
      ext4: correct inline offset when handling xattrs in inode body

Fabian Frederick (1):
      jffs2: reduce stack usage in jffs2_build_xattr_subsystem()

Fabio Estevam (1):
      drm/panel: simple: Add connector_type for innolux_at043tn24

Fancy Fang (1):
      pwm: imx-tpm: force 'real_period' to be zero in suspend

Fedor Pchelkin (2):
      wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx
      wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Feng Mingxi (1):
      clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe

Filipe Manana (2):
      btrfs: fix race when deleting quota root from the dirty cow roots list
      btrfs: fix warning when putting transaction with qgroups enabled after abort

Florent Revest (1):
      netfilter: conntrack: Avoid nf_ct_helper_hash uses after free

Florian Fainelli (1):
      net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Florian Westphal (7):
      netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one
      netfilter: nf_tables: fix nat hook table deletion
      netfilter: nf_tables: use net_generic infra for transaction data
      netfilter: nf_tables: add rescheduling points during loop detection walks
      netfilter: nf_tables: fix scheduling-while-atomic splat
      netfilter: nf_tables: fix spurious set element insertion failure
      netfilter: nf_tables: can't schedule in nft_chain_validate

Gao Xiang (1):
      erofs: fix compact 4B support for 16k block size

Geert Uytterhoeven (2):
      regulator: core: Fix more error checking for debugfs_create_dir()
      regulator: core: Streamline debugfs operations

Georg Müller (1):
      perf probe: Add test for regression introduced by switch to die_get_decl_file()

George Stark (1):
      meson saradc: fix clock divider mask length

Greg Kroah-Hartman (2):
      video: imsttfb: check for ioremap() failures
      Linux 5.4.251

Guillaume Nault (1):
      cls_flower: Add extack support for src and dst port range options

Gustavo A. R. Silva (1):
      wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Herbert Xu (2):
      hwrng: virtio - Fix race on data_avail and actual data
      hwrng: st - Fix W=1 unused variable warning

Ido Schimmel (1):
      net/sched: flower: Ensure both minimum and maximum ports are specified

Ilia.Gavrilov (1):
      netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Ilya Maximets (1):
      xsk: Honor SO_BINDTODEVICE on bind

Jakub Kicinski (2):
      net: create netdev->dev_addr assignment helpers
      wl3501_cs: use eth_hw_addr_set()

James Morse (1):
      x86/resctrl: Use is_closid_match() in more places

Jan Kara (5):
      ext4: Remove ext4 locking of moved directory
      Revert "f2fs: fix potential corruption when moving a directory"
      fs: Establish locking order for unrelated directories
      fs: Lock moved directories
      fs: no need to check source

Jarkko Sakkinen (1):
      tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Jason Baron (1):
      md/raid0: add discard support for the 'original' layout

Jason Gerecke (1):
      HID: wacom: Use ktime_t rather than int when dealing with timestamps

Jeremy Sowden (1):
      lib/ts_bm: reset initial match offset for every block of text

Jiaqing Zhao (1):
      Revert "8250: add support for ASIX devices with a FIFO bug"

Jiasheng Jiang (3):
      pstore/ram: Add check for kstrdup
      mfd: intel-lpss: Add missing check for platform_get_resource
      NTB: ntb_tool: Add check for devm_kcalloc

Jinhong Zhu (1):
      scsi: qedf: Fix NULL dereference in error handling

Jocelyn Falempe (2):
      drm/client: Fix memory leak in drm_client_target_cloned
      drm/client: Fix memory leak in drm_client_modeset_probe

Johannes Berg (2):
      wifi: iwlwifi: pull from TXQs with softirqs disabled
      wifi: iwlwifi: mvm: avoid baid size integer overflow

John Paul Adrian Glaubitz (2):
      irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
      sh: j2: Use ioremap() to translate device tree address into kernel memory

Jonas Gorski (2):
      spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
      spi: bcm63xx: fix max prepend length

Junyan Ye (1):
      PCI: ftpci100: Release the clock resources

Kalesh AP (1):
      RDMA/bnxt_re: Fix to remove an unnecessary log

Kemeng Shi (1):
      ext4: fix wrong unit use in ext4_mb_clear_bb

Klaus Kudielka (1):
      net: mvneta: fix txq_map in case of txq_number==1

Krishna Kurapati (1):
      usb: dwc3: gadget: Propagate core init errors to UDC during pullup

Krzysztof Kozlowski (5):
      nfc: constify several pointers to u8, char and sk_buff
      nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()
      nfc: llcp: simplify llcp_sock_connect() error paths
      arm64: dts: qcom: msm8916: correct camss unit address
      memory: brcmstb_dpfe: fix testing array offset after use

Kuniyuki Iwashima (5):
      gtp: Fix use-after-free in __gtp_encap_destroy().
      netlink: Add __sock_i_ino() for __netlink_diag_dump().
      icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().
      Revert "tcp: avoid the lookup process failing to get sk in ehash table"
      llc: Don't drop packet from non-root netns.

Laurent Pinchart (2):
      drm/panel: Initialise panel dev and funcs through drm_panel_init()
      drm/panel: Add and fill drm_panel type field

Laurent Vivier (4):
      hwrng: virtio - add an internal buffer
      hwrng: virtio - don't wait on cleanup
      hwrng: virtio - don't waste entropy
      hwrng: virtio - always add a pending request

Lee Jones (2):
      wl3501_cs: Fix a bunch of formatting issues related to function docs
      wl3501_cs: Fix misspelling and provide missing documentation

Li Nan (5):
      md/raid10: check slab-out-of-bounds in md_bitmap_get_counter
      md/raid10: fix overflow of md/safe_mode_delay
      md/raid10: fix wrong setting of max_corr_read_errors
      md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request
      md/raid10: fix io loss while replacement replace rdev

Li Yang (1):
      usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()

Lin Ma (2):
      net: nfc: Fix use-after-free caused by nfc_llcp_find_local
      net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX

Linus Torvalds (1):
      workqueue: clean up WORK_* constant types, clarify masking

Luca Weiss (1):
      Input: drv260x - sleep between polling GO bit

M A Ramdhan (1):
      net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Magnus Karlsson (1):
      xsk: Improve documentation for AF_XDP

Manish Rangankar (1):
      scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue

Manivannan Sadhasivam (1):
      PCI: qcom: Disable write access to read only registers for IP v2.3.3

Marc Zyngier (1):
      irqchip/jcore-aic: Kill use of irq_create_strict_mappings()

Marek Vasut (5):
      wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown
      Input: adxl34x - do not hardcode interrupt trigger type
      media: videodev2.h: Fix struct v4l2_input tuner index comment
      pwm: sysfs: Do not apply state to already disabled PWMs
      i2c: xiic: Defer xiic_wakeup() and __xiic_start_xfer() in xiic_process()

Mario Limonciello (4):
      pinctrl: amd: Fix mistake in handling clearing pins at startup
      pinctrl: amd: Detect internal GPIO0 debounce handling
      pinctrl: amd: Only use special debounce behavior for GPIO 0
      pinctrl: amd: Use amd_pinconf_set() for all config options

Mark Rutland (1):
      arm64: mm: fix VA-range sanity check

Martin KaFai Lau (1):
      bpf: Address KCSAN report on bpf_lru_list

Martin Kaiser (3):
      hwrng: st - keep clock enabled while hwrng is registered
      hwrng: imx-rngc - fix the timeout for init and self check
      fbdev: imxfb: warn about invalid left/right margin

Masahiro Yamada (3):
      modpost: fix section mismatch message for R_ARM_ABS32
      modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
      ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard

Masami Hiramatsu (Google) (1):
      tracing/probes: Fix not to count error code to total length

Mateusz Stachyra (1):
      tracing: Fix null pointer dereference in tracing_err_log_open()

Matthieu Baerts (1):
      selftests: tc: set timeout to 15 minutes

Max Filippov (1):
      xtensa: ISS: fix call to split_if_spec

Michael Schmitz (4):
      block: fix signed int overflow in Amiga partition support
      block: change all __u32 annotations to __be32 in affs_hardblocks.h
      block: add overflow checks for Amiga partition support
      block/partition: fix signedness issue for Amiga partitions

Miklos Szeredi (1):
      fuse: revalidate: don't invalidate if interrupted

Mohamed Khalfella (2):
      tracing/histograms: Add histograms to hist_vars if they have referenced variables
      tracing/histograms: Return an error if we fail to add histogram to hist_vars list

Moritz Fischer (1):
      net: lan743x: Don't sleep in atomic context

Muhammad Husaini Zulkifli (1):
      igc: Remove delay during TX ring configuration

Namhyung Kim (1):
      perf dwarf-aux: Fix off-by-one in die_get_varname()

Naveen N Rao (1):
      powerpc: Fail build if using recordmcount with binutils v2.37

Nico Boehr (1):
      KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes

Nikita Zhandarovich (3):
      PM: domains: fix integer overflow issues in genpd_parse_state()
      radeon: avoid double free in ci_dpm_init()
      drm/radeon: fix possible division-by-zero errors

Nilesh Javali (1):
      scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()

Nishanth Menon (1):
      mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0

Nitya Sunkad (1):
      ionic: remove WARN_ON to prevent panic_on_warn

Olga Kornievskaia (1):
      NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION

Ondrej Zary (1):
      PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

Pablo Neira Ayuso (6):
      netfilter: nftables: add helper function to set the base sequence number
      netfilter: add helper function to set up the nfnetlink header and use it
      netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE
      netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
      netfilter: nf_tables: reject unbound anonymous set before commit phase
      netfilter: nf_tables: unbind non-anonymous set if rule construction fails

Patrick Kelsey (1):
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors

Pedro Tammela (1):
      net/sched: make psched_mtu() RTNL-less safe

Pengcheng Yang (1):
      samples/bpf: Fix buffer overflow in tcp_basertt

Peter Seiderer (1):
      wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Petr Oros (1):
      devlink: report devlink_port_type_warn source device

Pierre Morel (1):
      KVM: s390: vsie: fix the length of APCB bitmap

Prasad Koya (1):
      igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings

Quinn Tran (1):
      scsi: qla2xxx: Wait for io return on terminate rport

Rafał Miłecki (2):
      bgmac: fix *initial* chip reset to support BCM5358
      ARM: dts: BCM5301X: Drop "clock-names" from the SPI node

Rajan Vaja (1):
      clocksource/drivers/cadence-ttc: Use ttc driver as platform driver

Randy Dunlap (4):
      soc/fsl/qe: fix usb.c build errors
      crypto: nx - fix build warnings when DEBUG_FS is not enabled
      powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y
      wifi: airo: avoid uninitialized warning in airo_get_rate()

Remi Pommarel (1):
      wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()

Rick Wertenbroek (5):
      PCI: rockchip: Assert PCI Configuration Enable bit after probe
      PCI: rockchip: Write PCI Device ID to correct register
      PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
      PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
      PCI: rockchip: Use u32 variable to access 32-bit registers

Robert Hancock (1):
      i2c: xiic: Don't try to handle more interrupt events after error

Robert Marko (2):
      mmc: core: disable TRIM on Kingston EMMC04G-M627
      mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M

Roberto Sassu (2):
      evm: Complete description of evm_inode_setattr()
      ima: Fix build warnings

Robin Murphy (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Rongguang Wei (1):
      PCI: pciehp: Cancel bringup sequence if card is not present

Sabrina Dubroca (1):
      selftests: rtnetlink: remove netdevsim device after ipsec offload test

Sebastian Andrzej Siewior (1):
      tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().

Shannon Nelson (4):
      ionic: improve irq numa locality
      ionic: clean irq affinity on queue deinit
      ionic: move irq request to qcq alloc
      ionic: ionic_intr_free parameter change

Shawn Wang (1):
      x86/resctrl: Only show tasks' pid in current pid namespace

Sherry Sun (1):
      tty: serial: fsl_lpuart: add earlycon for imx8ulp platform

Shreyas Deodhar (1):
      scsi: qla2xxx: Pointer may be dereferenced

Siddh Raman Pant (1):
      jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Stephan Gerhold (1):
      mfd: rt5033: Drop rt5033-battery sub-device

Su Hui (1):
      ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Sui Jingfeng (1):
      PCI: Add pci_clear_master() stub for non-CONFIG_PCI

Takashi Iwai (1):
      ALSA: jack: Fix mutex call in snd_jack_report()

Tanmay Patil (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()

Tetsuo Handa (1):
      debugobjects: Recheck debug_objects_enabled before reporting

Thadeu Lima de Souza Cascardo (1):
      netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Thomas Gleixner (2):
      x86/smp: Use dedicated cache-line for mwait_play_dead()
      posix-timers: Ensure timer ID search-loop limit is valid

Thomas Weißschuh (1):
      fs: avoid empty option when generating legacy mount string

Tianjia Zhang (1):
      integrity: Fix possible multiple allocation in integrity_inode_get()

Tobias Heider (1):
      Add MODULE_FIRMWARE() for FIRMWARE_TG357766.

Tony Lindgren (2):
      ARM: dts: gta04: Move model property out of pinctrl node
      serial: 8250_omap: Use force_suspend and resume for system suspend

Vijaya Krishna Nivarthi (1):
      spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG

Vladimir Oltean (2):
      net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
      net: dsa: tag_sja1105: fix MAC DA patching from meta frames

Vladislav Efanov (1):
      usb: dwc3: qcom: Fix potential memory leak

Wolfram Sang (1):
      arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1

Xiubo Li (1):
      ceph: don't let check_caps skip sending responses for revoke msgs

XuDong Liu (1):
      drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`

Yang Yingliang (1):
      NTB: ntb_transport: fix possible memory leak while device_register() fails

Yicong Yang (1):
      sched/fair: Don't balance task to its current running CPU

Ying Hsu (1):
      igb: Fix igb_down hung on surprise removal

Yu Kuai (2):
      md: fix data corruption for raid456 when reshape restart while grow up
      md/raid10: prevent soft lockup while flush writes

Yuan Can (4):
      clk: tegra: tegra124-emc: Fix potential memory leak
      ntb: idt: Fix error handling in idt_pci_driver_init()
      NTB: amd: Fix error handling in amd_ntb_pci_driver_init()
      ntb: intel: Fix error handling in intel_ntb_pci_driver_init()

Yuanjun Gong (1):
      net:ipv6: check return value of pskb_trim()

Yuchen Yang (1):
      scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()

YueHaibing (1):
      can: bcm: Fix UAF in bcm_proc_show()

Zhang Rui (1):
      powercap: RAPL: Fix CONFIG_IOSF_MBI dependency

Zhang Shurong (1):
      fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe

Zhen Lei (1):
      kexec: fix a memory leak in crash_shrink_memory()

Zheng Wang (2):
      fbdev: imsttfb: Fix use after free bug in imsttfb_probe
      bcache: Remove unnecessary NULL point check in node allocations

Zheng Yejian (1):
      ring-buffer: Fix deadloop issue on reading trace_pipe

Zhong Jinghua (1):
      nbd: Add the maximum limit of allocated index in nbd_dev_add

Ziyang Xuan (1):
      ipv6/addrconf: fix a potential refcount underflow for idev

