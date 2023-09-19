Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1637A6024
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjISKvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjISKv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:51:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE6BFB;
        Tue, 19 Sep 2023 03:51:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1FAC433CA;
        Tue, 19 Sep 2023 10:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695120678;
        bh=ntoJUBzHJFFhXCIRRcU7ilnPXdlO+ETYFAPDMfVpy3A=;
        h=From:To:Cc:Subject:Date:From;
        b=rQpK9uzgd5vWyo7fV6l880FOkC4xzHQF016dWzV3WW5IEltiGY/0upp9axXu/Zsvu
         7+v8wRzbh2iZUTplpTX8O1tKSy/ee8uAZiiaayMI/2sF/F86mt7uc1KyKU6VhEb3Ii
         6Uzye8xsxiXJN/aHu6LQS8tfh5Wa1jA+k484yAUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.195
Date:   Tue, 19 Sep 2023 12:51:13 +0200
Message-ID: <2023091913-uncharted-fondly-97b8@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.10.195 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml |    2 
 Documentation/scsi/scsi_mid_low_api.rst                      |    4 
 Makefile                                                     |    2 
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts              |    3 
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts                |   13 
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts                 |   13 
 arch/arm/boot/dts/bcm5301x.dtsi                              |    4 
 arch/arm/boot/dts/bcm53573.dtsi                              |   27 
 arch/arm/boot/dts/bcm947189acdbmr.dts                        |    6 
 arch/arm/boot/dts/exynos4210-i9100.dts                       |    4 
 arch/arm/boot/dts/imx23.dtsi                                 |    2 
 arch/arm/boot/dts/imx25.dtsi                                 |    2 
 arch/arm/boot/dts/imx28.dtsi                                 |    2 
 arch/arm/boot/dts/imx31.dtsi                                 |    2 
 arch/arm/boot/dts/imx35.dtsi                                 |    2 
 arch/arm/boot/dts/imx50.dtsi                                 |    2 
 arch/arm/boot/dts/imx51.dtsi                                 |    2 
 arch/arm/boot/dts/imx53.dtsi                                 |    2 
 arch/arm/boot/dts/imx6qdl.dtsi                               |    4 
 arch/arm/boot/dts/imx6sl.dtsi                                |    2 
 arch/arm/boot/dts/imx6sx.dtsi                                |    4 
 arch/arm/boot/dts/imx6ul.dtsi                                |    4 
 arch/arm/boot/dts/imx7s.dtsi                                 |   11 
 arch/arm/boot/dts/s3c6410-mini6410.dts                       |    6 
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi                       |  210 +++---
 arch/arm/boot/dts/s5pv210-aquila.dts                         |   12 
 arch/arm/boot/dts/s5pv210-aries.dtsi                         |    4 
 arch/arm/boot/dts/s5pv210-goni.dts                           |   14 
 arch/arm/boot/dts/s5pv210-smdkv210.dts                       |   30 
 arch/arm/mach-omap2/powerdomain.c                            |    2 
 arch/arm/mach-pxa/sharpsl_pm.c                               |    2 
 arch/arm/mach-pxa/spitz.c                                    |   14 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                        |    3 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                         |    3 
 arch/arm64/include/asm/sdei.h                                |    6 
 arch/arm64/kernel/entry.S                                    |   27 
 arch/arm64/kernel/sdei.c                                     |    3 
 arch/arm64/kernel/smp.c                                      |    8 
 arch/arm64/lib/csum.c                                        |    2 
 arch/m68k/fpsp040/skeleton.S                                 |    4 
 arch/m68k/ifpsp060/os.S                                      |    4 
 arch/m68k/kernel/relocate_kernel.S                           |    4 
 arch/mips/alchemy/devboards/db1000.c                         |    8 
 arch/mips/alchemy/devboards/db1200.c                         |   19 
 arch/mips/alchemy/devboards/db1300.c                         |   10 
 arch/parisc/include/asm/led.h                                |    4 
 arch/parisc/include/asm/processor.h                          |    1 
 arch/parisc/kernel/processor.c                               |   18 
 arch/powerpc/include/asm/lppaca.h                            |   13 
 arch/powerpc/include/asm/paca.h                              |    6 
 arch/powerpc/include/asm/paravirt.h                          |    1 
 arch/powerpc/include/asm/plpar_wrappers.h                    |    1 
 arch/powerpc/kernel/fadump.c                                 |    1 
 arch/powerpc/kernel/iommu.c                                  |   17 
 arch/powerpc/kvm/book3s_hv_ras.c                             |    1 
 arch/powerpc/mm/book3s64/slb.c                               |    1 
 arch/powerpc/perf/core-fsl-emb.c                             |    8 
 arch/powerpc/platforms/pseries/lpar.c                        |   10 
 arch/powerpc/platforms/pseries/lparcfg.c                     |    4 
 arch/powerpc/platforms/pseries/setup.c                       |    2 
 arch/powerpc/xmon/xmon.c                                     |    1 
 arch/s390/crypto/paes_s390.c                                 |    2 
 arch/s390/kernel/ipl.c                                       |    2 
 arch/sh/boards/mach-ap325rxa/setup.c                         |    2 
 arch/sh/boards/mach-ecovec24/setup.c                         |    6 
 arch/sh/boards/mach-kfr2r09/setup.c                          |    2 
 arch/sh/boards/mach-migor/setup.c                            |    2 
 arch/sh/boards/mach-se/7724/setup.c                          |    6 
 arch/um/configs/i386_defconfig                               |    1 
 arch/um/configs/x86_64_defconfig                             |    1 
 arch/um/drivers/Kconfig                                      |   16 
 arch/um/drivers/Makefile                                     |    2 
 arch/x86/boot/compressed/head_64.S                           |   30 
 arch/x86/include/asm/pgtable_types.h                         |   11 
 arch/x86/include/asm/virtext.h                               |    6 
 arch/x86/kernel/apm_32.c                                     |    6 
 arch/x86/kernel/cpu/common.c                                 |    8 
 arch/xtensa/include/asm/core.h                               |    9 
 arch/xtensa/kernel/perf_event.c                              |   17 
 crypto/algapi.c                                              |   16 
 crypto/asymmetric_keys/x509_public_key.c                     |    5 
 drivers/acpi/apei/ghes.c                                     |   19 
 drivers/acpi/bus.c                                           |    2 
 drivers/acpi/pci_root.c                                      |    3 
 drivers/amba/bus.c                                           |    1 
 drivers/ata/pata_arasan_cf.c                                 |    3 
 drivers/ata/pata_ftide010.c                                  |    1 
 drivers/ata/sata_gemini.c                                    |    1 
 drivers/base/regmap/regcache-rbtree.c                        |   10 
 drivers/base/test/test_async_driver_probe.c                  |    2 
 drivers/bluetooth/btsdio.c                                   |    1 
 drivers/bluetooth/btusb.c                                    |    2 
 drivers/bluetooth/hci_nokia.c                                |    6 
 drivers/bus/mhi/host/pm.c                                    |    5 
 drivers/bus/ti-sysc.c                                        |    2 
 drivers/char/hw_random/iproc-rng200.c                        |   25 
 drivers/char/hw_random/nomadik-rng.c                         |   12 
 drivers/char/ipmi/ipmi_si_intf.c                             |    5 
 drivers/char/ipmi/ipmi_ssif.c                                |    7 
 drivers/clk/Kconfig                                          |    1 
 drivers/clk/imx/clk-composite-8m.c                           |   12 
 drivers/clk/imx/clk-imx8mp.c                                 |    5 
 drivers/clk/imx/clk-pll14xx.c                                |    2 
 drivers/clk/keystone/pll.c                                   |    2 
 drivers/clk/qcom/gcc-mdm9615.c                               |    2 
 drivers/clk/qcom/gcc-sc7180.c                                |   33 -
 drivers/clk/qcom/gcc-sm8250.c                                |   93 +-
 drivers/clk/qcom/reset.c                                     |    3 
 drivers/clk/sunxi-ng/ccu_mmc_timing.c                        |    2 
 drivers/cpufreq/brcmstb-avs-cpufreq.c                        |    6 
 drivers/cpufreq/cpufreq.c                                    |    2 
 drivers/cpufreq/powernow-k8.c                                |    3 
 drivers/cpuidle/cpuidle-pseries.c                            |    8 
 drivers/crypto/caam/caampkc.c                                |    4 
 drivers/crypto/stm32/stm32-hash.c                            |    9 
 drivers/devfreq/devfreq.c                                    |    1 
 drivers/dma/Kconfig                                          |    2 
 drivers/dma/ste_dma40.c                                      |    4 
 drivers/firmware/Kconfig                                     |    1 
 drivers/firmware/arm_sdei.c                                  |   32 -
 drivers/firmware/efi/libstub/x86-stub.c                      |    2 
 drivers/firmware/meson/meson_sm.c                            |    2 
 drivers/firmware/stratix10-svc.c                             |    2 
 drivers/fsi/fsi-master-aspeed.c                              |    2 
 drivers/fsi/fsi-master-ast-cf.c                              |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                   |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                      |   14 
 drivers/gpu/drm/amd/amdgpu/cik.c                             |   36 -
 drivers/gpu/drm/amd/amdgpu/si.c                              |   36 -
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  |    3 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c             |    5 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c      |    9 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                           |   10 
 drivers/gpu/drm/armada/armada_overlay.c                      |    6 
 drivers/gpu/drm/ast/ast_post.c                               |    2 
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c                 |    9 
 drivers/gpu/drm/bridge/tc358764.c                            |    2 
 drivers/gpu/drm/etnaviv/etnaviv_dump.c                       |   14 
 drivers/gpu/drm/i915/gvt/gtt.c                               |   68 +-
 drivers/gpu/drm/i915/gvt/gtt.h                               |    5 
 drivers/gpu/drm/i915/gvt/gvt.c                               |    9 
 drivers/gpu/drm/i915/gvt/gvt.h                               |    3 
 drivers/gpu/drm/i915/gvt/handlers.c                          |   44 +
 drivers/gpu/drm/i915/gvt/mmio.h                              |    4 
 drivers/gpu/drm/i915/intel_gvt.c                             |   15 
 drivers/gpu/drm/i915/intel_gvt.h                             |    5 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                       |    6 
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c                        |    8 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c                   |    3 
 drivers/gpu/drm/panel/panel-simple.c                         |    4 
 drivers/gpu/drm/radeon/cik.c                                 |   36 -
 drivers/gpu/drm/radeon/si.c                                  |   37 -
 drivers/gpu/drm/tegra/dpaux.c                                |    6 
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                          |    4 
 drivers/hid/hid-logitech-dj.c                                |    5 
 drivers/hid/hid-multitouch.c                                 |   13 
 drivers/hid/wacom.h                                          |    1 
 drivers/hid/wacom_sys.c                                      |   25 
 drivers/hid/wacom_wac.c                                      |    1 
 drivers/hid/wacom_wac.h                                      |    1 
 drivers/hwmon/tmp513.c                                       |    2 
 drivers/hwtracing/coresight/coresight-tmc-etf.c              |    2 
 drivers/hwtracing/coresight/coresight-tmc-etr.c              |    5 
 drivers/hwtracing/coresight/coresight-tmc.h                  |    2 
 drivers/infiniband/core/uverbs_std_types_counters.c          |    2 
 drivers/infiniband/sw/siw/siw_cm.c                           |    1 
 drivers/infiniband/sw/siw/siw_verbs.c                        |    2 
 drivers/infiniband/ulp/isert/ib_isert.c                      |    2 
 drivers/infiniband/ulp/srp/ib_srp.c                          |    4 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                      |    7 
 drivers/iommu/intel/pasid.c                                  |    2 
 drivers/md/md-bitmap.c                                       |   28 
 drivers/media/cec/usb/pulse8/pulse8-cec.c                    |    7 
 drivers/media/dvb-frontends/ascot2e.c                        |    2 
 drivers/media/dvb-frontends/atbm8830.c                       |    2 
 drivers/media/dvb-frontends/au8522_dig.c                     |    2 
 drivers/media/dvb-frontends/bcm3510.c                        |    2 
 drivers/media/dvb-frontends/cx22700.c                        |    2 
 drivers/media/dvb-frontends/cx22702.c                        |    2 
 drivers/media/dvb-frontends/cx24110.c                        |    2 
 drivers/media/dvb-frontends/cx24113.c                        |    2 
 drivers/media/dvb-frontends/cx24116.c                        |    2 
 drivers/media/dvb-frontends/cx24120.c                        |    6 
 drivers/media/dvb-frontends/cx24123.c                        |    2 
 drivers/media/dvb-frontends/cxd2820r_core.c                  |    2 
 drivers/media/dvb-frontends/cxd2841er.c                      |    4 
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c            |    2 
 drivers/media/dvb-frontends/dib0070.c                        |    2 
 drivers/media/dvb-frontends/dib0090.c                        |    4 
 drivers/media/dvb-frontends/dib3000mb.c                      |    2 
 drivers/media/dvb-frontends/dib3000mc.c                      |    2 
 drivers/media/dvb-frontends/dib7000m.c                       |    2 
 drivers/media/dvb-frontends/dib7000p.c                       |    4 
 drivers/media/dvb-frontends/dib8000.c                        |    2 
 drivers/media/dvb-frontends/dib9000.c                        |    2 
 drivers/media/dvb-frontends/drx39xyj/drxj.c                  |    2 
 drivers/media/dvb-frontends/drxd_hard.c                      |    2 
 drivers/media/dvb-frontends/drxk_hard.c                      |    2 
 drivers/media/dvb-frontends/ds3000.c                         |    2 
 drivers/media/dvb-frontends/dvb-pll.c                        |    2 
 drivers/media/dvb-frontends/ec100.c                          |    2 
 drivers/media/dvb-frontends/helene.c                         |    4 
 drivers/media/dvb-frontends/horus3a.c                        |    2 
 drivers/media/dvb-frontends/isl6405.c                        |    2 
 drivers/media/dvb-frontends/isl6421.c                        |    2 
 drivers/media/dvb-frontends/isl6423.c                        |    2 
 drivers/media/dvb-frontends/itd1000.c                        |    2 
 drivers/media/dvb-frontends/ix2505v.c                        |    2 
 drivers/media/dvb-frontends/l64781.c                         |    2 
 drivers/media/dvb-frontends/lg2160.c                         |    2 
 drivers/media/dvb-frontends/lgdt3305.c                       |    2 
 drivers/media/dvb-frontends/lgdt3306a.c                      |    2 
 drivers/media/dvb-frontends/lgdt330x.c                       |    2 
 drivers/media/dvb-frontends/lgs8gxx.c                        |    2 
 drivers/media/dvb-frontends/lnbh25.c                         |    2 
 drivers/media/dvb-frontends/lnbp21.c                         |    4 
 drivers/media/dvb-frontends/lnbp22.c                         |    2 
 drivers/media/dvb-frontends/m88ds3103.c                      |    2 
 drivers/media/dvb-frontends/m88rs2000.c                      |    2 
 drivers/media/dvb-frontends/mb86a16.c                        |    2 
 drivers/media/dvb-frontends/mb86a20s.c                       |    2 
 drivers/media/dvb-frontends/mt312.c                          |    2 
 drivers/media/dvb-frontends/mt352.c                          |    2 
 drivers/media/dvb-frontends/nxt200x.c                        |    2 
 drivers/media/dvb-frontends/nxt6000.c                        |    2 
 drivers/media/dvb-frontends/or51132.c                        |    2 
 drivers/media/dvb-frontends/or51211.c                        |    2 
 drivers/media/dvb-frontends/s5h1409.c                        |    2 
 drivers/media/dvb-frontends/s5h1411.c                        |    2 
 drivers/media/dvb-frontends/s5h1420.c                        |    2 
 drivers/media/dvb-frontends/s5h1432.c                        |    2 
 drivers/media/dvb-frontends/s921.c                           |    2 
 drivers/media/dvb-frontends/si21xx.c                         |    2 
 drivers/media/dvb-frontends/sp887x.c                         |    2 
 drivers/media/dvb-frontends/stb0899_drv.c                    |    2 
 drivers/media/dvb-frontends/stb6000.c                        |    2 
 drivers/media/dvb-frontends/stb6100.c                        |    2 
 drivers/media/dvb-frontends/stv0288.c                        |    2 
 drivers/media/dvb-frontends/stv0297.c                        |    2 
 drivers/media/dvb-frontends/stv0299.c                        |    2 
 drivers/media/dvb-frontends/stv0367.c                        |    6 
 drivers/media/dvb-frontends/stv0900_core.c                   |    2 
 drivers/media/dvb-frontends/stv090x.c                        |    2 
 drivers/media/dvb-frontends/stv6110.c                        |    2 
 drivers/media/dvb-frontends/stv6110x.c                       |    2 
 drivers/media/dvb-frontends/tda10021.c                       |    2 
 drivers/media/dvb-frontends/tda10023.c                       |    2 
 drivers/media/dvb-frontends/tda10048.c                       |    2 
 drivers/media/dvb-frontends/tda1004x.c                       |    4 
 drivers/media/dvb-frontends/tda10086.c                       |    2 
 drivers/media/dvb-frontends/tda665x.c                        |    2 
 drivers/media/dvb-frontends/tda8083.c                        |    2 
 drivers/media/dvb-frontends/tda8261.c                        |    2 
 drivers/media/dvb-frontends/tda826x.c                        |    2 
 drivers/media/dvb-frontends/ts2020.c                         |    2 
 drivers/media/dvb-frontends/tua6100.c                        |    2 
 drivers/media/dvb-frontends/ves1820.c                        |    2 
 drivers/media/dvb-frontends/ves1x93.c                        |    2 
 drivers/media/dvb-frontends/zl10036.c                        |    2 
 drivers/media/dvb-frontends/zl10039.c                        |    2 
 drivers/media/dvb-frontends/zl10353.c                        |    2 
 drivers/media/i2c/ad5820.c                                   |    2 
 drivers/media/i2c/ov2680.c                                   |  246 +------
 drivers/media/i2c/ov5640.c                                   |    4 
 drivers/media/i2c/tvp5150.c                                  |    4 
 drivers/media/pci/bt8xx/dst.c                                |    2 
 drivers/media/pci/bt8xx/dst_ca.c                             |    2 
 drivers/media/pci/cx23885/cx23885-dvb.c                      |   12 
 drivers/media/pci/ddbridge/ddbridge-dummy-fe.c               |    2 
 drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c         |    5 
 drivers/media/tuners/fc0011.c                                |    2 
 drivers/media/tuners/fc0012.c                                |    2 
 drivers/media/tuners/fc0013.c                                |    2 
 drivers/media/tuners/max2165.c                               |    2 
 drivers/media/tuners/mc44s803.c                              |    2 
 drivers/media/tuners/mt2060.c                                |    2 
 drivers/media/tuners/mt2131.c                                |    2 
 drivers/media/tuners/mt2266.c                                |    2 
 drivers/media/tuners/mxl5005s.c                              |    2 
 drivers/media/tuners/qt1010.c                                |    2 
 drivers/media/tuners/tda18218.c                              |    2 
 drivers/media/tuners/xc4000.c                                |    2 
 drivers/media/tuners/xc5000.c                                |    2 
 drivers/media/usb/dvb-usb/m920x.c                            |    5 
 drivers/media/usb/go7007/go7007-i2c.c                        |    2 
 drivers/media/usb/siano/smsusb.c                             |   21 
 drivers/media/v4l2-core/v4l2-fwnode.c                        |   18 
 drivers/mmc/host/Kconfig                                     |    5 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                     |   45 +
 drivers/mtd/nand/raw/fsmc_nand.c                             |    7 
 drivers/mtd/spi-nor/core.c                                   |   19 
 drivers/net/arcnet/arcnet.c                                  |    2 
 drivers/net/can/usb/gs_usb.c                                 |    5 
 drivers/net/dsa/sja1105/sja1105_main.c                       |   38 +
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c              |    7 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c             |    9 
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c             |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c           |    4 
 drivers/net/ethernet/intel/ice/ice_main.c                    |   13 
 drivers/net/ethernet/intel/igb/igb.h                         |    4 
 drivers/net/ethernet/intel/igb/igb_main.c                    |   16 
 drivers/net/ethernet/intel/igbvf/igbvf.h                     |    4 
 drivers/net/ethernet/intel/igc/igc.h                         |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c                 |   28 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c              |    5 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                  |    3 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c           |    9 
 drivers/net/ethernet/mellanox/mlxsw/i2c.c                    |    5 
 drivers/net/macsec.c                                         |    3 
 drivers/net/usb/qmi_wwan.c                                   |    1 
 drivers/net/usb/r8152.c                                      |    3 
 drivers/net/veth.c                                           |    4 
 drivers/net/vxlan/vxlan_core.c                               |   58 -
 drivers/net/wireless/ath/ath10k/pci.c                        |    9 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c               |    2 
 drivers/net/wireless/ath/ath9k/wmi.c                         |   20 
 drivers/net/wireless/marvell/mwifiex/debugfs.c               |    9 
 drivers/net/wireless/marvell/mwifiex/pcie.c                  |   25 
 drivers/net/wireless/marvell/mwifiex/sta_rx.c                |   12 
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c              |   30 
 drivers/net/wireless/marvell/mwifiex/util.c                  |   10 
 drivers/net/wireless/mediatek/mt76/testmode.c                |    1 
 drivers/ntb/ntb_transport.c                                  |   19 
 drivers/of/unittest.c                                        |   12 
 drivers/opp/core.c                                           |    2 
 drivers/parisc/led.c                                         |    4 
 drivers/pci/hotplug/pciehp_hpc.c                             |   12 
 drivers/pci/pcie/aspm.c                                      |   30 
 drivers/perf/fsl_imx8_ddr_perf.c                             |   24 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                |    6 
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c                |   18 
 drivers/pinctrl/intel/pinctrl-cherryview.c                   |    5 
 drivers/pinctrl/pinctrl-amd.c                                |    4 
 drivers/pinctrl/pinctrl-mcp23s08_spi.c                       |   10 
 drivers/platform/mellanox/mlxbf-tmfifo.c                     |   91 ++
 drivers/platform/x86/huawei-wmi.c                            |    2 
 drivers/platform/x86/intel-hid.c                             |   21 
 drivers/pwm/pwm-lpc32xx.c                                    |   16 
 drivers/rpmsg/qcom_glink_native.c                            |    4 
 drivers/rtc/rtc-ds1685.c                                     |    2 
 drivers/s390/block/dasd.c                                    |  125 +--
 drivers/s390/block/dasd_3990_erp.c                           |    2 
 drivers/s390/crypto/pkey_api.c                               |    2 
 drivers/s390/crypto/zcrypt_api.c                             |    1 
 drivers/s390/crypto/zcrypt_ep11misc.c                        |    4 
 drivers/s390/crypto/zcrypt_ep11misc.h                        |    9 
 drivers/scsi/aic94xx/aic94xx_task.c                          |    2 
 drivers/scsi/be2iscsi/be_iscsi.c                             |    4 
 drivers/scsi/fcoe/fcoe_ctlr.c                                |   20 
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c                       |    8 
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                       |   19 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                       |   62 +
 drivers/scsi/hosts.c                                         |    4 
 drivers/scsi/isci/request.c                                  |   10 
 drivers/scsi/isci/task.c                                     |    2 
 drivers/scsi/libsas/sas_ata.c                                |    7 
 drivers/scsi/libsas/sas_expander.c                           |    2 
 drivers/scsi/libsas/sas_task.c                               |    4 
 drivers/scsi/mpt3sas/mpt3sas_base.c                          |   46 +
 drivers/scsi/mpt3sas/mpt3sas_base.h                          |    1 
 drivers/scsi/mvsas/mv_sas.c                                  |   10 
 drivers/scsi/pm8001/pm8001_hwi.c                             |   16 
 drivers/scsi/pm8001/pm8001_sas.c                             |    4 
 drivers/scsi/pm8001/pm80xx_hwi.c                             |   14 
 drivers/scsi/qedf/qedf_dbg.h                                 |    2 
 drivers/scsi/qedf/qedf_debugfs.c                             |   35 -
 drivers/scsi/qedi/qedi_main.c                                |    5 
 drivers/scsi/qla2xxx/qla_attr.c                              |    2 
 drivers/scsi/qla2xxx/qla_dbg.c                               |   18 
 drivers/scsi/qla2xxx/qla_def.h                               |   12 
 drivers/scsi/qla2xxx/qla_gbl.h                               |    3 
 drivers/scsi/qla2xxx/qla_init.c                              |   68 +-
 drivers/scsi/qla2xxx/qla_inline.h                            |   46 +
 drivers/scsi/qla2xxx/qla_iocb.c                              |   60 +
 drivers/scsi/qla2xxx/qla_isr.c                               |   16 
 drivers/scsi/qla2xxx/qla_mbx.c                               |    7 
 drivers/scsi/qla2xxx/qla_nvme.c                              |   12 
 drivers/scsi/qla2xxx/qla_os.c                                |  223 ++++---
 drivers/scsi/qla2xxx/qla_target.c                            |   14 
 drivers/scsi/qla4xxx/ql4_os.c                                |   15 
 drivers/scsi/scsi_transport_iscsi.c                          |   80 +-
 drivers/scsi/storvsc_drv.c                                   |    2 
 drivers/soc/qcom/ocmem.c                                     |   14 
 drivers/soc/qcom/qmi_encdec.c                                |    4 
 drivers/spi/spi-tegra20-sflash.c                             |    6 
 drivers/staging/media/rkvdec/rkvdec.c                        |    2 
 drivers/staging/rtl8712/os_intfs.c                           |    1 
 drivers/staging/rtl8712/usb_intf.c                           |    1 
 drivers/tty/serial/qcom_geni_serial.c                        |    5 
 drivers/tty/serial/sc16is7xx.c                               |   17 
 drivers/tty/serial/serial-tegra.c                            |    6 
 drivers/tty/serial/sprd_serial.c                             |   30 
 drivers/usb/chipidea/ci_hdrc_imx.c                           |   10 
 drivers/usb/chipidea/usbmisc_imx.c                           |    6 
 drivers/usb/core/hcd.c                                       |   10 
 drivers/usb/core/hub.c                                       |  349 ++++++-----
 drivers/usb/core/message.c                                   |   29 
 drivers/usb/core/usb.h                                       |    4 
 drivers/usb/dwc3/dwc3-meson-g12a.c                           |    6 
 drivers/usb/gadget/function/f_mass_storage.c                 |    2 
 drivers/usb/phy/phy-mxs-usb.c                                |   10 
 drivers/usb/serial/option.c                                  |    7 
 drivers/usb/typec/bus.c                                      |   12 
 drivers/usb/typec/tcpm/tcpci.c                               |    4 
 drivers/usb/typec/tcpm/tcpci.h                               |    1 
 drivers/usb/typec/tcpm/tcpm.c                                |    3 
 drivers/vfio/vfio_iommu_type1.c                              |    2 
 drivers/video/backlight/bd6107.c                             |    2 
 drivers/video/backlight/gpio_backlight.c                     |    5 
 drivers/video/backlight/lv5207lp.c                           |    2 
 drivers/video/fbdev/ep93xx-fb.c                              |    1 
 drivers/virtio/virtio_ring.c                                 |    2 
 drivers/watchdog/intel-mid_wdt.c                             |    1 
 fs/btrfs/disk-io.c                                           |    5 
 fs/btrfs/transaction.c                                       |    7 
 fs/configfs/dir.c                                            |    2 
 fs/dlm/plock.c                                               |    6 
 fs/erofs/zdata.c                                             |    2 
 fs/eventfd.c                                                 |    7 
 fs/ext4/balloc.c                                             |   15 
 fs/ext4/block_validity.c                                     |    8 
 fs/ext4/ext4.h                                               |    2 
 fs/ext4/mballoc.c                                            |    2 
 fs/fuse/readdir.c                                            |   10 
 fs/jfs/jfs_extent.c                                          |    5 
 fs/lockd/mon.c                                               |    3 
 fs/namei.c                                                   |    2 
 fs/nfs/blocklayout/dev.c                                     |    4 
 fs/nfs/direct.c                                              |   20 
 fs/nfs/nfs2xdr.c                                             |    2 
 fs/nfs/nfs3xdr.c                                             |    2 
 fs/nfs/nfs42proc.c                                           |    5 
 fs/nfs/pnfs_dev.c                                            |    2 
 fs/nfsd/blocklayoutxdr.c                                     |    9 
 fs/nfsd/flexfilelayoutxdr.c                                  |    9 
 fs/nfsd/nfs4xdr.c                                            |   25 
 fs/nilfs2/alloc.c                                            |    3 
 fs/nilfs2/inode.c                                            |    7 
 fs/nilfs2/segment.c                                          |    5 
 fs/nls/nls_base.c                                            |    4 
 fs/ocfs2/namei.c                                             |    4 
 fs/overlayfs/super.c                                         |    2 
 fs/proc/base.c                                               |    3 
 fs/pstore/ram_core.c                                         |    2 
 fs/quota/dquot.c                                             |  174 +++--
 fs/reiserfs/journal.c                                        |    4 
 fs/udf/balloc.c                                              |   31 
 fs/udf/inode.c                                               |   45 -
 fs/verity/signature.c                                        |   16 
 include/acpi/apei.h                                          |    4 
 include/crypto/algapi.h                                      |    3 
 include/linux/arm_sdei.h                                     |    4 
 include/linux/eventfd.h                                      |    6 
 include/linux/if_arp.h                                       |    4 
 include/linux/nls.h                                          |    2 
 include/linux/trace_events.h                                 |    3 
 include/linux/usb/typec_altmode.h                            |    2 
 include/net/ip.h                                             |    1 
 include/net/ip_tunnels.h                                     |   15 
 include/net/ipv6.h                                           |    2 
 include/net/lwtunnel.h                                       |    5 
 include/net/tcp.h                                            |    1 
 include/scsi/libsas.h                                        |   12 
 include/scsi/scsi_host.h                                     |    2 
 include/uapi/linux/sync_file.h                               |    2 
 io_uring/io-wq.c                                             |   10 
 io_uring/io-wq.h                                             |    1 
 io_uring/io_uring.c                                          |    9 
 kernel/auditsc.c                                             |    2 
 kernel/cgroup/namespace.c                                    |    6 
 kernel/kprobes.c                                             |   14 
 kernel/module.c                                              |   15 
 kernel/printk/printk_ringbuffer.c                            |    2 
 kernel/rcu/refscale.c                                        |    3 
 kernel/trace/bpf_trace.c                                     |    2 
 kernel/trace/trace.c                                         |   72 +-
 kernel/trace/trace.h                                         |    2 
 kernel/trace/trace_uprobe.c                                  |    3 
 lib/idr.c                                                    |    2 
 lib/test_meminit.c                                           |    2 
 mm/shmem.c                                                   |   28 
 net/9p/trans_virtio.c                                        |    2 
 net/bluetooth/hci_core.c                                     |   16 
 net/core/filter.c                                            |    2 
 net/core/flow_dissector.c                                    |    3 
 net/core/lwt_bpf.c                                           |    7 
 net/core/skbuff.c                                            |   34 -
 net/core/sock.c                                              |    9 
 net/dccp/ipv4.c                                              |   13 
 net/dccp/ipv6.c                                              |   15 
 net/hsr/hsr_forward.c                                        |    1 
 net/ipv4/devinet.c                                           |   10 
 net/ipv4/fib_semantics.c                                     |    5 
 net/ipv4/fib_trie.c                                          |    3 
 net/ipv4/igmp.c                                              |    3 
 net/ipv4/ip_input.c                                          |    3 
 net/ipv4/ip_output.c                                         |    2 
 net/ipv4/route.c                                             |    1 
 net/ipv4/tcp_input.c                                         |    3 
 net/ipv4/tcp_timer.c                                         |   18 
 net/ipv4/udp.c                                               |   20 
 net/ipv6/addrconf.c                                          |    2 
 net/ipv6/ip6_output.c                                        |    2 
 net/ipv6/udp.c                                               |   19 
 net/kcm/kcmsock.c                                            |   15 
 net/netfilter/ipset/ip_set_hash_netportnet.c                 |    1 
 net/netfilter/nfnetlink_osf.c                                |    8 
 net/netfilter/xt_sctp.c                                      |    2 
 net/netfilter/xt_u32.c                                       |   21 
 net/netlabel/netlabel_kapi.c                                 |    3 
 net/netrom/af_netrom.c                                       |    5 
 net/sched/sch_fq_pie.c                                       |   27 
 net/sched/sch_hfsc.c                                         |    4 
 net/sched/sch_plug.c                                         |    2 
 net/sched/sch_qfq.c                                          |   22 
 net/sctp/proc.c                                              |    2 
 net/sctp/sm_sideeffect.c                                     |    5 
 net/sctp/socket.c                                            |   10 
 net/smc/smc_core.c                                           |    2 
 net/socket.c                                                 |    6 
 net/tls/tls_sw.c                                             |    4 
 net/unix/af_unix.c                                           |    2 
 net/unix/scm.c                                               |    6 
 samples/bpf/tracex6_kern.c                                   |   17 
 scripts/kconfig/preprocess.c                                 |    3 
 security/integrity/ima/Kconfig                               |   12 
 security/keys/keyctl.c                                       |   11 
 security/smack/smackfs.c                                     |    2 
 sound/Kconfig                                                |    2 
 sound/core/pcm_compat.c                                      |    8 
 sound/core/seq/oss/seq_oss_midi.c                            |   35 -
 sound/pci/ac97/ac97_codec.c                                  |    5 
 sound/soc/atmel/atmel-i2s.c                                  |    5 
 sound/soc/codecs/Kconfig                                     |    1 
 sound/soc/codecs/da7219-aad.c                                |   12 
 sound/soc/codecs/es8316.c                                    |    2 
 sound/soc/codecs/rt5682-sdw.c                                |    7 
 tools/bpf/bpftool/skeleton/profiler.bpf.c                    |   27 
 tools/hv/vmbus_testing                                       |    4 
 tools/perf/builtin-top.c                                     |    1 
 tools/perf/ui/browsers/hists.c                               |   60 -
 tools/perf/util/annotate.c                                   |   10 
 tools/perf/util/header.c                                     |   11 
 tools/testing/selftests/bpf/benchs/run_bench_rename.sh       |    2 
 tools/testing/selftests/bpf/progs/test_cls_redirect.h        |    9 
 tools/testing/selftests/kselftest/runner.sh                  |   29 
 tools/testing/selftests/kselftest_harness.h                  |   11 
 tools/testing/selftests/resctrl/cache.c                      |   18 
 tools/testing/selftests/resctrl/fill_buf.c                   |    3 
 tools/testing/selftests/resctrl/resctrl.h                    |    1 
 550 files changed, 3506 insertions(+), 2253 deletions(-)

