Return-Path: <linux-kernel+bounces-28271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818F82FC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D759128FAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1F25574;
	Tue, 16 Jan 2024 20:48:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B5D25565;
	Tue, 16 Jan 2024 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438121; cv=none; b=p7TND41/JM6z8hFKBKxlmMPk7lvwB4+9r/6JymHvc6AnwS2VFYvMwh9CaY07LsaYQ4XI8jJeeshrWqLM1Lldk7Jjkt2BT1UWirQZeDT+QYuB540s7N8FuVuAGVNB+Cz2LlVmPFQJZibKT2Fj05VWH8RW9Be1LWQtK4JxpZnlxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438121; c=relaxed/simple;
	bh=Y3w3f3kce+eXjMPg/fWB2OkjLHS6gd02jYqc7dXVnQU=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=uYueRi56aQ6S+4xJONO6y4hKNoaMp+nWIHxutf17aCKk/XVd+RbbNiniy9Lbg2ck7Hpl3efxLIyem2nS8u6V7j+MgOv3CE/9d4W6H5AY6Mj0QfDljz2cObER4t9qjdZh+vxenTjpvjekA15MUqOsCGpganAC7V0m3SwXxphFZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 55D1F1C0071; Tue, 16 Jan 2024 21:48:38 +0100 (CET)
Date: Tue, 16 Jan 2024 21:48:37 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Pierre Mariani <pierre.mariani@gmail.com>,
	Steve French <stfrench@microsoft.com>, sfrench@samba.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: Re: [PATCH AUTOSEL 6.1 09/14] smb: client: Fix minor whitespace
 errors and warnings
Message-ID: <ZabrpUrKf1yolVi3@duo.ucw.cz>
References: <20240116010642.218876-1-sashal@kernel.org>
 <20240116010642.218876-9-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Fi84FJxVfiuW0PY"
Content-Disposition: inline
In-Reply-To: <20240116010642.218876-9-sashal@kernel.org>


--/Fi84FJxVfiuW0PY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 0108ce08aed195d200ffbad74c1948bbaefe6625 ]
>=20
> Fixes no-op checkpatch errors and warnings.

Why did AUTOSEL pick this? It should not be picking whitespace changes.

BR,
							Pavel


