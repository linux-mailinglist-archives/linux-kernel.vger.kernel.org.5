Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1835578409E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbjHVMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjHVMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:21:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AD6CD9;
        Tue, 22 Aug 2023 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692706848;
        bh=pU/Gx4YtZaDBwDUNfI1IoL0eeX0Rd8fwiRWuqoSHKjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oFBiE4dNJKdOG4oBrU6z/i+u2GNyRg7OpeGU8/x2GWlkgFhj7GJHx1BTVCa87EQpM
         H7PDtQ7T3F5m9eoxyQahMkxD6NA2jInYqbI0l1vKN0pY/OPAvOjLv2Dy/wWSLR6Lo/
         m3QXIbNnfVe4tyQvapA3dM+gaV8UktMVoOCWzvnoHYZz7ZfeEo4cpOPXxEm31euL1P
         hwTehIvnII1wKtt2H6uGslg4mIdgMErTCO41eT/qU46YRmKdOvs681hSSrmqxBMVYu
         l7mN3PpywjQX3GeVS22/EKzetqpoehex+XpIbO3KEAPLtWtLnoT0TUbMVXsDvOGJ8I
         NJCzqzT41+YKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVT2l5086z4wxR;
        Tue, 22 Aug 2023 22:20:47 +1000 (AEST)
Date:   Tue, 22 Aug 2023 22:20:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rust tree with the kunit-next
 tree
Message-ID: <20230822222036.3462aa57@canb.auug.org.au>
In-Reply-To: <CANiq72=DA1A5YyrWAPHEr+by_pac4R0-GemurbLWYNrSAUNSzw@mail.gmail.com>
References: <20230822162333.752217fa@canb.auug.org.au>
        <CANiq72=DA1A5YyrWAPHEr+by_pac4R0-GemurbLWYNrSAUNSzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HY7Ty=JOM3t9udWP3GUyVVj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HY7Ty=JOM3t9udWP3GUyVVj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

On Tue, 22 Aug 2023 10:15:44 +0200 Miguel Ojeda <miguel.ojeda.sandonis@gmai=
l.com> wrote:
>
> On Tue, Aug 22, 2023 at 8:23=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > Today's linux-next merge of the rust tree got a conflict in: =20
>=20
> Yeah, we expected this one when we applied an extra patch series
> yesterday. I tested the merged trees to double-check the (now tested)
> examples pass (i.e. the KUnit tree has a patch series which enables
> the testing of the examples in the documentation of Rust code).
>=20
> > - /// # use kernel::{macros::pin_data, pin_init};
> >  -/// # use kernel::pin_init;
> >  -/// # use macros::{Zeroable, pin_data};
> > ++/// # use kernel::{macros::Zeroable, pin_data, pin_init}; =20
>=20
> Almost right :) It should be:
>=20
>     /// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
>=20
> In case it helps for future similar conflicts, the reason is that
> there are 3 things we are "using" here:
>=20
>     kernel::macros::Zeroable
>     kernel::macros::pin_data
>     kernel::pin_init
>=20
> Instead, the current resolution would mean:
>=20
>     kernel::macros::Zeroable
>     kernel::pin_data
>     kernel::pin_init

Thanks for the explanation.  I have updated my resolution for tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/HY7Ty=JOM3t9udWP3GUyVVj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTkqBUACgkQAVBC80lX
0GzCQwf/W6SeDwVHRkawLfuC2UGSxkkKYvhAG69LVvdvXZZTHU1RES8CIVDgYAfB
j+dfy3LEIs/LnugmtwTCOiCpSiyG5ptg9ymrPAlIgi4WzLgJpjkbwUjDP3RNCS/p
ipCEmwq82M0uIFTM172WHML2Mt+/Xj2Qw79JJ7X6UClS1cN8YZ0HfF8OboqTZX3l
J5nueZMcBW2UPhkX+ltyYMQC6bRojkxfkZ2u7S3JA6NZ0hGuNrOP6DKnTGuTI6bN
7d52yDpGvPmfiHhGjUIVHbIESBwr0EZ7THzhmmcuVw/09uHTAdXGEZfNmcC+xKyR
drVNkXFHYvDQlUzYuiOReDjxfx9ZGQ==
=6ejh
-----END PGP SIGNATURE-----

--Sig_/HY7Ty=JOM3t9udWP3GUyVVj--
