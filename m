Return-Path: <linux-kernel+bounces-104659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF63987D1AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444D228361B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881F54911;
	Fri, 15 Mar 2024 16:53:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5335478B;
	Fri, 15 Mar 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521603; cv=none; b=sGdBu0jeIBcGyQXUjYvLLv8dBIilyA8BUwmUg4FwoTWwBahVP2bHnc6VZVbh4jVUJwHp89YicR5Wbj5gjlmy3Skca8OLhUXsas1vEKUwY02mzmKtWkJ05UBODUs4efW/NaeDQ0JtUk/+I5fEd8utakf+XtWqY4cyJeiH0ez7pYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521603; c=relaxed/simple;
	bh=quOxwG7GF78bsqXhXIFaqgiZCtCviVlc+c2l1XriIXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaiHM/RDmKgPkTmpwu3iudvKYmt9ksqjmFobUVqKuyGHxbebKIPEQHa33GArUyXyKFt1CzQSFaG3wwudnoLnVQxGVW4d0BsAE5RL+zAyRvebIVH2BS2eL/j6nO+F1ePQxGHr2uWLtG/9HL39EK1E26Vds23sxgpIJQ0D/d42o+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BD90C15;
	Fri, 15 Mar 2024 09:53:54 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83CF33F762;
	Fri, 15 Mar 2024 09:53:16 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:53:10 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
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
Subject: Re: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZfR89rdzRymY1Ovx@pluto>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
 <ZfMqWP-t39SCvkA2@pluto>
 <DU0PR04MB9417056FD84405898F1B007B88282@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417056FD84405898F1B007B88282@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Fri, Mar 15, 2024 at 12:31:51AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> > protocol basic support
> > 
> > On Thu, Mar 14, 2024 at 09:35:17PM +0800, Peng Fan (OSS) wrote:
> > > Since SCMI 3.2 Spec is released, and this patchset has got R-b/T-b, is
> > > it ok to land this patchset?
> > >
> > 
> > I'll have a look at this last version and a spin on my test setup.
> > 
> > ...but has this V5 change at all since the Reviewed-by tags due to the latest
> > spec changes ?
> 
> The tags are same as V4. I only did a rebase, no more changes.
> > 

Ok.

> > ...IOW does this V5 include the latest small bits spec-changes or those latest
> > gpio-related spec-changes are just not needed at the level of the Linux pinctrl
> > support as of now and can be added later on when a Linux gpio driver will be
> > built on top of this ?
> 
> In my current test, I no need the gpio related changes, so I would add that later
> if you are ok.
> 

I COULD have agreed with this, since AFAIK there is currently an effort to
add support for GPIO on top of SCMI Pinctrl BUT not in Linux, so no reason to
block this series for gpio-related missing features, that should only be additions
not breaking backward compatibility...

...BUT, I've just wrapped my head again around the latest public release
of v3.2 spec (which has gone through so many changes and additions that
I had lost track O_o) AND beside the above mentioned GPIO changes there
are indeed also BREAKING changes around the commands PINCTRL_SETTINGS_GET and
PINCTRL_SETTINGS_CONFIGURE (which were the old PINCTRL_CONFIG_GET/SET),
that now also get/set the selected function: so that, at the end the payload
itself of those commands/replies has also changed IN SIZE, so the driver needs
definitely to be updated (and whatever you use to test on the backend server too,
if you want to test this...)

I think these changes (which I forgot being there) were in since last month, so
already V4 was broken in these regards (which I have not looked at)

I'll leave some comments along the series and test all of this again next week...
..since too many things has changed and I want to re-verify all on my side.

Thanks,
Cristian


