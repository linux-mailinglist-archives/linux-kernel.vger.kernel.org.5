Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF547E5E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjKHT3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKHT33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:29:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DCB1FF3;
        Wed,  8 Nov 2023 11:29:27 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E28F66076A0;
        Wed,  8 Nov 2023 19:29:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699471765;
        bh=X+SQAkV/qD1VwHqpCoToQMLPVB+sfkGWnjVVTEV5k5g=;
        h=From:Subject:Date:To:Cc:From;
        b=M40h79oRDnbbWP7SsYrMYhrDtZYx7xhipO+TybQKK/YuS3ANvFiVTDaL5x2x42nE2
         tuEMHig0/OA029wI+xjca9dbBdF0CNXxiF0vdxoobrrhXg5AaYnatichWA8jTivT6x
         hufrv7sBLvhaEp+kSkDjDWwopHeq07hlVTGge049PpedqsvAab7CjmK1fUn/C4PSqU
         MuOsRZ3Mv0Lo79D7/S1/Wz7BkU8+sYp7dO1NTTLGO1Dy13zKra4rHw4OC76zUKpb0L
         cQZK+3RMjbGSYDwQnIlvKm/TScWQSeo+ninV00+kQHASxK/GspVC2nhnhuojbCyhNB
         nYEvIBXmHGh9w==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Subject: [PATCH v14 0/8] Wave5 codec driver
Date:   Wed, 08 Nov 2023 20:29:20 +0100
Message-Id: <20231108-wave5-v14-rebased-v14-0-0b4af1258656@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJDhS2UC/2WNSw6DMAwFr4K8riVMza9XQV0E4oI3aeVIAQlx9
 ybddvlGbzQnRDGVCI/qBJOkUd8hD+JbBcvmwiqoPgNo6uZOVA+4uyQtJmI0mV0UjyN3re967kdi
 yF6hOJsLy1bMP6F8PiYvPX7h6XldX7dbxJeIAAAA
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Ivan Bornyakov <brnkv.i1@gmail.com>,
        Deborah Brouwer <deborah.brouwer@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        devicetree@vger.kernel.org,
        Robert Beckett <bob.beckett@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699471762; l=17636;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=X+SQAkV/qD1VwHqpCoToQMLPVB+sfkGWnjVVTEV5k5g=;
 b=hdQ30SHTY0XlVcS+WLc3TAwamCXtVfYTLVhXikkWGrHWj6maOd3lqVO6Qf3QfxmorQUMQ1vQwzNz
 o+PUf31iDgG5z15ot75+umltxrL6gV/IWL4iULuTVJA+NCQp9GBR
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wave5 codec driver is a stateful encoder/decoder.
It is found on the J721S2 SoC, JH7100 SoC, ssd202d SoC. Etc.
But current test report is based on J721S2 SoC and pre-silicon FPGA.

The driver currently supports V4L2_PIX_FMT_HEVC, V4L2_PIX_FMT_H264
for both encoding and decoding.

This driver has so far been tested on J721S2 EVM board and pre-silicon
FPGA.

Testing on J721S2 EVM board shows it working fine both decoder and
encoder.
The driver is successfully working with gstreamer v4l2 good-plugin
without any modification.

We have based the tree on top of the latest
https://git.linuxtv.org/media_tree.git repository.

M2M framework modification:
===========================

(Patch 1 & 2)
Added a set of changes to enable ignoring the streaming state of one or more
queues while checking whether a new job can be inserted into the ready queue.
The use-case we encountered for this is a stateful decoder/encoder chip with a
tight connection to a firmware. On that firmware the bitstream is first
analyzed and the firmware produces output indicating the requirements for the
output of the decode (e.g. the buffers of the CAPTURE queue). We want to be
able to perform this action within the M2M job workflow in order to rely on the
concurrency safety provided by the M2M jobs.

v4l2-compliance results:
========================

v4l2-compliance 1.25.0-5110, 64 bits, 64-bit time_t
v4l2-compliance SHA: 3d6682746de5 2023-10-22 09:43:18

Buffer ioctls:
	    warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not supported
	    warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not supported
    test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
    test VIDIOC_EXPBUF: OK
    test Requests: OK (Not Supported)

Total for wave5-dec device /dev/video0: 45, Succeeded: 45, Failed: 0, Warnings: 2

Total for wave5-enc device /dev/video1: 45, Succeeded: 45, Failed: 0, Warnings: 0

Fluster test results:
=====================

Running test suite JCT-VC-HEVC_V1 with decoder GStreamer-H.265-V4L2-Gst1.0
Using 1 parallel job(s)
Ran 133/147 tests successfully               in 95.898 secs

(1 test fails because of a missing frame and slight corruption, 2 tests fail
because of sizes which are incompatible with the IP, 11 tests fail because of
unsupported 10 bit format)

