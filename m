Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC9379F933
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjINDxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjINDxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:53:50 -0400
X-Greylist: delayed 29023 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 20:53:44 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B392193;
        Wed, 13 Sep 2023 20:53:44 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.206]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZTyo-1rC6bK2p78-00WWJr; Thu, 14 Sep 2023 05:52:36 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id B8A673E872;
        Thu, 14 Sep 2023 05:52:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1694663538; bh=vDgINWPBzUIAWMngiKJuCoKZEkx2uCiwIU+aazJc+bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHCWCn54HMtTPGfYRBRLjNfPFGwAEBwM+V3IyM0gxSoUWQa2H1UFe2/k0ERiYWDsh
         RVJt71evYpv1PLxrVFa+0B8L6AM6qhsERl1pvE43i3sh4mWISDr+nlabZzS5tMascS
         3SL9LcDQip3ceE56BxDie69X6vae38J56VNTcQjs=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 3539A5EC7; Thu, 14 Sep 2023 05:51:32 +0200 (CEST)
Date:   Thu, 14 Sep 2023 05:51:32 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional
 dependencies
Message-ID: <ZQKDRANlIWGqTA/9@bergen.fjasle.eu>
References: <20230913113801.1901152-1-arnd@kernel.org>
 <ZQISGujwlH00B8KJ@fjasle.eu>
 <b234530c-88fe-4a2a-993c-f1733fe4d0c1@app.fastmail.com>
 <ZQIcuVgaDmA+VdV0@fjasle.eu>
 <c7c6de7b-4adf-4625-8f09-8f419869161d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pW/TkBCfOsDP79g/"
Content-Disposition: inline
In-Reply-To: <c7c6de7b-4adf-4625-8f09-8f419869161d@app.fastmail.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:NQOG6acG2KtKAphjAf5wLhsuAeUmx+UQJc8yzRv/bAiDUqlhDVD
 rJR/D0nu2J7U15lU3cYa4knT2VyzkcBRwYINNqADEGRJXEk90V1y9KhjmusLAJm3P1CXGoG
 bcrSXFpa4Mycx6RsPgVtEyyLmtuCGIUaS7GMxL6oAmRHCZgXCB9zaJMztIrPLJRX+H7JtKK
 dplgWqKfZqhq68CfREnGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cYlRSzQeoEk=;R8YmYFFRVt0iX/LhPKlkynWkg5A
 KKHFL1uoVjR/t6W9IWXvAJ/QFoUEOZW6P0tgrJa3IneOrx0ybe/uocPnb9eFi2LqQkEW7ptBg
 wu15F2sFlgu6gLoVgLs8WwDDlP62iLouuZ2GDoGbg58ukC+598jZu3Ik4bF8gGZ+BatMUrl/Q
 gIoX/W+zbmGpy4se0c3JsCEODieSYgnDqqk8NJOX/QKxaKIyK0b6WSv6U3hlGsfID6RRfLLvU
 N3LImeOhpPmdRmVN87D0ddbaZ9/EqREWFiC4xJvgdeYeCUCV0UcRsbaSQFJMxnlzLyeFw1Tf7
 4/t68+EIg9zClvSWWzHc8KNZna0h/5vr9RxGbY29/tHCkVjkmBxHMO7oXyP12lzZeaPo5zygy
 576IE4raeyckPVTM6Z3sbS2KDnI4B2/BwRs01nOWjz4sOSMlyt+O0mPIEAgnFUzO5/pzyCLYv
 YBjeAS7QugN2rvIjk3K4s/1xFI+/Rl3ttARYe30G+cuOK3/c9H9SZLd+tYVxIADOG5SWj4p0s
 iEMhzrrVag0lgHsi/jjkL6FqW5fElDXIiEfYQu+ewn8nCXQnVHeqOKFA0KA5wDZdH/F+jvhVk
 1cxWHuymiDRJHV8NbTzvc+Pk5HSpIt2ffYt/JvAjTQjFc7qR3Hd9ANcyafKb2380ns9o6ytEz
 sUfOnkLArbAftD1u1V0zT20WiavDMpXQeff6scXziLUGW1+/zcMdn8gRvd8J6ldv11CqxTR2A
 NhIaJ1HSkfH0M1ewhLzLy6hrk5rj+X5xov3Zqq8YjgRypalXCVIi62uVAv/juQbUPeS9QIKq8
 l5nUHt0rYqa3saJpDQ02f5X5yS70MMCeDjPbluOH5zpax0LidOyCEtnrtbweMbxDew9ArWwJi
 aqN2aVQa2MrMh7Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pW/TkBCfOsDP79g/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 13 Sep 2023 23:16:47 GMT, Arnd Bergmann wrote:
