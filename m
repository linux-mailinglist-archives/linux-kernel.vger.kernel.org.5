Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8220278D259
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjH3DLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjH3DL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:11:27 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A341CC5;
        Tue, 29 Aug 2023 20:11:23 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7a2785e34b6so1697781241.1;
        Tue, 29 Aug 2023 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693365082; x=1693969882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/zpOgLvIkPFvPcaR4xxmX73FKY11ocg9236FvpZH8M=;
        b=YIyIURlouVC27hhBfnekZ0IsOrc38nX7pu76DhReTI4ctTGBUB/4CZEpVRjFlcMcMx
         xpnfy8yeFRgujLJpvheWlxKFn8QpbOSpgNwvAvylHgW3qrKBBIqOQU0+eUkDoHVtAbMg
         3wyxb9d5PwjI9hQHTZLADFzGa7YDDeUfz/ExiQzH9stJ+Ba4zcDoynjofF4cQ5So82E0
         pPuStdDS30HyWiC1KE4zrU/HLqQxlfoIfEClS1VuRUwbSqUY6ANMP+cwa1yH9Wnbn3P1
         B5pESMmNte1H/mJfu7v61isaFJesZXPLIFpF27XHoNHON7yAmE5/1Ne37yRY1CMW/AvZ
         0dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693365082; x=1693969882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/zpOgLvIkPFvPcaR4xxmX73FKY11ocg9236FvpZH8M=;
        b=g3z0k0DwpAgMjBdLufFxgQz+75gpkQNCU4WDsmaLfT0I5ErUoIm5OpxHfN2H695R+G
         2Y+iFuUjwJ5W32q5UEeXlgkCLfM+oQr5C6zpUEZclW3UhN9n5dFbj472CjRKXIGVpzUA
         kPQGoQu+vCu26qdgTJwRPa/RxlHxANiH8Ep9jt/ekQpdToEQ9UXLmIYIZTOSAz1LxsAC
         FWWxCan/zpr/tQUDRa6C6wrnmDkE1F1Sv6HaABVn3QDyNVFErDRpViezrHHFl8A0Ge2n
         VA7i6Iyx3dr3mzXqUHgKJsGjqBNc8AEQQBFeSpNwm1oQG1bj1JxAabRBgVqo6ky/0DMy
         GCHQ==
X-Gm-Message-State: AOJu0YyVKMlBaNBzBLE0tH4OH+B4kE4HpOvUgKmYOTKVyHq6CROJehC9
        qxc/fqkZMezYRgZhNY4WhIssje2oBX4Lf7uMwxg=
X-Google-Smtp-Source: AGHT+IFcKHvGWkCwrHeUph6QKacvUFGeoVK+QuP9OlsWGA4RbslTUal2tr2ZR3/eQCQuMJw2exL8eO3QY5zcc/iGMW8=
X-Received: by 2002:a05:6102:3ce:b0:44e:dd43:38e1 with SMTP id
 n14-20020a05610203ce00b0044edd4338e1mr1018093vsq.1.1693365081966; Tue, 29 Aug
 2023 20:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl>
 <87il9xu1ro.wl-tiwai@suse.de> <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
 <87il9xoddo.wl-tiwai@suse.de> <CAA+D8AOVEpGxO0YNeS1p+Ym86k6VP-CNQB3JmbeT7mPKg0R99A@mail.gmail.com>
 <844ef9b6-d5e2-46a9-b7a5-7ee86a2e449c@sirena.org.uk> <CAA+D8AOnsx+7t3MrWm42waxtetL07nbKURLsh1hBx39LUDm+Zg@mail.gmail.com>
 <CAA+D8AMriHO60SD2OqQSDMmi7wm=0MkoW6faR5nyve-j2Q5AEQ@mail.gmail.com>
 <CAA+D8AN34-NVrgksRAG014PuHGUssTm0p-KR-HYGe+Pt8Yejxg@mail.gmail.com>
 <87wmxk8jaq.wl-tiwai@suse.de> <ZOe74PO4S6bj/QlV@finisterre.sirena.org.uk>
 <CAA+D8AM_pqbjQaE59n6Qm5gypLb8zPAwOpJR+_ZEG89-q3B8pg@mail.gmail.com>
 <8735076xdn.wl-tiwai@suse.de> <bc12f76e-a2ac-2818-f136-b31f6fa49310@xs4all.nl>
In-Reply-To: <bc12f76e-a2ac-2818-f136-b31f6fa49310@xs4all.nl>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 30 Aug 2023 11:11:10 +0800
Message-ID: <CAA+D8AMdvnBnaNyZ6jPpn9g=zwRa4Ht+mi=aU0o02zw_W-fEag@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
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

