Return-Path: <linux-kernel+bounces-96958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495FF8763AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F381F282A99
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFADA56746;
	Fri,  8 Mar 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpcQFk0K"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3370056469;
	Fri,  8 Mar 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898781; cv=none; b=E5cGOeKxmj5ilDnY/YX5diLI0d2dbISgzv2C3FBCNoghjayy1DA94mYQsCqgQ+NAnoweu8loPXcVY3+/o+QSe/Jxt0cAdJp2wnrt9B5Zvk7m/YzpK8hmJbQCpDMy2qSbPcIUvTnLmTBKpciGWYPwMtO1Ex4mcZ5GIy+4UfePQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898781; c=relaxed/simple;
	bh=qVLZXQCojnHDE7Z+d4zZab09rG4diXwMrJqYxCwWmwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtpimT3qERn/cQS+5uFRXLV9TuxuqFmTG9Rc68RQLmslLrxMwp3E7VJi/H0HKOiqt2c9ZBxyQwkqLH9xhWVuf4+7ZKGjADkcy2fVFZiVKkNL01N0bO7nb0X+d1c7Rrgq18963eTO/QXRrdSPq5e0HrQ2plCyyPTFdpoXHewVuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpcQFk0K; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-365169e0938so5093305ab.0;
        Fri, 08 Mar 2024 03:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709898779; x=1710503579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOTHmROUYyTs1AYaJjHkzMiOlXwBSAXtC4p6XafQyfw=;
        b=WpcQFk0KacSvogJ3Fn1HUnkql03SWW1nYXQNbjI02AVCxwSkDk1LAEr8Sve60BpycJ
         W1sBiXbL/plvJPjyczd44HVGxFSw7T21VDAKovbR2RV1bPQ8IgjlyuGHJIt4kbiXIGRJ
         JEUYK37nKaPWjWlW+/AwaUcufzG68qTYXN6h7apjnNu70NEVvIx0wlv4zfrRaos+2uKq
         AgKD1zbtNHGlBi99PKI7fL1xVV8AeOQpSD4EDD0Qn82Rr4fgoQCJzhpeq4guUVjeAlVH
         uhNPFBHPof8L+b5uqX+a+xhIVAeZx45qH0N/hdQ+FAuAs2JzTBSiYIx5kFlhm1zyhgvQ
         +dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709898779; x=1710503579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOTHmROUYyTs1AYaJjHkzMiOlXwBSAXtC4p6XafQyfw=;
        b=t70YiM6KOnjeoPWd65DzMCB11qf31d1FVYOv63fWi5WndSRrrobDOekCssmth8aSq4
         woCNSY5c0Kg33DEx9FafarU1zYGossfPqxLHRiefFV9sBng1hc5lWYEK4znY3QpSIsa8
         zBeVNHwyiQwYBjtL7bXDj5mYjhGLP0uFhw44FVycSsuUptm3YwogkbCRg1BwD542K58s
         QcEkz5BFPlXJPXL/7cK5tX7qSdOYd3yb7Rtr7doQaENtWGt/3SMHx0EimTt83UhryPQo
         92bRObMjovueoMallM5BPWAEqQ6OArAsq2g16SlQx4minn118S8XLpZoFcgRQt7ZQ/qI
         C58A==
X-Forwarded-Encrypted: i=1; AJvYcCVoXkdg7woAjUQb67LYVBpAo356x3NGpo+3Ho2nRNi08IV3e28GIJ/+I7DywkCDJQ1+AmiF/99jpgDUCLg1ajyZOvTgsIshxjcRCIXm1fBZpy0xWAhcFun1SZ/yiDkvCBVgNnRhgWyZwqI=
X-Gm-Message-State: AOJu0YzytyDJq1e9w8CoeSLZDXbevXDb7DvhlsmSPtgIJVYTellEMMej
	wAFP5SaESEksBgq+jd3ZPfeCy3phTufwgT9lA7FWsBIuNksnVr+ihYuLuO1ZaqWD/MEfwa8nHgu
	oKyvGTV+NvquaVQN2RjOdk2UBkX8=
