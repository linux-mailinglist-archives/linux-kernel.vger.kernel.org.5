Return-Path: <linux-kernel+bounces-91456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52268711BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F461C2126F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F714C9F;
	Tue,  5 Mar 2024 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="K1Z4gYN5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qwHM/ScL"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3AF7F;
	Tue,  5 Mar 2024 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598787; cv=none; b=sg2kxSX4RFJ5oXdBKcrnELNGUGP7XKE5D5evF00bo1qeDBtmIBQ+XMYkVcq1gkORx8vogV/kd5XZbm6QAFuql1KbK+H8B4bB1mtwWiIWp7AkEpTn6bq+MrLnCJN7fjEQ5K5XLG/ixkU0bBwGRHV7I8qiJTiLD6KinR+d0t/p4DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598787; c=relaxed/simple;
	bh=N6tOP2RWdPRzTJ9KeGlyEB+LAPp1OIf/zST7GNIXy9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl+kYVyJbsivddHkJGKI+b30C7CXFJL3K6a0nQfDPBzUHix5iEGLyFjCqsUh13IQRv82t9UOfo7MzPx1u4npH19eP1VzBpeO9BNzViTQLRUR/ILyJRAnzqMzCTIMn0qj8YW/MTaNT8cVOmACVwqs02dNIPNitAJj55NDt1IIdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=K1Z4gYN5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qwHM/ScL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7841D11400F6;
	Mon,  4 Mar 2024 19:33:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 04 Mar 2024 19:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709598784;
	 x=1709685184; bh=wZuDpRIyUxwZpbFgO9ouiTzyAoWAyZapOYUHwxkoViA=; b=
	K1Z4gYN5l+/76tvNZGSuhYtBCOZ1G1lisWyqv0po381ymXfLYG2fK0U8HLOole3n
	53EaYa34+h5o/imN97zQprzM8e6w7t9YP3f0zQgcBctSCi7oT5EdUEVpRWrv5UfD
	YZpiON6vnnH1e2K6zQRFPXhs/rpclp6QxzlWqVLKiP4oDSndt9AkQt2AUdZB/OLy
	L4gTy/6FiwwcQSusemciamBadsBt6M+2pM2VsawLMLW0WJJa+XESXq6uMYYOVvxZ
	pF93Oqwc4KeaVFnxLVJRTiXVeFhW+RT6e23sjOVdBfNt2ihEwP5L0jWewOGgiEX6
	I3eV507z/2mQ6DEFKSBV5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709598784; x=1709685184; bh=wZuDpRIyUxwZpbFgO9ouiTzyAoWA
	yZapOYUHwxkoViA=; b=qwHM/ScLraRh9QoSdk9k0Wxc2DC45pwGx3twiyA3j0rP
	SwLz5U5V/ctXQ6ZugRxMurPCMluWP1G6tKrWP9j/RZUs/NaH+f7iZvbK/zo1Y2YU
	Vv5xAG+ZqDASi1L0lNGBjgBp2TQJpF89RxeRinkSerfV4L5XwCaXHYQRU0k34dgH
	ysbs0D+ggKBlzx+qoLh3DhgeX1y6E78iuIPeuXiYcBUO8DH9ESwHK5DoO4SdHVGD
	ag8gI96rFTNsEbruJZ/s39SW9r8wcPDNxkGUETLdaVHYmFr11t5ffqROge7dEYpA
	O6xC9kZyvuKBQ6q65YMPFr2Sk1QbZk2WQR14BtRqOQ==
X-ME-Sender: <xms:QGjmZfFaQd_KhluVR5FHVhbvXCe9C9v-yQV68n2eRjH78TS9KYNgfg>
    <xme:QGjmZcVaquKqxTfBZBZxoZZbeiCAtGMOLwTvLL_N3qBfXaRXq1Ox0iKRqXtSFaZeL
    caCXmDRC5sjJw>
X-ME-Received: <xmr:QGjmZRL8EQtRfD07rgWn0IOv13T9mnckkd0T86o3f2o3Z28RFAZaHocpvHa20sAVZA6k1GWxiO6o2PfmhJNqm3l9kD10lqQKiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudel
    teefvefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:QGjmZdHrmyBAkVJLEgDF4p7hkz_-aKw8uFIfFgRkiDldiuk9Kc8NrA>
    <xmx:QGjmZVXyMNdmJz8FA1tD3N3wXBBmdckmKFSjsFwtR0Xjy6oSPjFsFg>
    <xmx:QGjmZYMo0jZ8E88z4L8fu4rrxQNFfe3p9fRIuB_P07AT1G6Z9h1d7A>
    <xmx:QGjmZYT717WO7rv0EAVGJGFDs4N5HvcHKIe1GsCSZqSa2ADxjcmdyg>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 19:33:03 -0500 (EST)
Date: Tue, 5 Mar 2024 01:33:00 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices
Message-ID: <ZeZoPAJw2Ip_Lgch@mail-itl>
References: <ZeYov0k8njwcZzGX@itl-email>
 <2024030406-kilogram-raving-33c5@gregkh>
 <ZeZPLX6z5pyn2Eh_@mail-itl>
 <ZeZetkR-i1bCDr9v@mail-itl>
 <ZeZh82gIm2xo_UFM@itl-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WN7gfDbbAqHw1d2/"
