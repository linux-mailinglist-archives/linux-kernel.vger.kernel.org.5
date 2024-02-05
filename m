Return-Path: <linux-kernel+bounces-52749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525F9849C3F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07D128505B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573632260A;
	Mon,  5 Feb 2024 13:52:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257922EF0;
	Mon,  5 Feb 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141159; cv=none; b=hcQKAHiXRCQaCca56wMT382rCKd3dk7HOZsJah0QfqmnkKuUebLj4PFUnf64hNw5hUO08MdnXCcSJrwxxhCVYsHgLme3dx7efh7RKqVLgaObbKx3Ugi2c0/LeAgX82HpT5ztFVGxLeVQ5IjuvkwbmS1Tzm7TnKcutwtpW1BdCjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141159; c=relaxed/simple;
	bh=RIlH3Kpx0z44ko9l4/g3YofT/tlmNnchxQwVaNfQBxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC9nqdxk66qfISpOOGkOHWT8yrzxyVKeHFala4fmTO9Kiil9sa2ynbMcIcYdR038SY3NVDTBVtCo9csPAraL03rnYDcsXOf2XKiX04P9dgo+6YBQScZ2fFsk7Xkk9zx5OmtczM6Vtpu+BpHtdFzM4XCubLbVUTbmBt5j6+7p8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 724901FB;
	Mon,  5 Feb 2024 05:53:18 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75A3F3F5A1;
	Mon,  5 Feb 2024 05:52:31 -0800 (PST)
Date: Mon, 5 Feb 2024 13:52:27 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"souvik.chakravarty@arm.com" <Souvik.Chakravarty@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZcDoG6FTiNgChQJF@pluto>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
 <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>
 <CACRpkdYV=qYQ9qDUWYTLDAV1niay30gYH5S=zjfi31GpeY5o-A@mail.gmail.com>
 <DU0PR04MB9417A9074C5DC49AE689E65288432@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zbt-QkWhz5d9P-v6@pluto>
 <DU0PR04MB9417CA6CF089B264112C32A088402@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB9417CA6CF089B264112C32A088402@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Sun, Feb 04, 2024 at 09:29:25AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> > protocol basic support
> > 
> > On Thu, Feb 01, 2024 at 07:14:17AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2
> > > > pincontrol protocol basic support
> > > >
> > 
> > Hi Peng,
> > 
> > > > On Mon, Jan 29, 2024 at 1:37 PM Peng Fan <peng.fan@oss.nxp.com>
> > wrote:
> > > >
> > > > > And for i.MX95 OEM extenstion, do you have any suggestions?
> > > > > I have two points:
> > > > > 1. use vendor compatible. This would also benefit when supporting
> > > > > vendor protocol.
> > > > > 2. Introduce a property saying supporting-generic-pinconf
> > > > >
> > > > > How do you think?
> > > >
> > > > While I don't know how OEM extensions to SCMI were designed, the pin
> > > > control subsystem has the philosophy that extensions are for minor
> > > > fringe stuff, such as a pin config option that no other silicon is
> > > > using and thus have no use for anyone else. Well that is actually
> > > > all the custom extensions we have.
> > > > (This notion is even carried over to SCMI pinctrl.)
> > > >
> > > > The i.MX95 OEM extension is really odd to me, it looks like a
> > > > reimplementation of the core aspects of SCMI pin control, and looks
> > > > much more like the old i.MX drivers than like the SCMI driver.
> > >
> > > i.MX SCMI pin protocol conf settings follows non-SCMI pin conf settings.
> > >
> > 
> > It is not just a matter of using custom SCMI OEM types, it is the whole
> > layout/definitions of the i.MX pin/groups/funcs DT bindings that deviates
> > from the generic DT bindings layout as handled and expected by the Linux
> > Pinctrl subsystem (AFAIU), while the SCMI Pinctrl driver as it stands in this
> > series, was conceived, designed and implemented originally by Oleksii to just
> > use the generic existing Pinctrl DT bindings; as a consequence, in your i.MX
> > extensions, you had to add a dedicated i.MX DT parser to interpret the
> > protocol@19 DT snippet in a completely different way, to try to stick your
> > custom solution on top of the generic one.
> 
> The two links shows the drop of i.MX generic pinconf
> https://patchwork.ozlabs.org/project/linux-gpio/patch/1541149669-10857-7-git-send-email-aisheng.dong@nxp.com/
> https://lore.kernel.org/all/20230302072132.1051590-1-linux@rasmusvillemoes.dk/
> 
> For non-scmi platforms, the generic pinconf was supported
> for i.MX7ULP for a while, and then dropped in the end per i.MX maintainers
> and agreed by Linus.
> 
> For i.MX95 SCMI platforms, the firmware design is simple and use similar
> programming model to simplify firmware design.
> 
> Using generic pinconf means the firmware needs exporting groups/functions/pins
> and etc, the firmware design will be complicated and code size enlarged.
> 

Understood.

> I have no better ideas without introducing a compatible for dt map hook.
> 
> Build exclusive is not acceptable for distro support.
> 

Indeed, and I understand that, but in any case it wont be required for
both the generic pinconf and the IMX way to coexist and live together on
the same system/platform at runtime, right ?

So, I was thinking as an alternative, while still building all
(generic+IMX) in defconfig, wouldn't be possible to detect at runtime in the
pinctrl-scmi probe() which is the type of binding used in the DT (i.e.
generic VS imx), before registering with the core Pinctrl subsystem, and so
act accordingly parsing and providing different callbacks based on that ?

I mean, without any compatible addition, just looking up the protocol@19
node content @probe and switch to iMX callbacks if the fsl,pins binding
is found ?

Not sure is this is totally viable, nor clean or that it is not less horrific
from the Pinctrl_subsystem/DT point of view for Linus ... just an idea to think
about or discard.

> So the last options is i.MX95 switch back to VENDOR protocol ID saying
> 0x82. But this means to exports functions of pinctrl-scmi.c and reused
> by pinctrl-scmi-imx.c.  If you agree, I will ask firmware developer
> switch back to a new SCMI ID, and I will use new ID for i.mx pinctrl
> driver.
> 

I dont think there is really any chance to upstream a vendor protocol that
is a bare copy of a standard protocol just to workaround this...and if
this is going to be the end-result you can just keep your current 2
small 'IMX custom-compatible' patches downstream.

> But in the end I would think when more SCMI vendor protocols
> comes in, saying vendor A and vendor B both use ID 0x81,
> both use 0x81 as RTC functions, same issue will come back.
>

This wont be a problem once the RFC[1] I posted last week is in...unless
someone objects, you will have to identify your vendor protocol module
at build time ALSO with the vendor/sub_vendor ID string exposed by your fw...
..so each vendor will effectively have the full vendor protocol space
number at their disposal.

Indeed this week, I hope to review your series about custom protocols
and the qualcomm ones and ask both for feedback on [1] and then to
rework those series on some non-RFC similar to 1 that I will post
afterwards.

Thanks,
Cristian

[1]: https://lore.kernel.org/linux-arm-kernel/20240122122437.546621-1-cristian.marussi@arm.com/

