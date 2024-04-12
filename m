Return-Path: <linux-kernel+bounces-142572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D72B8A2D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6601C21B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C750548E4;
	Fri, 12 Apr 2024 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqQ7kT95"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3634205A;
	Fri, 12 Apr 2024 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921074; cv=none; b=MEwFYCfWDNOTZ+NIkLwMizLJtD8ZBivGFLG7Dg3tkcddFX3DAVq3ux4jGcCFzYPZLilzQLk1ZfPno0sxFkVPWL18J4P8X0ququKqkx4Ut4uU2NTWZwYPRpSOjkrLkmsfbZ1/K8361Af7Kjx0mV5QfeQGwSon5qXEcGx4eZpji2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921074; c=relaxed/simple;
	bh=R3EqEdsxBODVZiR1t4FsAY+uuXyMbJl01zKUTUB4X0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtgfHEYcIi6AqgpW8lXoJYuy8cbtAjed/vnKoFV6Bdx98YWGUg3vSLaaWTLV7Tti05E5wCwiBRtATt88Y1+hpTR7FYYh8UNIGA9wvREnx5lkJW6yV1tK+0Nf/1QQdIao47h7vc9mIIzDu4NASwgYwYJbqncOqh2p9g/iob5Fx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqQ7kT95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14499C113CC;
	Fri, 12 Apr 2024 11:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921073;
	bh=R3EqEdsxBODVZiR1t4FsAY+uuXyMbJl01zKUTUB4X0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqQ7kT95yl/1TSCMsM0Ubak214wpR+mfm7iQA7CU/OuTGl4C/gKGQhlCR9OghpH3I
	 8oC4lxUB6jhgZPWP2FZsD9sgeb9MD1W2BpkZbYpJt3GKkGQl979HM4DiZSyCTrnPms
	 aNEmXpDfsiKmPPMlyVIwPbLKUZ0FFCyQEYA0i2sNDA6/49qNyY7qdg6FXtPwvMJdsA
	 L3hAVRCAY1On5mr7niXzvgTXwT8U9dSP28znSmJ4X3f5bwKfo1zXEyuGFjAn8k7Xfq
	 5rt4RfJSM2foXL8pqWVpetqDGk03OylwFPQvIsDpdEbwQMuIoGAyjjPqosdAJ++93W
	 kgjBDILRl6VzA==
Date: Fri, 12 Apr 2024 16:54:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
	"linux-imx@nxp.com" <linux-imx@nxp.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"kishon@kernel.org" <kishon@kernel.org>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [PATCH v1 0/1] phy: freescale: imx8m-pcie: facing pcie link-up
 instability
Message-ID: <ZhkZ7R7E9LlfZX-l@matsya>
References: <20240322130646.1016630-1-marcel@ziswiler.com>
 <171239511427.352254.8525089049107113141.b4-ty@kernel.org>
 <ae96ab05b47f9788bce1c8df5a795b35e16a629c.camel@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae96ab05b47f9788bce1c8df5a795b35e16a629c.camel@toradex.com>

On 07-04-24, 22:22, Marcel Ziswiler wrote:
> Hi Vinod
> 
> On Sat, 2024-04-06 at 14:48 +0530, Vinod Koul wrote:
> > 
> > On Fri, 22 Mar 2024 14:06:31 +0100, Marcel Ziswiler wrote:
> > > In our automated testing setup, we use Delock Mini-PCIe SATA cards [1].
> > > While this setup has proven very stable overall we noticed upstream on
> > > the i.MX8M Mini fails quite regularly (about 50/50) to bring up the PCIe
> > > link while with NXP's downstream BSP 5.15.71_2.2.2 it always works. As
> > > that old downstream stuff was quite different, I first also tried NXP's
> > > latest downstream BSP 6.1.55_2.2.0 which from a PCIe point of view is
> > > fairly vanilla, however, also there the PCIe link-up was not stable.
> > > Comparing and debugging I noticed that upstream explicitly configures
> > > the AUX_PLL_REFCLK_SEL to I_PLL_REFCLK_FROM_SYSPLL while working
> > > downstream [2] leaving it at reset defaults of AUX_IN (PLL clock).
> > > Unfortunately, the TRM does not mention any further details about this
> > > register (both for the i.MX 8M Mini as well as the Plus). Maybe somebody
> > > from NXP could further comment on this?
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] phy: freescale: imx8m-pcie: fix pcie link-up instability
> >       commit: 3a161017f1de55cc48be81f6156004c151f32677
> 
> Sorry, but it is slightly confusing whether v1 or v2 now got applied. I believe v1 but then only the commit
> messages differ. However, please note that only v2 included information on how to proceed concerning
> backporting to stable 6.1.x.

V2 was picked, you can check phy tree

Somehow b4 sent email for v1 as well

-- 
~Vinod

