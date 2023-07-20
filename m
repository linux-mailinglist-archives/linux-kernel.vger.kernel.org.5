Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5CD75B4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjGTQkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGTQkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:40:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430582D7B;
        Thu, 20 Jul 2023 09:40:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9924ac01f98so171831166b.1;
        Thu, 20 Jul 2023 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689871205; x=1690476005;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKmIFijaEmUWC1R9DDCzFee/X/7A/Y1/d/lZq/EmF1g=;
        b=enB5DmORrPSRZeikuhIGbNddAmNhSn7NNkmZg2PW+9VB0rRQiu/QVioD6Z0WMgXm49
         NQ+HyZJ8nU+VckliV2dmfCal+TP1E9Wt/+kVZ8nk2j9d+aJwBbPHUNfaimN0rjqN7xuP
         KW8XHrkO6JuXXQ6psbcPMw0CCpsoyg3DVN7z78zAMRDODvf6kh22XBv1O4ShIgmkRu7s
         619h50cU636rWLwoRAc3YKHKrLiCsqaLLrrSwVpIscNTVRdTiWvCFLLsnQi/Y+cw6YNu
         z+/thf1jBKi2u4vvaeU+M5bc0wOvRoP5qMF6tFQfBgh3pUFOlXhIdvOfVaxMn8+DM51Q
         jH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871205; x=1690476005;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKmIFijaEmUWC1R9DDCzFee/X/7A/Y1/d/lZq/EmF1g=;
        b=Bubm6tx3No+jSMg/q+MaXM0IaUrPeP7bM3VvFblRUbdxI389l9b2mlLqDLApIre7Z9
         0M+5J5TjT0Fg9ChbWn5/LOKDFJPVMsS5pA87vPxp69/HjIgN5t2jJtyH9rpua0qOeWHD
         NL9CmH+XfC2SaqYiHCUA6YSv54Gh5I6eAuWJJFq3uXDq3YDar4gEBt000nvA42wtCjQI
         fT807ctRm1JGoWBzefAdvZA5Wrg5+5YiK4RqhTYXZmc828epV2Ccmu0ldcIE7gcDYTGl
         fxo7+K1ixu7wL0inKZrnhlry8UYffJRLaGiabffxGJpCs38gLPrZlWwIw1Dr03Y+xnDZ
         it6w==
X-Gm-Message-State: ABy/qLZayNSiO5qRW2BU3p6bphGU3lXMcGgf69v0TSdlGAjE083/La98
        ak61fead0LJwBRoIt/IncBk=
X-Google-Smtp-Source: APBJJlG5r35HcKt3DTeAiZ1ufcKGjxglt9PjACpRLBOg3fWCmldlwbAKHKLI+TyEw7EYesj3Kqp0TQ==
X-Received: by 2002:a17:906:10cd:b0:993:d97f:ae06 with SMTP id v13-20020a17090610cd00b00993d97fae06mr5363264ejv.13.1689871204569;
        Thu, 20 Jul 2023 09:40:04 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kd7-20020a17090798c700b00992a8a54f32sm904704ejc.139.2023.07.20.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:40:04 -0700 (PDT)
Date:   Thu, 20 Jul 2023 18:40:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mohan Kumar <mkumard@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, spujar@nvidia.com
Subject: Re: [PATCH] arm64: tegra: Add audio support for IGX Orin
Message-ID: <ZLljYqE_gDzh_WgT@orome>
References: <20230620155847.14598-1-mkumard@nvidia.com>
 <ZLljRBBHl_3jsKGg@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="23DfovU3nZbHCktE"
Content-Disposition: inline
In-Reply-To: <ZLljRBBHl_3jsKGg@orome>
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


--23DfovU3nZbHCktE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 06:39:32PM +0200, Thierry Reding wrote:
> On Tue, Jun 20, 2023 at 09:28:47PM +0530, Mohan Kumar wrote:
> > Add audio support for the NVIDIA IGX Orin development kit having P3701
> > module with P3740 carrier board.
> >=20
> > Move the common device-tree nodes to a new file tegra234-p3701.dtsi and
> > use this for Jetson AGX Orin and NVIDIA IGX Orin platforms
> >=20
> > Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> > ---
> >  .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |    1 +
> >  .../boot/dts/nvidia/tegra234-p3701-0008.dtsi  |    1 +
> >  .../arm64/boot/dts/nvidia/tegra234-p3701.dtsi | 1991 ++++++++++++++++
> >  .../nvidia/tegra234-p3737-0000+p3701-0000.dts | 2009 -----------------
> >  .../boot/dts/nvidia/tegra234-p3737-0000.dtsi  |   41 +
> >  .../nvidia/tegra234-p3740-0002+p3701-0008.dts |   91 +-
> >  .../boot/dts/nvidia/tegra234-p3740-0002.dtsi  |   56 +
> >  7 files changed, 2176 insertions(+), 2014 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/nvidia/tegra234-p3701.dtsi
> [...]
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.=
dts b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
> > index 43d797e5544f..2b7856b303b4 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
> > +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
> [...]
> > @@ -103,7 +99,7 @@
> >  		};
> > =20
> >  		hda@3510000 {
> > -			nvidia,model =3D "NVIDIA IGX HDA";
> > +			nvidia,model =3D "NVIDIA Jetson IGX Orin HDA";
> [...]
> > @@ -151,4 +147,89 @@
> [...]
> > +		label =3D "NVIDIA Jetson IGX Orin APE";
> [...]
>=20
> The platform is called "NVIDIA IGX Orin Development Kit", so shouldn't
> these be "NVIDIA IGX Orin HDA" and "NVIDIA IGX Orin APE", respectively?

Oh, and no need to resend, I can fix this up when I apply.

Thierry

--23DfovU3nZbHCktE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS5Y2IACgkQ3SOs138+
s6ESVhAAsTZP40c5ASBe4C7mUMahAduFRPg/8KOdje4Zxwq/DvhgDcsR7Sv/IRYB
lS5IIuF6idOgCxKzrthBAUaKexkNhFZzLO7Try0PiaCHkq6MrqoYpdDFL00O0sFJ
HwYguX0kFQ/+IbI/tTbjcU9LY6R7tYb3Q39vLy5D7XEB/fpbBwlP5U9w8yhJqe/t
9/e1QYe1CVAP+SQVmmiOkt+vM80KRiGXjXVBdjh1UOR/Ted46r2jfWSA6BFRpyyj
vdztzCEY8bxGZDTHrmWkrAUmcWQpVJdMoKtscI6r8tlFol9ZWZ7gZ7w2wXBnUxHG
LWA7xr8LrRZVoemNqCKBIr6RbLQ01PMzxv/5/EeXLuEiX/+LYxw0/E27SKhtdMz7
TI6FZgEDheiozzWHNakYkEOM+0evcfze08mGCZ8euJdUxrh/wAnMS/JVsVJZlfKt
h5rV8wnhkwX5Sz8tY8Uf2Ij8/UMnCfwD2rcJycYXgls0STw7hfAVy4S1IxH85RqP
J6A2sPrfbfUhcQQDgTOlG9zDfHfuBkx4w542kigrVH49TxtqOCcri22k7+uoGqQT
vzr6dKZPN4IBNIkYkrT1NrFeXENYZAunVtlnOu2P/o41fjT1jvNhGLZEDUBNt/YT
VyIU41CqVAetdm5hSPrUuHTWKDzK1+j31MKVdDLdS/bCX95YrN0=
=UCk9
-----END PGP SIGNATURE-----

--23DfovU3nZbHCktE--
