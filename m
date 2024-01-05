Return-Path: <linux-kernel+bounces-18400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC2F825C8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433241C23AF3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1633360AF;
	Fri,  5 Jan 2024 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UvCy5qCH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF03609A;
	Fri,  5 Jan 2024 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704494029;
	bh=rpezY7E7ZYFhLGmpW92hvMon9DAaxzXvUdwXft+X8tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UvCy5qCHEgsGakVwoutRV0dY4JQTExUxsDlnY+N/erjEEJ0aIJi+66jN1Z3xLOTFy
	 lQyN7ZwqZeoPAqQhPwdLZsAurebpERn8lrKbwKpZfrIV6GUywLwmFTMXffgl1CQUlz
	 hufERs1nSajfvLeWovN2ZT7MvmsRYLcvqoBuse4Tl9QtOfqjcNPx5mj3/+azOH50g4
	 /9bsdufZH69jA8HmpK9JAqx55sk1JqYm/pSFR7P6J0g0TclO/4xMJt/yoeTnTwJL2g
	 lZFBNeR1q/7IWRMYOmtYiyFgX6yLuzq03ObljnkswzLbPpQUaguQ6x193dXt0g7I3G
	 JuRCtMajxGpqw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T6JCJ5yhcz4wnv;
	Sat,  6 Jan 2024 09:33:48 +1100 (AEDT)
Date: Sat, 6 Jan 2024 09:33:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jeffrey Layton <jlayton@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, NeilBrown <neilb@suse.de>
Subject: Re: linux-next: manual merge of the nfsd tree with the nfsd-fixes
 tree
Message-ID: <20240106093347.15810e18@canb.auug.org.au>
In-Reply-To: <ZZd8q4RSTTN/5wSq@tissot.1015granger.net>
References: <20240105110007.3f932561@canb.auug.org.au>
	<ZZd8q4RSTTN/5wSq@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MmCxwecSmrAxXalQUn_hEhd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/MmCxwecSmrAxXalQUn_hEhd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Thu, 4 Jan 2024 22:51:07 -0500 Chuck Lever <chuck.lever@oracle.com> wrot=
e:
>
> I plan to rebase nfsd-next as soon as 76d296a82657 ("nfsd: drop the
> nfsd_put helper") is merged. I'll have a closer look at this
> conflict tomorrow (my time).

Instead of rebasing your tree just before the merge window, why not
just merge nfsd-fixes into the nfsd tree?

--=20
Cheers,
Stephen Rothwell

--Sig_/MmCxwecSmrAxXalQUn_hEhd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWYg8sACgkQAVBC80lX
0GxJcAf/ZHPehlLspMqSMbDDHS5utWs2Myw33qiBeO9fpibNe/r6f6cRE77pjTqM
vcO9cDtniiIngaeK4YSGhBCCQaM5N+/XgTENGd3NLMp+0/kyhJERH5FpGIKhCyLB
kHIir0OGWmSRsrG5sH9F+Vpwce456kSVsolqgy45nrw4ok6w0sERz5uOvMC5oMck
tEYKqGkwgkKU1bFV68NoG9zSkq9p/plcE95xLy3/y1baGq2jRjgxggypCRozrN4R
y7Ov5PPAArTXqWqmitO0A/Jv2sliVvr0I6xdHeYtyb6mbzDJz88xRZPbxSSy8hUv
qHdVt567wWmo/80QzpTOnHVzdSpkig==
=5bt7
-----END PGP SIGNATURE-----

--Sig_/MmCxwecSmrAxXalQUn_hEhd--

