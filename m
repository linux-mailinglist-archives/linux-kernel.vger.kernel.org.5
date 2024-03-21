Return-Path: <linux-kernel+bounces-110067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C898885986
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F91C22381
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CC74E05;
	Thu, 21 Mar 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tkTamV4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB583CC1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026142; cv=none; b=PaVkspdr9hKYUvqNKVT1OLUGp1A3C101ia8SI8ZxwUXsbv1Xz+SFeCIReYrXK1I5b5cLwe129UAHM0KYS3SdQSoueVvXXEnVmYFeQB+HjsXtslxRld+gJTSrmm/oBVW9qZFn78uJs44QLQGSuOg8FeVLan3O2u+MUcz+0e6JdEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026142; c=relaxed/simple;
	bh=MmUjGHttA0ICRZsutK5auxQ12cXeNvNh9VtxOxQFnIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t8zG6wgY1Px9iLGreq64x+tUUh2+AZld+ABMoNqS/beZLNlZEVWc9WQhtU2h7DawwlA16RN7E8IrgKqLcapjW9mljG3NGRCcbqd/P9JdBv1v5jNH/sWDTezSBsFuUZuZnPdnslFWrE8FL8z+fhfyxbrmcRDQTj8USnE80Ul2M0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tkTamV4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A70C433C7;
	Thu, 21 Mar 2024 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711026142;
	bh=MmUjGHttA0ICRZsutK5auxQ12cXeNvNh9VtxOxQFnIY=;
	h=Date:From:To:Cc:Subject:From;
	b=tkTamV4KuVVc8aYDx9pv3Y3HDeU95qB0WC3gZiIMrf3xT6C5AjhnPx6QhJCCSqtMe
	 6pXr1D4h+Rb5oq9XFqJmhSQ3oKJcQ0STzb23AXK8g4P8ftnVv9t2z52UldPLopeU9S
	 4lN7SKjW29c4iky4Ou/WXEMyhiIqiIubncYMu4so=
Date: Thu, 21 Mar 2024 14:02:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 6.9-rc1
Message-ID: <Zfwv2y7P7BneKqMZ@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.9-rc1

for you to fetch changes up to 367b3560e10bbae3660d8ba4d0a7cc92170d8398:

  binder: remove redundant variable page_addr (2024-03-07 22:22:32 +0000)

----------------------------------------------------------------
Char/Misc and other driver subsystem updates for 6.9-rc1

Here is the big set of char/misc and a number of other driver subsystem
updates for 6.9-rc1.  Included in here are:
  - IIO driver updates, loads of new ones and evolution of existing ones
  - coresight driver updates
  - const cleanups for many driver subsystems
  - speakup driver additions
  - platform remove callback void cleanups
  - mei driver updates
  - mhi driver updates
  - cdx driver updates for MSI interrupt handling
  - nvmem driver updates
  - other smaller driver updates and cleanups, full details in the
    shortlog

All of these have been in linux-next for a long time with no reported
issue, other than a build warning with some older versions of gcc for a
speakup driver, fix for that will come in a few days when I catch up
with my pending patch queues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Skladowski (2):
      dt-bindings: interconnect: Add Qualcomm MSM8909 DT bindings
      interconnect: qcom: Add MSM8909 interconnect provider driver

Alexander Usyskin (4):
      mei: hdcp: match without driver name
      mei: pxp: match without driver name
      mei: hdcp: add dependency on Xe driver
      mei: pxp: add dependency on Xe driver

Amit Dhingra (1):
      MAINTAINERS: correct file entry for AD7091R

Andrew Davis (4):
      iio: health: afe4403: Use devm action helper for regulator disable
      iio: health: afe4403: Use devm IIO helpers
      iio: health: afe4404: Use devm action helper for regulator disable
      iio: health: afe4404: Use devm IIO helpers

Andy Shevchenko (3):
      misc: eeprom_93xx46: Remove unused of_gpio.h
      misc: hi6421-spmi-pmic: Remove unused of_gpio.h
      misc: hisi_hikey_usb: Remove unused of_gpio.h

Arturas Moskvinas (1):
      iio: adc: mcp320x: Simplify device removal logic

Basavaraj Natikar (2):
      iio: hid-sensor-als: Add light color temperature support
      iio: hid-sensor-als: Add light chromaticity support

Bjorn Helgaas (3):
      mei: gsc: remove unnecessary NULL pointer checks
      mei: txe: remove unnecessary NULL pointer checks
      mei: me: remove unnecessary NULL pointer checks

Chen-Yu Tsai (1):
      nvmem: mtk-efuse: Drop NVMEM device name

ChiYuan Huang (2):
      dt-bindings: iio: adc: rtq6056: add support for the whole RTQ6056 family
      iio: adc: rtq6056: Add support for the whole RTQ6056 family

Chris Leech (4):
      uio: introduce UIO_MEM_DMA_COHERENT type
      cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
      uio_pruss: UIO_MEM_DMA_COHERENT conversion
      uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion

Christophe JAILLET (2):
      slimbus: core: Remove usage of the deprecated ida_simple_xx() API
      greybus: Remove usage of the deprecated ida_simple_xx() API

Colin Ian King (3):
      iio: invensense: remove redundant initialization of variable period
      comedi: remove redundant assignment to variable range
      binder: remove redundant variable page_addr

