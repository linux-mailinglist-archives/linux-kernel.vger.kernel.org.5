Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8806A7DB8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjJ3LJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjJ3LJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:09:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899159C;
        Mon, 30 Oct 2023 04:09:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50D5C433C7;
        Mon, 30 Oct 2023 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698664183;
        bh=7Is5mZRkBpmJqgtrKqJiMwJvcStuzj0Yd5n23xJQ1Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6NvMHCcQbR17HkQj5ZE1vsu/3lpuZJ2Y5UjrI+xVyYCvIf9KtDA3oC9pXD14P8yA
         MokpgzT1EQw4dsJ9846G5xdYc+Dbb+tw44wlNkbpYChAgQO0h+yd8oiyC0VXm7SbZ+
         noYOhqQQnrdfZazQIG/UPcr17B5EjWyClCCl+Su47n4y9rh+8USJj/nGFbUkkba5Za
         ZQi/3Qy+qOd77ETXnddFNLw75S9oGYeAWTHkq76oKhX0E3DbJO2VhZM2zYIf47f4va
         3gL2WPyhEh7S/QooYGvTrPrMHJtZzI2q0xccIBVN1E2FwziCTAlUA64HrmvCgAHAbA
         C8MbkQqm9Hpyw==
Date:   Mon, 30 Oct 2023 11:09:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: linux-next: Tree for Oct 27 (drivers/cache/ax45mp_cache.o)
Message-ID: <20231030-overhand-brittle-b2c4dc7ad4e6@spud>
References: <20231027180429.5f718601@canb.auug.org.au>
 <1ee2f92d-7aad-4140-9ab0-bc52ea0d6fce@infradead.org>
 <a7fe0eca-2a18-41b1-a0a9-e54a6e49903b@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ihK0gQBGsMu9kYtp"
Content-Disposition: inline
In-Reply-To: <a7fe0eca-2a18-41b1-a0a9-e54a6e49903b@infradead.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ihK0gQBGsMu9kYtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 10:17:35PM -0700, Randy Dunlap wrote:
>=20
>=20
> On 10/29/23 22:12, Randy Dunlap wrote:
> >=20
> >=20
> > On 10/27/23 00:04, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Changes since 20231026:
> >>
> >=20
> > on riscv32:
> >=20
> > riscv32-linux-ld: drivers/cache/ax45mp_cache.o: in function `ax45mp_cac=
he_init':
> > ax45mp_cache.c:(.init.text+0xe4): undefined reference to `riscv_noncohe=
rent_register_cache_ops'
> >=20
> > Full randconfig file is attached.
> >=20
>=20
> or with a different config file:
>=20
> iscv32-linux-ld: arch/riscv/mm/pmem.o:(.text+0xa): undefined reference to=
 `noncoherent_cache_ops'
> riscv32-linux-ld: arch/riscv/mm/pmem.o:(.text+0xe): undefined reference t=
o `noncoherent_cache_ops'
> riscv32-linux-ld: arch/riscv/mm/pmem.o: in function `.L6':
> pmem.c:(.text+0x8a): undefined reference to `noncoherent_cache_ops'
> riscv32-linux-ld: pmem.c:(.text+0x8e): undefined reference to `noncoheren=
t_cache_ops'
> riscv32-linux-ld: drivers/cache/ax45mp_cache.o: in function `.L26':
> ax45mp_cache.c:(.init.text+0xd8): undefined reference to `riscv_noncohere=
nt_register_cache_ops'
>=20
> and that randconfig file is attached.
>=20
> I also have this one on riscv64:
>=20
> riscv64-linux-ld: arch/riscv/mm/pmem.o: in function `arch_wb_cache_pmem':
> pmem.c:(.text+0x20): undefined reference to `noncoherent_cache_ops'
> riscv64-linux-ld: arch/riscv/mm/pmem.o: in function `arch_invalidate_pmem=
':
> pmem.c:(.text+0xcc): undefined reference to `noncoherent_cache_ops'
> riscv64-linux-ld: drivers/cache/ax45mp_cache.o: in function `.L30':
> ax45mp_cache.c:(.init.text+0x174): undefined reference to `riscv_noncoher=
ent_register_cache_ops'
>=20
> LMK if anyone wants the .config file for that one.

I think Christoph has already posted a fix for that one:
https://lore.kernel.org/all/20231028155101.1039049-1-hch@lst.de/

I'll look at the other one, if Prabhakar doesn't beat me to it.

Cheers,
Conor.

--ihK0gQBGsMu9kYtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZT+O8wAKCRB4tDGHoIJi
0oWcAQCRfMFgi2G6yLd1ro+KnsXU5vOCvzGFMAHYU6DVuma4NAEAv4ij3to+LO/3
TQ5ElxYhmordl/skVIXTKLIYGMB4AwQ=
=/Adh
-----END PGP SIGNATURE-----

--ihK0gQBGsMu9kYtp--
