Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F4579F502
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjIMWby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjIMWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:31:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE201BCB;
        Wed, 13 Sep 2023 15:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694644307;
        bh=CyH1Zv3KH+W4MxyueDaRkKjzluybPYNgh5g+mgCPnOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=udFKnoGSaD6NEnnwTIzLjl3vNeGdwRbR0JG3ZRxz2lVu13jllybU6dL2dvmQgz0xv
         fI3aRVyyWLvRVlwBDpcB8AYAfFyy1HDtvKrPMEuc/pU2oq6j6+u/BtHi0U7YoIDKpO
         nyuuUf8v0vBsKpE1Z2wJyh5adtE7L6wBnbc5hcVMe7458OpY0GADOBEuuc405rORMA
         Zfu2wvYd1zrTAzyuOhrDFa3OVYdnEG1+Nz7mUgHUidngd05dRTz9HrDB5gkrKaQ03k
         ySb5uJ/qP+m0IwdqV7Y8UIvNBh3g7iHliQqLrh1Mcz1CtGUEJYJQ77N5UwRddBZt+9
         BUJToAxoNGfnQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmFYb0tJbz4wxn;
        Thu, 14 Sep 2023 08:31:47 +1000 (AEST)
Date:   Thu, 14 Sep 2023 08:31:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20230914083145.17c2e7de@canb.auug.org.au>
In-Reply-To: <20230913132330.00b3ef07f696cf9efc4d0886@linux-foundation.org>
References: <20230912120429.7852428f@canb.auug.org.au>
        <e639a428-0fb7-7329-ce52-e51f7951a146@bytedance.com>
        <20230913093553.4290421e@canb.auug.org.au>
        <ada473e9-aa2f-c6ff-b869-cf94942ddd20@bytedance.com>
        <20230913132330.00b3ef07f696cf9efc4d0886@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UMIYG0d0=vFwzY14LgNDAzq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UMIYG0d0=vFwzY14LgNDAzq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 13 Sep 2023 13:23:30 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Wed, 13 Sep 2023 09:10:11 +0800 Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>=20
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Tue, 12 Sep 2023 11:27:22 +1000
> > > Subject: [PATCH] bcachefs: convert to dynamically allocated shrinkers
> > >=20
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >   fs/bcachefs/btree_cache.c     | 22 ++++++++++++----------
> > >   fs/bcachefs/btree_key_cache.c | 21 ++++++++++++---------
> > >   fs/bcachefs/btree_types.h     |  4 ++--
> > >   fs/bcachefs/fs.c              |  2 +-
> > >   fs/bcachefs/sysfs.c           |  2 +-
> > >   5 files changed, 28 insertions(+), 23 deletions(-) =20
> >=20
> > This version looks good to me.
> >=20
> > Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com> =20
>=20
> I not longer carry a post-linux-next patch queue, so there's nothing I
> can do with this patch.  I'll assume that either Kent or I will merge
> it later, depending upon whose stuff goes into mainline first.

Actually the correct plan is for you and Kent to inform Linus of the
need for this patch as part of the merge resolution when he merges the
latter of your trees (unless you want to stabilise the shrinker changes
into a separate branch that is never rewritten and is merged into your
tree and the bcachefs tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/UMIYG0d0=vFwzY14LgNDAzq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUCOFEACgkQAVBC80lX
0Gy9zQf/ejgWzw0Rr5H/Tffk6cv/jazjqQfd6kRbJSh6yrGxyhuH+Hb7/UQxLdYT
96ZTBPjlsE9oGEk90ukOFtYGhhebsa0D0hA7ZQpbiNIAftOPcvoCT9sTKeJ+aUo5
wqWWJYhI5WR4VL22gMFEVN7R9pHMPKpb4YOOh3LH4bkj67gxAFvxcE27m8W5ggHU
eWiDPWx3Z9bok8RGeLoZeZa1IbafIEwfKfDBUpUzR8wVzAvz//0spg9cByiVR+VQ
dPA966f2GlSN8LyWj7/s+NhEwFAmGa+Rem/Zvl8ju3vb89VD/tjzjw8itIEZVqEB
icMFgCGdN0D8Cdhe1GSQcQzhoX3zDg==
=47h4
-----END PGP SIGNATURE-----

--Sig_/UMIYG0d0=vFwzY14LgNDAzq--
