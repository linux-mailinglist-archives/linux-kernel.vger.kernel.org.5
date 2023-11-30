Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8373E7FF949
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjK3S0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3S0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:26:05 -0500
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BEBD6C;
        Thu, 30 Nov 2023 10:26:10 -0800 (PST)
Received: from [213.219.164.206] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1r8ljV-0003Go-8f; Thu, 30 Nov 2023 19:25:53 +0100
Received: from ben by deadeye with local (Exim 4.97)
        (envelope-from <ben@decadent.org.uk>)
        id 1r8ljU-0000000DvfB-2zuJ;
        Thu, 30 Nov 2023 19:25:52 +0100
Message-ID: <573e05d347a46febbb0f512b6128a4d683551679.camel@decadent.org.uk>
Subject: Re: [PATCH v2] kbuild: deb-pkg: remove the fakeroot builds support
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Guillem Jover <guillem@debian.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 Nov 2023 19:25:42 +0100
In-Reply-To: <CAK7LNASWqQBcf+z+cxWphf5pi8VkB10ABYvPKSxrLKbePYwC0g@mail.gmail.com>
References: <20231128153858.84932-1-masahiroy@kernel.org>
         <7a2684e680ffe279ed1e586e8ddb24b94c2cf010.camel@decadent.org.uk>
         <CAK7LNASWqQBcf+z+cxWphf5pi8VkB10ABYvPKSxrLKbePYwC0g@mail.gmail.com>
Autocrypt: addr=ben@decadent.org.uk; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-uotSR0vwGFnDONb46hJU"
User-Agent: Evolution 3.50.1-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.164.206
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uotSR0vwGFnDONb46hJU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2023-11-29 at 03:56 +0900, Masahiro Yamada wrote:
> On Wed, Nov 29, 2023 at 1:31=E2=80=AFAM Ben Hutchings <ben@decadent.org.u=
k> wrote:
> >=20
> > On Wed, 2023-11-29 at 00:38 +0900, Masahiro Yamada wrote:
> > > In 2017, the dpkg suite introduced the rootless builds support with t=
he
> > > following commits:
> > >=20
> > >   - 2436807c87b0 ("dpkg-deb: Add support for rootless builds")
> > >   - fca1bfe84068 ("dpkg-buildpackage: Add support for rootless builds=
")
> > >=20
> > > This feature is available in the default dpkg on Debian 10 and Ubuntu
> > > 20.04.
> > >=20
> > > Remove the old method.
> >=20
> > This seems reasonable.
> >=20
> >=20
> > > Additionally, export DEB_RULES_REQUIRES_ROOT=3Dno in case debian/rule=
s is
> > > invoked without dpkg-buildpackage. This change aligns with the Debian
> > > kernel commit 65206e29f378 ("Allow to run d/rules.real without root")=
.
> >=20
> > The Debian linux package has multiple makefiles used recursively
> > (rather than included).  The referenced commit is kind of a hack to
> > make rootless builds of a subset of binary packages work when invoking
> > one of the lower-level makefiles directly.
>=20
>=20
> The upstream kernel does not support individual package build
> since it is implemented in scripts/package/builddeb shell script.
>=20
>=20
> Is the direct execution of debian/rules still worth supporting
> in the upstream kernel?

I don't have an opinion on that.

> If the answer is no, "export DEB_RULES_REQUIRES_ROOT=3Dno"
> is meaningless.
>=20
>=20
> > It works because the package runs dh_builddeb, which checks
> > DEB_RULES_REQUIRES_ROOT.  But setting DEB_RULES_REQUIRES_ROOT has
> > absolutely zero effect on dpkg-deb or other low-level tools.
>=20
> Please let me clarify your statement.
>=20
> Do you mean this?  ("is needed" ?)
>=20
> "It is needed because the package runs dh_builddeb, which checks
>  DEB_RULES_REQUIRES_ROOT."

Yes.

> > > While the upstream kernel currently does not run dh_testroot, it may
> > > be useful in the future.
> >=20
> > We can do one of:
> >=20
> > 1. Ignore DEB_RULES_REQUIRES_ROOT, assume that dpkg-deb supports
> >    --root-owner-group and use it unconditionally (your v1).
> > 2. Check DEB_RULES_REQUIRES_ROOT, do either fakeroot and chown or
> >    dpkg-deb --root-owner-group (current behaviour), and maybe also do
> >    the equivalent of dh_testroot.
> > 3. Delegate this to dh_builddeb.  Since we use dh_listpackages now,
> >    debhelper is already required and this would make things a lot
> >    simpler.
> >=20
> > But the combination of changes in v2 does not make sense to me.
>=20
>=20
>=20
> I like 1 or 3.
>=20
>=20
>=20
> If I go with 3.,
> does splitting it into two patches make sense?
>=20
>=20
> 1/2:  remove fakeroot  (just like v1)
> 2/2:  dh_* conversion + "export DEB_RULES_REQUIRES_ROOT=3Dno"

Yes, that makes sense to me.

Ben.

--=20
Ben Hutchings
It is easier to write an incorrect program
than to understand a correct one.


--=-uotSR0vwGFnDONb46hJU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmVo06YACgkQ57/I7JWG
EQkIFBAAkSQhwsdk3EZLg8U18NzKDMGz2wCCZaE680Tq1WKdRrGTIVRNTTufupPG
Fa4HpfktR0abIVoIOnUGNSTvzco0sE1qSh0zjV4DWlMRWSg2t0/JKLM8IMAZIPPW
j9epqyYefFwuWcZ3xt47KBkEE+L2twpBSyNGlMpI0U2etXSpgU27Jj32bXTWlvK1
T+k5GpoBGnbQrRBC0y2h7TxHC0slenNStmzP7Y0wJ9wWGzKK43npruruNtml68Bl
a3YkjeQDsOKXSEUXLMAzJOIZ41Mjo1cEM2Sa9PjSGfquE5YzPQFA/dwqOkyfM1LA
I/0so8K/TSbGLghXTV0OuR3q92qhqd7HUDCsFspoEnaxB2RMeY2rXFt++HDVBmD9
UohsUgRZ0iS8w4GzYPl2muOKhmhnqPjMcYSgbWEAVq21NYx0EFEnaXcUJE5yUVHj
DriRS3R6AGSZVOtvt/ZFab5vVP0Mi8wd8lsCeH3H8b+Gd4kSWqflfBmHDSnEONX7
ywc3VsXIPzVDfbPc7oGI8dAtTL3gpWfI64ThjKj9UNcBC/XvbSOscArQFA3BJsav
ROp4HPyY9xQtynbvGAXD+NOPHuxDMU1bcMtaRN7UpQyhLC5lW/UPLYA9zKF2Zjnz
LunaUbG9prFTY5CjxehTGyO5lNjsIs0LOcLvEocPLo0q6G8XoRA=
=Jy2v
-----END PGP SIGNATURE-----

--=-uotSR0vwGFnDONb46hJU--
