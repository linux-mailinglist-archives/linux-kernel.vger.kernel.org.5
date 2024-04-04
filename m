Return-Path: <linux-kernel+bounces-131226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515E8984D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F78B2968C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2806E76035;
	Thu,  4 Apr 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hg8VZYBw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED33D96B;
	Thu,  4 Apr 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225582; cv=none; b=RKYyGQFYyNqbD21AQVI6/Qkx44tJZ4KVB4BZcaIR9pg65f562UEDeqodsXGF9wl7VFbUOd3nABCBtpCNJLx2Ha2Wy3vFWk7X7CZGbampBhFJJLAoKFiH8zkzer8PSZweYcjuxdDI24SzcyzO/aPL70tJK233+5R3Knru4+zn8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225582; c=relaxed/simple;
	bh=4fg9inJNbedbRInZaMC4enjH7MPlO1J/oWaP14XD6d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEVTjlLNR78k+gdj/moc08fVB//sVnJe0IAg/X/MIPpY02f+HjRhOK/ppyln/KgKTHuFusvCOMT30BWJnqw+Bqb72/4rNemypLro+5zqPOwpghZrWOa1hYAaoSij7G7dCsP4DRCU8CbyPT/pHckD9951+36ckN1fhAFQtIOhyWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hg8VZYBw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712225578; x=1743761578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4fg9inJNbedbRInZaMC4enjH7MPlO1J/oWaP14XD6d8=;
  b=Hg8VZYBwD/hdUyY2N+YORQGaCYCZu4IgsnLDRlVcabqvRxo5MIzppgSu
   th/PfNk1X1hs8/eqiI44FoyaWCEkHWw7ECbCxgYbGlvYWZ3bA6bqUlC1l
   sfQNzjv6DIvY2oeGoNJP63dwpytzwrXttTtgvGDsV1CXwg2eB2JGhJrPy
   lav0ATPh0lIjA1TKERnAM62qSZ2I9m4TRmN/YRtimLreUM7y0XNRe7su1
   6BNegYTiGRhXHA5BJo2aB+nv1s9iKtA5Lb6A+oQtEi4XoVRD0OgiJ7R47
   2mx7iUimtgN7hc76XnwEejeZBNc5AXOud4JEtC8rA8T9C3gvLUhGxS+As
   Q==;
X-CSE-ConnectionGUID: 9yCDK68WTt2rveY3bD5/xw==
X-CSE-MsgGUID: e9QkaufkSbuRl2Tu6d0lcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18852574"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18852574"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 03:12:56 -0700
X-CSE-ConnectionGUID: NvVrsfnTQOOCA8SlitGbUA==
X-CSE-MsgGUID: lAbIT/5FSwS+rqoDjBoEFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18856074"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 03:12:53 -0700
Date: Thu, 4 Apr 2024 12:12:38 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>, Yury Norov <yury.norov@gmail.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Netdev <netdev@vger.kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 19/21] pfcp: always set
 pfcp metadata
Message-ID: <Zg59Ck+XBO5vhlOL@mev-dev>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <20240327152358.2368467-20-aleksander.lobakin@intel.com>
 <701f8f93-f5fb-408b-822a-37a1d5c424ba@app.fastmail.com>
 <Zg520gCPr+65sf5l@mev-dev>
 <5afd6f21-4f0e-442f-a970-77195b355a0e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5afd6f21-4f0e-442f-a970-77195b355a0e@app.fastmail.com>

On Thu, Apr 04, 2024 at 11:56:29AM +0200, Arnd Bergmann wrote:
> On Thu, Apr 4, 2024, at 11:45, Michal Swiatkowski wrote:
> > On Wed, Apr 03, 2024 at 10:59:36PM +0200, Arnd Bergmann wrote:
> >> On Wed, Mar 27, 2024, at 16:23, Alexander Lobakin wrote:
> >> 
> >> The memcpy() in the ip_tunnel_info_opts_set() causes
> >> a string.h fortification warning, with at least gcc-13:
> >> 
> >>     In function 'fortify_memcpy_chk',
> >>         inlined from 'ip_tunnel_info_opts_set' at include/net/ip_tunnels.h:619:3,
> >>         inlined from 'pfcp_encap_recv' at drivers/net/pfcp.c:84:2:
> >>     include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> >>       553 |                         __write_overflow_field(p_size_field, size);
> >> 
> >> As far as I can tell, the warning is caused by the
> >> ambiguity of the union, but what I noticed is that
> >> it also seems to copy a buffer to itself, as 'md'
> >> is initialized to tun_dst->u.tun_info as well.
> >> 
> >> Is this intentional?
> >
> > I used ip_tunnel_info_opts_set() to set options_len and flags.
> > You are right that it can and probably should be changed to:
> >
> > __set_bit(IP_TUNNEL_PFCP_OPT_BIT, tun_dst->u.tun_info.key.tun_flags);
> > tun_dst->u.tun_info.options_len = sizeof(*md);
> >
> > instead of copying the buffer. Thanks for pointing it.
> >
> > Should I sent a fix to the net or patch to the maintainer? Sorry, don't
> > know how this kind of situations are being solved.
> 
> I tend to just send fixes when I run into build problems like this,
> but since you already know what's going on, I think it's best if
> you send the fix as well, citing the warning I mention in the commit
> log, and explaining that the warning can be avoided by the simpler
> code but is otherwise a false-positive.
> 

Thanks, I will sent the fix ASAP.

Michal
>      Arnd

