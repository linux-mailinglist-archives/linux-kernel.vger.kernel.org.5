Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2270E7F105E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjKTK2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjKTK21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:28:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34759113;
        Mon, 20 Nov 2023 02:28:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337C7C433C8;
        Mon, 20 Nov 2023 10:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700476096;
        bh=1McKmsB9Kpm10pfn37+9nqFZspiP3ydAtHIn7FBgrIc=;
        h=From:To:Cc:Subject:Date:From;
        b=YksYfgGTr12TGd+ttSd/QUlWHj7trRsQbjIZvX29zEU42/w8tlCm4XN2e52Ey9Iqr
         qQ1RR71C55h/mTCwow12rPWjIbjT53JtgtJUDqA9ADLDRXo26CSl6yYi4BYaIbPttA
         K0vQvkkybejTgUWFtExL3gRKdJFnS91BCMUIM42M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.201
Date:   Mon, 20 Nov 2023 11:28:06 +0100
Message-ID: <2023112007-planner-numeric-4b98@gregkh>
X-Mailer: git-send-email 2.42.1
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

I'm announcing the release of the 5.10.201 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/process/deprecated.rst                            |   20 
 Makefile                                                        |    2 
 arch/arm/boot/dts/qcom-mdm9615.dtsi                             |   14 
 arch/arm/lib/memset.S                                           |    1 
 arch/arm/xen/enlighten.c                                        |   25 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                           |    2 
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                         |    2 
 arch/powerpc/include/asm/nohash/32/pte-40x.h                    |    3 
 arch/powerpc/perf/imc-pmu.c                                     |    2 
 arch/powerpc/platforms/pseries/lpar.c                           |    4 
 arch/powerpc/sysdev/xive/native.c                               |    2 
 arch/sh/Kconfig.debug                                           |   11 
 arch/x86/events/intel/pt.c                                      |   14 
 arch/x86/include/asm/page.h                                     |   10 
 arch/x86/include/asm/uaccess.h                                  |    2 
 arch/x86/kernel/cpu/bugs.c                                      |    2 
 arch/x86/kernel/head64.c                                        |    2 
 arch/x86/kvm/emulate.c                                          |    4 
 arch/x86/kvm/x86.c                                              |    2 
 arch/x86/kvm/x86.h                                              |    7 
 arch/x86/lib/copy_mc.c                                          |    8 
 arch/x86/mm/maccess.c                                           |   24 
 drivers/acpi/device_sysfs.c                                     |   10 
 drivers/base/regmap/regmap-debugfs.c                            |    2 
 drivers/base/regmap/regmap.c                                    |   16 
 drivers/char/hw_random/geode-rng.c                              |    6 
 drivers/clk/clk-asm9260.c                                       |   29 -
 drivers/clk/clk-npcm7xx.c                                       |    2 
 drivers/clk/clk-scmi.c                                          |    1 
 drivers/clk/imx/Kconfig                                         |    1 
 drivers/clk/imx/clk-imx8mq.c                                    |   17 
 drivers/clk/keystone/pll.c                                      |   15 
 drivers/clk/mediatek/clk-mt2701.c                               |    8 
 drivers/clk/mediatek/clk-mt6765.c                               |    6 
 drivers/clk/mediatek/clk-mt6779.c                               |    4 
 drivers/clk/mediatek/clk-mt6797.c                               |    6 
 drivers/clk/mediatek/clk-mt7629-eth.c                           |    4 
 drivers/clk/mediatek/clk-mt7629.c                               |    6 
 drivers/clk/qcom/Kconfig                                        |    1 
 drivers/clk/qcom/clk-rcg2.c                                     |   14 
 drivers/clk/qcom/gcc-sm8150.c                                   |   98 +--
 drivers/clk/qcom/mmcc-msm8998.c                                 |   17 
 drivers/clk/ti/apll.c                                           |   13 
 drivers/clk/ti/autoidle.c                                       |    2 
 drivers/clk/ti/clk-dra7-atl.c                                   |    6 
 drivers/clk/ti/clk.c                                            |   52 +-
 drivers/clk/ti/clkctrl.c                                        |    4 
 drivers/clk/ti/clock.h                                          |   11 
 drivers/clk/ti/clockdomain.c                                    |    2 
 drivers/clk/ti/composite.c                                      |    6 
 drivers/clk/ti/divider.c                                        |   12 
 drivers/clk/ti/dpll.c                                           |   10 
 drivers/clk/ti/fapll.c                                          |   11 
 drivers/clk/ti/fixed-factor.c                                   |    4 
 drivers/clk/ti/gate.c                                           |    8 
 drivers/clk/ti/interface.c                                      |    9 
 drivers/clk/ti/mux.c                                            |    8 
 drivers/crypto/caam/caamalg.c                                   |    3 
 drivers/crypto/caam/caamalg_qi2.c                               |    3 
 drivers/crypto/hisilicon/hpre/hpre_main.c                       |    2 
 drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c                |   34 +
 drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h                |    1 
 drivers/crypto/qat/qat_c3xxx/adf_drv.c                          |    6 
 drivers/crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c            |    4 
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c                        |    4 
 drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c                  |   34 +
 drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h                  |    1 
 drivers/crypto/qat/qat_c62x/adf_drv.c                           |    6 
 drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c              |    4 
 drivers/crypto/qat/qat_c62xvf/adf_drv.c                         |    4 
 drivers/crypto/qat/qat_common/adf_accel_devices.h               |    7 
 drivers/crypto/qat/qat_common/adf_transport_debug.c             |    4 
 drivers/crypto/qat/qat_common/qat_hal.c                         |   27 -
 drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c          |   20 
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c                       |    4 
 drivers/crypto/qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c      |    4 
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c                     |    4 
 drivers/devfreq/event/rockchip-dfi.c                            |   15 
 drivers/dma/pxa_dma.c                                           |    1 
 drivers/dma/ti/edma.c                                           |    4 
 drivers/firmware/ti_sci.c                                       |   46 -
 drivers/gpu/drm/bridge/tc358768.c                               |   25 
 drivers/gpu/drm/drm_syncobj.c                                   |    3 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                         |    3 
 drivers/gpu/drm/radeon/evergreen.c                              |    7 
 drivers/gpu/drm/rockchip/cdn-dp-core.c                          |   15 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                     |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                     |    8 
 drivers/hid/hid-cp2112.c                                        |    9 
 drivers/hid/hid-logitech-hidpp.c                                |   76 +-
 drivers/hwmon/axi-fan-control.c                                 |  101 +++
 drivers/hwmon/coretemp.c                                        |    2 
 drivers/i3c/master.c                                            |    4 
 drivers/infiniband/hw/hfi1/efivar.c                             |    2 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                      |    2 
 drivers/infiniband/hw/hns/hns_roce_qp.c                         |    2 
 drivers/infiniband/hw/mlx5/qp.c                                 |   27 +
 drivers/input/rmi4/rmi_bus.c                                    |    2 
 drivers/interconnect/qcom/sc7180.c                              |  256 +++++++++-
 drivers/leds/leds-pwm.c                                         |    2 
 drivers/leds/trigger/ledtrig-cpu.c                              |    4 
 drivers/media/i2c/max9286.c                                     |    2 
 drivers/media/pci/bt8xx/bttv-driver.c                           |    1 
 drivers/media/platform/s3c-camif/camif-capture.c                |    6 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                    |    7 
 drivers/media/test-drivers/vidtv/vidtv_psi.c                    |   45 +
 drivers/media/usb/dvb-usb-v2/af9035.c                           |   13 
 drivers/mfd/dln2.c                                              |    1 
 drivers/mfd/mfd-core.c                                          |   17 
 drivers/misc/ti-st/st_core.c                                    |    7 
 drivers/mmc/core/mmc.c                                          |    2 
 drivers/net/can/dev/dev.c                                       |   10 
 drivers/net/ethernet/broadcom/tg3.c                             |    3 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c     |    2 
 drivers/net/ethernet/google/gve/gve_main.c                      |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |   10 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c |    2 
 drivers/net/ethernet/realtek/r8169_main.c                       |   15 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                  |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |   14 
 drivers/net/ethernet/toshiba/spider_net.c                       |    2 
 drivers/net/ipvlan/ipvlan_core.c                                |    8 
 drivers/net/ipvlan/ipvlan_main.c                                |    1 
 drivers/net/macsec.c                                            |    6 
 drivers/net/wireless/mediatek/mt76/mt7603/core.c                |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                 |   23 
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c             |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c       |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c             |    2 
 drivers/net/wireless/realtek/rtw88/debug.c                      |    4 
 drivers/nvdimm/of_pmem.c                                        |    8 
 drivers/nvdimm/region_devs.c                                    |    8 
 drivers/pcmcia/cs.c                                             |    1 
 drivers/pcmcia/ds.c                                             |   14 
 drivers/platform/x86/wmi.c                                      |   50 -
 drivers/pwm/pwm-brcmstb.c                                       |    4 
 drivers/pwm/pwm-sti.c                                           |   75 +-
 drivers/rtc/rtc-pcf85363.c                                      |    2 
 drivers/scsi/ufs/ufshcd.c                                       |    2 
 drivers/soc/qcom/llcc-qcom.c                                    |    3 
 drivers/spi/Kconfig                                             |    1 
 drivers/spi/spi-nxp-fspi.c                                      |    2 
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c                  |   24 
 drivers/thermal/thermal_core.c                                  |    6 
 drivers/tty/tty_jobctrl.c                                       |   17 
 drivers/usb/dwc2/hcd.c                                          |    2 
 drivers/usb/host/xhci-pci.c                                     |    2 
 drivers/usb/host/xhci-plat.c                                    |   23 
 drivers/usb/usbip/stub_dev.c                                    |    9 
 drivers/video/fbdev/fsl-diu-fb.c                                |    2 
 drivers/video/fbdev/imsttfb.c                                   |   33 -
 drivers/xen/xen-pciback/conf_space.c                            |   19 
 drivers/xen/xen-pciback/conf_space_capability.c                 |    8 
 drivers/xen/xen-pciback/conf_space_header.c                     |   21 
 fs/btrfs/ioctl.c                                                |   10 
 fs/ext4/extents.c                                               |   10 
 fs/f2fs/file.c                                                  |    1 
 fs/pstore/platform.c                                            |    9 
 include/linux/clk-provider.h                                    |   34 +
 include/linux/cpuhotplug.h                                      |    1 
 include/linux/idr.h                                             |    6 
 include/linux/mfd/core.h                                        |    2 
 include/linux/netdevice.h                                       |    1 
 include/linux/overflow.h                                        |  110 ++--
 include/linux/padata.h                                          |    3 
 include/net/flow.h                                              |    2 
 include/net/netfilter/nf_nat_redirect.h                         |    3 
 include/net/tcp.h                                               |    2 
 kernel/futex/core.c                                             |   12 
 kernel/irq/matrix.c                                             |    6 
 kernel/livepatch/core.c                                         |    2 
 kernel/padata.c                                                 |   14 
 kernel/sched/fair.c                                             |   18 
 kernel/trace/trace_kprobe.c                                     |    2 
 lib/test_overflow.c                                             |   98 +++
 mm/readahead.c                                                  |    3 
 net/dccp/ipv4.c                                                 |    6 
 net/dccp/ipv6.c                                                 |    6 
 net/hsr/hsr_forward.c                                           |    4 
 net/ipv4/syncookies.c                                           |   20 
 net/ipv4/tcp_input.c                                            |    9 
 net/ipv4/tcp_metrics.c                                          |   15 
 net/ipv4/udp.c                                                  |    6 
 net/ipv6/ip6_output.c                                           |    8 
 net/ipv6/syncookies.c                                           |    7 
 net/llc/llc_input.c                                             |   10 
 net/llc/llc_s_ac.c                                              |    3 
 net/llc/llc_station.c                                           |    3 
 net/netfilter/nf_nat_redirect.c                                 |   98 ++-
 net/netfilter/nft_redir.c                                       |   84 +--
 net/netfilter/xt_REDIRECT.c                                     |   10 
 net/netfilter/xt_recent.c                                       |    2 
 net/smc/af_smc.c                                                |    4 
 net/smc/smc.h                                                   |    5 
 net/smc/smc_cdc.c                                               |   11 
 net/smc/smc_close.c                                             |    5 
 net/tipc/link.c                                                 |    4 
 net/tipc/netlink.c                                              |    4 
 scripts/mod/file2alias.c                                        |   10 
 sound/soc/fsl/fsl_easrc.c                                       |    8 
 sound/soc/fsl/mpc5200_dma.c                                     |    3 
 sound/soc/intel/skylake/skl-sst-utils.c                         |    1 
 sound/soc/ti/ams-delta.c                                        |    4 
 tools/iio/iio_generic_buffer.c                                  |   59 +-
 tools/perf/util/hist.c                                          |   10 
 tools/perf/util/machine.c                                       |   22 
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c               |    2 
 tools/testing/selftests/pidfd/pidfd_test.c                      |   12 
 tools/testing/selftests/resctrl/resctrl_tests.c                 |    5 
 209 files changed, 1768 insertions(+), 968 deletions(-)

