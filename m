Return-Path: <linux-kernel+bounces-104897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB287D51E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B2F288878
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1919E25740;
	Fri, 15 Mar 2024 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6KYFR0e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47B1EB48;
	Fri, 15 Mar 2024 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535286; cv=none; b=qeb8A4vi02+lKizLzyvUsb5K+LD2MzV1gP1Eq31q3ci3LbWW6bYfGZosBd0fQeuFy6QnpyKDP5pbwhuDrMWaq186m/7soIsqVbkmgrQX/pJ5NbKIg6di0ZxPhu/ntoPA3YIksiItIYNRF94dyWKndU3jrNN1V1M1jYNoYuEFhcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535286; c=relaxed/simple;
	bh=OCGwnFTrEKMR7c0B6YzT8O9HyaNBGHd+2FsDDY5QnpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXFvWXlR62o9AYvKvlZDrTFekztcVqiKb0gqygdx1aI9XN6MSRc9gmtNxKq/O/K0C8qZeNyYL7ebVV+nver2Bs2z7uySu9G5WOSmoUF24LWKgKPbQZSjqDU3X42VcNZKpQjW9RpvjzeVoGgzf4nZaYa1gvX+SuSXsD3cbc6b2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6KYFR0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D09C433C7;
	Fri, 15 Mar 2024 20:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535286;
	bh=OCGwnFTrEKMR7c0B6YzT8O9HyaNBGHd+2FsDDY5QnpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6KYFR0eGqSI4WRdnxqRUW0SUG6msu1cMhnmPGxxyVVa5RiisKSr8sviDtWOonI7U
	 hHSyyxdUesc95vAVrkcOKoodbsd4Hqz1B/WzWELSVqPgsjmXVehj9qg14qSUaKzDzL
	 +NcM0ZzGuSMTzLQ03rFQtVh68jeumeRjIZ2qVLypThrf4ExNhreLWXMJ3xOo8mZu1V
	 C33n6H50BJQWErH07JixQ3cd7RF1iJJ3x1yZCLO8lD3uq68I9Z1czYpx5EdXGQXJOO
	 sAPuZH0yZZJDJQvfxJWCoWxG2tEvWtiw+81W5EcjqCjYcfct0bvmwkXfKmRt4CzbsF
	 hj65LPqGR0LfQ==
Date: Fri, 15 Mar 2024 20:41:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spi: mt7621: allow GPIO chip select lines
Message-ID: <71533474-eb08-438c-b7ec-5f3277c195fc@sirena.org.uk>
References: <20240315015708.13948-1-justin.swartz@risingedge.co.za>
 <d562be73-ad76-4450-8bff-38ed5d144714@sirena.org.uk>
 <2dbc59c9133542f6f8bc465113d9630b@risingedge.co.za>
 <6c92fddd-f79b-40b5-bd52-61f43d6a7591@sirena.org.uk>
 <55c5f2e0723c18384c781e87985f0d22@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D8fyoBk023SaRwkC"
Content-Disposition: inline
In-Reply-To: <55c5f2e0723c18384c781e87985f0d22@risingedge.co.za>
X-Cookie: A well-known friend is a treasure.


--D8fyoBk023SaRwkC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 10:21:53PM +0200, Justin Swartz wrote:
> On 2024-03-15 19:47, Mark Brown wrote:

> > Look at other drivers that support GPIO chip selects?

> Of the 43 drivers (of drivers/spi/*.c) that setup the
> spi_controller's use_gpio_descriptors as true:

>   39 drivers use the transfer_one hook, and
>    4 drivers use the transfer_one_message hook.

> Drivers that use the transfer_one hook benefit from the core
> taking care of chip selection on their behalf.

> Drivers that use the transfer_one_message hook handle chip
> selection on their own, within the function they've pointed
> the hook at.

Oh, this is an old school driver.  Glancing at the code I can't see any
particular reason why it's not using transfer_one(), you should just
convert the driver to that which will reduce the open coding and just
generally improve functionality.  You could add a callback to flush the
write FIFO or add that into the write function, I'm not sure if there's
a meaningful performance benefit there.

> Considering spi-mt7621.c was implemented using the
> transfer_one_message() hook, I'd assumed that it made more

I think it's just old and based on having gone through staging likely
based on even older BSP code.

--D8fyoBk023SaRwkC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0snEACgkQJNaLcl1U
h9AiQwf/UOmHNcZDrwzH7kt6mKHCl+t2aZ6FfT4MQdJ8icSErJVvBcuuQ9oJsVxP
xz1vy6RLJhwCbN5LBk2dq55XzuBxiITCjPJhusoxmvZhbYZeZYzWzzWY8aB88aFV
fyxs1trGjhla0rRAs1oNr/y5UDZFLYQvD9tBX+BWyGbous6fV7yYBycO7nYdRHd5
rsfasrQicNwMFKe1CJfKPp7GbaHPvC4drNGlDL9EaAFHGlxCp0a5ayWrLV4k1A6W
v77j7yGf8gagHBzL7wp3pTbBKfJkYxSJiyEeIvsxXpKg7cjVHMywkzWlvF9RYTvv
ZN3l1mazhE3mtXYNfbTEgMCj1iNXKg==
=gBAh
-----END PGP SIGNATURE-----

--D8fyoBk023SaRwkC--

