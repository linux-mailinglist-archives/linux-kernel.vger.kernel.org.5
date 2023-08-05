Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCBB770F01
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjHEJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 05:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjHEJP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:15:26 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083A4469F;
        Sat,  5 Aug 2023 02:15:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9a828c920so43953181fa.1;
        Sat, 05 Aug 2023 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691226923; x=1691831723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEMrhJgRpsbu7zR7TA2bQHTZOtBmsvLnhXD4/GvVmYU=;
        b=ByzRNtMFnLrd9GxiHSVQHLxowzr65hqXuPf/NZB0wensOhVPYzu5ToLqe4kIy7MHEj
         Y1SliYE8cxWcMcmLgnNHDu6Yy+T20WE/uWB5Fkmn0YXwvjDB+w/iIvnGJtJZou9TcAAj
         L5q4aaT9uV8t3leAu+J81DmXNXeABjKe02P9n2WUPMpl7ScsLLc+J1qiewecbQweZLKq
         GQ5KFOo1W/HwX9fZQy84McBdVE8sPc9QOC8cHkMPdeoVjLssJf9yd/R7Hk84cp0hSSTc
         am8plE9JiTbJlpVbFsrf84cS69QHVVN5DToRRRQl33S8Ydyt21XHjUlKpblBxiDkkRRg
         Z/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691226923; x=1691831723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEMrhJgRpsbu7zR7TA2bQHTZOtBmsvLnhXD4/GvVmYU=;
        b=gS+jcrXlpm6+kBGvHlXHWPEbreXFZFyVlT8zsnbd0C0+e6W2BAooeRWtNs8V944s6L
         LU0KvieHCoK1LpuF7phIRJc+6C6ix1zo0jqaEAhaUTT/mpyVTT0nt/yVHf/7oGB7NWEh
         mBAUjb5DulKfWtxwdGtu8uNJ47rC6f7YEjFDslg1Ld1S9O7AO7c5paP1ltX0g37D7Udr
         0vz5Kttm+YP741RDdoULXNQ3UL5kTOL0duJ7nIkmcLj439dbtciL9myFiJwBM/uXGUo8
         WL6ONWVokxMQRX2MsEufbSC7tEm6vS0dggUrZLVasrq6WR4HGalAe5Zoxa/TrShCrNVJ
         zY+w==
X-Gm-Message-State: AOJu0Yx0HYNFd2X3Pr9gBuNskepGPX+l4jJC3+7XW1l9ScflBQZI+qGM
        ZLlbwgxiZx0LeGgNbG889fpWKTvJ/I7wBjl4
X-Google-Smtp-Source: AGHT+IHUkxlpoPzF31OElddPnzgqTc5AMFFKr2pzjnaghDPp3Ip1gxFvrpXc1JPPQXDzlWQaLABPLQ==
X-Received: by 2002:a2e:98cf:0:b0:2b9:e053:79d8 with SMTP id s15-20020a2e98cf000000b002b9e05379d8mr3322896ljj.18.1691226922927;
        Sat, 05 Aug 2023 02:15:22 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id v9-20020a2e7a09000000b002b836d8c839sm815724ljc.40.2023.08.05.02.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 02:15:22 -0700 (PDT)
Date:   Sat, 5 Aug 2023 11:17:21 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZM4ToQ4EiuEwlbEi@gmail.com>
References: <20230804100248.3773861-1-marcus.folkesson@gmail.com>
 <20230804100248.3773861-2-marcus.folkesson@gmail.com>
 <ZM1Td+v3tcoaID9v@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OZc4EUY9h3zGPqzZ"
Content-Disposition: inline
In-Reply-To: <ZM1Td+v3tcoaID9v@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OZc4EUY9h3zGPqzZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Andy,

Thanks for your revew!

[...]
>=20
> > +static int mcp3910_get_offset(struct mcp3911 *adc, int channel, int *v=
al)
> > +{
> > +	return mcp3911_read(adc, MCP3910_OFFCAL(channel), val, 3);
>=20
> Just to be sure, the proper endianess conversion is done in mcp3911_read()
> and mcp3911_write() calls?
>=20
> This question applies to all calls to that APIs.

Yes it does.

[...]

>=20
> > +static int mcp3910_get_osr(struct mcp3911 *adc, int *val)
> > +{
> > +	int ret =3D mcp3911_read(adc, MCP3910_REG_CONFIG0, val, 3);
>=20
> Have you run checkpatch? Here should be a blank line. Same in other sever=
al
> places.

Yes, checkpatch does not report any warning for this.

[...]

> > +	adc->chip =3D (struct mcp3911_chip_info *)spi_get_device_id(spi)->dri=
ver_data;
>=20
> Can't you use spi_get_device_match_data()?
>=20
> ...

Will go for spi_get_device_match_data().

[...]

>=20
> > +		device_property_read_u32(&adc->spi->dev, "device-addr", &adc->dev_ad=
dr);
>=20
> With
>=20
> 	struct device *dev =3D &adc->spi->dev;
>=20
> lines like this will be neater.

Indeed, but I think I will short it down to just spi->dev.

>=20
>=20
>=20

Best regards,
Marcus Folkesson

--OZc4EUY9h3zGPqzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTOE5wACgkQiIBOb1ld
UjKezw/9Ft3n9wG4UJox6bgPA6LdrFllY0Joyk8WcdHUzckCXh8R0kFowgIOhOOd
8LekC5lNQrx8r2aCpPwOyw7tuCVPjxrqUVxnF4ibU+HNFz4bqBodrXb6teUNAAHJ
8SBcgwfUsKz3zcg2WHKzcbZJYJnKHcdD5yzaecypRyNPFo+NfHhIoiav0tDWFMlk
6Ldd1Xa5w4xV4kCVt/BFl5YGOy/okrlntVEdWjL2+Jxu+rb7iD5FRQlS0d0OMPZk
WldHXAOpguEzJRMdRxPmWtEdhyfVyQEymSoKrS22iPJt/EJsxd+p3pvmq/PKdogD
4Q4dx4slUdYWD7CHRfTJ/cEMe3d9PUI5Cjqb381UavKJ4N/RsfgwoLO/LlbDZaBu
z6J9fTWKSFa0jPpXamxxaLeoTBTU8ZM0KHipK8xalaBO40NM7MsrIoWHSpBUYV6W
c4wDqpe5fz1YDOMZ+bea00Uyl+XlzNaVY/rWO2cflnRZ8I3550WaAKTPVJwlTy2F
58gwoEPD3X82RmTSAtwoVxTgXzbWileIM3/x0Hs08pksOuYUEkuFjCO1/i9sn2SB
JnCl6d3oRYW4D1+nksu5rFqPZIk72kIH4OgXdpG2x+gdRVt+iIBKWBKYUUhRJi3e
BF16knGzDggpv/+YYvGO3ZbjqfWSvf6tGyusiXOAGXw4Loz4Xgw=
=Rgh5
-----END PGP SIGNATURE-----

--OZc4EUY9h3zGPqzZ--