Aananth V (1):
      tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed

Abel Vesa (1):
      clk: imx: Select MXC_CLK for CLK_IMX8QXP

Adam Dunlap (1):
      x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot

Adrian Hunter (1):
      x86: Share definition of __is_canonical_address()

Alexandru Ardelean (1):
      tools: iio: privatize globals and functions in iio_generic_buffer.c file

Amit Kumar Mahapatra (1):
      spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies

Andrii Staikov (1):
      i40e: fix potential memory leaks in i40e_remove()

AngeloGioacchino Del Regno (2):
      clk: qcom: mmcc-msm8998: Add hardware clockgating registers to some clks
      clk: qcom: mmcc-msm8998: Set bimc_smmu_gdsc always on

Armin Wolf (2):
      platform/x86: wmi: Fix probe failure when failing to register WMI devices
      platform/x86: wmi: Fix opening of char device

Arnd Bergmann (1):
      fbdev: fsl-diu-fb: mark wr_reg_wa() static

Barnabás Pőcze (1):
      platform/x86: wmi: remove unnecessary initializations

Basavaraj Natikar (1):
      xhci: Loosen RPM as default policy to cover for AMD xHC 1.1

Bastien Nocera (2):
      Revert "HID: logitech-hidpp: add a module parameter to keep firmware gestures"
      HID: logitech-hidpp: Remove HIDPP_QUIRK_NO_HIDINPUT quirk

