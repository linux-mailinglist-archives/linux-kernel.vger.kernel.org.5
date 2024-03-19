Return-Path: <linux-kernel+bounces-106956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCF287F5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B61B1F21E20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC757BB0C;
	Tue, 19 Mar 2024 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLPsfxa7"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581D5A4CD;
	Tue, 19 Mar 2024 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710818081; cv=none; b=hhtpnasvGN7j55OPi3q149CmgDALq/fzOfUb14q1nlOhQrXrzSyxxEqndWCjuXvioD6e1TL8cbu3Nl3lt5OgLS7qABXLlP+IJGXorpaLYYkghCxiPMvMjF601Cxh7YooxWrPvk6xMua/VvxRoh6ecqOGUTWcsbQ4d9JVEDo0B4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710818081; c=relaxed/simple;
	bh=/MMr4zjbN+ZlbvNIUjEvMsSJQnBLcP1VsyokEyh4QDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRLnYdND+nTmswHkmQKhQYqpjKKqKnMB8xvgHxcks7qKK9g/4qLSjziz9FyNFV+TnkEf6+HjpN8sjRVwNtE9YzyeaOn7YAd9NYIVf9+A947kRG8Q2cuIYOwz1BREDZ1V9msiTdyjlVZhuUlKOt37Dph1cZ3inA8kFKSKDFFsZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLPsfxa7; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-366b45a1515so9322805ab.0;
        Mon, 18 Mar 2024 20:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710818079; x=1711422879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfExhFChwN9kHrXO4WD4JTPoZ48Bpj9BN+TuPfZMDzk=;
        b=KLPsfxa7SM5VuGvHU0AufewdVHckUSIFQZEVuwsE9UznKVDfy8PwBHk6kBBNkPcbwK
         sb/3uAGCbRQe+BDuKKyEWjMIMa/BKAw9mNSbSOADr5wRF/QQDw2wJAyU4L7ibyI4kvLQ
         BBK6aKG4lgxiT3jtgD51EVa+DK5pIsssCMg6RKtKFtzyST4WE8acPljmYSYlMxwjZ8xj
         unE6uB0ejof/iWFvrGacc49rA80KN2XrN+/SqHBQ8VF2xX5UKhyySk0BYcerF7Y8hEAg
         uOXUEFKCOyV9RIYwqJ7CMLVK7wnX8qM0V0SLzY4sTgDp5lF6T8JeKX+o5jGG1WSY/F1Y
         MgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710818079; x=1711422879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfExhFChwN9kHrXO4WD4JTPoZ48Bpj9BN+TuPfZMDzk=;
        b=EEalouusTvDcyZ0CirGW5FSWA/UpD8M203ztKQ4HB1eyqHOHv//kgw9FGh2MDSZM+K
         uasZBx+5boj+yxUZp2z0Ndg8J0Td/UGP7vCdOh+VT/b8ubaDuXrQ5gIiKRsVN7MRrNp4
         vfULGVrMrNbBNhDkSab4Lwnp/eCtO06kiGFgvVgqlQPj7dKrFs/Tok9TJb2LxdaEBs0u
         QtRe2g3iOh5aVg4WDquMHXTc21xNgit9Ybb7d1aRE6vnlDyJzLn8UI47MSSsC4gARheV
         1Kh8J7ejDNusKO7EWB5yfSEkv0ipU44Q3t+VvbyIQgtYDmiE8hN3/EFeFugAl3JJmGsy
         V0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCX7RM42CVtQr3XHslpUL3yYeYatKKRHfskeSSYgmFvvwJIrN7pNYlZW56fJnpUVl6nt/B2DmoFDdUQ6DNAlxm4KouGtdbKuhKikoohPNbAQOb2AOZ84qLbDIMVitTReUkJtHRTjRp7hSfs=
X-Gm-Message-State: AOJu0Yx/OtI1S0xgQktY0FPYFEYsUkuoQArddEe9z6MggKU8a48Z/X3V
	coYObw9wbnyr/3KAdJzE07Ch8T1sHhi80zgCBwQg1BlQ6FHbzMD389iFhPfqyz1az+JkBSDS7fc
	a2BmyHEPBU8/9H43xUOCxJX53CjE=
