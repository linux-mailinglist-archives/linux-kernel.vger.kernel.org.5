Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B851279F11A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjIMS3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:29:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9064A19BF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:29:10 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bfb0a2682fso1658211fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694629747; x=1695234547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukvdFrW0mu6Dhs/IRD1IZUwR2wIREV2auFM3wAgq3Xs=;
        b=NyNqu58hoAJ/YQO/XUQafM5qMD3SRPllciLia1tXfFaIsFnlXLn7WlCavUM+9yKpsD
         2SpSjhUJ380SIQdEOEt4qKQKbkIs5auXbMTKa/d1DM1v80dC2lk6geSSYw4UFfrd4B7r
         F+SnxSWUArPdWv+dj5ZWtaouF0jCsT021EkVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694629747; x=1695234547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukvdFrW0mu6Dhs/IRD1IZUwR2wIREV2auFM3wAgq3Xs=;
        b=Dhycly+2m8mB2OdNaw958k8R+BbgEJSkOopz5T17ihEaS62XD0rVnPUyZWxkdU3IAr
         VdKCbVzXeNK5rh3L3uGZCcdvHqSHJUvGBGYcoPXP8n1NYGbKScoWc8bX+7nufKgRKAv8
         DoEymbKxj/etogn6PVEMp08fyti8HiSCnSZaPl7d5VzA+mfHNaXHDmNFeIWcXzrNDI/R
         aFI2IPmc3sZ0/e9d+ExgXrpXESaFj8Cnu2V9RQwUSIMWgC7WAtkiTD0sLsYYPneyXdg/
         DGk5vVAEVKfw6fUbxjjYNIzawbLiq9y+e5PZl3p3kBUBzV+5aV202weTTKwu7bL+VoqG
         m7eg==
X-Gm-Message-State: AOJu0Yxut8C4DKtkrNbkp+zG6mXzBvDblqBHDCyivqzCGTts+3RXDC27
        Rh25nJ0oSKG5YYiuZ50XGM+eeqCoNlMT5H7iFdFj1zbf
X-Google-Smtp-Source: AGHT+IEhh/VLngOU5++T8JZgzh1psoIGti1dz5btDk496JGkN+Z9uis8MNDVAQ8y8rVjqG5UwmsN5A==
X-Received: by 2002:a2e:a1d0:0:b0:2bc:db5a:9546 with SMTP id c16-20020a2ea1d0000000b002bcdb5a9546mr2689118ljm.7.1694629747448;
        Wed, 13 Sep 2023 11:29:07 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f10-20020a2ea0ca000000b002bcbd292776sm2433173ljm.64.2023.09.13.11.29.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:29:06 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50095f6bdc5so510e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:29:06 -0700 (PDT)
X-Received: by 2002:a19:a40a:0:b0:502:cdb6:f316 with SMTP id
 q10-20020a19a40a000000b00502cdb6f316mr106284lfc.3.1694629746197; Wed, 13 Sep
 2023 11:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <lhd6ai7d6swlxhisjhikytguor7pptrymo3bmfwej4k7zqrnv4@hp2gvhw7mh3m>
 <CAD=FV=XUhzguFCC=aKzHFMV0bBnZzkHXP_tx+P=PNkVr=8SnTA@mail.gmail.com>
 <mumiep5q7x7qj7k64h3cyodxrgk737iy5rum5keguquwymf2gy@3qruwfrqjgy7>
 <CAD=FV=VEene+nr1us87iA+bomxzQ039r-E+wqvizvFGbxXjDvA@mail.gmail.com>
 <wwzbd7dt5qyimshnd7sbgkf5gxk7tq5dxtrerz76uw5p6s7tzt@cbiezkfeuqqn>
 <CAD=FV=XcUVvg5Om__dD=i9zu7ZtQmvWicms9yN7w0c2nWGhqYg@mail.gmail.com>
 <p7okuysh442hulqls3ekbaar2bguqv67fum3gsb2cj75kjvdpx@uebwlgvf46sy>
 <CAD=FV=Xr4nZUeHY-FdiedcV=BuP5szNBEHPKjdRnA7c+3MADqg@mail.gmail.com>
 <nahwibpea2akyg7swbdb3f6xyv7fqs35v5spqbjfzfchxnoqqz@glgg5core75d>
 <CAD=FV=UKSc4mNjWcvLCXT9Tdeok=xRjA0oVoLKVkq+kQ9-4M0A@mail.gmail.com> <xtyiu2i2m2xokxfrgwocdcw4sy2oreszgwczmbnfvp4kbmrdvb@vr5huyfhmmmh>
In-Reply-To: <xtyiu2i2m2xokxfrgwocdcw4sy2oreszgwczmbnfvp4kbmrdvb@vr5huyfhmmmh>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Sep 2023 11:28:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UfxdK9PsungMC0EiPvfPN7O+SVPq+CdCZ44GQyjwfmqQ@mail.gmail.com>
Message-ID: <CAD=FV=UfxdK9PsungMC0EiPvfPN7O+SVPq+CdCZ44GQyjwfmqQ@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 7, 2023 at 7:15=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> > a) Block landing the change to "panel-tdo-tl070wsh30.c" until after
> > all drivers properly call drm_atomic_helper_shutdown().
>
> I don't think we care about all drivers here. Only the driver it's
> enabled with would be a blocker. Like, let's say sun4i hasn't been
> converted but that panel is only used with rockchip anyway, we don't
> really care that sun4i shutdown patch hasn't been merged (yet).

Yeah, I suppose that would work, though it would require a bit of
research. Some other things have popped onto my plate recently, but
for now I'm going to focus on seeing how much of the drivers can get
their shutdown fixed. When that stalls out then we can see if we can
unblock some of the panels by digging into which DRM drivers they're
used with.

Also, as my proposal in the cover letter [1], I'm leaving a breadcrumb
here that I landed the first 3 patches in this series just to get them
out of the way. Those 3 patches didn't depend on the resolution of the
issues discussed here.

[1] https://lore.kernel.org/lkml/CAD=3DFV=3DUFuUsrrZmkL8_RL5WLvkJryDwRSAy_P=
WTa-hX_p0dF+Q@mail.gmail.com/
