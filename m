Return-Path: <linux-kernel+bounces-163545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9FA8B6CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94950B215E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4CC1272D9;
	Tue, 30 Apr 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o/Y/Dij6"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98C17F5;
	Tue, 30 Apr 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466159; cv=none; b=K3dP4kg2xCbw063+eK7teU6flaiGX47yMo1DR6NddtDWMDxl19Kc84mK8QIaqNFw+UKhuugnLJdP9QhUurfU17xklyvtPW13nGZM01KNdgiMx/Ac+pLdk7ZtmuY6jxaVqvbWgEWKvpAhV60zOKS/F2jIsfYipLibwvCStiaSJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466159; c=relaxed/simple;
	bh=UkUh+w+9HKgqtj0RQ8rDB4l/giBKlbL8suSDRZ8mUi8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAJvRyrq/buzRNQI7rPSQq1CTSmYjCSyedFW2TwtxYtSPp7NDVTtIrZUFWvFWNud9UqDWizceTLg1h6z/wqtdFjkBQOXM2mASTfYW9Os07RpzRemjcYXq6jEI6Nc7zG1k8ym/5We0WJnmQgwZPf/Qi9g/XUHtfixtLwNIdcEGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o/Y/Dij6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714466157; x=1746002157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UkUh+w+9HKgqtj0RQ8rDB4l/giBKlbL8suSDRZ8mUi8=;
  b=o/Y/Dij6OGH3WR8fDSWpySe6yJcolgHivpPBSVyi79VB4Y/AO6JTmOvn
   k7I4fuQedXE4EkDUTOXN+GSerSjF9a63mPz21B0/h7Avrjx0rMFGy/bwk
   YeqT0x7Y347oj3GoUVq9N8ceaNn5tJuQpEoim2wHeUYLBc7PysZEViUPS
   uEqKg4X+vnbt6xHywF6UeLhT2ez38+DlcFx9acVM0gpgPfD5PSFmqWclS
   vT7goYq2WskOpEbWbK9KgPqE5kMmtLkPK1pO4H4jMpTsgyZciK1Xr5VGG
   SIdDTOsL0SHZu2xzVJFCcF3kbFNZQ4ElobWeojNyJaIsCvDAu7y2dKc/f
   w==;
X-CSE-ConnectionGUID: 7ymLGdXlRHel0zLr79q6yg==
X-CSE-MsgGUID: jVEWITJCTba7if8za9kRJw==
X-IronPort-AV: E=Sophos;i="6.07,241,1708412400"; 
   d="asc'?scan'208";a="23835974"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Apr 2024 01:35:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 01:35:21 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 30 Apr 2024 01:35:19 -0700
Date: Tue, 30 Apr 2024 09:35:02 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Kelly Hung <ppighouse@gmail.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <kelly_hung@asus.com>, <Allenyy_Hsu@asus.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Message-ID: <20240430-spotty-generic-f34c53e2e50a@wendy>
References: <20240430045853.3894633-1-Kelly_Hung@asus.com>
 <20240430045853.3894633-2-Kelly_Hung@asus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vW1rHMiWjpv9z2U+"
Content-Disposition: inline
In-Reply-To: <20240430045853.3894633-2-Kelly_Hung@asus.com>

--vW1rHMiWjpv9z2U+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:58:52PM +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.
>=20
> Signed-off-by: Kelly Hung <ppighouse@gmail.com>
>=20
> ---
> V6 -> v7:
> - Remove incorrect tags.
> - Modify Signed-off-by field.
> v5 -> v6:
> - Add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> - Add Reviewed-by: Rob Herring <robh@kernel.org>
> - Add Reviewed-by: Zev Weiss <zweiss@equinix.com>
> - Add Acked-by: Conor Dooley <conor.dooley@microchip.com>

I did actually ack this, so dropping mine was not required:
https://lore.kernel.org/all/20240229-rocket-fraction-76e85d9f4bfb@spud/

> V4 -> V5: Update all changelog from v1 to v5.
> V3 -> V4: The new compatible is a BMC for a ASUS X4TF server which use
> a ast2600-a3 chip, so correct string to asus,x4tf-bmc.
> V2 -> V3: Add a label to indicate it is new compatible for bmc.
> V1 -> V2: Remove blank in front of the string x4tf.
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 749ee54a3..0047eb4ab 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -74,6 +74,7 @@ properties:
>                - ampere,mtmitchell-bmc
>                - aspeed,ast2600-evb
>                - aspeed,ast2600-evb-a1
> +              - asus,x4tf-bmc
>                - facebook,bletchley-bmc
>                - facebook,cloudripper-bmc
>                - facebook,elbert-bmc
> --=20
> 2.25.1
>=20

--vW1rHMiWjpv9z2U+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjCtKQAKCRB4tDGHoIJi
0i5AAP9qVLkKpEN9rrz34Szz04MkcJNQzs9JmnwGVYOJeL2kBwEAmSfZuCKsFjWk
cLm/Ud2P6LCWU/IaEX8UoRgQZVq7UAo=
=uHbO
-----END PGP SIGNATURE-----

--vW1rHMiWjpv9z2U+--

