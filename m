Return-Path: <linux-kernel+bounces-52831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A62849D32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A10BB27A36
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337252C1B9;
	Mon,  5 Feb 2024 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqJR7F2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783552C197;
	Mon,  5 Feb 2024 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143790; cv=none; b=IusV2UoMHCfKmsZzAfj8sopNRZKWg4/qJPbMm+T68zqqFY7h92/rp+KbNBNBoCpTPibgmQXYYqhGer84tFrKnl0VBA9J69QiYpNmsGWA9Riej34luPuLEdGONkBMOjxhrAMtzDVxNnu+eCXUy2qtSiumpAxAhQt/yUanhTjCJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143790; c=relaxed/simple;
	bh=TQBPDAmFUjmyp+0rnwZNqMJCXIT6ZMLHiSBMkaF8co4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrGS4YLq1kStxaOdw829XcHAMfp89e0TMM+MroS8kszCS1ZNWX8vJ6XeIvG0lpUZ/cwMIvAZWVLs/7BooV5g8/kOu6swTJsYZfd01gI6re/QGsG7J3EOJAotEkXhEWmTF/81kcK8yTUbd5nO6rCqQbOf4jyWnuf9AipVxFsBSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqJR7F2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889C3C433F1;
	Mon,  5 Feb 2024 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707143790;
	bh=TQBPDAmFUjmyp+0rnwZNqMJCXIT6ZMLHiSBMkaF8co4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqJR7F2z0RutzJ+trP+hqeWZ+7u5ctKNBmybXKMMmHtXpz8QS3fxI8omVM9Db+Knb
	 wjTaraTvkUztBbGtuULOp1Dq4BuNFZFviFQgaHxpwO20nq4r2tpWVfioC6pZt781J8
	 aBKOK2A4kuFqP4oIkZ0MN/Tms3q8EOO1qftWM/IaGaQ3bhUMPIbv5gXBlV8dgoPSUZ
	 6uh/9BteAyi8bj+TTxGlcVdEwVEN26kE5d+SSIeOxgGqhtj0Df7tVZrWAOD0MxAG5m
	 a/RzbfidlC/1b5cgnbdLHQ8YzwDDLnHYkAcwcLiU+BNOTSBHRcdkXtayCP5lF93ELl
	 Km3J18MHoH1hQ==
Date: Mon, 5 Feb 2024 14:36:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: SOF: amd: fix SND_AMD_SOUNDWIRE_ACPI
 dependencies
Message-ID: <ZcDyaUoaBT9gSsd+@finisterre.sirena.org.uk>
References: <20240204212207.3158914-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pa4f4aDKEaEPk88N"
Content-Disposition: inline
In-Reply-To: <20240204212207.3158914-1-arnd@kernel.org>
X-Cookie: You might have mail.


--Pa4f4aDKEaEPk88N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 04, 2024 at 10:22:01PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The snd-amd-sdw-acpi.ko module is under CONFIG_SND_SOC_AMD_ACP_COMMON but
> selected from SoF, which causes build failures in some randconfig builds
> that enable SOF but not ACP:

Please don't needlessly combine tangentially related things into a
single series, it just makes things harder to manage when they should go
to different branches.

--Pa4f4aDKEaEPk88N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXA8mgACgkQJNaLcl1U
h9A/vwf+J1Fu9RGe+hksZU7MhfRrchcEBnUZpNRYIJh8+uznAT705LBf2VVOcSXZ
hxCCaYckGrMTgI4RRXwufrz//TlTaiXMS4SQV2fnixF/K+S2tGHp8nRC0BVVf5wx
7GwxYaYkOWakjyN8boD/707zKs+RjR7wgaOg4i4v/Dr4eV2TyZkjumqVV5ZzGW0c
6yg8XTuXBWxg8NafLyHa2jOj+k+p2Z93cTuYQu6fWkrNCXt5SzeYVY8O7nEm+Ipe
3N8GfzQy7my8Boi8bxaGQACsl3jDLtIFqpap230x9D9JRdrVecv+NHX7kHcA0Zh4
Zx4zaVoTNh0SQDR8g5b+hJ9FPK9LtA==
=wKBL
-----END PGP SIGNATURE-----

--Pa4f4aDKEaEPk88N--

