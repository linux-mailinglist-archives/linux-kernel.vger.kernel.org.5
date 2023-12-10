Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F37F80BB24
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjLJNkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjLJNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:40:04 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F734DF;
        Sun, 10 Dec 2023 05:40:08 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bfd3a5b54so4041048e87.3;
        Sun, 10 Dec 2023 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702215606; x=1702820406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqJWa0R4WviXMXZaOcIckjKhjVqbAnCbIK00QJSP7SU=;
        b=jUIJ/qs2MV6q6c83eJOxNMrJ3brd4BvS7TUCiSj06O72WGymIRMddy+cI/d0CdVnIF
         NeGu5fVxrf/nQRrV0D/EJNXYwf94P5WEAwa26ap6HyQZyGEhDuXzCUqy9UjuicBv97Aj
         HxQAE95hBfxjxZqXQIm0BbrZL/zKEG2fkK3i6RHMRuYh9pOV9sv7yXnyB3coQ9OTqFhl
         8lKvjD5z+DB51TnF1Xe0IFyXS6vrtfkQsBQjbbGutWl7Zjg0sYjs6H5midJlRcoIq5gJ
         GrpcJCui55RQKKdY6EuCokLiVlRCkvXu1znxNqJ39aHWYRqF3JIZ3zDl7mtL8gFQaAIn
         a2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702215606; x=1702820406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqJWa0R4WviXMXZaOcIckjKhjVqbAnCbIK00QJSP7SU=;
        b=QR0NlVVhh0x43wxrawIaRySguDn4GIVQHqCYV/+m6kEs8GpSne3Hepp4RSSKYongFK
         X8fQufH4wCVJo6yBaBYllg6Ci4+6OoRtx/W0NumvMMeJuU16Vtlr809XGf3BIZY5qzkQ
         LF6M6599mxCp7ZS6GGjD2ZR2YXUwh8VYpbSQaO/qJdmHhJIOFKf1Hu9az1geTl8Vw+eq
         MWfIFFZZaiFiCYA9H8kwYi+Ox62RJ5PmYl6TDvsGKyKmgsbYA03E8OV+fYcmZHE/lYNX
         EypVHq+djvL8Mc1eMPsbT/ve9wB1j92s84RxOUXGM88tbTRiAXwSHGckm+4nMvsfIwYA
         7TcA==
X-Gm-Message-State: AOJu0YzDPD/A218QeUIOD9+jCFD9MIDCpEuEpzPL6io44NzJd59/nM4v
        x2NGUlm4D2CdXmbmvSDqThlVVVWP8HU=
X-Google-Smtp-Source: AGHT+IHsRQ8HYlH7jPEcQG32Ivqj+aYwpjDpJw+O9BBN+u0MLI4twWP/36cq6r+6V+WuHFW81KncRg==
X-Received: by 2002:ac2:5201:0:b0:50b:f9b2:cf2 with SMTP id a1-20020ac25201000000b0050bf9b20cf2mr1151770lfl.40.1702215606127;
        Sun, 10 Dec 2023 05:40:06 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id k4-20020a05651210c400b0050bef21a012sm807699lfg.191.2023.12.10.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 05:40:05 -0800 (PST)
Date:   Sun, 10 Dec 2023 14:44:40 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: mcp3911: simplify code with guard macro
Message-ID: <ZXXAyEkA55MFw5iH@gmail.com>
References: <20231206-mcp3911-guard-v4-1-30c3c5d4340f@gmail.com>
 <20231210113632.7880e730@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ivf6EFFOCMSRLL93"