Aaron Armstrong Skomra (1):
      HID: wacom: remove the battery when the EKR is off

Adrien Thierry (1):
      phy: qcom-snps-femto-v2: use qcom_snps_hsphy_suspend/resume error code

Ahmad Fatoum (2):
      clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op
      clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz

Alan Maguire (1):
      selftests/bpf: fix static assert compilation issue for test_cls_*.c

Alan Stern (5):
      USB: gadget: f_mass_storage: Fix unused variable warning
      USB: core: Unite old scheme and new scheme descriptor reads
      USB: core: Change usb_get_device_descriptor() API
      USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()
      USB: core: Fix oversight in SuperSpeed initialization

Aleksa Sarai (1):
      procfs: block chmod on /proc/thread-self/comm

Aleksey Nasibulin (1):
      ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2

Alex Henrie (1):
      net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr

Alexander Aring (1):
      dlm: fix plock lookup when using multiple lockspaces

Alexander Lobakin (1):
      bpftool: Use a local bpf_perf_event_value to fix accessing its fields

Alexei Filippov (1):
      jfs: validate max amount of blocks before allocation.

Anand Jain (1):
      btrfs: use the correct superblock to compare fsid in btrfs_validate_super

Andrew Donnellan (1):
      lib/test_meminit: allocate pages up to order MAX_ORDER

