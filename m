Return-Path: <linux-kernel+bounces-28894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A155B83044D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE8B6B24837
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A31DFF2;
	Wed, 17 Jan 2024 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="imh5gviq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B81DFC8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489932; cv=none; b=ufQRKZpG78vPxdnHdtWCrUy5yD4IA5J9gB9Mv/CTD76qYt0p0WVZjfx0hDC5s/5MlsoAMdjP/cf0rX5ZL/57udjexFRrNBbnHfa/AW6dpUO8aYjlsnTVGKpRm9IHjwM3QUv65Zyl+MbOgWueQy4njeQ4oq4kTjAzJyMkHS8KsXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489932; c=relaxed/simple;
	bh=351R6mu+X85KJJ9fObGvq0uTJ/I6xZ34MQ1W7i+BFdU=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding; b=XgdMF5cS4gPCo/CDEm6s5uAfhFRYJMe2vxSmV1Yn0QVQk0Wd1+PwIm5ubzi9fg4dY1h/PPQ3QId3DnGBGVW9KrvXQtMbo6cz5tFk3nlGcAuitHWqq7Y44PtYQfZV+QlLKeCC/CgD4pgTBxseFziXXO5j7tE8w5Y6KJbD+GHQrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=imh5gviq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DEFC433F1;
	Wed, 17 Jan 2024 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705489931;
	bh=351R6mu+X85KJJ9fObGvq0uTJ/I6xZ34MQ1W7i+BFdU=;
	h=Date:From:To:Cc:Subject:From;
	b=imh5gviqeG0m4JHs/JP/esufh6VJh57R6kkVicwFa5J0JbWLN64ij4D80S+PCiR/W
	 3QFD0e9ys0LNyMciSuT8sR7lCaP8TjUGYW99dWX5q9FfAiGEWdmhv+4LtgKbGdITCu
	 NAUZOhGEjUzsZz8RB6WUTuD4uVwgID27YXENegk4=
Date: Wed, 17 Jan 2024 12:12:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver changes for 6.8-rc1
Message-ID: <Zae2CXdDjX89bxKN@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc1

for you to fetch changes up to 5850edccec30325707f953bc088497b3b9041231:

  android: removed duplicate linux/errno (2024-01-07 09:48:26 +0100)

----------------------------------------------------------------
Char/Misc and other Driver changes for 6.8-rc1

Here is the big set of char/misc and other driver subsystem changes for
6.8-rc1.  Lots of stuff in here, but first off, you will get a merge
conflict in drivers/android/binder_alloc.c when merging this tree due to
changing coming in through the -mm tree.

The resolution of the merge issue can be found here:
	https://lore.kernel.org/r/20231207134213.25631ae9@canb.auug.org.au
or in a simpler patch form in that thread:
	https://lore.kernel.org/r/ZXHzooF07LfQQYiE@google.com

If there are issues with the merge of this file, please let me know.

Other than lots of binder driver changes (as you can see by the merge
conflicts) included in here are:
 - lots of iio driver updates and additions
 - spmi driver updates
 - eeprom driver updates
 - firmware driver updates
 - ocxl driver updates
 - mhi driver updates
 - w1 driver updates
 - nvmem driver updates
 - coresight driver updates
 - platform driver remove callback api changes
 - tags.sh script updates
 - bus_type constant marking cleanups
 - lots of other small driver updates

All of these have been in linux-next for a while with no reported issues
(other than the binder merge conflict.)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhijit Gangurde (2):
      cdx: create sysfs bin files for cdx resources
      cdx: Create resource debugfs file for cdx device

Alexander Graf (1):
      misc: Add Nitro Secure Module driver

Alexander Usyskin (1):
      mei: pxp: spdx should be at first line

Alexandru Ardelean (1):
      iio: buffer-dma: split iio_dma_buffer_fileio_free() function

Alice Ryhl (1):
      binder: use enum for binder ioctls

Amit Dhingra (1):
      MAINTAINERS: correct file entry IIO LIGHT SENSOR GAIN-TIME_SCALE HELPERS

Ana-Maria Cusco (2):
      dt-bindings: iio: hmc425a: add entry for ADRF5740 Attenuator
      iio: amplifiers: hmc425a: add support for ADRF5740 Attenuator

Andrew Davis (1):
      mux: mmio: use reg property when parent device is not a syscon

Andrew Hepp (2):
      dt-bindings: iio: Add MCP9600 thermocouple EMF converter
      iio: temperature: Add MCP9600 thermocouple EMF converter

Andy Shevchenko (8):
      device property: Use fwnode_property_string_array_count()
      device property: Add fwnode_property_match_property_string()
      iio: frequency: adf4377: Switch to device_property_match_property_string()
      iio: frequency: admv1014: Switch to device_property_match_property_string()
      iio: magnetometer: tmag5273: Switch to device_property_match_property_string()
      iio: proximity: sx9324: Switch to device_property_match_property_string()
      pvpanic: Don't use "proxy" headers
      pvpanic: Kill duplicate PCI_VENDOR_ID_REDHAT definition

Angel Iglesias (4):
      iio: pressure: bmp280: Use spi_get_device_match_data()
      iio: pressure: bmp280: Rearrange vars in reverse xmas tree order
      iio: pressure: bmp280: Allow multiple chips id per family of devices
      iio: pressure: bmp280: Add support for BMP390

Anshul Dalal (7):
      dt-bindings: iio: light: add ltr390
      iio: light: driver for Lite-On ltr390
      dt-bindings: vendor-prefixes: add aosong
      dt-bindings: iio: chemical: add aosong,ags02ma
      iio: chemical: add support for Aosong AGS02MA
      dt-bindings: iio: dac: add MCP4821
      iio: dac: driver for MCP4821

Anshuman Khandual (6):
      coresight: trbe: Add a representative coresight_platform_data for TRBE
      coresight: trbe: Enable ACPI based TRBE devices
      coresight: etm: Override TRCIDR3.CCITMIN on errata affected cpus
      coresight: etm: Make cycle count threshold user configurable
      Documentation: coresight: Add cc_threshold tunable
      coresight: tmc: Make etr buffer mode user configurable from sysfs

Arnd Bergmann (2):
      mei: fix vsc dependency
      mei: rework Kconfig dependencies

Ayush Singh (1):
      greybus: gb-beagleplay: Remove use of pad bytes

