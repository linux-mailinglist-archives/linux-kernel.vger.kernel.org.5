Return-Path: <linux-kernel+bounces-86871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABDF86CC06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C952D286534
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B123137C38;
	Thu, 29 Feb 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2D4aNTZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589AC137762;
	Thu, 29 Feb 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218165; cv=none; b=kAPQ1LpGAeZgk4HJGcGGQlBpkcoHglP7q4GauJOcCvi6PN/oWK8KEqnzPDX3R+i1K/eHUm0LlD1JcInn5Ps4nXWWA5aq21BLTE/JD6Lk/4sFfhiewMp0p8OiADkNTlCoFb55PSUrtUGDA/zNi0E+e5OPpTVsBgwojBpzo1+UMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218165; c=relaxed/simple;
	bh=o8tpaIa/V7fni6pjjD3Yr8h+WCEMSgwXfLuroPO4B5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIYlt8DmMX+q6xZ5ANEWm30msmqH+FZmcD2skONvGT+xJK1cxHv7lQFXlkLuIi7/B+FKCMbe92dJHCXx1GGwPheaj3KtglximeMgYE4IWyezfZau7CKWP1ME0XPv5hEmv1BDJ6VnmRhnLCi+UWc3tSAFoFrLHRFbMLukez/kPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2D4aNTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1901EC433C7;
	Thu, 29 Feb 2024 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709218163;
	bh=o8tpaIa/V7fni6pjjD3Yr8h+WCEMSgwXfLuroPO4B5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2D4aNTZm3hkOsgW8fCBdET1bIN8LHgIIrqPjtKS55WG8IfZmrpXr+jWMwvTlutae
	 iZybrQ2d6y+4pkZrWqHRQDzpl9I8AvdOFJfi43QjtxUljzIoEQqhes78dsu9+7J36z
	 YOf/mhe3Jot73QmV71QSX5wd1A+VTXf6CbWc2RS11rbz82fCrkM1ZmWOnGDUmew9mi
	 7STxamXOCFLQId2SaA3qIJDO5BiOT8vP54x38XGfmTeFheX0oUmVh5tFxjD6TWCDPt
	 lCAioh9AqY0lNGKLFJ2VZrzlKSFZ9Qk9/Koj9CEOGONoZ5f+omQMQVp8Ks6Rs/XDnQ
	 9Jr/iGvDdf+/w==
Date: Thu, 29 Feb 2024 14:49:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Bhargav Raviprakash <bhargav.r@ltts.com>, linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jpanis@baylibre.com, devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org
Subject: Re: [PATCH v2 12/14] regulator: tps6594-regulator: Add TI TPS65224
 PMIC regulators
Message-ID: <6fa04f9a-2904-4955-a219-d4962b8fe41b@sirena.org.uk>
References: <20240223093701.66034-1-bhargav.r@ltts.com>
 <20240223093701.66034-13-bhargav.r@ltts.com>
 <CZHN4S2QW6MY.KKKHHRPPY4ZG@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C3RoV1h1koPrEpV2"
Content-Disposition: inline
In-Reply-To: <CZHN4S2QW6MY.KKKHHRPPY4ZG@baylibre.com>
X-Cookie: Marriage is the sole cause of divorce.


--C3RoV1h1koPrEpV2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 29, 2024 at 03:42:50PM +0100, Esteban Blanc wrote:
> On Fri Feb 23, 2024 at 10:36 AM CET, Bhargav Raviprakash wrote:

> > +	/* Number of interrupts supported by each voltage source */
> > +	interrupt_cnt = (tps->chip_id == TPS6594) ?
> > +			 ARRAY_SIZE(tps6594_buck1_irq_types) :
> > +			 ARRAY_SIZE(tps65224_buck1_irq_types);

> The comment is not adding anything, the name is clear and ARRAY_SIZE is
> quite explicit.

Also please don't abuse the ternery operator like this, write normal
conditionals or for a case like this where we may get more options in
future use switch statements.

--C3RoV1h1koPrEpV2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXgmWwACgkQJNaLcl1U
h9A7fQf+P2ZRUxZ1OFuQHOH8xAkdPC++bb/AEXvafquTsQ66dbQL5g71d50MIspZ
IX+GgMjYnGvg2778K7NWelmOo8+rFfrTcICsI2FnZUHBqUj6kXJoNHXbX6Tojwj6
D+cbrt3TaG4fcH1T74uAvm4KKx3eY/MTFcQj7z1yx53Hw1YkaWKtI0RgTlw1H7Xw
32T/R5x/YQRm9S0iY4on0N/uT8h9fx7uUiu4F0sRw3nNpF/A6TlFA+kpLomxcZPm
zf76GFUrrhZx9l/04KHjyHL9JDli6hIJV59GKFCKlFLT+yW3aAxnOteoKXjJmezk
yx4zUcarBxQbkemGxR9n6H/h44ALBg==
=FOEF
-----END PGP SIGNATURE-----

--C3RoV1h1koPrEpV2--

