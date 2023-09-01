Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CACD78FD13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349378AbjIAMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjIAMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F7E7B;
        Fri,  1 Sep 2023 05:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A5046211B;
        Fri,  1 Sep 2023 12:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD83C433C8;
        Fri,  1 Sep 2023 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693570912;
        bh=AqJBTZOK9oSOfeQcUSIXtBSSu1P2i5IK6RaWyw0v2Fs=;
        h=Date:From:To:Cc:Subject:From;
        b=rvLjBOeOk5pYi+HIU8b/RuSrXa7be79JmFbwqC3+8UyXSCRd7/b+7AT5C+a/qk0mz
         /VDgWNgQYjWGyOmg2tXfivRCQsWoOu3K7cqoN3e9X7FdCwE2QUcyF5EhtwV3oLGcS6
         B1U/qPEP7mHiBtdd747C2XtWPJe7BzrlIYcOX1aKPiofJJReOz1R0Bq+rukQT1TSNv
         4OOp7XMP1u/eEVDAxgetW8md2sSiH1CZbYxN5GyVhqqvtoLXKx/xfeARQRjlKojGme
         pdDT0A76qYLCb6MH1H9pSaupNZE8OdJmnhyeeOZFRbmn1TcjjakcYqysxsAPkkAoLS
         De4AvDqfvK7Fw==
Date:   Fri, 1 Sep 2023 14:21:47 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.6-rc1] media updates
Message-ID: <20230901142147.096c1b57@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.6-1

For:

- new i2c drivers: ds90ub913, ds90ub953, ds90ub960, dw9719, ds90ub913
- New Intel IVSC MEI drivers;
- some Mediatek platform drivers were moved to a common location;
- Intel atomisp2 driver is now working with the main ov2680 driver.
  Due to that, the atomisp2 ov2680 staging one was removed;
- the bttv driver was finally converted to videobuf2 framework. This was
  the last one upstream using videobuf version 1 core. We'll likely remove
  the old videobuf framework on 6.7;
- Lots of improvements at atomisp driver: it now works with normal I2C
  sensors. Several compile-mode dependecies to select between=20
  ISP2400 and ISP2401 are now solved in runtime;
- A new ipu-bridge logic was added to work with IVSC MEI drivers;
- venus driver gained better support for new VPU versions;
- the v4l core async framework has gained lots of improvements and=20
  cleanups;
- lots of other cleanups, improvements and driver fixes.

Regards,
Mauro

---

