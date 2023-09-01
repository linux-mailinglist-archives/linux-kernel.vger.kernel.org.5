Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4783378FFDF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350198AbjIAPVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350192AbjIAPVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:21:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8E310FD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B354FCE23EE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBC9C433C7;
        Fri,  1 Sep 2023 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693581669;
        bh=jQj2HgW/veDC2aMokwQZSAIcWh5jEF+v9kOqKMeeOzA=;
        h=Date:From:To:Cc:Subject:From;
        b=T7I9C7JRK0tjN5DwGvHShszEST5NxmRIhvVQHbAryHEJLTjaRQJUY37joUxTwI2Hl
         nrL8entcuQZRo4G696L8iadvM6lcMennvqKciuLo/q6qBKUUOnkMNqfF7wMmmB5kSs
         Yx5zI6BKx1nv27GYUmZ2JQHXIHmaYkyoWzQFcdH0=
Date:   Fri, 1 Sep 2023 17:21:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 6.6-rc1
Message-ID: <ZPIBYsxu-MeeQCiK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc1

for you to fetch changes up to 704e2c6107f1a5353a1038bac137dda0df2a6dd0:

  Merge tag 'icc-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next (2023-08-24 14:00:14 +0200)

----------------------------------------------------------------
Char/Misc driver changes for 6.6-rc1

Here is the big set of char/misc and other small driver subsystem
changes for 6.6-rc1.

Stuff all over the place here, lots of driver updates and changes and
new additions.  Short summary is:
  - new IIO drivers and updates
  - Interconnect driver updates
  - fpga driver updates and additions
  - fsi driver updates
  - mei driver updates
  - coresight driver updates
  - nvmem driver updates
  - counter driver updates
  - lots of smaller misc and char driver updates and additions

All of these have been in linux-next for a long time with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (3):
      mei: log firmware status on hw_start failure.
      mei: bus: enable asynchronous suspend.
      mei: obtain firmware version only on gsc.

Alisa Roman (1):
      iio: adc: ad7192: Use sysfs_emit_at

Alper Nebi Yasak (1):
      firmware: coreboot: framebuffer: Allow building with simpledrm

Andrea Collamati (2):
      dt-bindings: iio: dac: add mcp4728.yaml
      iio: add MCP4728 I2C DAC driver

Andrei Coardos (1):
      iio: trigger: stm32-lptimer-trigger: remove unneeded platform_set_drvdata()

Andy Shevchenko (6):
      iio: core: Use min() instead of min_t() to make code more robust
      iio: core: Get rid of redundant 'else'
      iio: core: Improve indentation in a few places
      iio: core: Use sysfs_match_string() helper
      iio: core: Switch to krealloc_array()
      iio: core: Fix issues and style of the comments

Anshuman Khandual (6):
      coresight: etm4x: Allocate and device assign 'struct etmv4_drvdata' earlier
      coresight: etm4x: Drop iomem 'base' argument from etm4_probe()
      coresight: etm4x: Drop pid argument from etm4_probe()
      coresight: etm4x: Change etm4_platform_driver driver for MMIO devices
      coresight: trbe: Directly use ID_AA64DFR0_EL1_TraceBuffer_IMP
      coresight: etm4x: Ensure valid drvdata and clock before clk_put()

Antoniu Miclaus (5):
      dt-bindings: iio: admv1014: make all regs required
      dt-bindings: iio: admv1013: add vcc regulators
      drivers: iio: admv1013: add vcc regulators
      drivers: iio: filter: admv8818: add bypass mode
      Documentation: ABI: testing: admv8818: add bypass

Arnd Bergmann (2):
      extcon: cht_wc: add POWER_SUPPLY dependency
      bus: mhi: host: remove unused-but-set parameter

Astrid Rost (8):
      iio: light: vcnl4000: Add proximity irq for vcnl4200
      iio: light: vcnl4000: Add proximity ps_it for vcnl4200
      iio: light: vcnl4000: Check type with switch case
      iio: light: vcnl4000: Add als_it for vcnl4040/4200
      iio: light: vcnl4000: add illuminance irq vcnl4040/4200
      iio: light: vcnl4000: Add period for vcnl4040/4200
      iio: light: vcnl4000: Add oversampling_ratio for 4040/4200
      iio: light: vcnl4000: Add calibration bias for 4040/4200

Atul Raut (1):
      nvmem: u-boot-env:: Replace zero-length array with DECLARE_FLEX_ARRAY() helper

Baoquan He (3):
      char: xillybus: make XILLYBUS_OF depend on HAS_IOMEM
      misc: open-dice: make OPEN_DICE depend on HAS_IOMEM
      pcmcia : make PCMCIA depend on HAS_IOMEM

Biju Das (7):
      iio: accel: adxl355: Simplify probe()
      iio: accel: adxl313: Fix adxl313_i2c_id[] table
      iio: accel: adxl313: Use i2c_get_match_data
      iio: potentiometer: mcp4018: Use i2c_get_match_data()
      iio: potentiometer: mcp4531: Use i2c_get_match_data()
      Documentation: ABI: sysfs-bus-counter: Fix indentation
      counter: rz-mtu3-cnt: Reorder locking sequence for consistency

Brian Norris (1):
      MAINTAINERS: Add drivers/firmware/google/ entry

Chengfeng Ye (1):
      misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock

Chenyuan Mi (1):
      tools: iio: iio_generic_buffer: Fix some integer type and calculation

Christophe JAILLET (2):
      iio: adc: ad7192: Simplify using devm_clk_get_optional_enabled()
      mei: pxp: Keep a const qualifier when calling mei_cldev_send()

