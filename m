Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFFB7D0149
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346398AbjJSSVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbjJSSVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:21:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABA712A;
        Thu, 19 Oct 2023 11:21:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b95622c620so2432166b.0;
        Thu, 19 Oct 2023 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697739699; x=1698344499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6ChytOvOHSvApPA10oZhEcP/0JgPMv0U+va/XQPN/I=;
        b=TAoIOJbfY9f0MSk4rDqfpM5o22ZZr9ClnuOpH27qgMPUXRzKGzylvHwvUX61zWgdgA
         HpGljrbEpXF47slWwP/K8XBlxaR5VYxNLAiaWsCJ2cutGrhdhjqrZaIeTCFFMFmOkRpp
         mi3ppEVJSOoaDC99NVJGHByauNHutV7CqWWL1GGDQ1ixpdPclRHOIw9vPCCjI2M9Bbld
         kY8IFeJhptiweNRWWsC1v61OLSp5sgghU51IEgMs9qv0jHLJSz3bPNdex0lN26GkDqtY
         E7nFbauMfc4k14cFxtAzXq0IVVRHNHd+pQTjpaYVQAUO9cuX17509bhW7vupTj285Gmc
         n3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739699; x=1698344499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6ChytOvOHSvApPA10oZhEcP/0JgPMv0U+va/XQPN/I=;
        b=o2CHh8nCXZeLt4kVFrVt0NprJ8GVNYDQ1WhA3+uenQPwxiEIkLhpZVhnX3cYXhMGGc
         9fBEHy4W/RI/Y2525An3Fn5eR0Xl61DY5NcFuQXAxilitYBjMvT+QKXSCsJeL4k3b4/x
         JoxSWW46a939H8g43UbzGSoP4LtppY5gQqq/Vi5ruBR0KfrjUQ3pBKFkYNofIzWYozDG
         6NOEBdMbqdMsU9m4m4U0/I+VQnoLBQEUWqMqkJ6Lwm9GvdNNWEVV+MncAIZDTqe8WXYw
         qaKvYMi19HUnz8zUdhEM34/dS1loMv0zLqvcC8WqWNc+C9zHe0RLg3VuJR45EHj0e9U/
         IOCw==
X-Gm-Message-State: AOJu0YzJ0WbWasEb9oizBfIgN+XpsMqBAk/+fv408MdoqEfOZ4LKTgMU
        oSKJqHZfsQjotfJniQRviGuEM8mlvpCGatLivl4O0W8YVXA=
X-Google-Smtp-Source: AGHT+IGPy+2NGA4piGc9nGNaki1VKwUL6BWmW3JjGx9kyj/GPH7rKau/mmskiWQzT1zypgBA7yToxBHkQvs085xxeOA=
X-Received: by 2002:a17:906:c155:b0:9bd:d8d6:c1ad with SMTP id
 dp21-20020a170906c15500b009bdd8d6c1admr2399045ejc.61.1697739698858; Thu, 19
 Oct 2023 11:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <ZTEt7NqfDHPOkm8j@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
In-Reply-To: <ZTEt7NqfDHPOkm8j@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Thu, 19 Oct 2023 23:51:27 +0530
Message-ID: <CAM+2Eu+ndzS9NLvsZaX_=YTHb_+t4cE5GjQevJ1Lgc2EBO20rA@mail.gmail.com>
Subject: Re: [PATCH] iio: kx022a: Fix acceleration value scaling
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Thu, Oct 19, 2023 at 6:54=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> The IIO ABI mandates acceleration values from accelerometer to be
> emitted in m/s^2. The KX022A was emitting values in micro m/s^2.
>
> Fix driver to report the correct scale values.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reported-by: Jagath Jog J <jagathjog1996@gmail.com>
> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A acceleromete=
r")
>
> ---
> The fix is somewhat crude and just crops the last 3 digits (rounds) of th=
e
> scale while using IIO_VAL_INT_PLUS_NANO. I played with a thought of using
> IIO_VAL_FRACTIONAL, which could have modelled the computation
> G_range * g * scaling / (2^16 * scaling) - where scaling 10000 would
> have allowed using g value 980665.
>
> This would have worked fine for reporting scale and available scales -
> but would be somewhat tricky when converting the user-supplied scale to
> register values in write_raw().
>
> Well, the g varies from 9.832 (poles) to 9.780 (equator) according to
> some website - no proper source check done but this sounds about right -
> so maybe the loss of accuracy is acceptable.
>
> I did only very quick testing on KX022A and iio_generic_buffer. After
> the patch the values seemed to be correct order of magnitude. Further
> testing is appreciated :)

