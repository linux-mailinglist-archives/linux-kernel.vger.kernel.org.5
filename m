Return-Path: <linux-kernel+bounces-40586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF183E2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0650A1F24F48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45F22612;
	Fri, 26 Jan 2024 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B9F2mmXk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC290225AC;
	Fri, 26 Jan 2024 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298447; cv=none; b=bV1llpwcGA9sISpmebVzGoAz9tXm3PqvMnnhdG6CiEHfIiklIOV9IIWjGCQ3lbPoIu2tIeNoaFAEPh+CtmmgMl+DvVe/JHL2Pt8xg3BCdDYQDk6kiHJQVFcNRAgPiswqr0eAF6D5eYPGOUVjzvmYqcdrffbKfga5iv2gr11/eU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298447; c=relaxed/simple;
	bh=mpaehXT92oEyt7WvFKlN6cee4Uxho3u/Xaiy2EFAXr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXSigL4z1pGn32G7sfTk34IkO4f0NqV2JwXRkKbQKmzi5EnYowIrTmk3jIMjpE1ZZHF3hUIiSy1BKfXeFghePi3z3XybQpNqZtbWSzqNzJ5lo3MCWMA05MyvN3XHYMyzMTR00iKjcdpG8V6KOQYAOy2F4oKjnaOUPu1ZB8AVrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B9F2mmXk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706298443;
	bh=mpaehXT92oEyt7WvFKlN6cee4Uxho3u/Xaiy2EFAXr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B9F2mmXkx+PFEFu5mWIP8bluZ6K7yEz+4debiEWRLDhzgM+haHQ+58AMt0kU9LO+C
	 zGLowxhe0OlYY5LK7DcPNfoR9W+gZjAfD9LERc5xAro5FQrMfhuKr9f4f2pmzml62L
	 Fk0bwEift428nbXwp40Zszo42RgdQNEcFOkwCviXZ+Go9BqA+5/vxTifHCaFYRWiuk
	 IgsZ2MNjSeso1B20yB5TeSKLsMSwmR7Mxlx+n+Ki9311lETDnAFmc14rNQCeucAcSi
	 RCUOm3ghgskmXAEqnIjHgnlsKwPvhe3b8i5aOaXyciHoYq3kV7nt+PEcDa3miPJvQC
	 adyqg3vJkrcnA==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D0963780629;
	Fri, 26 Jan 2024 19:47:23 +0000 (UTC)
Message-ID: <80c4e788-65df-4a82-8453-74683289abcb@collabora.com>
Date: Fri, 26 Jan 2024 20:47:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] usb: gadget: 9pfs transport
To: Dominique Martinet <asmadeus@codewreck.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Latchesar Ionkov <lucho@ionkov.net>, linux-usb@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev,
 Christian Schoenebeck <linux_oss@crudebyte.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Eric Van Hensbergen <ericvh@kernel.org>
References: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>
 <ZaZsUQUhSlMPLJg0@codewreck.org>
 <0aba51a8be0fb165b44ec956bec7a9698a9518a2.camel@pengutronix.de>
 <Zaex_fkKcui7QZd7@codewreck.org>
Content-Language: en-US
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <Zaex_fkKcui7QZd7@codewreck.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

W dniu 17.01.2024 o 11:54, Dominique Martinet pisze:
> Jan Lübbe wrote on Tue, Jan 16, 2024 at 04:51:41PM +0100:
>>> So I didn't have time to look at everything through, just want to make
>>> sure, this series allows sharing data from an usb gadget (e.g. some
>>> device with storage) over 9p as an alternative to things like MTP ?
>>
>> It's the other way around. :) The USB host exports a filesystem, while the
>> gadget on the USB device side makes it mountable. Our main use-case is to use it
>> as an alternative to NFS root booting during the development of embedded Linux
>> devices. NFS root works in many cases, but has some downsides, which make it
>> cumbersome to use in more and more cases.
> 
> Oh!
> Okay, this makes a lot more sense. And that'll need a bit more
> explanations in the commits & Documentation/ as you've concluded :)
> 
> 
>> NFS root needs correctly configured Ethernet interfaces on both the development
>> host and the target device. On the target, this can interfere with the network
>> configuration that is used for the normal device operation (DHCP client, ...).
>> For the host, configuring a NFS (and perhaps DHCP) server can be an obstacle.
>>
>> For target devices which don't have a real Ethernet interface, NFS root would
>> also work with the USB Ethernet gadget, but this increases the complexity
>> further.
>>
>> As many embedded boards have a USB device port anyway, which is used during
>> development for uploading the boot-loader and to flash filesystem images (i.e.
>> via the fastboot protocol), we want to just reuse that single data cable to
>> allow access to the root filesystem as well.
>>
>> Compared to flashing images, using a network filesystem like NFS and 9P reduces
>> the time between compiling on the host and running the binary on the target, as
>> no flash and reboot cycle is needed. That can get rid of many minutes of waiting
>> over a day. :)
> 
> My other hat is on embedded development (dayjob at Atmark Techno[1], the
> only english page linked is about 4 years out of date but I guess it's
> better than no page at all), so I can understand where you're coming
> from -- thanks for the background.
> 
> [1] https://www.atmark-techno.com/english
> 
> That means I'll actually want to test this, but kind of always busy so
> it might take a few weeks...
> Or better, do you happen to know if qemu can create a USB controller
> that supports OTG so it'll be easy to test for folks with no such
> hardware?

Maybe dummy_hcd is what you want?

Regards,

Andrzej


> We've got enough 9p protocols that aren't actually tested on a regular
> basis, it'd be great if we could have something that can run anywhere.
> 
> 
>> diod (9pfs server) and the forwarder are on the development host, where the root
>> filesystem is actually stored. The gadget is initialized during boot (or later)
>> on the embedded board. Then the forwarder will find it on the USB bus and start
>> forwarding requests.
>>
>> It may seem a bit unusual that in this case the requests come from the device
>> and are handled by the host. The reason is that USB device ports are normally
>> not available on PCs, so a connection in the other direction would not work.
> 
> Right, most host PCs won't have OTG available...
> I was also perplexed by the linux foundation (0x1d6b):0x0109 id, that
> might be clearer once it's properly documented -- I'll let someone from
> the usb side chime on this as I have no idea what's appropriate.
> 
> 
>> In the future, the functionality of the forwarder could be integrated into the
>> 9pfs server. Alternatively, an improved forwarder could also react to udev
>> events of gadgets showing up and forward them to different 9PFS server over the
>> network (when you have multiple target devices connected to one USB host).
> 
> Plenty of potential work ahead :)
> Frankly at this stage I don't think it's much simpler than e.g. CDC
> ethernet gadget and mounting nfs over tcp, but with further improvements
> it can definitely get simpler.
> 
> 
>> Perhaps, the inverse setup (9PFS server on the USB gadget side, mounted on a PC)
>> also would be useful in the future and could share some of this code. Then,
>> you'd have an alternative to MTP.
> 
> (Yeah, I'm not actively looking for that -- was just asking because MTP
> has been kind of dead lately and I'm not aware of any potential
> alternative, but I didn't go looking for them either -- let's leave that
> to later)
> 


