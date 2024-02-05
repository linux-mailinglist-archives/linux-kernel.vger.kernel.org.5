Return-Path: <linux-kernel+bounces-52776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449EA849C8D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E68B28AB3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C024B26;
	Mon,  5 Feb 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xc02vhhA"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118D23753;
	Mon,  5 Feb 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141838; cv=none; b=TOwLcgwLWB36JwLhOjPWa5dlRF4pa/CSn0tf9JW5MPgSJT+Pvl23HXaNF2l5FOx8crM6MvENTO8qtejTHa+cRjE13nshv398Wxayv0Mfy5lbWuP+HNVsbzRJzkYNguRZAX9QVkJLIGtyOWT92VDzNNMPvkie7/NVW1FzgBMCk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141838; c=relaxed/simple;
	bh=R9m0seibPqVjuMRXRCtFH8OBXcYn9UV3bCtWarP4u4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmfNUKpIO3eTy0zCFqO1bFzrkoHGgA8loee0jROtI11SSfDbapNoBkMJbanGyL0GhdGtIaA3B4cOnfttQ0zBto3vuGXSrxsrfLeOTAYv48z/Xe9GviIMOm1SxpH2DR1khP9he4LFZsbW9IUL82KNdbpLAaT68fLszTw9cxMa/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xc02vhhA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T9hBFBJxGOqEN46Rzq3IDVzYp56XQV1MU7sVARX8R3k=; b=Xc02vhhAaIX2iWZ94yDZOmR6CY
	Uu5VlriWFu85b//G2mCV1xXSsllr8YEVdKyh5S+ym+eBG3c4j4u9aiSo4zuiRYjQ6zLxHBOt3d+U3
	0HS69k/gU8sE5I5u9Xa5kCKG/xxCMy8KsqP9ZEkB4O2esPT5lFonAnzdKTMmAfA98U6g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWzZZ-0072Jq-Ms; Mon, 05 Feb 2024 15:03:45 +0100
Date: Mon, 5 Feb 2024 15:03:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Grant Grundler <grundler@chromium.org>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: asix: add 0b95:1790 to AX88179A device list
Message-ID: <ea413b7f-2086-482c-b2e6-77817acf4168@lunn.ch>
References: <20240205104049.48900-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205104049.48900-1-christianshewitt@gmail.com>

On Mon, Feb 05, 2024 at 10:40:48AM +0000, Christian Hewitt wrote:
> Add a generic AX88179A entry for the 0b95:1790 device id:
> 
> kernel: usb 2-1: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 2.00
> kernel: usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> kernel: usb 2-1: Product: AX88179A
> kernel: usb 2-1: Manufacturer: ASIX
> kernel: usb 2-1: SerialNumber: 00D24DC0
> kernel: asix 2-1:1.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x0000: -32
> kernel: asix: probe of 2-1:1.0 failed with error -32
> kernel: ax88179_178a 2-1:1.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x0040: -32
> kernel: ax88179_178a 2-1:1.0 eth1: register 'ax88179_178a' at usb-0000:01:00.0-1, ASIX AX88179 USB 3.0 Gigabit Ethernet, 20:7b:d2:d2:4d:c0
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> The change is tested by a LibreELEC (distro) user who reports the NIC to be working
> fine (and logs support this) but the "Failed to read reg index 0x0000: -32" errors
> suggest ax88178_info might not be the correct choice. I'm not a serious coder so I
> need to "ask the audience" for suggestions on what more might be needed?

I would probably start by determining what ax88179_read_cmd() is
causing that print. Maybe print in addition cmd, and value. Or add a
WARN() so you get a stack trace.

It might be possible to figure it out by just looking at the code. How
many places actually pass index=0?

       Andrew

