Return-Path: <linux-kernel+bounces-71988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B585AD84
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41451C21E18
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B453E08;
	Mon, 19 Feb 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cIM5NyNN"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3381F18D;
	Mon, 19 Feb 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708376764; cv=none; b=jzcqHFc+rGXAzdWLeoevqZgT3lkA8FVEeEEMoxqLlUZJBVio4nD+I9PEctmCpgT/P0OvEFJXkPNcLKBOgv84zbEVoN8WUykstJ+4POv2/e/UdmTrk7k1kyu/TfZvvu5mJDbqpLVmnc/stv2lXn3y5YvUL5TcZVUfV1aRLOC/rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708376764; c=relaxed/simple;
	bh=KU4nGP7iEFzvC/1hs1YWVpyHfJhGdPFeSmJ8xNlLcWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaam/PdTHgGELq65WQ9y3k/DATIcyDd2nj5KWSfV1o6PW8sUBNnI00b1+xEq0avxo6hwcwPNoDL2J5EgDt3/iH2exSLyO9MIFJECIHKuhYwU3fFd7xxbHrwO5PP9deK8mQ1d7y9ejuLcAu7Rdb7Ge6ECc0y6k2O2k6gnevhhl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cIM5NyNN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZOgxDgXjl4qwjPPUdr5tiry2hRdBim87LYWDSoqsvk4=; b=cIM5NyNNeWDim+UZ1Gwx6XfcEH
	f0PKlkovpQVxnvG2cREypNR88n5pUmtf9z7rqlwmUm6Mlq2lLbQ9zCs6uJBmddp0ZLAtOKLHBpDys
	Vh42aXe2ZCWSM/85RhEWepKUYNcpWuWbkn3S0mf1V8/O8/nCFQDdXzMRVaC8HXRF18zg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rcApd-008EUS-9d; Mon, 19 Feb 2024 22:05:45 +0100
Date: Mon, 19 Feb 2024 22:05:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/6] net: hisilicon: add support for
 hisi_femac core on Hi3798MV200
Message-ID: <5572f4dd-dcf2-42ec-99c8-51bf4d1f28ba@lunn.ch>
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
 <20240220-net-v3-3-b68e5b75e765@outlook.com>
 <29fc21f0-0e46-4d0f-8d4b-c4dbd1689c55@lunn.ch>
 <SEZPR06MB695901E7D4BEABE1B6F319D096512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR06MB695901E7D4BEABE1B6F319D096512@SEZPR06MB6959.apcprd06.prod.outlook.com>

On Tue, Feb 20, 2024 at 04:14:36AM +0800, Yang Xiwen wrote:
> On 2/20/2024 4:03 AM, Andrew Lunn wrote:
> > > Note it's unable to put the MDIO bus node outside of MAC controller
> > > (i.e. at the same level in the parent bus node). Because we need to
> > > control all clocks and resets in FEMAC driver due to the phy reset
> > > procedure. So the clocks can't be assigned to MDIO bus device, which is
> > > an essential resource for the MDIO bus to work.
> > What PHY driver is being used? If there a specific PHY driver for this
> > hardware? Does it implement soft reset?
> 
> I'm using generic PHY driver.
> 
> It implements IEEE C22 standard. So there is a soft reset in BMCR register.
> 
> > 
> > I'm wondering if you can skip hardware reset of the PHY and only do a
> > software reset.
> 
> There must be someone to deassert the hardware reset control signal for the
> PHY. We can't rely on the boot loader to do that. And here even we choose to
> skip the hardware reset procedure, the sequence of deasserting the reset
> signals is also very important. (i.e. first PHY, then MAC and MACIF).
> Opposite to the normal sequence. (we normally first register MAC driver, and
> then PHY).

There are a few MACs which require the PHY to provide a clock to the
MAC before they can use their DMA engine. The PHY provides typically a
25MHz clock, which is used to driver the DMA. So long as you don't
touch the DMA, you can access other parts of the MAC before the PHY is
generating the clock.

So it might be possible to take the MAC and MACIF out of reset, then
create the MDIO bus, probe the PHY, take it out of reset so its
generating the clock, and then complete the rest of the MAC setup.

	Andrew


