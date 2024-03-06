Return-Path: <linux-kernel+bounces-94040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7987C8738F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1571C20D74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0914134735;
	Wed,  6 Mar 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaiMRe/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC5133425;
	Wed,  6 Mar 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735049; cv=none; b=lGQu9jE7jNIkU8e7GQitz6eIKA4Kk5PX79ukQRCWMZCTli72WZUHvLQgzrpprZ7zDH65J29DxU4t9IPE2pNcrrIlp7UC6eJFIwig8sbdLRj3zqYwGD8faGSKs5mwIbSukKop3wq3lHhth/XgZtqmnUpEaIFy9bmb7VcAjI6BG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735049; c=relaxed/simple;
	bh=NHmFvRnNMD452asVhlhHNDgJw06OaHqITdfsgJNpHh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2ZsLwQXyJcoBGTLRv5yDCoBP9WSgUWFN6mvbK06Ln0GLxYxtJbryHxUckR8PBimeV6Z2fIuWd7wLttk/K6TucIzGaehqZDDPc9fFOfB040fe6A5zfDSerQKUjnbC+RqONF8K361V4WzmtNtymMxU9GAt+/nn7HtCwIMlVFMoFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaiMRe/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20741C43399;
	Wed,  6 Mar 2024 14:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709735048;
	bh=NHmFvRnNMD452asVhlhHNDgJw06OaHqITdfsgJNpHh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaiMRe/2mFh6h1S8urgy9n5GgygPUznUpk9N2V/+cQ8hjqJykFfAzwDLyx9Y0hLzf
	 Oth1C9Esz9x9ZJKtdBkuuAoT5UUo6dCg8ag1wX6Ypa0Z7fY8O+PkUP75hQas9gOxUM
	 7f5AH2JZ2xkZlKveKRMbN7mLeJ4agEQIao7sH5dtWyX08GxvCz2rt20D1qtlc697g7
	 ERm2e4/EbBiBnZk3iLBPTsSZXXVjD7fqmjNcGZk6FqVyCuk1hxAYNm/ccE388K+YSO
	 r6w41nF6E+1cdk/YaYMrD0+jdVMC5YC8vJ63ViSejSWqARljgjDomzQmfkuYvmdP4P
	 dZwpKdKDwdMYA==
Date: Wed, 6 Mar 2024 15:24:05 +0100
From: Maxime Ripard <mripard@kernel.org>
To: forbidden405@outlook.com
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: set initial best mux parent to current
 parent when determining rate
Message-ID: <20240306-inescapable-astute-bobcat-20c3e8@houat>
References: <20240306-mux-v2-0-92a5fa461fd2@outlook.com>
 <20240306-mux-v2-1-92a5fa461fd2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zf73hvuk44f6kich"
Content-Disposition: inline
In-Reply-To: <20240306-mux-v2-1-92a5fa461fd2@outlook.com>


--zf73hvuk44f6kich
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 06, 2024 at 12:22:23AM +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> Originally, the initial clock rate is hardcoded to 0, this can lead to
> some problem when setting a very small rate with CLK_MUX_ROUND_CLOSEST.
>=20
> For example, if the lowest possible rate provided by the mux is 1000Hz,
> setting a rate below 500Hz will fail, because no clock can provide a
> better rate than the non-existant 0Hz. But it should succeed with 1000Hz
> being set.
>=20
> Setting the initial best parent to current parent could solve this bug.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

That patch makes sense to me, but this changes the behaviour of the functio=
n.

Before, if we couldn't find a good configuration for the rate, we were
error'ing out. Now, we keep the current configuration. We should
document the new behaviour in the function documentation, and we should
probably run that through kernelci to make sure we aren't breaking any
platform (and from experience, we probably are).

Maxime

--zf73hvuk44f6kich
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeh8hQAKCRDj7w1vZxhR
xYFUAQC64cGB/6QatYSjC3DnlztHH8x/x6LsjJUpD5B/vIbvVAEAmQ+PxbQ+4VTJ
iPySZ72xkzqMzdCHaGE2dgv/wYd63gk=
=+nPB
-----END PGP SIGNATURE-----

--zf73hvuk44f6kich--

