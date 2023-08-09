Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26D7752FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjHIGjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjHIGjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:39:10 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E0710CF;
        Tue,  8 Aug 2023 23:39:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so98459791fa.2;
        Tue, 08 Aug 2023 23:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691563148; x=1692167948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpWeiayZlAIEe1E3Nk+nVHStYloxOzgi1iWPgYNSoH4=;
        b=SPfF8hmRjOUTuyW97uqrRow1dZk8ia9JEEJSkdDhn4Z97+qm9p+jx8vwbTHPuqb4/A
         G3sJ80FQtSSCCliHhk0ApTFlxKnjSbu71JoSU8s8w3bJXmbNBLogKLFIq3jAGRPi1CF1
         wQLU9X0Fe7uo5/eXHDxq0UkrGnSNek0KYMwJB7vX4qR1ZEdBycIhOSGYbpednJH6qa3U
         f3a0yf8BhKThLanTmAlWVgQFsuQwB7unYQRQ3743nPTeRaJAkawMYT9jGPmm07y8Po93
         NmXanB6oz/Z9nzGby8ZU7QqlpbGVDyDEIwQk0DIujF3s91SVwurXOlO2tOwAvMqjGnH3
         4KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563148; x=1692167948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpWeiayZlAIEe1E3Nk+nVHStYloxOzgi1iWPgYNSoH4=;
        b=aaxkfMDqMkqCz2GUlPuRZjtW+sOlkVnvikFiOBv6d2EiP4GYbkee20Ms/rqvt9HQgK
         7qSYlJtfI3obumn33dvhpZrIHVLm2lHqWcP/Xa//k0A7BQWGD1ys/opWl2DAg6cI6/FC
         Xoe/CMQnrow2AlLtIW5szuSJKbSPyUuVt2HpkU+hHyLtLvvQEFjptnKam+oCNFD/86uW
         dDVnOXIUMz++hPRZGDhr466jXARDBeHm4n73QyEO8wEzH3WM2ugbQGb2BJ1nrmIjCc7h
         3Pn5b/wdpmhfnAmlGAm92skX5v241ATGFjINM4cnN/2H/T88DS1XTH8BuTtiwIb61WmE
         FWOQ==
X-Gm-Message-State: AOJu0Ywv+nHHrAi/srEKgDaLFNUjksF8Hgx6+Q0jnK9DwiBO/A+UiC96
        mM/l7UeIDRr0Gq5GPdGvF/MBvYbEtJ9Zr+Rf
X-Google-Smtp-Source: AGHT+IFKP5AWyWZujLJpO5etyUcBx/bpzy+SZ6bQ/z8/IumMuM87ftVqy2hSI6J/xmpbvKCRAUUo9A==
X-Received: by 2002:a2e:a0cc:0:b0:2b6:e124:4d96 with SMTP id f12-20020a2ea0cc000000b002b6e1244d96mr1010220ljm.26.1691563147554;
        Tue, 08 Aug 2023 23:39:07 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id m22-20020a2e9356000000b002ba161bdc9asm2584823ljh.79.2023.08.08.23.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:39:06 -0700 (PDT)
Date:   Wed, 9 Aug 2023 08:41:05 +0200
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
Subject: Re: [PATCH v4 4/4] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZNM1AYMB3RGRWp7C@gmail.com>
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
 <20230808110432.240773-4-marcus.folkesson@gmail.com>
 <ZNJP6xpOvRJigtMx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nrv095Qp/+mbQXwa"
Content-Disposition: inline
In-Reply-To: <ZNJP6xpOvRJigtMx@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nrv095Qp/+mbQXwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> ...
>=20
> > +#define MCP3910_OFFCAL(x)		(MCP3910_REG_OFFCAL_CH0 + x * 6)
>=20
> Inconsistent macro implementation, i.e. you need to use (x).

Sorry, I do not get you


[...]

> > +static int mcp3910_get_osr(struct mcp3911 *adc, int *val)
> > +{
> > +	int ret, osr;
>=20
> Strictly speaking osr can't be negative, otherwise it's a UB below.
>=20
> 	u32 osr =3D FIELD_GET(MCP3910_CONFIG0_OSR, *val);
> 	int ret;
>=20
> and why val is int?

I will change val to u32 for *_get_osr(), *_set_osr() and *_set_scale().

[...]

> > +	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-h=
iz"))
>=20
> This also becomes shorter.
>=20
> One trick to make it even shorter:
>=20
> 	if (device_property_present(dev, "microchip,data-ready-hiz"))

Thank you, I wasn't aware of device_property_present().

[...]

>=20
> > +	dev_dbg(&spi->dev, "use device address %i\n", adc->dev_addr);
>=20
> Is it useful?

Yes, I think so.

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

Best regards,
Marcus Folkesson

--nrv095Qp/+mbQXwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTTNPwACgkQiIBOb1ld
UjJMIxAA0ziqecFc2NsbIKI+ra1llKa2RMulAVXDaozUb6uMV+gwo5UN1ayLGuqv
asYAWxkaL0T/xTp86mrMNGFlvm+brllmsgmu72q4Xzclq5zJy7EEAnV8D/5OXGE2
xY63As3iX10rvdSYdIOCdm04M8//35jipJtSEUuUQ+wDx75tG7h1hUBjAdO6nru+
5hkplGFv6badZGHhfbglNxER17OSsK19uocXxxZyvynompHTwh2CdpHbwEjDt7Hw
bXf6C/sPdEPeEJyIc/bFAuIxaPy9ujcXgxxLNvybFtMz+nfd9wwFYhor7gj/xIac
Q/xF/7QuYrBSz1AHLImsFopyXto9LHQs4uFnuCnXvcFmnMUKLKt4M3b2pcsVG2hd
8WnRfx0TqKI0XpBA07+ePjJL3sXE4UatqNFFdvfV8UvU0IZc/6A2BIlknO83y1db
1bwV3Oqh8S7mUf6KVFm14ksaQS93Zrca05zLM4wh2cxg3ar0ASpqJreutsmdLJNI
3wG52RBw+uDIB+FXwRY5triNlb7xKWqKEMBHhJ0fdO3dyaKChfkAHxLqE2lALMnN
soAWus6zFpgfQyD9beC0jkn81o1xyME+Xwemv3ztcKD7ZSR5dfauejVIEV8OxCgg
yBC/BVlriluQtKeMDfXEzbiqlzOa/bK3j7ZdnnzTBP4khWpATyo=
=5dFK
-----END PGP SIGNATURE-----

--nrv095Qp/+mbQXwa--
