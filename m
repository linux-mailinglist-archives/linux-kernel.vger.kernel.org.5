Return-Path: <linux-kernel+bounces-84973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FA86AE58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149141F21096
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD213175A;
	Wed, 28 Feb 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT1b+VhH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA96CDDB;
	Wed, 28 Feb 2024 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120988; cv=none; b=WiDj5k/jwWqVIa1q54yl5vHznpNLKmPDo8I4SbxKJdactHzB08OaiSI1sxGb7CcbZ7nUnpqhOHMLL9fe9s4z3/QnuzhuDQ43PsjI1+u9Rau+Mx7Y7IHdHYLV7hy/knaPE1TsdJigVLI9qDsqkTk7z2u3S6HP7d36bxUrkAfxO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120988; c=relaxed/simple;
	bh=P9ZISTEIn48zfYIAKIiJExn1v/AewX92la45i1qfzqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX+rT2HMWMN8o/qerAByoAVmKXh4wbw/izU20WpTzsZfhfFDbLRkBhc6PHCPomSBu0zRbSEES2Q0JJrtUBCxqIGFx1DMHSS4nYj/yaNVZ2TLoYdeyo+4PKCxw7waSxzyVXyXHepUi4zTw4DpJeFc/vxsITfP0jxYZPAB1EikPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT1b+VhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B28DC43390;
	Wed, 28 Feb 2024 11:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709120988;
	bh=P9ZISTEIn48zfYIAKIiJExn1v/AewX92la45i1qfzqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oT1b+VhHCgNS1MYbgUqUjxaRVhmDlzO5LGCIfTZnL/gzArI8T1kcpggoCKQLe4qf9
	 t+RZKJmYHXWCBRitnM2n9NHkT9J1g2nqB1ChsYTQjqpFv1pKSyd1ASVHYSeQ1a0j/E
	 qolNNFIUzHucLZW2jCYRNz5txSYxeDzbqtllXVzeOp8YatYAAdvsTxI7R1Q21NljLW
	 2mbXenNlwK7wIsf943XGUqMrgA27breU1aNvMmjNeNmDidZiNXzH77uA+eZasLWDnB
	 afT+LHlvke2A6BycMxuqPUyTzJ58vxykPHl1/20qaR3Whep+bDYuhkIB65M3SIDnhy
	 jHLEUEl+lN4IQ==
Date: Wed, 28 Feb 2024 11:49:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Varshini.Rajendran@microchip.com
Cc: radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 12/39] dt-bindings: serial: atmel,at91-usart: add
 compatible for sam9x7.
Message-ID: <20240228-capital-nickname-696dfcd655de@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172559.672142-1-varshini.rajendran@microchip.com>
 <20240224-kimono-stress-898eae80abd3@spud>
 <b49572d4-b52e-4655-8d10-2709e2fbe803@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="naR5QLUVU6sxm80i"
Content-Disposition: inline
In-Reply-To: <b49572d4-b52e-4655-8d10-2709e2fbe803@microchip.com>


--naR5QLUVU6sxm80i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 07:03:01AM +0000, Varshini.Rajendran@microchip.com =
wrote:
> Hi Conor,
>=20
> On 25/02/24 1:32 am, Conor Dooley wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> > On Fri, Feb 23, 2024 at 10:55:59PM +0530, Varshini Rajendran wrote:
> >> Add sam9x7 compatible to DT bindings documentation.
> >>
> >> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> >> ---
> >> Changes in v4:
> >> - Fixed the wrong addition of compatible
> >> - Added further compatibles that are possible correct (as per DT)
> >> ---
> >>  .../devicetree/bindings/serial/atmel,at91-usart.yaml | 12 +++++++++---
> >>  1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart=
=2Eyaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> >> index 65cb2e5c5eee..30af537e8e81 100644
> >> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> >> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> >> @@ -23,11 +23,17 @@ properties:
> >>            - const: atmel,at91sam9260-dbgu
> >>            - const: atmel,at91sam9260-usart
> >>        - items:
> >> -          - const: microchip,sam9x60-usart
> >> +          - enum:
> >> +              - microchip,sam9x60-usart
> >> +              - microchip,sam9x7-usart
> >>            - const: atmel,at91sam9260-usart
> >>        - items:
> >> -          - const: microchip,sam9x60-dbgu
> >> -          - const: microchip,sam9x60-usart
> >> +          - enum:
> >> +              - microchip,sam9x60-dbgu
> >> +              - microchip,sam9x7-dbgu
> >=20
> >> +          - enum:
> >> +              - microchip,sam9x60-usart
> >> +              - microchip,sam9x7-usart
> >=20
> > This doesn't make sense - this enum should be a const.
> > I don't really understand the idea behind of the original binding here =
that
> > allowed:
> > "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260=
-dbgu", "atmel,at91sam9260-usart"
> >=20
> > Specifically, I don't get the purpose of the "microchip,sam9x60-usart".
> > Either make it
> >       - items:
> >           - enum:
> >               - microchip,sam9x60-dbgu
> >               - microchip,sam9x7-dbgu
> >           - const: microchip,sam9x60-usart
> >           - const: atmel,at91sam9260-dbgu
> >           - const: atmel,at91sam9260-usart
> > or add
> >       - items:
> >           - const: microchip,sam9x60-dbgu
> >           - const: atmel,at91sam9260-dbgu
> >           - const: atmel,at91sam9260-usart
> > or explain exactly why this needs to be
> > "chipa-dgbu", "chipa-usart", "chipb-dbgu", "chipb-dbgu"
> The compatible has to be "chipa-usart", "chipb-usart", "chipa-dbgu",=20
> "chipb-dbgu" for the device to work as a debug console over UART
> wher the chipa-<periph> is the device specific compatible
> and the chipb-<periph> is the fallback compatible that the driver=20
> actually uses.

This examples why you have "microchip,sam9x60-dbgu", "atmel,at91sam9260-dbg=
u"
and "atmel,at91sam9260-usart".
It does not explain "microchip,sam9x60-usart" though, I don't see what
purpose that serves. If used as a debug uart, you fall back to the
sam9260 debug uart compatible and if not you fall back to the sam9260
usart compatible.

In addition, the current setup implies that sam9x60 usart supports all
the features that the sam9260 debug usart does. I doubt that that is
true.

Thanks,
Conor.

--naR5QLUVU6sxm80i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8d1gAKCRB4tDGHoIJi
0jU8AQDfAMBhvlKIn3K9UK4JvgmYK7R9RtnCCLD4gz08rgwRgAEApDdb5EYy1wap
lFgNHMX2Z4M+6mlS9jnCV+apFqxAgAM=
=s5+L
-----END PGP SIGNATURE-----

--naR5QLUVU6sxm80i--