Dan Carpenter (4):
      bus: mhi: ep: check the correct variable in mhi_ep_register_controller()
      iio: adc: ti-ads1298: Fix error code in probe()
      iio: adc: ti-ads1298: prevent divide by zero in ads1298_set_samp_freq()
      char: xilinx_hwicap: Fix NULL vs IS_ERR() bug

Danila Tikhonov (2):
      dt-bindings: interconnect: Add Qualcomm SM7150 DT bindings
      interconnect: qcom: Add SM7150 driver support

David Lechner (1):
      iio: core: use INDIO_ALL_BUFFER_MODES in iio_buffer_enabled()

Dawei Li (1):
      misc: eeprom/idt_89hpesx: Convert data structures to LE explicitly

Dimitri Fedrau (3):
      iio: humidity: hdc3020: switch to 16bit register defines
      dt-bindings: iio: humidity: hdc3020: add interrupt bindings in example
      iio: humidity: hdc3020: add threshold events support

Dumitru Ceclan (5):
      dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
      dt-bindings: iio: hmc425a: add entry for LTC6373
      iio: amplifiers: hmc425a: move conversion logic
      iio: amplifiers: hmc425a: use pointers in match table
      iio: amplifiers: hmc425a: add support for LTC6373 Instrumentation Amplifier

Erick Archer (1):
      bus: mhi: ep: Use kcalloc() instead of kzalloc()

Georgi Djakov (3):
      Merge branch 'icc-msm8909' into icc-next
      Merge branch 'icc-cleanup' into icc-next
      Merge branch 'icc-sm7150' into icc-next

Greg Kroah-Hartman (10):
      Merge 6.8-rc3 into char-misc-next
      coresight: make coresight_bustype const
      Merge 6.8-rc5 into char-misc-next
      Merge tag 'iio-for-6.9a' of http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'mhi-for-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'coresight-next-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'fpga-for-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'iio-for-6.9b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'icc-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      greybus: make greybus_bus_type const

Hans de Goede (1):
      iio: accel: da280: Simplify id-matching

Ian Abbott (2):
      misc: hpilo: fix inconsistent device numbers
      misc: hpilo: rename device creation loop variable

Icenowy Zheng (3):
      dt-bindings: vendor-prefix: Add prefix for Voltafield
      dt-bindings: iio: magnetometer: Add Voltafield AF8133J
      iio: magnetometer: add a driver for Voltafield AF8133J magnetometer

James Clark (16):
      coresight: Fix uninitialized struct warnings
      coresight: etm3x: Fix build warning
      coresight: Fix undeclared variable warnings from sparse checker
      coresight: Make current W=1 warnings default
      coresight: Fix issue where a source device's helpers aren't disabled
      coresight: Make language around "activated" sinks consistent
      coresight: Remove ops callback checks
      coresight: Move mode to struct coresight_device
      coresight: Remove the 'enable' field.
      coresight: Move all sysfs code to sysfs file
      coresight: Remove atomic type from refcnt
      coresight: Remove unused stubs
      coresight: Add explicit member initializers to coresight_dev_type
      coresight: Add helper for atomically taking the device
      coresight: Add a helper for getting csdev->mode
      coresight: Add helper for setting csdev->mode

Javier Carrasco (5):
      iio: light: as73211: use IIO_VAL_FRACTIONAL for intensity scales
      dt-bindings: iio: light: as73211: add support for as7331
      iio: light: as73211: add support for as7331
      dt-bindings: iio: light: vishay,veml6075: make vdd-supply required
      char: xilinx_hwicap: drop casting to void in dev_set_drvdata

Jeff Johnson (2):
      bus: mhi: host: pci_generic: constify modem_telit_fn980_hw_v1_config
      slimbus: qcom-ngd-ctrl: Make QMI message rules const

Jeffrey Hugo (4):
      bus: mhi: host: Add MHI_PM_SYS_ERR_FAIL state
      bus: mhi: host: Read PK HASH dynamically
      dt-bindings: interconnect: qcom,rpmh: Fix bouncing @codeaurora address
      Revert "bus: mhi: core: Add support for reading MHI info from device"

Jerome Brunet (1):
      nvmem: meson-efuse: fix function pointer type mismatch

Jesus Gonzalez (1):
      Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding on some devices

Jiri Slaby (SUSE) (1):
      hpet: remove hpets::hp_clocksource

