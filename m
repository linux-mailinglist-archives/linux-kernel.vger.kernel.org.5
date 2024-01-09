Return-Path: <linux-kernel+bounces-20937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802382879C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC22FB25045
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BF639AD4;
	Tue,  9 Jan 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="benXRy8S"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4239FC7;
	Tue,  9 Jan 2024 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ReygpUPBEdZ1BRba3KM+g+WyDgtAIJz2xQPrwSClj6s=; b=benXRy8Sd0RZPkpPHP3tvYyP4F
	/hriQTChaPlBlekykMH+kl8qDiLEslaBxiTp+Nondmdzc2siU1HD05lcQvKdbm3vzoDmnKdkS3Dp+
	XdLE5DZtVbW5voBHXjDubMIWGkzGPg6eUMg1T9MCuo3o1J4WTFCiMwaaXJdNt1ZYdMPU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNCfd-004q18-Hg; Tue, 09 Jan 2024 15:01:33 +0100
Date: Tue, 9 Jan 2024 15:01:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Tero Kristo <kristo@kernel.org>, srk@ti.com, r-gunasekaran@ti.com,
	afd@ti.com
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet
 support
Message-ID: <70f2b16c-19af-41af-bd7f-255814899477@lunn.ch>
References: <20231212165832.3933335-1-danishanwar@ti.com>
 <20231212165832.3933335-3-danishanwar@ti.com>
 <1a2aba0c-5c4d-4258-b89c-b1be4593d7ff@lunn.ch>
 <f7dd0868-1eda-4dff-9b9f-ae55f07c7d96@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7dd0868-1eda-4dff-9b9f-ae55f07c7d96@ti.com>

On Tue, Jan 09, 2024 at 10:53:16AM +0530, MD Danish Anwar wrote:
> Hi Andrew,
> 
> On 13/12/23 6:56 pm, Andrew Lunn wrote:
> > On Tue, Dec 12, 2023 at 10:28:31PM +0530, MD Danish Anwar wrote:
> >> ICSSG1 provides dual Gigabit Ethernet support with proper FW loaded.
> >>
> >> The ICSSG1 MII0 (RGMII1) has DP83869 PHY attached to it. The ICSSG1 shares
> >> MII1 (RGMII2) PHY DP83869 with CPSW3g and it's assigned by default to
> >> CPSW3g. The MDIO access to MII1 (RGMII2) PHY DP83869 is controlled by MDIO
> >> bus switch and also assigned to CPSW3g. Therefore the ICSSG1 MII1 (RGMII2)
> >> port is kept disable and ICSSG1 is enabled in single MAC mode by
> >> default.
> > 
> > FYI
> > 
> > I want to review all this MII muxing, but it won't be today.
> 
> Did you get the chance to review this?

Sorry, no.

I will try to find some time in the next two weeks. During the merge
window it tends to be quieter.

       Andrew

