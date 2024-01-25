Return-Path: <linux-kernel+bounces-39018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898683C9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399571F2A3AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F640137C4E;
	Thu, 25 Jan 2024 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txkf3O/b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38113173F;
	Thu, 25 Jan 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202901; cv=none; b=asiRPTMshk5PCqoj45SfEjGxqJNJe+SbTlN7qdzgsW6ZY/unm4tmr9OpGKQxAz4ZFQ07pDd9kN8Lv5IMZKKj3F7Q7x5Xz+WngAY8Lztgka6enOnjskFGdWTDbpJT5yIsn/03iWwAfQtKRZkqLgGGftre59TUHAyH5uwMdyn4SVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202901; c=relaxed/simple;
	bh=3dVf+vPXIdsPQhadKBnqSmffUhDAz2vQfQH/Y8KghKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH+e6bjtG2eUB+YcB2SbFZJIGI/CKirqZ15gJ7TbwH/2LljRJXw8hdWEw0kAn49su8BlOTpaLAUpZu7ul7cH5UyEe8c3f8an7lHaPLMhQSAzeIGj1P3mCMViHR2tDSWFI3V3IHvgwEqDk7/K4HC7pJ3q+I+CG3/GJGtZSoAUBEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txkf3O/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB71C433C7;
	Thu, 25 Jan 2024 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706202901;
	bh=3dVf+vPXIdsPQhadKBnqSmffUhDAz2vQfQH/Y8KghKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Txkf3O/bU+w3xpkbVkgMMl8QUXBKPsrBmaVGJ73PJStKMIRdZZqS1btShnlKYSe4B
	 3tWxt+neitpkeD6DPTmPIUV6ZB93graF8xd+2W1FuoHqZVfe3h0vR4YjO2jucAzK5y
	 2apRC9G275s0VAckQ1rnOTKJLj8fI2J5p5OR32uU3NdIO0LvfNUgaLt0gBUvnsSowf
	 plXpjO3La7ab9VYy8UASERjMOsLZ1L1jr8FdGdOFn5MP6r47IiDue4UFNF7/j8k4Zx
	 ImdM51iNoWJfm+COzc+RPfgZT6UUCi5JAPHOGVraofBaXE5VDj5vhVyLzUjZFsjSlY
	 S2yjAiaTH/QFA==
Date: Thu, 25 Jan 2024 17:14:55 +0000
From: Conor Dooley <conor@kernel.org>
To: esben@geanix.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: net: snps,dwmac: Add
 time-based-scheduling property
Message-ID: <20240125-pebble-reproach-f550d00a2abb@spud>
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
 <30ce8f45b8752c603acc861ebb2f18d74d2f8a07.1706105494.git.esben@geanix.com>
 <20240124-reptilian-icing-a95b20f123be@spud>
 <87bk99hj7q.fsf@geanix.com>
 <3adf7908-be27-4125-ae5b-6f2eb6100304@linaro.org>
 <877cjxhbkv.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AsbEPBmbmpQjmWgj"
Content-Disposition: inline
In-Reply-To: <877cjxhbkv.fsf@geanix.com>


--AsbEPBmbmpQjmWgj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:55:12PM +0100, esben@geanix.com wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
>=20
> > On 25/01/2024 10:10, esben@geanix.com wrote:
> >> Conor Dooley <conor@kernel.org> writes:
> >>=20
> >>> On Wed, Jan 24, 2024 at 03:33:06PM +0100, Esben Haabendal wrote:
> >>>> Time Based Scheduling can be enabled per TX queue, if supported by t=
he
> >>>> controller.
> >>>
> >>> If time based scheduling is not supported by the controller, then the
> >>> property should not be present! The presence of a property like this
> >>> should mean that the feature is supported, using it is up to the
> >>> operating system.
> >>>
> >>> That said, why is this a property that should be in DT?
> >>=20
> >> It is added to the tx-queues-config object of snps,dwmac bindings. This
> >> entire object is about configuration of the ethernet controller, which
> >> is also what the purpose of the snps,time-based-scheduling.
> >> So yes, it is not specifically about describing what the hardware is
> >> capable of, but how the hardware is configured. It is a continuation of
> >> the current driver design.
> >>=20
> >>> If support is per controller is it not sufficient to use the
> >>> compatible to determine if this is supported?
> >>=20
> >> Are you suggesting to include the mapping from all supported compatible
> >> controllers to which TX queues supports TBS in the driver code?  What
> >> would the benefit of that compared to describing it explicitly in the
> >> binding?
> >
> > The benefit is complying with DT bindings rules, saying that bindings
> > describe hardware pieces, not drivers.
>=20
> Understood.
>=20
> >> And for the purpose of the above question, I am talking about it as if
> >> the binding was describing the hardware capability and not the
> >> configuration.
> >
> > "if"? You wrote it is for driver design...
>=20
> If you look at the current driver, all the devicetree bindings under
> rx-queues-config and tx-queues-config are violating the DT binding
> rules.
> Cleaning up that requires quite some work and I guess will break
> backwards compatibility to some extend.

Let bygones be bygones. If something undesirable got in previously,
breaking backwards compatibility there is not justified IMO.

--AsbEPBmbmpQjmWgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKXDwAKCRB4tDGHoIJi
0mZmAP9R7uQLuENcaLcze3yAlLCBg7nWplWJaCgWwS4IRXlV9gEAjX3MUDAdIDcP
ALEQkpPnRg6hiT9y1JmMSKxla8Uclwg=
=Q2qx
-----END PGP SIGNATURE-----

--AsbEPBmbmpQjmWgj--