X-Google-Smtp-Source: AGHT+IHRc82Z36xS/PilFQIGiAguartgijgxPgqccZqs+zmoHTnRFr6JGVvr6Xm3yUebELVxCb3o6Hn2h4xt3R7MGdw=
X-Received: by 2002:a92:d803:0:b0:368:4bf5:1468 with SMTP id
 y3-20020a92d803000000b003684bf51468mr667043ilm.32.1710818078765; Mon, 18 Mar
 2024 20:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710150841-26991-1-git-send-email-shengjiu.wang@nxp.com>
 <399da377-c2b6-4226-9108-8a1e776b6f3b@xs4all.nl> <CAA+D8APgFvATshUJCNxCynJsYr_6=A+V=xf5qFpimd4i4g1ygg@mail.gmail.com>
In-Reply-To: <CAA+D8APgFvATshUJCNxCynJsYr_6=A+V=xf5qFpimd4i4g1ygg@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 19 Mar 2024 11:14:27 +0800
Message-ID: <CAA+D8AM-ptHySA6V-s1h3MESfyVZPxB-o_sm9F4wJYCWTeV+YQ@mail.gmail.com>
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

On Tue, Mar 19, 2024 at 10:24=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gmail=
com> wrote:
>
> On Mon, Mar 18, 2024 at 11:56=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl=
> wrote:
> >
> > Hi Shengjiu,
> >
> > I was about to prepare a pull request for this when I realized that
> > entries for the new drivers need to be added to the MAINTAINERS file.
> >
> > Can you post patches 'v14 17/16' and 'v14/18/16' adding entries for eac=
h
> > new driver?
>
> Ok,  How about the change below?
>
> VIRTUAL MEM2MEM DRIVER FOR AUDIO
> M:      Hans Verkuil <hverkuil@xs4all.nl>
> M:      Shengjiu Wang <shengjiu.wang@gmail.com>
> L:      linux-media@vger.kernel.org
> S:      Maintained
> W:      https://linuxtv.org
> T:      git git://linuxtv.org/media_tree.git
> F:      drivers/media/test-drivers/vim2m-audio.c
>
> NXP ASRC V4L2 MEM2MEM DRIVERS
> M:      Shengjiu Wang <shengjiu.wang@gmail.com>
> L:      linux-media@vger.kernel.org
> S:      Maintained
> W:      https://linuxtv.org
> T:      git git://linuxtv.org/media_tree.git
> F:      drivers/media/platform/nxp/imx-asrc.c
>

BTW, should I merge this change to PATCH 15/16  and PATCH 16/16?
That I will resend the whole patch series.  Seems this is a better way.

Best regrads
Shengjiu Wang

> best regards
> wang shengjiu
>
> >
> > Thank you,
> >
> >         Hans
> >
> > On 11/03/2024 10:53 am, Shengjiu Wang wrote:
> > > Audio signal processing also has the requirement for memory to
> > > memory similar as Video.
> > >
> > > This asrc memory to memory (memory ->asrc->memory) case is a non
> > > real time use case.
> > >
> > > User fills the input buffer to the asrc module, after conversion, the=
n asrc
> > > sends back the output buffer to user. So it is not a traditional ALSA=
 playback
> > > and capture case.
> > >
> > > It is a specific use case,  there is no reference in current kernel.
> > > v4l2 memory to memory is the closed implementation,  v4l2 current
> > > support video, image, radio, tuner, touch devices, so it is not
> > > complicated to add support for this specific audio case.
> > >
> > > Because we had implemented the "memory -> asrc ->i2s device-> codec"
> > > use case in ALSA.  Now the "memory->asrc->memory" needs
> > > to reuse the code in asrc driver, so the first 3 patches is for refin=
ing
> > > the code to make it can be shared by the "memory->asrc->memory"
> > > driver.
> > >
> > > The main change is in the v4l2 side, A /dev/vl4-audioX will be create=
d,
> > > user applications only use the ioctl of v4l2 framework.
> > >
> > > Other change is to add memory to memory support for two kinds of i.MX=
 ASRC
