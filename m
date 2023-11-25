Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550907F905C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 00:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKYXqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 18:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKYXqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 18:46:09 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC212F0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 15:46:15 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5cc5988f85eso30326737b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 15:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700955975; x=1701560775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hFIt0HmR86o9B8NpKYxKa6/Sz6hTZOcUx/vMSf/X6U=;
        b=LclWgNdLtUgCrUPOz6lD3ZYZbcpRee6fMR/vU7nM6ALljxSs+nHiAPxhdn0PSNQZ45
         /NzJnENKNul8QwZ4M1RQ7s0pimQ3Lyorza8qzPmfwh4RidoNcR7x+Y80Ej9GAuRwtAGk
         /d1OCBYf7mwpEB/V6QDEefCokgH5kAnZhj7uR3EN6fBiHei/FTXD7ItT9NfbkbpEuoC0
         Vw7trBQZltdFgxdbJhBeHceIL8ZFrdvKP4r3VZYkEuS6dln94oMLpsCAz+mq1iO3YNfr
         aO0nTRHE+eQghND6Cn6/18oymsAEMKzgBRArZ9Fto2kz0mFMF8DoW2mYPEurvAVC5/bg
         Q0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700955975; x=1701560775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hFIt0HmR86o9B8NpKYxKa6/Sz6hTZOcUx/vMSf/X6U=;
        b=ncoPRr1uJyqKnmqZZEhLYYySM+n7IL1QtqXm5zrtc+kvod6MTdQpmYe7WD1Wlbzb/a
         ZTK6+urBwnEDjLXo0dAyU8ykHCTYSVTO8OI5ETnAkH3z8WXmV4GExMFK01c22wYedY9X
         FR3Hif6AHLn0ah7eo/SWR7o1ztEjH+SzIpqf8TVu76F/b2yewCG2wVVq9vYH3R/RBYfd
         E6BbwtNn9FZD8dA1CpWKJDdOCQ9/4atphovSeIk9tGiLMak0tbx9nfJrWOnqN5tfGW7H
         U6kDyEvalo3a9/qxyosGdtOMDLS6KblWj5ZGfXSnODhBvDpK/2c+ZU57EoXHYtB9c0dH
         azGg==
X-Gm-Message-State: AOJu0YyzDIqxTdeooueoVTPWQnGqOK57RBegqsC4hs24jC4i8RcCMQJ6
        yU6K87GQ6pNhCxrb0BNDT7xZ38xSAzW51gf51D4GNg==
X-Google-Smtp-Source: AGHT+IG60g3mNV47IlwttcnDH+atQvnMLJ1evmHoV/+jZ4ba2ng+5GbfULZhB+H2t82HBju/xWOk1HvQPjPv5o1XktY=
X-Received: by 2002:a0d:fcc2:0:b0:59f:b0d9:5df2 with SMTP id
 m185-20020a0dfcc2000000b0059fb0d95df2mr8159218ywf.0.1700955974890; Sat, 25
 Nov 2023 15:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20231123-mv88e6xxx-leds-v1-1-3c379b3d23fb@linaro.org> <c8c821f8-e170-44b3-a3f9-207cf7cb70e2@lunn.ch>
In-Reply-To: <c8c821f8-e170-44b3-a3f9-207cf7cb70e2@lunn.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Nov 2023 00:46:03 +0100
Message-ID: <CACRpkdY+T8Rqg_irkLNvAC+o_QfwO2N+eB9X-y24t34_9Rg3ww@mail.gmail.com>
Subject: Re: [PATCH RFC] net: dsa: mv88e6xxx: Support LED control
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 5:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> What i would really like to see happen is that the DSA core handles
> the registration of the LEDs, similar to how phylib does. The DT
> binding should be identical for all DSA devices, so there is no need
> for each driver to do its own parsing.
>
> There are some WIP patches at
>
> https://github.com/lunn/linux.git leds-offload-support-reduced-auto-netde=
v
>
> which implement this. Feel free to make use of them.

Oh it's quite a lot of patches, I really cannot drive that because there ar=
e
so many things about them that I don't understand the thinking behind...
But I like what I see!

While I defined the bits a bit differently, some of it looks similar enough=
.

> > +/* Entries are listed in selector order */
> > +static const struct mv88e6xxx_led_hwconfig mv88e6xxx_led_hwconfigs[] =
=3D {
>
> You need to be careful with naming. These are probably specific to the
> 6352. Different switches probably have different capabilities. So it
> would be good to have the names reflect the switch family they are
> valid for.

OK I'll try to name them like such.

> When we come to add support for other switch families, i wounder how
> tables like this scale. Is there some things which can be shared, if
> we break the table up? I need to check the data sheets.

We will see I guess. It falls back to the whole question of whether
supporting all variants in a single module is even scaling. So far
it does I guess? One day the MV88E6xxx may need to be broken
into submodules.

Yours,
Linus Walleij
