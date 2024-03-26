Return-Path: <linux-kernel+bounces-119040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D82888C306
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CAB1F3CC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59246745E1;
	Tue, 26 Mar 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="Wk8dpn8l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="siTAPSSM"
Received: from wflow7-smtp.messagingengine.com (wflow7-smtp.messagingengine.com [64.147.123.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92797175F;
	Tue, 26 Mar 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458563; cv=none; b=TDgiEB5wY7s96rr+8nUV0nwEVycB2p9xb9KFPBcFnUhxU1vS5+Ome8p+OBnGN4EuPn97YqKC40Bj40tUM6ewVpR/ae8uWUyW0Nv2/33Ipj2sBNnFk5iTI8cyf0i8DLj1vqa8q1xn/trCoy8pff3sbd18XcRYDJFiA3pnLS9BKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458563; c=relaxed/simple;
	bh=oSY2YQfIp3WxFRdatF3eB/uMvmpALwRM1eoIubbAtzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqwcKaQoHT1T/r668MfAeidJ0STydqnDXskIcaDKr0eVO2HaVlJYGM6+RyjtRHz8rT81a96z+E1TIQg4xHXTzvCPeweeMwNt0hTFkPeMxL7WYBe76DtMmQWYeB6ORopmxFMYm2o5UHyHoH+PxeETX3L40wgf+RXoof/bZ4d15BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=Wk8dpn8l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=siTAPSSM; arc=none smtp.client-ip=64.147.123.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.west.internal (Postfix) with ESMTP id 6DF722CC015E;
	Tue, 26 Mar 2024 09:09:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 26 Mar 2024 09:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711458556;
	 x=1711462156; bh=SbTcD/l8MHa59PyMOlNhqWFEL7/jqCRuzGyHcMwgJkI=; b=
	Wk8dpn8l+B10C7CBICCIzJZJfi2VVlz8+guq8aVnt2gTfW4j3zOAN8R9huB50+66
	geKgdkOvlgEzdrFLhcQ/VjnZfSK4psfnHM99iUHOKF9En3K8x53NC/H8695kFGtc
	d3f52djBiKuhlFoS+W6y8/yOVLWA1Tn8+sUGq2Uh84tRKE1iePDTGSN2VlrbG3j1
	/vgHK/8cGWz1E152YQsN8OuRIpiA7+2L81oqu8cdBK/MQ37Jaca2v5vKU2J2HBs5
	mUgQzMWsktTaw7VDlWSHjSNQb7bVyDwwTlae1Ky/JeZ6prA304yVCydNxFuqXu/J
	dxUf+fOF61jJ+vv6AuQ9Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711458556; x=
	1711462156; bh=SbTcD/l8MHa59PyMOlNhqWFEL7/jqCRuzGyHcMwgJkI=; b=s
	iTAPSSMY7adUQkr/h8dvppzUOdGtCZvFlZcYfeoZzFS/rPc68iYQ2vxU2Rj42WZY
	2Dkof8Tiyg4boG9GfEWpN9CJSHjGpsbw8GVOQZHrHXH1eB3VAUP5vw3pIvhYY9j4
	A1psBSrBJeLCOdBH58NE6wRKRREtHbiGhbFolBgrMMFr+x5HofJ6mrOmqwes04Hi
	UgT7PfjWyoevVgtMJ6Zz6GBY77FkRpwW+GYkm9ponWlrbys6WMKBU5eOsxLlpDhB
	csUG03BsN66E3HX63MOJomXaeGwzd1495IVlSvaApNQhWnbmUEOsCwEYvHiNhHzw
	sHxgvNdVDqu4T4Wbd0Wdw==
X-ME-Sender: <xms:_MgCZpsZQmhRD3FQvyVg1aYpZlcfJ1SZMLkAdOVeI6mxX5eCXm6hwA>
    <xme:_MgCZidFABR26jw64bfm7LbXS1qHgqgVJBcUkDrOCVZK3dHc-6qKDThZuq_V73fr2
    G3X-RmEJkdwL3UC5wk>
X-ME-Received: <xmr:_MgCZszTkktQm75dO6Pw3c6hV4enG0xDWqHf9lui1JjTc5BoW3gAOVXs67lI-RpxOHVgRpuw0_NS4F_P_fQIpfT_FfJDnwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeffkefgudek
    gefhhfejtedviedtgeetieekffeiudfhgeevteejvedtffdvkefftdenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvghsrghssehrrg
    hgnhgrthgvtghhrdhsvg
X-ME-Proxy: <xmx:_MgCZgPiwIRnL6Me7HCUBkbftAdwVrvVV3Wd08j9ohFx6nZFUxCkvw>
    <xmx:_MgCZp-xNgLRTt9OYwh6YJ3CfQ-Ito-OFNkqVY5BvgqsV4XJMVlmvA>
    <xmx:_MgCZgUXWTYaBgahAeBK_ci2OuiOCpP0FeP5GXWIGlcdJihtddi2cw>
    <xmx:_MgCZqfc1i-pMdt1MVWdBN32zFA3J0KH5hUWVqP41VyTllRk3MdFCA>
    <xmx:_MgCZoaJLt2n8sZfGdrTVNtfC7x4Jas-ZlQqZoM10Mii3cUes_UsMPkM47W_UES6>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 09:09:15 -0400 (EDT)
Date: Tue, 26 Mar 2024 14:09:12 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ravb: Always process TX descriptor ring
Message-ID: <20240326130912.GF1108818@ragnatech.se>
References: <20240326083740.23364-1-paul.barker.ct@bp.renesas.com>
 <20240326093843.GD1108818@ragnatech.se>
 <7e57c68b-1d73-40e2-824a-12193e62047f@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e57c68b-1d73-40e2-824a-12193e62047f@bp.renesas.com>

On 2024-03-26 09:54:04 +0000, Paul Barker wrote:
> On 26/03/2024 09:38, Niklas Söderlund wrote:
> > Hi Paul,
> > 
> > Thanks for your work.
> > 
> > On 2024-03-26 08:37:39 +0000, Paul Barker wrote:
> >> The TX queue should be serviced each time the poll function is called,
> >> even if the full RX work budget has been consumed. This prevents
> >> starvation of the TX queue when RX bandwidth usage is high.
> > 
> > Is this not a design decision? That the driver should prioritize Rx over 
> > Tx if there is contention. I have no opinion on if this design is good 
> > or bad, I let Sergey judge that.
> > 
> >>
> >> Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
> > 
> > However, I do not think it is a bug and should not have a fixes tag.  
> > Also this fixes tag is incorrect, this points to the commit where ravb.c 
> > was renamed ravb_main.c. ravb_poll() is not touched by this commit.
> 
> Sergey identified these as bugfixes in the following emails:
>   https://lore.kernel.org/netdev/a364963f-4e4f-dba5-cb59-b2125c14e8fc@omp.ru/
>   https://lore.kernel.org/netdev/c58ab319-222b-5ab0-0924-7774a473e276@omp.ru/

I see, I missed that. I do not agree, this is not a bugfix, it changes a 
design decision and the behavior of the driver.

@Sergey: What do you think? If you feel strongly about this being a bug 
I will yield.

> 
> I got the wrong fixes tag though, it should be:
>   Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> 
> Thanks,
> 
> -- 
> Paul Barker






-- 
Kind Regards,
Niklas Söderlund

