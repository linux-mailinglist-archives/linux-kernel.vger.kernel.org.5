Return-Path: <linux-kernel+bounces-104211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E7B87CABF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBFB1F236B5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287017C6E;
	Fri, 15 Mar 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWNcObkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933B17C60;
	Fri, 15 Mar 2024 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495084; cv=none; b=bCAuhV+fvd0Wi6XRuGZ4nJNEpaxabIWoKyXW6WihdZOznRqsDgvdF7imI5UQcekqJOFO0bIHVOaJKSXeQRKWHni+qDUeTqZes83PEtQXdh8iQQgylwBMYvm7Pl2yvMHAPM2Vg70jiCvhPI2mY5oWMnzVbabLWzDIe6DnNt+7lk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495084; c=relaxed/simple;
	bh=s5Z9V1IDdJp1r9FpEJSMgYWix7nzpkOQkdx5/fcvews=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BMYkW4VrF0tJcdUHAat74f8uPb/qDuqePTeNzWJNaBQUdM9uUSl3rk7ahvC56aGl4BeUHQW7dc/IDsoAz8XgVXIFpNXEdqPYITY4DrwODO22Sy+Kg4H2J5EojOJQnKWW0Pa+rzHRyvXKjF9hWBlXAgaWRlGGmk/ezF+NE5aswVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWNcObkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49CDC433F1;
	Fri, 15 Mar 2024 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710495084;
	bh=s5Z9V1IDdJp1r9FpEJSMgYWix7nzpkOQkdx5/fcvews=;
	h=Date:From:To:Cc:Subject:From;
	b=lWNcObkmURj/YABYghJKbZJVYj4UenqeZSRq5978pwZgwbOZV1FVX4PfmoaSGTJmT
	 aH8N4fcgD/D2zyuLoOkBDtOY2S23xPvCLsWGlaD0JFtTvFc9XNljTDpqBD6pJ/vzVw
	 BnRjddJwEjusrRmVRkFsc3OgTZ7uKGnRFyIVpwjUFErD2WTyW1QrwNmi5cytNbvFbl
	 pueQ1Rmp5J/CDgVduUC3fEeZNN3QFbGtmtM3jVHXQlZGmcquYUbeDpJbTdpcjG5P69
	 YT/hcK5asJONsN7xF821+rXVo4spqCI5nItfqYuKXQqrTdL1zSg3CGtuQktNCW5vSL
	 xnIFaMRPO1SEw==
Date: Fri, 15 Mar 2024 10:31:13 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Media Mailing List
 <linux-media@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.9-rc1] media updates
Message-ID: <20240315103113.26f9dad4@coco.lan>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
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
dia/v6.9-1

For:

- DVB budget legacy API was finally documented. It took only 20+ years
  to get some documentation about it...
- hantro driver has gained support for STM32MP25 VDEC/VENC;
- rkisp1 has gained support for i.MX8MP;
- atomisp got rid of two items from its todo list. Still 5 items pending
  for moving it out of staging;
- lots of driver fixes, cleanups and improvements.


The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.9-1

for you to fetch changes up to b14257abe7057def6127f6fb2f14f9adc8acabdb:

  media: rcar-isp: Disallow unbind of devices (2024-03-07 16:35:13 +0100)

----------------------------------------------------------------
media updates for v6.9-rc1

----------------------------------------------------------------
Aakarsh Jain (1):
      MAINTAINERS: Add entry for Samsung MFC DT Schema

Alexander Stein (4):
      media: tc358743: register v4l2 async device only after successful set=
up
      media: i2c: imx415: Convert to new CCI register access helpers
      media: i2c: imx415: Add more clock configurations
      media: i2c: imx290: Fix IMX920 typo

Andrzej Pietrasiewicz (2):
      media: videobuf2: Fix doc comment
      media: videobuf2: Add missing doc comment for waiting_in_dqbuf

Arnd Bergmann (5):
      media: sta2x11: fix irq handler cast
      media: pvrusb2: fix pvr2_stream_callback casts
      media: v4l: marvell: select CONFIG_V4L2_ASYNC where needed
      media: dvb-frontends: avoid stack overflow warnings with clang
      media: mediatek: vcodec: avoid -Wcast-function-type-strict warning

Benjamin Gaignard (1):
      media: usbtv: Remove useless locks in usbtv_video_free()

Bhavin Sharma (1):
      media: adv7180: Fix cppcheck errors

Biju Das (6):
      media: platform: rzg2l-cru: rzg2l-csi2: Switch to RUNTIME_PM_OPS()
      media: platform: rzg2l-cru: rzg2l-ip: Add delay after D-PHY reset
      media: platform: rzg2l-cru: rzg2l-video: Fix image processing initial=
