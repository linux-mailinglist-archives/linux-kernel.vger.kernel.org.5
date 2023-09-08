Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA898798016
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbjIHBWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbjIHBWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:22:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559B019A7;
        Thu,  7 Sep 2023 18:22:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b962c226ceso26343001fa.3;
        Thu, 07 Sep 2023 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694136146; x=1694740946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4IDcX2OMI5MDBK89jBNfGWaJOAa9+Z+WILcgNSnMsg=;
        b=l+DdjUEDeWLuKGZJMqULiBfGJ1yuo+4GrbT+Y/e5yhm+8Wr4lEZJ4xUy+FuXuVA93t
         uvNx7djgBJtMLYKOJiYqGYdWVbK+62dMtIcG+y+234o+ObpoMDqVzc4D1UXuql04u2Pg
         kLdyRR5Yr24d8td3Fb3KYBKXA6lOBInlJVuixlDcN5MXpdBELsNGDMCSajlK+1pAauOz
         29eKQXmVRM2QelPHPSj+ZEWDSUfSrom2N7d7pW5lWsZPDudlzSJjY2maXlTwlJh7TFg2
         yJmallcxqaf5HtGza2Vulm3x0z9+XAHhCR/uVKLOm5GF+7o7saZzimw61BUg52MgxYFD
         badg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694136146; x=1694740946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4IDcX2OMI5MDBK89jBNfGWaJOAa9+Z+WILcgNSnMsg=;
        b=ny/ikvDBVg+G0wEpxPuhgetiFhKJTkf0zFKw/9RKRVfM/suLy5Npnjx7dI0UfEcSHk
         pbZHR1g+sb+23AgeeNNqHxD/aohx89ZseAIlZ19uC223pldnYDnG0WMQU/Q7+M4fUz8d
         uJ99DdTrelG3TjnyELvhvxvZ+17nSr5gYwlVZtW9YBa+TyYLQiNAhe8ednZuChWzwit4
         rVCurAf3r3uOKgFcPX4xEgO56pz76ghTWYEkKE8B2FRzyTx19Byxw1GxCvXisgpjr3WV
         2+HZMoE3GudzGW90BwVMC5DKQi+IH+qETJp5kgWG6CKuLOxymq31xXTMTup2yG+iBBDp
         D7ig==
X-Gm-Message-State: AOJu0YyaXrzFBDdu11m6sqlRQUktNwEQoRzZMduwpFDg9E5cYwMi7ws0
        2vZ4qfCSJ8gUEydWHaWNpQnhPj0wYjE5bTjk9WI=
X-Google-Smtp-Source: AGHT+IE8dJLtSqf6IhcaOndRf57+z9fR9PkCgMraz0LBFsJN1IpOmpipdlLFQ9DsKYrtd40SbB6lxqaY2tnZIA86F9s=
X-Received: by 2002:a2e:88c6:0:b0:2bc:d38e:b500 with SMTP id
 a6-20020a2e88c6000000b002bcd38eb500mr553931ljk.42.1694136146245; Thu, 07 Sep
 2023 18:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230907094926.8278-1-tinozzo123@gmail.com>
In-Reply-To: <20230907094926.8278-1-tinozzo123@gmail.com>
From:   Daniel Ogorchock <djogorchock@gmail.com>
Date:   Thu, 7 Sep 2023 21:22:15 -0400
Message-ID: <CAEVj2tnNm-Ucq0R7D5-eA0yTpD6h+TUpTFUwJttnoFpDDSPaZQ@mail.gmail.com>
Subject: Re: [PATCH v4] HID: nintendo: cleanup LED code
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

On Thu, Sep 7, 2023 at 5:51=E2=80=AFAM Martino Fontana <tinozzo123@gmail.co=
m> wrote:
>
> - Only turn on the nth LED, instead of all the LEDs up to n. This better
>   matches Nintendo consoles' behaviour, as they never turn on more than
>   one LED.
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
> - `joycon_player_led_brightness_set` won't try it to "determine which pla=
yer
>   led this is" anymore: it's already looking at every LED brightness valu=
e.
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
> Signed-off-by: Martino Fontana <tinozzo123@gmail.com>

Hi Martino,

This cleanup looks pretty good to me.

Regarding the player LED setting though, I'm pretty sure the driver's
existing behavior matches that of an actual Switch console (at least
for the first 4 players).

1 LED lights up for P1, 2 for P2, etc.
See the nintendo documentation here:
https://www.nintendo.com/my/support/qa/detail/33822

Thanks,
Daniel

> ---
>  drivers/hid/hid-nintendo.c | 113 ++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index a5ebe857a..543098a8c 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -699,6 +699,25 @@ static int joycon_set_player_leds(struct joycon_ctlr=
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
> @@ -1849,7 +1868,6 @@ static int joycon_player_led_brightness_set(struct =
led_classdev *led,
>         int val =3D 0;
>         int i;
>         int ret;
> -       int num;
>
>         ctlr =3D hid_get_drvdata(hdev);
>         if (!ctlr) {
> @@ -1857,21 +1875,10 @@ static int joycon_player_led_brightness_set(struc=
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
> @@ -1884,9 +1891,6 @@ static int joycon_home_led_brightness_set(struct le=
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
> @@ -1894,25 +1898,13 @@ static int joycon_home_led_brightness_set(struct =
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
> @@ -1920,17 +1912,16 @@ static int joycon_leds_create(struct joycon_ctlr =
*ctlr)
>         const char *d_name =3D dev_name(dev);
>         struct led_classdev *led;
>         char *name;
> -       int ret =3D 0;
> +       int ret;
>         int i;
> -       static int input_num =3D 1;
> +       unsigned long flags;
> +       int player_led_number;
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
> +       /* Set the player leds based on controller number */
> +       spin_lock_irqsave(&joycon_input_num_spinlock, flags);
> +       player_led_number =3D input_num++ % JC_NUM_LEDS;
> +       spin_unlock_irqrestore(&joycon_input_num_spinlock, flags);
>
>         /* configure the player LEDs */
>         for (i =3D 0; i < JC_NUM_LEDS; i++) {
> @@ -1938,31 +1929,35 @@ static int joycon_leds_create(struct joycon_ctlr =
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
> +               led->brightness =3D (i =3D=3D player_led_number) ? 1 : 0;
>                 led->max_brightness =3D 1;
>                 led->brightness_set_blocking =3D
>                                         joycon_player_led_brightness_set;
>                 led->flags =3D LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
> +       }
> +       mutex_lock(&ctlr->output_mutex);
> +       ret =3D joycon_set_player_leds(ctlr, 0, 0x1 << player_led_number)=
;
> +       mutex_unlock(&ctlr->output_mutex);
> +       if (ret) {
> +               hid_warn(hdev, "Failed to set players LEDs, skipping regi=
stration; ret=3D%d\n", ret);
> +               goto home_led;
> +       }
>
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
> @@ -1978,16 +1973,20 @@ static int joycon_leds_create(struct joycon_ctlr =
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
> 2.41.0
>


--=20
Daniel Ogorchock
