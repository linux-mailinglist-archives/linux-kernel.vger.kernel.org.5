Return-Path: <linux-kernel+bounces-33374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD8F8368EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8F1287609
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09A26DD04;
	Mon, 22 Jan 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVq4KqsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353EE6DCF9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936032; cv=none; b=OJlLpFtzj3kc0aV78qn15n2gCFZziYzMoY5kAMy2a1hbgsNxXPpDODRmGaXDJZ5RTiZNylLF41srG1+bgTma4mmEoEUfecrmMmRyXg2EAnnqnZNpAi1EqviGdueI8wlOej0nA7X3HU6hde4LMiDhKkPcSOrDI2mCWq3mSbVgJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936032; c=relaxed/simple;
	bh=UcxkksHxcsaVz6RDRPnLcMAB+qrTU2YcefyY8O6v3UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUd7gEsYyLkq2w1i08OX7Tk4Z1ACQ/P1yCshLEYjgR1B8PUI8e4hoXuQLliwp/8KboshOvGesu1i8PD1DG/xF9kJw3RWqk2npeDbQ57kjHoshmKtOle3d8mcDz2R/YdvutB1JpQaJPXe5nwqU9H9zMfFB9OwC7e9yAqbQ9wJvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVq4KqsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30555C43399;
	Mon, 22 Jan 2024 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936032;
	bh=UcxkksHxcsaVz6RDRPnLcMAB+qrTU2YcefyY8O6v3UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVq4KqsSzRcW77reefwLad5zgDLuUb4AQfdroqI+EsSUqYSt8bYkYIr4BKk9qBcnG
	 Adp+qnrOpbrnAaVGmFM7UL36ZVne6N+Yf1kuRFIMWlZSJySbsNjqFleB9hDy5bH6c5
	 ZLkTP35WhhDTXed3eqKKJISVlriZeCOXXa41XqRpSEAM3NSttRKiFjUlY8WRHxOaaO
	 mdFXKUTN0RSSOCSzrAFd5kLSr+S57u8BfELg77sskAdUJFTmTXmMe98S1ItAzkn6Qh
	 j1QyrUqKvCH4+THZtx+JdJhj8D0PtmGwVPbuP3frY5kdxK45BT8pgY2Qe/bSaVXT/O
	 0WegAouDBqsGg==
Date: Mon, 22 Jan 2024 15:07:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
Message-ID: <20240122-party-kosher-6c1592d49ffc@spud>
References: <607c5ba8b95b1a11b6dc532223e9d7abcc2c20e4.1705935812.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kuN3y11A864o183R"
Content-Disposition: inline
In-Reply-To: <607c5ba8b95b1a11b6dc532223e9d7abcc2c20e4.1705935812.git.geert+renesas@glider.be>


--kuN3y11A864o183R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 04:04:14PM +0100, Geert Uytterhoeven wrote:
> The symbol's prompt should be a one-line description, instead of just
> duplicating the symbol name.

Huh. Why it was ever like that I do not know...

--kuN3y11A864o183R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6EnAAKCRB4tDGHoIJi
0mgCAQCUPR4IiGRpjs5TOekItdDyYZ6FZoid8Hk5P2v5MsmwjAD+L2y9azy5sG5R
2cd89GWxsKDgC4ZjtrPDhY9LTH1ZAgw=
=mw6L
-----END PGP SIGNATURE-----

--kuN3y11A864o183R--

