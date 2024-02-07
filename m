Return-Path: <linux-kernel+bounces-56314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768AF84C89B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2661F23CBD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317EE2562F;
	Wed,  7 Feb 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQNJC3ON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2525569;
	Wed,  7 Feb 2024 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301684; cv=none; b=nd9nTJ+iQROpTZ38kbFEHIyPmrtcbws0uagYdV0Ovp9s2KKYpe23Mo3KB1gpnAFnqV2lPJicW8TCTWTPOFAdyU5yjeUc8u4zxf0LGLlTaeABm1V1fjdtD60wNh/qAPNN1CN19vc1ffDXsgTE8j+d2sqhKkrwFKGz4dy096FSsUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301684; c=relaxed/simple;
	bh=DT7w9MrBhp7n1yTiTo1MiCoaRVJkXh7SXpN31OXBjDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXF75p2aCzmTDlvLm494vsz5myFk4ehufezcRsVWeszNWBOtg341X0vvIdDHcuvPBqiMLYPAsmHCpJ75gm0+A1tt19ZN08+pLNew6y2o4Z4iFLOvmxKAKMxRQ4L6aFXhuBV6RJFhnNVUw1QQ3vrWOM0DuyhD5iscN2+y/d59ON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQNJC3ON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDC7C43390;
	Wed,  7 Feb 2024 10:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707301683;
	bh=DT7w9MrBhp7n1yTiTo1MiCoaRVJkXh7SXpN31OXBjDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQNJC3ONzDKm6lJa6A4TcfHBsUBGETDhLRw9F9VYPhcoBu7GaO/U+VGBsvwAEBbxH
	 jbs/NF1vJxuM0AiprfrwdtPk4pPWL/aL3YxW2Ro/4x1VvVigW9qe0Rs68hneRpE+m+
	 5m1dA5qK5WRG1tcTAnPIpys43gSFn8h+DJ/Qb7b7EwurYJC2RBxeQtzhQgoz5F7H2y
	 gbcV2p1rGSKFu8Kk6cxiTN48pXWEaHdWMmpVN4nu1SDTKYj81OrQFsHatlswGc1zxz
	 YmVC4/mcJ5hsyv1lJ7hbBoliUNX91iD57qsrd9oj0I2aAbvGy3pwrhxlBR4C+TXjI2
	 m9OujhSk6hooA==
Date: Wed, 7 Feb 2024 10:28:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Ding, Shenghao" <shenghao-ding@ti.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
	"P O, Vijeth" <v-po@ti.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"McPherson, Jeff" <j-mcpherson@ti.com>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"Chawla, Mohit" <mohit.chawla@ti.com>,
	"soyer@irl.hu" <soyer@irl.hu>, "Huang, Jonathan" <jkhuang3@ti.com>,
	"tiwai@suse.de" <tiwai@suse.de>, "Djuandi, Peter" <pdjuandi@ti.com>,
	"Agrawal, Manisha" <manisha.agrawal@ti.com>,
	"Hari, Raj" <s-hari@ti.com>, "Yashar, Avi" <aviel@ti.com>,
	"Nagalla, Hari" <hnagalla@ti.com>,
	"Bajjuri, Praneeth" <praneeth@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Message-ID: <ZcNbMWgcDNNXAA08@finisterre.sirena.org.uk>
References: <20240203030504.1724-1-shenghao-ding@ti.com>
 <20240203030504.1724-4-shenghao-ding@ti.com>
 <ac4b73f6-0c2c-4586-98d6-e97c575b3df7@linaro.org>
 <8fe0b2d1990346efa056d6c2245412c3@ti.com>
 <e61999e6-8c82-40a2-a2b9-e19d636364f5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oTV3j8bX4pcDUejT"
Content-Disposition: inline
In-Reply-To: <e61999e6-8c82-40a2-a2b9-e19d636364f5@linaro.org>
X-Cookie: You might have mail.


--oTV3j8bX4pcDUejT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 10:53:28AM +0100, Krzysztof Kozlowski wrote:
> On 07/02/2024 10:47, Ding, Shenghao wrote:

> > dix4192 is not traditional ADC or DAC, but an Integrated Digital Audio =
Interface=20
> > Receiver and Transmitter, like an audio bridge to connect different dig=
ital audio=20
> > protocol, compatible with the AES3, S/PDIF, IEC 60958, and EIAJ CP-1201=
=20
> > interface standards, Left-Justified, Right-Justified, and Philips I2S=
=E2=84=A2 Data Formats.=20
> > So keep it alone for professional purpose.=20

> Hm, it is a bit surprising to see some PCM6240-compatible devices 100%
> different from other PCM6240-compatible. PCM6240 is ADC. DIX4192 is not
> ADC, not even DAC. How can it be compatible with PCM6240 in such case?

I don't know about this specific example but many modern CODECs have a
substantial digital component which can usefully be used separately to
the analog components in some system designs, sometimes that's still got
the digital parts of the ADCs/DACs as PDM inputs and outputs are used
but not always even that.  We have some devices that are just pure
S/PDIF bridges in tree already, and the WM8996 is an example of a CODEC
with only PDM.

--oTV3j8bX4pcDUejT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXDWzAACgkQJNaLcl1U
h9AikAf9E6YxxFtH9cfyoNmKem4YvgePB6p+36Bk6BfzlKtN9niud8h1pIvqyPx4
2Cs1luCnA3pjU6BTcpfbrlV9v0BjX2idZjw77dx587mFxyTCop3erQZfT6177pFU
fZotjpwa4fEWbzRpXlE+X9blHrqBfMEAPf9f9eWN8kSLuSVXmQXi4by955lFGNjN
yq9TDdO0m96Y7hWs/U645OQc50W8zcd4QDrUL1pddZP7QOWzpf6XqWATrlWCT5eh
98z1Y9MSvX5SIoJMm1Av7NifjLLQ4Ei4Sjm1KqZylRXZSRPNzUPnbWpPu4h/7Tl/
2fC+g2Qbw0iK2O2nJtzlooGrDUHA0Q==
=A9CK
-----END PGP SIGNATURE-----

--oTV3j8bX4pcDUejT--

