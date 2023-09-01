Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D675778FE86
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349852AbjIANnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349847AbjIANnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:43:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E0F10F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:43:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500cd6261fdso3679565e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693575781; x=1694180581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL5BjwRyGlAOU7e/CVQ6R12cRk3HAxoys/ZzOGvHYPc=;
        b=K+UIyTax9dawm8cboMdYo0+Ko7D1AgtuYBesANNHyIWBQ69YQIjWaZPGbHILWF2sJN
         xicWzBnroIQl46w8BH0eFqcFcAIqoRQ47eiTUcwcNdOHKP4BB4NSPwdA6LXgoKfDf3bP
         zfA/YHTBMFXxcGg9LeiWLORc1Nuqgzjublqbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693575781; x=1694180581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL5BjwRyGlAOU7e/CVQ6R12cRk3HAxoys/ZzOGvHYPc=;
        b=Kelb/lug+zFalQavWrk3fFtxOG1L4AMf2nCJW8p05XFZnehVCbJLLwCEcaiho8trLE
         vDgefZqQQOyO7TI2AZcaK8vrEqePxZPb1Es8FDZjRpb2tQZlU1KwhAm9HH3mrrFClyfU
         4tAyhPHepcsiI9sqYiL1TI13THXwhoRz8SyiFK2vjHtIt83hSvMtQaq6O3WncroYfBwg
         lQrGrst5dpR7IpMjAMayPnpoBBvrPFyOxyvOWcbZV/eH1TkIGvTImz/BuyBdmmJXSlms
         nF5IFeA9gIzRFU7up+f6PfRxSKnKCeNwrSaJTlHxmZV4rMaMD66EW0C+FwSHluWAqo1t
         qkcg==
X-Gm-Message-State: AOJu0YzS5e7VenDo+3XPw++CboIvODLPSrB9xttsfSm3ubr3WXOjeZu/
        Oi2MBy7KdlzfFGq/Eds1ZeIjZMQeS+vQtVEjwQ0Do38v
X-Google-Smtp-Source: AGHT+IF/Qfy5bpSH0D1h/vuXFiAVBTh/zdNSXpkTNujh65F6VnmLS8Fl/3WkH4598kJn/MSR2XYzEA==
X-Received: by 2002:a05:6512:3e2a:b0:500:adc6:141d with SMTP id i42-20020a0565123e2a00b00500adc6141dmr2101889lfv.45.1693575780826;
        Fri, 01 Sep 2023 06:43:00 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id a13-20020a056512020d00b005007824ad2esm650289lfo.30.2023.09.01.06.43.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 06:43:00 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5009687f822so2429e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 06:43:00 -0700 (PDT)
X-Received: by 2002:a19:ac05:0:b0:4ff:d0c0:5d72 with SMTP id
 g5-20020a19ac05000000b004ffd0c05d72mr109392lfc.0.1693575779560; Fri, 01 Sep
 2023 06:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230804210644.1862287-1-dianders@chromium.org>
 <20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid>
 <bphkopaq76imqzut7xrx7aprqybhx3veajdympqhig2wqlix6c@64ck23rc5cv7>
 <CAD=FV=XiVkoCsjin4R74nkcd8vzOq9uPq+o5cRjd=YOoPXuQkg@mail.gmail.com>
 <lhd6ai7d6swlxhisjhikytguor7pptrymo3bmfwej4k7zqrnv4@hp2gvhw7mh3m>
 <CAD=FV=XUhzguFCC=aKzHFMV0bBnZzkHXP_tx+P=PNkVr=8SnTA@mail.gmail.com>
 <mumiep5q7x7qj7k64h3cyodxrgk737iy5rum5keguquwymf2gy@3qruwfrqjgy7>
 <CAD=FV=VEene+nr1us87iA+bomxzQ039r-E+wqvizvFGbxXjDvA@mail.gmail.com>
 <wwzbd7dt5qyimshnd7sbgkf5gxk7tq5dxtrerz76uw5p6s7tzt@cbiezkfeuqqn>
 <CAD=FV=XcUVvg5Om__dD=i9zu7ZtQmvWicms9yN7w0c2nWGhqYg@mail.gmail.com> <p7okuysh442hulqls3ekbaar2bguqv67fum3gsb2cj75kjvdpx@uebwlgvf46sy>
In-Reply-To: <p7okuysh442hulqls3ekbaar2bguqv67fum3gsb2cj75kjvdpx@uebwlgvf46sy>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Sep 2023 06:42:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xr4nZUeHY-FdiedcV=BuP5szNBEHPKjdRnA7c+3MADqg@mail.gmail.com>
Message-ID: <CAD=FV=Xr4nZUeHY-FdiedcV=BuP5szNBEHPKjdRnA7c+3MADqg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] drm/panel_helper: Introduce drm_panel_helper
To:     Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 1, 2023 at 1:15=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> On Thu, Aug 31, 2023 at 11:18:49AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Aug 31, 2023 at 12:38=E2=80=AFAM Maxime Ripard <mripard@kernel.=
org> wrote:
> > >
> > > If so, then I think we can implement everything by doing something li=
ke:
> > >
> > >   - Implement enable and disable refcounting in panels.
> > >     drm_panel_prepare and drm_panel_enable would increase it,
> > >     drm_panel_unprepare and drm_panel_disable would decrease it.
> > >
> > >   - Only actually call the disable and unprepare functions when that
> > >     refcount goes to 0 in the normal case.
> >
> > Just to be clear: by refcounting do you mean switching this to actual
> > refcount?
>
> Yes
>
> > Today this is explicitly _not_ refcounting, right? It is simply
> > treating double-enables as no-ops and double-disables as no-ops. With
> > our current understanding, the only thing we actually need to guard
> > against is double-disable but at the moment we do guard against both.
> > Specifically we believe the cases that are issues:
> >
> > a) At shutdown/remove time we want to disable the panel, but only if
> > it was enabled (we wouldn't want to call disable if the panel was
> > already off because userspace turned it off).
>
> Yeah, and that's doable with refcounting too.

I don't understand the benefit of switching to refcounting, though. We
don't ever expect the "prepare" or "enable" function to be called more
than once and all we're guarding against is a double-unprepare and a
double-enable. Switching this to refcounting would make the reader
think that there was a legitimate case for things to be prepared or
enabled twice. As far as I know, there isn't.

In any case, I don't think there's any need to switch this to
refcounting as part of this effort. Someone could, in theory, do it as
a separate patch series.


> > The above solves the problem with panels wanting to power sequence
> > themselves at remove() time, but not at shutdown() time. Thus we'd
> > still have a dependency on having all drivers use
> > drm_atomic_helper_shutdown() so that work becomes a dependency.
>
> Does it? I think it can be done in parallel?

I don't think it can be in parallel. While it makes sense for panels
to call drm_panel_remove() at remove time, it doesn't make sense for
them to call it at shutdown time. That means that the trick of having
the panel get powered off in drm_panel_remove() won't help for
shutdown. For shutdown, which IMO is the more important case, we need
to wait until all drm drivers call drm_atomic_helper_shutdown()
properly.

-Doug
