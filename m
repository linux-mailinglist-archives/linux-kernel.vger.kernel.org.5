Return-Path: <linux-kernel+bounces-110589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8491B8860FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAFC28454E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC3B134424;
	Thu, 21 Mar 2024 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrcQiucb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8C133413;
	Thu, 21 Mar 2024 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049538; cv=none; b=PTrN4PgyF67APtr0HKHLyI//D5I1a5NBrG1/9I6oMpSNWWdSJ5nk0JeaMzR2pDHBRuuuMJwUPc044aTKh2qfv1hhUUvJWLA6auuFDDz7qv1HTThtBI4zX+7MKiSvrRfq3e5wVgSTTVfXOmNPzE/uGwlhyjoqGc/j0bAfgXCE/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049538; c=relaxed/simple;
	bh=RkMIcVyJBPNmrP3i9RZqC7EKeP38W9cL9a+3Pjk0aZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ8Rzsa6AmTbT2n9dCkpB0lZaMlHg3CqUTDHkTrWx4qPMYgHlJwsJVvnXx3Ft4CBziz8adDSarE07vgVQML8cItKguZICUca0wtXj8KxMnokt6B5C4IED2yR6UGH1b/bhFJq/ardlC/BlNXLveoo23Qh3owYTinSAIzWLcSQ01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrcQiucb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A137AC433C7;
	Thu, 21 Mar 2024 19:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711049537;
	bh=RkMIcVyJBPNmrP3i9RZqC7EKeP38W9cL9a+3Pjk0aZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrcQiucb3Na9xyPrmXC9TSX4UDaxP+7U1soYBdyjR2HCre3PRWSG2s5bbynhPVg4P
	 LEIZQULFUXBjsBH4vcTK31KyaLOGIwLoAR4qEIJmH9UzBTQ9mVWNCrS6lC6jc25tmV
	 hNI5jHmLijs/jTuQpin2x04fCiVny0tasAYgWO7k3qboizIqL+ppr9+8ekLVlBIZz2
	 j8j2JP7bQnHS+u0wWIDG3UhvFj3ZgtEjTFN1A7dDz4JAX6Hvr5slEsJ4R2l10ZMrZM
	 0xufXPMba01stBnPIZExvxs0meAOo33ctzQxg/s+yeQK/dIhY0cg3ommFYC389PXAa
	 VqJ8eKgxUtboQ==
Date: Thu, 21 Mar 2024 19:32:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/5] mfd: add driver for Marvell 88PM886 PMIC
Message-ID: <f9ff03a0-377e-46ed-b7b1-2f10017a3b1f@sirena.org.uk>
References: <20240321162045.GC13211@google.com>
 <CZZL3MNOT0QG.2WDSNX9XD2RET@matfyz.cz>
 <879296b4-5186-4170-af3f-971787d28514@sirena.org.uk>
 <CZZLDK79D5VK.2VK3X59OHIY2Z@matfyz.cz>
 <45079e37-dde9-4310-a112-7af49f35ac77@sirena.org.uk>
 <CZZLVS3T3QIS.223XHI5OZ7UBG@matfyz.cz>
 <e9c7bd38-49cd-44c2-8842-292bc0b4205f@sirena.org.uk>
 <CZZMTZBZ5S7B.2HR8A6LEY08D4@matfyz.cz>
 <bd4e96b9-1026-469b-9884-073cde1f39dc@sirena.org.uk>
 <CZZO2EFTAKN2.246XG441ECYYK@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lLalkpu8aLGWk2zM"
Content-Disposition: inline
In-Reply-To: <CZZO2EFTAKN2.246XG441ECYYK@matfyz.cz>
X-Cookie: MIT:


--lLalkpu8aLGWk2zM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2024 at 08:14:44PM +0100, Karel Balej wrote:
> Mark Brown, 2024-03-21T19:00:24+00:00:

> > I would expect that if you have two separate register maps they would
> > have separate configurations that describe the corresponding physical
> > register maps, as far as I can tell this driver is just making up a
> > maximum register number.

> Alright, so I should just use a separate config for each regmap and set
> the max_register value for each to whatever I can find is actually the
> highest used value in the downstream code -- correct?

That sounds plausible if you don't have any other information about the
register maps.

--lLalkpu8aLGWk2zM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX8izsACgkQJNaLcl1U
h9AxyAf/ZKddewyBvi8stRYLa9VKzILgV3va7iA2wGRy5+HbwQi1sP2TV5cyvzGZ
Kuervgv5gAQ2mmFT4nGVjVdRwVaoDXlgjLVZ7AyA+ST/PZj3Z7VN1h/Nu9fFIuGT
0mcWYGGCACD2/6g4hd61VVj41r/PL3ZAXLQi477azLRoZHNOGWzl8H97NY14QMW6
hJzba3tTNCoDAQJkdC7BF+OZrx42l0mvQlrttLKeZumGiU33w2yuOiMgnejfmwJN
zCu4sqrftv3zzX/9q5kAvARdQJ8Tk3A7m79RrcxTZGrj7VsLBoDZ+UN+zBSeirsb
3C0TExKyX35FDNakR9pxN232X6UETQ==
=3Zwp
-----END PGP SIGNATURE-----

--lLalkpu8aLGWk2zM--

