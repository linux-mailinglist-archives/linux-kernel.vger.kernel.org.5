Return-Path: <linux-kernel+bounces-88259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2593B86DF50
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211041C214E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799746A8BB;
	Fri,  1 Mar 2024 10:37:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6544C16FF46;
	Fri,  1 Mar 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289472; cv=none; b=tOs9Mvsgppj5+r+xStrYQzOhnjxVo7+JnJB2fZ3jOuq2Pt/NFN609jg4AZR26WBdD2bioGMFavlrt6hh/PE/6o+npTdqCewLZP7LoQWKRUCpM5Vg7g4TNor4FaQ+1TPfgRYzxbNLPlRNcTKbOC9g8gqV98gDHieqYpqdVZZDnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289472; c=relaxed/simple;
	bh=Lyz8N3o8xpcVNUmdu1vRjARKN3i7zk7F/j20LYEjNN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmwQls7JA1Z0nw4hz4C3ZTMuJMFkEcaxxDQt5wAz1gSkaqT48opR/6K1l5uQWANZ3Wi9U1+9rZvNoXRpEB7lmvEnfOZ1FGZyill7Zvv0UI32QsLs4jggPSuvUiowwFlLf4CF0E742AyZH91e61R85B1+y5Vio1lR0vr5ig6iVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C0751FB;
	Fri,  1 Mar 2024 02:38:27 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 286A33F762;
	Fri,  1 Mar 2024 02:37:48 -0800 (PST)
Date: Fri, 1 Mar 2024 10:37:45 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Message-ID: <ZeGv-cDbkJMnJkJe@pluto>
References: <20240226130243.3820915-1-peng.fan@oss.nxp.com>
 <ZdyR_MWeqOWga8iQ@pluto>
 <ZdyoAsYGXK9GjHVx@pluto>
 <DU0PR04MB941710FB1400D0A17F99B6ED88592@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeCNyLxQOIazc07h@bogus>
 <DU0PR04MB9417C06FD66182C705238662885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeGJIvk_LqglqdBa@pluto>
 <DU0PR04MB9417EAC31D3D7EC716A66C05885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417EAC31D3D7EC716A66C05885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Fri, Mar 01, 2024 at 09:22:24AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system power
> > protocol
> > 
> > On Fri, Mar 01, 2024 at 12:41:29AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system
> > > > power protocol
> > > >
> > > > On Tue, Feb 27, 2024 at 01:01:41AM +0000, Peng Fan wrote:
> > > > > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support
> > > > > > system power protocol
> > > > > >
> > > > > > On Mon, Feb 26, 2024 at 01:28:31PM +0000, Cristian Marussi wrote:
> > > > > > > On Mon, Feb 26, 2024 at 09:02:43PM +0800, Peng Fan (OSS) wrote:
> > > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > > >
> > > > > > > > Add SCMI System Power Protocol bindings, and the protocol id is
> > 0x12.
> > > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > yes this is something I spotted in the past it was missing and
> > > > > > > I posted a similar patch but I was told that a protocol node
> > > > > > > without any specific additional properties is already being
> > > > > > > described by the general protocol node described above.
> > > > >
> > > > > Without this patch, there is dtbs_check warning.
> > > > >
> > > > > scmi: 'protocol@12' does not match any of the regexes: 'pinctrl-[0-9]+'
> > > > > from schema $id:
> > > > > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fd
> > > > >
> > evic%2F&data=05%7C02%7Cpeng.fan%40nxp.com%7C3ef5d152a8e5463e9b
> > 3408
> > > > >
> > dc39c47e41%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63844
> > 87632
> > > > >
> > 86203182%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > V2luM
> > > > >
> > zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=kRBV9FPk6
> > Nrgu
> > > > > Hs2SHpL74VlNUH6cYO1kAsW74CkaTk%3D&reserved=0
> > > > >
> > > >
> > etree.org%2Fschemas%2Ffirmware%2Farm%2Cscmi.yaml%23&data=05%7C0
> > > > 2%7Cpen
> > > > >
> > > >
> > g.fan%40nxp.com%7Ccac77deb5f6a4b20460a08dc392ead40%7C686ea1d3b
> > > > c2b4c6fa
> > > > >
> > > >
> > 92cd99c5c301635%7C0%7C0%7C638448119832543335%7CUnknown%7CT
> > > > WFpbGZsb3d8e
> > > > >
> > > >
> > yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > > > %7C0%
> > > > >
> > > >
> > 7C%7C%7C&sdata=6MldIOUQ4hxn%2BRffwJJJ3jxXXtHCSxLUOa4JMWB0htU%
> > > > 3D&reserv
> > > > > ed=0
> > > > >
> > > >
> > > > Why are you adding protocol@12 to the device tree ? Does it have a
> > > > dedicated channel ? If not, you shouldn't need to add it.
> > >
> > > No dedicated channel.
> > > The idea is we have multile Agent, the M7 agent may ask to shutdown
> > > Linux Agent. So the linux agent need use protocol@12 to do the action.
> > >
> > 
> > Ok, so indeed you need, AFAICR, the node in the DT even without a dedicated
> > channel nor anynone referring it: no DT node means no protocol initialization.
> 
> Yeah, so this binding update is needed, right?
> 
> > 
> > > For now, we have not finish implementing this in linux side, just add
> > > the node in dts.
> > 
> > On the linux side you should not need to do anything but adding the node
> > @12, the existent drivers/firmware/arm_scmi/system_power_control.c
> > driver when loaded will shutdown the system upon receiving the
> > SytemPower notification....what lacks Linux side in these regards ?
> 
> " Ignoring unsupported system_state:" we have new defined
> number here.
> 

So I suppose you are using the Vendor defined system states and writing
your own driver to handle these instead of system_power_control ?

Thanks,
Cristian

