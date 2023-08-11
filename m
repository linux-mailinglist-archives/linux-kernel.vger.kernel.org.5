Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD528778D15
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjHKLHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbjHKLHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:07:02 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD163C06;
        Fri, 11 Aug 2023 04:05:55 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bfafe8a425so1649016fac.3;
        Fri, 11 Aug 2023 04:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691751955; x=1692356755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjQ64ZZGN8T91hWpEGceC0siZ3jwdNTZpdGZAQGJRUY=;
        b=e84JtWSPLLE8xUm4/YbusYDp8Qw2ketFjAVF3ddE+8kfIdnZ5s8aThtpsF6Q7BvgNM
         U+wNgXBuNao0FbknM/n6HfcA14pvgn3TY1CxpY1Qj0fN1ZYftiy12G6ihc+DvPFAPFvd
         cucy2tx+xucCIgmikT9YOZvJcl5Wt+8NMfQpgUVJPFxd3/rAtAPzDQ6hgCxjRdOTSL9X
         asGQFpsB0XiP/E//fDfpno6jFiuZGwGBNi92GsP1BVY4njp5RlUVPzfaDtMC3uJv0GFn
         RNnXKhS3I3sCiy20tXOHzJFbTb6NLPO5SKfunIrmfz3OpIC+7e3AFcFGtP8S40j5S1iV
         mV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691751955; x=1692356755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjQ64ZZGN8T91hWpEGceC0siZ3jwdNTZpdGZAQGJRUY=;
        b=QCLw0bL/hu4FjenT8r6f9AViYUvQuTXZiwMI42cUkzBI8rwGRWZbW7COdbG782sCcm
         W1YivjgFWfQ5ol5bgjdaA/B5FPTyjSJz0zi895ysqsslyN1m+vD36cJ95cqsU7mswqHW
         ExlmkmSNp635+Bh/FUdRwiJTdeNXfFBhDWjtkCCWc5/tdcSm6PH90XpsKzAqfRdzzfMb
         nvK+ExZsIytWtmwaq7yYsrxcK3EqvEpL88jRKwVUAWdv7+NTHBuUro1nKZEALsPeLeNi
         6V6qr1XO3yw54II41dEhWle6t0baO9ZBrvjao9qrwlg+Dr6Pc10qgszxHnCWp4U4PuL6
         h4Dw==
X-Gm-Message-State: AOJu0YzRzwEk11vTSSyKGoyxdC70iV5mn8FKMoa/D1kn1ih8ajuWpBWm
        3akJPFlUrqjXfFz1KeaTxMM6WvcjX/G2ViSnY4I=
X-Google-Smtp-Source: AGHT+IFpk41pz9ENDJNApolHi9hRFlr6B19DWPyJgpvXFEB+phtk7CHmvJj6RBn+wXmTBbnSP9W9WmfQXqmH5n8Tpdw=
X-Received: by 2002:a05:6870:c58e:b0:1b7:670e:ad7a with SMTP id
 ba14-20020a056870c58e00b001b7670ead7amr1728203oab.43.1691751955035; Fri, 11
 Aug 2023 04:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl> <87il9xu1ro.wl-tiwai@suse.de>
 <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
 <87il9xoddo.wl-tiwai@suse.de> <CAA+D8AOVEpGxO0YNeS1p+Ym86k6VP-CNQB3JmbeT7mPKg0R99A@mail.gmail.com>
 <844ef9b6-d5e2-46a9-b7a5-7ee86a2e449c@sirena.org.uk> <CAA+D8AOnsx+7t3MrWm42waxtetL07nbKURLsh1hBx39LUDm+Zg@mail.gmail.com>
In-Reply-To: <CAA+D8AOnsx+7t3MrWm42waxtetL07nbKURLsh1hBx39LUDm+Zg@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 11 Aug 2023 19:05:43 +0800
Message-ID: <CAA+D8AMriHO60SD2OqQSDMmi7wm=0MkoW6faR5nyve-j2Q5AEQ@mail.gmail.com>
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

Hi Mark, Takashi

On Thu, Aug 3, 2023 at 9:11=E2=80=AFPM Shengjiu Wang <shengjiu.wang@gmail.c=
om> wrote:
>
> On Thu, Aug 3, 2023 at 1:28=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
> >
> > On Wed, Aug 02, 2023 at 10:41:43PM +0800, Shengjiu Wang wrote:
> >
> > > Currently the ASRC in ALSA is to connect to another I2S device as
> > > a sound card.  But we'd like to the ASRC can be used by user space di=
rectly
> > > that user space application can get the output after conversion from =
ASRC.
> >
> > That sort of use case would be handled via DPCM at the minute, though
> > persuading it to connect two front ends together might be fun (which is
> > the sort of reason why we want to push digital information down into
> > DAPM and make everything a component).
>
> Thanks.
>
> ASRC M2M case needs to run as fast as possible, no sync clock control.
> If use sound card to handle ASRC M2M case,  the user application
> should be aplay/arecord, then we need to consider xrun issue, buffer
> may timeout, sync between aplay and arecord,  these should't be
> considered by pure memory to memory operation.
>
> DPCM may achitect all the audio things in components and sound
> card,  it is good. but for the M2M case, it is complcated. not sure
> it is doable.
>

Beside the concern in previous mail,

DPCM needs to separate ASRC to be two substreams (playback and capture).

But the ASRC needs the sample rate & format of input and output first
then start conversion.

If the playback controls the rate & format of input,  capture substream
controls the rate & format of output,  as a result
one substream needs to get information(dma buffer address, size...
rate, format) from another substream, then start both substreams in the
last substream. How to synchronize these two substreams is a problem.
One stream can be released but another stream doesn't know .

So I don't think it is a good idea to use DPCM for pure M2M case.

So can I persuade you to consider the V4L2 solution?

Best regards
Wang Shengjiu