Andy Shevchenko (1):
      s390/zcrypt: don't leak memory if dev_set_name() fails

AngeloGioacchino Del Regno (1):
      iommu/qcom: Disable and reset context bank before programming

Ani Sinha (1):
      vmbus_testing: fix wrong python syntax for integer value comparison

Ard Biesheuvel (1):
      x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved

Ariel Marcovitch (1):
      idr: fix param name in idr_alloc_cyclic() doc

Arnaldo Carvalho de Melo (2):
      perf annotate bpf: Don't enclose non-debug code with an assert()
      perf top: Don't pass an ERR_PTR() directly to perf_session__delete()

Arnd Bergmann (2):
      ARM: pxa: remove use of symbol_get()
      drm/amdgpu: avoid integer overflow warning in amdgpu_device_resize_fb_bar()

Artem Chernyshev (1):
      fs: ocfs2: namei: check return value of ocfs2_add_entry()

Baokun Li (4):
      quota: factor out dquot_write_dquot()
      quota: rename dquot_active() to inode_quota_active()
      quota: add new helper dquot_active()
      quota: fix dqput() to follow the guarantees dquot_srcu should provide

Baoquan He (2):
      clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM
      idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM

Bart Van Assche (3):
      scsi: libsas: Introduce more SAM status code aliases in enum exec_status
      scsi: RDMA/srp: Fix residual handling
      scsi: core: Fix the scsi_set_resid() documentation

