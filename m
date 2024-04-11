Return-Path: <linux-kernel+bounces-140631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB78A1705
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C055285CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4614E2FC;
	Thu, 11 Apr 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rnDBtNWs"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502D14D708;
	Thu, 11 Apr 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845268; cv=none; b=NAC4bG8Q9evXEDf/663xTABHGq8dwPjVBbNtDFgiwGKpgfyDJZUeSqu/h8QpqvTBTg3ZAe24YbDbz4/GjFaCN6iHOGPvAdL7fw4WhiC3x1SDKLbK5N7peaDMPAm6lhNoyJEeBMFWqyR/3x4HhPXt2jKwwFyAM/0NaDXzgx88uHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845268; c=relaxed/simple;
	bh=l7j7GLxWdevX8j9nxH2gEq+1VH4ij6kA0ZV6FEUWLa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZBnf37170TR/ypWHHJen/ERAza/WP+9SIO8tKGjMAp/YuIvPpglwUDYBbdPTXSVdT2mzcjW/n4hJtJlGeN178OXEoO7DDryIcFafTFtr31l6bZCv9vaYMx8ya+LuAET9Da85F5757/ZRj1kk3dPfaaXmGet8rdTA+O7CCT+jZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rnDBtNWs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q/oJU7Vy/d+vtAVhKgDsRx9ErkPhiN/5itGbIlcfFwo=; b=rnDBtNWsysuvAwGzBDHwwnBkXg
	n5T7i19Z9E2zXsQ1lOP2+QwHBzLlA2kBNCCPHXPjxcGby5m53CvpLxeJTDMiVY38gdYoRumxPnNl8
	NbzHpZj26dxhQwA+VSLyPMvPXJhsqzLW6AZ+Nc4ohMmGpr9Kv3XJfxBIB4t1QWIcj3k0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ruvIJ-00CmSb-42; Thu, 11 Apr 2024 16:20:51 +0200
Date: Thu, 11 Apr 2024 16:20:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 7/7] netdev_features: convert
 NETIF_F_FCOE_MTU to IFF_FCOE_MTU
Message-ID: <a9a45958-fac1-4523-96f7-19cf0b375395@lunn.ch>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
 <20240405133731.1010128-8-aleksander.lobakin@intel.com>
 <20240408193806.18e227c8@kernel.org>
 <1f14cb75-ee6b-4a7d-9041-23a8cfcd8476@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f14cb75-ee6b-4a7d-9041-23a8cfcd8476@intel.com>

> >> @@ -47,7 +47,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
> >>  
> >>  	[NETIF_F_FCOE_CRC_BIT] =         "tx-checksum-fcoe-crc",
> >>  	[NETIF_F_SCTP_CRC_BIT] =        "tx-checksum-sctp",
> >> -	[NETIF_F_FCOE_MTU_BIT] =         "fcoe-mtu",
> > 
> > 
> > But this definitely _is_ a uAPI change, right?
> 
> Why?

That it is not obvious why this is not a uAPI change makes it clear
this needs explaining in the commit message.

     Andrew

