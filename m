Return-Path: <linux-kernel+bounces-24666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297E682C000
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2042C1C21945
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276ED6BB2F;
	Fri, 12 Jan 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAZ19EJX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B450260;
	Fri, 12 Jan 2024 12:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6385CC433C7;
	Fri, 12 Jan 2024 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705063830;
	bh=q9XAwylse1ZA2nvq7PPowM/YCNLK3p/76zmYdq2azYI=;
	h=Date:From:To:Cc:Subject:From;
	b=LAZ19EJX3jVe4iNBZOLx1exvL99a1o7+QajsVT5qIY9/SMGH6kGc2FZ2iyo84kpV8
	 bdA5moQ9qijbBh98UcUpB+1Lg0Oyqd4QfAMCdymj+TISelzAMIkN0WXMtl3ZiNDnMg
	 5zDiAXEc8jH+e9LyO84vfAMlbV7DDnDAdxskBoEtbSdtTbo83VNvoadgu7bgreItWT
	 RvjE/srFBe9rS1E4YLpMiNmKVb35uPQWgJGkcQyh+YwZ40OZAWLxAQQJuh4UDVyLvq
	 bufL4KctP0SD2+Y3jnOJkFrV/iSn0cwmxrJjuWpcfJ5bHrXveY1S2MhJfRsUay6FtD
	 aUK7c9UM8vBoA==
Date: Fri, 12 Jan 2024 13:50:26 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Media Mailing List
 <linux-media@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.8-rc1] media updates
Message-ID: <20240112135026.41496764@coco.lan>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.8-2


For:

- v4l core: subdev frame interval now supports which field;
- v4l kapi: moves and renames the init_cfg pad op to init_state as an inter=
nal op.
- new sensor drivers: gc0308, gc2145, Avnet Alvium, ov64a40, tw9900;
- new camera driver: STM32 DCMIPP;
- s5p-mfc has gained MFC v12 support;
- new ISP driver added to staging: Starfive
- new stateful encoder/decoded: Wave5 codec It is found on the J721S2 SoC, =
JH7100 SoC, ssd202d SoC. Etc.
- fwnode gained support for MIPI "DisCo for Imaging" (https://www.mipi.org/=
specifications/mipi-disco-imaging)
- as usual, lots of cleanups, fixups and driver improvements.

Thanks,
Mauro

---

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.8-2

for you to fetch changes up to 60a031b64984ad4a219a13b0fe912746b586bb9b:

  media: i2c: thp7312: select CONFIG_FW_LOADER (2024-01-11 18:43:04 +0100)

----------------------------------------------------------------
media updates for v6.8-rc1

----------------------------------------------------------------
Aakarsh Jain (10):
      dt-bindings: media: s5p-mfc: Add mfcv12 variant
      media: s5p-mfc: Rename IS_MFCV10 macro
      media: s5p-mfc: Add initial support for MFCv12
      media: s5p-mfc: Add YV12 and I420 multiplanar format support
      media: s5p-mfc: Add support for rate controls in MFCv12
      media: s5p-mfc: Add support for UHD encoding.
      media: s5p-mfc: Add support for DMABUF for encoder
      media: s5p-mfc: Set context for valid case before calling try_run
      media: s5p-mfc: Load firmware for each run in MFCv12.
      media: s5p-mfc: DPB Count Independent of VIDIOC_REQBUF

Alain Volmat (15):
      dt-bindings: vendor-prefixes: Add prefix for GalaxyCore Inc.
      dt-bindings: media: i2c: add galaxycore,gc2145 dt-bindings
      media: i2c: gc2145: Galaxy Core GC2145 sensor support
      media: i2c: st-mipid02: correct format propagation
      media: i2c: st-mipid02: add usage of v4l2_get_link_freq
      media: i2c: st-mipid02: don't keep track of streaming status
      media: i2c: st-mipid02: use cci_* helpers for register access.
      media: i2c: st-mipid02: use active state to store pad formats
      media: i2c: st-mipid02: use mipi-csi macro for data-type
      media: i2c: st-mipid02: removal of unused link_frequency variable
      media: i2c: st-mipid02: add Y8 format support
      media: i2c: st-vgxy61: Add V4L2_SUBDEV_FL_HAS_EVENTS and subscribe ho=
oks
      media: i2c: st-vgxy61: add v4l2_fwnode ctrls parse and addition
      dt-bindings: media: add bindings for stm32 dcmipp
      media: MAINTAINERS: add entry for STM32 DCMIPP driver

Alexander Stein (4):
      media: amphion: Fix VPU core alias name
      media: nxp: imx8-isi-debug: Add missing 36-Bit DMA registers to debug=
fs output
      media: v4l2-cci: Add support for little-endian encoded registers
      media: i2c: imx290: Properly encode registers as little-endian

Andr=C3=A9 Apitzsch (4):
      media: i2c: imx214: Explain some magic numbers
      media: i2c: imx214: Move controls init to separate function
      media: i2c: imx214: Read orientation and rotation from system firmware
      media: i2c: imx214: Add sensor's pixel matrix size

AngeloGioacchino Del Regno (2):
      media: dt-bindings: mediatek: Add phandle to mediatek,scp on MDP3 RDMA
      media: platform: mtk-mdp3: Use devicetree phandle to retrieve SCP

Arnd Bergmann (2):
      media: i2c: mt9m114: use fsleep() in place of udelay()
      media: i2c: thp7312: select CONFIG_FW_LOADER

Benjamin Gaignard (51):
      media: videobuf2: Rename offset parameter
      media: videobuf2: Rework offset 'cookie' encoding pattern
      media: videobuf2: Stop spamming kernel log with all queue counter
      media: videobuf2: Use vb2_buffer instead of index
      media: videobuf2: Access vb2_queue bufs array through helper functions
      media: videobuf2: Remove duplicated index vs q->num_buffers check
      media: videobuf2: Add helper to get queue number of buffers
      media: videobuf2: Use vb2_get_num_buffers() helper
      media: amphion: Use vb2_get_buffer() instead of directly access to bu=
ffers array
      media: amphion: Stop direct calls to queue num_buffers field
      media: mediatek: jpeg: Use vb2_get_buffer() instead of directly acces=
s to buffers array
      media: mediatek: vdec: Remove useless loop
      media: mediatek: vcodec: Stop direct calls to queue num_buffers field
      media: sti: hva: Remove useless check
      media: visl: Use vb2_get_buffer() instead of directly access to buffe=
rs array
      media: atomisp: Use vb2_get_buffer() instead of directly access to bu=
ffers array
      media: atomisp: Stop direct calls to queue num_buffers field
      media: dvb-core: Use vb2_get_buffer() instead of directly access to b=
uffers array
      media: dvb-core: Do not initialize twice queue num_buffer field
      media: dvb-frontends: rtl2832: Stop direct calls to queue num_buffers=
 field
      media: pci: dt3155: Remove useless check
      media: pci: tw686x: Stop direct calls to queue num_buffers field
      media: pci: cx18: Stop direct calls to queue num_buffers field
      media: pci: netup_unidvb: Stop direct calls to queue num_buffers field
      media: pci: tw68: Stop direct calls to queue num_buffers field
      media: i2c: video-i2c: Stop direct calls to queue num_buffers field
      media: coda: Stop direct calls to queue num_buffers field
      media: nxp: Stop direct calls to queue num_buffers field
      media: verisilicon: Stop direct calls to queue num_buffers field
      media: test-drivers: Stop direct calls to queue num_buffers field
      media: imx: Stop direct calls to queue num_buffers field
      media: meson: vdec: Stop direct calls to queue num_buffers field
      media: touchscreen: sur40: Stop direct calls to queue num_buffers fie=
