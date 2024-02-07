Return-Path: <linux-kernel+bounces-56764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E8884CECD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DE11C266E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9ED811E4;
	Wed,  7 Feb 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTqxE3AS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CB67FBBD;
	Wed,  7 Feb 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322963; cv=none; b=glio6f2WM5KIlCe5EmiBwpkZApjo3iz8L0jV6GrQbtIl/WdRzrmyPtDNtx80DFG4bhzZktZfE2x5ZnXThuIAr/B8Hm7uKPmZK4dunUS1MjY3BI6utJpuTlbOD1tkx6SCYJuEcjoK14uya38b1B5OC0NHv4/C0nxtMYmGI+JHiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322963; c=relaxed/simple;
	bh=pMEzXXPIUcYuWpCdZv+0Vn1+7MD5FBZBfF3MLhc5cg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTw2mAQGs5+Lhzs2HEjaZLMrihB+iQ9AnWH5xjFPX1LxrA5btMVzjkizclvuKJT0n5egIq5kiJ/Ug7Nls1QUXrHqikGjqlY1shnYHCA1GIlFC9pgYYlStL9FNyDaZHZ4xnOWGiY61EHLofclfxBYv93hVaLTU78XFVLW8fQKAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTqxE3AS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A236BC433F1;
	Wed,  7 Feb 2024 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707322962;
	bh=pMEzXXPIUcYuWpCdZv+0Vn1+7MD5FBZBfF3MLhc5cg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTqxE3ASSOANkJoWnEcrFvIKWsHp0iuK6XxH0GlaFphdonkiWTAp2YJMACyodR2WM
	 WrrHNgw4CFeydw6U6JA8UBHPpWGEhQFigXiqQI6qdze91FTs4LNskbdkNwOvQ/LYYv
	 QMJparFv7hZdKWKTxikp+i1Qydwy2j2Y9pRyFEYL6cEZBh4SrgOhQY8TgJ4cBbW7lT
	 L1Tr9krntbSmstW3rqrtPU3EdJO06os95uQO5wMpZEDxsdhCjiBEBafdJD7JQ71q+G
	 XLLR7xNlir2mQGHrIIm8g426cAwdDFQQRZTMr+c5A9M+dvNKgpoFyKj2LA8PYqKeT/
	 jnk2sINiEoCcw==
Date: Wed, 7 Feb 2024 16:22:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: rtc: abx80x: convert to yaml
Message-ID: <20240207-astride-banister-371ce4d36edf@spud>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
 <20240202-add-am64-som-v4-2-5f8b12af5e71@solid-run.com>
 <20240203-prolonged-backfield-c659e0016d70@spud>
 <20240203-tummy-egomaniac-5aba55889a83@spud>
 <0c784113-9288-46bd-a34e-49bf0f1651bb@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DGDNYYnA7zsSAf/5"
Content-Disposition: inline
In-Reply-To: <0c784113-9288-46bd-a34e-49bf0f1651bb@solid-run.com>


--DGDNYYnA7zsSAf/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 02:44:24PM +0000, Josua Mayer wrote:

> > Ahh I now realise what your intent was here. All you need to do is add
> > | interrupts:
> > |   maxItems: 1
> > to your binding and it should do what you're looking for.
>=20
> Yes, that is in line with everything else.
>=20
> What bugs me is what to do about interrupt-parent,
> and whether to include it in example.

I am pretty sure you don't need to add it.

--DGDNYYnA7zsSAf/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcOuTQAKCRB4tDGHoIJi
0kQvAP4m2/Ux3BhI3wLWXVa9b0iB0LDgxI9uFmlV0BgUBArVyQD9GSbbODSVJO3+
D0qUvcwI93EzGiK7IQ78d85Ym4ljygM=
=b7P0
-----END PGP SIGNATURE-----

--DGDNYYnA7zsSAf/5--

