Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A01F7D97B5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbjJ0MT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345796AbjJ0MTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:19:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F54121;
        Fri, 27 Oct 2023 05:19:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD6EC433C9;
        Fri, 27 Oct 2023 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698409163;
        bh=NKiYgbA3r0s+9hx1fHFamy9t0uf76ZTKQZG6f+4qCnQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=puLdL/mEhrpvSvhZHNUzcPmGXn3bGdDebNi3QBIEaaS6oqMbeH3ljMAa/IFDva0mm
         XCcIhYMNd2yNZM8YdD2v0NyKKnp7Dw8vqWyYCzd3+3gvcq9LKQTFEJhK0V1AkxQtBJ
         IS7ZLHoCduzA5GHJxsCKYgevqC1BZnSr958E7e0dHdvSRE0pzM4fO+XKeJz5ENkv8j
         QjZuaFQjkZlu74r0Tmimgy+Vh6Rmm5RveY9nmQ06mqFVN/HCPeT1+JwRnvbAZHrOHn
         pbX8XFVvd4w3IoJY6PuwxgxG0D53drlCM9d1tLQ3FvpQBZHgzkEs09NKnzdKBOHVG9
         L5P1GyFyvR8bA==
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-457c134a702so751467137.1;
        Fri, 27 Oct 2023 05:19:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YzFmqozkrxM6cE8NcB4bf3Fl3T8/v9ZrauEx59Bu90Tns18JPdu
        KxD5YYkUQJMJnmgKzJAGme6key2UU50+vyuNprY=
X-Google-Smtp-Source: AGHT+IGIBVvNTFoDmJPC4Jjd8cfXxyr3m7iIcEUhOoG6TuDsbnyGjkH/909qIeCXqgKroKvi/X4sLy/RmXiBZ23So1Q=
X-Received: by 2002:a67:ab4a:0:b0:44d:3d29:4940 with SMTP id
 k10-20020a67ab4a000000b0044d3d294940mr1688008vsh.35.1698409162622; Fri, 27
 Oct 2023 05:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu> <20231023-imx214-v1-1-b33f1bbd1fcf@apitzsch.eu>
In-Reply-To: <20231023-imx214-v1-1-b33f1bbd1fcf@apitzsch.eu>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Fri, 27 Oct 2023 14:19:04 +0200
X-Gmail-Original-Message-ID: <CAPybu_3tJPuaS7P9FShQp6rrGJtbPVjS3G3UeYhAWDJsTT5s5Q@mail.gmail.com>
Message-ID: <CAPybu_3tJPuaS7P9FShQp6rrGJtbPVjS3G3UeYhAWDJsTT5s5Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: i2c: imx214: Explain some magic numbers
To:     git@apitzsch.eu
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andr=C3=A9

Thanks for your patch!

I usually do not care about creating a define for something that I use
only once... but if you think this is more clear, let it be :)



On Mon, Oct 23, 2023 at 11:49=E2=80=AFPM Andr=C3=A9 Apitzsch <git@apitzsch.=
eu> wrote:
>
> Code refinement, no functional changes.
>
> Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/i2c/imx214.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
> index 4f77ea02cc27..9218c149d4c8 100644
> --- a/drivers/media/i2c/imx214.c
> +++ b/drivers/media/i2c/imx214.c
> @@ -19,12 +19,23 @@
>  #include <media/v4l2-fwnode.h>
>  #include <media/v4l2-subdev.h>
>
> +#define IMX214_REG_MODE_SELECT         0x0100
> +#define IMX214_MODE_STANDBY            0x00
> +#define IMX214_MODE_STREAMING          0x01
> +
>  #define IMX214_DEFAULT_CLK_FREQ        24000000
>  #define IMX214_DEFAULT_LINK_FREQ 480000000
>  #define IMX214_DEFAULT_PIXEL_RATE ((IMX214_DEFAULT_LINK_FREQ * 8LL) / 10=
)
>  #define IMX214_FPS 30
>  #define IMX214_MBUS_CODE MEDIA_BUS_FMT_SRGGB10_1X10
>
> +/* Exposure control */
> +#define IMX214_REG_EXPOSURE            0x0202
> +#define IMX214_EXPOSURE_MIN            0
> +#define IMX214_EXPOSURE_MAX            3184
> +#define IMX214_EXPOSURE_STEP           1
> +#define IMX214_EXPOSURE_DEFAULT                0x0c70
> +
>  static const char * const imx214_supply_name[] =3D {
>         "vdda",
>         "vddd",
> @@ -665,7 +676,7 @@ static int imx214_set_ctrl(struct v4l2_ctrl *ctrl)
>         case V4L2_CID_EXPOSURE:
>                 vals[1] =3D ctrl->val;
>                 vals[0] =3D ctrl->val >> 8;
> -               ret =3D regmap_bulk_write(imx214->regmap, 0x202, vals, 2)=
;
> +               ret =3D regmap_bulk_write(imx214->regmap, IMX214_REG_EXPO=
SURE, vals, 2);
>                 if (ret < 0)
>                         dev_err(imx214->dev, "Error %d\n", ret);
>                 ret =3D 0;
> @@ -743,7 +754,7 @@ static int imx214_start_streaming(struct imx214 *imx2=
14)
>                 dev_err(imx214->dev, "could not sync v4l2 controls\n");
>                 goto error;
>         }
> -       ret =3D regmap_write(imx214->regmap, 0x100, 1);
> +       ret =3D regmap_write(imx214->regmap, IMX214_REG_MODE_SELECT, IMX2=
14_MODE_STREAMING);
>         if (ret < 0) {
>                 dev_err(imx214->dev, "could not sent start table %d\n", r=
et);
>                 goto error;
> @@ -761,7 +772,7 @@ static int imx214_stop_streaming(struct imx214 *imx21=
4)
>  {
>         int ret;
>
> -       ret =3D regmap_write(imx214->regmap, 0x100, 0);
> +       ret =3D regmap_write(imx214->regmap, IMX214_REG_MODE_SELECT, IMX2=
14_MODE_STANDBY);
>         if (ret < 0)
>                 dev_err(imx214->dev, "could not sent stop table %d\n",  r=
et);
>
> @@ -991,9 +1002,12 @@ static int imx214_probe(struct i2c_client *client)
>          *
>          * Yours sincerely, Ricardo.
>          */
> -       imx214->exposure =3D v4l2_ctrl_new_std(&imx214->ctrls, &imx214_ct=
rl_ops,
> +       imx214->exposure =3D v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_op=
s,
>                                              V4L2_CID_EXPOSURE,
> -                                            0, 3184, 1, 0x0c70);
> +                                            IMX214_EXPOSURE_MIN,
> +                                            IMX214_EXPOSURE_MAX,
> +                                            IMX214_EXPOSURE_STEP,
> +                                            IMX214_EXPOSURE_DEFAULT);
>
>         imx214->unit_size =3D v4l2_ctrl_new_std_compound(&imx214->ctrls,
>                                 NULL,
>
> --
> 2.42.0
>
