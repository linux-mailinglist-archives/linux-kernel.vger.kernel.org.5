Return-Path: <linux-kernel+bounces-44587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B578842496
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD55FB2D033
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7166067E7E;
	Tue, 30 Jan 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VTUFh7+F"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8246775E;
	Tue, 30 Jan 2024 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616763; cv=none; b=oBr0r24JzlNqydKpF+2lKM3WcZLGSRHRwxKD9okwu/9m2FNQpKp/zNsFOto6U/KOIK0tQTM887x6z9JfENpVngpyuHsmwCi7NeE72Ej5PYKoSZxgJi5DGZr5PlU6FF68X9cSYIrrI3Eq4UmH1ylNpO4UVjVhBDUGj0g2BvPceUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616763; c=relaxed/simple;
	bh=ts6+3cKiUi9J177cwzVgCHsWG2TI3IL/jBqFMX29Dpg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zpi+xbnV5c1TpIwtePql4bXhFOmPG2iHOe0h7exEZ1a3KytTfdeWFsLWhu/1G2I6ZLQNs96OKkECbpLO4nl3sp+t2QMTSj2RnzRMDq9vI2ec2ae3ze+T+1REN8aEnNx+AtyHJ/8kXU7oyfahwObSKAZoBv0OFu6aWekQK4dlSqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VTUFh7+F; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706616761; x=1738152761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ts6+3cKiUi9J177cwzVgCHsWG2TI3IL/jBqFMX29Dpg=;
  b=VTUFh7+FYr0Zzk/gUT779ohSTh63PUvwYD7lp08nfsrts9UH6gwnlea5
   r/XLp5ijX3YgbVAj6bBSZRYGlueV+/4urvbPrtmx+p6p/hOzzQoDFidce
   SF09U+r64FCvYLIauhdywePchwR/QeWe67cb0QlxL/o5Sfe+RNfcemvoY
   ZICAZVkkBOrQY2SggEjr6nMBNI/3XU37KEhv/1GMPv5ZNu+ZMXrTzgPVI
   25MZBSrtKAtNkypTLpVPfw2CarvZOSG2lsamPbE8xNK+ch+vjJ3xPNLAT
   LmKhwiR4EMfNZcH6+64L27lNPaENe4u3XN8W9CFrEPy7EZgn9nBSQ/X8w
   A==;
X-CSE-ConnectionGUID: daF2h1OmQfmAoCYQvT7ARg==
X-CSE-MsgGUID: SGmXWDjFQGqzfcOyr/9P1g==
X-IronPort-AV: E=Sophos;i="6.05,707,1701154800"; 
   d="asc'?scan'208";a="182745230"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2024 05:12:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 05:12:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 30 Jan 2024 05:12:22 -0700
Date: Tue, 30 Jan 2024 12:11:44 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>, "Daire
 McNamara" <daire.mcnamara@microchip.com>, Wolfgang Grandegger
	<wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Michael Turquette <mturquette@baylibre.com>,
	"Stephen Boyd" <sboyd@kernel.org>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: can: mpfs: add missing required clock
Message-ID: <20240130-narrow-lyricism-8b25baac7bb2@wendy>
References: <20240122-catty-roast-d3625dbb02fe@spud>
 <20240122-breeder-lying-0d3668d98886@spud>
 <20240122-surely-crimp-ba4a8c55106d-mkl@pengutronix.de>
 <20240122-cruelly-dainty-002081f0beb2@spud>
 <20240122-smokeless-ion-63e4148c22e5-mkl@pengutronix.de>
 <20240122-uncoated-cherub-a29cba1c0035@spud>
 <20240122-pogo-reputable-b1d06ae1f1f1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HOtgW7KLF4e36W+S"
Content-Disposition: inline
In-Reply-To: <20240122-pogo-reputable-b1d06ae1f1f1-mkl@pengutronix.de>

--HOtgW7KLF4e36W+S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 04:31:32PM +0100, Marc Kleine-Budde wrote:
> On 22.01.2024 14:56:09, Conor Dooley wrote:

> > I think we already had this discussion on v1, where I said that the
> > binding requires the clocks to be in that order, regardless of whether
> > or not clock-names is provided. You feel more strongly about it than I
> > do, so I will add them when I get around to sending a v3.
>=20
> Yes, this discussion sounded very familiar to me, never mind. Keep it as
> is, and let's get this binding and the CAN driver upstream!

BTW, I didn't see an ack on this nor do I see it in linux-next (yet).
Are you expecting the patch to go with the rest via the clock tree,
via the DT tree or will you be taking it with CAN stuff via netdev?

I can resend this one patch with a netdev appropriate subject prefix
if you like.

Thanks,
Conor.

--HOtgW7KLF4e36W+S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbjnfwAKCRB4tDGHoIJi
0td9AP91wL1UJKxv7WEXkQU6wml5iEFKMQpde0b5OMFJLiz7ggD/cJBfDDVA8GxG
4K79+ItvQhc3pNrmvQLtKEyZc1+fRQ8=
=AXqd
-----END PGP SIGNATURE-----

--HOtgW7KLF4e36W+S--

