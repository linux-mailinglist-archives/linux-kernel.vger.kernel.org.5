Return-Path: <linux-kernel+bounces-106917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B80D87F564
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650B4282788
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B026518F;
	Tue, 19 Mar 2024 02:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htVMaUpC"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC464CE1;
	Tue, 19 Mar 2024 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815104; cv=none; b=fHaC8nu+mzjCev5C7WBME5t165DwnVyaPeK2hAgy0c9rJXvMgsVz9VActgq0RFtzjzRl4najRaFu1QqtL4O2U19gLgZMNriSlhbAPabGFAyBRtLVgBi4XR+qI+UktFYHld61aKtQXBwQgtM/cu87tY6FOeSpFeSHtoCTiRJ7DWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815104; c=relaxed/simple;
	bh=FC6+/aI7BBUs6BF1uhfaUOKbhxkDFustrqUVR7+Fhf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjNFsoIRu0dsI3nrzWL11AGn1D2OPROEZXU1cgNnSLvNA6Vi4hHWESadpkPLx9bmFZ/fGKwQ3meZMgutziXBjHEHTl0yAId/+09MXbnOJ6dYSJMKGfYCjTubfn5O1qBCj+Kyf+jRWfjUe1RXsVL/UxQMpR13VwUKIME6Tb21zRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htVMaUpC; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7cc77e74b5cso64526139f.2;
        Mon, 18 Mar 2024 19:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710815101; x=1711419901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jXxbFRn7aUJ8vbwC+W7tuBl2ook1tIt1JLVdpl6uzA=;
        b=htVMaUpCuCtfkhNCQI/ADf6QmutFJAv7FbLnuQQpq7j0EYCTtYY5/bKgiTFROMwl3L
         9dYhCyuT0kbwwPMkyLNlAP82UMU6EPf10QZpRjaEt7xGuhxXaIe0bb9kUb2/rhwpzVlw
         vw1Hwd5xW09rM33sQ8MwOBT0a+NVbggFncXA+eR/aI9lapf6ANIALO2tChCX78VU3FPq
         wyz3JBMdP/rCbLKRPP9lmwXSffKhP5e/78egdlVDH4jYmGCy9wjY03LWlLrNVurGz5Yx
         xFWEviDDbF2I5mm60+GXwEdK4JXmJhWkEBnGEBpswDVJiTTucGdHzyYBaVaO23DVXDH+
         O8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710815101; x=1711419901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jXxbFRn7aUJ8vbwC+W7tuBl2ook1tIt1JLVdpl6uzA=;
        b=Fp8QDJ/unDmNTj0MyNueJ0v5q5LSHRQg11EF89Fw+NfsxeBXH1fuZOxNu74kDmQ0SA
         lxCUQ2wCA4fiYSB9CAzoWrJmWLUe0PTaCO+rccHWc/aJCRx7UoOgqAUHwYiAIP1irroA
         45s5YeqVSNkzNlPwyoEZ5D/Z4BB3gB6R9H12l2aHR17Uq6e1GzVk2pM/k79DPiWKxa76
         hR1vtzYOxuEVHVZHnD9veKngraRAUzMCxwu7yNh6z/VO0Xim+lxTmuunhiQ14ZI0ib1l
         CkxtEcQZyhqQ0HF41c2EQD9fnMYKZgsIFTaIkx6FLO5Ye/wiDhmP/OSuTaqKd5P0Q95C
         RJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK95OdDfn+XjpsdF0TIrQiI6BadlYzx6FfMtPZExWDD8o6NXYF/BQAXLmwtUSKS/iIbqmb6Ydka/ilepFma9BQu0QU3NrVcagpZ5DATatVLSQUDrZNHD/jU3MzM3iitsdykAO+3Kvuxj4=
X-Gm-Message-State: AOJu0YwBiKD0DqVRdmtUhKZH4HPvnBm3Bm17cimD9bu+/VaaU9U+U3ry
	Zl8XRJzEbnCAdQoURehWsDQNDY5WWx2tnp912serR7zlpRS0tTC2czx1P1FPJS/6GHT2LL3k3+J
	yFmVdqCLdp1e5KoBhYJBi2i4DcuI=