Values are correct with this change, Thank you for fixing.
Tested-by: Jagath Jog J <jagathjog1996@gmail.com>

Regards
Jagath


>
> ---
>  drivers/iio/accel/kionix-kx022a.c | 37 ++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix=
-kx022a.c
> index 4ea3c6718ed4..971fc60efef0 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -273,17 +273,17 @@ static const unsigned int kx022a_odrs[] =3D {
>   *     (range / 2^bits) * g =3D (range / 2^bits) * 9.80665 m/s^2
>   *     =3D> KX022A uses 16 bit (HiRes mode - assume the low 8 bits are z=
eroed
>   *     in low-power mode(?) )
> - *     =3D> +/-2G  =3D> 4 / 2^16 * 9,80665 * 10^6 (to scale to micro)
> - *     =3D> +/-2G  - 598.550415
> - *        +/-4G  - 1197.10083
> - *        +/-8G  - 2394.20166
> - *        +/-16G - 4788.40332
> + *     =3D> +/-2G  =3D> 4 / 2^16 * 9,80665
> + *     =3D> +/-2G  - 0.000598550415
> + *        +/-4G  - 0.00119710083
> + *        +/-8G  - 0.00239420166
> + *        +/-16G - 0.00478840332
>   */
>  static const int kx022a_scale_table[][2] =3D {
> -       { 598, 550415 },
> -       { 1197, 100830 },
> -       { 2394, 201660 },
> -       { 4788, 403320 },
> +       { 0, 598550 },
> +       { 0, 1197101 },
> +       { 0, 2394202 },
> +       { 0, 4788403 },
>  };
>
>  static int kx022a_read_avail(struct iio_dev *indio_dev,
> @@ -302,7 +302,7 @@ static int kx022a_read_avail(struct iio_dev *indio_de=
v,
>                 *vals =3D (const int *)kx022a_scale_table;
>                 *length =3D ARRAY_SIZE(kx022a_scale_table) *
>                           ARRAY_SIZE(kx022a_scale_table[0]);
> -               *type =3D IIO_VAL_INT_PLUS_MICRO;
> +               *type =3D IIO_VAL_INT_PLUS_NANO;
>                 return IIO_AVAIL_LIST;
>         default:
>                 return -EINVAL;
> @@ -366,6 +366,20 @@ static int kx022a_turn_on_unlock(struct kx022a_data =
*data)
>         return ret;
>  }
>
> +static int kx022a_write_raw_get_fmt(struct iio_dev *idev,
> +                                   struct iio_chan_spec const *chan,
> +                                   long mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               return IIO_VAL_INT_PLUS_NANO;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static int kx022a_write_raw(struct iio_dev *idev,
>                             struct iio_chan_spec const *chan,
>                             int val, int val2, long mask)
> @@ -510,7 +524,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
>
>                 kx022a_reg2scale(regval, val, val2);
>
> -               return IIO_VAL_INT_PLUS_MICRO;
> +               return IIO_VAL_INT_PLUS_NANO;
>         }
>
>         return -EINVAL;
> @@ -712,6 +726,7 @@ static int kx022a_fifo_flush(struct iio_dev *idev, un=
signed int samples)
>  static const struct iio_info kx022a_info =3D {
>         .read_raw =3D &kx022a_read_raw,
>         .write_raw =3D &kx022a_write_raw,
> +       .write_raw_get_fmt =3D &kx022a_write_raw_get_fmt,
>         .read_avail =3D &kx022a_read_avail,
>
>         .validate_trigger       =3D iio_validate_own_trigger,
> --
> 2.41.0
>
>
> --
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]