Ben Wolsieffer (2):
      futex: Don't include process MM in futex key on no-MMU
      regmap: prevent noinc writes from clobbering cache

Benjamin Gray (1):
      powerpc/xive: Fix endian conversion size

Cezary Rojewski (1):
      ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails

Chao Yu (1):
      f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()

Chen Ni (1):
      libnvdimm/of_pmem: Use devm_kstrdup instead of kstrdup and check its return value

Chen Yu (1):
      genirq/matrix: Exclude managed interrupts in irq_matrix_allocated()

Chengchang Tang (2):
      RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()
      RDMA/hns: Fix signed-unsigned mixed comparisons

Chenyuan Mi (1):
      tools: iio: iio_generic_buffer: Fix some integer type and calculation

Christophe JAILLET (7):
      ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()
      regmap: debugfs: Fix a erroneous check after snprintf()
      drm/rockchip: cdn-dp: Fix some error handling paths in cdn_dp_probe()
      crypto: hisilicon/hpre - Fix a erroneous check after snprintf()
      leds: trigger: ledtrig-cpu:: Fix 'output may be truncated' issue for 'cpu'
      dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()
      media: i2c: max9286: Fix some redundant of_node_put() calls

Christophe Leroy (1):
      powerpc/40x: Remove stale PTE_ATOMIC_UPDATES macro

