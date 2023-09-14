Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28537A068F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjINNzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjINNzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:55:39 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B24DCEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:55:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d8020510203so1017013276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694699734; x=1695304534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lVufp3CfPA+avJJEdJfW22ymBTvw516wdd+VxBZzds=;
        b=MIiS1UXMCeZq9OXUmc5JQ35svwQH6LCpc//dmoLiOkyQ356Hn4fNiznXImhIVS3jTH
         1vS0L0z+phTlsvTAc7JLV/l1J87HZJCBlpkvDPYRohJ+maxfu6qp1dqem1PChEzinrSk
         Ume16Tv7HA284yr6vjURu21GEBOLz8Gp1KeJLvq7gvrKJTuPmnAh62f+cUVa3mBEX18k
         B+BAvBf9pIGG9R3N6kpxIKlzMZ42aCDhrlT86o62NtaHucbYvss24O8gk0XclM1Jljyg
         UcUqrZ2w/Eyv8tTOZgJqAjc9Dy13vETpSrTrK0pIEzbfGKRMfxTNq9HUYftjWZ7U4ciB
         epbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694699734; x=1695304534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lVufp3CfPA+avJJEdJfW22ymBTvw516wdd+VxBZzds=;
        b=cY0UeZcNvpoA2kRbqIpdSJT1ci/FfDEOY/ScJo2zEilg+Z3Eg2bEIat2r2MTCRLRy6
         x7WeR7YSeEg++zu6PNcH5r7EvsBc6gowpojSjN124UPBUhKCO4ht0wuJpsNLVdmaTWTq
         d6u5sijBmdV/EfRoGX6j1eQw5Sk6tnLQKjuQjRZhxB7TbsjbaPSUpYzb3S1JNicddGUg
         PADWIoofJltiQlV4DfD1yJkHNWJ4Q09M6cGNWceTbhPYrt/uIyqHXr38T0mDr6M7hqOF
         Avbsm082Gk6jKdUAsWyZfYXT0/tHP3Nw1IRJlQozDjNsyST9+B39yBhCvzSptMp+jvVI
         VVpg==
X-Gm-Message-State: AOJu0YwQY50145vS9aKKLoPwAgmGCWldUoAYORG8rBAmaF52rag2KexE
        zGE4CgX87KWoMjerEFhc8Un9tK4ZhegkMyzNfUV+ag==
X-Google-Smtp-Source: AGHT+IHmzARiZmGAsVvUQi6lwHQOEn26bk87VErr5TXYZTtaPzwucwTkpNwUE9Hz/2T2a3UepOFa7PTmuZyP0PLHJ8A=
X-Received: by 2002:a25:d683:0:b0:d81:9ba3:43bc with SMTP id
 n125-20020a25d683000000b00d819ba343bcmr1489848ybg.12.1694699734333; Thu, 14
 Sep 2023 06:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230913115001.23183-1-brgl@bgdev.pl> <20230913115001.23183-3-brgl@bgdev.pl>
 <CAHp75Ve8aK4Pfid1JYWH86mKy-Zb-G2QDPrJYmRzPCYOsn1TqQ@mail.gmail.com>
 <CACRpkdYtYDJa6fo6RnizHNzUsyazBQxEaNMznaij8rBF4ie+ew@mail.gmail.com>
 <20230913222338.07d1625b@xps-13> <CAHp75Vd2a06rnGCEiJW0reN00amso0RyvgLT516nZiYLYZ-xcQ@mail.gmail.com>
 <4de724a1630eda74f4f304dc224dc981eb3b0875.camel@crapouillou.net> <CAMRc=MfnPdr66OPSkkjjpZY2VY7wN4WO2uBPbpyExFH0F6e=1Q@mail.gmail.com>
In-Reply-To: <CAMRc=MfnPdr66OPSkkjjpZY2VY7wN4WO2uBPbpyExFH0F6e=1Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 15:55:22 +0200
Message-ID: <CACRpkdah0+HjQ3Co=eHitK8srbWgT7e956+oeH-K+yjYs9=iuw@mail.gmail.com>
Subject: Re: [PATCH 2/5] mtd: rawnand: ingenic: use gpiod_set_active_high()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:30=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> On Thu, Sep 14, 2023 at 10:30=E2=80=AFAM Paul Cercueil <paul@crapouillou.=
net> wrote:

> > > I believe Linus was for moving.

Yes.

> > Which Linus? Because the one who's also the gpio maintainer just wrote
> > above that it was better to keep it in the driver.

What. No. I expressed myself unclearly:

> > Why not moving this quirk to gpiolib-of.c?
>
> That's a better idea here I think, it's clearly a quirk for a
> buggy device tree.

"That's a better idea here I think"

means

"That's a better idea [IN THIS CASE] I think"

i.e. in this case it is a better idea to move it into gpiolib-of.c

> I'm also under the impression that Linus meant moving it to gpiolib-of.c.=
 Let's
>
> Linus: Could you clarify?

Yes.

I invented that thing so I'm a fan of it.

Yours,
Linus Walleij
