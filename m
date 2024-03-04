Return-Path: <linux-kernel+bounces-91374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7358D871047
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F51C282153
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AA57C083;
	Mon,  4 Mar 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="WskddAMw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTPj3uI6"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27573C28;
	Mon,  4 Mar 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592372; cv=none; b=dwiDsPPzGRjYoFLJXktY8Zv2DZCOT3Za3XR4e5lqlMdo10kdim7B7Yp9w0ViopRe3xmZQGtzZ41CNzXVsADFrCD0NnpxubuORMhNFHQ9ogR8hb2rkt75L5RmWTHhXB4LgIPUExZ54OzTbEUuKJKdtFiaj2VTDl6/iBVXl0swl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592372; c=relaxed/simple;
	bh=68V6j83P2WpOy1AHlDu3IfWniVQwz5jF5hCZ+GBhryY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O39JLKE8RvFkBQd6b9Qp1CmXz6oPF3PDSQ7h7kWvWWaDV3ZmrQkegRHHHZh852q/BsK5IroDG5AZkJBYuhj517iZuCL7NFyC4NOj288GpZ1rLed7VesyConjDVEB4pgHtpVKRXDZluXywwtpy54yOlbWQgVYnC2QJkQYgVgkXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=WskddAMw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTPj3uI6; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D34E81140144;
	Mon,  4 Mar 2024 17:46:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 04 Mar 2024 17:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709592368;
	 x=1709678768; bh=MazQbRNiMLTjCsnYC+DAQ7NahahSMfC8KextuceTqoM=; b=
	WskddAMwtOjAw1OjSXU2fKcMtfpV6WMcJovM08z07SrMfkupbr3Do9GPf281zrT7
	+J8X0pk7yeh43IleW9axSmwPEFQgTqY6cTrp4pPb3I+XOl1Ruf28T6nT8IPX5E6N
	vCasIS7tlAfDuUbJ20Rd8v1kigl3oc+T7IE8YQwD6IBTavUs+SyytUSsxJHhsTfx
	N+lmTwha9ndTR9+bZl97vPzYjXtysGx1xRV6lajwnzUb2fDryurTOGEvWqOFM1Tq
	oYPcGrfLPKi1ZbYkYYm8D8vW79osWGagYiw683jgzjAn+dTcBH9gWg0gZldhbXJo
	z57+DChvp+27jqfwQ4qSMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709592368; x=1709678768; bh=MazQbRNiMLTjCsnYC+DAQ7NahahS
	MfC8KextuceTqoM=; b=eTPj3uI6ZuU+yzwKKptK9ilT20gELCgY8+KQSI8WLP+X
	0rVtXycgVaoAZZaCYL41V4DlFB39kphFso2nPLjTnJVsofm9BbsOMH8k0UVk2iW9
	M33uHehRgVIfdyHFGbh1zLErdK8WjeH0/xx2VxyaAN/jsFlloZpMOcxRp90leNcO
	SLJGb6qpMib74EKa8yg7tiIf/TQpwWmzU3ml3WCdoHPM/iHMrsxnUy+r6LKloxdp
	Zu0OqfnauyAEQtGXt9uk3LHLoN/o0lYNlw5rynsjVkYKcWdGxzHxZLmd+BOkZvKl
	Rq3+JbE6Fe6gPz1eOlY2E6mrbRLXVn+cZ+sWU0mVsQ==
X-ME-Sender: <xms:ME_mZd2V4td0ZU4H_g4lqraTa9Ww1SexM9CvKtrDWNOE2WIa9jtzXg>
    <xme:ME_mZUF50JPv1UgP85ln_hJX6svntybiFyaLQ_NuV0wfdyQ3G7lEeXOQTmKqf58ii
    ekp2EPhmFPo4g>