Content-Disposition: inline
In-Reply-To: <20231210113632.7880e730@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ivf6EFFOCMSRLL93
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 11:36:32AM +0000, Jonathan Cameron wrote:
> On Wed, 06 Dec 2023 19:39:04 +0100
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > Use the guard(mutex) macro for handle mutex lock/unlocks.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Various changes inline - most are focused around simplifying the
> path for any given flow through the code.
>=20
> Rather than going for a v5 - I've applied this with the following diff on=
 top
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index dfcb6cb7570f..7a32e7a1be9d 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -317,7 +317,7 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>                             int *val2, long mask)
>  {
>         struct mcp3911 *adc =3D iio_priv(indio_dev);
> -       int ret =3D -EINVAL;
> +       int ret;
> =20
>         guard(mutex)(&adc->lock);
>         switch (mask) {
> @@ -331,17 +331,23 @@ static int mcp3911_read_raw(struct iio_dev *indio_d=
ev,
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_OFFSET:
>                 ret =3D adc->chip->get_offset(adc, channel->channel, val);
> -               return (ret) ? ret : IIO_VAL_INT;
> +               if (ret)
> +                       return ret;
> +
> +               return IIO_VAL_INT;
>         case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>                 ret =3D adc->chip->get_osr(adc, val);
> -               return (ret) ? ret : IIO_VAL_INT;
> +               if (ret)
> +                       return ret;
> +
> +               return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SCALE:
>                 *val =3D mcp3911_scale_table[ilog2(adc->gain[channel->cha=
nnel])][0];
>                 *val2 =3D mcp3911_scale_table[ilog2(adc->gain[channel->ch=
annel])][1];
>                 return IIO_VAL_INT_PLUS_NANO;
> +       default:
> +               return -EINVAL;
>         }
> -
> -       return ret;
>  }
> =20
>  static int mcp3911_write_raw(struct iio_dev *indio_dev,
> @@ -361,7 +367,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_de=
v,
>                                 return adc->chip->set_scale(adc, channel-=
>channel, i);
>                         }
>                 }
> -               break;
> +               return -EINVAL;
>         case IIO_CHAN_INFO_OFFSET:
>                 if (val2 !=3D 0)
>                         return -EINVAL;
> @@ -373,9 +379,10 @@ static int mcp3911_write_raw(struct iio_dev *indio_d=
ev,
>                                 return adc->chip->set_osr(adc, i);
>                         }
>                 }
> -               break;
> +               return -EINVAL;
> +       default:
> +               return -EINVAL;
>         }
> -       return -EINVAL;
>  }
>=20
> hope that's ok with you!

Thank you Jonathan

Best regards
Marcus Folkesson

--ivf6EFFOCMSRLL93
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmV1wMMACgkQiIBOb1ld
UjJJWg//d6A7m1jCTld/R+jAvYfBNLAYcxBNWWyKbzA1wOsQwt9VLpFdxMdB/HfC
egZxUaQB4MyA9xSBkS9vWqDZUt8+YujOW/cND15evJKokbXUXSEXxOjinU01ZNyL
3gMIHNoyYMXzI26R8IvZ8T/xAp5B3KzY28DOmYYahnKePdCMlnfia/H0qYYEgy8h
IUeLZwGHIb+rW6k4TWiUKfDWQxUBUk+TMqKBkQShPBYjlzJf8Xp3OTf2YEtHDZNn
SaC0rMVrsAuFGCYTkZKWJs+ctkb6tivyR5EeT5+pqNMhUZwh601hK+pGYvcC9791
qJg7GQqynquiDyaTLk9jv3gSNgu9mvBBuszEb2vCyWX5fSEyRYzeKedqJZMecUFe
bln0n1gpxJ1E/mX69+5cMt0/nGb1+j8vLzHLeVtCVRTrAFYDn3a5nfdz2ftY27mQ
85BZ2Fy21YzvRYBam/Mhq3ZLSdCknekcb4OnYKpN9+zgIwLrdE8i4lbjm052R4Pi
BdTxeqDoCsvL0nv62xBe3+fETijpC++Cc5sWnAo95JPybxk5ntO5iRbCwnM/fBgy
Xc+9JB/RYrhMWt1wcvSYNzkKZl+jIZH4NSzZU9XBAakqlcvkwI+aicj8EPjdiOH2
y4Xo1TEcwHxLHW3L5ky29PIkBE+HSogJEpiPXiftiYdLV7uHSSM=
=fRkE
-----END PGP SIGNATURE-----

--ivf6EFFOCMSRLL93--
