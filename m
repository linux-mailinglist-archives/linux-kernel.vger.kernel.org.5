Return-Path: <linux-kernel+bounces-48007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A3B84562E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B1A286345
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002615CD76;
	Thu,  1 Feb 2024 11:24:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEDA15CD52;
	Thu,  1 Feb 2024 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786657; cv=none; b=jzltFvIyEjrfPg7wZ1UvX/060Rrfox0IuC/ntZ07/Af1nuis4lYRKzzY77dZ82Yb/wwVDMxqshk8bHML1iA3LDErVwL7skpTumgmNwMRsUpHn54Ddrdyzxv3hsIh56CofX7EFwDD+okx0MDwXxsLmosWmThJHYpsS9Qb7ty643s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786657; c=relaxed/simple;
	bh=uZUoJTXUOtGTmSyrM1RM4G9rWHINL+HQGMIgwpk5Gdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+CwVJY5XUuG/bHGjcvtw7LceCq7zqI6dgi30ALwO8xt43Xjm+ed68fmHGjuNHe/V1LyZUtJYnnAypK7FVI1cyYywUYKJPxobMG9ZMLNjeQINGooqb15RIX4h/TvgZIQHt0XVzsDLDiU3wUUb1h2bX2Uag1XLETY3RRJmyT2nUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9273FDA7;
	Thu,  1 Feb 2024 03:24:56 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0C5F3F762;
	Thu,  1 Feb 2024 03:19:41 -0800 (PST)
Date: Thu, 1 Feb 2024 11:19:30 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"souvik.chakravarty@arm.com" <Souvik.Chakravarty@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
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
Message-ID: <Zbt-QkWhz5d9P-v6@pluto>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
 <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>
 <CACRpkdYV=qYQ9qDUWYTLDAV1niay30gYH5S=zjfi31GpeY5o-A@mail.gmail.com>
 <DU0PR04MB9417A9074C5DC49AE689E65288432@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB9417A9074C5DC49AE689E65288432@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Thu, Feb 01, 2024 at 07:14:17AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> > protocol basic support
> > 

Hi Peng,

> > On Mon, Jan 29, 2024 at 1:37 PM Peng Fan <peng.fan@oss.nxp.com> wrote:
> > 
> > > And for i.MX95 OEM extenstion, do you have any suggestions?
> > > I have two points:
> > > 1. use vendor compatible. This would also benefit when supporting
> > > vendor protocol.
> > > 2. Introduce a property saying supporting-generic-pinconf
> > >
> > > How do you think?
> > 
> > While I don't know how OEM extensions to SCMI were designed, the pin
> > control subsystem has the philosophy that extensions are for minor fringe
> > stuff, such as a pin config option that no other silicon is using and thus have
> > no use for anyone else. Well that is actually all the custom extensions we
> > have.
> > (This notion is even carried over to SCMI pinctrl.)
> > 
> > The i.MX95 OEM extension is really odd to me, it looks like a
> > reimplementation of the core aspects of SCMI pin control, and looks much
> > more like the old i.MX drivers than like the SCMI driver.
> 
> i.MX SCMI pin protocol conf settings follows non-SCMI pin conf settings.
> 

It is not just a matter of using custom SCMI OEM types, it is the whole
layout/definitions of the i.MX pin/groups/funcs DT bindings that deviates from
the generic DT bindings layout as handled and expected by the Linux Pinctrl
subsystem (AFAIU), while the SCMI Pinctrl driver as it stands in this series,
was conceived, designed and implemented originally by Oleksii to just use the
generic existing Pinctrl DT bindings; as a consequence, in your i.MX extensions,
you had to add a dedicated i.MX DT parser to interpret the protocol@19 DT snippet
in a completely different way, to try to stick your custom solution on top of
the generic one.

Thanks,
Cristian

> > 
> > But I sure cannot speak of what is allowed in SCMI OEM extensions or not.
> 
> + SPEC owner, Souvik. Any comments?
> 
> Thanks,
> Peng.
> 
> > 
> > Yours,
> > Linus Walleij