Running test suite JVT-AVC_V1 with decoder GStreamer-H.264-V4L2-Gst1.0
Using 1 parallel job(s)
Ran 78/135 tests successfully               in 57.198 secs

(57 fail because the hardware is unable to decode
 MBAFF / FMO / Field / Extended profile streams.)

Encoder testing:
================

Among other tests the driver is able to produce valid output with the following test:
`gst-launch-1.0 videotestsrc num-buffers=300 ! v4l2h264enc ! h264parse ! qtmux ! filesink location=test.mp4`

Known missing features:
=======================

* 48 bit memory addressing
* Runtime suspend/resume support
* Encoder support for the YUV 422 format
* Support for the Background Detection encoder feature of the IP block
* Support for the Region Of Interest encoder feature of the IP block

Changes since v13:
==================

* For [PATCH v13 4/8] media: chips-media: wave5: Add vpuapi layer
   - return variable 'ret' instead of 0 in wave5_vpu_dec_give_command()
   - remove unnecessary initialization of ret in dec_clr_disp_flag()

* For [PATCH v13 5/8] media: chips-media: wave5: Add the v4l2 layer
   - fix decoder fail when payload size and sizeimage are different
   - remove CREATE_BUFS entirely from decoder
   - queue_setup: increase the number of CAPTURE buffers requested if
     less than the frame buffer count
   - bind driver to ti,k3-j721s2-wave521c instead of fallback compatible

* [PATCH v13 6/8] media: dt-bindings: wave5: add Chips&Media 521c codec IP support
   - remove -vpu suffix from fallback compatible name
   - fix $id path and example to match fallback compatible name
   - add vendor implementation to compatible property
   - remove interrupts from required property

* [PATCH v13 8/8] arm64: dts: ti: k3-j721s2-main: add wave5 video encoder/decoder node
   - add vendor implementation to DT compatible string

Changes since v12:
==================

* Add patch "arm64: dts: ti: k3-j721s2-main: add wave5 video encoder/decoder node"
* Fix locking issues when mutex hw_lock is taken while holding state_spinlock

* For [PATCH v12 1/7] media: v4l2: Add ignore_streaming flag:
  - rename flag: ignore_streaming -> ignore_cap_streaming
  - move flag from v4l2_m2m_queue_ctx to v4l2_m2m_ctx

* For [PATCH v12 2/7] media: v4l2: Allow M2M job queuing w/o streaming
  CAP queue:
  - use renamed ignore_cap_streaming flag

* For [PATCH v12 4/7] media: chips-media: wave5: Add vpuapi layer
  - refactor: wave5_bit_issue_command() accepts additional parameters
  - refactor: use wave5_send_query() where possible, clean up return values
  - fix: initialize additional registers and fix typo
  - fix: do not warn when rotation isn't enabled
  - fix: prevent decoder close failure by returning 0 from reset_auxiliary_buffers

* For [PATCH v12 5/7] media: chips-media: wave5: Add the v4l2 layer
  - reduce interrupt handling to one function called by the irq handler thread
  - use dma_set_mask_and_coherent() and check if it returns an error
  - extend copyright: 2021 -> 2021-2023
  - remove redundant work (e.g. type checking) already handled by v4l2 core
  - queue_setup: remove src_buf_count and dst_buf_count and rely on v4l2 counts
  - create_bufs: return EOPNOTSUPP when ioctl is unsupported by a queue
  - start_streaming: return buffers properly on error
  - minor fixes for typos, adding comments and small refactoring improvements

* For [PATCH v12 6/7] dt-bindings: media: wave5: add yaml devicetree bindings
  - rename patch "media: dt-bindings: wave5: add Chips&Media 521c codec IP support"
  - remove clock-names; fix formatting

Changes since v11:
==================

* Major rework of the decoder
  - Fix concurrency issues by moving the commands that invoke actions on the
    firmware into the device_run function from M2M, effectively causing M2M to
    take care of the concurrency via its job queue.
    - In order to do that device_run needs to be able to run before both queues
      are ready, as a sequence needs to be initialized on the firmware to get
      the required buffer count & communicate the result back to userspace,
      thus we added a routine to allow jobs to be queued in M2M with only one
      of two queues being started. (See: "Add ignore_streaming flag to M2M"
      series)
  - Add support for more output formats (YUV422P, YUV422M, NV16, NV16M, NV61,
    NV61M)
  - Add proper state switch function to verify state switches 
  - Simplify the queue_setup function and move the decoder opening to STREAMON
    as request in the review of V11
  - Enable handling dynamic resolution change and seeking
  - Remove thumbnail mode

* Similar reworks on the encoder
  - Move encoding into device_run and encoder opening + sequence intialization
    to STREAMON, this change simplifies the encoder as it previously was able
    to run multiple encode jobs simultaneously

