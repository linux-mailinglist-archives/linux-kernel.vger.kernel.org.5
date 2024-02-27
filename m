Return-Path: <linux-kernel+bounces-83285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EEC869146
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B615290874
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B7A13AA4F;
	Tue, 27 Feb 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="EZwN2HjQ"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA313AA2C;
	Tue, 27 Feb 2024 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039080; cv=none; b=EbSq1EfqCr5ccBaBwFdqHiMwwpFlRGAj77HJi42Sk2wFX82Fqrh0V7hm/XCSCwmP9l9rtV48cBJOFIqKWz90MTfrEv/aRvasBhe/pMxF6Kkl/QfVkkvf9gKBcnn44913wAGpUvgqTDzwWTGIAXBCXmN/gdKjwIngewhMDDPGlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039080; c=relaxed/simple;
	bh=ByX9FRD14N/u6UP+YU5f3XxMnaKnVAmtyMFVkSQRsq0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1+e0pn2Czwf8zz7cFyzQeu+232F8/5MWzsHPTyX8UiV3VxFWqb/TcHp9sWBFS/ptsTLTPTAUHI8i2ukSk7/RUnKj0f1642QatQw22Zea/WON0yMRGkqUT0XfDEpkCzx0/0GOO6AKw/CSX749Zkv11sjcNwiI+fvzOdRrO/IHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=EZwN2HjQ; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9E6841C0087; Tue, 27 Feb 2024 14:04:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1709039068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UauDaphtC8+Vo9nKhOjiJL+JyVwJz9PyRLIvvQKfEpo=;
	b=EZwN2HjQSo/AUO1oIznJYBgAJr7vV975WEGLD+ymFTxEMCb3m3slP48d9hcgdJQ339deby
	03izs3WB0jGjTgrU1Je3hfuhEnaHQ8IM2Uvll4wTILmTFYg6Q+Blr8k5+V3CvS4r6gbqau
	76Y134ixWa3KXPpHgmkQIDX6934xvbc=
Date: Tue, 27 Feb 2024 14:04:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
	"ojeda@kernel.org" <ojeda@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>,
	"lee@kernel.org" <lee@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH 0/3] auxdisplay: 7 segment LED display
Message-ID: <Zd3d3C+VA3Vqkc2u@duo.ucw.cz>
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
 <20240226-scabby-fiber-87d5d6e45028@thorsis.com>
 <fd1c8657-62e6-449c-b47f-a2c3223b405c@alliedtelesis.co.nz>
 <20240227-married-amulet-da532c0a70d3@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2tufHoKG79+LqpZb"
Content-Disposition: inline
In-Reply-To: <20240227-married-amulet-da532c0a70d3@thorsis.com>


--2tufHoKG79+LqpZb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> My idea was to do it on top of the LED abstraction, not on top of the
> GPIO abstraction.  Currently you are using the GPIO consumer
> interface

Let's not do that.
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--2tufHoKG79+LqpZb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZd3d3AAKCRAw5/Bqldv6
8piBAJwKteYF/6cxyFkA9kvaHSmoWQaZVgCfUYH4qm99px2JCgn7R9COL1aD/eA=
=E6We
-----END PGP SIGNATURE-----

--2tufHoKG79+LqpZb--

