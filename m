Return-Path: <linux-kernel+bounces-109323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E4B881795
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6A11F22780
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDD285627;
	Wed, 20 Mar 2024 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GW9UWxDS"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674A1E4AD;
	Wed, 20 Mar 2024 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961040; cv=none; b=QalfBi6RJwLd/LMCBk3uAjMw1X9iRei3cmPW0/lL4OoAxe6ttvqpbXC/h+lipY8KEQ2PsaosdDv3uCGQHWAw9Kegk5N2Pwlb6tAdUBxCp9zc31AsH54ql6qSY3lKrtqc95N/WrQHFW2uLT17o3qsgg8BGpJ7NvEmrRU17L8PXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961040; c=relaxed/simple;
	bh=Igur+ST22ucZbbutrgiQ3PXgj+k3Gv2Nd/xFZ8mGSWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okESk08/KDAnJeb0srobOA8F3BKeinAoTnInhKP8Hqfr09m/97fi2Utj/4YkxUeo0JRE8O38PgEIVBn5/ipuAPQ0TNPid+VfYPlEGRadJPhJfVL7CxigYshob5CCe/vatfUkc67aDdSW5bO4IGn1XHNNC4SyMjc24tvi5r7DQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GW9UWxDS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u5PQvM3epMT5XzIgzOnyWl6WvqIUgL5aXdBDmyi5TZI=; b=GW9UWxDSSjOGgTNeMaWfBl32pA
	XrdXlPWa36gP6XLnsmw3Bx2ZuTzzpI123tNM8awaI7a3EUgB8/6SqgqIXG4d6KmqytDYR6HT25/Bh
	/jAqEG9UdOsRAu+xk+HgfmAT0VMBPUlF5N/wtvd8a/b+lv0EkmLw9Mpu/pEANZBXhtn0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rn17Y-00AoGr-Jz; Wed, 20 Mar 2024 19:57:04 +0100
Date: Wed, 20 Mar 2024 19:57:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Message-ID: <793649ff-990c-46f0-9132-bc6e95fcb94f@lunn.ch>
References: <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>
 <Zfrt_dlYvBzlxull@nanopsycho>
 <c76c95af-71cb-4eb6-b3af-846ae318d18d@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c76c95af-71cb-4eb6-b3af-846ae318d18d@solid-run.com>

> With separators ('!') we have:
> cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdio
> cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdio-external
> Truncated to MII_BUS_ID_SIZE:
> cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi
> cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi

This has been made worse by the DT maintainers wanting
ethernet-switch@4, not switch@4. And i guess config-space was also
something shorter in the past.

I think your idea of cropping from the beginning, not the end, is in
general a good solution. However, is there any danger of

cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdio-external

and

cp1!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdio-external

I assume the two instances of cp have the same peripherals, at the
same address?

Another option would be if the name needs to be truncated, use the
fallback as if there was no np:

                bus->name = "mv88e6xxx SMI";
                snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);

That at least gives you unique names.

     Andrew