* Remove unused configurations and support for untested hardware
  - Remove the ability to configure the endianess of memory writes as only a
    single hardware can be tested so far
  - Remove the ability to configure the bitstream_mode, as the driver is
    currently hardcoded for the INTERRUPT mode
  - Remove support for all CODECS, that were not tested (everything besides
    H264/HEVC encoder + decoder)
  - The encoder currently contains a lot of configurable parameter, which are
    hard-coded in the `wave5_set_enc_openparam` function, remove all parameters
    which aren't currently specified in that configuration
  - Remove unused rotation and mirroring options from the decoder

* Add FLUSH_FIRMWARE firmware command
* Refactoring
  * Add wrappers for frequently used routines or to make the code more
    descriptive
    - Wrapper for firmware command calling `send_firmware_command`
    - Wrappers to intialize the sequence and to set up the framebuffers in the
      decoder and encoder
    - Using more general kernel functions and macros in various places
  * Add Macros for constant values and bit shifts
  * Fix typos and improve comments

* Fix bug with M2M instance stored in the driver instance, multiple
  simultaneous instances would overwrite the M2M handler of each other. Use a
  M2M handler per device instead to avoid overwriting.
* Adjust TRACE_PATH in the coda directory as highlighted in the review of V11
* Applied requested changes from review to the devicetree bindings file
  (the bindings check didn't return any warnings or errors)

Changes since v10:
==================

* Remove structure member from the encoder and decoder output info
  structs, that have assigned values from the registers but aren't used
  in the driver, add comments to describe the register values in the
  register definitions
* Fix issue with decoding videos with a dimension where the height is
  not a multiple of 16 (270, 360, 540, 1024 etc.)
* Fix incorrect variable format identifiers in printks
* Use debug logs in loops to avoid flooding the message log
* Use the swap() function instead of manual swapping of two values
* Add extended controls for the encoder
* Fix control flow issue while handling bitstream buffers, where an
  error while writing the source buffer into the hardware ring buffer
  would result in skipping the problematic buffer, which in turn causes
  a reordering of source buffers
* Use the rectangle format as described by the hardware, the hardware
  uses for rectangles like the display rectangle 4 offsets (top, bottom,
  left, right), which depict the offset from the respective edge. Use
  this format instead of implicitly converting the bottom and right
  attributes to width and height attributes.
* Return an error upon reading the sequence header while STREAMON
* Squash the VDI and the VPUAPI layer commits as they had circular
  dependencies

changes since v9:
=================

* Move from staging to the media directory
  * Move coda driver to sub-directory

* Fixes:
  * Use platform_get_irq instead of platform_get_resource to fetch the IRQ

* General cleanups:
  * Add missing error messages to error conditions
  * Improve messages/variable names/comments, align parameter names across the driver
  * Use macros instead of magic numbers in multiple occassions
  * Reduce code duplication in multiple places
  * Fix whitespace, newline and tab alignment issues
  * Remove unused struct fields & commented out code
  * Convert signed integers to unsigned if signed is not necessary
  * Convert int/unsigned int to s32/u32, when the variable is assigned to the
    return of a register read or provided as a parameter for a register write
    (and vice versa)
  * Fix incorrect bitwise operators where logical operators are appropriate
  * Multiple smaller changes

* Generalization:
  * Add new helper file providing generalized routines for vpu-dec & vpu-enc
  * Generalize luma & chroma table size calculation and stride calculation

* Resource cleanup and error handling:
  * Add error handling to all calls with ignored return codes
  * Handle DMA resource cleanup properly
  * Fix insufficient instance cleanup while opening dec/enc

Changes since v8:
=================

* add 'wave5' to DEV_NAME
* update to support Multi-stream
* update to support loop test/dynamic resolution change
* remove unnecessary memset, g_volatile, old version option

Changes since v7:
=================

* update v4l2-compliance test report
* fix build error on linux-kernel 5.18.0-rc4

Changes since v6:
=================

* update TODO file
* get sram info from device tree

Changes since v5:
=================

* support NV12/NV21 pixelformat for encoder and decoder
* handle adnormal exit and EOS

Changes since v4:
=================

* refactor functions in wave5-hw and fix bug reported by Daniel Palmer
* rename functions and variables to better names
* change variable types such as replacing s32 with u32 and int with bool
* as appropriate

Changes since v3:
=================

* Fixing all issues commented by Dan Carpenter
* Change file names to have wave5- prefix
* In wave5_vpu_probe, enable the clocks before reading registers, as
* commented from Daniel Palmer
* Add more to the TODO list,

Changes since v2:
=================

Main fixes includes:
* change the yaml and dirver code to support up to 4 clks (instead of
* one)
* fix Kconfig format
* remove unneeded cast,
* change var types
* change var names, func names
* checkpatch fixes

Changes since v1:
=================

Fix changes due to comments from Ezequiel and Dan Carpenter. Main fixes
inclueds:
* move all files to one dir 'wave5'
* replace private error codes with standard error codes
* fix extra spaces
* various checkpatch fixes
* replace private 'DPRINTK' macro with standard 'dev_err/dbg ..'
* fix error handling
* add more possible fixes to the TODO file

To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Hans Verkuil <hverkuil@xs4all.nl>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
To: Jackson Lee <jackson.lee@chipsnmedia.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: deborah.brouwer@collabora.com
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Robert Beckett <bob.beckett@collabora.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>
CC: kernel@collabora.com
CC: brnkv.i1@gmail.com
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

---
- Link to v13: https://lore.kernel.org/r/20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com

---
Darren Etheridge (1):
      arm64: dts: ti: k3-j721s2-main: add wave5 video encoder/decoder node

Nas Chung (2):
      media: chips-media: wave5: Add vpuapi layer
      media: chips-media: wave5: Add the v4l2 layer

Robert Beckett (2):
      dt-bindings: media: wave5: add yaml devicetree bindings
      media: chips-media: wave5: Add wave5 driver to maintainers file

Sebastian Fricke (3):
      media: v4l2: Add ignore_streaming flag
      media: v4l2: Allow M2M job queuing w/o streaming CAP queue
      media: platform: chips-media: Move Coda to separate folder

 .../devicetree/bindings/media/cnm,wave521c.yaml    |   61 +
 MAINTAINERS                                        |   10 +-
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |   14 +
 drivers/media/platform/chips-media/Kconfig         |   18 +-
 drivers/media/platform/chips-media/Makefile        |    6 +-
 drivers/media/platform/chips-media/coda/Kconfig    |   18 +
 drivers/media/platform/chips-media/coda/Makefile   |    6 +
 .../platform/chips-media/{ => coda}/coda-bit.c     |    0
 .../platform/chips-media/{ => coda}/coda-common.c  |    0
 .../platform/chips-media/{ => coda}/coda-gdi.c     |    0
 .../platform/chips-media/{ => coda}/coda-h264.c    |    0
 .../platform/chips-media/{ => coda}/coda-jpeg.c    |    0
 .../platform/chips-media/{ => coda}/coda-mpeg2.c   |    0
 .../platform/chips-media/{ => coda}/coda-mpeg4.c   |    0
 .../media/platform/chips-media/{ => coda}/coda.h   |    0
 .../platform/chips-media/{ => coda}/coda_regs.h    |    0
 .../platform/chips-media/{ => coda}/imx-vdoa.c     |    0
 .../platform/chips-media/{ => coda}/imx-vdoa.h     |    0
 .../media/platform/chips-media/{ => coda}/trace.h  |    2 +-
 drivers/media/platform/chips-media/wave5/Kconfig   |   12 +
 drivers/media/platform/chips-media/wave5/Makefile  |   10 +
 .../platform/chips-media/wave5/wave5-helper.c      |  213 ++
 .../platform/chips-media/wave5/wave5-helper.h      |   31 +
 .../media/platform/chips-media/wave5/wave5-hw.c    | 2554 ++++++++++++++++++++
 .../platform/chips-media/wave5/wave5-regdefine.h   |  732 ++++++
 .../media/platform/chips-media/wave5/wave5-vdi.c   |  205 ++
 .../media/platform/chips-media/wave5/wave5-vdi.h   |   35 +
 .../platform/chips-media/wave5/wave5-vpu-dec.c     | 1932 +++++++++++++++
 .../platform/chips-media/wave5/wave5-vpu-enc.c     | 1794 ++++++++++++++
 .../media/platform/chips-media/wave5/wave5-vpu.c   |  291 +++
 .../media/platform/chips-media/wave5/wave5-vpu.h   |   83 +
 .../platform/chips-media/wave5/wave5-vpuapi.c      |  960 ++++++++
 .../platform/chips-media/wave5/wave5-vpuapi.h      |  870 +++++++
 .../platform/chips-media/wave5/wave5-vpuconfig.h   |   77 +
 .../platform/chips-media/wave5/wave5-vpuerror.h    |  292 +++
 drivers/media/platform/chips-media/wave5/wave5.h   |  114 +
 drivers/media/v4l2-core/v4l2-mem2mem.c             |    9 +-
 include/media/v4l2-mem2mem.h                       |    7 +
 38 files changed, 10331 insertions(+), 25 deletions(-)
---
base-commit: 3e238417254bfdcc23fe207780b59cbb08656762
change-id: 20231108-wave5-v14-rebased-9465d6747914

Best regards,
-- 
Sebastian Fricke <sebastian.fricke@collabora.com>