ld
      media: sample: v4l: Stop direct calls to queue num_buffers field
      media: cedrus: Stop direct calls to queue num_buffers field
      media: nuvoton: Stop direct calls to queue num_buffers field
      media: renesas: Stop direct calls to queue num_buffers field
      media: ti: Stop direct calls to queue num_buffers field
      media: usb: airspy: Stop direct calls to queue num_buffers field
      media: usb: cx231xx: Stop direct calls to queue num_buffers field
      media: usb: hackrf: Stop direct calls to queue num_buffers field
      media: usb: usbtv: Stop direct calls to queue num_buffers field
      media: media videobuf2: Be more flexible on the number of queue store=
d buffers
      media: core: Report the maximum possible number of buffers for the qu=
eue
      media: test-drivers: vivid: Increase max supported buffers for captur=
e queues
      media: test-drivers: vicodec: Increase max supported capture queue bu=
ffers
      media: verisilicon: Refactor postprocessor to store more buffers
      media: verisilicon: Store chroma and motion vectors offset
      media: verisilicon: g2: Use common helpers to compute chroma and mv o=
ffsets
      media: verisilicon: vp9: Allow to change resolution while streaming
      media: videobuf2: core: Rename min_buffers_needed field in vb2_queue

Bingbu Cao (4):
      media: imx355: Enable runtime PM before registering async sub-device
      media: ov01a10: Enable runtime PM before registering async sub-device
      media: ov13b10: Enable runtime PM before registering async sub-device
      media: ov9734: Enable runtime PM before registering async sub-device

Bryan O'Donoghue (6):
      media: qcom: camss: Flag which VFEs require a power-domain
      media: qcom: camss: Convert to per-VFE pointer for power-domain linka=
ges
      media: qcom: camss: Use common VFE pm_domain_on/pm_domain_off where a=
pplicable
      media: qcom: camss: Move VFE power-domain specifics into vfe.c
      media: qcom: camss: Add support for named power-domains
      media: qcom: camss: Add sm8250 named power-domain support

Christophe JAILLET (2):
      media: vde: Use struct_size()
      media: dvb-frontends: m88ds3103: Fix a memory leak in an error handli=
ng path of m88ds3103_probe()

Colin Ian King (1):
      media: chips-media: wave5: Fix spelling mistake "bufferur" -> "buffer"

Dan Carpenter (4):
      media: qcom: camss: clean up a check
      media: staging: starfive: camss: fix off by one in isp_enum_mbus_code=
()
      media: chips-media: wave5: Remove duplicate check
      media: dvbdev: drop refcount on error path in dvb_device_open()

Deborah Brouwer (2):
      media: v4l2-mem2mem.h: fix typo in comment
      media: wave5: add OF and V4L_MEM2MEM_DRIVERS dependencies

Detlev Casanova (2):
      media: visl: Add AV1 support
      doc: media: visl: Add AV1 support

Geert Uytterhoeven (2):
      media: chips-media: wave5: VIDEO_WAVE_VPU should depend on ARCH_K3
      staging: media: VIDEO_STARFIVE_CAMSS should depend on ARCH_STARFIVE

Ghanshyam Agrawal (1):
      media: stk1160: Fixed high volume of stk1160_dbg messages

Hans Verkuil (10):
      media: cec: core: count low-drive, error and arb-lost conditions
      media: core: v4l2-ioctl: check if ioctl is known to avoid NULL name
      media: drop CONFIG_MEDIA_CONTROLLER_REQUEST_API
      media: videodev2.h: add missing __user to p_h264_pps
      media: videodev.h: add missing p_hdr10_* pointers
      media: ivtv: don't call s_stream(0) if not streaming
      Merge tag 'v6.7-rc4' into media_stage
      media: bttv: start_streaming should return a proper error code
      media: bttv: add back vbi hack
      media: videobuf2: request more buffers for vb2_read

Hans de Goede (9):
      media: ov2740: Add support for reset GPIO
      media: ov2740: Add support for external clock
      media: ov2740: Move fwnode_graph_get_next_endpoint() call up
      media: ov2740: Improve ov2740_check_hwcfg() error reporting
      media: ov2740: Fix hts value
      media: ov2740: Check hwcfg after allocating the ov2740 struct
      media: ov2740: Add support for 180 MHz link frequency
      media: ov2740: Add a sleep after resetting the sensor
      media: ipu-bridge: Change ov2740 link-frequency to 180 MHz

Heiner Kallweit (1):
      media: exynos4-is: fimc-is-i2c: remove I2C_CLASS_SPD support

Hugues Fruchet (1):
      media: stm32-dcmipp: STM32 DCMIPP camera interface driver

Jack Zhu (9):
      media: dt-bindings: Add JH7110 Camera Subsystem
      media: admin-guide: Add starfive_camss.rst for Starfive Camera Subsys=
tem
      media: staging: media: starfive: camss: Add core driver
      media: staging: media: starfive: camss: Add video driver
      media: staging: media: starfive: camss: Add ISP driver
      media: staging: media: starfive: camss: Add capture driver
      media: staging: media: starfive: camss: Add interrupt handling
      media: staging: media: starfive: camss: Register devices
      media: staging: media: starfive: camss: Add TODO file

Jacopo Mondi (3):
      media: v4l2-common: Add 10bpp RGB formats info
      media: dt-bindings: Add OmniVision OV64A40
      media: i2c: Add driver for OmniVision OV64A40

Ken Lin (1):
      media: platform: cros-ec: Add Dexi to the match table

Kieran Bingham (6):
      media: dt-bindings: media: imx335: Add supply bindings
      media: i2c: imx335: Fix logging line endings
      media: i2c: imx335: Improve configuration error reporting
      media: i2c: imx335: Enable regulator supplies
      media: i2c: imx335: Implement get selection API
      media: i2c: imx335: Fix hblank min/max values

Krzysztof Kozlowski (1):
      media: dt-bindings: ov8856: decouple lanes and link frequency from dr=
iver

Laurent Pinchart (31):
      media: atmel-isi: Use accessors for pad config 'try_*' fields
      media: microchip-isc: Use accessors for pad config 'try_*' fields
      media: atmel-isc: Use accessors for pad config 'try_*' fields
      media: atomisp: Use accessors for pad config 'try_*' fields
      media: tegra-video: Use accessors for pad config 'try_*' fields
      media: i2c: Use accessors for pad config 'try_*' fields
      media: v4l2-subdev: Rename pad config 'try_*' fields
      media: v4l2-subdev: Drop outdated comment for v4l2_subdev_pad_config
      media: ipu3-cio2: Drop comment blocks for subdev op handlers
      media: xilinx: csi2rxss: Drop comment blocks for subdev op handlers
      media: v4l2-subdev: Fix references to pad config
      media: qcom: camss: Fix references to pad config
      media: ti: omap3isp: Fix references to pad config
      media: ti: omap4iss: Fix references to pad config
      media: i2c: Fix references to pad config
      media: renesas: vsp1: Fix references to pad config
      media: uapi: Add controls for the THP7312 ISP
      media: v4l2-subdev: Rename .init_cfg() operation to .init_state()
      media: microchip-isc: Remove dead code in pipeline validation
      media: v4l2-subdev: Fix indentation in v4l2-subdev.h
      media: uvcvideo: Pick first best alternate setting insteed of last
      media: imx: imx7-media-csi: Include headers explicitly
      media: rkisp1: resizer: Stop manual allocation of v4l2_subdev_state
      media: atmel-isi: Fix crash due to missing subdev in state
      media: v4l2-subdev: Turn .[gs]_frame_interval into pad operations
      media: v4l2-subdev: Add which field to struct v4l2_subdev_frame_inter=