The following changes since commit 0cb1d9c845110ce638a43a1417c7df5968d1daa3:

  media: verisilicon: change confusingly named relaxed register access (202=
3-07-14 09:14:10 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.6-1

for you to fetch changes up to 9a5d660fdb25d20748d7f9e9559c86073c3bb368:

  media: ivsc: Add ACPI dependency (2023-08-18 12:28:07 +0200)

----------------------------------------------------------------
media updates for v6.6-rc1

----------------------------------------------------------------
Alain Volmat (2):
      media: i2c: st_mipid02: cascade s_stream call to the source subdev
      media: stm32: dcmi: only call s_stream on the source subdev

Alexander Stein (1):
      media: tc358743: Add error code to error message

Andy Shevchenko (1):
      media: drxk: Use %*ph for printing hexdump of a small buffer

Arnd BergmannArnd Bergmann (1):
      media: ipu3-cio2: allow ipu_bridge to be a module again

Benjamin Gaignard (1):
      media: rkvdec: increase max supported height for H.264

Bingbu Cao (6):
      media: ipu3-cio2: rename cio2 bridge to ipu bridge and move out of ip=
u3
      media: ipu-bridge: use IPU_MAX_PORTS for bridge instead of CIO2_NUM_P=
ORTS
      media: ipu3-cio2: rename ipu3-cio2-main.c back to ipu3-cio2.c
      media: ov13b10: Defer probe if no endpoint found
      media: ov13b10: support new ACPI HID 'OVTI13B1'
      media: ov13b10: add PM control support based on power resources

Christophe JAILLET (2):
      media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_=
link()
      media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()

Claudiu Beznea (1):
      media: i2c: tvp5150: check return value of devm_kasprintf()

Colin Ian King (2):
      media: wl128x: Fix spelling mistake "Transfered" -> "Transferred"
      media: go7007: Remove redundant if statement

Dan Carpenter (4):
      media: mediatek: vcodec: Fix potential crash in mtk_vcodec_dbgfs_remo=
ve()
      media: mediatek: vcodec: Improve an error message
      media: mediatek: vcodec: fix potential double free
      media: mediatek: vcodec: fix resource leaks in vdec_msg_queue_init()

Daniel Scally (1):
      media: i2c: Add driver for DW9719 VCM

Daniil Dulov (2):
      media: dib7000p: Fix potential division by zero
      media: cx24120: Add retval check for cx24120_message_send()

Deborah Brouwer (13):
      media: bttv: use video_drvdata to get bttv
      media: bttv: replace BUG with WARN_ON
      media: bttv: radio use v4l2_fh instead of bttv_fh
      media: bttv: copy vid fmt/width/height from fh
      media: bttv: copy vbi_fmt from bttv_fh
      media: bttv: move do_crop flag out of bttv_fh
      media: bttv: remove format field from bttv_buffer
      media: bttv: remove tvnorm field from bttv_buffer
      media: bttv: remove crop info from bttv_buffer
      media: bttv: move vbi_skip/vbi_count out of buffer
      media: bttv: refactor bttv_set_dma()
      media: bttv: use audio defaults for winfast2000
      media: bttv: convert to vb2

Dong Chuanjian (1):
      drivers/media/common/siano/smsendian.c : eliminate unnecessary type c=
onversions

Dongliang Mu (1):
      drivers: usb: smsusb: fix error handling code in smsusb_init_device

Emma Christy (1):
      media: rkvdec: removed redundant blank line

GUO Zihua (1):
      media: coda: Remove duplicated include

Guoniu.zhou (4):
      media: ov5640: fix low resolution image abnormal issue
      media: dt-bindings: nxp,imx8-isi: Add i.MX93 ISI compatible string
      media: nxp: imx8-isi: Move i.MX8 gasket configuration to an ops struc=
ture
      media: nxp: imx8-isi: Add ISI support for i.MX93

Hans Verkuil (15):
      media: tuners: qt1010: replace BUG_ON with a regular error
      staging: media: sun6i-isp: drop of_match_ptr for ID table
      staging: media: tegra-video: include video.h header
      media: pci: cx23885: replace BUG with error return
      media: pci: saa7164: replace BUG with error return
      media: venus: core.h: update kerneldoc
      media: cec: core: add adap_nb_transmit_canceled() callback
      media: cec: core: add adap_unconfigured() callback
      media: Documentation: media: cec: describe new callbacks
      media: cec-gpio: specify IRQF_NO_AUTOEN when requesting irq
      media: cec-pin: improve interrupt handling
      media: cec-gpio: drop the cec_gpio_free callback
      media: cec-pin: only enable interrupts when monitoring the CEC pin
      media: usb: pvrusb2: fix inconsistent indenting
      media: firewire: firedtv-avc.c: replace BUG with proper, error return

Hans de Goede (56):
      media: ad5820: Drop unsupported ad5823 from i2c_ and of_device_id tab=
les
      media: atomisp: Remove bogus asd =3D=3D NULL checks
      media: atomisp: Fix smatch warnings caused by atomisp custom assert()=
 usage
      media: atomisp: Fix me->stages error checking in sh_css_sp_init_pipel=
ine()
      media: Add MIPI CCI register access helper functions
      media: ov5693: Convert to new CCI register access helpers
      media: imx290: Convert to new CCI register access helpers
      media: atomisp: ov2680: Convert to new CCI register access helpers
      media: Remove ov_16bit_addr_reg_helpers.h
      media: ipu-bridge: Fix null pointer deref on SSDB/PLD parsing warnings
      media: ipu-bridge: Do not use on stack memory for software_node.name =
field
      media: ipu-bridge: Move initialization of node_names.vcm to ipu_bridg=
e_init_swnode_names()
      media: ipu-bridge: Move initialization of node_names.vcm to ipu_bridg=
e_init_swnode_names()
      media: ipu-bridge: Store dev pointer in struct ipu_bridge
      media: ipu-bridge: Only keep PLD around while parsing
      media: ipu-bridge: Add a ipu_bridge_parse_ssdb() helper function
      media: ipu-bridge: Drop early setting of sensor->adev
      media: ipu-bridge: Add a parse_sensor_fwnode callback to ipu_bridge_i=
nit()
      media: ipu-bridge: Move ipu-bridge.h to include/media/
      media: ipu-bridge: Add GalaxyCore GC0310 to ipu_supported_sensors[]
      media: ipu-bridge: Add a runtime-pm device-link between VCM and sensor
      media: atomisp: csi2-bridge: Switch to new common ipu_bridge_init()
      media: atomisp: csi2-bridge: Add dev_name() to acpi_handle_info() log=
ging
      media: atomisp: csi2-bridge: Add support for VCM I2C-client instantia=
tion
      media: ov2680: Remove auto-gain and auto-exposure controls
      media: ov2680: Fix ov2680_bayer_order()
      media: ov2680: Fix vflip / hflip set functions
      media: ov2680: Remove VIDEO_V4L2_SUBDEV_API ifdef-s
      media: ov2680: Don't take the lock for try_fmt calls
      media: ov2680: Add ov2680_fill_format() helper function
      media: ov2680: Fix ov2680_set_fmt() which =3D=3D V4L2_SUBDEV_FORMAT_T=
RY not working
      media: ov2680: Fix regulators being left enabled on ov2680_power_on()=
 errors
      media: ov2680: Convert to new CCI register access helpers
      media: ov2680: Store dev instead of i2c_client in ov2680_dev
      media: ov2680: Add runtime-pm support
      media: ov2680: Check for "powerdown" GPIO con-id before checking for =
"reset" GPIO con-id
      media: ov2680: Drop is_enabled flag
      media: ov2680: Add support for more clk setups
      media: ov2680: Add support for 19.2 MHz clock
      media: ov2680: Wait for endpoint fwnode before continuing with probe()
      media: ov2680: Add support for ACPI enumeration
      media: ov2680: Fix ov2680_enum_frame_interval()
      media: ov2680: Annotate the per mode register setting lists
      media: ov2680: Add ov2680_mode struct
      media: ov2680: Make setting the mode algorithm based
      media: ov2680: Add an __ov2680_get_pad_format() helper function
      media: ov2680: Implement selection support
      media: ov2680: Fix exposure and gain ctrls range and default value
      media: ov2680: Add a bunch of register tweaks
      media: ov2680: Drop unnecessary pad checks
      media: ov2680: Read and log sensor revision during probe
      media: ov2680: Add link-freq and pixel-rate controls
      media: ov2680: Add bus-cfg / endpoint property verification
      media: MAINTAINERS: Add Hans de Goede as OV2680 sensor driver maintai=
ner
      media: ipu-bridge: Add link-frequency to OV2680 ipu_supported_sensors=
[] entry
      media: atomisp: Drop atomisp-ov2680 sensor driver

Harshit Mogalapalli (1):
      media: i2c: ds90ub960: fix error handling in ub960_rxport_add_seriali=
zer()

Irui Wang (1):
      media: mediatek: vcodec: Return NULL if no vdec_fb is found

Jack Zhu (5):
      media: dt-bindings: cadence-csi2rx: Convert to DT schema
      media: dt-bindings: cadence-csi2rx: Add resets property
      media: cadence: Add operation on reset
      media: cadence: Add support for external dphy
      media: cadence: Add support for JH7110 SoC

Jacopo Mondi (7):
      media: v4l: async: Drop v4l2_async_nf_parse_fwnode_endpoints()
      media: i2c: imx219: Complete default format initialization
      media: i2c: imx219: Fix colorspace info
      media: i2c: imx219: Use subdev active state
      media: i2c: imx219: Simplify format assignment
      media: i2c: imx219: Simplify code handling in s_fmt
      media: i2c: rdacm21: Fix uninitialized value

Jammy Huang (1):
      media: aspeed: Fix memory overwrite if timing is 1600x900

Jason Chen (1):
      media: ov08x40: Fix hblank out of range issue

Jean-Michel Hautbois (2):
      media: i2c: imx219: Rename mbus codes array
      media: i2c: imx219: Switch from open to init_cfg

Jeffrey Hugo (1):
      media: docs: qcom_camss: Update Code Aurora references

Juerg Haefliger (1):
      media: meson: vdec: Add MODULE_FIRMWARE macro

Konrad Dybcio (18):
      media: venus: hfi_venus: Only consider sys_idle_indicator on V1
      media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking inte=
rrupts
      media: venus: Introduce VPU version distinction
      media: venus: Add vpu_version to most SoCs
      media: venus: firmware: Leave a clue about obtaining CP VARs
      media: venus: hfi_venus: Sanitize venus_boot_core() per-VPU-version
      media: venus: core: Assign registers based on VPU version
      media: venus: hfi_venus: Sanitize venus_halt_axi() per-VPU-version
      media: venus: hfi_venus: Sanitize venus_isr() per-VPU-version
      media: venus: hfi_venus: Sanitize venus_cpu_and_video_core_idle() per=
-VPU-version
      media: venus: hfi_venus: Sanitize venus_cpu_idle_and_pc_ready() per-V=
PU-version
      media: venus: firmware: Sanitize per-VPU-version
      media: venus: hfi_platform: Check vpu_version instead of device compa=
tible
      media: venus: vdec: Sanitize vdec_set_work_route() per-VPU-version
      media: venus: Introduce accessors for remapped hfi_buffer_reqs members
      media: venus: Use newly-introduced hfi_buffer_requirements accessors
      media: venus: hfi_venus: Restrict writing SCIACMDARG3 to Venus V1/V2
      media: venus: core: Set up secure memory ranges for SC7180

Krzysztof Kozlowski (25):
      media: cec: ch7322: drop of_match_ptr for ID table
      media: cec: meson: drop of_match_ptr for ID table
      media: cec: tegra: drop of_match_ptr for ID table
      media: rc: gpio-ir-recv: drop of_match_ptr for ID table
      media: rc: gpio-ir-tx: drop of_match_ptr for ID table
      media: rc: ir-rx51: drop of_match_ptr for ID table
      media: platform: allegro-dvt: drop of_match_ptr for ID table
      media: platform: intel: pxa: drop of_match_ptr for ID table
      media: platform: samsung: s5p-jpeg: drop of_match_ptr for ID table
      media: platform: ti: am437x: drop of_match_ptr for ID table
      media: platform: verisilicon: drop of_match_ptr for ID table
      media: platform: marvell: drop of_match_ptr for ID table
      media: platform: mdp3: drop of_match_ptr for ID table
      media: platform: mdp3: mark OF related data as maybe unused
      media: platform: sun6i-csi: drop of_match_ptr for ID table
      media: platform: sun6i-mipi-csi2: drop of_match_ptr for ID table
      media: platform: sun8i-a83t-mipi-csi2: drop of_match_ptr for ID table
      media: platform: mdp: mark OF related data as maybe unused
      media: i2c: isl7998x: drop of_match_ptr for ID table
      media: i2c: mt9m111: drop of_match_ptr for ID table
      media: i2c: ov2640: drop of_match_ptr for ID table
      media: i2c: ov2680: drop of_match_ptr for ID table
      media: i2c: ov7740: drop of_match_ptr for ID table
      media: i2c: max9286: drop of_match_ptr for ID table
      media: dt-bindings: drop unneeded status from examples

Laurent Pinchart (3):
      staging: media: imx: Merge VIDEO_IMX_CSI into VIDEO_IMX_MEDIA
      arm64: defconfig: Drop CONFIG_VIDEO_IMX_MEDIA
      media: imx: imx7-media-csi: Fix frame sizes enumeration

Lu Hongfei (1):
      media: mdp3: Fix resource leaks in of_find_device_by_node

Luca Ceresoli (1):
      media: i2c: add I2C Address Translator (ATR) support

Lukas Bulwahn (1):
      MAINTAINERS: correct file entry in MEDIA DRIVERS FOR FREESCALE IMX7/8

Marek Vasut (2):
      media: ov5640: Enable MIPI interface in ov5640_set_power_mipi()
      media: ov5640: Fix initial RESETB state and annotate timings

Mariusz Bialonczyk (1):
      media: cx23885: debug cosmetics

Martin Kepplinger (1):
      media: imx: Unstage the imx8mq-mipi-csi2 driver

Michael Tretter (1):
      media: verisilicon: Fix TRY_FMT on encoder OUTPUT

Ming Qian (9):
      MAINTAINERS: update amphion vpu driver entry
      media: amphion: reinit vpu if reqbufs output 0
      media: amphion: add helper function to get id name
      media: amphion: decoder support display delay for all formats
      media: amphion: fix CHECKED_RETURN issues reported by coverity
      media: amphion: fix REVERSE_INULL issues reported by coverity
      media: amphion: fix UNINIT issues reported by coverity
      media: amphion: fix UNUSED_VALUE issue reported by coverity
      media: amphion: ensure the bitops don't cross boundaries

Mingjia Zhang (3):
      media: mediatek: vcodec: Add capture format to support 10bit tile mode
      media: mediatek: vcodec: Add capture format to support 10bit raster m=
ode
      media: mediatek: vcodec: Add driver to support 10bit

Minjie Du (1):
      drivers: saa7164: remove duplicate assignments

Nicolas Ferre (1):
      media: MAINTAINERS: Orphan the OV7740 driver

Niklas S=C3=B6derlund (1):
      media: rcar-csi2: Add support for C-PHY on R-Car V4H

Nikolay Kyx (1):
      staging: media: ipu3: code style fix - avoid multiple line dereference

N=C3=ADcolas F. R. A. Prado (6):
      media: dt-bindings: mediatek,vcodec: Allow single clock for mt8183
      media: dt-bindings: mediatek,vcodec: Don't require assigned-clocks
      media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS register space
      media: mediatek: vcodec: Define address for VDEC_HW_ACTIVE
      media: mediatek: vcodec: Read HW active status from syscon
      media: mediatek: vcodec: Consider vdecsys presence in reg range check

Patrick Whewell (1):
      media: venus: Fix firmware path for sm8250

Paul Kocialkowski (3):
      media: doc: dev-encoder: Fixup whitespace before bold asterisks
      media: doc: codec: Rename "Return fields" to "Returned fields" for co=
nsistency
      media: doc: dev-encoder: Fixup type for ENUM_FRAMEINTERVALS

Peng Fan (1):
      dt-bindings: media: amphion,vpu: correct node name

Rob Herring (1):
      media: Explicitly include correct DT includes

Ruan Jinjie (7):
      media: jpeg-core: Remove redundant dev_err()
      media: rcar_jpu: Remove redundant dev_err()
      media: nxp: Remove redundant dev_err()
      media: tegra_cec: fix the return value handle for platform_get_irq()
      media: camif-core: Do not check for 0 return after calling platform_g=
et_irq()
      media: verisilicon: Do not check for 0 return after calling platform_=
get_irq()
      media: platform: ti: fix the return value handle for platform_get_irq=
()

Sakari Ailus (51):
      media: MAINTAINERS: Assign Shawn Tu's sensor drivers to myself
      media: MAINTAINERS: Add an entry for V4L2 sensor and lens drivers
      media: MAINTAINERS: Orphan dw9768 and ov02a10 drivers
      media: MAINTAINERS: Pick ov5670 maintenance
      media: i2c: Remove Shawn's and Chiranjeevi's e-mail addresses
      media: v4l: fwnode: Remove unneeded forward declaration
      media: atmel-isi: Remote unneeeded forward declaration
      media: xilinx-vipp: Clean up bound async notifier callback
      media: omap3isp: Move link creation to bound callback
      media: Documentation: v4l: Fix async notifier registration example
      media: Documentation: v4l: Add section titles for async
      media: Documentation: v4l: Fix async sensor subdev helper documentati=
on
      media: Documentation: v4l: Document missing async subdev function
      media: Documentation: v4l: Document v4l2_async_nf_cleanup
      media: v4l: async: Add some debug prints
      media: v4l: async: Clean up testing for duplicate async subdevs
      media: v4l: async: Don't check whether asd is NULL in validity check
      media: v4l: async: Make V4L2 async match information a struct
      media: v4l: async: Rename V4L2_ASYNC_MATCH_ macros, add TYPE_
      media: v4l: async: Only pass match information for async subdev valid=
ation
      media: v4l: async: Clean up list heads and entries
      media: v4l: async: Simplify async sub-device fwnode matching
      media: v4l: async: Rename v4l2_async_subdev as v4l2_async_connection
      media: v4l: async: Clean up error handling in v4l2_async_match_notify
      media: v4l: async: Drop duplicate handling when adding connections
      media: v4l: async: Rework internal lists
      media: v4l: async: Obtain async connection based on sub-device
      media: v4l: async: Allow multiple connections between entities
      media: v4l: async: Drop unneeded list entry initialisation
      media: v4l: async: Try more connections
      media: v4l: async: Support fwnode endpoint list matching for subdevs
      media: adv748x: Return to endpoint matching
      media: pxa_camera: Fix probe error handling
      media: pxa_camera: Register V4L2 device early
      media: marvell: cafe: Register V4L2 device earlier
      media: am437x-vpfe: Register V4L2 device early
      media: omap3isp: Initialise V4L2 async notifier later
      media: xilinx-vipp: Init async notifier after registering V4L2 device
      media: davinci: Init async notifier after registering V4L2 device
      media: qcom: Initialise V4L2 async notifier later
      media: v4l: async: Set v4l2_device and subdev in async notifier init
      media: Documentation: v4l: Document sub-device notifiers
      media: ccs-pll: Initialise best_div to avoid a compiler warning
      media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler w=
arning
      media: i2c: Add a camera sensor top level menu
      media: i2c: Remove common dependencies from sensor drivers
      media: MAINTAINERS: Add entry for V4L2 async and fwnode frameworks
      media: MAINTAINERS: Split sensors and lens drivers, add documentation
      media: v4l: async: Avoid a goto in loop implementation
      media: i2c: ccs: Check rules is non-NULL
      media: ivsc: Add ACPI dependency

Sishuai Gong (1):
      media: vivid: fix the racy dev->radio_tx_rds_owner

Stephan Gerhold (1):
      media: venus: firmware: Use of_reserved_mem_lookup()

Thomas Zimmermann (1):
      media: Remove flag FBINFO_FLAG_DEFAULT from fbdev drivers

Tomi Valkeinen (28):
      media: dt-bindings: i2c: Add I2C Address Translator (ATR)
      media: dt-bindings: media: add TI DS90UB913 FPD-Link III Serializer
      media: dt-bindings: media: add TI DS90UB953 FPD-Link III Serializer
      media: dt-bindings: media: add TI DS90UB960 FPD-Link III Deserializer
      media: i2c: add DS90UB960 driver
      media: i2c: add DS90UB913 driver
      media: i2c: add DS90UB953 driver
      media: ti: cal: Clean up mbus formats uses
      media: ti: cal: Fix cal_camerarx_create() error handling
      media: ti: cal: Use subdev state
      media: ti: cal: Implement get_frame_desc for camera-rx
      media: i2c: ds90ub913: Fix a warning about use of uninitialized varia=
ble
      media: i2c: ds90ub9x3: Fix sub-device matching
      media: i2c: ds90ub960: Configure CSI-2 continuous clock
      media: i2c: ds90ub953: Use v4l2_fwnode_endpoint_parse()
      media: i2c: ds90ub913: Use v4l2_fwnode_endpoint_parse()
      media: i2c: ds90ub953: Handle V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK
      media: i2c: ds90ub960: Allow FPD-Link async mode
      media: i2c: ds90ub953: Restructure clkout management
      media: i2c: ds90ub953: Support non-sync mode
      media: i2c: ds90ub960: Rename RXPORT_MODE_CSI2_ASYNC to RXPORT_MODE_C=
SI2_NONSYNC
      media: subdev: Drop implicit zeroing of stream field
      media: subdev: Constify v4l2_subdev_set_routing_with_fmt() param
      media: subdev: Add debug prints to enable/disable_streams
      media: Documentation: Fix [GS]_ROUTING documentation
      media: i2c: ds90ub913: Fix use of uninitialized variables
      media: i2c: ds90ub953: Fix use of uninitialized variables
      media: i2c: ds90ub960: Fix PLL config for 1200 MHz CSI rate

Tommaso Merciai (1):
      media: i2c: imx290: drop format param from imx290_ctrl_update

Uwe Kleine-K=C3=B6nig (2):
      media: ds90ub9xx: switch three more drivers back to use struct i2c_dr=
iver::probe()
      media: i2c: ov01a10: Switch back to use struct i2c_driver::probe

Wentong Wu (3):
      media: pci: intel: ivsc: Add CSI submodule
      media: pci: intel: ivsc: Add ACE submodule
      media: pci: intel: Add IVSC support for IPU bridge driver

Xiaoyong Lu (1):
      media: mediatek: vcodec: fix AV1 decode fail for 36bit iova

Yang Li (1):
      media: i2c: ds90ub953: No need to set device_driver owner

Yang Yingliang (2):
      media: nxp: Fix wrong return pointer check in mxc_isi_crossbar_init()
      media: davinci: vpif_capture: fix error return code in vpif_probe()

Yangtao Li (11):
      media: atmel-isi: Convert to devm_platform_ioremap_resource()
      media: pxa_camera: Use devm_platform_get_and_ioremap_resource()
      media: marvell: Use devm_platform_get_and_ioremap_resource()
      media: microchip-sama5d2-isc: Convert to devm_platform_ioremap_resour=
ce()
      media: fimc-lite: Convert to devm_platform_ioremap_resource()
      media: microchip-sama7g5-isc: Convert to devm_platform_ioremap_resour=
ce()
      media: verisilicon: Convert to devm_platform_ioremap_resource() and d=
evm_platform_ioremap_resource_byname()
      media: stm32-dcmi: Use devm_platform_get_and_ioremap_resource()
      media: platform: ti: Use devm_platform_get_and_ioremap_resource()
      media: fimc-core: Convert to devm_platform_ioremap_resource()
      media: sh_vou: Convert to devm_platform_ioremap_resource()

Yu Zhe (3):
      media: ttusb-dec: remove unnecessary (void*) conversions
      media: ttpci: remove unnecessary (void*) conversions
      media: cx18: remove unnecessary (void*) conversions

Yuanjun Gong (1):
      media: dvb: mb86a16: check the return value of mb86a16_read()

Yunfei Dong (13):
      media: mediatek: vcodec: remove unused parameter
      media: mediatek: vcodec: align fw interface
      media: mediatek: vcodec: Removing struct 'mtk_vcodec_ctx/dev' for sha=
red interface
      media: mediatek: vcodec: Removing useless debug log
      media: mediatek: vcodec: remove the dependency of vcodec debug log
      media: mediatek: vcodec: replace pr_* with dev_* for v4l2 debug messa=
ge
      media: mediatek: vcodec: separate struct 'mtk_vcodec_ctx'
      media: mediatek: vcodec: separate struct mtk_vcodec_dev
      media: mediatek: vcodec: fix unreasonable parameter definition and st=
yle
      media: mediatek: vcodec: remove unused include header
      media: mediatek: vcodec: separate decoder and encoder
      media: mediatek: vcodec: Fix possible invalid memory access for decod=
er
      media: mediatek: vcodec: Fix possible invalid memory access for encod=
er

Zelong Dong (3):
      media: rc: meson-ir: sort Meson IR Controller register macros
      media: rc: meson-ir: rename Meson IR Controller register macros
      media: rc: meson-ir: support MMIO regmaps to access registers

Zhang Shurong (7):
      media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xf=
er
      media: dw2102: Fix null-ptr-deref in dw2102_i2c_transfer()
      media: af9005: Fix null-ptr-deref in af9005_i2c_xfer
      media: anysee: fix null-ptr-deref in anysee_master_xfer
      media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()
      media: dvb-usb: opera1: fix uninit-value in dvb_usb_adapter_dvb_init
      media: dvb-usb-v2: gl861: Fix null-ptr-deref in gl861_i2c_master_xfer

Zheng Wang (1):
      media: mtk-jpeg: Fix use after free bug due to uncanceled work

ye xingchen (2):
      media: pvrusb2: use sysfs_emit() to instead of scnprintf()
      media: siano: Convert to use sysfs_emit_at() API

 Documentation/admin-guide/media/qcom_camss.rst     |    6 +-
 Documentation/devicetree/bindings/i2c/i2c-atr.yaml |   34 +
 .../devicetree/bindings/media/amphion,vpu.yaml     |    8 +-
 .../devicetree/bindings/media/cdns,csi2rx.txt      |  100 -
 .../devicetree/bindings/media/cdns,csi2rx.yaml     |  201 +
 .../bindings/media/cec/nvidia,tegra114-cec.yaml    |    1 -
 .../bindings/media/i2c/st,st-mipid02.yaml          |    1 -
 .../bindings/media/i2c/ti,ds90ub913.yaml           |  133 +
 .../bindings/media/i2c/ti,ds90ub953.yaml           |  134 +
 .../bindings/media/i2c/ti,ds90ub960.yaml           |  427 ++
 .../bindings/media/mediatek,vcodec-decoder.yaml    |   67 +-
 .../devicetree/bindings/media/nxp,imx8-isi.yaml    |    5 +-
 Documentation/driver-api/media/cec-core.rst        |   44 +-
 Documentation/driver-api/media/v4l2-cci.rst        |    5 +
 Documentation/driver-api/media/v4l2-core.rst       |    1 +
 Documentation/driver-api/media/v4l2-subdev.rst     |  110 +-
 Documentation/i2c/i2c-address-translators.rst      |   96 +
 Documentation/i2c/index.rst                        |    1 +
 .../userspace-api/media/v4l/dev-decoder.rst        |   16 +-
 .../userspace-api/media/v4l/dev-encoder.rst        |   24 +-
 .../media/v4l/dev-stateless-decoder.rst            |    4 +-
 .../userspace-api/media/v4l/pixfmt-reserved.rst    |   13 +
 .../media/v4l/vidioc-subdev-g-routing.rst          |    7 +-
 MAINTAINERS                                        |   86 +-
 arch/arm64/configs/defconfig                       |    1 -
 drivers/i2c/Kconfig                                |    9 +
 drivers/i2c/Makefile                               |    1 +
 drivers/i2c/i2c-atr.c                              |  710 ++++
 drivers/media/cec/core/cec-adap.c                  |    8 +-
 drivers/media/cec/core/cec-notifier.c              |    1 +
 drivers/media/cec/core/cec-pin-priv.h              |    1 +
 drivers/media/cec/core/cec-pin.c                   |   32 +-
 drivers/media/cec/i2c/ch7322.c                     |    2 +-
 drivers/media/cec/platform/cec-gpio/cec-gpio.c     |   10 +-
 drivers/media/cec/platform/meson/ao-cec.c          |    2 +-
 drivers/media/cec/platform/stm32/stm32-cec.c       |    1 -
 drivers/media/cec/platform/tegra/tegra_cec.c       |    6 +-
 drivers/media/common/siano/smsdvb-debugfs.c        |  334 +-
 drivers/media/common/siano/smsendian.c             |    2 +-
 drivers/media/dvb-frontends/cx24120.c              |    4 +-
 drivers/media/dvb-frontends/dib7000p.c             |    2 +-
 drivers/media/dvb-frontends/drxk_hard.c            |   29 +-
 drivers/media/dvb-frontends/mb86a16.c              |   10 +-
 drivers/media/dvb-frontends/mn88443x.c             |    2 +-
 drivers/media/firewire/firedtv-avc.c               |    4 +-
 drivers/media/i2c/Kconfig                          |  298 +-
 drivers/media/i2c/Makefile                         |    4 +
 drivers/media/i2c/ad5820.c                         |    2 -
 drivers/media/i2c/adv748x/adv748x-csi2.c           |   13 +-
 drivers/media/i2c/ccs-pll.c                        |    2 +-
 drivers/media/i2c/ccs/Kconfig                      |    5 +-
 drivers/media/i2c/ccs/ccs-data.c                   |  101 +-
 drivers/media/i2c/ds90ub913.c                      |  903 +++++
 drivers/media/i2c/ds90ub953.c                      | 1430 +++++++
 drivers/media/i2c/ds90ub960.c                      | 4059 ++++++++++++++++=
++++
 drivers/media/i2c/dw9719.c                         |  350 ++
 drivers/media/i2c/et8ek8/Kconfig                   |    4 -
 drivers/media/i2c/hi556.c                          |    2 +-
 drivers/media/i2c/hi847.c                          |    2 +-
 drivers/media/i2c/imx208.c                         |    2 +-
 drivers/media/i2c/imx219.c                         |  292 +-
 drivers/media/i2c/imx290.c                         |  369 +-
 drivers/media/i2c/imx296.c                         |    2 +-
 drivers/media/i2c/imx319.c                         |    2 +-
 drivers/media/i2c/imx355.c                         |    2 +-
 drivers/media/i2c/imx415.c                         |    2 +-
 drivers/media/i2c/isl7998x.c                       |    2 +-
 drivers/media/i2c/max9286.c                        |   29 +-
 drivers/media/i2c/mt9m111.c                        |    2 +-
 drivers/media/i2c/og01a1b.c                        |    2 +-
 drivers/media/i2c/ov01a10.c                        |    2 +-
 drivers/media/i2c/ov08x40.c                        |   16 +-
 drivers/media/i2c/ov13858.c                        |    2 +-
 drivers/media/i2c/ov13b10.c                        |  129 +-
 drivers/media/i2c/ov2640.c                         |    2 +-
 drivers/media/i2c/ov2680.c                         | 1290 ++++---
 drivers/media/i2c/ov2740.c                         |    2 +-
 drivers/media/i2c/ov5640.c                         |   24 +-
 drivers/media/i2c/ov5670.c                         |    2 +-
 drivers/media/i2c/ov5675.c                         |    2 +-
 drivers/media/i2c/ov5693.c                         |  587 ++-
 drivers/media/i2c/ov7740.c                         |    2 +-
 drivers/media/i2c/rdacm20.c                        |   16 +-
 drivers/media/i2c/rdacm21.c                        |   17 +-
 drivers/media/i2c/st-mipid02.c                     |   25 +-
 drivers/media/i2c/tc358743.c                       |    8 +-
 drivers/media/i2c/tc358746.c                       |   15 +-
 drivers/media/i2c/tvp5150.c                        |    4 +
 drivers/media/i2c/video-i2c.c                      |    2 +-
 drivers/media/pci/Kconfig                          |    2 +-
 drivers/media/pci/bt8xx/Kconfig                    |    2 +-
 drivers/media/pci/bt8xx/bt848.h                    |    8 +
 drivers/media/pci/bt8xx/bttv-audio-hook.c          |   10 +-
 drivers/media/pci/bt8xx/bttv-driver.c              | 1014 ++---
 drivers/media/pci/bt8xx/bttv-risc.c                |  415 +-
 drivers/media/pci/bt8xx/bttv-vbi.c                 |  281 +-
 drivers/media/pci/bt8xx/bttvp.h                    |   79 +-
 drivers/media/pci/cx18/cx18-gpio.c                 |    2 +-
 drivers/media/pci/cx18/cx18-irq.c                  |    2 +-
 drivers/media/pci/cx23885/cx23885-core.c           |    6 +-
 drivers/media/pci/cx23885/cx23885-video.c          |    2 +-
 drivers/media/pci/intel/Kconfig                    |   11 +
 drivers/media/pci/intel/Makefile                   |    5 +-
 drivers/media/pci/intel/ipu-bridge.c               |  814 ++++
 drivers/media/pci/intel/ipu3/Kconfig               |    1 +
 drivers/media/pci/intel/ipu3/Makefile              |    3 -
 drivers/media/pci/intel/ipu3/cio2-bridge.c         |  494 ---
 .../intel/ipu3/{ipu3-cio2-main.c =3D> ipu3-cio2.c}   |   26 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.h           |    6 -
 drivers/media/pci/intel/ivsc/Kconfig               |   12 +
 drivers/media/pci/intel/ivsc/Makefile              |    9 +
 drivers/media/pci/intel/ivsc/mei_ace.c             |  579 +++
 drivers/media/pci/intel/ivsc/mei_csi.c             |  825 ++++
 drivers/media/pci/ivtv/ivtvfb.c                    |    1 -
 drivers/media/pci/saa7164/saa7164-encoder.c        |    2 +-
 drivers/media/pci/saa7164/saa7164-fw.c             |    1 -
 drivers/media/pci/ttpci/budget-av.c                |   34 +-
 drivers/media/pci/ttpci/budget-ci.c                |   30 +-
 drivers/media/pci/ttpci/budget-core.c              |    6 +-
 drivers/media/pci/ttpci/budget.c                   |   20 +-
 drivers/media/platform/allegro-dvt/allegro-core.c  |    3 +-
 drivers/media/platform/amphion/vdec.c              |   41 +-
 drivers/media/platform/amphion/venc.c              |    6 +-
 drivers/media/platform/amphion/vpu.h               |    3 +
 drivers/media/platform/amphion/vpu_cmds.c          |   18 +-
 drivers/media/platform/amphion/vpu_core.c          |    4 +-
 drivers/media/platform/amphion/vpu_dbg.c           |   17 +-
 drivers/media/platform/amphion/vpu_drv.c           |    4 +-
 drivers/media/platform/amphion/vpu_helpers.c       |   61 +
 drivers/media/platform/amphion/vpu_malone.c        |    2 -
 drivers/media/platform/amphion/vpu_mbox.c          |    2 -
 drivers/media/platform/amphion/vpu_msgs.c          |   14 +-
 drivers/media/platform/amphion/vpu_rpc.c           |    2 -
 drivers/media/platform/amphion/vpu_v4l2.c          |    7 +-
 drivers/media/platform/amphion/vpu_windsor.c       |    2 -
 drivers/media/platform/aspeed/aspeed-video.c       |    5 +-
 drivers/media/platform/atmel/atmel-isi.c           |   16 +-
 drivers/media/platform/atmel/atmel-isi.h           |    2 -
 drivers/media/platform/cadence/cdns-csi2rx.c       |  117 +-
 drivers/media/platform/chips-media/coda-common.c   |    4 +-
 drivers/media/platform/intel/pxa_camera.c          |   82 +-
 drivers/media/platform/marvell/cafe-driver.c       |   18 +-
 drivers/media/platform/marvell/mcam-core.c         |   15 +-
 drivers/media/platform/marvell/mmp-driver.c        |   11 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |    1 +
 .../media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c |    2 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |    4 +-
 drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c |    2 -
 drivers/media/platform/mediatek/mdp/mtk_mdp_core.c |    2 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   |    4 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |    2 +-
 drivers/media/platform/mediatek/vcodec/Makefile    |   55 +-
 .../media/platform/mediatek/vcodec/common/Makefile |   21 +
 .../mediatek/vcodec/common/mtk_vcodec_cmn_drv.h    |  147 +
 .../vcodec/{ =3D> common}/mtk_vcodec_dbgfs.c         |   68 +-
 .../vcodec/{ =3D> common}/mtk_vcodec_dbgfs.h         |   24 +-
 .../mediatek/vcodec/{ =3D> common}/mtk_vcodec_fw.c   |   21 +-
 .../mediatek/vcodec/{ =3D> common}/mtk_vcodec_fw.h   |    8 +-
 .../vcodec/{ =3D> common}/mtk_vcodec_fw_priv.h       |   14 +-
 .../vcodec/{ =3D> common}/mtk_vcodec_fw_scp.c        |   26 +-
 .../vcodec/{ =3D> common}/mtk_vcodec_fw_vpu.c        |   64 +-
 .../mediatek/vcodec/common/mtk_vcodec_intr.c       |   68 +
 .../mediatek/vcodec/{ =3D> common}/mtk_vcodec_intr.h |    6 +-
 .../mediatek/vcodec/{ =3D> common}/mtk_vcodec_util.c |   83 +-
 .../mediatek/vcodec/common/mtk_vcodec_util.h       |   75 +
 .../platform/mediatek/vcodec/decoder/Makefile      |   25 +
 .../mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_dec.c |  204 +-
 .../mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_dec.h |   10 +-
 .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_drv.c      |  165 +-
 .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h   |  324 ++
 .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_hw.c       |   23 +-
 .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_hw.h       |    9 +-
 .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_pm.c       |   41 +-
 .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_pm.h       |    6 +-
 .../vcodec/{ =3D> decoder}/mtk_vcodec_dec_stateful.c |  176 +-
 .../{ =3D> decoder}/mtk_vcodec_dec_stateless.c       |  235 +-
 .../{ =3D> decoder}/vdec/vdec_av1_req_lat_if.c       |  170 +-
 .../vcodec/{ =3D> decoder}/vdec/vdec_h264_if.c       |   79 +-
 .../{ =3D> decoder}/vdec/vdec_h264_req_common.c      |    4 +-
 .../{ =3D> decoder}/vdec/vdec_h264_req_common.h      |    6 +-
 .../vcodec/{ =3D> decoder}/vdec/vdec_h264_req_if.c   |   75 +-
 .../{ =3D> decoder}/vdec/vdec_h264_req_multi_if.c    |  157 +-
 .../{ =3D> decoder}/vdec/vdec_hevc_req_multi_if.c    |  129 +-
 .../vcodec/{ =3D> decoder}/vdec/vdec_vp8_if.c        |   80 +-
 .../vcodec/{ =3D> decoder}/vdec/vdec_vp8_req_if.c    |   81 +-
 .../vcodec/{ =3D> decoder}/vdec/vdec_vp9_if.c        |  137 +-
 .../{ =3D> decoder}/vdec/vdec_vp9_req_lat_if.c       |  129 +-
 .../mediatek/vcodec/{ =3D> decoder}/vdec_drv_base.h  |    2 +-
 .../mediatek/vcodec/{ =3D> decoder}/vdec_drv_if.c    |   12 +-
 .../mediatek/vcodec/{ =3D> decoder}/vdec_drv_if.h    |   10 +-
 .../mediatek/vcodec/{ =3D> decoder}/vdec_ipi_msg.h   |    0
 .../mediatek/vcodec/{ =3D> decoder}/vdec_msg_queue.c |   70 +-
 .../mediatek/vcodec/{ =3D> decoder}/vdec_msg_queue.h |   14 +-
 .../mediatek/vcodec/{ =3D> decoder}/vdec_vpu_if.c    |  128 +-
 .../mediatek/vcodec/{ =3D> decoder}/vdec_vpu_if.h    |    6 +-
 .../platform/mediatek/vcodec/encoder/Makefile      |   11 +
 .../mediatek/vcodec/{ =3D> encoder}/mtk_vcodec_enc.c |  296 +-
 .../mediatek/vcodec/{ =3D> encoder}/mtk_vcodec_enc.h |   12 +-
 .../vcodec/{ =3D> encoder}/mtk_vcodec_enc_drv.c      |   75 +-
 .../mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h   |  248 ++
 .../vcodec/{ =3D> encoder}/mtk_vcodec_enc_pm.c       |   15 +-
 .../vcodec/{ =3D> encoder}/mtk_vcodec_enc_pm.h       |    4 +-
 .../vcodec/{ =3D> encoder}/venc/venc_h264_if.c       |  110 +-
 .../vcodec/{ =3D> encoder}/venc/venc_vp8_if.c        |   69 +-
 .../mediatek/vcodec/{ =3D> encoder}/venc_drv_base.h  |    4 +-
 .../mediatek/vcodec/{ =3D> encoder}/venc_drv_if.c    |   10 +-
 .../mediatek/vcodec/{ =3D> encoder}/venc_drv_if.h    |   11 +-
 .../mediatek/vcodec/{ =3D> encoder}/venc_ipi_msg.h   |    0
 .../mediatek/vcodec/{ =3D> encoder}/venc_vpu_if.c    |  110 +-
 .../mediatek/vcodec/{ =3D> encoder}/venc_vpu_if.h    |    3 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h      |  548 ---
 .../platform/mediatek/vcodec/mtk_vcodec_intr.c     |   43 -
 .../platform/mediatek/vcodec/mtk_vcodec_util.h     |   83 -
 drivers/media/platform/mediatek/vpu/mtk_vpu.c      |    4 +-
 .../media/platform/microchip/microchip-csi2dc.c    |   11 +-
 .../media/platform/microchip/microchip-isc-base.c  |    4 +-
 drivers/media/platform/microchip/microchip-isc.h   |    2 +-
 .../platform/microchip/microchip-sama5d2-isc.c     |   13 +-
 .../platform/microchip/microchip-sama7g5-isc.c     |   13 +-
 drivers/media/platform/nvidia/tegra-vde/vde.c      |    3 +-
 drivers/media/platform/nxp/Kconfig                 |   11 +
 drivers/media/platform/nxp/Makefile                |    1 +
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     |    1 -
 drivers/media/platform/nxp/imx-mipi-csis.c         |   18 +-
 drivers/media/platform/nxp/imx-pxp.c               |    1 -
 drivers/media/platform/nxp/imx7-media-csi.c        |   26 +-
 drivers/media/platform/nxp/imx8-isi/Makefile       |    4 +-
 .../media/platform/nxp/imx8-isi/imx8-isi-core.c    |   35 +-
 .../media/platform/nxp/imx8-isi/imx8-isi-core.h    |   14 +-
 .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      |   38 +-
 .../media/platform/nxp/imx8-isi/imx8-isi-gasket.c  |   85 +
 .../media/platform/nxp/imx8-isi/imx8-isi-pipe.c    |    1 -
 .../imx =3D> media/platform/nxp}/imx8mq-mipi-csi2.c  |   10 +-
 drivers/media/platform/qcom/camss/camss.c          |   26 +-
 drivers/media/platform/qcom/camss/camss.h          |    2 +-
 drivers/media/platform/qcom/venus/core.c           |   16 +-
 drivers/media/platform/qcom/venus/core.h           |   19 +-
 drivers/media/platform/qcom/venus/firmware.c       |   42 +-
 drivers/media/platform/qcom/venus/helpers.c        |    7 +-
 drivers/media/platform/qcom/venus/hfi_helper.h     |   61 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c       |    2 +-
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |   22 +-
 drivers/media/platform/qcom/venus/hfi_platform.c   |    4 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |   42 +-
 drivers/media/platform/qcom/venus/vdec.c           |   10 +-
 drivers/media/platform/qcom/venus/vdec_ctrls.c     |    2 +-
 drivers/media/platform/qcom/venus/venc.c           |    4 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |    2 +-
 drivers/media/platform/renesas/rcar-isp.c          |   14 +-
 .../media/platform/renesas/rcar-vin/rcar-core.c    |   53 +-
 .../media/platform/renesas/rcar-vin/rcar-csi2.c    |  312 +-
 drivers/media/platform/renesas/rcar-vin/rcar-vin.h |   10 +-
 drivers/media/platform/renesas/rcar_drif.c         |   15 +-
 drivers/media/platform/renesas/rcar_fdp1.c         |    1 -
 drivers/media/platform/renesas/rcar_jpu.c          |    5 +-
 drivers/media/platform/renesas/renesas-ceu.c       |   11 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-core.c  |   15 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h   |    2 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  |   13 +-
 drivers/media/platform/renesas/sh_vou.c            |   12 +-
 drivers/media/platform/renesas/vsp1/vsp1_drv.c     |    1 -
 .../media/platform/rockchip/rkisp1/rkisp1-common.h |    2 +-
 .../media/platform/rockchip/rkisp1/rkisp1-csi.c    |    7 +-
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |   14 +-
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |    8 +-
 .../media/platform/samsung/exynos-gsc/gsc-core.c   |    1 -
 .../media/platform/samsung/exynos4-is/fimc-core.c  |    5 +-
 .../media/platform/samsung/exynos4-is/fimc-lite.c  |    4 +-
 .../media/platform/samsung/exynos4-is/media-dev.c  |   12 +-
 .../media/platform/samsung/exynos4-is/media-dev.h  |    2 +-
 .../media/platform/samsung/s3c-camif/camif-core.c  |    4 +-
 .../media/platform/samsung/s5p-jpeg/jpeg-core.c    |    6 +-
 drivers/media/platform/st/stm32/stm32-dcmi.c       |   92 +-
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c |   11 +-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |    3 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi_bridge.c    |   12 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi_bridge.h    |    2 +-
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c        |   13 +-
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c    |   13 +-
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c   |    4 +-
 .../platform/sunxi/sun8i-rotate/sun8i_rotate.c     |    4 +-
 drivers/media/platform/ti/am437x/am437x-vpfe.c     |   42 +-
 drivers/media/platform/ti/am437x/am437x-vpfe.h     |    2 +-
 drivers/media/platform/ti/cal/cal-camerarx.c       |  206 +-
 drivers/media/platform/ti/cal/cal-video.c          |   23 +-
 drivers/media/platform/ti/cal/cal.c                |   78 +-
 drivers/media/platform/ti/cal/cal.h                |   10 -
 drivers/media/platform/ti/davinci/vpif_capture.c   |   36 +-
 drivers/media/platform/ti/omap3isp/isp.c           |   62 +-
 drivers/media/platform/ti/omap3isp/isp.h           |   15 +-
 drivers/media/platform/ti/omap3isp/ispccdc.c       |   13 +-
 drivers/media/platform/ti/omap3isp/ispccp2.c       |    2 +
 drivers/media/platform/ti/omap3isp/ispcsi2.c       |    2 +
 drivers/media/platform/ti/omap3isp/ispcsiphy.c     |   15 +-
 drivers/media/platform/verisilicon/hantro_drv.c    |   15 +-
 drivers/media/platform/verisilicon/hantro_v4l2.c   |    9 +-
 drivers/media/platform/video-mux.c                 |   10 +-
 drivers/media/platform/xilinx/xilinx-vipp.c        |   55 +-
 drivers/media/radio/wl128x/fmdrv_common.c          |    3 +-
 drivers/media/rc/Kconfig                           |    1 +
 drivers/media/rc/gpio-ir-recv.c                    |    2 +-
 drivers/media/rc/gpio-ir-tx.c                      |    2 +-
 drivers/media/rc/ir-rx51.c                         |    2 +-
 drivers/media/rc/meson-ir.c                        |  122 +-
 drivers/media/rc/mtk-cir.c                         |    3 +-
 drivers/media/rc/sunxi-cir.c                       |    3 +-
 drivers/media/test-drivers/vivid/vivid-core.c      |    2 +-
 drivers/media/test-drivers/vivid/vivid-osd.c       |    1 -
 drivers/media/tuners/qt1010.c                      |   11 +-
 drivers/media/usb/dvb-usb-v2/af9035.c              |    9 +-
 drivers/media/usb/dvb-usb-v2/anysee.c              |    2 +-
 drivers/media/usb/dvb-usb-v2/az6007.c              |    8 +
 drivers/media/usb/dvb-usb-v2/gl861.c               |    2 +-
 drivers/media/usb/dvb-usb/af9005.c                 |    5 +
 drivers/media/usb/dvb-usb/dw2102.c                 |   24 +
 drivers/media/usb/dvb-usb/m920x.c                  |    5 +-
 drivers/media/usb/dvb-usb/opera1.c                 |    9 +-
 drivers/media/usb/go7007/go7007-i2c.c              |    2 -
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |    6 +-
 drivers/media/usb/pvrusb2/pvrusb2-sysfs.c          |   20 +-
 drivers/media/usb/siano/smsusb.c                   |   21 +-
 drivers/media/usb/ttusb-dec/ttusbdecfe.c           |   12 +-
 drivers/media/v4l2-core/Kconfig                    |    9 +
 drivers/media/v4l2-core/Makefile                   |    1 +
 drivers/media/v4l2-core/v4l2-async.c               |  701 ++--
 drivers/media/v4l2-core/v4l2-cci.c                 |  166 +
 drivers/media/v4l2-core/v4l2-common.c              |    4 +
 drivers/media/v4l2-core/v4l2-fwnode.c              |  127 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    2 +
 drivers/media/v4l2-core/v4l2-subdev.c              |   44 +-
 drivers/staging/media/atomisp/Kconfig              |    3 +
 drivers/staging/media/atomisp/i2c/Kconfig          |   12 -
 drivers/staging/media/atomisp/i2c/Makefile         |    1 -
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c |  849 ----
 drivers/staging/media/atomisp/i2c/ov2680.h         |  249 --
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |   24 -
 .../media/atomisp/pci/atomisp_compat_css20.c       |    3 -
 drivers/staging/media/atomisp/pci/atomisp_csi2.h   |   67 -
 .../media/atomisp/pci/atomisp_csi2_bridge.c        |  414 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |    3 +-
 drivers/staging/media/atomisp/pci/sh_css_mipi.c    |   16 -
 .../staging/media/atomisp/pci/sh_css_param_dvs.c   |    3 -
 drivers/staging/media/atomisp/pci/sh_css_sp.c      |   14 +-
 .../media/deprecated/atmel/atmel-isc-base.c        |    4 +-
 drivers/staging/media/deprecated/atmel/atmel-isc.h |    2 +-
 .../media/deprecated/atmel/atmel-sama5d2-isc.c     |    9 +-
 .../media/deprecated/atmel/atmel-sama7g5-isc.c     |    9 +-
 drivers/staging/media/imx/Kconfig                  |   27 +-
 drivers/staging/media/imx/Makefile                 |    9 +-
 drivers/staging/media/imx/imx-media-csi.c          |   10 +-
 drivers/staging/media/imx/imx-media-dev-common.c   |    6 +-
 drivers/staging/media/imx/imx-media-dev.c          |    2 +-
 drivers/staging/media/imx/imx-media-of.c           |    4 +-
 drivers/staging/media/imx/imx6-mipi-csi2.c         |   12 +-
 drivers/staging/media/ipu3/ipu3-css.c              |   14 +-
 drivers/staging/media/meson/vdec/vdec_platform.c   |    9 +
 drivers/staging/media/rkvdec/rkvdec-vp9.c          |    1 -
 drivers/staging/media/rkvdec/rkvdec.c              |    2 +-
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c  |    2 +-
 .../staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c |    6 +-
 .../staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h |    2 +-
 drivers/staging/media/tegra-video/vi.c             |   21 +-
 drivers/staging/media/tegra-video/vip.c            |    1 +
 include/linux/i2c-atr.h                            |  116 +
 include/media/cec.h                                |   11 +-
 include/media/davinci/vpif_types.h                 |    2 +-
 include/media/i2c/ds90ub9xx.h                      |   22 +
 .../cio2-bridge.h =3D> include/media/ipu-bridge.h    |   97 +-
 include/media/ov_16bit_addr_reg_helpers.h          |   92 -
 include/media/v4l2-async.h                         |  238 +-
 include/media/v4l2-cci.h                           |  125 +
 include/media/v4l2-fwnode.h                        |   70 -
 include/media/v4l2-subdev.h                        |   21 +-
 include/uapi/linux/videodev2.h                     |    2 +
 374 files changed, 18949 insertions(+), 9559 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-atr.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.txt
 create mode 100644 Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ti,ds90ub91=
