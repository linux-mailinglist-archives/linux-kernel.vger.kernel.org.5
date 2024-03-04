Return-Path: <linux-kernel+bounces-91426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8B387115A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9CA1C2094C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674787D3EA;
	Mon,  4 Mar 2024 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="edKn9aPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQHSZfpK"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE567D07C;
	Mon,  4 Mar 2024 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709596348; cv=none; b=g1NAL9Z2m0NcAEWjj58XnjKkQB3B5PKfErcLuDchyca08tlQnGxpAI0K3qmgGxPvvTawGfzj5g1gh5ibBPwbWUVgRxlzZ0tnxuC2EJChHhgqenokPpAnkosm6v+oiSrT71h2FEhWkHdwkW+sd/d/dw0BgzLp96ORjI9/U65EZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709596348; c=relaxed/simple;
	bh=EfW7X9YjU1q/fx7Pvf/3yjPRKIZq48IabAJAAyIpAbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFZC3V8hegYgjoGM6W+sof0R0uqct+IiHyuq34H2IWGnZUkzygqUz5mEN/juemuIgmGPFmOXDN+ppHK/GsZqZ3zWVdq7pmDZPQyRA5W5dSKoLBWn0zk721yTRpk6Y9p6Dvg8976h/HBu++kzwC+1J30O36tDHSBGiHfOg838ZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=edKn9aPn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQHSZfpK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 681D41380118;
	Mon,  4 Mar 2024 18:52:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Mar 2024 18:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709596345;
	 x=1709682745; bh=heEnaN472wsq95PDjD6QKdd4mnPRbYltT03Kzr0VsWI=; b=
	edKn9aPnGIHXh12BAcfpIUKBvfRuVGUiyR4jBlCBr1DvKqVqEu1IPBXN5Igxrrh+
	7cOCvfxd8RM7h9Qy1cRERZhgTdba5Ht8Sv2w/fKN1krzqiy5Ghc3bFuFbVeOJM56
	jiEJlRQ8/GVXA8G91dGf93PYq1xcs42kA7ooLs1EBIWIo6u2bapbNzT5v8MQI6OQ
	lEUMkkpSG0AGYcvRaKiWBqvViGNtjo6NQ9EDB1FMhcBTZfcwvuarAdTqBxIJmNao
	HfEVyKhbT3/5ZTQL7trwNJAu4LGAgxg+J4A4F8ToLjrwtzJ3pS8FjJnlTvmOUYKk
	1Y+IBthcM5LPk9/3hNHuag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709596345; x=1709682745; bh=heEnaN472wsq95PDjD6QKdd4mnPR
	bYltT03Kzr0VsWI=; b=lQHSZfpKCNuMB85hdWh2Ir4JUWwKDdUZAS6UjfGajcbq
	b+kq16WpgjPcygOOQ1rW5TbnEQBYKCh5O11WNFzbEk1ScDYoivdi41FVZNMJVI8N
	4PJ3COgCmEow2crQM1FFDjWKf+/p4PBpGIURZKQhmPxuLrenrNgyoU5963po4VYn
	3Hq8zSmkUCTAz0slvQPVDBxsNnWsDLawCpHCix3ny5VhaDeLhhhcBiXmVmh2QCM1
	zujGo4CzbE8Q009U7oOz6C/fnDoFKSSR1N6bdWlIdZdPwQocl3paOSJCoIaScbBR
	Cz+15/sL8ZPaag1fL4445zJz2aKyJjJsAcZv5G6R/A==
X-ME-Sender: <xms:uV7mZQnJufUFN8V6GXPVRpJtCg_t56jmAXaZpVuv4LiEJWKHXTsb2w>
    <xme:uV7mZf3K-vTNvZJGP0CVGa0wgGvZxJyYltmTTcA5A0I9YFWhCBeqpyCfeDt8OBENy
    0TxcQBwqtPIJA>
X-ME-Received: <xmr:uV7mZeoTxB8gJKKnKX9fnyzxVYRigaY4lN0gZqOde792hDruCwlTVszXCOunDd5gL16_NsDDWhTVwbIjk30kMbVDyIFCJ9aImQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudel
    teefvefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:uV7mZcki_DyVLamucu4W-RbcWgBj5lzd6Lw-nfeH79941Z2WyYYylA>
    <xmx:uV7mZe0pKxrz_btkvWPbcTAdaRePFFGk6SAUbCyTwtyqpTdYahANWA>
    <xmx:uV7mZTtkbpkuPvYE2yT_OwKYayaRbpx-Rj6-SfR9cQunR5jjhdLB5w>
    <xmx:uV7mZTz2ql5MIrMDkmTmfzI9dmrp7hTrZdGSH4cMTF9hBVZ4ZHyoZA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 18:52:24 -0500 (EST)
Date: Tue, 5 Mar 2024 00:52:22 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Demi Marie Obenour <demi@invisiblethingslab.com>,
	linux-usb@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices
Message-ID: <ZeZetkR-i1bCDr9v@mail-itl>
References: <ZeYov0k8njwcZzGX@itl-email>
 <2024030406-kilogram-raving-33c5@gregkh>
 <ZeZPLX6z5pyn2Eh_@mail-itl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vjxjlK2sKkkzCwBy"
