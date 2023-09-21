Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EB07A9D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjIUTbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjIUTag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:30:36 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F000B56D38;
        Thu, 21 Sep 2023 10:18:26 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c21b2c6868so710554a34.1;
        Thu, 21 Sep 2023 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316706; x=1695921506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6Io+NqdH4bxbw7qedQ2WLW3wnG7KpfohNDHzRzQ7HQ=;
        b=a42Jhq7F8SjW0ZExjFGT/NMG51AGscXCa+vQg0M7q6tY4RR8SUfn9gMooM/yJnXL72
         amhA9iSA5LaRFZ/NBIhcyxWEOVnoWlm10Wl9eZnnFYJp/G5sdG0Pj9DNtKk1y7oHlxsw
         DC64FvDaFge121tiPM3qcIYgoHuv7joy5zFoRcoSXXnKfXHpR13iFUJIEx0yDPzT4Ke/
         YqKE15JJc9+PPUveY3dC8bf98HMKfde+sx1GUmX+4BWNrypq1qwTT+vl/NV/jqvkJt9S
         kljpk1tq0CsalhNUwTq/fUxHyyO33oZgziqIo4vB3a6TGtkEc7V88qSSdcJUdePcaH5c
         04+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316706; x=1695921506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6Io+NqdH4bxbw7qedQ2WLW3wnG7KpfohNDHzRzQ7HQ=;
        b=J0PBu7FA7o7uIuFEz9psKi8rAEt4HQEYwKZVP8oVDeXxAy+Iw+5bGTeWTuwl6IyFSK
         7/xuM5khrW1jQL1v77JfSvUZnfHoSk7sUcJdq7XMpKBldIENQUk65VBG1qDNxf+km3tN
         R6yBwTOnkXdjTsV3DZuGCdxHuXY9fCh2egLR2qRhMBZjB/JRJGDBqaaEpZIexq7g4sLJ
         rOfjeC2AHFnFBCKjSS9vYX90wABPAxMBlCyuDUaLBQjOv5cmxhyi87EsV57IbLkpLOXi
         dNxoz9X5WiZIXMPrWDn+1t5uRYtTghxZnMlCNQPpyuYBoBsl0Atr17cyMkYz0oNlwEjj
         WhCg==
X-Gm-Message-State: AOJu0YyNTFiVI+kQDcZkqcWtJaWLdEE22XQiphi+uF0O5oS8Or8A+W2T
        b+tSW0ABvEnBO1vcob+Z6e5WcNzXTphSx8XI1ms0Ro9xdjE=
X-Google-Smtp-Source: AGHT+IFd83OFEN20e4ml9L8pmlvbvhS2daJ1R+Y7BWCut39c7qxVh2xC1k3KYOAJpyayzaGsCncOE3w/BFNte+w5Fc8=
X-Received: by 2002:a17:90b:390a:b0:26d:2bac:a0bb with SMTP id
 ob10-20020a17090b390a00b0026d2baca0bbmr4967326pjb.6.1695294806097; Thu, 21
 Sep 2023 04:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <1695202370-24678-1-git-send-email-shengjiu.wang@nxp.com>
 <1695202370-24678-10-git-send-email-shengjiu.wang@nxp.com>
 <fbedcbf1-d925-47d6-b9fb-c9e15263c117@xs4all.nl> <CAA+D8APyNGFSry1GUv6TOW0nKYHKSwQd5bTcRNuT7cu0Xf8eUA@mail.gmail.com>
 <5292ce53-643e-44f0-b2cc-cb66efee9712@xs4all.nl>
In-Reply-To: <5292ce53-643e-44f0-b2cc-cb66efee9712@xs4all.nl>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 21 Sep 2023 19:13:14 +0800
Message-ID: <CAA+D8AMZN59uTRs2sOrSeVb5AGopTzurNVCTNwJOVPahfEXd+w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 09/11] media: uapi: Add V4L2_CID_USER_IMX_ASRC_RATIO_MOD
 control
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
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 3:11=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> w=
rote:
>
> On 21/09/2023 08:55, Shengjiu Wang wrote:
> > On Wed, Sep 20, 2023 at 6:19=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.n=
l> wrote:
> >>
> >> On 20/09/2023 11:32, Shengjiu Wang wrote:
> >>> The input clock and output clock may not be the accurate
> >>> rate as the sample rate, there is some drift, so the convert
> >>> ratio of i.MX ASRC module need to be changed according to
> >>> actual clock rate.
> >>>
> >>> Add V4L2_CID_USER_IMX_ASRC_RATIO_MOD control for user to
> >>> adjust the ratio.
> >>>
> >>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >>> ---
> >>>  Documentation/userspace-api/media/v4l/control.rst | 5 +++++
> >>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c         | 1 +
> >>>  include/uapi/linux/v4l2-controls.h                | 1 +
> >>>  3 files changed, 7 insertions(+)
> >>>
> >>> diff --git a/Documentation/userspace-api/media/v4l/control.rst b/Docu=
mentation/userspace-api/media/v4l/control.rst
> >>> index 4463fce694b0..2bc175900a34 100644
> >>> --- a/Documentation/userspace-api/media/v4l/control.rst
> >>> +++ b/Documentation/userspace-api/media/v4l/control.rst
> >>> @@ -318,6 +318,11 @@ Control IDs
> >>>      depending on particular custom controls should check the driver =
name
> >>>      and version, see :ref:`querycap`.
> >>>
> >>> +.. _v4l2-audio-imx:
> >>> +
> >>> +``V4L2_CID_USER_IMX_ASRC_RATIO_MOD``
> >>> +    sets the rasampler ratio modifier of i.MX asrc module.
> >>
> >> rasampler -> resampler (I think?)
> >>
> >> This doesn't document at all what the type of the control is or how to=
 interpret it.
