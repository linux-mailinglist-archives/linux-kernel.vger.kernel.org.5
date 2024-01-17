Return-Path: <linux-kernel+bounces-28867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267718303F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6841F25B75
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9536F1CFB9;
	Wed, 17 Jan 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Y80toRAW";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="t+n8lC+5"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735714AA5;
	Wed, 17 Jan 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488922; cv=none; b=NW/09ZXO1kdIMweXFCmWwtk+8i3WS8A6bQwGD3CF+B3Br9R5EAORJFw4Lr2blRYcYAr9CWN4oL+g2N9urTyQb8HqLwv7vwz39fQ87yhuemx5N/TCBeNbGYA3qLfNpvDpQCEMgm2Yv/8SKc2tBqrIPhgir8ZaKQ4cft8QbDM5HXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488922; c=relaxed/simple;
	bh=X7ri6/DC7dQ0k7GmkIF8uzW4YU+DeXLsZrOtnLLUppM=;
	h=Received:DKIM-Signature:X-Spam-Checker-Version:X-Spam-Level:
	 X-Spam-Status:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=ehmvPuxaPYzQV4ZxmFiOILtNlKiS1vv8HsDm4smKV7DrH+wNMCS9jzJa0z2qGr4pRWR6FsgGADmxoBVN5CP4IVxZAYV67WLnaHvMfdnwOM4NpWCJv9yXwJ26tf91bsEzUqbABjZNUVDCb5a5wVJKpAKfqEYxypI7y7TV1PcROBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Y80toRAW; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=t+n8lC+5; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id D3D05C020; Wed, 17 Jan 2024 11:55:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1705488917; bh=QPQ1kHwkpR/bSo/5dfdZfVGrQA0NVwMsugmiUUBqUUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y80toRAWRVoIuFVFMKt8O9CH9+xIjHlZIcq0xVi94TZUHBF9cwWdav3kqOXFW9J/U
	 k8RaIOlzOZc0z/7MJ4MqxnKiO9m0DEQ7TdvvpvcZH44Q1CsJXDOpOfHJaeZrBltCtZ
	 /ltzVpUFNJpTg75NCLpAVWwTW9IPwiGyXnU+aKDtUbgdmZjb+/mmyg0D3ERy9O3KUL
	 KeGqo3jtpMDeDZX1JClvR9uGV9vM7BlvpqpEyeeYIXd/mu1sGy8SKUxUKZAo6dhByx
	 MiTx+tLd2cptwL8pHDLbjQ/gWRnW8h4veeWdpUFffxclpnhYHpYnih2T0l69Ys0XJf
	 H3NYWSe98cZCw==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 1EC8DC009;
	Wed, 17 Jan 2024 11:55:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1705488916; bh=QPQ1kHwkpR/bSo/5dfdZfVGrQA0NVwMsugmiUUBqUUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+n8lC+5sdDFiHuENr4ruAOhrP5KsC2TfPzE81RyUjeCaSeWq1Dg/N1SuVOBLU2wZ
	 I01/y48CGIUHlPrJqda07B7OR1HfSzbXAy7LnjE3JBYZx0RJdUQtGBx3QNeGyecCee
	 d8XqzNq5hdZmQHtk0uAnxxBuVXEUiQcK5k9n0dLNk5rDtC9QSK4F78HD0C4r58yLMq
	 NlHGvCDqQ9UNxn8MdSvQcxv0gn/OxysVNbNSTao35v8v+r12I3GbnpxD4lyu4p9gr4
	 1YPEFUO6ItprrRyMSqSKD23o+ZU/dQfP8uTFpNqWozhLSRZeynqlqq8oSkp1cbkm5y
	 JuP4s6mfnz8zw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9ed4a2fc;
	Wed, 17 Jan 2024 10:55:08 +0000 (UTC)
