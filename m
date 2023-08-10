Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE33777ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjHJO3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjHJO3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:29:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F166121;
        Thu, 10 Aug 2023 07:29:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe700f9bf7so1490628e87.0;
        Thu, 10 Aug 2023 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691677760; x=1692282560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4FRDC2uRyAvLbSGn3/VtLhEURYcAkPMGRYoJZM0kyQ=;
        b=FIlu/UCIR7u+C6/Q/aETaHnjcQjAywRCDBeS9uuemSe7Abs/EriZBV4D348i/RQCzr
         zO+cxiTiu3J802J2JQc9/0lnu8QDHROnOlfO5D9vb2+LeEVaxW4omRtHgXNscXsx4A1o
         nh5Bn+zTj4W8ke6OlnOvKshvRlc6Jm7Wv19usWTSOtszIyosxOXoVAjivUZfyKY+UkwX
         l21A4ISQc8PH/GvA+huVzIU+bdsJGYez8Fh+GTMFyw+6oZ8Y/zoC8cT3G87t5IS0mrWp
         U7bLHXMkgEDlOCZw9JXYr7YK3H/JeREqOonE2+aUgQeRa5/nzO0QsV+n2u1zAW9PD6FY
         eXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691677760; x=1692282560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4FRDC2uRyAvLbSGn3/VtLhEURYcAkPMGRYoJZM0kyQ=;
        b=LoNPfdprVErQ3FFfGV3qa0SUXk5jZ2L19AvIi5/s90yEaOlcIupbe8lBoq+g5mdC7l
         TLPo1rt1GdpbWZ/Vc5U+e5EXZ2+ql3IRtTjc6gKGXx6/Nj/EppevWnt53Hk5El/7NecN
         A/b9Wlu6V0iHgtZkczweg/UVtYfPSV858mUCdeufrS0amw+hM3Zqi59TKTbObAiqEax0
         b0f/qXYVTRbhJ6RXc6q4igGojK83OeJFAX2iVS8WN4zBuEzqJkDbTBjSxOrQEaRKQhyn
         14QMgTdt9V15qHofgXq1XEQkL7lj7K6iS/jY2YRRO1UZTdnAxKS7WjtvvZni3G1xrrZK
         cXrg==
X-Gm-Message-State: AOJu0Yw2pneP+PjZ/44Cufb1fkmxk0zIdL5YFfHXHt+yCi6QaEgNT7Sp
        q/rHjdIIIEJTZYpfYajvOTQ=
X-Google-Smtp-Source: AGHT+IFdrB/r3MxvPbWus9rrOgZKl7WaPwHUrvbiU3VxpUAh0qCmkywZawqcINGZWwgL2htp9o5l+A==
X-Received: by 2002:a05:6512:34c2:b0:4fe:8c4:44f6 with SMTP id w2-20020a05651234c200b004fe08c444f6mr2006573lfr.56.1691677760139;
        Thu, 10 Aug 2023 07:29:20 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id n16-20020ac24910000000b004fe700f9b0bsm304068lfi.174.2023.08.10.07.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:29:19 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:31:42 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Kent Gustavsson <kent@minoris.se>,
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
Message-ID: <ZNT0zkIagIRTfbMK@gmail.com>
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
 <20230808110432.240773-4-marcus.folkesson@gmail.com>
 <ZNJP6xpOvRJigtMx@smile.fi.intel.com>
 <ZNM1AYMB3RGRWp7C@gmail.com>
 <20230809190257.67602e55@jic23-huawei>
 <3939bd56-d57d-173e-da78-297ce607f9bc@linaro.org>
 <ZNTptMeRFAga34wd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wdSiVRv50xKam7eQ"
Content-Disposition: inline
In-Reply-To: <ZNTptMeRFAga34wd@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wdSiVRv50xKam7eQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 04:44:20PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 09, 2023 at 08:14:54PM +0200, Krzysztof Kozlowski wrote:
> > On 09/08/2023 20:02, Jonathan Cameron wrote:
> > > On Wed, 9 Aug 2023 08:41:05 +0200
> > > Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> ...
>=20
> > >>> Inconsistent macro implementation, i.e. you need to use (x).
> > >>
> > >> Sorry, I do not get you
>=20
> In other macros you avoid ambiguity of the parameter, so they can be eval=
uated
> properly, and not here.


Hrmf, I missed that I had asked about this before I sent out v5. Such a sha=
me.

I got you now, thanks.

I agree that maybe it should be 'ch' instead.
Already existing macros for channel and offcal use 'x' though, so in
that case should be changed as well.

#define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
#define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)

[...]

>=20
> See (1) above ?
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

Best regards,
Marcus Folkesson

--wdSiVRv50xKam7eQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTU9MkACgkQiIBOb1ld
UjICMBAA2Q5Nl8QZU75JoFUhh1BpfFQCmaLS6dW/xn1i6+z1AIFXwqU1ZIG3SNDf
qsPZv/oBSHWbFXfq9+2rS76QNceLeS2hC2o6TkSOu2v/viyK/yZVLXCiLul4jRDQ
dGcymuL7iyaoxoqN9fCOiLB7j5mopFsanagm0AqATA8diNre1C8LN4J+lrYLodMe
Ngi44YTjB3ln55d4j8o0gF6HhANcGpMrOKK7GOiobCiqBDxS+YJY7EnDeq4hE1oK
U41fHYE85kBdONKFj7uwYbq1mlZ6GMNJQqPzx6Dftkty/MGobwgPo/f9pVrd3dop
3AHyKjlQwslZOvllt/RcwIejs/liZPGCw86ftQGvOQPx0cXjW3gVR8U/SKN0qETG
eGv0eBe3tg5lkt418mkRicNj0fB464QA+Z4sQtKdokK7g2mr+3BU13MieaZBZDPS
UnmF/vDrHsR8x/bF7mUtbRxuv4YMzli/oHDkgN8HY9D3NfIdoYHfxXJ07L9AUzAC
omQfiSSrElsG+a4BYRN3aYiUozye4JiZCikF9WTQZSwW6son1SXSaAJuNlxtALrn
NETo2AZJgO3UAiJaKjaj4jZ1smXfEfVgxkCfJd8VhzFFNgcr1gfemERgijrmxiN0
cjB+mSIZaiWOoNDxjNEdU5JtyjBha2IU4x3952nOtxJi2UgaJjs=
=sNyS
-----END PGP SIGNATURE-----

--wdSiVRv50xKam7eQ--
