Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD8B7B790F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbjJDHw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjJDHw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:52:26 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BAAA7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:52:22 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4525dd7f9d0so789271137.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 00:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696405942; x=1697010742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03Hi5B9i19pINHNT2cXNqOx1X0FcGumhn4pSIk+xNak=;
        b=eQrRQ3RavQstAxnnc9NV5ckZCXwC6lxv+zSCtib6DEZTwgDOTh7osGGgAlGLbPA2tj
         prZ7IdsKZj7OarD9h4KjsatO34L/hj3cvneJZvXYqhyk/BNqu5/M/sIUb4acFIxwbtsk
         D3oegfOFluXnnpW6Lpo69IvLvZ2aMaSVqwYcztQthkNkPelkz6mNaTd/YbpP1eTxHFCR
         +/WoeQXf2rK6rqVqlaV64CAn6M0UN+uHPh5PW9e5IWcVR7/E1aEGp7ZWhxYJPwJ5Ejxo
         IqVH4XXb+ctd+fDNOdevUXY1p0DDk9p4CtQqMV3jxNc7ZCgjl24CBrd1zb7jyLEXXCqN
         g+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696405942; x=1697010742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03Hi5B9i19pINHNT2cXNqOx1X0FcGumhn4pSIk+xNak=;
        b=jum3knS2iN7AzjnrXvwhwHz2wLd3Pk8XX3heujrmU2krnL8phtyVkMyCf2gJnhji3y
         OzQiqgWXE7Nq7dVdJlnIRGqT+KgrSii75nzzQydAKUx8hl5NirjnUTjgJ162/Yzlt+l1
         9qPrasOwmu9FwNubAbea5PRZMpRKJMVETKzVHhF2avUbZG3p/mohimGLJu3aogOGoKmg
         c7O5HK44FF3suUkf1xsNmKNm6WebBo6QcJdd6oTMed0Gw4Vn1yM4NLbNHEkx8nmSubcn
         9QrLEJr1kHi8s1XaEurHqFHgXWL7pdWR7MhjL8hDSUFl9d3E2Gjuv4RwSkOF6qwL+129
         /6hA==
X-Gm-Message-State: AOJu0YyQNQ99M5uj29jEuS3JtVB/SVhhEm3bRXjGheFepQ3rARDiCKM7
        9ZpcVD1MnM8p4XKhpw3LGmLjbM0hYi61x02y4is0oQ==
X-Google-Smtp-Source: AGHT+IF+SfMq2+4rcyVk787hqbTqQACwxwr3NQ9qdUSKwNySvRUOq2uaDQpJEy+6vNeovqQYrMhRrfA7PXOUP9+G5NU=
X-Received: by 2002:a67:fe88:0:b0:452:513a:ac1d with SMTP id
 b8-20020a67fe88000000b00452513aac1dmr1202409vsr.15.1696405941802; Wed, 04 Oct
 2023 00:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-5-brgl@bgdev.pl>
 <ZRwtEG1DamMLZC/3@sol> <CAHp75VdSDart2b+_d6_9E204JYa2zyFKdh_Pey6Wb4MZ-Z-L0Q@mail.gmail.com>
 <ZRwyG80u6nIf7PGU@sol> <CAMRc=McbWU+bPph7f6treqNmqJvakj8nLzNEJPjgb8tbG_pWxQ@mail.gmail.com>
 <ZRznEe2tKmVcVlwr@sol>
In-Reply-To: <ZRznEe2tKmVcVlwr@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 4 Oct 2023 09:52:10 +0200
Message-ID: <CAMRc=McscCdtOHggCv9PXVBMOSaG5eHZL-vOhm4AxDN7NLsMHg@mail.gmail.com>
Subject: Re: [PATCH 04/36] gpio: cdev: use pinctrl_gpio_can_use_line_new()
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 6:16=E2=80=AFAM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> On Tue, Oct 03, 2023 at 08:07:05PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Oct 3, 2023 at 5:24=E2=80=AFPM Kent Gibson <warthog618@gmail.co=
m> wrote:
> > >
> > > On Tue, Oct 03, 2023 at 06:17:27PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 3, 2023 at 6:02=E2=80=AFPM Kent Gibson <warthog618@gmai=
l.com> wrote:
> > > > > On Tue, Oct 03, 2023 at 04:50:42PM +0200, Bartosz Golaszewski wro=
te:
> > > >
> > > > ...
> > > >
> > > > > I agree with the change in principle, just not comfortable with t=
he naming.
> > > >
> > > > +1 here. I proposed some names, have you seen my comment(s)?
> > > >
> > >
> > > I have now - any of those work for me.
> > > Whichever is consistent with what we are using for gpiochip functions=
 in
> > > gpiolib would make most sense to me.
> > >
> >
> > Does it really matter? It's not here to stay, it's temporary and
> > exists only until the whole series is applied - which given that it's
> > limited to gpio and pinctrl, shouldn't take more than one release
> > cycle.
> >
> > There are plenty of examples of this naming convention for temporary
> > symbols - there's even an ongoing effort to replace all .remove()
> > callbacks with .remove_new() which will then be changed back to
> > .remove() treewide.
> >
>
> This was the only patch that I was included into, so I didn't realise
> there was a treewide rename at the end.

I didn't want to spam 20+ maintainers with the entire series of 36
patches. Should have probably Cc'ed everyone on the cover letter
though.

> Even so, using _new suffix for that purpose is poor (well
> pinctrl_gpio_free_new() did draw a laugh, but other than that...).
> Perhaps use something specific to the patch series so it is clear what
> its purpose is?
>

I think Linus will end up applying the entire series to his tree in
one go in which case the name really doesn't matter. Do we really need
to bikeshed about the name which will exist for as long as it takes to
apply the series on his laptop? I much more care about preserving
bisectability across the series which it does.

Bart
