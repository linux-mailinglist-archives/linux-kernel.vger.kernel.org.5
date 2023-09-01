Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9313790445
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbjIAXqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjIAXqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:46:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07175171A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:46:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bcc0adab4so311835366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611894; x=1694216694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgXrSJYfo1dkdyg09y4XFoQUBk4FG4+e88odjuhYWLg=;
        b=LFMMKphgYDeov8XRSXOdbQgPtFn+5oVjG2ewa0Mbd9LdjmelOVHZcLwxA3+7vOmCzg
         shzfcjj5HVLQzzn26eDSXgqwgkZ5oNpUGLzN3yPpLmWV5XliU5g7hl2B4jIu0J/DFWnK
         QuwopfDiOEhd5Oc4sifQZsvoVF0fI8zRCi1JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611894; x=1694216694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgXrSJYfo1dkdyg09y4XFoQUBk4FG4+e88odjuhYWLg=;
        b=OBvOCchD3xnEUS+1evsCBeJZjhzxZ9IQsrBpz7R8R/2GHfrj2QUYfx5IoIumVvgo0D
         1aygLaMJY1w9ND5Q8MD8a0GJxNMJYBsplj5k/dnrFU1/KLjs9iPdiO6x6aU9YIPqvni0
         zTVAemTEKSzlSqBZm+laOym/p6RUYoxY8WtQPjaM6gRGlrYiI00+jNn+ajUBbHtUl2dD
         WKR+bBwuq2bycD/UcnnR51OQ1KRj3YSA3gMtZ4hd55BTDJOil5jCDx9OhtgLu3/E4quw
         9RQxY/b2j5fiZSXh377/klFyOA3su2tkuSnWegjw4V8I0F9vyycPo7qbDm9bCJ0BFV66
         dlBQ==
X-Gm-Message-State: AOJu0YzXMrIeo2LkPTwf6YtrtXIgVMyzdl4+L0bvZrkt9UVjp9mqlnYl
        q0XqaEqgBcs8X4evFm1LJl3YeG66i7I6E/Bji9CN04BM
X-Google-Smtp-Source: AGHT+IE2eyvhH68gnpERwOBuX1tRXhI3s5NE76g1oIQKTYPGFR+ZpXSyYTaEYaioRPdNGYUibog6TQ==
X-Received: by 2002:a17:907:d690:b0:9a5:b630:a92a with SMTP id wf16-20020a170907d69000b009a5b630a92amr2944218ejc.8.1693611893766;
        Fri, 01 Sep 2023 16:44:53 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064a8a00b0099b8234a9fesm2587148eju.1.2023.09.01.16.44.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 16:44:53 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso12885e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:44:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1f16:b0:3fe:cd3a:ef92 with SMTP id
 bd22-20020a05600c1f1600b003fecd3aef92mr67452wmb.6.1693611892718; Fri, 01 Sep
 2023 16:44:52 -0700 (PDT)
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
 <CAD=FV=XcUVvg5Om__dD=i9zu7ZtQmvWicms9yN7w0c2nWGhqYg@mail.gmail.com>
 <p7okuysh442hulqls3ekbaar2bguqv67fum3gsb2cj75kjvdpx@uebwlgvf46sy> <CAD=FV=Xr4nZUeHY-FdiedcV=BuP5szNBEHPKjdRnA7c+3MADqg@mail.gmail.com>
In-Reply-To: <CAD=FV=Xr4nZUeHY-FdiedcV=BuP5szNBEHPKjdRnA7c+3MADqg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Sep 2023 16:44:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vidq0hwk=wzMU2W7GrobC57kT1gk+cfh0VFCLQucYQhg@mail.gmail.com>
Message-ID: <CAD=FV=Vidq0hwk=wzMU2W7GrobC57kT1gk+cfh0VFCLQucYQhg@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 1, 2023 at 6:42=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> > > The above solves the problem with panels wanting to power sequence
> > > themselves at remove() time, but not at shutdown() time. Thus we'd
> > > still have a dependency on having all drivers use
> > > drm_atomic_helper_shutdown() so that work becomes a dependency.
> >
> > Does it? I think it can be done in parallel?
>
> I don't think it can be in parallel. While it makes sense for panels
> to call drm_panel_remove() at remove time, it doesn't make sense for
> them to call it at shutdown time. That means that the trick of having
> the panel get powered off in drm_panel_remove() won't help for
> shutdown. For shutdown, which IMO is the more important case, we need
> to wait until all drm drivers call drm_atomic_helper_shutdown()
> properly.

FWIW, it was a bit of a slog, but I've managed to put together a RFT
series. Good thing it's Friday and beer-o-clock. Please enjoy
reviewing.

Ugh. It's now two series because there are too many recipients. Email
is fun. OK, these should be at:

* https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
- patches targeting drm-misc

* https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
- patches targeting something that's not drm-misc

-Doug
