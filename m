Return-Path: <linux-kernel+bounces-19806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1BF827484
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6A3B21AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43247524AC;
	Mon,  8 Jan 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="odd55ff7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E451C30;
	Mon,  8 Jan 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oyblU9fS9RIJhRfq92DSb7yUSCuEu12wiegVylc2g30=; b=odd55ff7qVX3LGHrloljObiz1O
	v2p/97U82lb9laxeFxsG3dQ6za8J5Q/HPzXk6Gsv9WaXA3PTPRXeDZOxJPz1XGlTfO82eaZIj14U9
	JLnVdnniUiBE2p/5QOoIzO32zAzlMcDICGN9t1Ydbx0khVNbx8jgj+4tMgDgEfuprlmYZPAOeaK4W
	iLe7w3jD18HHkjB6hHS2oh1PTJQraW4OS9BNS94QYqTJ5KsKOeV2fmNUmJhtRlPJErXhc4rbsJIM3
	Q0llvh+RPy0yoDh3b545p3E4shhJdRF8rug1bfVCVE1BIpOOTiUa2Za278kUvLqAtVCZWm25p4cMC
	gCS5fKlw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36992)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rMrwC-0003BF-0e;
	Mon, 08 Jan 2024 15:53:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rMrwD-0003MQ-F2; Mon, 08 Jan 2024 15:53:17 +0000
Date: Mon, 8 Jan 2024 15:53:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, robert.marko@sartura.hr,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_srichara@quicinc.com
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Message-ID: <ZZwabT7pmwDof8Cs@shell.armlinux.org.uk>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
 <ac1977f5-cd6a-4f16-b0a0-f4322c34c5f5@quicinc.com>
 <bdeca791-f2e5-4256-b386-a75c03f93686@gmail.com>
 <895eadd7-1631-4b6b-8db4-d371f2e52611@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895eadd7-1631-4b6b-8db4-d371f2e52611@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 06, 2024 at 04:45:08PM +0100, Andrew Lunn wrote:
> > I just realized that the UNIPHY block is a MII (probably SGMII) controller.
> > Isn't it? And I expect that it responsible more then just for clock
> > enabling. It should also activate and perform a basic configuration of MII
> > for actual data transmission. If so, then it should placed somewhere under
> > drivers/net/phy or drivers/net/pcs.
> 
> Before we decide that, we need a description of what the UNIPHY
> actually does, what registers it has, etc. Sometimes blocks like this
> get split into a generic PHY, aka drivers/phy/ and a PCS driver. This
> would be true if the UNIPHY is also used for USB SERDES, SATA SERDES
> etc. The SERDES parts go into a generic PHY driver, and the SGMII on
> to of the SERDES is placed is a PCS driver.
> 
> The problem i have so far is that there is no usable description of
> any of this hardware, and the developers trying to produce drivers for
> this hardware don't actually seem to understand the Linux architecture
> for things like this.

+1. I think it's now more convoluted than ever, and someone needs to
take a step back, look at the hardware, look at the kernel model, and
work out how to implement this. It needs to be explained in a clear
and concise way in _one_ go, not spread over multiple emails. Probably
with ASCII art diagrams showing the structure.

If that isn't possible, then someone needs to provide a detailed
description of the hardware so that the subsystem maintainers get a
proper view of what this hardware is so they can advise. This is the
least preferable option due to the maintainer time it takes.

If neither of these two things happen, then I'm afraid all bets are
off for getting this into the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