ization
      media: platform: rzg2l-cru: rzg2l-csi2: Restructure vclk handling
      media: platform: rzg2l-cru: rzg2l-video: Fix start reception procedure
      media: i2c: ov5645: Remove software reset entry from ov5645_global_in=
it_setting

Bo Liu (6):
      media: i2c: imx214: convert to use maple tree register cache
      media: i2c: imx274: convert to use maple tree register cache
      media: i2c: mt9v032: convert to use maple tree register cache
      media: i2c: tvp5150: convert to use maple tree register cache
      media: i2c: max2175: convert to use maple tree register cache
      media: i2c: isl7998x: convert to use maple tree register cache

Changhuang Liang (2):
      media: cadence: csi2rx: Add enum_mbus_code pad ops
      staging: media: starfive: Set 16 bpp for capture_raw device

Christophe JAILLET (1):
      media: dvb-frontends/dvb-pll: Remove usage of the deprecated ida_simp=
le_xx() API

Colin Ian King (5):
      media: v4l2-subdev: Fix spelling mistake "heigth" -> "height"
      media: atomisp: Remove redundant assignments to variables
      media: dvb: remove redundant assignment to variable ret
      media: tda18271: remove redundant assignment to variable bcal
      media: i2c: st-vgxy61: remove redundant initialization of pointer mode

Daniil Dulov (2):
      media: go7007: add check of return value of go7007_read_addr()
      media: pvrusb2: remove redundant NULL check

Detlev Casanova (4):
      media: visl,vidtv: Set parameters permissions to 0444
      media: visl: Add a tpg_verbose parameter
      doc: media: visl: Document tpg_verbose parameter
      media: visl: Add codec specific variability on output frames

Dipendra Khadka (13):
      media: atomisp: Fix spelling mistakes in ia_css_irq.h
      media: atomisp: Fix a spelling mistake in sh_css_defs.h
      media: atomisp: Fix repeated "of" in isp2400_input_system_public.h
      media: atomisp: Fix spelling mistake in isp2400_input_system_global.h
      media: atomisp: Fix spelling mistakes in circbuf.c
      media: atomisp: Fix spelling mistake in ia_css_circbuf.h
      media: atomisp: Fix spelling mistakes in sh_css_mipi.c
      media: atomisp: Fix spelling mistakes in queue.c
      media: atomisp: Fix spelling mistakes in rmgr_vbuf.c
      media: atomisp: Fix spelling mistakes in ia_css_macc_table.host.c
      media: atomisp: Fix spelling mistakes in ia_css_hdr_types.h
      media: atomisp: Fix spelling mistake in binary.c
      media: atomisp: Fix spelling mistake in ia_css_acc_types.h

Dorcas Anono Litunya (1):
      documentation: media: vivid: Modify typo in documentation

Duc-Long, Le (1):
      media: tc358746: fix the pll calculating function

Edward Adam Davis (1):
      media: pvrusb2: fix uaf in pvr2_context_set_notify

Gui-Dong Han (1):
      media: xc4000: Fix atomicity violation in xc4000_get_frequency

Hans Verkuil (13):
      media: mediatek: vcodec: drop excess struct members descriptions
      Merge tag 'v6.8-rc2'
      media: pci: cx23885: check cx23885_vdev_init() return
      media: vidioc-subdev-g-client-cap.rst: document struct v4l2_subdev_cl=
ient_capability
      media: cx231xx: controls are from another device, mark this
      media: v4l2-ctrls: show all owned controls in log_status
      media: v4l2-common.h: kerneldoc: correctly format return values
      media: atomisp: make dbgopt static
      media: atomisp: don't use sizeof(NULL)
      media: staging: imx: controls are from another device, mark this
      media: v4l2-ctrls-core.c: check min/max for menu, controls
      media: core: v4l2-ioctl.c: use is_valid_ioctl()
      Merge tag 'tags/media-next-rkisp1-20240223' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/pinchartl/linux.git into media_stage

Hans de Goede (15):
      media: atomisp: Adjust for v4l2_subdev_state handling changes in 6.8
      media: atomisp: Refactor sensor crop + fmt setting
      media: atomisp: Remove s_routing subdev call
      media: atomisp: Remove remaining deferred firmware loading code
      media: atomisp: Drop is_valid_device() function
      media: atomisp: Call pcim_enable_device() and pcim_iomap_regions() la=
ter
      media: atomisp: Fix probe error-exit path
      media: atomisp: Fix atomisp_pci_remove()
      media: atomisp: Group cpu_latency_qos_add_request() call together wit=
h other PM calls
      media: atomisp: Fix probe()/remove() power-management
      media: atomisp: Replace atomisp_drvfs attr with using driver.dev_grou=
ps attr
      media: atomisp: Move power-management [un]init into atomisp_pm_[un]in=
it()
      media: atomisp: Bind and do power-management without firmware
      media: atomisp: Remove unnecessary msleep(10) from atomisp_mrfld_powe=
