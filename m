Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BCB76D357
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjHBQJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjHBQJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:09:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522231BC7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:09:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so12457a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690992571; x=1691597371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=113LkHbiEvGKznTlJsnRhaby8358mc5nh2oXLk1USVI=;
        b=LFI4rA25jijMEPPHKR1SNDWldDm9/ygIcRMZrWrVr1goHUdEBej5dsgYlHAgjNaIpt
         G6i7UXK1qtDX0AXOIqH8oAFj+etZ8ynHGKA1iL5FcdbVW3JmuA8yAdP+8vIm3vtSqlTn
         Z12jz848KVJgEvqEziKjAeA9r7LZeTvRh+7HUSAwqDvrQE2oT0eRulC/lrXJE02B53Q9
         VDdPSysD7uX8gGuhLN+DZ+1/FBGu16lB/9Op85GjijDGRcBxDrWWW9NzwWDfhcaYUWK7
         Er5mVbB+pWBLkIAVj7/JyLtOWmly2Y1VVVwmOHMGrwta4c918Y5NqyMlOtDI5Had2jjY
         zB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690992571; x=1691597371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=113LkHbiEvGKznTlJsnRhaby8358mc5nh2oXLk1USVI=;
        b=XTTICQiyLZFYoa72NiHm199SIw7qI7oGu3DqovRrCpywoRlkvK7+R6U2eBRoQCU4SG
         FnyKJqVBmL7SjJhMb+ndYh/4CoNIF/J84qwfyc/NnUYEHxPH+dMVkUzUjiU45UZY7vk9
         wH+MTsqUTsqON9XwmpgOGWsy88lD6hzTqhQOm3C8ZBimxRW/MlYTIYju0xIpfBr3vRg+
         AQahnE/EIh6Hr2xc6p4EiGF3SLP6VQiFssnAdF/kzB1wETyj4uUFsPu5CTgwqPIXJIOQ
         VKsWD1voegvsWsGMDwuTnwIZarf3KAwBvsiUuAjxdHcGA+4EwJPrAs5E+f64hAFrGtZU
         Q+Cg==
X-Gm-Message-State: ABy/qLbZ1FIVC/kILzxFCmvjIdFUl7jhOr0RWyYislNOtgeXBi4o9lb6
        PFU0JWvxm2kW1WBUfhyjh01Ytnl8v6b1Dbwzx4Ao8Q==
X-Google-Smtp-Source: APBJJlHNSzA+5I+gfFhTC6voqAyJr4aPx2EGDbMFMgCoqcQFETjIFolABaZwMqpX4c04GauX4srYr78Fa/uKx9yPFTQ=
X-Received: by 2002:a50:8ac1:0:b0:51a:1ffd:10e with SMTP id
 k1-20020a508ac1000000b0051a1ffd010emr436939edk.3.1690992570625; Wed, 02 Aug
 2023 09:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
 <20230802071947.1683318-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230802071947.1683318-3-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Wed, 2 Aug 2023 09:09:18 -0700
Message-ID: <CAD=FV=Um8875aMt_kWvCvpNjb3EwSk8VjVTEgv_TJ9WDS+LniA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] HID: i2c-hid: elan: Add ili9882t timing
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        benjamin.tissoires@redhat.com,
        Benjamin Tissoires <bentiss@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        hsinyi@google.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin,

On Wed, Aug 2, 2023 at 12:20=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The ili9882t is a TDDI IC (Touch with Display Driver). The
> datasheet specifies there should be 60ms between touch SDA
> sleep and panel RESX. Doug's series[1] allows panels and
> touchscreens to power on/off together, so we can add the 65 ms
> delay in i2c_hid_core_suspend before panel_unprepare.
>
> Because ili9882t touchscrgeen is a panel follower, and
> needs to use vccio-supply instead of vcc33-supply, so set
> it NULL to ili9882t_chip_data, then not use vcc33 regulator.
>
> [1]: https://lore.kernel.org/all/20230727171750.633410-1-dianders@chromiu=
m.org
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 50 ++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 12 deletions(-)


