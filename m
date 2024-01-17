Return-Path: <linux-kernel+bounces-29023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC483071E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB65288549
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A700F1F5E7;
	Wed, 17 Jan 2024 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0rVryi4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E41EB20;
	Wed, 17 Jan 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498425; cv=none; b=N76UF5w6ITX9b7MOs42p2pQwcFt+lZ05VXS2lTu1ZLVFRBKVkFMfoBqvM9ynL1kHQMg8uiUtL64zQECbN4DJjmqGpqdj5aJCg51Dt5bvwA9DHjkvdhu6UVD7SGTWrR+HFKh+9rXgaM47rbjkjELq1CwMj+dgoUjMjNsPUarPEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498425; c=relaxed/simple;
	bh=OV2rywvnygBbIkqLOT9BjIcfYgGpS25LBhRJ/xr4F8I=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=aWjnNDavsJnYTHdskjvth83pTYH56hbRQIBaSsPglmdgO8KhgFXHF6WY9/JHogLciPSomD3j9GFr9CUer0gQw6q663KhwVhZlq8oWXHSr1BuPJ+cjSdi4ucigvt4s0Sz9dHBkHdKKhB7i7QeKfSaPHeEVnztPGSyU3RrmmIgPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0rVryi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F55CC433C7;
	Wed, 17 Jan 2024 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705498424;
	bh=OV2rywvnygBbIkqLOT9BjIcfYgGpS25LBhRJ/xr4F8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0rVryi4dFAQbbrNXrJvCFAuLba+m2Zi+QemNPCh6meiGFXyZQBjjNLTVCrvjQUJ3
	 p1iFHyacx1dCV3o5f717K/Ra2YDMDtdn6iYo/em4SJMPKA/KyyfPO7d7LDp8uzP3kV
	 M7yqDUL4lEaXGj4wx9IHhiuAg1dJxqrSYZ0eJYqGQq2Llum0qNnn6cAPi7YY+BRnuG
	 bQg9q57F96ID0bNDnUBYBEo8A0sWYgU+i8/3ysJ3TtoLYrDq4uxpYnJRYQVHInzH/9
	 8VA83mT1nAVUAYMuc7TS9+yaRfzNSwPdPReTyw8cX6Q4+4hZRzGof19jOfii3ULgHK
	 HkMegeKnw9cCw==
Date: Wed, 17 Jan 2024 14:33:40 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-man@vger.kernel.org
Subject: Re: [PATCH v2alx] MAINTAINERS: Add man-pages git trees
Message-ID: <ZafXNac8p8CKk1_U@debian>
References: <ZafC1MkKDAK2s6n1@debian>
 <20240117122315.15698-1-alx@kernel.org>
 <20240117130705.GB2711070@pevik>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kbBG7tvQqalPsVWF"
Content-Disposition: inline
In-Reply-To: <20240117130705.GB2711070@pevik>


--kbBG7tvQqalPsVWF
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 14:33:40 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-man@vger.kernel.org
Subject: Re: [PATCH v2alx] MAINTAINERS: Add man-pages git trees

Hi,

On Wed, Jan 17, 2024 at 02:07:05PM +0100, Petr Vorel wrote:
> Hi,
>=20
> > As the man-pages README documents:
>=20
> > $ sed -n '/^Versions/,/^[^ ]/p' README | head -n-1;
> > Versions
> >    Distribution
> >        <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
> nit: Shouldn't this be kernel.org instead of mirrors.edge.kernel.org?

I actually don't know.  Was wondering, because kernel.org redirects
there, but didn't know which subdomain I should document.  If it should
have no subdomain, would you mind sending a patch?  Thanks!

>=20
> >        <https://www.alejandro-colomar.es/share/dist/man-pages/>
>=20
> >    Git
> >        <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/>
> >        <https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pa=
ges.git/>
>=20
> >    Online man-pages
> >        PDF
> >              <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/=
book/>
> >              <https://www.alejandro-colomar.es/share/dist/man-pages/>
> >        HTML
> >              <https://man7.org/linux/man-pages/index.html>
>=20
> > Suggested-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
>=20
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!

Have a lovely day,
Alex

>=20
> @Andrew: whoever is going to mere, please take this commit
> instead of mine.

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--kbBG7tvQqalPsVWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmWn1zQACgkQnowa+77/
2zIzPg/7BLzwynFsoslvUuPYXIo53GSoHzH02N04NIbbo59xrkan1MgKbDT8oJzX
xLlZqKK3cX8PzfIGlCo7dMgxpDP1kstwQcsQVrllFKmpK+IvpabVyRlBvdnlcGE1
O1U+rcsPz1ZuiYLLfyTwtRuYsTNgXicNsJvqZnOj3D7s3x3cryDrirdRj49QzEEz
A9O24npTmeYIUy+sgOWYYD0f8EUDtuB8EaZriTpM7wtYcuOpGfIX1COWzo3J/H6V
k4zICgI9Mw0FRvknNhx6PEHFy1p7rOmmxDsFMmGvtdsI6vSoltjeiuYqtic4hVNs
GKdEHg1TW9euuC48AdXNfPti5Jm6E1ViH687ZrbP0GSsg9dPy1raYD0t5txqybSD
02E7oiBM7UkGYhLZvahAoUfElAbDN6uRG4p1t8SEcsw3xNy56I6vbSmmEz/B2hr6
wF66itnOYa6Avr1K+WtrPCVrpDOtxDLnaBCCEg2+1FhoJ79RMAPMAKaL8XF8zwZz
SiifCxdnZOtXOvZm8m3/UOyPzxuXLWcw4+NnSCKApPYf7mCXZXU480bXRY1rv38I
n5sObQoQ38X1Z7ZrC3oCnhZ0LBwhL4sGwXrUS9BSMgLa3aELaA0Ye9zfcxVY8Nz3
tKxlqpZx50q948ZVKCUy51SesVpr4hA0lZHZ+GLJYkwcB6ZARgQ=
=xXJU
-----END PGP SIGNATURE-----

--kbBG7tvQqalPsVWF--