D. Wythe (3):
      net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT
      net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc
      net/smc: put sk reference if close work was canceled

Dan Carpenter (8):
      thermal: core: prevent potential string overflow
      clk: keystone: pll: fix a couple NULL vs IS_ERR() checks
      clk: ti: fix double free in of_ti_divider_clk_setup()
      drm/rockchip: Fix type promotion bug in rockchip_gem_iommu_map()
      dmaengine: ti: edma: handle irq_of_parse_and_map() errors
      Input: synaptics-rmi4 - fix use after free in rmi_unregister_function()
      hsr: Prevent use after free in prp_create_tagged_frame()
      fbdev: imsttfb: fix a resource leak in probe

Daniel Mentz (1):
      scsi: ufs: core: Leave space for '\0' in utf8 desc string

Danila Tikhonov (1):
      clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src

Danny Kaehn (2):
      hid: cp2112: Fix duplicate workqueue initialization
      hid: cp2112: Fix IRQ shutdown stopping polling for all IRQs on chip

Dario Binacchi (1):
      clk: ti: change ti_clk_register[_omap_hw]() API

David Howells (1):
      iov_iter, x86: Be consistent about the __user tag on copy_mc_to_user()

Devi Priya (1):
      clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies

Dhruva Gole (1):
      firmware: ti_sci: Mark driver as non removable

