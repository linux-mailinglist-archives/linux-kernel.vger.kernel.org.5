Return-Path: <linux-kernel+bounces-154093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4598AD74B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58CCBB230DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1C208C7;
	Mon, 22 Apr 2024 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XOx2KqVV"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4510A20;
	Mon, 22 Apr 2024 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825119; cv=none; b=FG+tu3NbH68gaVTxDHcyypdW9gn1STSXEo7wteg4ubHDJm44smVFPiwuhY5nBOHfe+MgqVEYSTzbYXsO8x0OaY02lruDEzthbzHE9rce4Hi4Sc5t9VUXVjlaQx9RlQN9apoWAG5Fvrv7DinpwDJ3nCbt+b7yTJrptJpMWTQyRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825119; c=relaxed/simple;
	bh=kf+ZR8T7Z29rqXoays996MAkdV+Ne7CJSkwmJ2ck9tM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eAUeBi1uddctGLt7rOLxWZOOWah8qODvtVKu7vSrXHXOe7s+DzoVrjhV1JjM6JlmPBCDU+Z4SzwkaOa08WpCdXaDDzSHqjri999wYSxMli/QSknjzTKEV4FcmPtvyxF+mKbqtGfcmLxnC+99ttfbhGkTfkv3hfQ1MGhiJzkCxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=XOx2KqVV; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713825107;
	bh=CBNPTh/j0dtAeIo8IQkOpYE80YzJz/hwlgHSjn0cD6k=;
	h=Date:From:To:Cc:Subject:From;
	b=XOx2KqVV0YEMhqPR/32casPYBn8zR1bHuB8Il8Q4yuYs2moel6E3ZSiyRaptG2TNm
	 yqGcXF8dUqvyhp6ShYVrq0lRy/uHqHMKladyO+gckuHnjJuMJ2HVvO9AGBbabIV/vU
	 r0I4qL68K8ZpGOigxoGYidW2jckk+xVqt2bZWmME898U1hiRsIsxx2vE2qLT9lKWTV
	 TRN6kCWY+nYOPzenxcJ4Em4JQ0w6B0GfKu9B529lmxjAOfJGAyF5wXi7h9w0BqDKxz
	 UBH/edtAJY/1DCnRXZ57k8NWE3rpawbE1nCnQPFoPfHDGTa/JArv26p3kBzvjuz+99
	 fmfGpdUvhbQ+w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNg375dsVz4wcp;
	Tue, 23 Apr 2024 08:31:47 +1000 (AEST)
Date: Tue, 23 Apr 2024 08:31:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the i2c-host-fixes
 tree
Message-ID: <20240423083145.771dddf5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2Bl54QsjYVEctGKe5NQ8Tt0";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2Bl54QsjYVEctGKe5NQ8Tt0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  86eb98127332 ("gpio: pca953x: move suspend()/resume() to suspend_noirq()/=
resume_noirq()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/2Bl54QsjYVEctGKe5NQ8Tt0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYm5VEACgkQAVBC80lX
0GwxsAgApU6Mw2X6vrLWY+0YRiHvXwkKVwXMxuqE2T2kyOcusLJ/kRohu4qhylmN
ZgO8umix+zchTajVmutXQNq+w0mUhCwqwxlN9vR7WWKdAhjdOSXt1gJPxFfBSVgk
5WgxGY8U2xKE9+q2CxlwIac9oTl7F+dzUXxK8kpoFr0WxmX4xo/Yf7Y2WswRQByR
cfog29l3cn7hEiKCUtduZ4WXbFlrVxAHJW1NpBlqZoXTFreAc708iaOgZUGUQCxW
KXBdAhVxtABwKH/QsKvJBmq+qMlj6b+hLfamCFkDM0gLKMtdzHq2FQ+2S7Zj7fX1
miEg6UbKhgbnbX3dLEZXEFHl75jpdw==
=54sA
-----END PGP SIGNATURE-----

--Sig_/2Bl54QsjYVEctGKe5NQ8Tt0--

