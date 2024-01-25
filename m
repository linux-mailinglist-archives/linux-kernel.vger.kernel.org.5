Return-Path: <linux-kernel+bounces-38642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4B83C390
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7804428E82A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80350A95;
	Thu, 25 Jan 2024 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q3bdEWKl"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE554F89A;
	Thu, 25 Jan 2024 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189037; cv=none; b=MygzytJ4ItdLadD4aSZ06n+ZCv/MhyHhGTVhDvj0Axx45Ds9uQzhRf/7pZTRnO9acb3metEAaPR2/nHyU7PpLVoFZKnEoxRXsZy5WwmjvOd5z7aWWMnRdIVXPW7oMtwC5dM0nnsQiN7jNwnf4WAaCqzcZd4PqMYAZ0dmzvigd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189037; c=relaxed/simple;
	bh=XtQw4AFgGYzqIH/Xew9U1aJm1yzGt9kNKPGGaSBjoEM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3YB8zMyx6G7BvlX73NHyA9JTGxAvsWBPs0zsFw5VPGmipoqoPa1XgnZFRtRkkyUTZb7q9iIzhGfVQGv0d7CHzRBzLlqF3kEVEGM5+hf7C+Qoywpdy3W3gvM5uWyLj4/IHHHc+RHhTVZhIWpfdNXhnmspn7qTz5Io3kKPyMcoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Q3bdEWKl; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706189035; x=1737725035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XtQw4AFgGYzqIH/Xew9U1aJm1yzGt9kNKPGGaSBjoEM=;
  b=Q3bdEWKlPzwXvXbvENGdjtWt0xCKMfgAwVIcVEUUCHbt0q//Si3NH2R5
   mp4qCGL659W2d0aYKWfT1DhFLEDQs4b02EtDBok4+EHDw9cXOHWqllqkW
   88OBrPM9VVFiIOiVUwvqES+YgZH1UDXT8+9OQs5En3rM5gttgR/DrYFDc
   6G+0A3zEeiOPKYiwhMf8a1sHIXKi0pKo7w8sVwcboKO1FPfc2l345XhP5
   iBHvTWIiUnAanGFL4nNdNIZOuli/RXzdJJnBPYkZKJ4siWGnfmH3vv/pa
   s5pmBP14xlf0eRWNCoin6459cEWi9c8JRazHwSlhd47c6+WME2tFAW1nH
   g==;
X-CSE-ConnectionGUID: FhQ+gd6DRlilwd5DcEURwA==
X-CSE-MsgGUID: LmCRtipWROiYABA1X/70Kw==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="asc'?scan'208";a="15279352"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 06:23:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 06:23:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Jan 2024 06:23:35 -0700
Date: Thu, 25 Jan 2024 13:22:57 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: Conor Dooley <conor@kernel.org>, Philippe Schenker <dev@pschenker.ch>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>, Marek Vasut
	<marex@denx.de>, Florian Fainelli <f.fainelli@gmail.com>,
	<devicetree@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "David S .
 Miller" <davem@davemloft.net>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Jakub Kicinski <kuba@kernel.org>,
	"Andrew Lunn" <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
Message-ID: <20240125-neurotic-bouncing-82df9cfc2fa3@wendy>
References: <20240123135014.614858-1-dev@pschenker.ch>
 <20240123-ripening-tabby-b97785375990@spud>
 <b2e232de11cee47a5932fccc2d151a9c7c276784.camel@pschenker.ch>
 <20240123-atlas-dart-7e955e7e24e5@spud>
 <979b1e77b5bb62463d52e7b9d3f9ca1415f4006a.camel@pschenker.ch>
 <20240123-carpool-avatar-c1e51ab3cc32@spud>
 <20240125095719.2nu3u3auwdcmouaw@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RBdbisQWjGXr+kKp"
Content-Disposition: inline
In-Reply-To: <20240125095719.2nu3u3auwdcmouaw@skbuf>

