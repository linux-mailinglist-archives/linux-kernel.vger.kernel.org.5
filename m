Return-Path: <linux-kernel+bounces-133276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E1C89A196
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3591C23056
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75516FF30;
	Fri,  5 Apr 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kgerwkWI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C516F909;
	Fri,  5 Apr 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331727; cv=none; b=nGcK5LKZOEHJRFgZ1xaPaynmZYA0SFQP445vhyf1CJFjs0HQIbP7sVzgEAYT65XBa6moNPQXYl2MadjLg5b4Br5NXw/gSdhpGOKtfVBzmbtqixtTqJZz2bSXnAwdzMUmtWR6wJxqGvyW4XvDMz0eFRSMCfRlVTadC0KxEcncAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331727; c=relaxed/simple;
	bh=akVLxZ0gpLRY8TlRqVNs9BhyJy3GXMw2rIkL1JXP3Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6RNVKxbhiVhQbNJfulnIw+IiNY/95PU/5z6ujsMe6CR0Bzj9Sk7BkChJtS4SShyh2z1QbeixynCnGFZwoJgGis17IIjhbp0rXpS5KAcORvdx6bawguVUYevcnMqT90h+oJSQEXQwcw4lRITUOAeXRpK26mSqLgxoTjK4oJVYn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kgerwkWI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S57qMLoX/N03NSRqT8ItgFLssRfNbaxDJ602DHQX86Q=; b=kgerwkWIGchJgjxLMSKV8H6iVL
	gi7daibq/FhGvRLZuOJf2aspraCNzLS6tI6gpqI2VD2AzNz1XzHmM827BBenkUgJSUzEuB53d3s5a
	DVbT4O0eFc3ZMMh5IM+6SH5qVNBw9J9r1+y3rH2JEQqQBwljyShFWuqGH+0LeQ8XY9dE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rslhL-00CJiq-KA; Fri, 05 Apr 2024 17:41:47 +0200
Date: Fri, 5 Apr 2024 17:41:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/7] netdev_features: remove unused
 __UNUSED_NETIF_F_1
Message-ID: <10a14ce9-1cbb-4906-8363-99c8fc3c7fb6@lunn.ch>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
 <20240405133731.1010128-2-aleksander.lobakin@intel.com>
 <f6d9db1c-bde2-4704-a3cf-69e84a5a6fd3@lunn.ch>
 <bbdb5c3c-1a2a-4fa3-8e08-2e1a3fc51b85@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbdb5c3c-1a2a-4fa3-8e08-2e1a3fc51b85@intel.com>

On Fri, Apr 05, 2024 at 05:15:58PM +0200, Alexander Lobakin wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Fri, 5 Apr 2024 16:12:50 +0200
> 
> > On Fri, Apr 05, 2024 at 03:37:25PM +0200, Alexander Lobakin wrote:
> >> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
> >> ("net: remove NETIF_F_NO_CSUM feature bit") and became
> >> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
> >> Remove this bit waste.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> ---
> >>  include/linux/netdev_features.h | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
> >> index 7c2d77d75a88..44c428d62db4 100644
> >> --- a/include/linux/netdev_features.h
> >> +++ b/include/linux/netdev_features.h
> >> @@ -14,7 +14,6 @@ typedef u64 netdev_features_t;
> >>  enum {
> >>  	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
> >>  	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
> >> -	__UNUSED_NETIF_F_1,
> >>  	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
> >>  	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
> >>  	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
> > 
> > Are you sure this enum is not ABI?
> 
> Why should this be ABI? It's not a part of UAPI and Ethtool receives
> these bits together with string names.

As a reviewer, i think about ABI. When looking at a change like this,
it is the first thing i think of. Our code is not always clean, there
could well be things outside of include/uapi which influence the
ABI. For some reason ("net: remove NETIF_F_NO_CSUM feature bit")
renamed rather than removed it? Why?

I assume you have looked into the code in this respect, you have
tested both and ioctl and netlink code, and concluded it does not
cause an ABI change. It could of been removed in 3.2-rc2. But i don't
see anything in the cover letter or commit message which indicates you
have done that. That is partially what the cover letter and the commit
message is about. Explaining things you have done, but cannot be seen
in the code change.

	Andrew

