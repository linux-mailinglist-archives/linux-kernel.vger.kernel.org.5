Return-Path: <linux-kernel+bounces-91430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92109871166
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592181C21266
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A910E4;
	Tue,  5 Mar 2024 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="fJRbLuvo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjJFxM/S"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676E170;
	Tue,  5 Mar 2024 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597175; cv=none; b=DSa7lxkZK0SOrJJYTD8xYI2j/uoX9F31/NJdy4ox89F+ce/iIc3FVXyXR3fNwexABhoXEOWeRohfr0tk3cVHKv9N/hsgc3Jg8KVM6DLVfwwTJEJp6bDcEt38rhGqaP36lVZ/cgMfItLL9apULeZQVNTxtGKt2lYiAAQVZQzj3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597175; c=relaxed/simple;
	bh=xy0DKsbL1mxHGPHqVXkZTZLFPMhAn0bVE/lPTzzgahs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YY6NTv0mzNAmoktVKucWpcZ8RqS9RZfJ6jTuUH3osTr7ZgK/BFd1gbm6z9ATDKoEfRkKy3/i0DwFzPww3J9FhGdYQ6x1YysG66HEyRcHUGZ/LiOMgQEZ5b3mpzsbzlOsZus6AXRmL2u9yRkmvdjsR+4BEw3/vD5XVinRkrxdpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=fJRbLuvo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjJFxM/S; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 29C5D1380128;
	Mon,  4 Mar 2024 19:06:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 04 Mar 2024 19:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709597173;
	 x=1709683573; bh=76HwTu7VSwj0HV1HESu28MaCZgJwvwg1f5TiI/QjiJI=; b=
	fJRbLuvoy/dGeeqcWcXrEf3AfkphSvjgqgr4Ncge1q5klnBZfmQiyaaQPQKBy8Fc
	L3NngxlQThfbt5fBYzhz9cCIF5cnkOBm5iBET2Mh2ZCbqolRUKMW1qASVlmhdHyk
	xblRFreQoUtDMQYWsPdmpYotV4O6xgEKigaVwTmg33s4EkXo/mhX1yoLP9mU+dXy
	v7RT6mICTvHc43sZlso4IEMcMeZsXeaqmCK8ljpk2FlaokbUzc0At9Y98SeY3/Z6
	Cb7H7ZFjxtMUGee9hZF69jbgr0NJig6djj7fr4AAUI2qqjUMpliOiQOBMFj3PIg0
	6e9mUMgeO6db3sOuilJvoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709597173; x=1709683573; bh=76HwTu7VSwj0HV1HESu28MaCZgJw
	vwg1f5TiI/QjiJI=; b=QjJFxM/SBi+8mds0TSMxqOlVOfjLab+Sl99Nz0wQXMUc
	a4u9UoMOIeJoEb8AUU77ZFyN7uidDTQVA9iv/nMraqj52rqkigqt7DVj/4npGh1F
	2ThuRYK9PZ3nHP5FbLsXREbCOgUzaLGTAiHAk3ehDuYZBeOHe2y+XDFsREu7QxxF
	NRxWWp75x5cAwymEZtN1rxUxRW0SnYWgUH4WWxyu8Y8LxZRfEVJb4TbxS2+Ws2Mf
	3vamX9IGWyrTQk3X6B3Rl154AGtqkpU7No5wfzMPBibB73VkhoXUMxlo7Ial7Zkr
	7cJ38zzjf2f84fwcEMcZrudgr9Ap/V+h60EmjXn1lA==
X-ME-Sender: <xms:9GHmZf5GWcOgjrx6uekZ-0WK2AfKiJV44eBUCQ8OmWvzfyaxMLio-g>
    <xme:9GHmZU6K6WDtvRSH_EPodyRIQzaGsYBpfaaoOun6-YGtaNKQ0RLsBt5SbVdmkrfSY
    q8SURyegzMTDa8>