Babis Chalios (1):
      vmgenid: emit uevent when VMGENID updates

Bagas Sanjaya (1):
      Documentation: ABI: coresight-tpdm: Fix Bit[3] description indentation

Bhaumik Bhatt (1):
      bus: mhi: host: Add spinlock to protect WP access when queueing TREs

Biju Das (1):
      iio: pressure: bmp280: Use i2c_get_match_data()

Bragatheswaran Manickavel (1):
      iio/imu: inv_icm42600: Use max() helper macros

Cameron Williams (2):
      parport: parport_serial: Add Brainboxes BAR details
      parport: parport_serial: Add Brainboxes device IDs and geometry

Carlos Llamas (28):
      binder: use EPOLLERR from eventpoll.h
      binder: fix use-after-free in shinker's callback
      binder: fix race between mmput() and do_exit()
      binder: fix async space check for 0-sized buffers
      binder: fix unused alloc->free_async_space
      binder: fix trivial typo of binder_free_buf_locked()
      binder: fix comment on binder_alloc_new_buf() return value
      binder: remove extern from function prototypes
      binder: keep vma addresses type as unsigned long
      binder: split up binder_update_page_range()
      binder: do unlocked work in binder_alloc_new_buf()
      binder: remove pid param in binder_alloc_new_buf()
      binder: separate the no-space debugging logic
      binder: relocate low space calculation
      binder: relocate binder_alloc_clear_buf()
      binder: refactor page range allocation
      binder: malloc new_buffer outside of locks
      binder: initialize lru pages in mmap callback
      binder: perform page installation outside of locks
      binder: remove redundant debug log
      binder: make oversized buffer code more readable
      binder: rename lru shrinker utilities
      binder: document the final page calculation
      binder: collapse print_binder_buffer() into caller
      binder: refactor binder_delete_free_buffer()
      binder: avoid user addresses in debug logs
      binder: reverse locking order in shrinker callback
      binder: switch alloc->mutex to spinlock_t

Christophe JAILLET (6):
      ipack: Remove usage of the deprecated ida_simple_xx() API
      parport: Save a few bytes of memory
      VMCI: Remove handle_arr_calc_size()
      VMCI: Remove VMCI_HANDLE_ARRAY_HEADER_SIZE and VMCI_HANDLE_ARRAY_MAX_CAPACITY
      iio: buffer: Use IIO_SEPARATE instead of a hard-coded 0
      ppdev: Remove usage of the deprecated ida_simple_xx() API

Colin Ian King (2):
      iio: imu: Fix spelling mistake "accelrometer" -> "accelerometer"
      tools/counter: Fix spelling mistake "componend" -> "component"

Crt Mori (2):
      iio: temperature: mlx90635 MLX90635 IR Temperature sensor
      dt-bindings: iio: temperature: add MLX90635 device

Dan Carpenter (2):
      cdx: call of_node_put() on error path
      cdx: Unlock on error path in rescan_store()

Dan Williams (1):
      tools/testing/nvdimm: Add compile-test coverage for ndtest

David Lechner (2):
      iio: resolver: ad2s1210: add support for adi,fixed-mode
      iio: resolver: ad2s1210: add reset gpio support

Fabrice Gasnier (2):
      tools/counter: add a flexible watch events tool
      MAINTAINERS: add myself as counter watch events tool maintainer

Fei Shao (5):
      spmi: Introduce device-managed functions
      spmi: Use devm_spmi_controller_alloc()
      spmi: mtk-pmif: Reorder driver remove sequence
      spmi: hisi-spmi-controller: Use devm_spmi_controller_add()
      spmi: Return meaningful errors in spmi_controller_alloc()

Georgi Djakov (5):
      Merge branch 'icc-sm8650' into icc-next
      Merge branch 'icc-platform-remove' into icc-next
      Merge branch 'icc-x1e80100' into icc-next
      Merge branch 'icc-sm6115' into icc-next
      Merge branch 'icc-qcm2290' into icc-next

Greg Kroah-Hartman (17):
      Merge 6.7-rc5 into char-misc-next
      Merge tag 'coresight-next-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'fpga-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'mhi-for-v6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-next
      Merge tag 'extcon-next-for-6.8' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge tag 'iio-for-6.8a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'w1-drv-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into char-misc-next
      Merge tag 'icc-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Merge tag 'fpga-for-6.8-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'counter-updates-for-6.8a' of git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-next
      Merge tag 'iio-for-6.8b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      maple: make maple_bus_type static and const
      dma-debug: make dma_debug_add_bus take a const pointer
      locomo: make locomo_bus_type constant and static
      moxtet: remove unused moxtet_type declaration
      moxtet: mark moxtet_bus_type as const
      platform/surface: aggregator: make ssam_bus_type constant and static

Guanghui Feng (1):
      uio: Fix use-after-free in uio_open

Hans de Goede (1):
      misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback

Heiner Kallweit (4):
      eeprom: ee1004: Add support for multiple i2c busses
      eeprom: ee1004: add support for temperature sensor
      eeprom: at24: Probe for DDR3 thermal sensor in the SPD case
      eeprom: at24: Use pm_runtime_resume_and_get to simplify the code

Ivan Mikhaylov (2):
      dt-bindings: adc: provide max34408/9 device tree binding document
      iio: adc: Add driver support for MAX34408/9

Jagath Jog J (3):
      dt-bindings: iio: imu: Add Bosch BMI323
      iio: imu: Add driver for BMI323 IMU
      iio: imu: bmi323: Make the local structures static

James Clark (1):
      coresight: etm4x: Fix width of CCITMIN field

Javier Carrasco (5):
      iio: add modifiers for A and B ultraviolet light
      dt-bindings: iio: light: add support for Vishay VEML6075
      iio: light: add VEML6075 UVA and UVB light sensor driver
      iio: core: introduce trough info element for minimum values
      iio: ABI: document temperature and humidity peak/trough raw attributes

Jay Buddhabhatti (7):
      firmware: xilinx: Update firmware call interface to support additional args
      firmware: xilinx: Expand feature check to support all PLM modules
      firmware: xilinx: Register event manager driver
      drivers: soc: xilinx: Fix error message on SGI registration failure
      firmware: zynqmp: Add support to handle IPI CRC failure
      firmware: xilinx: Export function to use in other module
      drivers: soc: xilinx: add check for platform