r() error path
      media: atomisp: Update TODO

Hidenori Kobayashi (1):
      media: staging: ipu3-imgu: Set fields before media_entity_pads_init()

Hugues Fruchet (5):
      media: dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
      media: hantro: add support for STM32MP25 VDEC
      media: hantro: add support for STM32MP25 VENC
      media: arm64: dts: st: add video decoder support to stm32mp255
      media: arm64: dts: st: add video encoder support to stm32mp255

Jai Luthra (2):
      media: cadence: csi2rx: add support for RGB formats
      media: ti: j721e-csi2rx: add support for RGB formats

Jason Chen (4):
      media: ov08x40: Avoid sensor probing in D0 state
      media: ov08x40: Modify the tline calculation in different modes
      media: ov08x40: Reduce start streaming time
      media: ov08x40: Reduce start streaming time

Jernej Skrabec (4):
      media: cedrus: h265: Fix configuring bitstream size
      media: sun8i-di: Fix coefficient writes
      media: sun8i-di: Fix power on/off sequences
      media: sun8i-di: Fix chroma difference threshold

Jonathan Bergh (1):
      media: atomisp: Removed duplicate comment and fixed comment format

Jonathan Corbet (1):
      staging: media: ipu3: Remove some excess struct member documentation

Julien Massot (5):
      media: cadence: csi2rx: use match fwnode for media link
      media: cadence: csi2rx: add Y8_1X8 format
      media: ti: j721e-csi2rx: add GREY format
      media: i2c: st-vgxy61: Convert to CCI register access helpers
      media: v4l2: cci: print leading 0 on error

Kells Ping (1):
      media: platform: cros-ec: Add Dita to the match table

Kevin Hao (3):
      media: dvb_frontend: Use wait_event_freezable_timeout() for freezable=
 kthread
      media: msp3400: Use wait_event_freezable_timeout() in msp_sleep()
      media: pvrusb2: Use wait_event_freezable() for freezable kthread

Krzysztof Kozlowski (27):
      media: fimc-lite: drop unused flite_hw_set_camera_polarity()
      media: fimc-lite: constify several pointers in function arguments
      media: fimc-lite: constify pointers to v4l2_pix_format_mplane
      media: fimc-is: drop unused fimc_vidioc_enum_fmt_mplane()
      media: fimc-is: constify clock names
      media: fimc-is: constify several pointers in function arguments
      media: fimc-is: constify local pointers to fimc_fmt
      media: fimc-is: constify fimc_formats array
      media: fimc-is: constify pointers to v4l2_pix_format_mplane
      media: fimc-is: constify local pointers to fimc_dma_offset
      media: fimc-is: constify local pointers to fimc_vid_cap
      media: fimc-is: constify local pointers to fimc_frame
      media: s5p-mfc: drop unused static s5p_mfc_cmds
      media: s5p-mfc: drop unused static s5p_mfc_ops
      media: s5p-mfc: drop unused get_*_def_fmt declarations
      media: s5p-mfc: constify fw_name strings
      media: s5p-mfc: constify s5p_mfc_buf_size structures
      media: s5p-mfc: constify s5p_mfc_variant structures
      media: s5p-mfc: constify s5p_mfc_hw_cmds structures
      media: s5p-mfc: constify s5p_mfc_hw_ops structures
      media: s5p-mfc: constify s5p_mfc_fmt structures
      media: s5p-mfc: constify struct structures
      media: s5p-mfc: constify pointers to s5p_mfc_cmd_args
      media: s5p-mfc: constify local pointers to s5p_mfc_enc_params
      media: s5p-mfc: drop useless clock refcnt debugging
      media: s5p-mfc: drop useless static s5p_mfc_dev in s5p_mfc_pm.c
      media: s5p-mfc: drop static device variable in s5p_mfc_pm.c

Kuninori Morimoto (2):
      media: i2c: replace of_graph_get_next_endpoint()
      media: platform: replace of_graph_get_next_endpoint()

Laurent Pinchart (8):
      media: mc: Add local pad to pipeline regardless of the link state
      media: mc: Fix flags handling when creating pad links
      media: mc: Add num_links flag to media_pad
      media: mc: Rename pad variable to clarify intent
      media: mc: Expand MUST_CONNECT flag to always require an enabled link
      media: nxp: imx8-isi: Mark all crossbar sink pads as MUST_CONNECT
      media: rkisp1: Add and use rkisp1_has_feature() macro
      media: rkisp1: Configure gasket on i.MX8MP

Lucas Stach (1):
      media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak

Marek Vasut (1):
      media: nxp: imx8-isi: Check whether crossbar pad is non-NULL before a=
ccess

Markus Elfring (1):
      media: ti: Use devm_platform_ioremap_resource() in ti_csi2rx_probe()

Matthias Fend (1):
      media: imx335: Add support for test pattern generator

