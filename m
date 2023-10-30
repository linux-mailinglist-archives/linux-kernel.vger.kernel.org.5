Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA17DB1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 02:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJ3B4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 21:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJ3B4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 21:56:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E523BE;
        Sun, 29 Oct 2023 18:56:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2802c41b716so614023a91.1;
        Sun, 29 Oct 2023 18:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698630994; x=1699235794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXRLwnyvcfy6jE/MUWoW/Yby9B0gy2TfIvcPthNvb0k=;
        b=O1e2zy9Do0fs/PL6Pmt8MBaiCHSxW/+3ckEQrUQrWdyZjDl/cgQXdt5AZpdsHfIeMv
         +At2VCR7h/WwvcGLMiiTgw9JFk2ddoOpY3o+Xz2J1OZtqm1CXfvSL+WcovKIhCg31pUk
         dTjEINUXVd8d6iQ5GC2tBKiFq0ldZ2qNQeqYT3vNZxUyfaOZ6RFokmkNlD8yyXcr0+4I
         qbXG4Vu/lVaT9N2sgC0bSTzk5YZweC7FYuVQczFxdYV1Ck83lXd1hXDQAsh4vXLb0DVH
         7U8VVZDELjhr6feY9hGi7BnHYdwWwowVDii5S0H//jdSLHFMXelGvs4AsgHIx1tEcJo9
         9MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698630994; x=1699235794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXRLwnyvcfy6jE/MUWoW/Yby9B0gy2TfIvcPthNvb0k=;
        b=se5Vno6qfa2cv1FMDRrzvoRKluOy6GXDxrA6BlN7eIoFoku0fV557md2fGP3BtSRRF
         qbpEdI7xcdhZ9lbjEvbkpzVKHPR62ud6MSay0cqgoV1Hejp8Dm4A9RFt59dC2JAXcS5w
         mG1Xp+SVRGLkGWQnkT/vZ8NBLjMJvOD8pePwVvM+RgEQEMpoRc7yzRCWEcQBYW1ar5Ui
         d+EfnJolmC+Yrh8RdEIkknrezmvKJYgLXN3CAVREzsAv8948kqXAvo2SJp5jp/T2jzDV
         Gbw4a+EKeZMpQaDgsLkNgmefzqGttB2zQ5khHXaoaGzE9iqgj9EGOZ/X8obXxpab2FpO
         x1pA==
X-Gm-Message-State: AOJu0Yxj8kHpimHcUjJoi5Pjnjnn1RN5A0tOwrZjKixX16twG0V78NzM
        3NDIxnoWMLV92ltkff5g4B169KlWKOAlRwZptHI=
X-Google-Smtp-Source: AGHT+IGAB1+4aLMMfdrAGAJeVPLx3vXyPUzK5aU43XjGbCGprf4okqXxvQKJ4QuTuO9/Vq869iPZgyjlym6LTFzzngQ=
X-Received: by 2002:a17:90a:357:b0:27d:5964:4eec with SMTP id
 23-20020a17090a035700b0027d59644eecmr5885791pjf.1.1698630993867; Sun, 29 Oct
 2023 18:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <1698402948-10618-1-git-send-email-shengjiu.wang@nxp.com> <c1cfa3e0-6e5d-4e1d-b6e0-4d1045196a11@xs4all.nl>
In-Reply-To: <c1cfa3e0-6e5d-4e1d-b6e0-4d1045196a11@xs4all.nl>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 30 Oct 2023 09:56:22 +0800
Message-ID: <CAA+D8AOCujL-eD2-chqHAW7UN7UmLrO6CWRd7d6wTCPP8=VyfA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 00/13] Add audio support in v4l2 framework
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 7:18=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> w=
rote:
>
> Hi Shengjiu,
>
> Is there a reason why this series is still marked RFC?
>
> Just wondering about that.

In the very beginning I started this series with RFC, So
I still use RFC now...