Dan Carpenter (1):
      misc: microchip: pci1xxxx: Fix some NULL vs IS_ERR() bugs

Daniele Palmas (1):
      bus: mhi: host: pci_generic: add support for Telit FE990 modem

Diederik de Haas (1):
      nvmem: Kconfig: Fix typo "drive" -> "driver"

Dmitry Baryshkov (1):
      dt-bindings: iio: adc: qcom,spmi-adc7: use predefined channel ids

Duke Xin (辛安文) (3):
      bus: mhi: host: pci_generic: Add support for Quectel EM160R-GL modem
      bus: mhi: host: pci_generic: Add support for Quectel RM520N-GL modem
      bus: mhi: host: pci_generic: Add support for Quectel RM520N-GL Lenovo variant

Eddie James (15):
      fsi: Move fsi_slave structure definition to header
      fsi: Add aliased device numbering
      fsi: Use of_match_table for bus matching if specified
      fsi: sbefifo: Don't check status during probe
      fsi: sbefifo: Add configurable in-command timeout
      fsi: sbefifo: Remove limits on user-specified read timeout
      fsi: aspeed: Reset master errors after CFAM reset
      fsi: core: Add trace events for scan and unregister
      fsi: core: Fix legacy minor numbering
      fsi: core: Switch to ida_alloc/free
      fsi: Improve master indexing
      fsi: Lock mutex for master device registration
      dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
      fsi: Add IBM I2C Responder virtual FSI master
      fsi: Add I2C Responder SCOM driver

Ekansh Gupta (3):
      misc: fastrpc: Fix remote heap allocation request
      misc: fastrpc: Fix incorrect DMA mapping unmap request
      misc: fastrpc: Pass proper scm arguments for static process init

George Stark (9):
      iio: adc: meson: remove unused timestamp channel
      iio: adc: meson: move enums declaration before variables declaration
      iio: adc: meson: move meson_sar_adc_set_chan7_mux routine upper
      iio: adc: meson: add enum for iio channel numbers
      iio: adc: meson: add channel labels
      iio: adc: meson: support reading from channel 7 mux inputs
      iio: adc: meson: init channels 0,1 input muxes
      iio: adc: meson: init internal continuous ring counter
      iio: adc: meson: init voltage control bits

Georgi Djakov (8):
      Merge branch 'qcom/20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git into icc-next
      interconnect: qcom: icc-rpm: Explicitly return 0 at the end of the function
      Merge branch 'icc-sm8250-qup' into icc-next
      Merge tag 'v6.5-rc6' into icc-next
      Merge branch 'icc-qcm2290' into icc-next
      Merge branch 'icc-enable-mask' into icc-next
      Merge branch 'icc-retire-macros' into icc-next
      Merge branch 'icc-debugfs' into icc-next

Greg Kroah-Hartman (11):
      Merge 6.5-rc4 into char-misc-next
      Merge tag 'peci-next-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next
      Merge tag 'iio-for-6.6a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'fsi-for-v6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi into char-misc-next
      Merge tag 'mhi-for-v6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge 6.5-rc6 into char-misc-next
      Merge tag 'fpga-for-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'counter-updates-for-6.6a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge tag 'coresight-next-v6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'extcon-next-for-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge tag 'icc-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next

Hans de Goede (1):
      iio: accel: da280: Add support for the DA217 accelerometer

Ivan Orlov (6):
      fpga: bridge: make fpga_bridge_class a static const structure
      fpga: fpga-mgr: make fpga_mgr_class a static const structure
      fpga: region: make fpga_region_class a static const structure
      misc: genwqe: make class_genwqe a static const structure
      misc: hpilo: make ilo_class a static const structure
      mei: make mei_class a static const structure

Iwona Winiarska (2):
      ARM: dts: nuvoton: Add PECI controller node
      arm64: dts: nuvoton: Add PECI controller node

James Clark (1):
      coresight: Fix all W=1 build warnings

Jean-Baptiste Maneyrol (5):
      iio: imu: inv_icm42600: make timestamp module chip independent
      iio: move inv_icm42600 timestamp module in common
      iio: make invensense timestamp module generic
      iio: imu: inv_mpu6050: use the common inv_sensors timestamp module
      iio: imu: inv_mpu6050: read the full fifo when processing data

Jeffrey Hugo (1):
      docs: ABI: sysfs-bus-mhi: Update contact info

Juerg Haefliger (1):
      fsi: master-ast-cf: Add MODULE_FIRMWARE macro

Julia Lawall (1):
      bus: mhi: host: use vmalloc_array and vcalloc

Junhao He (2):
      coresight: Fix memory leak in acpi_buffer->pointer
      coresight: trbe: Fix TRBE potential sleep in atomic context

Kalle Valo (1):
      bus: mhi: host: allow MHI client drivers to provide the firmware via a pointer

Kees Cook (3):
      interconnect: icc-clk: Annotate struct icc_clk_provider with __counted_by
      interconnect: Annotate struct icc_path with __counted_by
      interconnect: qcom: Annotate struct icc_onecell_data with __counted_by

Kim Seer Paller (1):
      iio: amplifiers: ad8366: add support for HMC792A Attenuator

Komal Bajaj (2):
      dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
      nvmem: sec-qfprom: Add Qualcomm secure QFPROM support

