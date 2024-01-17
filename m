Return-Path: <linux-kernel+bounces-28690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45AB8301DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37921C246EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53C13AD8;
	Wed, 17 Jan 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="llDiGHEr"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F53134BD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482358; cv=none; b=Fo7ZACJlCuKwMuglRAXONBCBFkQBDrOQRz2g8oKhRboD+SyYNfisYL5GFhQqiiG6K/+aXce2TMNXex0fJvYrWRZ8S3Am0chjVtXax6L6AhJBxERXSGAB4II99cqEIqSL8qAsi3TTOf9fdgu9ok2cyFp610fvv7dya4tbpLMTMA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482358; c=relaxed/simple;
	bh=HUxnOv9lpq6eB86LbK5ELhkcteKhWq8U8LCT6iiiKYA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=IMr4g6fabUB0FNPFdyUMjXziz8a8b+yKhQM8y4gupVG2DfCdsbhGsUzGtHj61McJDkf1JHX4vR8B3VyZgTzPJtc1rzeru8B7JuvJJfOJNjQxuniqIMCohxD4DXsCpM8dmKgnc5XUkni6sxlzrwdz7OXD7b/DEIMnaYhIQtgmtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=llDiGHEr; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AE54C1C0076; Wed, 17 Jan 2024 10:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1705482346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KeRLwwZ1HDJnAfYZoFbBc2Cb4u4R/zDcUwYKhDNDpog=;
	b=llDiGHErJ60+mIQNq+XseeLowZVnkAC9O+e+ePqeQydppyXfPTiG/zBdln+9U/Q+MK5hKO
	VNjZU9osk9N1nmFlcE80uaxDQyF+eFRTTn3MW2Pp/mce2LA7ciWU3+1ywRwOPRny3Cjsqd
	QzKuOuZVA+/tuRQLlSrvN1Stu3o7FAk=
Date: Wed, 17 Jan 2024 10:05:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Luis =?iso-8859-1?Q?Mu=F1oz?= Fuente <luis.munoz.edu@juntadeandalucia.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I can't activate term(e) and kill(i) magic SysRq key
Message-ID: <ZaeYavtu6ZNYvEbB@duo.ucw.cz>
References: <002cc4da-e502-4c79-97bd-0a8b6cb2630c@juntadeandalucia.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ugwIjh5IOViM3yow"
Content-Disposition: inline
In-Reply-To: <002cc4da-e502-4c79-97bd-0a8b6cb2630c@juntadeandalucia.es>


--ugwIjh5IOViM3yow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I try to activate all magic SysRq key options according to:
> https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html
> but I can't activate term(e) and kill(i) option, is this option
> disabled? Thank you

Some keyboards can't handle required combinations.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ugwIjh5IOViM3yow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZaeYagAKCRAw5/Bqldv6
8oYPAJ0R+/aRaFC3+7pgn54XY+f1KxQChgCfXhTAUXeaL3VtNQ2Y3N/QVCfgwkw=
=AAtu
-----END PGP SIGNATURE-----

--ugwIjh5IOViM3yow--

