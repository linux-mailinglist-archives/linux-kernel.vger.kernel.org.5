Return-Path: <linux-kernel+bounces-61723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7168515B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29781C22CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E13B799;
	Mon, 12 Feb 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NXy22sJo"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C33B296
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745374; cv=none; b=A1jHOSqD51lRowYAlY0CEstdF4uRsNrP3PVVpkbBTRymFPV99LnUJlsE5TusxoaM4FJC8s/2wLNsMCwJ5GKgk7NZn5EURSyFLPnKc5HxLPMSUcggTubUvqYil7rl+/VBs2AI6am+30UTb+cXCOApB6QzEA3lTtD/SvFMMHw09L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745374; c=relaxed/simple;
	bh=AbjQ2DV/nX2p97vvxC2UM0Jmz09uFhNK2994d7XYkN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peGIlyfUqB7hv9KelwFYH3IL3iD/RDa+QN5gocM63xBQWsL05dlLZljDWOcdwmZOPKV4a8N4bkOp4EMYD/l5oqk9mM3KyN+SdxNMqpc/vTSRI+txGhCdDkUphA7SG9I+6aAUcNhb2xFaCOgM0BB7bW1m6S1wq7MJh9bTHh5/1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NXy22sJo; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=dnTS
	RML03NXrWUaUmxvov3tWnZvOFwRpDRGc9usJsQY=; b=NXy22sJo52GISOYqjKz/
	SbNuxA723hME+fgFkGtRfQhZLvw0iPDvN5YM5VXbIG2iUhtkUL9nQH9pEb+hskfE
	pCql1kw0C33DVAdvfpHFYu/jJttug9qrvWUcwZtDYG0XW6Ds/nFfSXTWwxh9JW0o
	yN5hrQaZ9lQCmY3ADrzYAH6vdzAZ7xuXjW+WRmg5TiP+jEtU27whraP8T5jPRXxk
	J3rOVSWFGvB6Y1Y3Am+KakJgbsqRiqb+iVXZekkNZhAfboZPNr6iMylDrzHG8T+4
	RsJnYPykLS0RrloDZPyaZ4r/d+9HPi3zhkFKC7rZ88fMEPWEO84wgthLlRw+eq9a
	cw==
Received: (qmail 514895 invoked from network); 12 Feb 2024 14:42:50 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Feb 2024 14:42:50 +0100
X-UD-Smtp-Session: l3s3148p1@iFAmdC8RyMEujnsZ
Date: Mon, 12 Feb 2024 14:42:50 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] arm64: dts: renesas: ulcb-kf: adapt 1.8V HDMI
 regulator to schematics
Message-ID: <ZcogWgtQ7hZ-5aj0@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240129212350.33370-1-wsa+renesas@sang-engineering.com>
 <20240129212350.33370-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdXuWHCLa8HFXBZK4M4fqivudxjHcqqUyZ2=a3=OfFLPYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ViCkhs1N/DSNyQCE"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXuWHCLa8HFXBZK4M4fqivudxjHcqqUyZ2=a3=OfFLPYQ@mail.gmail.com>


--ViCkhs1N/DSNyQCE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -       hdmi_1v8: regulator-hdmi-1v8 {
> > +       t1v8: regulator-t1v8 {
>=20
> "t1p8v"?
> Or "reg_t1p8v", as the former is a rather short name, causing conflicts?

Agreed, I'll take the latter and resend.


--ViCkhs1N/DSNyQCE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXKIFkACgkQFA3kzBSg
KbYo+A/5AQodBk5gyl8QWD4Fgh53bbi20T4mIrlsEXtIiXO8UWJBw11a9aApsiw4
a2EYedUgo5gsf6KB5NvB5bMEVN6ALiJAJ/GcDktgwibWxxlFMYC3CeSp4A2BymQw
0fZI1uOV4R1mZcDjP9Lotu7tJMXSRbqj9U9ubIE+/EWaPrF5WpIuvqlyEcvWA/UL
uSY4e/c8LQPnGFBMxcL7ASnvpVMwurYi3cVLhWttxAN6KNT+wF6hH18K9fy/aA4u
e7aeJY5kHZcujzSbs2Bv/GeHIMC3CG1d3AsGiRMAFhL8FTvfazuCjoYPBJ686qzY
Zzz4A0i/Rt2EmjtvaRNJpZudjHAEj2rY+RXCJ/QFrdJ7NY6S0Y7RSp9NfwltOcu4
pGTM5XTPBbXGJfNtyb1hGNdb4qxchb5pL5foNniZoMww4KXMj8OxqvPpS/2Tok9w
SHwDKJtTRbA8fTQtr8EkuxWfao97wcJXF25rsFtWcOYuvqD4phQmWu4RzghDwTOA
Dq59n7Vb32neX4qcGXMbb7yUq0qLxPy9d+BdG43MwVy9O4fSac/qQEK+NFqt27sR
SIIVZRuFKG7rpLmhRZz6K8IMT30hGbsb/pJQ5RYTM/I1aPMKV0FWXV+hiq50ELcg
GDG+5M1AJepnGDAtLgmtWOp08R7yYZjz0gUY83Ayepgw8ygLang=
=tcSq
-----END PGP SIGNATURE-----

--ViCkhs1N/DSNyQCE--

