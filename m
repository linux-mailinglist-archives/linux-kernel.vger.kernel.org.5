Return-Path: <linux-kernel+bounces-165729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E5E8B904F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7B3B2223F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CA21635A1;
	Wed,  1 May 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hpjItpNp"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAEF9EB;
	Wed,  1 May 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593543; cv=none; b=nH27gGSL8KqnIl1A2De7uIvNXt+hdh23+gmPacDUw84jugKs0MNS1vOgfuQNXo+JVyJOcGIX9GedfyVfIjI43UJ8eidaJ/WeR1bsVhuE/nyF0ndGY3z9KpPho9g26UxhIT2rVv8qZaXbP4teeOLTYYi7d8G+wOBMAq98bKf1Lgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593543; c=relaxed/simple;
	bh=sH+kPAfPtPPzuzFlFeWrZY9KddU1txu/ShuQs6gKKfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLEx9ChgZfNzjNfCfMc9FO7co5JoxBnJFljxKcTWLoc/i+dF+1p5t/sndSV7ZPc5NriJ99DNK3d5dvopaGlFruiIldOZhum7uyd/Ru/AY0jzx25oqreWtxxICyKpqFNhmHLLLwRS6Q+J30M/53EmYiYxF1YsFCJoSKeCfDTRQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hpjItpNp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Crv1FLzU1DFSQngdp0IScKnC91Dz3LBFOcsgrrV7NJw=; b=hpjItpNp/wVur8ltojtSaJmcpP
	bDQtDHkCaSKmGRgVFXJDy2LmNmzKd/SFPtAjzLgdS5L/kfd/kMR3f7QiOYIaBnrXeGUto7WQneYKl
	KJCcXMp0PA7VB9N24GhyncgmcR/fOrpT59uFbSAGetMhVpa5ew07Z4EQrfmllASUFosE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2G6F-00ERxS-7B; Wed, 01 May 2024 21:58:43 +0200
Date: Wed, 1 May 2024 21:58:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <210d7f40-ec98-4811-be33-2bab6dbe608a@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi4czGX8jlqSdNrr@builder>
 <874654d4-3c52-4b0e-944a-dc5822f54a5d@lunn.ch>
 <ZjKJ93uPjSgoMOM7@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjKJ93uPjSgoMOM7@builder>

> Kernel output:
> [   94.361312] sched: RT throttling activated
> 
> top output:
>  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>  145 root     -51   0       0      0      0 R  95.5   0.0   1:11.22 oa-tc6-spi-thread
> 
> link stats:
> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
>     link/ether 32:c2:7e:22:93:99 brd ff:ff:ff:ff:ff:ff
>     RX:  bytes packets errors dropped  missed   mcast
>        3371902    7186      0      48       0       0
>     RX errors:  length    crc   frame    fifo overrun
>                      0      0       0       0       0
>     TX:  bytes packets errors dropped carrier collsns
>       10341438    8071      0       0       0       0
>     TX errors: aborted   fifo  window heartbt transns
>                      0      0       0       0       1
> state:
> Completly borked, can't ping in or out, bringing the interface down then up
> has no effect.

Completely borked is not good. 

> I'd be keen on hearing what Microchips plans to address. If tracking
> down performance issues is a priority I'll probably not spend any time
> on it, if not then I'll definetly dig into it more.

Borked ! = performance issue. This should be addressed. Lets see if
the python scripts are enough to be able to reproduce it.

We should not rule out differences in SPI drivers. So it might be you
need to debug this, if Microchip cannot reproduce it.

I would also suggest you enable the "kernel hacking" debug features
for finding deadlocks, bad spinlocks, stuck RT tasks etc. That might
give some clues.

	Andrew

