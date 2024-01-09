Return-Path: <linux-kernel+bounces-21029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895D48288C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D8DB2294E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90AF39FDC;
	Tue,  9 Jan 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EhgJ5JBZ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948D39AE8;
	Tue,  9 Jan 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gRiZiJWOoVL6Oa5TlXweb+aZfLgTD3/mvROJ7Dpd6vo=; b=EhgJ5JBZ0knWO1CRq06h9bTbXZ
	ZF4H3dqITWvmqEbmUSX+49PXuSy0FBPA26c2MLmyPJtmBFYFq3bUYA6VFLywYgnE7ZlX/jh2JCA/X
	34HRmL1Sy/FR2AmKPpCon150+fczB7SXbtw4EgxEsc4X31/Dw4HSYckK4+DxBc+dvTEk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNDng-004qNW-I3; Tue, 09 Jan 2024 16:13:56 +0100
Date: Tue, 9 Jan 2024 16:13:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH v2] net: stmmac: dwmac-qcom-ethqos: Add support for 2.5G
 SGMII
Message-ID: <c9290a44-a239-4ccf-9e14-4647b68aac2f@lunn.ch>
References: <20240108121128.30071-1-quic_snehshah@quicinc.com>
 <4216bcbb-730d-4c51-a9ce-d3f0a0846e31@lunn.ch>
 <6f97e753-435e-4b86-bd47-290097f6a3f0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f97e753-435e-4b86-bd47-290097f6a3f0@quicinc.com>

On Tue, Jan 09, 2024 at 08:22:40PM +0530, Sneh Shah wrote:
> 
> 
> On 1/9/2024 1:00 AM, Andrew Lunn wrote:
> > On Mon, Jan 08, 2024 at 05:41:28PM +0530, Sneh Shah wrote:
> >> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
> >> mode for 1G/100M/10M speed.
> >> Added changes to configure serdes phy and mac based on link speed.
> > 
> > Please take a look at:
> > 
> > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> > 
> > The Subject is missing which tree this is for. Also, net-next is
> > closed at the moment.
> 
> It was supposed to be net-next. Missed updating in subject.
> Sorry for that!
> If net-next is closed at the moment, how to proceed further?
> Should I wait until it gets reopened?

Yes, please repost in two weeks time.

> >>  	switch (ethqos->speed) {
> >> +	case SPEED_2500:
> >> +		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
> >> +		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> >> +			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
> >> +			      RGMII_IO_MACRO_CONFIG2);
> >> +		if (ethqos->serdes_speed != SPEED_2500)
> >> +			phy_set_speed(ethqos->serdes_phy, SPEED_2500);
> > 
> > Is calling phy_set_speed() expensive? Why not just unconditionally
> > call it?
> > 
> It reconfigures whole serdes phy block, with lots of register read/writes.
> So I feel it is better to avoid doing this unconditionally

O.K, please add this to the commit message.

Part of the purpose of the commit message is to try to answer
questions the reviewers are going to ask when they look at the
code. Its better to put more in the commit message than less, it helps
get your code merged faster, and reduces the load on reviewers.

     Andrew

