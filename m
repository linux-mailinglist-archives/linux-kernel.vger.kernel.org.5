Return-Path: <linux-kernel+bounces-13947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC995821564
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8988A281FD5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 21:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248ADF69;
	Mon,  1 Jan 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IxmOx9rU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A9DF44;
	Mon,  1 Jan 2024 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704142954;
	bh=EIW2vDb1KTE0G8eEn3f1S4gxIzX2t7EeMvzyiXPHCxs=;
	h=Date:From:To:Cc:Subject:From;
	b=IxmOx9rUCPPR5yU5ufFGX3AEfcRpDzttrbeBUYjE9Iu5Ckfu1z8BizMnWZHiAK/69
	 1cAi/3MfJq6WqBYRVFexfYNUVkRXuMfmwAL5bJFqHSiqa8+vkWhutSUXk/2GnhB521
	 /g/Kj9+4uLGwoo3FWMKffFkF1jFzWSYEEp8xxhsRfpW52+zm0TP9JUBTWls+Mb9KIM
	 o/W4/Mh0Qe9VUpX5uGDxHL2SxXe3jtlK3Mx4K33dhYGeYCl5yPtmYuniqjH1Y0LWxc
	 ILzhWYc9hCFo/54xKpgJZK366flOIFnF8DxY6n+EInRP9gCWc1blH3GXP6PfDNjxXy
	 BgZgvHux4ixHg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3pMt4cLXz4wcH;
	Tue,  2 Jan 2024 08:02:34 +1100 (AEDT)
Date: Tue, 2 Jan 2024 08:02:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marc Zyngier <maz@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: errors fetching the irqchip trees
Message-ID: <20240102080233.20aca3ec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s=31OqnaH7m=QkKzKf7uf4Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/s=31OqnaH7m=QkKzKf7uf4Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Attempting to fetch the irqchip and irqchip-fixes trees today fails
like this:

fatal: couldn't find remote ref refs/heads/irq/irqchip-next

and

fatal: couldn't find remote ref refs/heads/irq/irqchip-fixes

They both use
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git .

--=20
Cheers,
Stephen Rothwell

--Sig_/s=31OqnaH7m=QkKzKf7uf4Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTKGkACgkQAVBC80lX
0GzbvggAhQ2yecAt3Ym8sjFDkVJLD8/ew2cZFyVsa0/MSyuHBtWGAgWtWIA/ndWX
w6TU5182GjVO1rg/nCU+WIO2ZmSv4509Gf3Ah2FgfunPSi95WUjR/6kJez/wY0NJ
K7iz5ccy3iIKKplR7YkgsH9SbyNaa1pbENGR6EIyIXG7z7xHsXpTa2geBQ8fgiWI
FNOk0GKHXyTvIq72Hd4dNB5uMOtijOvwatiGyIbRFNh73xvQQKM1jhHOvjFG7A1Q
E8vNTFAYgk96hKpqVPSJlH433SS7uc9OXD/8dcLtV0kXynNOtmaA3oJbhdao51mN
CL0Q480rv7KIS6dMclGnLD1vul/qaQ==
=skAQ
-----END PGP SIGNATURE-----

--Sig_/s=31OqnaH7m=QkKzKf7uf4Y--