> index f725a119ce31..a957efaa5e74 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -505,6 +505,7 @@ static int reconnect_dfs_server(struct TCP_Server_Inf=
o *server)
>  {
>  	int rc =3D 0;
>  	const char *refpath =3D server->current_fullpath + 1;
> +
>  	struct dfs_cache_tgt_list tl =3D DFS_CACHE_TGT_LIST_INIT(tl);
>  	struct dfs_cache_tgt_iterator *target_hint =3D NULL;
>  	int num_targets =3D 0;
> @@ -773,6 +774,7 @@ cifs_read_from_socket(struct TCP_Server_Info *server,=
 char *buf,
>  {
>  	struct msghdr smb_msg =3D {};
>  	struct kvec iov =3D {.iov_base =3D buf, .iov_len =3D to_read};
> +
>  	iov_iter_kvec(&smb_msg.msg_iter, ITER_DEST, &iov, 1, to_read);
> =20
>  	return cifs_readv_from_socket(server, &smb_msg);
> @@ -1412,11 +1414,13 @@ cifs_match_ipaddr(struct sockaddr *srcaddr, struc=
t sockaddr *rhs)
>  	case AF_INET: {
>  		struct sockaddr_in *saddr4 =3D (struct sockaddr_in *)srcaddr;
>  		struct sockaddr_in *vaddr4 =3D (struct sockaddr_in *)rhs;
> +
>  		return (saddr4->sin_addr.s_addr =3D=3D vaddr4->sin_addr.s_addr);
>  	}
>  	case AF_INET6: {
>  		struct sockaddr_in6 *saddr6 =3D (struct sockaddr_in6 *)srcaddr;
>  		struct sockaddr_in6 *vaddr6 =3D (struct sockaddr_in6 *)rhs;
> +
>  		return ipv6_addr_equal(&saddr6->sin6_addr, &vaddr6->sin6_addr);
>  	}
>  	default:
> @@ -2588,8 +2592,8 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_=
context *ctx)
>  			rc =3D -EOPNOTSUPP;
>  			goto out_fail;
>  		} else {
> -			cifs_dbg(VFS, "Check vers=3D mount option. SMB3.11 "
> -				"disabled but required for POSIX extensions\n");
> +			cifs_dbg(VFS,
> +				"Check vers=3D mount option. SMB3.11 disabled but required for POSIX=
 extensions\n");
>  			rc =3D -EOPNOTSUPP;
>  			goto out_fail;
>  		}
> @@ -2733,7 +2737,6 @@ cifs_put_tlink(struct tcon_link *tlink)
>  	if (!IS_ERR(tlink_tcon(tlink)))
>  		cifs_put_tcon(tlink_tcon(tlink));
>  	kfree(tlink);
> -	return;
>  }
> =20
>  static int
> @@ -2867,6 +2870,7 @@ static inline void
>  cifs_reclassify_socket4(struct socket *sock)
>  {
>  	struct sock *sk =3D sock->sk;
> +
>  	BUG_ON(!sock_allow_reclassification(sk));
>  	sock_lock_init_class_and_name(sk, "slock-AF_INET-CIFS",
>  		&cifs_slock_key[0], "sk_lock-AF_INET-CIFS", &cifs_key[0]);
> @@ -2876,6 +2880,7 @@ static inline void
>  cifs_reclassify_socket6(struct socket *sock)
>  {
>  	struct sock *sk =3D sock->sk;
> +
>  	BUG_ON(!sock_allow_reclassification(sk));
>  	sock_lock_init_class_and_name(sk, "slock-AF_INET6-CIFS",
>  		&cifs_slock_key[1], "sk_lock-AF_INET6-CIFS", &cifs_key[1]);
> @@ -2910,15 +2915,18 @@ static int
>  bind_socket(struct TCP_Server_Info *server)
>  {
>  	int rc =3D 0;
> +
>  	if (server->srcaddr.ss_family !=3D AF_UNSPEC) {
>  		/* Bind to the specified local IP address */
>  		struct socket *socket =3D server->ssocket;
> +
>  		rc =3D kernel_bind(socket,
>  				 (struct sockaddr *) &server->srcaddr,
>  				 sizeof(server->srcaddr));
>  		if (rc < 0) {
>  			struct sockaddr_in *saddr4;
>  			struct sockaddr_in6 *saddr6;
> +
>  			saddr4 =3D (struct sockaddr_in *)&server->srcaddr;
>  			saddr6 =3D (struct sockaddr_in6 *)&server->srcaddr;
>  			if (saddr6->sin6_family =3D=3D AF_INET6)
> @@ -3146,6 +3154,7 @@ void reset_cifs_unix_caps(unsigned int xid, struct =
cifs_tcon *tcon,
> =20
>  	if (!CIFSSMBQFSUnixInfo(xid, tcon)) {
>  		__u64 cap =3D le64_to_cpu(tcon->fsUnixInfo.Capability);
> +
>  		cifs_dbg(FYI, "unix caps which server supports %lld\n", cap);
>  		/*
>  		 * check for reconnect case in which we do not
> @@ -3997,7 +4006,7 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *s=
es,
>  	smb_buffer_response =3D smb_buffer;
> =20
>  	header_assemble(smb_buffer, SMB_COM_TREE_CONNECT_ANDX,
> -			NULL /*no tid */ , 4 /*wct */ );
> +			NULL /*no tid */, 4 /*wct */);
> =20
>  	smb_buffer->Mid =3D get_next_mid(ses->server);
>  	smb_buffer->Uid =3D ses->Suid;
> @@ -4016,12 +4025,12 @@ CIFSTCon(const unsigned int xid, struct cifs_ses =
*ses,
>  	if (ses->server->sign)
>  		smb_buffer->Flags2 |=3D SMBFLG2_SECURITY_SIGNATURE;
> =20
> -	if (ses->capabilities & CAP_STATUS32) {
> +	if (ses->capabilities & CAP_STATUS32)
>  		smb_buffer->Flags2 |=3D SMBFLG2_ERR_STATUS;
> -	}
> -	if (ses->capabilities & CAP_DFS) {
> +
> +	if (ses->capabilities & CAP_DFS)
>  		smb_buffer->Flags2 |=3D SMBFLG2_DFS;
> -	}
> +
>  	if (ses->capabilities & CAP_UNICODE) {
>  		smb_buffer->Flags2 |=3D SMBFLG2_UNICODE;
>  		length =3D

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/Fi84FJxVfiuW0PY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZabrpQAKCRAw5/Bqldv6
8vCiAKCSTvWI5Trv0C+z0NvMhyUpJCX8OQCfcsXC/pHkdCrseZx3gXdW55c3d1Y=
=WufH
-----END PGP SIGNATURE-----

--/Fi84FJxVfiuW0PY--