Best regards
Wang shengjiu
>
> Regards,
>
>         Hans
>
> On 27/10/2023 12:35, Shengjiu Wang wrote:
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
> > Shengjiu Wang (13):
> >   ASoC: fsl_asrc: define functions for memory to memory usage
> >   ASoC: fsl_easrc: define functions for memory to memory usage
> >   ASoC: fsl_asrc: move fsl_asrc_common.h to include/sound
> >   ASoC: fsl_asrc: register m2m platform device
> >   ASoC: fsl_easrc: register m2m platform device
> >   media: uapi: Add V4L2_CAP_AUDIO_M2M capability flag
> >   media: v4l2: Add audio capture and output support
> >   media: uapi: Define audio sample format fourcc type
> >   media: uapi: Add V4L2_CTRL_CLASS_M2M_AUDIO
> >   media: uapi: Add V4L2_CTRL_TYPE_FIXED_POINT
> >   media: uapi: Add audio rate controls support
> >   media: imx-asrc: Add memory to memory driver
> >   media: vim2m_audio: add virtual driver for audio memory to memory
> >
> >  .../userspace-api/media/v4l/buffer.rst        |    6 +
> >  .../userspace-api/media/v4l/common.rst        |    1 +
> >  .../media/v4l/dev-audio-mem2mem.rst           |   71 +
> >  .../userspace-api/media/v4l/devices.rst       |    1 +
> >  .../media/v4l/ext-ctrls-audio-m2m.rst         |   41 +
> >  .../userspace-api/media/v4l/pixfmt-audio.rst  |   87 ++
> >  .../userspace-api/media/v4l/pixfmt.rst        |    1 +
> >  .../media/v4l/vidioc-enum-fmt.rst             |    2 +
> >  .../media/v4l/vidioc-g-ext-ctrls.rst          |   17 +-
> >  .../userspace-api/media/v4l/vidioc-g-fmt.rst  |    4 +
> >  .../media/v4l/vidioc-querycap.rst             |    3 +
> >  .../media/v4l/vidioc-queryctrl.rst            |    9 +-
> >  .../media/videodev2.h.rst.exceptions          |    4 +
> >  .../media/common/videobuf2/videobuf2-v4l2.c   |    4 +
> >  drivers/media/platform/nxp/Kconfig            |   12 +
> >  drivers/media/platform/nxp/Makefile           |    1 +
> >  drivers/media/platform/nxp/imx-asrc.c         | 1186 +++++++++++++++++
> >  drivers/media/test-drivers/Kconfig            |    9 +
> >  drivers/media/test-drivers/Makefile           |    1 +
> >  drivers/media/test-drivers/vim2m_audio.c      |  680 ++++++++++
> >  drivers/media/v4l2-core/v4l2-ctrls-api.c      |    5 +-
> >  drivers/media/v4l2-core/v4l2-ctrls-core.c     |    2 +
> >  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |   16 +
> >  drivers/media/v4l2-core/v4l2-dev.c            |   17 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c          |   66 +
> >  include/media/v4l2-dev.h                      |    2 +
> >  include/media/v4l2-ioctl.h                    |   34 +
> >  .../fsl =3D> include/sound}/fsl_asrc_common.h   |   60 +
> >  include/uapi/linux/v4l2-controls.h            |    9 +
> >  include/uapi/linux/videodev2.h                |   42 +
> >  sound/soc/fsl/fsl_asrc.c                      |  144 ++
> >  sound/soc/fsl/fsl_asrc.h                      |    4 +-
> >  sound/soc/fsl/fsl_asrc_dma.c                  |    2 +-
> >  sound/soc/fsl/fsl_easrc.c                     |  233 ++++
> >  sound/soc/fsl/fsl_easrc.h                     |    6 +-
> >  35 files changed, 2771 insertions(+), 11 deletions(-)
> >  create mode 100644 Documentation/userspace-api/media/v4l/dev-audio-mem=
2mem.rst
> >  create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-aud=
io-m2m.rst
> >  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audio.=
rst
> >  create mode 100644 drivers/media/platform/nxp/imx-asrc.c
> >  create mode 100644 drivers/media/test-drivers/vim2m_audio.c
> >  rename {sound/soc/fsl =3D> include/sound}/fsl_asrc_common.h (60%)
> >
>
