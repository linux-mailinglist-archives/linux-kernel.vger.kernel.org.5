Return-Path: <linux-kernel+bounces-161450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB7A8B4C23
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0375F2819BA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C2B6EB7B;
	Sun, 28 Apr 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PsybsRSJ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F9AD52;
	Sun, 28 Apr 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714314342; cv=none; b=UMNFsUXqtxgHq4bwF0XLWsMGvbTXT8v1OYXRBJBGE+8IzhEj8aTGS0bC1hSZH619gew4KK2okliFhpVljwtWIkFLZOvoD+8aESDs+KivaaYpN96iWlGVjF8tdzQtHaxA5JRs94nNPY+NBrOgAQM//HnLl1EtL35Ki2aCAri5iJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714314342; c=relaxed/simple;
	bh=lZxJrpNHn0XSynHk/uJrhAg3iT15StGrcBJXagCaH9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOuarzbh5njgD/7kLQvIb3pDDasTpqNfmgjaYSvrqW0/tuej1UkNApO9mbfeXYROqBhAtJEQViMJZknjrEghyV+DVqaqqjkbABXTLquZWPktRBZfEeAQ50jOnkKFpE7mU5yLYDuPRC8/pD7G19N7V6p+WyBbp7HQ0BJ1LMmZeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PsybsRSJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M2ewwiL2pIG/9gVc441cLBbAgSNOqpkmdmS7M7cFcKk=; b=PsybsRSJOkK+rGQOMjU4XdJfQ2
	PAtzE8sZGN0AlyQlsLwcVCWK1ocgaCJtSWG1akpwGdSZwplwCtDlbtCe5PTLrCit+FU2ronl8NDUN
	GcRnDxwgLBGDFw8M/GbLCDRtpwsfyW56zlGdCguvofmc0UMTGgjaifCWtXsb7p8+t3KY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s15T6-00EBwA-JJ; Sun, 28 Apr 2024 16:25:28 +0200
Date: Sun, 28 Apr 2024 16:25:28 +0200
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
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <8e06c952-b5ab-4591-8ab0-7aebf612a67e@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1Tang5RQMmEFdx@builder>
 <50b7cb69-61c0-45a2-9a48-4160b2d1e24c@lunn.ch>
 <Zi1uIjoIgzir1cwA@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi1uIjoIgzir1cwA@builder>

> I agree with your assesment, the phy won't reset itself, but maybe we
> could add some comment doc about not adding it for the lan8670,
> so no one trips over that in the future.

In the PHY driver, you can provide your own .soft_reset handler. It
could return -EOPNOTSUPP, or -EINVAL. Maybe check the data sheets for
the standalone devices supported by the driver. Can you limit this to
just the TC6 PHY?

     Andrew

