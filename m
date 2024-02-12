Return-Path: <linux-kernel+bounces-61717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F628515A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7EA28363C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AA745979;
	Mon, 12 Feb 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="G+vrH5Uc"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E51A446D8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745130; cv=none; b=LdnR/QHjA7aN2vN8DE8INRleGwkiOAH0ORVfRzYdiTxjAxkG8PDUIS+KHFztmnpyZypJddxXcuvDiRc6qFt0sIEX4qEIpkPVMIYyjdm3qIZ77VC9aFp8FG8pBUD57unkyUwd6dML47v/fl0kk0xtCqf7MVVj03ePwVorfPijVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745130; c=relaxed/simple;
	bh=G+LwZbdosLphVUCI0TtvMKeR3Lwbz0L/ddgHV+X6BiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhEywa7meGXbc+XKAtFnUU0GutM+qydzSf4G4hspeFi3qynDsDgHeEkStyadIRfVgQ4MefQiFm1yp8w4sSl09hIv+DyWRYnHPiwKKNqHEoqTJmMOGoNb8sScTmqKkh4bXc9kCf2EB3auiCdkdszaupk8N7zUS0eXzBvAskfXeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=G+vrH5Uc; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=G+Lw
	ZbdosLphVUCI0TtvMKeR3Lwbz0L/ddgHV+X6BiE=; b=G+vrH5UcRHwYpVYvdkVq
	hOzQJgcQvMpsGxMN1Hi6ru23OCi1DK/Iw9NebC76cwHhOE02aoK1AaPpWE/5c+PF
	PK9EA+mhpXxhgYdaJWqjVr0oNZLZ1ZsVt6/WQWcTHEXNnljw+WwEMrO7L1mVKwmV
	oFoG3S+bgh2VnQCy+mdJqmdyC5KTb0TuEWVrvT+PrqEg8zab7/e00CqaUVJ6feJH
	fWTg9bMYO9TquVe4SS/55+b3j9iHtXdgmuDvo7GjkBtUBeEID/bX0Y0mQXJFK8aN
	v2gL4lodxFHDgQMZvCT75Xyfdjw7yHUE7cV4iqNt1H7kPRxicR+UKuuLHL6zAIa6
	0Q==
Received: (qmail 512518 invoked from network); 12 Feb 2024 14:38:42 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Feb 2024 14:38:42 +0100
X-UD-Smtp-Session: l3s3148p1@zM5kZS8RuKEujnsZ
Date: Mon, 12 Feb 2024 14:38:42 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: add regulators for PCIe ch1
Message-ID: <ZcofYg9GPHRd-IB7@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240129135840.28988-1-wsa+renesas@sang-engineering.com>
 <ZcZhHWn3QrouRigo@shikoro>
 <CAMuHMdV5bmmZ0A4F-gPJOAhF=u_fxBbUJa8N_uDa+ft+V8XqTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FoJFderG22Z0MUNI"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV5bmmZ0A4F-gPJOAhF=u_fxBbUJa8N_uDa+ft+V8XqTg@mail.gmail.com>


--FoJFderG22Z0MUNI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Can we have this one in 6.9, please?
>=20
> Thanks, will queue in renesas-devel for v6.9.

Thanks, Geert!


--FoJFderG22Z0MUNI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXKH14ACgkQFA3kzBSg
KbYW6A//crOc1GtF5d12Unpyy+xqFqzcuFbrgcHf+y+GD4o4ZPfdtzUcX/rmQw08
rb7Esk4i3zO1Ag5qbZddZ2PT0Bk5L4PHd+MiE8kIWYmmAlASxzR7GDIr31YCmEU7
T9YzgnW6VeR49+P27rDhU/vrHzuIz40vpnO7hauCYT2qYjuGFelwOB3Qv7OmBNHu
/2VqZuKNDbL+KT/X9f4yVPHZS0U+W6DHOoec1GhBk+KMshyPFzLlGxRW+lUOYGjM
DUnc8GE5gTsjVdNNBZRMDud0Y6oe7yrvfcrasj5YJ3bCOuKYlDZqY2Qi+Wa2+k/2
NfiTFPrwjF7xZV83yNET5OkXUXPjOG5qaN4xhddxNuj+kClIVvG4oC3JvneWX8f0
K2ABwo/PY/oHG+/UAr/Y8C2XvxZcvdLoBMkmArSWtvZyIca3pXZwBrIPmQLLOyUo
tTkO7OFEw8JATddJ1YXsfJCCcHn6j2pkpe2iVVgDCJAH/lS9o3Vuyiv9OtdKEVIf
JQIdmAZM5IeygY06DA3tqIjYiZH4iV5OpejyVraCVeFJF1vQ7LGiX4MJJ8oco04B
NBqCM1ebVg5KV7JDwBC++UzEpzwVtv/Y2s5vmqxhhJbVijeLwurgOSQQBIc2hLjj
cGJJH88V6sA9ivQCi2w4dFHNCkxOt514l4systHzIRz+TDcaJZY=
=n/LE
-----END PGP SIGNATURE-----

--FoJFderG22Z0MUNI--