Jonathan Cameron (42):
      iio: accel: da280: Stop using ACPI_PTR()
      iio: accel: kxcjk-1013: Move acpi_device_id table under ifdef CONFIG_ACPI
      iio: accel: mma9551: Drop ACPI_PTR() usage
      iio: accel: mma9553: Drop ACPI_PTR() usage
      iio: accel: mxc4005: Drop ACPI_PTR() usage
      iio: accel: mxc6255: Drop ACPI_PTR() usage
      iio: accel: stk8ba50: Drop ACPI_PTR() usage
      iio: accel: bmc150: Drop ACPI_PTR()
      iio: gyro: bmg160: Drop ACPI_PTR() usage
      iio: humidity: hts221: Drop ACPI_PTR() usage
      iio: imu: fxos8700: Drop ACPI_PTR() usage
      iio: imu: kmx61: Drop ACPI_PTR() usage
      iio: light: jsa1212: Drop ACPI_PTR() usage
      iio: light: ltr501: Drop ACPI_PTR() usage
      iio: light: rpr0521: Drop ACPI_PTR() usage
      iio: light: stk3310: Drop ACPI_PTR() usage
      iio: light: us5182d: Drop ACPI_PTR() usage
      iio: magnetometer: bmc150: Drop ACPI_PTR() usage
      iio: magnetometer: mmc35240: Drop ACPI_PTR() usage
      iio: potentiometer: max5487: Drop ACPI_PTR() usage
      iio: st_sensors: drop ACPI_PTR() and CONFIG_ACPI guards
      iio: pressure: hp206c: drop ACPI_PTR() and CONFIG_ACPI guards
      iio: light: max44000: drop ACPI_PTR() and CONFIG_ACPI guards
      iio: adc: ti-adc109s102: drop ACPI_PTR() and CONFIG_ACPI guards
      iio: locking: introduce __cleanup() based direct mode claiming infrastructure
      iio: dummy: Use automatic lock and direct mode cleanup.
      iio: accel: adxl367: Use automated cleanup for locks and iio direct mode.
      iio: imu: bmi323: Use cleanup handling for iio_device_claim_direct_mode()
      iio: adc: max1363: Use automatic cleanup for locks and iio mode claiming.
      iio: proximity: sx9360: Use automated cleanup for locks and IIO mode claiming.
      iio: proximity: sx9324: Use automated cleanup for locks and IIO mode claiming.
      iio: proximity: sx9310: Use automated cleanup for locks and IIO mode claiming.
      iio: adc: ad4130: Use automatic cleanup of locks and direct mode.
      iio: adc: ad7091r-base: Use auto cleanup of locks.
      iio: light: vl6180: Drop unused linux/of.h include
      iio: light: al3320a: Drop unused linux/of.h include
      iio: light: al3010: Switch from linux/of.h to linux/mod_devicetable.h
      iio: adc: ads8688: Switch to mod_devicetable.h for struct of_device_id definition
      iio: accel: adxl372: Switch from linux/of.h to linux/mod_devicetable.h
      iio: accel: bma180: Switch from linux/of.h to linux/mod_devicetable.h
      iio: accel: kxsd9: Switch from linux/of.h to linux/mod_devicetable.h
      iio: dac: mcp4821: Switch to including mod_devicetable.h for struct of_device_id definition.

Jonathan LoBue (2):
      iio: accel: bmc150: Document duplicate ACPI entries with bmi323 driver
      iio: imu: bmi323: Add ACPI Match Table

Josua Mayer (1):
      dt-bindings: iio: humidity: hdc20x0: add optional interrupts property

Jun Yan (1):
      iio: accel: bmi088: add i2c support for bmi088 accel driver

Justin Stitt (1):
      iio: sx9324: avoid copying property strings

Kim Seer Paller (2):
      dt-bindings: iio: frequency: add admfm2000
      iio: frequency: admfm2000: New driver

Konrad Dybcio (3):
      interconnect: qcom: sm8550: Remove bogus per-RSC BCMs and nodes
      dt-bindings: interconnect: Remove bogus interconnect nodes
      interconnect: qcom: x1e80100: Remove bogus per-RSC BCMs and nodes

Krishna chaitanya chundru (2):
      bus: mhi: host: Add tracing support
      bus: mhi: host: Change the trace string for the userspace tools mapping

Krzysztof Kozlowski (11):
      interconnect: qcom: msm8909: constify pointer to qcom_icc_node
      interconnect: qcom: sa8775p: constify pointer to qcom_icc_node
      interconnect: qcom: sm8250: constify pointer to qcom_icc_node
      interconnect: qcom: sm6115: constify pointer to qcom_icc_node
      interconnect: qcom: sa8775p: constify pointer to qcom_icc_bcm
      interconnect: qcom: x1e80100: constify pointer to qcom_icc_bcm
      interconnect: constify of_phandle_args in xlate
      dt-bindings: iio: adc: drop redundant type from label
      iio: adc: qcom-pm8xxx-xoadc: drop unused kerneldoc struct pm8xxx_chan_info member
      iio: proximity: isl29501: make use of of_device_id table
      dt-bindings: nvmem: add common definition of nvmem-cell-cells

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: improve kernel docs and comments
      iio: imu: st_lsm6dsx: add support to ASM330LHHXG1
      dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1

Lukas Bulwahn (1):
      pps: use cflags-y instead of EXTRA_CFLAGS

Mao Jinlong (3):
      coresight: etm4x: Set skip_power_up in etm4_init_arch_data function
      dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
      coresight-tpda: Change qcom,dsb-element-size to qcom,dsb-elem-bits

Marco Felsch (2):
      dt-bindings: iio: ti,tmp117: add optional label property
      dt-bindings: iio: gyroscope: bosch,bmg160: add spi-max-frequency

Marco Pagani (1):
      fpga: remove redundant checks for bridge ops

Marius Cristea (2):
      dt-bindings: iio: adc: adding support for PAC193X
      iio: adc: adding support for PAC193x

Markus Schneider-Pargmann (1):
      nvmem: core: Print error on wrong bits DT property

Masahiro Yamada (1):
      platform: goldfish: move the separate 'default' propery for CONFIG_GOLDFISH

Matt Hsiao (1):
      MAINTAINERS: change the maintainer for hpilo driver

Matti Vaittinen (3):
      iio: test: test gain-time-scale helpers
      MAINTAINERS: add IIO GTS tests
      iio: gts-helper: Fix division loop

Mike Looijmans (2):
      dt-bindings: iio: adc: ti-ads1298: Add bindings
      iio: adc: ti-ads1298: Add driver

Mohammed Billoo (1):
      iio: adc: ti-ads1015: Use correct pga upper bound

