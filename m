Return-Path: <linux-kernel+bounces-47772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B9084529B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214711C20C59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF65159572;
	Thu,  1 Feb 2024 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q/SUoU82"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80784158D7C;
	Thu,  1 Feb 2024 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775719; cv=none; b=BPNnyyf73lklb6e0j2Hh3dPR+Qycl6OAR0tDDq75ACqe6d0Z0GxRX+3b1eL5G6S13VR7HiZR4ceGNwwWaf2AcnKNOUtYf8lc4yTYZ24Mo+QTUIUDX7Ewz3w+WQ3WXL6kzBleKHhR4BdUz8kf3OADVeR3/l8hF4XQRjXlhUutIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775719; c=relaxed/simple;
	bh=wfZpdZl/N31/4tOLTGcfIu3SyJ0XLAVEJXeoyLZ1J48=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTVE30HQdO7DpvUCAS1WdhzxpaDfPPFN4Id06eXT3+rOWucjoUoDtefBLaN9FKA7Y4Rqhl8txMQJGpytUtuNf7Lrn+PH3osSqxWfeMJFUgNHAoOLLJhcE0rNbE2iDOXOxODVyVMM+MfjxNgax4lHy3iS5h3cMC/aIiLuPRQKaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q/SUoU82; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706775717; x=1738311717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wfZpdZl/N31/4tOLTGcfIu3SyJ0XLAVEJXeoyLZ1J48=;
  b=Q/SUoU82TsjUo1XPhiuQLZtSMnq5sleLQAIgzb0p4/H0qwk0ymd52Lru
   +BiuJ/w7lUGaFEhCJgJeQlMyh0bjBp+L7XtzOtYKpS4GLWDUqocSVl8Tx
   1aCYmWjBpPBjgUA6zCiXFEpY0/k6SUipTci5DVxSURuSCMDinxNQsPwHD
   NdXOKT7HGVQqS7BwFJ1k5DLAcoGY74OFPh4rc7fhvTCDP/kohIOz1sWLc
   j1XCtYF9oh4RxWQXkP/Ct3en6DTBviLT3CQoJ6VrNliB6o+58I5v7leX4
   0d9UKXLINgo7BkP5qdgYEFRZfJrHG3MofSwHHZYWtz+kVMSakxc9odFjY
   w==;
X-CSE-ConnectionGUID: xeT3MgaNR+W5qlWhP2avng==
X-CSE-MsgGUID: hgNpKvbOS5yYpYQTXvgMYw==
X-IronPort-AV: E=Sophos;i="6.05,234,1701154800"; 
   d="asc'?scan'208";a="246338219"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2024 01:21:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 01:21:32 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 1 Feb 2024 01:21:30 -0700
Date: Thu, 1 Feb 2024 08:20:51 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Guenter Roeck <linux@roeck-us.net>, Conor Dooley <conor@kernel.org>,
	Charles Hsu <ythsu0511@gmail.com>, <jdelvare@suse.com>, <corbet@lwn.net>,
	<Delphine_CC_Chiu@wiwynn.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: Add MPQ8785 voltage regulator device
Message-ID: <20240201-professor-slobbery-a77c9c76ca82@wendy>
References: <20240131055526.2700452-1-ythsu0511@gmail.com>
 <20240131055526.2700452-2-ythsu0511@gmail.com>
 <20240131-eraser-given-8381a44f41a4@spud>
 <d20e1f93-4e6c-4c18-b4bd-19412eb4e8da@roeck-us.net>
 <f99af7ee-1a6c-4e00-9a7d-3a1ddc9574d2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eiYzcIx+MwHK8ugQ"
Content-Disposition: inline
In-Reply-To: <f99af7ee-1a6c-4e00-9a7d-3a1ddc9574d2@linaro.org>

--eiYzcIx+MwHK8ugQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 08:47:07AM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2024 01:41, Guenter Roeck wrote:
> > On 1/31/24 07:41, Conor Dooley wrote:
> >> On Wed, Jan 31, 2024 at 01:55:26PM +0800, Charles Hsu wrote:
> >>> Monolithic Power Systems, Inc. (MPS) synchronous step-down converter.
> >>>
> >>> Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
> >>> ---
> >>>   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b=
/Documentation/devicetree/bindings/trivial-devices.yaml
> >>> index 79dcd92c4a43..088b23ed2ae6 100644
> >>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> >>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> >>> @@ -129,6 +129,8 @@ properties:
> >>>             - mps,mp2975
> >>>               # Monolithic Power Systems Inc. multi-phase hot-swap co=
ntroller mp5990
> >>>             - mps,mp5990
> >>> +            # Monolithic Power Systems Inc. synchronous step-down co=
nverter mpq8785
> >>> +          - mps,mpq8785
> >>
> >> q sorts before 2, otherwise
> >=20
> > It does ? Not in ASCII. Am I missing something ?
>=20
> Also `sort` agrees with q being after numbers.

Disregard that comment so.

--eiYzcIx+MwHK8ugQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbtUVgAKCRB4tDGHoIJi
0gN/AP4tg5L5FIzAL86HeXCni6iANExtZEzYQm/GuHvM/xL1AwD/SkChM5F+gynW
lmkadnEGZQvZYnT4OxYJANK+EUVBnwA=
=tEEr
-----END PGP SIGNATURE-----

--eiYzcIx+MwHK8ugQ--

