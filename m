Return-Path: <linux-kernel+bounces-153141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF558ACA13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D01C20F16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6F513B2BA;
	Mon, 22 Apr 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkGNxy30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B254317E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780006; cv=none; b=i6KTIjdHvGto9ZKoG2fMm04wIhYHLWnmx7gPqLrF/JSG8H/Q3xiny/mfoOBY9rKCECtf6Jl5+9jBeKHG5REv6YECQpxgEdlv3YHfPUCnFXQObGsmiWhcR1LGjDTtoROUULy7U/NzEIAfRT7ivf8OmYKQxy+zHbH5/FKe9OxH94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780006; c=relaxed/simple;
	bh=Zz/hGe+QiU8k8EUivQl4fsqSnza4y+Np7gXjWyF5sL0=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=e42sAlPrI8Ktj1kyDTDEA7lME5YphNbVSZo42oj0a/vvUwf/77jS4pa/U8S2OeRh7nUsyeO7V4Hhqvxan/F95u5+9O2TfFMSNFUe9jrBbIAPeFpoxU3gLixEotuRKC4qnlIPlIXloL6vv2smha4x3YW54jzeC66XYb4ckUaiLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkGNxy30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9921C113CC;
	Mon, 22 Apr 2024 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713780005;
	bh=Zz/hGe+QiU8k8EUivQl4fsqSnza4y+Np7gXjWyF5sL0=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=lkGNxy30oFrdBHx326ueMX/KPsk5ZGjrzc54bdbFslzEJHhYfSAI0NBGKrI3EsE2e
	 Ru/NN6hZrBqic18XaOhRzj69YKOC5bHLrzLkIN33/W4GnjjiIRsEb+YNfncu6pg58r
	 PP/pQr3SoUtL8xV5+LBhmxS4jbA3ZQzjSm9lRIpsveJMCr8SksKMj+mJ/SyUmahYzI
	 guD+SYu15yKNRgB1IvvaRj4dk0bvBvJMGgYVCI7uTM0D9rwktKJ5yEK9iCa5+9FPQw
	 8eqpfuUstbxkUMr85n8BONZhVd3GUIB+HKHxqX/gS3kZDzkWp4wsH+tzwCvZgyi2BK
	 TcKAuyaYeemkg==
Content-Type: multipart/signed;
 boundary=2335d7d0e3efe6f9e8292475c35fd961a93700a4c057916999c70d64c53b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 22 Apr 2024 12:00:01 +0200
Message-Id: <D0QKB3VQRULU.3OGYN3AFBK3V7@kernel.org>
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: introduce support for displaying
 deprecation message
Cc: "Ricardo Ribalda" <ribalda@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>
X-Mailer: aerc 0.16.0
References: <20240419141249.609534-1-mwalle@kernel.org>
 <20240419141249.609534-7-mwalle@kernel.org>
 <33e23cbb-4e52-471c-929f-65316e668ae9@linaro.org>
In-Reply-To: <33e23cbb-4e52-471c-929f-65316e668ae9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--2335d7d0e3efe6f9e8292475c35fd961a93700a4c057916999c70d64c53b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Apr 22, 2024 at 8:06 AM CEST, Tudor Ambarus wrote:
> On 4/19/24 15:12, Michael Walle wrote:
> > SPI-NOR will automatically detect the attached flash device most of the
>
> SPI NOR. Looks good. Please follow up with a patch in the same patch set
> to use deprecation_version, otherwise we introduce code that's not used
> and we risk to get patches removing it.

I missed the RFC tag this time. My plan was actually to have this
patch already reviewed and then repost it with a deprecation of
some flashes.

But apart from that, it's the nature of this flag that it might be
unused from time to time.

> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks!

-michael

--2335d7d0e3efe6f9e8292475c35fd961a93700a4c057916999c70d64c53b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZiY1IRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jUZQF/QkEs+ceCCZfRNLRIhtQw+ku1Bv4OwoR9
Y32gBAHnPVrPwkjizFLe7yqDaDjuXUFcAYDtG9RqyAMc0LzI+KmbOiO1z4K10pbj
c0TUjZbjlcHKtxkVYwp60hAXuFh4psFko2U=
=E/IP
-----END PGP SIGNATURE-----

--2335d7d0e3efe6f9e8292475c35fd961a93700a4c057916999c70d64c53b--

