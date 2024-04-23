Return-Path: <linux-kernel+bounces-154519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2878ADD11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2369B221A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2F3208A7;
	Tue, 23 Apr 2024 05:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIO6khEz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B41B966
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849456; cv=none; b=NNoSsXa2xhRFInvKs7ac7dJAixrl5eKVf9RVw5Jvb7VXRHYFrj/OXxcbb8KyUtbskJydr1LIMFvXqmrL/03lX+bPYHEUJfhuYjcsBuCb5oDGLYKm8TbQ8g+5KcKp7p00L8gjFj00ZSYMaCarTtprp4m68N+50odWLAneEL6kDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849456; c=relaxed/simple;
	bh=HeotCJcghQNRi29l1z9kedkrAnyUVRoEWfii/QDKt8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwReKL9cW9Q/U772T57gqB7II0ASiLR+BYD2Dp1bYFVdAfYUUACnYhtpfxkLs2Zcv0J2TOkzc9ownIVNzZqGJYqdVvX+qnpT8ZrKUIq+W7O/KMDsFHR38vMKAb6AiwFapnOuEEjFjR7qvAqmvheJXdqFl1dM2mMK5/MmkXMcLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIO6khEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0B1C116B1;
	Tue, 23 Apr 2024 05:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713849455;
	bh=HeotCJcghQNRi29l1z9kedkrAnyUVRoEWfii/QDKt8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIO6khEzSV5X2pduJLo2BZ+/nmO14FmNE7MgN52sse47jYAuzu7qSJnA0fPMHfcqo
	 TLLJypvQOOulbffvV3jP2+9gSIYh78OHa5ho5avD3bOHlKeuSACyl7yrSdlxVdJdyb
	 gRk226h8UonH2h/jQTGWGGUuGHNsO6R4pyTbp+FFBrpcXaAsSPkDRSl6gAGwualhI4
	 64QTt6Ws2h7bawaYfwrv0lubFh8pHYA6C02w0gCuvVcRHANFBn8UczJfRQIQqSWkNt
	 RC5Y/tEfrE1kGqQuID6prLWrgUtDkbF2l5Nbadlre5y7nW4GM77o8iDY3tG1BgRpca
	 fNsFqrrUmESuA==
Date: Tue, 23 Apr 2024 14:17:30 +0900
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Update ID_AA64MMFR2_EL1 register
Message-ID: <ZidEalY_V3bXhJrJ@finisterre.sirena.org.uk>
References: <20240419021325.2880384-1-anshuman.khandual@arm.com>
 <20240419134623.GE3148@willie-the-truck>
 <49365864-0080-4ddd-b0cb-eef41c88b6a9@arm.com>
 <20240422171613.GC6223@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J8bn/pOzNwfYEkkm"
Content-Disposition: inline
In-Reply-To: <20240422171613.GC6223@willie-the-truck>
X-Cookie: TANSTAAFL


--J8bn/pOzNwfYEkkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 22, 2024 at 06:16:13PM +0100, Will Deacon wrote:
> On Mon, Apr 22, 2024 at 08:38:40AM +0530, Anshuman Khandual wrote:

> > This is not being used currently but will be required for upcoming
> > features. I was under the impression that register fields (atleast
> > for the ID registers) should be kept updated, with latest released
> > spec ? Besides lately arch/arm64/tools/sysreg serves as very good
> > reference for all necessary register fields.

> Why? The linux headers aren't documenting the architecture.

I don't know that it's something that we should be doing apropos of
nothing but if people have done updates and they're not unreasonbly
complicated to review it does seem useful to integrate them to avoid
duplicated work.  There have been some issues with that around the ID
registers (which are going to be on the places most prone to this I
guess).

--J8bn/pOzNwfYEkkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYnRGkACgkQJNaLcl1U
h9C6Rwf/Ss9y362yQfFUmqUbdi+GZr96SuHmRHPsQRhOKnjP/fmjGX5igoJldgcG
wfa15cpBIwRKW46rDlSVehzzX43u+zRKd6CMtOjRrol173F6hXVfIXHGBi2a9tdj
5oIAsnytZD8ho36DjdrzkxKrDytuY57B4034LqPLQ1GqAR7ay3PMXHN8PEyr8H9a
6iCjg51kcqjPozIqBTcf+PGYB4U784K7Tf7RPG2gRWTnNYhy/0oOT62khSZCTL25
CBbpnbyKeQdp+dBmF8wB6mGjsVnHATsrC82d3av6q7aLBrMVPVF7Lccghe3A7jT0
yUXFEtHLFdooQirabUSk+EDz7Ej+EQ==
=h7X/
-----END PGP SIGNATURE-----

--J8bn/pOzNwfYEkkm--