X-ME-Received: <xmr:9GHmZWdP-jCQIinQwI0WKZ3jAheNHukV3ee_nlQGCFh4het_CP-Ov17UITvkWIX_FrQmN7Q9OsJPLRgfe_4f9z1qBwpQFqF-wkpahTLOQXQrZtuq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffegfffg
    uddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:9WHmZQLFwYexuxGj2f0e81I5oTonbIPTRG1XjyLXQbtKzcMR6ZAiYg>
    <xmx:9WHmZTJynHr5xMjtDqwcfxoXqTG53vvV91o_EHkQnLn5hgY_OEgTPA>
    <xmx:9WHmZZwnNOZH0mYgYQ_d3a5YLjh-SMl3kLhw6B3I-8XpUp7qdigyZA>
    <xmx:9WHmZb1kh5SBSi9XMXZaCbmbyLYSl9R10y0YEh3H8E31p8IGEG8wNA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 19:06:12 -0500 (EST)
Date: Mon, 4 Mar 2024 19:06:08 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices
Message-ID: <ZeZh82gIm2xo_UFM@itl-email>
References: <ZeYov0k8njwcZzGX@itl-email>
 <2024030406-kilogram-raving-33c5@gregkh>
 <ZeZPLX6z5pyn2Eh_@mail-itl>
 <ZeZetkR-i1bCDr9v@mail-itl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x028aD6FFihtxBuF"
Content-Disposition: inline
In-Reply-To: <ZeZetkR-i1bCDr9v@mail-itl>


--x028aD6FFihtxBuF
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Mar 2024 19:06:08 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices

