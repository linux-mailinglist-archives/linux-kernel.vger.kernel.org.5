Return-Path: <linux-kernel+bounces-110519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BFF88600A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058D1284A90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D28132C19;
	Thu, 21 Mar 2024 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlSypDNW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A08C0A;
	Thu, 21 Mar 2024 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043314; cv=none; b=Mvhh9Y5a1S+GpgKpI7efqpTvgdiReX3LlwMEQgI0976/hNtgAghtbNv7i/uaeubViyt9so8IL2mD41vyhmb/gZ3wU/UP4aOqrpxVz9Z9jKneyytRhmLmXjJRtzMFGX9jo+l7vGMdI+A7O/t77aC4cQBU1TFOM1OWjvJOuv5DfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043314; c=relaxed/simple;
	bh=+JJX9o8lHqOEwaTZe7QvwxLg0SJmmcEplHy7GcPD31E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbaflprv1PywMdNeMENHcZSdMmhTOG5DGrkxLy5MRvJz/NWDqXOlLb5yOYnewb6t2yagL2NT8KsqiOyJ0jwBHFfnJAM5kGsJB8VVWy1WjQgELpP9j5NrrpHb8hc6G0DenZ1IAJZaOzg0WR/Gcaq/wlOcWtMEdjYLxRGIVgs6Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlSypDNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D774BC433C7;
	Thu, 21 Mar 2024 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711043313;
	bh=+JJX9o8lHqOEwaTZe7QvwxLg0SJmmcEplHy7GcPD31E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlSypDNWg4UbypzYgQIEx/rQjsTmJspj0zuhylQdzBW8gEc6ICcf0MI2A5SfNtg6D
	 q6Fxs30BiXA7HEUWKxO2vQxwFtz7AdkIRnexjIrdaU+rsnIS8De2tHXCwkaOtECCUP
	 T9M2wFcHR6Z1ancQsCPlJ/FXFYVoT5QnCyXm++trAXTu8/b+UKDMG5sDI6Jg42/wR5
	 /z8hvOUMUvki1+bgIedQaoRsS1omPEsWyN9uuaNKCbrFRZ8LkitNr1qIdV08ERTbTY
	 tf1DXo3PAqcsCMmI8UliyKrbQiRNIUoBVedO08pwofCOpi0itKWFsUOfKwdZcKvIfO
	 TzVGGDJHwDp/w==
Date: Thu, 21 Mar 2024 17:48:28 +0000
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
Message-ID: <e9c7bd38-49cd-44c2-8842-292bc0b4205f@sirena.org.uk>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
 <20240311160110.32185-3-karelb@gimli.ms.mff.cuni.cz>
 <20240321154211.GA13211@google.com>
 <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz>
 <20240321162045.GC13211@google.com>
 <CZZL3MNOT0QG.2WDSNX9XD2RET@matfyz.cz>
 <879296b4-5186-4170-af3f-971787d28514@sirena.org.uk>
 <CZZLDK79D5VK.2VK3X59OHIY2Z@matfyz.cz>
 <45079e37-dde9-4310-a112-7af49f35ac77@sirena.org.uk>
 <CZZLVS3T3QIS.223XHI5OZ7UBG@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rI0a4HK4N/lO0HZ9"
Content-Disposition: inline
In-Reply-To: <CZZLVS3T3QIS.223XHI5OZ7UBG@matfyz.cz>
X-Cookie: MIT:


--rI0a4HK4N/lO0HZ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2024 at 06:32:03PM +0100, Karel Balej wrote:
> Mark Brown, 2024-03-21T17:17:40+00:00:

> > Do they both genuinely have the same maximum register?

> They do according to the downstream driver which is my only reference.
> In fact, there the driver defines the configs separately for each regmap
> but with the same values.

This is a downstream driver - are you sure it's got the best code
quality?  I'm not seeing any references to registers with numbers as
high as the maximum register that's there in your driver for example.

--rI0a4HK4N/lO0HZ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX8cusACgkQJNaLcl1U
h9DRAQf/b2vXpWtTSOuxP+Jv459OplttogJWu185FKj94bmbQTuuhuaSmwLDekNj
92G29am26hhKJ9BRHfwVnXC0v9iaMWTG1wJzTHPxUliYixd+CJ9IfvqHAMsVaHUS
9gLj4wqhQSDGNqh93KXWzzttpVeCGO9cRmq3A5cfucZuAAjpEN47AZHBAZPv5s2f
SMdYd3oFoBARmvyzgfaUZaPp8wu9IAh2jcNrFQnB1z6Vx4Ym4ouIAKkTd32aHIo8
OPrrgL1g0cDtSAineggjPO/chFFkKHCtkHTVa4OTC715yLS8YCoKEJ3FRxXW6L41
bZWlnVDLAkDFXUPLNFUHsNwomu4rug==
=48cj
-----END PGP SIGNATURE-----

--rI0a4HK4N/lO0HZ9--

