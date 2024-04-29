Return-Path: <linux-kernel+bounces-162388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1888B5A70
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7711C20DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FCF79949;
	Mon, 29 Apr 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv72g4Gl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2C745C5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398456; cv=none; b=lNZjrw7ADjIVrqv/EdlRUkpgaD7P38QBKOcO49qEG40AJKepAsHz98tXGAXFwUB0IxZYjj/Guxtg5+EuUfhltH9l6F0UyVXRp4pMRTEEDDzVhleDYc35vN+cBEkfrT2Nbcb/MUvBugf5Dcoiy2TzgRrAXAGse5NNNp4qO0rPKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398456; c=relaxed/simple;
	bh=YTDBu7i4Qm3uWNrBtZ6iNRK3KTpA55FXccHlI6B3vMM=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=St0WXCRYU6gvtmITLPrPebtwYFPtLCydqS97hj31v4Tjy97LCOyxacNiBrGDSJxiN0xzKduP7Ej0sjhziFuK4QjNLXR9g3ZWr8NZh+8jGoSaMg/lbg2Q23dDu9ENvlXvoB6Dtj8bg0kCQAK2Nw0CfTbYjao2hHGfPR7fQO1WyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv72g4Gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A29C4AF19;
	Mon, 29 Apr 2024 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714398456;
	bh=YTDBu7i4Qm3uWNrBtZ6iNRK3KTpA55FXccHlI6B3vMM=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=Xv72g4GlaEdk3wBng8Z5HiexlLCD8loaMEjgufAWr7g/rzguM8zgkXjP2Fvhf0W20
	 380Us1/2fnsnNAemrg0MlTNuE65w1ocXpnyyfiOl0kkndIS7NAruS5J8auWZdw3Z+y
	 o1nY4Go5/KENX23/KTMwixIjLdlVVinVGvWKPy1MvF+cYDB4jAdJT5MMEgYKXM2E4a
	 XYXVFEaTxcih5FnogwMYiq6RBhloy1E/y1BpYA/Bdmx+SMFK54oddp1pOlQvnMpJNR
	 OQs/fn7d7rlkRru4/xBUW34o6dcF05Bvu1YnVkaMyRnEDqBFFdqeFBqzBrePWoownx
	 dqsqHedEUh2QQ==
Content-Type: multipart/signed;
 boundary=835c43056ed51c66bddab6950631070232af469583daba94213c5b42a3fe;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 29 Apr 2024 15:47:13 +0200
Message-Id: <D0WNIVK1DBL5.3KQOD1K2O128P@kernel.org>
To: "Pratyush Yadav" <pratyush@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: replace unnecessary div64_u64() with
 div_u64()
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Dan Carpenter"
 <dan.carpenter@linaro.org>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240429121113.803703-1-mwalle@kernel.org>
 <mafs05xw0cn8v.fsf@kernel.org>
In-Reply-To: <mafs05xw0cn8v.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--835c43056ed51c66bddab6950631070232af469583daba94213c5b42a3fe
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon Apr 29, 2024 at 3:27 PM CEST, Pratyush Yadav wrote:
> On Mon, Apr 29 2024, Michael Walle wrote:
>
> > Both occurences of div64_u64() just have a u8 or u32 divisor. Use
> > div_u64() instead.
>
> Does this improve performance or is this only for correctness?

See function doc for div_u64():

 * This is the most common 64bit divide and should be used if possible,
 * as many 32bit archs can optimize this variant better than a full 64bit
 * divide.

> Patch LGTM otherwise.
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>
> BTW, I also noticed that there is a do_div() call in spi_nor_write()
> that also uses a u64 dividend and u32 divisor. I was wondering why it
> uses do_div() and not div_u64() (I am not sure what the difference
> between the two is) but I suppose it doesn't matter much since your
> spring cleaning series will delete that code anyway.

do_div() is a macro and is modifying the dividend in place, whereas
div_u64() will return it. do_div() is using u32 for the divisor
anyway.

-michael

--835c43056ed51c66bddab6950631070232af469583daba94213c5b42a3fe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZi+k4hIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hNLgF+LlPVrs+XYNoNPY3HJktt+35X6xG0B4sa
6xZL8RX95pozeOpjBoMygK1kDKUwqFOMAYDKZIyCD1kN0n0Wj7tiRpY/YCRQJjxd
yZfQNMubH2WhzSpI0oA45LJLEfYadWaoCqg=
=2oCk
-----END PGP SIGNATURE-----

--835c43056ed51c66bddab6950631070232af469583daba94213c5b42a3fe--

