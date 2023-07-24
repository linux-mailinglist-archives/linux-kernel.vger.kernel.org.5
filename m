Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10544760343
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGXXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXXm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:42:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3590310FD;
        Mon, 24 Jul 2023 16:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690242140;
        bh=swmpqi3zCu/7F+USpB91FA6B65YdCzV3Tq109TNTAXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F1oTrIfgRHYL2codGh1w2vQ+k7tOXE/XPJZfQoaRABtazGVZLkfrthOjW46tXSJBI
         3mNjd/H6e18xAcAbxxduSRJ/zaJVBv2zE7x3eqd0f2AwedRipX3mdhgWzm05KNlZGx
         NSRLJt/p+M6HskfyWZHUGcEPZqT+KTVcm9/e0fgPgmiGNiLoNRPS8PWBzZjyM0tAl/
         MT8lWcXOGoJaareCJ9qCW7Zf5sAd7xakpqhp26wjbCmEO6MW/+oSrcX54AHzY3p8WB
         lbAJ7BjJ5Wc/90K3lac/ij+/aMw94EsLQBuLV7xJ8eB72kSGVu8gpRNoIYccChjuk6
         SGlszJlkbjWjA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8xXX06LKz4wy4;
        Tue, 25 Jul 2023 09:42:19 +1000 (AEST)
Date:   Tue, 25 Jul 2023 09:42:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-next@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>,
        thomas@t-8ch.de, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Request for linux-kselftest nolibc branch Inclusion in
 linux-next
Message-ID: <20230725094219.7c1790fa@canb.auug.org.au>
In-Reply-To: <4a007283-be03-907a-094f-6651a44e631f@linuxfoundation.org>
References: <4a007283-be03-907a-094f-6651a44e631f@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M_+rX/v4Tb4g1.wahoMq+Tt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M_+rX/v4Tb4g1.wahoMq+Tt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Mon, 24 Jul 2023 16:22:16 -0600 Shuah Khan <skhan@linuxfoundation.org> w=
rote:
>
> Please include the following linux-kselftest nolibc branch for linux-next
> coverage. This will be based on Linus's tree.
>=20
> I will be using this branch to send nolibc pull requests to Linus.
>=20
> URL for the branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git=
/log/?h=3Dnolibc
>=20
> Primary Contacts:
> Shuah Khan - shuah@kernel.org or Shuah Khan <skhan@linuxfoundation.org>
>=20
> Please cc:
> Willy Tarreau <w@1wt.eu>
> Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
> Paul E. McKenney <paulmck@kernel.org>

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/M_+rX/v4Tb4g1.wahoMq+Tt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS/DFsACgkQAVBC80lX
0Gy9ZAf+P4CJi8z4pfX7bDqhTGuhy1fJD3rA6h8uRCNvUV6G++sWGjPW2AHl1c4+
AYC+o8SNSQz45PSBLRl207D+rR94o2H9oy6l1aZR49toC4/OgtJmlrox7PVEpQq+
1K+a0g0Ep8pFGMOWtGHsLdDiiFI8rKdRdE/j9OF3Hw4/DsiWdpvqpC0S3PoP7/f8
N9G3igvAzdCRWcXCjyT0sedbVGlaa/P2WpLZ/RtqsbAUajaV9y6BgueuGpxVaZ0R
xqvK7FzDX6r765Bfid9/qhsJmM+PkgmBBl9gG4aG6toIBxNyJNWXO4tR+71vtQ/L
c31+EnRvF9wNED1cFzfZRHukaX9Fsg==
=8BBq
-----END PGP SIGNATURE-----

--Sig_/M_+rX/v4Tb4g1.wahoMq+Tt--
