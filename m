Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED17E0279
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbjKCMFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjKCMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:05:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FEBD44
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:04:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC678C433C8;
        Fri,  3 Nov 2023 12:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699013097;
        bh=8w2WPyxejIWif8k469a31tiRZxofy5/luDJMZWrR4KY=;
        h=Date:From:To:Cc:Subject:From;
        b=L5lKCPR5yhtIouacM6MLzkIGbCF5LO9k/KSIEtHU4cYU6jzqglA5YkSCqdHSZzbn3
         Jd1uHYI6r5SA4qa/30HrvLU4lF+kuvajKiZagnVVv2+3soMyuWw9vtQA6PITZVjidm
         xr5b7oNOPBNmjdBpq6Z2hOIWBBGb0RKThTu9qu1M=
Date:   Fri, 3 Nov 2023 13:04:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc and other driver subsytems update for 6.7-rc1
Message-ID: <ZUTh4pl9zi9EosKe@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.7-rc1

for you to fetch changes up to fa10f413091a43f801f82b3cf484f15d6fc9266f:

  cdx: add sysfs for subsystem, class and revision (2023-10-27 13:23:24 +0200)

----------------------------------------------------------------
Char/Misc and other driver changes for 6.7-rc1

Here is the big set of char/misc and other small driver subsystem
changes for 6.7-rc1.  Included in here are:
  - IIO subsystem driver updates and additions (largest part of this
    pull request)
  - FPGA subsystem driver updates
  - Counter subsystem driver updates
  - ICC subsystem driver updates
  - extcon subsystem driver updates
  - mei driver updates and additions
  - nvmem subsystem driver updates and additions
  - comedi subsystem dependency fixes
  - parport driver fixups
  - cdx subsystem driver and core updates
  - splice support for /dev/zero and /dev/full
  - other smaller driver cleanups

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhijit Gangurde (7):
      cdx: Remove cdx controller list from cdx bus system
      cdx: Introduce lock to protect controller ops
      cdx: Create symbol namespaces for cdx subsystem
      cdx: Register cdx bus as a device on cdx subsystem
      cdx: add support for bus enable and disable
      cdx: add sysfs for bus reset
      cdx: add sysfs for subsystem, class and revision

Alan Previn (1):
      mei: update mei-pxp's component interface with timeouts

Alexander Usyskin (3):
      mei: bus: add send and recv api with timeout
      mei: pxp: recover from recv fail under memory pressure
      mei: pxp: re-enable client on errors

Alisa-Dariana Roman (5):
      iio: adc: ad7192: Use bitfield access macros
      iio: adc: ad7192: Improve f_order computation
      iio: adc: ad7192: Organize chip info
      iio: adc: ad7192: Remove unused member
      iio: adc: ad7192: Add fast settling support

Ana-Maria Cusco (1):
      dt-bindings: iio: hmc425a: add entry for HMC540S

Andreas Kemnade (3):
      dt-bindings: iio: adc: Add TI TWL603X GPADC
      dt-bindings: iio: imu: mpu6050: Add level shifter
      iio: imu: mpu6050: add level shifter flag

André Apitzsch (1):
      iio: magnetometer: ak8975: Fix 'Unexpected device' error

Andy Shen Shen (1):
      iio: adc: palmas_gpadc: Drop duplicated the in comment.

Andy Shevchenko (12):
      iio: accel: kionix-kx022a: Use correct header(s) instead of string_helpers.h
      iio: accel: msa311: Use correct header(s) instead of string_helpers.h
      iio: dac: stm32-dac: Use correct header(s) instead of string_helpers.h
      interconnect: imx: Replace custom implementation of COUNT_ARGS()
      interconnect: msm8974: Replace custom implementation of COUNT_ARGS()
      interconnect: qcom: osm-l3: Replace custom implementation of COUNT_ARGS()
      interconnect: imx: Replace inclusion of kernel.h in the header
      parport: Use kasprintf() instead of fixed buffer formatting
      parport: Use list_for_each() helper
      parport: Drop unneeded NULL or 0 assignments
      parport: Clean up resources correctly when parport_register_port() fails
      parport: Drop even more unneeded NULL or 0 assignments

AngeloGioacchino Del Regno (1):
      iio: adc: mt6577_auxadc: Fix kernel panic on suspend

Antoniu Miclaus (3):
      iio: addac: ad74413r: fix function prefix typo
      iio: addac: ad74413r: update channel function set
      MAINTAINERS: fix Analog Devices website link

Ayush Singh (3):
      dt-bindings: net: Add ti,cc1352p7
      greybus: Add BeaglePlay Linux Driver
      dts: ti: k3-am625-beagleplay: Add beaglecc1352

Basavaraj Natikar (9):
      iio: hid-sensor-als: Use channel index to support more hub attributes
      iio: Add channel type light color temperature
      iio: hid-sensor-als: Add light color temperature support
      HID: amd_sfh: Add support for light color temperature
      HID: amd_sfh: Add support for SFH1.1 light color temperature
      iio: Add channel type for chromaticity
      iio: hid-sensor-als: Add light chromaticity support
      HID: amd_sfh: Add light chromaticity support
      HID: amd_sfh: Add light chromaticity for SFH1.1

Biju Das (30):
      iio: accel: mma8452: Convert enum->pointer for data in the ID table
      iio: accel: mma8452: Sort match tables
      iio: chemical: vz89x: Convert enum->pointer for data in the match tables
      iio: chemical: atlas-sensor: Convert enum->pointer for data in the match tables
      iio: chemical: atlas-ezo-sensor: Simplify probe()
      iio: proximity: sx9310: Convert enum->pointer for match data table
      iio: dac: ti-dac5571: Use i2c_get_match_data()
      iio: dac: ti-dac5571: Sort match tables
      iio: magnetometer: yamaha-yas530: Use i2c_get_match_data()
      iio: adc: max1363: Use i2c_get_match_data()
      iio: accel: bma180: Convert enum->pointer for data in the match table
      iio: mlx90614: Use i2c_get_match_data()
      iio: magnetometer: ak8975: Convert enum->pointer for data in the match tables
      iio: magnetometer: ak8975: Sort ID and ACPI tables
      dt-bindings: iio: magnetometer: asahi-kasei,ak8975: Drop deprecated enums
      iio: chemical: sgp30: Convert enum->pointer for data in the match tables
      iio: potentiometer: ds1803: Convert enum->pointer for data in the ID table
      iio: potentiometer: ad5110: Use i2c_get_match_data()
      iio: light: opt4001: Use i2c_get_match_data()
      iio: temperature: tmp117: Convert enum->pointer for data in the match tables
      iio: adc: ti-adc081c: Simplify probe()
      iio: adc: ti-ads1015: Simplify probe()
      iio: adc: ltc2497: Simplify probe()
      iio: accel: adxl345: Convert enum->pointer for data in match data table
      iio: accel: adxl345: Simplify adxl345_read_raw()
      iio: dac: mcp4725: Replace variable 'id' from struct mcp4725_data
      iio: dac: mcp4725: Use i2c_get_match_data()
      iio: dac: mcp4725: Add use_ext_ref_voltage to struct mcp4725_chip_info
      iio: dac: mcp4725: Add dac_reg_offset to struct mcp4725_chip_info
      iio: pressure: ms5637: Use i2c_get_match_data()

