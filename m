Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED78F7C42F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjJJVto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJJVtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:49:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2968D9B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:49:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so10647436a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696974578; x=1697579378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7h+lc6NYDkM0aLu7Je52h2iauy5SW2qjtY2wHCOWf8=;
        b=EagDt8nRbid7anETHcYGvI2OPtfrXkAMwHkGdvtXoAtmjied1o2TLxOKrAq45eEJBP
         qOMGOzdenOFmSN2YYYY0wydGf1pEO3wDFkArMkPmOvgWWVTs+tSu25btIHDPz5w517CC
         6k0agE5zUKAmEa641PTELPN42GLffxoOnRMTwphy24Q2ZL8GLFiAHduNli8EfGqSSsXQ
         tzGRpUf6Kg/qLKYHmkbfT9uAlLUVMM5xzwIH25LyEYpg+SWX/4jBaPCLQo0mCuAJxgtT
         389vS9kaJ8x5vkJ8LgQo2DyVD8ZuzAK1F6lOE+nvkqww5bA8RHyFGjAKc8Rs/3sFFCFE
         2O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696974578; x=1697579378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7h+lc6NYDkM0aLu7Je52h2iauy5SW2qjtY2wHCOWf8=;
        b=TmStD9dXqYgSk3jSw5rusGdZiSX01Ya9Ksu+Dg373RUdDk6DdHkKB5p7F5XwjSkKMT
         4cuUwQPcOJiRl+j8qPc0qlMvaXa/Ceen3OgHl6vRMiaigfMl6ALHWmkGmnkBW1gJFf90
         1RU9CNbmnysCZzjKALnhvAEQntUKzy3XhpTMTsT2WK3iuTcU+N3vXtvv76W6SoWHWhhc
         vLDmD0kiOHq4U9JsZ2aL3Xc2t8q4mtXvim30k1ZjP8yKIM4oOs8kl4+2qOkFTbafn2Fj
         RaHaXSorLH+58uV8D7plCqj/Z374sLbwRw07aTgCo6LJ0JNUVCbol13Uwv7tx8EOcVAQ
         zNVQ==
X-Gm-Message-State: AOJu0YwkfgxKLXom2wRQkGFPN0yLO6Jq3j1EV0XNluds2OcaO6jboC94
        QTJqRDfR7NGUJK9Z/OpjDQdI6tkEKPsknRs9n9fjaA==
X-Google-Smtp-Source: AGHT+IE6ISNf8cf4dTDXk7X1ataFWg0rtgwPfk3ueBUDDX0QKUVHZqMdCqzfHZ2i3xQflCne3oL89FZN5pgQljLYcS4=
X-Received: by 2002:aa7:cf87:0:b0:525:570c:566b with SMTP id
 z7-20020aa7cf87000000b00525570c566bmr16299268edx.22.1696974578513; Tue, 10
 Oct 2023 14:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
 <20231010112051.zgefbx2c3tjneudz@skbuf>
