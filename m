Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DBA7AA71C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 04:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjIVCvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 22:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVCvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:51:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9680C194;
        Thu, 21 Sep 2023 19:51:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27489f78e52so1172470a91.1;
        Thu, 21 Sep 2023 19:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695351104; x=1695955904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYkrqB9uA7M+0eOAqW1r8qSkknHUZhDVrIi/aSlq6T8=;
        b=fsnuCqZ8PF2KC0O9A2dSIj5Th5A7Tw1KZ5LPBZDIF0bXfdX9gvYCCPg5cW6cSjzDF3
         cM+UCA5JhU9Axbf76fANI7VSCQ/qiuUIiUfZUus+GlJWImdjQ6ALc25DF4lIgaYwSai+
         I5huD8aINmyyyCZBkKo414wtx53hD7netuU5+dPEfJVc7DXtl81Km3SE3Um0oakYBfMy
         Kd+jbqDJb6EBor20li2BC0EGdwo4hSX3dvp9jZYJ5l5RRLnDDAvX09560n4cvAkCeP64
         sTEgsUHBleyVmwQaLjsRW+JwOoNBZu/ooSx0m7KWS+Lg5Z7Q/Vexlh3cC3TlryCAIG80
         quMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695351104; x=1695955904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYkrqB9uA7M+0eOAqW1r8qSkknHUZhDVrIi/aSlq6T8=;
        b=LKaziNy/FF2+NyTq+atTSyX88n/wE/KGrQd9TNoWAO7sNJoWT/mDO8K8yGO7o0fN8/
         X47in0MIoN0ALTwdWPc51MYeWvmkkWTAgU8v3IxiA1irqhrZ2A91FwWxIuyazV1U5rZ0
         MennN0rjBMrCTqBCmjBslwGGkv3/vW3BT8ObuzMK+oPrm2ikfsNa/chdMHNR2UN0xVJa
         OTaOTm0OVdOlfBoRlp7N6yekvHGPpXf7fZTF7xAxlMKjhWkZaKqECgZik5BmbPg46joI
         BzfR6MU4B3mlJOrXJhUoqskwz2iI7dIWTWo5BZ76OuwhbB/jqZh8snkJA0vjPI41pZwc
         kxbQ==
X-Gm-Message-State: AOJu0YxoKcaELETlfTh9VlTTqX/qmu/d0Xt3wr37sDtFi0G8JuvTZ4Sf
        9+1MOoStMOFsqS+kpDmgdpbaNmy91//MFXPQpZs=
X-Google-Smtp-Source: AGHT+IGtiz5wXyrbAhyFg8avb8jX5ymjFN23gqRi0pY8tk76E77xHmkQsY5RA8geWyon6mrn/RqdLparfr1kcZjp+nY=
X-Received: by 2002:a17:90b:19cb:b0:276:cd68:6081 with SMTP id
 nm11-20020a17090b19cb00b00276cd686081mr5418829pjb.40.1695351103836; Thu, 21
 Sep 2023 19:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <1695202370-24678-1-git-send-email-shengjiu.wang@nxp.com>
 <1695202370-24678-10-git-send-email-shengjiu.wang@nxp.com>
 <fbedcbf1-d925-47d6-b9fb-c9e15263c117@xs4all.nl> <CAA+D8APyNGFSry1GUv6TOW0nKYHKSwQd5bTcRNuT7cu0Xf8eUA@mail.gmail.com>
 <5292ce53-643e-44f0-b2cc-cb66efee9712@xs4all.nl> <CAA+D8AMZN59uTRs2sOrSeVb5AGopTzurNVCTNwJOVPahfEXd+w@mail.gmail.com>
 <2d44d574-08e5-4db3-87d9-5d12657f8935@xs4all.nl>
