Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C901776BE2B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjHATz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHATzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:55:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48820E67;
        Tue,  1 Aug 2023 12:55:44 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.66]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M6ltQ-1qUnrs0c2A-008G8u; Tue, 01 Aug 2023 21:55:10 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 93AB33F721; Tue,  1 Aug 2023 21:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1690919704; bh=BT1hm3et5GymMONcBYkUUy5AjpfOPZg77sIrTzibPuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eu3nuPxOQVnkHeuDmjn+t1veLWaDARXgspqGbr70cy3c29+SvFA1NEOM6SbZ61JDL
         8qEYnZG3yEnmyMenhdJFfdFI6DK9htC1oM6gwkgRvDJ5wR2kwJA+ntkQHOrelCxR2H
         yb+6arM42eY+EOQM70zI2j7qw8kBp+Adf3+Cnldw=
Date:   Tue, 1 Aug 2023 21:55:03 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 1/2] kbuild: deb-pkg: use Debian compliant shebang for
 debian/rules
Message-ID: <ZMljFyrNaH2HFXSU@fjasle.eu>
References: <20230801121926.1677205-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XvHK78VNyfppXqPR"
Content-Disposition: inline
In-Reply-To: <20230801121926.1677205-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:rBN+XNUh2m2BqvCcVo2Nm18l+zIR5/7SjMVXPxMKI2CH0JJ7MVO
 ZdwtMUFtIItR8JPbIaNnwPF4P662ihYoTAgityZ1Pu6UxprdRQXaXeodCeyH5TaadGYfw5L
 ugdSOsvmcWoEffqb6WPDnab4HBNIkYyTrWZtTQPFhHSxMCsedLOCMuw6N902J2GE+4SVq8+
 tqchUd+s2oQ2YGDAkz4aQ==
UI-OutboundReport: notjunk:1;M01:P0:MjUxifUBGQg=;5VnuFQp460+h0x1S3V38cEZhRBT
 /QtwPKLkGQN7+ZBQT6y536yQv/244+qCTxCOrlxboDgmdGTJvR+sqouj0W0oucpsVpgkgM4qz
 BCv4Gpl29FWOk8/YfqP/CRKRy6MnjL/J85U+uPVLfJFOfVrirLnjfwRy8rsg17nowq4S5AI0M
 f3zxEBvRe7AZwNwsMELFDZ0NecamMC8/mArgD4aIlM5UawU7WTyVutHzpOtjTmRI7tq+0bYCW
 inRTzbk3qTUuB0wNxf3uRWuO0C2Oe2BgYzzqcdEetA+WTZSURKW0WECRM2PzhDd/ejHXlVt2o
 DbtJvB7eDy59cG1vYIOG1iNtCyM1FbnYFpCKhU3MNP9znGmrz378a7Zv3dtKxS+XPBoHCpASV
 /9Buzt7/LMRjpcE4BoE6/BpSnhBZ15eb/gQb7o65GHKsuLGSH07yVr1zCcsDsHCn8WMUWSCim
 l7/rVDFVNwHxIdHUkeNOJ02MtU+8wl/pgVp75ut+y2RNjBJU7p+0jpvl4QgzfvBMUzVbaJnFB
 JmKss/uni9MWvX6U6urxWlMDwivMgwEfa7WI+P/ocGUBCIaXwCtnSpA8+IyaJpFBE/IYfcICl
 mv6O77zW+D2gnL+Z+HiaDin4oPiDKINnOoZc8dAGbSePKbNjJmqziRCiC+ZKJyFvI9GwC6k/s
 BRd/mvt5lHdAVq88NMLzH4D/ZFpPk98du6O/66UZ1dajbXz+ToCawBrJfk2zcbiPfrKhLM922
 O12q8fen86hTRdLeCR08UE4xrvxyOxfaTMWAuZW3wRhno2kKR/LeYorF9b7fSCtp/rF6VqQzD
 TxImFebMh9JhhE5wY47NbuoCEfTouZI5bWKTOJ/zDURfQ0IXC44ocGqb5gB/sj2hPeRgZYAKZ
 r7HHhwDy8DeIG6w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvHK78VNyfppXqPR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 09:19:25PM +0900 Masahiro Yamada wrote:
> Debian Policy "4.9. Main building script: debian/rules" requires
> "debian/rules must start with the line #!/usr/bin/make -f". [1]
>=20
> Currently, Kbuild does not follow this policy.
>=20
> When Kbuild generates debian/rules, "#!$(command -v $MAKE) -f" is
> expanded by shell. The resuling string may not be "#!/usr/bin/make -f".
>=20
> There was a reason to opt out the Debian policy.
>=20
> If you run '/path/to/my/custom/make deb-pkg', debian/rules must also be
> invoked by the same Make program. If #!/usr/bin/make were hard-coded in
> debian/rules, the sub-make would be executed by a possibly different
> Make version.
>=20
> This is problematic due to the MAKEFLAGS incompatibility, especially the
> job server flag. Old Make versions used --jobserver-fds to propagate job
> server file descriptors, but Make >=3D 4.2 uses --jobserver-auth. The flag
> disagreement between the parent/child Makes would result in a process
> fork explosion.
>=20
> However, having a non-standard path in the shebang causes another issue;
> the generated source package is not portable as such a path does not
> exist in other build environments.
>=20
> This commit solves those conflicting demands.
>=20
> Hard-code '#!/usr/bin/make -f' in debian/rules to create a portable and
> Debian-compliant source package.
>=20
> Pass '--rules-file=3D$(MAKE) -f debian/rules' when dpkg-buildpackage is
> invoked from Makefile so that debian/rules is executed by the same Make
> program as used to start Kbuild.
>=20
> [1] https://www.debian.org/doc/debian-policy/ch-source.html#main-building=
-script-debian-rules
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


--XvHK78VNyfppXqPR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTJYxYACgkQB1IKcBYm
Emnw6BAAx1BI66MtzwMSqvDYKDHqiNP6RVUbqqE+8dgAUjINHp1uKM6jjyDjjxAc
NpDGFDxHBNsnh6kZkRDuulayMKwRjCboRk4w0FGDJKk9xKrWFMPdL3eqLg3Csjiv
KsbgVWUeH8bDc/vlNPO+w2vyay8pEUiaE35/FyW+GibjaH4P7kZ7zziuYQZly49x
Wcot1PcJuOfYk6veaiRDYYrAmlMdVC458Xl/HT/NxaNZnPxFR35DwH7mqQiX9mVR
0cEawnWckHPbusXIpQbJFB2Mdf8iJgYng6qzAmj9Yn/nCn55HmnKuHfx6dbO+mFF
fHvqKDqHmo6wzsLq5owXjs7dCY40K25w9ojfgAtlx+p1TZgDWvq3nVut/J/evfPu
9dkH0KQnjDli5pZ6aw08yKYOEvfdaSO/m1+SrC3LHrIsV6hnTqu+KQNlHChzvnhu
5rho1Gc0+F4zj3q7WFqUiYFio9t/17Im1btr7a2HMLcnfnVnUzzo5N1keA7hX3e7
JuESHGQsAk+zRKi3SUSZlb2ZewPZEELLBwMDKbC7fT3uSCeQro16Wq6xeQd/9bqs
5yY0DTa34Ccrg/VtohldjLBZ2k/0sfR7qRI3JBAGzPsOkvxtj1hgMsAzSn2p84DW
/H0lgCCdDR/xGTny8k5RRz54t31Qr6UYE3AFOZ8sjN3xUydIcd8=
=61wu
-----END PGP SIGNATURE-----

--XvHK78VNyfppXqPR--
