Return-Path: <linux-kernel+bounces-40706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D727983E464
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EEFF1F21690
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F61F2557C;
	Fri, 26 Jan 2024 21:57:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8FE2554E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306268; cv=none; b=uDQmHX00ovfOXow00c2wSqTPwgaVyvrUYnhSGH83w0wxhuY0MsZQ73/7cl0Q475bt6lpcaWBznAnNWk+w7lCIjh2hCN0YfX9YWXvXnSc7Cictzv/Gspt1HMiDVv7mxkCnthPy+JCsFiyVRDCzzxr401JznFQ/QI+o9coUod7bu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306268; c=relaxed/simple;
	bh=BVrGq/7XfOhF9vHBuLXUYQUG8qvDs8RmRicYvfTIGJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5XNliKHKLhc8Ubkd1biQb7o3RKfWVbZDZ+J4cK9PIdbEixoNVt8idEJL11ZQbptw5V159MhdagAcPPNdoEo3xf1fLGZFVn89v0hLGKlrEPcg0R3CLfx6UDF6hwyYpblh2i74lKaBLwAdBIyZ+eCoJFLp43HfE/6REc5iR/8hX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rTUCX-0001Od-Nf; Fri, 26 Jan 2024 22:57:29 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rTUCU-002atY-LE; Fri, 26 Jan 2024 22:57:26 +0100
Received: from mgr by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rTUCU-0020WK-IA; Fri, 26 Jan 2024 22:57:26 +0100
Date: Fri, 26 Jan 2024 22:57:26 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Jan =?iso-8859-15?Q?L=FCbbe?= <jlu@pengutronix.de>,
	Latchesar Ionkov <lucho@ionkov.net>, linux-usb@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	v9fs@lists.linux.dev,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH 0/3] usb: gadget: 9pfs transport
Message-ID: <20240126215726.GA183863@pengutronix.de>
References: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>
 <ZaZsUQUhSlMPLJg0@codewreck.org>
 <0aba51a8be0fb165b44ec956bec7a9698a9518a2.camel@pengutronix.de>
 <Zaex_fkKcui7QZd7@codewreck.org>
 <80c4e788-65df-4a82-8453-74683289abcb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <80c4e788-65df-4a82-8453-74683289abcb@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 08:47:22PM +0100, Andrzej Pietrasiewicz wrote:
>Hi,
>
>W dniu 17.01.2024 o=A011:54, Dominique Martinet pisze:
>>Jan L=FCbbe wrote on Tue, Jan 16, 2024 at 04:51:41PM +0100:
>>>>So I didn't have time to look at everything through, just want to make
>>>>sure, this series allows sharing data from an usb gadget (e.g. some
>>>>device with storage) over 9p as an alternative to things like MTP ?
>>>
>>>It's the other way around. :) The USB host exports a filesystem, while t=
he
>>>gadget on the USB device side makes it mountable. Our main use-case is t=
o use it
>>>as an alternative to NFS root booting during the development of embedded=
 Linux
>>>devices. NFS root works in many cases, but has some downsides, which mak=
e it
>>>cumbersome to use in more and more cases.
>>
>>Oh!
>>Okay, this makes a lot more sense. And that'll need a bit more
>>explanations in the commits & Documentation/ as you've concluded :)
>>
>>
>>>NFS root needs correctly configured Ethernet interfaces on both the deve=
lopment
>>>host and the target device. On the target, this can interfere with the n=
etwork
>>>configuration that is used for the normal device operation (DHCP client,=
 ...).
>>>For the host, configuring a NFS (and perhaps DHCP) server can be an obst=
acle.
>>>
>>>For target devices which don't have a real Ethernet interface, NFS root =
would
>>>also work with the USB Ethernet gadget, but this increases the complexity
>>>further.
>>>
>>>As many embedded boards have a USB device port anyway, which is used dur=
ing
>>>development for uploading the boot-loader and to flash filesystem images=
 (i.e.
>>>via the fastboot protocol), we want to just reuse that single data cable=
 to
>>>allow access to the root filesystem as well.
>>>
>>>Compared to flashing images, using a network filesystem like NFS and 9P =
reduces
>>>the time between compiling on the host and running the binary on the tar=
get, as
>>>no flash and reboot cycle is needed. That can get rid of many minutes of=
 waiting