Christophe JAILLET (1):
      comedi: Annotate struct comedi_lrange with __counted_by

David Lechner (39):
      staging: iio: resolver: ad2s1210: fix ad2s1210_show_fault
      staging: iio: resolver: ad2s1210: fix not restoring sample gpio in channel read
      staging: iio: resolver: ad2s1210: fix use before initialization
      staging: iio: resolver: ad2s1210: remove call to spi_setup()
      staging: iio: resolver: ad2s1210: check return of ad2s1210_initial()
      staging: iio: resolver: ad2s1210: remove spi_set_drvdata()
      staging: iio: resolver: ad2s1210: sort imports
      staging: iio: resolver: ad2s1210: always use 16-bit value for raw read
      staging: iio: resolver: ad2s1210: implement IIO_CHAN_INFO_SCALE
      staging: iio: resolver: ad2s1210: use devicetree to get CLKIN rate
      staging: iio: resolver: ad2s1210: use regmap for config registers
      staging: iio: resolver: ad2s1210: add debugfs reg access
      staging: iio: resolver: ad2s1210: remove config attribute
      staging: iio: resolver: ad2s1210: rework gpios
      staging: iio: resolver: ad2s1210: refactor setting excitation frequency
      staging: iio: resolver: ad2s1210: read excitation frequency from control register
      dt-bindings: iio: resolver: add devicetree bindings for ad2s1210
      staging: iio: resolver: ad2s1210: do not use fault register for dummy read
      staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
      staging: iio: resolver: ad2s1210: convert fexcit to channel attribute
      staging: iio: resolver: ad2s1210: convert resolution to devicetree property
      staging: iio: resolver: ad2s1210: add phase lock range support
      staging: iio: resolver: ad2s1210: add triggered buffer support
      staging: iio: resolver: ad2s1210: convert LOT threshold attrs to event attrs
      staging: iio: resolver: ad2s1210: convert LOS threshold to event attr
      staging: iio: resolver: ad2s1210: convert DOS overrange threshold to event attr
      staging: iio: resolver: ad2s1210: convert DOS mismatch threshold to event attr
      staging: iio: resolver: ad2s1210: rename DOS reset min/max attrs
      iio: event: add optional event label support
      staging: iio: resolver: ad2s1210: implement fault events
      staging: iio: resolver: ad2s1210: add register/fault support summary
      staging: iio: resolver: ad2s1210: add label attribute support
      staging: iio: resolver: ad2s1210: remove fault attribute
      staging: iio: resolver: ad2s1210: refactor sample toggle
      staging: iio: resolver: ad2s1210: clear faults after soft reset
      staging: iio: resolver: ad2s1210: simplify code with guard(mutex)
      iio: resolver: ad2s1210: move out of staging
      iio: resolver: ad2s1210: remove DRV_NAME macro
      iio: resolver: ad2s1210: remove of_match_ptr()

Fabrice Gasnier (1):
      counter: chrdev: remove a typo in header file comment

George Stark (1):
      iio: adc: meson: improve error logging at probe stage

Georgi Djakov (6):
      Merge branch 'icc-qcom-coefficients' into icc-next
      Merge branch 'icc-rpm-dt-bindings' into icc-next
      Merge branch 'icc-acv-enable-mask' into icc-next
      Merge branch 'icc-sdx75' into icc-next
      Merge branch 'icc-misc' into icc-next
      Merge branch 'icc-platform-remove' into icc-next

Greg Kroah-Hartman (11):
      Merge 6.6-rc6 into char-misc-next
      Merge tag 'fpga-for-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      tee: make tee_class constant
      Merge tag 'iio-for-6.7a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'counter-updates-for-6.7a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      misc: phantom: make phantom_class constant
      cxl: make cxl_class constant
      ocxl: make ocxl_class constant
      uacce: make uacce_class constant
      Merge tag 'icc-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'extcon-next-for-6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next

Heiner Kallweit (1):
      eeprom: Remove deprecated legacy eeprom driver

Hugo Villeneuve (1):
      Documentation: stable: clarify patch series prerequisites

Ian Abbott (13):
      comedi: Correct dependencies for COMEDI_NI_PCIDIO
      comedi: comedi_8254: Use a call-back function for register access
      comedi: comedi_8254: Replace comedi_8254_init() and comedi_8254_mm_init()
      comedi: comedi_8254: Conditionally remove I/O port support
      comedi: 8255_pci: Conditionally remove devices that use port I/O
      comedi: comedi_8255: Rework subdevice initialization functions
      comedi: comedi_8255: Conditionally remove I/O port support
      comedi: ni_labpc_common: Conditionally remove I/O port support
      comedi: ni_mio_common: Conditionally use I/O port or MMIO
      comedi: amplc_dio200_pci: Conditionally remove devices that use port I/O
      comedi: amplc_dio200_common: Refactor register access functions
      comedi: amplc_dio200_common: Conditionally remove I/O port support
      comedi: add HAS_IOPORT dependencies again

Ivan Orlov (1):
      rapidio: make all 'class' structures const

James Clark (1):
      MAINTAINERS: coresight: Add missing Coresight files

Javier Carrasco (2):
      iio: si7005: Add device tree support
      dt-bindings: trivial-devices: add silabs,si7005

