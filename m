Return-Path: <linux-kernel+bounces-64317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173FF853CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D5728D30B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A29612FE;
	Tue, 13 Feb 2024 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s6l2gkje"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EAB6310D;
	Tue, 13 Feb 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858461; cv=none; b=ToSodinmPPHI10QlNsN+g3O1XwA7xt4p4y7T0XzEw6742P9K1bnta0M0W5VHWwgyhDf7FZuVxr9pbC3lq7MubfJr+Nx+FvrpmGdXBcOvwLbSGnVt09jLTtNIEPfJqqyxy1zuUUYGx501PGIPnTn1rwitcXExhEuGUweHML1s6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858461; c=relaxed/simple;
	bh=j6becupcixOhJejB9DHZ/U8X2xK9inw8ghFQuQPUSFM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gvzDXmTWB/Gcnk0GmjOKkEjkXC4Wp/USvYT0hYv9rpo1Y/55nfLWc17UpIXZg/6COqn0c40dIOt+02yCSNc2yOhKJxtgeM1JmhQi+Z0irj8APpB7ejrcY8BlUffPuNk1L6EKafvBWw7Td2HKbyjCiHWdP6+G/MEirYQ/10ZdMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=s6l2gkje; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707858454;
	bh=hQiJRte2bVBKcJR3CX4k3HN0hEbk/vGrSk9qK2LgF5k=;
	h=Date:From:To:Cc:Subject:From;
	b=s6l2gkje75m1uL8NQPcOoIBtSfSYIfVwLiI+9YcBCxdVzsfdo1SZK70iOw70T1q6Z
	 HNid8AuTDlA+co1Cosj+7XSKdlH5lelo+kD+tQReSEUJZjZinSH6UAxsyXOaoVta4h
	 tQ1O93iE1/68Lj4K9UKdF1LhT2VfGemciNhoWYNDEmuA8jjekKDg9FJzk2Iw3zJvno
	 wIH0JAKdH/7B6FED/v1fgPg2Thnsgxt6RSafq/9ylOoJQS/iLGjtVg+syE0f6kB8st
	 yScOAlsfqQy8JVLOpQYMoBk1OKlRgBpOHQZ3x1h3YGr2+v3O9AJEaOhylNeaGVbdKW
	 Z4wc04QntSbDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TZDRn4X6Nz4wcK;
	Wed, 14 Feb 2024 08:07:33 +1100 (AEDT)
Date: Wed, 14 Feb 2024 08:07:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the hid tree
Message-ID: <20240214080730.744c9b9d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D9weJoBkEJ6iBqxjovrjf.M";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/D9weJoBkEJ6iBqxjovrjf.M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  05c7d1de81eb ("HID: nintendo: Remove some unused functions")

Fixes tag

  Fixes: 94f18bb1994 ("HID: nintendo: add support for nso controllers")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/D9weJoBkEJ6iBqxjovrjf.M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXL2hIACgkQAVBC80lX
0GxJtgf/Y/Dm7OYpHKW+94uxJlH3j6NXNl4OXul/WESjXu5N0inyjosQ5IIkZXe1
irciQyUlMLKCQWTZsY9nvu4zFIH2SI0qV5lG/YsAWy7zq877qkvSgJrrrJY14glk
amhdeGydAyxTquvEXfRXtK+nPyMWXhVdyDk8AlQnOYhtfw/KyY5vgkqxD3hdk5kf
gUSRYFfvmiCzcTcxVm5vx2zDLXCdyc6u/4LiucnD4hmLRSgOwMWSvMNRLlCQ742r
76VaQBoNUoR6cOuF5mFi83hsBr6qZIZca5cfmqEeoIRoD9YMCErkraQbEHHhuXl4
WCorQIKqiRwuIiMwhh32la+TJ93gdg==
=vRj+
-----END PGP SIGNATURE-----

--Sig_/D9weJoBkEJ6iBqxjovrjf.M--

