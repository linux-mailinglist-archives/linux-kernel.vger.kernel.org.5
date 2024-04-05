Return-Path: <linux-kernel+bounces-133120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBD2899F26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CAA1C22202
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971216EBEA;
	Fri,  5 Apr 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qmTEIYh+"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70C16D4FD;
	Fri,  5 Apr 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326384; cv=none; b=sZhKFdyt+m6wZN65FqF6iGFU/0vNMHIxS1XmuYjXYMnUL0QdCm4lypAYRYbQiI+n2ibRci8gcskcr/1ZuujJEDCnCrP0kCbn+QvPukgh4YLwsZElczqCo445SCWp4Dpf+fhTV6cCxi+kMw/bC78GoXeOLuvCxBpCBHvxb2/IJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326384; c=relaxed/simple;
	bh=HPIt9psmFPVnp7r7+Zh3KzoyVHWbAy48PqCYi0Pu4IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od8TLpxEa/dbdD7uqSJTVlfwOCjwkiv4Fje+HpFTXXKvVZsAH9+gjIKWghlPfmkGjpgqzrX92Z7+j2vgCG2XRw978MRfJpQjl8eBlq0jzkhNwEdxcg1VL2n4o8bJtcBOkMVYXmV9QwDdyir9wKd8rwAubAtKDRGazNjQdBNUze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qmTEIYh+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9qdf+0eilDJvsPS3nOJaMxfRkKXZWsVah0onHb0dxbo=; b=qmTEIYh+8dnT3oGS9xU3I5O5Je
	M/1zRWZkNUIc0RE8GUgi4kaoY0yQcdvSyRBavgk1+7QJqTeKWj6INlAc7vgcG72DqRoLthwt/m4iJ
	qQfTTy45ANvYBxa8LrVD4VRqsMTY7/PNyBEOCfeiODYjhmgNoyhosuwe7gONuIvN0cy4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rskJG-00CJEz-FA; Fri, 05 Apr 2024 16:12:50 +0200
Date: Fri, 5 Apr 2024 16:12:50 +0200
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
Message-ID: <f6d9db1c-bde2-4704-a3cf-69e84a5a6fd3@lunn.ch>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
 <20240405133731.1010128-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405133731.1010128-2-aleksander.lobakin@intel.com>

On Fri, Apr 05, 2024 at 03:37:25PM +0200, Alexander Lobakin wrote:
> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
> ("net: remove NETIF_F_NO_CSUM feature bit") and became
> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
> Remove this bit waste.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/netdev_features.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
> index 7c2d77d75a88..44c428d62db4 100644
> --- a/include/linux/netdev_features.h
> +++ b/include/linux/netdev_features.h
> @@ -14,7 +14,6 @@ typedef u64 netdev_features_t;
>  enum {
>  	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
>  	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
> -	__UNUSED_NETIF_F_1,
>  	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
>  	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
>  	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */

Are you sure this enum is not ABI?

It would be good to add an explanation why it is not ABI to the cover
letter.

	Andrew

