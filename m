Return-Path: <linux-kernel+bounces-97113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823948765A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BC81C215EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2A53D0B9;
	Fri,  8 Mar 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2PMARWD"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2438DCD;
	Fri,  8 Mar 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905993; cv=none; b=hktcA5Es6Ovkh4/Er5Tb/gK/Zhu/Wb1qAbNAgeMeCW6d8p7HMijxrgNfxA4iY3ExhCrMpgqzDKYRqbELui+oiLnZ6V3RTxaFDXa+KXfHT+Cm8e0t1iobcUS02pEMSQWjfBRoqFZLSln2fmj6rlWCETBTIcQRqr/tnul9ShnyoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905993; c=relaxed/simple;
	bh=/ZP9jA6vaRjOq1dSEUgFASgBmKrqhHag7fxdY45/I/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYh3817E0PZPsqV4vXpzaxLEWMm0jgHYpBMwxB2wsmztULNMD2lJWkJHmMtJonsZQf1PryuIfml1Jz10MrV0NZllwa3U9ukQRoLwKiwYF6O/00IPhiqPz8/3YDcmhkG5g68djruWpUBqEZ3zcEgrNlXv+GrEiYUZNSp7+6tQbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2PMARWD; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3660132bf15so4807505ab.1;
        Fri, 08 Mar 2024 05:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709905991; x=1710510791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on6viS3E8aUEUEG+G9BNQW0L35UK1hOcnR15aTgtBok=;
        b=I2PMARWDjUr6uGSe+zAhdLtIvkpGpzPd8T957z0vtJybKkFpk4xdmpw411eHDW79Eh
         TatDAgHN3k1czXh4Hc8MqSyZjIftbjF1xvlVMd7jNlzb/+YqGMCQTKiCPfLyM/qowbtp
         8Tm4N6EGBXa397+O64Ouj7mnNa0xwMRnMsX79zEyUajPh5bwwDA9+twCVhyYWpf118yC
         3Ijd/c94I/tgc690NRmiZIV6G6NhmCrSCcRSADWnTXAu+9E9eD0rlYy2MA0eBLcTMuwV
         RnqKGz2kBo3rYWqmKz5dSgC/EE4a2GnA2INIXV9khtAOVU2PezEFl0UUqyLDRX1OsGnQ
         2XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709905991; x=1710510791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=on6viS3E8aUEUEG+G9BNQW0L35UK1hOcnR15aTgtBok=;
        b=ivYPpzoi7NKb0IXL+lEzpLAKP8UU97ayreNRhCe5W0zYnwmYWu6OhLOd1hDEVwqE4s
         0vo1s8knSZZaOZrzvVvYaXunm3+IyXwGnc4uPjjU45t8hXvWlDtkLYezHhiWpZnXj6Pk
         7fKqVLgcX3Llyg+mgoxfEjIFueNUs3ffRY4Jo6BnJ+W03QXSDKEkNrM4kVV8egxqKQV1
         AJr+Izmik3/DxcXS04Kx9s+ECl5JkMXnsj9ZbLnA15KgB1YnxjjpJBF1IVbGeeO7hhAm
         tJwMaadpogyDhh6AoWwDTfFZuJLDLC8BeIeCUoJkxqFlQxaDRNImL1Z1UYJuF6L+F7Wl
         wzdA==
X-Forwarded-Encrypted: i=1; AJvYcCU1gOiELukrV3lwbRSMXfkm2UtXu+/Oxz6R33l8i4g6LkZc4iwioOMVjgI05A+jsiW2IR5EfPb2O+gvUPUtv+u24rrYokNepnlTKfppaV0DhCQpFDe3loL8kwXcQV795L5gQKMvfKUMf1M=
X-Gm-Message-State: AOJu0YxrAyFY0MY2JPo28XUU50MsJY4tYJLMMNUPC+ZPQB6gMSnLW49z
	KbMdRU1KU9R0u5fZrMPOi0OchMyj0tjJpe+O3YBs5ZN68j1/h6XPQR75T1vhdxkWqKwSS6i0ZjW
	PZzYmcJFtPtOCRgJ4oGHcvBBTVpg=
