Return-Path: <linux-kernel+bounces-156758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600138B07BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15447282DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11F015A48B;
	Wed, 24 Apr 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbyJFc2Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC715990E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956067; cv=none; b=kG/MJ6780YL4hIqKfSfiYRVRzAKfzT1C//5BTGej+KOmiuKuq4Ekff25CZkeYDDuENrjtYnhm8XjpGovARwXuYYOUgcK7mVciNwyhm0eyzIWoKDuUAbJMbhiT1WPBV3vzPFL3hm9DWtc8LLoMemrArPmnqf3d+pl5vANJxyVJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956067; c=relaxed/simple;
	bh=fkHyB5kj3Ej/ZXKY/45BZTmNjWhhIKPLZdiQon3VcSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgwpnC5t+cBLpzIMejf9PXjQu2EWpHPFaLzovhj3FMCV6Hjah+djKGXEHWHmWH9fkKA45wJniJFO28zz5IEebBkB0s3nexBS8uwli+5jR1qrJHJk93dKQmf0CiWcOCJvGv+TiYzxZ3o94OWzaGu2WaPsr8CoP+PyM1NyFJ1FQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbyJFc2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7107C113CE;
	Wed, 24 Apr 2024 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713956065;
	bh=fkHyB5kj3Ej/ZXKY/45BZTmNjWhhIKPLZdiQon3VcSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbyJFc2YnTcKJDIZRzIvhgWCjZzeHXxwCVeyeYiQ8XoOfPuatv+oEH/XcMTp03LY0
	 Cwu93uNJYhYGnGjULlzOCbfHN5DIiNllO30y62XE2JC35Wyslnh1B/r3bA2gdY/LNn
	 UbSraV0GL24QyqQh/LPQoj/bS9cMCEh6kxrbHwOpT/lZwWkljNC08IK7CWbt69mM29
	 zPyX1z25WUBlFJ4qxPbFFYWEgUFH2jhrPRwSG0HKfPiaVUhBgQ7WD8ctqGGJvWYj/e
	 4HxSc0UjxkCq6k8OTGLP2Zk9NRnFSbM/iYlZFGe6Pk31Pg9yGCRe5U4LsOGwrsIwA4
	 9d4cJ4AtE9V2w==
Date: Wed, 24 Apr 2024 11:54:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] riscv: Remove extra variable in
 patch_text_nosync()
Message-ID: <20240424-denote-alike-ee3858fadecf@spud>
References: <20240327160520.791322-1-samuel.holland@sifive.com>
 <20240327160520.791322-8-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SgmRl1SXMlQwXumE"
Content-Disposition: inline
In-Reply-To: <20240327160520.791322-8-samuel.holland@sifive.com>


--SgmRl1SXMlQwXumE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 09:04:46AM -0700, Samuel Holland wrote:
> This cast is superfluous, and is incorrect anyway if compressed
> instructions may be present.
>=20
> Reviewed-by: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--SgmRl1SXMlQwXumE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZijk3gAKCRB4tDGHoIJi
0rb7AQCCj7ZCc8NyZE6QkSUhR01PWj04+Tq4L9okpcXedzoF/gEAwV8OBW1Nebs+
jrMyFx2hDjwDR8jmZUooBX1qvqS26AQ=
=d/Y7
-----END PGP SIGNATURE-----

--SgmRl1SXMlQwXumE--