Matthias Schwarzott (1):
      media: zl10036: Fix my email address

Michal Simek (1):
      media: platform: xilinx: Fix Kconfig indentation

Ming Qian (2):
      media: imx-jpeg: Support for negotiating bytesperline with client
      media: amphion: Abort vpu parsing directly in seek

Moudy Ho (12):
      media: platform: mtk-mdp3: add support second sets of MMSYS
      media: platform: mtk-mdp3: add support second sets of MUTEX
      media: platform: mtk-mdp3: introduce more pipelines from MT8195
      media: platform: mtk-mdp3: introduce more MDP3 components
      media: platform: mtk-mdp3: add checks for dummy components
      media: platform: mtk-mdp3: avoid multiple driver registrations
      media: platform: mtk-mdp3: extend GCE event waiting in RDMA and WROT
      media: platform: mtk-mdp3: add support for blending multiple componen=
ts
      media: platform: mtk-mdp3: add mt8195 platform configuration
      media: platform: mtk-mdp3: add mt8195 shared memory configurations
      media: platform: mtk-mdp3: add mt8195 MDP3 component settings
      media: platform: mtk-mdp3: add support for parallel pipe to improve F=
PS

Nikita Zhandarovich (1):
      media: em28xx: annotate unchecked call to media_device_register()

Niklas S=C3=B6derlund (2):
      media: rcar-csi2: Move driver to renesas directory
      media: rcar-isp: Disallow unbind of devices

Nini Song (1):
      media: cec: core: remove length check of Timer Status

Ondrej Jirman (1):
      media: i2c: dw9714: Fix occasional probe errors

Paul Elder (10):
      media: rkisp1: Support setting memory stride for main path
      media: rkisp1: Support devices lacking self path
      media: rkisp1: Support devices lacking dual crop
      dt-bindings: media: rkisp1: Add i.MX8MP ISP to compatible
      media: rkisp1: Add version enum for i.MX8MP ISP
      media: rkisp1: Support i.MX8MP's 34-bit DMA
      media: rkisp1: Add YC swap capability
      media: rkisp1: Add UYVY as an output format
      media: rkisp1: Fix endianness on raw streams on i.MX8MP
      media: rkisp1: Add match data for i.MX8MP ISP

Philipp Stanner (1):
      media: drivers/media/dvb-core: copy user arrays safely

Randy Dunlap (2):
      media: media-entity.h: fix Excess kernel-doc description warnings
      media: i2c: ar0521: fix spellos

Ricardo B. Marliere (3):
      media: cec: make cec_bus_type const
      media: media-devnode: make media_bus_type const
      media: bt8xx: make bttv_sub_bus_type const

Ricardo Ribalda (15):
      media: videodev2.h: Fix kerneldoc
      media: cec.h: Fix kerneldoc
      media: pci: dt315.h: Fix kerneldoc
      media: i2c: css-quirk.h: Fix kerneldoc
      media: i2c: adv748: Fix kerneldoc
      media: mediatek: jpeg: Fix kerneldoc
      media: mediatek: vcodec: Fix kerneldoc
      media: verisilicon: Fix kerneldoc
      media: qcom: venus: Fix kerneldoc
      media: samsung: exynos4-is: Fix kerneldoc
      media: samsung: s5p-mfc: Fix kerneldoc
      media: dvb-usb: Fix kerneldoc
      media: staging: meson: Fix kerneldoc
      media: nxp: imx8-isi: Factor out a variable
      media: usb: s2255: Refactor s2255_get_fx2fw

Rob Herring (1):
      media: dt-bindings: techwell,tw9900: Fix port schema ref

Sakari Ailus (14):
      media: ipu3-cio2: Further clean up async subdev link creation
      media: v4l2-mc: Add debug prints for v4l2_fwnode_create_links_for_pad=
()
      media: mc: Drop useless debug print on file handle release
      media: Documentation: Rework CCS driver documentation
      media: v4l: Add a helper for setting up link-frequencies control
      media: imx334: Use v4l2_link_freq_to_bitmap helper
      media: imx319: Use v4l2_link_freq_to_bitmap helper
      media: imx355: Use v4l2_link_freq_to_bitmap helper
      Revert "media: ov08x40: Reduce start streaming time"
      media: ipu-bridge: Add ov01a10 in Dell XPS 9315
      media: ipu-bridge: Move graph checking to IPU bridge
      media: ipu-bridge: Serialise calls to IPU bridge init
      media: ivsc: csi: Swap SINK and SOURCE pads
      media: ivsc: csi: Make use of sub-device state

Stefan Herdler (6):
      media: docs: uAPI: dvb/osd: completing the documentation
      media: docs: uAPI: dvb/audio: completing the documentation (data type=
s)
      media: docs: uAPI: dvb/audio: completing the documentation (function =
calls)
      media: docs: uAPI: dvb/video: completing the documentation (data type=
s)
      media: docs: uAPI: dvb/video: completing the documentation (function =
calls)
      media: docs: uAPI: dvb/decoder: completing the documentation

