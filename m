Return-Path: <linux-kernel+bounces-117318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A92888A9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71AC29B97E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819F5D738;
	Mon, 25 Mar 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2rvDq33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A091847;
	Mon, 25 Mar 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378890; cv=none; b=fOo9ebUCt//c8m9soDc6oLBRMPjE563g87GxWn8m9vWbMosg+IADVjF1BkoY8bhrdHm2Mc4c9Z/j6/yiM7g/3juc8N6QEbZjSTvJVgrc0pxLq2PWpZMAjWXnhn1++Lua7qpdErVKvQt6Y6yRE3L4x4uKHdrfC3XdQer4RVkBLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378890; c=relaxed/simple;
	bh=06mS+4kIFvRI7NL8dZUAAS2fcpHqyjEmc4cUuazwmpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huBzQapPF+7LAuLj4MJhs9SG9o8cpA5RBrQHtkvHBO9Xx1O6BugJBMACIX3GovtOXkbxIQypIKAQ2g5e59CsouXGkB9CT2AMOrBk5At8+MPTK78PL42UckBxxvRdscChheyNYGND8WyZ8IRD5CMRVbQJ3lY2yAhlg5jOb5mYiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2rvDq33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1777C433C7;
	Mon, 25 Mar 2024 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711378890;
	bh=06mS+4kIFvRI7NL8dZUAAS2fcpHqyjEmc4cUuazwmpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2rvDq33D2BT7MRyINXwhk511wHBPD+XXpRWOUEh88oY7KVWXwBZQN7nIuEXThHdQ
	 EkZ+j1jJgH1IjjCQdDIc7xVS6FEtbCBvwJb6h3BnjJJNm2Ie0u+5En3Jl8tb7fHoAr
	 jo0nHx7RvGuAXm5LsCcRob/Md4ZklTm7O4AY1+G9cEZKHt3V0k82m6BdzGHaKx573A
	 DlRkGHaCvKZ6oW2hG66LG2PMfRK88p9VH/9pAgtTrNBZ1SUmWTWCFlDNMQEnjmPDJu
	 flphVO97myK+Q3vh9va+zplZUvbrzUNGjilBCeLRF4DLdCEvYpS29lbjmpxWqWXtD1
	 iJzKAci3Fo9rQ==
Date: Mon, 25 Mar 2024 15:01:25 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: remove struct spi_message::is_dma_mapped
Message-ID: <270202d2-add3-4ad2-8233-6a993e2f3f87@sirena.org.uk>
References: <20240315-spi-remove-is_dma_mapped-v1-1-ca876f9de1c5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZZavzfwQuKVDzLbl"
Content-Disposition: inline
In-Reply-To: <20240315-spi-remove-is_dma_mapped-v1-1-ca876f9de1c5@baylibre.com>
X-Cookie: Did I SELL OUT yet??


--ZZavzfwQuKVDzLbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 05:29:43PM -0500, David Lechner wrote:
> There are no more users of the deprecated is_dma_mapped in struct
> spi_message so it can be removed.

This breaks an allmodconfig build:

/build/stage/linux/drivers/spi/spi-pxa2xx.c: In function =E2=80=98pxa2xx_sp=
i_transfer_on
e=E2=80=99:
/build/stage/linux/drivers/spi/spi-pxa2xx.c:947:29: error: unused variable =
=E2=80=98mess
age=E2=80=99 [-Werror=3Dunused-variable]
  947 |         struct spi_message *message =3D controller->cur_msg;
      |                             ^~~~~~~
cc1: all warnings being treated as errors


--ZZavzfwQuKVDzLbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBkcQACgkQJNaLcl1U
h9Du0Af+KNKEIp5prd5874XsLTngYQHI3CnLC0L8MkrHq5Eq3U+sQEJPk/iJQbS3
4iu5CNtTkUUaO+PVtiTbgqZFqcNDNc96azGMA+cowSw1vJ7StXv2u2bnmRr83+1O
83nGwzOohlpJ0vm8rNXQc87Zloxe5bWe5E6B/LzjQ1MiQL5xWnxxd5vlP6kxZmWl
QYjipXkNutN029UAQ0MCKZ83Oocf9l7crTUSWcr4u7CzFqD+2jCRN36h6hLgqXs4
e/XD35aGZo7VwTE/bk5XFGvKFA0xVVImlaJGrD/hBoy3aeBLBVL3E/8SL8Ehxiwb
m2udXr/XH8LAYuf/oXPQgGfeunTWtQ==
=+NXl
-----END PGP SIGNATURE-----

--ZZavzfwQuKVDzLbl--

