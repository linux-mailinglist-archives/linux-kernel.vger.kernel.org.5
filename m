Return-Path: <linux-kernel+bounces-107312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93DD87FAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C8828288B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9C7D080;
	Tue, 19 Mar 2024 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKBmVB1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE81CAB1;
	Tue, 19 Mar 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841118; cv=none; b=syVQgQmF8OeRQW9bmQpIslN/auyLSAVZaW4+n7axn3QGzf0y960JU+gkakfcNGA5ijBjBurLJyTeo6RC3gJ+PHSYdAm807xJpuhlTvR7sGrI75LlCV+Mo3ESZvzvOk1RPYYMOmnpAfL70IM/XhMsHK82VvMVMNgDpbe3OzKSfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841118; c=relaxed/simple;
	bh=dxXG+Gmtbb64ln2eN3MmDl7PAhyvyEqGB5ajd/zVdnY=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=H+8uHfi0HrXWvvXoN4F/TAJBBBoA5pDHBmOtduXhjs0ydYDGjPWExWYfITsifSCSswnpJJHbIjkA/R+hCYJg9GIS0LrAmlHq+R8dJsUZxzPC/bhJ15akowZI0R4qhBkR2SsSR3xyq9n8b8LAV7ev01ck9YKTLu/nYN/Gq1DXgIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKBmVB1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F1DC433C7;
	Tue, 19 Mar 2024 09:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710841117;
	bh=dxXG+Gmtbb64ln2eN3MmDl7PAhyvyEqGB5ajd/zVdnY=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=fKBmVB1wCWQTlyB2LkK6/DWJKWzaVhpYnl0xYgat3CgzJ8j0ou7BZ61257DSYLKTG
	 SqL75gFrhasTinlW0HriN20rLpjSyFh5k9S861/iI21NTAJlvwWjF5Op0RtjEPIUOR
	 4Zl2iwNpedH+tjfgDG6deLcnWmc4YhFavh/VdVhfNhVn1fdkGIDBJ9SAv/H+b+V9UQ
	 unmKOpX1rpYknZU8IEM/UThmnQODLPOX9Iy5kU1mxrAnt0Qo2dCsRhVYpzwrAwNobt
	 z6bMWTQ2jvhU/qWdvm5fXookW8hyk3JM2qnTc7l6G8F76yV76Zzpv1/DUMIS8wPClZ
	 GR/a+ulpIGq0w==
Content-Type: multipart/signed;
 boundary=8068612056f91609805b0f3394abf385f17c6317149a3cc1d042b2a60044;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 19 Mar 2024 10:38:30 +0100
Message-Id: <CZXMK3W52AFO.1APK080GVJESK@kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Cc: <jkridner@beagleboard.org>, <robertcnelson@beagleboard.org>,
 <lorforlinux@beagleboard.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>, "Derek Kiernan"
 <derek.kiernan@amd.com>, "Dragan Cvetic" <dragan.cvetic@amd.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Vaishnav M A" <vaishnav.a@ti.com>, "Mark
 Brown" <broonie@kernel.org>, "Johan Hovold" <johan@kernel.org>, "Alex
 Elder" <elder@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/TEXAS
 INSTRUMENTS K3 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open
 list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, "moderated list:GREYBUS
 SUBSYSTEM" <greybus-dev@lists.linaro.org>, "Vaishnav M A"
 <vaishnav@beagleboard.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Ayush Singh" <ayushdevel1325@gmail.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "open list"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <0f3f56d4-3381-44f1-91bc-c126f3ced085@linaro.org>
 <c8031e17-5ae8-4794-8b8c-1736be6452d3@gmail.com>
In-Reply-To: <c8031e17-5ae8-4794-8b8c-1736be6452d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--8068612056f91609805b0f3394abf385f17c6317149a3cc1d042b2a60044
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> Regardless, this patch actually does not contain any code for EEPROM=20
> support I have just mentioned it to give more context on why mikroBUS=20
> manifest is the focus of this patch instead of DT overlay or something=20
> else.

Right, and I think this is the crux here. Why can't you use DT
overlays? The manifest files, seem to be yet another hardware
description (method) and we already have DT. Can't we have some kind
of userspace helper that could translate them to DT overlays? That
way, you could also handle the EEPROM vs non-EEPROM case, or have
some other kind of method to load a DT overlay.

Admittedly, I've never worked with in-kernel overlays, but AFAIK
they work with some subsystems.

-michael

--8068612056f91609805b0f3394abf385f17c6317149a3cc1d042b2a60044
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZfldFhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvvCoQD/WFQJ+8ZAvLHT0Mp0SBPRhgtJWyJwU9to
nhNxUXpv6a4A/RCxVlHK59pcC5xd49z5T4GJQU1fdtusPFMC7GsapJoL
=uH/4
-----END PGP SIGNATURE-----

--8068612056f91609805b0f3394abf385f17c6317149a3cc1d042b2a60044--

