Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678717CEE97
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjJSETd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSETc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:19:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F85B121;
        Wed, 18 Oct 2023 21:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697689168;
        bh=y3lM9sVJ/5rYnLLJqPwGOLVQo3x0zH1aI0AdCt5lKvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HolbH944Z1ffP79WWjoCrUJ2CLG2CKdtIwSX8nO83ZRu11ojSRssFEqqUp7blUHmo
         z2s0goahOpwHspiWCOtfi/DNkcekJr/pR/Wcrqk2aQnmAm1pmyUV0pOK4TI0Z2twDN
         pp9OzVCx2biirQ/XLxUy0YSaOQQ5ju+fEkPRdSQoS3tJgm0EIe+dWZ34QT0CtsdKkw
         +jkDQn0PIdi4Tm7cyUTpuVWxRl8r1MkIulbEVutJIXYQazlehrjAa+mXGOOFUzfdkt
         QfaIgtD6q69FVijmiHYouUzJhqVczF6rQhq8Siuz8BMGOS0km9ab8cPNdWnU4pPy0l
         yJ+MVbK3XGfag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9vcc04D4z4xWn;
        Thu, 19 Oct 2023 15:19:27 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 15:19:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the efi-fixes
 tree
Message-ID: <20231019151927.2a20d800@canb.auug.org.au>
In-Reply-To: <20231019145404.63bd38ca@canb.auug.org.au>
References: <20231019145404.63bd38ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nu1=GzIZq1fgE2iaHx6JLVK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nu1=GzIZq1fgE2iaHx6JLVK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 19 Oct 2023 14:54:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   drivers/firmware/efi/libstub/x86-stub.c
>=20
> between commit:
>=20
>   db7724134c26 ("x86/boot: efistub: Assign global boot_params variable")
>=20
> from the efi-fixes tree and commit:
>=20
>   50dcc2e0d62e ("x86/boot: efistub: Assign global boot_params variable")
>=20
> from the tip tree.
>=20
> I fixed it up (I just arbitrarily chose the former) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Well, that didn't work :-(

I ave used the latter version (i.e. the tip tree one) this time.

--=20
Cheers,
Stephen Rothwell

--Sig_/Nu1=GzIZq1fgE2iaHx6JLVK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwrk8ACgkQAVBC80lX
0GxGUwf6Au6HrVYERwExXwObgn3HjPSeMtJnB5DI57PGkUUv07A6WAW3QZHY1Nuf
F1WEMsKe3yNYkS0Y4h/48C7Y7Tfaz702+gF8YxOauZyMzLWZfZk8DiR7VisIQDa+
9yqsrV7dNqFkUQ+7TAQXGrouxRfc20RZB2cmlLfqI7RtW5RRZ+IjarENzb59dFrM
Otly3MmAo7J24smX+o1KgnRF6ijFLRPFKlsNbbe9Rt2nQqVdy3jmyaeKp1DJiNP3
eTZVRg5eVleFQ5wTl7bmbGPBOqGovIILml5wWZlQFblh6kxLLp7fKGyo9rs1li5d
x1ILa5BrrM/NQ/wHmCssV/84XJa+ag==
=2arr
-----END PGP SIGNATURE-----

--Sig_/Nu1=GzIZq1fgE2iaHx6JLVK--
