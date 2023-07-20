Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFDB75B430
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGTQ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjGTQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:29:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A82E75;
        Thu, 20 Jul 2023 09:29:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b74310566cso15339521fa.2;
        Thu, 20 Jul 2023 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689870543; x=1690475343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocSaHX5NIVFNKYOsfv6n0BEBaxKRDPz0bQ1Rbnsgza0=;
        b=mpxA7JkBj7jv1YVESB2ckxNUJcbRn22fEA0Jt09Oc9l3ibYw+ondIl8GseInFHhKsa
         LeYX0PQppKzyQtELehqZgaU8ouenxWto3oAzXI/94CCi/2L3DKNAtlj0+IXG6ySgYAlI
         8Yv75xKwwNy11tuj5/6WnHqgRqdcGP940Iz5wkO0iqtCQKAg6kDJt/gR7/Izd7Z8A3q8
         KmcSaPZ4ZKjhtXZW7ZIkDOcCcOVhEXflJQek0j8b1LU+/nbwV8/KYp1+qOy4Ph13m0vK
         FnH6qIuLD27RUDxhT/KmsXHT7TzzZSQULB3yZ8d1noJ6p+u9QOp7P+mW9jgyk5RqzX7A
         wliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689870543; x=1690475343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocSaHX5NIVFNKYOsfv6n0BEBaxKRDPz0bQ1Rbnsgza0=;
        b=K7cwng99GC1lvlPhosqcGWfqwK310g3v2ZrJmweVdGsRWqdUFDpGJVTg3zuuKiXscq
         HFZ5xg8wwx8jP9+AFGFV3K+zVuOhb1MBHP7LeD8EQz3YsMJkH23NOjpRwde5TDh9p5Pb
         h1560kcDMSI3zxqOPpv+kdEqFJVDb5B+k7jarzj3IIGF3DduaFNlAEdy2XlmY4aVYJw2
         oab+uXGcKjhyWROA81R7lv9pQu5sRkperfnxdCfdyfCfBt0MMyni6d+BcnrORCrmcOGZ
         aIY0YDRNAwxs/ScHnKDL5CWKIVDtEBaI0fBudDjC9HonfcAVmXoZrIQymJ+1vDf0azyY
         1asQ==
X-Gm-Message-State: ABy/qLatirkETS1Mq2iROuLLds6g6Q2ADiuZ7Tn4at5oVcIUeFgDwp1/
        xB7bfa/39xn2gJi2y48b5cUgrluocpatu1cbuE8=
X-Google-Smtp-Source: APBJJlECZqwpsuvvsnL5OMKuLs00FpsDWt0kR1bFClLwdqeW+ShzMPTJAas1gJeKMsPx8ihKs6Tx3kyhZzIqiVctg/8=
X-Received: by 2002:a2e:3203:0:b0:2b6:e105:6174 with SMTP id
 y3-20020a2e3203000000b002b6e1056174mr2751836ljy.47.1689870542887; Thu, 20 Jul
 2023 09:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230720061105.154821-1-victor.liu@nxp.com> <20230720112742.GA2525277@aspen.lan>
In-Reply-To: <20230720112742.GA2525277@aspen.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jul 2023 19:28:26 +0300
Message-ID: <CAHp75Vdw_-nKUdNm0TNRnMFLhUEoFAtTpt4ApVNmeHFOi_16Xg@mail.gmail.com>
Subject: Re: [PATCH] backlight: gpio_backlight: Drop output gpio direction
 check for initial power state
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Ying Liu <victor.liu@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 2:27=E2=80=AFPM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Jul 20, 2023 at 06:06:27AM +0000, Ying Liu wrote:
> > Bootloader may leave gpio direction as input and gpio value as logical =
low.
> > It hints that initial backlight power state should be FB_BLANK_POWERDOW=
N
> > since the gpio value is literally logical low.
>
> To be honest this probably "hints" that the bootloader simply didn't
> consider the backlight at all :-) . I'd rather the patch description
> focus on what circumstances lead to the current code making a bad
> decision. More like:
>
>   If the GPIO pin is in the input state but the backlight is currently
>   off due to default pull downs then ...
>
> > So, let's drop output gpio
> > direction check and only check gpio value to set the initial power stat=
e.
>
> This check was specifically added by Bartosz so I'd be interested in his
> opinion of this change (especially since he is now a GPIO maintainer)!
>
> What motivates (or motivated) the need to check the direction rather
> than just read that current logic level on the pin?

...

> > -     else if (gpiod_get_direction(gbl->gpiod) =3D=3D 0 &&
> > -              gpiod_get_value_cansleep(gbl->gpiod) =3D=3D 0)
> > +     else if (gpiod_get_value_cansleep(gbl->gpiod) =3D=3D 0)
> >               bl->props.power =3D FB_BLANK_POWERDOWN;

The code before this patch needs a bit of elaboration. There is no
prohibition on reading value for the pin that is in any direction.
I.o.w. if the direction here is a problem it should have been
configured beforehand.

--=20
With Best Regards,
Andy Shevchenko
