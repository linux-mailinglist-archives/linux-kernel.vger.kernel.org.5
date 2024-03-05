Return-Path: <linux-kernel+bounces-92805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEEE872630
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECEF1C23821
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE9C18EB3;
	Tue,  5 Mar 2024 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="UX6+wXCy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="da+EPSJG"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6718EA2;
	Tue,  5 Mar 2024 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661865; cv=none; b=UVOlbHVbDWA1S0GvcU8lTjHG0Bel52/TbGcFr/zPdIlLcp8uUIf90ivv8LHt/e4l1lJXSWMIXPKEw90qY8bFrQdfvZ/f0uBW/jIqI5yT/fOghq7AAQHyfJZbCnRq1RC+witBILOKOC9HvQ9R+z/crYIhwVoe3Uc+mq/p5+tUeJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661865; c=relaxed/simple;
	bh=CzoUQeUuD/Op4J/bIDyyH8d27EUxkN3m+tfcHhz4KTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbXXacpNJDJpfAFQepFIA9Bb+JRRTwBnxpMI39PB6/TeHd0z55AIOdOd7Tm4r+s0PDm8IBW9NO0NNZpNASF7gD6247raFr13Xr90NfOxx486ogdhmV1DPtrJbsPGsgJnKWp15TqNVGwyE6133I/LuRiW+xddT7IL1TIKlsfdyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=UX6+wXCy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=da+EPSJG; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 212DB18000C2;
	Tue,  5 Mar 2024 13:04:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 05 Mar 2024 13:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709661861;
	 x=1709748261; bh=oJ89TjWV3yERdS8ie8KDxuv0wN9Nxj1Idl407UIe0hY=; b=
	UX6+wXCyZgBfan+tiWIpzBz+pvCq2lZN6iT9Z87C13u6N26sZoeSxnONc7Zf0yyi
	daxVe0o3UopEDWaWpjNeXEFYBQCXW0mRYxEJQfwMP0Fnsq+Ug3Up2Re/kRduxnjp
	7X3PkT0vTUMQqBej4OTZ/YsT4aPGN64QEU24r6yxuMLdrkUjFThAzZVibLZQaFyQ
	8yK+xCjEB9g5ASQTJfYweECGBSMO+9t14mxZHIz2PYVHreViDONTnPJ3X5pSV0Hn
	cmMimkAH5pJI7zTunPndg89mmJEWI3Y4DDZEOrzQBmCaXUot9givnZJ0eTKz2f28
	zpxumfNs3aJEaCvGniknPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709661861; x=1709748261; bh=oJ89TjWV3yERdS8ie8KDxuv0wN9N
	xj1Idl407UIe0hY=; b=da+EPSJG5b9L2XMcD4+uIitqJst5ZjGiI41WKSjNrV8Q
	N8Gpp4OvgzWm5yrNwwgJVLDzqsqt8MD8h1bsJLYZCCPuZ4UqScZH8N6Ix35sNsMP
	y3Fo667ZgB8CN5v4tq7ReNNwBzgapDqxx0jmhnlQBpU6Ii6t7AEpLvBn+rP+IXaO
	MKVNT8xtd0ACJEaZ3ynLbEzA7N/deNAvf+jdoxDQ0ltrUR7PH8erjxy91CvTpnIe
	VSwMWZGvHdGg8JpOxt9zOy0AF1aJZ/EnNoDz5K+nmaeUfYoDhfTNPn3oeak2wHLM
	khwy9ssym4YzEL2ffkoDmhflO/m9wClF9fa9FC1B1g==
X-ME-Sender: <xms:pV7nZRuMSQtIl0PczRH4I2zhK3iS8aStvc05xtiUan7bLNrtmOaxFQ>
    <xme:pV7nZacFC70dexq4M9wW4lXV-jKPn0hTbzVJaimyYU-Lni5GRiQy2p6X7_bFfgYUj
    1vPCDUP6u2lwBE>
X-ME-Received: <xmr:pV7nZUzKGWTde2ggxcnsWcd08b_1lYMf-zcaz_pfGrFzRlPRt0B12Dup9Nmrxqe1is-O6DzaaWx7MchYsC2mJ-XS5D-_PUKsuqUe1dVUT1fI4YFf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:pV7nZYPWrnXxf_RQCTcWZVh4P9kf1OhLUL4wHxDt1bXRlVjOAgeLQQ>
    <xmx:pV7nZR_MMscUfmwySVA-h-0C_Jrk1t3ZOwXbf1LACQy9LfIZN0XGAA>
    <xmx:pV7nZYVffwPhCHvQbc2GbEqu5BH9wDCzkfGMw1RC3qZ-YtWgUc7lOw>
    <xmx:pV7nZdbn79XA8CEDP7VzPtXbXacmnzHJLNEa7Px2Tm4rB-xffzy8MXehdL4>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 13:04:20 -0500 (EST)
