Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17C27E1E35
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjKFKZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:25:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB210A9;
        Mon,  6 Nov 2023 02:25:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2866C433C7;
        Mon,  6 Nov 2023 10:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699266336;
        bh=FXo0WVkxAe2I7sf4SdjRCIURCEnH40u53yIkoxRLXeU=;
        h=Date:From:To:Cc:Subject:From;
        b=XQyfCMjscDIrbVCdnSoeDP2FdQy/8Coj/MrXCc78Ls49s0D5YDh+M+HYoTa4khAYN
         557syEQkVmURJoJ/HN4/VfqTi1V5bpLeau/vEl0EEe1pvJpunKJHxhMIoJS/PYKpUW
         ZXRVFogGUGjeEHx6EOsyN2+zkKJ7tct/wT2ePnHV5DilITosHuRIUYlg3rc6/J4x18
         ISo1PhlzPuBVMnNCfBw1ZEmdVlwI5D96pZ28YPxs0lHZidkHHPX2P6Ms8D37nGhcDX
         FfenEAG++9Qqmrhtsdc90alQQPhVtTr9NQ2GlsFOooxOLDYAiIdFvRnSDd9njYYiSD
         PQ7Ze+PZJewUA==
Date:   Mon, 6 Nov 2023 11:25:31 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.7-rc1] media updates
Message-ID: <20231106112531.717e897b@coco.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.7-1

For:

- the old V4L2 core videobuf kAPI was finally removed. All media drivers
  should now be using VB2 kAPI;
- New automotive driver: mgb4;
- New platform video driver: npcm-video;
- new sensor driver: mt9m114;
- new TI driver used in conjunction with Cadence CSI2RX IP to bridge
  TI-specific parts;
- ir-rx51 was removed and the N900 DT binding was moved to the pwm-ir-tx
  generic driver;
- drop atomisp-specific ov5693, using the upstream driver instead;
- The camss has gained RDI3 support for VFE 17x;
- the atomisp driver now detects ISP2400 or ISP2401 at run time. No need
  to set it up at build time anymore;
- lots of driver fixes, cleanups and improvements.

Regards,
Mauro

---

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.7-1

for you to fetch changes up to 3e238417254bfdcc23fe207780b59cbb08656762:

  media: nuvoton: VIDEO_NPCM_VCD_ECE should depend on ARCH_NPCM (2023-10-27=
 11:44:19 +0200)

----------------------------------------------------------------
media updates for v6.7-rc1

----------------------------------------------------------------
Andrey Konovalov (1):
      media: qcom: camss: Fix csid-gen2 for test pattern generator

Benjamin Gaignard (2):
      media: verisilicon: Fixes clock list for rk3588 av1 decoder
      dt-bindings: media: rockchip: Add resets property into decoder node

Biju Das (10):
      media: i2c: video-i2c: Convert enum->pointer for data in the match ta=
bles
      media: i2c: mt9v032: Extend match support for OF tables
      media: i2c: mt9v032: Drop CONFIG_OF ifdeffery
      media: i2c: ov7670: Extend match support for OF tables
      media: i2c: ov7670: Drop CONFIG_OF ifdeffery
      media: i2c: adv7180: Extend match support for OF tables
      media: i2c: adv7180: Drop CONFIG_OF ifdeffery
      media: tvp541x: Extend match support for OF tables
      media: tvp541x: Drop CONFIG_OF ifdeffery
      media: tvp541x: Sort header files

Bingbu Cao (1):
      media: i2c/hi556: add a new mode 1296x722 settings

Bryan O'Donoghue (26):
      media: qcom: camss: Fix pm_domain_on sequence in probe
      media: qcom: camss: Fix V4L2 async notifier error path
      media: qcom: camss: Fix genpd cleanup
      media: qcom: camss: Fix vfe_get() error jump
      media: qcom: camss: Fix VFE-17x vfe_disable_output()
      media: qcom: camss: Fix VFE-480 vfe_disable_output()
      media: qcom: camss: Fix missing vfe_lite clocks check
      media: qcom: camss: Fix invalid clock enable bit disjunction
      media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater t=
han 3
      media: qcom: camss: Amalgamate struct resource with struct resource_i=
spif
      media: qcom: camss: Rename camss struct resources to camss_subdev_res=
ources
      media: qcom: camss: Start to move to module compat matched resources
      media: qcom: camss: Pass icc bandwidth table as a platform parameter
      media: qcom: camss: Pass remainder of variables as resources
      media: qcom: camss: Pass line_num from compat resources
      media: qcom: camss: Pass CAMSS subdev callbacks via resource ops poin=
ter
      media: qcom: camss: Assign the correct number of RDIs per VFE
      media: qcom: camss: Remove special case for VFE get/put
      media: qcom: camss: Untangle if/else spaghetti in camss
      media: qcom: camss: Allow clocks vfeN vfe_liteN or vfe_lite
      media: qcom: camss: Functionally decompose CSIPHY clock lookups
      media: qcom: camss: Fix support for setting CSIPHY clock name csiphyX
      media: qcom: camss: Support RDI3 for VFE 17x
      media: qcom: camss: Move vfe_disable into a common routine where appl=
icable
      media: qcom: camss: Propagate vfe_reset error up the callstack
      media: qcom: camss: Comment CSID dt_id field

Chen Jiahao (1):
      media: usb: siano: Use kmemdup to simplify kmalloc and memcpy logic

Chengfeng Ye (1):
      media: s5p-mfc: Fix potential deadlock on condlock

Christophe JAILLET (1):
      media: i2c: max9286: Fix some redundant of_node_put() calls

Colin Ian King (2):
      media: bt8xx: make read-only arrays static
      media: mediatek: vcodec: fix spelling mistake "resonable" -> "reasona=
ble"

Dan Carpenter (2):
      media: ov13b10: Fix some error checking in probe
      media: nuvoton: npcm-video: Fix IS_ERR() vs NULL bug

Fabio Estevam (1):
      media: dt-bindings: Add OV5642

Fei Shao (1):
      media: mtk-jpegenc: Fix bug in JPEG encode quality selection

Geert Uytterhoeven (1):
      media: nuvoton: VIDEO_NPCM_VCD_ECE should depend on ARCH_NPCM

Guoniu.zhou (1):
      media: ov5640: fix vblank unchange issue when work at dvp mode

Gustavo A. R. Silva (1):
      media: venus: hfi_cmds: Replace one-element array with flex-array mem=
ber and use __counted_by

Hans Verkuil (41):
      media: videobuf2: fix typo: vb2_dbuf -> vb2_qbuf
      media: cx25840: simplify cx23885_dif_setup()
      media: atomisp: remove left-over videobuf include
      media: remove the old videobuf framework
      media: atomisp: fix 'read beyond size of field'
      media: allegro-dvt: increase buffer size in msg_type_name()
      media: cadence: increase buffer size in csi2tx_get_resources()
      media: atomisp: ia_ccs_debug.c: increase enable_info buffer
      media: vivid: avoid integer overflow
      media: ipu-bridge: increase sensor_name size
      media: cx18: increase in_workq_name size
      media: rc: ati_remote: increase mouse_name buffer size
      media: cec.h: increase input_phys buffer
      media: renesas-ceu: keep input name simple
      media: zoran: increase name size
      media: v4l2-dev.h: increase struct video_device name size
      media: v4l2-subdev.h: increase struct v4l2_subdev name size
      media: use sizeof() instead of V4L2_SUBDEV_NAME_SIZE
      media: v4l2-device.h: drop V4L2_DEVICE_NAME_SIZE
      media: vivid: use VIVID_MODULE_NAME to fill bus_info
      media: microchip: don't set bus_info
      media: rcar_drif: use explicit name for bus_info
      media: am437x: don't fill in bus_info
      media: atmel: drop bus_info
      media: radio-isa: use dev_name to fill in bus_info
      media: radio-miropcm20: set bus_info to explicit name
      media: verisilicon: replace snprintf with strscpy+strlcat
      media: radio-si476x: don't fill in bus_info
      media: Documentation: dv-timings.rst: explain basic approach
      media: rc: keymaps: add missing MODULE_DESCRIPTION to keymaps
      staging: media: atomisp: drop check for reentrant .s_stream()
      media: i2c: tc358746: check fmt validity
      staging: media: atomisp: improve unwinding
      media: i2c: adp1653: don't reuse the same node pointer
      media: qcom: venus: fix incorrect return value
      media: dvb-usb-v2: af9035: fix missing unlock
      media: nxp: imx-jpeg: use goto instead of return
      media: pci: mgb4: fix potential spectre vulnerability
      media: pci: cx18: if cx =3D=3D NULL, then don't use it.
      Documentation: media: gen-errors.rst: fix confusing ENOTTY description
      Documentation: media: buffer.rst: fix V4L2_BUF_FLAG_PREPARED

