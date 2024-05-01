Return-Path: <linux-kernel+bounces-165738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06998B906A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909251F24322
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB81635AC;
	Wed,  1 May 2024 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c2Veqygb"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5C1474B1;
	Wed,  1 May 2024 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594079; cv=none; b=ZOGLVPEbPNTLfZTD7vDXPYDUcbhR4DvpsPVmdcLLZT4LNts/nN3DVYUGWDqXWGtUSsQ5zdfs0iIJC9eiNEE3m/yAzKFm5/fHrA0+Cap4hreCW57h3W5cp7avhANTOD4sZzE6To56mLfFiLtidNsWDNPCnsxYCypD52BjgJy+stg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594079; c=relaxed/simple;
	bh=N3zk6Y234MgqGMAQG9RoCDph4rWUl30bnD7vWlEU0cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJQR/pgzR6geXSkwWZpFr6v9U+gIvkepusfjkyBlGvnBP44Vr57uSrjPDF4VsWs8kpdRhsa75KcfdX65C7NoSIeQttKOJdUb/Qxj8/fSNdtInR7mhYNTLtTAA37CYonX/QeyVcpJ5Gxhhc0SuX0hyakcOMxqoahhfRSjuaeMEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c2Veqygb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=k3d7/UgyKgzqATK8IOdA9YZPJAlZPNvl/CaLjYyubLs=; b=c2
	VeqygbK4kMrNOqM+BMGsJoDKkcY8/L1sC1BdKVRwWunbcGmKnxKzIw5ryFrljq/SUBxRQs+XKcUFr
	cv/uJ2pJvJ+MpTTXawoowC07lYn9u1e1E53MQo0TjgAsKAeK8Y+TWasPdoUreKn77/8PHzbiBREFF
	ZQa0/qUbiRvX1GQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2GEz-00ERzR-Gv; Wed, 01 May 2024 22:07:45 +0200
Date: Wed, 1 May 2024 22:07:45 +0200
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
Message-ID: <78395aa9-5871-4db1-8232-ffdaacc7671a@lunn.ch>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjKJ93uPjSgoMOM7@builder>

> I don't have access to a logic analyzer but my old oscilloscope is
> almost reliable. I could confirm that the spi clock is indeed running at
> the expected 25MHz, but I could observe some gaps of up to 320µs so
> that's 8k spi cycles spent doing something else.
> These gaps were observed on the SPI clock and the macphy interrupt was
> active for the same ammount of time(though this was measured independently
> and not on the same trigger).
> I've been drinking way to much coffe, so soldering is not gonna happen
> today (shaky hands), but if it helps I can solder wires to attach both
> probes to confirm that the gap in the SPI clock happens at the same time
> or not as the interrupt is active.

What i expect you will see is that the interrupt line goes active. A
while later there is an SPI bus transfer to fetch the interrupt
status, and when that transfer completes the interrupt should go
inactive. But you will need your second channel to confirm this.

One question would be, is 320µs reasonable for an interrupt, and one
SPI transfer?

I would then expect a number of back to back transfers, each around 64
bytes in size, as it gets the received frame. The gaps between those
transfers will be interesting.

	Andrew

