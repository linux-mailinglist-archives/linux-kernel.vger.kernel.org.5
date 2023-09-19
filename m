Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9607A6F54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjISXSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjISXSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:18:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D3883;
        Tue, 19 Sep 2023 16:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695165518;
        bh=xY1RGG+/0gscDLeveLulvpHm4mxxLb1AS3ZtO6C8wPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u7IryiMQCWMYh8OgqVTiLRag6b+LKE68Td/Fqt2t8ejVaZYhpSZivUyUCXZfEyUNE
         KHYL90KSWCsmmFQmSKkU1Gn2t4Hl94ykWXllMSALprpWlo/CsAaQKep5yDwZJR8SNs
         31VSETOISiQ4DIHaS9I0eBmunvRBq8hRym1IgApCYaGfYEHTDFpdonLS7MMMJYypJH
         bhoPRtQIvzxG8/wMJxLKiNBQqFxsi8sivCfho6fFSOQqmfCMwDfHINpnwFKlzkObfq
         s3ws8q7IoAhampFqNxZfHJkdb5E0WEHZZmuA1BkruLzUt38h21e05w1PZPnxb0sDtr
         aWCVZIDgahaMg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqyJs0gcBz4x2X;
        Wed, 20 Sep 2023 09:18:36 +1000 (AEST)
Date:   Wed, 20 Sep 2023 09:18:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>, llvm@lists.linux.dev
Subject: Re: linux-next: Tree for Sep 19 (UML)
Message-ID: <20230920091714.10053ba5@canb.auug.org.au>
In-Reply-To: <ZQoQLJnGFxjA8p5E@google.com>
References: <20230919163728.78432283@canb.auug.org.au>
        <04b8a6de-2b20-4488-b20f-c8a8f6001fd2@infradead.org>
        <ZQoQLJnGFxjA8p5E@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8qozy5L20AH8hxRIxoLg6wM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8qozy5L20AH8hxRIxoLg6wM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Tue, 19 Sep 2023 14:18:36 -0700 Nick Desaulniers <ndesaulniers@google.co=
m> wrote:
>
> On Tue, Sep 19, 2023 at 08:42:07AM -0700, Randy Dunlap wrote:
> >=20
> > on i386 or x86_64:
> >=20
> > ../arch/x86/um/../kernel/module.c: In function 'execmem_arch_params':
> > ../arch/x86/um/../kernel/module.c:54:50: error: implicit declaration of=
 function 'kaslr_enabled'; did you mean 'kasan_enabled'? [-Werror=3Dimplici=
t-function-declaration]
> >    54 |         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled(=
))
> >       |                                                  ^~~~~~~~~~~~~
> >       |                                                  kasan_enabled
> >=20
> >=20
> >=20
> > git blames this on:
> >=20
> > commit 12633d679796
> > Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date:   Tue Sep 19 15:14:03 2023 +1000
> >=20
> >     Revert "arch: make execmem setup available regardless of CONFIG_MOD=
ULES"
> >    =20
> >     This reverts commit 3300c3af20090ff5e03e5c4bf2ef2cfaa03d4e9b. =20
>=20
> Thanks for the report, FWIW, our CI is hitting this, too.
>=20
> Was 12633d679796 a pure revert, or was it manually modified?

It was a pure revert due to having to revert a previous commit to fix a
boot warning.  These reverts should not need to be in the next
linux-next as a patch has been applied to the appropriate included tree
to fix the boot warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/8qozy5L20AH8hxRIxoLg6wM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUKLEQACgkQAVBC80lX
0GxoOQf/XQ7ER7U9A6iIEj9PX4LP6EQ/HJ58Pci1hVo+3wldY5AcTdhqK6i4QXwa
xTyJfM/SDomXy+CiVDcLbl6x3Ep6xR1OKq0X1UITnkAFlzxPqpbWjDhVdWpCTNW1
It3Ollb830saEKbHXeg0yYguhXT7xnBnp18O1qqfHlzkh7RP7ZptTGySM3x/WI+J
W2ZUnsaMDBdHyApjTWvWJySVah7qzDAPugZ2AVNW0JptXNOOQFxkyOnllLAtTMcf
LhYQYK0uhbOCzQFxRCSHR9u5+aNmO4c7+ik1+GYccuUYV5jnyKBj9u89W5o48Fyz
vdzEljIWSpee4gAaGr+exX9mIDQvdg==
=1tlz
-----END PGP SIGNATURE-----

--Sig_/8qozy5L20AH8hxRIxoLg6wM--