> > > module.
> > >
> > > changes in v14:
> > > - document the reservation of 'AUXX' fourcc format.
> > > - add v4l2_audfmt_to_fourcc() definition.
> > >
> > > changes in v13
> > > - change 'pixelformat' to 'audioformat' in dev-audio-mem2mem.rst
> > > - add more description for clock drift in ext-ctrls-audio-m2m.rst
> > > - Add "media: v4l2-ctrls: add support for fraction_bits" from Hans
> > >   to avoid build issue for kernel test robot
> > >
> > > changes in v12
> > > - minor changes according to comments
> > > - drop min_buffers_needed =3D 1 and V4L2_CTRL_FLAG_UPDATE flag
> > > - drop bus_info
> > >
> > > changes in v11
> > > - add add-fixed-point-test-controls in vivid.
> > > - add v4l2_ctrl_fp_compose() helper function for min and max
> > >
> > > changes in v10
> > > - remove FIXED_POINT type
> > > - change code base on media: v4l2-ctrls: add support for fraction_bit=
s
> > > - fix issue reported by kernel test robot
> > > - remove module_alias
> > >
> > > changes in v9:
> > > - add MEDIA_ENT_F_PROC_AUDIO_RESAMPLER.
> > > - add MEDIA_INTF_T_V4L_AUDIO
> > > - add media controller support
> > > - refine the vim2m-audio to support 8k<->16k conversion.
> > >
> > > changes in v8:
> > > - refine V4L2_CAP_AUDIO_M2M to be 0x00000008
> > > - update doc for FIXED_POINT
> > > - address comments for imx-asrc
> > >
> > > changes in v7:
> > > - add acked-by from Mark
> > > - separate commit for fixed point, m2m audio class, audio rate contro=
ls
> > > - use INTEGER_MENU for rate,  FIXED_POINT for rate offset
> > > - remove used fmts
> > > - address other comments for Hans
> > >
> > > changes in v6:
> > > - use m2m_prepare/m2m_unprepare/m2m_start/m2m_stop to replace
> > >   m2m_start_part_one/m2m_stop_part_one, m2m_start_part_two/m2m_stop_p=
art_two.
> > > - change V4L2_CTRL_TYPE_ASRC_RATE to V4L2_CTRL_TYPE_FIXED_POINT
> > > - fix warning by kernel test rebot
> > > - remove some unused format V4L2_AUDIO_FMT_XX
> > > - Get SNDRV_PCM_FORMAT from V4L2_AUDIO_FMT in driver.
> > > - rename audm2m to viaudm2m.
> > >
> > > changes in v5:
> > > - remove V4L2_AUDIO_FMT_LPCM
> > > - define audio pixel format like V4L2_AUDIO_FMT_S8...
> > > - remove rate and format in struct v4l2_audio_format.
> > > - Add V4L2_CID_ASRC_SOURCE_RATE and V4L2_CID_ASRC_DEST_RATE controls
> > > - updata document accordingly.
> > >
> > > changes in v4:
> > > - update document style
> > > - separate V4L2_AUDIO_FMT_LPCM and V4L2_CAP_AUDIO_M2M in separate com=
mit
> > >
> > > changes in v3:
> > > - Modify documents for adding audio m2m support
> > > - Add audio virtual m2m driver
> > > - Defined V4L2_AUDIO_FMT_LPCM format type for audio.
> > > - Defined V4L2_CAP_AUDIO_M2M capability type for audio m2m case.
> > > - with modification in v4l-utils, pass v4l2-compliance test.
> > >
> > > changes in v2:
> > > - decouple the implementation in v4l2 and ALSA
> > > - implement the memory to memory driver as a platfrom driver
> > >   and move it to driver/media
> > > - move fsl_asrc_common.h to include/sound folder
> > >
> > > Hans Verkuil (1):
> > >   media: v4l2-ctrls: add support for fraction_bits
> > >
> > > Shengjiu Wang (15):
> > >   ASoC: fsl_asrc: define functions for memory to memory usage
> > >   ASoC: fsl_easrc: define functions for memory to memory usage
> > >   ASoC: fsl_asrc: move fsl_asrc_common.h to include/sound
> > >   ASoC: fsl_asrc: register m2m platform device
> > >   ASoC: fsl_easrc: register m2m platform device
> > >   media: uapi: Add V4L2_CAP_AUDIO_M2M capability flag
> > >   media: v4l2: Add audio capture and output support
> > >   media: uapi: Define audio sample format fourcc type
> > >   media: uapi: Add V4L2_CTRL_CLASS_M2M_AUDIO
> > >   media: uapi: Add audio rate controls support
> > >   media: uapi: Declare interface types for Audio
> > >   media: uapi: Add an entity type for audio resampler
> > >   media: vivid: add fixed point test controls
> > >   media: imx-asrc: Add memory to memory driver
> > >   media: vim2m-audio: add virtual driver for audio memory to memory
> > >
> > >  .../media/mediactl/media-types.rst            |   11 +
> > >  .../userspace-api/media/v4l/buffer.rst        |    6 +
> > >  .../userspace-api/media/v4l/common.rst        |    1 +
> > >  .../media/v4l/dev-audio-mem2mem.rst           |   71 +
> > >  .../userspace-api/media/v4l/devices.rst       |    1 +
> > >  .../media/v4l/ext-ctrls-audio-m2m.rst         |   59 +
> > >  .../userspace-api/media/v4l/pixfmt-audio.rst  |  100 ++
> > >  .../userspace-api/media/v4l/pixfmt.rst        |    1 +
> > >  .../media/v4l/vidioc-enum-fmt.rst             |    2 +
> > >  .../media/v4l/vidioc-g-ext-ctrls.rst          |    4 +
> > >  .../userspace-api/media/v4l/vidioc-g-fmt.rst  |    4 +
> > >  .../media/v4l/vidioc-querycap.rst             |    3 +
> > >  .../media/v4l/vidioc-queryctrl.rst            |   11 +-
> > >  .../media/videodev2.h.rst.exceptions          |    3 +
> > >  .../media/common/videobuf2/videobuf2-v4l2.c   |    4 +
> > >  drivers/media/platform/nxp/Kconfig            |   13 +
> > >  drivers/media/platform/nxp/Makefile           |    1 +
> > >  drivers/media/platform/nxp/imx-asrc.c         | 1256 +++++++++++++++=
++
> > >  drivers/media/test-drivers/Kconfig            |   10 +
> > >  drivers/media/test-drivers/Makefile           |    1 +
> > >  drivers/media/test-drivers/vim2m-audio.c      |  793 +++++++++++
> > >  drivers/media/test-drivers/vivid/vivid-core.h |    2 +
> > >  .../media/test-drivers/vivid/vivid-ctrls.c    |   26 +
> > >  drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    9 +
> > >  drivers/media/v4l2-core/v4l2-ctrls-api.c      |    1 +
> > >  drivers/media/v4l2-core/v4l2-ctrls-core.c     |   93 +-
> > >  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |   10 +
> > >  drivers/media/v4l2-core/v4l2-dev.c            |   21 +
> > >  drivers/media/v4l2-core/v4l2-ioctl.c          |   66 +
> > >  drivers/media/v4l2-core/v4l2-mem2mem.c        |   13 +-
> > >  include/media/v4l2-ctrls.h                    |   13 +-
> > >  include/media/v4l2-dev.h                      |    2 +
> > >  include/media/v4l2-ioctl.h                    |   34 +
> > >  .../fsl =3D> include/sound}/fsl_asrc_common.h   |   60 +
> > >  include/uapi/linux/media.h                    |    2 +
> > >  include/uapi/linux/v4l2-controls.h            |    9 +
> > >  include/uapi/linux/videodev2.h                |   50 +-
> > >  sound/soc/fsl/fsl_asrc.c                      |  144 ++
> > >  sound/soc/fsl/fsl_asrc.h                      |    4 +-
> > >  sound/soc/fsl/fsl_asrc_dma.c                  |    2 +-
> > >  sound/soc/fsl/fsl_easrc.c                     |  233 +++
> > >  sound/soc/fsl/fsl_easrc.h                     |    6 +-
> > >  42 files changed, 3128 insertions(+), 27 deletions(-)
> > >  create mode 100644 Documentation/userspace-api/media/v4l/dev-audio-m=
em2mem.rst
> > >  create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-a=
udio-m2m.rst
> > >  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audi=
o.rst
> > >  create mode 100644 drivers/media/platform/nxp/imx-asrc.c
> > >  create mode 100644 drivers/media/test-drivers/vim2m-audio.c
> > >  rename {sound/soc/fsl =3D> include/sound}/fsl_asrc_common.h (60%)
> > >
> >

