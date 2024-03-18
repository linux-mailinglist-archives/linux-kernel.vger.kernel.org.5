Return-Path: <linux-kernel+bounces-106197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A087EA96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A7D1F218E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494A04E1D3;
	Mon, 18 Mar 2024 14:08:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10E4A990
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770890; cv=none; b=ZQqUekmUCX6pEKsAPR5eQ4GiJQ6sJAXUQFYll0uxg3ZGbiRCvWlPjj7eLQTf1QyB3C3vHsV/m75iFFq/St1NB+JK15uw+tm2dzUBpD6y9t10kwfEbSsvWj0wQY2yq/6na09UFEdvGe7t8DFC0+ZmMWhIFn8Ow7eRY7ONUWxBKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770890; c=relaxed/simple;
	bh=wIFzDeOuz2b3HspmGucGQW0ZsPmRxHogsNZniaceIts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqkvBINhow7IS8Tc90f6yhVAil8JKgpS4LIed6F2ffjnQZ9xEald6X9Cu99fOAMNfLNtuwALSeA2hGsVlHMwRO6Hd5CxUcPDmg+TRO0Jb+fYB5YwjEbWvvMCdnq0EOrObHEC5g3wa/Sj6QiRWSzWVeJoI1a7B7Ywdj0MG2TpO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rmDeR-0004iD-Oj; Mon, 18 Mar 2024 15:07:43 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rmDeR-0075gE-0W; Mon, 18 Mar 2024 15:07:43 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rmDeQ-005WWj-2y;
	Mon, 18 Mar 2024 15:07:42 +0100
Date: Mon, 18 Mar 2024 15:07:42 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock features
Message-ID: <20240318140742.3pfn5h6wqhbtgbmj@pengutronix.de>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240317155911.pdc32nsyxcdhs2t7@pengutronix.de>
 <DU0PR04MB941725052D5E3EF78F67A1C5882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240318095959.v5d7qeoci5v2dtkq@pengutronix.de>
 <DU0PR04MB94177A4081547764F600635E882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94177A4081547764F600635E882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-03-18, Peng Fan wrote:
> > Subject: Re: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock
> > features
> > 
> > On 24-03-18, Peng Fan wrote:
> > > Hi Marco,
> > >
> > > > Subject: Re: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock
> > > > features
> > > >
> > > > Hi Peng,
> > > >
> > > > thank for the patchset.
> > > >
> > > > On 24-03-14, Peng Fan (OSS) wrote:
> > > > > i.MX95's several MIXes has BLK CTL module which could be used for
> > > > > clk settings, QoS settings, Misc settings for a MIX. This patchset
> > > > > is to add the clk feature support, including dt-bindings
> > > >
> > > > I have to ask since there is almost no public documentation
> > > > available yet. The
> > > > i.MX95 does have an system-controller for managing pinmux settings
> > > > and power-domains, right?
> > >
> > > Yes.
> > >
> > > If this is the case, why not making use of it via the
> > > > standard scmi_pm_domain.c driver?
> > >
> > > The SCMI firmware not handle the BLK CTL stuff, but blk ctl stuff is a
> > > mix of clk, qos, module specific things. It is not good for SCMI
> > > firmare to handle it.
> > 
> > Currently most of the blk-ctrl users do use the blk-ctrl as power-domain
> > consumer, except for the isi and the audio part. 
> 
> Yes, for i.MX8M.
> 
> > So as I said above the
> > scmi_pm_domain.c should be able to supply this. The audio blk-ctrl could be
> > abstracted via the clk-scmi.c driver. The ISI is another topic.
> 
> Pengutronix rejected the efforts for putting blk ctrl stuff in ATF for i.MX8M
> before. So we take the kernel power domain approach to handle blk ctrl
> clk gating.

AFAIK the problem here was that your proposal had an layering violation
even worse it was an layering inversion since the TF-A (lower layer)
code updated CCM registers which were under control of Linux (upper
layer).