Konrad Dybcio (54):
      dt-bindings: interconnect: qcom,bwmon: Document SC7180 BWMONs
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM8250 bwmon instances
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM6350 bwmon instances
      dt-bindings: interconnect: Add Qcom RPM ICC bindings
      soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
      soc: qcom: smd-rpm: Use tabs for defines
      clk: qcom: smd-rpm: Move some RPM resources to the common header
      interconnect: qcom: icc-rpm: Introduce keep_alive
      interconnect: qcom: Add missing headers in icc-rpm.h
      interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
      interconnect: qcom: smd-rpm: Add rpmcc handling skeleton code
      interconnect: qcom: Define RPM bus clocks
      interconnect: qcom: sdm660: Hook up RPM bus clk definitions
      interconnect: qcom: msm8996: Hook up RPM bus clk definitions
      interconnect: qcom: qcs404: Hook up RPM bus clk definitions
      interconnect: qcom: msm8939: Hook up RPM bus clk definitions
      interconnect: qcom: msm8916: Hook up RPM bus clk definitions
      interconnect: qcom: qcm2290: Hook up RPM bus clk definitions
      interconnect: qcom: icc-rpm: Control bus rpmcc from icc
      clk: qcom: smd-rpm: Separate out interconnect bus clocks
      interconnect: qcom: icc-rpm: Fix bucket number
      interconnect: qcom: icc-rpm: Set bandwidth on both contexts
      interconnect: qcom: icc-rpm: Set correct bandwidth through RPM bw req
      interconnect: qcom: icc-rpm: Fix bandwidth calculations
      dt-bindings: interconnect: qcom,rpmh: Add SM8250 QUP virt
      dt-bindings: interconnect: qcom,sm8250: Add QUP virt
      interconnect: qcom: sm8250: Fix QUP0 nodes
      iio: adc: qcom-spmi-adc5: Add ADC5_GPIO2_100K_PU
      interconnect: qcom: qcm2290: Enable keep_alive on all buses
      interconnect: qcom: qcm2290: Enable sync state
      interconnect: qcom: sm8450: Enable sync_state
      interconnect: qcom: bcm-voter: Improve enable_mask handling
      interconnect: qcom: bcm-voter: Use enable_maks for keepalive voting
      interconnect: qcom: sc7180: Retire DEFINE_QNODE
      interconnect: qcom: sdm670: Retire DEFINE_QNODE
      interconnect: qcom: sdm845: Retire DEFINE_QNODE
      interconnect: qcom: sdx55: Retire DEFINE_QNODE
      interconnect: qcom: sdx65: Retire DEFINE_QNODE
      interconnect: qcom: sm6350: Retire DEFINE_QNODE
      interconnect: qcom: sm8150: Retire DEFINE_QNODE
      interconnect: qcom: sm8250: Retire DEFINE_QNODE
      interconnect: qcom: sm8350: Retire DEFINE_QNODE
      interconnect: qcom: icc-rpmh: Retire DEFINE_QNODE
      interconnect: qcom: sc7180: Retire DEFINE_QBCM
      interconnect: qcom: sdm670: Retire DEFINE_QBCM
      interconnect: qcom: sdm845: Retire DEFINE_QBCM
      interconnect: qcom: sdx55: Retire DEFINE_QBCM
      interconnect: qcom: sdx65: Retire DEFINE_QBCM
      interconnect: qcom: sm6350: Retire DEFINE_QBCM
      interconnect: qcom: sm8150: Retire DEFINE_QBCM
      interconnect: qcom: sm8250: Retire DEFINE_QBCM
      interconnect: qcom: sm8350: Retire DEFINE_QBCM
      interconnect: qcom: icc-rpmh: Retire DEFINE_QBCM
      dt-bindings: nvmem: Add compatible for QCM2290

Krzysztof Kozlowski (4):
      dt-bindings: iio: semtech,sx9310: reference common schema for label
      dt-bindings: iio: semtech,sx9324: reference common schema for label
      dt-bindings: extcon: maxim,max77843: restrict connector properties
      dt-bindings: extcon: siliconmitus,sm5502-muic: document connector

Kumaravel Thiagarajan (2):
      misc: microchip: pci1xxxx: Add support to read and write into PCI1XXXX OTP via NVMEM sysfs
      misc: microchip: pci1xxxx: Add support to read and write into PCI1XXXX EEPROM via NVMEM sysfs

Leonard Göhrs (1):
      iio: adc: ti-lmp92064: add buffering support

Li Zetao (2):
      iio: adc: men_z188_adc: Remove redundant initialization owner in men_z188_driver
      misc: eeprom/idt_89hpesx: Use devm_kmemdup to replace devm_kmalloc + memcpy

Maksim Kiselev (3):
      iio: adc: Kconfig change description for Allwinner GPADC
      iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
      dt-bindings: iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC

Manivannan Sadhasivam (1):
      bus: mhi: host: pci_generic: Add support for IP_SW0 channels

Marco Felsch (1):
      dt-bindings: iio: adc: ti,ads1015: fix datarate max value and meaning

Marco Pagani (6):
      fpga: region: fix kernel-doc
      fpga: bridge: fix kernel-doc
      fpga: add an initial KUnit suite for the FPGA Manager
      fpga: add an initial KUnit suite for the FPGA Bridge
      fpga: add an initial KUnit suite for the FPGA Region
      fpga: add configuration for the FPGA KUnit test suites.

Markus Burri (1):
      iio: adi: ad7192: Add error check and more debug log

Matti Lehtimäki (1):
      dt-bindings: nvmem: qfprom: Add compatible for MSM8226

Matti Vaittinen (5):
      iio: mb1232: relax return value check for IRQ get
      iio: cdc: ad7150: relax return value check for IRQ get
      dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor
      iio: light: bu27008: add chip info
      iio: light: bd27008: Support BD27010 RGB

Mike Tipton (3):
      debugfs: Add write support to debugfs_create_str()
      interconnect: Reintroduce icc_get()
      interconnect: Add debugfs test client