Hans de Goede (15):
      media: atomisp: Fix missing v4l2_fh_release() in atomisp_open() error=
 exit
      media: atomisp: Clamp width to max 1920 pixels when in ATOMISP_RUN_MO=
DE_PREVIEW
      media: atomisp: Change atomisp_enum_framesizes() too small cut off fr=
om 2/3th to 5/8th
      media: atomisp: Add some higher resolutions to atomisp_enum_framesize=
s()
      media: atomisp: Remove support for custom run-mode v4l2-ctrl on senso=
rs
      media: atomisp: Remove v4l2_ctrl_s_ctrl(asd->run_mode) calls from ato=
misp_open()
      media: atomisp: Remove empty isys_public.h
      media: atomisp: Remove aliases for MIPI_FORMAT_2400_CUSTOM0
      media: atomisp: Mark ia_css_isys_240?_init() static
      media: atomisp: Simplify some if (IS_ISP2401...) statements
      media: atomisp: Drop ia_css_debug_dump_debug_info() and functions onl=
y used by it
      media: atomisp: Drop VIDEO_ATOMISP_ISP2401 Kconfig option
      media: atomisp: gc0310: Stop setting v4l2_subdev.fwnode to the endpoi=
nt fwnode
      media: atomisp: Disable VCM for OV5693 for now
      media: atomisp: Drop atomisp-ov5693 sensor driver

Hao Yao (1):
      media: ov13b10: Add 1364x768 register settings

Ilpo J=C3=A4rvinen (1):
      media: cobalt: Use FIELD_GET() to extract Link Width

Irui Wang (2):
      media: mediatek: vcodec: add encoder power management helper functions
      media: mediatek: vcodec: Handle invalid encoder vsi

Jacopo Mondi (7):
      media: i2c: Drop ifdeffery from sensor drivers
      media: dt-bindings: hynix,hi846: Add video-interface-devices properti=
es
      media: dt-bindings: ovti,ov02a10: Allow props from video-interface-de=
vices
      media: dt-bindings: ovti,ov4689: Allow props from video-interface-dev=
ices
      media: dt-bindings: ovti,ov5640: Allow props from video-interface-dev=
ices
      media: dt-bindings: sony,imx214: Allow props from video-interface-dev=
ices
      media: dt-bindings: sony,imx415: Allow props from video-interface-dev=
ices

Jai Luthra (4):
      media: dt-bindings: cadence-csi2rx: Add TI compatible string
      media: ti: Add CSI2RX support for J721E
      media: MAINTAINERS: Fix path for J721E CSI2RX bindings
      media: platform: cadence: select MIPI_DPHY dependency

Jean-Michel Hautbois (1):
      media: staging: ipu3-imgu: Initialise height_per_slice in the stripes

Jernej Skrabec (1):
      media: cedrus: Fix clock/reset sequence

Jiasheng Jiang (2):
      media: vidtv: psi: Add check for kstrdup
      media: vidtv: mux: Add check and kfree for kstrdup

Jinjie Ruan (6):
      media: cobalt: Use list_for_each_entry() helper
      media: cx231xx: Switch to use kmemdup() helper
      media: cx231xx: Add EP5_BUF_SIZE and EP5_TIMEOUT_MS macros
      media: aspeed: Drop unnecessary error check for debugfs_create_file()
      media: siano: Drop unnecessary error check for debugfs_create_dir/fil=
e()
      media: cx231xx: Use EP5_BUF_SIZE macro

Juerg Haefliger (1):
      media: bttv: Add MODULE_FIRMWARE macro

Julia Lawall (1):
      media: platform: mtk-mdp3: add missing of_node_put

Kate Hsuan (26):
      media: atomisp: ia_css_debug: Removed unused codes for debug
      media: atomisp: Removed unused HAS_WATCHDOG_SP_THREAD_DEBUG debug
      media: atomisp: sh_css_internal: sh_css_params: Unifying sh_css_sp_gr=
oup data structure
      media: atomisp: ia_css_debug: Removed debug codes for dumping status
      media: atomisp: Make two individual enum to define the MIPI format
      media: atomisp: Included both input system headers
      media: atomisp: css_2401_system: Remove #ifdef ISP2401 to make the dr=
iver generic
      media: atomisp: isys: Removed #if defined(ISP2401) to make driver gen=
eric
      media: atomisp: hive_isp_css_common: Removed #if defined(ISP2401) to =
make driver generic
      media: atomisp: pipeline: Removed #if defined(ISP2401) to make driver=
 generic
      media: atomisp: ifmtr: Removed #if defined(ISP2401) to make driver ge=
neric
      media: atomisp: Compile the object codes for a generic driver
      media: atomisp: rx: Removed #if defined(ISP2401) to make driver gener=
ic
      media: atomisp: isys_init: Initiate atomisp in a generic manner
      media: atomisp: ia_css_raw.host: Remove #ifdef ISP2401 to make the dr=
iver generic
      media: atomisp: binary: Removed #ifdef ISP2401 to make driver generic
      media: atomisp: hive_isp_css_include: Removed #ifdef ISP2401 to make =
driver generic
      media: atomisp: atomisp_compat_css20: Removed #ifdef ISP2401 to make =
driver generic
      media: atomisp: sh_css_mipi: Removed unused code ia_css_mipi_frame_en=
able_check_on_size()
      media: atomisp: sh_css: Removed #ifdef ISP2401 to make the driver gen=
eric
      media: atomisp: sh_css_sp: Remove #ifdef ISP2401 to make driver gener=
ic
      media: atomisp: sh_css: Removed #ifdef ISP2401 to make driver generic
      media: atomisp: sh_css: Renamed sh_css_config_input_network()
      media: atomisp: sh_css: Removed #ifdef ISP2401 to make code generic
      media: atomisp: sh_css: Removed #ifdef ISP2401 to make the driver gen=
eric
      media: atomisp: atomisp_v4l2: Removed unnecessary code

Katya Orlova (1):
      media: s3c-camif: Avoid inappropriate kfree()

Kees Cook (2):
      media: allegro: Annotate struct mcu_msg_push_buffers_internal with __=
counted_by
      media: v4l2-event: Annotate struct v4l2_subscribed_event with __count=
ed_by

Ken Lin (2):
      media: platform: cros-ec: Rename conns array for the match table
      media: platform: cros-ec: Add Taranza to the match table

Konrad Dybcio (1):
      dt-bindings: media: qcom,sdm845-venus-v2: Allow interconnect properti=
es

Krzysztof Kozlowski (4):
      media: platform: use capital "OR" for multiple licenses in SPDX
      media: dt-bindings: samsung,exynos4212-fimc-is: replace duplicate pmu=
 node with phandle
      media: dt-bindings: samsung,fimc: correct unit addresses in DTS examp=
le
      media: exynos4-is: fimc-is: replace duplicate pmu node with phandle

Laurent Pinchart (99):
      media: v4l2-subdev: Document that routing support depends on streams
      media: i2c: Use pm_runtime_resume_and_get()
      media: i2c: ov5693: Drop the unused streaming flag
      media: i2c: imx415: Replace streaming flag with runtime PM check
      media: i2c: imx296: Replace streaming flag with runtime PM check
      media: v4l2-subdev: Document and enforce .s_stream() requirements
      media: i2c: hi556: Drop check for reentrant .s_stream()
      media: i2c: hi846: Drop check for reentrant .s_stream()
      media: i2c: imx208: Drop check for reentrant .s_stream()
      media: i2c: imx214: Drop check for reentrant .s_stream()
      media: i2c: imx219: Drop check for reentrant .s_stream()
      media: i2c: imx258: Drop check for reentrant .s_stream()
      media: i2c: imx319: Drop check for reentrant .s_stream()
      media: i2c: imx334: Drop check for reentrant .s_stream()
      media: i2c: imx335: Drop check for reentrant .s_stream()
      media: i2c: imx355: Drop check for reentrant .s_stream()
      media: i2c: imx412: Drop check for reentrant .s_stream()
      media: i2c: mt9m001: Drop check for reentrant .s_stream()
      media: i2c: og01a1b: Drop check for reentrant .s_stream()
      media: i2c: ov01a10: Drop check for reentrant .s_stream()
      media: i2c: ov08d10: Drop check for reentrant .s_stream()
      media: i2c: ov08x40: Drop check for reentrant .s_stream()
      media: i2c: ov13858: Drop check for reentrant .s_stream()
      media: i2c: ov13b10: Drop check for reentrant .s_stream()
      media: i2c: ov2685: Drop check for reentrant .s_stream()
      media: i2c: ov2740: Drop check for reentrant .s_stream()
      media: i2c: ov4689: Drop check for reentrant .s_stream()
      media: i2c: ov5647: Drop check for reentrant .s_stream()
      media: i2c: ov5670: Drop check for reentrant .s_stream()
      media: i2c: ov5675: Drop check for reentrant .s_stream()
      media: i2c: ov5695: Drop check for reentrant .s_stream()
      media: i2c: ov7740: Drop check for reentrant .s_stream()
      media: i2c: ov8856: Drop check for reentrant .s_stream()
      media: i2c: ov9282: Drop check for reentrant .s_stream()
      media: i2c: ov9734: Drop check for reentrant .s_stream()
      Documentation: media: camera-sensor: Fix typo and vocabulary selection
      Documentation: media: camera-sensor: Use link to upstream DT bindings
      Documentation: media: camera-sensor: Move power management section
      Documentation: media: camera-sensor: Improve power management documen=
