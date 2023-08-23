Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2ED786156
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjHWUXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjHWUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:22:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFB1A5;
        Wed, 23 Aug 2023 13:22:35 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.46]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Myb4H-1pny9D3YQX-00yugP; Wed, 23 Aug 2023 22:22:07 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id F28413F8F1; Wed, 23 Aug 2023 22:22:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1692822124; bh=AOW2fmZmr7LrVSF5fWz75BPlc97tS3c2Wia5W8HVJoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpVXaIYnq771ZzuDovp81sm+W1SiE/Kpxmwo4vwTB3oRr943Bi7ACckEnLM/LOgAf
         U0WDVXKoB11ROL8rO81fnHM9ssG+KZfyRmPq1+DQJB9AdikH2Tb8HS6C/RBiyFg7xD
         dwR2hdD5YuEV9lqycGD+OIPUGHzZ3tNuG0dGWw6c=
Date:   Wed, 23 Aug 2023 22:22:03 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 5/8] kbuild: reduce the number of mkdir calls during
 modules_install
Message-ID: <ZOZqa8mk+4uKY87f@fjasle.eu>
References: <20230823115048.823011-1-masahiroy@kernel.org>
 <20230823115048.823011-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o5EJtZiqoKH2Vpj7"
Content-Disposition: inline
In-Reply-To: <20230823115048.823011-5-masahiroy@kernel.org>
X-Provags-ID: V03:K1:TTc0SkZNtgF+bDdChsYX3XfSa9rpUDhlj6PwO2o5iHbjeVakEyW
 CPGxIi4WxqyUF23AvE8gkB7KM6Y7WqWNXaR0dLRLU7eWz/VftmGBuTu/NV/nfdY1NBiKDkG
 HZ2HfiqF0jxSocTvVxFXsTz1Av8/3RbOcODwJlnsLiP8hW6DTDKFfzGIVXx8RE4wIFgGVpr
 TYQbYsW+sCsdSfLuaq3fg==
UI-OutboundReport: notjunk:1;M01:P0:4tPwYQtoysk=;+SIcE3U/enprLx4pdGESBKJ+MGe
 98KdSKL/CaAo4BqKHtSeWe0L1UPmKOLAI5MgQMXgR8Mmj/VoooDTy3QAXISSEEB1NJa+jMJif
 faL090D0gEviPPtRoQaiJeOJ7g4THJh+0yXtle2PQpOzE+hgATecZRw/H1BQW83Vgda3mEGXA
 bY+ng0HPXmvdM1z1asmsLS33E/rmv6+hnqrC/mC9iBKjJFWDBObUDkNXzBW8ndlsc4rVvzmLL
 b/MJrRwjh+L1b8K5GVqxYQlEuJd1BwH1QDB1F3UM/rST/JGAQmh/nOLzsN4WqHUmhUaZTSrny
 ZjT57+0f7P4Sr4/vsP/K8v+Jzsw+qOAH1mSI+eXgc0ZAwU7mXq8CF3lcztP7sfFd2nZaeZqMx
 7Z6LROQB2b+pQTgNOi22+pYv6bjwyyUdzruzNPHeSwRHbYfJzkUcJFC8Ruie/4RtrB+iZq5i5
 isoG+M+LhyN3Uqf/5DsDUZ3tFV3f1HTYk+ooIe22sbnP4qYh6ZPyRiH8KLIoalieXk4c+Pf7D
 xbeVNxzxVA2rxWLe0rdizyCS7bUOzfA6oUFaAU3/erIKRYsbHnWcsZzYsuqYOYpoEyfcojcPO
 LFNc3s1lg5n0OEBUIPf9A48mIfFmU5nOioea55InL5W0zZrHefTXGUymExr8gHbG8nAkm0Fia
 eFU2BhSI93yzagzGZ55Mq9HFc/czUDKjeBrZ0jqg1LTu2bvo4VPWtkqwQ6m0ijR24styWUaCt
 oLMn4/3Cgekl/0nlqkJU/uoXORCGJAXRpTW4/wXhYygEoOdKWhElOEVIAeyYXmI8Qa8BJL9T8
 29snI5sq+4c1vgRTNlX9aiOof/CoiR36h3hQLR5thUOt83/9CoAKKRofCd195JybrNdHzmOQM
 abP4P3s6rjaoTgdbkrqmJ03iul2X8Mwc+My0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o5EJtZiqoKH2Vpj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 08:50:45PM +0900 Masahiro Yamada wrote:
> Calling 'mkdir' for every module results in redundant syscalls.
>=20
> Use $(sort ...) to drop the duplicated directories.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Makefile.modinst | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index 7a64ece9b826..5d687a453d90 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -9,6 +9,13 @@ __modinst:
>  include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
> =20
> +install-y :=3D
> +
> +PHONY +=3D prepare
> +
> +prepare:
> +	$(Q)mkdir -p $(sort $(dir $(install-y)))
> +
>  modules :=3D $(call read-file, $(MODORDER))
> =20
>  ifeq ($(KBUILD_EXTMOD),)
> @@ -27,6 +34,7 @@ suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:=3D .xz
>  suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:=3D .zst
> =20
>  modules :=3D $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(m=
odules))
> +install-y +=3D $(modules)
> =20
>  __modinst: $(modules)
>  	@:
> @@ -35,7 +43,7 @@ __modinst: $(modules)
>  # Installation
>  #
>  quiet_cmd_install =3D INSTALL $@
> -      cmd_install =3D mkdir -p $(dir $@); cp $< $@
> +      cmd_install =3D cp $< $@
> =20
>  # Strip
>  #
> @@ -95,6 +103,8 @@ depmod: $(modules)
>  quiet_cmd_depmod =3D DEPMOD  $(MODLIB)
>        cmd_depmod =3D $(srctree)/scripts/depmod.sh $(KERNELRELEASE)
> =20
> +$(install-y): prepare
> +
>  else
> =20
>  $(dst)/%.ko: FORCE
> --=20
> 2.39.2

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--o5EJtZiqoKH2Vpj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTmamsACgkQB1IKcBYm
Emn4ZRAAs+NCoU6CVUVwcPq6ecY6hpQZWzz183tPzEfMA5xqf0kid+PAhvnsbk+l
RROLu51C4Yy9WQRrOIz3R2i0CztyBVgz7TkAuQzZE9/YL6CqFfVVifToaIabP9C9
k46llJAU4P97RbbxffOR74expjUz4/4gRM40UXl2/V81yb5+ddhrSP7W1wPQit+0
zPO47FaetM8yUxh8T5BV7abDVQVpgJ60OVNRyfUxnIv/RQQ8s0ZfIrdQDwq679ll
4XrfYYpxmoZSgYd0w/ogkMrzO+K7zSC5U9Hl5n76YWXQQb0aIwkQ8RR53ZHcWu4v
Pqp68953t5aVvMQ3DQbM5zWC0bdMasJ/m11guCdovTcjjBncePH4pzW/A31XG5Rh
RQf8rZRGwlQSqtygZh0dpovmxCtiNvbq9i4LLmTj1bpBv72Rh5NwTXWlneuJ+FRN
uWliap16X050J0ycCc4L2jp7j9Nl5wHa+DRF4VQ3j2roq/CkTFT1gPxsuKbKAZCD
JzFxbaFpbMF4KfCVNLh5FF6gonKkk3YdyiRonQpd9kntITmltw5z+TYVvXbgTZSr
0MCoZnEc9E9szeEvokGyGQMvhOl2VEvFi07OW3cyIooEtlQQmx7S8ZHf2jCn+rm9
zEIR6K+e9DLvec9VKD12z/C2knbt07JBG489Q3M2EAoaB+dFrBA=
=+HnJ
-----END PGP SIGNATURE-----

--o5EJtZiqoKH2Vpj7--