Content-Disposition: inline
In-Reply-To: <ZeZh82gIm2xo_UFM@itl-email>


--WN7gfDbbAqHw1d2/
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 Mar 2024 01:33:00 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices

On Mon, Mar 04, 2024 at 07:06:08PM -0500, Demi Marie Obenour wrote:
> On Tue, Mar 05, 2024 at 12:52:22AM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > On Mon, Mar 04, 2024 at 11:46:04PM +0100, Marek Marczykowski-G=C3=B3rec=
ki wrote:
> > > On Mon, Mar 04, 2024 at 09:04:00PM +0000, Greg KH wrote:
> > > > On Mon, Mar 04, 2024 at 03:01:51PM -0500, Demi Marie Obenour wrote:
> > > > > Qubes OS users are reporting that MTP doesn't work with USB passt=
hrough.
> > > > > Fastboot (used for flashing a custom OS to an Android device) also
> > > > > doesn't work.  Kernel-mode drivers, such as Bluetooth and USB sto=
rage,
> > > > > seem to usually work as expected.  Since MTP and fastboot are both
> > > > > implemented in userspace, it appears that there is some problem w=
ith the
> > > > > interaction of usbip, our USB proxy (which is based on USBIP), and
> > > > > userspace programs that interact with USB devices directly.
> > > > >=20
> > > > > The bug report can be found at [1] and the source code for the US=
B proxy
> > > > > can be found at [2].  The script used on the sending side (the on=
e with
> > > > > the physical USB controller) is at [3] and the script used by the
> > > > > receiving side (the one the device is attached to) is at [4].  Al=
l of
> > > > > these links are for the current version as of this email being se=
nt, so
> > > > > that anyone looking at this email in the future doesn't get confu=
sed.
> > > > >=20
> > > > > Is this a bug in usbip, or is this due to usbip being used incorr=
ectly?
> > > >=20
> > > > I'm amazed that usbip works with usbfs at all, I didn't think that =
was a
> > > > thing.
> > > >=20
> > > > If you have a reproducer, or some error messages somewhere, that mi=
ght
> > > > be the easiest way forward.  In reading the bug report, it looks li=
ke
> > > > the "bridge" you all made can't handle the device disconnecting its=
elf
> > > > properly?  But that's just a guess, could be anything.
> > >=20
> > > Device disconnecting itself indeed is an issue (our proxy doesn't
> > > automatically reconnect it, at least not yet). But that's definitely =
not
> > > the only issue, things break also when disconnect is not involved.
> > >=20
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
> What happens if the device is not bound to _any_ driver in sys-usb?  For
> instance, does the problem go away if the only USB-related drivers in
> sys-usb are xhci-pci, usbip-host, and their dependencies?  If not, what
> about if sys-usb's kernel has no other USB-related drivers included at
> all?

I don't think I can get rid of the "usb" driver, and that's what binds to
the device. There is no driver bound to the first interface of the
device (2-1:1.0) at all.

> Also, if you have not done so already, could you try uninstalling gvfs
> from sys-usb's template?  gvfs might be interacting with the device.
> Using a -minimal template might help.

I highly doubt it would change anything.

> > Since both problematic cases involve Android, maybe the actual issue is
> > somewhere in Android instead of usbip? But then, fastboot could be a
> > completely different issue, likely related to reconnection (this one I
> > haven't tried to reproduce, and can't find much details in our issues
> > tracker).
> > On the other hand, USB tethering works just fine, so at least some
> > Android functions do work with usbip (but then, it's a kernel driver,
> > not usbfs).
> > Could be also an issue with just MTP implementation on either side of
> > the connection (I did tried also gvfs instead of jmtpfs with similar
> > result, but they likely use the same implementation). Since that's
> > Android, the device side is Linux too, but I don't know how MTP is
> > implemented there (I don't see MTP gadget function in upstream Linux).
>=20
> I suspect MTP is implemented in userspace somewhere in AOSP.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--WN7gfDbbAqHw1d2/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmXmaDwACgkQ24/THMrX
1yxsRgf+NaWUFQIbjKfO9lABM6LoyHD8VWptDVKH/sjrdvn2asmmNDnfqOmj+ZGl
rZwxXHfgOvL3atnUHRCbMCPo1PwH4+6C3xyPBkW+ISTCLE/hk1g9WUDkxx/RJ9z9
jSUIw07LThGcPp2zkLynNZRGBoc5Jz/JFX75GGIS2Fx/GnwVdmXpjJGou8cul7+e
rvXkYfslXT8JLG8SZ3XmmfWF6eQ6v109kyEE9csYC5buOe77hT0ej/ur8naSjstl
4QeWZFOxZ8WZIkiKwo9E4uGQI7ywU0Mur2Rjm46jfEc9kXVP/VvHzv2msbStQ5xU
QUsZHWfwDgSE4ZxQRlLwfPUfxIxK0g==
=HwDX
-----END PGP SIGNATURE-----

--WN7gfDbbAqHw1d2/--