On Tue, Mar 05, 2024 at 12:52:22AM +0100, Marek Marczykowski-G=C3=B3recki w=
rote:
> On Mon, Mar 04, 2024 at 11:46:04PM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > On Mon, Mar 04, 2024 at 09:04:00PM +0000, Greg KH wrote:
> > > On Mon, Mar 04, 2024 at 03:01:51PM -0500, Demi Marie Obenour wrote:
> > > > Qubes OS users are reporting that MTP doesn't work with USB passthr=
ough.
> > > > Fastboot (used for flashing a custom OS to an Android device) also
> > > > doesn't work.  Kernel-mode drivers, such as Bluetooth and USB stora=
ge,
> > > > seem to usually work as expected.  Since MTP and fastboot are both
> > > > implemented in userspace, it appears that there is some problem wit=
h the
> > > > interaction of usbip, our USB proxy (which is based on USBIP), and
> > > > userspace programs that interact with USB devices directly.
> > > >=20
> > > > The bug report can be found at [1] and the source code for the USB =
proxy
> > > > can be found at [2].  The script used on the sending side (the one =
with
> > > > the physical USB controller) is at [3] and the script used by the
> > > > receiving side (the one the device is attached to) is at [4].  All =
of
> > > > these links are for the current version as of this email being sent=
, so
> > > > that anyone looking at this email in the future doesn't get confuse=
d.
> > > >=20
> > > > Is this a bug in usbip, or is this due to usbip being used incorrec=
tly?
> > >=20
> > > I'm amazed that usbip works with usbfs at all, I didn't think that wa=
s a
> > > thing.
> > >=20
> > > If you have a reproducer, or some error messages somewhere, that might
> > > be the easiest way forward.  In reading the bug report, it looks like
> > > the "bridge" you all made can't handle the device disconnecting itself
> > > properly?  But that's just a guess, could be anything.
> >=20
> > Device disconnecting itself indeed is an issue (our proxy doesn't
> > automatically reconnect it, at least not yet). But that's definitely not
> > the only issue, things break also when disconnect is not involved.
> >=20
> > Terminology:
> > 1. sys-usb - a VM where USB controller (a PCI device) lives; here
> > usbip-host is attached to the device
> > 2. testvm - target VM where usbip is connected; here vhci-hcd is used
> > 3. qvm-usb - tool that connects the above two (equivalent of
> > userspace part of standard usbip)
> >=20
> > Specific steps:
> > 1. Connect android phone - at this point it's only in sys-usb
> > 2. Switch its mode to file transfer - observe reconnect in sys-usb
> > 3. Use qvm-usb to attach it to the testvm
> > 4. Call jmtpfs -d /mnt in testvm
>=20
> Or maybe reset or something is involved here too?
>=20
> After using qvm-usb to attach _and detach_ the device, it stays bound to
> usbip-host driver (that's intentional). But then, even after re-binding
> back to the "usb" driver, jmtpfs called in sys-usb directly fails the
> same way, including failure to reset.
>=20
> In fact, even without usbip involved at all, jmtpfs directly in sys-usb
> works only once. The second attempt (without either physically reconnecti=
ng
> the phone, or changing its more to "no data transfer" and back to "file
> transfer") fails the same way. After terminating the first instance, I
> see just this logged:
>=20
>     [921332.525210] usb 2-1: reset high-speed USB device number 22 using =
xhci_hcd

What happens if the device is not bound to _any_ driver in sys-usb?  For
instance, does the problem go away if the only USB-related drivers in
sys-usb are xhci-pci, usbip-host, and their dependencies?  If not, what
about if sys-usb's kernel has no other USB-related drivers included at
all?

Also, if you have not done so already, could you try uninstalling gvfs
=66rom sys-usb's template?  gvfs might be interacting with the device.
Using a -minimal template might help.

> Since both problematic cases involve Android, maybe the actual issue is
> somewhere in Android instead of usbip? But then, fastboot could be a
> completely different issue, likely related to reconnection (this one I
> haven't tried to reproduce, and can't find much details in our issues
> tracker).
> On the other hand, USB tethering works just fine, so at least some
> Android functions do work with usbip (but then, it's a kernel driver,
> not usbfs).
> Could be also an issue with just MTP implementation on either side of
> the connection (I did tried also gvfs instead of jmtpfs with similar
> result, but they likely use the same implementation). Since that's
> Android, the device side is Linux too, but I don't know how MTP is
> implemented there (I don't see MTP gadget function in upstream Linux).

I suspect MTP is implemented in userspace somewhere in AOSP.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--x028aD6FFihtxBuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmXmYfMACgkQsoi1X/+c
IsF2qhAAznb4KMYZKZZGFFJcKIqkVzFGgk+htrlr9n6dddg7PYvYskyg4dAbcQvG
qkVco/u8y2J4XwvSGN3wwrqBRgBnJojZtRfLXR1o6Lmz/telYbS8KnSnVDcAlstP
RtjeX4FCIwd/TuYIZPaqZVN0h10Ns9odThCwEMrm3Czyfd3foXUQ0w/0CBrzEgMY
/QvdG22W9YHYYBlzZN4kOfL5NauzshQlDK17EneK3P3QnxYBkg3OZefgEGELSt70
PobKbUnXV6wUUQxbiESeInddM5yWglKn5vLxiCuhn1cVYsOVVt6mguj4kY9l33R3
2B7tXAOX/mUBU1DCFxcJtpsm56GGujO/B8wYf0uYeTFUL5gAagsNdaj2/q/Z8hYP
0K6wvyjfHZxxxlF9GME35Fd/WgV4kEJPC+RZsxO91d47vRv6NnRj2vHJP4lyB3Z/
WbcmSodjropUY01jJjrBF+pTk0f3yMSRR/iyxjWePmWjFc2zvWy1Kpy7uCqADb7I
pf+yz8fnPXKwXEjcOuKDYTcYIsvzd/jFPn0/4JtllJP2BAfJ7kI3AlO3Qxz9eoUt
L5pwFPcD/Hmrf17uB+08JUkT2n+jRC4AxytkcgvzOo2KiBDB8rCSP5PpIvt7kP1+
fyNSRysK8Sry+RGci6qxGWaNvy6m75YrNLKwkNa/o+7jv9X9UYU=
=4iUx
-----END PGP SIGNATURE-----

--x028aD6FFihtxBuF--