val
      media: v4l2-subdev: Store frame interval in subdev state
      media: docs: uAPI: Clarify error documentation for invalid 'which' va=
lue
      media: docs: uAPI: Expand error documentation for invalid 'which' val=
ue
      media: docs: uAPI: Fix documentation of 'which' field for routing ioc=
tls
      media: i2c: thp7312: Store frame interval in subdev state

Luca Weiss (1):
      media: venus: core: Set up secure memory ranges for SC7280

Lukas Bulwahn (2):
      media: exynos-gsc: remove unused improper CONFIG definition
      media: MAINTAINERS: Correct file entry in WAVE5 VPU CODEC DRIVER

Marvin Lin (1):
      media: nuvoton: npcm-video: Fix sleeping in atomic context

Matti Lehtim=C3=A4ki (2):
      media: qcom: camss: Flag VFE-lites to support more VFEs
      media: qcom: camss: Flag CSID-lites to support more CSIDs

Mattijs Korpershoek (1):
      media: chips-media: wave5: Fix panic on decoding DECODED_IDX_FLAG_SKIP

Mauro Carvalho Chehab (1):
      Merge tag 'v6.7-rc2' into media_stage

Mehdi Djait (4):
      media: dt-bindings: media: rkisp1: Fix the port description for the p=
arallel interface
      dt-bindings: vendor-prefixes: Add techwell vendor prefix
      media: dt-bindings: media: i2c: Add bindings for TW9900
      media: i2c: Introduce a driver for the Techwell TW9900 decoder

Michael Grzeschik (1):
      media: videobuf2-dma-sg: fix vmap callback

Michael Tretter (13):
      media: rockchip: rga: fix swizzling for RGB formats
      media: rockchip: rga: extract helper to fill descriptors
      media: rockchip: rga: allocate DMA descriptors per buffer
      media: rockchip: rga: split src and dst buffer setup
      media: rockchip: rga: pre-calculate plane offsets
      media: rockchip: rga: set dma mask to 32 bits
      media: rockchip: rga: use clamp() to clamp size to limits
      media: rockchip: rga: use pixelformat to find format
      media: rockchip: rga: add local variable for pix_format
      media: rockchip: rga: use macros for testing buffer type
      media: rockchip: rga: switch to multi-planar API
      media: rockchip: rga: rework buffer handling for multi-planar formats
      media: rockchip: rga: add NV12M support

Ming Qian (1):
      media: amphion: remove mutext lock in condition of wait_event

Nas Chung (2):
      media: chips-media: wave5: Add vpuapi layer
      media: chips-media: wave5: Add the v4l2 layer

Niklas S=C3=B6derlund (1):
      MAINTAINERS: Add missing bindings for max96712

Paul Elder (5):
      dt-bindings: media: Add bindings for THine THP7312 ISP
      media: i2c: Add driver for THine THP7312
      media: rkisp1: regs: Consolidate MI interrupt wrap fields
      media: rkisp1: debug: Add register dump for IS
      media: rkisp1: debug: Count completed frame interrupts

Paul Kocialkowski (6):
      media: v4l2-dev: Check that g/s_selection are valid before selecting =
crop
      media: cedrus: Update TODO with future rework plans
      media: vicodec: Disable (TRY_)DECODER_CMD for the stateless case
      media: visl: Hook the (TRY_)DECODER_CMD stateless ioctls
      media: verisilicon: Hook the (TRY_)DECODER_CMD stateless ioctls
      media: rkvdec: Hook the (TRY_)DECODER_CMD stateless ioctls

Randy Dunlap (1):
      media: chips-media: wave5: Requires GENERIC_ALLOCATOR

Ricardo B. Marliere (1):
      media: pvrusb2: fix use after free on context disconnection

Ricardo Ribalda (2):
      media: uvcvideo: Fix power line control for a Chicony camera
      media: uvcvideo: Fix power line control for SunplusIT camera

Rob Herring (2):
      media: ir-hix5hd2: Use device_get_match_data()
      media: stm32-dcmi: Drop unnecessary of_match_device() call

Robert Beckett (2):
      dt-bindings: media: wave5: add yaml devicetree bindings
      media: chips-media: wave5: Add wave5 driver to maintainers file

Sakari Ailus (37):
      media: ccs: Ensure control handlers have been set up after probe
      media: ivsc: csi: Don't parse remote endpoints
      media: ivsc: csi: Clean up V4L2 async notifier on error
      media: ivsc: csi: Clean up notifier set-up
      media: ivsc: csi: Clean up parsing firmware and setting up async noti=
fier
      media: ivsc: csi: Don't mask v4l2_fwnode_endpoint_parse return value
      media: ivsc: csi: Check number of lanes on source, too
      media: v4l: subdev: Store the sub-device in the sub-device state
      media: v4l: subdev: Also return pads array information on stream func=
tions
      media: v4l: subdev: Rename sub-device state information access functi=
ons
      media: v4l: subdev: v4l2_subdev_state_get_format always returns forma=
t now
      media: v4l: subdev: Make stream argument optional in state access fun=
ctions
      media: v4l: subdev: Always compile sub-device state access functions
      media: v4l: subdev: Switch to stream-aware state functions
      media: v4l: subdev: Remove stream-unaware sub-device state access
      media: v4l: subdev: Return NULL from pad access functions on error
      device property: Add fwnode_name_eq()
      media: v4l: fwnode: Parse MIPI DisCo for Imaging properties
      media: ccs: Print ireal and float limits converted to integers
      media: imx319: Enable runtime PM before registering async sub-device
      media: Documentation: Initialisation finishes before subdev registrat=
ion
      media: v4l: cci: Include linux/bits.h
      media: v4l: cci: Add driver-private bit definitions
      media: v4l: cci: Add macros to obtain register width and address
      media: ccs: Generate V4L2 CCI compliant register definitions
      media: ccs: Better separate CCS static data access
      media: ccs: Use V4L2 CCI for accessing sensor registers
      media: ccs: Select V4L2_CCI_I2C
      media: saa6752hs: Don't set format in sub-device state
      media: adv7183: Don't set format in sub-device state
      media: mt9t112: Don't set format in sub-device state
      media: rj54n1cb0c: Don't set format in sub-device state
      media: tw9910: Don't set format in sub-device state
      media: ov9640: Don't set format in sub-device state
      media: v4l: Safely to call v4l2_subdev_cleanup on an uninitialised su=
bdev
      media: Documentation: BT.601 is not a bus
      media: Documentation: LP-11 and LP-111 are states, not modes

Sebastian Fricke (3):
      media: v4l2: Add ignore_streaming flag
      media: v4l2: Allow M2M job queuing w/o streaming CAP queue
      media: platform: chips-media: Move Coda to separate folder

Sebastian Reichel (5):
      media: v4l: async: Fix duplicated list deletion
      media: v4l: async: Drop useless list move operation
      media: dt-bindings: gc0308: add binding
      media: MAINTAINERS: Add GalaxyCore in camera sensor section
      media: i2c: gc0308: new driver

Su Hui (2):
      media: platform: exynos4-is: return callee's error code rather than -=
ENXIO
      media: ddbridge: fix an error code problem in ddb_probe

Tomi Valkeinen (9):
      media: imx-mipi-csis: Fix clock handling in remove()
      media: imx-mipi-csis: Drop extra clock enable at probe()
      media: rkisp1: Fix media device memory leak
      media: rkisp1: Fix memory leaks in rkisp1_isp_unregister()
      media: rkisp1: Drop IRQF_SHARED
      media: rkisp1: Fix IRQ handler return values
      media: rkisp1: Store IRQ lines
      media: rkisp1: Fix IRQ disable race issue
      media: v4l: subdev: Move out subdev state lock macros outside CONFIG_=
MEDIA_CONTROLLER