Jiapeng Chong (1):
      iio: light: isl76682: remove unreachable code

Johan Hovold (6):
      dt-bindings: iio/adc: qcom,spmi-iadc: fix reg description
      dt-bindings: iio/adc: qcom,spmi-iadc: fix example node name
      dt-bindings: iio/adc: qcom,spmi-iadc: clean up example
      dt-bindings: iio/adc: qcom,spmi-rradc: clean up example
      dt-bindings: iio/adc: qcom,spmi-vadc: fix example node names
      dt-bindings: iio/adc: qcom,spmi-vadc: clean up examples

Jonathan Cameron (1):
      iio: light: pa1203001: Drop ACPI_PTR() protection.

Jun Yan (1):
      iio: accel: bmi088: update comments and Kconfig

Junhao He (1):
      coresight: ultrasoc-smb: Use guards to cleanup

Konrad Dybcio (5):
      dt-bindings: interconnect: Add Qualcomm SM6115 NoC
      interconnect: qcom: Add SM6115 interconnect provider driver
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM6115 bwmon instance
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add QCM2290 bwmon instance
      interconnect: qcom: sm6115: Fix up includes

Kris Chaplin (2):
      dt-bindings: w1: Add AMD AXI w1 host and MAINTAINERS entry
      w1: Add AXI 1-wire host driver for AMD programmable logic IP core

Krishna chaitanya chundru (1):
      bus: mhi: host: Add alignment check for event ring read pointer

Krzysztof Kozlowski (1):
      dt-bindings: iio: honeywell,mprls0025pa: drop ref from pressure properties

Leo Yan (1):
      MAINTAINERS: Remove myself as a Arm CoreSight reviewer

Li kunyu (1):
      misc: ocxl: main: Remove unnecessary ‘0’ values from rc

Li peiyu (3):
      iio: pressure: fix some word spelling errors
      iio: humidity: Add driver for ti HDC302x humidity sensors
      dt-bindings: iio: humidity: Add TI HDC302x support

Li zeming (3):
      misc: ocxl: context: Remove unnecessary (void*) conversions
      misc: ocxl: afu_irq: Remove unnecessary (void*) conversions
      misc: ocxl: link: Remove unnecessary (void*) conversions

Linus Walleij (1):
      iio: proximity: irsd200: Drop unused include

Lukas Bulwahn (4):
      MAINTAINERS: correct file entry in BOSCH SENSORTEC BMI323 IMU IIO DRIVER
      MAINTAINERS: improve section MICROCHIP MCP3564 ADC DRIVER
      vgacon: drop IA64 reference in VGA_CONSOLE dependency list
      misc: nsm: remove selecting the non-existing config CBOR

Lukas Funke (1):
      extcon: usbc-tusb320: Set interrupt polarity based on device-tree

Manivannan Sadhasivam (13):
      bus: mhi: ep: Do not allocate event ring element on stack
      bus: mhi: ep: Use slab allocator where applicable
      bus: mhi: ep: Add support for interrupt moderation timer
      bus: mhi: ep: Pass mhi_ep_buf_info struct to read/write APIs
      bus: mhi: ep: Rename read_from_host() and write_to_host() APIs
      bus: mhi: ep: Introduce async read/write callbacks
      PCI: epf-mhi: Simulate async read/write using iATU
      PCI: epf-mhi: Add support for DMA async read/write operation
      PCI: epf-mhi: Enable MHI async read/write support
      bus: mhi: ep: Add support for async DMA write operation
      bus: mhi: ep: Add support for async DMA read operation
      bus: mhi: ep: Add checks for read/write callbacks while registering controllers
      PCI: epf-mhi: Fix the DMA data direction of dma_unmap_single()

Marc Ferland (5):
      w1: ds2490: support block sizes larger than 128 bytes in ds_read_block
      w1: ds2433: remove unused definitions
      w1: ds2433: introduce a configuration structure
      w1: ds2433: use the kernel bitmap implementation
      w1: ds2433: add support for ds28ec20 eeprom

Marcelo Schmitt (15):
      scripts: checkpatch: Add __aligned to the list of attribute notes
      iio: adc: ad7091r: Pass iio_dev to event handler
      iio: adc: ad7091r: Set alert bit in config register
      iio: adc: ad7091r: Align arguments to function call parenthesis
      iio: adc: ad7091r: Allow users to configure device events
      iio: adc: ad7091r: Enable internal vref if external vref is not supplied
      iio: adc: ad7091r: Move generic AD7091R code to base driver and header file
      iio: adc: ad7091r: Move chip init data to container struct
      iio: adc: ad7091r: Remove unneeded probe parameters
      iio: adc: ad7091r: Set device mode through chip_info callback
      iio: adc: ad7091r: Add chip_info callback to get conversion result channel
      iio: adc: Split AD7091R-5 config symbol
      dt-bindings: iio: Add AD7091R-8
      iio: adc: Add support for AD7091R-8
      MAINTAINERS: Add MAINTAINERS entry for AD7091R

Marcus Folkesson (1):
      iio: adc: mcp3911: simplify code with guard macro

Marek Vasut (3):
      dt-bindings: iio: light: isl76682: Document ISL76682
      iio: light: isl76682: Add ISL76682 driver
      doc: iio: Document intensity scale as poorly defined

Matt Ranostay (1):
      mailmap: Change email mapping from previous employers

Matti Vaittinen (3):
      iio: bu27008: Add illuminance channel
      iio: sanity check available_scan_masks array
      iio: buffer: document known issue

Michael Hennerich (2):
      dt-bindings: adi,ad5791: Add support for controlling RBUF
      iio: dac: ad5791: Add support for controlling RBUF via devicetree

Michal Simek (3):
      firmware: xilinx: Use proper indentation in kernel-doc
      firmware: xilinx: Remove clock_setrate and clock_getrate api
      firmware: xilinx: Remove zynqmp_pm_pinctrl_get_function()

Miquel Raynal (8):
      of: device: Export of_device_make_bus_id()
      nvmem: Move of_nvmem_layout_get_container() in another header
      nvmem: Create a header for internal sharing
      nvmem: Simplify the ->add_cells() hook
      nvmem: Move and rename ->fixup_cell_info()
      nvmem: core: Rework layouts to become regular devices
      ABI: sysfs-nvmem-cells: Expose cells through sysfs
      nvmem: core: Expose cells through sysfs

