Return-Path: <linux-kernel+bounces-144291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27818A443A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E32B22183
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F601135412;
	Sun, 14 Apr 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="b23DnHf/"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE13A1DDD1;
	Sun, 14 Apr 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114001; cv=none; b=JUQ75NjKmrjHmeqxJ1BO7xPHFzBmLom3MEXJ2xEjrmrHR3EkOfslouB5rFHpbN4eRaFra/JVQfrTDu4GjW+giaaSz8gOUnlAqTuYh2uzUJzCdBoz9hKohJiLpnBq6o3NThc/KBq3newJehdLBIDe9ZF0fAC0TEVreV99wKipork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114001; c=relaxed/simple;
	bh=mbkka5ov0pjllyobnal4qlOmTS94vtLU8iRcxxEH3UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQXrSqbdWFOwTxBmqkbO9m12xZnT0EAdjxIqpeuehEAy0kl/kUKQjasID3TEefQOQEjwU59EgJnuQmTLFv+bGR8zY1Vzt4+AXHftvDZDGK+O1+fBYtckDIWfmJWN+b6ehyTyFD/tDuK66XzSHAw4EpeQiCiTDqWghER0d8UPaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=b23DnHf/; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0C1821C0081; Sun, 14 Apr 2024 18:59:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1713113990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=plvj2pu75zmJtwfWQwKO6E7gQ/zblJirjpZJ84tKWdc=;
	b=b23DnHf/PlbnxjUd96V7Z1pSmri8eOHFbo7ZnAEiiCAQAKOnISp9CxhtATYpRO+Yk7f1H+
	E5DfQMtRTVXwKikZMbxxSKTVtAbbTkf6rqJFdX8ERUWIykIDT5WLdZMGiyqhQru06qY0nD
	I/7ZA8U0gJmTZbhXtVZcLQ3iY5dxpp8=
Date: Sun, 14 Apr 2024 18:59:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: serdeliuk@yahoo.com
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Samsung Galaxy Z Fold5 initial support
Message-ID: <ZhwLheDmwFTYBU/C@duo.ucw.cz>
References: <20240407-samsung-galaxy-zfold5-q5q-v4-0-8b67b1813653@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m4hfCxMWwdamns22"
Content-Disposition: inline
In-Reply-To: <20240407-samsung-galaxy-zfold5-q5q-v4-0-8b67b1813653@yahoo.com>


--m4hfCxMWwdamns22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> - removed extraneous new line
> - removed pcie_1_phy_aux_clk
> - removed extranous pcie1
>=20
> This documents and add intial dts support for Samsung Galaxy Z Fold5 (sam=
sung,q5q)
> which is a foldable phone by Samsung based on the sm8550 SoC.
>=20
> Currently working features:
> - Framebuffer
> - UFS
> - i2c
> - Buttons

Interesting, folding will be fun to play with.

Please cc phone-devel@vger.kernel.org with phone patches.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--m4hfCxMWwdamns22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZhwLhQAKCRAw5/Bqldv6
8hMnAJ0SvZJcotQx/i0WTcWAHOs8ojpFYQCgkFU8uaiXJCBFTkgnf0I+bS7wCIc=
=wOHG
-----END PGP SIGNATURE-----

--m4hfCxMWwdamns22--

