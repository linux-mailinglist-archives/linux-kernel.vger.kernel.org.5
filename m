Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68E37D5EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344726AbjJYAJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344663AbjJYAJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:09:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621010D1;
        Tue, 24 Oct 2023 17:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698192559;
        bh=/dPLz/UUEPyrz9+V37gfUQ/1jWhwCcantI4isgNsmf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TZYUP+ysGGM6yli2FDsx89ekkETbFFWa2/cYYQ/gQieZ6tAgmT+qktTRnwVUKbCsj
         HXkVbLLqooVCR6BBRWVPPzqY5bwXcTB6IrFQFKmNy2U46D+doY+h4g0Oi27OV337cq
         wW67iaolCaBy/J9J3AoeMUQ3O46OrCQyvWeCjzT6Es4l0LDfHyKFKpCzxosnQbS+Pb
         ajnlAQbYnEb7L4tiXCr9l9j9ZlvKsZv4PyPxX91opYkTbRwPxg+oSuDNsgeoLh9+j5
         EjkEJz7wCIe6O8ltmNe/vtiCWBajU6iFFcM7v/1//CMgUPVkdSsSYwcQofKZjcXsPV
         4UH/4mvg78NsA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFTnC53CTz4wd2;
        Wed, 25 Oct 2023 11:09:19 +1100 (AEDT)
Date:   Wed, 25 Oct 2023 11:09:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231025110918.5417ab87@canb.auug.org.au>
In-Reply-To: <20231024153229.GP26353@twin.jikos.cz>
References: <20231009104840.1bdadc80@canb.auug.org.au>
        <20231009-bauch-gedanken-e02e35804e03@brauner>
        <20231011083754.45a9ed53@canb.auug.org.au>
        <20231011092004.GE2211@suse.cz>
        <20231012154210.GI2211@suse.cz>
        <20231023175513.GL26353@twin.jikos.cz>
        <20231024082543.575b3edd@canb.auug.org.au>
        <20231024153229.GP26353@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sQaoBO2EQeMWvXziY0XFN/F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sQaoBO2EQeMWvXziY0XFN/F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 24 Oct 2023 17:32:29 +0200 David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Oct 24, 2023 at 08:25:43AM +1100, Stephen Rothwell wrote:
> >=20
> > On Mon, 23 Oct 2023 19:55:13 +0200 David Sterba <dsterba@suse.cz> wrote=
: =20
> > >
> > > I have updated my for-next branch again, sorry (top commit 1a4dc97c88=
3a4f763cbaf50).
> > > There are some fixes I don't want to miss from the 6.7 pull request.
> > > There should be minimal change to the VFS tree conflict resolution so
> > > the diff should be reusable. =20
> >=20
> > So, why did you not just merge in v6.6-rc7 (or better yet, the branch
> > that contains the fix(es) that Linus merged) and then apply your new
> > commits on top of that?  All the commits that were in the btrfs tree
> > have been rebased unchanged. =20
>=20
> I don't back merge Linus' branches nor the fixes that I send, that's
> against what I understand is the recommended practice. The development
> queue gets rebased on top of the rc, in that way it's clean and
> eventually drops patches sent independently merged to the master branch.

Please read Documentation/maintainer/rebasing-and-merging.rst

--=20
Cheers,
Stephen Rothwell

--Sig_/sQaoBO2EQeMWvXziY0XFN/F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU4XK4ACgkQAVBC80lX
0GzRMgf/YCA7AeSerC+aD8I+z7XGs+sHD4WVA5uArqsTMH33OARGkuDbLNu/4HkC
B7PxRCIMJQo4Ae0I25cCYoK0xKt17AkEWPUgY7wExrT9XwL9VzgNqnJGAhSA155F
y/YCaZVTVM7HNjZK04E64BYz/QGhQdbzwmv332LiP2q6SHFTcPXq+O0XApjWDEv1
QROZR3kfoDBfiT2M8qyLNi0ao8AKII93mrkvsrfO2V9VsdTG+tNBXR2M2QacTY+S
ko1Tx+zffDMG/tN5HWfOKEBDjB1HeeyluiHd3kTvH9oTkBmE6syZR6sYMOu8QAEW
VM7l1TQDkgaH6ikJXKxvhmcp2pdEfA==
=10zL
-----END PGP SIGNATURE-----

--Sig_/sQaoBO2EQeMWvXziY0XFN/F--