Thorsten Blum (1):
      media: chips-media: wave5: Remove unnecessary semicolons

Tommaso Merciai (5):
      media: i2c: alvium: removal of dft_fr, min_fr and max_fr
      media: i2c: alvium: remove the fr field of the alvium_dev structure
      media: i2c: alvium: inline set_frame_interval into s_frame_interval
      media: i2c: alvium: store frame interval in subdev state
      media: i2c: alvium: fix req_fr check in alvium_s_frame_interval()

Umang Jain (4):
      media: imx335: Set reserved register to default value
      media: imx335: Use v4l2_link_freq_to_bitmap helper
      media: imx335: Support multiple link frequency
      media: imx335: Refactor power sequence to set controls

Uwe Kleine-K=C3=B6nig (5):
      media: chips-media: wave5: Convert to platform remove callback return=
ing void
      media: nuvoton: Convert to platform remove callback returning void
      media: nxp: imx8-isi: Convert to platform remove callback returning v=
oid
      media: stm32-dcmipp: Convert to platform remove callback returning vo=
id
      media: ti: j721e-csi2rx: Convert to platform remove callback returnin=
g void

Vincenzo Mezzela (1):
      docs: media: fix typo in docs

XueBing Chen (5):
      media: cx24110: clean up some coding style issues
      media: dvb-frontends: Clean up errors in cx24110.h
      media: stv6110x: Clean up errors in stv6110x.h
      media: Clean up errors in bcm3510_priv.h
      media: dvb-frontends: Clean up errors in tda8083.h

Yang Li (1):
      media: mediatek: vcodec: Remove unneeded semicolon

Zhipeng Lu (5):
      media: v4l2-tpg: fix some memleaks in tpg_alloc
      media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity
      media: edia: dvbdev: fix a use-after-free
      media: go7007: fix a memleak in go7007_load_encoder
      media: ttpci: fix two memleaks in budget_av_attach

renjun wang (1):
      media: verisilicon: Fix some typos

 Documentation/admin-guide/media/visl.rst           |   12 +-
 Documentation/admin-guide/media/vivid.rst          |    2 +-
 .../bindings/media/i2c/techwell,tw9900.yaml        |    2 +-
 .../devicetree/bindings/media/rockchip-isp1.yaml   |   37 +-
 .../bindings/media/st,stm32mp25-video-codec.yaml   |   49 +
 Documentation/driver-api/media/drivers/ccs/ccs.rst |   53 +-
 Documentation/driver-api/media/v4l2-subdev.rst     |    2 +-
 Documentation/userspace-api/media/drivers/ccs.rst  |    6 +-
 .../userspace-api/media/dvb/legacy_dvb_apis.rst    |    1 +
 .../userspace-api/media/dvb/legacy_dvb_audio.rst   | 1642 +++++++++++++
 .../media/dvb/legacy_dvb_decoder_api.rst           |   61 +
 .../userspace-api/media/dvb/legacy_dvb_osd.rst     |  883 +++++++
 .../userspace-api/media/dvb/legacy_dvb_video.rst   | 2430 ++++++++++++++++=
