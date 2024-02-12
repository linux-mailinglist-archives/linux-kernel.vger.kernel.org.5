Return-Path: <linux-kernel+bounces-62372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C81851F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985C31C2237A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87ED4C622;
	Mon, 12 Feb 2024 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kyi0Bic3"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCA4C61F;
	Mon, 12 Feb 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772431; cv=none; b=AP9N1SGDAPoK1I1pG4ROW2deAdEbfNGFqjDRNvlPlT+9u8LIdVNK1ZU4PbyvvRIjKbKlOB5bLN+DQNuBGgZBFb/Lo8HGb9t/RLl+eFOtHAoNjZyoG2SwgYrgVJpm7AKlmQ8xlMZLXZRWvoeViTvDkQbVfzeEDA+8PbkvU/BfQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772431; c=relaxed/simple;
	bh=Tqh7OZHSz6fAN3kYNXxAMjdIAb78IYAc9VLmRUQtngo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6skmyGQQve8h9pFclqQPSiZSYzp2hQ2u0ymnSU0Gz8/GKnv0sCP93IuBH5Nh9Qcv8H4IC3M7tZqOiMZ4QErgBfcqjBesV1mJ8BPOuu5daIgahMcJpxBEyB61KoPRnn9gD0GWG2P3GiCU4fJiCoUqyBnQnv1T5u1XaSiuuif6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kyi0Bic3; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707772427;
	bh=yEvLWTPr0LqGWhlLjoaAQiYwHFzQnZvpJW4CZQANQm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kyi0Bic3YAJaDss26kfd/8UJrvaZQ3YSVGMuPX7GoottCIvIBDMA9a1wXXstPX2fF
	 auKKxBvZP5luN2wm7lvDctlt/J+va7kknf8giKnkZutstNeGvl0dHraM8Z1Osd194w
	 pJhxP24ePkMiyVL0cGwhP55VnH38GYicHzzLU8x3WajEy5AKPPJQwj8tLcy2FfNmUP
	 nH6TnCH5QgYD86nPApMQZY3XAVBGXeLNKlGmOamtFOwu7K+FCiEC+0q1Fzj9AGjO+6
	 3xckzFLYfOrZMceWVe9FWvWEwqLhsSqD06wUSR/SY86kmjqlPjeot51unTZxSgPw37
	 xmy309epKcmkA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TYcdP0jWWz4wcb;
	Tue, 13 Feb 2024 08:13:45 +1100 (AEDT)
Date: Tue, 13 Feb 2024 08:13:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, "open list:LOONGARCH"
 <loongarch@lists.linux.dev>, Huacai Chen <chenhuacai@kernel.org>, Xuerui
 Wang <kernel@xen0n.name>, dm-devel@lists.linux.dev, Matthew Sakai
 <msakai@redhat.com>, "J. corwin Coburn" <corwin@hurlbutnet.net>, Thomas
 Jaskiewicz <tom@jaskiewicz.us>, Bruce Johnston <bjohnsto@redhat.com>, Ken
 Raeburn <raeburn@redhat.com>
Subject: Re: linux-next: Tree for Feb 12
 (drivers/md/dm-vdo/thread-registry.c on arch/loongarch/)
Message-ID: <20240213081344.5e80d898@canb.auug.org.au>
In-Reply-To: <ea0554f6-e0f6-44eb-b98a-d25772273f6e@infradead.org>
References: <20240212153137.2c37f7e6@canb.auug.org.au>
	<ea0554f6-e0f6-44eb-b98a-d25772273f6e@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dDfWQ+Zn0XM4tHQuoUT5JSr";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dDfWQ+Zn0XM4tHQuoUT5JSr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 12 Feb 2024 12:33:08 -0800 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> on loongarch:
>=20
> ../drivers/md/dm-vdo/thread-registry.c: In function 'vdo_register_thread':
> ../drivers/md/dm-vdo/thread-registry.c:32:28: error: 'current' undeclared=
 (first use in this function)
>    32 |         new_thread->task =3D current;
>       |                            ^~~~~~~
> ../drivers/md/dm-vdo/thread-registry.c:32:28: note: each undeclared ident=
ifier is reported only once for each function it appears in
> ../drivers/md/dm-vdo/thread-registry.c: In function 'vdo_unregister_threa=
d':
> ../drivers/md/dm-vdo/thread-registry.c:61:37: error: 'current' undeclared=
 (first use in this function)
>    61 |                 if (thread->task =3D=3D current) {
>       |                                     ^~~~~~~
> ../drivers/md/dm-vdo/thread-registry.c: In function 'vdo_lookup_thread':
> ../drivers/md/dm-vdo/thread-registry.c:84:37: error: 'current' undeclared=
 (first use in this function)
>    84 |                 if (thread->task =3D=3D current) {
>       |                                     ^~~~~~~

Caused by commit

  bf28b754d024 ("dm vdo: add thread and synchronization utilities")

from the device-mapper tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/dDfWQ+Zn0XM4tHQuoUT5JSr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXKiggACgkQAVBC80lX
0GzSJAf7BwW0B5X4fJLFTv3mfUFzaedq4PNloK8E7F8roeGBZJ5KyvRUzItV+dP2
ein1Swgq4mtxTg/9DSR3Oqu924EejTwFRuSjP+J3W+eNUht8Sd9GnBXl45ErRNpB
NrThW8fwt0IcsSi0aFEzW+sd1Upv4lM9E/BF0oOOQTv0Q+ohRWKlBeH8GQy0ZgPp
L0RsB/18LKm3/+dmwbyk/0FC8UIpE6b7pwVfpr+p+mRiPBjE8qrKIc7zo+9oqysR
1B4ZDEMcdWC8o5MdWKWNvbeCHvBy4HNjLTDRmDEHe9eD/dccnOfcQW4JAG0zRSsz
QkkxWuLgnE85igUrBdCKtGTB7o4m4w==
=lZ5G
-----END PGP SIGNATURE-----

--Sig_/dDfWQ+Zn0XM4tHQuoUT5JSr--

