Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7A676CC3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjHBMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjHBMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:02:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7870010C1;
        Wed,  2 Aug 2023 05:02:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2681223aaacso610718a91.0;
        Wed, 02 Aug 2023 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690977761; x=1691582561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ819GwVCo9zR5ZzAiYSpFVr/sz2KTIAVN8PAALo4bo=;
        b=U8PZHqu5zyydy1mgddoFG96L9VW8L25yjDa/lyNEO64ddWZ33KemFAEis0ddxf/nnj
         IzU5ZRpsCImPTyezgGd7zS1yY3i/OnsPjP4evLfghD7NT6SOddqlW88ztwBDlvIHEENC
         pHhiwFrPAayjmeq6e0/mdL0Hr6x3h3ystMpFTt94VESAkM86o0k2zKJAHap0jZBkBhi5
         +jdI0W3//hHvQOspRYgjhvXtgziuuLO/YVbrv7uLzXp4HrWWc2DpHe1XqWbUMgWa7m/U
         +/dyWeT0JVoeKPgsSVi3YQA4Pgw23byHNoJCX9MDb9ozZUwx3ltbr4Sr4V6VUCpBrpbb
         wknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690977761; x=1691582561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ819GwVCo9zR5ZzAiYSpFVr/sz2KTIAVN8PAALo4bo=;
        b=RfSYLMHN5c43mzualzUILBVCW72okHumt+UTLCpHN6eH3Iis4cPKkl3bUnk2XdWt+c
         kMl8/e8Ox9BAxTEisNv465ZWP+N4BVQ21Jwo3UW5VN21vek8QzQU5rbTCuFIfYiNtnCu
         XQ/ICNpHsekT+74W8FugL46ogwSVvZC/eMAHdR1bGwbQviOX+GbhOb6/MEGSnUiJ/oiO
         FD6pHRZpyXhLv5PWN/5jRQWdMGy6dfTKLlGWdgQ3AVjK1SPBVO/aYdWviRBaLGNH3WQX
         SeKo30xRx3eQYE7FiwBMvN6P6RLLhxyi6rVn3C8zsH7gcN8BMabvpNxp7h1GOCtA2G+z
         c+Ug==
X-Gm-Message-State: ABy/qLbMsp0YyUufoOPYEVgEoaaLq2+VWThWC0KguFqNX8+moWZt/NdN
        sHnVcn9hN/iWEZRhJ7Jl7ro9tNjHhubUdAzAvfM=
X-Google-Smtp-Source: APBJJlHuloA0HTsPSoNz24gU6TOurNeBITpKadl1FpEMN3ek0OYWAF6+FL7hx/VdWb7RYwujlTuWhOvWXMHfDiFVaSw=
X-Received: by 2002:a17:90a:c210:b0:267:f8f4:73ab with SMTP id
 e16-20020a17090ac21000b00267f8f473abmr19375725pjt.16.1690977760816; Wed, 02
 Aug 2023 05:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl> <87il9xu1ro.wl-tiwai@suse.de>
In-Reply-To: <87il9xu1ro.wl-tiwai@suse.de>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 2 Aug 2023 20:02:29 +0800
Message-ID: <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
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

On Wed, Aug 2, 2023 at 7:22=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 02 Aug 2023 09:32:37 +0200,
> Hans Verkuil wrote:
> >
> > Hi all,
> >
> > On 25/07/2023 08:12, Shengjiu Wang wrote:
> > > Audio signal processing has the requirement for memory to
> > > memory similar as Video.
> > >
> > > This patch is to add this support in v4l2 framework, defined
> > > new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
> > > V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
> > > for audio case usage.
> > >
> > > The created audio device is named "/dev/audioX".
> > >
> > > And add memory to memory support for two kinds of i.MX ASRC
> > > module
> >
> > Before I spend time on this: are the audio maintainers OK with doing
> > this in V4L2?
> >
> > I do want to have a clear statement on this as it is not something I
> > can decide.
>
> Well, I personally don't mind to have some audio capability in v4l2
> layer.  But, the only uncertain thing for now is whether this is a
> must-have or not.
>

Thanks,  I am also not sure about this.  I am also confused that why
there is no m2m implementation for audio in the kernel.  Audio also
has similar decoder encoder post-processing as video.

>
> IIRC, the implementation in the sound driver side was never done just
> because there was no similar implementation?  If so, and if the
> extension to the v4l2 core layer is needed, shouldn't it be more
> considered for the possible other route?
>

Actually I'd like someone could point me to the other route. I'd like to
try.

The reason why I select to extend v4l2 for such audio usage is that v4l2
looks best for this audio m2m implementation.  v4l2 is designed for m2m
usage.  if we need implement another 'route',  I don't think it can do bett=
er
that v4l2.

I appreciate that someone can share his ideas or doable solutions.
And please don't ignore my request, ignore my patch.

Best regards
Wang shengjiu