In-Reply-To: <2d44d574-08e5-4db3-87d9-5d12657f8935@xs4all.nl>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 22 Sep 2023 10:51:32 +0800
Message-ID: <CAA+D8AN+Uz+3CN9BnD5R_gp5opD1v-D8FBjANRpGrH43Ac2tdg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 10:09=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> =
wrote:
>
> On 21/09/2023 13:13, Shengjiu Wang wrote:
> > On Thu, Sep 21, 2023 at 3:11=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.n=
l> wrote:
> >>
> >> On 21/09/2023 08:55, Shengjiu Wang wrote:
> >>> On Wed, Sep 20, 2023 at 6:19=E2=80=AFPM Hans Verkuil <hverkuil@xs4all=
.nl> wrote:
> >>>>
> >>>> On 20/09/2023 11:32, Shengjiu Wang wrote:
> >>>>> The input clock and output clock may not be the accurate
> >>>>> rate as the sample rate, there is some drift, so the convert
> >>>>> ratio of i.MX ASRC module need to be changed according to
> >>>>> actual clock rate.
> >>>>>
> >>>>> Add V4L2_CID_USER_IMX_ASRC_RATIO_MOD control for user to
> >>>>> adjust the ratio.
> >>>>>
> >>>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >>>>> ---
> >>>>>  Documentation/userspace-api/media/v4l/control.rst | 5 +++++
> >>>>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c         | 1 +
> >>>>>  include/uapi/linux/v4l2-controls.h                | 1 +
> >>>>>  3 files changed, 7 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/userspace-api/media/v4l/control.rst b/Do=
cumentation/userspace-api/media/v4l/control.rst
> >>>>> index 4463fce694b0..2bc175900a34 100644
> >>>>> --- a/Documentation/userspace-api/media/v4l/control.rst
> >>>>> +++ b/Documentation/userspace-api/media/v4l/control.rst
> >>>>> @@ -318,6 +318,11 @@ Control IDs
> >>>>>      depending on particular custom controls should check the drive=
r name
> >>>>>      and version, see :ref:`querycap`.
> >>>>>
> >>>>> +.. _v4l2-audio-imx:
> >>>>> +
> >>>>> +``V4L2_CID_USER_IMX_ASRC_RATIO_MOD``
> >>>>> +    sets the rasampler ratio modifier of i.MX asrc module.
> >>>>
> >>>> rasampler -> resampler (I think?)
> >>>>
> >>>> This doesn't document at all what the type of the control is or how =
to interpret it.
> >>>>
> >>>>> +
> >>>>>  Applications can enumerate the available controls with the
> >>>>>  :ref:`VIDIOC_QUERYCTRL` and
> >>>>>  :ref:`VIDIOC_QUERYMENU <VIDIOC_QUERYCTRL>` ioctls, get and set a
> >>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/me=
dia/v4l2-core/v4l2-ctrls-defs.c
> >>>>> index 8696eb1cdd61..16f66f66198c 100644
> >>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>> @@ -1242,6 +1242,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>>>>       case V4L2_CID_COLORIMETRY_CLASS:        return "Colorimetry C=
ontrols";
> >>>>>       case V4L2_CID_COLORIMETRY_HDR10_CLL_INFO:               retur=
n "HDR10 Content Light Info";
> >>>>>       case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:      retur=
n "HDR10 Mastering Display";
> >>>>> +     case V4L2_CID_USER_IMX_ASRC_RATIO_MOD:                  retur=
n "ASRC RATIO MOD";
> >>>>
> >>>> Let's stay consistent with the other control names:
> >>>>
> >>>> "ASRC Ratio Modifier"
> >>>>
> >>>> But if this is a driver specific control, then this doesn't belong h=
ere.
> >>>>
> >>>> Driver specific controls are defined in the driver itself, including=
 this
> >>>> description.
> >>>>
> >>>> Same for the control documentation: if it is driver specific, then t=
hat
> >>>> typically is documented either in a driver-specific public header, o=
r
> >>>> possibly in driver-specific documentation (Documentation/admin-guide=
/media/).
> >>>>
> >>>> But is this imx specific? Wouldn't other similar devices need this?
> >>>
> >>> It is imx specific.
> >>
> >> Why? I'm not opposed to this, but I wonder if you looked at datasheets=
 of
> >> similar devices from other vendors: would they use something similar?
> >
> > I tried to find some datasheets for other vendors, but failed to find t=
hem.
> > So I don't know how they implement this part.
> >
> > Ratio modification on i.MX is to modify the configured ratio.
> > For example, the input rate is 44.1kHz,  output rate is 48kHz,
> > configured ratio =3D 441/480,   the ratio modification is to modify
> > the fractional part of (441/480) with small steps.  because the
> > input clock or output clock has drift in the real hardware.
> > The ratio modification is signed value, it is added to configured
> > ratio.
> >
> > In our case, we have some sysfs interface for user to get the
> > clock from input audio device and output audio device, user
> > need to calculate the ratio dynamically , then configure the
> > modification to driver
>
> So this ratio modifier comes into play when either the audio input
> or audio output (or both) are realtime audio inputs/outputs where
> the sample rate is not a perfect 44.1 or 48 kHz, but slightly different?

