Return-Path: <linux-kernel+bounces-154202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A48AD935
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C181C212D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638464594A;
	Mon, 22 Apr 2024 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RBXlUBfv"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803F446AB;
	Mon, 22 Apr 2024 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828846; cv=none; b=h1icrV+I2n7s0rlOEUuHghSrKo4H9yU7+iSXSDgO96pajZn5YqiP/qcW/5n4ERdhI5KvbSToUkrttEwAQAaYguSUXH03ppSpwuNj3H+y9eAvZ7W6hN+d99eVW7mmvnL7WfOb2MZU4IlIGjdsuE1pOrIftEUENciWbxHScsaBsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828846; c=relaxed/simple;
	bh=ykRlCUU6T87TodnBwttbJq5ck1ZaWz/jwcYeS6CUa8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=h+21t9hnaGQnzntXog82XEnyDCI4/xRomQarnGPVeE56FJnhpxHOPyDJb+qXNbS0lvdYuHeIFNc1MZ2QnSrD3a2RtAp7ccXufhHH9zvK+DfGhwz4MU3EwhMo6/Bku0cHA7vDtTz0sZogpqkBWqc5HHx+6qhwj5pJc+p4GP2dBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RBXlUBfv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713828838;
	bh=o/6ScmTNzwf6FqSniq2tPjr5e/5aWKIOB3p2Ex8L+MI=;
	h=Date:From:To:Cc:Subject:From;
	b=RBXlUBfvG3P0WdYXJuL2bS9zKJ4WHPDAfU1R495Zqpj11o/kCe6sCOKCLIp3CSpU6
	 rxe11Ct0tdMoVBchrnfBxe7TEIinXFRVuXmrjxQ44sQk7tPxY/tVeGKpleGJQtvq70
	 QARBD7HtxXqwH0Xnnwgwp2w3ytizeeSWnxIEMYFEzDRnWFOAJ/2eOl2kBnLmh6LR8Z
	 14NP3ShhngMqyHNFjPo/zrURCzojxrF31U08C/s90YzPdbN4PDdIdDC1cGyXbeK2rP
	 0tl01Ag82oavi12w9tk37f2tHMKecPK5xIyeS9npo9WT+uCCGamhxDrmlfkM+bg8aA
	 uGam3cNooos6w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNhQt24Lkz4wcd;
	Tue, 23 Apr 2024 09:33:57 +1000 (AEST)
Date: Tue, 23 Apr 2024 09:33:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Prathamesh Shete
 <pshete@nvidia.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the gpio-brgl-fixes tree
Message-ID: <20240423093354.3d060378@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OPFdSVX3/T.QyanbfFxMl0R";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/OPFdSVX3/T.QyanbfFxMl0R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the gpio-brgl-fixes tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpio/gpio-tegra186.c: In function 'tegra186_gpio_is_accessible':
drivers/gpio/gpio-tegra186.c:189:14: error: 'or' of unmatched not-equal tes=
ts is always 1 [-Werror]
  189 |              (value & TEGRA186_GPIO_WRITE_ACCESS)))
      |              ^
drivers/gpio/gpio-tegra186.c:189:14: error: 'or' of unmatched not-equal tes=
ts is always 1 [-Werror]
cc1: all warnings being treated as errors

Caused by commit

  62326f7cefc2 ("gpio: tegra186: Fix tegra186_gpio_is_accessible() check")

I have used the gpio-brgl-fixes tree from next-20240422 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/OPFdSVX3/T.QyanbfFxMl0R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYm8+IACgkQAVBC80lX
0Gw77Qf/Tdz4urKEQL9YXH0qgyYCseMkPdUK+hvR/QlCu2nQ/McuxWOkuu9an2PS
kBN2Or/LqhTwaNnq7sKr4VBPwNh/evLbeV5O3Zcz71p1AI4S1w4Sye/pVliMgMy5
w8wEkRbKJbItJ/eyFL4ez5+3AOJ8KULegXHAnM4H55i8iPYq9pD3yYUtIiolXr1U
nNbjgrIYcDTA4e+jFyJ044NlMs0c50H34BMMah+hrjBjWSSe4R9xyVkBjdwAHBO1
1BWE1kGETE70uP3w3OBkjFmj0m2PlOGHL45eDfhZqoc3EdpShQbYe60QmexinhtY
FRCqzJhvZJlzXNYqZU0ntpAaJBwSfg==
=3I/N
-----END PGP SIGNATURE-----

--Sig_/OPFdSVX3/T.QyanbfFxMl0R--