Jinjie Ruan (11):
      iio: adc: mt6577_auxadc: Use devm_clk_get_enabled() helper function
      iio: adc: spear_adc: Use device managed function
      iio: adc: spear_adc: Use dev_err_probe()
      iio: adc: mt6577_auxadc: Simplify with dev_err_probe()
      iio: adc: mt6577_auxadc: Simplify with device managed function
      staging: iio: Use devm_clk_get_enabled() helper function
      iio: frequency: adf4350: Use device managed functions and fix power down issue.
      iio: adc: at91_adc: Use devm_request_irq() helper function
      iio: adc: at91_adc: Use devm_clk_get_enabled() helper function
      iio: adc: at91_adc: Simplify with dev_err_probe()
      misc: st_core: Do not call kfree_skb() under spin_lock_irqsave()

Jonathan Cameron (2):
      Merge branch 'ib-iio-hid-sensors-v6.6-rc1' into togreg
      Revert "dt-bindings: iio: magnetometer: asahi-kasei,ak8975: Drop deprecated enums"

Jorge Sanjuan Garcia (1):
      mcb: use short version for function pointer for mcb_free_bus

Justin Stitt (6):
      eeprom: idt_89hpesx: replace open-coded kmemdup_nul
      ibmvmc: replace deprecated strncpy with strscpy
      drivers: misc: ti-st: replace deprecated strncpy with strscpy
      c2port: replace deprecated strncpy with strscpy
      accessibility: speakup: refactor deprecated strncpy
      iio: adc: stm32-adc: Replace deprecated strncpy() with strscpy()

Kees Cook (2):
      misc: bcm-vk: Annotate struct bcm_vk_wkent with __counted_by
      hpet: Annotate struct hpets with __counted_by

Konrad Dybcio (27):
      interconnect: qcom: icc-rpm: Add AB/IB calculations coefficients
      interconnect: qcom: icc-rpm: Separate out clock rate calulcations
      interconnect: qcom: icc-rpm: Let nodes drive their own bus clock
      interconnect: qcom: icc-rpm: Check for node-specific rate coefficients
      interconnect: qcom: qcm2290: Hook up MAS_APPS_PROC's bus clock
      interconnect: qcom: qcm2290: Set AB coefficients
      interconnect: qcom: qcm2290: Update EBI channel configuration
      interconnect: qcom: sdm660: Set AB/IB coefficients
      interconnect: qcom: msm8996: Set AB/IB coefficients
      dt-bindings: interconnect: qcom: Introduce qcom,rpm-common
      dt-bindings: interconnect: qcom: qcm2290: Remove RPM bus clocks
      dt-bindings: interconnect: qcom: Fix and separate out SDM660
      dt-bindings: interconnect: qcom: Fix and separate out MSM8996
      dt-bindings: interconnect: qcom: Fix and separate out MSM8939
      dt-bindings: interconnect: qcom: rpm: Clean up the file
      dt-bindings: interconnect: qcom: rpm: Clean up the example
      interconnect: qcom: qdu1000: Set ACV enable_mask
      interconnect: qcom: sc7180: Set ACV enable_mask
      interconnect: qcom: sc7280: Set ACV enable_mask
      interconnect: qcom: sc8180x: Set ACV enable_mask
      interconnect: qcom: sc8280xp: Set ACV enable_mask
      interconnect: qcom: sdm670: Set ACV enable_mask
      interconnect: qcom: sdm845: Set ACV enable_mask
      interconnect: qcom: sm6350: Set ACV enable_mask
      interconnect: qcom: sm8150: Set ACV enable_mask
      interconnect: qcom: sm8250: Set ACV enable_mask
      interconnect: qcom: sm8350: Set ACV enable_mask

Krzysztof Kozlowski (1):
      dt-bindings: interconnect: qcom,rpmh: do not require reg on SDX65 MC virt

Kuan-Wei Chiu (1):
      binderfs: fix typo in binderfs.c

Lars-Peter Clausen (1):
      iio: ad4310: Replace devm_clk_register() with devm_clk_hw_register()

Liam Beguin (2):
      dt-bindings: iio: adc: add lltc,ltc2309 bindings
      iio: adc: add ltc2309 support

Luca Ceresoli (1):
      iio: accel: mxc4005: allow module autoloading via OF compatible

Luca Weiss (1):
      nvmem: qfprom: Mark core clk as optional

Lukas Bulwahn (1):
      eeprom: remove doc and MAINTAINERS section after driver was removed

Marcus Folkesson (6):
      dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx family
      iio: adc: mcp3911: make use of dev_err_probe()
      iio: adc: mcp3911: simplify usage of spi->dev
      iio: adc: mcp3911: fix indentation
      iio: adc: mcp3911: avoid ambiguity parameters in macros
      iio: adc: mcp3911: add support for the whole MCP39xx family

Marek Szyprowski (2):
      extcon: max77693: add device-tree compatible string
      extcon: max77843: add device-tree compatible string

Marek Vasut (2):
      iio: adc: ti-ads1015: Add edge trigger support
      dt-bindings: iio: adc: ti,ads1015: Document optional interrupt line

Marius Cristea (4):
      dt-bindings: iio: adc: adding MCP3564 ADC
      iio: adc: adding support for MCP3564 ADC
      iio: adc: MCP3564: fix the static checker warning
      iio: adc: MCP3564: fix warn: unsigned '__x' is never less than zero.

Martin Kepplinger (1):
      dt-bindings: iio: imu: st,lsm6dsx: add mount-matrix property

Matti Vaittinen (7):
      iio: improve doc for available_scan_mask
      dt-bindings: Add ROHM BM1390 pressure sensor
      iio: pressure: Support ROHM BU1390
      MAINTAINERS: Add ROHM BM1390
      dt-bindings: iio: Add KX132ACR-LBZ accelerometer
      iio: kx022a: Support ROHM KX132ACR-LBZ
      tools: iio: iio_generic_buffer ensure alignment

Max Kellermann (1):
      drivers/char/mem: implement splice() for /dev/zero, /dev/full

Mehdi Djait (7):
      dt-bindings: iio: Add KX132-1211 accelerometer
      iio: accel: kionix-kx022a: Remove blank lines
      iio: accel: kionix-kx022a: Warn on failed matches and assume compatibility
      iio: accel: kionix-kx022a: Add an i2c_device_id table
      iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
      iio: accel: kionix-kx022a: Add a function to retrieve number of bytes in buffer
      iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer

Michael Hennerich (1):
      iio: amplifiers: hmc425a: Add Support HMC540S 4-bit Attenuator

Nava kishore Manne (1):
      fpga: versal: Add support for 44-bit DMA operations

Rafał Miłecki (5):
      nvmem: add explicit config option to read old syntax fixed OF cells
      dt-bindings: nvmem: move deprecated cells binding to its own file
      Revert "nvmem: add new config option"
      dt-bindings: nvmem: SID: allow NVMEM cells based on old syntax
      dt-bindings: eeprom: at24: allow NVMEM cells based on old syntax

Rajan Vaja (1):
      firmware: xilinx: Move EXPORT_SYMBOL_GPL next to zynqmp_pm_feature definition

Ramona Bolboaca (3):
      iio: Add IIO_DELTA_ANGL channel type
      iio: Add IIO_DELTA_VELOCITY channel type
      iio: imu: adis16475.c: Add delta angle and delta velocity channels

Ramona Gradinariu (2):
      iio: imu: adis16475: Add buffer padding after temp channel
      drivers: imu: adis16475.c: Remove scan index from delta channels

Randy Dunlap (8):
      mei: fix doc typos
      misc: mei: hw.h: fix kernel-doc warnings
      misc: mei: client.c: fix kernel-doc warnings
      misc: mei: dma-ring.c: fix kernel-doc warnings
      misc: mei: hbm.c: fix kernel-doc warnings
      misc: mei: hw-me.c: fix kernel-doc warnings
      misc: mei: interrupt.c: fix kernel-doc warnings
      misc: mei: main.c: fix kernel-doc warnings

Rob Herring (6):
      fpga: Use device_get_match_data()
      iio: Use device_get_match_data()
      fpga: altera-ps-spi: Use spi_get_device_match_data()
      char: xilinx_hwicap: Modernize driver probe
      dt-bindings: nvmem: u-boot,env: Add missing additionalProperties on child node schemas
      nvmem: Use device_get_match_data()

Rodríguez Barbarin, José Javier (1):
      mcb: Use the actual bus passed to init and release functions

Rohit Agarwal (2):
      dt-bindings: interconnect: Add compatibles for SDX75
      interconnect: qcom: Add SDX75 interconnect provider driver

Sanjuán García, Jorge (1):
      mcb: fix error handling for different scenarios when parsing

Siddharth Vadapalli (1):
      misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP device support

Stanley Chang (3):
      extcon: add Realtek DHC RTD SoC Type-C driver
      dt-bindings: usb: Add Realtek DHC RTD SoC Type-C
      extcon: realtek: add the error handler for nvmem_cell_read

Thomas Weißschuh (1):
      misc/pvpanic: deduplicate common code

Tomas Winkler (3):
      mei: docs: use correct structures name in kdoc
      mei: docs: add missing entries to kdoc in struct mei_cfg_idx
      mei: docs: fix spelling errors

Uwe Kleine-König (50):
      iio: accel: hid-sensor-accel-3d: Convert to platform remove callback returning void
      iio: adc: ab8500-gpadc: Convert to platform remove callback returning void
      iio: adc: at91-sama5d2: Convert to platform remove callback returning void
      iio: adc: at91: Convert to platform remove callback returning void
      iio: adc: axp20x: Convert to platform remove callback returning void
      iio: adc: bcm_iproc: Convert to platform remove callback returning void
      iio: adc: dln2: Convert to platform remove callback returning void
      iio: adc: ep93xx: Convert to platform remove callback returning void
      iio: adc: exynos: Convert to platform remove callback returning void
      iio: adc: fsl-imx25-gcq: Convert to platform remove callback returning void
      iio: adc: hx711: Convert to platform remove callback returning void
      iio: adc: imx8qxp: Convert to platform remove callback returning void
      iio: adc: imx93: Convert to platform remove callback returning void
      iio: adc: meson_saradc: Convert to platform remove callback returning void
      iio: adc: mp2629: Convert to platform remove callback returning void
      iio: adc: mxs-lradc: Convert to platform remove callback returning void
      iio: adc: npcm: Convert to platform remove callback returning void
      iio: adc: qcom-pm8xxx-xoadc: Convert to platform remove callback returning void
      iio: adc: rcar-gyroadc: Convert to platform remove callback returning void
      iio: adc: stm32-adc-core: Convert to platform remove callback returning void
      iio: adc: stm32-adc: Convert to platform remove callback returning void
      iio: adc: stm32-dfsdm-adc: Convert to platform remove callback returning void
      iio: adc: stm32-dfsdm-core: Convert to platform remove callback returning void
      iio: adc: sun4i-gpadc-iio: Convert to platform remove callback returning void
      iio: adc: ti_am335x_adc: Convert to platform remove callback returning void
      iio: adc: twl4030-madc: Convert to platform remove callback returning void
      iio: adc: twl6030-gpadc: Convert to platform remove callback returning void
      iio: adc: vf610_adc: Convert to platform remove callback returning void
      iio: dac: dpot-dac: Convert to platform remove callback returning void
      iio: dac: lpc18xx_dac: Convert to platform remove callback returning void
      iio: dac: stm32-dac-core: Convert to platform remove callback returning void
      iio: dac: stm32-dac: Convert to platform remove callback returning void
      iio: dac: vf610: Convert to platform remove callback returning void
      iio: gyro: hid-sensor-gyro-3d: Convert to platform remove callback returning void
      iio: humidity: hid-sensor-humidity: Convert to platform remove callback returning void
      iio: light: cm3605: Convert to platform remove callback returning void
      iio: light: hid-sensor-als: Convert to platform remove callback returning void
      iio: light: hid-sensor-prox: Convert to platform remove callback returning void
      iio: light: lm3533-als: Convert to platform remove callback returning void
      iio: magnetometer: hid-sensor-magn-3d: Convert to platform remove callback returning void
      iio: orientation: hid-sensor-incl-3d: Convert to platform remove callback returning void
      iio: orientation: hid-sensor-rotation: Convert to platform remove callback returning void
      iio: position: hid-sensor-custom-intel-hinge: Convert to platform remove callback returning void
      iio: pressure: hid-sensor: Convert to platform remove callback returning void
      iio: proximity: cros_ec_mkbp: Convert to platform remove callback returning void
      iio: proximity: srf04: Convert to platform remove callback returning void
      iio: temperature: hid-sensor: Convert to platform remove callback returning void
      iio: trigger: iio-trig-interrupt: Convert to platform remove callback returning void
      iio: trigger: stm32-timer: Convert to platform remove callback returning void
      interconnect: qcom: Convert to platform remove callback returning void