X-Google-Smtp-Source: AGHT+IG2q864TT4kQWIktboJpadP1dLOOpXUf0ZnJPgDxvDnNUbExksEWMT7qmXGCwvGsHhXqinfs6mXvRNWiRZcicM=
X-Received: by 2002:a05:6e02:20c3:b0:363:e3d1:2bc8 with SMTP id
 3-20020a056e0220c300b00363e3d12bc8mr23631457ilq.6.1709905990594; Fri, 08 Mar
 2024 05:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1708936109-11587-1-git-send-email-shengjiu.wang@nxp.com>
 <1708936109-11587-10-git-send-email-shengjiu.wang@nxp.com>
 <df05261f-2f0e-490f-883b-72ad8a02d11b@xs4all.nl> <CAA+D8AMJOCfp6WdqYqy7KSj=mX9o_D5U-aF6Wn=3cOnhWg7VDg@mail.gmail.com>
 <56368a0d-6ada-4ab6-8389-b4bd20d6efc4@xs4all.nl>
In-Reply-To: <56368a0d-6ada-4ab6-8389-b4bd20d6efc4@xs4all.nl>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 8 Mar 2024 21:52:59 +0800
Message-ID: <CAA+D8AOXKJP1r-+j0QiH82x3MQ+Y1y2c1h04n=jmJncPogn7Vg@mail.gmail.com>
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

On Fri, Mar 8, 2024 at 8:06=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> wr=
ote:
>
> On 08/03/2024 12:52 pm, Shengjiu Wang wrote:
> > On Fri, Mar 8, 2024 at 3:34=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl=
> wrote:
> >>
> >> Hi Shengjiu,
> >>
> >> After thinking it over I think this patch can be improved:
> >>
> >> On 26/02/2024 9:28 am, Shengjiu Wang wrote:
> >>> The audio sample format definition is from alsa,
> >>> the header file is include/uapi/sound/asound.h, but
> >>> don't include this header file directly, because in
> >>> user space, there is another copy in alsa-lib.
> >>> There will be conflict in userspace for include
> >>> videodev2.h & asound.h and asoundlib.h
> >>>
> >>> Here still use the fourcc format.
> >>>
> >>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >>> ---
> >>>  .../userspace-api/media/v4l/pixfmt-audio.rst  | 87 +++++++++++++++++=
++
> >>>  .../userspace-api/media/v4l/pixfmt.rst        |  1 +
> >>>  drivers/media/v4l2-core/v4l2-ioctl.c          | 13 +++
> >>>  include/uapi/linux/videodev2.h                | 23 +++++
> >>>  4 files changed, 124 insertions(+)
> >>>  create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-audi=
o.rst
> >>>
> >>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-audio.rst b=
/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> >>> new file mode 100644
> >>> index 000000000000..04b4a7fbd8f4
> >>> --- /dev/null
> >>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-audio.rst
> >>> @@ -0,0 +1,87 @@
> >>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> >>> +
> >>> +.. _pixfmt-audio:
> >>> +
> >>> +*************
> >>> +Audio Formats
> >>> +*************
> >>> +
> >>> +These formats are used for :ref:`audiomem2mem` interface only.
> >>
> >> Here you should also document that all these fourccs start with 'AU' a=
nd are
> >> reserved for mappings of the snd_pcm_format_t type.
> >>
> >> Also document the v4l2_fourcc_to_audfmt define and the v4l2_audfmt_to_=
fourcc
> >> define (see also below).
> >
> > How about below description?
> > '
> > All these fourccs starting with 'AU' are reserved for mappings
>
> All these fourccs -> All FourCCs
>
> > of the snd_pcm_format_t type.
> >
> > The v4l2_audfmt_to_fourcc() is defined to convert snd_pcm_format_t
>
> convert -> convert the
>
> > type to fourcc. The first character is 'A', the second character
>
> fourcc -> a FourCC
>
> > is 'U', the third character is ten's digit of snd_pcm_format_t,
> > the fourth character is unit's digit of snd_pcm_format_t.
>
> "is 'U', and the remaining two characters is the snd_pcm_format_t
> value in ASCII. Example: SNDRV_PCM_FORMAT_S16_LE (with value 2)
> maps to 'AU02' and SNDRV_PCM_FORMAT_S24_3LE (with value 32) maps
> to 'AU32'."
>
> >
> > The v4l2_fourcc_to_audfmt() is defined to convert these fourccs to
>
> fourccs -> FourCCs
>
> > snd_pcm_format_t type.
>
> BTW, given the way snd_pcm_format_t is defined I am fairly certain
> some casts are needed for the v4l2_audfmt_to_fourcc define.
>
> Regards,
>
>         Hans
>
> > '
> > Best regards
> > Shengjiu Wang
> >>
> >>> +
> >>> +.. tabularcolumns:: |p{5.8cm}|p{1.2cm}|p{10.3cm}|
> >>> +
> >>> +.. cssclass:: longtable
> >>> +
> >>> +.. flat-table:: Audio Format
> >>> +    :header-rows:  1
> >>> +    :stub-columns: 0
> >>> +    :widths:       3 1 4
> >>> +
> >>> +    * - Identifier
> >>> +      - Code
> >>> +      - Details
> >>> +    * .. _V4L2-AUDIO-FMT-S8:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_S8``
> >>> +      - 'S8'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_S8 in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-S16-LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_S16_LE``
> >>> +      - 'S16_LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_S16_LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-U16-LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_U16_LE``
> >>> +      - 'U16_LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_U16_LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-S24-LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_S24_LE``
> >>> +      - 'S24_LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_S24_LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-U24-LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_U24_LE``
> >>> +      - 'U24_LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_U24_LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-S32-LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_S32_LE``
> >>> +      - 'S32_LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_S32_LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-U32-LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_U32_LE``
> >>> +      - 'U32_LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_U32_LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-FLOAT-LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_FLOAT_LE``
> >>> +      - 'FLOAT_LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_FLOAT_LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-IEC958-SUBFRAME-LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE``
> >>> +      - 'IEC958_SUBFRAME_LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-S24-3LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_S24_3LE``
> >>> +      - 'S24_3LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_S24_3LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-U24-3LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_U24_3LE``
> >>> +      - 'U24_3LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_U24_3LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-S20-3LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_S20_3LE``
> >>> +      - 'S20_3LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_S24_3LE in ALSA
> >>> +    * .. _V4L2-AUDIO-FMT-U20-3LE:
> >>> +
> >>> +      - ``V4L2_AUDIO_FMT_U20_3LE``
> >>> +      - 'U20_3LE'
> >>> +      - Corresponds to SNDRV_PCM_FORMAT_U20_3LE in ALSA
> >>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt.rst b/Docum=
entation/userspace-api/media/v4l/pixfmt.rst
> >>> index 11dab4a90630..2eb6fdd3b43d 100644
> >>> --- a/Documentation/userspace-api/media/v4l/pixfmt.rst
> >>> +++ b/Documentation/userspace-api/media/v4l/pixfmt.rst
> >>> @@ -36,3 +36,4 @@ see also :ref:`VIDIOC_G_FBUF <VIDIOC_G_FBUF>`.)
> >>>      colorspaces
> >>>      colorspaces-defs
> >>>      colorspaces-details
> >>> +    pixfmt-audio
> >>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l=
2-core/v4l2-ioctl.c
> >>> index 961abcdf7290..be229c69e991 100644
> >>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> >>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> >>> @@ -1471,6 +1471,19 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtde=
sc *fmt)
> >>>       case V4L2_PIX_FMT_Y210:         descr =3D "10-bit YUYV Packed";=
 break;
