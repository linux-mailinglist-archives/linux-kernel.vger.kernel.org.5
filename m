Return-Path: <linux-kernel+bounces-149361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D748A9014
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC731F22244
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37954E1BA;
	Thu, 18 Apr 2024 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="biaUtnLe"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869A4D9F7;
	Thu, 18 Apr 2024 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713400442; cv=none; b=im+Y1d7E6ITzxgM3BLKX5Aq552xsdIkkeDnNzSOqwD5Z84IA1Chb5O0hVDsB8N2lFEOJ+TrbR1vpV7hOdlEXDkt2wxdjj/DyFh1oQcdPobpmLiJI4MgA0LmQngl/L1UtlKYJEMrkSzKRM7Rd6djm1jAEefgfxTHr10w2X2yHkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713400442; c=relaxed/simple;
	bh=BXXVN8t5Tnskq8JVS+cmFbuNflyF46tkFPe34+6KjyY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fcm/yzJ04H/1zfXp5DNhkZVaofT1SRtkgaNCv5XOFGk9MbvCAYLSiXgbTKv+lm1a5m30FKxNb5h5MZhnN281pxhrjh/JZPdEiBocRmQWbSfscmJXHM3zT3HZOVkdL03t1bQ9wNN6iUI2JcJaOreQdTQL+x5Vw2Oh2mdWOpCNh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=biaUtnLe; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713400430;
	bh=YBMpr5wU+ZLhOI1+IprAXQ39GL/IQrf6iVUkeQghOsM=;
	h=Date:From:To:Cc:Subject:From;
	b=biaUtnLe9YCwet7W4b0c5koCSpaJTKNXoki9r0woasfqWL0jdKhx4U7pu55STumpd
	 J4y9oT1LHoypMKOootu3AzdFZDEUS4WRH/1o9cIhZEhyQ3N2gIZmodUwfY3fx5KOE+
	 gUta1RJ/tIJj0LwjWnsaxZsmb5zzxhVOfzIM3lHIf5wuHybn/ectlFBf7RWxLikOxX
	 kpbc38AoVJE1vve4eEczdSzeSYoc1MIQOmfxwdbGnYDKHDqaABdv57CmDkqHuiMFSU
	 sVVJEkXDG59BV7Al4Naa8441oEOw/eU7/djjHG81X/OxZVojUvIQO+Slj1vuuHOD6S
	 wYUwrz61vrHJw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKf0G3pQmz4wyV;
	Thu, 18 Apr 2024 10:33:50 +1000 (AEST)
Date: Thu, 18 Apr 2024 10:33:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the ntfs3
 tree
Message-ID: <20240418103347.2ace95e0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Utsz1.Tk.jkD.alAdewhe6k";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Utsz1.Tk.jkD.alAdewhe6k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/ntfs3/ntfs_fs.h

between commit:

  6be30a7aa20b ("fs/ntfs3: Remove cached label from sbi")

from the ntfs3 tree and commit:

  1a2af5ca9b66 ("ntfs3: enforce read-only when used as legacy ntfs driver")

from the vfs-brauner tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ntfs3/ntfs_fs.h
index 12c392db5b08,5f4d288c6adf..000000000000
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@@ -1153,28 -1156,6 +1155,30 @@@ static inline void le64_sub_cpu(__le64=20
  	*var =3D cpu_to_le64(le64_to_cpu(*var) - val);
  }
 =20
 +/*
 + * Attributes types: 0x10, 0x20, 0x30....
 + * indexes in attribute table:  0, 1, 2...
 + */
 +static inline const struct ATTR_DEF_ENTRY_SMALL *
 +ntfs_query_def(const struct ntfs_sb_info *sbi, enum ATTR_TYPE type)
 +{
 +	const struct ATTR_DEF_ENTRY_SMALL *q;
 +	u32 idx =3D (le32_to_cpu(type) >> 4) - 1;
 +
 +	if (idx >=3D sbi->attrdef.entries) {
 +		/* such attribute is not allowed in this ntfs. */
 +		return NULL;
 +	}
 +
 +	q =3D sbi->attrdef.table + idx;
 +	if (!q->type) {
 +		/* such attribute is not allowed in this ntfs. */
 +		return NULL;
 +	}
 +
 +	return q;
 +}
 +
+ bool is_legacy_ntfs(struct super_block *sb);
+=20
  #endif /* _LINUX_NTFS3_NTFS_FS_H */

--Sig_/Utsz1.Tk.jkD.alAdewhe6k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYgamsACgkQAVBC80lX
0Gzx2Qf8C4Jmw817QWVZz8uURMfvJzkzhjwhiIeIM6zdlm/iQ+aYcN/DMRRT+tgj
RN7OA6992oAtNFD+hMqwmat9zPXjdQZ7RFcoZUhrEu73uKgj4CKvhJmheLqfItZs
2HPpCcHgwQW2O0PvDVwNqGl4NOVXurXWIev/l5jbjKrwKEs6ToJUgu0WmXEG84uJ
cgGGrTcUMkxawmqNEOjSEO0bmfDQKduGpLp8mSm8Ofjyf6gWrdBLamA8/KX5WQuV
kLJV2sfxS+6jUTiP2y7AbvHUNXlg7kwkEb/2I/35jWqJHfViEIAzY73SdQQJNFvq
/qNEYEoWOxCT7kmlENHT6iu06gVvBw==
=uXlO
-----END PGP SIGNATURE-----

--Sig_/Utsz1.Tk.jkD.alAdewhe6k--

