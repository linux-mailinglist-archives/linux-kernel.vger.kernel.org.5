Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8364806C11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377462AbjLFKgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377463AbjLFKgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:36:22 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6393137;
        Wed,  6 Dec 2023 02:36:27 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58d5979c676so4210258eaf.1;
        Wed, 06 Dec 2023 02:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701858987; x=1702463787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSHguhdYXTBvbS9uaUvEUspYNKYDJXD8tRJJNaYtm/4=;
        b=DFrKtgoTssqiNxW2xH5rTZQmfY3nRBSyW02+5tZEM7FcNAreaT3fRgNoyRh10AOa4m
         N6VcjBzYdBTnHKKta396F3qSbYfxRRtgtMDXRkR8n4vQ4yPkKgyxUnJ2Eiqsxcxwsymr
         fx8qeYqYRnrKga36f8LcWzN0PzzRlgu8p/EA8dyE1CWdhOdNNVXRRAkwdBKoJAiEz+5l
         B2ORaQN9Mlunl7CUfZDxHdWw0uQBc3gnrAixV9kD1deZb9YiQXtzieVm5miHUWBznZMa
         lkjlfv9Jm98w0z+u2LvQ8BQLQ+Rn+nJRVirGq9nt9gvuVaD1PImzAU16dvRhY8x9sPXZ
         WctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858987; x=1702463787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSHguhdYXTBvbS9uaUvEUspYNKYDJXD8tRJJNaYtm/4=;
        b=kmYkzGTQKnCXRCnDd/5G3e6RyAD8PpcD4G4Ur5EpEkEiOC7E9Xz0M/cxOeZmsR5N/4
         H5tNm2YJTEmOQfg2VcbYrROCLlD0y+bkilrcNGsl80Vj6aikraegqRiC314ccvOGX4S+
         WhsrF+/8vSn+9lH+SrLu5XDq5Ya7KZEzz5Os8Y8UR+gbi4b6gbcN+alXtMCuAjQQI/9a
         ZQfxJhanDxLl9xbswaBHQlytpafmOmDnzhSwdvIfOt/89IooqsiihuucAj7vrStTpSta
         bLXN6D+8yDppKG8ZoyLnnAQ1yA3Qdf9sjt1bEWBhrJWgHoFfCQ3wl1/hK0sHjUf2KmpY
         4cpw==
X-Gm-Message-State: AOJu0YzL81lVu9jtWLQh9GVw/AYvdkizFxTcO37Iv9OO3D8jTGqP1Iib
        DPI97KCEJsZAXhlYHe+YXw7SDezI6Th0V1n1kR0=
X-Google-Smtp-Source: AGHT+IEOZ+MLiRmb/S6EqV/xSpTjmcXgIZjhtYgimuOsEADFi9rhPAoRfej2QsU8ydHLGgNRSK30svnwV1AzhgNSH5s=
X-Received: by 2002:a05:6358:3399:b0:16e:29a9:f5af with SMTP id
 i25-20020a056358339900b0016e29a9f5afmr960782rwd.27.1701858986997; Wed, 06 Dec
 2023 02:36:26 -0800 (PST)
MIME-Version: 1.0
References: <1700637838-6743-1-git-send-email-shengjiu.wang@nxp.com> <a318e512-393c-477d-b1db-72c75855b962@xs4all.nl>
In-Reply-To: <a318e512-393c-477d-b1db-72c75855b962@xs4all.nl>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 6 Dec 2023 18:36:15 +0800
Message-ID: <CAA+D8APy4aUDgPBM0+BVmUWtHvP5g75vSMZTTzxTUASjBhY_AA@mail.gmail.com>
Subject: Re: [PATCH v11 00/15] Add audio support in v4l2 framework
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 4:09=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> wr=
ote:
>
> Hi Shengjiu,
>
> On 22/11/2023 08:23, Shengjiu Wang wrote:
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
>
> I just wanted to let you know that this will have to be postponed until v=
6.8.
> I need more time to work on the v4l-utils changes, esp. for the fraction =
bits
> feature, and realistically that is not going to happen before my Christma=
s
> vacation starts.

No problem. Have a good vacation!
Thanks.

Best Regards
Shengjiu Wang
>
> Apologies for the delay.
>
>
> Regards,
>
>         Hans
>
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
> >  .../media/v4l/ext-ctrls-audio-m2m.rst         |   41 +
> >  .../userspace-api/media/v4l/pixfmt-audio.rst  |   87 ++
> >  .../userspace-api/media/v4l/pixfmt.rst        |    1 +
> >  .../media/v4l/vidioc-enum-fmt.rst             |    2 +
> >  .../media/v4l/vidioc-g-ext-ctrls.rst          |    4 +
> >  .../userspace-api/media/v4l/vidioc-g-fmt.rst  |    4 +
> >  .../media/v4l/vidioc-querycap.rst             |    3 +
> >  .../media/videodev2.h.rst.exceptions          |    3 +
> >  .../media/common/videobuf2/videobuf2-v4l2.c   |    4 +
> >  drivers/media/platform/nxp/Kconfig            |   13 +
> >  drivers/media/platform/nxp/Makefile           |    1 +
> >  drivers/media/platform/nxp/imx-asrc.c         | 1264 +++++++++++++++++
> >  drivers/media/test-drivers/Kconfig            |   11 +
> >  drivers/media/test-drivers/Makefile           |    1 +
> >  drivers/media/test-drivers/vim2m-audio.c      |  799 +++++++++++
> >  drivers/media/test-drivers/vivid/vivid-core.h |    2 +
> >  .../media/test-drivers/vivid/vivid-ctrls.c    |   26 +
> >  drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    9 +
> >  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |   10 +
> >  drivers/media/v4l2-core/v4l2-dev.c            |   21 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c          |   66 +
> >  drivers/media/v4l2-core/v4l2-mem2mem.c        |   13 +-
> >  include/media/v4l2-ctrls.h                    |    3 +
> >  include/media/v4l2-dev.h                      |    2 +
> >  include/media/v4l2-ioctl.h                    |   34 +
> >  .../fsl =3D> include/sound}/fsl_asrc_common.h   |   60 +
> >  include/uapi/linux/media.h                    |    2 +
> >  include/uapi/linux/v4l2-controls.h            |    9 +
> >  include/uapi/linux/videodev2.h                |   41 +
> >  sound/soc/fsl/fsl_asrc.c                      |  144 ++
> >  sound/soc/fsl/fsl_asrc.h                      |    4 +-
> >  sound/soc/fsl/fsl_asrc_dma.c                  |    2 +-
> >  sound/soc/fsl/fsl_easrc.c                     |  233 +++
> >  sound/soc/fsl/fsl_easrc.h                     |    6 +-
> >  39 files changed, 3008 insertions(+), 7 deletions(-)
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
