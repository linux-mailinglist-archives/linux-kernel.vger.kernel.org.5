Return-Path: <linux-kernel+bounces-108024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF68804EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ED61F20FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558B339847;
	Tue, 19 Mar 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3DLvNig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C282EAEA;
	Tue, 19 Mar 2024 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873338; cv=none; b=UzWXaDrTy4X4OjDV0s/Vf4PpZUCUrkHm/n8sHc/BjF4cxShmwYBH/DyH591EKnLx4CLP056NiffBGTktNGQPt1bGaILSZaJ2VSTKQMxOQMnZlLBynmAl4IqD/C12Po/lQODf+3g0RujOcPif+Mc45dVSysd05XQs6UlEMl3l5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873338; c=relaxed/simple;
	bh=0HH33mb7jgiZMa5dhyUQczXypiKnOtBOfjNUxNoIbrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q2bXD24ji/m9hlU+Y0HPr8Xnd9ZTpcWLD/NuPTQS5L/jaTns/CegEYkH6arkmi1pgERbJ8j1YUeb03kVWeLNaiZYbEWe2RS5AeNxFnLKrnXnabUCY253HE1O+wh2ppjDdsfjgO4bvs1RNYbN2sQl//YtWwyuIYDztD3w41X4RDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3DLvNig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75FEC433C7;
	Tue, 19 Mar 2024 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710873338;
	bh=0HH33mb7jgiZMa5dhyUQczXypiKnOtBOfjNUxNoIbrw=;
	h=Date:From:To:Cc:Subject:From;
	b=q3DLvNigP/qgWPXTJUkZNAs91tHZPuLIa2qMFq7cBlvYTB4IfFMQC6C+N014Z3lm0
	 yQTagMPT6W832L6umWX0UnIPqR0m7VyHOI114u79hvv9VjqTqyAz5wOSaRTK5JJCG9
	 zeknYM1Ub6xJuLmVqlqWrtk1lg669VzrV7hcgmppAE3Ar0hJkcJ4p17d9WGtbhUfxe
	 1kNAdV58Co+cVin3KQTSt4clQkiZ0Zk30mw62dghP5AfhmRHvzJd3pfMLpcDlZzk5x
	 OIEqNTXxZ+gMvB/VfT7EQq6orvPR2tiYnBsYdU0lZwJVQQxTpH4g5rGuw2u3xABbqH
	 o2GY6/oZIazRw==
Date: Tue, 19 Mar 2024 19:35:33 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	andyrtr <andyrtr@archlinux.org>,
	Luna Jernberg <droidbittin@gmail.com>,
	"Dr. Tobias Quathamer" <toddy@debian.org>,
	Marcos Fouces <marcos@debian.org>, Sam James <sam@gentoo.org>,
	Jonathan Corbet <corbet@lwn.net>,
	man-pages-maintainers@fedoraproject.org
Subject: man-pages-6.7 released
Message-ID: <Zfna9TOEMqQdI88n@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NFt9vGFm5+QOZdhn"
Content-Disposition: inline


--NFt9vGFm5+QOZdhn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Mar 2024 19:35:33 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	andyrtr <andyrtr@archlinux.org>,
	Luna Jernberg <droidbittin@gmail.com>,
	"Dr. Tobias Quathamer" <toddy@debian.org>,
	Marcos Fouces <marcos@debian.org>, Sam James <sam@gentoo.org>,
	Jonathan Corbet <corbet@lwn.net>,
	man-pages-maintainers@fedoraproject.org
Subject: man-pages-6.7 released

Gidday!

I'm proud to announce:

	tag man-pages-6.7
	Tagger: Alejandro Colomar <alx@kernel.org>
	Date:   Tue Mar 19 19:07:31 2024 +0100

	man-pages-6.7 - manual pages for GNU/Linux


Thank you all for contributing!


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Changes in man=
-pages-6.7 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Released: 2024-03-19, Val=C3=A8ncia


New and rewritten pages
-----------------------

man3/
        TIMEVAL_TO_TIMESPEC.3


Newly documented interfaces in existing pages
---------------------------------------------

man2/
        process_madvise.2
                process_madvise() glibc wrapper


New and changed links
---------------------

man3/
        TIMESPEC_TO_TIMEVAL.3           (TIMEVAL_TO_TIMESPEC(3))


Global changes
--------------

-  Build system
   -  Reorganize build system
   -  Clarify dependencies
   -  Clarify configurable variables
   -  Add 'distcheck' target
   -  Ignore known warnings
   -  Replace uses of man2html(1) by grohtml(1)


Changes to individual pages
---------------------------

The manual pages (and other files in the repository) have been improved
beyond what this changelog covers.  To learn more about changes applied
to individual pages, or the authors of changes, use git(1).

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--NFt9vGFm5+QOZdhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmX52vUACgkQnowa+77/
2zKc8A/8Dr2jwK5coYrdnGfJ6kGHR5hboIlYocNA4bsYUBoZIPsmQgmH6zIRr0G1
hyLeSjIrb/GuIdQ1Ou1BajWeVdMr18gouDZA/zsQV01Jfcd0zQR2wxerfPb1zZuH
2CKgnEXOWVPMwUzHdcGzqb31Aj8SuHbaZafOZhdAIULisXcoyXL9wu3VvbJTJDC3
DU5B88XhaV/yhSkK8fLpa37E/iCtnS6exL0fj1JGuuRc7jOLEIveIkBf76De5hx1
afcz4NWTHOQVhyzqN6DOCPrBvAPMzGGzferGEc7IQAFpl+LhAXdLkGzX7rWRtS2+
tBA+n8zyW6xq76GIUGRVjT0xQDDtMzAYZdggydsf82CksEgbCCUurMn+9OPbSiQr
GuMMEzgSpFSEtFeYrp7UCWTLYTMiqUDnZ/XjdNS+bOEsPkLuC7BZxyhJy5LtDu+F
72WBM1IeAWxL3u8pdxDiguF7yQNUVxypRFtT0fKnflWSZob6g6sTTow2wWRqtjZG
LS8CD1ZPM8G5l9zQAFaVHXWz2/TtgRnqIt12aEInrsxYQOHl930U80flvPXSMd9r
k8OnIwORlyWmJ57HqHfvDaIEogvqLmKdK+b6ixyYMt7I+E0iY+miMynI3rro2CNR
1UpseRPVEAGxuXSkozs9ZYSLump8YRtSgvpAB5I4G6LO0gJLVuA=
=4wO3
-----END PGP SIGNATURE-----

--NFt9vGFm5+QOZdhn--