Miquel Raynal (4):
      nvmem: core: Create all cells before adding the nvmem device
      nvmem: core: Return NULL when no nvmem layout is found
      nvmem: core: Do not open-code existing functions
      nvmem: core: Notify when a new layout is registered

Naresh Solanki (1):
      peci: cpu: Add Intel Sapphire Rapids support

Patrick Rudolph (2):
      hwmon: (peci/cputemp) Add Intel Sapphire Rapids support
      hwmon: (peci/dimmtemp) Add Sapphire Rapids support

Peng Fan (1):
      amba: bus: fix refcount leak

Peter Colberg (1):
      fpga: dfl: fme: use SI unit prefix macros

Qiang Yu (1):
      bus: mhi: host: Skip MHI reset if device is in RDDM

Radu Bacrau (1):
      firmware: stratix10-rsu: query spt addresses

Rafał Miłecki (1):
      dt-bindings: nvmem: fixed-cell: add compatible for MAC cells

Ramona Bolboaca (2):
      iio: imu: adis16475.c: Remove unused enum elements
      iio: imu: adis16475.c: Add has_burst32 flag to adis16477 devices

Randy Dunlap (2):
      x86/APM: drop the duplicate APM_MINOR_DEV macro
      docs: ABI: fix spelling/grammar in SBEFIFO timeout interface

Richard Acayan (1):
      dt-bindings: interconnect: OSM L3: add SDM670 compatible

Richard Alpe (2):
      dt-bindings: nvmem: Add t1023-sfp efuse support
      nvmem: add new NXP QorIQ eFuse driver

Roan van Dijk (1):
      iio: chemical: scd4x: Add pressure compensation

Rob Clark (3):
      dma-buf/sync_file: Fix docs syntax
      interconnect: Fix locking for runpm vs reclaim
      interconnect: Teach lockdep about icc_bw_lock order

Rob Herring (11):
      interconnect: Explicitly include correct DT includes
      fpga: Explicitly include correct DT includes
      iio: adc: Explicitly include correct DT includes
      hwtracing: coresight: Explicitly include correct DT includes
      char: Explicitly include correct DT includes
      misc: Explicitly include correct DT includes
      cdx: Explicitly include correct DT includes
      fsi: Explicitly include correct DT includes
      fsi: Use of_property_read_reg() to parse "reg"
      counter: Explicitly include correct DT includes
      nvmem: Explicitly include correct DT includes

Ruan Jinjie (5):
      iio: adc: Remove redundant dev_err_probe()
      iio: adc: fix the return value handle for platform_get_irq()
      misc: hi6421-spmi-pmic: Remove redundant dev_err()
      misc: eeprom/idt_89hpesx: Switch to memdup_user_nul() helper
      misc: tps6594: Remove redundant dev_err_probe() for platform_get_irq_byname()

Ruidong Tian (1):
      coresight: tmc: Explicit type conversions to prevent integer overflow

Slark Xiao (1):
      bus: mhi: host: pci_generic: Add support for Dell DW5932e

Stephan Gerhold (1):
      soc: qcom: smd-rpm: Move icc_smd_rpm registration to clk-smd-rpm

Suzuki K Poulose (3):
      coresight: platform: acpi: Ignore the absence of graph
      coresight: etm4x: Add ACPI support in platform driver
      coresight: trbe: Allocate platform data per device

Teh Wen Ping (1):
      firmware: stratix10-svc: Generic Mailbox Command

Thomas Weißschuh (3):
      dyndbg: constify opt_array
      dyndbg: increase PREFIX_SIZE to 128
      dyndbg: add source filename to prefix

Tomas Winkler (1):
      mei: gsc: add module description

Tomer Maimon (2):
      dt-bindings: Add bindings for peci-npcm
      peci: Add peci-npcm controller driver

Uwe Kleine-König (5):
      binderfs: Drop unused #include <linux/radix-tree.h>
      misc: tps6594-pfsm: Convert to platform remove callback returning void
      misc: tps6594-esm: Convert to platform remove callback returning void
      counter: Declare counter_priv() to be const
      fsi: i2cr: Switch to use struct i2c_driver's .probe()

Wang Ming (2):
      firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
      android: Remove error checking for debugfs_create_dir()

Waqar Hameed (4):
      iio: Make return value check for set_trigger_state() consistent
      dt-bindings: iio: proximity: Add Murata IRS-D200
      iio: Add event enums for running period and count
      iio: Add driver for Murata IRS-D200

Xiongfeng Wang (2):
      fpga: dfl-pci: Use pci_find_vsec_capability() to simplify the code
      hwtracing: hisi_ptt: Use pci_dev_id() to simplify the code

Yang Yingliang (2):
      coresight: dummy: simplify the code with module_platform_driver
      uio: pruss: fix missing iounmap() in pruss_probe()

Yangtao Li (20):
      fpga: bridge: Convert to devm_platform_ioremap_resource()
      fpga: dfl-fme-mgr: Convert to devm_platform_ioremap_resource()
      fpga: xilinx-pr-decoupler: Convert to devm_platform_ioremap_resource()
      fpga: fpga-mgr: socfpga: Convert to devm_platform_ioremap_resource()
      fpga: fpga-mgr: ts73xx: Convert to devm_platform_ioremap_resource()
      fpga: zynq-fpga: Convert to devm_platform_ioremap_resource()
      fpga: fpga-mgr: altera-pr-ip: Convert to devm_platform_ioremap_resource()
      fpga: socfpga-a10: Convert to devm_platform_ioremap_resource()
      iio: adc: stm32-adc: Use devm_platform_get_and_ioremap_resource()
      misc: atmel-ssc: Use devm_platform_get_and_ioremap_resource()
      misc/xilinx_sdfec: Convert to devm_platform_ioremap_resource()
      misc: xilinx_tmr_manager: Use devm_platform_get_and_ioremap_resource()
      nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()
      nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()
      nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
      nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()
      nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()
      nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()
      nvmem: qfprom: do some cleanup
      nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()

