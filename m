Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC9782C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjHUOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbjHUOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:49:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5A1AA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:49:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fef56e85edso28255e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692629335; x=1693234135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8jXCYIqyhmpLreD70EjAUJFKXAlWYjYkvcU4wz+60w=;
        b=q/0E1KAa+Y4kKvVzixWwHcEGAp8HT8PJAM5riMfuy0tkC0gEaOhDFtZqRk7RN5x38D
         I8Q1maWFebs6b1+xU1mIxC51qLDe538WGTEkFushm+6URPxKVSFIhvegVq7suXaBD08O
         nu36j5Vxx4CW/rsBH0YcAE5Wrj1GluTsnzLaz5NMzlqHjxBLRgxkTNx9+Qy7YLAD9RK6
         4+bAO1tUNf3DbDVSbgmU9RSmUwrpgYe6hKLGNMJl1Rb6KxKmk5gdUDpWch/+OX629Mpn
         lO3ZdTd4gFP0lQZ4qOOFOxG3Ku86THJbiY56v74PVa4TesvXLmsUD4Tskblo5xpleyHu
         l0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692629335; x=1693234135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8jXCYIqyhmpLreD70EjAUJFKXAlWYjYkvcU4wz+60w=;
        b=mH5vyGkpXnf3d8WVC3ojPv6BW4Gmu+L4MLfFtbdaiRNGI8ICezMP6oqZPZdCjIQJRk
         eW/hKaWloRKrWC++GuT4KTBR1oUp4dAhfBp/wG/X/1SoqiDfMAw7FPaKUg79bGhYwjYu
         whTfgMNqAV0NLu3VhrnQhZTlPCrQ29BV2+SgkHsVpgYSn0hFHijCXxBjI5SH7QkiHJN7
         mJwn+IDABgXsGnzr/nnvr8hTkGpf4wwWjWn+EA1dAqeX826VnALXoAQH299OsRMLo08e
         /294t2Pa3/7Zmi9C08q+0y8yv3p0UwutzXI+kjvX+byCNORoGikWt7PhrAYnH3gKA+pi
         aiJA==
X-Gm-Message-State: AOJu0YzggOgVPmPvU4PDcMJGgS9JxFE9MJ1MIW+nnObuLaeOa6GuRuGU
        +pwqYGvEsFeNfdXFQZz1yi7nUTAzXj86aQNe/25SkA==
X-Google-Smtp-Source: AGHT+IHtbrF3M4PA8JeUE4+qsLi/1xpdQHFqQ/6nMLwg3McHuKYyJUVDyYrlwYnSmFeRuk4YxXvSPdyMlerbS6E2mDg=
X-Received: by 2002:a05:600c:331e:b0:3fe:eb42:7ec with SMTP id
 q30-20020a05600c331e00b003feeb4207ecmr93162wmp.1.1692629334782; Mon, 21 Aug
 2023 07:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
 <20230802071947.1683318-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=Um8875aMt_kWvCvpNjb3EwSk8VjVTEgv_TJ9WDS+LniA@mail.gmail.com>
 <lyns4qkh57xhppnqroaooqtniypfsmr2l5fujlry3stmhrjww4@3iy5mmmrazl6>
 <CAD=FV=UFM-5XFsTRt7LPXsN9Fjff33khYGQM+XqcLF1YdsRY4Q@mail.gmail.com> <dqom52gdxgsglhkfrl43peoh2lw2npmx6libdeulmyi67nszat@vqlvijq5mld7>
