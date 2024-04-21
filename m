Return-Path: <linux-kernel+bounces-152656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19488AC226
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BAF2811BE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 23:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B97C4644C;
	Sun, 21 Apr 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QpUDBjaQ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0A45BF1;
	Sun, 21 Apr 2024 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713743302; cv=none; b=DJR7mmOjaSyMMB85SndTYK30ejVpOJ2aVJM/vXaXyTZXze2hwczEcSA6FGN2XLGXUY+okPoX6U4b64pEf/M124lCDfdb1xeCziiBNapZzguOvAbYIJeXgy53ENZdJM+BzoFuMWn8ii4CG0iz9h7YMJcn3Z2eXqj/VSrMK/QVuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713743302; c=relaxed/simple;
	bh=1tVnCQDaxLhNK8Gft9eYLuBbepaAotAO5h0F4HqedQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6tOkx/oEN1uiFIRQuPdq9CNvjBNpGSwSHjClLJngt1i3oV4RppZ5Nt6UpLoV6jbLnDu3/H9HrmzAY9OXw2Gn4tNsrgE/b370Q1qoU3l+0yyQZ14TWdoUo//vzBY1hIhBt3jc9zsr2WmsKujhnD7Ysj56c3irEHO8zCZEWjOOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=QpUDBjaQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713743298;
	bh=pnKkoBG38UQMRdLv7sWFsV0g87RCjZXaEe/a8GwaSTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QpUDBjaQmqsv3JCypsQ8xexQB0ZH6GIAuTKIgtCaslmAajvkZGzik1kujYriWFOeO
	 AVaWLiSgAj5Vd/XEBj7FoUjSaMkVTxcWvnGdkEvt4lLh4F8+ud61SDGFn52kzSrVvx
	 tb3BjiADxcQOpcjiUhnF1qeMP9DKcQH5F3rNUwgORUVPXrv/f95RER4iBlsgVq4QNX
	 2lmz9ZZfOvGbZieyxwFC4cKoRuOIoOb8EEppDhxOBA6FRdxsk3Iej+x62gSccxu0MA
	 689CNSJ0H6gYGaX/n0F2v5fYovtzsEgrjSI+IGP2s9p0kaRMwOSIy0caz5g0FRSpnY
	 YD3GJWmOZMj/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VN4nt136jz4wjF;
	Mon, 22 Apr 2024 09:48:18 +1000 (AEST)
Date: Mon, 22 Apr 2024 09:48:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the workqueues tree
Message-ID: <20240422094816.09cbdcc2@canb.auug.org.au>
In-Reply-To: <20240130133748.7c30d71f@canb.auug.org.au>
References: <20240130133748.7c30d71f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S5_F4/BqLo/7A_7YwyidL_0";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/S5_F4/BqLo/7A_7YwyidL_0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 Jan 2024 13:37:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the workqueues tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> Documentation/core-api/workqueue:761: include/linux/workqueue.h:476: WARN=
ING: Inline literal start-string without end-string.
>=20
> Introduced by commit
>=20
>   5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement f=
or unbound workqueues")

I am still seeing the above warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/S5_F4/BqLo/7A_7YwyidL_0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYlpcAACgkQAVBC80lX
0GzMpwgAij9cOO2Vwjf9CZGevuxjbEU+BVO+3FbIX+rTdrGcs2c0gEZVzxTue/QJ
a3oWB0ZXX1BkdxgxbNmKBsls427wq7YenU+KPMQxMxRN0Br93YrewI1GmldT4j1O
zaaRkPa9SiKurSuY1u38yKkW8qbGV/NJ0V/acMJEyj4xG9s5jXIRiZmeoWMd6d/s
snmczhsxLWMX8Mg9lx0bXyTOhmwyiDDja34q6wwVMxeDCS+YoOL0Pk15aiFe9JUz
raNfgh4tUVrp9cT2nApH/7aQCsCBqi0n4h+cExvwbwCkw+E9IeFRXx3oK0bzRN/4
hklqSm3uqtPSkAxWqbnbDOAqckHYvw==
=KFPQ
-----END PGP SIGNATURE-----

--Sig_/S5_F4/BqLo/7A_7YwyidL_0--

