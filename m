Return-Path: <linux-kernel+bounces-64157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF244853AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8A7284DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6358605D9;
	Tue, 13 Feb 2024 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcFjL4tV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8601D69B;
	Tue, 13 Feb 2024 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852198; cv=none; b=g+KEQxSAGxbsDzMRGjHIdGNJteRgWh/K1lJoympxfDdMP+pb41M0FFe1SBNUJeFqq7q6NEnooAcY88qncrihExzypipSx2DF9YQewdxW4qe6veRJ33JO+PiCk7cCna40//v9FZAMp8qXwvPRv4N8xRtmQUgC8UqTgaDVxBxSWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852198; c=relaxed/simple;
	bh=hsD+OvmLS+3S0aEg2rHdHXbh2Nru/txjT+9O83/aFoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9/BF7lXyQnPyTST0bFTgbi04AV+QcBnFVn1inEn7jzpFcH5dc59qutG/AY1DWid41SIb4XGxjGFhvJ2GT/vVVBbZU1flssG6xnJBPYgX23mTWoGr5xn2s+nUiRmj/6Z5XtB1fiMrAmDYRsPpnXpOnxK3CYwq8YtiC8n1lQ/dCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcFjL4tV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48963C433C7;
	Tue, 13 Feb 2024 19:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852197;
	bh=hsD+OvmLS+3S0aEg2rHdHXbh2Nru/txjT+9O83/aFoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcFjL4tV96gUavkroHbSO6wiPDCZYUrufMQKW6QmBi/E0wALT9be7dq6C4ndhK6DQ
	 MRYvZa0RxII85Rj/dFCpyc3YhGhfceMFJMgCNyX+MmMNAUb792xRAEIBsNLsFAiAul
	 +I3DCwzax15rmVzWlY9MS1zYzPhFUjjnzL/pJEyEyQnDRmTst+3r3U50tfhoRbrfbo
	 ApMDeFNTo3qFarMHoHr4AmDZ+qO6yEwFQyA3gtSRiiPwhCDXSW3BMobl0K4RPRDTCP
	 zKzOFLIIUEEfhPIUVUCL2BdTR2a0riZssJdflSawKm5wwj25f3pwyaVhuWRN0NViyL
	 GRQEA06Yra33g==
Date: Tue, 13 Feb 2024 19:23:13 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Icenowy Zheng <icenowy@aosc.io>, Dalton Durst <dalton@ubports.com>,
	Shoji Keita <awaittrot@shjk.jp>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: magnetometer: Add Voltafield
 AF8133J
Message-ID: <20240213-bath-plenty-6349eab2f9ff@spud>
References: <20240212175410.3101973-1-megi@xff.cz>
 <20240212175410.3101973-3-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UlZTnTUSr/twg2So"
Content-Disposition: inline
In-Reply-To: <20240212175410.3101973-3-megi@xff.cz>


--UlZTnTUSr/twg2So
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 06:53:54PM +0100, Ond=C5=99ej Jirman wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> Voltafield AF8133J is a simple magnetometer sensor produced by Voltafield
> Technology Corp, with dual power supplies (one for core and one for I/O)
> and active-low reset pin.
>=20
> The sensor has configurable range 1.2 - 2.2 mT and a software controlled
> standby mode.
>=20
> Add a device tree binding for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ond=C5=99ej Jirman <megi@xff.cz>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--UlZTnTUSr/twg2So
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcvBoAAKCRB4tDGHoIJi
0ri4AP98M54wYPIAkwY0P5ptbYpSoDCBlkhcEof3uMjY67FmLgD/e5EwEvFlSPB0
3FPDwejjegJy/dpDu8IWpUCOu6HDHQY=
=m3jW
-----END PGP SIGNATURE-----

--UlZTnTUSr/twg2So--

