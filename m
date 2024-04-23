Return-Path: <linux-kernel+bounces-155504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093998AF2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEAA1F24DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D413C90D;
	Tue, 23 Apr 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHVcwrr3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217AD136652;
	Tue, 23 Apr 2024 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887669; cv=none; b=ue+lINhGCVFk1X7IE1ka231siTl4qR96WS1Bm01WVvJSi27JqGLpiiGvPmWW+xTNOav0UM2KBlKZTiEyVOCoXcUJCHwfPpUPuoxke88AmWn+B7BAQLMbWVSb8KvemYiFbO5o/0g1WxMcuSylru051kaF3kKqYk01p4fMMpFsgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887669; c=relaxed/simple;
	bh=ygI09t554nLoyr6BkmW7OLrmKfZMJOQw1a4wokqN6Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7MdHZwIFqIP/42qN4zAz9SpqAn0meJy8mlL4UDHdU3y/oL7KET9HE0jCyirmFTWPAVoOyx4sJJzuwebdfXfW5eKXraXc1UjLXl95IlPnL8iQ5Mkq0g7hwPU7X8BBTFW93QCgu7ZnJu4PW6psAEm5IoN0RCVfX2NA4SQ5WwwoDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHVcwrr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E224C116B1;
	Tue, 23 Apr 2024 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713887668;
	bh=ygI09t554nLoyr6BkmW7OLrmKfZMJOQw1a4wokqN6Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHVcwrr3RiJYhKjscVZo+51SROohKtrZd5sgQRoiG0GWmNdjLzMpcXdJnEyl5KSRe
	 4X63eAqmtA8PT7Fvo6pRkUCuAEcjNq7jTdJpPQnV3u0ZRUynku/5beXpTvP8o3D9H6
	 pJadn+GdCeRNfMYolqVjG71p5INF+GexAyzPmMyUwFWWC5fcSlybNdYFmADibv4NtA
	 IcnpjjGTRofh+HFe6AuR+OIMXca1nPH2N1xFVMd6grvHanqWu+qcU28GqnPrUfmrUd
	 3QU0qmHFEfT4kvvp5a2N5cftLxr5StDZ08py9RG3EEBNcQCZw2eJE9YVglE7kgHF6i
	 okMJUfFaEx50Q==
Date: Tue, 23 Apr 2024 16:54:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	leyfoon.tan@starfivetech.com, jeeheng.sia@starfivetech.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] cache: Add StarFive StarLink cache management for
 StarFive JH8100
Message-ID: <20240423-clique-despair-ead97b78b186@spud>
References: <20240423072639.143450-1-joshua.yeong@starfivetech.com>
 <20240423072639.143450-2-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i/ONzq50GI9VXLjz"
Content-Disposition: inline
In-Reply-To: <20240423072639.143450-2-joshua.yeong@starfivetech.com>


--i/ONzq50GI9VXLjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2024 at 03:26:38PM +0800, Joshua Yeong wrote:
> +
> +#include <asm/dma-noncoherent.h>
> +
> +#define STARLINK_CACHE_FLUSH_START_ADDR			0x0
> +#define STARLINK_CACHE_FLUSH_END_ADDR			0x8
> +#define STARLINK_CACHE_FLUSH_CTL			0x10
> +#define STARLINK_CACHE_CACHE_ALIGN			0x40
> +
> +#define STARLINK_CACHE_ADDRESS_RANGE_MASK		GENMASK(39, 0)
> +#define STARLINK_CACHE_FLUSH_CTL_MODE_MASK		GENMASK(2, 1)
> +#define STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK		BIT(0)
> +
> +#define STARLINK_CACHE_FLUSH_CTL_CLEAN_INVALIDATE	0
> +#define STARLINK_CACHE_FLUSH_CTL_MAKE_INVALIDATE	1
> +#define STARLINK_CACHE_FLUSH_CTL_CLEAN_SHARED		2
> +#define STARLINK_CACHE_FLUSH_TIMEOUT_US			5000000
> +
> +struct starlink_cache_priv {
> +	void __iomem *base_addr;
> +};
> +
> +static struct starlink_cache_priv starlink_cache_priv;
> +
> +static void starlink_cache_flush_complete(void)
> +{
> +	volatile void __iomem *_ctl = starlink_cache_priv.base_addr +

Why does this variable have an _ prefix?

> +                                      STARLINK_CACHE_FLUSH_CTL;

This link only has spaces, it should be tabs + < 8 spaces.

> +	u64 v;
> +
> +	if (readq_poll_timeout_atomic((_ctl), v,
> +	    !(v & STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK), 1,
> +	    STARLINK_CACHE_FLUSH_TIMEOUT_US))
> +		WARN(1, "StarFive Starlink cache flush operation timeout\n");
> +}

I'd fine this easier to read as:

static void starlink_cache_flush_complete(void)
{
	volatile void __iomem *_ctl = starlink_cache_priv.base_addr +
				      STARLINK_CACHE_FLUSH_CTL;
	u64 v;
	int ret;

	ret = readq_poll_timeout_atomic(_ctl, v, !(v & STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK),
					STARLINK_CACHE_FLUSH_POLL_DELAY_US,
					STARLINK_CACHE_FLUSH_TIMEOUT_US);
	if (ret)
		WARN(1, "StarFive Starlink cache flush operation timeout\n");
}

Cheers,
Conor.


--i/ONzq50GI9VXLjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZifZsAAKCRB4tDGHoIJi
0kwUAP9bkTUM8ATatR50WkFrHITbtXJUqI6lq/ynn3qCblRkwAD/UXOExyXwpn1X
kW+/o0c8/SZKNz5wUqVXAWo0PcC+CQg=
=gZdu
-----END PGP SIGNATURE-----

--i/ONzq50GI9VXLjz--

