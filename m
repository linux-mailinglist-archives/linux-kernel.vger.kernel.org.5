Return-Path: <linux-kernel+bounces-134680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE4189B4E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745E61F21351
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 00:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7280801;
	Mon,  8 Apr 2024 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sR0W7xEf"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0764622;
	Mon,  8 Apr 2024 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712535222; cv=none; b=a4l3BXi2R/e0ehtysRe9B39F5eGx9+fl++hjk+vYHMkL7G9+IDcQYoQyA9gpaCVhmgDMJypBtdweRG0S8OvJY9bohaGQIdUTxk7sE3VcWIE12GU63BaklG3u7nRZ4Yait2ad4FBIEdbe82LQLzEd3m9lrJD+6LpIt7uzNicxvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712535222; c=relaxed/simple;
	bh=XxjzcsS90R2DrMSr2FSQSIefN4OFas3tYYbdo23GQF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xy2Qm3n/dp+1KwMNVvRpmb8BQn2VQ+WH89cW5XDeW5rQ1Gxd26J79XZe0YLuIx05Fo7Rq8rlnHT26iTUCpRQaxlJF0TwulCi3ux+Hfp28V6f6jzkRcaJ3CjRrU2zLTOh5hlVfGQlljQCFmuJ+bFkj8xtzw3BQuhXbsqCvKkj8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sR0W7xEf; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712535215;
	bh=uW3VpuewRB2t/+Lm0ouvbSww4oBuK72AAU7udP3fYYs=;
	h=Date:From:To:Cc:Subject:From;
	b=sR0W7xEfVFCcIDOSyPHNy55MKaAaNvo/Hvl+XoC5K40i79uc3NvW1/76O1g0lMcif
	 H+1WNrE+sonbZhKxy9qxK9ixf6lpvth4Z71eLRsFi6FfnBLGJZfpAGKsz5JYstJo3p
	 CM0Bc7OUVuBSPxJ//4uKVO9iTY0lQGh11Cp6UxTtKFjmwoHmmbVwhDqEM7nEiyS0F3
	 4L4TtkfVn2wAuk0ywWWokdqxDnqzUaO4LLlwDpiodr0LkOK/TXd1MpVm8xiCZ/u+rI
	 fJXG9qRCJUcM+y+FMZwj3bnHqeHkX4VjVfx/HGVmCY4YYDRRpFgLFgeRhQkSosxEut
	 uo0S1xq6ltMHQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCV1V6SRqz4wd3;
	Mon,  8 Apr 2024 10:13:34 +1000 (AEST)
Date: Mon, 8 Apr 2024 10:13:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the loongarch tree
Message-ID: <20240408101333.67a8bf17@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B+8m8XSXd9b0VabYLQfAuV.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/B+8m8XSXd9b0VabYLQfAuV.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm tree as a different commit (but
the same patch):

  27e361b5e171 ("LoongArch: Include linux/sizes.h in addrspace.h to prevent=
 build errors")

this is commit

  5d90c9735da8 ("fix-missing-vmalloch-includes-fix-3")

in the mm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/B+8m8XSXd9b0VabYLQfAuV.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYTNq0ACgkQAVBC80lX
0GyoDgf7BnP/w79EXLyUXCeSnbrT7YI7HW37rV6reMUu7O8oj8zLz2ezsKYPl6MX
udwR6cDuWZnUD18jUtYLYMMeEC4ICVVwUs+Q3AYMmKMb6uyZQhzVQBcxEKLU+xcy
wvOxEvG3vnqyBow6Pj6frC2iO2wV3jpw6OL36oPp8p35Dja90/z+ze/MQCEo4RlW
a+qhZEvrNde6wNuvb3nD97gnbrQuob8G7yKrdA0sdy777bicHEpenIQQhOrk94LK
6dNBc6rZXyHdp6eoaVo5sqff/NuXkP72ZsZKvF5ZE0RLRvfx6/wmwcWwMhnx88sD
poWQPBxuJxisrhCbDtgdc2ksvQ28CA==
=ze1a
-----END PGP SIGNATURE-----

--Sig_/B+8m8XSXd9b0VabYLQfAuV.--