Mårten Lindahl (1):
      iio: light: vcnl4000: Set ps high definition for 4040/4200

Nadav Amit (1):
      vmw_balloon: change maintainership

Naresh Solanki (1):
      dt-bindings: iio: afe: voltage-divider: Add io-channel-cells

Nikita Mikhailevich (1):
      iio: accel: mxc4005: new ACPI ID for the MXC6655 accelerometer

Nipun Gupta (1):
      cdx: add MSI support for CDX bus

Nuno Sa (13):
      iio: buffer-dmaengine: make use of the 'struct device *' argument
      iio: imu: adis16475: make use of irq_get_trigger_type()
      iio: imu: adis16480: make use of irq_get_trigger_type()
      iio: adc: ad_sigma_delta: allow overwriting the IRQ flags
      dt-bindings: adc: ad9467: add new io-backend property
      dt-bindings: adc: axi-adc: update bindings for backend framework
      iio: buffer-dmaengine: export buffer alloc and free functions
      iio: add the IIO backend framework
      iio: adc: ad9467: convert to backend framework
      iio: adc: adi-axi-adc: move to backend framework
      iio: temperature: ltc2983: make use of spi_get_device_match_data()
      iio: temperature: ltc2983: rename ltc2983_parse_dt()
      iio: temperature: ltc2983: explicitly set the name in chip_info

Olivier Moysan (1):
      of: property: add device link support for io-backends

Ondrej Jirman (1):
      MAINTAINERS: Add an entry for AF8133J driver

Peng Fan (1):
      dt-bindings: iio: adc: imx93: drop the 4th interrupt

Petre Rodan (17):
      dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml improvements
      dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add pressure-triplet
      dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add spi bus
      iio: pressure: mprls0025pa fix off-by-one enum
      iio: pressure: mprls0025pa improve driver error resilience
      iio: pressure: mprls0025pa remove defaults
      iio: pressure: mprls0025pa whitespace cleanup
      iio: pressure: mprls0025pa refactor to split core and i2c parts.
      iio: pressure: mprls0025pa add triplet property
      iio: pressure: mprls0025pa add SPI driver
      tools: iio: replace seekdir() in iio_generic_buffer
      dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
      iio: pressure: hsc030pa: use signed type to hold div_64() result
      iio: pressure: hsc030pa: include cleanup
      iio: pressure: hsc030pa: update datasheet URLs
      iio: pressure: hsc030pa add mandatory delay
      iio: pressure: hsc030pa add triggered buffer

Praveen Teja Kundanala (5):
      dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml
      firmware: xilinx: Add ZynqMP efuse access API
      nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup
      nvmem: zynqmp_nvmem: Add support to access efuse
      MAINTAINERS: Add maintainers for ZynqMP NVMEM driver

Quentin Schulz (3):
      iio: adc: rockchip_saradc: fix bitmask for channels on SARADCv2
      iio: adc: rockchip_saradc: use mask for write_enable bitfield
      iio: adc: rockchip_saradc: replace custom logic with devm_reset_control_get_optional_exclusive

Ramona Gradinariu (3):
      docs: iio: Refactor index.rst
      docs: iio: add documentation for device buffers
      docs: iio: add documentation for adis16475 driver

Randy Dunlap (1):
      iio: dummy_evgen: remove Excess kernel-doc comments

Ricardo B. Marliere (14):
      iio: core: make iio_bus_type const
      fpga: dfl: make dfl_bus_type const
      greybus: constify the struct device_type usage
      slimbus: core: make slimbus_bus const
      nvmem: core: make nvmem_layout_bus_type const
      most: core: make mostbus const
      ipack: make ipack_bus_type const
      dio: make dio_bus_type const
      siox: constify the struct device_type usage
      tifm: make tifm_adapter_class constant
      mcb: make mcb_bus_type const
      mcb: constify the struct device_type usage
      siox: make siox_bus_type const
      greybus: move is_gb_* functions out of greybus.h

Rob Herring (1):
      nvmem: fixed-cell: Simplify nested if/then schema

Sakari Ailus (3):
      mei: vsc: Call wake_up() in the threaded IRQ handler
      mei: vsc: Don't use sleeping condition in wait_event_timeout()
      mei: vsc: Assign pinfo fields in variable declaration

Samuel Thibault (2):
      speakup: Fix 8bit characters from direct synth
      speakup: Add /dev/synthu device

Sean Rhodes (1):
      iio: accel: kxcjk-1013: Implement ACPI method ROTM to retrieve mount matrix.

Srinivas Pandruvada (2):
      iio: hid-sensor-als: Assign channels dynamically
      iio: hid-sensor-als: Remove hardcoding of values for enums

Suzuki K Poulose (1):
      coresight: tpdm: Fix build break due to uninitialised field

Tao Zhang (10):
      coresight-tpdm: Optimize the store function of tpdm simple dataset
      coresight-tpdm: Optimize the useage of tpdm_has_dsb_dataset
      dt-bindings: arm: qcom,coresight-tpdm: Add support for CMB element size
      coresight-tpdm: Add CMB dataset support
      coresight-tpda: Add support to configure CMB element
      coresight-tpdm: Add support to configure CMB
      coresight-tpdm: Add pattern registers support for CMB
      coresight-tpdm: Add timestamp control register support for the CMB
      dt-bindings: arm: qcom,coresight-tpdm: Add support for TPDM CMB MSR register
      coresight-tpdm: Add msr register support for CMB

