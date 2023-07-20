Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E8F75B4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGTQkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjGTQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:39:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAE22106;
        Thu, 20 Jul 2023 09:39:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e5da802afso1370727a12.3;
        Thu, 20 Jul 2023 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689871175; x=1690475975;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEx6nUL4YZM5bantpgSzvZE+5jKhxmLmiP9voK482Gs=;
        b=JtOkNZXisfBISFNljbWys1+mJJ9nauBq2uu8sBaOYpaGx03meu1bRyVPtZfQwRAYIX
         bqwvGbvn5T4zbuoZdzbd11YwfhMMttB/JrR/4goX7zUSdfYAoEDCh8KnXZJFKCFQCErS
         5ibDKWBhWisBth4PoAgaJ2JNJzODaNYx4GCtNZyzkSWdb9KUEnHqcyNMEgnt42rj55YE
         mWqyebIcapcDsM5csWlq74shP9MJ2CoX0UN+i8YAiEe1wPnLH1DIhy0DgQt0GbY3A4Ks
         cc2DpoeUXQYWrO/Yn+eEgoVAGFfSJ04Tkdf/guXY14U3GtqGcAr1ILnRaXRbtwYpvM5s
         dIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871175; x=1690475975;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEx6nUL4YZM5bantpgSzvZE+5jKhxmLmiP9voK482Gs=;
        b=dnM+LdwraqSAGQDUm6VNZVEvuA2poNJLGiOMDvb3z7GLTtSMqo4kizwJDNv9Q5r20h
         UF7AmZw7PJ+fqxDDmBTqpzox1fSBh/URKwzWEWMH9H9ERJDJWazAyjCOjbXu1F8cYPqS
         Tlv1xvZ1ekRbw8b5CJdpNXJzEteZ3GsSeYI5HCUWici9v5WmVMsg9B9wMuwZo+0K/dB3
         vvC7ENXbE92hcmZqGNoyxfF9zDzV40mwADoS+vKsxosJu2JnQ1gLcImFaY2E3FgVQzTj
         NM1TNvjKyjFFBJbQvLODnlgJiX7bFMhItCd7L7PHVqq8Du0mDr74z4r+SLJGwPiwZ6fY
         NcZw==
X-Gm-Message-State: ABy/qLaFkoL/1CsC36qc2vA7mZXqvkSYrsk8eKLtfCnJsDftk7+1xL4M
        IlRWfgWHlr4qEaXDbvqTeEIks6+Foro=
X-Google-Smtp-Source: APBJJlHYCMNmMGqKYdtvfQsqdV5XYjoKIQGDNiCvPuXEhILZtCufK9sYXpxeyeaTcvWu7n4Qp1jIqg==
X-Received: by 2002:aa7:d80f:0:b0:51e:cb4:2b40 with SMTP id v15-20020aa7d80f000000b0051e0cb42b40mr2416173edq.6.1689871175158;
        Thu, 20 Jul 2023 09:39:35 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b005219864c7cfsm975038edy.39.2023.07.20.09.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:39:34 -0700 (PDT)
Date:   Thu, 20 Jul 2023 18:39:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mohan Kumar <mkumard@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, spujar@nvidia.com
Subject: Re: [PATCH] arm64: tegra: Add audio support for IGX Orin
Message-ID: <ZLljRBBHl_3jsKGg@orome>
References: <20230620155847.14598-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vLEOq6j5hPYuBGgG"
Content-Disposition: inline
In-Reply-To: <20230620155847.14598-1-mkumard@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vLEOq6j5hPYuBGgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 09:28:47PM +0530, Mohan Kumar wrote:
> Add audio support for the NVIDIA IGX Orin development kit having P3701
> module with P3740 carrier board.
>=20
> Move the common device-tree nodes to a new file tegra234-p3701.dtsi and
> use this for Jetson AGX Orin and NVIDIA IGX Orin platforms
>=20
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> ---
>  .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |    1 +
>  .../boot/dts/nvidia/tegra234-p3701-0008.dtsi  |    1 +
>  .../arm64/boot/dts/nvidia/tegra234-p3701.dtsi | 1991 ++++++++++++++++
>  .../nvidia/tegra234-p3737-0000+p3701-0000.dts | 2009 -----------------
>  .../boot/dts/nvidia/tegra234-p3737-0000.dtsi  |   41 +
>  .../nvidia/tegra234-p3740-0002+p3701-0008.dts |   91 +-
>  .../boot/dts/nvidia/tegra234-p3740-0002.dtsi  |   56 +
>  7 files changed, 2176 insertions(+), 2014 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi
[...]
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dt=
s b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
> index 43d797e5544f..2b7856b303b4 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
[...]
> @@ -103,7 +99,7 @@
>  		};
> =20
>  		hda@3510000 {
> -			nvidia,model =3D "NVIDIA IGX HDA";
> +			nvidia,model =3D "NVIDIA Jetson IGX Orin HDA";
[...]
> @@ -151,4 +147,89 @@
[...]
> +		label =3D "NVIDIA Jetson IGX Orin APE";
[...]

The platform is called "NVIDIA IGX Orin Development Kit", so shouldn't
these be "NVIDIA IGX Orin HDA" and "NVIDIA IGX Orin APE", respectively?

Thierry

--vLEOq6j5hPYuBGgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS5Y0QACgkQ3SOs138+
s6Fb6Q//XqMgA3W+sUybflSZbh5Kq41ThyM1yVl9KE0/v8+0uPwRwT7zGwXft/pB
O6BFHvPaSCMQHQ2FKcTOVAnIp1bIRGWb8taI7W4zDI57KqWiJYrBk68sdj8HvrsY
GZ/z5o1ethG5vkf+S4HxlLCjEsFqsStbzg21sMThMQb/Vwwr0YMBy9/3o+uVvSSe
SEQJoki2ExzpTCX9VNPQL6xz9O289pgFXYpAbZ3AFtmVn1Yqpvlj9BvtnsZKQB46
Q+dVQg965UOXYROYFirbh/ecj4zn4Eqi24pSZMv9QU4Peuiu7QDXUbBgTjXkzt5J
2e2uHMNGhU6KC4/hgpNizSqN4ITN6WGwmgl77Bq9lD/K+Y0WRCiROvvt24Eh4dhY
NTvtJXoorFlBD3fD+sJbUZyEXrJ0FYeFpC6vZX7XNW38sKizEn8XBOxYpqTuehva
JZK++p6GEFNnMzJyGgmP/wnk3e/MsfQnrAENqZRkQshXqLgVSpJMl3MOwFDvn26f
k8su8sr9hEF6SSQyuSsKddN9HLC8sSjfPpUZNHUbikQBGyQl2SSWoTCd12S0eX8/
Bwmiek7riu4yx1xwHWzpXdXy4lAFrTuY+UHJvRJVvvufach+xyiwn+h9t7deEnMS
Sv9vIdvTIA3GgK7jjSRdOh2ypc0NcsOJ3/5ivBWR27nGW0R9JJ0=
=YtvD
-----END PGP SIGNATURE-----

--vLEOq6j5hPYuBGgG--