3.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ti,ds90ub95=
3.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ti,ds90ub96=
0.yaml
 create mode 100644 Documentation/driver-api/media/v4l2-cci.rst
 create mode 100644 Documentation/i2c/i2c-address-translators.rst
 create mode 100644 drivers/i2c/i2c-atr.c
 create mode 100644 drivers/media/i2c/ds90ub913.c
 create mode 100644 drivers/media/i2c/ds90ub953.c
 create mode 100644 drivers/media/i2c/ds90ub960.c
 create mode 100644 drivers/media/i2c/dw9719.c
 create mode 100644 drivers/media/pci/intel/Kconfig
 create mode 100644 drivers/media/pci/intel/ipu-bridge.c
 delete mode 100644 drivers/media/pci/intel/ipu3/cio2-bridge.c
 rename drivers/media/pci/intel/ipu3/{ipu3-cio2-main.c =3D> ipu3-cio2.c} (9=
9%)
 create mode 100644 drivers/media/pci/intel/ivsc/Kconfig
 create mode 100644 drivers/media/pci/intel/ivsc/Makefile
 create mode 100644 drivers/media/pci/intel/ivsc/mei_ace.c
 create mode 100644 drivers/media/pci/intel/ivsc/mei_csi.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/common/Makefile
 create mode 100644 drivers/media/platform/mediatek/vcodec/common/mtk_vcode=