X-Google-Smtp-Source: AGHT+IHLWW6kqWlLcrdK4P5C03HNWBVSXwjGGF/R2FkqbTgY+js64Z8UbJJa+4aVFS1nAseTmTGNGyR4zn/b5wRU/BI=
X-Received: by 2002:a05:6e02:1a87:b0:365:4e45:5436 with SMTP id
 k7-20020a056e021a8700b003654e455436mr3149325ilv.15.1709898779226; Fri, 08 Mar
 2024 03:52:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1708936109-11587-1-git-send-email-shengjiu.wang@nxp.com>
 <1708936109-11587-10-git-send-email-shengjiu.wang@nxp.com> <df05261f-2f0e-490f-883b-72ad8a02d11b@xs4all.nl>
In-Reply-To: <df05261f-2f0e-490f-883b-72ad8a02d11b@xs4all.nl>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 8 Mar 2024 19:52:48 +0800
Message-ID: <CAA+D8AMJOCfp6WdqYqy7KSj=mX9o_D5U-aF6Wn=3cOnhWg7VDg@mail.gmail.com>
Subject: Re: [PATCH v13 09/16] media: uapi: Define audio sample format fourcc type
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi, tfiga@chromium.org, 
	m.szyprowski@samsung.com, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:34=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> wr=
ote:
>
> Hi Shengjiu,
>
> After thinking it over I think this patch can be improved:
>
> On 26/02/2024 9:28 am, Shengjiu Wang wrote:
> > The audio sample format definition is from alsa,
> > the header file is include/uapi/sound/asound.h, but
> > don't include this header file directly, because in
> > user space, there is another copy in alsa-lib.
> > There will be conflict in userspace for include
> > videodev2.h & asound.h and asoundlib.h
> >
> > Here still use the fourcc format.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../userspace-api/media/v4l/pixfmt-audio.rst  | 87 +++++++++++++++++++
> >  .../userspace-api/media/v4l/pixfmt.rst        |  1 +
> >  drivers/media/v4l2-core/v4l2-ioctl.c          | 13 +++
> >  include/uapi/linux/videodev2.h                | 23 +++++
> >  4 files changed, 124 insertions(+)
> >  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audio.=
rst
> >
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-audio.rst b/D=
ocumentation/userspace-api/media/v4l/pixfmt-audio.rst
> > new file mode 100644
> > index 000000000000..04b4a7fbd8f4
> > --- /dev/null
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> > @@ -0,0 +1,87 @@
> > +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> > +
> > +.. _pixfmt-audio:
> > +
> > +*************
> > +Audio Formats
> > +*************
> > +
> > +These formats are used for :ref:`audiomem2mem` interface only.
>
> Here you should also document that all these fourccs start with 'AU' and =
are
> reserved for mappings of the snd_pcm_format_t type.
>
> Also document the v4l2_fourcc_to_audfmt define and the v4l2_audfmt_to_fou=
rcc
> define (see also below).

How about below description?
'
All these fourccs starting with 'AU' are reserved for mappings
of the snd_pcm_format_t type.

The v4l2_audfmt_to_fourcc() is defined to convert snd_pcm_format_t
type to fourcc. The first character is 'A', the second character
is 'U', the third character is ten's digit of snd_pcm_format_t,
the fourth character is unit's digit of snd_pcm_format_t.

