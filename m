Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2278C7B4368
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 21:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjI3Twi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 15:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3Twh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 15:52:37 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95004A6;
        Sat, 30 Sep 2023 12:52:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c00df105f8so243844191fa.2;
        Sat, 30 Sep 2023 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696103553; x=1696708353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gulyGIXjLYQG5fTcN0xgpbM4Og56pP+pCYT2R905Snc=;
        b=UbTq56WG76bvVoeZeiP2kikjx4g4EYTfYXxLWPGyGy6dMgcrLEsHYpXZM3IQfP4XJW
         P5U9VXt9Lm9KbJnTpEInb/b5Wl2/zH9MUHLf2znF7N4szu0Z5xklDW89fgXN0MnZRURC
         uLAuhjrzW7PaIziFv01mXI35L7jMjyXt9l9+MSwuiqdabetR7EqqxshyqrtTB20tQBXX
         sv0vPlX40B3PS1XWf9SYsmFk/DlWjtjKMQynaFzgglCVN7yRaFZFBmfG6D9qhbR80V2F
         F2mV3bzfACKzduEy2JKHxwB+yzA3EOE4augSLTpioDshboIlbzgj+cYF0tm/H/wI2pXS
         fdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696103553; x=1696708353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gulyGIXjLYQG5fTcN0xgpbM4Og56pP+pCYT2R905Snc=;
        b=Uy3mQX+YFY36B1Dfexky4eklKGXu8FLe0zSC4aHuK5pUZzBFQGMkj1qgDYye0VXpyX
         OfpMNdx02vxMi/slifWUxZhzgklnKUrlj37W6y8UXV5/go0mE5jNDTYn54T24lj6pMyg
         TMLD5NP7YUFXAI+auXj4c5V1Zp40eMqJ/ChjO+ab52kE2wAt2Bllxe0EWzkMHUmvzV9Y
         tepaYJEMvJFaPOINqH/zmg2J3xjpC68AdrxsPV8eUxXdRs85Rn/ZVsQfqYfUS/FDSjYP
         OgY9RHTDgz+ZG4oW0mjwvrXJZEqpN7is9zLjefzUQSaurc4NqSWQW4BCzX3Jmors00s2
         /Hcg==
X-Gm-Message-State: AOJu0Yw9DnnM13k6Ywt7ftynEKYyNLRjD66X0LUpgUcNYa+1DqQomcoC
        lj6J7fjLwOcJYS7TasIjIPsQFGTvN7XQHuyjh/k=
X-Google-Smtp-Source: AGHT+IEaMPC01Ya1H/hUFmMrlnvqg4jC+0oiBuhGtRUDKXh0r2CiVLyJoMnI9/pu+5Y3RA8MeJJ5TKQBaAVJYUbsGMY=
X-Received: by 2002:a2e:9946:0:b0:2c0:a99:68dd with SMTP id
 r6-20020a2e9946000000b002c00a9968ddmr6497583ljj.4.1696103552510; Sat, 30 Sep
 2023 12:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230924141547.11597-1-tinozzo123@gmail.com>
In-Reply-To: <20230924141547.11597-1-tinozzo123@gmail.com>
From:   Daniel Ogorchock <djogorchock@gmail.com>
Date:   Sat, 30 Sep 2023 15:52:21 -0400
Message-ID: <CAEVj2tm0t_kb93736c1h0BttB9YHHRbos4n+cFRp-zQ0meWmqQ@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND] HID: nintendo: cleanup LED code
To:     Martino Fontana <tinozzo123@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martino,

