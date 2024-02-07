Return-Path: <linux-kernel+bounces-56394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685F84C9A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F882879A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD841B582;
	Wed,  7 Feb 2024 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJDQcUvN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F731B7E3;
	Wed,  7 Feb 2024 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305595; cv=none; b=o2W0y1plV8AS9bu/3mL4PibacUb+k+HpjjrTkFtrbnNT7djptWcW7+l5W/xklwf6FtS2FGHHnOiZ6FqQzoG+8DWt/h0bUYyonEB/GebN61JwmDFEZivlOz60YEiVNw0eBUjEb1U+JEp9U/mdR1hzlPUpzWSRZ1fDece9PmU4Chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305595; c=relaxed/simple;
	bh=gyo235aVjYRC8Ovs+OpeW93VAIBVmWCkzUNg5AzcKdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYMFoJVgFOKq4TQJh2a9KCFLawAIeM8GPAXL9UiiVOwH4iLvSMUGwe7mdXD41nSGPsaZenI1boLU+2MC70PlyKkw1t0lwjEZercEjbayx4Mcp9wVkAM2CTWqr8pfA2K+Vml53o1Sa8C2ggsZutSOT78KRNyQtT0pom/N1QeOE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJDQcUvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE73BC433F1;
	Wed,  7 Feb 2024 11:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707305595;
	bh=gyo235aVjYRC8Ovs+OpeW93VAIBVmWCkzUNg5AzcKdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJDQcUvNMSiZKwfV3rUCNm+SBPvaChR9vz6jg+V3OXMgkDZOflWgwJKWXltXsoZiI
	 Inp2SU+sfh7n3lQmqxIH7JQe7BglD+sxDMG/oFV5EBCXUrpaBoGjsD03E6X+DbUdSl
	 kw7rrAHbUPxsy7tfDREpIJf0ND2Tt73vQBRV4gKgDDLKvkTD0pSz09QZWqs+m5ta/z
	 WagrgrNvX3fOyyDk8Y7YWh+t13O7mnTaTsTO/I7B5WY90M+TlXVWJrq+S1xiemIcpK
	 JAnHAx/i/chC5vsQRSvvbT/DEIWwq07gyTh699/5YwZTm8EjbbMf0XCPCj+Ni9/R/4
	 lxpDK8A7BTCfQ==
Date: Wed, 7 Feb 2024 11:33:10 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net v2 5/9] net: fill in MODULE_DESCRIPTION()s for ipv6
 modules
Message-ID: <20240207113310.GC1297511@kernel.org>
References: <20240207101929.484681-1-leitao@debian.org>
 <20240207101929.484681-6-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101929.484681-6-leitao@debian.org>

On Wed, Feb 07, 2024 at 02:19:24AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the IPv6 modules.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

..

> index a7bf0327b380..8820bf5b101a 100644
> --- a/net/ipv6/ip6_udp_tunnel.c
> +++ b/net/ipv6/ip6_udp_tunnel.c
> @@ -182,4 +182,5 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL_GPL(udp_tunnel6_dst_lookup);
>  
> +MODULE_DESCRIPTION("IPv6 UDP tunnel driver");
>  MODULE_LICENSE("GPL");

Hi Breno,

I don't feel strongly about this,
but looking at NET_UDP_TUNNEL and NET_FOU in net/ipv4/Kconfig, maybe:

	IPv6 Foo over UDP tunnel driver

Likewise for the change to net/ipv4/udp_tunnel_core.c
in the following patch.


The above not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

..

