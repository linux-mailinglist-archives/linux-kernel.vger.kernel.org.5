Return-Path: <linux-kernel+bounces-90203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D679686FBDD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067751C21B32
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024EE17586;
	Mon,  4 Mar 2024 08:30:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323F17555;
	Mon,  4 Mar 2024 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541003; cv=none; b=L9iLrwCC5S3JovFb8yG0l4shW1Y3n0+uxQ9RvZwqqZxIg6OWv/zV95vveEwI4h4v/a7xwBEu/ml/h84+L/cTAx/ZFjojX8Gkl8xe7Pg+NeeprkNDnPWSQO3FKUoBsAqsVQQp5HDr0x1KUb5+1QB6mTw+Cw7g5BstKoi5CTdW8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541003; c=relaxed/simple;
	bh=YSgYYYl0DOoFXJoGvSLS/3MliIq/Rfs6F1SvD+8t0mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2ig/jSNVZH4FukzDQmZUoJsIrYibRvDOFxv73uDYILxENdT9xKZMXJYvi7oyRXWBII3OJprz9ZovbbSRlmh51EZ9S9v9dnHYTCM1Vog69r1AeyuM07EpdQVLDmdTKKohxx+pedxjlcUhlN2JuI9Te5yHJP6BQ21cPQdof8ebmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 062251FB;
	Mon,  4 Mar 2024 00:30:37 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6FE23F762;
	Mon,  4 Mar 2024 00:29:58 -0800 (PST)
Date: Mon, 4 Mar 2024 08:29:56 +0000
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
Message-ID: <ZeWGhPwSkz-NW8Gu@pluto>
References: <ZdyR_MWeqOWga8iQ@pluto>
 <ZdyoAsYGXK9GjHVx@pluto>
 <DU0PR04MB941710FB1400D0A17F99B6ED88592@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeCNyLxQOIazc07h@bogus>
 <DU0PR04MB9417C06FD66182C705238662885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeGJIvk_LqglqdBa@pluto>
 <DU0PR04MB9417EAC31D3D7EC716A66C05885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeGv-cDbkJMnJkJe@pluto>
 <ZeGyES-VOxafuAQx@pluto>
 <DU0PR04MB9417C8355827EE9477A11BF888232@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417C8355827EE9477A11BF888232@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Mon, Mar 04, 2024 at 02:18:10AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system power