Dinghao Liu (2):
      mfd: dln2: Fix double put in dln2_probe
      i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs

Dmitry Antipov (1):
      wifi: rtlwifi: fix EDCA limit set by BT coexistence

Dmitry Baryshkov (3):
      clk: qcom: gcc-sm8150: use ARRAY_SIZE instead of specifying num_parents
      clk: asm9260: use parent index to link the reference clock
      arm64: dts: qcom: sdm845-mtp: fix WiFi configuration

Dmitry Osipenko (1):
      drm/bridge: tc358768: Disable non-continuous clock mode

Dominique Martinet (1):
      Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

Dragos Bogdan (1):
      hwmon: (axi-fan-control) Fix possible NULL pointer dereference

Eric Dumazet (9):
      udp: add missing WRITE_ONCE() around up->encap_rcv
      tcp_metrics: add missing barriers on delete
      tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
      tcp_metrics: do not create an entry from tcp_init_metrics()
      chtls: fix tp->rcv_tstamp initialization
      tcp: fix cookie_init_timestamp() overflows
      net: add DEV_STATS_READ() helper
      ipvlan: properly track tx_errors
      inet: shrink struct flowi_common

Erik Kurzinger (1):
      drm/syncobj: fix DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE

Felix Fietkau (1):
      wifi: mt76: mt7603: rework/fix rx pse hang check

Filipe Manana (1):
      btrfs: use u64 for buffer sizes in the tree search ioctls

Florian Fainelli (1):
      pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume

Florian Westphal (1):
      netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses

Furong Xu (1):
      net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs

Gaurav Jain (2):
      crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure
      crypto: caam/jr - fix Chacha20 + Poly1305 self test failure

Gaurav Kohli (1):
      arm64: dts: qcom: msm8916: Fix iommu local address range

Geert Uytterhoeven (1):
      sh: bios: Revive earlyprintk support

George Shuklin (1):
      tg3: power down device only on SYSTEM_POWER_OFF

Giovanni Cabiddu (2):
      crypto: qat - mask device capabilities with soft straps
      crypto: qat - increase size of buffers

Gou Hao (1):
      ext4: move 'ix' sanity check to corrent position

Greg Kroah-Hartman (1):
      Linux 5.10.201

Gustavo A. R. Silva (4):
      gve: Use size_add() in call to struct_size()
      mlxsw: Use size_mul() in call to struct_size()
      tipc: Use size_add() in calls to struct_size()
      net: spider_net: Use size_add() in call to struct_size()

Han Xu (1):
      spi: nxp-fspi: use the correct ioremap function