Neil Armstrong (3):
      dt-bindings: interconnect: document the RPMh Network-On-Chip Interconnect in Qualcomm SM8650 SoC
      interconnect: qcom: introduce RPMh Network-On-Chip Interconnect on SM8650 SoC
      dt-bindings: interconnect: qcom-bwmon: document SM8650 BWMONs

Nuno Sa (8):
      iio: adc: ad9467: fix reset gpio handling
      iio: adc: ad9467: don't ignore error codes
      iio: adc: ad9467: add mutex to struct ad9467_state
      iio: adc: ad9467: fix scale setting
      iio: adc: ad9467: use spi_get_device_match_data()
      iio: adc: ad9467: use chip_info variables instead of array
      iio: adc: ad9467: use the more common !val NULL check
      iio: adc: adi-axi-adc: convert to regmap

Nícolas F. R. A. Prado (1):
      spmi: mtk-pmif: Serialize PMIF status check and command submission

Patrick Delaunay (2):
      dt-bindings: nvmem: add new stm32mp25 compatible for stm32-romem
      nvmem: stm32: add support for STM32MP25 BSEC to control OTP data

Paul Cercueil (1):
      iio: buffer-dma: Get rid of outgoing queue

Petre Rodan (2):
      dt-bindings: iio: pressure: add honeywell,hsc030
      iio: pressure: driver for Honeywell HSC/SSC series

Philipp Stanner (2):
      drivers/fpga: use standard array-copy function
      drivers/comedi: use standard array-copy-function

Qiang Yu (3):
      bus: mhi: host: Add a separate timeout parameter for waiting ready
      bus: mhi: host: pci_generic: Add SDX75 based modem support
      bus: mhi: host: Drop chan lock before queuing buffers

Rafał Miłecki (6):
      nvmem: layouts: refactor .add_cells() callback arguments
      nvmem: drop nvmem_layout_get_match_data()
      nvmem: core: add nvmem_dev_size() helper
      nvmem: u-boot-env: use nvmem_add_one_cell() nvmem subsystem helper
      nvmem: u-boot-env: use nvmem device helpers
      nvmem: u-boot-env: improve coding style

Rajendra Nayak (2):
      dt-bindings: interconnect: Add Qualcomm X1E80100 SoC
      interconnect: qcom: Add X1E80100 interconnect provider driver

Ramona Gradinariu (3):
      iio: imu: adis: Use spi cs inactive delay
      dt-bindings: adis16475: Add 'spi-cs-inactive-delay-ns' property
      dt-bindings: adis16460: Add 'spi-cs-inactive-delay-ns' property

Randy Dunlap (8):
      android: binder: fix a kernel-doc enum warning
      extcon: qcom-spmi-misc: don't use kernel-doc marker for comment
      mei: fix spellos in mei.h
      mcb: core: fix kernel-doc warnings
      virt: vbox: core: fix all kernel-doc warnings
      virt: vbox: linux: fix all kernel-doc warnings
      virt: vbox: utils: fix all kernel-doc warnings
      iio: linux/iio.h: fix Excess kernel-doc description warning

René Nyffenegger (1):
      scripts/tags.sh: Update comment (addition of gtags)

Ricky Wu (3):
      misc: rtsx: add to support new card reader rts5264 new definition and function
      misc: rtsx: add to support new card reader rts5264
      mmc: rtsx: add rts5264 to support sd express card

Rob Herring (3):
      dt-bindings: iio/adc: ti,palmas-gpadc: Drop incomplete example
      w1: amd_axi_w1: Explicitly include correct DT includes
      cdx: Explicitly include correct DT includes, again

Sakari Ailus (1):
      mei: vsc: Rework firmware image names

Sen Chu (1):
      spmi: mediatek: add device id check

Shreeya Patel (1):
      iio: light: ltrf216a: Return floating point values

Stefan Berger (1):
      rootfs: Fix support for rootfstype= when root= is given

Su Hui (1):
      iio: imu: inv_mpu6050: return callee's error code rather than -EINVAL

Tanzir Hasan (2):
      android: binder: binderfs.c: removed asm-generic/errno-base.h
      android: removed duplicate linux/errno

Tao Zhang (14):
      coresight-tpdm: Remove the unnecessary lock
      dt-bindings: arm: Add support for DSB element size
      coresight-tpdm: Introduce TPDM subtype to TPDM driver
      coresight-tpda: Add DSB dataset support
      coresight-tpdm: Initialize DSB subunit configuration
      coresight-tpdm: Add reset node to TPDM node
      coresight-tpdm: Add nodes to set trigger timestamp and type
      coresight-tpdm: Add node to set dsb programming mode
      coresight-tpdm: Add nodes for dsb edge control
      coresight-tpdm: Add nodes to configure pattern match output
      coresight-tpdm: Add nodes for timestamp request
      dt-bindings: arm: Add support for DSB MSR register
      coresight-tpdm: Add nodes for dsb msr support
      coresight-tpdm: Correct the property name of MSR number