tation
      media: i2c: ar0521: Drop system suspend and resume handlers
      media: i2c: ccs: Drop system suspend and resume handlers
      media: i2c: hi556: Drop system suspend and resume handlers
      media: i2c: hi846: Drop system suspend and resume handlers
      media: i2c: hi847: Drop system suspend and resume handlers
      media: i2c: imx208: Drop system suspend and resume handlers
      media: i2c: imx214: Drop system suspend and resume handlers
      media: i2c: imx219: Drop system suspend and resume handlers
      media: i2c: imx258: Drop system suspend and resume handlers
      media: i2c: imx319: Drop system suspend and resume handlers
      media: i2c: imx355: Drop system suspend and resume handlers
      media: i2c: og01a1b: Drop system suspend and resume handlers
      media: i2c: ov01a10: Drop system suspend and resume handlers
      media: i2c: ov02a10: Drop system suspend and resume handlers
      media: i2c: ov08d10: Drop system suspend and resume handlers
      media: i2c: ov08x40: Drop system suspend and resume handlers
      media: i2c: ov13858: Drop system suspend and resume handlers
      media: i2c: ov2740: Drop system suspend and resume handlers
      media: i2c: ov13b10: Drop stream handling in runtime PM handlers
      media: i2c: ov5670: Drop system suspend and resume handlers
      media: i2c: ov5675: Drop system suspend and resume handlers
      media: i2c: ov8856: Drop system suspend and resume handlers
      media: i2c: ov9734: Drop system suspend and resume handlers
      media: dt-bindings: media: i2c: Add MT9M114 camera sensor binding
      media: i2c: Add driver for onsemi MT9M114 camera sensor
      media: i2c: imx219: Convert to CCI register access helpers
      media: i2c: imx219: Drop unused macros
      media: i2c: imx219: Replace register addresses with macros
      media: i2c: imx219: Drop IMX219_REG_CSI_LANE_MODE from common regs ar=
ray
      media: i2c: imx219: Fix test pattern window for 640x480 mode
      media: i2c: imx219: Set mode registers programmatically
      media: i2c: imx219: Merge format and binning setting functions
      media: i2c: imx219: Initialize ycbcr_enc
      media: i2c: imx219: Use active crop rectangle to configure registers
      media: i2c: imx219: Infer binning settings from format and crop
      media: i2c: imx219: Access height from active format in imx219_set_ct=
rl
      media: i2c: imx219: Don't store the current mode in the imx219 struct=
ure
      media: i2c: imx219: Drop IMX219_VTS_* macros
      media: i2c: imx219: Group functions by purpose
      media: i2c: imx219: Remove unneeded goto
      media: i2c: imx219: Implement .init_cfg() using .set_fmt()
      media: i2c: imx219: Separate horizontal and vertical binning
      media: i2c: imx219: Calculate crop rectangle dynamically
      media: i2c: imx219: Name all subdev state variables 'state'
      media: i2c: imx219: Move variables to inner scope
      media: i2c: mt9m114: Fix missing error unwind in probe()
      media: MAINTAINERS: Add co-maintainer for the rkisp1 driver
      media: rkisp1: resizer: Use V4L2 subdev active state
      media: rkisp1: isp: Use V4L2 subdev active state
      media: rkisp1: csi: Use V4L2 subdev active state
      media: rkisp1: Convert hex constants to lowercase
      media: rkisp1: Constify rkisp1_v12_params_ops
      media: rkisp1: Fix line stride calculation
      media: rkisp1: Remove dual crop control register from config structure
      media: rkisp1: Program RKISP1_CIF_MI_SP_Y_PIC_SIZE register
      media: rkisp1: resizer: Constify argument and local variables
      media: rkisp1: resizer: Use v4l2_area instead of v4l2_rect to store s=
ize
      media: rkisp1: resizer: Drop unneeded local variable
      media: rkisp1: resizer: Improve debug message when configuring resizer
      media: rkisp1: resizer: Fix resizer disable check when starting stream

Li Zetao (1):
      media: nxp: Use devm_kmemdup to replace devm_kmalloc + memcpy

Ma Ke (2):
      media: videobuf2: Fix IS_ERR checking in vb2_vmalloc_put_userptr()
      media: videobuf2: Fix IS_ERR checking in vb2_dc_put_userptr()

Marek Szyprowski (1):
      media: cec: meson: always include meson sub-directory in Makefile

Marek Vasut (2):
      media: hantro: Check whether reset op is defined before use
      media: verisilicon: Do not enable G2 postproc downscale if source is =
narrower than destination

Martin D=C3=B8rum (1):
      media: qcom/camss: use 1X16 formats instead of 2X8

Martin T=C5=AFma (2):
      media: pci: mgb4: Added Digiteq Automotive MGB4 driver
      media: Documentation: Added Digiteq Automotive MGB4 driver documentat=
ion

Marvin Lin (6):
      media: dt-bindings: nuvoton: Add NPCM VCD and ECE engine
      dt-bindings: soc: nuvoton: Add NPCM GFXI
      media: v4l: Add HEXTILE compressed format
      media: v4l2-ctrls: Add user control base for Nuvoton NPCM controls
      media: uapi: Add controls for NPCM video driver
      media: nuvoton: Add driver for NPCM video capture and encoding engine

Mikhail Rudenko (1):
      MAINTAINERS: fix file path for Omnvision OV4689

Ming Qian (3):
      media: imx-jpeg: initiate a drain of the capture queue in dynamic res=
olution change
      media: amphion: handle firmware debug message
      media: imx-jpeg: notify source chagne event when the first picture pa=
rsed

Moudy Ho (1):
      media: platform: mtk-mdp3: fix uninitialized variable in mdp_path_con=
fig()

Patrick Whewell (1):
      media: venus: Fix firmware path for resources

Pratyush Yadav (11):
      media: dt-bindings: Make sure items in data-lanes are unique
      media: cadence: csi2rx: Unregister v4l2 async notifier
      media: cadence: csi2rx: Cleanup media entity properly
      media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
      media: cadence: csi2rx: Configure DPHY using link freq
      media: cadence: csi2rx: Soft reset the streams before starting capture
      media: cadence: csi2rx: Set the STOP bit when stopping a stream
      media: cadence: csi2rx: Fix stream data configuration
      media: cadence: csi2rx: Populate subdev devnode
      media: cadence: csi2rx: Add link validation
      media: dt-bindings: Add TI J721E CSI2RX

Rajeshwar R Shinde (1):
      media: gspca: cpia1: shift-out-of-bounds in set_flicker

Reka Norman (9):
      media: cros-ec-cec: Use cros_ec_cmd to send host commands
      media: cros-ec-cec: Manage an array of ports
      media: cros-ec-cec: Support multiple ports in set/get host commands
      media: cros-ec-cec: Support multiple ports in write command
      media: cros-ec-cec: Support multiple ports in MKBP cec_events
      media: cros-ec-cec: Support receiving messages from multiple ports
      media: cros-ec-cec: Allow specifying multiple HDMI connectors
      media: cros-ec-cec: Get number of CEC ports from EC
      media: cros-ec-cec: Add Dibbi to the match table

Ricardo B. Marliere (1):
      staging: media: ipu3: remove ftrace-like logging

Ross Zwisler (1):
      media: visl: use canonical ftrace path

Ruan Jinjie (6):
      media: dvb-frontends: drx39xyj: Remove unnecessary ternary operators
      media: radio-wl1273: Remove an unnecessary ternary operator
      media: dvb-usb: gp8psk: Remove an unnecessary ternary operator
      media: c8sectpfe: Use the devm_clk_get_enabled() helper function
      media: ov2640: Use the devm_clk_get_enabled() helper function
      media: staging: media: sunxi: cedrus: Remove redundant of_match_ptr()

