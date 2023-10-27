Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9280C7D8E21
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbjJ0F1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0F1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:27:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A713A93;
        Thu, 26 Oct 2023 22:27:21 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1429594a12.2;
        Thu, 26 Oct 2023 22:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698384441; x=1698989241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSH6er1S/8VpTk0zK1LTJVVGU+rFN/elA5pOh6jUYKs=;
        b=i8DlL/ckRkyzP3odkFZqqXwrW8NEeFHnHeKWUCxamQwP6ssqXsKvrXxv3JIqjBKw3Q
         kgPypEpk2dWxBD1GCNpewMndB5OIH7rnrQKJU2p1f3+NqHUdHPhaN5GX7BX3oH5NqeT6
         tXDJTR1ohn847FHBDk7v3/ZKnBbHTExhKVklUlZ5G2lAgn6TpoFiksdl3SMG8NPQhqqg
         nxfmtACdQyX7B85mBdhRrde4HwBKlcfFAoXVqwOIQ204g8FEY5eMElTk5F6+ChYqqUJY
         3zuesOhwVl8LEx09GcR6gWF+p1LSckO43tvvg7ASxEdF7AYZal+AFgyXY4FDG6vnzU0f
         w8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698384441; x=1698989241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSH6er1S/8VpTk0zK1LTJVVGU+rFN/elA5pOh6jUYKs=;
        b=eVCZ874XJP/vVhfPmuDGCrWxkIKKF3iCFsRD/jCL7UxUN2UdBKOBijPBGML2VWCLdh
         X1oi8eAwjc5UV+nFANgZIFWo81v3AG8aF703SkJZ3Vrrwj9K8VERM0MeIp6pq9Zf3aaM
         OM3odRf4egwNgX/9sMS+dpEyEl2+E5CKlBJezOqtkb7Mal2SHHmcjjJH8l5DyT/KOisl
         pXhzC3hbo7VuPlc9PYowD/0uSzk544teEEJl0UWehFJJ/wbJdu6/lEZ2y9aLT3xlNJBi
         e4PcsT7+oWs/lAMHJd07Rh5pQe15PQfGmE6Y4sV+1fEhENJtGhaCAtw0tYjvLoOGLbe3
         uulA==
X-Gm-Message-State: AOJu0YzedhkLcGSU3htuzv16wg5gK/qbF962vgLcCZFyZ3EIqDVJisOp
        rITGLxpdsKAge6hK5F2zU6UjM2nDAM1QuyXDxk8=
X-Google-Smtp-Source: AGHT+IEnI8ab1+JdNF7ype3BwZWF15ZqPeMu0XQR0L+WWYyQ5mhuVfNxRleauDz1GPh94vZdw3ix9QMRKF9L/xPfAsI=
X-Received: by 2002:a17:90a:6d02:b0:27d:21dd:258f with SMTP id
 z2-20020a17090a6d0200b0027d21dd258fmr1611815pjj.37.1698384441050; Thu, 26 Oct
 2023 22:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <1697794232-2607-1-git-send-email-shengjiu.wang@nxp.com>
 <1697794232-2607-12-git-send-email-shengjiu.wang@nxp.com> <7929b801-63a4-4b30-9da7-e080e38a7e40@xs4all.nl>
In-Reply-To: <7929b801-63a4-4b30-9da7-e080e38a7e40@xs4all.nl>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 27 Oct 2023 13:27:09 +0800
Message-ID: <CAA+D8APYcRvmscFcEx4bg5bpjUSmK7G7TZ8d3P-8-yZkvCrw8A@mail.gmail.com>
Subject: Re: [RFC PATCH v7 11/13] media: uapi: Add audio rate controls support
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

