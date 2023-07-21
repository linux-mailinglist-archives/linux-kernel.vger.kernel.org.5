Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A388275BEF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjGUGdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGUGdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:33:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A8D113;
        Thu, 20 Jul 2023 23:33:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9891c73e0fbso339026066b.1;
        Thu, 20 Jul 2023 23:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689921215; x=1690526015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnoccgm9pbFbfKUa9nHPfrhyKpJevZV6lRDZU+5R3HY=;
        b=lff+WY/rFM79DiX68p0sDAXj+pfWUi86h0J8FhNtLOqTuVYK4386kw1jWOHJxhPE1R
         SIe5+u3TWL7OlQRjR5PRK/CieuHVltbVamSV7z7kaexGnAYwy+0sp+MUtYfiKrTVze+J
         TMPlDVVlRNU6WA3LEIhsldmVb7xy3J3eezzWe9R4MtcHd8TajMhBTQT22TFFRkQfP6Zh
         nY+TUv3fKJwglNZkTIlf+Nvrder7u9HOEbrkfGDewYQRsQp36KdVojRsb+NpR0zvXNty
         +Kmu4lZObKQTE7cNVAPVFOjNjukIsu5umvADczDVnC6unINqxKyyhYdS8kw5OT8TxWe/
         xP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689921215; x=1690526015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnoccgm9pbFbfKUa9nHPfrhyKpJevZV6lRDZU+5R3HY=;
        b=ATMIVlhZmDLCCO4/IBy6Kp3vqYMAU3MKCt756UJd0jJhXPLGG8H/lstpWIRn3KPUA6
         EVkbh2FNLBRkKShj6PHtnrkqltQDVscLR1fbKHCoIdGZXUC3OwlNfl+Sv3PtdH5DgqxJ
         v9aL/O4KCxM1PRbmEKz/RpGaJd0BWzvUAc8htAcTjtxrvUF+d7Si4l4ABRJVMOfUhVQU
         ESMLEMsv9T/DH7aWSfgg2I1FwD5Rqbie43C9LlVxpHncp+ffyLm6Unb5jtY3Iwq4uxPy
         1sxRitwa/JYvtg1hMflwpGNf86C6DRf+Bcg/xot262gdPODTCY8/kl2juXzE2V6HCA+Q
         L1BA==
X-Gm-Message-State: ABy/qLYGrOdxYQYX6bkfft1euA8njG16yPLEYvAXrcB1f6nz3Ywuk5YQ
        L0oMNe4Iu3DeV9D2Jo56wJJ8g8+AGK6oO2dThic=
X-Google-Smtp-Source: APBJJlEtO4UicrSfPlGEItokOw0Rqd9qo0Xz3sQB7r3a2uNCVNw6hO5cWfLViqwkI1hefdfKpgawHCVRuNQc60GaJTw=
X-Received: by 2002:a17:907:7e92:b0:98e:4f1:f987 with SMTP id
 qb18-20020a1709077e9200b0098e04f1f987mr8028770ejc.3.1689921214685; Thu, 20
 Jul 2023 23:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230720061105.154821-1-victor.liu@nxp.com> <20230720112742.GA2525277@aspen.lan>
 <AM7PR04MB7046CF1E1561A37C7A5AC89B983FA@AM7PR04MB7046.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB7046CF1E1561A37C7A5AC89B983FA@AM7PR04MB7046.eurprd04.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Jul 2023 09:32:58 +0300
Message-ID: <CAHp75Vf6FTgHyimX+B80tZEwJRg7ut1=DS=Dbdy+Aa+xVwh5YQ@mail.gmail.com>
Subject: Re: [PATCH] backlight: gpio_backlight: Drop output gpio direction
 check for initial power state
To:     Ying Liu <victor.liu@nxp.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
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

On Fri, Jul 21, 2023 at 8:17=E2=80=AFAM Ying Liu <victor.liu@nxp.com> wrote=
:
> On Thursday, July 20, 2023 7:28 PM Daniel Thompson <daniel.thompson@linar=
o.org> wrote:
> > On Thu, Jul 20, 2023 at 06:06:27AM +0000, Ying Liu wrote:
> > > Bootloader may leave gpio direction as input and gpio value as logica=
l low.
> > > It hints that initial backlight power state should be
> > FB_BLANK_POWERDOWN
> > > since the gpio value is literally logical low.
> >
> > To be honest this probably "hints" that the bootloader simply didn't
> > consider the backlight at all :-) . I'd rather the patch description
> > focus on what circumstances lead to the current code making a bad
> > decision. More like:
> >
> >   If the GPIO pin is in the input state but the backlight is currently
> >   off due to default pull downs then ...
>
> How about this patch description?
>
> ---------------------------------8<--------------------------------------=
-----
> Without this patch, if gpio pin is in input state but backlight is curren=
tly

s/Without this patch, if/If/

> off due to default pull downs, then initial power state is set to
> FB_BLANK_UNBLANK in DT boot mode with phandle link and the backlight is
> effectively turned on in gpio_backlight_probe(), which is undesirable
> according to patch description of commit ec665b756e6f ("backlight:
> gpio-backlight: Correct initial power state handling").
>
> Quote:
> ---
> If in DT boot we have phandle link then leave the GPIO in a state which t=
he
> bootloader left it and let the user of the backlight to configure it furt=
her.
> ---
>
> So, let's drop output gpio direction check and only check gpio value to s=
et
> the initial power state.
> ---------------------------------8<--------------------------------------=
-----

--=20
With Best Regards,
Andy Shevchenko
