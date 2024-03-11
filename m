Return-Path: <linux-kernel+bounces-98580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58484877C46
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4F81F214E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625A414271;
	Mon, 11 Mar 2024 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WRLNFJcd"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474D12E58;
	Mon, 11 Mar 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148156; cv=none; b=GtcP6axm3a1TIaYMjBN6+802U6Tfn7zw9TZRiB9whPsw96x4nqr0D9S5yq0VVc8WwmOqYbz/Th4LyydtwiP4+aPqA/b0kWw83w9+SW+EX1+tgMAaahszXgcpClBzgkiY0ziympmcKnJ0Uwr5Lv/XJsDDiOMSd+npKjGccjmufX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148156; c=relaxed/simple;
	bh=uyl55cCGAlnq7qvYYxqLuZ/s63D8tShp+hzHzGvLURw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWdgkbCh5sTbSKKf/KM5Hz8dgI2GjOSbncCYp7qZ3Anq1o4ERwTW8Z4Tm9azBAHUL0n8+rfCAm4QtBkrKby3d6JvSnkA6enXSGBFY7gXM0ty2SJ/DZLMNU1Kl2oYXNQUcFSyT4629Kxd79yvLleCzu8UCWgQtQ4I41KgHWU3saM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WRLNFJcd; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id AC109C1EE5;
	Mon, 11 Mar 2024 09:09:05 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51D19C0002;
	Mon, 11 Mar 2024 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710148138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sW9TE7Dsk6Cs6tGMrp3CfoHwIeC8cgRCSGY3QwFyBJY=;
	b=WRLNFJcdBDLserQ1qSRK/4V6Yymmk6fOwu3Oc3iH2fB/gDMo04aopqQP7xh1xlfDlejU7D
	oXe1TZevhvFM6uZkP/J8qwGbgQI6p8d2z7aZURBUoZ7ueCAmUr5FSyR+ru99uLPv/HHuTS
	As6I8Gu8mGfsA/5qbA8iSnCRMeKIKJd8dxxRsOOHKhz8EzQ+x1rY/8669Rj2eS0C26PrGU
	Wf1Yo0dy4rYP2aOjvyxyDRFgjqTkYGSQqf2rQYaseLkp/sBOaNkBJ7qRMiLO+sRIy4H0mk
	I0CwdLc2/EJaf6GtWjRnX6G3dBnkPQDSeUSpU+93TY/BqS75o36ZoJtG8QZW0A==
Date: Mon, 11 Mar 2024 10:08:56 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] ptp: Move from simple ida to xarray
Message-ID: <20240311100856.4187d247@kmaincent-XPS-13-7390>
In-Reply-To: <20240308210745.GE603911@kernel.org>
References: <20240307100327.887758-1-kory.maincent@bootlin.com>
	<20240308210745.GE603911@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 8 Mar 2024 21:07:45 +0000
Simon Horman <horms@kernel.org> wrote:

> On Thu, Mar 07, 2024 at 11:03:26AM +0100, Kory Maincent wrote:
> > Move from simple ida to xarray for storing and loading the ptp_clock
> > pointer. This prepares support for future hardware timestamp selection =
by
> > being able to link the ptp clock index to its pointer.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> ...
>=20
> > @@ -246,11 +246,10 @@ struct ptp_clock *ptp_clock_register(struct
> > ptp_clock_info *info, if (ptp =3D=3D NULL)
> >  		goto no_memory;
> > =20
> > -	index =3D ida_alloc_max(&ptp_clocks_map, MINORMASK, GFP_KERNEL);
> > -	if (index < 0) {
> > -		err =3D index;
> > +	err =3D xa_alloc(&ptp_clocks_map, &index, ptp, xa_limit_31b,
> > +		       GFP_KERNEL);
> > +	if (err)
> >  		goto no_slot;
> > -	}
> > =20
> >  	ptp->clock.ops =3D ptp_clock_ops;
> >  	ptp->info =3D info; =20
>=20
> Hi Kory,
>=20
> Prior to this change err was -ENOMEM at this point. Now it is 0.

You are totally right. Thanks for reporting the issue!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

