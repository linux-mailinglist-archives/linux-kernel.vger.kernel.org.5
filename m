Return-Path: <linux-kernel+bounces-81131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4491E8670FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0489B287FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E83155E4D;
	Mon, 26 Feb 2024 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TIUD9stV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53C55C3A;
	Mon, 26 Feb 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942050; cv=none; b=nr2LzGgfLHmfEoJmfpOzZgW/og3DxX517z0TGGYapkf/SH4WCReVKUKTb7Zv1NKUwp0MaqWvFAYXkYMMdfH/j8uFJ/YEaCHxjY8u0lF9Ai9lJOGz0KUgErwFVN9jObdv2dECvmkftjrfmTvNhDzX/Ms7laXPFmXRZLoZjvz+j+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942050; c=relaxed/simple;
	bh=DNebHSY35bj2aTTlomFot9W8ge7L9kuaM2+VvG/w0cQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vydz4MPFDJEJku9gbUB+PGOmDAxR9OtRFyOmapug1OnAZWxLZhxCE3gm+rOAnnLufPiOz5Zc7e8ekMTmoOnx3VkD2G2OLM7utPwCMPCTXT3vW7dNxzMze2vl8pjhFHK+Dn5l9w/q37lFTXiTfyfVTvg2nQhS31oU04QeWE42D2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TIUD9stV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708942049; x=1740478049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DNebHSY35bj2aTTlomFot9W8ge7L9kuaM2+VvG/w0cQ=;
  b=TIUD9stVWwLtzZVubbyLaE2JskhGPzvRjupek/YU0zmxCcTAqiQL5K7B
   Fp7ZimIWgvkwMph33WUQqty5oAGkSJIP3eKXR1nHi0uc+ipVxflD0iQrl
   XutfJ7gwXEY8opNgzpfJ/y1g1eNJGpMfUmzOPtu10PJyWrTSuC0TTo9lk
   dYtgteG/aEQ6CcUGnJ3cFlWmTP1cmvjWpBi+bByLdDf1tKZOfbY/fgtoC
   W5s4IrQWo5va7lhWmm5XHLGoX0f9q0+HPQvevF+B6qdOYDWV6MJEOAhFf
   wyOtJ/VBbR6eNK1FxbwKYpVp2HxHSQ8BYggOFer+Yz/6oLZ80lclccdiS
   w==;
X-CSE-ConnectionGUID: VSJxsAsaSlyrhJ5T50LSuQ==
X-CSE-MsgGUID: QEGURzX6Rn6dwABcqO++nQ==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="asc'?scan'208";a="247564532"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 03:07:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 03:07:07 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 03:07:04 -0700
Date: Mon, 26 Feb 2024 10:06:22 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
CC: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, William Qiu
	<william.qiu@starfivetech.com>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	<linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: pwm: opencores: Add compatible for StarFive
 JH8100
Message-ID: <20240226-hurt-cubbyhole-f792a9e8b25b@wendy>
References: <20240226033945.816974-1-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O/w1adAHCIQ0qVfg"
Content-Disposition: inline
In-Reply-To: <20240226033945.816974-1-jisheng.teoh@starfivetech.com>

--O/w1adAHCIQ0qVfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:39:45AM +0800, Ji Sheng Teoh wrote:
> StarFive JH8100 uses the same OpenCores PWM controller as JH7110.
> Mark JH8100 as compatible to the OpenCores PWM controller.
>=20
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
>=20

Applied, thanks.

This should've been a b4 email, but I don't think the old copy of b4 I
had on this machine likes UTF-8 encoding in email addresses as it
generated a pile of crap in the to field. I'll have to see if a new
version fixes that.

Conor.

--O/w1adAHCIQ0qVfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdxingAKCRB4tDGHoIJi
0nImAP4vdfnl3n5CXRLR+1UVkwBvzjbGYeIeN699Lwxtm34nBAEAqrsi/qdEuw2a
QrQux1Bc7Q30vbEzVEY8CwRVrQjdwAw=
=I55z
-----END PGP SIGNATURE-----

--O/w1adAHCIQ0qVfg--

