Return-Path: <linux-kernel+bounces-85062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298586AFE4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB7628205F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CA214A081;
	Wed, 28 Feb 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g65liBL2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B1149E03
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125615; cv=none; b=YehHBIH4UCF2PUvrYg4W3kOhfsdAd3RAIFM5b+Re8XZv2Cqnv8GND2PQ2SkDvt7QHT76LGs/RtDU8XBTY/L7cDubcWyTrjERL+F3mipFJDWJR0iR/XaIJFxSfpnopZBIQ91/3UFO1Ps/4VTMeGPPnm8/a5OJkSW7uckJqAnwqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125615; c=relaxed/simple;
	bh=iTRDbDJ3CCdiHtHUuQXjxzstc5V4pe8YfL+dZgzZ5dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6V5RBF+9LR1BCUQT5xEEP0cLRSVphhlBuCDqA/b0AC0qUmJ/uGrVw5qDQgu9djmakuFmzKC6En/05NGPjZ30DMae/V0neLPDreg3LtBLtWgnj+geBrq5YRzRjO3K0A/VkUlhh3f2dViBzVqkAScO1r0CD8oMwD6TuhqIqki4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g65liBL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C92C43390;
	Wed, 28 Feb 2024 13:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709125614;
	bh=iTRDbDJ3CCdiHtHUuQXjxzstc5V4pe8YfL+dZgzZ5dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g65liBL2JQynFPCFv7ZVDcGOu81QhV+xBzyeSifKala4/T+Jo21LFcscY3zTvAzAD
	 M97aFOXdYN+TuZxPFnvrf76vUlaqT90yQHeQU+bsAalhbO0C1JZHX1mT2lrOJ9dvK/
	 dZm7hxaixJptLX3/T6jbsXnroOd6H1E1bfXg6GKha+by47t8CAGbfbJMd1aLMTt6Yy
	 pfziKb6u8jNPZMwjBzUahgaLFwEcsqatYFt4CebJSEGfnwIZ0lzXkcvIrJ2XQdPWxt
	 q3ZRgXCJ5VT7fKgFp2MXkuk1UW6Pe7NHsGqYn0i/1h7WYTQHkm/4l8/Yhy9JrUDV6G
	 dkPFc13/kSKXg==
Date: Wed, 28 Feb 2024 13:06:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/hw_breakpoint: Define an ISS code for watchpoint
 exception
Message-ID: <2450a11c-9b90-4b7c-9093-c3f976f7f42a@sirena.org.uk>
References: <20240223094615.3977323-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NOMNlSTLQ6dJ6wWm"
Content-Disposition: inline
In-Reply-To: <20240223094615.3977323-1-anshuman.khandual@arm.com>
X-Cookie: Function reject.


--NOMNlSTLQ6dJ6wWm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 23, 2024 at 03:16:15PM +0530, Anshuman Khandual wrote:
> This defines a new ISS code macro i.e ESR_ELx_WnR for watchpoint exception.
> This represents an instruction's either writing to or reading from a memory
> location during an watchpoint exception, and also moves this macro into the
> ESR header as required. This drops non-standard AARCH64_ESR_ACCESS_MASK.

Reviewed-by: Mark Brown <broonie@kernel.org>

--NOMNlSTLQ6dJ6wWm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXfL+kACgkQJNaLcl1U
h9BlZgf+KjxsPf6de4G/8K2XjTNSeLQ9vpz/zEQyxonAis77kEg8CmwA9tHYGXJ3
+jzDJI6i4kE5HbNMoi3aJ7glFrcUyFBdL68nHCWAWcJ+kIaId6SmN4GoXcDZ5/3o
7AFMh4YjjnjYBy5dIP+N2ukOFjTFXpMpq1pPv8fy/Um3VQ537R7fX+AnmHzvRdaf
UcxAv78AQyGm9ZVQmLqy1x1jc6Bx8QXQLkMQ2++v2ZfyWYyX5FzAcjDJCA7TAM7u
gIas0h+epZHnmrK9PVR6Ea6cZdG30DqX6n7dJ7mi0jlegfOweGYC+kg1M75ALrka
bW2W2dtWZwKTj+8bDkfAvhoSx9G/fA==
=wL1L
-----END PGP SIGNATURE-----

--NOMNlSTLQ6dJ6wWm--