> >>>       case V4L2_PIX_FMT_Y212:         descr =3D "12-bit YUYV Packed";=
 break;
> >>>       case V4L2_PIX_FMT_Y216:         descr =3D "16-bit YUYV Packed";=
 break;
> >>> +     case V4L2_AUDIO_FMT_S8:         descr =3D "8-bit Signed"; break=
;
> >>> +     case V4L2_AUDIO_FMT_S16_LE:     descr =3D "16-bit Signed LE"; b=
reak;
> >>> +     case V4L2_AUDIO_FMT_U16_LE:             descr =3D "16-bit Unsig=
ned LE"; break;
> >>> +     case V4L2_AUDIO_FMT_S24_LE:             descr =3D "24(32)-bit S=
igned LE"; break;
> >>> +     case V4L2_AUDIO_FMT_U24_LE:             descr =3D "24(32)-bit U=
nsigned LE"; break;
> >>> +     case V4L2_AUDIO_FMT_S32_LE:             descr =3D "32-bit Signe=
d LE"; break;
> >>> +     case V4L2_AUDIO_FMT_U32_LE:             descr =3D "32-bit Unsig=
ned LE"; break;
> >>> +     case V4L2_AUDIO_FMT_FLOAT_LE:           descr =3D "32-bit Float=
 LE"; break;