> >>
> >>> +
> >>>  Applications can enumerate the available controls with the
> >>>  :ref:`VIDIOC_QUERYCTRL` and
> >>>  :ref:`VIDIOC_QUERYMENU <VIDIOC_QUERYCTRL>` ioctls, get and set a
> >>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/medi=
a/v4l2-core/v4l2-ctrls-defs.c
> >>> index 8696eb1cdd61..16f66f66198c 100644
> >>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>> @@ -1242,6 +1242,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>>       case V4L2_CID_COLORIMETRY_CLASS:        return "Colorimetry Con=
trols";
> >>>       case V4L2_CID_COLORIMETRY_HDR10_CLL_INFO:               return =
"HDR10 Content Light Info";
> >>>       case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:      return =
"HDR10 Mastering Display";
> >>> +     case V4L2_CID_USER_IMX_ASRC_RATIO_MOD:                  return =
"ASRC RATIO MOD";
> >>
> >> Let's stay consistent with the other control names:
> >>
> >> "ASRC Ratio Modifier"
> >>
> >> But if this is a driver specific control, then this doesn't belong her=
e.
> >>
> >> Driver specific controls are defined in the driver itself, including t=
his
> >> description.
> >>
> >> Same for the control documentation: if it is driver specific, then tha=
t
> >> typically is documented either in a driver-specific public header, or
> >> possibly in driver-specific documentation (Documentation/admin-guide/m=
edia/).
> >>
> >> But is this imx specific? Wouldn't other similar devices need this?
> >
> > It is imx specific.
>
> Why? I'm not opposed to this, but I wonder if you looked at datasheets of
> similar devices from other vendors: would they use something similar?

I tried to find some datasheets for other vendors, but failed to find them.
So I don't know how they implement this part.

Ratio modification on i.MX is to modify the configured ratio.
For example, the input rate is 44.1kHz,  output rate is 48kHz,
configured ratio =3D 441/480,   the ratio modification is to modify
the fractional part of (441/480) with small steps.  because the
input clock or output clock has drift in the real hardware.
The ratio modification is signed value, it is added to configured
ratio.

In our case, we have some sysfs interface for user to get the
clock from input audio device and output audio device, user
need to calculate the ratio dynamically , then configure the
modification to driver

May be other vendors has similar implementation. or make
the definition be generic is an option.

best regards
wang shengjiu

>
> And the very short description you gave in the commit log refers to input
> and output clock: how would userspace know those clock frequencies? In
> other words, what information does userspace need in order to set this
> control correctly? And is that information actually available? How would
> you use this control?
>
> I don't really understand how this is supposed to be used.
>
> >
> > Does this mean that I need to create a header file in include/uapi/linu=
x
> > folder to put this definition?  I just hesitate if this is necessary.
>
> Yes, put it there. There are some examples of this already:
>
> include/uapi/linux/aspeed-video.h
> include/uapi/linux/max2175.h
>
> >
> > There is folder Documentation/userspace-api/media/drivers/ for drivers
> > Should this document in this folder, not in the
> > Documentation/admin-guide/media/?
>
> Yes, you are correct. For the headers above, the corresponding documentat=
ion
> is in:
>
> Documentation/userspace-api/media/drivers/aspeed-video.rst
> Documentation/userspace-api/media/drivers/max2175.rst
>
> So you have some examples as reference.
>
> Frankly, what is in admin-guide and in userspace-api is a bit random, it
> probably could use a cleanup.
>
> Regards,
>
>         Hans
>
> >
> > Best regards
> > Wang shengjiu
> >>
> >>>       default:
> >>>               return NULL;
> >>>       }
> >>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/=
v4l2-controls.h
> >>> index c3604a0a3e30..b1c319906d12 100644
> >>> --- a/include/uapi/linux/v4l2-controls.h
> >>> +++ b/include/uapi/linux/v4l2-controls.h
> >>> @@ -162,6 +162,7 @@ enum v4l2_colorfx {
> >>>  /* The base for the imx driver controls.
> >>>   * We reserve 16 controls for this driver. */
> >>>  #define V4L2_CID_USER_IMX_BASE                       (V4L2_CID_USER_=
BASE + 0x10b0)
> >>> +#define V4L2_CID_USER_IMX_ASRC_RATIO_MOD     (V4L2_CID_USER_IMX_BASE=
 + 0)
> >>>
> >>>  /*
> >>>   * The base for the atmel isc driver controls.
> >>
> >> Regards,
> >>
> >>         Hans
>
