Return-Path: <linux-kernel+bounces-49878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F93F8470DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554301C2693D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B6732C88;
	Fri,  2 Feb 2024 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jy0ECwWN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8446A1;
	Fri,  2 Feb 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879348; cv=none; b=mE21/MIFprdPMXHoBlfYz4LwJzfyp/mA+gVD8L3M+P2yThyHK/p2dC2Do6T8tfSojTuLv+fHusvG4vbyS8HKgarQdQ5vUi6ZPjfwc5hNJi8fB8jJO2W1qziu1qgmk4wUlcXZVT0/IDoW1xc3XVCFZth2qxNRRKee0RvNVuOvwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879348; c=relaxed/simple;
	bh=rQIYUc5pp3Rz7/dcNH7XPkmrEi1ITVoDRHNWKXuedXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eph7InxdcQKOlkzOVMkqUQFPR5UhefP/D3ycbgHM3zDocb50y+5hkwAwk9740gVc+nWM+0cP5nYX5Elta/g39cHip0egVW0C0nxGcqzTKPgZbB6/lJXKrR5bYRZ9GkInkZ6zC1YnL9nz8Yp0i7acBVwU5zchL8rj/9R8Y8MQkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jy0ECwWN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706879346; x=1738415346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rQIYUc5pp3Rz7/dcNH7XPkmrEi1ITVoDRHNWKXuedXo=;
  b=jy0ECwWNdkA3ZIhLRXIkCY8Cvu2s4zBdNZBCBs/aESvmf4EfA34a/9kT
   6GjNU/y9kgFFhP3CDQZbq/1gE0liF999BWSxleSXD+iw/4+z8K+pzea7i
   vxrUP+7CXcnM5YEnc2Vk7xXCggLVhtPg/zFqhq0uUzFywOnVj5ZBVuxvb
   LsjAYyE69q1Fql74V9l3NX3YPSZ2Inp8aYmQqO7NwR4o9nZpuwu6NqCS3
   98Dq+H0KK/2A66d9kdl5Ic3rhMjecvb4OMWLplJSZdJCAyOOTBQhiWlzY
   z8fUVgcCcUXXla1GLJMKYTAVk5eqrHnPOeIjMVa+tKt2RARqthqYxX7kh
   w==;
X-CSE-ConnectionGUID: YxDka9K6S3205y8iAzi+Sg==
X-CSE-MsgGUID: 2jAMHJV2RTq2Vh02+X84cw==
X-IronPort-AV: E=Sophos;i="6.05,238,1701154800"; 
   d="asc'?scan'208";a="16183861"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2024 06:09:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 06:08:32 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 2 Feb 2024 06:08:30 -0700
Date: Fri, 2 Feb 2024 13:07:51 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Peter Rosin <peda@axentia.se>
CC: Naresh Solanki <naresh.solanki@9elements.com>, Conor Dooley
	<conor@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240202-shone-footwork-b247b1ae8e06@wendy>
References: <20240130115651.457800-1-naresh.solanki@9elements.com>
 <1c855a34-8a0d-491e-bfd2-24635b41c86f@linaro.org>
 <20240131163516.000043df@Huawei.com>
 <20240131-stylized-defile-d8fe346ab197@spud>
 <CABqG17iNxfKFNqydkgo6gL8ZmaZ_bqm=pG8kNEhzx_h2eaGuhQ@mail.gmail.com>
 <e8b30740-379c-9ab0-6bd7-d4726f822381@axentia.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="usQcF2wOq7nJ/0DO"
Content-Disposition: inline
In-Reply-To: <e8b30740-379c-9ab0-6bd7-d4726f822381@axentia.se>

--usQcF2wOq7nJ/0DO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 12:49:26PM +0100, Peter Rosin wrote:
> 2024-02-02 at 11:43, Naresh Solanki wrote:
> > On Wed, 31 Jan 2024 at 22:24, Conor Dooley <conor@kernel.org> wrote:
> >> On Wed, Jan 31, 2024 at 04:35:16PM +0000, Jonathan Cameron wrote:
> >>> On Wed, 31 Jan 2024 09:29:59 +0100
> >>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>>> On 30/01/2024 12:56, Naresh Solanki wrote:
> >>> Conor requested an example of the device acting as a consumer and a p=
rovider.
> >>> Might have meant in the patch description?
> >>>
> >>> Conor?
> >>
> >> I wanted it in the property description to help with understanding when
> >> to use it. I don't think the extra example nodes actually help you
> >> understand what it is doing, only how to write one yourself once you
> >> know you need it.
> >
> > I'm not sure if I get it right but what I understood is that a
> > voltage-divider can
> > also be a provider to other devices & hence the property.
> > Also do you want me to put a complete example of it in description ?
>=20
> My understanding is the requested example in the description should not
> be exactly /how/ to hook up the voltage-divider as a provider, but
> instead have some words about why it is interesting to do so at all. And
> those words would also make it clear that is even possible. The latter
> is something which, to be honest, is perhaps not all that obvious. It
> has always been totally obvious to me of course, sorry for not being
> clearer when I wrote the binding...

Yeah, you're right about what I was looking for Peter.

In my original request, which I think I already linked to in this
thread, I said that I would like an example like the one that Peter had
used to explain to me the scenario in which someone would want to use
this feature:
https://lore.kernel.org/all/536971eb-51f0-40e5-d025-7c4c1d683d49@axentia.se/

Cheers,
Conor.

--usQcF2wOq7nJ/0DO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbzpJwAKCRB4tDGHoIJi
0uBFAQDd15cD8MlFITgRCGGrILqvQfUUTBlUwpZKIBO44nEglwEA4kyJoMeP6ch6
GVduioubFuEAahb5xAJrtGAOnY/jjgU=
=yUBY
-----END PGP SIGNATURE-----

--usQcF2wOq7nJ/0DO--