c_cmn_drv.h
 rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_db=
gfs.c (75%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_db=
gfs.h (62%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_fw=
.c (75%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_fw=
.h (86%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_fw=
_priv.h (75%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_fw=
_scp.c (70%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_fw=
_vpu.c (58%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/common/mtk_vcode=
c_intr.c
 rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_in=
tr.h (68%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> common}/mtk_vcodec_ut=
il.c (50%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/common/mtk_vcode=
c_util.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_d=
ec.c (82%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_d=
ec.h (91%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_d=
ec_drv.c (72%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcod=
ec_dec_drv.h
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_d=
ec_hw.c (89%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_d=
ec_hw.h (87%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_d=
ec_pm.c (81%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_d=
ec_pm.h (61%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_d=
ec_stateful.c (73%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/mtk_vcodec_d=
ec_stateless.c (67%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_av=
1_req_lat_if.c (93%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_h2=
64_if.c (84%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_h2=
64_req_common.c (98%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_h2=
64_req_common.h (97%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_h2=
64_req_if.c (86%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_h2=
64_req_multi_if.c (85%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_he=
vc_req_multi_if.c (90%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_vp=
8_if.c (87%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_vp=
8_req_if.c (81%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_vp=
9_if.c (87%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec/vdec_vp=
9_req_lat_if.c (94%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_drv_bas=
e.h (95%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_drv_if.=
c (86%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_drv_if.=
h (89%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_ipi_msg=
.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_msg_que=
ue.c (81%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_msg_que=
ue.h (95%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_vpu_if.=
c (67%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> decoder}/vdec_vpu_if.=
h (97%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/encoder/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec_e=
nc.c (82%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec_e=
nc.h (78%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec_e=
nc_drv.c (85%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcod=
ec_enc_drv.h
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec_e=
nc_pm.c (82%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/mtk_vcodec_e=
nc_pm.h (78%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc/venc_h2=
64_if.c (88%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc/venc_vp=
8_if.c (88%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_drv_bas=
e.h (94%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_drv_if.=
c (86%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_drv_if.=
h (94%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_ipi_msg=
.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_vpu_if.=
c (75%)
 rename drivers/media/platform/mediatek/vcodec/{ =3D> encoder}/venc_vpu_if.=
h (96%)
 delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
 delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
 delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
 create mode 100644 drivers/media/platform/nxp/imx8-isi/imx8-isi-gasket.c
 rename drivers/{staging/media/imx =3D> media/platform/nxp}/imx8mq-mipi-csi=
2.c (99%)
 create mode 100644 drivers/media/v4l2-core/v4l2-cci.c
 delete mode 100644 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
 delete mode 100644 drivers/staging/media/atomisp/i2c/ov2680.h
 create mode 100644 include/linux/i2c-atr.h
 create mode 100644 include/media/i2c/ds90ub9xx.h
 rename drivers/media/pci/intel/ipu3/cio2-bridge.h =3D> include/media/ipu-b=
ridge.h (51%)
 delete mode 100644 include/media/ov_16bit_addr_reg_helpers.h
 create mode 100644 include/media/v4l2-cci.h

