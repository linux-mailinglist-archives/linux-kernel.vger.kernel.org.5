Return-Path: <linux-kernel+bounces-35039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8928E838AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9991F22138
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6420C5C601;
	Tue, 23 Jan 2024 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAGDujtn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CECF5C5F1;
	Tue, 23 Jan 2024 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003373; cv=none; b=T2VnqpSN0zcud7QVGcdXH9vLejr4jFTzGPptJDTYp/Ll4hP/Lz29YbBHVMMFCV8ExLEo4o6iYyQDjaVS29YgtztmPaXQ8VV8Sf3bBLk5LKFDiQ5QJ1LghY9uPfG1MeUakS9Gfj0DShpG//vP8QK0z/BoHNzube3VaWqh1sWvStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003373; c=relaxed/simple;
	bh=4tKkrMzOezkts98c7O1jAxgD/J6EMADqSj3KA2Osl04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ8/cDGw3pdW7cDXwwTcO5vz8DPDjEiHkBsitY4K3IveHBUda8po/vbDWOrmXrsoEnKjpCzLX96WUbFP/yzze32Ch7tAdlwovMRJJlKpz77g6jr7rucDsVRgxkxrNOP98kj3i0xHAQvkbGGV/CBYIwZwR8r6FkqnzLPDG52QjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAGDujtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC25C43390;
	Tue, 23 Jan 2024 09:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706003373;
	bh=4tKkrMzOezkts98c7O1jAxgD/J6EMADqSj3KA2Osl04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAGDujtnHEiZsJuqN1nVJFMN/np1+XR3MnwUaMxoJM4VRcbV/cPlACEFbeg0lnpZO
	 rwb3d5C+M+74dH9efEvS6sdTOoW3scEqiMYY1kfwE79mYUk0qSfLSKP/sq9dQeokQ1
	 43xxMA70rudaOpHlmNFcfeKa3AZbyR9SWVMX+0j9TfsDX01oxym4/R7QiZpPFeudbL
	 qxJvp+9pF08evm7uejy34BEV7PLeLgtId4983JukFfUreTRPUueMdarXJAj8VPV0nR
	 Quou1xZx2AhnChUkc4JxBzPPrLodCtAZry4gI3XcJA5gMUi5e7rEbk0t75dw5g8Y9X
	 1RlpMhSYDmZHA==
Date: Tue, 23 Jan 2024 10:49:29 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-staging@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] staging: Remove board staging code
Message-ID: <Za-LqSDUbLGp2Mke@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-staging@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <cover.1705932585.git.geert+renesas@glider.be>
 <eec1bfb2878237888a8c3bc866d18dc53900739f.1705932585.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L2v1YfRFEceDTTTe"
Content-Disposition: inline
In-Reply-To: <eec1bfb2878237888a8c3bc866d18dc53900739f.1705932585.git.geert+renesas@glider.be>


--L2v1YfRFEceDTTTe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 03:24:33PM +0100, Geert Uytterhoeven wrote:
> There are no more users of the board staging code.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Hooray! \o/

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--L2v1YfRFEceDTTTe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWvi6kACgkQFA3kzBSg
KbZR0w//fsbm2nqehQ1TLygxIL6L/Om6G+6Ik3rcEu87/8kr7hPEj6bUAr0RB/Gl
xzmQ0qwOKtEI8QjuFx6A8BXGqfOoETW6PBnUUCG+geRE/3H0ieQrMttmcA6vBsQj
Al/QdmArxVKQbegw/6LLbNdlFavP/lkoWJkbfRhaZFm6VgUhJqWTPp5iVQC3cKQ3
QdJn/0APfMpAMS8cvY+g0iabVvUOeUE+F5C5ynIv1eoW5gjpGbsFS2h2vly8KRTt
mJRuieyz7HF6d/OcL+EGcCISGcQogrch2Q+jgZT1fKuKRK51VDVJgXoqWLgLHW5A
ULTd/gf9gc2mCnFAwXyzs7BmHRzcCktAk+0LHKYaqLTZ6xtYDDvB0DhhVD9cHU5c
+7Y6L7xhTwS50IEDRiZWunqL/WYUfNVzZvoITcI26pTnq4gq2h7Jl2woVeypE6YO
By/QbuWx9O/BcxY3RwQPVYaj8kYHTshh5/l6XD9lSRrtKggmQkuzkD3DlphEuIAq
ZOs/5ggAf0/Uz7HC4/LaVB18ArQ0FSgm62l79yR3aUE2wvh0vPRaFKPpMvMu47ut
fK0HUDFBsX3xsHgvCPz4HsLglYo8WxZSMp4rfdczz3s6AEY2kdJg72xt9I6Bg7ky
Z2GaJ5CkBYLbrBp9JCVVFVy1SGKM8bpFWZL0L04C0IGozj06ims=
=b2C3
-----END PGP SIGNATURE-----

--L2v1YfRFEceDTTTe--