Tommaso Merciai (3):
      dt-bindings: vendor-prefixes: Add prefix alliedvision
      media: dt-bindings: alvium: add document YAML binding
      media: i2c: Add support for alvium camera

Umang Jain (1):
      media: i2c: imx335: Support 2592x1940 10-bit mode

Uwe Kleine-K=C3=B6nig (4):
      media: meson-ir-tx: Convert to use devm_rc_register_device()
      media: meson-ir-tx: Simplify and improve using dev_err_probe()
      media: meson-ir-tx: Drop usage of platform_driver_probe()
      media: staging: media: tegra-video: Convert to platform remove callba=
ck returning void

Vincent Knecht (3):
      media: i2c: ak7375: Prepare for supporting another chip
      media: dt-bindings: ak7375: Add ak7345 support
      media: i2c: ak7375: Add support for ak7345

Yunfei Dong (7):
      media: mediatek: vcodec: Get the chip name for each platform
      media: mediatek: vcodec: Set the supported h264 level for each platfo=
rm
      media: mediatek: vcodec: Set the supported h265 level for each platfo=
rm
      media: mediatek: vcodec: Set the supported h264 profile for each plat=
form
      media: mediatek: vcodec: Set the supported h265 profile for each plat=
form
      media: mediatek: vcodec: Set the supported vp9 level for each platform
      media: mediatek: vcodec: Set the supported vp9 profile for each platf=
orm

Zheng Wang (3):
      media: mtk-jpeg: Remove cancel worker in mtk_jpeg_remove to avoid the=
 crash of multi-core JPEG devices
      media: mtk-jpeg: Fix use after free bug due to error path handling in=
 mtk_jpeg_dec_device_run
      media: mtk-jpeg: Fix timeout schedule error in mtk_jpegdec_worker.

Zhipeng Lu (1):
      media: cx231xx: fix a memleak in cx231xx_init_isoc

 Documentation/admin-guide/media/starfive_camss.rst |   72 +
 .../admin-guide/media/starfive_camss_graph.dot     |   12 +
 Documentation/admin-guide/media/v4l-drivers.rst    |    1 +
 Documentation/admin-guide/media/visl.rst           |    2 +
 .../devicetree/bindings/media/cnm,wave521c.yaml    |   61 +
 .../media/i2c/alliedvision,alvium-csi2.yaml        |   81 +
 .../bindings/media/i2c/asahi-kasei,ak7375.yaml     |    4 +-
 .../bindings/media/i2c/galaxycore,gc0308.yaml      |  108 +
 .../bindings/media/i2c/galaxycore,gc2145.yaml      |  113 +
 .../devicetree/bindings/media/i2c/ov8856.yaml      |   24 +-
 .../bindings/media/i2c/ovti,ov64a40.yaml           |  103 +
 .../devicetree/bindings/media/i2c/sony,imx335.yaml |   13 +
 .../bindings/media/i2c/techwell,tw9900.yaml        |  137 +
 .../bindings/media/i2c/thine,thp7312.yaml          |  224 ++
 .../bindings/media/mediatek,mdp3-rdma.yaml         |    8 +
 .../devicetree/bindings/media/rockchip-isp1.yaml   |   11 +-
 .../devicetree/bindings/media/samsung,s5p-mfc.yaml |   18 +
 .../devicetree/bindings/media/st,stm32-dcmipp.yaml |   89 +
 .../bindings/media/starfive,jh7110-camss.yaml      |  180 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    6 +
 Documentation/driver-api/media/camera-sensor.rst   |    7 +-
 .../driver-api/media/drivers/ccs/mk-ccs-regs       |  104 +-
 Documentation/driver-api/media/tx-rx.rst           |   25 +-
 Documentation/driver-api/media/v4l2-subdev.rst     |   11 +-
 .../userspace-api/media/drivers/index.rst          |    1 +
 .../userspace-api/media/drivers/thp7312.rst        |   39 +
 .../userspace-api/media/v4l/vidioc-create-bufs.rst |    8 +-
 .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst |    8 +
 .../userspace-api/media/v4l/vidioc-reqbufs.rst     |    1 +
 .../v4l/vidioc-subdev-enum-frame-interval.rst      |    9 +-
 .../media/v4l/vidioc-subdev-enum-frame-size.rst    |    7 +-
 .../media/v4l/vidioc-subdev-enum-mbus-code.rst     |    7 +-
 .../media/v4l/vidioc-subdev-g-client-cap.rst       |    5 +
 .../media/v4l/vidioc-subdev-g-crop.rst             |    7 +-
 .../media/v4l/vidioc-subdev-g-fmt.rst              |    5 +-
 .../media/v4l/vidioc-subdev-g-frame-interval.rst   |   20 +-
 .../media/v4l/vidioc-subdev-g-routing.rst          |    7 +-
 .../media/v4l/vidioc-subdev-g-selection.rst        |    7 +-
 MAINTAINERS                                        |   75 +-
 drivers/base/property.c                            |   28 +
 drivers/input/touchscreen/atmel_mxt_ts.c           |    2 +-
 drivers/input/touchscreen/sur40.c                  |    7 +-
 drivers/media/cec/core/cec-adap.c                  |   54 +-
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c   |    2 +
 drivers/media/common/saa7146/saa7146_fops.c        |    2 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |  518 +--
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  |   10 +-
 drivers/media/common/videobuf2/videobuf2-v4l2.c    |   87 +-
 drivers/media/dvb-core/dvb_vb2.c                   |   21 +-
 drivers/media/dvb-core/dvbdev.c                    |    2 +
 drivers/media/dvb-frontends/m88ds3103.c            |    7 +-
 drivers/media/dvb-frontends/rtl2832_sdr.c          |    5 +-
 drivers/media/i2c/Kconfig                          |   73 +
 drivers/media/i2c/Makefile                         |    6 +
 drivers/media/i2c/adv7180.c                        |   28 +-
 drivers/media/i2c/adv7183.c                        |    2 -
 drivers/media/i2c/adv748x/adv748x-afe.c            |    6 +-
 drivers/media/i2c/adv748x/adv748x-csi2.c           |    2 +-
 drivers/media/i2c/adv748x/adv748x-hdmi.c           |    6 +-
 drivers/media/i2c/adv7511-v4l2.c                   |    4 +-
 drivers/media/i2c/adv7604.c                        |    4 +-
 drivers/media/i2c/adv7842.c                        |    4 +-
 drivers/media/i2c/ak7375.c                         |  132 +-
 drivers/media/i2c/alvium-csi2.c                    | 2558 ++++++++++++++
 drivers/media/i2c/alvium-csi2.h                    |  475 +++
 drivers/media/i2c/ar0521.c                         |    5 +-
 drivers/media/i2c/ccs/Kconfig                      |    1 +
 drivers/media/i2c/ccs/ccs-core.c                   |  134 +-
 drivers/media/i2c/ccs/ccs-reg-access.c             |  213 +-
 drivers/media/i2c/ccs/ccs-regs.h                   |  906 ++---
 drivers/media/i2c/ccs/ccs.h                        |    3 +
 drivers/media/i2c/ccs/smiapp-reg-defs.h            |  951 ++---
 drivers/media/i2c/ds90ub913.c                      |   13 +-
 drivers/media/i2c/ds90ub953.c                      |   13 +-
 drivers/media/i2c/ds90ub960.c                      |   23 +-
 drivers/media/i2c/et8ek8/et8ek8_driver.c           |   23 +-
 drivers/media/i2c/gc0308.c                         | 1451 ++++++++
 drivers/media/i2c/gc2145.c                         | 1450 ++++++++
 drivers/media/i2c/hi556.c                          |   13 +-
 drivers/media/i2c/hi846.c                          |   21 +-
 drivers/media/i2c/hi847.c                          |    9 +-
 drivers/media/i2c/imx208.c                         |    9 +-
 drivers/media/i2c/imx214.c                         |  207 +-
 drivers/media/i2c/imx219.c                         |   21 +-
 drivers/media/i2c/imx258.c                         |    9 +-
 drivers/media/i2c/imx274.c                         |   74 +-
 drivers/media/i2c/imx290.c                         |   60 +-
 drivers/media/i2c/imx296.c                         |   28 +-
 drivers/media/i2c/imx319.c                         |   19 +-
 drivers/media/i2c/imx334.c                         |   16 +-
 drivers/media/i2c/imx335.c                         |  227 +-
 drivers/media/i2c/imx355.c                         |   19 +-
 drivers/media/i2c/imx412.c                         |   16 +-
 drivers/media/i2c/imx415.c                         |   16 +-
 drivers/media/i2c/isl7998x.c                       |    6 +-
 drivers/media/i2c/max9286.c                        |   32 +-
 drivers/media/i2c/mt9m001.c                        |   16 +-
 drivers/media/i2c/mt9m111.c                        |   44 +-
 drivers/media/i2c/mt9m114.c                        |  104 +-
 drivers/media/i2c/mt9p031.c                        |   14 +-
 drivers/media/i2c/mt9t112.c                        |    1 -
 drivers/media/i2c/mt9v011.c                        |   34 +-
 drivers/media/i2c/mt9v032.c                        |   10 +-
 drivers/media/i2c/mt9v111.c                        |   44 +-
 drivers/media/i2c/og01a1b.c                        |   10 +-
 drivers/media/i2c/ov01a10.c                        |   30 +-
 drivers/media/i2c/ov02a10.c                        |   16 +-
 drivers/media/i2c/ov08d10.c                        |    9 +-
 drivers/media/i2c/ov08x40.c                        |    7 +-
 drivers/media/i2c/ov13858.c                        |   10 +-
 drivers/media/i2c/ov13b10.c                        |   24 +-
 drivers/media/i2c/ov2640.c                         |   16 +-
 drivers/media/i2c/ov2659.c                         |    6 +-
 drivers/media/i2c/ov2680.c                         |   34 +-
 drivers/media/i2c/ov2685.c                         |    4 +-
 drivers/media/i2c/ov2740.c                         |  396 ++-
 drivers/media/i2c/ov4689.c                         |    2 +-
 drivers/media/i2c/ov5640.c                         |   49 +-
 drivers/media/i2c/ov5645.c                         |   16 +-
 drivers/media/i2c/ov5647.c                         |   12 +-
 drivers/media/i2c/ov5648.c                         |   72 +-
 drivers/media/i2c/ov5670.c                         |   23 +-
 drivers/media/i2c/ov5675.c                         |    9 +-
 drivers/media/i2c/ov5693.c                         |   18 +-
 drivers/media/i2c/ov5695.c                         |    8 +-
 drivers/media/i2c/ov64a40.c                        | 3690 ++++++++++++++++=