Ben Hutchings (1):
      m68k: Fix invalid .section syntax

Benjamin Coddington (1):
      NFS: Guard against READDIR loop when entry names exceed MAXNAMELEN

Benjamin Gaignard (1):
      media: rkvdec: increase max supported height for H.264

Biju Das (1):
      hwmon: (tmp513) Fix the channel number in tmp51x_is_visible()

Bjorn Helgaas (1):
      Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"

Björn Töpel (1):
      kselftest/runner.sh: Propagate SIGTERM to runner child

Bogdan Togorean (1):
      drm: adv7511: Fix low refresh rate register for ADV7533/5

Boris Brezillon (1):
      PM / devfreq: Fix leak in devfreq_dev_release()

Brian Foster (1):
      tracing: Zero the pipe cpumask on alloc to avoid spurious -EBUSY

Budimir Markovic (1):
      net/sched: sch_hfsc: Ensure inner classes have fsc curve

Chengfeng Ye (2):
      scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
      scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock

Chris Lew (1):
      soc: qcom: qmi_encdec: Restrict string length in decode

Christian Brauner (1):
      tmpfs: verify {g,u}id mount options correctly

Christian Göttsche (1):
      security: keys: perform capable check only on privileged operations

Christoph Hellwig (4):
      mmc: au1xmmc: force non-modular build and remove symbol_get usage
      net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index
      rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
      modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules

Christophe JAILLET (2):
      media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()
      media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()

Christophe Leroy (1):
      powerpc/perf: Convert fsl_emb notifier to state machine callbacks

Chuck Lever (1):
      NFSD: da_addr_body field missing in some GETDEVICEINFO replies

Chunyan Zhang (2):
      serial: sprd: Assign sprd_port after initialized to avoid wrong access
      serial: sprd: Fix DMA buffer leak issue

Claudiu Beznea (2):
      pinctrl: mcp23s08: check return value of devm_kasprintf()
      media: i2c: tvp5150: check return value of devm_kasprintf()

Colin Ian King (1):
      media: go7007: Remove redundant if statement

Colin Xu (1):
      drm/i915/gvt: Save/restore HW status to support GVT suspend/resume

Corey Minyard (1):
      ipmi:ssif: Fix a memory leak when scanning for an adapter

Corinna Vinschen (1):
      igb: disable virtualization features on 82580

D Scott Phillips (1):
      arm64: sdei: abort running SDEI handlers during crash

Damien Le Moal (2):
      ata: sata_gemini: Add missing MODULE_DESCRIPTION
      ata: pata_ftide010: Add missing MODULE_DESCRIPTION

Dan Carpenter (5):
      sctp: handle invalid error codes without calling BUG()
      regmap: rbtree: Use alloc_flags for memory allocations
      smackfs: Prevent underflow in smk_set_cipso()
      nfs/blocklayout: Use the passed in gfp flags
      driver core: test_async: fix an error code

Daniel T. Lee (1):
      samples/bpf: fix broken map lookup probe

Daniel Vetter (1):
      drm/msm/mdp5: Don't leak some plane state

