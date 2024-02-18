Return-Path: <linux-kernel+bounces-70471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244DF859860
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579C31C20D58
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DDF6F06F;
	Sun, 18 Feb 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Wpw7iV50"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF7329401;
	Sun, 18 Feb 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708279220; cv=none; b=XKmE7y515UWgoQa5PWAR+hVjov3u6F3JJqJtHkn3bZHknlS4L6INPlfz8esZ2Eqy41O/NTETdC5fda+bEn8bA+pUHitbQ8R4+4fXyynt1pgNE8OaHQqNwqJiWMBymIkO7NGSgsSQ/cB2T5H0xWEKT7VUyF4nuIUvcC+14MlidUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708279220; c=relaxed/simple;
	bh=MRTZT2wydvV9g4+L3T8Cy5v1cxJApA/ZFD4xuz+TmMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYbCN5Wsbvb/XhlyOD7FPNKduWoevioCmqn0INCwVCHFUXu9TnJktFfKssGyJXMdmwigyiq13rDZeJVfLILW1CKP3P+tSwfuVDK/vMvLlqXUMmGW5zTK8RbLlcx8pacvli8NlcNDqNlyqXWOT/g6nFMIrhEm9ITj+TfaTOdyQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Wpw7iV50; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5A4F81C006B; Sun, 18 Feb 2024 19:00:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708279213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KY7UwwVMk+29949A5eXWxc2HgEJyrtfWdkswBoyqc+Q=;
	b=Wpw7iV50I3xg7wwwTkC2RL+gRLUacusIwzYbp6qA/PmEmgJGYqLnE2uZNXjw9Y7GXZ+Loi
	L7aePebhhghtW+bP4jloi7MSK0ozKESuIqsp4AO+JgZnR+Opveg3h0Skdx7yXCH6M25ZtG
	aRy+ApMGzXVlDCN+/vSLctqDGyWQQ20=
Date: Sun, 18 Feb 2024 19:00:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.1 09/28] fs/ntfs3: Prevent generic message
 "attempt to access beyond end of device"
Message-ID: <ZdJFqmZhIwTFTbHR@duo.ucw.cz>
References: <20240213002235.671934-1-sashal@kernel.org>
 <20240213002235.671934-9-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pUDbgsQtT3lXZP2c"
Content-Disposition: inline
In-Reply-To: <20240213002235.671934-9-sashal@kernel.org>


--pUDbgsQtT3lXZP2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>=20
> [ Upstream commit 5ca87d01eba7bdfe9536a157ca33c1455bb8d16c ]
>=20
> It used in test environment.

This seems to just replace one printk with another; not sure we want
it in stable.

Best regards,
								Pavel

> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 873b1434a998..34813429e2ab 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -976,6 +976,30 @@ static inline __le32 security_hash(const void *sd, s=
ize_t bytes)
>  	return cpu_to_le32(hash);
>  }
> =20
> +/*
> + * simple wrapper for sb_bread_unmovable.
> + */
> +struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block)
> +{
> +	struct ntfs_sb_info *sbi =3D sb->s_fs_info;
> +	struct buffer_head *bh;
> +
> +	if (unlikely(block >=3D sbi->volume.blocks)) {
> +		/* prevent generic message "attempt to access beyond end of device" */
> +		ntfs_err(sb, "try to read out of volume at offset 0x%llx",
> +			 (u64)block << sb->s_blocksize_bits);
> +		return NULL;
> +	}
> +
> +	bh =3D sb_bread_unmovable(sb, block);
> +	if (bh)
> +		return bh;
> +
> +	ntfs_err(sb, "failed to read volume at offset 0x%llx",
> +		 (u64)block << sb->s_blocksize_bits);
> +	return NULL;
> +}
> +
>  int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *bu=
ffer)
>  {
>  	struct block_device *bdev =3D sb->s_bdev;
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 977e1422f904..cbeda94d7161 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -580,6 +580,7 @@ bool check_index_header(const struct INDEX_HDR *hdr, =
size_t bytes);
>  int log_replay(struct ntfs_inode *ni, bool *initialized);
> =20
>  /* Globals from fsntfs.c */
> +struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block);
>  bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes);
>  int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
>  		       bool simple);
> @@ -1012,19 +1013,6 @@ static inline u64 bytes_to_block(const struct supe=
r_block *sb, u64 size)
>  	return (size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
>  }
> =20
> -static inline struct buffer_head *ntfs_bread(struct super_block *sb,
> -					     sector_t block)
> -{
> -	struct buffer_head *bh =3D sb_bread_unmovable(sb, block);
> -
> -	if (bh)
> -		return bh;
> -
> -	ntfs_err(sb, "failed to read volume at offset 0x%llx",
> -		 (u64)block << sb->s_blocksize_bits);
> -	return NULL;
> -}
> -
>  static inline struct ntfs_inode *ntfs_i(struct inode *inode)
>  {
>  	return container_of(inode, struct ntfs_inode, vfs_inode);

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--pUDbgsQtT3lXZP2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdJFqgAKCRAw5/Bqldv6
8kTAAJsEzDfmCgL6QEiJn5vOqZa4zoaaHgCfel7eOK9LUE+kRL/3jqHno+tiIlA=
=rBzw
-----END PGP SIGNATURE-----

--pUDbgsQtT3lXZP2c--