In-Reply-To: <dqom52gdxgsglhkfrl43peoh2lw2npmx6libdeulmyi67nszat@vqlvijq5mld7>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 21 Aug 2023 07:48:42 -0700
Message-ID: <CAD=FV=Wd61CbcVuHwVwZiGRWb52iVR0u4Vfc8r319j+KumFKqg@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 21, 2023 at 7:14=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On Aug 21 2023, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Aug 21, 2023 at 2:01=E2=80=AFAM Benjamin Tissoires <bentiss@ker=
nel.org> wrote:
> > >
> > > On Aug 02 2023, Doug Anderson wrote:
> > > > Benjamin,
> > > >
> > > > On Wed, Aug 2, 2023 at 12:20=E2=80=AFAM Cong Yang
> > > > <yangcong5@huaqin.corp-partner.google.com> wrote:
> > > > >
> > > > > The ili9882t is a TDDI IC (Touch with Display Driver). The
> > > > > datasheet specifies there should be 60ms between touch SDA
> > > > > sleep and panel RESX. Doug's series[1] allows panels and
> > > > > touchscreens to power on/off together, so we can add the 65 ms
> > > > > delay in i2c_hid_core_suspend before panel_unprepare.
> > > > >
> > > > > Because ili9882t touchscrgeen is a panel follower, and
> > > > > needs to use vccio-supply instead of vcc33-supply, so set
> > > > > it NULL to ili9882t_chip_data, then not use vcc33 regulator.
> > > > >
> > > > > [1]: https://lore.kernel.org/all/20230727171750.633410-1-dianders=
@chromium.org
> > > > >
> > > > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > > > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.co=
m>
> > > > > ---
> > > > >  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 50 ++++++++++++++++++++-=
------
> > > > >  1 file changed, 38 insertions(+), 12 deletions(-)
> > > >
> > > >
> > > > >
> > > > > diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/=
i2c-hid/i2c-hid-of-elan.c
> > > > > index 029045d9661c..31abab57ad44 100644
> > > > > --- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> > > > > +++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> > > > > @@ -18,9 +18,11 @@
> > > > >  #include "i2c-hid.h"
> > > > >
> > > > >  struct elan_i2c_hid_chip_data {
> > > > > -       unsigned int post_gpio_reset_delay_ms;
> > > > > +       unsigned int post_gpio_reset_on_delay_ms;
> > > > > +       unsigned int post_gpio_reset_off_delay_ms;
> > > > >         unsigned int post_power_delay_ms;
> > > > >         u16 hid_descriptor_address;
> > > > > +       const char *main_supply_name;
> > > > >  };
> > > > >
> > > > >  struct i2c_hid_of_elan {
> > > > > @@ -38,9 +40,11 @@ static int elan_i2c_hid_power_up(struct i2chid=
_ops *ops)
> > > > >                 container_of(ops, struct i2c_hid_of_elan, ops);
> > > > >         int ret;
> > > > >
> > > > > -       ret =3D regulator_enable(ihid_elan->vcc33);
> > > > > -       if (ret)
> > > > > -               return ret;
> > > > > +       if (ihid_elan->vcc33) {
> > > > > +               ret =3D regulator_enable(ihid_elan->vcc33);
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +       }
> > > > >
> > > > >         ret =3D regulator_enable(ihid_elan->vccio);
> > > > >         if (ret) {
> > > > > @@ -52,8 +56,8 @@ static int elan_i2c_hid_power_up(struct i2chid_=
ops *ops)
> > > > >                 msleep(ihid_elan->chip_data->post_power_delay_ms)=
;
> > > > >
> > > > >         gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
> > > > > -       if (ihid_elan->chip_data->post_gpio_reset_delay_ms)
> > > > > -               msleep(ihid_elan->chip_data->post_gpio_reset_dela=
y_ms);
> > > > > +       if (ihid_elan->chip_data->post_gpio_reset_on_delay_ms)
> > > > > +               msleep(ihid_elan->chip_data->post_gpio_reset_on_d=
elay_ms);
> > > > >
> > > > >         return 0;
> > > > >  }
> > > > > @@ -64,8 +68,12 @@ static void elan_i2c_hid_power_down(struct i2c=
hid_ops *ops)
> > > > >                 container_of(ops, struct i2c_hid_of_elan, ops);
> > > > >
> > > > >         gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> > > > > +       if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
> > > > > +               msleep(ihid_elan->chip_data->post_gpio_reset_off_=
delay_ms);
> > > > > +
> > > > >         regulator_disable(ihid_elan->vccio);
> > > > > -       regulator_disable(ihid_elan->vcc33);
> > > > > +       if (ihid_elan->vcc33)
> > > > > +               regulator_disable(ihid_elan->vcc33);
> > > > >  }
> > > > >
> > > > >  static int i2c_hid_of_elan_probe(struct i2c_client *client)
> > > > > @@ -89,24 +97,42 @@ static int i2c_hid_of_elan_probe(struct i2c_c=
lient *client)
> > > > >         if (IS_ERR(ihid_elan->vccio))
> > > > >                 return PTR_ERR(ihid_elan->vccio);
> > > > >
> > > > > -       ihid_elan->vcc33 =3D devm_regulator_get(&client->dev, "vc=
c33");
> > > > > -       if (IS_ERR(ihid_elan->vcc33))
> > > > > -               return PTR_ERR(ihid_elan->vcc33);
> > > > > -
> > > > >         ihid_elan->chip_data =3D device_get_match_data(&client->d=
ev);
> > > > >
> > > > > +       if (ihid_elan->chip_data->main_supply_name) {
> > > > > +               ihid_elan->vcc33 =3D devm_regulator_get(&client->=
dev,
> > > > > +                                                     ihid_elan->=
chip_data->main_supply_name);
> > > > > +               if (IS_ERR(ihid_elan->vcc33))
> > > > > +                       return PTR_ERR(ihid_elan->vcc33);
> > > > > +       }
> > > > > +
> > > > >         return i2c_hid_core_probe(client, &ihid_elan->ops,
> > > > >                                   ihid_elan->chip_data->hid_descr=
iptor_address, 0);
> > > > >  }
> > > > >
> > > > >  static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_da=
ta =3D {
> > > > >         .post_power_delay_ms =3D 1,
> > > > > -       .post_gpio_reset_delay_ms =3D 300,
> > > > > +       .post_gpio_reset_on_delay_ms =3D 300,
> > > > > +       .hid_descriptor_address =3D 0x0001,
> > > > > +       .main_supply_name =3D "vcc33",
> > > > > +};
> > > > > +
> > > > > +static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_=
data =3D {
> > > > > +       .post_power_delay_ms =3D 1,
> > > > > +       .post_gpio_reset_on_delay_ms =3D 200,
> > > > > +       .post_gpio_reset_off_delay_ms =3D 65,
> > > > >         .hid_descriptor_address =3D 0x0001,
> > > > > +       /*
> > > > > +        * this touchscreen is tightly integrated with the panel =
and assumes
> > > > > +        * that the relevant power rails (other than the IO rail)=
 have already
> > > > > +        * been turned on by the panel driver because we're a pan=
el follower.
> > > > > +        */
> > > > > +       .main_supply_name =3D NULL,
> > > > >  };
> > > > >
> > > > >  static const struct of_device_id elan_i2c_hid_of_match[] =3D {
> > > > >         { .compatible =3D "elan,ekth6915", .data =3D &elan_ekth69=
15_chip_data },
> > > > > +       { .compatible =3D "ilitek,ili9882t", .data =3D &ilitek_il=
i9882t_chip_data },
> > > >
> > > > Logically, this patch depends on the panel-follower series that's n=
ow
> > > > landed in drm-misc-next. With your Ack, I'm willing to land these t=
wo
> > > > patches into drm-misc-next too. Other options:
> > >
> > > If you are fine with the code, I think it could go with the drm tree
> > > given that it depends on the panel-follower.
> > >
> > > Unless it's too late for you to take 6.6 material (sorry I was off in
> > > August and just came back).
> > >
> > > Acked-By: Benjamin Tissoires <bentiss@kernel.org>
> >
> > Thanks for the Ack, but yeah, it's probably too late for drm-misc.
> > Hopefully this can go through the normal tree after the next -rc1
> > then. Thanks!
>
> We don't have those strict rules in hid.git. And given that I was in
> PTO, I think it's fine if we take the patch now if it's compiling fine
> on its own and doesn't break on existing hardware. What are the
> consequences of using this patch without the panel-follower series?

I think it should be fine.

I actually tried running `make dt_binding_check
DT_SCHEMA_FILES=3Dilitek,ili9882t.yaml` with just this bindings file and
I actually _didn't_ get an error, so that's good. I guess it still
verifies OK even without commit 2ca376ef18f6 ("dt-bindings: HID:
i2c-hid: Add "panel" property to i2c-hid backed touchscreens"). I
guess the "panel: true" is enough for it to at least not complain...
;-)

So I think there's no downside to landing this in the i2c-hid tree. As
I mentioned before, this panel won't actually be functional without
the panel follower code, but once the two meetup in linuxnext we'll
end up with something that works. :-)


> Also, does it has enough reviews from the DT folks?

The bindings have Krzysztof's review and that's the important one. I
believe Krzysztof was unhappy that Cong Yang hasn't been including
version history in each individual patch, but he did provide a
reviewed by on v5 [1]

[1] https://lore.kernel.org/all/949a2d21-eb14-3ef8-a7be-9c12152cd15a@linaro=
.org/
