Return-Path: <linux-kernel+bounces-64141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF27853A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5AA285B55
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C4B605D9;
	Tue, 13 Feb 2024 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF1MFRUo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8531F618;
	Tue, 13 Feb 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851642; cv=none; b=g+6Q5/Y87tC72iWtuFXh+HTlA8ejJ4aYE6GfuOqIpNOsTSIDMAzgZradxYlVXtNazW1y94qATU5KBJfPomg3/TtH9BRTc1PLCeY6Y3YdtzCoQNgGw0Q/D6qc6s82UXoZIaece22Tnm3zNrIFk5VgPc4Zo5DXiN1OiAqzbrvMBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851642; c=relaxed/simple;
	bh=6kiN4wiwZ7wdwYwbdv3uD0MprwgKoWw3N+XaXtyJk2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TguuHeVOEIkERStrBF1aTHTtkEPu3Ta263mUfSMayvykEdBYZ4YYZFS/vpUC0zNVkuD9ap7qgaxahgJGZAChnjvH+D/ERirCyqsmBi68Bw7HHtva6jwx1WInjAWMuWxiRogTTsfHjVNaUoJcKkv/fyOAlbSRED2hHBMDvzl988g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF1MFRUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EF7C433C7;
	Tue, 13 Feb 2024 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707851641;
	bh=6kiN4wiwZ7wdwYwbdv3uD0MprwgKoWw3N+XaXtyJk2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DF1MFRUou46Tj8Yh/v3Tt3bOTRl3z5a288sgY90GPcDH5XaHjs0erCmjmEXjon6HX
	 c2NtVP4v3bLBZbdCYWHtUfsDuZ5mKVASKvr8nuyvaYWXWRWEOiVO5iZnubWbgVJGGk
	 W2a7laXAEc6u5HRan3TmEvFFYQE8EyNs7ArN3qZYrcOlB/J5JoEhbNSGn7gqX6P/ww
	 DuzX7gvhUKY4IOkSEoI5v/Osj5/neF23jDdVI1MVvSxMO/XCc/kYZgzYe0Mm3Wn8OL
	 BDF+HQsJY+QIf0t5j93H1tU/KNqmqOCP0ZrBS+SNx8DLV/fQlp5C+G3IPCbDzYN3/1
	 RNhYk8dRW6Zug==
Date: Tue, 13 Feb 2024 19:13:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma.B@microchip.com
Cc: robh@kernel.org, tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Message-ID: <20240213-estranged-charger-bf0372f367e0@spud>
References: <20240209100122.61335-1-dharma.b@microchip.com>
 <20240212140824.GA107736-robh@kernel.org>
 <003d61c9-b914-4e1c-b3f8-1140ea640039@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DP2O63EPE4l7uJmE"
Content-Disposition: inline
In-Reply-To: <003d61c9-b914-4e1c-b3f8-1140ea640039@microchip.com>


--DP2O63EPE4l7uJmE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 04:23:36AM +0000, Dharma.B@microchip.com wrote:
> On 12/02/24 7:38 pm, Rob Herring wrote:
> > On Fri, Feb 09, 2024 at 03:31:22PM +0530, Dharma Balasubiramani wrote:
> >> +  atmel,external-irqs:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +    description: u32 array of external irqs.
> >=20
> > Constraints on the array size and/or entry values?
>=20
> The hardware's support for external IRQs may differ, which is why a u32=
=20
> array is utilized. This choice is based on the fact that IRQ numbers are=
=20
> commonly expressed as integers, and a 32-bit unsigned integer provides a=
=20
> standardized size capable of representing a broad range of numbers. This=
=20
> size is more than adequate for accommodating IRQ numbering.

I don't think Rob was questioning your use of u32s, but rather the fact
that you do not limit the values at all nor the number of values.

--DP2O63EPE4l7uJmE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcu/dAAKCRB4tDGHoIJi
0hRGAQDFmS0WZOIhtx+CxVE2or6F0Xb2Sy0lXRItnm9EtBauHgD+J50w1UOrdUOX
LsiY0HyUU5V9F0jwzQmdiaR/ntTSfAY=
=eCUq
-----END PGP SIGNATURE-----

--DP2O63EPE4l7uJmE--