Daniil Dulov (2):
      media: dib7000p: Fix potential division by zero
      media: cx24120: Add retval check for cx24120_message_send()

Dave Hansen (1):
      x86/speculation: Mark all Skylake CPUs as vulnerable to GDS

Dave Jiang (3):
      ntb: Drop packets when qp link is down
      ntb: Clean up tx tail index on link down
      ntb: Fix calculation ntb_transport_tx_free_entry()

Dave Stevenson (1):
      media: i2c: ov2680: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips

David Christensen (1):
      bnx2x: fix page fault following EEH recovery

David Woodhouse (1):
      eventfd: Export eventfd_ctx_do_read()

David Wronek (1):
      clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src

Dmitry Antipov (4):
      media: pulse8-cec: handle possible ping error
      wifi: mwifiex: fix error recovery in PCIE buffer descriptor management
      wifi: mwifiex: fix memory leak in mwifiex_histogram_read()
      wifi: mwifiex: avoid possible NULL skb pointer dereference

Dmitry Baryshkov (3):
      clk: qcom: gcc-sc7180: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-sm8250: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: gcc-mdm9615: use proper parent for pll0_vote clock

Dmitry Mastykin (1):
      netlabel: fix shift wrapping bug in netlbl_catmap_setlong()

Dmytro Maluka (2):
      ASoC: da7219: Flush pending AAD IRQ when suspending
      ASoC: da7219: Check for failure reading AAD IRQ events

Dominique Martinet (1):
      9p: virtio: make sure 'offs' is initialized in zc_request

Dongliang Mu (1):
      drivers: usb: smsusb: fix error handling code in smsusb_init_device

Eddie James (1):
      fsi: aspeed: Reset master errors after CFAM reset

Edgar (1):
      ASoc: codecs: ES8316: Fix DMIC config

Enlin Mu (1):
      pstore/ram: Check start of empty przs during init

Eric Biggers (1):
      fsverity: skip PKCS#7 parser when keyring is empty

Eric Dumazet (8):
      tcp: tcp_enter_quickack_mode() should be static
      igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
      net/sched: fq_pie: avoid stalls in fq_pie_timer()
      sctp: annotate data-races around sk->sk_wmem_queued
      ipv4: annotate data-races around fi->fib_dead
      net: read sk->sk_family once in sk_mc_loop()
      ip_tunnels: use DEV_STATS_INC()
      ipv6: fix ip6_sock_set_addr_preferences() typo

Eric Snowberg (1):
      ovl: Always reevaluate the file signature for IMA

Fabio Estevam (1):
      drm/msm/a2xx: Call adreno_gpu_init() earlier

Fedor Pchelkin (3):
      wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx
      wifi: ath9k: protect WMI command response buffer replacement with a lock
      NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info

Filipe Manana (1):
      btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART

Florian Fainelli (1):
      hwrng: iproc-rng200 - Implement suspend and resume calls

Gao Xiang (1):
      erofs: ensure that the post-EOF tails are all zeroed

Gaosheng Cui (1):
      audit: fix possible soft lockup in __audit_inode_child()

Gaurav Jain (1):
      crypto: caam - fix unchecked return value error

Geert Uytterhoeven (2):
      drm/armada: Fix off-by-one error in armada_overlay_get_property()
      of: unittest: Fix overlay type in apply/revert check

Greg Kroah-Hartman (2):
      media: dvb: symbol fixup for dvb_attach()
      Linux 5.10.195

Guangguan Wang (1):
      net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in smcr_port_add

Guiting Shen (1):
      ASoC: atmel: Fix the 8K sample parameter in I2SC master

Guoqing Jiang (3):
      md/bitmap: don't set max_write_behind if there is no write mostly device
      RDMA/siw: Balance the reference of cep->kref in the error path
      RDMA/siw: Correct wrong debug message

Gustavo A. R. Silva (2):
      ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()
      cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Hamza Mahfooz (1):
      drm/amd/display: prevent potential division by zero errors

Hangyu Hua (2):
      net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()
      net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()

Hans de Goede (6):
      platform/x86: intel: hid: Always call BTNL ACPI method
      media: ad5820: Drop unsupported ad5823 from i2c_ and of_device_id tables
      media: ov2680: Remove auto-gain and auto-exposure controls
      media: ov2680: Fix ov2680_bayer_order()
      media: ov2680: Fix vflip / hflip set functions
      media: ov2680: Fix regulators being left enabled on ov2680_power_on() errors

Hayes Wang (1):
      r8152: check budget for r8152_poll()

Helge Deller (4):
      parisc: Fix /proc/cpuinfo output for lscpu
      parisc: led: Fix LAN receive and transmit LEDs
      parisc: led: Reduce CPU overhead for disk & lan LED computation
      parisc: Drop loops_per_jiffy from per_cpu struct

Herbert Xu (1):
      crypto: api - Use work queue in crypto_destroy_instance

Holger Dengler (2):
      s390/pkey: fix/harmonize internal keyblob headers
      s390/paes: fix PKEY_TYPE_EP11_AES handling for secure keyblobs

Hsin-Yi Wang (1):
      mtd: spi-nor: Check bus width while setting QE bit

Hugo Villeneuve (2):
      serial: sc16is7xx: fix broken port 0 uart init
      serial: sc16is7xx: fix bug when first setting GPIO direction

Ilpo Järvinen (9):
      selftests/resctrl: Don't leak buffer in fill_cache()
      selftests/resctrl: Unmount resctrl FS if child fails to run benchmark
      selftests/resctrl: Close perf value read fd on errors
      PCI: pciehp: Use RMW accessors for changing LNKCTL
      PCI/ASPM: Use RMW accessors for changing LNKCTL
      drm/amdgpu: Use RMW accessors for changing LNKCTL
      drm/radeon: Use RMW accessors for changing LNKCTL
      net/mlx5: Use RMW accessors for changing LNKCTL
      wifi: ath10k: Use RMW accessors for changing LNKCTL

Irui Wang (1):
      media: mediatek: vcodec: Return NULL if no vdec_fb is found

Jan Kara (1):
      udf: Handle error when adding extent to a file

Jann Horn (1):
      dccp: Fix out of bounds access in DCCP error handler

Janusz Krzysztofik (1):
      x86/mm: Fix PAT bit missing from page protection modify mask

Jiasheng Jiang (3):
      drm: xlnx: zynqmp_dpsub: Add missing check for dma_set_mask
      ipmi:ssif: Add check for kstrdup
      rpmsg: glink: Add check for kstrdup

Jinjie Ruan (2):
      Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()
      net: arcnet: Do not call kfree_skb() under local_irq_disable()

Jiri Benc (1):
      vxlan: generalize vxlan_parse_gpe_hdr and remove unused args

Johan Hovold (1):
      serial: qcom-geni: fix opp vote on shutdown

Jonas Karlman (2):
      phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
      phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write

Jordan Rife (1):
      net: Avoid address overwrite in kernel_connect

Joy Zou (1):
      ARM: dts: imx: update sdma node name format

Juerg Haefliger (1):
      fsi: master-ast-cf: Add MODULE_FIRMWARE macro

Kees Cook (2):
      selftests/harness: Actually report SKIP for signal tests
      printk: ringbuffer: Fix truncating buffer size min_t cast

Kemeng Shi (1):
      ext4: correct grp validation in ext4_mb_good_group

Konrad Dybcio (2):
      arm64: dts: qcom: msm8996: Add missing interrupt to the USB2 controller
      clk: qcom: reset: Use the correct type of sleep/delay based on length

Konstantin Meskhidze (1):
      kconfig: fix possible buffer overflow

Konstantin Shelekhin (1):
      platform/x86: huawei-wmi: Silence ambient light sensor

Krzysztof Kozlowski (6):
      ARM: dts: s3c64xx: align pinctrl with dtschema
      ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)
      ARM: dts: s5pv210: adjust node names to DT spec
      ARM: dts: s5pv210: add dummy 5V regulator for backlight on SMDKv210
      ARM: dts: samsung: s5pv210-smdkv210: correct ethernet reg addresses (split)
      dt-bindings: clock: xlnx,versal-clk: drop select:false