--RBdbisQWjGXr+kKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 11:57:19AM +0200, Vladimir Oltean wrote:
> Hi Conor,
>=20
> On Tue, Jan 23, 2024 at 06:37:55PM +0000, Conor Dooley wrote:
> > On Tue, Jan 23, 2024 at 06:30:16PM +0100, Philippe Schenker wrote:
> > > > > Hi Conor, Thanks for your message!
> > > > >=20
> > > > > I need the compatible to make sure the correct ID of the switch is
> > > > > being set in the driver as well as its features.
> > > >=20
> > > > Are the features of this switch such that a driver for another ksz
> > > > switch would not work (even in a limited capacity) with the 8567?
> > > > Things like the register map changing or some feature being removed
> > > > are
> > > > examples of why it may not work.
> > >=20
> > > Yes the ksz dsa driver is made so that it checks the ID of the attach=
ed
> > > chip and refuses to work if it doesn't match. [1]
> >=20
> > That sounds counter productive to be honest. Why does the driver not
> > trust that the dt is correct? I saw this recently in some IIO drivers,
> > but it was shot down for this sort of reason.
>=20
> If the hardware provides device ID registers, what is the best practice
> in reconciling them with the compatible string?
>=20
> I see 2 extreme cases. Ethernet PHY devices seem to blindly trust the
> PHY ID from the "ethernet-phy-idXXXX.XXXX" compatible string, and phylib
> won't read the PHY ID from the standard MDIO registers when this is prese=
nt.
> Whereas PCI seems to completely disregard the vendor ID and device ID
> from the "pciXXXX,XXXX" compatible string of function OF nodes. Both
> these subsystems have the "compatible" string optional.

The software is free to do either, even if the compatible is a mandatory
property. Which is the right thing to do varies though. In your first
example, the compatible might be used because the standard MDIO
registers do not provide that function for whatever reason and therefore
cannot be read. Or there might be some shenzen market ripoff of another
device that it claims to be in its ID registers but has some
incompatible difference in the programming model.

In general though, if a device can self identify, I would be inclined to
value the self identification over that provided by the devicetree.

My comments here were because of the default in the switch statement
that rejects probe if the ID is unknown as it excludes the use of
fallback compatibles.

In this particular case, and maybe some historical reasons prevent this
that I am unaware of, I would read the ID of the device and if that is
an ID that the driver is aware of, treat that as the truth. As far as I
can tell from my quick look, the driver does this.

The first potential mismatch then is where the ID is, but does not match
what the DT claims the device is. As I said, I'd be inclined to trust
the self identification here, but I can at least understand rejection of
probe. Again from a quick look, the driver seems to trust the self
identification.

If the driver don't recognise the ID then I would treat the device as if
it is what the match data says it is, so that fallback compatibles would
work. This is the case that this driver does not allow.

> I could see an advantage in using a precise device ID in the compatible
> string, rather than just one from which the _location_ of the device ID
> can be deduced, because the precise compatible string allows for much
> finer grained static analysis in the schema for the device. In case of a
> switch, that is the number of ports, supported interface modes for each
> port, etc. With an imprecise device ID, you don't know what you really
> get until you boot the board.

That is true, I think it is pretty desirable (although admittedly I am
rather biased) to add specific compatibles for validation reasons even
if the drivers make no use of them. Generally new bindings for such
cases require a fair bit of justification, but its harder to stop the
proliferation of existing cases, without retrofitting specific
compatibles to the dts users (in addition to the generic one), and
disallowing the generic compatible in isolation.

> > And despite the email, I have nothing to do with these switches, I am
> > just a sucker that signed up to review dt-bindings...
>=20
> Same here, just a sucker with some switches and not many clues about
> other things :)

--RBdbisQWjGXr+kKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbJgsQAKCRB4tDGHoIJi
0g40AQDGGJiI9eFtvksB9tc8NzEdF65pooUYjZujzYiwNOQE6gD/Q054FlhO3uQS
kX6APqtvzO1BU5Eu/HPGNXZEN1sazgE=
=1g+r
-----END PGP SIGNATURE-----

--RBdbisQWjGXr+kKp--

