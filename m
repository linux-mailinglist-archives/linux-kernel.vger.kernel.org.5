Return-Path: <linux-kernel+bounces-5408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6DE818A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFB51F2D5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3E1C296;
	Tue, 19 Dec 2023 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dehLBIGr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B01C282;
	Tue, 19 Dec 2023 14:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A9EC433C8;
	Tue, 19 Dec 2023 14:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702997061;
	bh=Ec49Y1Ch4Y7DbynL5qJ3/M6jv5kHIuiLATbynFYdEYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dehLBIGr1LajE1OtvLVTLPVToTCjSzGsWdAe/pHVJeX2MIrC9m1mPTvooMTQrt3ta
	 7RGV4aXSoxoCh+Xnx0YICqWv36ry11nHS/nzEb8E87JqaOK6O/XvQtbWdjvWtFdlFk
	 Ax4IumnD102EC7x7VhIiWz1tdIygL5RL82izs263RsC/22KrDePCqEiQffo0bzg/fx
	 IH02+GzjOlMJyhx/ApVqSUrufavub2gGPQRrSNemUpbfH1eoTb1/7OlF+Izlp0YFig
	 o46oeV75pUDtP1526DL2IImMqbrWtaAdCOgm36G8fWwsiUQCOCxzS0D6au1TxDVNBI
	 BlUl90OFPwCbA==
Date: Tue, 19 Dec 2023 14:44:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
	joe@perches.com, nathan@kernel.org
Subject: Re: [PATCH v4 5/7] kexec_file, ricv: print out debugging message if
 required
Message-ID: <20231219-twitch-many-ca8877857182@spud>
References: <20231213055747.61826-1-bhe@redhat.com>
 <20231213055747.61826-6-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s/6JoYHenWk4BZK6"
Content-Disposition: inline
In-Reply-To: <20231213055747.61826-6-bhe@redhat.com>


--s/6JoYHenWk4BZK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 01:57:45PM +0800, Baoquan He wrote:
> Then when specifying '-d' for kexec_file_load interface, loaded
> locations of kernel/initrd/cmdline etc can be printed out to help debug.
>=20
> Here replace pr_debug() with the newly added kexec_dprintk() in kexec_file
> loading related codes.
>=20
> And also replace pr_notice() with kexec_dprintk() in elf_kexec_load()
> because loaded location of purgatory and device tree are only printed
> out for debugging, it doesn't make sense to always print them out.
>=20
> And also remove kexec_image_info() because the content has been printed
> out in generic code.
>=20
> Signed-off-by: Baoquan He <bhe@redhat.com>

I'm sorry - I meant to look at this several days ago but I forgot.
Apart from the typo that crept back into $subject, this version explains
the rationale behind what you're changing a lot better, thanks.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--s/6JoYHenWk4BZK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYGsQQAKCRB4tDGHoIJi
0m1fAP9g+8AFIV/8mpsN7yszSR98AoukUk319L4Cyd7Ffhkl6wEA7poQh+JBuAOa
YQJL75j4TedEPF5Y6iyMMP3w1MeKMAs=
=JnLd
-----END PGP SIGNATURE-----

--s/6JoYHenWk4BZK6--