Yu Zhe (1):
      fsi: fix some spelling mistakes in comment

Yue Haibing (1):
      greybus: svc: Remove unused declarations

YueHaibing (1):
      extcon: Remove unused inline functions

Zev Weiss (1):
      peci: Constify struct peci_controller_ops

Zhang Shurong (1):
      uio: pruss: fix to check return value of platform_get_irq() in pruss_probe()

 Documentation/ABI/stable/sysfs-bus-mhi             |    4 +-
 Documentation/ABI/testing/sysfs-bus-counter        |    8 +-
 .../ABI/testing/sysfs-bus-fsi-devices-sbefifo      |    6 +-
 Documentation/ABI/testing/sysfs-bus-iio            |   16 +
 .../ABI/testing/sysfs-bus-iio-filter-admv8818      |    2 +
 Documentation/admin-guide/dynamic-debug-howto.rst  |    5 +-
 .../devicetree/bindings/extcon/maxim,max77843.yaml |    1 +
 .../bindings/extcon/siliconmitus,sm5502-muic.yaml  |    4 +
 .../bindings/fsi/ibm,i2cr-fsi-master.yaml          |   41 +
 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         |   91 +
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |   15 +-
 .../bindings/iio/dac/microchip,mcp4728.yaml        |   49 +
 .../bindings/iio/frequency/adi,admv1013.yaml       |   60 +
 .../bindings/iio/frequency/adi,admv1014.yaml       |    8 +
 .../bindings/iio/light/rohm,bu27010.yaml           |   49 +
 .../bindings/iio/proximity/murata,irsd200.yaml     |   60 +
 .../bindings/iio/proximity/semtech,sx9310.yaml     |    5 +-
 .../bindings/iio/proximity/semtech,sx9324.yaml     |    5 +-
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    6 +
 .../bindings/interconnect/qcom,osm-l3.yaml         |    1 +
 .../bindings/interconnect/qcom,rpmh.yaml           |   18 +-
 .../devicetree/bindings/nvmem/fsl,t1023-sfp.yaml   |   37 +
 .../bindings/nvmem/layouts/fixed-cell.yaml         |   26 +
 .../bindings/nvmem/layouts/fixed-layout.yaml       |   12 +
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |    5 +-
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    2 +
 .../devicetree/bindings/nvmem/qcom,sec-qfprom.yaml |   55 +
 .../bindings/peci/nuvoton,npcm-peci.yaml           |   56 +
 Documentation/driver-api/interconnect.rst          |   25 +
 MAINTAINERS                                        |   11 +
 .../boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi   |    9 +
 .../boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi   |    9 +
 arch/x86/kernel/apm_32.c                           |    6 -
 drivers/acpi/acpi_amba.c                           |    1 -
 drivers/amba/bus.c                                 |    1 +
 drivers/android/binder.c                           |   20 +-
 drivers/android/binderfs.c                         |    1 -
 drivers/bus/mhi/host/boot.c                        |   34 +-
 drivers/bus/mhi/host/init.c                        |    2 +-
 drivers/bus/mhi/host/main.c                        |    1 -
 drivers/bus/mhi/host/pci_generic.c                 |   53 +-
 drivers/bus/mhi/host/pm.c                          |    5 +
 drivers/cdx/controller/cdx_controller.c            |    3 +-
 drivers/cdx/controller/cdx_rpmsg.c                 |    3 +-
 drivers/char/agp/uninorth-agp.c                    |    1 +
 drivers/char/bsr.c                                 |    3 +-
 drivers/char/xillybus/Kconfig                      |    2 +-
 drivers/clk/qcom/clk-smd-rpm.c                     |  314 ++--
 drivers/counter/microchip-tcb-capture.c            |    1 -
 drivers/counter/rz-mtu3-cnt.c                      |    4 +-
 drivers/extcon/Kconfig                             |    1 +
 drivers/firmware/google/Kconfig                    |    2 +-
 drivers/firmware/stratix10-rsu.c                   |  100 +-
 drivers/firmware/stratix10-svc.c                   |   20 +-
 drivers/fpga/Kconfig                               |    2 +
 drivers/fpga/Makefile                              |    3 +
 drivers/fpga/altera-fpga2sdram.c                   |    2 +-
 drivers/fpga/altera-freeze-bridge.c                |   11 +-
 drivers/fpga/altera-pr-ip-core-plat.c              |    9 +-
 drivers/fpga/dfl-fme-main.c                        |   17 +-
 drivers/fpga/dfl-fme-mgr.c                         |    4 +-
 drivers/fpga/dfl-pci.c                             |   15 +-
 drivers/fpga/fpga-bridge.c                         |   48 +-
 drivers/fpga/fpga-mgr.c                            |   25 +-
 drivers/fpga/fpga-region.c                         |   37 +-
 drivers/fpga/microchip-spi.c                       |    2 +-
 drivers/fpga/of-fpga-region.c                      |    2 +
 drivers/fpga/socfpga-a10.c                         |    7 +-
 drivers/fpga/socfpga.c                             |    7 +-
 drivers/fpga/stratix10-soc.c                       |    1 +
 drivers/fpga/tests/.kunitconfig                    |    5 +
 drivers/fpga/tests/Kconfig                         |   11 +
 drivers/fpga/tests/Makefile                        |    6 +
 drivers/fpga/tests/fpga-bridge-test.c              |  175 ++
 drivers/fpga/tests/fpga-mgr-test.c                 |  327 ++++
 drivers/fpga/tests/fpga-region-test.c              |  211 +++
 drivers/fpga/ts73xx-fpga.c                         |    4 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |    4 +-
 drivers/fpga/zynq-fpga.c                           |    4 +-
 drivers/fsi/Kconfig                                |   17 +
 drivers/fsi/Makefile                               |    2 +
 drivers/fsi/fsi-core.c                             |  154 +-
 drivers/fsi/fsi-master-aspeed.c                    |    4 +-
 drivers/fsi/fsi-master-ast-cf.c                    |    5 +-
 drivers/fsi/fsi-master-gpio.c                      |    2 +-
 drivers/fsi/fsi-master-hub.c                       |    2 +-
 drivers/fsi/fsi-master-i2cr.c                      |  316 ++++
 drivers/fsi/fsi-master-i2cr.h                      |   33 +
 drivers/fsi/fsi-master.h                           |    2 +-
 drivers/fsi/fsi-occ.c                              |    2 +-
 drivers/fsi/fsi-sbefifo.c                          |   53 +-
 drivers/fsi/fsi-scom.c                             |    8 +
 drivers/fsi/fsi-slave.h                            |   28 +
 drivers/fsi/i2cr-scom.c                            |  154 ++
 drivers/hwmon/peci/cputemp.c                       |   18 +
 drivers/hwmon/peci/dimmtemp.c                      |   50 +
 drivers/hwtracing/coresight/coresight-core.c       |    2 +-
 drivers/hwtracing/coresight/coresight-cti-core.c   |    2 +-
 drivers/hwtracing/coresight/coresight-dummy.c      |   12 +-
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |    4 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  118 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |    4 +
 drivers/hwtracing/coresight/coresight-platform.c   |   46 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |    2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |    5 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    2 +-
 drivers/hwtracing/coresight/coresight-trbe.c       |   43 +-
 drivers/hwtracing/coresight/coresight-trbe.h       |    2 +-
 drivers/hwtracing/ptt/hisi_ptt.c                   |    8 +-
 drivers/iio/accel/adxl313_i2c.c                    |    8 +-
 drivers/iio/accel/adxl355_i2c.c                    |   15 +-
 drivers/iio/accel/adxl372_spi.c                    |    1 -
 drivers/iio/accel/bma180.c                         |    1 -
 drivers/iio/accel/da280.c                          |   11 +-
 drivers/iio/accel/kxsd9-spi.c                      |    1 -
 drivers/iio/accel/mma8452.c                        |    2 +-
 drivers/iio/adc/Kconfig                            |   12 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ab8500-gpadc.c                     |    6 +-
 drivers/iio/adc/ad7124.c                           |    2 +-
 drivers/iio/adc/ad7192.c                           |   31 +-
 drivers/iio/adc/ad9467.c                           |    2 +-
 drivers/iio/adc/adi-axi-adc.c                      |    3 +-
 drivers/iio/adc/at91_adc.c                         |    1 -
 drivers/iio/adc/bcm_iproc_adc.c                    |    4 +-
 drivers/iio/adc/cc10001_adc.c                      |    1 -
 drivers/iio/adc/imx7d_adc.c                        |    2 +-
 drivers/iio/adc/ina2xx-adc.c                       |    2 +-
 drivers/iio/adc/lpc32xx_adc.c                      |    4 +-
 drivers/iio/adc/men_z188_adc.c                     |    1 -
 drivers/iio/adc/meson_saradc.c                     |  243 ++-
 drivers/iio/adc/npcm_adc.c                         |    4 +-
 drivers/iio/adc/palmas_gpadc.c                     |    7 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |    2 +
 drivers/iio/adc/qcom-spmi-iadc.c                   |    1 -
 drivers/iio/adc/rockchip_saradc.c                  |    3 +-
 drivers/iio/adc/sc27xx_adc.c                       |    1 -
 drivers/iio/adc/spear_adc.c                        |    4 +-
 drivers/iio/adc/stm32-adc-core.c                   |    5 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |    3 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |    4 +-
 drivers/iio/adc/stmpe-adc.c                        |    2 +-
 drivers/iio/adc/sun20i-gpadc-iio.c                 |  276 +++
 drivers/iio/adc/sun4i-gpadc-iio.c                  |    1 -
 drivers/iio/adc/ti-lmp92064.c                      |   53 +
 drivers/iio/adc/ti_am335x_adc.c                    |    1 -
 drivers/iio/amplifiers/Kconfig                     |    1 +
 drivers/iio/amplifiers/ad8366.c                    |   15 +
 drivers/iio/cdc/ad7150.c                           |   10 +-
 drivers/iio/chemical/scd4x.c                       |   79 +-
 drivers/iio/common/Kconfig                         |    1 +
 drivers/iio/common/Makefile                        |    1 +
 drivers/iio/common/inv_sensors/Kconfig             |    7 +
 drivers/iio/common/inv_sensors/Makefile            |    6 +
 .../inv_sensors/inv_sensors_timestamp.c}           |  100 +-
 drivers/iio/dac/Kconfig                            |   11 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/mcp4728.c                          |  618 +++++++
 drivers/iio/filter/admv8818.c                      |   65 +-
 drivers/iio/frequency/admv1013.c                   |   14 +
 drivers/iio/imu/adis16475.c                        |    5 +-
 drivers/iio/imu/inv_icm42600/Kconfig               |    1 +
 drivers/iio/imu/inv_icm42600/Makefile              |    1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   35 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   33 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   14 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   35 +-
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.h  |   85 -
 drivers/iio/imu/inv_mpu6050/Kconfig                |    1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   33 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   22 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  104 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |    6 +-
 drivers/iio/industrialio-core.c                    |  161 +-
 drivers/iio/industrialio-event.c                   |    2 +
 drivers/iio/industrialio-trigger.c                 |    2 +-
 drivers/iio/light/cm3605.c                         |    2 +-
 drivers/iio/light/rohm-bu27008.c                   |  630 +++++--
 drivers/iio/light/vcnl4000.c                       |  710 +++++++-
 drivers/iio/potentiometer/mcp4018.c                |   35 +-
 drivers/iio/potentiometer/mcp4531.c                |  139 +-
 drivers/iio/proximity/Kconfig                      |   12 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/irsd200.c                    |  958 +++++++++++
 drivers/iio/proximity/isl29501.c                   |    2 +-
 drivers/iio/proximity/mb1232.c                     |    7 +-
 drivers/iio/temperature/mlx90614.c                 |    2 +-
 drivers/iio/trigger/stm32-lptimer-trigger.c        |    9 +-
 drivers/interconnect/Makefile                      |    2 +-
 drivers/interconnect/core.c                        |   84 +-
 drivers/interconnect/debugfs-client.c              |  168 ++
 drivers/interconnect/icc-clk.c                     |    2 +-
 drivers/interconnect/imx/imx8mp.c                  |    1 -
 drivers/interconnect/internal.h                    |    5 +-
 drivers/interconnect/qcom/Makefile                 |    2 +-
 drivers/interconnect/qcom/bcm-voter.c              |   43 +-
 drivers/interconnect/qcom/bcm-voter.h              |    8 -
 drivers/interconnect/qcom/icc-rpm-clocks.c         |   77 +
 drivers/interconnect/qcom/icc-rpm.c                |  222 +--
 drivers/interconnect/qcom/icc-rpm.h                |   56 +-
 drivers/interconnect/qcom/icc-rpmh.c               |    5 +-
 drivers/interconnect/qcom/icc-rpmh.h               |   10 -
 drivers/interconnect/qcom/msm8916.c                |    7 +-
 drivers/interconnect/qcom/msm8939.c                |    8 +-
 drivers/interconnect/qcom/msm8974.c                |    7 +-
 drivers/interconnect/qcom/msm8996.c                |   13 +-
 drivers/interconnect/qcom/osm-l3.c                 |    4 +-
 drivers/interconnect/qcom/qcm2290.c                |   18 +-
 drivers/interconnect/qcom/qcs404.c                 |    7 +-
 drivers/interconnect/qcom/qdu1000.c                |    3 +-
 drivers/interconnect/qcom/sa8775p.c                |    3 +-
 drivers/interconnect/qcom/sc7180.c                 | 1614 +++++++++++++++--
 drivers/interconnect/qcom/sc7280.c                 |    3 +-
 drivers/interconnect/qcom/sc8180x.c                |    3 +-
 drivers/interconnect/qcom/sc8280xp.c               |    3 +-
 drivers/interconnect/qcom/sdm660.c                 |   11 +-
 drivers/interconnect/qcom/sdm670.c                 | 1387 +++++++++++++--
 drivers/interconnect/qcom/sdm845.c                 | 1656 ++++++++++++++++--
 drivers/interconnect/qcom/sdx55.c                  |  844 ++++++++-
 drivers/interconnect/qcom/sdx65.c                  |  831 ++++++++-
 drivers/interconnect/qcom/sm6350.c                 | 1527 ++++++++++++++--
 drivers/interconnect/qcom/sm8150.c                 | 1687 ++++++++++++++++--
 drivers/interconnect/qcom/sm8250.c                 | 1820 ++++++++++++++++++--
 drivers/interconnect/qcom/sm8250.h                 |    6 +
 drivers/interconnect/qcom/sm8350.c                 | 1799 +++++++++++++++++--
 drivers/interconnect/qcom/sm8450.c                 |    5 +-
 drivers/interconnect/qcom/sm8550.c                 |    4 +-
 drivers/interconnect/qcom/smd-rpm.c                |   25 +-
 drivers/interconnect/qcom/smd-rpm.h                |   15 -
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/atmel-ssc.c                           |    3 +-
 drivers/misc/bcm-vk/bcm_vk.h                       |    2 +-
 drivers/misc/bcm-vk/bcm_vk_msg.c                   |   14 +-
 drivers/misc/cxl/base.c                            |    1 +
 drivers/misc/eeprom/idt_89hpesx.c                  |   23 +-
 drivers/misc/fastrpc.c                             |   36 +-
 drivers/misc/genwqe/card_base.c                    |   49 +-
 drivers/misc/genwqe/card_base.h                    |    2 +-
 drivers/misc/hi6421v600-irq.c                      |    4 +-
 drivers/misc/hpilo.c                               |   18 +-
 drivers/misc/lis3lv02d/lis3lv02d.c                 |    2 +-
 drivers/misc/mchp_pci1xxxx/Kconfig                 |    1 +
 drivers/misc/mchp_pci1xxxx/Makefile                |    2 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c  |  443 +++++
 drivers/misc/mei/bus-fixup.c                       |   10 +-
 drivers/misc/mei/bus.c                             |    1 +
 drivers/misc/mei/gsc-me.c                          |    1 +
 drivers/misc/mei/init.c                            |    8 +-
 drivers/misc/mei/main.c                            |   25 +-
 drivers/misc/mei/mei_dev.h                         |    2 +
 drivers/misc/mei/pxp/mei_pxp.c                     |    3 +-
 drivers/misc/qcom-coincell.c                       |    1 -
 drivers/misc/sram.c                                |    2 +-
 drivers/misc/tps6594-esm.c                         |    9 +-
 drivers/misc/tps6594-pfsm.c                        |    9 +-
 drivers/misc/vcpu_stall_detector.c                 |    1 -
 drivers/misc/xilinx_sdfec.c                        |    7 +-
 drivers/misc/xilinx_tmr_inject.c                   |    3 +-
 drivers/misc/xilinx_tmr_manager.c                  |    6 +-
 drivers/nvmem/Kconfig                              |   31 +-
 drivers/nvmem/Makefile                             |    4 +
 drivers/nvmem/bcm-ocotp.c                          |    1 -
 drivers/nvmem/brcm_nvram.c                         |    3 +-
 drivers/nvmem/core.c                               |   21 +-
 drivers/nvmem/imx-iim.c                            |    1 -
 drivers/nvmem/imx-ocotp-ele.c                      |    2 +-
 drivers/nvmem/imx-ocotp-scu.c                      |    2 +-
 drivers/nvmem/imx-ocotp.c                          |    1 -
 drivers/nvmem/lpc18xx_otp.c                        |    5 +-
 drivers/nvmem/meson-mx-efuse.c                     |    5 +-
 drivers/nvmem/qcom-spmi-sdam.c                     |    2 +-
 drivers/nvmem/qfprom.c                             |   17 +-
 drivers/nvmem/qoriq-efuse.c                        |   78 +
 drivers/nvmem/rave-sp-eeprom.c                     |    2 +-
 drivers/nvmem/rockchip-efuse.c                     |    3 +-
 drivers/nvmem/sc27xx-efuse.c                       |    1 -
 drivers/nvmem/sec-qfprom.c                         |   96 ++
 drivers/nvmem/snvs_lpgpr.c                         |    3 +-
 drivers/nvmem/sprd-efuse.c                         |    2 +-
 drivers/nvmem/stm32-romem.c                        |    3 +-
 drivers/nvmem/sunplus-ocotp.c                      |    2 +-
 drivers/nvmem/sunxi_sid.c                          |    5 +-
 drivers/nvmem/u-boot-env.c                         |    4 +-
 drivers/nvmem/uniphier-efuse.c                     |    3 +-
 drivers/pcmcia/Kconfig                             |    1 +
 drivers/peci/controller/Kconfig                    |   16 +
 drivers/peci/controller/Makefile                   |    1 +
 drivers/peci/controller/peci-aspeed.c              |    2 +-
 drivers/peci/controller/peci-npcm.c                |  298 ++++
 drivers/peci/core.c                                |    4 +-
 drivers/peci/cpu.c                                 |    5 +
 drivers/soc/qcom/smd-rpm.c                         |   17 +-
 drivers/uio/uio_pruss.c                            |    7 +-
 fs/debugfs/file.c                                  |   48 +-
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h    |   88 +-
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h   |  124 +-
 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h   |   52 +-
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h   |   24 +-
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h   |   24 +-
 include/dt-bindings/interconnect/qcom,rpm-icc.h    |   13 +
 include/dt-bindings/interconnect/qcom,sm8250.h     |    7 +
 include/linux/coresight.h                          |   59 +
 include/linux/counter.h                            |    2 +-
 include/linux/dynamic_debug.h                      |    4 +-
 include/linux/extcon.h                             |   12 -
 include/linux/firmware/intel/stratix10-smc.h       |   25 +
 .../linux/firmware/intel/stratix10-svc-client.h    |    5 +
 include/linux/greybus/svc.h                        |    3 -
 include/linux/iio/common/inv_sensors_timestamp.h   |   95 +
 include/linux/iio/types.h                          |    2 +
 include/linux/interconnect-provider.h              |    2 +-
 include/linux/mhi.h                                |    6 +
 include/linux/nvmem-consumer.h                     |    4 +-
 include/linux/peci.h                               |    4 +-
 include/linux/soc/qcom/smd-rpm.h                   |   20 +-
 include/trace/events/fsi.h                         |   31 +
 include/trace/events/fsi_master_i2cr.h             |  107 ++
 include/uapi/linux/fsi.h                           |   10 +
 include/uapi/linux/sync_file.h                     |    2 +-
 lib/dynamic_debug.c                                |    8 +-
 tools/iio/iio_generic_buffer.c                     |   17 +-
 321 files changed, 20941 insertions(+), 3204 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
 create mode 100644 Documentation/devicetree/bindings/peci/nuvoton,npcm-peci.yaml
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
 create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
 create mode 100644 drivers/fpga/tests/fpga-region-test.c
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 drivers/fsi/fsi-master-i2cr.h
 create mode 100644 drivers/fsi/fsi-slave.h
 create mode 100644 drivers/fsi/i2cr-scom.c
 create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c
 create mode 100644 drivers/iio/common/inv_sensors/Kconfig
 create mode 100644 drivers/iio/common/inv_sensors/Makefile
 rename drivers/iio/{imu/inv_icm42600/inv_icm42600_timestamp.c => common/inv_sensors/inv_sensors_timestamp.c} (56%)
 create mode 100644 drivers/iio/dac/mcp4728.c
 delete mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
 create mode 100644 drivers/iio/proximity/irsd200.c
 create mode 100644 drivers/interconnect/debugfs-client.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm-clocks.c
 delete mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
 create mode 100644 drivers/nvmem/qoriq-efuse.c
 create mode 100644 drivers/nvmem/sec-qfprom.c
 create mode 100644 drivers/peci/controller/peci-npcm.c
 create mode 100644 include/dt-bindings/interconnect/qcom,rpm-icc.h
 create mode 100644 include/linux/iio/common/inv_sensors_timestamp.h
 create mode 100644 include/trace/events/fsi_master_i2cr.h
