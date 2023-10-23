Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DAB7D3BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjJWQM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:12:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E28CC;
        Mon, 23 Oct 2023 09:12:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03081C433C7;
        Mon, 23 Oct 2023 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698077544;
        bh=qAfQfnASOwEw2I1gSh1b9F780q6nwNnSsTKiLZYyBng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzA9rfZ/HTWtxZjcRBdJNKOSmh83i3j8GjdkLLwpKO0H0+KVvubOCuu+yXp1q2JfG
         OGjMVjykfulsDO8fMaaVx9FUXu6Nu3/VvFMggrO9hqGdZ+xaL0IIYd8ltX5UMEPFvQ
         il+Wr8irRSLnuXdHD9OhO4M2f9QxXgeDgUVM0M9eJnVwlzisnooQHfOHhe52seCUBg
         GiVKIaTeweS00NGn7PW6BZyDjFs41Q4SJ0pgHfyc2Xyn+LLFgBC6Ou8KOGW0bfELDN
         f3zeAvuMDoqa6I2R+LtuRQyBBVtvQLLog2Onai3b2/bTJmtHOi+eQQkk99hIpbyCmi
         Ur02VlSxeGaWQ==
Date:   Mon, 23 Oct 2023 17:12:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] kexec: fix KEXEC_FILE dependencies
Message-ID: <20231023-grower-riches-76ab00195002@spud>
References: <20231023110308.1202042-1-arnd@kernel.org>
 <20231023-thievish-imitation-c7c4b36d76f1@spud>
 <67ddd260-d424-4229-a815-e3fcfb864a77@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RprDvLMNxjsipoGk"
Content-Disposition: inline
In-Reply-To: <67ddd260-d424-4229-a815-e3fcfb864a77@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RprDvLMNxjsipoGk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 06:04:06PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 23, 2023, at 17:37, Conor Dooley wrote:
> > On Mon, Oct 23, 2023 at 01:01:54PM +0200, Arnd Bergmann wrote:
>=20
> >> index 25474f8c12b79..f571bad2d22d0 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -687,9 +687,7 @@ config ARCH_SELECTS_KEXEC_FILE
> >>  	select KEXEC_ELF
> >> =20
> >>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> >> -	def_bool KEXEC_FILE
> >> -	depends on CRYPTO=3Dy
> >> -	depends on CRYPTO_SHA256=3Dy
> >> +	def_bool y
> >
> > This being the problem, KEXEC_FILE is 64-bit only.
> >
> > IIRC I commented on this same thing during the original conversion
> > patches.
>=20
> Does it work with this patch on top?

Yah, that modification builds.

rv32 being the redheaded stepchild strikes again :!

Cheers,
Conor.

>=20
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -687,7 +687,7 @@ config ARCH_SELECTS_KEXEC_FILE
>         select KEXEC_ELF
> =20
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> -       def_bool y
> +       def_bool ARCH_SUPPORTS_KEXEC_FILE
> =20
>  config ARCH_SUPPORTS_CRASH_DUMP
>         def_bool y
>=20
>=20
>      Arnd

--RprDvLMNxjsipoGk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTabYAAKCRB4tDGHoIJi
0ur9AQCKjo1eyI56rDJ+wq7ei6/ptwM4nKPVMtMwxDG4buP1AgD+MNiwYiopmEpR
Rg5VQw4r6QSCMkhYM0xu5fYVvRE9qQE=
=mhv+
-----END PGP SIGNATURE-----

--RprDvLMNxjsipoGk--
