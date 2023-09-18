Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1FC7A4F26
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjIRQe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjIRQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:34:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E6B7283
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:19:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so5724795a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695053989; x=1695658789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbOQzNmAo2PKtDx0msSwuX8Ix4PNWb6iOgapQHbD27Q=;
        b=PP5a9/seC3ll8cLOZiIwevjtwgoymCJGABBZwfCKVcTjFX+yR2uy4l2iCN9BQLjn6u
         N1YFxUsZhCAoUtLyUGMa0TQfSjky39xwUeAPhgOKsT6OKvOWT6l0P8ssQ/QT+3WZmlLf
         Xj0fk9VLlsJNwNrh6xPf5LdiuXpdRUrEeO5SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053989; x=1695658789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbOQzNmAo2PKtDx0msSwuX8Ix4PNWb6iOgapQHbD27Q=;
        b=s+J46fhN78CJx2kNfGhTq2tNvFyaEgXwoXPf2v19cmN4LzlQmqyo+F69/YanY8XGPK
         lLYzBPvJHQP1K1Dp35yAO2O/iUNlT+KucRfFout/cRgsDa6YLV/qdhSFLzhYC40hBaag
         2AgfKhVOzE+ilWficxqFiDT/6PO1R3YOMKcN9onzYUB/nZ173O1ZA/nGVUTEC+70Q9jO
         slm/Jj1OQ9EcRC+VxTDu2hkCBpCqUZ/kZ6snQhpqBz/3ReqeeLRlhf68IXCW6QZvQ4pN
         rAcTJjOZETwzD7p9tB3BV686WBD60LDN7KNnUK2hTOjsgT1USgH9kV13WlYlYll0zJeB
         xE1Q==
X-Gm-Message-State: AOJu0YwH34FQTCBQBZ0oZOGyjrVuJEbIt9oShC+iDHdmwvdmT+oLZ5Xm
        2AdMVfegvNVKlbJ5NoLImBwsbvGjgVuCTP9e2VGIt0X8
X-Google-Smtp-Source: AGHT+IFRG9d/DTbk4j85EtniBYVK7+bgEW8bSXKu4WNy5M6jiErvd8xsj05z4XHd7SYwu2Qkn0UWTQ==
X-Received: by 2002:a17:906:300c:b0:99e:6a0:5f64 with SMTP id 12-20020a170906300c00b0099e06a05f64mr8399701ejz.36.1695053989032;
        Mon, 18 Sep 2023 09:19:49 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b009ad75d318ffsm6832597ejd.17.2023.09.18.09.19.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 09:19:48 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4047c6ec21dso122365e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:19:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3b14:b0:3fe:f32f:c57f with SMTP id
 m20-20020a05600c3b1400b003fef32fc57fmr206022wms.0.1695053987860; Mon, 18 Sep
 2023 09:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org>
In-Reply-To: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Sep 2023 09:19:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2AKQSnWh02Lxbqi47M325JNCaEn1_B0xAW3PKPKKF7Q@mail.gmail.com>
Message-ID: <CAD=FV=W2AKQSnWh02Lxbqi47M325JNCaEn1_B0xAW3PKPKKF7Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix up the boe-tv101wum-nl6 panel driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 3, 2023 at 6:21=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> This is two patches fixing things I would normally complain about
> in reviews, but alas I missed this one, so I go in and fix it up
> myself.
>
> Discovering that a completely unrelated driver has been merged
> into this panel driver I had to bite the bullet and break it out.
> I am pretty suspicious of the other recently added panel as well.
>
> I am surprised that contributors from manufacturers do not seem
> to have datasheets for the display controllers embedded in the
> panels of their products. Can you take a second look?
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v3:
> - Rebase on drm-misc-next
> - Convert the two newly added Starry panels as well.
> - Break out the obvious ILI9882t-based panel into its own driver.
> - Link to v2: https://lore.kernel.org/r/20230615-fix-boe-tv101wum-nl6-v2-=
0-457d7ece4590@linaro.org
>
> Changes in v2:
> - Fix a missed static keyword
> - Link to v1: https://lore.kernel.org/r/20230615-fix-boe-tv101wum-nl6-v1-=
0-8ac378405fb7@linaro.org
>
> ---
> Linus Walleij (4):
>       drm/panel: boe-tv101wum-nl6: Drop macros and open code sequences
>       drm/panel: boe-tv101wum-nl6: Drop surplus prepare tracking
>       drm/panel: ili9882t: Break out as separate driver
>       drm/panel: ili9882t: Break out function for switching page
>
>  drivers/gpu/drm/panel/Kconfig                  |    9 +
>  drivers/gpu/drm/panel/Makefile                 |    1 +
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 3037 ++++++++++--------=
------
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c  |  759 ++++++
>  4 files changed, 2067 insertions(+), 1739 deletions(-)

I'm curious what the latest on this patch series is. Is it abandoned,
or is it still on your list to move forward with it? If it's
abandoned, does that mean we've abandoned the idea of breaking
ili9882t into a separate driver?

From looking at things that have landed downstream in the ChromeOS
kernel trees it looks as if additional fixes are getting blocked from
being posted/landed because of the limbo state that this is in.

-Doug