Thomas Haemmerle (2):
      dt-bindings: iio: ti,tmp117: add vcc supply binding
      iio: temperature: tmp117: add support for vcc-supply

Uwe Kleine-König (14):
      misc: atmel-ssc: Convert to platform remove callback returning void
      cxl: Convert to platform remove callback returning void
      misc: fastrpc: Convert to platform remove callback returning void
      misc: hisi_hikey_usb: Convert to platform remove callback returning void
      mei: vsc: Convert to platform remove callback returning void
      misc: open-dice: Convert to platform remove callback returning void
      misc: sram: Convert to platform remove callback returning void
      misc: ti-st: st_kim: Convert to platform remove callback returning void
      misc: vcpu_stall_detector: Convert to platform remove callback returning void
      misc: xilinx_sdfec: Convert to platform remove callback returning void
      misc: xilinx_tmr_inject: Convert to platform remove callback returning void
      char: xillybus: Convert to platform remove callback returning void
      parport: amiga: Convert to platform remove callback returning void
      parport: sunbpp: Convert to platform remove callback returning void

Vitaly Lubart (1):
      mei: gsc: add support for auxiliary device created by Xe driver

William-tw Lin (1):
      nvmem: mtk-efuse: Register MediaTek socinfo driver from efuse

Yang Jihong (1):
      hwtracing: hisi_ptt: Move type check to the beginning of hisi_ptt_pmu_event_init()

