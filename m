Return-Path: <linux-kernel+bounces-73217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2985BF80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00583281A84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB1374E10;
	Tue, 20 Feb 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQomGOGI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6E43AD3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441791; cv=none; b=HdzeQKo79mSENXC5glRbU9n2A+JYb+MQRcwhiHCQktlpT1QFSaKMsusYKlZBHG9RU2eVJDbOgZB6sBMbI3e44992jPZcel0/2+6tQjMWnI01rg2phvx1Vr4G2qbRz/CQoKj1sY80f23+g1lTwcIUhe1JNH1k29+2wp1JfP8Jz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441791; c=relaxed/simple;
	bh=lAgKtxD2nv84dNtBapCFhQp7mMx44kYtY9KqtDFqjzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8bsNEg1pQMTxJpn9bTgW4cbIiKx3W+bADjjaS4FdKSRUxR5w8f+rD4U3slpvUiWlzYpfIM6/85ZNA8TdW8QjxVmvDdXFDAuBFRD/r6czOanN0ZdaxPsfsmr1eEsLbDJzanH1O5NMrx0XIbPlN9l+PExwQtGopdbwLJJ29EEmG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQomGOGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C89C43390;
	Tue, 20 Feb 2024 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708441791;
	bh=lAgKtxD2nv84dNtBapCFhQp7mMx44kYtY9KqtDFqjzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQomGOGIzPZM8iQxveIPoYACQ4CjVkB4qjTNUM2tW8NgGql29SXPWEuDAJKe5YUu6
	 hr7WBMem+JVuszdPYTllpBrfJGeiK02f6Q+nnkPeHw0tlnDp6Es3FVjss1PdOOfr8C
	 yL8VWPRXFnxkPlaDlJwjiQhylQYowBlL7YKa8yHtJd+pyftnqUuwoXTEXZFi83fI7z
	 25BbkdXxrvFHKmFE19zJaX1Q8ZPWlt3jFcV0mblIl9iNm/5RzjP3DFROQL/ebZLpn8
	 gInkFkecaEhwgaK9fREcXjv8ZmY4qG5iTYToKzxTvu1sUo4+hiVDUaEabYFi9lY96r
	 grMiPssyagpLQ==
Date: Tue, 20 Feb 2024 15:09:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/sysreg: Update ID_DFR0_EL1 register fields
Message-ID: <013824e8-4c6a-49c2-9390-14fb8090676d@sirena.org.uk>
References: <20240220025343.3093955-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5SAdbaI1A66lv+ge"
Content-Disposition: inline
In-Reply-To: <20240220025343.3093955-1-anshuman.khandual@arm.com>
X-Cookie: E = MC ** 2 +- 3db


--5SAdbaI1A66lv+ge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 08:23:43AM +0530, Anshuman Khandual wrote:
> This updates ID_DFR0_EL1.PerfMon and ID_DFR0_EL1.CopDbg register fields as
> per the definitions based on DDI0601 2023-12.

Reviewed-by: Mark Brown <broonie@kernel.org>

--5SAdbaI1A66lv+ge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXUwLoACgkQJNaLcl1U
h9BPUAf9GFWcuDYz4jmmY76+YIOaffG/ifcwmLEruARgKvIFonI66TSMRbE1RXh1
m+wbibEJKy+Ig++TZfkzGjw9nxnTuP8NI/FScC92HTwOJCGCTpYI8izgQ+lnByIu
wP2YOMpPkb9AsRIwoCQtENafsssbbq6wAEPVbTlk1L+C/WKNJlieoA4mEcejG2q4
4kkqOnTagKmboL510Iv8BWT31ziSOUbmb1jBCsg84XOuDhEEfi0ukqb16RmBGd6k
KX7XjGidB/VGkOvgmo5jCJcv11lN8LtWKZ9wiUYaUh0wdtQW3hwowUxU6IR+56Vo
ltV83eD2YJ06oRAACRC60opaFWqUUQ==
=eACz
-----END PGP SIGNATURE-----

--5SAdbaI1A66lv+ge--

