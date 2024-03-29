Return-Path: <linux-kernel+bounces-124453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117A9891837
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347451C21C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F77D3E7;
	Fri, 29 Mar 2024 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A1q120mb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917782A1A5;
	Fri, 29 Mar 2024 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711713401; cv=none; b=iuSlqSDl2Fc8+nyjkCKA9CVFZBEunzEACBSu1NkdjaYVX7lmSU107xDS5yBWXLjqS69Ox7FTRhlviLVIpDy5Y++Lx7VUIWZo/fCs3om+aBn9EeQ4xVrDYiawWN+gRF+SRCqroFhJnDz0JznRvkZ4n6O0lOpD3bVv3TlQweghMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711713401; c=relaxed/simple;
	bh=zxYrkuVAUpLl4Z7Yj1bEeeQLX+DhAjPrTYcGONUQg80=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk9dyGqZvvCgb5ArCv8pny65a3XaepoNRJElBnAkfZR7uGqIVrjERZkGJAh8oNv0i2qiIiZDsPsHdSKcbQ8pcxUqX4G42R8VNrUMw7wZKT886JLA7CmYX/OlCAV4j5aVbrCLsZ2/vamLaLh9YPt2LWQBQy1tld7D27kFt3qsbks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A1q120mb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711713399; x=1743249399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zxYrkuVAUpLl4Z7Yj1bEeeQLX+DhAjPrTYcGONUQg80=;
  b=A1q120mbOqo+peb+Xn1uEY09ozOGHs4VPBoG9YfHCsACXgOvpZkxDsuX
   XfNPLDQlfazBmAxMl8xuwNxpk0wI79q6ASXZrEiegYcpdNUJov206iLnI
   pVZfMld1DCMfI8RCb/yN4p8vqKmc15YCYvh94JGRgs9Jrfvw+PSZOhBBZ
   L77wUDfIDTnpxeeIziuCfb3gk9smkzeYmzNCQ6sJfy+vyy4bIl1aYb2qg
   Z6dc6xyrqVY/iUDA2Ao7J22K5VNIyDQS24o7/TGkPqC67acOiEkzp1u2p
   mSCvOHg8Lkcl19QZX57Vc47pmAdws1pz/tHdiTq/KGPOBcTYpAp+jNcmx
   Q==;
X-CSE-ConnectionGUID: KGRIKYohQPW4WiVaONZ8Dw==
X-CSE-MsgGUID: myZA0OyZQzaL9Pl/CMrcMQ==
X-IronPort-AV: E=Sophos;i="6.07,164,1708412400"; 
   d="asc'?scan'208";a="18595909"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2024 04:56:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 04:56:16 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 04:56:13 -0700
Date: Fri, 29 Mar 2024 11:55:25 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Alexey Romanov <avromanov@salutedevices.com>
CC: Conor Dooley <conor@kernel.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "clabbe@baylibre.com" <clabbe@baylibre.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "khilman@baylibre.com" <khilman@baylibre.com>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v6 17/23] dt-bindings: crypto: meson: remove clk and
 second interrupt line for GXL
Message-ID: <20240329-dotted-illusive-9f0593805a05@wendy>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
 <20240326153219.2915080-18-avromanov@salutedevices.com>
 <20240326-obscurity-angriness-d7bb48bc9eaa@spud>
 <20240329111424.i2zp2coznqpnibk4@cab-wsm-0029881>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OWDxAKnoP5FbCqUI"
Content-Disposition: inline
In-Reply-To: <20240329111424.i2zp2coznqpnibk4@cab-wsm-0029881>

--OWDxAKnoP5FbCqUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:14:29AM +0000, Alexey Romanov wrote:
> Hi Conor,
>=20
> On Tue, Mar 26, 2024 at 06:09:37PM +0000, Conor Dooley wrote:
> > On Tue, Mar 26, 2024 at 06:32:13PM +0300, Alexey Romanov wrote:
> > > GXL crypto IP uses DMA engine, which doesn't require clk input
> > > and second interrupt line.
> > >=20
> > > Fixes: c4a0457eb858 ("ARM64: dts: amlogic: adds crypto hardware node")
> >=20
> > How does this fix a commit that only modifies a dts? The commit cited
> > here should be a dt-bindings commit.
>=20
> Yep, my bad. Will fix it in next series.
>=20
> >=20
> > However, your commit message says "require" but you do more than remove
> > these as required, you remove them entirely. What am I missing?
>=20
> Crypto HW isn't connected to clk / 2nd interrput line, so we must remove
> them from dt. I will reformulate commit message.

Yeah, please do. Be clear about the hardware not actually having these
things. And hopefully Corentin can chime in as to why he thought it did.


--OWDxAKnoP5FbCqUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgasLQAKCRB4tDGHoIJi
0nngAPsFHgCeAZUB7PIObsvIZP/P+DvGPq/PYOyGwboFETQrjAEAtkASonmxY4qS
yt5TD7EbgaRPDqo9W4bjTUgkIn49Xws=
=MGQH
-----END PGP SIGNATURE-----

--OWDxAKnoP5FbCqUI--

