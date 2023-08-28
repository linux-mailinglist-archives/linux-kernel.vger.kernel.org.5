Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852B478B514
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjH1QGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjH1QGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:06:48 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB6123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:06:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b962c226ceso51093631fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693238802; x=1693843602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJIQq3Q5XZugkIRvBGCko5sB8qNI0t2ngmpOadONnhI=;
        b=I6hXe9gXAg/Ab4pKStl06By0B3kwpNnVMg+7P/uW484iu3rZAaYLiwXh3hstkJhJHb
         D3ZBtFXuy3PZiHgXSltCmK8JIdz/x8hDLyVg0VORNuaeodHbjzZfYwLR4wVvTSxDlwQ7
         iAMDy2u65KNa7IyIm1ssvJ6V0AFwYvcXDjHeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693238802; x=1693843602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJIQq3Q5XZugkIRvBGCko5sB8qNI0t2ngmpOadONnhI=;
        b=CVMYMfz88ZaU4Kr4pR/EK/PFibDZdONpmGYwmDJtaKbZGoEkySnBEAbd4QzYVXXAIh
         6+rQ3t7jyZW0+uxz4NNvLWA5CjklqdIumcQrFWt34C3Pcl5TTml312YlMzuUHvVa9+mx
         wGZnCLfNeMSBhcTNzcUuj95UJTdrmp8Lto21O3Gy732+e/YXRU4bVGvxNW+9R1nSQHlj
         b26pyxeqOTJCKWmOCDVGDJYIsfohWgcn+2rzelwNSz1C2f40WQ7ShBurqUg9GVLQVq9q
         8NkRG2astYmJBJnHze+u2oPxnezOVTl72jiz0juDt+uhwLg8ILOmb8zjVpRZz/ND4qqE
         SHpA==
X-Gm-Message-State: AOJu0YzDMVGm6ckz0jREOFnL1YWR/Dfr83f3F/y6Hzg4kgxnLwP27204
        Y83fRlk6LiOoZ42hYIBB0jRoxwUPOPhumOQbcLkQoTTk
X-Google-Smtp-Source: AGHT+IE/SrSTlMcm/FZyR9u1gJrdoFXFxcIQzL4gaB6X7h5A4LPoNeFsrsdUM8N7vCQxSaID+HsTDg==
X-Received: by 2002:a2e:9097:0:b0:2bc:f252:6cc4 with SMTP id l23-20020a2e9097000000b002bcf2526cc4mr6174682ljg.10.1693238802590;
        Mon, 28 Aug 2023 09:06:42 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709067e1300b00982d0563b11sm4772569ejr.197.2023.08.28.09.06.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 09:06:42 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so131885e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:06:41 -0700 (PDT)
X-Received: by 2002:a05:600c:600d:b0:3f6:f4b:d4a6 with SMTP id
 az13-20020a05600c600d00b003f60f4bd4a6mr316974wmb.7.1693238801578; Mon, 28 Aug
 2023 09:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230804210644.1862287-1-dianders@chromium.org>
 <20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid>
 <bphkopaq76imqzut7xrx7aprqybhx3veajdympqhig2wqlix6c@64ck23rc5cv7>
 <CAD=FV=XiVkoCsjin4R74nkcd8vzOq9uPq+o5cRjd=YOoPXuQkg@mail.gmail.com> <lhd6ai7d6swlxhisjhikytguor7pptrymo3bmfwej4k7zqrnv4@hp2gvhw7mh3m>
In-Reply-To: <lhd6ai7d6swlxhisjhikytguor7pptrymo3bmfwej4k7zqrnv4@hp2gvhw7mh3m>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Aug 2023 09:06:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUhzguFCC=aKzHFMV0bBnZzkHXP_tx+P=PNkVr=8SnTA@mail.gmail.com>
Message-ID: <CAD=FV=XUhzguFCC=aKzHFMV0bBnZzkHXP_tx+P=PNkVr=8SnTA@mail.gmail.com>
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

On Mon, Aug 28, 2023 at 12:45=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
>
> > For removal I'd be fine with just dropping the call and saying it's
> > the responsibility of the driver to call drm_atomic_helper_shutdown(),
> > as you suggest. I'd tend to believe that removal of DRM drivers is not
> > used anywhere in "production" code (or at least not common) and I
> > think it's super hard to get it right, to unregister and unbind all
> > the DRM components in the right order.
>
> It depends on the kind of devices. USB devices are very likely to be
> removed, platform devices very unlikely, and PCIe cards somewhere in the
> middle :)

Good point. Obviously those cases need to work. I guess I've just
spent lots of time on the SoC case where all the pieces coming
together are very intertwined with each other...


> > Shutdown is called any time you reboot a device. That means that if a
> > DRM driver is _not_ calling drm_atomic_helper_shutdown() on the
> > panel's behalf at shutdown time then the panel won't be powered off
> > properly. This feels to me like something that might actually matter.
>
> It does matter. What I disagree on is that you suggest working around
> that brokenness in the core framework. What I'm saying is driver is
> broken, we should keep the core framework sane and fix it in the driver.
>
> It should be fairly easy with a coccinelle script to figure out which
> panels are affected, and to add that call in remove.

I think I'm confused here. I've already figured out which panels are
affected in my patch series, right? It's the set of panels that today
try to power the panel off in their shutdown call, right? ...but I
think we can't add the call you're suggesting,
drm_atomic_helper_shutdown(), to the _panel_'s shutdown callback, can
we? We need to add it to the shutdown callback of the top-level DRM
driver, right?


> > Panels tend to be one of those things that really care about their
> > power sequencing and can even get damaged (or not turn on properly
> > next time) if sequencing is not done properly, so just removing this
> > code and putting the blame on the DRM driver seems scary to me.
>
> Sure, it's bad. But there's no difference compared to the approach you
> suggest in that patch: you created a helper, yes, but every driver will
> still have to call that helper and if they don't, the panel will still
> be called and it's a bug. And we would have to convert everything to
> that new helper.
>
> It's fundamentally the same discussion than what you were opposed to
> above.

I think the key difference here is that, if I understand correctly,
drm_atomic_helper_shutdown() needs to be added to the top-level DRM
driver, not to the panel itself. I guess I'm worried that I'll either
miss a case or that simply adding a call to
drm_atomic_helper_shutdown() in the top-level DRM driver will break
something. Well, I suppose I can try it and see what happens...


I'll try to cook up a v2 and we'll see what people say. I might keep
the RFC tag for v2 just because I expect it to still be touching a lot
of stuff.

-Doug
