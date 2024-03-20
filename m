Return-Path: <linux-kernel+bounces-109391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C83C881880
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A12B226BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDDF85937;
	Wed, 20 Mar 2024 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="FUD/CI4Y"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B78594C;
	Wed, 20 Mar 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965951; cv=none; b=oFRLnum0/btMXQi5St9rH3GZ1L03uoN2by5isa597q8fiIG7MRoBzuy+OXRQ0aQsyX687Of3B2pStene4DNTKbtxn9tmtBmUPzYWa2EAE38yk1ZvgJ24DIKYgsTUCr4t/LqnOxLb9cOCDzlTwBtAu/DjrreqlF3gnDYpvvqYy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965951; c=relaxed/simple;
	bh=1InWQrQRzI8df03YA+uMajlmuvvarx0891Elr78Rzfo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JRy541NxTdGEtt/cKlI4wc4PhlDrUCJ1eHKGzrkhOtCSyz+0fRSTmzJ1p3qJY5aW1oN8D5PfuX1qtW3cJjM91DzTc/ydm1Cs/9RX/HJqEcXgJADP80uWS+HGAlCiajv58blft6U41e84NBZk6TXW1BvtZqmQLvN0y2SvguZN8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=FUD/CI4Y; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7D59D1C007F; Wed, 20 Mar 2024 21:19:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1710965945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=YzWGo7ZDlHo/gTXMevOf1cRXxQyP40vDt4ohNrfOea4=;
	b=FUD/CI4Ynd3ojwXbF4td8Z5XNROCnJPOWc7sWz8hfag6L09DLzxdhhVVdcpaVXqhvZVdFc
	f6TwTZYbYTxYSmo/7KPhr4xp6jjM2AP04a+cDNune89cRQldDq1lfHm03yLuo9BzSg7cE7
	oUmqeVA+sBITQL3eU4eT6+SpGBSWOFc=
Date: Wed, 20 Mar 2024 21:19:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org, hdegoede@redhat.com, rafael@kernel.org,
	lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: Wake-on-LAN stopped working around 6.8-rc7. Thinkpad X220.
Message-ID: <ZftEufJx0uDXSqFT@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JFcImNO7Rayn6cOk"
Content-Disposition: inline


--JFcImNO7Rayn6cOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I was using wake-on-LAN a lot... and it stopped working.

pavel@duo:/data/l/k$ sudo ethtool enp0s25 | grep Wake-on
	Supports Wake-on: pumbg
	Wake-on: g

Hardware is thinkpad x220. ethtool was correct, and I don't think I
changed anything.

Did something break in ACPI? Does wake-on-LAN work for you?

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--JFcImNO7Rayn6cOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZftEuQAKCRAw5/Bqldv6
8lCCAKC2h4M/GqWtqARDbwM73uz1BChUDgCbBTEGyDePE5LbJMzXxHrMC+QALzw=
=kEU1
-----END PGP SIGNATURE-----

--JFcImNO7Rayn6cOk--