Sakari Ailus (28):
      media: ivsc: Improve Kconfig help text
      media: v4l2-mc: Make v4l2_pipeline_pm_{get,put} deprecated
      media: Documentation: Mention CCS tools
      media: ov9282: Assign maintenance to Dave
      media: imx412: Orphan the driver
      media: imx335: Orphan the driver
      media: imx334: Orphan the driver
      media: Documentation: Align numbered list, make it a proper ReST
      media: ccs: Fix driver quirk struct documentation
      media: ccs: Correctly initialise try compose rectangle
      media: ccs: Correct error handling in ccs_register_subdev
      media: ccs: Switch to init_cfg
      media: ccs: Rename ccs_create_subdev as ccs_init_subdev
      media: ccs: Move media_entity_pads_init to init from register
      media: ccs: Obtain media bus formats before initialising up sub-devic=
es
      media: ccs: Use sub-device active state
      media: ccs: Partially revert "media: i2c: Use pm_runtime_resume_and_g=
et()"
      media: ccs: Drop re-entrant s_stream support
      media: ov2740: Enable runtime PM before registering the async subdev
      media: ov2740: Use sub-device active state
      media: ov2740: Return -EPROBE_DEFER if no endpoint is found
      media: v4l: subdev: Clear frame descriptor before get_frame_desc
      media: v4l: subdev: Print debug information on frame descriptor
      media: mc: Check pad flag validity
      media: Add MIPI CSI-2 generic long packet type definition
      media: Documentation: Split camera sensor documentation
      media: ccs: Rework initialising sub-device state
      media: ccs: Fix a (harmless) lockdep warning

Sean Young (4):
      dt-bindings: media: remove nokia,n900-ir as pwm-ir-tx is compatible
      media: rc: remove ir-rx51 in favour of generic pwm-ir-tx
      media: sharp: fix sharp encoding
      media: lirc: drop trailing space from scancode transmit

Shravan Chippa (1):
      media: i2c: imx334: add support for test pattern generator

Stefan Adolfsson (1):
      media: cros-ec-cec: Add Constitution to the match table

Suhrid Subramaniam (1):
      media: v4l: Fix documentation for 12-bit packed Bayer

Takashi Iwai (1):
      media: imon: fix access to invalid resource for the second interface

Tommaso Merciai (1):
      media: dt-bindings: ov5693: fix maintainer email address

Umang Jain (2):
      media: i2c: imx415: Use v4l2_subdev_get_fmt()
      media: Documentation: ccs: Fix spelling mistake

Vikash Garodia (4):
      media: venus: hfi: add checks to perform sanity on queue pointers
      media: venus: hfi: fix the check to handle session buffer requirement
      media: venus: hfi: add checks to handle capabilities from firmware
      media: venus: hfi_parser: Add check to keep the number of codecs with=
in range

Wang Ming (1):
      media: platform: Use dev_err_probe instead of dev_err

Wentong Wu (3):
      media: ivsc: csi: remove name identifier
      media: ivsc: ace: remove name identifier
      media: ivsc: ace: probe ace device after IPU bridge is initialized.

Wolfram Sang (2):
      media: i2c: drop check because i2c_unregister_device() is NULL safe
      media: dvb-frontends: drop check because i2c_unregister_device() is N=
ULL safe

Xiaolei Wang (1):
      media: ov5640: Fix a memory leak when ov5640_probe fails

Yu Liao (1):
      media: use struct_size() helper

Yue Haibing (1):
      media: imx-jpeg: Remove unused declarations

Yunfei Dong (1):
      media: mediatek: vcodec: using encoder device to alloc/free encoder m=
emory

Zelong Dong (2):
      media: rc: meson-ir: support rc driver type RC_DRIVER_SCANCODE
      dt-bindings: media: Add compatible for Meson-S4 IR Controller

Zheng Wang (1):
      media: bttv: fix use after free error due to btv->timeout timer

rasheed.hsueh (1):
      media: platform: cros-ec: Add Boxy to the match table

 Documentation/admin-guide/media/mgb4.rst           |  374 ++
 Documentation/admin-guide/media/pci-cardlist.rst   |    1 +
 Documentation/admin-guide/media/v4l-drivers.rst    |    1 +
 Documentation/admin-guide/media/visl.rst           |    6 +-
 .../devicetree/bindings/leds/irled/pwm-ir-tx.yaml  |    5 +-
 .../bindings/media/amlogic,meson6-ir.yaml          |    1 +
 .../devicetree/bindings/media/cdns,csi2rx.yaml     |    1 +
 .../devicetree/bindings/media/i2c/hynix,hi846.yaml |    7 +-
 .../bindings/media/i2c/onnn,mt9m114.yaml           |  114 +
 .../bindings/media/i2c/ovti,ov02a10.yaml           |    8 +-
 .../devicetree/bindings/media/i2c/ovti,ov4689.yaml |    6 +-
 .../devicetree/bindings/media/i2c/ovti,ov5640.yaml |    7 +-
 .../devicetree/bindings/media/i2c/ovti,ov5642.yaml |  141 +
 .../devicetree/bindings/media/i2c/ovti,ov5693.yaml |    2 +-
 .../devicetree/bindings/media/i2c/sony,imx214.yaml |    2 +-
 .../devicetree/bindings/media/i2c/sony,imx415.yaml |   10 +-
 .../devicetree/bindings/media/nokia,n900-ir        |   20 -
 .../bindings/media/nuvoton,npcm-ece.yaml           |   43 +
 .../bindings/media/nuvoton,npcm-vcd.yaml           |   72 +
 .../bindings/media/qcom,sdm845-venus-v2.yaml       |    8 +
 .../devicetree/bindings/media/rockchip-vpu.yaml    |    7 +
 .../bindings/media/samsung,exynos4212-fimc-is.yaml |   15 +-
 .../devicetree/bindings/media/samsung,fimc.yaml    |   27 +-
 .../bindings/media/ti,j721e-csi2rx-shim.yaml       |  100 +
 .../bindings/media/video-interfaces.yaml           |    1 +
 .../bindings/soc/nuvoton/nuvoton,gfxi.yaml         |   39 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 Documentation/driver-api/media/camera-sensor.rst   |  192 +-
 Documentation/driver-api/media/drivers/ccs/ccs.rst |   10 +-
 Documentation/driver-api/media/v4l2-core.rst       |    1 -
 Documentation/driver-api/media/v4l2-dev.rst        |    8 -
 Documentation/driver-api/media/v4l2-videobuf.rst   |  403 ---
 .../zh_CN/video4linux/v4l2-framework.txt           |   12 -
 .../userspace-api/media/drivers/camera-sensor.rst  |  104 +
 .../userspace-api/media/drivers/index.rst          |    2 +
 .../userspace-api/media/drivers/npcm-video.rst     |   66 +
 Documentation/userspace-api/media/gen-errors.rst   |    4 +-
 Documentation/userspace-api/media/v4l/buffer.rst   |    4 +-
 Documentation/userspace-api/media/v4l/control.rst  |    4 +
 .../userspace-api/media/v4l/dev-subdev.rst         |   49 +-
 .../userspace-api/media/v4l/dv-timings.rst         |   21 +
 .../userspace-api/media/v4l/pixfmt-reserved.rst    |    7 +
 .../userspace-api/media/v4l/pixfmt-srggb12p.rst    |    4 +-
 MAINTAINERS                                        |   52 +-
 arch/arm/configs/omap2plus_defconfig               |    1 -
 drivers/media/cec/platform/Makefile                |    2 +-
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c   |  387 +-
 drivers/media/common/siano/smsdvb-debugfs.c        |   22 +-
 drivers/media/common/videobuf2/frame_vector.c      |    2 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |    2 +-
 .../media/common/videobuf2/videobuf2-dma-contig.c  |   13 +-
 drivers/media/common/videobuf2/videobuf2-vmalloc.c |   10 +-
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |    6 +-
 drivers/media/dvb-frontends/m88ds3103.c            |    3 +-
 drivers/media/i2c/Kconfig                          |   11 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/adp1653.c                        |   28 +-
 drivers/media/i2c/adv7180.c                        |   65 +-
 drivers/media/i2c/ar0521.c                         |   30 +-
 drivers/media/i2c/ccs/ccs-core.c                   |  431 +--
 drivers/media/i2c/ccs/ccs-quirk.h                  |    4 +-
 drivers/media/i2c/ccs/ccs.h                        |    4 +-
 drivers/media/i2c/cx25840/cx25840-core.c           | 3694 +++++-----------=
