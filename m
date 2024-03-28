Return-Path: <linux-kernel+bounces-122788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C6288FD43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA16F1C278C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1967D06B;
	Thu, 28 Mar 2024 10:40:30 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05C7C6D5;
	Thu, 28 Mar 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622430; cv=none; b=VIhT+gJD9HUfSlnxFmNZ1+ltPyZr51CXmVsSzg+p5KamZqBum3O1jsEAFhWLi/EENJclyaDlE4F1RSCzaw0u1D+lO1Pt6W8npjQF+xz0Qdjknv02gru1QjL1cRBDONiE7BtzhL5qSmBmjc9XmQ/Kak9DxXwEafzE7w9vubWYsT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622430; c=relaxed/simple;
	bh=dw2qE9ljhz6X/z7yDJs6sMEP5mr/rY/P6qXHuiQ6/iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtMac9h90wRqRM03GxeyKnyj140+xkQasSW7FTE6ORZbwZzvX8eirVWjo3+dZ+BKVSSntNrKhqZ1+TQTyTfaxcnujFt7tnkxaVEJdvE/RT2zcNmiqmWxX9136XBPxOYV2ALHSS9p1+vKZC1cd4bdhKbpBixyuqqjcAXFox9siuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BD9181C0081; Thu, 28 Mar 2024 11:40:26 +0100 (CET)
Date: Thu, 28 Mar 2024 11:40:26 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mikhail Khvainitski <me@khvoinitsky.org>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH 5.10 127/238] HID: lenovo: Add middleclick_workaround
 sysfs knob for cptkbd
Message-ID: <ZgVJGs2OI/4QsJCQ@duo.ucw.cz>
References: <20240324234027.1354210-1-sashal@kernel.org>
 <20240324234027.1354210-128-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xPubCJWfEMGwzQ2"
Content-Disposition: inline
In-Reply-To: <20240324234027.1354210-128-sashal@kernel.org>


--+xPubCJWfEMGwzQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Mikhail Khvainitski <me@khvoinitsky.org>
>=20
> [ Upstream commit 2814646f76f8518326964f12ff20aaee70ba154d ]
>=20
> Previous attempt to autodetect well-behaving patched firmware
> introduced in commit 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw
> on cptkbd and stop applying workaround") has shown that there are
> false-positives on original firmware (on both 1st gen and 2nd gen
> keyboards) which causes the middle button click workaround to be
> mistakenly disabled.
>=20
> This commit adds explicit parameter to sysfs to control this
> workaround.

Should this go to stable? We have stream of lenovo workarounds, maybe
-stable should wait for upstream to solve this.

Plus it should really have documentation.

Oh and we normally solve this stuff with module parameters, so that it
can be fixed during bootup.

Best regards,
							Pavel

> Fixes: 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw on cptkbd and sto=
p applying workaround")
> Fixes: 43527a0094c1 ("HID: lenovo: Restrict detection of patched firmware=
 only to USB cptkbd")
> Signed-off-by: Mikhail Khvainitski <me@khvoinitsky.org>
> Signed-off-by: Jiri Kosina <jkosina@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+xPubCJWfEMGwzQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgVJGgAKCRAw5/Bqldv6
8jCuAJ91l5476iPTU59SHkJjNcGTxb6i8gCgoecaRojX1warU2+YBOQIBk9uESY=
=vVWE
-----END PGP SIGNATURE-----

--+xPubCJWfEMGwzQ2--