In-Reply-To: <20231010112051.zgefbx2c3tjneudz@skbuf>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 10 Oct 2023 14:49:26 -0700
Message-ID: <CAFhGd8qoAy49FnnsZVn89f-cVgsfivDzhu2PzYZ_UwCvhmrhYw@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: vsc73xx: replace deprecated strncpy with ethtool_sprintf
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 4:20=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Mon, Oct 09, 2023 at 10:54:37PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > ethtool_sprintf() is designed specifically for get_strings() usage.
> > Let's replace strncpy in favor of this more robust and easier to
> > understand interface.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/net/dsa/vitesse-vsc73xx-core.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/v=
itesse-vsc73xx-core.c
> > index 4f09e7438f3b..09955fdea2ff 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> > +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> > @@ -928,7 +928,8 @@ static void vsc73xx_get_strings(struct dsa_switch *=
ds, int port, u32 stringset,
> >       const struct vsc73xx_counter *cnt;
> >       struct vsc73xx *vsc =3D ds->priv;
> >       u8 indices[6];
> > -     int i, j;
> > +     u8 *buf =3D data;
> > +     int i;
> >       u32 val;
> >       int ret;
> >
> > @@ -948,10 +949,7 @@ static void vsc73xx_get_strings(struct dsa_switch =
*ds, int port, u32 stringset,
> >       indices[5] =3D ((val >> 26) & 0x1f); /* TX counter 2 */
> >
> >       /* The first counters is the RX octets */
> > -     j =3D 0;
> > -     strncpy(data + j * ETH_GSTRING_LEN,
> > -             "RxEtherStatsOctets", ETH_GSTRING_LEN);
> > -     j++;
> > +     ethtool_sprintf(&buf, "RxEtherStatsOctets");
>
> Here you don't use "%s", but everywhere else you do. Can't you just pass
> the counter name everywhere, without "%s"?

Because it's a string literal, no warning there. Maybe an argument
regarding style could be made. I have no style preference here
so I could send v2 if you feel strongly about it.

>
> >
> >       /* Each port supports recording 3 RX counters and 3 TX counters,
> >        * figure out what counters we use in this set-up and return the
> > @@ -962,22 +960,16 @@ static void vsc73xx_get_strings(struct dsa_switch=
 *ds, int port, u32 stringset,
> >       for (i =3D 0; i < 3; i++) {
> >               cnt =3D vsc73xx_find_counter(vsc, indices[i], false);
> >               if (cnt)
> > -                     strncpy(data + j * ETH_GSTRING_LEN,
> > -                             cnt->name, ETH_GSTRING_LEN);
> > -             j++;
> > +                     ethtool_sprintf(&buf, "%s", cnt->name);
>
> The code conversion is not functionally identical, and I think it's a
> bit hard to make it identical.
>
> The VSC7395 has 45 port counters, but it seems that it can only monitor
> and display 8 of them at a time - 2 fixed and 6 configurable through
> some windows.
>
> vsc73xx_get_strings() detects which counter is each window configured
> for, based on the value of the CNT_CTRL_CFG hardware register (VSC73XX_C_=
CFG
> in the code). It displays a different string depending on the hardware
> value.
>
> The code must deal with the case where vsc73xx_find_counter() returns
> NULL, aka the hardware window is configured for a value that vsc73xx_tx_c=
ounters[]
> and vsc73xx_rx_counters[] don't know about.
>
> Currently, the way that this is treated is by skipping the strncpy()
> (and thus leaving an empty string), and incrementing j to get to the
> next ethtool counter, and next window.
>
> The order of the strings in vsc73xx_get_strings() needs to be strongly
> correlated to the order of the counters from vsc73xx_get_ethtool_stats().
> So, the driver would still print counter values for the unknown windows,
> it will just not provide a string for them.
>
> In your proposal, the increment of j basically goes into the "if (cnt)"
> block because it's embedded within ethtool_sprintf(), which means that
> if a hardware counter is unknown, the total number of reported strings
> will be less than 8. Which is very problematic, because vsc73xx_get_sset_=
count()
> says that 8 strings are reported. Also, all the counter strings after
> the unknown one will be shifted to the left.
>
> I suggest that "if (!cnt)", you should call ethtool_sprintf() with an
> empty string, to preserve the original behavior.
>
> >       }
> >
> >       /* TX stats begins with the number of TX octets */
> > -     strncpy(data + j * ETH_GSTRING_LEN,
> > -             "TxEtherStatsOctets", ETH_GSTRING_LEN);
> > -     j++;
> > +     ethtool_sprintf(&buf, "TxEtherStatsOctets");
> >
> >       for (i =3D 3; i < 6; i++) {
> >               cnt =3D vsc73xx_find_counter(vsc, indices[i], true);
> >               if (cnt)
> > -                     strncpy(data + j * ETH_GSTRING_LEN,
> > -                             cnt->name, ETH_GSTRING_LEN);
> > -             j++;
> > +                     ethtool_sprintf(&buf, "%s", cnt->name);
> >       }
> >  }
> >
> >
> > ---
> > base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> > change-id: 20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-1cfd=
0ac2d81b
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
>
Thanks
Justin
