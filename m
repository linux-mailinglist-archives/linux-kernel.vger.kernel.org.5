Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDB076D051
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjHBOmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjHBOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:42:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962AC139;
        Wed,  2 Aug 2023 07:41:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-56486669643so294627a12.1;
        Wed, 02 Aug 2023 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690987315; x=1691592115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIjRCuFSh10TgeuSUQ8r4PrErxnjVCdj/TIwnacZN1M=;
        b=mGgnebdB8kAVU+E2H5mynakxO+gKdMPzTPPnfuycCqzcB/1PHsmMTkSVCSiU7lhUUI
         ISo1GIYfQ9Vuzwy8IAUdLxEsRQEHulbbs8YpB1j9NdhX3ghVb/GEf8HZbQJhgD42L9W6
         J4tUmzOl3xNsWNsHob/Tg4tYwVVPoAH96k8sbSAmz9k1hDHaRLJWk5/a3Z2KIeJhmIRi
         P+wPPxwgb78DmyFbaOR+m8bYtICXyyJ/vHR5WzzWclsB1Fkx0e3wIXtATQwz9fbBhNY/
         pxq8WWRyFUd899J75q5wG/Hbanlc6WKpRWN+aVkgpq3ePXpaLkvsg0rYB/HkBA6FX4fW
         CiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987315; x=1691592115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIjRCuFSh10TgeuSUQ8r4PrErxnjVCdj/TIwnacZN1M=;
        b=blxLzVdtVSxL6bLN525vSYc6QEMTG4M+7U1lwGthL4t7ocDyYUULxhjVG5KGE/lh7X
         cxxbbSU+vhQkzN48BdMtVbBMC6an3IRp4As9Hk7jw36mWo3CpDLpwODx0mCN8TPh0id3
         qLCd5KJtrhS7KOSV0Wn3fWglEGAVgCmaRo2DpArpRxIdRAiyZPBCCLIzuqvApvWrrM+V
         TU6StA5Ng3yrvbEr2GPt3AlotY86BSVP4Qqlc0383v0x2qqk6NBbFEboMPz+uKWZ1KVN
         Hqe8fdwXEq1zsqZCubpLpfUiqJ2CfoyB2CO8/hw+5aMO+NSdCMold6u8ZSzAYPbIR17R
         A6ig==
X-Gm-Message-State: ABy/qLY1SCRdEgwpHR9YwMCgFeLuJEgQ7GjJknSsD1+SuSTzhKfoTQYJ
        fYlhXFkVgvOKkSu1ItcAztNzSuFceOhQOlkc9Qg=
X-Google-Smtp-Source: APBJJlFz2P+Hhh/+gr4lvaHd8cYOPbmuxQXrmDFhh17NWbkyLYYcpfmWzMEWjHFqCWqAW1bGM/Mh7zG6bY8iwCpx2CU=
X-Received: by 2002:a17:90a:fa05:b0:268:21c3:4fd8 with SMTP id
 cm5-20020a17090afa0500b0026821c34fd8mr19933605pjb.20.1690987314959; Wed, 02
 Aug 2023 07:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl> <87il9xu1ro.wl-tiwai@suse.de>
 <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com> <87il9xoddo.wl-tiwai@suse.de>
In-Reply-To: <87il9xoddo.wl-tiwai@suse.de>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 2 Aug 2023 22:41:43 +0800
Message-ID: <CAA+D8AOVEpGxO0YNeS1p+Ym86k6VP-CNQB3JmbeT7mPKg0R99A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 8:08=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 02 Aug 2023 14:02:29 +0200,
> Shengjiu Wang wrote:
> >
> > On Wed, Aug 2, 2023 at 7:22=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wro=
te:
> > >
> > > On Wed, 02 Aug 2023 09:32:37 +0200,
> > > Hans Verkuil wrote:
> > > >
> > > > Hi all,
> > > >
> > > > On 25/07/2023 08:12, Shengjiu Wang wrote:
> > > > > Audio signal processing has the requirement for memory to
> > > > > memory similar as Video.
> > > > >
> > > > > This patch is to add this support in v4l2 framework, defined
> > > > > new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
> > > > > V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
> > > > > for audio case usage.
> > > > >
> > > > > The created audio device is named "/dev/audioX".
> > > > >
> > > > > And add memory to memory support for two kinds of i.MX ASRC
> > > > > module
> > > >
> > > > Before I spend time on this: are the audio maintainers OK with doin=
g
> > > > this in V4L2?
> > > >
> > > > I do want to have a clear statement on this as it is not something =
I
> > > > can decide.
> > >
> > > Well, I personally don't mind to have some audio capability in v4l2
> > > layer.  But, the only uncertain thing for now is whether this is a
> > > must-have or not.
> > >
> >
> > Thanks,  I am also not sure about this.  I am also confused that why
> > there is no m2m implementation for audio in the kernel.  Audio also
> > has similar decoder encoder post-processing as video.
> >
> > >
> > > IIRC, the implementation in the sound driver side was never done just
> > > because there was no similar implementation?  If so, and if the
> > > extension to the v4l2 core layer is needed, shouldn't it be more
> > > considered for the possible other route?
> > >
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
> Can you explain a bit more details of your demand?
> At least, a "big picture" showing how your hardware is implemented and
> what is exactly necessary would be helpful for understanding the
> problem.
>

We have the hardware IP: ASRC,  asynchronous sample rate converter.

Currently the ASRC in ALSA is to connect to another I2S device as
a sound card.  But we'd like to the ASRC can be used by user space directly
that user space application can get the output after conversion from ASRC.

The ASRC can be integrated into a multimedia framework (gstreamer) as a plu=
gin.

best regards
wang shengjiu