On Fri, Aug 25, 2023 at 10:15=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> =
wrote:
>
> On 25/08/2023 15:54, Takashi Iwai wrote:
> > On Fri, 25 Aug 2023 05:46:43 +0200,
> > Shengjiu Wang wrote:
> >>
> >> On Fri, Aug 25, 2023 at 4:21=E2=80=AFAM Mark Brown <broonie@kernel.org=
> wrote:
> >>>
> >>> On Thu, Aug 24, 2023 at 07:03:09PM +0200, Takashi Iwai wrote:
> >>>> Shengjiu Wang wrote:
> >>>
> >>>>> But there are several issues:
> >>>>> 1. Need to create sound cards.  ASRC module support multi instances=
, then
> >>>>> need to create multi sound cards for each instance.
> >>>
> >>>> Hm, why can't it be multiple PCM instances instead?
> >>>
> >>> I'm having a hard time following this one too.
> >>>
> >>>>> 2. The ASRC is an entirety but with DPCM we need to separate input =
port and
> >>>>> output port to playback substream and capture stream. Synchronous b=
etween
> >>>>> playback substream and capture substream is a problem.
> >>>>> How to start them and stop them at the same time.
> >>>
> >>>> This could be done by enforcing the full duplex and linking the both
> >>>> PCM streams, I suppose.
> >>>
> >>>>> So shall we make the decision that we can go to the V4L2 solution?
> >>>
> >>>> Honestly speaking, I don't mind much whether it's implemented in V2L=
4
> >>>> or not -- at least for the kernel part, we can reorganize / refactor
> >>>> things internally.  But, the biggest remaining question to me is
> >>>> whether this user-space interface is the most suitable one.  Is it
> >>>> well defined, usable and maintained for the audio applications?  Or
> >>>> is it meant to be a stop-gap for a specific use case?
> >>>
> >>> I'm having a really hard time summoning much enthusiasm for using v4l
> >>> here, it feels like this is heading down the same bodge route as DPCM
> >>> but directly as ABI so even harder to fix properly.  That said all th=
e
> >>> ALSA APIs are really intended to be used in real time and this sounds
> >>> like a non real time application?  I don't fully understand what the
> >>> actual use case is here.
> >>
> >> Thanks for your reply.
> >>
> >> This asrc memory to memory (memory ->asrc->memory) case is a non
> >> real time use case.
> >>
> >> User fills the input buffer to the asrc module,  after conversion, the=
n asrc
> >> sends back the output buffer to user. So it is not a traditional ALSA =
playback
> >> and capture case. I think it is not good to create sound card for it, =
 it is
> >> not a sound card actually.
> >>
> >> It is a specific use case,  there is no reference in current kernel.
> >> v4l2 memory to memory is the closed implementation,  v4l2 current
> >> support video, image, radio, tuner, touch devices, so it is not
> >> complicated to add support for this specific audio case.
> >>
> >> Maybe you can go through these patches first.  Because we
> >> had implemented the "memory -> asrc ->i2s device-> codec"
> >> use case in ALSA.  Now the "memory->asrc->memory" needs
> >> to reuse the code in asrc driver, so the first 3 patches is for refini=
ng
> >> the code to make it can be shared by the "memory->asrc->memory"
> >> driver.
> >>
> >> The main change is in the v4l2 side, A /dev/vl42-audio will be created=
,
> >> user applications only use the ioctl of v4l2 framework.
> >
> > Ah, now I'm slowly understanding.  So, what you want is to have an
> > interface to perform the batch conversion of a data stream from an
> > input to an output?  And ALSA PCM interface doesn't fit fully for that
> > purpose because the data handling is batched and it's not like a
> > normal PCM streaming?
> >
> > Basically the whole M2M arguments are rather subtle.  Those are
> > implementation details that can be resolved in several different ways
> > in the kernel side.  But the design of the operation is the crucial
> > point.
> >
> > Maybe we can consider implementing a similar feature in ALSA API, too.
> > But it's too far-stretched for now.
> >
> > So, if v4l2 interface provides the requested feature (the batched
> > audio stream conversion), it's OK to ride on it.
>
> The V4L2 M2M interface is simple: you open a video device and then you ca=
n
> pass data to the hardware, it processes it and you get the processed data=
 back.
>
> The hardware just processes the data as fast as it can. Each time you ope=
n
> the video device a new instance is created, and each instance can pass jo=
bs
> to the hardware.
>
> Currently it is used for video scalers, deinterlacers, colorspace convert=
ers and
> codecs, but in the end it is just data in, data out with some job schedul=
ing (fifo)
> towards the hardware. So supporting audio using the same core m2m framewo=
rk wouldn't
> be a big deal. We'd probably make a /dev/v4l-audio device for that.
>
> It doesn't come for free: it is a new API, so besides adding support for =
it, it
> also needs to be documented, we would need compliance tests, and very lik=
ely I
> would want a new virtual driver for this (vim2m.c would be a good templat=
e).
>

Thanks all.

I will try to pass the compliance test.  Should the virtual driver be added=
 now?

Best regards
Wang Shengiu
