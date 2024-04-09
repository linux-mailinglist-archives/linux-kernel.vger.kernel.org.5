Return-Path: <linux-kernel+bounces-136596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC40089D5F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53465B248DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B78003B;
	Tue,  9 Apr 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="UA764w1y"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD27F478;
	Tue,  9 Apr 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656220; cv=none; b=uq1729g1ezaKQXMMaW1QgBqOb5VzfNv/aV/Q/L3gKrFFICdajJOJBGFnvFusuMrARBUOluqxYq9s9PoWCthp/+Vw+f+xjhJDoEOZ+GLUAe1eDqMHH8o678z8Djdss+whlNa4SaAZIIGdk/2jfP6vkMB84/LD/l3/EEofbFyT/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656220; c=relaxed/simple;
	bh=B1hRF4wh5KsEIlNYnlONjUnwHiM/6l8Y0AGg+VjQqrI=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=KBDO37dvkSqLpzGiADsY5gqgGVhszuv8AonQw41FiVVf39mQwSrCSsMqo16Yzo1KMEnJB6g8G0czNjr2TSDrND0mTnkGnVzF+rUKM65u0zXBrYQnx/xskClaPThMy6tPdtuwd01o+4V2t6YMX6aloY1AtUK2O7b/c1Y+dNSAmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=UA764w1y; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 148E53D5;
	Tue,  9 Apr 2024 11:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1712655668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=B1hRF4wh5KsEIlNYnlONjUnwHiM/6l8Y0AGg+VjQqrI=;
	b=UA764w1yQyVsuLGF6Lk+kfDHdZhFDibWXIrnwXcrK/b2vDlQVDhehSpZhGld8VTQlDT5Wg
	/Qx/N2KRJ477RGmQv9Qs4s+qZgpmV3kF2VXlzJ1yXarTQI6ZHpKhcmWK2pcoVjLkk/uT+N
	gUNtI6X20YBPuXVlye++Tk8wqiJNKOv1DWOd1OYjYhYdLsPLMictRnyQ4PgWPize3PBlTP
	7HhYb+Npmmfr3nHQOVCb12am3FVBBNbLiqS26vXz5qdBAV6GOCUyOxpSY/NzofXcM/ijeI
	JWZpOTz2HdNwueoVBML8t6clo2yQJl34olPUELkWXN3iMANTaurzrMmE3qVrhA==
Content-Type: multipart/signed;
 boundary=8a32cdc00bd7bdcde487afcf8d9f9ed3c2c6e755e2a918de1ef16595d7db;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 09 Apr 2024 11:41:06 +0200
Message-Id: <D0FHRJG05LJN.1GU1N7J0BH6S4@walle.cc>
Subject: Re: [PATCH v4] mtd: limit OTP NVMEM Cell parse to non Nand devices
Cc: <stable@vger.kernel.org>
From: "Michael Walle" <michael@walle.cc>
To: "Christian Marangi" <ansuelsmth@gmail.com>,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20240402212331.27328-1-ansuelsmth@gmail.com>
In-Reply-To: <20240402212331.27328-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--8a32cdc00bd7bdcde487afcf8d9f9ed3c2c6e755e2a918de1ef16595d7db
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

just a quick (non-technical) nitpick if you do a new version or
maybe Miquel will fix it during applying:

> Subject: [PATCH v4] mtd: limit OTP NVMEM Cell parse to non Nand devices

subject should be "non-NAND", also cell could be lower case :)

-michael

--8a32cdc00bd7bdcde487afcf8d9f9ed3c2c6e755e2a918de1ef16595d7db
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZhUNMhEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+LymAYDD9wmmYfgy26EJDv13ae+bC0ut1EyeUTAm
lJ9YqLRePNYZ6DdNEEPblZqfBNUTD04BfR6m8Yg0Y/LiFSrhkmPFkcOGZroghen/
hXr19Rz/FouCSXF2uoJ0y/cdSqW5pYZJKg==
=wSoG
-----END PGP SIGNATURE-----

--8a32cdc00bd7bdcde487afcf8d9f9ed3c2c6e755e2a918de1ef16595d7db--

