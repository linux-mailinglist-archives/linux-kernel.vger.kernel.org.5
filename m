Return-Path: <linux-kernel+bounces-70746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D64859BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FCEB2133E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D27200DC;
	Mon, 19 Feb 2024 06:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLyYN2Uz"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA61CD0F;
	Mon, 19 Feb 2024 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322631; cv=none; b=HIJupFm3emDi1rNclIG89qH0Zy7yy+65fcWLG2kNiB5ikohtIWuCsOx7Ljyn+D5yHv2PzeStpYbPPfacDS7WGg8Y3GEe0H52AcZFU2blvhtaJOXwSBjK34Oi/chSkPlR4AbDs6OlxRPr0jemJUlr5WnqqfcsiYoFJYF4SOZV210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322631; c=relaxed/simple;
	bh=4p3chFjmYrTbHPpVrweGEgP2/JTbJWJhCYkS0mNGTyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvH5KmoZtsAR5cGJ4HWutBYwZnG7WsAGr7QJN+W2/+3yOo56EA6CHJX95E/7xDzC838vmy7xM3lFnmvqXD+wc9toCv1CfjcC9Tg2Wp+FQMvXV34P8aRzToVyS9AdoDxeiu7nfYt7e2I2RHdNBKfcAt11At5jrugr+AymSllkvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLyYN2Uz; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3650b558a8cso7194715ab.3;
        Sun, 18 Feb 2024 22:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708322629; x=1708927429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoCJLYOduj9n23MLx0saV8cGvj1vyy+InFEBX0fNSWY=;
        b=HLyYN2Uzq/xUfb4U8Y+O6COapNlNsP15GcZWRWj2TUG2L+r0hnZmVkbtTUThizDd0E
         Is6n6OWeLkB4W7fRMA1P49Sjl4C0EbMlqrzd7ui22744K+DM/7QCsvlgUN7eVFnlO/4j
         sso8XvvxyEI1daUKqZZgPYuYm3N3c9aMOO1QhoUOGGOf/9GviklOv96wKTkSHYKwIH0f
         O4svTFd0aUbG5IoZ4KKS8N335355PLUmKQUBV33WLHXpyXu9nbD3dADTyQNeSl+qwBCF
         Yh+Sa/zF5gHHTIxJdO8K+7PwEiBb8TH/xz7kxaKXdYkP8hYbn2AFGwo3sOEQso0WfkSc
         6VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708322629; x=1708927429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoCJLYOduj9n23MLx0saV8cGvj1vyy+InFEBX0fNSWY=;
        b=uzsirGlN2swo/YwNx41aJNKr1FkE+pZnj5/Ua5//hQqXUbkJG3LBMnZ5VgK8k9Y+xU
         nK9oqW8OqMcwih2yXc9jD8TtvGrCMp7MPwgKwKDt5E8iKAHoh5dC32WqoMOAM82fO/7D
         yq8ha3SOoYWnQcmSoCAVey5z+tiCrC4SXDqnOPhXACFtcsunOMzyWpRtkqBU0gX6DQxr
         WBAyVQm9HmF38ewmWRCmblNhg3ZqNCADI9uf6YT2+IWJcL4mHnmxEFzywgz/Tu2bAclU
         lFUJIkDDrplmPkQdHA1SYTxrJpzbSgldo6o+nNWDp4TQA1L+hXUJHMyaXsLp3VAFy+OV
         xUKw==
X-Forwarded-Encrypted: i=1; AJvYcCUH0RDGcC47hirzwPlIk84v6wpIFUEaqdqc4Q5zcws5vwZutAIspjjNrGqyaASnmtoVK7QzCNL2qwcOEtc5pkLFX3AIfKr5nKrEL5V40RPYUNxYoukh6H2RGfkA826RV8Bcqpba/SjmFAs=
X-Gm-Message-State: AOJu0YxH15arTOv+MY7pWU0xstP0axu+/oIYNfFUNCTM85+lrpneet9S
	n5YlUv6KjFqWhdwrzSm3orT8msGB6Yk9zP79RB8AcYZDpsKb15T+goO+G3slW0PC4RNK/bXh5gs
	4E7cFv/dQAKDNyRoovKn+RZ+JEy8=
X-Google-Smtp-Source: AGHT+IEYk69UufUFWwE7DTTiq8C+0ZQ+JTG7QL74tqi/J6KrU4GZcFAsfIhM3H47exPifWYnK4hxbC8F6eipbdBDtHw=
X-Received: by 2002:a92:d78b:0:b0:363:e573:da77 with SMTP id
 d11-20020a92d78b000000b00363e573da77mr9821592iln.18.1708322628698; Sun, 18
 Feb 2024 22:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705581128-4604-1-git-send-email-shengjiu.wang@nxp.com>
 <1705581128-4604-11-git-send-email-shengjiu.wang@nxp.com> <20240217105708.53c81b04@coco.lan>
In-Reply-To: <20240217105708.53c81b04@coco.lan>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 19 Feb 2024 14:03:37 +0800
Message-ID: <CAA+D8APQy0NaZH44zgoHfMJ1pFS3TporVZZt7zV=Yy-edWacdg@mail.gmail.com>
Subject: Re: [PATCH v12 10/15] media: uapi: Add audio rate controls support
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl, sakari.ailus@iki.fi, 
	tfiga@chromium.org, m.szyprowski@samsung.com, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 5:57=E2=80=AFPM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> Em Thu, 18 Jan 2024 20:32:03 +0800