The v4l2_fourcc_to_audfmt() is defined to convert these fourccs to
snd_pcm_format_t type.
'
Best regards
Shengjiu Wang
>
> > +
> > +.. tabularcolumns:: |p{5.8cm}|p{1.2cm}|p{10.3cm}|
> > +
> > +.. cssclass:: longtable
> > +
> > +.. flat-table:: Audio Format
> > +    :header-rows:  1
> > +    :stub-columns: 0
> > +    :widths:       3 1 4
> > +
> > +    * - Identifier
> > +      - Code
> > +      - Details
> > +    * .. _V4L2-AUDIO-FMT-S8:
> > +
> > +      - ``V4L2_AUDIO_FMT_S8``
> > +      - 'S8'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S8 in ALSA
> > +    * .. _V4L2-AUDIO-FMT-S16-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_S16_LE``
> > +      - 'S16_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S16_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-U16-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_U16_LE``
> > +      - 'U16_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_U16_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-S24-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_S24_LE``
> > +      - 'S24_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S24_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-U24-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_U24_LE``
> > +      - 'U24_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_U24_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-S32-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_S32_LE``
> > +      - 'S32_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S32_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-U32-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_U32_LE``
> > +      - 'U32_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_U32_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-FLOAT-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_FLOAT_LE``
> > +      - 'FLOAT_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_FLOAT_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-IEC958-SUBFRAME-LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE``
> > +      - 'IEC958_SUBFRAME_LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-S24-3LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_S24_3LE``
> > +      - 'S24_3LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S24_3LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-U24-3LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_U24_3LE``
> > +      - 'U24_3LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_U24_3LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-S20-3LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_S20_3LE``
> > +      - 'S20_3LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_S24_3LE in ALSA
> > +    * .. _V4L2-AUDIO-FMT-U20-3LE:
> > +
> > +      - ``V4L2_AUDIO_FMT_U20_3LE``
> > +      - 'U20_3LE'
> > +      - Corresponds to SNDRV_PCM_FORMAT_U20_3LE in ALSA
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt.rst b/Documen=
tation/userspace-api/media/v4l/pixfmt.rst
> > index 11dab4a90630..2eb6fdd3b43d 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt.rst
> > @@ -36,3 +36,4 @@ see also :ref:`VIDIOC_G_FBUF <VIDIOC_G_FBUF>`.)
> >      colorspaces
> >      colorspaces-defs
> >      colorspaces-details
> > +    pixfmt-audio
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index 961abcdf7290..be229c69e991 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1471,6 +1471,19 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc=
 *fmt)