X-ME-Received: <xmr:ME_mZd5eAFquNO_kxhRsUDI2jdVP4VU0a5jDPWmuSMiKW6OOVANmBZnNA8lXDGlx5vYKna3w3fI2Jzfa28mgPZd0kZktPrdQ4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudel
    teefvefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:ME_mZa1E7-REhztHs1kFmExO1ytDVfT9hmJ0y5c-D3dtjGvnuL__sg>
    <xmx:ME_mZQFwUwNUy9jWeIhzrvntjb-URBcEzSC4GOpVD4pWRjO5QIytfA>
    <xmx:ME_mZb8y-gDDLMUPEWELD4AtmmVg3Bnb-1CjtoGqZH8jOdx10lNNSQ>
    <xmx:ME_mZUCRCGJ8gffQVhLcRYO823ZrdlRbOuVy0IV4avERGPY1_HaCiA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 17:46:07 -0500 (EST)
Date: Mon, 4 Mar 2024 23:46:04 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Demi Marie Obenour <demi@invisiblethingslab.com>,
	linux-usb@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices
Message-ID: <ZeZPLX6z5pyn2Eh_@mail-itl>
References: <ZeYov0k8njwcZzGX@itl-email>
 <2024030406-kilogram-raving-33c5@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bSEqgkMjtgBF/hET"
Content-Disposition: inline
In-Reply-To: <2024030406-kilogram-raving-33c5@gregkh>


--bSEqgkMjtgBF/hET
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Mar 2024 23:46:04 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Demi Marie Obenour <demi@invisiblethingslab.com>,
	linux-usb@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usbip doesn't work with userspace code that accesses USB devices

On Mon, Mar 04, 2024 at 09:04:00PM +0000, Greg KH wrote:
> On Mon, Mar 04, 2024 at 03:01:51PM -0500, Demi Marie Obenour wrote:
> > Qubes OS users are reporting that MTP doesn't work with USB passthrough.
> > Fastboot (used for flashing a custom OS to an Android device) also
> > doesn't work.  Kernel-mode drivers, such as Bluetooth and USB storage,
> > seem to usually work as expected.  Since MTP and fastboot are both
> > implemented in userspace, it appears that there is some problem with the
> > interaction of usbip, our USB proxy (which is based on USBIP), and
> > userspace programs that interact with USB devices directly.
> >=20
> > The bug report can be found at [1] and the source code for the USB proxy
> > can be found at [2].  The script used on the sending side (the one with
> > the physical USB controller) is at [3] and the script used by the
> > receiving side (the one the device is attached to) is at [4].  All of
> > these links are for the current version as of this email being sent, so
> > that anyone looking at this email in the future doesn't get confused.
> >=20
> > Is this a bug in usbip, or is this due to usbip being used incorrectly?
>=20
> I'm amazed that usbip works with usbfs at all, I didn't think that was a
> thing.
>=20
> If you have a reproducer, or some error messages somewhere, that might
> be the easiest way forward.  In reading the bug report, it looks like
> the "bridge" you all made can't handle the device disconnecting itself
> properly?  But that's just a guess, could be anything.

Device disconnecting itself indeed is an issue (our proxy doesn't
automatically reconnect it, at least not yet). But that's definitely not
the only issue, things break also when disconnect is not involved.

Terminology:
1. sys-usb - a VM where USB controller (a PCI device) lives; here
usbip-host is attached to the device
2. testvm - target VM where usbip is connected; here vhci-hcd is used
3. qvm-usb - tool that connects the above two (equivalent of
userspace part of standard usbip)

Specific steps:
1. Connect android phone - at this point it's only in sys-usb
2. Switch its mode to file transfer - observe reconnect in sys-usb
3. Use qvm-usb to attach it to the testvm
4. Call jmtpfs -d /mnt in testvm


It fails this way:

    Device 0 (VID=3D18d1 and PID=3D4ee1) is a Google Inc Nexus/Pixel (MTP).
    PTP_ERROR_IO: failed to open session, trying again after resetting USB =
interface
    LIBMTP libusb: Attempt to reset device
    LIBMTP PANIC: failed to open session on second attempt
    Cannot open requested device

