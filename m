Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A07A9E14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjIUTzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjIUTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:54:32 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DF16901C;
        Thu, 21 Sep 2023 12:02:06 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4525cfe255bso1681147137.1;
        Thu, 21 Sep 2023 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695322925; x=1695927725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bVL+jGs6sqP7VG1dEZazWMAPQBBD+mX9InFJhTfc4M=;
        b=YtQz/Fp4aeyUfVE6lgsa8mx9dgE0UFXPyJRfwKQsfM34H4uPI9KPAMySLZmgOh4klB
         59r/aLK5R3gCNoFH1xts88xmsw5jKKTrk5h72yjxcADRw88ipZNMiOCvh7snAFYMUwCZ
         Un7YdvBlI3Dgd92+1HrDMlBNoO4jdwQlMvNCqTQcp5/+y2JO+ltI0J9lDAo4DRh3fIdN
         HL916lDdhxhiJBW+IncpacsAVs9BD6OGL+UxNIzziO2RdlpJ/z7YL7cFsigX2lSxwFr5
         xjRGyPbTiNLHjDYopfCdxDwxwhPyZ/gOfHzS2tbOMOi+of8UHHWJiEEwKlqLi0c2CGrd
         jLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322925; x=1695927725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bVL+jGs6sqP7VG1dEZazWMAPQBBD+mX9InFJhTfc4M=;
        b=gV+5M0MQxCY5z0aDMCNYR1wxRRR+IjsoaKDRqHPvR7GHoR0wEx4h8BCOQ2+Uh1EF8n
         niXYbnQrQJ6CfPDOSCIa1miB12MdG9m/kn5Ld3LbZMUL/Jc7HZAfZZejpv7SUiH8D7gk
         1TXX5KNlxkqw3B2/FOp7/M17U+pdk82AyrCmnqe8vDvG2gqB94IZAX+DNWpcRSt1X0uF
         Dh4Y36lEKGf9krgAr37SkYmfEUDMMahy/mAMhKlOK5ZcWowyR6J4Gsvgn3i3FLOVrXq+
         Cxy5ZIX+7f+RK00heCpxtSskY2QhXuDp12Uu2KXAic3/PoKPzOtuBffxHHooTZbRcLIF
         IcsQ==
X-Gm-Message-State: AOJu0Ywfh9Q1PEIaliK8QgGWPwOViTgQLG4r6gQ6TkPOVDlB9M8WhY0d
        fIVVbeiWaq9sEj3gYaX+HrKOmndTyzwrgnv4VommOJsYVtI=
X-Google-Smtp-Source: AGHT+IFVBrCouVQWwD+e2QYzdo6XT481j2Idi0aW4ihmGivrnNEgvLCRqXRTybpDG6APLo336LaCnJUTntu6YTFsRW0=
X-Received: by 2002:a17:90b:1482:b0:276:6be8:8bfe with SMTP id
 js2-20020a17090b148200b002766be88bfemr7106957pjb.23.1695279348052; Wed, 20
 Sep 2023 23:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <1695202370-24678-1-git-send-email-shengjiu.wang@nxp.com>
 <1695202370-24678-10-git-send-email-shengjiu.wang@nxp.com> <fbedcbf1-d925-47d6-b9fb-c9e15263c117@xs4all.nl>
In-Reply-To: <fbedcbf1-d925-47d6-b9fb-c9e15263c117@xs4all.nl>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 21 Sep 2023 14:55:36 +0800
Message-ID: <CAA+D8APyNGFSry1GUv6TOW0nKYHKSwQd5bTcRNuT7cu0Xf8eUA@mail.gmail.com>
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
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 6:19=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> w=
rote:
>
> On 20/09/2023 11:32, Shengjiu Wang wrote:
> > The input clock and output clock may not be the accurate
> > rate as the sample rate, there is some drift, so the convert
> > ratio of i.MX ASRC module need to be changed according to
> > actual clock rate.
> >
> > Add V4L2_CID_USER_IMX_ASRC_RATIO_MOD control for user to
> > adjust the ratio.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  Documentation/userspace-api/media/v4l/control.rst | 5 +++++
> >  drivers/media/v4l2-core/v4l2-ctrls-defs.c         | 1 +
> >  include/uapi/linux/v4l2-controls.h                | 1 +
> >  3 files changed, 7 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/control.rst b/Docume=
ntation/userspace-api/media/v4l/control.rst
> > index 4463fce694b0..2bc175900a34 100644
> > --- a/Documentation/userspace-api/media/v4l/control.rst
> > +++ b/Documentation/userspace-api/media/v4l/control.rst
> > @@ -318,6 +318,11 @@ Control IDs
> >      depending on particular custom controls should check the driver na=
me
> >      and version, see :ref:`querycap`.
> >
> > +.. _v4l2-audio-imx:
> > +
> > +``V4L2_CID_USER_IMX_ASRC_RATIO_MOD``
> > +    sets the rasampler ratio modifier of i.MX asrc module.
>
> rasampler -> resampler (I think?)
>
> This doesn't document at all what the type of the control is or how to in=
terpret it.
>
> > +
> >  Applications can enumerate the available controls with the
> >  :ref:`VIDIOC_QUERYCTRL` and
> >  :ref:`VIDIOC_QUERYMENU <VIDIOC_QUERYCTRL>` ioctls, get and set a
> > diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/=
v4l2-core/v4l2-ctrls-defs.c
> > index 8696eb1cdd61..16f66f66198c 100644
> > --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> > @@ -1242,6 +1242,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >       case V4L2_CID_COLORIMETRY_CLASS:        return "Colorimetry Contr=
ols";
> >       case V4L2_CID_COLORIMETRY_HDR10_CLL_INFO:               return "H=
DR10 Content Light Info";
> >       case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:      return "H=
DR10 Mastering Display";
> > +     case V4L2_CID_USER_IMX_ASRC_RATIO_MOD:                  return "A=
SRC RATIO MOD";
>
> Let's stay consistent with the other control names:
>
> "ASRC Ratio Modifier"
>
> But if this is a driver specific control, then this doesn't belong here.
>
> Driver specific controls are defined in the driver itself, including this
> description.
>
> Same for the control documentation: if it is driver specific, then that
> typically is documented either in a driver-specific public header, or
> possibly in driver-specific documentation (Documentation/admin-guide/medi=
a/).
>
> But is this imx specific? Wouldn't other similar devices need this?

It is imx specific.

Does this mean that I need to create a header file in include/uapi/linux
folder to put this definition?  I just hesitate if this is necessary.

There is folder Documentation/userspace-api/media/drivers/ for drivers
Should this document in this folder, not in the
Documentation/admin-guide/media/?

Best regards
Wang shengjiu
>
> >       default:
> >               return NULL;
> >       }
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4=
l2-controls.h
> > index c3604a0a3e30..b1c319906d12 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -162,6 +162,7 @@ enum v4l2_colorfx {
> >  /* The base for the imx driver controls.
> >   * We reserve 16 controls for this driver. */
> >  #define V4L2_CID_USER_IMX_BASE                       (V4L2_CID_USER_BA=
SE + 0x10b0)
> > +#define V4L2_CID_USER_IMX_ASRC_RATIO_MOD     (V4L2_CID_USER_IMX_BASE +=
 0)
> >
> >  /*
> >   * The base for the atmel isc driver controls.
>
> Regards,
>
>         Hans
