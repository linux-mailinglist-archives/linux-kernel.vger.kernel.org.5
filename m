Return-Path: <linux-kernel+bounces-49618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C81846D44
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C930DB2A1ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8C77F1C;
	Fri,  2 Feb 2024 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bmDGsdPX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776B487A7;
	Fri,  2 Feb 2024 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867682; cv=none; b=m/jY02O53l2VENSwxUT6dopU+n7dlMz1IbBV8kCX7RdhEH/WdxTeh2vOxClo8qplyuRpHS2rTMocXFlYyOkXUpPldfHPOBG84kKwCUXPZnN+Qgu21YwJ+D0yYOdhTzb7nZK/dNhp4PeqIYvPKQ3bQg7JwOq0a+lOjuCmvCaUsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867682; c=relaxed/simple;
	bh=HLdAtsTxbl4fEyp+8gS0jl/pp8gu2Z4JAGbawefcu48=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN+7dOqhgeqB3m9GQ9AOB3JSv6VGQkrpuU3QC0iZPTgtuERQAMYNiP/HiGmUg00SK6AFXlSZZ94SKipslMYJ/VmFDkXBqv6xXxxIJnMYzwY85N9NFG8dvjO8vokeJrqkf49zuBSpsHnP8zMgYhe3Clw+imxPDcIOrvQIwIRo4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bmDGsdPX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706867679; x=1738403679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HLdAtsTxbl4fEyp+8gS0jl/pp8gu2Z4JAGbawefcu48=;
  b=bmDGsdPXg2fPqrLj4hWG/CxXMVVgrXyuinAJRbviU6RFsjD+IKPtTtYL
   b9v8JZAU8faDTdcZDEhZryqhZmFrErXLIRcnaTEnycw85Zj/5YkTQyU7Q
   mO91E8twisvshiv4UuIvA/xSl+w+jWI5lS0c8/VBxW2PrQjLB4rrhxqQa
   GioXgsA+bSVayH5TPV+Fx97di1VuW3mYvHf8rmBHq51Vx3hGAbX4dJqj4
   1yBVPyEmZLh4QEhVZoRuo5e9wlV+IORVQ/4yv4/dBMwec1W9hsN1QUFLC
   4Yk1OPUAWL1gi6PztfT7a90w1XU1OEgCO9SNDSj8583qvSnibLwv8nCse
   A==;
X-CSE-ConnectionGUID: /ifdK88ERii550o6UWvHNg==
X-CSE-MsgGUID: aAm2nhaDT8m6OZg3lj+5xw==
X-IronPort-AV: E=Sophos;i="6.05,237,1701154800"; 
   d="asc'?scan'208";a="182925598"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2024 02:54:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 02:53:52 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 2 Feb 2024 02:53:49 -0700
Date: Fri, 2 Feb 2024 09:53:11 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Conor Dooley <conor@kernel.org>, Bin Liu <b-liu@ti.com>, <nm@ti.com>,
	<vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <srk@ti.com>,
	<r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Message-ID: <20240202-unzip-whacky-bb2f151c618b@wendy>
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-5-rogerq@kernel.org>
 <20240201-viewpoint-upload-fb714f650ff5@spud>
 <20240201-violet-chalice-51a73f113e7b@spud>
 <20240201183522.ssj553rwefr2wuqi@iaqt7>
 <20240201-clad-unopposed-ccfdfe53b770@spud>
 <bc3ab60f-539b-41d0-8595-6e0b55f2763d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="09bQoPjxvThdjUNR"
Content-Disposition: inline
In-Reply-To: <bc3ab60f-539b-41d0-8595-6e0b55f2763d@kernel.org>

--09bQoPjxvThdjUNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 11:36:55AM +0200, Roger Quadros wrote:
>=20
>=20
> On 01/02/2024 21:13, Conor Dooley wrote:
> > On Thu, Feb 01, 2024 at 12:35:22PM -0600, Bin Liu wrote:
> >> On Thu, Feb 01, 2024 at 06:18:05PM +0000, Conor Dooley wrote:
> >>> On Thu, Feb 01, 2024 at 06:15:20PM +0000, Conor Dooley wrote:
> >>>> On Thu, Feb 01, 2024 at 02:03:31PM +0200, Roger Quadros wrote:
> >>>>> So far this was not required but due to the newly identified
> >>>>> Errata i2409 [1] we need to poke this register space.
> >>>>>
> >>>>> [1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
> >>>>>
> >>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >>>>
> >>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >>>
> >>> Actually, where is the user for this that actually pokes the register
> >>> space?
>=20
> https://lore.kernel.org/all/20240201121220.5523-5-rogerq@kernel.org/
>=20
> >>> You're adding another register region, so I went to check how you were
> >>> handling that in drivers, but there's no driver patch.
> >>
> >> See Roger's another patch set 'Add workaround for Errata i2409' posted
> >> on 16th.
> >=20
> > This patch should be with that series, not with these dts patches.
> >=20
>=20
> Why not? There should be no dependency between DTS and driver implementat=
ion.
>=20
> As DTS and driver will be merged by separate maintainers I thought it
> would be easier for maintainers this way.

dts and driver might be merged by different people, but dt-bindings and
drivers are merged by the same people. This is a bindings patch, not a
dts patch. Look at what get_maintainer says for this file:
	Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
	Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED D=
EVICE TREE BINDINGS)
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN F=
IRMWARE AND FLATTENED DEVICE TREE BINDINGS)
	Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED=
 DEVICE TREE BINDINGS)
	Aswath Govindraju <a-govindraju@ti.com> (in file)
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE T=
REE BINDINGS)
	linux-kernel@vger.kernel.org (open list)
Greg and linux-usb are on there, but you have not CCed them.

Being with the driver also allows bindings maintainers to check that you
don't break backwards compatibility. It also prevents me having to ask
for the driver patch, then be given just a subject line that I have to
go and look up myself!

Thanks,
Conor.


--09bQoPjxvThdjUNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZby7hgAKCRB4tDGHoIJi
0lZNAQDfnUDAjmRAZ9RFirPTEdFAI3fOleBFWcr1Z3YYeNtPUwEA9Zdsa1/GJnq1
Vr1bHu3HSNYVpAUxksp5F4oVbySSUgM=
=eVOE
-----END PGP SIGNATURE-----

--09bQoPjxvThdjUNR--