Hans Verkuil (1):
      media: dvb-usb-v2: af9035: fix missing unlock

Hans de Goede (3):
      HID: logitech-hidpp: Don't restart IO, instead defer hid_connect() only
      HID: logitech-hidpp: Revert "Don't restart communication if not necessary"
      HID: logitech-hidpp: Move get_wireless_feature_index() check to hidpp_connect_event()

Heiner Kallweit (2):
      r8169: fix rare issue with broken rx after link-down on RTL8125
      r8169: respect userspace disabling IFF_MULTICAST

Helge Deller (1):
      fbdev: imsttfb: Fix error path of imsttfb_probe()

Herve Codina (1):
      mfd: core: Ensure disabled devices are skipped without aborting

Ian Rogers (2):
      perf machine: Avoid out of bounds LBR memory read
      perf hist: Add missing puts to hist__account_cycles

Ilpo Järvinen (1):
      selftests/resctrl: Ensure the benchmark commands fits to its array

Jason-JH.Lin (1):
      drm/mediatek: Fix iommu fault during crtc enabling

Javier Carrasco (1):
      rtc: pcf85363: fix wrong mask/val parameters in regmap_update_bits call

Jeremy Sowden (1):
      netfilter: nft_redir: use `struct nf_nat_range2` throughout and deduplicate eval call-backs

Jernej Skrabec (1):
      media: cedrus: Fix clock/reset sequence

Jia-Ju Bai (1):
      usb: dwc2: fix possible NULL pointer dereference caused by driver concurrency

Jiasheng Jiang (9):
      pstore/platform: Add check for kstrdup
      clk: mediatek: clk-mt6765: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt6779: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt6797: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt7629-eth: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt7629: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt2701: Add check for mtk_alloc_clk_data
      media: vidtv: psi: Add check for kstrdup
      media: vidtv: mux: Add check and kfree for kstrdup

Jinjie Ruan (2):
      wifi: rtw88: debug: Fix the NULL vs IS_ERR() bug for debugfs_create_file()
      misc: st_core: Do not call kfree_skb() under spin_lock_irqsave()

Jonas Blixt (1):
      USB: usbip: fix stub_dev hub disconnect

Jonas Gorski (1):
      hwrng: geode - fix accessing registers

Jonas Karlman (2):
      drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs
      drm/rockchip: vop: Fix call to crtc reset helper

Jonathan Neuschäfer (1):
      clk: npcm7xx: Fix incorrect kfree

Josh Poimboeuf (1):
      x86/srso: Fix SBPB enablement for (possible) future fixed HW

Juhee Kang (1):
      r8169: use tp_to_dev instead of open code

Katya Orlova (1):
      media: s3c-camif: Avoid inappropriate kfree()

Kees Cook (1):
      overflow: Implement size_t saturating arithmetic helpers

Konrad Dybcio (4):
      clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
      interconnect: qcom: sc7180: Retire DEFINE_QBCM
      interconnect: qcom: sc7180: Set ACV enable_mask

Konstantin Meskhidze (1):
      drm/radeon: possible buffer overflow

Krzysztof Kozlowski (1):
      ARM: dts: qcom: mdm9615: populate vsdcc fixed regulator

Kuninori Morimoto (2):
      ASoC: fsl: mpc5200_dma.c: Fix warning of Function parameter or member not described
      ASoC: ams-delta.c: use component after check

Kuniyuki Iwashima (2):
      dccp: Call security_inet_conn_request() after setting IPv4 addresses.
      dccp/tcp: Call security_inet_conn_request() after setting IPv6 addresses.

Kursad Oney (1):
      ARM: 9321/1: memset: cast the constant byte to unsigned char

Leon Romanovsky (1):
      RDMA/hfi1: Workaround truncation compilation error

Maciej Wieczor-Retman (1):
      selftests/pidfd: Fix ksft print formats

Maciej Żenczykowski (1):
      netfilter: xt_recent: fix (increase) ipv6 literal buffer length

