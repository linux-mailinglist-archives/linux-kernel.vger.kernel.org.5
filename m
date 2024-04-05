Return-Path: <linux-kernel+bounces-132834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E0B899AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7EE1C2173C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD50216ABCA;
	Fri,  5 Apr 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="I7n5aCtd"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42A6CDB7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313194; cv=none; b=s49gjqIWTK8R5iN9+0GiW6d2dzzRLWtupqpY4a1CW/72tvdIPCXi2me9yWsBBrEZD9K2GMrfGK5ZLBlXr1Z8xxKnrfxR6lbMZpHDonssEuIH67oVPO/RSqe7MWX6j05iz3a9SLdj7i3bkFBsdhKJoV9JK5D5aRx8GVw51aE8V+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313194; c=relaxed/simple;
	bh=QKju591WM/78pOJY/z3mVvYwKeTJ8Xv3if4mLIFxYT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRt4GgHQONYv0O/H9sdDV21iJAx68ZRoYadw7bSh7kg7CoCfiPjfRii7m4sLq0TApYaBd8ptyaAb7T3Hg3GkZolNfPrhTb6KUYl9QyvfLGV5nSD66jUb4n2ldU5tNEgUZWA6//pWWVW0mzzz4dW7JVJpY6IrCvU/nGHYloCDWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=I7n5aCtd; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=QKju
	591WM/78pOJY/z3mVvYwKeTJ8Xv3if4mLIFxYT0=; b=I7n5aCtd2OqroXjEMsOd
	ExJnjL1MvWIajbsEV0h6ZNxhJytiAAc3AD6HLbs0QcTV8yBV8rGNmB6ErpxXtZzh
	QNZeZ0ehu1Z4bzKPUsZlDq2UfhS2cU+0aT7PEbQospm5GWJR2ZXu0nWioHVkWg5H
	wax0CFSisjbrmGZEMbctncmlPMVOuW0x1DTaeZo809mUBS70vKWjcNIxaeKa60pU
	f+PA2W6wXrmyeTsF5SQ0flT/dWrcQMaSFaXKmc72OhBlwQG8qKXdGFjqtmkPkLn1
	DPtQ5ZLkg01UeK1MUVQL6cmHqVuAzgZ99dn0Umdp6GHHx7e5P+c/L2jT/Ki7ZM9K
	nA==
Received: (qmail 4076362 invoked from network); 5 Apr 2024 12:33:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Apr 2024 12:33:09 +0200
X-UD-Smtp-Session: l3s3148p1@pkRj+1YVxNMgAwDPXwEGAANOsN0UmmrN
Date: Fri, 5 Apr 2024 12:33:09 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] i2c: add HAS_IOPORT dependencies
Message-ID: <gwmdlcbfkqtbtfwot7edltbvwy5wfj2gsrnjp6kyve2jhwqa4v@j3ucmwj7r4ci>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <20240404143351.3950179-1-schnelle@linux.ibm.com>
 <20240404143351.3950179-2-schnelle@linux.ibm.com>
 <osgkd7mfd5jhl622hvybsbuaqp7awxcm474zzzlbpxkvxh57l7@hpm37bjuandj>
 <c86b17eb173f21214b6bf765114af79f20c91718.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bhlkcr2sk5dkca4w"
Content-Disposition: inline
In-Reply-To: <c86b17eb173f21214b6bf765114af79f20c91718.camel@linux.ibm.com>


--bhlkcr2sk5dkca4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Only reasons seems to be that I'm bad at juggling large patch series.
> i2c-partport.c builds fine with HAS_IOPORT=3Dn and I don't see a reason
> why it wouldn't work with MMIO based parallel port drivers.
>=20
> Will send a v2 shortly.

Thanks for the update and thanks for doing this!


--bhlkcr2sk5dkca4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYP02UACgkQFA3kzBSg
KbYd6g//T1RE6Ri47rwA27Amh/NMQzL654nSfGAWSf4ilxFnrgwtAjTm8iZejAPr
J/wg1RJfCQmGWZNA5WmAlsOfzRYSRit4qC5mniuBwc7Ev7ECxTMIT7oaQL8OJQcx
wlWadwHm2GT0+eAGjJCB/WMm619b16vczLSzKg4YbY0T01eHQc6gJTcnmIPR3iWX
Tkm+gCn9BQFGvbUFEggRjk0tyF2xlVhMe23dN77qPyQEtFfSloqh5n62KbcXcVo2
hE2kfV+QQZoqIhQaNNsEjvCJiNspQ6VulgpoIHOQozMO9aRUD6S1T31/F8Oz1aKx
/f904FYDC2KYm8tAdbYJuF1DY9omj5hroScpK9PmVwAghHG6pAFDvTEPv6UQfkcq
4kfPpaE27ultaUVMpRh5LSn8BFTCrLFmFOBELMCJYllDKXgdpC/VlUCqjahSYFwm
DdBpK4DgBg6tOSejygmRk+4cpEk2tcBJEJi4Q8x37HRCZxv9DdpdxZVuTkiWLuZi
Kkbzkju42XuyY7IcI3o3MooFWqAnHP+rsgvaOZbuM3TDpC0Sahy4FGyzfagKbJyI
0JvMBN2fXCBudJeO2w2qaUZfdY+aQnE/g5rHBWjF54Pa74oXhWkmvu2Bypy7lRhv
JWvue1Jc/F/I33i72Anc+aqTref7BlG7J6eWZmqg+pF4ZOWNMLE=
=jcWg
-----END PGP SIGNATURE-----

--bhlkcr2sk5dkca4w--