Date: Wed, 17 Jan 2024 19:54:53 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jan =?utf-8?B?TMO8YmJl?= <jlu@pengutronix.de>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Latchesar Ionkov <lucho@ionkov.net>, linux-usb@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	v9fs@lists.linux.dev,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH 0/3] usb: gadget: 9pfs transport
Message-ID: <Zaex_fkKcui7QZd7@codewreck.org>
References: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>
 <ZaZsUQUhSlMPLJg0@codewreck.org>
 <0aba51a8be0fb165b44ec956bec7a9698a9518a2.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0aba51a8be0fb165b44ec956bec7a9698a9518a2.camel@pengutronix.de>

Jan Lübbe wrote on Tue, Jan 16, 2024 at 04:51:41PM +0100:
> > So I didn't have time to look at everything through, just want to make
> > sure, this series allows sharing data from an usb gadget (e.g. some
> > device with storage) over 9p as an alternative to things like MTP ?
> 
> It's the other way around. :) The USB host exports a filesystem, while the
> gadget on the USB device side makes it mountable. Our main use-case is to use it
> as an alternative to NFS root booting during the development of embedded Linux
> devices. NFS root works in many cases, but has some downsides, which make it
> cumbersome to use in more and more cases.

Oh!
Okay, this makes a lot more sense. And that'll need a bit more
explanations in the commits & Documentation/ as you've concluded :)


> NFS root needs correctly configured Ethernet interfaces on both the development
> host and the target device. On the target, this can interfere with the network
> configuration that is used for the normal device operation (DHCP client, ...).
> For the host, configuring a NFS (and perhaps DHCP) server can be an obstacle.
> 
> For target devices which don't have a real Ethernet interface, NFS root would
> also work with the USB Ethernet gadget, but this increases the complexity
> further.
> 
> As many embedded boards have a USB device port anyway, which is used during
> development for uploading the boot-loader and to flash filesystem images (i.e.
> via the fastboot protocol), we want to just reuse that single data cable to
> allow access to the root filesystem as well. 
> 
> Compared to flashing images, using a network filesystem like NFS and 9P reduces
> the time between compiling on the host and running the binary on the target, as
> no flash and reboot cycle is needed. That can get rid of many minutes of waiting
> over a day. :)

My other hat is on embedded development (dayjob at Atmark Techno[1], the
only english page linked is about 4 years out of date but I guess it's
better than no page at all), so I can understand where you're coming
from -- thanks for the background.

[1] https://www.atmark-techno.com/english

That means I'll actually want to test this, but kind of always busy so
it might take a few weeks...
Or better, do you happen to know if qemu can create a USB controller
that supports OTG so it'll be easy to test for folks with no such
hardware?
We've got enough 9p protocols that aren't actually tested on a regular
basis, it'd be great if we could have something that can run anywhere. 


> diod (9pfs server) and the forwarder are on the development host, where the root
> filesystem is actually stored. The gadget is initialized during boot (or later)
> on the embedded board. Then the forwarder will find it on the USB bus and start
> forwarding requests.
> 
> It may seem a bit unusual that in this case the requests come from the device
> and are handled by the host. The reason is that USB device ports are normally
> not available on PCs, so a connection in the other direction would not work.

Right, most host PCs won't have OTG available...
I was also perplexed by the linux foundation (0x1d6b):0x0109 id, that
might be clearer once it's properly documented -- I'll let someone from
the usb side chime on this as I have no idea what's appropriate.


> In the future, the functionality of the forwarder could be integrated into the
> 9pfs server. Alternatively, an improved forwarder could also react to udev
> events of gadgets showing up and forward them to different 9PFS server over the
> network (when you have multiple target devices connected to one USB host).

Plenty of potential work ahead :)
Frankly at this stage I don't think it's much simpler than e.g. CDC
ethernet gadget and mounting nfs over tcp, but with further improvements
it can definitely get simpler.


> Perhaps, the inverse setup (9PFS server on the USB gadget side, mounted on a PC)
> also would be useful in the future and could share some of this code. Then,
> you'd have an alternative to MTP.

(Yeah, I'm not actively looking for that -- was just asking because MTP
has been kind of dead lately and I'm not aware of any potential
alternative, but I didn't go looking for them either -- let's leave that
to later)

-- 
Dominique Martinet | Asmadeus