> > What you're are going to do here is to put pinctrl etc into SCMI firmware and
> > power-control into Linux, which sound to me like an 50/50 approach and
> > IMHO is rather sub-optimal. 
> 
> Now back to i.MX95 which supports function safety.
> 
> The SCMI firmware only handle CCM/SRC/GPC for clock/power, it not
> handle blk ctrl.

I know that.

> The BLK CTRL registers are not only for clk gating, it has other
> module specific functions.

I suspected that this is the case for i.MX95 too :/

> Moving BLK CTRL to SCMI firmware, means linux accessing module
> specific functions needs go through vendor SCMI protocol.

Right and here it's a bit complicated to have an proper interface.
Therefore I'm not again the solution of keeping the blk-ctrl within
Linux.

> And BLK CTRL stuff is MIX level stuff, it is not SOC level stuff as
> CCM which is system critical resource.

Hm.. it's still SoC level albeit the area is more limited to specific
functions like HSIO, MEDIA, GPU, ...

> (BLK CTLR, I mean non system critical BLK CTRL, such as GPU,VPU,DISP)

What's system critical is up to the system design but I get your point
that having an safe DISP stack is not going to happen.

> The other approach is to let ATF as SCMI server to handle BLK CTRL stuff,
> But I not see benefits.

How is that any different from putting it into the system-controller
firmware.

> > To quote your online available fact sheet:
> > 
> > 8<----------------------------------------------------------
> > ENERGY FLEX ARCHITECTURE
> > 
> > The i,MX 95 family is designed to be configurable and scalable, with multiple
> > heterogenous processing domains.
> > This includes an application domain with up to 6 Arm Cortex A55 cores, a
> > high-performance real-time domain with Arm Cortex M7, and low-
> > power/safety domain with Arm Cortex M33, each able to access interfaces
> > including CAN-FD, 10GbE networking, PCIe Gen 3 x1 interfaces, and
> > accelerators such as V2X, ISP, and VPU.
> > 8<----------------------------------------------------------
> > 
> > 8<----------------------------------------------------------
> > HIGH-PERFORMANCE COMPUTE
> > The i.MX 95 family capabilities include a multi-core application domain with
> > up to six Arm Cortex(r)-A55 cores, as well as two independent real-time
> > domains for safety/low-power, and high-performance real-time use,
> > consisting of high-performance Arm Cortex-M7 and Arm Cortex-M33 CPUs,
> > combining low-power, real-time, and high-performance processing. The i.MX
> > 95 family is designed to enable ISO 26262 ASIL-B and SIL-2 IEC 61508
> > compliant platforms, with the safety domain serving as a critical capability for
> > many automotive and industrial applications.
> > ...
> > 8<----------------------------------------------------------
> > 
> > To me this sound like we can turn of the power/clock of an hardware block
> > which was assigned to a core running SIL-2 certified software from an non-
> > critical core running Linux if we follow that approach. Also the
> > SIL-2 software requires the non-critical software to turn on the power of these
> > hardware blocks. Is this correct?
> 
> Non-critical software not able to turn off power/clock of a critical resource in
> safety software domain.
> Safety software not require non-safety software to turn on power/clocks.

Due to lack of documentation I don't know how you implemented this in
HW/SW, also the system-design is telling us which parts should be seen
as safe and which don't. However I get your point, VPUMIX is not going
to be a part of the safe partition albeit it "could" due to complexity.

> CCM/SRC/GPC is handled by SCMI firmware, agent w/o safety needs use
> SCMI API to request SCMI firmware to enable clock/power for a module.
> The SCMI firmware will check whether the agent is allowed to touch
> a clock entry or a power entry.

I got this. I still don't like the 50/50 approach but I also get your
point about the GPR registers which is the only valid argument to me of
not putting the blk-ctrl handling into the system-controller firmware.

Regards,
  Marco