X-Google-Smtp-Source: AGHT+IGnWR3B9g/WoAwOtaoEM89k4iilEqv+3OCoq6B4OwhrLulsTXLE02G/egyZDtycYkHZLV95uXfPr1KhQx7ol+4=
X-Received: by 2002:a05:6e02:1142:b0:366:a289:2fc6 with SMTP id
 o2-20020a056e02114200b00366a2892fc6mr10994035ill.7.1710815100818; Mon, 18 Mar
 2024 19:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710150841-26991-1-git-send-email-shengjiu.wang@nxp.com> <399da377-c2b6-4226-9108-8a1e776b6f3b@xs4all.nl>
In-Reply-To: <399da377-c2b6-4226-9108-8a1e776b6f3b@xs4all.nl>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 19 Mar 2024 10:24:49 +0800
Message-ID: <CAA+D8APgFvATshUJCNxCynJsYr_6=A+V=xf5qFpimd4i4g1ygg@mail.gmail.com>
Subject: Re: [PATCH v14 00/16] Add audio support in v4l2 framework
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi, tfiga@chromium.org, 
	m.szyprowski@samsung.com, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:56=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> =
wrote:
>
> Hi Shengjiu,
>
> I was about to prepare a pull request for this when I realized that
> entries for the new drivers need to be added to the MAINTAINERS file.
>
> Can you post patches 'v14 17/16' and 'v14/18/16' adding entries for each
> new driver?

Ok,  How about the change below?

VIRTUAL MEM2MEM DRIVER FOR AUDIO
M:      Hans Verkuil <hverkuil@xs4all.nl>
M:      Shengjiu Wang <shengjiu.wang@gmail.com>
L:      linux-media@vger.kernel.org
S:      Maintained
W:      https://linuxtv.org
T:      git git://linuxtv.org/media_tree.git
F:      drivers/media/test-drivers/vim2m-audio.c

NXP ASRC V4L2 MEM2MEM DRIVERS
M:      Shengjiu Wang <shengjiu.wang@gmail.com>
L:      linux-media@vger.kernel.org
S:      Maintained
W:      https://linuxtv.org
T:      git git://linuxtv.org/media_tree.git
F:      drivers/media/platform/nxp/imx-asrc.c

best regards
wang shengjiu

