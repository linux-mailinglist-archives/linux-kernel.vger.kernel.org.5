Return-Path: <linux-kernel+bounces-72803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F298085B8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D029B24BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F81D634E5;
	Tue, 20 Feb 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="t9IBjfgM"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22B60EC1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424213; cv=none; b=OOog02Nyer0l1cP6MgJ0FY3jG2AClZy3aMHQbFji8QJaE0FswwCQuo7HnujSdCh/rO/YhZ4CDeuyGOsB7Vn5vupVY6D1R+tfzVbjxG9aMY8CtG8+zhPtgmCtBFC8ZpT9yCKAHJSjq1SGdPKqr6FmX9xmWmWXFCPJhNM6ppvS1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424213; c=relaxed/simple;
	bh=eGLz6aJot1+MkvZyBs32ma9qgEOHUd1Vc2KQ4BsjgZc=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=JkipOYF8SiWfECPGI8x5orEAuUhXzfQu0vuEGqvQK43/EV6crnT0dZNReS+3MSStYvgxz22AfY2nw233g1OOapQdDXDnOTLAbizuHaE7TF6mMjM2dq5ji5JY1cuKPAFXg7c3hmA12BFOP8Uw+3QNLghYnyQSRO4P4qyP55aUhDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=t9IBjfgM; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 9F2052F4;
	Tue, 20 Feb 2024 11:16:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1708424207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=eGLz6aJot1+MkvZyBs32ma9qgEOHUd1Vc2KQ4BsjgZc=;
	b=t9IBjfgM8zqQZyNaeyUeDYVF6VrK7zwT3gzHfIArYTNpkQ/G5P0fNreh/ngAKz0UvIZct9
	XowoNtFW5q7cIkX1+IP60klw5qScp1VmiMsE+yO1HyNOFM1BN5Hd8Rd+bQ99ejraOskQXS
	sx0+FQ3ulLCYj525+iFJGectAr+csjLyqkrULisgjJotoiWRy8rO4J/nw7RBv0mss8/1R5
	VXUhvrZyGpaEBHuXJ3pC6+FoHcb51HurcjNIVnyApaRoOCyzIl6f5F3yZWefeKlt6LHugx
	Rn4LadjEG/Dp98PH1Bu7EWSRoZNdxfyuBKsvKcrfdGIEpDXxPo2NJduJbA0rcw==
Content-Type: multipart/signed;
 boundary=99d5b6af3b37eed3e87946f324a43accdfa3b238b01258cf2d3895a9440f;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 20 Feb 2024 11:16:40 +0100
Message-Id: <CZ9TU33SEHWS.1HK9XLFPKBROY@walle.cc>
To: "Marco Felsch" <m.felsch@pengutronix.de>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH] nvmem: core: add sysfs cell write support
Cc: <srinivas.kandagatla@linaro.org>, <gregkh@linuxfoundation.org>,
 <rafal@milecki.pl>, <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>
From: "Michael Walle" <michael@walle.cc>
X-Mailer: aerc 0.16.0
References: <20240215211401.1201004-1-m.felsch@pengutronix.de>
 <CZ6DFL6061FS.2WMDPMSSBXX8S@walle.cc>
 <20240216100750.zxl4wncbgpulr2cc@pengutronix.de>
 <20240219120414.32395299@xps-13>
 <20240219115358.xui5fpoisvsubdyb@pengutronix.de>
 <CZ938PEUZ1JQ.2DJE7C03HI9OO@walle.cc> <20240220101811.6ae23f2e@xps-13>
 <20240220095038.2betrguygehvwodz@pengutronix.de>
In-Reply-To: <20240220095038.2betrguygehvwodz@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--99d5b6af3b37eed3e87946f324a43accdfa3b238b01258cf2d3895a9440f
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Feb 20, 2024 at 10:50 AM CET, Marco Felsch wrote:
> > Read-copy-update would probably work but would as well be very
> > sub-optimal. I guess we could live with it, but as for now there has
> > not been any real request for it, I'd also advise to keep this feature
> > out of the mtd world in general.
>
> SPI-NORs are very typical for storing production-data as well but as I
> said this is another story. I'm fine with limiting it to EEPROMs since
> this is my use-case :)

Right, that is just what we are doing on our boards. But we do that
in one go in our production environment, like just writing to the
mtd partition or the OTP region. The nvmem cells are then just for
connecting the devices to this information (like the nvmem-cells
property of an ethernet device).

Also usually, there is more to it, like removing write protection of
said flash (sometimes in a proprietary way).

-michael

--99d5b6af3b37eed3e87946f324a43accdfa3b238b01258cf2d3895a9440f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYIAC8WIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZdR8CREcbWljaGFlbEB3
YWxsZS5jYwAKCRDNyh2jtWxG+xvxAQDtMH1XHZdjQCgwdWqEPaF8Hw/mNDngtI2j
cIKYo94QiAD7BBKpriQg1PacRpXxm+TgFN0YvQKceun+KklmGZEBdgo=
=E749
-----END PGP SIGNATURE-----

--99d5b6af3b37eed3e87946f324a43accdfa3b238b01258cf2d3895a9440f--