>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/=
i2c-hid-of-elan.c
> index 029045d9661c..31abab57ad44 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> @@ -18,9 +18,11 @@
>  #include "i2c-hid.h"
>
>  struct elan_i2c_hid_chip_data {
> -       unsigned int post_gpio_reset_delay_ms;
> +       unsigned int post_gpio_reset_on_delay_ms;
> +       unsigned int post_gpio_reset_off_delay_ms;
>         unsigned int post_power_delay_ms;
>         u16 hid_descriptor_address;
> +       const char *main_supply_name;
>  };
>
>  struct i2c_hid_of_elan {
> @@ -38,9 +40,11 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *op=
s)
>                 container_of(ops, struct i2c_hid_of_elan, ops);
>         int ret;
>
> -       ret =3D regulator_enable(ihid_elan->vcc33);
> -       if (ret)
> -               return ret;
> +       if (ihid_elan->vcc33) {
> +               ret =3D regulator_enable(ihid_elan->vcc33);
> +               if (ret)
> +                       return ret;
> +       }
>
>         ret =3D regulator_enable(ihid_elan->vccio);
>         if (ret) {
> @@ -52,8 +56,8 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *ops=
)
>                 msleep(ihid_elan->chip_data->post_power_delay_ms);
>
>         gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
> -       if (ihid_elan->chip_data->post_gpio_reset_delay_ms)
> -               msleep(ihid_elan->chip_data->post_gpio_reset_delay_ms);
> +       if (ihid_elan->chip_data->post_gpio_reset_on_delay_ms)
> +               msleep(ihid_elan->chip_data->post_gpio_reset_on_delay_ms)=
;
>
>         return 0;
>  }
> @@ -64,8 +68,12 @@ static void elan_i2c_hid_power_down(struct i2chid_ops =
*ops)
>                 container_of(ops, struct i2c_hid_of_elan, ops);
>
>         gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> +       if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
> +               msleep(ihid_elan->chip_data->post_gpio_reset_off_delay_ms=
);
> +
>         regulator_disable(ihid_elan->vccio);
> -       regulator_disable(ihid_elan->vcc33);
> +       if (ihid_elan->vcc33)
> +               regulator_disable(ihid_elan->vcc33);
>  }
>
>  static int i2c_hid_of_elan_probe(struct i2c_client *client)
> @@ -89,24 +97,42 @@ static int i2c_hid_of_elan_probe(struct i2c_client *c=
lient)
>         if (IS_ERR(ihid_elan->vccio))
>                 return PTR_ERR(ihid_elan->vccio);
>
> -       ihid_elan->vcc33 =3D devm_regulator_get(&client->dev, "vcc33");
> -       if (IS_ERR(ihid_elan->vcc33))
> -               return PTR_ERR(ihid_elan->vcc33);
> -
>         ihid_elan->chip_data =3D device_get_match_data(&client->dev);
>
> +       if (ihid_elan->chip_data->main_supply_name) {
> +               ihid_elan->vcc33 =3D devm_regulator_get(&client->dev,
> +                                                     ihid_elan->chip_dat=
a->main_supply_name);
> +               if (IS_ERR(ihid_elan->vcc33))
> +                       return PTR_ERR(ihid_elan->vcc33);
> +       }
> +
>         return i2c_hid_core_probe(client, &ihid_elan->ops,
>                                   ihid_elan->chip_data->hid_descriptor_ad=
dress, 0);
>  }
>
>  static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_data =3D {
>         .post_power_delay_ms =3D 1,
> -       .post_gpio_reset_delay_ms =3D 300,
> +       .post_gpio_reset_on_delay_ms =3D 300,
> +       .hid_descriptor_address =3D 0x0001,
> +       .main_supply_name =3D "vcc33",
> +};
> +
> +static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data =3D=
 {
> +       .post_power_delay_ms =3D 1,
> +       .post_gpio_reset_on_delay_ms =3D 200,
> +       .post_gpio_reset_off_delay_ms =3D 65,
>         .hid_descriptor_address =3D 0x0001,
> +       /*
> +        * this touchscreen is tightly integrated with the panel and assu=
mes
> +        * that the relevant power rails (other than the IO rail) have al=
ready
> +        * been turned on by the panel driver because we're a panel follo=
wer.
> +        */
> +       .main_supply_name =3D NULL,
>  };
>
>  static const struct of_device_id elan_i2c_hid_of_match[] =3D {
>         { .compatible =3D "elan,ekth6915", .data =3D &elan_ekth6915_chip_=
data },
> +       { .compatible =3D "ilitek,ili9882t", .data =3D &ilitek_ili9882t_c=
hip_data },

Logically, this patch depends on the panel-follower series that's now
landed in drm-misc-next. With your Ack, I'm willing to land these two
patches into drm-misc-next too. Other options:

a) We could land the two patches in the i2c-hid tree since they don't
appear to conflict. The touchscreen won't actually function until the
patches meetup in linux-next but I don't think they'll give any
compile errors (I haven't double-checked that, but I can). ...though
it's possible that the dt bindings might generate errors? Again, I can
investigate if we want to go this way.

b) We can snooze this for a few months and you can pick it to i2c-hid
when my series reaches mainline.

Let me know how you'd like to proceed.

-Doug
