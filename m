Return-Path: <linux-kernel+bounces-87285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774AA86D233
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70FDB2735C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96151134431;
	Thu, 29 Feb 2024 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFrtT96X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366C2A8D7;
	Thu, 29 Feb 2024 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231175; cv=none; b=rk36zvD4PgzKsW/vwXWKhPILXNGUhiNTqzF32U+zrDxlkBM8zP+KMp6l04HhM07J6UrkXb0pke6hkGsQFwss6iQoHpR6K2jghFOrciyP3gqvDFT4dmuD/VRJXAqvpLgC/wdw0eXEEMYkNn7LVcANyjf8aJv9ZUj+mjfeBUa0OZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231175; c=relaxed/simple;
	bh=Vgq4hnQMw27GH6PkaZfA5dT6KlUr9HO4n6N8lO1OUZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Og/HNEkguYqOl+YE/JfDvWNMwH5EszwXxEvgN9hOi805d46qFrSaFubWfm12zUNQ/44Z4yvr+nDDbP7zZjsNen0kvpXMu55m++SLS4wZlOORNyKkWHxotGl9qgMTNRXQmLTzEKESSTXtmglCe1RR6y51x5xz6fMXJMw7YuaYQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFrtT96X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C1DC433F1;
	Thu, 29 Feb 2024 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709231175;
	bh=Vgq4hnQMw27GH6PkaZfA5dT6KlUr9HO4n6N8lO1OUZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFrtT96Xq64H+T6w/LgvmGQcoep03LjgB30PBEddTKmTqkdMUU2vRqeODlsoNU9lJ
	 KAOLtXcJW6sqkjVJ6iGi5/U3whxLZpxfvHZV96TcS7EUqoQn53KTCW83bibg2mSXU9
	 kZ8vLNptyVMM25I29+7bMbkO06IThF02QLUjr824P7ibSitzCWzbKRBEQmdCOJBFFs
	 Sdp6jiww/LXGOogKQcsZUcNT+Zn2HJaA4FSSTvxE9keuvto74s7rFM0nofqEd+4t8H
	 S0yXl3wGjNlViVie5Ml0fcVYTqJGUgi96C3a75HCe1+6VsHKwKZlc5N13NkNuCaZ91
	 q5HFNa7Cpf8jA==
Date: Thu, 29 Feb 2024 18:26:09 +0000
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
Message-ID: <20240229-champion-vengeful-4612cee0d678@spud>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172559.672142-1-varshini.rajendran@microchip.com>
 <20240224-kimono-stress-898eae80abd3@spud>
 <b49572d4-b52e-4655-8d10-2709e2fbe803@microchip.com>
 <20240228-capital-nickname-696dfcd655de@spud>
 <16e37a0e-74d0-4632-b0a2-403f74a3a379@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="27icH3WNe5d1kQpd"
Content-Disposition: inline
In-Reply-To: <16e37a0e-74d0-4632-b0a2-403f74a3a379@microchip.com>


