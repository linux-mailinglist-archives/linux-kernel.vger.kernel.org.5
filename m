Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A57E7D419F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjJWVZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJWVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:25:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEC497;
        Mon, 23 Oct 2023 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698096344;
        bh=7uXHn8pBcJ0jOZNZBOlglgGkqTNXgYQlWSwFgLjI7R0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aJ2YYv0HfyygmNj7zfnXZZHS4mPnRbad83wFeMRyRpVkUpTe8Eq7nA0dwRcafDguz
         7CPeMxc4P/XWCigrOXt5qGaDCdWbukDGZOEW7lGC9OXcLY4SeBTlo734QJMnKoK76n
         iLm2IUf2KO0DLvLeHsGtnVVQsJnEBRQOoM31hwe39xaMBsVtM1JI17UMUdpp+OwKhH
         fKOAucsfICYDFMjT1Vq+vTqUtDP6/75kD14NCjDu76oNJ17ULqvRknaX3R0132bWHe
         UcHhyYOJ+2jWPX0m+Hn+MaxJrGSDXNyAqCFfjd4t8hMICQyo8nFeGD3Fm/byVuucA5
         z6EN6O4X9eA/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDpBw08Rgz4wcZ;
        Tue, 24 Oct 2023 08:25:43 +1100 (AEDT)
Date:   Tue, 24 Oct 2023 08:25:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231024082543.575b3edd@canb.auug.org.au>
In-Reply-To: <20231023175513.GL26353@twin.jikos.cz>
References: <20231009104840.1bdadc80@canb.auug.org.au>
        <20231009-bauch-gedanken-e02e35804e03@brauner>
        <20231011083754.45a9ed53@canb.auug.org.au>
        <20231011092004.GE2211@suse.cz>
        <20231012154210.GI2211@suse.cz>
        <20231023175513.GL26353@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AT3nUgAc7rvRCgMGlJb6co9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AT3nUgAc7rvRCgMGlJb6co9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 23 Oct 2023 19:55:13 +0200 David Sterba <dsterba@suse.cz> wrote:
>
> I have updated my for-next branch again, sorry (top commit 1a4dc97c883a4f=
763cbaf50).
> There are some fixes I don't want to miss from the 6.7 pull request.
> There should be minimal change to the VFS tree conflict resolution so
> the diff should be reusable.

So, why did you not just merge in v6.6-rc7 (or better yet, the branch
that contains the fix(es) that Linus merged) and then apply your new
commits on top of that?  All the commits that were in the btrfs tree
have been rebased unchanged.

--=20
Cheers,
Stephen Rothwell

--Sig_/AT3nUgAc7rvRCgMGlJb6co9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU25NcACgkQAVBC80lX
0GzE9gf+OuDtCnNFpw5eqx1zq5PigPgMZgPbQ9glGv+ObDUVGNxi+IbhqKgKTCux
UbviCpVeHt5aqXqlWLdLt5jpQPrR6QfUuadeBr6b5sP4INvdmYpo9fwqCKgRNecu
rS1Uf2cOAKZNUimMMBYjfcPY7DywuGoLl9Ue0i4+bqfcK7MxPQ0IP8eOyzOaw8AT
Dvrz07vu9M9jlZWaIy2FE0KHomWQeMFwsKd9Xlggm6JpZDB1I9hH5HoI5MS3/cxQ
FmUOZz8kLMoIJw3UXV961DKizjOgEqDI+qaPKWiN9UE2ZAMsLoagKImz8JcJXvlB
/GL00jvoUWH1IpCTGCxYekPS+4Q18w==
=v3KC
-----END PGP SIGNATURE-----

--Sig_/AT3nUgAc7rvRCgMGlJb6co9--