Marc Kleine-Budde (2):
      can: dev: can_restart(): don't crash kernel if carrier is OK
      can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()

Marek Marczykowski-Górecki (1):
      xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled

Mark Rutland (1):
      arm64/arm: xen: enlighten: Fix KPTI checks

Masahiro Yamada (1):
      modpost: fix tee MODULE_DEVICE_TABLE built on big-endian host

Matti Vaittinen (1):
      tools: iio: iio_generic_buffer ensure alignment

Michał Mirosław (1):
      mfd: core: Un-constify mfd_cell.of_reg

NeilBrown (1):
      Fix termination state for idr_for_each_entry_ul()

Nuno Sá (1):
      hwmon: (axi-fan-control) Support temperature vs pwm points

Patrick Thompson (1):
      net: r8169: Disable multicast filter for RTL8168H and RTL8107E

Patrisious Haddad (1):
      IB/mlx5: Fix rdma counter binding for RAW QP

Peng Fan (1):
      clk: imx: imx8mq: correct error handling path

Qais Yousef (1):
      sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0

Randy Dunlap (1):
      clk: linux/clk-provider.h: fix kernel-doc warnings and typos

Reuben Hawkins (1):
      vfs: fix readahead(2) on block devices

Sascha Hauer (1):
      PM / devfreq: rockchip-dfi: Make pmu regmap mandatory

Sebastian Andrzej Siewior (1):
      powerpc/imc-pmu: Use the correct spinlock initializer.

Sergey Shtylyov (1):
      usb: host: xhci-plat: fix possible kernel oops while resuming

Shigeru Yoshida (1):
      tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING

Sudeep Holla (1):
      clk: scmi: Free scmi_clk allocated when the clocks with invalid info are skipped

Thierry Reding (1):
      pwm: sti: Avoid conditional gotos

Tomas Glozar (1):
      nd_btt: Make BTT lanes preemptible

Tomi Valkeinen (2):
      drm/bridge: tc358768: Fix use of uninitialized variable
      drm/bridge: tc358768: Fix bit updates

Tony Lindgren (3):
      clk: ti: Add ti_dt_clk_name() helper to use clock-output-names
      clk: ti: Update pll and clockdomain clocks to use ti_dt_clk_name()
      clk: ti: Update component clocks to use ti_dt_clk_name()

Uwe Kleine-König (3):
      soc: qcom: llcc: Handle a second device without data corruption
      leds: pwm: Don't disable the PWM when the LED should be off
      pwm: sti: Reduce number of allocations and drop usage of chip_data

Varadarajan Narayanan (1):
      clk: qcom: config IPQ_APSS_6018 should depend on QCOM_SMEM

Wang Yufen (1):
      powerpc/pseries: fix potential memory leak in init_cpu_associativity()

WangJinchao (1):
      padata: Fix refcnt handling in padata_free_shell()

Willem de Bruijn (1):
      llc: verify mac len before reading mac header

Xiyu Yang (1):
      padata: Convert from atomic_t to refcount_t on parallel_data->refcnt

Yan Zhai (1):
      ipv6: avoid atomic fragment on GSO packets

Yang Yingliang (3):
      pcmcia: cs: fix possible hung task and memory leak pccardd()
      pcmcia: ds: fix refcount leak in pcmcia_device_add()
      pcmcia: ds: fix possible name leak in error path in pcmcia_device_add()

Yi Yang (1):
      tty: tty_jobctrl: fix pid memleak in disassociate_ctty()

Yujie Liu (1):
      tracing/kprobes: Fix the order of argument descriptions

Yuntao Wang (1):
      x86/boot: Fix incorrect startup_gdt_descr.size

Zhang Rui (1):
      hwmon: (coretemp) Fix potentially truncated sysfs attribute name

Zhang Shurong (1):
      ASoC: fsl: Fix PM disable depth imbalance in fsl_easrc_probe

Zheng Wang (1):
      media: bttv: fix use after free error due to btv->timeout timer

Zheng Yejian (1):
      livepatch: Fix missing newline character in klp_resolve_symbols()