Content-Disposition: inline
In-Reply-To: <ZeZPLX6z5pyn2Eh_@mail-itl>


--vjxjlK2sKkkzCwBy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 Mar 2024 00:52:22 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Demi Marie Obenour <demi@invisiblethingslab.com>,
	linux-usb@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices

On Mon, Mar 04, 2024 at 11:46:04PM +0100, Marek Marczykowski-G=C3=B3recki w=
rote:
> On Mon, Mar 04, 2024 at 09:04:00PM +0000, Greg KH wrote:
> > On Mon, Mar 04, 2024 at 03:01:51PM -0500, Demi Marie Obenour wrote:
> > > Qubes OS users are reporting that MTP doesn't work with USB passthrou=
gh.
> > > Fastboot (used for flashing a custom OS to an Android device) also
> > > doesn't work.  Kernel-mode drivers, such as Bluetooth and USB storage,
> > > seem to usually work as expected.  Since MTP and fastboot are both
> > > implemented in userspace, it appears that there is some problem with =
the
> > > interaction of usbip, our USB proxy (which is based on USBIP), and
> > > userspace programs that interact with USB devices directly.
> > >=20
> > > The bug report can be found at [1] and the source code for the USB pr=
oxy
> > > can be found at [2].  The script used on the sending side (the one wi=
th
> > > the physical USB controller) is at [3] and the script used by the
> > > receiving side (the one the device is attached to) is at [4].  All of
> > > these links are for the current version as of this email being sent, =
so
> > > that anyone looking at this email in the future doesn't get confused.
> > >=20
> > > Is this a bug in usbip, or is this due to usbip being used incorrectl=
y?
> >=20
> > I'm amazed that usbip works with usbfs at all, I didn't think that was a
> > thing.
> >=20
> > If you have a reproducer, or some error messages somewhere, that might
> > be the easiest way forward.  In reading the bug report, it looks like
> > the "bridge" you all made can't handle the device disconnecting itself
> > properly?  But that's just a guess, could be anything.
>=20
> Device disconnecting itself indeed is an issue (our proxy doesn't
> automatically reconnect it, at least not yet). But that's definitely not
> the only issue, things break also when disconnect is not involved.
>=20
> Terminology:
> 1. sys-usb - a VM where USB controller (a PCI device) lives; here
> usbip-host is attached to the device
> 2. testvm - target VM where usbip is connected; here vhci-hcd is used
> 3. qvm-usb - tool that connects the above two (equivalent of
> userspace part of standard usbip)
>=20
> Specific steps:
> 1. Connect android phone - at this point it's only in sys-usb
> 2. Switch its mode to file transfer - observe reconnect in sys-usb
> 3. Use qvm-usb to attach it to the testvm
> 4. Call jmtpfs -d /mnt in testvm

Or maybe reset or something is involved here too?

After using qvm-usb to attach _and detach_ the device, it stays bound to
usbip-host driver (that's intentional). But then, even after re-binding
back to the "usb" driver, jmtpfs called in sys-usb directly fails the
same way, including failure to reset.

In fact, even without usbip involved at all, jmtpfs directly in sys-usb
works only once. The second attempt (without either physically reconnecting
the phone, or changing its more to "no data transfer" and back to "file
transfer") fails the same way. After terminating the first instance, I
see just this logged:

    [921332.525210] usb 2-1: reset high-speed USB device number 22 using xh=
ci_hcd

Since both problematic cases involve Android, maybe the actual issue is
somewhere in Android instead of usbip? But then, fastboot could be a
completely different issue, likely related to reconnection (this one I
haven't tried to reproduce, and can't find much details in our issues
tracker).
On the other hand, USB tethering works just fine, so at least some
Android functions do work with usbip (but then, it's a kernel driver,
not usbfs).
Could be also an issue with just MTP implementation on either side of
the connection (I did tried also gvfs instead of jmtpfs with similar
result, but they likely use the same implementation). Since that's
Android, the device side is Linux too, but I don't know how MTP is
implemented there (I don't see MTP gadget function in upstream Linux).

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--vjxjlK2sKkkzCwBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmXmXrYACgkQ24/THMrX
1ywqTAf+KFm0MRSupyhuHY/Ls1eORUE8fuKGhlY3Xr2n19WrYulw7grHbJ8WwoVf
IqV4r05Uy5fvhnBCw9upayG18vN7tWGwlWorar8dWvDAssOauenoz9U0IC57fBOq
7zsxLJRHUOSraglMINDkP/pcFmYm7uSFOwneLIsvFvX+9vpH/yc8y83+vSpB9/w0
CZHgY2EE0+9S0Cobz7II3O8bBDLGJuvH8X+WOp61hEU3S21MUEX8pGqMDh+br/WE
iUgIaP2xHQAuUACXUJPpY3lmCpzkRC9epVCiup5AQij3I4donvJzhtiuaqE59QuP
Flw5B+LVuYhTOMDWUZyfcgs5qCcxFA==
=xUcW
-----END PGP SIGNATURE-----

--vjxjlK2sKkkzCwBy--

