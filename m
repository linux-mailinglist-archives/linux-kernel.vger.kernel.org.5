Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19D770019
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjHDMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHDMUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:20:08 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3546A6;
        Fri,  4 Aug 2023 05:20:07 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34913c049c4so7330725ab.2;
        Fri, 04 Aug 2023 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691151606; x=1691756406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrwOUvJz44BN5+OtSVByIy8J3CpPSze+6riYsFxfsMQ=;
        b=kbQlGVsJp70sWB8QfAfHW27v/PNM84FAARz14y/rUBtAb4gtteYLF+sn3H3D69jwb4
         iugxxkMuzylxdHfEz68QjqfCS3RjX+xRrF7VgiAJmgHYmZNCgzJLzl5t3NCgn19UakBF
         Uri4Pbjl8XI0HprawdOaGavbl11N4d3J0u4idM0gNqUqtgZGiMFA46XMdGEnNaez+jGv
         omJgYUuHUIyiRKUZrCKuW11ITVCEioymwgiMnOxdY079JEeNQ198TGzr1cuVWSfvmkMY
         R5XueAh45t8KGN/CABOf79zw24ngPZXbrF2YJMsy5YewAvNxQQlydN/iyNlR8y2472/1
         DdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691151606; x=1691756406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrwOUvJz44BN5+OtSVByIy8J3CpPSze+6riYsFxfsMQ=;
        b=J/bUnZrYWKaJ8/vmFairRBgeWktkJ9wYjNUhBHG/7rwjOSR9bUeaM0eMh47uMqe2R6
         QMUQHnG8GIvzTPM06PUSYX+pnnrV/7gxXKgJEjPQxvqz/pmWfKHh9YKoD3bVpQzPVXQV
         /FxcdhUXRnTSzLYBCd7OHZnj0L1yJze/HY61HncxuBCOQbnh2vZEbBsCa4duZSd2nhBH
         5x/1s9DQm2mbgsXJj5DhMbJTc/LYNOTgzQ9aE9FUoTwSWsJ6JULKtn7yuPm6SL3RMT8+
         5HQeDY7oLULN9rjjHnSRFxt7Tpno8JDfvH2YEbgGFfabTTAHXbnPFD2SOv7jWfV1IJGa
         pwEw==
X-Gm-Message-State: AOJu0YwtuxqvaXftFHAjxxe04egZ0wRjeVVyqaxKyVWlpp5LDIgfbCPS
        O7XoeS+HeTfuqait4zZaXdDzJvVPMhiFLGo9C9KUBTWzwd8=
X-Google-Smtp-Source: AGHT+IGXmtFNaA0hRyLJ1GmqVu20WaJ5uUAJgyR8e37qIbW6h/p7fMU2JoYVpgxxO9U9RB7zJ7ER+mQH+cMrPNHxCQQ=
X-Received: by 2002:a05:6e02:184e:b0:345:cdbe:833c with SMTP id
 b14-20020a056e02184e00b00345cdbe833cmr1983943ilv.28.1691151606515; Fri, 04
 Aug 2023 05:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl> <87il9xu1ro.wl-tiwai@suse.de>
 <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com> <d038360b-22a2-3869-cd64-2da827736faa@xs4all.nl>
In-Reply-To: <d038360b-22a2-3869-cd64-2da827736faa@xs4all.nl>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 4 Aug 2023 20:19:49 +0800
Message-ID: <CAA+D8ANSihjxvqkATE9z460sPz4nbcUqhDrR3eiEjPaU6ytrXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 8:28=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> wr=
ote:
>
> On 02/08/2023 14:02, Shengjiu Wang wrote:
> > On Wed, Aug 2, 2023 at 7:22=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wro=
te:
> >>
> >> On Wed, 02 Aug 2023 09:32:37 +0200,
> >> Hans Verkuil wrote:
> >>>
> >>> Hi all,
> >>>
> >>> On 25/07/2023 08:12, Shengjiu Wang wrote:
> >>>> Audio signal processing has the requirement for memory to
> >>>> memory similar as Video.
> >>>>
> >>>> This patch is to add this support in v4l2 framework, defined
> >>>> new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
> >>>> V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
> >>>> for audio case usage.
> >>>>
> >>>> The created audio device is named "/dev/audioX".
> >>>>
> >>>> And add memory to memory support for two kinds of i.MX ASRC
> >>>> module
> >>>
> >>> Before I spend time on this: are the audio maintainers OK with doing
> >>> this in V4L2?
> >>>
> >>> I do want to have a clear statement on this as it is not something I
> >>> can decide.
> >>
> >> Well, I personally don't mind to have some audio capability in v4l2
> >> layer.  But, the only uncertain thing for now is whether this is a
> >> must-have or not.
> >>
> >
> > Thanks,  I am also not sure about this.  I am also confused that why
> > there is no m2m implementation for audio in the kernel.  Audio also
> > has similar decoder encoder post-processing as video.
> >
> >>
> >> IIRC, the implementation in the sound driver side was never done just
> >> because there was no similar implementation?  If so, and if the
> >> extension to the v4l2 core layer is needed, shouldn't it be more
> >> considered for the possible other route?
> >>
> >
> > Actually I'd like someone could point me to the other route. I'd like t=
o
> > try.
> >
> > The reason why I select to extend v4l2 for such audio usage is that v4l=
2
> > looks best for this audio m2m implementation.  v4l2 is designed for m2m
> > usage.  if we need implement another 'route',  I don't think it can do =
better
> > that v4l2.
> >
> > I appreciate that someone can share his ideas or doable solutions.
> > And please don't ignore my request, ignore my patch.
>
> To give a bit more background: if it is decided to use the v4l API for th=
is
> (and I have no objection to this from my side since API/framework-wise it=
 is a
> good fit for this), then there are a number of things that need to be don=
e to
> get this into the media subsystem:
>
> - documentation for the new uAPI
> - add support for this to v4l2-ctl
> - add v4l2-compliance tests for the new device
> - highly desirable: have a virtual driver (similar to vim2m) that support=
s this:
>   it could be as simple as just copy input to output. This helps regressi=
on
>   testing.
> - it might need media controller support as well. TBD.
>
> None of this is particularly complex, but taken all together it is a fair
> amount of work that also needs a lot of review time from our side.
>
> I want to add one more option to the mix: drivers/media/core/v4l2-mem2mem=
.c is
> the main m2m framework, but it relies heavily on the videobuf2 framework =
for
> the capture and output queues.
>
> The core vb2 implementation in drivers/media/common/videobuf2/videobuf2-c=
ore.c
> is independent of V4L2 and can be used by other subsystems (in our case, =
it is
> also used by the DVB API). It is a possibility to create an alsa version =
of
> v4l2-mem2mem.c that uses the core vb2 code with an ALSA uAPI on top.
>
> So in drivers/media/common/videobuf2/ you would have a videobuf2-alsa.c b=
esides
> the already existing videobuf2-v4l2.c and -dvb.c.
>
> Perhaps parts of v4l2-mem2mem.c can be reused as well in that case, but I=
 am
> not sure if it is worth the effort. I suspect copying it to an alsa-mem2m=
em.c
> and adapting it for alsa is easiest if you want to go that way.
>

Thanks.

Does this means that videobuf2-v4l2.c and v4l2-mem2mem.c are dedicate
for video device? if audio want to use v4l2 framework,  need to create
videobuf2-alsa.c and alsa-mem2mem.c, but it may cause a lot of function
duplicate.

Best regards
Wang Shengjiu
