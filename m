Return-Path: <linux-kernel+bounces-81464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109BA86764B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F232875E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CAA127B6E;
	Mon, 26 Feb 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf6Yy9HX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752171272D0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953501; cv=none; b=Eu7B4OqIPkBv2Z3ZqYsPigQTZNzGCVih+Dx14pxWNPauD+vYv/mjSfwGeh4tRY1zHwkAyadQBxF2Ika29yT5sCSQvXwtUSA2M9e4deDnUtEu9GsDhJSvvlR7C5frONdyJbCfxngp+AndpxybRR+SKjLd/WifSifFPPyvxWyYvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953501; c=relaxed/simple;
	bh=itffYwGu94MfefSe1TDCxGDnCpotnnqxKZxiTHVeGNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prYKYrzaWEbYtgB6QrBQfl9538vWPtFCIWvDxwiALaA9oEa5Cosz55Mx1AmMLnbASMwidqRFuoKuTMuHPRNryNLu2AVM/XtuXr3j8WBy5Tnip+W2NqPH3vzDQOPfb/MfHnZloDAtxyiu/5ahPq534h4Y01Z2Yzd2yb4bGiHwMGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf6Yy9HX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40D0C433C7;
	Mon, 26 Feb 2024 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708953501;
	bh=itffYwGu94MfefSe1TDCxGDnCpotnnqxKZxiTHVeGNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nf6Yy9HXJUCEnmTxHgRlrWDYOKAWMm7myh7wS8e8utyzKRMoZGhYASukXdXV3gjAJ
	 UBeVk2acO3gs5rhA2Dpw+0PE6XvUlQyzWgYMgCQSbaItl7ZROfjEWYZXX/dsX6uaSP
	 26P7PkiA26lOke5gyfJ12BUcR0N5hP/ECMwuvCCDoM9y5h4okyn65WM8w/7JC+sO9X
	 x7aMP4A3IMkz3t6seaJ/Nh3iGrcFUUNKhSRTC9P4W1ZfwwHdexfjnSw011aE+LukU8
	 PaLWFS8MRXROYr5ajwU7ja3EwQA0Cy+UB6WH/W4n3Tz7boYg15OcZNgsr/0NSap9uY
	 g1bnCJe7d9urg==
Date: Mon, 26 Feb 2024 13:18:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Add BRBE registers and fields
Message-ID: <79fed7cc-44f1-4afa-a969-8327be128617@sirena.org.uk>
References: <20240125094119.2542332-2-anshuman.khandual@arm.com>
 <20240226042441.4098806-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aExtrtESAOtc5MCc"
Content-Disposition: inline
In-Reply-To: <20240226042441.4098806-1-anshuman.khandual@arm.com>
X-Cookie: Walk softly and carry a BFG-9000.


--aExtrtESAOtc5MCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 26, 2024 at 09:54:41AM +0530, Anshuman Khandual wrote:

> Please find the modified patch here for a quick review and do let me know
> if this looks good for the next version i.e V17. BRBCR_EL1/12/2 organized
> per their encoding. Thanks !

That looks good to me from a quick scan.

--aExtrtESAOtc5MCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXcj5cACgkQJNaLcl1U
h9BlQAf/QabE42enqVam4rIEpqzj77CpVNTV0ETfwOtWs5DZJCKWtscZl7jxSU8i
mOJy2KSKn+EE1DkEdQ4RL6yvxmiTOuZFLnKqojBa41j3nugIXliLtxz7nVP3FHTu
nDw939Pizqt2uE7lPDCk/IpBTz7XBbw4Ls0cpQgnQeAAkWsdGru9UVCKqVj47Ern
qq0R4nZQzY1APO5VGZvtrFAS4wJ7AcH6ib5l7oophC3l7Vam3504VE4npe4u65ZO
wYJ2bTf+PUOg9G4W5QXR85wbyCM+wHK1XmwoTMa7m8uPTm7OqY++t5PF4cKrkCd4
khvTWlx7oKUPs0Efnv49LQoeA0olLw==
=wlhM
-----END PGP SIGNATURE-----

--aExtrtESAOtc5MCc--

