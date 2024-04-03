Return-Path: <linux-kernel+bounces-130466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB1897887
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768E01F22F05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4893B154442;
	Wed,  3 Apr 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="PeZGyL48"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04622F24;
	Wed,  3 Apr 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170017; cv=none; b=St/4NIQ352lpEswjHe7n9LtOPRYh/VbsmNLjKb7YFYrB8xTtF5SNWXqr3G4I+MyiKykHtW5AdAqvoQpR48bwVhHvWDM8v67jOw+iWCvLLo9XdRCvqwpQoMoyS2isitRjEeSexeUCBrulEfO2FHCmxOFfl+3BpasGyiOv0bb7eQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170017; c=relaxed/simple;
	bh=1gV8AFeeIO9ri/OfnxKbGbD0lxU/bNXHBgHfb5vIwMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3L3MSZRwFgxnlleJdD3NRxHs7JUEOAVOYKsoCK3eFWbXBn2JACdCiUslKRIddbcAScT6SfIFCHeNtedRuTCgMWz56GyhXzngUXE7TZBjvMD8eh1O7Ejd/UbjRs6AuActw8VuPD62GD6HStCsfZczBoyTW6brlaxdFAKmV6oZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=PeZGyL48; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6CFEB1C0083; Wed,  3 Apr 2024 20:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1712170014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/hZN/5kC7xYglgObZWX4StZtR45dR0BAh/VSufNqpTE=;
	b=PeZGyL48tOeuRFlfNMRutiKrdYTQRgzLd5nb6L6uZ7MqWHG4yw3oGyiXREn4BcqeccNcFs
	30AuB9cG1EKIPA7SJ58g4+dSnhtBxlvcXmIfg5j2p5MC5Wg6EXEEpA5Q4Lo4aiHXguierI
	3DNeB8drGRGzL32GfD+g15ZRdi24gts=
Date: Wed, 3 Apr 2024 20:46:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 11/25] media: i2c: imx258: Add get_selection for pixel
 array information
Message-ID: <Zg2kHYc6kdiZEAFD@duo.ucw.cz>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-12-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZ9OiAyi6i2ioQgi"
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-12-git@luigi311.com>


--dZ9OiAyi6i2ioQgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Libcamera requires the cropping information for each mode, so
> add this information to the driver.

> @@ -116,6 +124,9 @@ struct imx258_mode {
>  	u32 link_freq_index;
>  	/* Default register values */
>  	struct imx258_reg_list reg_list;
> +
> +	/* Analog crop rectangle. */

No need for "." at the end, as it is not above.

> +	struct v4l2_rect crop;
>  };

If the crop is same in all modes, should we have it in common place?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--dZ9OiAyi6i2ioQgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZg2kHQAKCRAw5/Bqldv6
8lbiAKCV+uugZ5uwqSNAAD9qilM5gC6koACfZDX/g99u7tA9+KJIRkBJjEycgD0=
=0kGR
-----END PGP SIGNATURE-----

--dZ9OiAyi6i2ioQgi--

