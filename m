Return-Path: <linux-kernel+bounces-8558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66E981B963
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C7728300D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EC66D6E1;
	Thu, 21 Dec 2023 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Fm3ZJ7Do"
X-Original-To: linux-kernel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E746D6DA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703168142;
	bh=e9zgLuGXGOkHT08UsGiv+toaaavLusIfuE7NOP8bEOo=;
	h=Date:From:Cc:Subject:From;
	b=Fm3ZJ7Dout40OOeAC7t3f9C8CCRIX0jDilznPUWirzLMyRVLRC0PB4gsFmAH6lWA5
	 Ad/KyglEkUJBuExxSooSL4Mycy9ZqHu4ABjbsDkoDoACzVP0mQXZ4n62WmAAvVnSHl
	 FgL5UIXI56AwJwXFB/aHZRa8OS8LVZMgWfPqE0ehvQ8nOzUCmKCYBj5xhTuwa3k3pK
	 nnhw2LlRRXiQMlJKO6NwR2LITOYVrE9srLHO3FFpWcjTMpntZ9raGvxYede2MqMOpQ
	 MyotxIrvxGO2mbQCcQZsTclItvQue3qw3O1QB8no1AigRIBb+4EHzlvjeNpJBPz9du
	 tXj/BE+9kAo3A==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 353CB13F14;
	Thu, 21 Dec 2023 15:15:42 +0100 (CET)
Date: Thu, 21 Dec 2023 15:15:42 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernfs: fix reference to renamed function
Message-ID: <4f2wybrepigxjpuxj4bdkh3qmksetfioedit2bdrswf6b75ebb@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="swytft7g5yl76e3v"
Content-Disposition: inline
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--swytft7g5yl76e3v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

commit c637b8acbe079edb477d887041755b489036f146 ("kernfs:
 s/sysfs/kernfs/ in internal functions and whatever is left")
renamed kernfs_file_open to kernfs_fop_open, but didn't update the
comment referencing it.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/kernfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f0cb729e9a97..ffa4565c275a 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -447,7 +447,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm=
_area_struct *vma)
 	 * warnings and we don't want to add spurious locking dependency
 	 * between the two.  Check whether mmap is actually implemented
 	 * without grabbing @of->mutex by testing HAS_MMAP flag.  See the
-	 * comment in kernfs_file_open() for more details.
+	 * comment in kernfs_fop_open() for more details.
 	 */
 	if (!(of->kn->flags & KERNFS_HAS_MMAP))
 		return -ENODEV;
--=20
2.39.2

--swytft7g5yl76e3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWESI0ACgkQvP0LAY0m
WPGrgA//RpamixrMC5pHedSNxq4tHAUynt7Ohs18G629gD5hkEDBHPDJNM6zkDI+
hq1v1LEm7QSurUQEp78K5L2u4H7fI+xZl/lvNsD/8MRvQKrS9BBdMzsnakq/yOeN
i/6PYBqZ2hGixWQmJV8Rd83CrE/xw6ZvnweVFIYS602026x8+uBOs2HnqolhxWl8
Lp842YucFnADcS+lir9yis5C85ix5JiJYsR8ulByaa/RgP8QjLdtbAu+d04nEq6S
YzthSowz1JvwGJkO7lrXF5O+EQVYnXE+dXJSPrIXsRb39aprw171y12jtflQeSai
v60Eml7uhXto+jlE19unNSKCznXqGxxTgKOGT7+PZfb4IKnvTRXE11iGIXeBppr5
Aw8TMsRJpZMqBfQ/mw804NKLGO/o/bzvLSqOXvHm03VKYB4rBnOHqyG4eIngsFGJ
ZBMdzrMY2rz0gpVhcLXw44/XeKsj/tpa2OjdMxIjaM8RZyHc1jRlCKZt7fv6CIja
VLxHQnA/ENKLyt3qmdoWrJFgpNZtGrYvqDMr/triqSMShSV5ibUcbZjEec0I8iSF
MY8oszmm4MYyogOBSAh1SgzyiNGt3wACc1MuX1J2XuNiNCXXWJvlHjekH/WRqZSD
9EPL2gVKUcA9oncHCwzGk4hD9B7luGIwbqNYUyQz2sIv19zThh0=
=lnLA
-----END PGP SIGNATURE-----

--swytft7g5yl76e3v--