>>>over a day. :)
>>
>>My other hat is on embedded development (dayjob at Atmark Techno[1], the
>>only english page linked is about 4 years out of date but I guess it's
>>better than no page at all), so I can understand where you're coming
>>from -- thanks for the background.
>>
>>[1] https://www.atmark-techno.com/english
>>
>>That means I'll actually want to test this, but kind of always busy so
>>it might take a few weeks...
>>Or better, do you happen to know if qemu can create a USB controller
>>that supports OTG so it'll be easy to test for folks with no such
>>hardware?
>
>Maybe dummy_hcd is what you want?

I did a lot of testing with dummy_hcd. So this should work.

But of course testing the special case of rootfs is tricky. Since you
will have to share the gadget with qemu to boot the rootfs from
somewhere else.

Regards,
Michael

>>We've got enough 9p protocols that aren't actually tested on a regular
>>basis, it'd be great if we could have something that can run anywhere.
>>
>>
>>>diod (9pfs server) and the forwarder are on the development host, where =
the root
>>>filesystem is actually stored. The gadget is initialized during boot (or=
 later)
>>>on the embedded board. Then the forwarder will find it on the USB bus an=
d start
>>>forwarding requests.
>>>
>>>It may seem a bit unusual that in this case the requests come from the d=
evice
>>>and are handled by the host. The reason is that USB device ports are nor=
mally
>>>not available on PCs, so a connection in the other direction would not w=
ork.
>>
>>Right, most host PCs won't have OTG available...
>>I was also perplexed by the linux foundation (0x1d6b):0x0109 id, that
>>might be clearer once it's properly documented -- I'll let someone from
>>the usb side chime on this as I have no idea what's appropriate.
>>
>>
>>>In the future, the functionality of the forwarder could be integrated in=
to the
>>>9pfs server. Alternatively, an improved forwarder could also react to ud=
ev
>>>events of gadgets showing up and forward them to different 9PFS server o=
ver the
>>>network (when you have multiple target devices connected to one USB host=
).
>>
>>Plenty of potential work ahead :)
>>Frankly at this stage I don't think it's much simpler than e.g. CDC
>>ethernet gadget and mounting nfs over tcp, but with further improvements
>>it can definitely get simpler.
>>
>>
>>>Perhaps, the inverse setup (9PFS server on the USB gadget side, mounted =
on a PC)
>>>also would be useful in the future and could share some of this code. Th=
en,
>>>you'd have an alternative to MTP.
>>
>>(Yeah, I'm not actively looking for that -- was just asking because MTP
>>has been kind of dead lately and I'm not aware of any potential
>>alternative, but I didn't go looking for them either -- let's leave that
>>to later)
>>
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmW0KsMACgkQC+njFXoe
LGRMDA//TS98JSMa3OqGApgt33CFV5o169WiV14RCxkouF2ELFSZ8MKaiYrpijV6
joMER3osdUuvuaRcrw2HDK9TzeKEfm6PwkrSrJu0mTt7VHBN6vFlhcuTVME8ED+G
Wah5cpVq8wVjLybR8m27R6WYkLUH629ARvpJAEa13A5+76ZIBPM6gUklEvrtUJ0k
WQEsF6G5e0ddRp48CAFalniGBFGr+yKmiEJ+emBDGCJycFWg6clmXSuQR86ZTfU4
wQ76yg8lNbMXk178yjzNLhc2kHjbr/JO7Gn3CQMl3wzgkmhGBqPoF5DEgxEcKA5a
yulcwwmn8S1zTSJqKApd1vMSlf7qhG3O2kf6e3P+oG+eMJKALk5xud5u0n3gtMgK
Mk7CqlWP/UJ+SqgmBi+30i/+jKYnXuaIa9BHk77NNpPfXYZOMhheXqhw2wKHl/UW
90Qq6DFQyLkfaGZpkuXkmmhmBmOKQ0R8AXz00luWKuVhZjC5oi6B0mTcrUDpBUt6
aBOiKQxE6l/MK6l6wk36H6S9MPA+OAQbD8FfsaLkKJsTaS9qr4h28mruWpPq6uJU
iD7SDFCR35Yu/6y4U/m9w4imQNUFv+HwBGmRXukRDQ9apVUEYSJ6GO+6RHMmNUPR
AHmjXrN9n/IfQbHXjhus37xuDOs5D1U+FBFeuWcRATMifkult+M=
=UteF
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

