Return-Path: <linux-kernel+bounces-27541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C487282F1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615C028256C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F381C698;
	Tue, 16 Jan 2024 15:51:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0C1C683
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <jlu@pengutronix.de>)
	id 1rPlj4-0003Dv-L9; Tue, 16 Jan 2024 16:51:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <jlu@pengutronix.de>)
	id 1rPlj3-000H4W-Sb; Tue, 16 Jan 2024 16:51:41 +0100
Received: from localhost ([127.0.0.1])
	by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jlu@pengutronix.de>)
	id 1rPlj3-0012XM-2I;
	Tue, 16 Jan 2024 16:51:41 +0100
Message-ID: <0aba51a8be0fb165b44ec956bec7a9698a9518a2.camel@pengutronix.de>
Subject: Re: [PATCH 0/3] usb: gadget: 9pfs transport
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Dominique Martinet <asmadeus@codewreck.org>, Michael Grzeschik
	 <m.grzeschik@pengutronix.de>
Cc: Latchesar Ionkov <lucho@ionkov.net>, linux-usb@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 v9fs@lists.linux.dev,  Christian Schoenebeck <linux_oss@crudebyte.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de,  Eric Van Hensbergen <ericvh@kernel.org>
Date: Tue, 16 Jan 2024 16:51:41 +0100
In-Reply-To: <ZaZsUQUhSlMPLJg0@codewreck.org>
References: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>
	 <ZaZsUQUhSlMPLJg0@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, 2024-01-16 at 20:45 +0900, Dominique Martinet wrote:
> Michael Grzeschik wrote on Tue, Jan 16, 2024 at 02:49:40AM +0100:
> > This series is adding support to mount 9pfs exported filesystems via th=
e
> > usb gadget interface. It also includes tools and descriptions on how to
> > translate an tcp 9pfs and use it via the usb interface.
>=20
> So I didn't have time to look at everything through, just want to make
> sure, this series allows sharing data from an usb gadget (e.g. some
> device with storage) over 9p as an alternative to things like MTP ?

It's the other way around. :) The USB host exports a filesystem, while the
gadget on the USB device side makes it mountable. Our main use-case is to u=
se it
as an alternative to NFS root booting during the development of embedded Li=
nux
devices. NFS root works in many cases, but has some downsides, which make i=
t
cumbersome to use in more and more cases.

NFS root needs correctly configured Ethernet interfaces on both the develop=
ment
host and the target device. On the target, this can interfere with the netw=
ork
configuration that is used for the normal device operation (DHCP client, ..=
).
For the host, configuring a NFS (and perhaps DHCP) server can be an obstacl=
e.

For target devices which don't have a real Ethernet interface, NFS root wou=
ld
also work with the USB Ethernet gadget, but this increases the complexity
further.

As many embedded boards have a USB device port anyway, which is used during
development for uploading the boot-loader and to flash filesystem images (i=
e.
via the fastboot protocol), we want to just reuse that single data cable to
allow access to the root filesystem as well.=20

Compared to flashing images, using a network filesystem like NFS and 9P red=
uces
the time between compiling on the host and running the binary on the target=
, as
no flash and reboot cycle is needed. That can get rid of many minutes of wa=
iting
over a day. :)

> I don't quite understand what the forwarder and diod have to do with
> this; you're emulating a fake usb device with the forwarder that just
> transmits requests to diod as backend implementation?
> But 'usb.core.find(idVendor=3D0x1D6B, idProduct=3D0x0109)' looks like it'=
s
> searching for a real device not creating one, so that doesn't seem to
> match up...

diod (9pfs server) and the forwarder are on the development host, where the=
 root
filesystem is actually stored. The gadget is initialized during boot (or la=
ter)
on the embedded board. Then the forwarder will find it on the USB bus and s=
tart
forwarding requests.

It may seem a bit unusual that in this case the requests come from the devi=
ce
and are handled by the host. The reason is that USB device ports are normal=
ly
not available on PCs, so a connection in the other direction would not work=
.

In the future, the functionality of the forwarder could be integrated into =
the
9pfs server. Alternatively, an improved forwarder could also react to udev
events of gadgets showing up and forward them to different 9PFS server over=
 the
network (when you have multiple target devices connected to one USB host).

Perhaps, the inverse setup (9PFS server on the USB gadget side, mounted on =
a PC)
also would be useful in the future and could share some of this code. Then,
you'd have an alternative to MTP.

> If you have any background information on where you're coming from and
> where this is headed it'd be great to include in the cover letter.

Yes. Probably also in Documentation/.

Thanks,
Jan