++++
 .../userspace-api/media/mediactl/media-types.rst   |   11 +-
 .../media/v4l/vidioc-subdev-g-client-cap.rst       |   15 +
 MAINTAINERS                                        |    2 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |   12 +
 arch/arm64/boot/dts/st/stm32mp255.dtsi             |   17 +
 drivers/media/cec/core/cec-adap.c                  |   14 -
 drivers/media/cec/core/cec-core.c                  |    2 +-
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c   |    2 +
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c      |   52 +-
 drivers/media/dvb-core/dvb_frontend.c              |   25 +-
 drivers/media/dvb-core/dvbdev.c                    |    5 +
 drivers/media/dvb-frontends/bcm3510.c              |    3 +-
 drivers/media/dvb-frontends/bcm3510_priv.h         |    6 +-
 drivers/media/dvb-frontends/cx24110.c              |    4 +-
 drivers/media/dvb-frontends/cx24110.h              |    8 +-
 drivers/media/dvb-frontends/dvb-pll.c              |    6 +-
 drivers/media/dvb-frontends/stv0367.c              |   34 +-
 drivers/media/dvb-frontends/stv6110x_priv.h        |    8 +-
 drivers/media/dvb-frontends/tda8083.h              |    8 +-
 drivers/media/dvb-frontends/zl10036.c              |    2 +-
 drivers/media/dvb-frontends/zl10036.h              |    2 +-
 drivers/media/i2c/Kconfig                          |    2 +
 drivers/media/i2c/adv7180.c                        |    4 +-
 drivers/media/i2c/adv7343.c                        |    2 +-
 drivers/media/i2c/adv748x/adv748x.h                |    1 -
 drivers/media/i2c/adv7604.c                        |    4 +-
 drivers/media/i2c/alvium-csi2.c                    |  101 +-
 drivers/media/i2c/alvium-csi2.h                    |    5 -
 drivers/media/i2c/ar0521.c                         |    6 +-
 drivers/media/i2c/ccs/ccs-quirk.h                  |    8 +-
 drivers/media/i2c/dw9714.c                         |    2 +
 drivers/media/i2c/imx214.c                         |    2 +-
 drivers/media/i2c/imx274.c                         |    2 +-
 drivers/media/i2c/imx290.c                         |   16 +-
 drivers/media/i2c/imx319.c                         |   53 +-
 drivers/media/i2c/imx334.c                         |   41 +-
 drivers/media/i2c/imx335.c                         |  251 +-
 drivers/media/i2c/imx355.c                         |   53 +-
 drivers/media/i2c/imx415.c                         |  672 ++++--
 drivers/media/i2c/isl7998x.c                       |    2 +-
 drivers/media/i2c/max2175.c                        |    2 +-
 drivers/media/i2c/msp3400-driver.c                 |   22 +-
 drivers/media/i2c/msp3400-driver.h                 |    2 +-
 drivers/media/i2c/mt9p031.c                        |    2 +-
 drivers/media/i2c/mt9v032.c                        |    4 +-
 drivers/media/i2c/ov08x40.c                        | 1307 ++---------
 drivers/media/i2c/ov2659.c                         |    2 +-
 drivers/media/i2c/ov5645.c                         |    7 +-
 drivers/media/i2c/ov5647.c                         |    2 +-
 drivers/media/i2c/s5c73m3/s5c73m3-core.c           |    2 +-
 drivers/media/i2c/s5k5baf.c                        |    2 +-
 drivers/media/i2c/st-vgxy61.c                      |  392 ++--
 drivers/media/i2c/tc358743.c                       |    9 +-
 drivers/media/i2c/tc358746.c                       |    4 +-
 drivers/media/i2c/tda1997x.c                       |    2 +-
 drivers/media/i2c/tvp514x.c                        |    2 +-
 drivers/media/i2c/tvp5150.c                        |    2 +-
 drivers/media/i2c/tvp7002.c                        |    2 +-
 drivers/media/mc/mc-devnode.c                      |    3 +-
 drivers/media/mc/mc-entity.c                       |   93 +-
 drivers/media/pci/bt8xx/bttv-gpio.c                |    2 +-
 drivers/media/pci/bt8xx/bttvp.h                    |    2 +-
 drivers/media/pci/cx23885/cx23885-video.c          |    8 +
 drivers/media/pci/dt3155/dt3155.h                  |    1 -
 drivers/media/pci/intel/ipu-bridge.c               |   26 +
 drivers/media/pci/intel/ipu3/ipu3-cio2.c           |   53 +-
 drivers/media/pci/intel/ivsc/mei_csi.c             |   87 +-
 drivers/media/pci/sta2x11/sta2x11_vip.c            |    9 +-
 drivers/media/pci/ttpci/budget-av.c                |    8 +-
 drivers/media/platform/amphion/vdec.c              |    4 +-
 drivers/media/platform/atmel/atmel-isi.c           |    4 +-
 drivers/media/platform/cadence/cdns-csi2rx.c       |   19 +-
 .../media/platform/chips-media/wave5/wave5-hw.c    |    2 +-
 .../platform/chips-media/wave5/wave5-vpu-enc.c     |    2 +-
 .../media/platform/chips-media/wave5/wave5-vpu.c   |    6 +-
 drivers/media/platform/intel/pxa_camera.c          |    2 +-
 drivers/media/platform/marvell/Kconfig             |    2 +
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.h   |    1 -
 drivers/media/platform/mediatek/mdp/mtk_mdp_vpu.c  |    2 +-
 .../media/platform/mediatek/mdp3/mdp_cfg_data.c    |  729 +++++-
 drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h |   25 +
 .../media/platform/mediatek/mdp3/mdp_reg_color.h   |   31 +
 drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h  |   23 +
 drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h |   31 +
 .../media/platform/mediatek/mdp3/mdp_reg_merge.h   |   25 +
 drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h |   25 +
 drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h |   21 +
 .../media/platform/mediatek/mdp3/mdp_reg_rdma.h    |   24 +
 drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h |    2 +
 .../media/platform/mediatek/mdp3/mdp_reg_tdshp.h   |   34 +
 .../media/platform/mediatek/mdp3/mdp_reg_wrot.h    |    8 +
 .../media/platform/mediatek/mdp3/mdp_sm_mt8195.h   |  283 +++
 drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h |    4 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-cfg.h    |    2 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   |  440 +++-
 .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h   |    1 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   |  895 ++++++-
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.h   |   93 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |  142 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |   50 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.c    |   15 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-regs.c   |   18 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-regs.h   |    1 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-vpu.c    |    3 +-
 .../mediatek/vcodec/common/mtk_vcodec_fw_vpu.c     |   10 +-
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.h       |    1 -
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c      |   14 +-
 .../mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c |    1 -
 .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c      |    1 -
 .../platform/mediatek/vcodec/decoder/vdec_vpu_if.h |    1 -
 .../mediatek/vcodec/encoder/mtk_vcodec_enc.h       |    1 -
 drivers/media/platform/mediatek/vpu/mtk_vpu.c      |    2 +-
 drivers/media/platform/mediatek/vpu/mtk_vpu.h      |    2 +-
 drivers/media/platform/nuvoton/npcm-video.c        |    6 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     |   16 +
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h     |    1 +
 .../media/platform/nxp/imx8-isi/imx8-isi-core.c    |    6 +-
 .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      |    4 +-
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c  |    8 +-
 drivers/media/platform/qcom/venus/core.h           |    1 -
 drivers/media/platform/renesas/Kconfig             |   16 +
 drivers/media/platform/renesas/Makefile            |    1 +
 .../platform/renesas/{rcar-vin =3D> }/rcar-csi2.c    |    0
 drivers/media/platform/renesas/rcar-isp.c          |    1 +
 drivers/media/platform/renesas/rcar-vin/Kconfig    |   16 -
 drivers/media/platform/renesas/rcar-vin/Makefile   |    1 -
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h   |    3 -
 .../media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  |   37 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-ip.c    |   18 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c |   83 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c      |  216 +-
 .../media/platform/rockchip/rkisp1/rkisp1-common.h |   35 +-
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |   71 +-
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  131 +-
 .../media/platform/rockchip/rkisp1/rkisp1-regs.h   |   36 +
 .../platform/rockchip/rkisp1/rkisp1-resizer.c      |   19 +-
 .../platform/samsung/exynos4-is/fimc-capture.c     |   52 +-
 .../media/platform/samsung/exynos4-is/fimc-core.c  |   23 +-
 .../media/platform/samsung/exynos4-is/fimc-core.h  |   23 +-
 .../media/platform/samsung/exynos4-is/fimc-is.c    |    2 +-
 .../platform/samsung/exynos4-is/fimc-isp-video.c   |    2 +-
 .../platform/samsung/exynos4-is/fimc-lite-reg.c    |   13 +-
 .../platform/samsung/exynos4-is/fimc-lite-reg.h    |   12 +-
 .../media/platform/samsung/exynos4-is/fimc-lite.c  |    2 +-
 .../media/platform/samsung/exynos4-is/fimc-lite.h  |    3 -
 .../media/platform/samsung/exynos4-is/fimc-m2m.c   |   23 +-
 .../media/platform/samsung/exynos4-is/fimc-reg.c   |   38 +-
 .../media/platform/samsung/exynos4-is/fimc-reg.h   |   10 +-
 .../media/platform/samsung/exynos4-is/mipi-csis.c  |    3 +-
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c   |   76 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_cmd.c   |    8 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_cmd.h   |    2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c      |    6 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h      |    2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c      |    8 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h      |    2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h      |   15 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c  |   26 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_dec.c   |   20 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_dec.h   |    3 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_enc.c   |   12 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_enc.h   |    3 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_opr.c   |    7 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c      |   28 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.h      |    2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c      |   36 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h      |    2 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_pm.c    |   51 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_pm.h    |    8 +-
 drivers/media/platform/st/stm32/stm32-dcmi.c       |    4 +-
 .../platform/st/stm32/stm32-dcmipp/dcmipp-core.c   |    6 +-
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c   |   69 +-
 drivers/media/platform/ti/davinci/vpif.c           |    3 +-
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  |   35 +-
 drivers/media/platform/verisilicon/Kconfig         |   14 +-
 drivers/media/platform/verisilicon/Makefile        |    3 +
 drivers/media/platform/verisilicon/hantro.h        |    1 -
 drivers/media/platform/verisilicon/hantro_drv.c    |    4 +
 .../platform/verisilicon/hantro_g1_h264_dec.c      |    2 +-
 drivers/media/platform/verisilicon/hantro_hw.h     |    2 +
 .../verisilicon/rockchip_vpu2_hw_h264_dec.c        |    2 +-
 .../platform/verisilicon/rockchip_vpu981_regs.h    |    2 +-
 .../media/platform/verisilicon/stm32mp25_vpu_hw.c  |  186 ++
 drivers/media/platform/xilinx/Kconfig              |    4 +-
 drivers/media/test-drivers/vidtv/vidtv_bridge.c    |   26 +-
 drivers/media/test-drivers/visl/visl-core.c        |   15 +-
 drivers/media/test-drivers/visl/visl-dec.c         |  301 ++-
 drivers/media/test-drivers/visl/visl.h             |    1 +
 drivers/media/tuners/tda18271-fe.c                 |    1 -
 drivers/media/tuners/xc4000.c                      |    4 +-
 drivers/media/usb/cx231xx/cx231xx-417.c            |    2 +-
 drivers/media/usb/dvb-usb/dvb-usb.h                |    2 -
 drivers/media/usb/em28xx/em28xx-cards.c            |    4 +
 drivers/media/usb/go7007/go7007-driver.c           |    8 +-
 drivers/media/usb/go7007/go7007-usb.c              |    4 +-
 drivers/media/usb/pvrusb2/pvrusb2-context.c        |   10 +-
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c            |   12 +-
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c           |   11 +-
 drivers/media/usb/s2255/s2255drv.c                 |    7 +-
 drivers/media/usb/usbtv/usbtv-video.c              |    7 -
 drivers/media/v4l2-core/v4l2-cci.c                 |    4 +-
 drivers/media/v4l2-core/v4l2-common.c              |   47 +
 drivers/media/v4l2-core/v4l2-ctrls-api.c           |    2 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |   23 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    2 +-
 drivers/media/v4l2-core/v4l2-mc.c                  |   23 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             |   10 +-
 drivers/staging/media/atomisp/TODO                 |   10 -
 drivers/staging/media/atomisp/i2c/gc2235.h         |    5 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |  133 +-
 .../media/atomisp/pci/atomisp_compat_css20.c       |    2 +-
 drivers/staging/media/atomisp/pci/atomisp_drvfs.c  |  144 +-
 drivers/staging/media/atomisp/pci/atomisp_drvfs.h  |    5 +-
 .../staging/media/atomisp/pci/atomisp_internal.h   |    5 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |   60 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |  319 ++-
 .../pci/base/circbuf/interface/ia_css_circbuf.h    |    2 +-
 .../media/atomisp/pci/base/circbuf/src/circbuf.c   |    6 +-
 .../staging/media/atomisp/pci/ia_css_acc_types.h   |    4 +-
 drivers/staging/media/atomisp/pci/ia_css_control.h |   29 +-
 .../staging/media/atomisp/pci/ia_css_firmware.h    |    6 +-
 drivers/staging/media/atomisp/pci/ia_css_irq.h     |    6 +-
 .../atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h |    4 +-
 .../kernels/macc/macc_1.0/ia_css_macc_table.host.c |    4 +-
 .../atomisp/pci/isp2400_input_system_global.h      |    2 +-
 .../atomisp/pci/isp2400_input_system_public.h      |    2 +-
 .../media/atomisp/pci/runtime/binary/src/binary.c  |    2 +-
 .../atomisp/pci/runtime/pipeline/src/pipeline.c    |    2 +-
 .../media/atomisp/pci/runtime/queue/src/queue.c    |   22 +-
 .../media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c |    6 +-
 drivers/staging/media/atomisp/pci/sh_css.c         |   35 +-
 drivers/staging/media/atomisp/pci/sh_css_defs.h    |    2 +-
 drivers/staging/media/atomisp/pci/sh_css_mipi.c    |    4 +-
 drivers/staging/media/imx/imx-media-csc-scaler.c   |    1 +
 drivers/staging/media/imx/imx-media-fim.c          |    2 +-
 .../staging/media/ipu3/include/uapi/intel-ipu3.h   |    3 -
 drivers/staging/media/ipu3/ipu3-v4l2.c             |   16 +-
 drivers/staging/media/meson/vdec/vdec.h            |    1 -
 drivers/staging/media/starfive/camss/stf-capture.c |    8 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c   |   10 +-
 include/media/cec.h                                |    2 -
 include/media/media-entity.h                       |    6 +-
 include/media/v4l2-common.h                        |   32 +-
 include/media/videobuf2-core.h                     |   15 +-
 include/uapi/linux/rkisp1-config.h                 |   50 +-
 include/uapi/linux/videodev2.h                     |   32 +-
 259 files changed, 11089 insertions(+), 3728 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-vi=
deo-codec.yaml
 create mode 100644 Documentation/userspace-api/media/dvb/legacy_dvb_audio.=
rst
 create mode 100644 Documentation/userspace-api/media/dvb/legacy_dvb_decode=
r_api.rst
 create mode 100644 Documentation/userspace-api/media/dvb/legacy_dvb_osd.rst
 create mode 100644 Documentation/userspace-api/media/dvb/legacy_dvb_video.=
rst
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_color.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_merge.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_sm_mt8195.h
 rename drivers/media/platform/renesas/{rcar-vin =3D> }/rcar-csi2.c (100%)
 create mode 100644 drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c