----
 drivers/media/i2c/ds90ub913.c                      |    2 -
 drivers/media/i2c/ds90ub953.c                      |    2 -
 drivers/media/i2c/ds90ub960.c                      |    2 -
 drivers/media/i2c/hi556.c                          |  114 +-
 drivers/media/i2c/hi846.c                          |   34 +-
 drivers/media/i2c/hi847.c                          |   57 +-
 drivers/media/i2c/imx208.c                         |   61 +-
 drivers/media/i2c/imx214.c                         |   40 -
 drivers/media/i2c/imx219.c                         | 1279 +++----
 drivers/media/i2c/imx258.c                         |   40 -
 drivers/media/i2c/imx296.c                         |   16 +-
 drivers/media/i2c/imx319.c                         |   44 -
 drivers/media/i2c/imx334.c                         |   66 +-
 drivers/media/i2c/imx335.c                         |    9 -
 drivers/media/i2c/imx355.c                         |   45 -
 drivers/media/i2c/imx412.c                         |    9 -
 drivers/media/i2c/imx415.c                         |   45 +-
 drivers/media/i2c/max9286.c                        |    2 -
 drivers/media/i2c/msp3400-driver.c                 |    2 +-
 drivers/media/i2c/mt9m001.c                        |    6 -
 drivers/media/i2c/mt9m111.c                        |   13 +-
 drivers/media/i2c/mt9m114.c                        | 2481 +++++++++++++
 drivers/media/i2c/mt9v011.c                        |    6 -
 drivers/media/i2c/mt9v032.c                        |   26 +-
 drivers/media/i2c/mt9v111.c                        |   14 -
 drivers/media/i2c/og01a1b.c                        |   55 +-
 drivers/media/i2c/ov01a10.c                        |   59 +-
 drivers/media/i2c/ov02a10.c                        |    2 -
 drivers/media/i2c/ov08d10.c                        |   52 -
 drivers/media/i2c/ov08x40.c                        |   44 -
 drivers/media/i2c/ov13858.c                        |   44 -
 drivers/media/i2c/ov13b10.c                        |   98 +-
 drivers/media/i2c/ov2640.c                         |   21 +-
 drivers/media/i2c/ov2659.c                         |   16 +-
 drivers/media/i2c/ov2685.c                         |   19 -
 drivers/media/i2c/ov2740.c                         |  168 +-
 drivers/media/i2c/ov4689.c                         |    9 +-
 drivers/media/i2c/ov5640.c                         |   24 +-
 drivers/media/i2c/ov5647.c                         |    6 -
 drivers/media/i2c/ov5670.c                         |   36 -
 drivers/media/i2c/ov5675.c                         |   44 -
 drivers/media/i2c/ov5693.c                         |    9 +-
 drivers/media/i2c/ov5695.c                         |   25 -
 drivers/media/i2c/ov7251.c                         |    8 +-
 drivers/media/i2c/ov7670.c                         |   72 +-
 drivers/media/i2c/ov772x.c                         |    4 -
 drivers/media/i2c/ov7740.c                         |   30 +-
 drivers/media/i2c/ov8856.c                         |   47 -
 drivers/media/i2c/ov9282.c                         |    9 -
 drivers/media/i2c/ov9734.c                         |   50 -
 drivers/media/i2c/rdacm20.c                        |    3 +-
 drivers/media/i2c/st-vgxy61.c                      |    9 +-
 drivers/media/i2c/tc358746.c                       |    6 +-
 drivers/media/i2c/tvp514x.c                        |   49 +-
 drivers/media/i2c/video-i2c.c                      |   12 +-
 drivers/media/mc/mc-entity.c                       |   15 +-
 drivers/media/pci/Kconfig                          |    1 +
 drivers/media/pci/Makefile                         |    1 +
 drivers/media/pci/bt8xx/bttv-cards.c               |    1 +
 drivers/media/pci/bt8xx/bttv-driver.c              |    1 +
 drivers/media/pci/bt8xx/dvb-bt8xx.c                |   14 +-
 drivers/media/pci/cobalt/cobalt-driver.c           |   11 +-
 drivers/media/pci/cobalt/cobalt-v4l2.c             |    8 +-
 drivers/media/pci/cx18/cx18-driver.h               |    2 +-
 drivers/media/pci/cx18/cx18-mailbox.c              |    2 +-
 drivers/media/pci/intel/ivsc/Kconfig               |   12 +-
 drivers/media/pci/intel/ivsc/mei_ace.c             |    9 +-
 drivers/media/pci/intel/ivsc/mei_csi.c             |    5 +-
 drivers/media/pci/mgb4/Kconfig                     |   17 +
 drivers/media/pci/mgb4/Makefile                    |    6 +
 drivers/media/pci/mgb4/mgb4_cmt.c                  |  244 ++
 drivers/media/pci/mgb4/mgb4_cmt.h                  |   17 +
 drivers/media/pci/mgb4/mgb4_core.c                 |  686 ++++
 drivers/media/pci/mgb4/mgb4_core.h                 |   74 +
 drivers/media/pci/mgb4/mgb4_dma.c                  |  123 +
 drivers/media/pci/mgb4/mgb4_dma.h                  |   18 +
 drivers/media/pci/mgb4/mgb4_i2c.c                  |  140 +
 drivers/media/pci/mgb4/mgb4_i2c.h                  |   35 +
 drivers/media/pci/mgb4/mgb4_io.h                   |   33 +
 drivers/media/pci/mgb4/mgb4_regs.c                 |   30 +
 drivers/media/pci/mgb4/mgb4_regs.h                 |   35 +
 drivers/media/pci/mgb4/mgb4_sysfs.h                |   18 +
 drivers/media/pci/mgb4/mgb4_sysfs_in.c             |  772 ++++
 drivers/media/pci/mgb4/mgb4_sysfs_out.c            |  740 ++++
 drivers/media/pci/mgb4/mgb4_sysfs_pci.c            |   71 +
 drivers/media/pci/mgb4/mgb4_trigger.c              |  208 ++
 drivers/media/pci/mgb4/mgb4_trigger.h              |    8 +
 drivers/media/pci/mgb4/mgb4_vin.c                  |  939 +++++
 drivers/media/pci/mgb4/mgb4_vin.h                  |   69 +
 drivers/media/pci/mgb4/mgb4_vout.c                 |  602 ++++
 drivers/media/pci/mgb4/mgb4_vout.h                 |   65 +
 drivers/media/pci/zoran/zoran.h                    |    2 +-
 drivers/media/platform/Kconfig                     |    1 +
 drivers/media/platform/Makefile                    |    1 +
 drivers/media/platform/allegro-dvt/allegro-mail.c  |    2 +-
 drivers/media/platform/allegro-dvt/allegro-mail.h  |    2 +-
 drivers/media/platform/amphion/vpu_defs.h          |    1 +
 drivers/media/platform/amphion/vpu_helpers.c       |    1 +
 drivers/media/platform/amphion/vpu_malone.c        |    1 +
 drivers/media/platform/amphion/vpu_msgs.c          |   31 +-
 drivers/media/platform/aspeed/aspeed-video.c       |   15 +-
 drivers/media/platform/cadence/Kconfig             |    2 +
 drivers/media/platform/cadence/cdns-csi2rx.c       |  180 +-
 drivers/media/platform/cadence/cdns-csi2tx.c       |    6 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |    5 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   |    2 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   |    1 +
 .../mediatek/vcodec/common/mtk_vcodec_fw_scp.c     |    2 +-
 .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c     |    2 +-
 .../mediatek/vcodec/common/mtk_vcodec_util.c       |   56 +-
 .../mediatek/vcodec/encoder/mtk_vcodec_enc.c       |   21 +-
 .../mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c    |   18 +
 .../mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h    |    3 +-
 .../platform/mediatek/vcodec/encoder/venc_drv_if.c |    8 +-
 .../platform/mediatek/vcodec/encoder/venc_vpu_if.c |    5 +
 .../media/platform/microchip/microchip-isc-base.c  |    6 -
 drivers/media/platform/nuvoton/Kconfig             |   15 +
 drivers/media/platform/nuvoton/Makefile            |    2 +
 drivers/media/platform/nuvoton/npcm-regs.h         |  152 +
 drivers/media/platform/nuvoton/npcm-video.c        | 1831 ++++++++++
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h  |   11 -
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     |   36 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h     |    1 +
 drivers/media/platform/nxp/imx-mipi-csis.c         |    2 -
 .../media/platform/nxp/imx8-isi/imx8-isi-core.c    |    4 +-
 drivers/media/platform/qcom/camss/camss-csid-4-1.c |    8 +-
 drivers/media/platform/qcom/camss/camss-csid-4-7.c |    8 +-
 .../media/platform/qcom/camss/camss-csid-gen2.c    |   33 +-
 drivers/media/platform/qcom/camss/camss-csid.c     |   39 +-
 drivers/media/platform/qcom/camss/camss-csid.h     |    4 +-
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   10 +-
 drivers/media/platform/qcom/camss/camss-csiphy.c   |   95 +-
 drivers/media/platform/qcom/camss/camss-csiphy.h   |    4 +-
 drivers/media/platform/qcom/camss/camss-ispif.c    |   52 +-
 drivers/media/platform/qcom/camss/camss-ispif.h    |    4 +-
 drivers/media/platform/qcom/camss/camss-vfe-170.c  |   73 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c  |   18 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c  |   18 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-8.c  |   18 +-
 drivers/media/platform/qcom/camss/camss-vfe-480.c  |   61 +-
 drivers/media/platform/qcom/camss/camss-vfe.c      |  228 +-
 drivers/media/platform/qcom/camss/camss-vfe.h      |   15 +-
 drivers/media/platform/qcom/camss/camss-video.c    |   81 +-
 drivers/media/platform/qcom/camss/camss.c          |  482 +--
 drivers/media/platform/qcom/camss/camss.h          |   34 +-
 drivers/media/platform/qcom/venus/core.c           |   10 +-
 drivers/media/platform/qcom/venus/hfi_cmds.h       |    2 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c       |    2 +-
 drivers/media/platform/qcom/venus/hfi_parser.c     |   15 +
 drivers/media/platform/qcom/venus/hfi_venus.c      |   10 +
 drivers/media/platform/qcom/venus/pm_helpers.c     |    2 +-
 drivers/media/platform/renesas/rcar-isp.c          |    2 +-
 .../media/platform/renesas/rcar-vin/rcar-csi2.c    |    2 +-
 drivers/media/platform/renesas/rcar_drif.c         |    3 +-
 drivers/media/platform/renesas/renesas-ceu.c       |    6 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c      |   24 +-
 .../media/platform/rockchip/rkisp1/rkisp1-common.h |   18 -
 .../media/platform/rockchip/rkisp1/rkisp1-csi.c    |  107 +-
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  261 +-
 .../media/platform/rockchip/rkisp1/rkisp1-params.c |    4 +-
 .../media/platform/rockchip/rkisp1/rkisp1-regs.h   |  620 ++--
 .../platform/rockchip/rkisp1/rkisp1-resizer.c      |  251 +-
 .../media/platform/samsung/exynos4-is/fimc-is.c    |   33 +-
 .../platform/samsung/s3c-camif/camif-capture.c     |    6 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_enc.c   |    2 +-
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.c     |   26 +-
 drivers/media/platform/ti/Kconfig                  |   12 +
 drivers/media/platform/ti/Makefile                 |    1 +
 drivers/media/platform/ti/am437x/am437x-vpfe.c     |    4 -
 drivers/media/platform/ti/j721e-csi2rx/Makefile    |    2 +
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 1159 ++++++
 drivers/media/platform/ti/omap3isp/ispstat.c       |    2 +-
 drivers/media/platform/verisilicon/hantro_drv.c    |    8 +-
 .../media/platform/verisilicon/hantro_postproc.c   |    2 +-
 .../platform/verisilicon/rockchip_av1_filmgrain.c  |    2 +-
 .../media/platform/verisilicon/rockchip_vpu_hw.c   |    2 +-
 drivers/media/platform/xilinx/xilinx-dma.c         |    5 +-
 drivers/media/radio/radio-isa.c                    |    2 +-
 drivers/media/radio/radio-miropcm20.c              |    4 +-
 drivers/media/radio/radio-si476x.c                 |    4 +-
 drivers/media/radio/radio-wl1273.c                 |    2 +-
 drivers/media/rc/Kconfig                           |   10 -
 drivers/media/rc/Makefile                          |    1 -
 drivers/media/rc/ati_remote.c                      |    2 +-
 drivers/media/rc/imon.c                            |    6 +
 drivers/media/rc/ir-rx51.c                         |  285 --
 drivers/media/rc/ir-sharp-decoder.c                |    8 +-
 drivers/media/rc/keymaps/rc-adstech-dvb-t-pci.c    |    1 +
 drivers/media/rc/keymaps/rc-alink-dtu-m.c          |    1 +
 drivers/media/rc/keymaps/rc-anysee.c               |    1 +
 drivers/media/rc/keymaps/rc-apac-viewcomp.c        |    1 +
 drivers/media/rc/keymaps/rc-astrometa-t2hybrid.c   |    1 +
 drivers/media/rc/keymaps/rc-asus-pc39.c            |    1 +
 drivers/media/rc/keymaps/rc-asus-ps3-100.c         |    1 +
 drivers/media/rc/keymaps/rc-ati-tv-wonder-hd-600.c |    1 +
 drivers/media/rc/keymaps/rc-ati-x10.c              |    1 +
 drivers/media/rc/keymaps/rc-avermedia-a16d.c       |    1 +
 drivers/media/rc/keymaps/rc-avermedia-cardbus.c    |    1 +
 drivers/media/rc/keymaps/rc-avermedia-dvbt.c       |    1 +
 drivers/media/rc/keymaps/rc-avermedia-m135a.c      |    1 +
 .../media/rc/keymaps/rc-avermedia-m733a-rm-k6.c    |    1 +
 drivers/media/rc/keymaps/rc-avermedia-rm-ks.c      |    1 +
 drivers/media/rc/keymaps/rc-avermedia.c            |    1 +
 drivers/media/rc/keymaps/rc-avertv-303.c           |    1 +
 drivers/media/rc/keymaps/rc-azurewave-ad-tu700.c   |    1 +
 drivers/media/rc/keymaps/rc-beelink-gs1.c          |    1 +
 drivers/media/rc/keymaps/rc-beelink-mxiii.c        |    1 +
 drivers/media/rc/keymaps/rc-behold-columbus.c      |    1 +
 drivers/media/rc/keymaps/rc-behold.c               |    1 +
 drivers/media/rc/keymaps/rc-budget-ci-old.c        |    1 +
 drivers/media/rc/keymaps/rc-cinergy-1400.c         |    1 +
 drivers/media/rc/keymaps/rc-cinergy.c              |    1 +
 drivers/media/rc/keymaps/rc-ct-90405.c             |    1 +
 drivers/media/rc/keymaps/rc-d680-dmb.c             |    1 +
 drivers/media/rc/keymaps/rc-dib0700-nec.c          |    1 +
 drivers/media/rc/keymaps/rc-dib0700-rc5.c          |    1 +
 drivers/media/rc/keymaps/rc-digitalnow-tinytwin.c  |    1 +
 drivers/media/rc/keymaps/rc-digittrade.c           |    1 +
 drivers/media/rc/keymaps/rc-dm1105-nec.c           |    1 +
 drivers/media/rc/keymaps/rc-dntv-live-dvb-t.c      |    1 +
 drivers/media/rc/keymaps/rc-dntv-live-dvbt-pro.c   |    1 +
 drivers/media/rc/keymaps/rc-dreambox.c             |    1 +
 drivers/media/rc/keymaps/rc-dtt200u.c              |    1 +
 drivers/media/rc/keymaps/rc-dvbsky.c               |    1 +
 drivers/media/rc/keymaps/rc-dvico-mce.c            |    1 +
 drivers/media/rc/keymaps/rc-dvico-portable.c       |    1 +
 drivers/media/rc/keymaps/rc-em-terratec.c          |    1 +
 drivers/media/rc/keymaps/rc-encore-enltv-fm53.c    |    1 +
 drivers/media/rc/keymaps/rc-encore-enltv.c         |    1 +
 drivers/media/rc/keymaps/rc-encore-enltv2.c        |    1 +
 drivers/media/rc/keymaps/rc-evga-indtube.c         |    1 +
 drivers/media/rc/keymaps/rc-eztv.c                 |    1 +
 drivers/media/rc/keymaps/rc-flydvb.c               |    1 +
 drivers/media/rc/keymaps/rc-flyvideo.c             |    1 +
 drivers/media/rc/keymaps/rc-fusionhdtv-mce.c       |    1 +
 drivers/media/rc/keymaps/rc-gadmei-rm008z.c        |    1 +
 drivers/media/rc/keymaps/rc-geekbox.c              |    1 +
 drivers/media/rc/keymaps/rc-genius-tvgo-a11mce.c   |    1 +
 drivers/media/rc/keymaps/rc-gotview7135.c          |    1 +
 drivers/media/rc/keymaps/rc-hauppauge.c            |    1 +
 drivers/media/rc/keymaps/rc-hisi-poplar.c          |    1 +
 drivers/media/rc/keymaps/rc-hisi-tv-demo.c         |    1 +
 drivers/media/rc/keymaps/rc-imon-mce.c             |    1 +
 drivers/media/rc/keymaps/rc-imon-pad.c             |    1 +
 drivers/media/rc/keymaps/rc-imon-rsc.c             |    1 +
 drivers/media/rc/keymaps/rc-iodata-bctv7e.c        |    1 +
 drivers/media/rc/keymaps/rc-it913x-v1.c            |    1 +
 drivers/media/rc/keymaps/rc-it913x-v2.c            |    1 +
 drivers/media/rc/keymaps/rc-kaiomy.c               |    1 +
 drivers/media/rc/keymaps/rc-khadas.c               |    1 +
 drivers/media/rc/keymaps/rc-khamsin.c              |    1 +
 drivers/media/rc/keymaps/rc-kworld-315u.c          |    1 +
 drivers/media/rc/keymaps/rc-kworld-pc150u.c        |    1 +
 .../media/rc/keymaps/rc-kworld-plus-tv-analog.c    |    1 +
 drivers/media/rc/keymaps/rc-leadtek-y04g0051.c     |    1 +
 drivers/media/rc/keymaps/rc-lme2510.c              |    1 +
 drivers/media/rc/keymaps/rc-manli.c                |    1 +
 drivers/media/rc/keymaps/rc-mecool-kii-pro.c       |    1 +
 drivers/media/rc/keymaps/rc-mecool-kiii-pro.c      |    1 +
 drivers/media/rc/keymaps/rc-medion-x10.c           |    1 +
 drivers/media/rc/keymaps/rc-minix-neo.c            |    1 +
 drivers/media/rc/keymaps/rc-msi-digivox-ii.c       |    1 +
 drivers/media/rc/keymaps/rc-msi-digivox-iii.c      |    1 +
 drivers/media/rc/keymaps/rc-msi-tvanywhere-plus.c  |    1 +
 drivers/media/rc/keymaps/rc-msi-tvanywhere.c       |    1 +
 drivers/media/rc/keymaps/rc-nebula.c               |    1 +
 .../media/rc/keymaps/rc-nec-terratec-cinergy-xs.c  |    1 +
 drivers/media/rc/keymaps/rc-norwood.c              |    1 +
 drivers/media/rc/keymaps/rc-npgtech.c              |    1 +
 drivers/media/rc/keymaps/rc-odroid.c               |    1 +
 drivers/media/rc/keymaps/rc-pctv-sedna.c           |    1 +
 drivers/media/rc/keymaps/rc-pine64.c               |    1 +
 drivers/media/rc/keymaps/rc-pinnacle-color.c       |    1 +
 drivers/media/rc/keymaps/rc-pinnacle-grey.c        |    1 +
 drivers/media/rc/keymaps/rc-pinnacle-pctv-hd.c     |    1 +
 drivers/media/rc/keymaps/rc-pixelview-002t.c       |    1 +
 drivers/media/rc/keymaps/rc-pixelview-mk12.c       |    1 +
 drivers/media/rc/keymaps/rc-pixelview-new.c        |    1 +
 drivers/media/rc/keymaps/rc-pixelview.c            |    1 +
 .../media/rc/keymaps/rc-powercolor-real-angel.c    |    1 +
 drivers/media/rc/keymaps/rc-proteus-2309.c         |    1 +
 drivers/media/rc/keymaps/rc-purpletv.c             |    1 +
 drivers/media/rc/keymaps/rc-pv951.c                |    1 +
 drivers/media/rc/keymaps/rc-rc6-mce.c              |    1 +
 .../media/rc/keymaps/rc-real-audio-220-32-keys.c   |    1 +
 drivers/media/rc/keymaps/rc-reddo.c                |    1 +
 drivers/media/rc/keymaps/rc-snapstream-firefly.c   |    1 +
 drivers/media/rc/keymaps/rc-streamzap.c            |    1 +
 drivers/media/rc/keymaps/rc-su3000.c               |    1 +
 drivers/media/rc/keymaps/rc-tanix-tx3mini.c        |    1 +
 drivers/media/rc/keymaps/rc-tanix-tx5max.c         |    1 +
 drivers/media/rc/keymaps/rc-tbs-nec.c              |    1 +
 drivers/media/rc/keymaps/rc-technisat-ts35.c       |    1 +
 drivers/media/rc/keymaps/rc-technisat-usb2.c       |    1 +
 .../media/rc/keymaps/rc-terratec-cinergy-c-pci.c   |    1 +
 .../media/rc/keymaps/rc-terratec-cinergy-s2-hd.c   |    1 +
 drivers/media/rc/keymaps/rc-terratec-cinergy-xs.c  |    1 +
 drivers/media/rc/keymaps/rc-terratec-slim-2.c      |    1 +
 drivers/media/rc/keymaps/rc-terratec-slim.c        |    1 +
 drivers/media/rc/keymaps/rc-tevii-nec.c            |    1 +
 drivers/media/rc/keymaps/rc-tivo.c                 |    1 +
 .../media/rc/keymaps/rc-total-media-in-hand-02.c   |    1 +
 drivers/media/rc/keymaps/rc-total-media-in-hand.c  |    1 +
 drivers/media/rc/keymaps/rc-trekstor.c             |    1 +
 drivers/media/rc/keymaps/rc-tt-1500.c              |    1 +
 drivers/media/rc/keymaps/rc-twinhan-dtv-cab-ci.c   |    1 +
 drivers/media/rc/keymaps/rc-twinhan1027.c          |    1 +
 drivers/media/rc/keymaps/rc-vega-s9x.c             |    1 +
 drivers/media/rc/keymaps/rc-videomate-m1f.c        |    1 +
 drivers/media/rc/keymaps/rc-videomate-s350.c       |    1 +
 drivers/media/rc/keymaps/rc-videomate-tv-pvr.c     |    1 +
 drivers/media/rc/keymaps/rc-videostrong-kii-pro.c  |    1 +
 drivers/media/rc/keymaps/rc-wetek-hub.c            |    1 +
 drivers/media/rc/keymaps/rc-wetek-play2.c          |    1 +
 drivers/media/rc/keymaps/rc-winfast-usbii-deluxe.c |    1 +
 drivers/media/rc/keymaps/rc-winfast.c              |    1 +
 drivers/media/rc/keymaps/rc-x96max.c               |    1 +
 drivers/media/rc/keymaps/rc-xbox-360.c             |    1 +
 drivers/media/rc/keymaps/rc-xbox-dvd.c             |    1 +
 drivers/media/rc/keymaps/rc-zx-irdec.c             |    1 +
 drivers/media/rc/lirc_dev.c                        |    6 +-
 drivers/media/rc/meson-ir.c                        |  522 ++-
 drivers/media/rc/pwm-ir-tx.c                       |    1 +
 drivers/media/test-drivers/vidtv/vidtv_mux.c       |    7 +-
 drivers/media/test-drivers/vidtv/vidtv_psi.c       |   45 +-
 drivers/media/test-drivers/vivid/vivid-core.c      |    2 +-
 drivers/media/test-drivers/vivid/vivid-rds-gen.c   |    2 +-
 drivers/media/usb/cx231xx/cx231xx-417.c            |    9 +-
 drivers/media/usb/cx231xx/cx231xx-core.c           |    7 +-
 drivers/media/usb/cx231xx/cx231xx.h                |    3 +
 drivers/media/usb/dvb-usb-v2/af9035.c              |   13 +-
 drivers/media/usb/dvb-usb/gp8psk.c                 |    2 +-
 drivers/media/usb/gspca/cpia1.c                    |    3 +
 drivers/media/usb/siano/smsusb.c                   |    4 +-
 drivers/media/v4l2-core/Kconfig                    |   16 -
 drivers/media/v4l2-core/Makefile                   |    5 -
 drivers/media/v4l2-core/v4l2-event.c               |    2 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    1 +
 drivers/media/v4l2-core/v4l2-subdev.c              |   55 +-
 drivers/media/v4l2-core/videobuf-core.c            | 1198 -------
 drivers/media/v4l2-core/videobuf-dma-contig.c      |  402 ---
 drivers/media/v4l2-core/videobuf-dma-sg.c          |  681 ----
 drivers/media/v4l2-core/videobuf-vmalloc.c         |  326 --
 drivers/staging/media/atomisp/Kconfig              |   12 -
 drivers/staging/media/atomisp/Makefile             |   16 +-
 drivers/staging/media/atomisp/TODO                 |    3 -
 drivers/staging/media/atomisp/i2c/Kconfig          |   12 -
 drivers/staging/media/atomisp/i2c/Makefile         |    1 -
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c |   26 +-
 drivers/staging/media/atomisp/i2c/ov5693/Makefile  |    2 -
 drivers/staging/media/atomisp/i2c/ov5693/ad5823.h  |   63 -
 .../media/atomisp/i2c/ov5693/atomisp-ov5693.c      | 1763 ----------
 drivers/staging/media/atomisp/i2c/ov5693/ov5693.h  | 1331 -------
 .../staging/media/atomisp/include/linux/atomisp.h  |   10 -
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |   44 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.h    |   13 -
 .../media/atomisp/pci/atomisp_compat_css20.c       |   15 +-
 .../media/atomisp/pci/atomisp_csi2_bridge.c        |    7 +-
 drivers/staging/media/atomisp/pci/atomisp_fops.c   |    7 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |   21 +-
 drivers/staging/media/atomisp/pci/atomisp_subdev.c |   48 -
 drivers/staging/media/atomisp/pci/atomisp_subdev.h |    2 -
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |   19 -
 .../pci/css_2401_system/host/isys_irq_local.h      |    3 -
 .../pci/css_2401_system/host/isys_irq_private.h    |    2 -
 .../atomisp/pci/css_2401_system/isys_irq_global.h  |    2 -
 .../atomisp/pci/hive_isp_css_common/debug_global.h |    7 -
 .../atomisp/pci/hive_isp_css_common/host/dma.c     |  266 --
 .../pci/hive_isp_css_common/host/dma_local.h       |  116 -
 .../pci/hive_isp_css_common/host/input_formatter.c |    2 -
 .../pci/hive_isp_css_common/host/input_system.c    |  446 ---
 .../atomisp/pci/hive_isp_css_common/host/irq.c     |   19 -
 .../pci/hive_isp_css_common/host/irq_local.h       |    8 -
 .../atomisp/pci/hive_isp_css_common/host/isp.c     |   60 -
 .../pci/hive_isp_css_common/host/isp_local.h       |   31 -
 .../atomisp/pci/hive_isp_css_common/host/sp.c      |   47 -
 .../pci/hive_isp_css_common/host/sp_local.h        |   26 -
 .../pci/hive_isp_css_include/host/csi_rx_public.h  |    2 -
 .../pci/hive_isp_css_include/host/dma_public.h     |   13 -
 .../pci/hive_isp_css_include/host/irq_public.h     |   10 -
 .../pci/hive_isp_css_include/host/isp_public.h     |   13 -
 .../hive_isp_css_include/host/isys_dma_public.h    |    2 -
 .../hive_isp_css_include/host/isys_irq_public.h    |    2 -
 .../pci/hive_isp_css_include/host/isys_public.h    |   38 -
 .../hive_isp_css_include/host/pixelgen_public.h    |    2 -
 .../pci/hive_isp_css_include/host/sp_public.h      |   16 -
 .../atomisp/pci/hive_isp_css_include/isys_irq.h    |    2 -
 .../staging/media/atomisp/pci/ia_css_acc_types.h   |    6 +-
 drivers/staging/media/atomisp/pci/ia_css_mipi.h    |   16 -
 .../staging/media/atomisp/pci/input_system_local.h |    7 +-
 .../media/atomisp/pci/input_system_private.h       |    7 +-
 .../media/atomisp/pci/input_system_public.h        |    4 +-
 .../pci/isp/kernels/raw/raw_1.0/ia_css_raw.host.c  |   21 +-
 .../media/atomisp/pci/isp2400_input_system_local.h |  198 +-
 .../atomisp/pci/isp2400_input_system_private.h     |    4 +-
 .../atomisp/pci/isp2400_input_system_public.h      |   42 +-
 .../media/atomisp/pci/isp2401_input_system_local.h |   88 +-
 .../atomisp/pci/isp2401_input_system_private.h     |  112 +-
 .../media/atomisp/pci/runtime/binary/src/binary.c  |   15 +-
 .../pci/runtime/debug/interface/ia_css_debug.h     |   85 -
 .../atomisp/pci/runtime/debug/src/ia_css_debug.c   | 1495 +-------
 .../media/atomisp/pci/runtime/ifmtr/src/ifmtr.c    |    2 -
 .../pci/runtime/isys/interface/ia_css_isys.h       |    9 +-
 .../pci/runtime/isys/interface/ia_css_isys_comm.h  |    2 -
 .../atomisp/pci/runtime/isys/src/csi_rx_rmgr.c     |    2 -
 .../atomisp/pci/runtime/isys/src/isys_dma_rmgr.c   |    2 -
 .../media/atomisp/pci/runtime/isys/src/isys_init.c |   31 +-
 .../pci/runtime/isys/src/isys_stream2mmio_rmgr.c   |    2 -
 .../media/atomisp/pci/runtime/isys/src/rx.c        |  229 +-
 .../atomisp/pci/runtime/isys/src/virtual_isys.c    |    8 +-
 .../runtime/pipeline/interface/ia_css_pipeline.h   |    2 -
 .../atomisp/pci/runtime/pipeline/src/pipeline.c    |    2 -
 drivers/staging/media/atomisp/pci/sh_css.c         |  238 +-
 .../staging/media/atomisp/pci/sh_css_internal.h    |   41 +-
 drivers/staging/media/atomisp/pci/sh_css_mipi.c    |   29 -
 drivers/staging/media/atomisp/pci/sh_css_params.c  |   41 +-
 drivers/staging/media/atomisp/pci/sh_css_sp.c      |   62 +-
 drivers/staging/media/atomisp/pci/sh_css_sp.h      |    4 -
 .../media/deprecated/atmel/atmel-isc-base.c        |    4 -
 drivers/staging/media/ipu3/ipu3-css-params.c       |   44 +-
 drivers/staging/media/ipu3/ipu3.c                  |    6 -
 drivers/staging/media/omap4iss/iss_csi2.c          |    2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        |    2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |   24 +-
 drivers/staging/media/tegra-video/csi.c            |    4 +-
 drivers/staging/media/tegra-video/vip.c            |    2 +-
 include/linux/platform_data/cros_ec_commands.h     |   66 +-
 include/media/cec.h                                |    2 +-
 include/media/ipu-bridge.h                         |    2 +-
 include/media/mipi-csi2.h                          |    1 +
 include/media/v4l2-dev.h                           |    2 +-
 include/media/v4l2-device.h                        |    4 +-
 include/media/v4l2-event.h                         |    2 +-
 include/media/v4l2-mc.h                            |    6 +
 include/media/v4l2-subdev.h                        |   13 +-
 include/media/videobuf-core.h                      |  233 --
 include/media/videobuf-dma-contig.h                |   30 -
 include/media/videobuf-dma-sg.h                    |  102 -
 include/media/videobuf-vmalloc.h                   |   43 -
 include/uapi/linux/npcm-video.h                    |   41 +
 include/uapi/linux/v4l2-controls.h                 |    6 +
 include/uapi/linux/videodev2.h                     |    1 +
 505 files changed, 17217 insertions(+), 18024 deletions(-)
 create mode 100644 Documentation/admin-guide/media/mgb4.rst
 create mode 100644 Documentation/devicetree/bindings/media/i2c/onnn,mt9m11=
