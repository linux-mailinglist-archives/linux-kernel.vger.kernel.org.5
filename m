Return-Path: <linux-kernel+bounces-38597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6671883C2DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F08728FA8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163BC4F605;
	Thu, 25 Jan 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RLUEzpka"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48614F885;
	Thu, 25 Jan 2024 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187271; cv=none; b=KXFbe9h0yLhKKxJ/8fQYIY5u5/cBwDkuXv7ipmbjPFjFw4S0BVDy/AsWhJzGnPjP3jqiZaICA040/YqnfZbtNQ3TuyhHUcQGmARFEcRLJHFB6RI9agbNM9u/H7iwfPpaZtPCi4S8jX/FXHPJOA3dgUYp8J6xTPKs7wQ0U4eAyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187271; c=relaxed/simple;
	bh=IJhoKFM+i5ASs0eGsRCruWhTxm7oDqUUNqFVN5TeXwM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQc3dB7OM35F17N2HHdP2rE6vwCIIbBi8pcFer+7uWoF0EG6j9XnX3CokMG3pSEptfULlqK0Sr3cPVIz9sKd/8MhiyaYbPApN0eudrM4affxWKqlMkYuDV78qBf3WjRnzCDrAJmJrq2WQKRM+VWZ3WKSb0S3qkTY+GLJLvzaq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RLUEzpka; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706187270; x=1737723270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IJhoKFM+i5ASs0eGsRCruWhTxm7oDqUUNqFVN5TeXwM=;
  b=RLUEzpkamyNFAt8RaguLH99mrXM/dtLTLRE8bGaEPqhWVqvf7CmM5SYJ
   aR1Nv3qikNHuX/zYK5bGcQBOmZKVtAPizspvC6ebkCKuOsjUbb6sZ14K4
   mqtZll5QAxDB65OoL+ve4YhS8wfoBaozVhSB6U0pWbM7G5WSSK7zSt+F6
   rvpQU2eU08rDZ4vB3WYoOOooj9wAnnaPyXq0Z60S3KkhXfrwn0lWB7cNR
   lR8clLN5E3T+US1zYib3yErByprz0QY5ilMG93IITRCR0E4YeI5p3ITFF
   LKqCi7h0oNdogNSYrzTbq23/O9kpkVef51+/PqTBKRMuYoMFsIVAmyGHX
   Q==;
X-CSE-ConnectionGUID: /Aq3hlafTTiCOLhNSRHcKA==
X-CSE-MsgGUID: lzBoItwTTlWkoW1LraUKKg==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="asc'?scan'208";a="246002953"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 05:54:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 05:54:19 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Jan 2024 05:54:16 -0700
Date: Thu, 25 Jan 2024 12:53:38 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Conor Dooley <conor@kernel.org>, Philippe Schenker <dev@pschenker.ch>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Vladimir
 Oltean" <olteanv@gmail.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Marek Vasut <marex@denx.de>, Florian Fainelli
	<f.fainelli@gmail.com>, <devicetree@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Jakub Kicinski
	<kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
Message-ID: <20240125-crouch-decay-5b149b60e9f3@wendy>
References: <20240123135014.614858-1-dev@pschenker.ch>
 <20240123-ripening-tabby-b97785375990@spud>
 <b2e232de11cee47a5932fccc2d151a9c7c276784.camel@pschenker.ch>
 <20240123-atlas-dart-7e955e7e24e5@spud>
 <979b1e77b5bb62463d52e7b9d3f9ca1415f4006a.camel@pschenker.ch>
 <20240123-carpool-avatar-c1e51ab3cc32@spud>
 <359c32a1-3ffb-4bb2-9a46-802dff3812c4@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FasY058SMp5+ll7F"
Content-Disposition: inline
In-Reply-To: <359c32a1-3ffb-4bb2-9a46-802dff3812c4@lunn.ch>

--FasY058SMp5+ll7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 07:08:29PM +0100, Andrew Lunn wrote:
> > That sounds counter productive to be honest. Why does the driver not
> > trust that the dt is correct? I saw this recently in some IIO drivers,
> > but it was shot down for this sort of reason.
>=20
> DT is software, therefore it contains bugs.
>=20
> Say we ignore that the compatible does not match the hardware on the
> board and just accept the DT has a bug in it and keep going.
>=20
> That then makes the compatible pointless, and unusable for anything,
> since there are boards out in the wild with incorrect compatibles. If
> we later actually use the compatible for something, it might cause
> regressions for those buggy DT blobs.
>=20
> By erroring out then the compatible does not match the hardware avoids
> such bugs.

It also makes fallback compatibles useless, which is what I see as being
counter productive, since you'll have to add support to the driver even
if (other than the id) the change is imperceptible to software.
If you have your reasons why you do not trust the compatibles for these
devices, then it is your prerogative as a driver author to cross check it
and fail if they don't match.

That said, it does not prevent the fallback being accurately described
in the binding itself, which at the end of the day is what I am more
interested it.

> The marvell mv88e6xxx driver takes a different approach. All the
> compatible does is tell the driver where to find the ID
> register. Marvell keeps moving it around, so there are three different
> compatibles for the three different locations. If you use the wrong
> compatible, its not going to find a device is knows about and errors
> out. So this also avoids bugs in the compatible.
>=20
>      Andrew

--FasY058SMp5+ll7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbJZ0gAKCRB4tDGHoIJi
0kQ+AQC8bfXwu4cS2q0UdokiptXIHP0dNFYEDpmgxeF19Tpo+wEAlrHaYMrYkfJH
CKM8cpf8KpQLdoE/xhPrfS1a1YBYBQU=
=aa2K
-----END PGP SIGNATURE-----

--FasY058SMp5+ll7F--