Vitaly Lubart (1):
      mei: me: emit error only if reset was unexpected

William Breathitt Gray (1):
      iio: addac: stx104: Add 8254 Counter/Timer support

Yang Yingliang (1):
      interconnect: fix error handling in qnoc_probe()

Yue Haibing (1):
      iio: Remove unused declarations

Zhang Shurong (1):
      iio: adc: stm32-adc: harden against NULL pointer deref in stm32_adc_probe()

 Documentation/ABI/testing/sysfs-bus-cdx            |   66 +-
 Documentation/ABI/testing/sysfs-bus-iio            |   75 +
 .../ABI/testing/sysfs-bus-iio-adc-mcp3564          |   53 +
 .../ABI/testing/sysfs-bus-iio-resolver-ad2s1210    |   27 +
 Documentation/devicetree/bindings/eeprom/at24.yaml |    1 +
 .../bindings/iio/accel/kionix,kx022a.yaml          |   14 +-
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   20 +-
 .../bindings/iio/adc/microchip,mcp3564.yaml        |  205 +++
 .../bindings/iio/adc/microchip,mcp3911.yaml        |    6 +
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |    3 +
 .../bindings/iio/adc/ti,twl6030-gpadc.yaml         |   43 +
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |   12 +-
 .../bindings/iio/imu/invensense,mpu6050.yaml       |    5 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    3 +
 .../bindings/iio/pressure/rohm,bm1390.yaml         |   52 +
 .../bindings/iio/resolver/adi,ad2s1210.yaml        |  177 ++
 .../bindings/interconnect/qcom,msm8939.yaml        |   74 +
 .../bindings/interconnect/qcom,msm8996.yaml        |  126 ++
 .../bindings/interconnect/qcom,qcm2290.yaml        |   60 +-
 .../bindings/interconnect/qcom,rpm-common.yaml     |   28 +
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |  250 +--
 .../bindings/interconnect/qcom,rpmh.yaml           |    1 +
 .../bindings/interconnect/qcom,sdm660.yaml         |  108 ++
 .../bindings/interconnect/qcom,sdx75-rpmh.yaml     |   92 +
 Documentation/devicetree/bindings/mtd/mtd.yaml     |    7 +-
 .../bindings/mtd/partitions/nvmem-cells.yaml       |    1 +
 .../devicetree/bindings/net/ti,cc1352p7.yaml       |   51 +
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |    1 +
 .../bindings/nvmem/amlogic,meson-gxbb-efuse.yaml   |    1 +
 .../bindings/nvmem/amlogic,meson6-efuse.yaml       |    1 +
 .../devicetree/bindings/nvmem/apple,efuses.yaml    |    1 +
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |    1 +
 .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |    1 +
 .../bindings/nvmem/microchip,sama7g5-otpc.yaml     |    1 +
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       |    1 +
 .../bindings/nvmem/nvmem-deprecated-cells.yaml     |   28 +
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |    9 -
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
 .../devicetree/bindings/nvmem/qcom,sec-qfprom.yaml |    1 +
 .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  |    1 +
 .../devicetree/bindings/nvmem/rockchip,otp.yaml    |    1 +
 .../devicetree/bindings/nvmem/rockchip-efuse.yaml  |    1 +
 .../bindings/nvmem/socionext,uniphier-efuse.yaml   |    1 +
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       |    1 +
 .../devicetree/bindings/nvmem/u-boot,env.yaml      |    2 +
 .../bindings/rtc/amlogic,meson6-rtc.yaml           |    1 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 +
 .../bindings/usb/realtek,rtd-type-c.yaml           |   82 +
 Documentation/misc-devices/eeprom.rst              |  107 --
 Documentation/misc-devices/index.rst               |    1 -
 Documentation/process/stable-kernel-rules.rst      |   13 +
 MAINTAINERS                                        |   36 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |    6 +
 drivers/accessibility/speakup/kobjects.c           |   25 +-
 drivers/android/binderfs.c                         |    2 +-
 drivers/cdx/Makefile                               |    2 +
 drivers/cdx/cdx.c                                  |  264 ++-
 drivers/cdx/cdx.h                                  |   22 +-
 drivers/cdx/controller/cdx_controller.c            |   20 +
 drivers/cdx/controller/mc_cdx_pcol.h               |   54 +
 drivers/cdx/controller/mcdi_functions.c            |   31 +
 drivers/cdx/controller/mcdi_functions.h            |   18 +
 drivers/char/hpet.c                                |    2 +-
 drivers/char/mem.c                                 |    4 +
 drivers/char/xilinx_hwicap/xilinx_hwicap.c         |  138 +-
 drivers/comedi/Kconfig                             |   45 +-
 drivers/comedi/drivers.c                           |    3 +-
 drivers/comedi/drivers/8255.c                      |    2 +-
 drivers/comedi/drivers/8255_pci.c                  |   15 +-
 drivers/comedi/drivers/adl_pci9111.c               |    8 +-
 drivers/comedi/drivers/adl_pci9118.c               |    8 +-
 drivers/comedi/drivers/adv_pci1710.c               |    8 +-
 drivers/comedi/drivers/adv_pci_dio.c               |   14 +-
 drivers/comedi/drivers/aio_aio12_8.c               |   10 +-
 drivers/comedi/drivers/amplc_dio200_common.c       |  104 +-
 drivers/comedi/drivers/amplc_dio200_pci.c          |   12 +-
 drivers/comedi/drivers/amplc_pc236_common.c        |    2 +-
 drivers/comedi/drivers/amplc_pci224.c              |    8 +-
 drivers/comedi/drivers/amplc_pci230.c              |   10 +-
 drivers/comedi/drivers/cb_das16_cs.c               |    8 +-
 drivers/comedi/drivers/cb_pcidas.c                 |   23 +-
 drivers/comedi/drivers/cb_pcidas64.c               |    7 +-
 drivers/comedi/drivers/cb_pcidda.c                 |    2 +-
 drivers/comedi/drivers/cb_pcimdas.c                |   12 +-
 drivers/comedi/drivers/cb_pcimdda.c                |    2 +-
 drivers/comedi/drivers/comedi_8254.c               |  236 ++-
 drivers/comedi/drivers/comedi_8255.c               |  135 +-
 drivers/comedi/drivers/daqboard2000.c              |    4 +-
 drivers/comedi/drivers/das08.c                     |   11 +-
 drivers/comedi/drivers/das16.c                     |   10 +-
 drivers/comedi/drivers/das16m1.c                   |   22 +-
 drivers/comedi/drivers/das1800.c                   |    8 +-
 drivers/comedi/drivers/das6402.c                   |    8 +-
 drivers/comedi/drivers/das800.c                    |    8 +-
 drivers/comedi/drivers/dmm32at.c                   |    3 +-
 drivers/comedi/drivers/me4000.c                    |    6 +-
 drivers/comedi/drivers/ni_at_a2150.c               |    8 +-
 drivers/comedi/drivers/ni_at_ao.c                  |    8 +-
 drivers/comedi/drivers/ni_atmio16d.c               |    2 +-
 drivers/comedi/drivers/ni_daq_dio24.c              |    2 +-
 drivers/comedi/drivers/ni_labpc_common.c           |   51 +-
 drivers/comedi/drivers/ni_mio_common.c             |   74 +-
 drivers/comedi/drivers/pcl711.c                    |    8 +-
 drivers/comedi/drivers/pcl724.c                    |    6 +-
 drivers/comedi/drivers/pcl812.c                    |   10 +-
 drivers/comedi/drivers/pcl816.c                    |    8 +-
 drivers/comedi/drivers/pcl818.c                    |    8 +-
 drivers/comedi/drivers/pcm3724.c                   |    2 +-
 drivers/comedi/drivers/rtd520.c                    |    6 +-
 drivers/extcon/Kconfig                             |   11 +
 drivers/extcon/Makefile                            |    1 +
 drivers/extcon/extcon-max77693.c                   |    7 +
 drivers/extcon/extcon-max77843.c                   |    7 +
 drivers/extcon/extcon-rtk-type-c.c                 | 1794 ++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |    2 +-
 drivers/fpga/altera-hps2fpga.c                     |   12 +-
 drivers/fpga/altera-ps-spi.c                       |   46 +-
 drivers/fpga/versal-fpga.c                         |    2 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |   17 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_tee.c           |    8 +-
 drivers/greybus/Kconfig                            |   10 +
 drivers/greybus/Makefile                           |    2 +
 drivers/greybus/gb-beagleplay.c                    |  501 ++++++
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  |    7 +
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  |    3 +
 .../hid_descriptor/amd_sfh_hid_report_desc.h       |   21 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |    9 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h |   15 +
 drivers/iio/accel/Kconfig                          |   10 +-
 drivers/iio/accel/adxl345.h                        |   21 +-
 drivers/iio/accel/adxl345_core.c                   |   47 +-
 drivers/iio/accel/adxl345_i2c.c                    |   20 +-
 drivers/iio/accel/adxl345_spi.c                    |   20 +-
 drivers/iio/accel/bma180.c                         |   27 +-
 drivers/iio/accel/fxls8962af.h                     |    1 -
 drivers/iio/accel/hid-sensor-accel-3d.c            |    6 +-
 drivers/iio/accel/kionix-kx022a-i2c.c              |   24 +-
 drivers/iio/accel/kionix-kx022a-spi.c              |   19 +-
 drivers/iio/accel/kionix-kx022a.c                  |  351 +++-
 drivers/iio/accel/kionix-kx022a.h                  |  114 +-
 drivers/iio/accel/mma8452.c                        |   28 +-
 drivers/iio/accel/msa311.c                         |    2 +-
 drivers/iio/accel/mxc4005.c                        |    8 +
 drivers/iio/adc/Kconfig                            |   29 +-
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/ab8500-gpadc.c                     |    6 +-
 drivers/iio/adc/ad4130.c                           |   15 +-
 drivers/iio/adc/ad7192.c                           |  269 +--
 drivers/iio/adc/at91-sama5d2_adc.c                 |    6 +-
 drivers/iio/adc/at91_adc.c                         |  114 +-
 drivers/iio/adc/axp20x_adc.c                       |    6 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |    6 +-
 drivers/iio/adc/dln2-adc.c                         |    5 +-
 drivers/iio/adc/ep93xx_adc.c                       |    6 +-
 drivers/iio/adc/exynos_adc.c                       |    6 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |    6 +-
 drivers/iio/adc/hx711.c                            |    6 +-
 drivers/iio/adc/imx8qxp-adc.c                      |    6 +-
 drivers/iio/adc/imx93_adc.c                        |    6 +-
 drivers/iio/adc/ltc2309.c                          |  246 +++
 drivers/iio/adc/ltc2497.c                          |    5 +-
 drivers/iio/adc/max1363.c                          |   87 +-
 drivers/iio/adc/mcp3564.c                          | 1513 +++++++++++++++++
 drivers/iio/adc/mcp3911.c                          |  562 ++++--
 drivers/iio/adc/meson_saradc.c                     |   22 +-
 drivers/iio/adc/mp2629_adc.c                       |    6 +-
 drivers/iio/adc/mt6577_auxadc.c                    |   72 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |    6 +-
 drivers/iio/adc/npcm_adc.c                         |    6 +-
 drivers/iio/adc/palmas_gpadc.c                     |    2 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |    6 +-
 drivers/iio/adc/rcar-gyroadc.c                     |    6 +-
 drivers/iio/adc/spear_adc.c                        |   64 +-
 drivers/iio/adc/stm32-adc-core.c                   |   12 +-
 drivers/iio/adc/stm32-adc.c                        |    8 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |    6 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |    6 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |    8 +-
 drivers/iio/adc/ti-adc081c.c                       |   12 +-
 drivers/iio/adc/ti-ads1015.c                       |    7 +-
 drivers/iio/adc/ti_am335x_adc.c                    |    6 +-
 drivers/iio/adc/twl4030-madc.c                     |    6 +-
 drivers/iio/adc/twl6030-gpadc.c                    |   16 +-
 drivers/iio/adc/vf610_adc.c                        |    6 +-
 drivers/iio/addac/Kconfig                          |    1 +
 drivers/iio/addac/ad74413r.c                       |   24 +-
 drivers/iio/addac/stx104.c                         |   61 +-
 drivers/iio/amplifiers/hmc425a.c                   |   17 +
 drivers/iio/chemical/atlas-ezo-sensor.c            |    6 +-
 drivers/iio/chemical/atlas-sensor.c                |   32 +-
 drivers/iio/chemical/sgp30.c                       |   24 +-
 drivers/iio/chemical/vz89x.c                       |   16 +-
 drivers/iio/dac/dpot-dac.c                         |    6 +-
 drivers/iio/dac/lpc18xx_dac.c                      |    6 +-
 drivers/iio/dac/mcp4725.c                          |   42 +-
 drivers/iio/dac/stm32-dac-core.c                   |   15 +-
 drivers/iio/dac/stm32-dac.c                        |    9 +-
 drivers/iio/dac/ti-dac5571.c                       |   48 +-
 drivers/iio/dac/vf610_dac.c                        |    6 +-
 drivers/iio/frequency/adf4350.c                    |   75 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |    6 +-
 drivers/iio/humidity/hid-sensor-humidity.c         |    6 +-
 drivers/iio/humidity/si7005.c                      |    7 +
 drivers/iio/iio_core.h                             |    3 -
 drivers/iio/imu/adis16475.c                        |  238 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c          |   13 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    3 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +-
 drivers/iio/industrialio-core.c                    |    4 +
 drivers/iio/industrialio-event.c                   |   55 +
 drivers/iio/light/cm3605.c                         |    6 +-
 drivers/iio/light/hid-sensor-als.c                 |  134 +-
 drivers/iio/light/hid-sensor-prox.c                |    6 +-
 drivers/iio/light/lm3533-als.c                     |    6 +-
 drivers/iio/light/opt4001.c                        |    2 +-
 drivers/iio/magnetometer/ak8975.c                  |   97 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    6 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    4 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |    6 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |    6 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |    6 +-
 drivers/iio/potentiometer/ad5110.c                 |   21 +-
 drivers/iio/potentiometer/ds1803.c                 |   13 +-
 drivers/iio/pressure/Kconfig                       |    9 +
 drivers/iio/pressure/Makefile                      |    1 +
 drivers/iio/pressure/hid-sensor-press.c            |    6 +-
 drivers/iio/pressure/ms5637.c                      |    6 +-
 drivers/iio/pressure/rohm-bm1390.c                 |  934 ++++++++++
 drivers/iio/proximity/cros_ec_mkbp_proximity.c     |    6 +-
 drivers/iio/proximity/srf04.c                      |    6 +-
 drivers/iio/proximity/sx9310.c                     |   46 +-
 drivers/iio/resolver/Kconfig                       |   13 +
 drivers/iio/resolver/Makefile                      |    1 +
 drivers/iio/resolver/ad2s1210.c                    | 1519 +++++++++++++++++
 drivers/iio/temperature/hid-sensor-temperature.c   |    6 +-
 drivers/iio/temperature/mlx90614.c                 |    2 +-
 drivers/iio/temperature/tmp117.c                   |   94 +-
 drivers/iio/trigger/iio-trig-interrupt.c           |    6 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |    6 +-
 drivers/interconnect/imx/imx.h                     |    9 +-
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/icc-rpm-clocks.c         |    6 +
 drivers/interconnect/qcom/icc-rpm.c                |   90 +-
 drivers/interconnect/qcom/icc-rpm.h                |   15 +
 drivers/interconnect/qcom/icc-rpmh.c               |    4 +-
 drivers/interconnect/qcom/icc-rpmh.h               |    2 +-
 drivers/interconnect/qcom/msm8974.c                |    4 +-
 drivers/interconnect/qcom/msm8996.c                |    8 +-
 drivers/interconnect/qcom/osm-l3.c                 |    3 +-
 drivers/interconnect/qcom/qcm2290.c                |    9 +-
 drivers/interconnect/qcom/qdu1000.c                |    3 +-
 drivers/interconnect/qcom/sa8775p.c                |    2 +-
 drivers/interconnect/qcom/sc7180.c                 |    3 +-
 drivers/interconnect/qcom/sc7280.c                 |    3 +-
 drivers/interconnect/qcom/sc8180x.c                |    3 +-
 drivers/interconnect/qcom/sc8280xp.c               |    3 +-
 drivers/interconnect/qcom/sdm660.c                 |    4 +
 drivers/interconnect/qcom/sdm670.c                 |    3 +-
 drivers/interconnect/qcom/sdm845.c                 |    3 +-
 drivers/interconnect/qcom/sdx55.c                  |    2 +-
 drivers/interconnect/qcom/sdx65.c                  |    2 +-
 drivers/interconnect/qcom/sdx75.c                  | 1107 ++++++++++++
 drivers/interconnect/qcom/sdx75.h                  |   97 ++
 drivers/interconnect/qcom/sm6350.c                 |    3 +-
 drivers/interconnect/qcom/sm8150.c                 |    3 +-
 drivers/interconnect/qcom/sm8250.c                 |    3 +-
 drivers/interconnect/qcom/sm8350.c                 |    3 +-
 drivers/interconnect/qcom/sm8450.c                 |    2 +-
 drivers/interconnect/qcom/sm8550.c                 |    2 +-
 drivers/mcb/mcb-core.c                             |    7 +-
 drivers/mcb/mcb-parse.c                            |    2 +-
 drivers/misc/bcm-vk/bcm_vk_msg.c                   |    2 +-
 drivers/misc/bcm-vk/bcm_vk_msg.h                   |    2 +-
 drivers/misc/c2port/core.c                         |    2 +-
 drivers/misc/cxl/file.c                            |   21 +-
 drivers/misc/eeprom/Kconfig                        |   14 -
 drivers/misc/eeprom/Makefile                       |    1 -
 drivers/misc/eeprom/eeprom.c                       |  214 ---
 drivers/misc/eeprom/idt_89hpesx.c                  |   11 +-
 drivers/misc/ibmvmc.c                              |    4 +-
 drivers/misc/mei/bus.c                             |   92 +-
 drivers/misc/mei/client.c                          |   20 +-
 drivers/misc/mei/dma-ring.c                        |    6 +-
 drivers/misc/mei/hbm.c                             |    6 +-
 drivers/misc/mei/hw-me-regs.h                      |    3 +
 drivers/misc/mei/hw-me.c                           |   77 +-
 drivers/misc/mei/hw-me.h                           |    4 +
 drivers/misc/mei/hw.h                              |   12 +-
 drivers/misc/mei/init.c                            |   27 +-
 drivers/misc/mei/interrupt.c                       |    6 +-
 drivers/misc/mei/main.c                            |    8 +-
 drivers/misc/mei/mei_dev.h                         |   51 +-
 drivers/misc/mei/pxp/mei_pxp.c                     |   88 +-
 drivers/misc/ocxl/file.c                           |   27 +-
 drivers/misc/pci_endpoint_test.c                   |    4 +
 drivers/misc/phantom.c                             |   24 +-
 drivers/misc/pvpanic/pvpanic-mmio.c                |   58 +-
 drivers/misc/pvpanic/pvpanic-pci.c                 |   58 +-
 drivers/misc/pvpanic/pvpanic.c                     |   76 +-
 drivers/misc/pvpanic/pvpanic.h                     |   10 +-
 drivers/misc/ti-st/st_core.c                       |    7 +-
 drivers/misc/ti-st/st_kim.c                        |    5 +-
 drivers/misc/uacce/uacce.c                         |   17 +-
 drivers/mtd/mtdcore.c                              |    3 +-
 drivers/nvmem/apple-efuses.c                       |    1 +
 drivers/nvmem/core.c                               |   10 +-
 drivers/nvmem/imx-ocotp-scu.c                      |    1 +
 drivers/nvmem/imx-ocotp.c                          |    1 +
 drivers/nvmem/meson-efuse.c                        |    1 +
 drivers/nvmem/meson-mx-efuse.c                     |    1 +
 drivers/nvmem/microchip-otpc.c                     |    1 +
 drivers/nvmem/mtk-efuse.c                          |    1 +
 drivers/nvmem/mxs-ocotp.c                          |   10 +-
 drivers/nvmem/qcom-spmi-sdam.c                     |    1 +
 drivers/nvmem/qfprom.c                             |    7 +-
 drivers/nvmem/rave-sp-eeprom.c                     |    1 +
 drivers/nvmem/rockchip-efuse.c                     |    1 +
 drivers/nvmem/sc27xx-efuse.c                       |    1 +
 drivers/nvmem/sec-qfprom.c                         |    1 +
 drivers/nvmem/sprd-efuse.c                         |    1 +
 drivers/nvmem/stm32-romem.c                        |    8 +-
 drivers/nvmem/sunplus-ocotp.c                      |    1 +
 drivers/nvmem/sunxi_sid.c                          |    1 +
 drivers/nvmem/uniphier-efuse.c                     |    1 +
 drivers/nvmem/zynqmp_nvmem.c                       |    1 +
 drivers/parport/procfs.c                           |   53 +-
 drivers/parport/share.c                            |   26 +-
 drivers/rapidio/devices/rio_mport_cdev.c           |   16 +-
 drivers/rapidio/rio_cm.c                           |   18 +-
 drivers/rtc/nvmem.c                                |    1 +
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/frequency/ad9832.c             |   15 +-
 drivers/staging/iio/frequency/ad9834.c             |   21 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   22 +-
 drivers/staging/iio/resolver/Kconfig               |   18 -
 drivers/staging/iio/resolver/Makefile              |    6 -
 drivers/staging/iio/resolver/ad2s1210.c            |  716 --------
 drivers/tee/tee_core.c                             |   21 +-
 drivers/vfio/cdx/main.c                            |    1 +
 drivers/w1/slaves/w1_ds250x.c                      |    1 +
 include/drm/i915_pxp_tee_interface.h               |    6 +-
 include/dt-bindings/interconnect/qcom,sdx75.h      |  102 ++
 include/linux/cdx/cdx_bus.h                        |   41 +-
 include/linux/comedi/comedi_8254.h                 |   51 +-
 include/linux/comedi/comedi_8255.h                 |   24 +-
 include/linux/comedi/comedidev.h                   |    2 +-
 include/linux/hid-sensor-ids.h                     |    4 +
 include/linux/iio/iio.h                            |   12 +-
 include/linux/iio/sw_device.h                      |    3 -
 include/linux/iio/sw_trigger.h                     |    3 -
 include/linux/mei_cl_bus.h                         |   12 +-
 include/linux/mod_devicetable.h                    |   10 +
 include/linux/nvmem-provider.h                     |    4 +-
 include/linux/parport.h                            |    2 -
 include/uapi/linux/counter.h                       |    2 +-
 include/uapi/linux/iio/types.h                     |    4 +
 include/uapi/linux/mei.h                           |   14 +-
 scripts/mod/devicetable-offsets.c                  |    4 +
 scripts/mod/file2alias.c                           |    8 +
 tools/iio/iio_event_monitor.c                      |    8 +
 tools/iio/iio_generic_buffer.c                     |   13 +-
 363 files changed, 13498 insertions(+), 3654 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-resolver-ad2s1210
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/rohm,bm1390.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s1210.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8996.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpm-common.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdx75-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-deprecated-cells.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/realtek,rtd-type-c.yaml
 delete mode 100644 Documentation/misc-devices/eeprom.rst
 create mode 100644 drivers/extcon/extcon-rtk-type-c.c
 create mode 100644 drivers/greybus/gb-beagleplay.c
 create mode 100644 drivers/iio/adc/ltc2309.c
 create mode 100644 drivers/iio/adc/mcp3564.c
 create mode 100644 drivers/iio/pressure/rohm-bm1390.c
 create mode 100644 drivers/iio/resolver/ad2s1210.c
 create mode 100644 drivers/interconnect/qcom/sdx75.c
 create mode 100644 drivers/interconnect/qcom/sdx75.h
 delete mode 100644 drivers/misc/eeprom/eeprom.c
 delete mode 100644 drivers/staging/iio/resolver/Kconfig
 delete mode 100644 drivers/staging/iio/resolver/Makefile
 delete mode 100644 drivers/staging/iio/resolver/ad2s1210.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx75.h