Uwe Kleine-König (50):
      coresight: dummy: Convert to platform remove callback returning void
      coresight: etm4x: Convert to platform remove callback returning void
      coresight: funnel: Convert to platform remove callback returning void
      coresight: replicator: Convert to platform remove callback returning void
      coresight: trbe: Convert to platform remove callback returning void
      coresight: ultrasoc-smb: Convert to platform remove callback returning void
      interconnect: qcom: Make qnoc_remove return void
      interconnect: imx8mm: Convert to platform remove callback returning void
      interconnect: imx8mn: Convert to platform remove callback returning void
      interconnect: imx8mp: Convert to platform remove callback returning void
      interconnect: imx8mq: Convert to platform remove callback returning void
      interconnect: qcom/msm8974: Convert to platform remove callback returning void
      interconnect: qcom/osm-l3: Convert to platform remove callback returning void
      interconnect: qcom/smd-rpm: Convert to platform remove callback returning void
      interconnect: exynos: Convert to platform remove callback returning void
      platform/goldfish: goldfish_pipe: Convert to platform remove callback returning void
      w1: gpio: Don't use platform data for driver data
      w1: gpio: Drop unused enable_external_pullup from driver data
      w1: gpio: rename pointer to driver data from pdata to ddata
      pcmcia: bcm63xx: Convert to platform remove callback returning void
      pcmcia: db1xxx_ss: Convert to platform remove callback returning void
      pcmcia: electra_cf: Convert to platform remove callback returning void
      pcmcia: omap_cf: Convert to platform remove callback returning void
      pcmcia: pxa2xx: Convert to platform remove callback returning void
      pcmcia: sa1100: Convert to platform remove callback returning void
      pcmcia: xxs1500_ss: Convert to platform remove callback returning void
      fpga: altera-fpga2sdram: Convert to platform remove callback returning void
      fpga: altera-freeze-bridge: Convert to platform remove callback returning void
      fpga: altera-hps2fpga: Convert to platform remove callback returning void
      fpga: dfl-afu-main: Convert to platform remove callback returning void
      fpga: dfl-fme-br: Convert to platform remove callback returning void
      fpga: dfl-fme-main: Convert to platform remove callback returning void
      fpga: dfl-fme-region: Convert to platform remove callback returning void
      fpga: intel-m10-bmc-sec-update: Convert to platform remove callback returning void
      fpga: of-fpga-region: Convert to platform remove callback returning void
      fpga: socfpga-a10: Convert to platform remove callback returning void
      fpga: stratix10-soc: Convert to platform remove callback returning void
      fpga: xilinx-pr-decoupler: Convert to platform remove callback returning void
      fpga: zynq-fpga: Convert to platform remove callback returning void
      firmware: arm_scmi: Convert to platform remove callback returning void
      firmware: arm_scpi: Convert to platform remove callback returning void
      firmware: coreboot_table: Convert to platform remove callback returning void
      firmware: imx-dsp: Convert to platform remove callback returning void
      firmware: mtk-adsp-ipc: Convert to platform remove callback returning void
      firmware: qemu_fw_cfg: Convert to platform remove callback returning void
      firmware: raspberrypi: Convert to platform remove callback returning void
      firmware: stratix10-rsu: Convert to platform remove callback returning void
      firmware: stratix10-svc: Convert to platform remove callback returning void
      firmware: turris-mox-rwtm: Convert to platform remove callback returning void
      firmware: zynqmp: Convert to platform remove callback returning void

Wei Yang (4):
      scripts/tags.sh: use more portable -path instead of -wholename
      scripts/tags.sh: add local annotation
      scripts/tags.sh: use -n to test archinclude
      scripts/tags.sh: remove find_sources

Wentong Wu (2):
      mei: Add transport driver for IVSC device
      mei: Add MEI hardware support for IVSC device

Yang Li (1):
      tools/counter: Remove unneeded semicolon

Yaxiong Tian (1):
      extcon: fix possible name leak in extcon_dev_register()

Yicong Yang (2):
      hwtracing: hisi_ptt: Disable interrupt after trace end
      hwtracing: hisi_ptt: Optimize the trace data committing

