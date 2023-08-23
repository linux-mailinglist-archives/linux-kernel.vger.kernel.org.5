Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8D785AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjHWOde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjHWOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:33 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08D2E5F;
        Wed, 23 Aug 2023 07:33:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-564af0ac494so3353462a12.0;
        Wed, 23 Aug 2023 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692801211; x=1693406011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opEDXWUEt7EKF4zm4tFGmxwp6/VFKRX/hggL0pC3hFg=;
        b=JGVtzFIwm9ATiCLFtcnR4ulEC/KTDJ5wcL7bo2i2dkdJ6wrrV2DMvys7roHvDlvnyp
         InIhqHu18As19q4HC+xgrmQZSMwjOCbijG51sharRcrjron3f2rUmHwaZFm2lgF5CMhF
         0uAOLXHN6ZieCobbUXgn+qbfA8ZGEBG4LTt2nznj8fQ9yREsZN2PrESlN6OCsHwwIKve
         agcaTSdUY14ngP8i8kpkpD9ISSdYMu7i2T3z5NVrPlOwcQ8Z+v3jnjF+uJn1TiFDDpYb
         oOscJjumi6/7Q1XoF94KLYpOnzwwas/r23gNNyc1l9/IKFsKUdjtSSTGNdlgR4BXYg9k
         Mehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801211; x=1693406011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opEDXWUEt7EKF4zm4tFGmxwp6/VFKRX/hggL0pC3hFg=;
        b=jDEQy0PWAa1rpYeY4GZNzTSqC0yOfvgDvqfGLegKAfKsGD2YjcXQsChuFN03GRhxp0
         7hvhTz+g/I0cr3OBnvJzO/40Jo7mmV4tzz67CHeQ24MVy+CqxAFlPTiEZwnezqxbrAq+
         /8GcEY7Q7EZEyyRVPaFCznYTmHUbaZHHCyDKo+ScZKGwWkg+Yhdnjf3e12FJ+EtSv5oq
         1yioNOXrYFzSVtAvwSu82y/nqv+8QPms2WzSwZMYS3efOnxNeQpb9jVEvyIn6HUYaamN
         Kh/hzhc/Jg+/W7OpzZ1TICKhs/x2GbOA35zVPWNEfciC+zHdXel5w4llcijqxN5qAcx6
         k2dw==
X-Gm-Message-State: AOJu0YxQcV4z4NrlEzZWGTiOWdGKklU8Govnmj+whz61Ek+eMcuY1at+
        PJEZpZfnVTyy0276cZg55Ak+ue2COFdTBIJhoDM=
X-Google-Smtp-Source: AGHT+IEYVLJxkNQ+r5jQ6CuGxcPrrROsrxTFPOgHY9VnYAB28C8do6b0cl9JPpTo2JeKUnzxrulPL7MFHljcVXMW9mg=
X-Received: by 2002:a17:90b:124f:b0:26c:f6d2:2694 with SMTP id
 gx15-20020a17090b124f00b0026cf6d22694mr9303778pjb.12.1692801211024; Wed, 23
 Aug 2023 07:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl> <87il9xu1ro.wl-tiwai@suse.de>
 <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
 <87il9xoddo.wl-tiwai@suse.de> <CAA+D8AOVEpGxO0YNeS1p+Ym86k6VP-CNQB3JmbeT7mPKg0R99A@mail.gmail.com>
 <844ef9b6-d5e2-46a9-b7a5-7ee86a2e449c@sirena.org.uk> <CAA+D8AOnsx+7t3MrWm42waxtetL07nbKURLsh1hBx39LUDm+Zg@mail.gmail.com>
 <CAA+D8AMriHO60SD2OqQSDMmi7wm=0MkoW6faR5nyve-j2Q5AEQ@mail.gmail.com>
In-Reply-To: <CAA+D8AMriHO60SD2OqQSDMmi7wm=0MkoW6faR5nyve-j2Q5AEQ@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 23 Aug 2023 22:33:19 +0800
Message-ID: <CAA+D8AN34-NVrgksRAG014PuHGUssTm0p-KR-HYGe+Pt8Yejxg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>,
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

On Fri, Aug 11, 2023 at 7:05=E2=80=AFPM Shengjiu Wang <shengjiu.wang@gmail.=
com> wrote:
>
> Hi Mark, Takashi
>
> On Thu, Aug 3, 2023 at 9:11=E2=80=AFPM Shengjiu Wang <shengjiu.wang@gmail=
.com> wrote:
> >
> > On Thu, Aug 3, 2023 at 1:28=E2=80=AFAM Mark Brown <broonie@kernel.org> =
wrote:
> > >
> > > On Wed, Aug 02, 2023 at 10:41:43PM +0800, Shengjiu Wang wrote:
> > >
> > > > Currently the ASRC in ALSA is to connect to another I2S device as
> > > > a sound card.  But we'd like to the ASRC can be used by user space =
directly
> > > > that user space application can get the output after conversion fro=
m ASRC.
> > >
> > > That sort of use case would be handled via DPCM at the minute, though
> > > persuading it to connect two front ends together might be fun (which =
is
> > > the sort of reason why we want to push digital information down into
> > > DAPM and make everything a component).
> >
> > Thanks.
> >
> > ASRC M2M case needs to run as fast as possible, no sync clock control.
> > If use sound card to handle ASRC M2M case,  the user application
> > should be aplay/arecord, then we need to consider xrun issue, buffer
> > may timeout, sync between aplay and arecord,  these should't be
> > considered by pure memory to memory operation.
> >
> > DPCM may achitect all the audio things in components and sound
> > card,  it is good. but for the M2M case, it is complcated. not sure
> > it is doable.
> >
>
> Beside the concern in previous mail,
>
> DPCM needs to separate ASRC to be two substreams (playback and capture).
>
> But the ASRC needs the sample rate & format of input and output first
> then start conversion.
>
> If the playback controls the rate & format of input,  capture substream
> controls the rate & format of output,  as a result
> one substream needs to get information(dma buffer address, size...
> rate, format) from another substream, then start both substreams in the
> last substream. How to synchronize these two substreams is a problem.
> One stream can be released but another stream doesn't know .
>
> So I don't think it is a good idea to use DPCM for pure M2M case.
>
> So can I persuade you to consider the V4L2 solution?
>

Just a summary:

Basic M2M conversion can work with DPCM, I have tried with some
workaround to make it work.

But there are several issues:
1. Need to create sound cards.  ASRC module support multi instances, then
need to create multi sound cards for each instance.

2. The ASRC is an entirety but with DPCM we need to separate input port and
output port to playback substream and capture stream. Synchronous between
playback substream and capture substream is a problem.
How to start them and stop them at the same time.

3. How to handle the xrun issue. pause or resume. which are brought by ALSA=
.

So shall we make the decision that we can go to the V4L2 solution?

Best regards
Wang Shengjiu