> On Wed, Sep 13, 2023, at 22:34, Nicolas Schier wrote:
> > On Wed, Sep 13, 2023 at 09:55:36PM +0200 Arnd Bergmann wrote:
>=20
> >>    config FOO
> >> -       bool "Support for foo hardware"
> >> +       tristate "Support for foo hardware"
> >>         depends on BAR || !BAR
> >
> > ah, thanks, tristate kconfig symbols are really more interesting.  But =
I am
> > still not sure, whether this works as proposed:
> >
> > With the 'config FOO' above and
> >
> >   config BAR
> >   	tristate "Support for bar feature"
> >
> > kconfig allows me to choose between these:
> >
> > BAR=3Dy  =3D> FOO=3D{N/m/y}
> > BAR=3Dm  =3D> FOO=3D{N/m}
> > BAR=3Dn  =3D> FOO=3D{N/m/y}
> >
> > But with
> >
> >   config FOO
> >   	tristate "Support for foo hardware"
> >   	depends on !BAR=3Dm
> >
> > I can choose between:
> >
> > BAR=3Dy  =3D> FOO=3D{N/m/y}
> > BAR=3Dm  =3D> FOO is not selectable
> > BAR=3Dn  =3D> FOO=3D{N/m/y}
>=20
> That is indeed the point: if BAR=3Dm, we want to be able to pick FOO=3Dm
> here, otherwise it is impossible to enabled everything as modules.

oh, I misinterpreted your very first sentence; thanks for clarifying it to =
me
and sorry for the noise.
With the minor fixes:

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Kind regards,
Nicolas

--pW/TkBCfOsDP79g/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmUCg0MACgkQB1IKcBYm
EmkqMQ//eGegldi6pmfGsvc81ltTfQrq+D5tVf/nFo5oL2HbSXPIlZ627OGtC/hv
v9mD91mEB3m/WQG+E/22Y/enjvscqBWpTrJRp4su43U8y6mQcQWZ6QotZgk5YLg4
7k4pZNPkjC2rCTPodec+bKgd1ZIVOCP3xWAY9GTaK08nON2tz/FWppNbRMS6L8De
08y8GqMDn6BT+b0Q89XumCWfemvSzMK7odGAnUbWEfDn9s5wmUDzvdW8PnuOpFGC
fq82cJA75xO+TOTwGCqednstyEPov6LLFfEKdOzAwCjGg7sGO7EFUDvo6JuH7YHN
K4lmUQ+uq8c8XmMSQ3nceEEy/pZ+qgtVNDDSedJey8p3INkU/A41uQ6LcNq7oFTV
3oW22kTJf3T/MiD+eo5cIjJazKmK9WGOaHgceNWmbVG08TRHeGhriIlvOjPl1JPP
3IC+Ww1mpNTCOktMxUHEpzwjhDgMEKGPmIz3NaULe3NFPNBIpD9+KW/8lMLc9r3Q
X0IbqIeRgHG7jjZprzaLlBrDQVO/f2Xmp+5qTKQlQLP9p00plp6AuD+BEp1z/51Y
Ydu1SL2+6ocM43a0kgIQ+rjPBMxlPhIs11EKvvU8Kh/hspt/xo2csi6thdlKIseC
8E58CQwd9ysL25IDcq4wpGwgkZ2b2Ie7t7MVoBsC/s1z2QAwyis=
=uyPd
-----END PGP SIGNATURE-----

--pW/TkBCfOsDP79g/--
