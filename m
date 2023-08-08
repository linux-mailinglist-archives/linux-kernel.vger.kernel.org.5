Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0C977419A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjHHRYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjHHRXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:23:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799221EF72;
        Tue,  8 Aug 2023 09:09:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso9496472e87.1;
        Tue, 08 Aug 2023 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510967; x=1692115767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Qc9TaZ0YZxfr2ijk4qJEfWVJCx/zM4Mwpq5TAaoTRE=;
        b=RFgjI424/B1J8d6fEQU85hdFR29a2/jvGuzeKNbrcbA2Kz+4Z4+3nkGWGw1SIKjUnl
         XfQEwoKbPHyPc3IMihHxdlHz4D1RSKgM1PZ+ik2B3T2OqH3aM1CQCVkFcrn+8qCM6LfA
         48wihyD2GoNsnhjaeEyD7JRgKohwaBlqzUJ5bVpefjLB/qok90Cxn9nQMmvSD31xdFcA
         /ghsCcLoOrE0ncMr0yGRr7gZv6ejow98BpmWYVuf/eBxkFQMOsrRHOdOndCaIsI7l9kG
         pp75lojReKqQcHxFA+B7/KiBd5qDmAexqF5KNnN2J81xB2QWRO/TphBxM/JWW8b7K4Rk
         raoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510967; x=1692115767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Qc9TaZ0YZxfr2ijk4qJEfWVJCx/zM4Mwpq5TAaoTRE=;
        b=cXBmYIlt0u7Yg1U79aobcPFBRuhoGHXXU97V+Q9TPoOKbx3j2jCZ5Kls9mnJSmQniA
         XbI7nWAT0IkQvSlpK0c4QwPitVpFF2zFRDigJEpWjscUHue+XqoX0MC8v+RGiQO/4McO
         gVemFCHUFEdkp19z9pBY5OkJfMQC3hxjlgqx4MI8PKTeueMnMk1jhzJr/99f6NspK/Ce
         kkLfBvLhHR3cv/N5Ei1kmAEFH/d/mAsFRKwGcOmnpakr28Vzb1nWOdSXvRtZd4Il/5wL
         3797rADOv7uXtym0T9SkfFf1oHFTBYtG7GxUvvRVZRvx5Mx/N9JHcTJ0XOvhl2xV8sfK
         hHdg==
X-Gm-Message-State: AOJu0YxyuZnNfYfhyw/OoE2OG+z8dSXyK84yti0xxSgYXy7sbMwVKdQY
        XL7O5TONi3OT2Um+tAaaEKgJhCYw6Yg5pI3X
X-Google-Smtp-Source: AGHT+IGwh13bXO1PdIDK9A2IeD+OcpE7lGUQqZmmNhhWKV9U7iMTXE1/H8R9JVCPsPxdCaTWb6BaTg==
X-Received: by 2002:a2e:3208:0:b0:2b9:ad7d:a144 with SMTP id y8-20020a2e3208000000b002b9ad7da144mr8929317ljy.11.1691479226041;
        Tue, 08 Aug 2023 00:20:26 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id z22-20020a2e8856000000b002b95eb96ab7sm2210306ljj.18.2023.08.08.00.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 00:20:25 -0700 (PDT)
Date:   Tue, 8 Aug 2023 09:22:24 +0200
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
Subject: Re: [PATCH v3 2/2] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZNHtMBG4yHpgL1kj@gmail.com>
References: <20230807071831.4152183-1-marcus.folkesson@gmail.com>
 <20230807071831.4152183-2-marcus.folkesson@gmail.com>
 <ZNETcVNsEmvK0KKH@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9iQz+m/6foi59TLA"
Content-Disposition: inline
In-Reply-To: <ZNETcVNsEmvK0KKH@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9iQz+m/6foi59TLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 06:53:21PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 07, 2023 at 09:18:31AM +0200, Marcus Folkesson wrote:
> > Microchip does have many similar chips, add support for those.
> >=20
> > The new supported chips are:
> >   - microchip,mcp3910
> >   - microchip,mcp3912
> >   - microchip,mcp3913
> >   - microchip,mcp3914
> >   - microchip,mcp3918
> >   - microchip,mcp3919
>=20
> ...
>=20
> > +#define MCP3910_STATUSCOM_DRHIZ         BIT(20)
>=20
> Is it deliberately using spaces? If so, why?

No, probably due to my with my new vim setup..

>=20
> ...
>=20
> > +static int mcp3910_get_osr(struct mcp3911 *adc, int *val)
> > +{
> > +	int ret, osr;
> > +
> > +	ret =3D mcp3911_read(adc, MCP3910_REG_CONFIG0, val, 3);
>=20
> > +	osr =3D FIELD_GET(MCP3910_CONFIG0_OSR, *val);
> > +	*val =3D 32 << osr;
> > +	return ret;
>=20
> I believe this is wrong order. Or bad code. The rule of thumb is not poll=
ute
> the output variable if we know the error happened.
>=20
> Same applies to another function.
>=20
> > +}
>=20
> ...
>=20
> > -	ret =3D mcp3911_config(adc);
> > +	ret =3D device_property_read_u32(&adc->spi->dev, "microchip,device-ad=
dr", &adc->dev_addr);
>=20
> Why not spi->dev? Ditto for other uses like this.

After all, I think it is better to stick sith adc->spi-dev to be
consistent with the rest of the probe function. Change to spi->dev
should probably be a seperate patch.
Do you agree?

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

--9iQz+m/6foi59TLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTR7SsACgkQiIBOb1ld
UjKmLhAAmVbkmMJoLp/7/9BSuDNad52Q4sV0eiG2cYqHMn/ZFLdVISQmtYDtbPAd
Kb2Co//QorEr0UeoxEKqOqkWOn1VhLHhP7wne2EosuVWZtW0f1t+wBx89NkMcr4O
PwVZbSjPeOy7ZYqAk9av0pYugdW4H1dRCvivY9FsB653tuOQ3R+jetOxn0pWou06
mCfA0jtBVFptfKjTuifEsPuGqJS4g20yyfMuDMOBhOA6362ShAV/vlq/EUr3c+C9
f5t3MfCfYXrC/8tOI4DDzZ8VlFCDmEbPdAwjaOvaEJLh+enC4Yjh/kS3B6IryOGM
VUatDrmCg1/vSrtBHCLsysC2ZPep1Liz+tthDwNB68KPlOiugQd1NN1LoO1mb3Jn
khDZUdB9CEAJvSzA6sx3ZtehW7iKIrPCuc8EY9NClbHd63Q4hkXXXvbWzFSEr6Vv
+/Fkg8WA4rfTjq1oOHsna2CNiHsb+xpbhoSPV4Y5qRpKsNQOSB74T8aU+YDxYDmy
fhvC/d0aKPFcInIZaforvFOP4AAFgsDtYKNSI64qkiR4DjCe4+s0HsVNxWqFgjcg
EZMzT8iuaZ4sFuNmlqskhQgqj/b+iN7vA/kaSztrnOlx6Ir5+uOk7dyHD+walUJs
j+LuiTv4faZM22I4+J8df8ORUoLhj2r9nhggYg6zIXox04Bbu4s=
=B4Sa
-----END PGP SIGNATURE-----

--9iQz+m/6foi59TLA--