> > protocol
> > 
> > On Fri, Mar 01, 2024 at 10:37:49AM +0000, Cristian Marussi wrote:
> > > On Fri, Mar 01, 2024 at 09:22:24AM +0000, Peng Fan wrote:
> > > > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support
> > > > > system power protocol
> > > > >
> > > > > On Fri, Mar 01, 2024 at 12:41:29AM +0000, Peng Fan wrote:
> > > > > > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support
> > > > > > > system power protocol
> > > > > > >
> > > > > > > On Tue, Feb 27, 2024 at 01:01:41AM +0000, Peng Fan wrote:
> > > > > > > > > Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi:
> > > > > > > > > support system power protocol
> > > > > > > > >
> > > > > > > > > On Mon, Feb 26, 2024 at 01:28:31PM +0000, Cristian Marussi
> > wrote:
> > > > > > > > > > On Mon, Feb 26, 2024 at 09:02:43PM +0800, Peng Fan (OSS)
> > wrote:
> > > > > > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > > > > > >
> > > > > > > > > > > Add SCMI System Power Protocol bindings, and the
> > > > > > > > > > > protocol id is
> > > > > 0x12.
> > > > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > yes this is something I spotted in the past it was
> > > > > > > > > > missing and I posted a similar patch but I was told that
> > > > > > > > > > a protocol node without any specific additional
> > > > > > > > > > properties is already being described by the general protocol
> > node described above.
> > > > > > > >
> > > > > > > > Without this patch, there is dtbs_check warning.
> > > > > > > >
> > > > > > > > scmi: 'protocol@12' does not match any of the regexes: 'pinctrl-[0-
> > 9]+'
> > > > > > > > from schema $id:
> > > > > > > > https://eur01.safelinks.protection.outlook.com/?url=http%3A%
> > > > > > > >
> > 2F%2Fd%2F&data=05%7C02%7Cpeng.fan%40nxp.com%7Caf8c2c02cfc644
> > > > > > > >
> > 981a3a08dc39dce87d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> > > > > > > >
> > 0%7C638448868151253291%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > wL
> > > > > > > >
> > jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C
> > > > > > > > %7C%7C&sdata=hRNs%2BMA%2BPR3rdUSEMg%2FzqO4nN1YP4EX
> > DSikXxZMhJ
> > > > > > > > HQ%3D&reserved=0
> > > > > > > >
> > > > >
> > evic%2F&data=05%7C02%7Cpeng.fan%40nxp.com%7C3ef5d152a8e5463e9b
> > > > > 3408
> > > > > > > >
> > > > >
> > dc39c47e41%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63844
> > > > > 87632
> > > > > > > >
> > > > >
> > 86203182%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > > > V2luM
> > > > > > > >
> > > > >
> > zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=kRBV9FPk6
> > > > > Nrgu
> > > > > > > > Hs2SHpL74VlNUH6cYO1kAsW74CkaTk%3D&reserved=0
> > > > > > > >
> > > > > > >
> > > > >
> > etree.org%2Fschemas%2Ffirmware%2Farm%2Cscmi.yaml%23&data=05%7C0
> > > > > > > 2%7Cpen
> > > > > > > >
> > > > > > >
> > > > >
> > g.fan%40nxp.com%7Ccac77deb5f6a4b20460a08dc392ead40%7C686ea1d3b
> > > > > > > c2b4c6fa
> > > > > > > >
> > > > > > >
> > > > >
> > 92cd99c5c301635%7C0%7C0%7C638448119832543335%7CUnknown%7CT
> > > > > > > WFpbGZsb3d8e
> > > > > > > >
> > > > > > >
> > > > >
> > yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > > > > > > %7C0%
> > > > > > > >
> > > > > > >
> > > > >
> > 7C%7C%7C&sdata=6MldIOUQ4hxn%2BRffwJJJ3jxXXtHCSxLUOa4JMWB0htU%
> > > > > > > 3D&reserv
> > > > > > > > ed=0
> > > > > > > >
> > > > > > >
> > > > > > > Why are you adding protocol@12 to the device tree ? Does it
> > > > > > > have a dedicated channel ? If not, you shouldn't need to add it.
> > > > > >
> > > > > > No dedicated channel.
> > > > > > The idea is we have multile Agent, the M7 agent may ask to
> > > > > > shutdown Linux Agent. So the linux agent need use protocol@12 to do
> > the action.
> > > > > >
> > > > >
> > > > > Ok, so indeed you need, AFAICR, the node in the DT even without a
> > > > > dedicated channel nor anynone referring it: no DT node means no
> > protocol initialization.
> > > >
> > > > Yeah, so this binding update is needed, right?
> > > >
> > > > >
> > > > > > For now, we have not finish implementing this in linux side,
> > > > > > just add the node in dts.
> > > > >
> > > > > On the linux side you should not need to do anything but adding
> > > > > the node @12, the existent
> > > > > drivers/firmware/arm_scmi/system_power_control.c
> > > > > driver when loaded will shutdown the system upon receiving the
> > > > > SytemPower notification....what lacks Linux side in these regards ?
> > > >
> > > > " Ignoring unsupported system_state:" we have new defined number
> > > > here.
> > > >
> > >
> > > So I suppose you are using the Vendor defined system states and
> > > writing your own driver to handle these instead of system_power_control ?
> > 
> > Or some vendor extensions to the std driver ?
> > IOW what is the plan...custom vendor states was left out from
> > system_power_control waiting for a real usecase...that seems to have shown
> > up eventually :D
> 
> I have not implemented the linux side driver as of now, but we do need
> Extension:
> 
> Ignoring unsupported system_state: 0x80000003, we use this state indicating
> others are requesting linux to suspend.
> 
> And when system is doing emergency reset, linux will get a notification, and got
> force reset, we are thinking to let linux do some disk flush or whatelse, the
> Time window is small.

mmm ... now I am puzzled....why do you need extra custom state since
this behaviour just sounds like the normal SYSTEM_POWER notification
graceful shutdown request (that can carry a platform timeout)...

..some other agents requested a shutdown so Linuux get a notification
SYSTEM_POWER(shutdown) with possibly timeout advised by the platform to
complete the shutdown...then scmi_power_control existing upstream driver
issues a orderly_poweroff (which carries out an emergency_sync) and then
finally userspace can do whatever it wants hooking its own shutdown-callbacks
into whatever pid_1 process it has...if all of this exceeds the advised
timeout for a graceful shutdown Linux will just force-shutdown without
waiting futher for userspace shutdown-callbacks to complete...

so wqhat do you need more than this to justify a new custom vendor
system_power state AND a dedicated driver other than scmi_power_control
IF you really have just to shutdown based on some SYSTEM_POWER
notification sent by the platform when some  other agents decided to
shutdown ?

Thanks,
Cristian

