Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2D2803526
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbjLDNjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjLDNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:38:45 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D15D4C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:38:33 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7c51d5e6184so1292523241.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701697112; x=1702301912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1UpuRerWKubmFOnOhiP1vLCixCHUqesCX/FHO4e/TE=;
        b=CGA7vVyB5ChqTVVkV1hwVV8KS90GhdrGSkiq5tzDVvr4E5GcXep42sHeQIgOfODVFb
         L/6hmiWHuadgMllTs34OvUwlY5HE3TlENDmYrLiOlDszKkvw99K/7jyaj8adquzBEJM0
         XHRYvO6DSE+C0IG6ZOjsNBftedug/ToQggmA6KwlyIJQrBcEjaeNEOA4OkpSsfSN/rYY
         BtxURbqvW1iURtRv428jq8YT7jduDD0kEWy2+iFk6rx25wVvr5ij8ojh8zb7S0ZVHr8w
         9woJZytrFAbwqbrf+eoO+8Z0pdytfFoXBYPBRQ3Gd95wxAcd/HyH3uUcx7S9p37AyMKl
         A8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701697112; x=1702301912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1UpuRerWKubmFOnOhiP1vLCixCHUqesCX/FHO4e/TE=;
        b=Az8k5v9tno7CCAHnrLWAht1zPqRHjSS4MtBrHuxcQikAugPs/iRoGRA/IqN9KRF0Hs
         D48qyDG69jsjvXoGxQq9jZ9hqOUV22zREUCjYnuY3cKAu51Gtwl42QtyEz5phjJwmpNv
         H9JGSVIHn0gsE40vVvkrG/gAGJNd8v0sLlBw4DPMQ5MwCtWlQKDrRbGnFr9/KuwKGQXU
         0FH1TFTak5OyQtsraHwBBpmpEIALF7tzhSjK7lHCAfBlJ4P65joL9Chzs+J9e2xdB6wR
         QAS84qbuj22dU0NjSlVNtQzJgSw7yRlOfQ4JY+gcF1WP3a9L5XbcU3qA0THZyOCF1/ag
         ntrA==
X-Gm-Message-State: AOJu0YxFqQkry4DiOHQ4Y52qQmAoPO9pJQQlFHFLOC/45PzhFi1cXN9N
        fXe3K00FtQoP8dhRKooKfUTqeEoUXWGGuwsSyHOcoQ==
X-Google-Smtp-Source: AGHT+IGM8wAGr7fLScqJtGZwmQGvYP9FpBLRz6Bjw+XTscV7du8vlhzmCYEnr9jCZ90nMnozFKOvOn0S4F1U+cCrhsk=
X-Received: by 2002:ac5:cc48:0:b0:4b2:c554:e9b8 with SMTP id
 l8-20020ac5cc48000000b004b2c554e9b8mr2292269vkm.26.1701697112157; Mon, 04 Dec
 2023 05:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20231204093509.19225-1-brgl@bgdev.pl> <20231204093509.19225-3-brgl@bgdev.pl>
 <ZW3RPxjsNPacT9Si@smile.fi.intel.com>
In-Reply-To: <ZW3RPxjsNPacT9Si@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Dec 2023 14:38:21 +0100
Message-ID: <CAMRc=Mf1MOFfN1XwTBt2=9rzB6kZ8+cW9cBR=7TTkMqHrLDh_w@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] gpio: wm831x: use gpiochip_dup_line_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 2:16=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 04, 2023 at 10:35:01AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use the new gpiochip_dup_line_label() helper to safely retrieve the
> > descriptor label.
>
> ...
>
> >       for (i =3D 0; i < chip->ngpio; i++) {
> >               int gpio =3D i + chip->base;
> >               int reg;
> > -             const char *label, *pull, *powerdomain;
> > +             const char *pull, *powerdomain;
>
> Make it reversed xmas tree?
>

Bikeshedding again. :)

But I plan on making all local variables across the core GPIOLIB code
consistent (no tabs and reverse xmas tree) closer to the end of the
release cycle.

Bart
