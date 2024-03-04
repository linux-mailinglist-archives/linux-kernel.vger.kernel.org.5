Return-Path: <linux-kernel+bounces-90403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD386FEB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9B1B21FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906D37157;
	Mon,  4 Mar 2024 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pienItvX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D436AF1;
	Mon,  4 Mar 2024 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547193; cv=none; b=k9c0qv6orq/FZqH5TuDjH10FTIIwpQ6eYeAmA8HjQ3E7q4W64CyoVjwZwa2wQrG5XsoB10glVI2lWf2gat18tNOETkuvruZwHAPPyS2aQpeAl47Tk9roftqZApP3vzOCxdzWSdoXURdec6DYMJ/LHXw/cuBUDi3yRxyYxyEq6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547193; c=relaxed/simple;
	bh=sJ4KOxVtmcc7XeECsdsqOlAheKAO0mDagIQEbtEy1/U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS+D1Tb5u46cZYHlA/TxiMhig5xbYpxa0gcUGftI8hf1qJbTGP+uGp9jbLOqf+4rE0mqo5QQcGQYMAfzS7j3FAfq59B9524aWaxXS+2RqorfCVafHbJb3izehMEVDKETlkIZgLtxAmPp46CYOwEWg5w5GSMAGnp4hiTZ74MWLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pienItvX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709547192; x=1741083192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sJ4KOxVtmcc7XeECsdsqOlAheKAO0mDagIQEbtEy1/U=;
  b=pienItvXf6WWCtZsPsLvi9awgT7Dawbc0ayRQ0XTgTHmSwdLiJdl+fHk
   RKMPCR6VOcGs89l4et03yGh1Ku6h8AS0nSlQpHhafwFNcFh/I5GByWiqd
   XcvJ4IzUtqsdtAvh9wF8O6QQjJf56BYVp0L3rA8uiuzkcvMLwZbw2FrX7
   UgOGbJfidvACIGGjpvY40XUIjDoanP4eN/d7qLxygQPBMFJEqaGKUXvXP
   wfTeSUEFKHe5qsCBeiD+kTOzLU+OYKQksYKzVb79iiPSHExG/3xyol3LK
   BOXoRFKFG22zhob1jubkUdmDV17DejTkBqHT6Zaxtlhs73aw4A9THsgwd
   Q==;
X-CSE-ConnectionGUID: Goj1IDGUTvCf0ooKZ5NpOg==
X-CSE-MsgGUID: NuxxthElRJ2+wV0lAx3k4g==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="asc'?scan'208";a="247916573"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 03:13:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 03:12:58 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 4 Mar 2024 03:12:56 -0700
Date: Mon, 4 Mar 2024 10:12:12 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Yangyu Chen <cyy@cyyself.name>
CC: <linux-riscv@lists.infradead.org>, Conor Dooley <conor@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: riscv: Add T-HEAD C908 compatible
Message-ID: <20240304-password-swerve-f82a682fb619@wendy>
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
 <tencent_BD3B8D107CA98249DA8D8EFDB862310A2108@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ugvRUHfMu+512og8"
Content-Disposition: inline
In-Reply-To: <tencent_BD3B8D107CA98249DA8D8EFDB862310A2108@qq.com>

--ugvRUHfMu+512og8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 03, 2024 at 09:26:23PM +0800, Yangyu Chen wrote:
> The thead,c908 is a RISC-V CPU core from T-HEAD Semiconductor which used
> in Canaan Kendryte K230 SoC.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 9d8670c00e3b..e853a7fcee8a 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -47,6 +47,7 @@ properties:
>                - sifive,u74
>                - sifive,u74-mc
>                - thead,c906
> +              - thead,c908
>                - thead,c910
>                - thead,c920
>            - const: riscv
> --=20
> 2.43.0
>=20

--ugvRUHfMu+512og8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeWefAAKCRB4tDGHoIJi
0lyxAQDRzUkuJwBkpYeAvRrCLhGNK9XYFWh7fKJrI7yo2WVD/QEAik6+0zb4XGGW
M8ScvQFXGFBwYs1ke00bhDaARkvIOgg=
=+dYI
-----END PGP SIGNATURE-----

--ugvRUHfMu+512og8--

