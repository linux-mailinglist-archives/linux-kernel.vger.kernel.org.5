Return-Path: <linux-kernel+bounces-131201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3502B898464
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AB9B24014
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BC474C0D;
	Thu,  4 Apr 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWsFBJlc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570F74438;
	Thu,  4 Apr 2024 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224142; cv=none; b=U5BPLZQXU1XJb/4GZAaB/0nFtqe9SZt1p1BiWHjvkIZRUZHHZzOslvTBtDx+lwOL8+/wKvP97GQ59cW4A8D58X2I4RdrceTSKvnkZZIp6ExquFeAU1UP1+rpWBFbaXQ3s/RYg3rwlp6yVABDCudY7R8HcXu2DClRJBl1np1rioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224142; c=relaxed/simple;
	bh=HtkXVwM+iFAGGvr+kUD0dRiyp1DbZhZOQzSip15beRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onz9bQSe76F3rtV7yeWdiSE/6F5Au1AzMOlZ3vesf3aQJ1v0ekkT7mVvWWTi5qeFjLWojo0fSJs9v25P/EkvZSMkSUiNb3pJxYzXViBSlWzHba5/4FtELEAb8G9r7/EF6TEJM1cosP2FGsbs2zJkxO2hzP8p9jFeWuuvvqcrfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWsFBJlc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712224138; x=1743760138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HtkXVwM+iFAGGvr+kUD0dRiyp1DbZhZOQzSip15beRo=;
  b=VWsFBJlcBTH1tLnwXNgjQezZM5kk21qupomVMp2eRC39bhK3DcE2DK/O
   6M3/1rym143ubfDrH8Cnpv+/feSu5wTKgVGloI+1C+BXVT0vTKgiaS7Tj
   rYIZTq8EQPNq8Hk0KepkXSzYQRRclZiT1syl0SNg3Y9LXfobd1ZsMjic3
   O8h6NaG2t2JXesDXF9bf4+o5qgmUZhknMem1dHox/gCkLDoqMO0qOmeWp
   0EOhWsiXK5J6wwhjvOI/j1RpsR86N1wsfCi+7FySHAzUogpe68QnyH7gQ
   5aa9ivgli33JPvzZgmsHGTyWTL6vn9kMK/+MRMRCO0Cdky99TIixYZ9tP
   Q==;
X-CSE-ConnectionGUID: qbbmrJ7lQJawOnen1crRmw==
X-CSE-MsgGUID: uCElAF3gSHy8LikxCd7HhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7393419"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="7393419"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:46:13 -0700
X-CSE-ConnectionGUID: ++d9YZT8TDytdMV2c2L46w==
X-CSE-MsgGUID: WqeOzf9OQeK8oCmECxYFYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="41898069"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:46:09 -0700
Date: Thu, 4 Apr 2024 11:45:54 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH net-next v6 19/21] pfcp: always set pfcp metadata
Message-ID: <Zg520gCPr+65sf5l@mev-dev>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <20240327152358.2368467-20-aleksander.lobakin@intel.com>
 <701f8f93-f5fb-408b-822a-37a1d5c424ba@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701f8f93-f5fb-408b-822a-37a1d5c424ba@app.fastmail.com>

On Wed, Apr 03, 2024 at 10:59:36PM +0200, Arnd Bergmann wrote:
> On Wed, Mar 27, 2024, at 16:23, Alexander Lobakin wrote:
> 
> > +static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
> > +{
> > +	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
> > +	struct metadata_dst *tun_dst;
> > +	struct pfcp_metadata *md;
> > +	struct pfcphdr *unparsed;
> > +	struct pfcp_dev *pfcp;
> > +
> > +	if (unlikely(!pskb_may_pull(skb, PFCP_HLEN)))
> > +		goto drop;
> > +
> > +	pfcp = rcu_dereference_sk_user_data(sk);
> > +	if (unlikely(!pfcp))
> > +		goto drop;
> > +
> > +	unparsed = pfcp_hdr(skb);
> > +
> > +	ip_tunnel_flags_zero(flags);
> > +	tun_dst = udp_tun_rx_dst(skb, sk->sk_family, flags, 0,
> > +				 sizeof(*md));
> > +	if (unlikely(!tun_dst))
> > +		goto drop;
> > +
> > +	md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
> > +	if (unlikely(!md))
> > +		goto drop;
> > +
> > +	if (unparsed->flags & PFCP_SEID_FLAG)
> > +		pfcp_session_recv(pfcp, skb, md);
> > +	else
> > +		pfcp_node_recv(pfcp, skb, md);
> > +
> > +	__set_bit(IP_TUNNEL_PFCP_OPT_BIT, flags);
> > +	ip_tunnel_info_opts_set(&tun_dst->u.tun_info, md, sizeof(*md),
> > +				flags);
> > +
> 
> The memcpy() in the ip_tunnel_info_opts_set() causes
> a string.h fortification warning, with at least gcc-13:
> 
>     In function 'fortify_memcpy_chk',
>         inlined from 'ip_tunnel_info_opts_set' at include/net/ip_tunnels.h:619:3,
>         inlined from 'pfcp_encap_recv' at drivers/net/pfcp.c:84:2:
>     include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>       553 |                         __write_overflow_field(p_size_field, size);
> 
> As far as I can tell, the warning is caused by the
> ambiguity of the union, but what I noticed is that
> it also seems to copy a buffer to itself, as 'md'
> is initialized to tun_dst->u.tun_info as well.
> 
> Is this intentional?

I used ip_tunnel_info_opts_set() to set options_len and flags.
You are right that it can and probably should be changed to:

__set_bit(IP_TUNNEL_PFCP_OPT_BIT, tun_dst->u.tun_info.key.tun_flags);
tun_dst->u.tun_info.options_len = sizeof(*md);

instead of copying the buffer. Thanks for pointing it.

Should I sent a fix to the net or patch to the maintainer? Sorry, don't
know how this kind of situations are being solved.

Michal

> 
>       Arnd