On Sun, Sep 24, 2023 at 10:16=E2=80=AFAM Martino Fontana <tinozzo123@gmail.=
com> wrote:
>
> - Support player LED patterns up to 8 players.
>   (Note that the behavior still consinsts in increasing the player number
>   every time a controller is connected, never decreasing it. It should be
>   as is described in https://bugzilla.kernel.org/show_bug.cgi?id=3D216225=
.
>   However, any implementation here would stop making sense as soon as a
>   non-Nintendo controller is connected, which is why I'm not bothering.)
>
> - Split part of `joycon_home_led_brightness_set` (which is called by hid)
>   into `joycon_set_home_led` (which is what actually sets the LEDs), for
>   consistency with player LEDs.
>
> - `joycon_player_led_brightness_set` won't try it to "determine which
>   player led this is" anymore: it's already looking at every LED
>   brightness value.
>
> - Instead of first registering the `led_classdev`, then attempting to set
>   the LED and unregistering the `led_classdev` if it fails, first attempt
>   to set the LED, then register the `led_classdev` only if it succeeds
>   (the class is still filled up in either case).
>
> - If setting the player LEDs fails, still attempt setting the home LED.
>   (I don't know there's a third party controller where this may actually
>   happen, but who knows...)
>
> - Use `JC_NUM_LEDS` where appropriate instead of 4.
>
> - Print return codes in more places.
>
> - Use spinlock instead of mutex for `input_num`. Copy its value to a loca=
l
>   variable, so that it can be unlocked immediately.
>
> - `input_num` starts counting from 0
>
> - Less holding of mutexes in general.
>
> Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
> ---
> Changes for v2:
>
> Applied suggestions, commit message explains more stuff, restored `return=
 ret`
> when `devm_led_classdev_register` fails (since all other hid drivers do t=
his).
> If setting LED fails, `hid_warn` now explicitly says "skipping registrati=
on".
>
> Changes for v3 and v4:
>
> Fixed errors and warnings from test robot.
>
> Changes for v5:
>
> I thought that when connecting the controller on an actual Nintendo Switc=
h,
> only the nth player LED would turn on, which is true... on Wii and Wii U.
> So I reverted that, and to compensate, now this supports the LED patterns
> up to 8 players.
>
>  drivers/hid/hid-nintendo.c | 133 +++++++++++++++++++++----------------
>  1 file changed, 76 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 10468f727..138f154fe 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -410,6 +410,18 @@ static const char * const joycon_player_led_names[] =
=3D {
>         LED_FUNCTION_PLAYER4,
>  };
>  #define JC_NUM_LEDS            ARRAY_SIZE(joycon_player_led_names)
> +#define JC_NUM_LED_PATTERNS 8
> +/* Taken from https://www.nintendo.com/my/support/qa/detail/33822 */
> +static const enum led_brightness joycon_player_led_patterns[JC_NUM_LED_P=
ATTERNS][JC_NUM_LEDS] =3D {
> +       { 1, 0, 0, 0 },
> +       { 1, 1, 0, 0 },
> +       { 1, 1, 1, 0 },
> +       { 1, 1, 1, 1 },
> +       { 1, 0, 0, 1 },
> +       { 1, 0, 1, 0 },
> +       { 1, 0, 1, 1 },
> +       { 0, 1, 1, 0 },
> +};
>
>  /* Each physical controller is associated with a joycon_ctlr struct */
>  struct joycon_ctlr {
> @@ -699,6 +711,25 @@ static int joycon_set_player_leds(struct joycon_ctlr=
 *ctlr, u8 flash, u8 on)
>         return joycon_send_subcmd(ctlr, req, 1, HZ/4);
>  }
>
> +static int joycon_set_home_led(struct joycon_ctlr *ctlr, enum led_bright=
ness brightness)
> +{
> +       struct joycon_subcmd_request *req;
> +       u8 buffer[sizeof(*req) + 5] =3D { 0 };
> +       u8 *data;
> +
> +       req =3D (struct joycon_subcmd_request *)buffer;
> +       req->subcmd_id =3D JC_SUBCMD_SET_HOME_LIGHT;
> +       data =3D req->data;
> +       data[0] =3D 0x01;
> +       data[1] =3D brightness << 4;
> +       data[2] =3D brightness | (brightness << 4);
> +       data[3] =3D 0x11;
> +       data[4] =3D 0x11;
> +
> +       hid_dbg(ctlr->hdev, "setting home led brightness\n");
> +       return joycon_send_subcmd(ctlr, req, 5, HZ/4);
> +}
> +
>  static int joycon_request_spi_flash_read(struct joycon_ctlr *ctlr,
>                                          u32 start_addr, u8 size, u8 **re=
ply)
>  {
> @@ -1840,6 +1871,7 @@ static int joycon_input_create(struct joycon_ctlr *=
ctlr)
>         return 0;
>  }
>
> +/* Because the subcommand sets all the leds at once, the brightness argu=
ment is ignored */
>  static int joycon_player_led_brightness_set(struct led_classdev *led,
>                                             enum led_brightness brightnes=
s)
>  {
> @@ -1849,7 +1881,6 @@ static int joycon_player_led_brightness_set(struct =
led_classdev *led,
>         int val =3D 0;
>         int i;
>         int ret;
> -       int num;
>
>         ctlr =3D hid_get_drvdata(hdev);
>         if (!ctlr) {
> @@ -1857,21 +1888,10 @@ static int joycon_player_led_brightness_set(struc=
t led_classdev *led,
>                 return -ENODEV;
>         }
>
> -       /* determine which player led this is */
> -       for (num =3D 0; num < JC_NUM_LEDS; num++) {
> -               if (&ctlr->leds[num] =3D=3D led)
> -                       break;
> -       }
> -       if (num >=3D JC_NUM_LEDS)
> -               return -EINVAL;
> +       for (i =3D 0; i < JC_NUM_LEDS; i++)
> +               val |=3D ctlr->leds[i].brightness << i;
>
>         mutex_lock(&ctlr->output_mutex);
> -       for (i =3D 0; i < JC_NUM_LEDS; i++) {
> -               if (i =3D=3D num)
> -                       val |=3D brightness << i;
> -               else
> -                       val |=3D ctlr->leds[i].brightness << i;
> -       }
>         ret =3D joycon_set_player_leds(ctlr, 0, val);
>         mutex_unlock(&ctlr->output_mutex);
>
> @@ -1884,9 +1904,6 @@ static int joycon_home_led_brightness_set(struct le=
d_classdev *led,
>         struct device *dev =3D led->dev->parent;
>         struct hid_device *hdev =3D to_hid_device(dev);
>         struct joycon_ctlr *ctlr;
> -       struct joycon_subcmd_request *req;
> -       u8 buffer[sizeof(*req) + 5] =3D { 0 };
> -       u8 *data;
>         int ret;
>
>         ctlr =3D hid_get_drvdata(hdev);
> @@ -1894,43 +1911,35 @@ static int joycon_home_led_brightness_set(struct =
led_classdev *led,
>                 hid_err(hdev, "No controller data\n");
>                 return -ENODEV;
>         }
> -
> -       req =3D (struct joycon_subcmd_request *)buffer;
> -       req->subcmd_id =3D JC_SUBCMD_SET_HOME_LIGHT;
> -       data =3D req->data;
> -       data[0] =3D 0x01;
> -       data[1] =3D brightness << 4;
> -       data[2] =3D brightness | (brightness << 4);
> -       data[3] =3D 0x11;
> -       data[4] =3D 0x11;
> -
> -       hid_dbg(hdev, "setting home led brightness\n");
>         mutex_lock(&ctlr->output_mutex);
> -       ret =3D joycon_send_subcmd(ctlr, req, 5, HZ/4);
> +       ret =3D joycon_set_home_led(ctlr, brightness);
>         mutex_unlock(&ctlr->output_mutex);
> -
>         return ret;
>  }
>
> -static DEFINE_MUTEX(joycon_input_num_mutex);
> +static DEFINE_SPINLOCK(joycon_input_num_spinlock);
>  static int joycon_leds_create(struct joycon_ctlr *ctlr)
>  {
>         struct hid_device *hdev =3D ctlr->hdev;
>         struct device *dev =3D &hdev->dev;
>         const char *d_name =3D dev_name(dev);
>         struct led_classdev *led;
> +       int led_val =3D 0;
>         char *name;
> -       int ret =3D 0;
> +       int ret;
>         int i;
> -       static int input_num =3D 1;
> +       unsigned long flags;
> +       int player_led_pattern;
> +       static int input_num;
>
> -       /* Set the default controller player leds based on controller num=
ber */
> -       mutex_lock(&joycon_input_num_mutex);
> -       mutex_lock(&ctlr->output_mutex);
> -       ret =3D joycon_set_player_leds(ctlr, 0, 0xF >> (4 - input_num));
> -       if (ret)
> -               hid_warn(ctlr->hdev, "Failed to set leds; ret=3D%d\n", re=
t);
> -       mutex_unlock(&ctlr->output_mutex);
> +       /*
> +        * Set the player leds based on controller number
> +        * Because there is no standard concept of "player number", the p=
attern
> +        * number will simply increase by 1 every time a controller is co=
nnected.
> +        */
> +       spin_lock_irqsave(&joycon_input_num_spinlock, flags);
> +       player_led_pattern =3D input_num++ % JC_NUM_LED_PATTERNS;
> +       spin_unlock_irqrestore(&joycon_input_num_spinlock, flags);
>
>         /* configure the player LEDs */
>         for (i =3D 0; i < JC_NUM_LEDS; i++) {
> @@ -1938,31 +1947,37 @@ static int joycon_leds_create(struct joycon_ctlr =
*ctlr)
>                                       d_name,
>                                       "green",
>                                       joycon_player_led_names[i]);
> -               if (!name) {
> -                       mutex_unlock(&joycon_input_num_mutex);
> +               if (!name)
>                         return -ENOMEM;
> -               }
>
>                 led =3D &ctlr->leds[i];
>                 led->name =3D name;
> -               led->brightness =3D ((i + 1) <=3D input_num) ? 1 : 0;
> +               led->brightness =3D joycon_player_led_patterns[player_led=
_pattern][i];
>                 led->max_brightness =3D 1;
>                 led->brightness_set_blocking =3D
>                                         joycon_player_led_brightness_set;
>                 led->flags =3D LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
>
> +               led_val |=3D joycon_player_led_patterns[player_led_patter=
n][i] << i;
> +       }
> +       mutex_lock(&ctlr->output_mutex);
> +       ret =3D joycon_set_player_leds(ctlr, 0, led_val);
> +       mutex_unlock(&ctlr->output_mutex);
> +       if (ret) {
> +               hid_warn(hdev, "Failed to set players LEDs, skipping regi=
stration; ret=3D%d\n", ret);
> +               goto home_led;
> +       }
> +
> +       for (i =3D 0; i < JC_NUM_LEDS; i++) {
> +               led =3D &ctlr->leds[i];
>                 ret =3D devm_led_classdev_register(&hdev->dev, led);
>                 if (ret) {
> -                       hid_err(hdev, "Failed registering %s LED\n", led-=
>name);
> -                       mutex_unlock(&joycon_input_num_mutex);
> +                       hid_err(hdev, "Failed to register player %d LED; =
ret=3D%d\n", i + 1, ret);
>                         return ret;
>                 }
>         }
>
> -       if (++input_num > 4)
> -               input_num =3D 1;
> -       mutex_unlock(&joycon_input_num_mutex);
> -
> +home_led:
>         /* configure the home LED */
>         if (jc_type_has_right(ctlr)) {
>                 name =3D devm_kasprintf(dev, GFP_KERNEL, "%s:%s:%s",
> @@ -1978,16 +1993,20 @@ static int joycon_leds_create(struct joycon_ctlr =
*ctlr)
>                 led->max_brightness =3D 0xF;
>                 led->brightness_set_blocking =3D joycon_home_led_brightne=
ss_set;
>                 led->flags =3D LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
> -               ret =3D devm_led_classdev_register(&hdev->dev, led);
> +
> +               /* Set the home LED to 0 as default state */
> +               mutex_lock(&ctlr->output_mutex);
> +               ret =3D joycon_set_home_led(ctlr, 0);
> +               mutex_unlock(&ctlr->output_mutex);
>                 if (ret) {
> -                       hid_err(hdev, "Failed registering home led\n");
> -                       return ret;
> +                       hid_warn(hdev, "Failed to set home LED, skipping =
registration; ret=3D%d\n", ret);
> +                       return 0;
>                 }
> -               /* Set the home LED to 0 as default state */
> -               ret =3D joycon_home_led_brightness_set(led, 0);
> +
> +               ret =3D devm_led_classdev_register(&hdev->dev, led);
>                 if (ret) {
> -                       hid_warn(hdev, "Failed to set home LED default, u=
nregistering home LED");
> -                       devm_led_classdev_unregister(&hdev->dev, led);
> +                       hid_err(hdev, "Failed to register home LED; ret=
=3D%d\n", ret);
> +                       return ret;
>                 }
>         }
>
> --
> 2.42.0
>

This looks good to me. Thanks for the patch.

Reviewed-by: Daniel J. Ogorchock <djogorchock@gmail.com>
