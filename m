Return-Path: <linux-kernel+bounces-167942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E6C8BB164
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455071F217DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1EF1581EE;
	Fri,  3 May 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+pcZfXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D341CFA8;
	Fri,  3 May 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755711; cv=none; b=RGb+0ircNbzjuClwv+nqg4VUu9GEaMZ8/AwRkR2luRx9qtrppwAmRIqJ3yq7Q1jVVb3/3l0gUZwobSlS3zA73uPfvnTgDYxaNLCiws+GXOHet2UIlKZ2W5vIATXnhfrroN8lc4lt4W5Ty1nO+d8dLxoobN27tlSW4dlBvIZcDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755711; c=relaxed/simple;
	bh=FTaOlyTRBQhQQAb7vZwEa2LctghGTeQJqXhlkzNOBI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMImpPfPlMZ2GoCI/K5pbYrv+StTuLHZBd1AiQS+bEGo/Bvfz3nbf05eDzuQXI+IKorqWQ7jh+tBO94jgtG0oFrHVLWoRzfpmc5hoOY36ogPoH3C6Y9vBaGECMskRhephfcW1Sykvz/R7R9fKIi4+JF+HVgn5FTCOoBa1LnG3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+pcZfXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63BBC116B1;
	Fri,  3 May 2024 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714755710;
	bh=FTaOlyTRBQhQQAb7vZwEa2LctghGTeQJqXhlkzNOBI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+pcZfXZpJFOA9j0VKkgIIsI9WBref2GyOONCDzPlZFRsKo0UaaCgWAylyb62Fv9R
	 IkpR0TicodAMWYQdLxEJCtN9YcqXzZvKZl+5kVxHnIqZ48R0/ApkoT/KfAY7gtEm8l
	 6EA/+XALx2dgKHCn+2/LLLdtfXjHx69entbkVFcyQtW0owUvSDsQgzE5VGLkS/9l3Y
	 mInvr6yFqZ9vTEyqEI31u2mj00HKFR0j763omQvGHTfL/vOyWVA/RWLkPnkbDlqv00
	 rf62Ahg2x+LmpmhsyKExM2kzmgNnQ6b1oys3J/Fv5Rk/5eBSZmov15c7Z8taj+eb5J
	 ppxH+Xo5bOfQw==
Date: Fri, 3 May 2024 18:01:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add Sophgo CV1800 USB phy
Message-ID: <20240503-deduct-jellied-23f4f90e94e3@spud>
References: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB495355A4186420B78BD78F49BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240430-crummiest-overnight-0f46dba32bb8@spud>
 <IA1PR20MB49535665CF1C89FFB4E1E46DBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240501-effort-virus-9baa07daf429@spud>
 <IA1PR20MB4953EF886763A05EE6DDEF25BB1F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mC/9d63aJT0Up3A5"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953EF886763A05EE6DDEF25BB1F2@IA1PR20MB4953.namprd20.prod.outlook.com>


--mC/9d63aJT0Up3A5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 08:36:47AM +0800, Inochi Amaoto wrote:
> On Wed, May 01, 2024 at 06:05:28PM GMT, Conor Dooley wrote:
> > On Wed, May 01, 2024 at 08:28:47AM +0800, Inochi Amaoto wrote:
> > > On Tue, Apr 30, 2024 at 06:09:20PM GMT, Conor Dooley wrote:
> > > > On Mon, Apr 29, 2024 at 08:31:11AM +0800, Inochi Amaoto wrote:

> > > > > +  vbus_det-gpios:
> > > >=20
> > > > "vbus_det-gpios" isn't a common property AFAICT, why does it not ge=
t a
> > > > vendor prefix when the other gpios property does?
> > > >=20
> > >=20
> > > I have seen other binding (such as sunxi phy) uses this property with=
out=20
> > > vendor prefix. So I think it is a common property and don't add perfi=
x=20
> > > for it. But it is OK for me add the vendor prefix, thanks.
> >=20
> > I asked yesterday and Krzysztof said:
> > "gpios just like supplies - no prefixes, I think."
>=20
> Thanks for your explanation. If I do not understand wrong, you mean=20
> it does not need to add vender prefix?

Yeah, I think you're okay.

--mC/9d63aJT0Up3A5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjUYeQAKCRB4tDGHoIJi
0ippAQCbZB+6yctrVo8FxPFGsoTXfVgu0jCn6Myoknnj6a2r0gEAtRpP9ldQSTNK
hFaGSTTBGWa0JD09rGB4zZZCjVY4uwI=
=1ISt
-----END PGP SIGNATURE-----

--mC/9d63aJT0Up3A5--