>
> Thank you,
>
>         Hans
>
> On 11/03/2024 10:53 am, Shengjiu Wang wrote:
> > Audio signal processing also has the requirement for memory to
> > memory similar as Video.
> >
> > This asrc memory to memory (memory ->asrc->memory) case is a non
> > real time use case.
> >
> > User fills the input buffer to the asrc module, after conversion, then =
asrc
> > sends back the output buffer to user. So it is not a traditional ALSA p=
layback
> > and capture case.
> >
> > It is a specific use case,  there is no reference in current kernel.
> > v4l2 memory to memory is the closed implementation,  v4l2 current
> > support video, image, radio, tuner, touch devices, so it is not
> > complicated to add support for this specific audio case.
> >
> > Because we had implemented the "memory -> asrc ->i2s device-> codec"
> > use case in ALSA.  Now the "memory->asrc->memory" needs
> > to reuse the code in asrc driver, so the first 3 patches is for refinin=
g
> > the code to make it can be shared by the "memory->asrc->memory"
> > driver.
> >
> > The main change is in the v4l2 side, A /dev/vl4-audioX will be created,
> > user applications only use the ioctl of v4l2 framework.
> >
> > Other change is to add memory to memory support for two kinds of i.MX A=
SRC
> > module.
> >
> > changes in v14:
> > - document the reservation of 'AUXX' fourcc format.
> > - add v4l2_audfmt_to_fourcc() definition.
> >
> > changes in v13
> > - change 'pixelformat' to 'audioformat' in dev-audio-mem2mem.rst
> > - add more description for clock drift in ext-ctrls-audio-m2m.rst
> > - Add "media: v4l2-ctrls: add support for fraction_bits" from Hans
> >   to avoid build issue for kernel test robot
> >
> > changes in v12
> > - minor changes according to comments
> > - drop min_buffers_needed =3D 1 and V4L2_CTRL_FLAG_UPDATE flag
> > - drop bus_info
> >
> > changes in v11
> > - add add-fixed-point-test-controls in vivid.
> > - add v4l2_ctrl_fp_compose() helper function for min and max
> >
> > changes in v10
> > - remove FIXED_POINT type
> > - change code base on media: v4l2-ctrls: add support for fraction_bits
> > - fix issue reported by kernel test robot
> > - remove module_alias
> >
> > changes in v9:
> > - add MEDIA_ENT_F_PROC_AUDIO_RESAMPLER.
> > - add MEDIA_INTF_T_V4L_AUDIO
> > - add media controller support
> > - refine the vim2m-audio to support 8k<->16k conversion.
> >
> > changes in v8:
> > - refine V4L2_CAP_AUDIO_M2M to be 0x00000008
> > - update doc for FIXED_POINT
> > - address comments for imx-asrc
> >
> > changes in v7:
> > - add acked-by from Mark
> > - separate commit for fixed point, m2m audio class, audio rate controls
> > - use INTEGER_MENU for rate,  FIXED_POINT for rate offset
> > - remove used fmts
> > - address other comments for Hans
> >
> > changes in v6:
> > - use m2m_prepare/m2m_unprepare/m2m_start/m2m_stop to replace
> >   m2m_start_part_one/m2m_stop_part_one, m2m_start_part_two/m2m_stop_par=
t_two.
> > - change V4L2_CTRL_TYPE_ASRC_RATE to V4L2_CTRL_TYPE_FIXED_POINT
> > - fix warning by kernel test rebot
> > - remove some unused format V4L2_AUDIO_FMT_XX
> > - Get SNDRV_PCM_FORMAT from V4L2_AUDIO_FMT in driver.
> > - rename audm2m to viaudm2m.
> >
> > changes in v5:
> > - remove V4L2_AUDIO_FMT_LPCM
> > - define audio pixel format like V4L2_AUDIO_FMT_S8...
> > - remove rate and format in struct v4l2_audio_format.
> > - Add V4L2_CID_ASRC_SOURCE_RATE and V4L2_CID_ASRC_DEST_RATE controls
> > - updata document accordingly.
> >
> > changes in v4:
> > - update document style
> > - separate V4L2_AUDIO_FMT_LPCM and V4L2_CAP_AUDIO_M2M in separate commi=
t
> >
> > changes in v3:
> > - Modify documents for adding audio m2m support
> > - Add audio virtual m2m driver
> > - Defined V4L2_AUDIO_FMT_LPCM format type for audio.
> > - Defined V4L2_CAP_AUDIO_M2M capability type for audio m2m case.
> > - with modification in v4l-utils, pass v4l2-compliance test.
> >
> > changes in v2:
> > - decouple the implementation in v4l2 and ALSA
> > - implement the memory to memory driver as a platfrom driver
> >   and move it to driver/media
> > - move fsl_asrc_common.h to include/sound folder
> >
> > Hans Verkuil (1):
> >   media: v4l2-ctrls: add support for fraction_bits
> >
> > Shengjiu Wang (15):
> >   ASoC: fsl_asrc: define functions for memory to memory usage
> >   ASoC: fsl_easrc: define functions for memory to memory usage
> >   ASoC: fsl_asrc: move fsl_asrc_common.h to include/sound
> >   ASoC: fsl_asrc: register m2m platform device
> >   ASoC: fsl_easrc: register m2m platform device
> >   media: uapi: Add V4L2_CAP_AUDIO_M2M capability flag
> >   media: v4l2: Add audio capture and output support
> >   media: uapi: Define audio sample format fourcc type
> >   media: uapi: Add V4L2_CTRL_CLASS_M2M_AUDIO
> >   media: uapi: Add audio rate controls support
> >   media: uapi: Declare interface types for Audio
> >   media: uapi: Add an entity type for audio resampler
> >   media: vivid: add fixed point test controls
> >   media: imx-asrc: Add memory to memory driver
> >   media: vim2m-audio: add virtual driver for audio memory to memory
> >
> >  .../media/mediactl/media-types.rst            |   11 +
> >  .../userspace-api/media/v4l/buffer.rst        |    6 +
> >  .../userspace-api/media/v4l/common.rst        |    1 +
> >  .../media/v4l/dev-audio-mem2mem.rst           |   71 +
> >  .../userspace-api/media/v4l/devices.rst       |    1 +
> >  .../media/v4l/ext-ctrls-audio-m2m.rst         |   59 +
> >  .../userspace-api/media/v4l/pixfmt-audio.rst  |  100 ++
> >  .../userspace-api/media/v4l/pixfmt.rst        |    1 +
> >  .../media/v4l/vidioc-enum-fmt.rst             |    2 +
> >  .../media/v4l/vidioc-g-ext-ctrls.rst          |    4 +
> >  .../userspace-api/media/v4l/vidioc-g-fmt.rst  |    4 +
> >  .../media/v4l/vidioc-querycap.rst             |    3 +
> >  .../media/v4l/vidioc-queryctrl.rst            |   11 +-
> >  .../media/videodev2.h.rst.exceptions          |    3 +
> >  .../media/common/videobuf2/videobuf2-v4l2.c   |    4 +
> >  drivers/media/platform/nxp/Kconfig            |   13 +
> >  drivers/media/platform/nxp/Makefile           |    1 +
> >  drivers/media/platform/nxp/imx-asrc.c         | 1256 +++++++++++++++++
> >  drivers/media/test-drivers/Kconfig            |   10 +
> >  drivers/media/test-drivers/Makefile           |    1 +
> >  drivers/media/test-drivers/vim2m-audio.c      |  793 +++++++++++
> >  drivers/media/test-drivers/vivid/vivid-core.h |    2 +
> >  .../media/test-drivers/vivid/vivid-ctrls.c    |   26 +
> >  drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    9 +
> >  drivers/media/v4l2-core/v4l2-ctrls-api.c      |    1 +
> >  drivers/media/v4l2-core/v4l2-ctrls-core.c     |   93 +-
> >  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |   10 +
> >  drivers/media/v4l2-core/v4l2-dev.c            |   21 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c          |   66 +
> >  drivers/media/v4l2-core/v4l2-mem2mem.c        |   13 +-
> >  include/media/v4l2-ctrls.h                    |   13 +-
> >  include/media/v4l2-dev.h                      |    2 +
> >  include/media/v4l2-ioctl.h                    |   34 +
> >  .../fsl =3D> include/sound}/fsl_asrc_common.h   |   60 +
> >  include/uapi/linux/media.h                    |    2 +
> >  include/uapi/linux/v4l2-controls.h            |    9 +
> >  include/uapi/linux/videodev2.h                |   50 +-
> >  sound/soc/fsl/fsl_asrc.c                      |  144 ++
> >  sound/soc/fsl/fsl_asrc.h                      |    4 +-
> >  sound/soc/fsl/fsl_asrc_dma.c                  |    2 +-
> >  sound/soc/fsl/fsl_easrc.c                     |  233 +++
> >  sound/soc/fsl/fsl_easrc.h                     |    6 +-
> >  42 files changed, 3128 insertions(+), 27 deletions(-)
> >  create mode 100644 Documentation/userspace-api/media/v4l/dev-audio-mem=
2mem.rst
> >  create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-aud=
io-m2m.rst
> >  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audio.=
rst
> >  create mode 100644 drivers/media/platform/nxp/imx-asrc.c
> >  create mode 100644 drivers/media/test-drivers/vim2m-audio.c
> >  rename {sound/soc/fsl =3D> include/sound}/fsl_asrc_common.h (60%)
> >
>

