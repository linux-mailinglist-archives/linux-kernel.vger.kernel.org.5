Return-Path: <linux-kernel+bounces-98628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EF9877CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5950281739
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8992B9DB;
	Mon, 11 Mar 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHFfUwpU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F724A11;
	Mon, 11 Mar 2024 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149680; cv=none; b=EfNVKezCNN/V5aqO8dENyOGVqaw6GlpobHkjbr6dhXT9LxNLjJb0irdCoKmlQZ5d8JADpTWCIrXWfnuoKEGEKu2fRb3oIrdaebYzZh4FsjNfa1OUyynpGs0FvH+28yhR3XV35cx3xYevIEhOhwa1moTJlRd36Ae9PboQ9AUpQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149680; c=relaxed/simple;
	bh=GW58phvo715vgZ4OLgOYs7GQ4friduHICarbzwJ+rBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHae5ooqzuBUXL6wOtK8wsYqVGoUE7jcGgEaAYqOuefndcDXDKCPbp8rosqBlJAUginUBLN+0VFwhq6kJ6KoJoj1t25foFMvD6ItRy4CJ031oZQxVWGzA68qJFiAMkHuAYawXhJM8NDWLUZ31Dboq8FwPhsFmA06RK9WK8y5yuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHFfUwpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5225C433C7;
	Mon, 11 Mar 2024 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710149680;
	bh=GW58phvo715vgZ4OLgOYs7GQ4friduHICarbzwJ+rBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHFfUwpU47zvYKu1hM+D7aUyoNUYYWyhmbB6eARHFy7mu5sAOJc1buAuJqMCkkKDL
	 IBzWEx0q2ekbVzVZxj9v9IA0ndIesT5VC0jZj2hQSZMLmOZCu0/Dmfqym4lDQJywes
	 il1bRyUc9ckkTiDcsCAAuTLlQ4g5ElqZSuqovJp6bVE8WL7sZPEQ8N67wN3nP/GEYj
	 EoC5AuEGnoa1Gnsfvr/mF/QHJ8+9orwM1kQoUQlyxFF1ecZjKu/WHs2N443Qf6KzqG
	 Sm7hCOv61YIHPp9kqUf/lHkUrjxPz1am59gRu6Z5ttUD+ZsHzv29wDXKr4kZWFjZfq
	 AzTdl7VcwIaQA==
Date: Mon, 11 Mar 2024 10:34:37 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: set initial best mux parent to current parent
 with CLK_MUX_ROUND_CLOSEST
Message-ID: <20240311-speedy-bat-of-art-4facfc@houat>
References: <20240307-mux-v3-1-0885fc1ab2c9@outlook.com>
 <20240307-hot-hummingbird-of-atheism-87503c@houat>
 <SEZPR06MB6959882F5DA673456A3AA85D96202@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bftwjk7fcovlmr3o"
Content-Disposition: inline
In-Reply-To: <SEZPR06MB6959882F5DA673456A3AA85D96202@SEZPR06MB6959.apcprd06.prod.outlook.com>


--bftwjk7fcovlmr3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 07:18:05PM +0800, Yang Xiwen wrote:
> On 3/7/2024 4:48 PM, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Thu, Mar 07, 2024 at 10:03:50AM +0800, Yang Xiwen via B4 Relay wrote:
> > > From: Yang Xiwen <forbidden405@outlook.com>
> > >=20
> > > Originally, the initial clock rate is hardcoded to 0, this can lead to
> > > some problem when setting a very small rate with CLK_MUX_ROUND_CLOSES=
T.
> > >=20
> > > For example, if the lowest possible rate provided by the mux is 1000H=
z,
> > > setting a rate below 500Hz will fail, because no clock can provide a
> > > better rate than the non-existant 0Hz. But it should succeed with 100=
0Hz
> > > being set.
> > >=20
> > > Setting the initial best parent to current parent could solve this bu=
g.
> > >=20
> > > Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> > I don't think it would be the way to go. The biggest issue to me is that
> > it's inconsistent, and only changing the behaviour for a given flag
> > doesn't solve that.
>=20
>=20
> I think the current behavior is odd but conforms to the document if
> CLK_MUX_ROUND_CLOSEST is not specified.

clk_mux_determine_rate_flags isn't documented, and the determine_rate
clk_ops documentation doesn't mention it can return an error.

> If i understand correctly, the default behavior of mux clocks is to
> select the closest rate lower than requested rate, and
> CLK_MUX_ROUND_CLOSEST removes the "lower than" limitation, which is
> what this version tries to accomplish.

The situation is not as clear-cut as you make it to be, unfortunately.
The determine_rate clk_ops implementation states:

  Given a target rate as input, returns the closest rate actually
  supported by the clock, and optionally the parent clock that should be
  used to provide the clock rate.

So CLK_MUX_ROUND_CLOSEST shouldn't exist, because that's what
determine_rate expects so it should always be there.

Now, the "actually supported by the clock" can be interpreted in
multiple ways, and most importantly, doesn't state what the behaviour is
if we can't find a rate actually supported by the clock.

But now, this situation has been ambiguous for a while and thus drivers
kind of relied on that ambiguity.

So the way to fix it up is:

  - Assess what drivers are relying on
  - Document the current behaviour in clk_ops determine_rate
  - Make clk_mux_determine_rate_flags consistent with that
  - Run that through kernelci to make sure we don't have any regression

Maxime

--bftwjk7fcovlmr3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZe7QLAAKCRDj7w1vZxhR
xRtAAP4jnq0AU2eBH/EQxTHEF/Kw0cZq4fwDzKSVbh0+2DnA3QD/bl06o0eOOtCO
eXKHNHCmleWeqbn3XdXUpoe3JNQYFwc=
=Bdd2
-----END PGP SIGNATURE-----

--bftwjk7fcovlmr3o--

