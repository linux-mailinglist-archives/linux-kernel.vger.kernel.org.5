Return-Path: <linux-kernel+bounces-159168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADEC8B2A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4688FB256DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A11154436;
	Thu, 25 Apr 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RCA2hdoW"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06BB11720;
	Thu, 25 Apr 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078460; cv=none; b=qY64Lv6ge71xAtivzFn7Xi18XI7EDYM407k6GnJcWGg7K4irJT4Kbk4XIH0qt19oHcz7FUODBEJq05TI/LVG9gUco/4ADEUGtfhAHbbc9AIlk/AUvqHPGXmaMGuL8yPJVPhtl7zlZ9aCOPB5tSP92waFRjealoPOCdkTFrmY/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078460; c=relaxed/simple;
	bh=WciR8uDABQl1urcVq8d2U2T1d9Ad3gU29yvgUKJCx24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fsekKH/C+zlBpO+fFOkwclT4ZG6MY4Q/lZnbG3AeWQsLEwEY/rceQ9ZOGBt+Nfs+YWCiU/+vPmkuUc6qfXtpNjVHAYsDhtBRAupfNERkzJBybd6MKeRqS8aFRnSvYOVlS02qzNe4bFG75PFU4V5Ypnv9uyb9ZU/QoRduOU8HiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RCA2hdoW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714078451;
	bh=gfXvOeYACH2+rkJ+XuVNqc9MT4wcwdx7LxeCiLrPwv4=;
	h=Date:From:To:Cc:Subject:From;
	b=RCA2hdoWzBY/YjkDjSkfV/XVLssKMqwcjxgmCBc2ay9rDzPe/Q5zNC8W1mmEHMxLD
	 rKbvJfvavRS5aqoZhH1ukO+nva8tIXEQb41BiWQCOh8Sf1dfY4T2+GeBkpFtizDkpV
	 nwd2bt+BdL6Any5wwWakQz8PGs6OtafEKZxMU8Y7L+DPD812DrO+CD1EfsJHjcp/kO
	 77SDIGya7oC6fPHFD7K/d+BahjLVYNyl3h3b4St3jnY8D136uuKiw+xWyrbLGV43ZZ
	 /SlxVhli4V9eDIJ5ZiytGKBugosCrDHOHszZLU8aS1eByGKLJAeM4JXssBzhD8j9/W
	 UnwuLyBe4srYQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQSl75wqHz4wny;
	Fri, 26 Apr 2024 06:54:11 +1000 (AEST)
Date: Fri, 26 Apr 2024 06:53:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cpufreq-arm
 tree
Message-ID: <20240426065343.4a29617b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7V8n3cVK.wQM4k+lHGVZzo_";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/7V8n3cVK.wQM4k+lHGVZzo_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  51090b2ef6ea ("dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450 compatib=
les")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/7V8n3cVK.wQM4k+lHGVZzo_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYqwtcACgkQAVBC80lX
0GzPZAf8DnHYPrVmmiA8pIfZ4ALUUljGPlr3rzu3TQ+/jPPixfGsjjvl2G2g8hvo
RbbZj99BtucGYUh0LpD8d8L7CupQcEr03FhORtMu4/gIvoUu4BQ15AIXZ7GYqZOM
xMzugM4d6ndv+1p1tsPicECBYoi4Ex5RYuNN02wTgY8b51lKexp3Sn5xAZPN7C/A
C1igimtCe0wm5vM2OmGjd7sCChzk6qJ/9f/xQBkZusOyuIp5AYW8ZIfzWrRV1WO4
P+aRs3J+26pn89+feKdKiCsYtq234irwDplUiv2VqyazZwTdljVTNUrldOUYGKS5
q4TyN8Nwe0Wx3yJGqyfpV9UGP0ctpg==
=r6BK
-----END PGP SIGNATURE-----

--Sig_/7V8n3cVK.wQM4k+lHGVZzo_--

