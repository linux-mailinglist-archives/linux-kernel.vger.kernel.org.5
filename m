Return-Path: <linux-kernel+bounces-81261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023CE867303
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A471F24597
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B7208AD;
	Mon, 26 Feb 2024 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLgnqmOc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF520314
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946820; cv=none; b=XURTps1fOfWhfo76pQA8E8ODqvyRB9vOtwayb93/Ct2EeTVX60be/CtfBRYTwFB/Mjgc7MRmNQIAppBJdNn5ebo9xQSEiLgO+pL3zFsuOVQy19YAaxvoV8l4LTknhl2bsErQM7jxF+8e9hBRrsksfqqYLjJpzlJlw+l6eEEA7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946820; c=relaxed/simple;
	bh=U6jDkI4Rv2MdParcSGGGnlp89Kg52ruxo6sSR5sbRp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpHK0Xf6XpIl9waSevh/PYthumDre6YqtVk5zUDszGHWuK4hPPy8aI2Kew/R13US8G/DB9bNlZPQ3KRKGaYMXwFLV35KWuz/CfkQjgx6djBCsoE+G2Wq3Sh9WFfFZDcBWhQmoYpT9c15AJXsZ1ab4+fUVxqDhiW6ZoPJ9dfgp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLgnqmOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8059C433F1;
	Mon, 26 Feb 2024 11:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708946820;
	bh=U6jDkI4Rv2MdParcSGGGnlp89Kg52ruxo6sSR5sbRp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jLgnqmOcVf7MGoAdfaXJeujL87infBxRoDejA5lTJjNYqQJ4LNFxj1/c4qDun54jG
	 JjgQwdRLSLpgZ8EmsemxLD0yf8ur3aVkxWrKoc0t31S04/PaT2NQ8WauhquzlS6aD5
	 JFPAms4/8ovtFIZfNVVpf42mGrdtVQaKYTcAJPzazrInBoCs/ObS2WPlyqMhUoi3bE
	 g0U1RAyn9cjrzwhze4JKfa1UUl5A37s+Tr4T5PvtkvU4e/zqSXx7P8TF3TMXyxHE7C
	 QQjhzJXlcc3U8arzK6xVdtKuQttmU6F0CpyRjbHtpRWdnqZ5hwlwQ+WXXtdv2AZ88A
	 z8YCq1FLDXhNQ==
Date: Mon, 26 Feb 2024 12:26:57 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Marco Pagani <marpagan@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/test/shmem: set a DMA mask for the mock device
Message-ID: <d65v7jy4natx22lacw6awmg6iecfr2hqk3puuz3qem5dfsvj2x@hh6vp265hm5p>
References: <20240226110028.28009-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bdxjb7opyfuj56ed"
Content-Disposition: inline
In-Reply-To: <20240226110028.28009-1-marpagan@redhat.com>


--bdxjb7opyfuj56ed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 12:00:27PM +0100, Marco Pagani wrote:
> Set a DMA mask for the mock device to avoid warnings generated in
> dma_map_sgtable().
>=20
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

I've submitted last week this patch:
https://lore.kernel.org/all/20240221125324.718192-1-mripard@kernel.org/

Which should be equivalent, but fixes the issue for all users in the
tree.

Maxime

--bdxjb7opyfuj56ed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZdx1gAAKCRDj7w1vZxhR
xXCRAQCilaZ5vMmOtS84duICyUXtAmRIVKAL3+kaIPvI4SqHOwEAx0cddu2i5v4M
iGUoxIygBTAY4Y6Eo4+eNGQWiOe5fAc=
=DzdO
-----END PGP SIGNATURE-----

--bdxjb7opyfuj56ed--

