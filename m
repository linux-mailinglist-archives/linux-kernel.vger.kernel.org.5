Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97404782AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjHUNtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjHUNtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:49:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5950EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:49:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so12752a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692625746; x=1693230546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaYsz98fmO0AeRBJAu60FsVXxbkbmXArYB3D1Oortk0=;
        b=NY8oaljNQrhtgW5K6S4sGaVlEXyY6+6r9N0NAQFWNvYz9Gzug4wf8p7dv4guqfoEr4
         AVwsM1dro963Mwj8Y0+lLHxTVVT3qQS1vcLWcD0SbDJ0WEhAwX3QZ0dTWYyxq78d0pMU
         /12tx20wlR4Nriid+x5wuEd5WHF8kOD4XjdId3gD9rPjpWg/I8NApWR7wvsC+l2cV1Jx
         d/h8i0wWEK5vPskb5BONrZ22MgET40Y/ft8zcsu5KhD6tWyVzw18QjhwuSZ8oHefHSMA
         FGWC2iyWlK8xThnXNjPxJRhGLC8u/gGGuTWOXYL81xjhkMpjkrhHgrK0nDja6sfzLZF0
         m3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692625746; x=1693230546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaYsz98fmO0AeRBJAu60FsVXxbkbmXArYB3D1Oortk0=;
        b=fR3Ev5M0l5EhudpI3cHEjwU1cA3JwehCUFbXxaWKdWgcaM5yLJId3x2vStf+qyJa4u
         7iseyGXWckZGeC8mmjVDfALVY8LOrHHA+o3TO/++Qs8PTooic2D6bQkt1ST987vGZ/gh
         JO6xc4AeSlT6K0jmNjzN5UUrP0rxdzgqwOfkvDqQvB/WWnwFuFXIYWu4yhBx5tnIb4Jd
         5TxBLIsjWcUVwlECDA/9H1eoG6dqJTxfWKKnT2nVpGxtDGhO2mVvdPYU2DIYCOSoEuiC
         JC4gq4pfGIa+SE4MfoibnIybO/Ks5roPn6ZBnO0N9QzpJ1uwatsP72ULP0YxCYf8iXaE
         1Kmg==
X-Gm-Message-State: AOJu0Yw2YleKsQKs5SYuzzg7BnuoAXgbqN6SHN9KaTxrGcnDEjJla5yj
        vUVpfjxD97juFaJiuGjUu9nRLoWLddO3ZMAuOsGnaA==
X-Google-Smtp-Source: AGHT+IEsdYGt90fBKrN0wm/Vx4ISKupF2JySSM4rjWmpOgimEjZDuxmmOucFPn9uxTu62uO4TBLkuDp4Vn0QFAAIERQ=
X-Received: by 2002:a50:ab17:0:b0:522:cc9c:f5a4 with SMTP id
 s23-20020a50ab17000000b00522cc9cf5a4mr271722edc.4.1692625745977; Mon, 21 Aug
 2023 06:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
 <20230802071947.1683318-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=Um8875aMt_kWvCvpNjb3EwSk8VjVTEgv_TJ9WDS+LniA@mail.gmail.com> <lyns4qkh57xhppnqroaooqtniypfsmr2l5fujlry3stmhrjww4@3iy5mmmrazl6>