--27icH3WNe5d1kQpd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 08:55:11AM +0000, Varshini.Rajendran@microchip.com =
wrote:
> Hi Conor,
>=20
> On 28/02/24 5:19 pm, Conor Dooley wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> > On Wed, Feb 28, 2024 at 07:03:01AM +0000, Varshini.Rajendran@microchip.=
com wrote:
> >> Hi Conor,
> >>
> >> On 25/02/24 1:32 am, Conor Dooley wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> >>> On Fri, Feb 23, 2024 at 10:55:59PM +0530, Varshini Rajendran wrote:
> >>>> Add sam9x7 compatible to DT bindings documentation.
> >>>>
> >>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> >>>> ---
> >>>> Changes in v4:
> >>>> - Fixed the wrong addition of compatible
> >>>> - Added further compatibles that are possible correct (as per DT)
> >>>> ---
> >>>>  .../devicetree/bindings/serial/atmel,at91-usart.yaml | 12 +++++++++=
---
> >>>>  1 file changed, 9 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usa=
rt.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> >>>> index 65cb2e5c5eee..30af537e8e81 100644
> >>>> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> >>>> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> >>>> @@ -23,11 +23,17 @@ properties:
> >>>>            - const: atmel,at91sam9260-dbgu
> >>>>            - const: atmel,at91sam9260-usart
> >>>>        - items:
> >>>> -          - const: microchip,sam9x60-usart
> >>>> +          - enum:
> >>>> +              - microchip,sam9x60-usart
> >>>> +              - microchip,sam9x7-usart
> >>>>            - const: atmel,at91sam9260-usart
> >>>>        - items:
> >>>> -          - const: microchip,sam9x60-dbgu
> >>>> -          - const: microchip,sam9x60-usart
> >>>> +          - enum:
> >>>> +              - microchip,sam9x60-dbgu
> >>>> +              - microchip,sam9x7-dbgu
> >>>
> >>>> +          - enum:
> >>>> +              - microchip,sam9x60-usart
> >>>> +              - microchip,sam9x7-usart
> >>>
> >>> This doesn't make sense - this enum should be a const.
> >>> I don't really understand the idea behind of the original binding her=
e that
> >>> allowed:
> >>> "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam92=
60-dbgu", "atmel,at91sam9260-usart"
> >>>
> >>> Specifically, I don't get the purpose of the "microchip,sam9x60-usart=
".
> >>> Either make it
> >>>       - items:
> >>>           - enum:
> >>>               - microchip,sam9x60-dbgu
> >>>               - microchip,sam9x7-dbgu
> >>>           - const: microchip,sam9x60-usart
> >>>           - const: atmel,at91sam9260-dbgu
> >>>           - const: atmel,at91sam9260-usart
> >>> or add
> >>>       - items:
> >>>           - const: microchip,sam9x60-dbgu
> >>>           - const: atmel,at91sam9260-dbgu
> >>>           - const: atmel,at91sam9260-usart
> >>> or explain exactly why this needs to be
> >>> "chipa-dgbu", "chipa-usart", "chipb-dbgu", "chipb-dbgu"
> >> The compatible has to be "chipa-usart", "chipb-usart", "chipa-dbgu",=
=20
> >> "chipb-dbgu" for the device to work as a debug console over UART
> >> wher the chipa-<periph> is the device specific compatible
> >> and the chipb-<periph> is the fallback compatible that the driver=20
> >> actually uses.
> >=20
> > This examples why you have "microchip,sam9x60-dbgu", "atmel,at91sam9260=
-dbgu"
> > and "atmel,at91sam9260-usart".
> > It does not explain "microchip,sam9x60-usart" though, I don't see what
> > purpose that serves. If used as a debug uart, you fall back to the
> > sam9260 debug uart compatible and if not you fall back to the sam9260
> > usart compatible.
> >=20
> Here, if it is not used as debug uart it has to fallback to the default=
=20
> usart compatible which in this case should have a device specific=20
> compatible too right?
>=20
> The common usart compatible looks as follows,
>=20
>      compatible =3D "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
>=20
> meaning the 1st one is the device specific usart compatible and the 2nd=
=20
> one is the fallback compatible which the driver actually supports.
>=20
> The debug uart looks as follows,
>=20
> compatible =3D "microchip,sam9x60-dbgu", "atmel,at91sam9260-dbgu",=20
> "microchip,sam9x60-usart", "atmel,at91sam9260-usart";

This version here makes a lot more sense than what is currently in use
and what is being added in your original patch. I wouldn't object to
this being used.

> In this case, there is a device specific debug uart compatible, a=20
> fallback tot he debug uart compatible and as you said if not used as a=20
> debug uart it should fallback and work as a normal uart device which has=
=20
> both a device specific compatible and a fallback to work.
>=20
> In case the device specific compatible is supported with some other=20
> features in the driver in the future, the debug uart also should get its=
=20
> perk. Does this make sense?
>=20
>=20
> > In addition, the current setup implies that sam9x60 usart supports all
> > the features that the sam9260 debug usart does. I doubt that that is
> > true.

--27icH3WNe5d1kQpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDMQQAKCRB4tDGHoIJi
0p5MAQDmJ9VKwmndXGtuYADUIRc9WGk25Ny/CCPltwAriEMOYwD+PPAQ6NAoy6jt
WUaQKjRkDFQpmgCzd1Fn+JVDmsW/NgA=
=vhzy
-----END PGP SIGNATURE-----

--27icH3WNe5d1kQpd--