++++
 drivers/media/i2c/ov6650.c                         |   64 +-
 drivers/media/i2c/ov7251.c                         |   36 +-
 drivers/media/i2c/ov7670.c                         |   37 +-
 drivers/media/i2c/ov772x.c                         |   30 +-
 drivers/media/i2c/ov7740.c                         |   47 +-
 drivers/media/i2c/ov8856.c                         |    9 +-
 drivers/media/i2c/ov8858.c                         |   16 +-
 drivers/media/i2c/ov8865.c                         |   66 +-
 drivers/media/i2c/ov9282.c                         |   18 +-
 drivers/media/i2c/ov9640.c                         |    2 -
 drivers/media/i2c/ov9650.c                         |   35 +-
 drivers/media/i2c/ov9734.c                         |   28 +-
 drivers/media/i2c/rj54n1cb0c.c                     |    4 +-
 drivers/media/i2c/s5c73m3/s5c73m3-core.c           |   65 +-
 drivers/media/i2c/s5k5baf.c                        |   69 +-
 drivers/media/i2c/s5k6a3.c                         |    8 +-
 drivers/media/i2c/saa6752hs.c                      |    4 +-
 drivers/media/i2c/st-mipid02.c                     |  481 +--
 drivers/media/i2c/st-vgxy61.c                      |   34 +-
 drivers/media/i2c/tc358746.c                       |   22 +-
 drivers/media/i2c/tda1997x.c                       |   16 +-
 drivers/media/i2c/thp7312.c                        | 2256 ++++++++++++
 drivers/media/i2c/tvp514x.c                        |   41 +-
 drivers/media/i2c/tvp5150.c                        |    8 +-
 drivers/media/i2c/tvp7002.c                        |    6 +-
 drivers/media/i2c/tw9900.c                         |  781 +++++
 drivers/media/i2c/tw9910.c                         |    2 -
 drivers/media/i2c/video-i2c.c                      |    7 +-
 drivers/media/mc/Kconfig                           |    7 -
 drivers/media/mc/mc-device.c                       |    4 -
 drivers/media/pci/bt8xx/bttv-driver.c              |   29 +-
 drivers/media/pci/bt8xx/bttv-vbi.c                 |    8 +-
 drivers/media/pci/cobalt/cobalt-v4l2.c             |    2 +-
 drivers/media/pci/cx18/cx18-streams.c              |    7 +-
 drivers/media/pci/cx23885/cx23885-417.c            |    2 +-
 drivers/media/pci/cx23885/cx23885-dvb.c            |    2 +-
 drivers/media/pci/cx23885/cx23885-video.c          |    4 +-
 drivers/media/pci/cx25821/cx25821-video.c          |    2 +-
 drivers/media/pci/cx88/cx88-blackbird.c            |    2 +-
 drivers/media/pci/cx88/cx88-dvb.c                  |    2 +-
 drivers/media/pci/cx88/cx88-video.c                |    4 +-
 drivers/media/pci/ddbridge/ddbridge-main.c         |    2 +-
 drivers/media/pci/dt3155/dt3155.c                  |    4 +-
 drivers/media/pci/intel/ipu-bridge.c               |    2 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.c           |   26 +-
 drivers/media/pci/intel/ivsc/mei_csi.c             |   83 +-
 drivers/media/pci/ivtv/ivtv-driver.h               |    1 +
 drivers/media/pci/ivtv/ivtv-streams.c              |    4 +-
 drivers/media/pci/mgb4/mgb4_vin.c                  |    2 +-
 drivers/media/pci/mgb4/mgb4_vout.c                 |    2 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |    5 +-
 drivers/media/pci/tw5864/tw5864-video.c            |    2 +-
 drivers/media/pci/tw68/tw68-video.c                |    7 +-
 drivers/media/pci/tw686x/tw686x-video.c            |    7 +-
 drivers/media/pci/zoran/zoran_driver.c             |    6 +-
 drivers/media/platform/amphion/vpu.h               |    3 +-
 drivers/media/platform/amphion/vpu_cmds.c          |   28 +-
 drivers/media/platform/amphion/vpu_core.c          |    2 +-
 drivers/media/platform/amphion/vpu_dbg.c           |   30 +-
 drivers/media/platform/amphion/vpu_v4l2.c          |    9 +-
 drivers/media/platform/aspeed/aspeed-video.c       |    2 +-
 drivers/media/platform/atmel/atmel-isi.c           |   15 +-
 drivers/media/platform/cadence/cdns-csi2rx.c       |   14 +-
 drivers/media/platform/cadence/cdns-csi2tx.c       |    3 +-
 drivers/media/platform/chips-media/Kconfig         |   18 +-
 drivers/media/platform/chips-media/Makefile        |    6 +-
 drivers/media/platform/chips-media/coda/Kconfig    |   18 +
 drivers/media/platform/chips-media/coda/Makefile   |    6 +
 .../platform/chips-media/{ =3D> coda}/coda-bit.c     |    0
 .../platform/chips-media/{ =3D> coda}/coda-common.c  |    4 +-
 .../platform/chips-media/{ =3D> coda}/coda-gdi.c     |    0
 .../platform/chips-media/{ =3D> coda}/coda-h264.c    |    0
 .../platform/chips-media/{ =3D> coda}/coda-jpeg.c    |    0
 .../platform/chips-media/{ =3D> coda}/coda-mpeg2.c   |    0
 .../platform/chips-media/{ =3D> coda}/coda-mpeg4.c   |    0
 .../media/platform/chips-media/{ =3D> coda}/coda.h   |    0
 .../platform/chips-media/{ =3D> coda}/coda_regs.h    |    0
 .../platform/chips-media/{ =3D> coda}/imx-vdoa.c     |    0
 .../platform/chips-media/{ =3D> coda}/imx-vdoa.h     |    0
 .../media/platform/chips-media/{ =3D> coda}/trace.h  |    2 +-
 drivers/media/platform/chips-media/wave5/Kconfig   |   15 +
 drivers/media/platform/chips-media/wave5/Makefile  |   10 +
 .../platform/chips-media/wave5/wave5-helper.c      |  213 ++
 .../platform/chips-media/wave5/wave5-helper.h      |   31 +
 .../media/platform/chips-media/wave5/wave5-hw.c    | 2551 ++++++++++++++
 .../platform/chips-media/wave5/wave5-regdefine.h   |  732 ++++
 .../media/platform/chips-media/wave5/wave5-vdi.c   |  205 ++
 .../media/platform/chips-media/wave5/wave5-vdi.h   |   35 +
 .../platform/chips-media/wave5/wave5-vpu-dec.c     | 1932 ++++++++++
 .../platform/chips-media/wave5/wave5-vpu-enc.c     | 1794 ++++++++++
 .../media/platform/chips-media/wave5/wave5-vpu.c   |  291 ++
 .../media/platform/chips-media/wave5/wave5-vpu.h   |   83 +
 .../platform/chips-media/wave5/wave5-vpuapi.c      |  960 +++++
 .../platform/chips-media/wave5/wave5-vpuapi.h      |  870 +++++
 .../platform/chips-media/wave5/wave5-vpuconfig.h   |   77 +
 .../platform/chips-media/wave5/wave5-vpuerror.h    |  292 ++
 drivers/media/platform/chips-media/wave5/wave5.h   |  114 +
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |   20 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |   16 +-
 drivers/media/platform/mediatek/vcodec/Kconfig     |    1 -
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c       |   24 +-
 .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c   |   26 +
 .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h   |   14 +
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c      |  168 +-
 .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c      |    9 +-
 .../mediatek/vcodec/encoder/mtk_vcodec_enc.c       |    2 +-
 .../media/platform/microchip/microchip-csi2dc.c    |   25 +-
 .../media/platform/microchip/microchip-isc-base.c  |   41 +-
 .../platform/microchip/microchip-isc-scaler.c      |   26 +-
 drivers/media/platform/nuvoton/npcm-video.c        |   34 +-
 drivers/media/platform/nvidia/tegra-vde/Kconfig    |    1 -
 drivers/media/platform/nvidia/tegra-vde/v4l2.c     |    2 +-
 drivers/media/platform/nxp/imx-mipi-csis.c         |   37 +-
 drivers/media/platform/nxp/imx7-media-csi.c        |   58 +-
 .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      |   20 +-
 .../media/platform/nxp/imx8-isi/imx8-isi-debug.c   |   27 +-
 .../media/platform/nxp/imx8-isi/imx8-isi-pipe.c    |   28 +-
 .../media/platform/nxp/imx8-isi/imx8-isi-video.c   |    4 +-
 drivers/media/platform/nxp/imx8mq-mipi-csi2.c      |   23 +-
 .../media/platform/qcom/camss/camss-csid-gen2.c    |   31 +-
 drivers/media/platform/qcom/camss/camss-csid.c     |   20 +-
 drivers/media/platform/qcom/camss/camss-csid.h     |    7 +
 drivers/media/platform/qcom/camss/camss-csiphy.c   |   15 +-
 drivers/media/platform/qcom/camss/camss-ispif.c    |   17 +-
 drivers/media/platform/qcom/camss/camss-vfe-170.c  |   36 -
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c  |    8 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c  |   36 -
 drivers/media/platform/qcom/camss/camss-vfe-4-8.c  |   31 -
 drivers/media/platform/qcom/camss/camss-vfe-480.c  |   69 +-
 drivers/media/platform/qcom/camss/camss-vfe.c      |  115 +-
 drivers/media/platform/qcom/camss/camss-vfe.h      |   26 +
 drivers/media/platform/qcom/camss/camss.c          |  122 +-
 drivers/media/platform/qcom/camss/camss.h          |   10 +-
 drivers/media/platform/qcom/venus/core.c           |    4 +
 drivers/media/platform/qcom/venus/vdec.c           |    4 +-
 drivers/media/platform/qcom/venus/venc.c           |    4 +-
 drivers/media/platform/renesas/rcar-isp.c          |    4 +-
 .../media/platform/renesas/rcar-vin/rcar-csi2.c    |    4 +-
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c |    2 +-
 drivers/media/platform/renesas/rcar_drif.c         |    5 +-
 drivers/media/platform/renesas/renesas-ceu.c       |    2 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  |   16 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-ip.c    |   16 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c |    2 +-
 drivers/media/platform/renesas/sh_vou.c            |    2 +-
 drivers/media/platform/renesas/vsp1/vsp1_brx.c     |   43 +-
 drivers/media/platform/renesas/vsp1/vsp1_clu.c     |    4 +-
 drivers/media/platform/renesas/vsp1/vsp1_entity.c  |  138 +-
 drivers/media/platform/renesas/vsp1/vsp1_entity.h  |   12 +-
 drivers/media/platform/renesas/vsp1/vsp1_hgo.c     |    4 +-
 drivers/media/platform/renesas/vsp1/vsp1_hgt.c     |    4 +-
 drivers/media/platform/renesas/vsp1/vsp1_histo.c   |   24 +-
 drivers/media/platform/renesas/vsp1/vsp1_hsit.c    |   12 +-
 drivers/media/platform/renesas/vsp1/vsp1_lif.c     |    3 +-
 drivers/media/platform/renesas/vsp1/vsp1_lut.c     |    1 -
 drivers/media/platform/renesas/vsp1/vsp1_rpf.c     |    8 +-
 drivers/media/platform/renesas/vsp1/vsp1_rwpf.c    |   41 +-
 drivers/media/platform/renesas/vsp1/vsp1_sru.c     |   37 +-
 drivers/media/platform/renesas/vsp1/vsp1_uds.c     |   40 +-
 drivers/media/platform/renesas/vsp1/vsp1_uif.c     |   25 +-
 drivers/media/platform/renesas/vsp1/vsp1_video.c   |    4 +-
 drivers/media/platform/renesas/vsp1/vsp1_wpf.c     |   10 +-
 drivers/media/platform/rockchip/rga/rga-buf.c      |  162 +-
 drivers/media/platform/rockchip/rga/rga-hw.c       |  146 +-
 drivers/media/platform/rockchip/rga/rga.c          |  189 +-
 drivers/media/platform/rockchip/rga/rga.h          |   35 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c      |    2 +-
 .../media/platform/rockchip/rkisp1/rkisp1-common.h |   12 +-
 .../media/platform/rockchip/rkisp1/rkisp1-csi.c    |   40 +-
 .../media/platform/rockchip/rkisp1/rkisp1-debug.c  |    6 +
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |   41 +-
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  136 +-
 .../media/platform/rockchip/rkisp1/rkisp1-regs.h   |    9 +-
 .../platform/rockchip/rkisp1/rkisp1-resizer.c      |  101 +-
 .../media/platform/samsung/exynos-gsc/gsc-core.h   |    1 -
 .../platform/samsung/exynos4-is/fimc-capture.c     |   12 +-
 .../media/platform/samsung/exynos4-is/fimc-core.c  |    2 +-
 .../platform/samsung/exynos4-is/fimc-is-i2c.c      |    1 -
 .../media/platform/samsung/exynos4-is/fimc-isp.c   |   24 +-
 .../media/platform/samsung/exynos4-is/fimc-lite.c  |   16 +-
 .../media/platform/samsung/exynos4-is/mipi-csis.c  |    3 +-
 .../platform/samsung/s3c-camif/camif-capture.c     |    8 +-
 .../media/platform/samsung/s5p-mfc/regs-mfc-v12.h  |   52 +
 .../media/platform/samsung/s5p-mfc/regs-mfc-v7.h   |    1 +
 .../media/platform/samsung/s5p-mfc/regs-mfc-v8.h   |    3 +
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c   |   36 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h      |   33 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c  |   14 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_dec.c   |   60 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_enc.c   |  150 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_opr.h   |   14 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c      |   12 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c      |  299 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h      |    7 +-
 drivers/media/platform/st/sti/hva/hva-v4l2.c       |   13 +-
 drivers/media/platform/st/stm32/Kconfig            |   16 +
 drivers/media/platform/st/stm32/Makefile           |    1 +
 drivers/media/platform/st/stm32/stm32-dcmi.c       |   10 +-
 .../media/platform/st/stm32/stm32-dcmipp/Makefile  |    4 +
 .../st/stm32/stm32-dcmipp/dcmipp-bytecap.c         |  956 +++++
 .../st/stm32/stm32-dcmipp/dcmipp-byteproc.c        |  565 +++
 .../platform/st/stm32/stm32-dcmipp/dcmipp-common.c |  111 +
 .../platform/st/stm32/stm32-dcmipp/dcmipp-common.h |  217 ++
 .../platform/st/stm32/stm32-dcmipp/dcmipp-core.c   |  604 ++++
 .../st/stm32/stm32-dcmipp/dcmipp-parallel.c        |  440 +++
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c |    1 +
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h |    1 +
 drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c |    2 +-
 .../media/platform/sunxi/sun4i-csi/sun4i_v4l2.c    |   17 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi_bridge.c    |   18 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi_capture.c   |    2 +-
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c        |   18 +-
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c    |   18 +-
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c   |    4 +-
 .../platform/sunxi/sun8i-rotate/sun8i_rotate.c     |    4 +-
 drivers/media/platform/ti/am437x/am437x-vpfe.c     |    7 +-
 drivers/media/platform/ti/cal/cal-camerarx.c       |   28 +-
 drivers/media/platform/ti/cal/cal-video.c          |    9 +-
 drivers/media/platform/ti/davinci/vpif_capture.c   |    7 +-
 drivers/media/platform/ti/davinci/vpif_display.c   |    7 +-
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  |    2 +-
 drivers/media/platform/ti/omap/omap_vout.c         |    7 +-
 drivers/media/platform/ti/omap3isp/ispccdc.c       |   19 +-
 drivers/media/platform/ti/omap3isp/ispccp2.c       |   13 +-
 drivers/media/platform/ti/omap3isp/ispcsi2.c       |    9 +-
 drivers/media/platform/ti/omap3isp/isppreview.c    |   18 +-
 drivers/media/platform/ti/omap3isp/ispresizer.c    |   21 +-
 drivers/media/platform/verisilicon/Kconfig         |    1 -
 drivers/media/platform/verisilicon/hantro.h        |    9 +-
 drivers/media/platform/verisilicon/hantro_drv.c    |    6 +-
 drivers/media/platform/verisilicon/hantro_g2.c     |   14 +
 .../platform/verisilicon/hantro_g2_hevc_dec.c      |   18 +-
 .../media/platform/verisilicon/hantro_g2_vp9_dec.c |   28 +-
 drivers/media/platform/verisilicon/hantro_hw.h     |    7 +-
 .../media/platform/verisilicon/hantro_postproc.c   |   93 +-
 drivers/media/platform/verisilicon/hantro_v4l2.c   |   29 +-
 drivers/media/platform/video-mux.c                 |   28 +-
 drivers/media/platform/xilinx/xilinx-csi2rxss.c    |   74 +-
 drivers/media/platform/xilinx/xilinx-tpg.c         |    9 +-
 drivers/media/platform/xilinx/xilinx-vip.c         |    4 +-
 drivers/media/rc/ir-hix5hd2.c                      |   10 +-
 drivers/media/rc/meson-ir-tx.c                     |   34 +-
 drivers/media/test-drivers/Kconfig                 |    1 -
 drivers/media/test-drivers/vicodec/Kconfig         |    1 -
 drivers/media/test-drivers/vicodec/vicodec-core.c  |   20 +-
 drivers/media/test-drivers/vimc/vimc-capture.c     |    2 +-
 drivers/media/test-drivers/vimc/vimc-debayer.c     |   21 +-
 drivers/media/test-drivers/vimc/vimc-scaler.c      |   20 +-
 drivers/media/test-drivers/vimc/vimc-sensor.c      |   17 +-
 drivers/media/test-drivers/visl/Kconfig            |    1 -
 drivers/media/test-drivers/visl/visl-core.c        |   21 +
 drivers/media/test-drivers/visl/visl-dec.c         |  104 +-
 drivers/media/test-drivers/visl/visl-dec.h         |    8 +
 drivers/media/test-drivers/visl/visl-trace-av1.h   |  314 ++
 .../media/test-drivers/visl/visl-trace-points.c    |    1 +
 drivers/media/test-drivers/visl/visl-video.c       |   21 +
 drivers/media/test-drivers/visl/visl-video.h       |    1 +
 drivers/media/test-drivers/visl/visl.h             |    1 +
 drivers/media/test-drivers/vivid/Kconfig           |    1 -
 drivers/media/test-drivers/vivid/vivid-core.c      |   18 +-
 drivers/media/test-drivers/vivid/vivid-meta-cap.c  |    3 -
 drivers/media/test-drivers/vivid/vivid-meta-out.c  |    5 +-
 drivers/media/test-drivers/vivid/vivid-touch-cap.c |    5 +-
 drivers/media/test-drivers/vivid/vivid-vbi-cap.c   |    3 -
 drivers/media/test-drivers/vivid/vivid-vbi-out.c   |    3 -
 drivers/media/test-drivers/vivid/vivid-vid-cap.c   |    3 -
 drivers/media/test-drivers/vivid/vivid-vid-out.c   |    5 +-
 drivers/media/usb/airspy/airspy.c                  |    5 +-
 drivers/media/usb/cx231xx/cx231xx-417.c            |    7 +-
 drivers/media/usb/cx231xx/cx231xx-core.c           |    2 +
 drivers/media/usb/cx231xx/cx231xx-video.c          |    9 +-
 drivers/media/usb/dvb-usb/cxusb-analog.c           |    2 +-
 drivers/media/usb/em28xx/em28xx-video.c            |    6 +-
 drivers/media/usb/gspca/gspca.c                    |    6 +-
 drivers/media/usb/hackrf/hackrf.c                  |    5 +-
 drivers/media/usb/pvrusb2/pvrusb2-context.c        |    3 +-
 drivers/media/usb/stk1160/stk1160-video.c          |    5 +-
 drivers/media/usb/usbtv/usbtv-video.c              |    5 +-
 drivers/media/usb/uvc/uvc_driver.c                 |   18 +
 drivers/media/usb/uvc/uvc_video.c                  |    2 +-
 drivers/media/v4l2-core/v4l2-async.c               |    4 -
 drivers/media/v4l2-core/v4l2-cci.c                 |   52 +-
 drivers/media/v4l2-core/v4l2-common.c              |   11 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |   10 +-
 drivers/media/v4l2-core/v4l2-dev.c                 |    6 +-
 drivers/media/v4l2-core/v4l2-fwnode.c              |    4 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    6 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             |    9 +-
 drivers/media/v4l2-core/v4l2-subdev.c              |  334 +-
 drivers/staging/media/Kconfig                      |    2 +
 drivers/staging/media/Makefile                     |    1 +
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c |   16 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c |   16 +-
 .../staging/media/atomisp/i2c/atomisp-mt9m114.c    |   16 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c |   16 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |    4 +-
 drivers/staging/media/atomisp/pci/atomisp_csi2.c   |    3 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |    8 +-
 drivers/staging/media/atomisp/pci/atomisp_subdev.c |    6 +-
 drivers/staging/media/atomisp/pci/atomisp_tpg.c    |    2 +-
 .../media/deprecated/atmel/atmel-isc-base.c        |   12 +-
 drivers/staging/media/imx/imx-ic-prp.c             |   34 +-
 drivers/staging/media/imx/imx-ic-prpencvf.c        |   34 +-
 drivers/staging/media/imx/imx-media-capture.c      |   15 +-
 drivers/staging/media/imx/imx-media-csi.c          |   38 +-
 drivers/staging/media/imx/imx-media-utils.c        |   10 +-
 drivers/staging/media/imx/imx-media-vdic.c         |   32 +-
 drivers/staging/media/imx/imx-media.h              |    4 +-
 drivers/staging/media/imx/imx6-mipi-csi2.c         |    4 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c             |   16 +-
 drivers/staging/media/meson/vdec/vdec.c            |   19 +-
 drivers/staging/media/omap4iss/iss_csi2.c          |    9 +-
 drivers/staging/media/omap4iss/iss_ipipe.c         |   11 +-
 drivers/staging/media/omap4iss/iss_ipipeif.c       |   11 +-
 drivers/staging/media/omap4iss/iss_resizer.c       |   11 +-
 drivers/staging/media/rkvdec/Kconfig               |    1 -
 drivers/staging/media/rkvdec/rkvdec.c              |    3 +
 drivers/staging/media/starfive/Kconfig             |    5 +
 drivers/staging/media/starfive/Makefile            |    2 +
 drivers/staging/media/starfive/camss/Kconfig       |   18 +
 drivers/staging/media/starfive/camss/Makefile      |   13 +
 drivers/staging/media/starfive/camss/TODO.txt      |    4 +
 drivers/staging/media/starfive/camss/stf-camss.c   |  436 +++
 drivers/staging/media/starfive/camss/stf-camss.h   |  134 +
 drivers/staging/media/starfive/camss/stf-capture.c |  603 ++++
 drivers/staging/media/starfive/camss/stf-capture.h |   86 +
 .../staging/media/starfive/camss/stf-isp-hw-ops.c  |  445 +++
 drivers/staging/media/starfive/camss/stf-isp.c     |  385 ++
 drivers/staging/media/starfive/camss/stf-isp.h     |  428 +++
 drivers/staging/media/starfive/camss/stf-video.c   |  572 +++
 drivers/staging/media/starfive/camss/stf-video.h   |  100 +
 drivers/staging/media/sunxi/cedrus/Kconfig         |    1 -
 drivers/staging/media/sunxi/cedrus/TODO            |   23 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c   |    9 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c   |    9 +-
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c      |    2 +-
 .../media/sunxi/sun6i-isp/sun6i_isp_params.c       |    2 +-
 .../staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c |   18 +-
 drivers/staging/media/tegra-video/csi.c            |   22 +-
 drivers/staging/media/tegra-video/vi.c             |   22 +-
 drivers/staging/media/tegra-video/vip.c            |    6 +-
 include/linux/property.h                           |    1 +
 include/media/cec.h                                |   22 +-
 include/media/v4l2-cci.h                           |   16 +
 include/media/v4l2-common.h                        |    4 +-
 include/media/v4l2-mem2mem.h                       |    9 +-
 include/media/v4l2-subdev.h                        |  419 ++-
 include/media/videobuf2-core.h                     |   48 +-
 include/uapi/linux/thp7312.h                       |   19 +
 include/uapi/linux/v4l2-controls.h                 |    6 +
 include/uapi/linux/v4l2-subdev.h                   |   15 +-
 include/uapi/linux/videodev2.h                     |   11 +-
 samples/v4l/v4l2-pci-skeleton.c                    |    7 +-
 479 files changed, 38144 insertions(+), 5193 deletions(-)
 create mode 100644 Documentation/admin-guide/media/starfive_camss.rst
 create mode 100644 Documentation/admin-guide/media/starfive_camss_graph.dot
 create mode 100644 Documentation/devicetree/bindings/media/cnm,wave521c.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvisio=
