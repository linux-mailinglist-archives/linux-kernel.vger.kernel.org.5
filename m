Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F403F779E80
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjHLJST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbjHLJSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3812D61;
        Sat, 12 Aug 2023 02:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5690635ED;
        Sat, 12 Aug 2023 09:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94B5C433CA;
        Sat, 12 Aug 2023 09:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691831872;
        bh=POheynZ79NEUJH44XM2eA1dRcv8QudUHfLKgH5ufLxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vgv4kRAJ24FhJlx1AU+kbiTPdyw4SYlWiKiUwtL8iOOrtx8xP53fcRBP8y6DkonhB
         55FFxya5+NqwdiG4yIPARhIHlRLGFgNMOovGgq0EgBnDmQuFlhfx+FK7V/4tuMpDW5
         u/9x0YWyr9dwXt54VnWh3TmWTVE+Z+UTiINoEUCHNFV2ZY4XC2lzmpA4xl7re+g8LY
         rHh7ggjARWLgbYvx2pCrue49D/MwtuIXbb6pFoKfsyg2qAG5hZDe3eDy5N0b2unduF
         wXGPbCpQyLe89bzPddqJijK+jURjSXk6w5pWq0Sszf3H/vbnN0oHoCDbo8mq8pe3+Z
         tfO7G7FeT7KKA==
Date:   Sat, 12 Aug 2023 11:17:46 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: lsm6dsx: Support temperature channel
Message-ID: <ZNdOOuXy7vON/Shb@lore-rh-laptop>
References: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
 <20230811-iio-spacex-lsm6ds0-v1-1-e953a440170d@linaro.org>
 <ZNYIaagdt7HuRet5@lore-rh-laptop>
 <CACRpkdYHMyfvAGxgvtB8jgTsOp36Lm4gXzVYcBfXdY7RQK36cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JW11KyscPKBiby6C"
Content-Disposition: inline
In-Reply-To: <CACRpkdYHMyfvAGxgvtB8jgTsOp36Lm4gXzVYcBfXdY7RQK36cQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JW11KyscPKBiby6C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo!
>=20
> thanks for the review!
>=20
> On Fri, Aug 11, 2023 at 12:07=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel=
=2Eorg> wrote:
>=20
> > > +                     [ST_LSM6DSX_ID_TEMP] =3D {
> > > +                             .reg =3D {
> > > +                                     .addr =3D 0x0A,
> > > +                                     .mask =3D GENMASK(5, 4),
> > > +                             },
> >
> > looking at the ISM330DHCX datasheet, the temperature sensor ODR is just=
 52Hz,
> > while values in 0x0A register are used only for FIFO decimation, they a=
re not
> > values you can configure the sensor e.g. for read_one_shot().
> >
> > > +                             .odr_avl[0] =3D {  26000, 0x02 },
> > > +                             .odr_avl[1] =3D {  52000, 0x03 },
> > > +                             .odr_len =3D 2,
>=20
> I look at page 44, paragraph 9.6 about bits 4-5:
>=20
> ODR_T_BATCH_[1:0]
> Selects batch data rate (write frequency in FIFO) for temperature data
> (00: Temperature not batched in FIFO (default);
> 01: 1.6 Hz;
> 10: 12.5 Hz;
> 11: 52 Hz)

AFAIR the batch register is used to sub-sample sensor data before queueing =
them
into the FIFO (please check st_lsm6dsx_set_fifo_odr()), but it does not ref=
er
to the configured sensor ODR.
Looking at the device application-note [0], the temperature sensor ODR depe=
nds
on the accel/gyro one:

- temperature sensor ODR =3D=3D accel sensor ODR if accel ODR is < 52Hz and=
 the
  gyro is in power-down
- temperature sensor ODR =3D 52Hz if accel ODR > 52Hz or if the gyro is not=
 in
  power-down

Regards,
Lorenzo

[0] https://www.st.com/resource/en/application_note/an5398-ism330dhcx-alway=
son-3d-accelerometer-and-3d-gyroscope-with-digital-output-for-industrial-ap=
plications-stmicroelectronics.pdf

>=20
> That reads to me that I should actually add the odr for 1.6 and 12.5 Hz
> and the above 26 Hz is wrong but the .odr_avl[1] =3D {  52000, 0x03 },
> 52000 milli-Hz is fine?
>=20
> Yours,
> Linus Walleij

--JW11KyscPKBiby6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZNdONwAKCRA6cBh0uS2t
rGTgAPwMXyzceZYVU6okEAgaH9yCvyNeOc3nFiYMtI016bnmtgD/WbETAWx5M6Mr
JCxdDIvAcGmT/ETd9KQFy2Ltq+2EZgE=
=B9Yu
-----END PGP SIGNATURE-----

--JW11KyscPKBiby6C--