> >>> +     case V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE: descr =3D "32-bit IEC95=
8 LE"; break;
> >>> +     case V4L2_AUDIO_FMT_S24_3LE:            descr =3D "24(24)-bit S=
igned LE"; break;
> >>> +     case V4L2_AUDIO_FMT_U24_3LE:            descr =3D "24(24)-bit U=
nsigned LE"; break;
> >>> +     case V4L2_AUDIO_FMT_S20_3LE:            descr =3D "20(24)-bit S=
igned LE"; break;
> >>> +     case V4L2_AUDIO_FMT_U20_3LE:            descr =3D "20(24)-bit U=
nsigned LE"; break;
> >>>
> >>>       default:
> >>>               /* Compressed formats */
> >>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/vide=
odev2.h
> >>> index 2c03d2dfadbe..673a6235a029 100644
> >>> --- a/include/uapi/linux/videodev2.h
> >>> +++ b/include/uapi/linux/videodev2.h
> >>> @@ -843,6 +843,29 @@ struct v4l2_pix_format {
> >>>  #define V4L2_META_FMT_RK_ISP1_PARAMS v4l2_fourcc('R', 'K', '1', 'P')=
 /* Rockchip ISP1 3A Parameters */
> >>>  #define V4L2_META_FMT_RK_ISP1_STAT_3A        v4l2_fourcc('R', 'K', '=
1', 'S') /* Rockchip ISP1 3A Statistics */
> >>>
> >>> +/*
> >>> + * Audio-data formats
> >>> + * All these audio formats use a fourcc starting with 'AU'
> >>> + * followed by the SNDRV_PCM_FORMAT_ value from asound.h.
> >>
> >> Also document here that fourccs starting with 'AU' are reserved for
> >> the snd_pcm_format_t to fourcc mappings.
> >>
> >> That to avoid that someone adds a 'AUXX' fourcc later.
> >>
> >>> + */
> >>> +#define V4L2_AUDIO_FMT_S8                    v4l2_fourcc('A', 'U', '=
0', '0')
> >>> +#define V4L2_AUDIO_FMT_S16_LE                        v4l2_fourcc('A'=
, 'U', '0', '2')
> >>> +#define V4L2_AUDIO_FMT_U16_LE                        v4l2_fourcc('A'=
, 'U', '0', '4')
> >>> +#define V4L2_AUDIO_FMT_S24_LE                        v4l2_fourcc('A'=
, 'U', '0', '6')
> >>> +#define V4L2_AUDIO_FMT_U24_LE                        v4l2_fourcc('A'=
, 'U', '0', '8')
> >>> +#define V4L2_AUDIO_FMT_S32_LE                        v4l2_fourcc('A'=
, 'U', '1', '0')
> >>> +#define V4L2_AUDIO_FMT_U32_LE                        v4l2_fourcc('A'=
, 'U', '1', '2')
> >>> +#define V4L2_AUDIO_FMT_FLOAT_LE                      v4l2_fourcc('A'=
, 'U', '1', '4')
> >>> +#define V4L2_AUDIO_FMT_IEC958_SUBFRAME_LE    v4l2_fourcc('A', 'U', '=
1', '8')
> >>> +#define V4L2_AUDIO_FMT_S24_3LE                       v4l2_fourcc('A'=
, 'U', '3', '2')
> >>> +#define V4L2_AUDIO_FMT_U24_3LE                       v4l2_fourcc('A'=
, 'U', '3', '4')
> >>> +#define V4L2_AUDIO_FMT_S20_3LE                       v4l2_fourcc('A'=
, 'U', '3', '6')
> >>> +#define V4L2_AUDIO_FMT_U20_3LE                       v4l2_fourcc('A'=
, 'U', '3', '8')
> >>> +
> >>> +#define v4l2_fourcc_to_audfmt(fourcc)        \
> >>> +     (__force snd_pcm_format_t)(((((fourcc) >> 16) & 0xff) - '0') * =
10  \
> >>> +                                + ((((fourcc) >> 24) & 0xff) - '0'))
> >>> +
> >>
> >> As I suggested in an earlier reply, add this:
> >>
> >> #define v4l2_audfmt_to_fourcc(audfmt) \
> >>         v4l2_fourcc('A', 'U', '0' + (audfmt) / 10, '0' + (audfmt) % 10=
)
> >>
> >> Even though it is not used in the drivers, since this is a public head=
er used
> >> by drivers and applications, it makes sense to provide the reverse map=
ping as well.
> >>
> >> Please test it in actual code to make sure there are no compilation wa=
rnings.

I test this definition, the compiler doesn't report warning.

best regards
Shengjiu Wang

> >>
> >> Regards,
> >>
> >>         Hans
> >>
> >>>  /* priv field value to indicates that subsequent fields are valid. *=
/
> >>>  #define V4L2_PIX_FMT_PRIV_MAGIC              0xfeedcafe
> >>>
> >>
>