Kuniyuki Iwashima (6):
      netrom: Deny concurrent connect().
      af_unix: Fix data-races around user->unix_inflight.
      af_unix: Fix data-race around unix_tot_inflight.
      af_unix: Fix data-races around sk->sk_shutdown.
      af_unix: Fix data race around sk->sk_err.
      kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Kyle Zeng (1):
      netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

Leo Chen (1):
      drm/amd/display: Exit idle optimizations before attempt to access PHY

Leon Romanovsky (1):
      Revert "IB/isert: Fix incorrect release of isert connection"

Liang Chen (1):
      veth: Fixing transmit return status for dropped packets

Liao Chang (2):
      cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()
      cpufreq: Fix the race condition while updating the transition_task of policy

Liming Sun (2):
      platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descriptors
      platform/mellanox: mlxbf-tmfifo: Drop jumbo frames

Lin Ma (5):
      wifi: mt76: testmode: add nla_policy for MT76_TM_ATTR_TX_LENGTH
      scsi: iscsi: Add length check for nlattr payload
      scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()
      scsi: be2iscsi: Add length check when parsing nlattrs
      scsi: qla4xxx: Add length check when parsing nlattrs

Liu Jian (2):
      net: ipv4: fix one memleak in __inet_del_ifa()
      net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

Lorenz Bauer (2):
      udp: re-score reuseport groups when connected sockets are present
      bpf: reject unhashed sockets in bpf_sk_assign

Lu Jialin (1):
      cgroup:namespace: Remove unused cgroup_namespaces_init()

Luca Weiss (2):
      soc: qcom: ocmem: Add OCMEM hardware version print
      soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros

Lucas Stach (1):
      drm/etnaviv: fix dumping of active MMU context

Luke Lu (1):
      usb: dwc3: meson-g12a: do post init to fix broken usb after resumption

Luo Jiaxing (1):
      scsi: hisi_sas: Print SAS address for v3 hw erroneous completion print

Manish Rangankar (1):
      scsi: qla2xxx: Remove unsupported ql2xenabledif option

Manivannan Sadhasivam (3):
      OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
      arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
      arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM

Marco Felsch (2):
      clk: imx8mp: fix sai4 clock
      usb: typec: tcpci: clear the fault status bit

Marek Vasut (4):
      ARM: dts: imx7s: Drop dma-apb interrupt-names
      drm/bridge: tc358764: Fix debug print parameter order
      drm/panel: simple: Add missing connector type and pixel format for AUO T215HVN01
      media: ov5640: Enable MIPI interface in ov5640_set_power_mipi()

Mario Limonciello (1):
      pinctrl: amd: Don't show `Invalid config param` errors

Martin Kaiser (1):
      hwrng: nomadik - keep clock enabled while hwrng is registered

Martin Kohn (2):
      USB: serial: option: add Quectel EM05G variant (0x030e)
      net: usb: qmi_wwan: add Quectel EM05GV2

Masami Hiramatsu (Google) (1):
      kprobes: Prohibit probing on CFI preamble symbol

Matthew Wilcox (1):
      reiserfs: Check the return value from __getblk()

Max Filippov (1):
      xtensa: PMU: fix base address for the newer hardware

Menglong Dong (1):
      net: tcp: fix unexcepted socket die when snd_wnd is 0

Michael Ellerman (1):
      powerpc: Don't include lppaca.h in paca.h

Michael Kelley (1):
      scsi: storvsc: Always set no_report_opcodes

Mikel Rychliski (1):
      x86/efistub: Fix PCI ROM preservation in mixed mode

Min Li (1):
      Bluetooth: Fix potential use-after-free when clear keys

Minjie Du (2):
      ata: pata_arasan_cf: Use dev_err_probe() instead dev_err() in data_xfer()
      drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()

Mohamed Khalfella (1):
      skbuff: skb_segment, Call zero copy functions before using skbuff frags

Nam Cao (1):
      staging: rtl8712: fix race condition

Namhyung Kim (3):
      perf hists browser: Fix hierarchy mode header
      perf tools: Handle old data in PERF_RECORD_ATTR
      perf hists browser: Fix the number of entries for 'e' key

Nayna Jain (1):
      ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig

Nicolas Dichtel (1):
      net: handle ARPHRD_PPP in dev_is_mac_header_xmit()

Nikita Zhandarovich (1):
      HID: logitech-dj: Fix error handling in logi_dj_recv_switch_to_dj_mode()

Nikolay Burykin (1):
      media: pci: cx23885: fix error handling for cx23885 ATSC boards

Nilesh Javali (1):
      Revert "scsi: qla2xxx: Fix buffer overrun"

Oder Chiou (1):
      ASoC: rt5682: Fix a problem with error handling in the io init function of the soundwire

Oleksandr Natalenko (3):
      scsi: qedf: Do not touch __user pointer in qedf_dbg_stop_io_on_error_cmd_read() directly
      scsi: qedf: Do not touch __user pointer in qedf_dbg_debug_cmd_read() directly
      scsi: qedf: Do not touch __user pointer in qedf_dbg_fp_int_cmd_read() directly

Olga Kornievskaia (1):
      NFSv4.2: fix handling of COPY ERR_OFFLOAD_NO_REQ

Olga Zaborska (3):
      igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
      igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
      igb: Change IGB_MIN to allow set rx/tx value between 64 and 80

Patrick Whewell (1):
      clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src

Paul Cercueil (1):
      ARM: dts: samsung: exynos4210-i9100: Fix LCD screen's physical size

Pavel Begunkov (3):
      io_uring: always lock in io_apoll_task_func
      io_uring: break out of iowq iopoll on teardown
      io_uring: break iopolling on signal

Peng Fan (1):
      amba: bus: fix refcount leak

Petr Tesarik (1):
      sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()

Polaris Pi (2):
      wifi: mwifiex: Fix OOB and integer underflow when rx packets
      wifi: mwifiex: Fix missed return in oob checks failed path

Przemek Kitszel (1):
      ice: ice_aq_check_events: fix off-by-one check when filling buffer

Qiang Yu (1):
      bus: mhi: host: Skip MHI reset if device is in RDDM

Quan Tian (1):
      net/ipv6: SKB symmetric hash should incorporate transport ports

Quinn Tran (7):
      scsi: qla2xxx: Fix deletion race condition
      scsi: qla2xxx: fix inconsistent TMF timeout
      scsi: qla2xxx: Fix erroneous link up failure
      scsi: qla2xxx: Turn off noisy message log
      scsi: qla2xxx: Consolidate zio threshold setting for both FCP & NVMe
      scsi: qla2xxx: Fix crash in PCIe error handling
      scsi: qla2xxx: Flush mailbox commands on chip reset

RD Babiera (1):
      usb: typec: bus: verify partner exists in typec_altmode_attention

Raag Jadav (2):
      pinctrl: cherryview: fix address_space_handler() argument
      watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load

Radoslaw Tyl (1):
      igb: set max size RX buffer when store bad packet is enabled

Rafał Miłecki (5):
      ARM: dts: BCM53573: Describe on-SoC BCM53125 rev 4 switch
      ARM: dts: BCM53573: Drop nonexistent #usb-cells
      ARM: dts: BCM53573: Add cells sizes to PCIe node
      ARM: dts: BCM53573: Use updated "spi-gpio" binding properties
      ARM: dts: BCM53573: Fix Ethernet info for Luxul devices

Rahul Rameshbabu (1):
      HID: multitouch: Correct devm device reference for hidinput input_dev name

Randy Dunlap (3):
      ASoC: stac9766: fix build errors with REGMAP_AC97
      x86/APM: drop the duplicate APM_MINOR_DEV macro
      um: Fix hostaudio build errors

Ranjan Kumar (1):
      scsi: mpt3sas: Perform additional retries if doorbell read returns 0

Rob Clark (1):
      dma-buf/sync_file: Fix docs syntax

Ruan Jinjie (1):
      of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()

Ruidong Tian (1):
      coresight: tmc: Explicit type conversions to prevent integer overflow

Russell Currey (2):
      powerpc/pseries: Rework lppaca_shared_proc() to avoid DEBUG_PREEMPT
      powerpc/iommu: Fix notifiers being shared by PCI and VIO buses

Ryusuke Konishi (2):
      nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix WARNING in mark_buffer_dirty due to discarded buffer reuse

