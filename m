Return-Path: <linux-kernel+bounces-28953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED3F83051D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC8428A977
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619D81DFE7;
	Wed, 17 Jan 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFQH5GGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF91DFCD;
	Wed, 17 Jan 2024 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494200; cv=none; b=VYU/5OGsiV4kg28zv/Jy4Z2Vk+GrvAqqfH80+50VBieCOKNbZvUs4GutwPmgi1vpZTfooyZEoABEkwekHMOhSWF6IBS8vDcPkH+aJI6wosjosA4gLzPiLHXs50xrSYsiAM2jT0D7MNeRqoy9yCBe5eE1NwBl5g7JkMltuh0oc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494200; c=relaxed/simple;
	bh=YZKUQP7pybSv+QAUrpSE0TYNn39r1cBS7BCMTvjxRI0=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=QBb3AxjN08tdhB7quWLPm0BPaWC2HoipdhEPxGXlFrLH3fgwdAOTlkMwVieujqG8J0vDlmz2HB66iUrgyUd4102qPbgHwyHqCLwn7ue15zUh//78CjFvCQN1Gi14ZV+/7iRQB8BtIfajc+LCpmqhYn9sYGobrfWbI8Hk1ikw4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFQH5GGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22E9C43390;
	Wed, 17 Jan 2024 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705494200;
	bh=YZKUQP7pybSv+QAUrpSE0TYNn39r1cBS7BCMTvjxRI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFQH5GGwC69HPbvyS503MTVfSbBkh2uu2rsu0nHv0ZRYFKWfASL+mpd8rIVIHxN55
	 8PCPHIUlah/24B+li5KDnX/K4ywJNXyJMh2GVSHZGIbtVY31/hClAQqBMcoVG2Rfvn
	 TmlUFjkSHWtMHI2fQ6JRtC6b6PFzoEDOtfMerBoAk/1Rej54Hn7RvNFS+0aSW4yQFT
	 0QE5x74pm+W2Mllu59tQeoXJInDTvYYWjzWAtz2mRYPTj9a6urqfgxDuxy6hmahcTk
	 nEIKtg4CKq9Ri8PDI8N4/wNNGVgaV+NNqUy4fxkRLyKE8voa3UFUxF2TOcM3IAg/Dh
	 JWaKXNqpr8NXw==
Date: Wed, 17 Jan 2024 13:23:16 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, Petr Vorel <pvorel@suse.cz>, 
	linux-man@vger.kernel.org
Subject: [PATCH v2alx] MAINTAINERS: Add man-pages git trees
Message-ID: <20240117122315.15698-1-alx@kernel.org>
X-Mailer: git-send-email 2.43.0
References: <ZafC1MkKDAK2s6n1@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="feewq3knp6aluk7q"
Content-Disposition: inline
In-Reply-To: <ZafC1MkKDAK2s6n1@debian>


--feewq3knp6aluk7q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH v2alx] MAINTAINERS: Add man-pages git trees
MIME-Version: 1.0

As the man-pages README documents:

$ sed -n '/^Versions/,/^[^ ]/p' README | head -n-1;
Versions
   Distribution
       <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
       <https://www.alejandro-colomar.es/share/dist/man-pages/>

   Git
       <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/>
       <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.=
git/>

   Online man-pages
       PDF
             <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/book=
/>
             <https://www.alejandro-colomar.es/share/dist/man-pages/>
       HTML
             <https://man7.org/linux/man-pages/index.html>

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a59214c48e52..e5d90cd0ed8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12749,6 +12749,8 @@ M:	Alejandro Colomar <alx@kernel.org>
 L:	linux-man@vger.kernel.org
 S:	Maintained
 W:	http://www.kernel.org/doc/man-pages
+T:	git git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
+T:	git git://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git
=20
 MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP)
 M:	Jeremy Kerr <jk@codeconstruct.com.au>
--=20
2.43.0


--feewq3knp6aluk7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmWnxrQACgkQnowa+77/
2zL5hA/+MkWH0AyfgzzHw0UxcA9i03PV4E8NVXNBmLnf3ljTFriOpOy1P+yRU17S
Vclh3Ix1OjKF/ueBJkPjbj4TardvG7PwcVtFGpfl+tm8ZmnZiRtdPnQCE9r0kLO0
M8TKTJI1x5Zo38s5aJ2z3nDZ1lZyWM/8tD8Xmx+iJaPx5b6uyNN7wChqH2mjvzdV
0r6WDpkTEOZH8O7b0RsXJ5xgIC5XdIUv6G7IZPjdY525IwOO7PY/KZvCUsF+yQzv
2O6tXyVnI9cAh1ZG9Y5irmDsh+qhzxkurAJ1u7ULwnjurICEZSJE+4prLnJy9KOd
rM2uZjbgBrZObDUvjkm/w5BKCB+knbeoDyfWD4PeffT4Av7Hhxbb44cx0clXZVuc
8Gca9/gGB1uVWiOlVQqziOk+zY6dCcA1Q+c0FV/XLcTQEfScjTwSVGJivyjE+i8x
fltqSoiVjKgUjEZdGM7IZrAS4mgAGeKw52SvqxvvZ3qK3DMSrSxznVCRrmt2wW1o
MLRKqvVBpmcp1OlQnxB83HL/cPWwdq20/TIJKetliOQ20cslPz0HDjmXgrKHv284
sWvhUyHt14VFIlcm3fRhyVBao15B9GlBY73pAWrSJ9B3KUboPk3dNxz2nwzXVTpQ
pgucOADAziy9AUtjvf4xu90FEXGgLHiMHpkHgRiet+oCe6pKPFo=
=i4Dr
-----END PGP SIGNATURE-----

--feewq3knp6aluk7q--

