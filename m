Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675967DDA38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376941AbjKAAdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376900AbjKAAdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:33:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF0124;
        Tue, 31 Oct 2023 17:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698798745;
        bh=6p1mMr2S18vzpg3JUCfuptuKroPdbAQKf0L4IgUzuzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VlvpLyoG6Pz8D1POVOZNP+cYbOVYpPyjxhbG6XKF1yXHC5vWhHAfpJit3J9q6sAbA
         LYNFY1z+fSbbgjNqdM5K5vkS0rEa6vlWWJfJXA80l11HmWnGgxRZtuGacmmcPLNQge
         BI5nBDxEeuQHIeRysAIdE8WCOiZZoO3kFZ7BDIum5SQ0YrCcMjr5MPEbPlOT2IYXS3
         NVl+5dYPbtE2+2QbRgqNrXkm9VGrZZZXGWhwAKhDuhfERuagyRlUD80EfZUnT7mrvx
         9FcRwsY+1AfIKaBqP+6od4LixWVJHCmZUEoYchwbZZueEuuGqgpjGVkvQyN+Xq4Ysd
         nRW83Caft0LYw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKnyc5F0Jz4wx7;
        Wed,  1 Nov 2023 11:32:24 +1100 (AEDT)
Date:   Wed, 1 Nov 2023 11:32:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20231101113222.13e7edc2@canb.auug.org.au>
In-Reply-To: <20230914083145.17c2e7de@canb.auug.org.au>
References: <20230912120429.7852428f@canb.auug.org.au>
        <e639a428-0fb7-7329-ce52-e51f7951a146@bytedance.com>
        <20230913093553.4290421e@canb.auug.org.au>
        <ada473e9-aa2f-c6ff-b869-cf94942ddd20@bytedance.com>
        <20230913132330.00b3ef07f696cf9efc4d0886@linux-foundation.org>
        <20230914083145.17c2e7de@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1.0EBoCEorT8Ulh4SIWeziu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1.0EBoCEorT8Ulh4SIWeziu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, 14 Sep 2023 08:31:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 13 Sep 2023 13:23:30 -0700 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
> >
> > On Wed, 13 Sep 2023 09:10:11 +0800 Qi Zheng <zhengqi.arch@bytedance.com=
> wrote:
> >  =20
> > > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Date: Tue, 12 Sep 2023 11:27:22 +1000
> > > > Subject: [PATCH] bcachefs: convert to dynamically allocated shrinke=
rs
> > > >=20
> > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > ---
> > > >   fs/bcachefs/btree_cache.c     | 22 ++++++++++++----------
> > > >   fs/bcachefs/btree_key_cache.c | 21 ++++++++++++---------
> > > >   fs/bcachefs/btree_types.h     |  4 ++--
> > > >   fs/bcachefs/fs.c              |  2 +-
> > > >   fs/bcachefs/sysfs.c           |  2 +-
> > > >   5 files changed, 28 insertions(+), 23 deletions(-)   =20
> > >=20
> > > This version looks good to me.
> > >=20
> > > Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>   =20
> >=20
> > I not longer carry a post-linux-next patch queue, so there's nothing I
> > can do with this patch.  I'll assume that either Kent or I will merge
> > it later, depending upon whose stuff goes into mainline first. =20
>=20
> Actually the correct plan is for you and Kent to inform Linus of the
> need for this patch as part of the merge resolution when he merges the
> latter of your trees (unless you want to stabilise the shrinker changes
> into a separate branch that is never rewritten and is merged into your
> tree and the bcachefs tree).

This is now a conflict between the mm-stable tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/1.0EBoCEorT8Ulh4SIWeziu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVBnJYACgkQAVBC80lX
0GwJpwf/csecxXPPdT/XePMK3t2Pqr81wdy9BzK7Au3Jrw/J3qL6MJbaXxf4ME7G
y8Tmfmcf6TLK2LWhvnV1T0lLlWC8UMJbCxvXp/AWj7mVLyeeyhNfecPGJXIjB7xF
z9mmocX83gy0GLcdB4XG3vZqCY++4wr2OJONrPd041nvENinqjsiHTMdh7JOdv7E
MwFi6Acf8bczrsDVKBkUfVIn5wP3Xd7UgMiHXlvtknTie5q9lCfyM8LuhpfGLoXb
UqiTxE2x2jQiM8fVkM8//5/qA+fKAGk+Pe5mN4FuHzqjkUJeoMIGYjp1yoWYgQCL
eT7j66WMcujmEWqXVBkKHhEcpczLCA==
=dLTC
-----END PGP SIGNATURE-----

--Sig_/1.0EBoCEorT8Ulh4SIWeziu--
