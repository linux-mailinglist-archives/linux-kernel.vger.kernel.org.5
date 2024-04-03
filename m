Return-Path: <linux-kernel+bounces-130473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A228A89789B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA18285EE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C815445B;
	Wed,  3 Apr 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="SPAXzShL"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41C147C8C;
	Wed,  3 Apr 2024 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170223; cv=none; b=sqyn154WiIlqROtxFPyPxxXeiQLpJfrxmJEDykQtwLax2fiRtTIz2TdIwIhty1U3EBY4A/fu6YHTsGHIT38tJSwxeG7s0b31VqDz7SX4UsKeZcmFgPRIpUOEehE43aPOkmxTsW5qQjlvLyIspnyR+DQAX6u+GqEQDx6xtahxP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170223; c=relaxed/simple;
	bh=xdUCX00krdG8tQrYAGTKOMTfs+W2Io6k8s946ktaUMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXOHda/fYsVM6n29fIyZ8oXRNMOUNdFRBDUTux8X9Sz+IngvghvTvOAcd2YDyDmwrlFyYmcL+NVbPqomelDApCLk4JeQLqvSUBLblvUUqbBSkOc4Jm8f828S5jX8YxuatMfXky/o6HHHcqeZgmspv9ulQbIUSHwm4pZi0QHBx7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=SPAXzShL; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 579BB1C007F; Wed,  3 Apr 2024 20:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1712170219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OSiHGjyug/A7S31CdOg47HSCU2Ka9d1dJBzt4GMaEzg=;
	b=SPAXzShL3WWOpuPck0KicBOaoxkR88clYRuFGaQE2GOjLeFbUCpVBUVDoSt/DYpwm/EfkJ
	72+eW1K5xeKSdAiRB3YoCsH2NRt6vEYNvp/0P81PAmI3+97/0cTlgSIjNu/tdEN6itQZPA
	On5zsZ4typTBxsq71vXsdulT0lvTIwg=
Date: Wed, 3 Apr 2024 20:50:18 +0200
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
Subject: Re: [PATCH v3 00/25] imx258 improvement series
Message-ID: <Zg2k6nWBUFLUWHMb@duo.ucw.cz>
References: <20240403150355.189229-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BP+FZsRBKnabhp5a"
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-1-git@luigi311.com>


--BP+FZsRBKnabhp5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for doing this. I had some comments on 5, 9, 10, 11, 12, 21
and 22. You can add "Reviewed-by: Pavel Machek <pavel@ucw.cz>" to the
rest.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--BP+FZsRBKnabhp5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZg2k6gAKCRAw5/Bqldv6
8lBaAKCnolrbEXBNYoVX+tBLo0p38ybJ9ACglWQjTrZ1uCLLuRKrJRJzOCJCZSk=
=oPTH
-----END PGP SIGNATURE-----

--BP+FZsRBKnabhp5a--