Sabrina Dubroca (1):
      Revert "net: macsec: preserve ingress frame ordering"

Saurav Kashyap (1):
      scsi: qla2xxx: If fcport is undergoing deletion complete I/O with retry

Sean Christopherson (2):
      x86/virt: Drop unnecessary check on extended CPUID level in cpu_has_svm()
      drm/i915/gvt: Drop unused helper intel_vgpu_reset_gtt()

SeongJae Park (1):
      selftests/kselftest/runner/run_one(): allow running non-executable files

Serge Semin (1):
      ARM: dts: BCM5301X: Harmonize EHCI/OHCI DT nodes name

Shigeru Yoshida (2):
      kcm: Destroy mutex in kcm_exit_net()
      kcm: Fix memory leak in error path of kcm_sendmsg()

Shih-Yi Chen (1):
      platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications

Shuai Xue (1):
      ACPI: APEI: explicit init of HEST and GHES in apci_init()

Sishuai Gong (1):
      configfs: fix a race in configfs_lookup()

Slark Xiao (1):
      USB: serial: option: add FOXCONN T99W368/T99W373 product

Sourabh Jain (1):
      powerpc/fadump: reset dump area size if fadump memory reserve fails

Srinivasan Shanmugam (1):
      drm/amdgpu: Update min() to min_t() in 'amdgpu_info_ioctl'

Sriram Yagnaraman (1):
      ipv4: ignore dst hint for multipath routes

Stefan Haberland (2):
      s390/dasd: use correct number of retries for ERP requests
      s390/dasd: fix hanging device after request requeue

Stefan Hajnoczi (1):
      vfio/type1: fix cap_migration information leak

Stefan Wahren (1):
      ARM: dts: imx: Adjust dma-apbh node name

Su Hui (2):
      ALSA: ac97: Fix possible error value of *rac97
      fs: lockd: avoid possible wrong NULL parameter

Sui Jingfeng (1):
      drm/mediatek: Fix potential memory leak if vmap() fail

Sven Schnelle (1):
      s390/ipl: add missing secure/has_secure file to ipl type 'unknown'

Takashi Iwai (2):
      ALSA: seq: oss: Fix racy open/close of MIDI devices
      ALSA: pcm: Fix missing fixup call in compat hw_refine ioctl

Tan Zhongjun (1):
      drm/tegra: Remove superfluous error messages around platform_get_irq()

Thomas Bourgoin (1):
      crypto: stm32 - fix loop iterating through scatterlist for DMA

Thomas Zimmermann (5):
      backlight/gpio_backlight: Compare against struct fb_info.device
      backlight/bd6107: Compare against struct fb_info.device
      backlight/lv5207lp: Compare against struct fb_info.device
      fbdev/ep93xx-fb: Do not assign to struct fb_info.dev
      drm/ast: Fix DRAM init on AST2200

Thore Sommer (1):
      X.509: if signature is unsupported skip validation

Tom Rix (1):
      udf: initialize newblock to 0

Tony Battersby (1):
      scsi: core: Use 32-bit hostnum in scsi_host_lookup()

Tony Lindgren (2):
      bus: ti-sysc: Fix build warning for 64-bit build
      bus: ti-sysc: Fix cast to enum warning

Trond Myklebust (1):
      NFS: Fix a potential data corruption

Uwe Kleine-König (1):
      crypto: stm32 - Properly handle pm_runtime_get failing

Vadim Fedorenko (1):
      ixgbe: fix timestamp configuration code

Vadim Pasternak (2):
      mlxsw: i2c: Fix chunk size setting in output mailbox buffer
      mlxsw: i2c: Limit single transaction buffer size

Vladimir Oltean (2):
      net: dsa: sja1105: fix bandwidth discrepancy between tc-cbs software and offload
      net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many times

Vladimir Zapolskiy (1):
      pwm: lpc32xx: Remove handling of PWM channels

Vladislav Efanov (1):
      udf: Check consistency of Space Bitmap Descriptor

Waiman Long (1):
      refscale: Fix uninitalized use of wait_queue_head_t

Wander Lairson Costa (3):
      netfilter: xt_u32: validate user space input
      netfilter: xt_sctp: validate the flag_info count
      netfilter: nfnetlink_osf: avoid OOB read

Wang Jianjian (1):
      ext4: add correct group descriptors and reserved GDT blocks to system zone

Wang Ming (3):
      firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
      fs: Fix error checking for d_hash_and_lookup()
      wifi: ath9k: use IS_ERR() with debugfs_create_dir()

Wen Yang (1):
      eventfd: prevent underflow for eventfd semaphores

Wenchao Hao (1):
      scsi: iscsi: Rename iscsi_set_param() to iscsi_if_set_param()

Wesley Chalmers (1):
      drm/amd/display: Fix a bug when searching for insert_above_mpcc

Will Deacon (1):
      arm64: csum: Fix OoB access in IP checksum code for negative lengths

William Zhang (4):
      mtd: rawnand: brcmnand: Fix mtd oobsize
      mtd: rawnand: brcmnand: Fix crash during the panic_write
      mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write
      mtd: rawnand: brcmnand: Fix potential false time out warning

Winston Wen (1):
      fs/nls: make load_nls() take a const parameter

Wu Zongyong (1):
      PCI: Mark NVIDIA T4 GPUs to avoid bus reset

Xiang Yang (1):
      IB/uverbs: Fix an potential error pointer dereference

Xiaolei Wang (1):
      ARM: dts: imx: Set default tuning step for imx7d usdhc

Xingui Yang (4):
      scsi: hisi_sas: Modify v3 HW SSP underflow error processing
      scsi: hisi_sas: Modify v3 HW SATA completion error processing
      scsi: hisi_sas: Fix warnings detected by sparse
      scsi: hisi_sas: Fix normally completed I/O analysed as failed

Xu Yang (3):
      usb: chipidea: imx: improve logic if samsung,picophy-* parameter is 0
      perf/imx_ddr: don't enable counter0 if none of 4 counters are used
      usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()

Yafang Shao (1):
      bpf: Clear the probe_addr for uprobe

Yan Zhai (2):
      lwt: Fix return values of BPF xmit ops
      lwt: Check LWTUNNEL_XMIT_CONTINUE strictly

Yanfei Xu (1):
      iommu/vt-d: Fix to flush cache of PASID directory table

Yang Wang (1):
      drm/amd/pm: fix variable dereferenced issue in amdgpu_device_attr_create()

Yangtao Li (1):
      drm/tegra: dpaux: Fix incorrect return value of platform_get_irq

Yi Yang (3):
      serial: tegra: handle clk prepare error in tegra_uart_hw_init()
      mtd: rawnand: fsmc: handle clk prepare error in fsmc_nand_resume()
      ipmi_si: fix a memleak in try_smi_init()

Ying Liu (1):
      backlight: gpio_backlight: Drop output GPIO direction check for initial power state

Yipeng Zou (1):
      selftests/bpf: Clean up fmod_ret in bench_rename test script

Yisen Zhuang (1):
      net: hns3: fix the port information display when sfp is absent

Yu Kuai (2):
      md/md-bitmap: hold 'reconfig_mutex' in backlog_store()
      md/md-bitmap: remove unnecessary local variable in backlog_store()

Yuan Yao (1):
      virtio_ring: fix avail_wrap_counter in virtqueue_add_packed

Yuanjun Gong (2):
      ethernet: atheros: fix return value check in atl1c_tso_csum()
      Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()

Zhang Jianhua (1):
      clk: sunxi-ng: Modify mismatched function name

Zhang Shurong (2):
      spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()
      firmware: meson_sm: fix to avoid potential NULL pointer dereference

Zheng Wang (1):
      Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition

Zheng Yang (1):
      phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate

Zheng Yejian (2):
      tracing: Introduce pipe_cpumask to avoid race on trace_pipes
      tracing: Fix race issue between cpu buffer write and swap

Ziyang Xuan (1):
      hsr: Fix uninit-value access in fill_frame_info()

ruanjinjie (1):
      dmaengine: ste_dma40: Add missing IRQ check in d40_probe

ruanmeisi (1):
      fuse: nlookup missing decrement in fuse_direntplus_link

valis (1):
      net: sched: sch_qfq: Fix UAF in qfq_dequeue()

