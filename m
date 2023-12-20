Return-Path: <linux-kernel+bounces-6313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F18819712
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64AAB24546
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD8F10A3C;
	Wed, 20 Dec 2023 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M8Ts71+f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C923FBE3;
	Wed, 20 Dec 2023 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703041531;
	bh=5vrh5N3dyBZ7xhnzAHIp3VX722TfkY7DdCO82wTTKcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M8Ts71+fFrBoTuFoHKUYJbOgj+WBFxUJKxKVype+sdbOdmUqe5R/rX7rrYkgHR0ji
	 JIg8QaDSgvCvTC9V/HMu5J4UAEHq8WMQFFuiHjByp2+1iquna33bGAG556lghymPxm
	 UCY+yVF7HjXIbQzxoidQLMHs66L1BQbiV8AK9s/e/BZ1URPg7MjwgISQzFkJzECzk5
	 WsIZ1sHqYvzAauKNj7qLsftUVgJlyHU6+NcOH2lg5AHERq94bZr35wiBFcynakHZ9W
	 yZmHpReDqym7eESXdL4xLFh5+sLY3NcSrArb65pxDvIRRQ6PtFJRAtNreS//+YBFva
	 1UCX8xMxeKbPg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Svz2f6jlhz4wd4;
	Wed, 20 Dec 2023 14:05:30 +1100 (AEDT)
Date: Wed, 20 Dec 2023 14:05:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Jan Kara
 <jack@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs tree with the f2fs tree
Message-ID: <20231220140529.3979085c@canb.auug.org.au>
In-Reply-To: <20231220013402.GW1674809@ZenIV>
References: <20231220104734.0979a9f8@canb.auug.org.au>
	<20231220111325.5dd55e47@canb.auug.org.au>
	<20231220013402.GW1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9WpnFLRRp/vj_YOIQc8WJSu";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/9WpnFLRRp/vj_YOIQc8WJSu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Wed, 20 Dec 2023 01:34:02 +0000 Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> My suggested resolution had been wrong, actually - the way it's written,
> link count drop should be conditional on old_is_dir, cross-directory or
> not.
>=20
> I think the right solution is
> 	if (old_dir_entry)
> 		f2fs_set_link(old_inode, old_dir_entry, old_dir_page, new_dir);
>         if (old_is_dir)
> 		f2fs_i_links_write(old_dir, false);

Ok, I will fix it up.

--=20
Cheers,
Stephen Rothwell

--Sig_/9WpnFLRRp/vj_YOIQc8WJSu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWCWfkACgkQAVBC80lX
0GxCcgf/THbisqsNRK587ORnaSG2shUwhcHuy9mujelIZUGF2GxQS+QFawAvpKOi
++IzRAZunWRNVn68nmLgPjIx22VfU2RpwlBIn62EVAG40JcVrUTEvoXXRycmoWl2
mSCHvikHQFvkbeIlS3s/60ashT0alDjlJpTeWWFBdzh2jzFynatZi9KF5sS2aAl0
NbIhPzs2Xa8y8Y0VvqLQ4AGhjoDWRpJVNHkxRRLPixH9k6wkp3QboNF2YcBhlbt+
qwYb8at3NWjGXl7oayxvFkKog/U6+L7OlwkW3MZyarH/RRfIHH6xkOgjLn1ajcSR
v3yr2PomZGCCOgjNsB3NNvRTrgxAdA==
=bnhO
-----END PGP SIGNATURE-----

--Sig_/9WpnFLRRp/vj_YOIQc8WJSu--