yes.

>
> If you would use this resampler to do offline resampling (i.e. resample
> a 44.1 kHz wav file to a 48 kHz wav file), then this wouldn't be needed,
> correct?

yes.

>
> When dealing with realtime audio, userspace will know how to get the
> precise sample rate, but that is out-of-scope of this driver. Here
> you just need a knob to slightly tweak the resampling ratio.
>
> If my understanding is correct, then I wonder if it is such a good
> idea to put the rate into the v4l2_audio_format: it really has nothing
> to do with the audio format as it is stored in memory.
>
> What if you would drop that 'rate' field and instead create just a single
> control for the resampling ratio. This can use struct v4l2_fract to repre=
sent
> a fraction. It would be more work since v4l2_fract is currently not suppo=
rted
> for controls, but it is not hard to add support for that (just a bit tedi=
ous)
> and I actually think this might be a perfect solution.
>
> That way userspace can quite precisely tweak the ratio on the fly, and
> it is a generic solution as well instead of mediatek specific.
>

(rate, channel, format) are the basic parameters for audio stream.
For example, if there is decoder/encoder requirement, the rate field is
still needed,  I think the rate shouldn't be removed.

tweak ratio is not always needed by use case. As you said, for
file to file conversion, it is not needed, so keeping 'rate' is necessary.

best regards
wang shengjiu

> Regards,
>
>         Hans
>
> >
> > May be other vendors has similar implementation. or make
> > the definition be generic is an option.
> >
> > best regards
> > wang shengjiu
> >
> >>
> >> And the very short description you gave in the commit log refers to in=
put
> >> and output clock: how would userspace know those clock frequencies? In
> >> other words, what information does userspace need in order to set this
> >> control correctly? And is that information actually available? How wou=
ld
> >> you use this control?
> >>
> >> I don't really understand how this is supposed to be used.
> >>
> >>>
> >>> Does this mean that I need to create a header file in include/uapi/li=
nux
> >>> folder to put this definition?  I just hesitate if this is necessary.
> >>
> >> Yes, put it there. There are some examples of this already:
> >>
> >> include/uapi/linux/aspeed-video.h
> >> include/uapi/linux/max2175.h
> >>
> >>>
> >>> There is folder Documentation/userspace-api/media/drivers/ for driver=
s
> >>> Should this document in this folder, not in the
> >>> Documentation/admin-guide/media/?
> >>
> >> Yes, you are correct. For the headers above, the corresponding documen=
tation
> >> is in:
> >>
> >> Documentation/userspace-api/media/drivers/aspeed-video.rst
> >> Documentation/userspace-api/media/drivers/max2175.rst
> >>
> >> So you have some examples as reference.
> >>
> >> Frankly, what is in admin-guide and in userspace-api is a bit random, =
it
> >> probably could use a cleanup.
> >>
> >> Regards,
> >>
> >>         Hans
> >>
> >>>
> >>> Best regards
> >>> Wang shengjiu
> >>>>
> >>>>>       default:
> >>>>>               return NULL;
> >>>>>       }
> >>>>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linu=
x/v4l2-controls.h
> >>>>> index c3604a0a3e30..b1c319906d12 100644
> >>>>> --- a/include/uapi/linux/v4l2-controls.h
> >>>>> +++ b/include/uapi/linux/v4l2-controls.h
> >>>>> @@ -162,6 +162,7 @@ enum v4l2_colorfx {
> >>>>>  /* The base for the imx driver controls.
> >>>>>   * We reserve 16 controls for this driver. */
> >>>>>  #define V4L2_CID_USER_IMX_BASE                       (V4L2_CID_USE=
R_BASE + 0x10b0)
> >>>>> +#define V4L2_CID_USER_IMX_ASRC_RATIO_MOD     (V4L2_CID_USER_IMX_BA=
SE + 0)
> >>>>>
> >>>>>  /*
> >>>>>   * The base for the atmel isc driver controls.
> >>>>
> >>>> Regards,
> >>>>
> >>>>         Hans
> >>
>