4.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5642=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/nokia,n900-ir
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-ec=
e.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-vc=
d.yaml
 create mode 100644 Documentation/devicetree/bindings/media/ti,j721e-csi2rx=
-shim.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,g=
fxi.yaml
 delete mode 100644 Documentation/driver-api/media/v4l2-videobuf.rst
 create mode 100644 Documentation/userspace-api/media/drivers/camera-sensor=
.rst
 create mode 100644 Documentation/userspace-api/media/drivers/npcm-video.rst
 create mode 100644 drivers/media/i2c/mt9m114.c
 create mode 100644 drivers/media/pci/mgb4/Kconfig
 create mode 100644 drivers/media/pci/mgb4/Makefile
 create mode 100644 drivers/media/pci/mgb4/mgb4_cmt.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_cmt.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_core.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_core.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_dma.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_dma.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_i2c.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_i2c.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_io.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_regs.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_regs.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_in.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_out.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_pci.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_trigger.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_trigger.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_vin.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_vin.h
 create mode 100644 drivers/media/pci/mgb4/mgb4_vout.c
 create mode 100644 drivers/media/pci/mgb4/mgb4_vout.h
 create mode 100644 drivers/media/platform/nuvoton/Kconfig
 create mode 100644 drivers/media/platform/nuvoton/Makefile
 create mode 100644 drivers/media/platform/nuvoton/npcm-regs.h
 create mode 100644 drivers/media/platform/nuvoton/npcm-video.c
 create mode 100644 drivers/media/platform/ti/j721e-csi2rx/Makefile
 create mode 100644 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
 delete mode 100644 drivers/media/rc/ir-rx51.c
 delete mode 100644 drivers/media/v4l2-core/videobuf-core.c
 delete mode 100644 drivers/media/v4l2-core/videobuf-dma-contig.c
 delete mode 100644 drivers/media/v4l2-core/videobuf-dma-sg.c
 delete mode 100644 drivers/media/v4l2-core/videobuf-vmalloc.c
 delete mode 100644 drivers/staging/media/atomisp/i2c/ov5693/Makefile
 delete mode 100644 drivers/staging/media/atomisp/i2c/ov5693/ad5823.h
 delete mode 100644 drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693=
.c
 delete mode 100644 drivers/staging/media/atomisp/i2c/ov5693/ov5693.h
 delete mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/isys_public.h
 delete mode 100644 include/media/videobuf-core.h
 delete mode 100644 include/media/videobuf-dma-contig.h
 delete mode 100644 include/media/videobuf-dma-sg.h
 delete mode 100644 include/media/videobuf-vmalloc.h
 create mode 100644 include/uapi/linux/npcm-video.h