andy.shevchenko@gmail.com (3):
      iio: st_sensors: lsm9ds0: Use dev_err_probe() everywhere
      iio: st_sensors: lsm9ds0: Don't use "proxy" headers
      iio: st_sensors: lsm9ds0: Use common style for terminator in ID tables

 .mailmap                                           |    2 +
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |   87 +
 .../ABI/testing/sysfs-bus-iio-adc-pac1934          |    9 +
 .../bindings/arm/qcom,coresight-tpdm.yaml          |   40 +-
 Documentation/devicetree/bindings/iio/adc/adc.yaml |    1 -
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |    4 +
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |    8 +-
 .../bindings/iio/adc/microchip,pac1934.yaml        |  120 ++
 .../devicetree/bindings/iio/adc/nxp,imx93-adc.yaml |    4 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |    1 -
 .../bindings/iio/adc/richtek,rtq6056.yaml          |    9 +-
 .../devicetree/bindings/iio/adc/ti,ads1298.yaml    |   80 +
 .../bindings/iio/afe/voltage-divider.yaml          |   11 +
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |   47 +-
 .../bindings/iio/frequency/adi,admfm2000.yaml      |  127 ++
 .../bindings/iio/gyroscope/bosch,bmg160.yaml       |    8 +-
 .../bindings/iio/humidity/ti,hdc2010.yaml          |    3 +
 .../bindings/iio/humidity/ti,hdc3020.yaml          |    3 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    4 +-
 .../devicetree/bindings/iio/light/ams,as73211.yaml |    7 +-
 .../bindings/iio/light/vishay,veml6075.yaml        |    1 +
 .../iio/magnetometer/voltafield,af8133j.yaml       |   60 +
 .../bindings/iio/pressure/honeywell,hsc030pa.yaml  |    3 +
 .../iio/pressure/honeywell,mprls0025pa.yaml        |   98 +-
 .../bindings/iio/temperature/ti,tmp117.yaml        |    8 +
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |    3 +
 .../bindings/interconnect/qcom,rpmh.yaml           |    2 +-
 .../bindings/interconnect/qcom,sm7150-rpmh.yaml    |   84 +
 .../bindings/nvmem/layouts/fixed-cell.yaml         |   22 +-
 .../devicetree/bindings/nvmem/nvmem-provider.yaml  |   18 +
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt           |   46 -
 .../bindings/nvmem/xlnx,zynqmp-nvmem.yaml          |   42 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/iio/adis16475.rst                    |  407 +++++
 Documentation/iio/iio_devbuf.rst                   |  152 ++
 Documentation/iio/index.rst                        |    9 +-
 MAINTAINERS                                        |   49 +-
 arch/x86/Kconfig                                   |    4 -
 drivers/accessibility/speakup/devsynth.c           |  148 +-
 drivers/accessibility/speakup/synth.c              |    4 +-
 drivers/android/binder_alloc.c                     |    2 -
 drivers/bus/mhi/common.h                           |   38 +-
 drivers/bus/mhi/ep/main.c                          |    7 +-
 drivers/bus/mhi/host/boot.c                        |   11 +-
 drivers/bus/mhi/host/init.c                        |   91 +-
 drivers/bus/mhi/host/internal.h                    |   56 +-
 drivers/bus/mhi/host/main.c                        |   19 +-
 drivers/bus/mhi/host/pci_generic.c                 |    2 +-
 drivers/bus/mhi/host/pm.c                          |   27 +-
 drivers/bus/mhi/host/trace.h                       |  282 ++++
 drivers/cdx/Makefile                               |    4 +
 drivers/cdx/cdx.c                                  |   20 +
 drivers/cdx/cdx.h                                  |   12 +
 drivers/cdx/cdx_msi.c                              |  192 +++
 drivers/cdx/controller/Kconfig                     |    1 +
 drivers/cdx/controller/cdx_controller.c            |   25 +
 drivers/cdx/controller/mc_cdx_pcol.h               |   64 +
 drivers/cdx/controller/mcdi_functions.c            |   33 +-
 drivers/cdx/controller/mcdi_functions.h            |   33 +
 drivers/char/hpet.c                                |    1 -
 drivers/char/xilinx_hwicap/xilinx_hwicap.c         |    6 +-
 drivers/char/xillybus/xillybus_of.c                |    6 +-
 drivers/comedi/drivers/das08.c                     |    1 -
 drivers/dio/dio-driver.c                           |    2 +-
 drivers/firmware/xilinx/zynqmp.c                   |   25 +
 drivers/fpga/dfl.c                                 |    2 +-
 drivers/fpga/fpga-bridge.c                         |    8 +-
 drivers/greybus/bundle.c                           |    2 +-
 drivers/greybus/control.c                          |    2 +-
 drivers/greybus/core.c                             |   32 +-
 drivers/greybus/es2.c                              |    8 +-
 drivers/greybus/hd.c                               |   18 +-
 drivers/greybus/interface.c                        |   11 +-
 drivers/greybus/module.c                           |    2 +-
 drivers/greybus/svc.c                              |    2 +-
 drivers/hwtracing/coresight/Makefile               |   20 +
 drivers/hwtracing/coresight/coresight-cfg-afdo.c   |    1 +
 drivers/hwtracing/coresight/coresight-core.c       |  496 +-----
 drivers/hwtracing/coresight/coresight-cti-core.c   |    2 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |   31 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    2 +-
 drivers/hwtracing/coresight/coresight-etm.h        |    2 -
 drivers/hwtracing/coresight/coresight-etm3x-core.c |   27 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |    4 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   38 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |    1 -
 drivers/hwtracing/coresight/coresight-funnel.c     |    4 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    9 +-
 drivers/hwtracing/coresight/coresight-replicator.c |    2 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   32 +-
 drivers/hwtracing/coresight/coresight-sysfs.c      |  391 +++++
 drivers/hwtracing/coresight/coresight-tmc-core.c   |    4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   46 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   33 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    2 -
 drivers/hwtracing/coresight/coresight-tpda.c       |  151 +-
 drivers/hwtracing/coresight/coresight-tpda.h       |    6 +
 drivers/hwtracing/coresight/coresight-tpdm.c       |  459 ++++-
 drivers/hwtracing/coresight/coresight-tpdm.h       |  114 ++
 drivers/hwtracing/coresight/coresight-tpiu.c       |   16 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c         |   24 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h         |    2 -
 drivers/hwtracing/ptt/hisi_ptt.c                   |    6 +-
 drivers/iio/Kconfig                                |    9 +
 drivers/iio/Makefile                               |    1 +
 drivers/iio/accel/Kconfig                          |    8 +-
 drivers/iio/accel/Makefile                         |    1 +
 drivers/iio/accel/adxl367.c                        |  297 ++--
 drivers/iio/accel/adxl372_spi.c                    |    2 +-
 drivers/iio/accel/bma180.c                         |    2 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |   15 +-
 drivers/iio/accel/bmc150-accel-spi.c               |    3 +-
 drivers/iio/accel/bmi088-accel-i2c.c               |   70 +
 drivers/iio/accel/da280.c                          |   66 +-
 drivers/iio/accel/kxcjk-1013.c                     |  120 +-
 drivers/iio/accel/kxsd9-spi.c                      |    2 +-
 drivers/iio/accel/mma9551.c                        |    4 +-
 drivers/iio/accel/mma9553.c                        |    4 +-
 drivers/iio/accel/mxc4005.c                        |    5 +-
 drivers/iio/accel/mxc6255.c                        |    4 +-
 drivers/iio/accel/st_accel_i2c.c                   |    5 +-
 drivers/iio/accel/stk8ba50.c                       |    4 +-
 drivers/iio/adc/Kconfig                            |   26 +-
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/ad4130.c                           |  131 +-
 drivers/iio/adc/ad7091r-base.c                     |   25 +-
 drivers/iio/adc/ad9467.c                           |  267 ++-
 drivers/iio/adc/ad_sigma_delta.c                   |    7 +-
 drivers/iio/adc/adi-axi-adc.c                      |  407 ++---
 drivers/iio/adc/max1363.c                          |  161 +-
 drivers/iio/adc/mcp320x.c                          |   31 +-
 drivers/iio/adc/pac1934.c                          | 1636 ++++++++++++++++++
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |    1 -
 drivers/iio/adc/rockchip_saradc.c                  |   17 +-
 drivers/iio/adc/rtq6056.c                          |  275 ++-
 drivers/iio/adc/ti-adc108s102.c                    |    4 +-
 drivers/iio/adc/ti-ads1015.c                       |    2 +-
 drivers/iio/adc/ti-ads1298.c                       |  771 +++++++++
 drivers/iio/adc/ti-ads8688.c                       |    2 +-
 drivers/iio/amplifiers/hmc425a.c                   |  274 ++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   11 +-
 .../iio/common/inv_sensors/inv_sensors_timestamp.c |    2 +-
 drivers/iio/dac/mcp4821.c                          |    2 +-
 drivers/iio/dummy/iio_dummy_evgen.c                |    2 -
 drivers/iio/dummy/iio_simple_dummy.c               |  193 ++-
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/admfm2000.c                  |  282 ++++
 drivers/iio/gyro/bmg160_i2c.c                      |    4 +-
 drivers/iio/health/afe4403.c                       |   65 +-
 drivers/iio/health/afe4404.c                       |   65 +-
 drivers/iio/humidity/hdc3020.c                     |  451 +++--
 drivers/iio/humidity/hts221_i2c.c                  |    4 +-
 drivers/iio/imu/adis16475.c                        |    8 +-
 drivers/iio/imu/adis16480.c                        |    9 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    9 +
 drivers/iio/imu/bmi323/bmi323_core.c               |   78 +-
 drivers/iio/imu/bmi323/bmi323_i2c.c                |   21 +
 drivers/iio/imu/fxos8700_i2c.c                     |    3 +-
 drivers/iio/imu/fxos8700_spi.c                     |    3 +-
 drivers/iio/imu/kmx61.c                            |    2 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |   31 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   28 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   33 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    5 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h            |    5 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |   21 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |    6 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |    4 +-
 drivers/iio/industrialio-backend.c                 |  418 +++++
 drivers/iio/industrialio-core.c                    |    6 +-
 drivers/iio/industrialio-gts-helper.c              |   15 +-
 drivers/iio/light/Kconfig                          |    5 +-
 drivers/iio/light/al3010.c                         |    2 +-
 drivers/iio/light/al3320a.c                        |    1 -
 drivers/iio/light/as73211.c                        |  142 +-
 drivers/iio/light/hid-sensor-als.c                 |  122 +-
 drivers/iio/light/jsa1212.c                        |    4 +-
 drivers/iio/light/ltr501.c                         |    3 +-
 drivers/iio/light/max44000.c                       |    6 +-
 drivers/iio/light/rpr0521.c                        |    4 +-
 drivers/iio/light/stk3310.c                        |    4 +-
 drivers/iio/light/us5182d.c                        |    4 +-
 drivers/iio/light/vcnl4000.c                       |   36 +-
 drivers/iio/light/vl6180.c                         |    1 -
 drivers/iio/magnetometer/Kconfig                   |   12 +
 drivers/iio/magnetometer/Makefile                  |    1 +
 drivers/iio/magnetometer/af8133j.c                 |  528 ++++++
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    3 +-
 drivers/iio/magnetometer/bmc150_magn_spi.c         |    3 +-
 drivers/iio/magnetometer/mmc35240.c                |    4 +-
 drivers/iio/potentiometer/max5487.c                |    4 +-
 drivers/iio/pressure/Kconfig                       |   16 +-
 drivers/iio/pressure/Makefile                      |    2 +
 drivers/iio/pressure/hp206c.c                      |    6 +-
 drivers/iio/pressure/hsc030pa.c                    |   49 +-
 drivers/iio/pressure/hsc030pa.h                    |    7 +
 drivers/iio/pressure/hsc030pa_i2c.c                |    9 +-
 drivers/iio/pressure/hsc030pa_spi.c                |    7 +-
 drivers/iio/pressure/mprls0025pa.c                 |  313 ++--
 drivers/iio/pressure/mprls0025pa.h                 |  102 ++
 drivers/iio/pressure/mprls0025pa_i2c.c             |  100 ++
 drivers/iio/pressure/mprls0025pa_spi.c             |   92 +
 drivers/iio/pressure/st_pressure_i2c.c             |    5 +-
 drivers/iio/proximity/isl29501.c                   |    3 +-
 drivers/iio/proximity/sx9310.c                     |  114 +-
 drivers/iio/proximity/sx9324.c                     |  178 +-
 drivers/iio/proximity/sx9360.c                     |  115 +-
 drivers/iio/temperature/ltc2983.c                  |   28 +-
 drivers/iio/temperature/tmp117.c                   |    9 +
 drivers/iio/test/Kconfig                           |   14 +
 drivers/iio/test/Makefile                          |    1 +
 drivers/iio/test/iio-test-gts.c                    |  513 ++++++
 drivers/interconnect/core.c                        |    4 +-
 drivers/interconnect/qcom/Kconfig                  |   18 +
 drivers/interconnect/qcom/Makefile                 |    4 +
 drivers/interconnect/qcom/icc-common.c             |    3 +-
 drivers/interconnect/qcom/icc-common.h             |    3 +-
 drivers/interconnect/qcom/msm8909.c                | 1329 +++++++++++++++
 drivers/interconnect/qcom/sa8775p.c                |   56 +-
 drivers/interconnect/qcom/sm6115.c                 |   12 +-
 drivers/interconnect/qcom/sm7150.c                 | 1754 ++++++++++++++++++++
 drivers/interconnect/qcom/sm7150.h                 |  140 ++
 drivers/interconnect/qcom/sm8250.c                 |    2 +-
 drivers/interconnect/qcom/sm8550.c                 |  574 -------
 drivers/interconnect/qcom/sm8550.h                 |  284 ++--
 drivers/interconnect/qcom/x1e80100.c               |  327 +---
 drivers/interconnect/samsung/exynos.c              |    2 +-
 drivers/ipack/ipack.c                              |    2 +-
 drivers/mcb/mcb-core.c                             |    4 +-
 drivers/memory/tegra/mc.c                          |    2 +-
 drivers/memory/tegra/tegra124-emc.c                |    2 +-
 drivers/memory/tegra/tegra124.c                    |    2 +-
 drivers/memory/tegra/tegra186-emc.c                |    2 +-
 drivers/memory/tegra/tegra20-emc.c                 |    2 +-
 drivers/memory/tegra/tegra20.c                     |    2 +-
 drivers/memory/tegra/tegra30-emc.c                 |    2 +-
 drivers/memory/tegra/tegra30.c                     |    2 +-
 drivers/misc/atmel-ssc.c                           |    6 +-
 drivers/misc/cxl/of.c                              |    5 +-
 drivers/misc/eeprom/eeprom_93xx46.c                |    1 -
 drivers/misc/eeprom/idt_89hpesx.c                  |    6 +-
 drivers/misc/fastrpc.c                             |    6 +-
 drivers/misc/hi6421v600-irq.c                      |    1 -
 drivers/misc/hisi_hikey_usb.c                      |    7 +-
 drivers/misc/hpilo.c                               |    8 +-
 drivers/misc/mei/gsc-me.c                          |   22 +-
 drivers/misc/mei/hdcp/Kconfig                      |    2 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   |   14 +-
 drivers/misc/mei/pci-me.c                          |   38 +-
 drivers/misc/mei/pci-txe.c                         |   40 +-
 drivers/misc/mei/platform-vsc.c                    |    6 +-
 drivers/misc/mei/pxp/Kconfig                       |    2 +-
 drivers/misc/mei/pxp/mei_pxp.c                     |   14 +-
 drivers/misc/mei/vsc-tp.c                          |   33 +-
 drivers/misc/open-dice.c                           |    5 +-
 drivers/misc/sram.c                                |    6 +-
 drivers/misc/ti-st/st_kim.c                        |    5 +-
 drivers/misc/tifm_core.c                           |    2 +-
 drivers/misc/vcpu_stall_detector.c                 |    6 +-
 drivers/misc/xilinx_sdfec.c                        |    5 +-
 drivers/misc/xilinx_tmr_inject.c                   |    5 +-
 drivers/most/core.c                                |    2 +-
 drivers/net/ethernet/broadcom/bnx2.c               |    1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    2 +
 drivers/net/ethernet/broadcom/cnic.c               |   25 +-
 drivers/net/ethernet/broadcom/cnic.h               |    1 +
 drivers/net/ethernet/broadcom/cnic_if.h            |    1 +
 drivers/nvmem/core.c                               |    5 +
 drivers/nvmem/layouts.c                            |    2 +-
 drivers/nvmem/meson-efuse.c                        |   25 +-
 drivers/nvmem/mtk-efuse.c                          |   20 +-
 drivers/nvmem/zynqmp_nvmem.c                       |  213 ++-
 drivers/of/property.c                              |    2 +
 drivers/parport/parport_amiga.c                    |    5 +-
 drivers/parport/parport_sunbpp.c                   |    6 +-
 drivers/platform/goldfish/Kconfig                  |    1 +
 drivers/pps/generators/Makefile                    |    4 +-
 drivers/siox/siox-core.c                           |    6 +-
 drivers/slimbus/core.c                             |    6 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |    8 +-
 drivers/uio/uio.c                                  |   47 +
 drivers/uio/uio_dmem_genirq.c                      |   22 +-
 drivers/uio/uio_pruss.c                            |    6 +-
 include/dt-bindings/interconnect/qcom,msm8909.h    |   93 ++
 .../dt-bindings/interconnect/qcom,sm7150-rpmh.h    |  150 ++
 .../dt-bindings/interconnect/qcom,x1e80100-rpmh.h  |   24 -
 include/linux/cdx/cdx_bus.h                        |   53 +-
 include/linux/coresight.h                          |  148 +-
 include/linux/dio.h                                |    2 +-
 include/linux/firmware/xlnx-zynqmp.h               |    8 +
 include/linux/greybus.h                            |   44 +-
 include/linux/hid-sensor-ids.h                     |    4 +
 include/linux/iio/adc/adi-axi-adc.h                |   68 -
 include/linux/iio/backend.h                        |   72 +
 include/linux/iio/buffer-dmaengine.h               |    3 +
 include/linux/iio/iio.h                            |   30 +-
 include/linux/interconnect-provider.h              |   11 +-
 include/linux/mhi.h                                |   19 -
 include/linux/slimbus.h                            |    2 +-
 include/linux/uio_driver.h                         |   13 +
 include/soc/tegra/mc.h                             |    7 +-
 tools/iio/iio_utils.c                              |    2 +-
 305 files changed, 15180 insertions(+), 4508 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/voltafield,af8133j.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-provider.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
 create mode 100644 Documentation/iio/adis16475.rst
 create mode 100644 Documentation/iio/iio_devbuf.rst
 create mode 100644 drivers/bus/mhi/host/trace.h
 create mode 100644 drivers/cdx/cdx_msi.c
 create mode 100644 drivers/iio/accel/bmi088-accel-i2c.c
 create mode 100644 drivers/iio/adc/pac1934.c
 create mode 100644 drivers/iio/adc/ti-ads1298.c
 create mode 100644 drivers/iio/frequency/admfm2000.c
 create mode 100644 drivers/iio/industrialio-backend.c
 create mode 100644 drivers/iio/magnetometer/af8133j.c
 create mode 100644 drivers/iio/pressure/mprls0025pa.h
 create mode 100644 drivers/iio/pressure/mprls0025pa_i2c.c
 create mode 100644 drivers/iio/pressure/mprls0025pa_spi.c
 create mode 100644 drivers/iio/test/iio-test-gts.c
 create mode 100644 drivers/interconnect/qcom/msm8909.c
 create mode 100644 drivers/interconnect/qcom/sm7150.c
 create mode 100644 drivers/interconnect/qcom/sm7150.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8909.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
 delete mode 100644 include/linux/iio/adc/adi-axi-adc.h
 create mode 100644 include/linux/iio/backend.h