There is a short wait before first failure and then the reset fails as
well (interestingly, device doesn't actually reset, it stays connected).

At that time, testvm's dmesg shows:

    [2126560.758005] vhci_hcd: unlink->seqnum 98
    [2126560.758025] vhci_hcd: urb->status -104
    [2126560.872413] usb 1-1: reset high-speed USB device number 3 using vh=
ci_hcd
    [2126560.992995] usb 1-1: SetAddress Request (3) to port 0
    [2126561.162264] usb 1-1: reset high-speed USB device number 3 using vh=
ci_hcd
    [2126561.278584] usb 1-1: SetAddress Request (3) to port 0

And sys-usb's dmesg:

    [915567.691431] usbip-host 2-1: unlinked by a call to usb_unlink_urb()

I've observed it also with wireshark in testvm, and there is a single packe=
t sent (before the attempt to reset):

    Frame 90: 80 bytes on wire (640 bits), 80 bytes captured (640 bits) on =
interface usbmon1, id 0
    USB URB
        [Source: host]
        [Destination: 1.3.1]
        URB id: 0xffff888007cbaa80
        URB type: URB_SUBMIT ('S')
        URB transfer type: URB_BULK (0x03)
        Endpoint: 0x01, Direction: OUT
        Device: 3
        URB bus id: 1
        Device setup request: not relevant ('-')
        Data: present ('\0')
        URB sec: 1709589466
        URB usec: 80050
        URB status: Operation now in progress (-EINPROGRESS) (-115)
        URB length [bytes]: 16
        Data length [bytes]: 16
        [Response in: 91]
        [bInterfaceClass: Imaging (0x06)]
        Unused Setup Header
        Interval: 0
        Start frame: 0
        Copy of Transfer Flags: 0x00000000
        Number of ISO descriptors: 0
    Leftover Capture Data: 10000000010002100000000001000000

And the same seen in sys-usb:

    Frame 117: 80 bytes on wire (640 bits), 80 bytes captured (640 bits) on=
 interface usbmon2, id 0
    USB URB
        [Source: host]
        [Destination: 2.18.1]
        URB id: 0xffff908b585f5480
        URB type: URB_SUBMIT ('S')
        URB transfer type: URB_BULK (0x03)
        Endpoint: 0x01, Direction: OUT
        Device: 18
        URB bus id: 2
        Device setup request: not relevant ('-')
        Data: present ('\0')
        URB sec: 1709591829
        URB usec: 752585
        URB status: Operation now in progress (-EINPROGRESS) (-115)
        URB length [bytes]: 16
        Data length [bytes]: 16
        [Response in: 118]
        [bInterfaceClass: Imaging (0x06)]
        Unused Setup Header
        Interval: 0
        Start frame: 0
        Copy of Transfer Flags: 0x00000000
        Number of ISO descriptors: 0
    Leftover Capture Data: 10000000010002100000000001000000

And after few seconds it gets this "response":

    Frame 91: 64 bytes on wire (512 bits), 64 bytes captured (512 bits) on =
interface usbmon1, id 0
    USB URB
        [Source: 1.3.1]
        [Destination: host]
        URB id: 0xffff888007cbaa80
        URB type: URB_COMPLETE ('C')
        URB transfer type: URB_BULK (0x03)
        Endpoint: 0x01, Direction: OUT
        Device: 3
        URB bus id: 1
        Device setup request: not relevant ('-')
        Data: not present ('>')
        URB sec: 1709589471
        URB usec: 83920
        URB status: No such file or directory (-ENOENT) (-2)
        URB length [bytes]: 0
        Data length [bytes]: 0
        [Request in: 90]
        [Time from request: 5.003870000 seconds]
        [bInterfaceClass: Imaging (0x06)]
        Unused Setup Header
        Interval: 0
        Start frame: 0
        Copy of Transfer Flags: 0x00000000
        Number of ISO descriptors: 0

and the same seen in sys-usb:

    Frame 118: 64 bytes on wire (512 bits), 64 bytes captured (512 bits) on=
 interface usbmon2, id 0
    USB URB
        [Source: 2.18.1]
        [Destination: host]
        URB id: 0xffff908b585f5480
        URB type: URB_COMPLETE ('C')
        URB transfer type: URB_BULK (0x03)
        Endpoint: 0x01, Direction: OUT
        Device: 18
        URB bus id: 2
        Device setup request: not relevant ('-')
        Data: not present ('>')
        URB sec: 1709591834
        URB usec: 753529
        URB status: Connection reset by peer (-ECONNRESET) (-104)
        URB length [bytes]: 0
        Data length [bytes]: 0
        [Request in: 117]
        [Time from request: 5.000944000 seconds]
        [bInterfaceClass: Imaging (0x06)]
        Unused Setup Header
        Interval: 0
        Start frame: 0
        Copy of Transfer Flags: 0x00000000
        Number of ISO descriptors: 0


Calling jmtpfs directly in sys-usb succeeds without device reset:

    Device 0 (VID=3D18d1 and PID=3D4ee1) is a Google Inc Nexus/Pixel (MTP).
    Android device detected, assigning default bug flags
    FUSE library version: 2.9.9
    nullpath_ok: 0
    nopath: 0
    utime_omit_ok: 0
    unique: 2, opcode: INIT (26), nodeid: 0, insize: 104, pid: 0
    INIT: 7.37
    flags=3D0x73fffffb
    max_readahead=3D0x00020000
       INIT: 7.19
       flags=3D0x00000011
       max_readahead=3D0x00020000
       max_write=3D0x00020000
       max_background=3D0
       congestion_threshold=3D0
       unique: 2, success, outsize: 40

At that time, looking at wireshark in sys-usb, I see similar URB_BULK sent:

    Frame 1171: 80 bytes on wire (640 bits), 80 bytes captured (640 bits) o=
n interface usbmon2, id 0
    USB URB
        [Source: host]
        [Destination: 2.18.1]
        URB id: 0xffff908b4fe92180
        URB type: URB_SUBMIT ('S')
        URB transfer type: URB_BULK (0x03)
        Endpoint: 0x01, Direction: OUT
        Device: 18
        URB bus id: 2
        Device setup request: not relevant ('-')
        Data: present ('\0')
        URB sec: 1709591408
        URB usec: 157571
        URB status: Operation now in progress (-EINPROGRESS) (-115)
        URB length [bytes]: 16
        Data length [bytes]: 16
        [Response in: 1172]
        [bInterfaceClass: Imaging (0x06)]
        Unused Setup Header
        Interval: 0
        Start frame: 0
        Copy of Transfer Flags: 0x00000000
        Number of ISO descriptors: 0
    Leftover Capture Data: 10000000010002100000000001000000

but this time it gets a response:

    Frame 1172: 64 bytes on wire (512 bits), 64 bytes captured (512 bits) o=
n interface usbmon2, id 0
    USB URB
        [Source: 2.18.1]
        [Destination: host]
        URB id: 0xffff908b4fe92180
        URB type: URB_COMPLETE ('C')
        URB transfer type: URB_BULK (0x03)
        Endpoint: 0x01, Direction: OUT
        Device: 18
        URB bus id: 2
        Device setup request: not relevant ('-')
        Data: not present ('>')
        URB sec: 1709591408
        URB usec: 157806
        URB status: Success (0)
        URB length [bytes]: 16
        Data length [bytes]: 0
        [Request in: 1171]
        [Time from request: 0.000235000 seconds]
        [bInterfaceClass: Imaging (0x06)]
        Unused Setup Header
        Interval: 0
        Start frame: 0
        Copy of Transfer Flags: 0x00000000
        Number of ISO descriptors: 0

I'm happy to provide more information, debug logs etc, just tell me what
:)


--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--bSEqgkMjtgBF/hET
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmXmTy0ACgkQ24/THMrX
1yzN1Af9EOVSPtEQjBHWrW1AGqMWTjtqT3lAMyvHLFM0DAtcrax8aE4FGiYbAuVN
pXZpGo/ImF3/U2N+d/Bc121irv4q50BeqcALYd3CMObme1H6Jxr8/oqyhaorFJkv
pPvtGw99MQQIxMdNrTMRdholD2s5yTOku8Sc90Yhr9pcPh+8I2Q6cEt7ho044WO8
KkDMWMCV7u7T7nigs6SKiAEd8PJ8RG+syAWABV9ZBtbv/yC/XUVh7o1D4Qw5SdE5
lXbhSCsDttorwW9EhY8wIcYKHfFFIwS4aRaYhC5EqW0BrpaUkD8zJRgAHtyC2rRh
Fa3oof4uYGrAwXAu5eK74RF1nNZ1nQ==
=ClV7
-----END PGP SIGNATURE-----

--bSEqgkMjtgBF/hET--