In-Reply-To: <lyns4qkh57xhppnqroaooqtniypfsmr2l5fujlry3stmhrjww4@3iy5mmmrazl6>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 21 Aug 2023 06:48:53 -0700
Message-ID: <CAD=FV=UFM-5XFsTRt7LPXsN9Fjff33khYGQM+XqcLF1YdsRY4Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] HID: i2c-hid: elan: Add ili9882t timing
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        benjamin.tissoires@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dmitry.torokhov@gmail.com, jikos@kernel.org, hsinyi@google.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 21, 2023 at 2:01=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On Aug 02 2023, Doug Anderson wrote:
> > Benjamin,
> >
> > On Wed, Aug 2, 2023 at 12:20=E2=80=AFAM Cong Yang
> > <yangcong5@huaqin.corp-partner.google.com> wrote:
> > >
> > > The ili9882t is a TDDI IC (Touch with Display Driver). The
> > > datasheet specifies there should be 60ms between touch SDA
> > > sleep and panel RESX. Doug's series[1] allows panels and
> > > touchscreens to power on/off together, so we can add the 65 ms
> > > delay in i2c_hid_core_suspend before panel_unprepare.
> > >
> > > Because ili9882t touchscrgeen is a panel follower, and
> > > needs to use vccio-supply instead of vcc33-supply, so set
> > > it NULL to ili9882t_chip_data, then not use vcc33 regulator.
> > >
> > > [1]: https://lore.kernel.org/all/20230727171750.633410-1-dianders@chr=
omium.org
> > >
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > > ---
> > >  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 50 ++++++++++++++++++++-----=
--
> > >  1 file changed, 38 insertions(+), 12 deletions(-)
> >
> >
> > >
> > > diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-=
hid/i2c-hid-of-elan.c
> > > index 029045d9661c..31abab57ad44 100644
> > > --- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> > > +++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> > > @@ -18,9 +18,11 @@
> > >  #include "i2c-hid.h"
> > >
> > >  struct elan_i2c_hid_chip_data {
> > > -       unsigned int post_gpio_reset_delay_ms;
> > > +       unsigned int post_gpio_reset_on_delay_ms;
> > > +       unsigned int post_gpio_reset_off_delay_ms;
> > >         unsigned int post_power_delay_ms;
> > >         u16 hid_descriptor_address;
> > > +       const char *main_supply_name;
> > >  };
> > >
> > >  struct i2c_hid_of_elan {
> > > @@ -38,9 +40,11 @@ static int elan_i2c_hid_power_up(struct i2chid_ops=
 *ops)
> > >                 container_of(ops, struct i2c_hid_of_elan, ops);
> > >         int ret;
> > >
> > > -       ret =3D regulator_enable(ihid_elan->vcc33);
> > > -       if (ret)
> > > -               return ret;
> > > +       if (ihid_elan->vcc33) {
> > > +               ret =3D regulator_enable(ihid_elan->vcc33);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > >
> > >         ret =3D regulator_enable(ihid_elan->vccio);
> > >         if (ret) {
> > > @@ -52,8 +56,8 @@ static int elan_i2c_hid_power_up(struct i2chid_ops =
*ops)
> > >                 msleep(ihid_elan->chip_data->post_power_delay_ms);
> > >
> > >         gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
> > > -       if (ihid_elan->chip_data->post_gpio_reset_delay_ms)
> > > -               msleep(ihid_elan->chip_data->post_gpio_reset_delay_ms=
);
> > > +       if (ihid_elan->chip_data->post_gpio_reset_on_delay_ms)
> > > +               msleep(ihid_elan->chip_data->post_gpio_reset_on_delay=
_ms);
> > >
> > >         return 0;
> > >  }
> > > @@ -64,8 +68,12 @@ static void elan_i2c_hid_power_down(struct i2chid_=
ops *ops)
> > >                 container_of(ops, struct i2c_hid_of_elan, ops);
> > >
> > >         gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> > > +       if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
> > > +               msleep(ihid_elan->chip_data->post_gpio_reset_off_dela=
y_ms);
> > > +
> > >         regulator_disable(ihid_elan->vccio);
> > > -       regulator_disable(ihid_elan->vcc33);
> > > +       if (ihid_elan->vcc33)
> > > +               regulator_disable(ihid_elan->vcc33);
> > >  }
> > >
> > >  static int i2c_hid_of_elan_probe(struct i2c_client *client)
> > > @@ -89,24 +97,42 @@ static int i2c_hid_of_elan_probe(struct i2c_clien=
t *client)
> > >         if (IS_ERR(ihid_elan->vccio))
> > >                 return PTR_ERR(ihid_elan->vccio);
> > >
> > > -       ihid_elan->vcc33 =3D devm_regulator_get(&client->dev, "vcc33"=
);
> > > -       if (IS_ERR(ihid_elan->vcc33))
> > > -               return PTR_ERR(ihid_elan->vcc33);
> > > -
> > >         ihid_elan->chip_data =3D device_get_match_data(&client->dev);
> > >
> > > +       if (ihid_elan->chip_data->main_supply_name) {
> > > +               ihid_elan->vcc33 =3D devm_regulator_get(&client->dev,
> > > +                                                     ihid_elan->chip=
_data->main_supply_name);
> > > +               if (IS_ERR(ihid_elan->vcc33))
> > > +                       return PTR_ERR(ihid_elan->vcc33);
> > > +       }
> > > +
> > >         return i2c_hid_core_probe(client, &ihid_elan->ops,
> > >                                   ihid_elan->chip_data->hid_descripto=
r_address, 0);
> > >  }
> > >
> > >  static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_data =
=3D {
> > >         .post_power_delay_ms =3D 1,
> > > -       .post_gpio_reset_delay_ms =3D 300,
> > > +       .post_gpio_reset_on_delay_ms =3D 300,
> > > +       .hid_descriptor_address =3D 0x0001,
> > > +       .main_supply_name =3D "vcc33",
> > > +};
> > > +
> > > +static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data=
 =3D {
> > > +       .post_power_delay_ms =3D 1,
> > > +       .post_gpio_reset_on_delay_ms =3D 200,
> > > +       .post_gpio_reset_off_delay_ms =3D 65,
> > >         .hid_descriptor_address =3D 0x0001,
> > > +       /*
> > > +        * this touchscreen is tightly integrated with the panel and =
assumes
> > > +        * that the relevant power rails (other than the IO rail) hav=
e already
> > > +        * been turned on by the panel driver because we're a panel f=
ollower.
> > > +        */
> > > +       .main_supply_name =3D NULL,
> > >  };
> > >
> > >  static const struct of_device_id elan_i2c_hid_of_match[] =3D {
> > >         { .compatible =3D "elan,ekth6915", .data =3D &elan_ekth6915_c=
hip_data },
> > > +       { .compatible =3D "ilitek,ili9882t", .data =3D &ilitek_ili988=
2t_chip_data },
> >
> > Logically, this patch depends on the panel-follower series that's now
> > landed in drm-misc-next. With your Ack, I'm willing to land these two
> > patches into drm-misc-next too. Other options:
>
> If you are fine with the code, I think it could go with the drm tree
> given that it depends on the panel-follower.
>
> Unless it's too late for you to take 6.6 material (sorry I was off in
> August and just came back).
>
> Acked-By: Benjamin Tissoires <bentiss@kernel.org>

Thanks for the Ack, but yeah, it's probably too late for drm-misc.
Hopefully this can go through the normal tree after the next -rc1
then. Thanks!

-Doug