On Wed, Oct 25, 2023 at 6:47=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> w=
rote:
>
> On 20/10/2023 11:30, Shengjiu Wang wrote:
> > Add V4L2_CID_M2M_AUDIO_SOURCE_RATE and V4L2_CID_M2M_AUDIO_DEST_RATE
> > new IDs for rate control.
> >
> > Add V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET and
> > V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET for clock drift.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../media/v4l/ext-ctrls-audio-m2m.rst          | 18 ++++++++++++++++++
> >  drivers/media/v4l2-core/v4l2-ctrls-defs.c      | 12 ++++++++++++
> >  include/uapi/linux/v4l2-controls.h             |  5 +++++
> >  3 files changed, 35 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.=
rst b/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
> > index 82d2ecedbfee..e6972a2d3b17 100644
> > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
> > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-audio-m2m.rst
> > @@ -19,3 +19,21 @@ Audio M2M Control IDs
> >      The Audio M2M class descriptor. Calling
> >      :ref:`VIDIOC_QUERYCTRL` for this control will
> >      return a description of this control class.
> > +
> > +.. _v4l2-audio-asrc:
> > +
> > +``V4L2_CID_M2M_AUDIO_SOURCE_RATE``
>
> Add ' (integer menu)' after the name.
>
> > +    Sets the audio source rate, unit is (Hz)
>
> (Hz) -> Hz.
>
> General question: is 'rate' good enough or should it be 'sample rate'?

Ok, will use 'sample rate'.

Best regards
Wang shengjiu
>
> > +
> > +``V4L2_CID_M2M_AUDIO_DEST_RATE``
> > +    Sets the audio destination rate, unit is (Hz)
>
> Ditto here.
>
> > +
> > +``V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET``
>
> Add ' (fixed point)' after the name.
>
> > +    Sets the offset for audio source rate, unit is (Hz).
>
> for -> from the
>
> (Hz) -> Hz
>
> > +    Offset expresses the drift of clock if there is. It is
> > +    equal to real rate minus ideal rate.
>
> How about:
>
> The offset compensates for any clock drift. The actual source audio
> rate is the ideal source audio rate from ``V4L2_CID_M2M_AUDIO_SOURCE_RATE=
``
> plus this fixed point offset.
>
> > +
> > +``V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET``
> > +    Sets the offset for audio destination rate, unit is (Hz)
> > +    Offset expresses the drift of clock if there is. It is
> > +    equal to real rate minus ideal rate.
>
> Same changes as for V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET.
>
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/=
v4l2-core/v4l2-ctrls-defs.c
> > index 2a85ea3dc92f..b695cbdd1f6e 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > @@ -1245,6 +1245,10 @@ const char *v4l2_ctrl_get_name(u32 id)
> >
> >       /* Audio M2M controls */
> >       case V4L2_CID_M2M_AUDIO_CLASS:  return "Audio M2M Controls";
> > +     case V4L2_CID_M2M_AUDIO_SOURCE_RATE:    return "Audio Source Samp=
le Rate";
> > +     case V4L2_CID_M2M_AUDIO_DEST_RATE:      return "Audio Dest Sample=
 Rate";
> > +     case V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET:     return "Audio Sou=
rce Sample Rate Offset";
> > +     case V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET:       return "Audio Des=
t Sample Rate Offset";
>
> Related to my question above: "Sample Rate" or just "Rate"? Whatever we p=
ick, it should
> be consistent.
>
> >       default:
> >               return NULL;
> >       }
> > @@ -1606,6 +1610,14 @@ void v4l2_ctrl_fill(u32 id, const char **name, e=
num v4l2_ctrl_type *type,
> >       case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:
> >               *type =3D V4L2_CTRL_TYPE_HDR10_MASTERING_DISPLAY;
> >               break;
> > +     case V4L2_CID_M2M_AUDIO_SOURCE_RATE:
> > +     case V4L2_CID_M2M_AUDIO_DEST_RATE:
> > +             *type =3D V4L2_CTRL_TYPE_INTEGER_MENU;
> > +             break;
> > +     case V4L2_CID_M2M_AUDIO_SOURCE_RATE_OFFSET:
> > +     case V4L2_CID_M2M_AUDIO_DEST_RATE_OFFSET:
> > +             *type =3D V4L2_CTRL_TYPE_FIXED_POINT;
> > +             break;
> >       default:
> >               *type =3D V4L2_CTRL_TYPE_INTEGER;
> >               break;
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4=
l2-controls.h
> > index eb0f0a76f867..d433c6f0b533 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -3498,4 +3498,9 @@ struct v4l2_ctrl_av1_film_grain {
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
> >  #endif
>
> Regards,
>
>         Hans