Date: Tue, 5 Mar 2024 13:03:40 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices
Message-ID: <Zedeo6_4ZwuHiT3T@itl-email>
References: <ZeYov0k8njwcZzGX@itl-email>
 <2024030406-kilogram-raving-33c5@gregkh>
 <ZeZPLX6z5pyn2Eh_@mail-itl>
 <ZeZetkR-i1bCDr9v@mail-itl>
 <a95c7e71-a720-49ba-b503-6f20a86be38e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WuauqmvHY1lzItxJ"
Content-Disposition: inline
In-Reply-To: <a95c7e71-a720-49ba-b503-6f20a86be38e@rowland.harvard.edu>


--WuauqmvHY1lzItxJ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 Mar 2024 13:03:40 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices

On Mon, Mar 04, 2024 at 10:19:24PM -0500, Alan Stern wrote:
> On Tue, Mar 05, 2024 at 12:52:22AM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > On Mon, Mar 04, 2024 at 11:46:04PM +0100, Marek Marczykowski-G=C3=B3rec=
ki wrote:
> > > Terminology:
> > > 1. sys-usb - a VM where USB controller (a PCI device) lives; here
> > > usbip-host is attached to the device
> > > 2. testvm - target VM where usbip is connected; here vhci-hcd is used
> > > 3. qvm-usb - tool that connects the above two (equivalent of
> > > userspace part of standard usbip)
> > >=20
> > > Specific steps:
> > > 1. Connect android phone - at this point it's only in sys-usb
> > > 2. Switch its mode to file transfer - observe reconnect in sys-usb
> > > 3. Use qvm-usb to attach it to the testvm
> > > 4. Call jmtpfs -d /mnt in testvm
> >=20
> > Or maybe reset or something is involved here too?
> >=20
> > After using qvm-usb to attach _and detach_ the device, it stays bound to
> > usbip-host driver (that's intentional). But then, even after re-binding
> > back to the "usb" driver, jmtpfs called in sys-usb directly fails the
> > same way, including failure to reset.
> >=20
> > In fact, even without usbip involved at all, jmtpfs directly in sys-usb
> > works only once. The second attempt (without either physically reconnec=
ting
> > the phone, or changing its more to "no data transfer" and back to "file
> > transfer") fails the same way. After terminating the first instance, I
> > see just this logged:
> >=20
> >     [921332.525210] usb 2-1: reset high-speed USB device number 22 usin=
g xhci_hcd
>=20
> If something doesn't work when usbip isn't involved, you definitely=20
> shouldn't expect it to work when usbip _is_ involved.

With usbip, jmtpfs fails the _first_ time, instead of only the _second_
time.  This might be related: maybe the attachment of usbip acts like
the first attach?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--WuauqmvHY1lzItxJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmXnXqIACgkQsoi1X/+c
IsEpUBAA127He3YTnKqeYWZB6BxzbpxCSINki6Do6SVOuC/ndGalKTj0bbDdwvDp
jNjDudUSCdqqF8J30g9Ey4IEMtmbncLW0MJrOq9lErLdvu7W39w8DWANwdhtex43
IeayIECk6A9IV8M0aJOp6RDXHyxDBDMqkCfLPYQZkczIxAHd5Wvg2Nav0w4C2QBp
lwNWrQ2OaieLgYkYCwsziUu6JF94KyvvEguQqRlR3uSEdvb/JSbeVKladc3FZZ6s
uFM1qdILr21unwQ8OC/CxfN4e8ZIcoOfRfBddPJPl7EsaPG+rI4ydgCEmCXxEUXS
b+80iYTpCcCq+8FIcLjuFT4isaxxy5rllF+Jc21eMXTVXqOWvcjd9lY2wPwbp2mp
Za1QbjyXyI/csuEUIOeBWRl4TXZYPQCBGebyHAxjw/JEicmdcc+YiLI4+lsFUDJ9
rjkAF8nMcqrQtVD+bXUnGaURmd2nHvxNdWRX5BAV2+DX4GMSSl+0ihh/Gx+fDGpZ
bmdRraVID6vtqM0GfzfS5b+rAMBRrhItbgH+UobxoGfhf22yBmUfIXR1kUx/YYia
FZ9x6svH37F/6czpwpdKJFQHrrPO7wQYNsEhQMMJHEaqSvC6fhBK2mCxKtyIodmA
b4ugE/zCnk+LLlloDMui4jlmYhOycnhccuyr0daRquzduKKo+bc=
=x6n7
-----END PGP SIGNATURE-----

--WuauqmvHY1lzItxJ--

