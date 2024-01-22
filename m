Return-Path: <linux-kernel+bounces-32228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F98358DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B092822A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D04367;
	Mon, 22 Jan 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0U7WMZh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF56161;
	Mon, 22 Jan 2024 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705881936; cv=none; b=N1Whtd5KOBolm1Dbbi8iPa8D+AXL1ak13lBYYRd7Ss4mOq0DYpFsPvYiq2iJ+AxoWuiHmhl/meDlmwsgxNJEHILca34+2kyENCxNc+/jr6/l+UCbf56tFnx6UxYL6/hqWnCEfd7Lshbf/l8SrxAITl63ce7W77vtkzqj372s6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705881936; c=relaxed/simple;
	bh=Au8khH7Zv4k54FCEbuCumzTavqYrGgfeha/BOwnvUWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3MMs7VaJYYqMDA50STBV4dNBfpQ+/cqTe9uJB1tkbP3SXZg/Y6FFdbc5KutrlFDx19/1TYPGPOa9pYUQwZ4ZcJoXPFtXRmgsA+uHb4Ub3/HMVkeEhhyd6BVHBPDBsf9rZwBihIr7ouYaXJwwwKx3VcCFY72UOUgfdp5Ox1gp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0U7WMZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78177C43390;
	Mon, 22 Jan 2024 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705881936;
	bh=Au8khH7Zv4k54FCEbuCumzTavqYrGgfeha/BOwnvUWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0U7WMZhiHdgNJK8eFxrBHzkcN/VbL2sUtjrwivlrsFMLQ5LhCuDuC/hOQpqogDYD
	 PUvW7V6sLvs2/L4F0ccC8ax7wgp9YOZOCbGnYMu0JU8gxLCfqRpgUp+5uGrIq6SOj7
	 Tj78TjaHqAZ9Dp+zo2YS5sSqGpFeaAECDE+OL0i/wyRMvBCfjiy2GELcqwt6NW7XLp
	 pOAHDn0Se4rlLQySl++TFSSq1rwbeJimHxeQWLqrkXWEWKEQOL9tf4yvV/V/tYG38w
	 XPE3hTy4r1E6hrlK4NZAwhTZNRpAGv2qELISwpg4FZBTRyVQnvPr4iy8HxOv3f51Xl
	 a4IFkcyiQBrDw==
Date: Mon, 22 Jan 2024 00:05:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Abrecht <linux-sound@nodmarc.danielabrecht.ch>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: soc-core.c: Add "Unknown" and "Unknown Product"
 to dmi_blacklist
Message-ID: <5e501a1d-a729-4844-b2c6-53d5ad332a69@sirena.org.uk>
References: <7d11d0711ad93f2208efb9ab13fe915b@abrecht.li>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U+17xNBKgTGscJDm"
Content-Disposition: inline
In-Reply-To: <7d11d0711ad93f2208efb9ab13fe915b@abrecht.li>
X-Cookie: Your lucky color has faded.


--U+17xNBKgTGscJDm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 17, 2024 at 02:44:43PM +0100, Daniel Abrecht wrote:
> In U-Boot, the default for DMI vendor / product if not set is "Unknown" and
> "Unknown Product".

This doesn't apply against current code, please check and resend.

--U+17xNBKgTGscJDm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWtsUoACgkQJNaLcl1U
h9DtcAf+OakNOFcayihvk5bRMXUxk8S8CKm286BI5igstoC5Nmy9HY8CjQpcJeTM
xZTx10eWu3HGcXob1q3Y4jej9ji5IiOulc/S9nAxxLuZfdefTFLS1ntb2HH6qdop
vnRNGu8vtSRrB4+1Kwqnlnxx8bW/xR3E8s24mmvA/rfBkg/GnfcgMFtJwO8fMIRf
+IUjUrYvYbzrq0GRLsIKsx7HLwDqjIGYMwLbj1cxGOHPhLlEwVN50Qa8Uo1SSsXP
fXvqh7CLA9qApLkVlHE/GfygEfT30Y4+cHbUMtXmOF72jjII7UbyJFBnam5qC/qJ
JC8rmYmN6WJMz4hITVGpKDwy4gD8NQ==
=s9Bt
-----END PGP SIGNATURE-----

--U+17xNBKgTGscJDm--