n,alvium-csi2.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,=
gc0308.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,=
gc2145.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov64a4=
0.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw=
9900.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/thine,thp73=
12.yaml
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmipp=
yaml
 create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110=
-camss.yaml
 create mode 100644 Documentation/userspace-api/media/drivers/thp7312.rst
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h
 create mode 100644 drivers/media/i2c/gc0308.c
 create mode 100644 drivers/media/i2c/gc2145.c
 create mode 100644 drivers/media/i2c/ov64a40.c
 create mode 100644 drivers/media/i2c/thp7312.c
 create mode 100644 drivers/media/i2c/tw9900.c
 create mode 100644 drivers/media/platform/chips-media/coda/Kconfig
 create mode 100644 drivers/media/platform/chips-media/coda/Makefile
 rename drivers/media/platform/chips-media/{ =3D> coda}/coda-bit.c (100%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/coda-common.c (99%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/coda-gdi.c (100%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/coda-h264.c (100%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/coda-jpeg.c (100%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/coda-mpeg2.c (100%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/coda-mpeg4.c (100%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/coda.h (100%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/coda_regs.h (100%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/imx-vdoa.c (100%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/imx-vdoa.h (100%)
 rename drivers/media/platform/chips-media/{ =3D> coda}/trace.h (99%)
 create mode 100644 drivers/media/platform/chips-media/wave5/Kconfig
 create mode 100644 drivers/media/platform/chips-media/wave5/Makefile
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-helper.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-helper.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-hw.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-regdefin=
e.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuconfi=
g.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuerror=
h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5.h
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/Makefile
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-byt=
ecap.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-byt=
eproc.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-com=
mon.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-com=
mon.h
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-cor=
e.c
 create mode 100644 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-par=
allel.c
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-av1.h
 create mode 100644 drivers/staging/media/starfive/Kconfig
 create mode 100644 drivers/staging/media/starfive/Makefile
 create mode 100644 drivers/staging/media/starfive/camss/Kconfig
 create mode 100644 drivers/staging/media/starfive/camss/Makefile
 create mode 100644 drivers/staging/media/starfive/camss/TODO.txt
 create mode 100644 drivers/staging/media/starfive/camss/stf-camss.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-camss.h
 create mode 100644 drivers/staging/media/starfive/camss/stf-capture.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-capture.h
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp.h
 create mode 100644 drivers/staging/media/starfive/camss/stf-video.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-video.h
 create mode 100644 include/uapi/linux/thp7312.h


