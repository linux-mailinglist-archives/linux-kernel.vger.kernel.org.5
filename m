Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A049D786F90
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbjHXMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbjHXMuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:50:12 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3CE19A8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:49:48 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-79aa1f24ba2so2382070241.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692881368; x=1693486168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psaSY7/3D9BKRI0vdUBu6XZ3d1WpR2NDkS9G9gc3LwU=;
        b=vTjfpfaOmLqhAQ7GPDttO+Aj5H4ysvEHIq9QBztejCZqJ0rX6NvH3LHcVai/MLjdr0
         9HS5wvxE/NB8cOIZTxUlfQZ7lCMz2vo4LLucYwVSTVaRAf5CtOXBXd5rHoQ7KW0FLwKG
         dOurVfvdQPBo2CsoR7yCPedldRvGwWFBDe1LvNUXSZI8pnxp8RySbwVljusyXoyf9fYP
         xIReftOeCMGTe154NlmzsAI9aphzX6djpVr/AXVAEq9OXRfah7jEwYHYTGhg2tT2PIUw
         2BIRVROawvlmdmBT9Hg6JiHylh9baCmAy6RjwPZTVrRJa35S/5O3I/L3al20fZJxTDoW
         bN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692881368; x=1693486168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psaSY7/3D9BKRI0vdUBu6XZ3d1WpR2NDkS9G9gc3LwU=;
        b=dIi4hgAKoOFyEcVv/ui6C3a+cOhYrMvYTSNIgdVPiK7+Z3KDbI06oLvvklh1NLIAmY
         qJvN7HNvNchW4tOg6YzbSUMsdg8aJwqwerEcnSi/U6Hg5IRNHGGjrsx6MniF3q0DoqE7
         yGHbknWodSJ9o3x3GWutOafAPe1F6z5xCgXDhUHuYA9IXuTPM5DiRlx5I1W2631GtxTl
         TV9l7hBZLBQKGxY/bFAJssnwMSwmsC+9QuOoadWKuDEybCLxE8dEW20RVlHddcfSJg7G
         tLgQvXZ2Y2QFICZn0a3GR+91BT7+UNeegA/fbld/m8YUsyWqX3xBZDa702wOvNuDBBNr
         h7Yw==
X-Gm-Message-State: AOJu0YyU7rNP4WSapKjQ61xtb17B8Csojdm8I8XBesDN2DND0dLOFsur
        nmMrAUajGpBfWVN8Ruz6Qbrv2/T7XaBlJUY/90+RcjwRFsKK2KzM
X-Google-Smtp-Source: AGHT+IEKxXZy19/KQpqoU4x6QZlrPLtimwwJOfvtQpy9p2CDeshJ2ZzDie+Uogzn6naCFPf/PiEtjrfaq6rT2+xjv/k=
X-Received: by 2002:a67:efcf:0:b0:44e:8e28:2853 with SMTP id
 s15-20020a67efcf000000b0044e8e282853mr2898154vsp.35.1692881368467; Thu, 24
 Aug 2023 05:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230818190108.22031-1-brgl@bgdev.pl> <ZOMxue7lvHFWMCCb@smile.fi.intel.com>
 <CAMRc=Mci-HjN8-Gta7G604grUCzDKmOYDxJ1PJU=x=AmfHohKA@mail.gmail.com>
In-Reply-To: <CAMRc=Mci-HjN8-Gta7G604grUCzDKmOYDxJ1PJU=x=AmfHohKA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 24 Aug 2023 14:49:17 +0200
Message-ID: <CAMRc=McaGfScBOqAY88=ck7_F8p7zCEka=EOXe1VQLHhqB71QQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: tie module references to GPIO devices, not
 requested descs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:00=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Mon, Aug 21, 2023 at 11:43=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Aug 18, 2023 at 09:01:08PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > After a deeper look at commit 3386fb86ecde ("gpiolib: fix reference
> > > leaks when removing GPIO chips still in use") I'm now convinced that
> > > gpiolib gets module reference counting wrong.
> > >
> > > As we only take the reference to the owner module when a descriptor i=
s
> > > requested and put it when it's freed, we can easily trigger a crash b=
y
> > > removing a module which registered a driver bound to a GPIO chip whic=
h
> > > is unused as nothing prevents us from doing so.
> > >
> > > For correct behavior, we should take the reference to the module when
> > > we're creating a GPIO device and only put it when that device is
> > > released as it's at this point that we can safely remove the module's
> > > code from memory.
> >
> > Two cases to consider:
> > 1) legacy gpio_*() APIs, do they suppose to create a GPIO device?
>
> Legacy uses descriptors under the hood so there must be a GPIO device.
>
> > 2) IRQ request without GPIO being requested, is it the case?
>
> I need to double-check and also test this but it seems to me that
> right now if you do this (request an irq from a GPIO irqchip), the
> reference count of the module will not be increased. With this change
> it will have already been at 1 until the GPIO device backing this irq
> will go down. So it should actually fix another use-after-free bug.
> But don't take my word for it, I will test it later when I have the
> time.
>
> There's another issue that will become visible with this patch -
> namely the modules that register devices from their init functions,
> will no longer allow unloading until the device is unbound first. This
> is not wrong wrong as module's init is not the place to register
> devices, platform or otherwise but I'm wondering if it counts as
> breaking someone's setup?
>
> Bart
>

Ok so just checked in theory and verified in practice: with an irq
request orthogonal to the GPIO descriptor, when the GPIO device goes
down, it destroys the irq domain (side note: gpio-sim now finally
disposes of all existing mappings too which would have been the source
of an error here). When the user calls free_irq(), the underlying
irq_do_desc() calls mtree_load() which now returns NULL (mapping is
gone) and nothing happens.

This change doesn't change that behavior - you can still unbind the
GPIO device at any moment and the irq user will be fine.

The problem is: I can no longer reproduce the crash I saw in KASAN
with current next and I'm thinking I may have mistaken one of the bugs
I recently fixed for the culprit here. What I'm seeing now when a
module is unloaded is: driver gets unregistered, device gets unbound
and that's it, all works fine. So this patch and the libgpiod one may
have been pointless noise. :(

Taking the module reference only when there's a requested descriptor
is in line with what most other frameworks do as well.

I need more coffee but maybe at this point I should switch to
panzerschokolade...

Bart