Yu-Che Cheng (1):
      spmi: mediatek: Fix UAF on device remove

 .mailmap                                           |    7 +-
 Documentation/ABI/testing/sysfs-bus-cdx            |    7 +
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |   16 +
 .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  159 ++
 Documentation/ABI/testing/sysfs-bus-iio            |   42 +-
 Documentation/ABI/testing/sysfs-nvmem-cells        |   21 +
 Documentation/arch/arm64/silicon-errata.rst        |   10 +
 .../bindings/arm/qcom,coresight-tpdm.yaml          |   20 +
 .../devicetree/bindings/iio/adc/adi,ad7091r5.yaml  |   82 +-
 .../bindings/iio/adc/maxim,max34408.yaml           |  139 ++
 .../bindings/iio/adc/qcom,spmi-iadc.yaml           |   10 +-
 .../bindings/iio/adc/qcom,spmi-rradc.yaml          |    4 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |    9 +-
 .../bindings/iio/adc/ti,palmas-gpadc.yaml          |   15 -
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |    4 +
 .../bindings/iio/chemical/aosong,ags02ma.yaml      |   47 +
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml    |    5 +
 .../bindings/iio/dac/microchip,mcp4821.yaml        |   86 +
 .../bindings/iio/humidity/ti,hdc3020.yaml          |   55 +
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml |    4 +
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |    4 +
 .../devicetree/bindings/iio/imu/bosch,bmi323.yaml  |   77 +
 .../bindings/iio/light/liteon,ltr390.yaml          |   56 +
 .../bindings/iio/light/vishay,veml6075.yaml        |   39 +
 .../bindings/iio/pressure/honeywell,hsc030pa.yaml  |  142 ++
 .../iio/pressure/honeywell,mprls0025pa.yaml        |    2 -
 .../bindings/iio/temperature/melexis,mlx90632.yaml |   19 +-
 .../iio/temperature/microchip,mcp9600.yaml         |   70 +
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    4 +
 .../bindings/interconnect/qcom,sm6115.yaml         |  152 ++
 .../bindings/interconnect/qcom,sm8650-rpmh.yaml    |  136 ++
 .../bindings/interconnect/qcom,x1e80100-rpmh.yaml  |   83 +
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |    1 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 .../devicetree/bindings/w1/amd,axi-1wire-host.yaml |   44 +
 Documentation/trace/coresight/coresight.rst        |    4 +
 MAINTAINERS                                        |   95 +-
 arch/arm/common/locomo.c                           |    4 +-
 arch/arm/include/asm/hardware/locomo.h             |    2 -
 drivers/android/binder.c                           |   27 +-
 drivers/android/binder_alloc.c                     | 1596 +++++++-------
 drivers/android/binder_alloc.h                     |   61 +-
 drivers/android/binder_alloc_selftest.c            |   18 +-
 drivers/android/binder_trace.h                     |    2 +-
 drivers/android/binderfs.c                         |    1 -
 drivers/base/property.c                            |   37 +-
 drivers/bus/mhi/ep/internal.h                      |    4 +
 drivers/bus/mhi/ep/main.c                          |  387 ++--
 drivers/bus/mhi/ep/ring.c                          |   60 +-
 drivers/bus/mhi/host/init.c                        |    1 +
 drivers/bus/mhi/host/internal.h                    |    2 +-
 drivers/bus/mhi/host/main.c                        |   34 +-
 drivers/bus/mhi/host/pci_generic.c                 |   22 +
 drivers/bus/mhi/host/pm.c                          |   24 +-
 drivers/bus/moxtet.c                               |    2 +-
 drivers/cdx/cdx.c                                  |  171 +-
 drivers/char/ppdev.c                               |    6 +-
 drivers/comedi/comedi_fops.c                       |    4 +-
 drivers/edac/versal_edac.c                         |    4 +-
 drivers/extcon/extcon-qcom-spmi-misc.c             |    2 +-
 drivers/extcon/extcon-usbc-tusb320.c               |    9 +-
 drivers/extcon/extcon.c                            |    3 +-
 drivers/firmware/arm_scmi/driver.c                 |    6 +-
 drivers/firmware/arm_scpi.c                        |    6 +-
 drivers/firmware/google/coreboot_table.c           |    5 +-
 drivers/firmware/imx/imx-dsp.c                     |    6 +-
 drivers/firmware/mtk-adsp-ipc.c                    |    6 +-
 drivers/firmware/qemu_fw_cfg.c                     |    5 +-
 drivers/firmware/raspberrypi.c                     |    6 +-
 drivers/firmware/stratix10-rsu.c                   |    5 +-
 drivers/firmware/stratix10-svc.c                   |    6 +-
 drivers/firmware/turris-mox-rwtm.c                 |    6 +-
 drivers/firmware/xilinx/zynqmp.c                   |  398 ++--
 drivers/fpga/altera-fpga2sdram.c                   |    6 +-
 drivers/fpga/altera-freeze-bridge.c                |    6 +-
 drivers/fpga/altera-hps2fpga.c                     |    6 +-
 drivers/fpga/dfl-afu-main.c                        |    6 +-
 drivers/fpga/dfl-fme-br.c                          |    6 +-
 drivers/fpga/dfl-fme-main.c                        |    6 +-
 drivers/fpga/dfl-fme-region.c                      |    6 +-
 drivers/fpga/dfl.c                                 |    4 +-
 drivers/fpga/intel-m10-bmc-sec-update.c            |    6 +-
 drivers/fpga/of-fpga-region.c                      |    6 +-
 drivers/fpga/socfpga-a10.c                         |    6 +-
 drivers/fpga/stratix10-soc.c                       |    6 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |    6 +-
 drivers/fpga/zynq-fpga.c                           |    6 +-
 drivers/greybus/gb-beagleplay.c                    |   58 +-
 drivers/hwtracing/coresight/coresight-core.c       |    3 +
 drivers/hwtracing/coresight/coresight-dummy.c      |    5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    2 +
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   52 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |    2 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |    5 +-
 drivers/hwtracing/coresight/coresight-replicator.c |    5 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |   15 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  111 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    3 +
 drivers/hwtracing/coresight/coresight-tpda.c       |  126 +-
 drivers/hwtracing/coresight/coresight-tpda.h       |    2 +
 drivers/hwtracing/coresight/coresight-tpdm.c       |  718 +++++-
 drivers/hwtracing/coresight/coresight-tpdm.h       |  161 ++
 drivers/hwtracing/coresight/coresight-trbe.c       |   28 +-
 drivers/hwtracing/coresight/coresight-trbe.h       |    2 +
 drivers/hwtracing/coresight/ultrasoc-smb.c         |   76 +-
 drivers/hwtracing/ptt/hisi_ptt.c                   |   19 +-
 drivers/hwtracing/ptt/hisi_ptt.h                   |    1 +
 drivers/iio/accel/Kconfig                          |    7 +-
 drivers/iio/accel/bmi088-accel-core.c              |    2 +
 drivers/iio/accel/bmi088-accel-spi.c               |    2 +
 drivers/iio/adc/Kconfig                            |   29 +-
 drivers/iio/adc/Makefile                           |    5 +-
 drivers/iio/adc/ad7091r-base.c                     |  288 ++-
 drivers/iio/adc/ad7091r-base.h                     |   83 +-
 drivers/iio/adc/ad7091r5.c                         |  120 +-
 drivers/iio/adc/ad7091r8.c                         |  272 +++
 drivers/iio/adc/ad9467.c                           |  207 +-
 drivers/iio/adc/adi-axi-adc.c                      |  159 +-
 drivers/iio/adc/max34408.c                         |  276 +++
 drivers/iio/adc/mcp3911.c                          |   64 +-
 drivers/iio/amplifiers/hmc425a.c                   |   23 +
 drivers/iio/buffer/industrialio-buffer-dma.c       |   87 +-
 drivers/iio/chemical/Kconfig                       |   11 +
 drivers/iio/chemical/Makefile                      |    1 +
 drivers/iio/chemical/ags02ma.c                     |  165 ++
 drivers/iio/dac/Kconfig                            |   10 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5791.c                           |    9 +-
 drivers/iio/dac/mcp4821.c                          |  236 ++
 drivers/iio/frequency/adf4377.c                    |   16 +-
 drivers/iio/frequency/admv1014.c                   |   31 +-
 drivers/iio/humidity/hdc3020.c                     |  473 ++++
 drivers/iio/imu/Kconfig                            |    1 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/adis.c                             |   18 +-
 drivers/iio/imu/bmi323/Kconfig                     |   33 +
 drivers/iio/imu/bmi323/Makefile                    |    7 +
 drivers/iio/imu/bmi323/bmi323.h                    |  209 ++
 drivers/iio/imu/bmi323/bmi323_core.c               | 2139 ++++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c                |  121 +
 drivers/iio/imu/bmi323/bmi323_spi.c                |   92 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |    5 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |    5 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |    5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    9 +-
 drivers/iio/industrialio-buffer.c                  |   22 +-
 drivers/iio/industrialio-core.c                    |   66 +
 drivers/iio/light/Kconfig                          |   37 +
 drivers/iio/light/Makefile                         |    3 +
 drivers/iio/light/isl76682.c                       |  345 +++
 drivers/iio/light/ltr390.c                         |  196 ++
 drivers/iio/light/ltrf216a.c                       |   10 +-
 drivers/iio/light/pa12203001.c                     |    2 +-
 drivers/iio/light/rohm-bu27008.c                   |  201 +-
 drivers/iio/light/veml6075.c                       |  474 ++++
 drivers/iio/magnetometer/tmag5273.c                |   10 +-
 drivers/iio/pressure/Kconfig                       |   22 +
 drivers/iio/pressure/Makefile                      |    3 +
 drivers/iio/pressure/bmp280-core.c                 |   42 +-
 drivers/iio/pressure/bmp280-i2c.c                  |    8 +-
 drivers/iio/pressure/bmp280-spi.c                  |   10 +-
 drivers/iio/pressure/bmp280.h                      |    6 +-
 drivers/iio/pressure/hsc030pa.c                    |  494 +++++
 drivers/iio/pressure/hsc030pa.h                    |   74 +
 drivers/iio/pressure/hsc030pa_i2c.c                |   69 +
 drivers/iio/pressure/hsc030pa_spi.c                |   61 +
 drivers/iio/proximity/irsd200.c                    |    1 -
 drivers/iio/proximity/sx9324.c                     |   24 +-
 drivers/iio/resolver/ad2s1210.c                    |  160 +-
 drivers/iio/temperature/Kconfig                    |   22 +
 drivers/iio/temperature/Makefile                   |    2 +
 drivers/iio/temperature/mcp9600.c                  |  139 ++
 drivers/iio/temperature/mlx90635.c                 | 1097 +++++++++
 drivers/interconnect/imx/imx8mm.c                  |    9 +-
 drivers/interconnect/imx/imx8mn.c                  |    9 +-
 drivers/interconnect/imx/imx8mp.c                  |    9 +-
 drivers/interconnect/imx/imx8mq.c                  |    9 +-
 drivers/interconnect/qcom/Kconfig                  |   27 +
 drivers/interconnect/qcom/Makefile                 |    6 +
 drivers/interconnect/qcom/icc-rpm.c                |    4 +-
 drivers/interconnect/qcom/icc-rpm.h                |    2 +-
 drivers/interconnect/qcom/msm8916.c                |    2 +-
 drivers/interconnect/qcom/msm8939.c                |    2 +-
 drivers/interconnect/qcom/msm8974.c                |    6 +-
 drivers/interconnect/qcom/msm8996.c                |    2 +-
 drivers/interconnect/qcom/osm-l3.c                 |    6 +-
 drivers/interconnect/qcom/qcm2290.c                |    2 +-
 drivers/interconnect/qcom/qcs404.c                 |    2 +-
 drivers/interconnect/qcom/sdm660.c                 |    2 +-
 drivers/interconnect/qcom/sm6115.c                 | 1423 ++++++++++++
 drivers/interconnect/qcom/sm8650.c                 | 1674 ++++++++++++++
 drivers/interconnect/qcom/sm8650.h                 |  143 ++
 drivers/interconnect/qcom/smd-rpm.c                |    6 +-
 drivers/interconnect/qcom/x1e80100.c               | 2328 ++++++++++++++++++++
 drivers/interconnect/qcom/x1e80100.h               |  192 ++
 drivers/interconnect/samsung/exynos.c              |    6 +-
 drivers/ipack/ipack.c                              |    4 +-
 drivers/mcb/mcb-core.c                             |    5 +-
 drivers/misc/Kconfig                               |   12 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/cardreader/Makefile                   |    2 +-
 drivers/misc/cardreader/rts5264.c                  |  886 ++++++++
 drivers/misc/cardreader/rts5264.h                  |  278 +++
 drivers/misc/cardreader/rtsx_pcr.c                 |   30 +-
 drivers/misc/cardreader/rtsx_pcr.h                 |    1 +
 drivers/misc/eeprom/at24.c                         |   43 +-
 drivers/misc/eeprom/ee1004.c                       |  113 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |    1 +
 drivers/misc/mei/Kconfig                           |   35 +-
 drivers/misc/mei/Makefile                          |    7 +
 drivers/misc/mei/gsc_proxy/Kconfig                 |    2 +-
 drivers/misc/mei/hdcp/Kconfig                      |    2 +-
 drivers/misc/mei/platform-vsc.c                    |  450 ++++
 drivers/misc/mei/pxp/Kconfig                       |    3 +-
 drivers/misc/mei/vsc-fw-loader.c                   |  770 +++++++
 drivers/misc/mei/vsc-tp.c                          |  555 +++++
 drivers/misc/mei/vsc-tp.h                          |   50 +
 drivers/misc/nsm.c                                 |  506 +++++
 drivers/misc/ocxl/afu_irq.c                        |    2 +-
 drivers/misc/ocxl/context.c                        |    2 +-
 drivers/misc/ocxl/link.c                           |   14 +-
 drivers/misc/ocxl/main.c                           |    2 +-
 drivers/misc/pvpanic/pvpanic-mmio.c                |    7 +-
 drivers/misc/pvpanic/pvpanic-pci.c                 |    6 +-
 drivers/misc/pvpanic/pvpanic.c                     |   12 +-
 drivers/misc/pvpanic/pvpanic.h                     |    5 +
 drivers/misc/vmw_vmci/vmci_handle_array.c          |   12 +-
 drivers/misc/vmw_vmci/vmci_handle_array.h          |    6 -
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   17 +-
 drivers/mux/mmio.c                                 |   19 +-
 drivers/nvmem/Kconfig                              |    1 +
 drivers/nvmem/Makefile                             |    2 +
 drivers/nvmem/core.c                               |  359 +--
 drivers/nvmem/imx-ocotp.c                          |   11 +-
 drivers/nvmem/internals.h                          |   59 +
 drivers/nvmem/layouts.c                            |  201 ++
 drivers/nvmem/layouts/Kconfig                      |    8 +
 drivers/nvmem/layouts/onie-tlv.c                   |   29 +-
 drivers/nvmem/layouts/sl28vpd.c                    |   29 +-
 drivers/nvmem/mtk-efuse.c                          |   11 +-
 drivers/nvmem/stm32-romem.c                        |   16 +
 drivers/nvmem/u-boot-env.c                         |   84 +-
 drivers/of/device.c                                |   41 +
 drivers/of/platform.c                              |   40 -
 drivers/parport/parport_serial.c                   |   64 +
 drivers/parport/share.c                            |    8 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c       |  314 ++-
 drivers/pcmcia/bcm63xx_pcmcia.c                    |    5 +-
 drivers/pcmcia/db1xxx_ss.c                         |    6 +-
 drivers/pcmcia/electra_cf.c                        |    6 +-
 drivers/pcmcia/omap_cf.c                           |    5 +-
 drivers/pcmcia/pxa2xx_base.c                       |    6 +-
 drivers/pcmcia/sa1100_generic.c                    |    8 +-
 drivers/pcmcia/xxs1500_ss.c                        |    6 +-
 drivers/platform/goldfish/goldfish_pipe.c          |    5 +-
 drivers/platform/surface/aggregator/bus.c          |    5 +-
 drivers/sh/maple/maple.c                           |    4 +-
 drivers/soc/xilinx/xlnx_event_manager.c            |   33 +-
 drivers/soc/xilinx/zynqmp_power.c                  |    2 +-
 drivers/spmi/Makefile                              |    2 +-
 drivers/spmi/hisi-spmi-controller.c                |   32 +-
 drivers/spmi/spmi-devres.c                         |   64 +
 drivers/spmi/spmi-mtk-pmif.c                       |   61 +-
 drivers/spmi/spmi-pmic-arb.c                       |   87 +-
 drivers/spmi/spmi.c                                |    6 +-
 drivers/uio/uio.c                                  |    7 +-
 drivers/video/console/Kconfig                      |    2 +-
 drivers/virt/vboxguest/vboxguest_core.c            |  156 +-
 drivers/virt/vboxguest/vboxguest_linux.c           |   22 +-
 drivers/virt/vboxguest/vboxguest_utils.c           |   33 +-
 drivers/virt/vmgenid.c                             |    2 +
 drivers/w1/masters/Kconfig                         |   11 +
 drivers/w1/masters/Makefile                        |    1 +
 drivers/w1/masters/amd_axi_w1.c                    |  396 ++++
 drivers/w1/masters/ds2490.c                        |   25 +-
 drivers/w1/masters/w1-gpio.c                       |  118 +-
 drivers/w1/slaves/w1_ds2433.c                      |  162 +-
 include/dt-bindings/interconnect/qcom,sm6115.h     |  111 +
 .../dt-bindings/interconnect/qcom,sm8650-rpmh.h    |  154 ++
 .../dt-bindings/interconnect/qcom,x1e80100-rpmh.h  |  207 ++
 include/linux/cdx/cdx_bus.h                        |   12 +
 include/linux/coresight.h                          |    1 +
 include/linux/dma-map-ops.h                        |    4 +-
 include/linux/firmware/xlnx-zynqmp.h               |   59 +-
 include/linux/iio/adc/adi-axi-adc.h                |    4 +
 include/linux/iio/buffer-dma.h                     |    7 +-
 include/linux/iio/iio.h                            |    6 -
 include/linux/iio/types.h                          |    1 +
 include/linux/maple.h                              |    1 -
 include/linux/mhi.h                                |    4 +
 include/linux/mhi_ep.h                             |   36 +-
 include/linux/moxtet.h                             |    2 -
 include/linux/nvmem-consumer.h                     |    8 +-
 include/linux/nvmem-provider.h                     |   68 +-
 include/linux/of_device.h                          |    6 +
 include/linux/property.h                           |   12 +
 include/linux/rtsx_pci.h                           |    8 +
 include/linux/spmi.h                               |    3 +
 include/linux/surface_aggregator/device.h          |    1 -
 include/linux/w1-gpio.h                            |   22 -
 include/uapi/linux/android/binder.h                |   30 +-
 include/uapi/linux/iio/types.h                     |    2 +
 include/uapi/linux/mei.h                           |    4 +-
 include/uapi/linux/nsm.h                           |   31 +
 init/do_mounts.c                                   |    9 +-
 kernel/dma/debug.c                                 |    2 +-
 scripts/checkpatch.pl                              |    1 +
 scripts/tags.sh                                    |   17 +-
 tools/counter/Build                                |    1 +
 tools/counter/Makefile                             |   12 +-
 tools/counter/counter_watch_events.c               |  406 ++++
 tools/iio/iio_event_monitor.c                      |    2 +
 tools/testing/nvdimm/test/Kbuild                   |    1 +
 314 files changed, 25408 insertions(+), 3043 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
 create mode 100644 drivers/iio/adc/ad7091r8.c
 create mode 100644 drivers/iio/adc/max34408.c
 create mode 100644 drivers/iio/chemical/ags02ma.c
 create mode 100644 drivers/iio/dac/mcp4821.c
 create mode 100644 drivers/iio/humidity/hdc3020.c
 create mode 100644 drivers/iio/imu/bmi323/Kconfig
 create mode 100644 drivers/iio/imu/bmi323/Makefile
 create mode 100644 drivers/iio/imu/bmi323/bmi323.h
 create mode 100644 drivers/iio/imu/bmi323/bmi323_core.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_i2c.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_spi.c
 create mode 100644 drivers/iio/light/isl76682.c
 create mode 100644 drivers/iio/light/ltr390.c
 create mode 100644 drivers/iio/light/veml6075.c
 create mode 100644 drivers/iio/pressure/hsc030pa.c
 create mode 100644 drivers/iio/pressure/hsc030pa.h
 create mode 100644 drivers/iio/pressure/hsc030pa_i2c.c
 create mode 100644 drivers/iio/pressure/hsc030pa_spi.c
 create mode 100644 drivers/iio/temperature/mcp9600.c
 create mode 100644 drivers/iio/temperature/mlx90635.c
 create mode 100644 drivers/interconnect/qcom/sm6115.c
 create mode 100644 drivers/interconnect/qcom/sm8650.c
 create mode 100644 drivers/interconnect/qcom/sm8650.h
 create mode 100644 drivers/interconnect/qcom/x1e80100.c
 create mode 100644 drivers/interconnect/qcom/x1e80100.h
 create mode 100644 drivers/misc/cardreader/rts5264.c
 create mode 100644 drivers/misc/cardreader/rts5264.h
 create mode 100644 drivers/misc/mei/platform-vsc.c
 create mode 100644 drivers/misc/mei/vsc-fw-loader.c
 create mode 100644 drivers/misc/mei/vsc-tp.c
 create mode 100644 drivers/misc/mei/vsc-tp.h
 create mode 100644 drivers/misc/nsm.c
 create mode 100644 drivers/nvmem/internals.h
 create mode 100644 drivers/nvmem/layouts.c
 create mode 100644 drivers/spmi/spmi-devres.c
 create mode 100644 drivers/w1/masters/amd_axi_w1.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sm6115.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8650-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h
 delete mode 100644 include/linux/w1-gpio.h
 create mode 100644 include/uapi/linux/nsm.h
 create mode 100644 tools/counter/counter_watch_events.c