> >       case V4L2_PIX_FMT_Y210:         descr =3D "10-bit YUYV Packed"; b=
reak;
> >       case V4L2_PIX_FMT_Y212:         descr =3D "12-bit YUYV Packed"; b=
reak;
> >       case V4L2_PIX_FMT_Y216:         descr =3D "16-bit YUYV Packed"; b=
reak;
> > +     case V4L2_AUDIO_FMT_S8:         descr =3D "8-bit Signed"; break;
> > +     case V4L2_AUDIO_FMT_S16_LE:     descr =3D "16-bit Signed LE"; bre=
ak;
> > +     case V4L2_AUDIO_FMT_U16_LE:             descr =3D "16-bit Unsigne=
d LE"; break;
> > +     case V4L2_AUDIO_FMT_S24_LE:             descr =3D "24(32)-bit Sig=
ned LE"; break;
> > +     case V4L2_AUDIO_FMT_U24_LE:             descr =3D "24(32)-bit Uns=
igned LE"; break;
> > +     case V4L2_AUDIO_FMT_S32_LE:             descr =3D "32-bit Signed =
LE"; break;
> > +     case V4L2_AUDIO_FMT_U32_LE:             descr =3D "32-bit Unsigne=
d LE"; break;
> > +     case V4L2_AUDIO_FMT_FLOAT_LE:           descr =3D "32-bit Float L=
E"; break;
> > +     case V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE: descr =3D "32-bit IEC958 =
LE"; break;
> > +     case V4L2_AUDIO_FMT_S24_3LE:            descr =3D "24(24)-bit Sig=
ned LE"; break;
> > +     case V4L2_AUDIO_FMT_U24_3LE:            descr =3D "24(24)-bit Uns=
igned LE"; break;
> > +     case V4L2_AUDIO_FMT_S20_3LE:            descr =3D "20(24)-bit Sig=
ned LE"; break;
> > +     case V4L2_AUDIO_FMT_U20_3LE:            descr =3D "20(24)-bit Uns=
igned LE"; break;
> >
> >       default:
> >               /* Compressed formats */
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 2c03d2dfadbe..673a6235a029 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -843,6 +843,29 @@ struct v4l2_pix_format {
> >  #define V4L2_META_FMT_RK_ISP1_PARAMS v4l2_fourcc('R', 'K', '1', 'P') /=
* Rockchip ISP1 3A Parameters */
> >  #define V4L2_META_FMT_RK_ISP1_STAT_3A        v4l2_fourcc('R', 'K', '1'=
, 'S') /* Rockchip ISP1 3A Statistics */
> >
> > +/*
> > + * Audio-data formats
> > + * All these audio formats use a fourcc starting with 'AU'
> > + * followed by the SNDRV_PCM_FORMAT_ value from asound.h.
>
> Also document here that fourccs starting with 'AU' are reserved for
> the snd_pcm_format_t to fourcc mappings.
>
> That to avoid that someone adds a 'AUXX' fourcc later.
>
> > + */
> > +#define V4L2_AUDIO_FMT_S8                    v4l2_fourcc('A', 'U', '0'=
, '0')
> > +#define V4L2_AUDIO_FMT_S16_LE                        v4l2_fourcc('A', =
'U', '0', '2')
> > +#define V4L2_AUDIO_FMT_U16_LE                        v4l2_fourcc('A', =
'U', '0', '4')
> > +#define V4L2_AUDIO_FMT_S24_LE                        v4l2_fourcc('A', =
'U', '0', '6')
> > +#define V4L2_AUDIO_FMT_U24_LE                        v4l2_fourcc('A', =
'U', '0', '8')
> > +#define V4L2_AUDIO_FMT_S32_LE                        v4l2_fourcc('A', =
'U', '1', '0')
> > +#define V4L2_AUDIO_FMT_U32_LE                        v4l2_fourcc('A', =
'U', '1', '2')
> > +#define V4L2_AUDIO_FMT_FLOAT_LE                      v4l2_fourcc('A', =
'U', '1', '4')
> > +#define V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE    v4l2_fourcc('A', 'U', '1'=
, '8')
> > +#define V4L2_AUDIO_FMT_S24_3LE                       v4l2_fourcc('A', =
'U', '3', '2')
> > +#define V4L2_AUDIO_FMT_U24_3LE                       v4l2_fourcc('A', =
'U', '3', '4')
> > +#define V4L2_AUDIO_FMT_S20_3LE                       v4l2_fourcc('A', =
'U', '3', '6')
> > +#define V4L2_AUDIO_FMT_U20_3LE                       v4l2_fourcc('A', =
'U', '3', '8')
> > +
> > +#define v4l2_fourcc_to_audfmt(fourcc)        \
> > +     (__force snd_pcm_format_t)(((((fourcc) >> 16) & 0xff) - '0') * 10=
  \
> > +                                + ((((fourcc) >> 24) & 0xff) - '0'))
> > +
>
> As I suggested in an earlier reply, add this:
>
> #define v4l2_audfmt_to_fourcc(audfmt) \
>         v4l2_fourcc('A', 'U', '0' + (audfmt) / 10, '0' + (audfmt) % 10)
>
> Even though it is not used in the drivers, since this is a public header =
used
> by drivers and applications, it makes sense to provide the reverse mappin=
g as well.
>
> Please test it in actual code to make sure there are no compilation warni=
ngs.
>
> Regards,
>
>         Hans
>
> >  /* priv field value to indicates that subsequent fields are valid. */
> >  #define V4L2_PIX_FMT_PRIV_MAGIC              0xfeedcafe
> >
>