> Shengjiu Wang <shengjiu.wang@nxp.com> escreveu:
>
> > Add V4L2_CID_M2M_AUDIO_SOURCE_RATE and V4L2_CID_M2M_AUDIO_DEST_RATE
> > new IDs for rate control.
> >
> > Add V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET and
> > V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET for clock drift.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../media/v4l/ext-ctrls-audio-m2m.rst         | 20 +++++++++++++++++++
> >  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  6 ++++++
> >  include/uapi/linux/v4l2-controls.h            |  5 +++++
> >  3 files changed, 31 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.=
rst b/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
> > index 82d2ecedbfee..de579ab8fb94 100644
> > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
> > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
> > @@ -19,3 +19,23 @@ Audio M2M Control IDs
> >      The Audio M2M class descriptor. Calling
> >      :ref:`VIDIOC_QUERYCTRL` for this control will
> >      return a description of this control class.
> > +
> > +.. _v4l2-audio-asrc:
> > +
> > +``V4L2_CID_M2M_AUDIO_SOURCE_RATE (integer menu)``
> > +    Sets the audio source sample rate, unit is Hz
> > +
> > +``V4L2_CID_M2M_AUDIO_DEST_RATE (integer menu)``
> > +    Sets the audio destination sample rate, unit is Hz
> > +
> > +``V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET (fixed point)``
> > +    Sets the offset from the audio source sample rate, unit is Hz.
> > +    The offset compensates for any clock drift. The actual source audi=
o
> > +    sample rate is the ideal source audio sample rate from
> > +    ``V4L2_CID_M2M_AUDIO_SOURCE_RATE`` plus this fixed point offset.
> > +
> > +``V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET (fixed point)``
> > +    Sets the offset from the audio destination sample rate, unit is Hz=
.
> > +    The offset compensates for any clock drift. The actual destination=
 audio
> > +    sample rate is the ideal source audio sample rate from
> > +    ``V4L2_CID_M2M_AUDIO_DEST_RATE`` plus this fixed point offset.
>
> Hmm... first of all, controls on V4L2 API can either be get or set.
> So, starting the sentence with "Set" sounds an assumption that may
> be wrong.

Ok, will update the description.
>
> Also, I would explain a little bit more about the frequency offset values=
,
> as clock drift adjustment on PCM streams is something that can be done
> using different approaches.
>
> I'm assuming that what you wanted here is to use it to check if the
> video and audio clocks have some drift, and reducing or increasing
> the audio sample rate dynamically to ensure that such drift will
> stay constraint to a maximum allowed drift measured in mili or nano
> seconds. So, userspace would be expected to be monitoring such drift
> and increasing/decreasing the sample frequency as needed to maintain
> such constraint.
>
> Is that the way such uAPI is expected to work?

Yes. Userspace should monitor the drift, get the offset based on the
common sample rate (8k, 44.1k, 48k...) then send it to the driver.
The offset is a fixed point. it is base on the patch:
https://patchwork.kernel.org/project/linux-media/patch/cec82507-ced9-4e7d-8=
02c-04a40f84a4b4@xs4all.nl/

Best regards
Shengjiu Wang
>
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/=
v4l2-core/v4l2-ctrls-defs.c
> > index 2a85ea3dc92f..91e1f5348c23 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > @@ -1245,6 +1245,8 @@ const char *v4l2_ctrl_get_name(u32 id)
> >
> >       /* Audio M2M controls */
> >       case V4L2_CID_M2M_AUDIO_CLASS:  return "Audio M2M Controls";
> > +     case V4L2_CID_M2M_AUDIO_SOURCE_RATE:    return "Audio Source Samp=
le Rate";
> > +     case V4L2_CID_M2M_AUDIO_DEST_RATE:      return "Audio Destination=
 Sample Rate";
> >       default:
> >               return NULL;
> >       }
> > @@ -1606,6 +1608,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, e=
num v4l2_ctrl_type *type,
> >       case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:
> >               *type =3D V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY;
> >               break;
> > +     case V4L2_CID_M2M_AUDIO_SOURCE_RATE:
> > +     case V4L2_CID_M2M_AUDIO_DEST_RATE:
> > +             *type =3D V4L2_CTRL_TYPE_INTEGER_MENU;
> > +             break;
> >       default:
> >               *type =3D V4L2_CTRL_TYPE_INTEGER;
> >               break;
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4=
l2-controls.h
> > index a8b4b830c757..30129ccdc282 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -3495,6 +3495,11 @@ struct v4l2_ctrl_av1_film_grain {
> >  #define V4L2_CID_M2M_AUDIO_CLASS_BASE  (V4L2_CTRL_CLASS_M2M_AUDIO | 0x=
900)
> >  #define V4L2_CID_M2M_AUDIO_CLASS       (V4L2_CTRL_CLASS_M2M_AUDIO | 1)
> >
> > +#define V4L2_CID_M2M_AUDIO_SOURCE_RATE       (V4L2_CID_M2M_AUDIO_CLASS=
_BASE + 0)
> > +#define V4L2_CID_M2M_AUDIO_DEST_RATE (V4L2_CID_M2M_AUDIO_CLASS_BASE + =
1)
> > +#define V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET        (V4L2_CID_M2M_AUD=
IO_CLASS_BASE + 2)
> > +#define V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET  (V4L2_CID_M2M_AUDIO_CLASS=
_BASE + 3)
> > +
> >  /* MPEG-compression definitions kept for backwards compatibility */
> >  #ifndef __KERNEL__
> >  #define V4L2_CTRL_CLASS_MPEG            V4L2_CTRL_CLASS_CODEC
>
>
>
> Thanks,
> Mauro

