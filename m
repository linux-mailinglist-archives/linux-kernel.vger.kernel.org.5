Return-Path: <linux-kernel+bounces-23896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1C082B35A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7302AB21545
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7B5101E;
	Thu, 11 Jan 2024 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cFrcMzmV"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918985026B;
	Thu, 11 Jan 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nNmbzZCswWwtgLBrD7rB/wFzIPdTH+54rK1gGsl9Ncg=; b=cFrcMzmVFAp+coo1nDD28eInxq
	nMFcPA1xyhMPEqFpH+zsbA2gopiczhZz5FpCbxUh1DUYNYo5KUzg4In+TYehxwBWGUD0HoOAgXCv1
	IC8SAMECz9+GSwbp3EZmnsLeAD+dhgT5Zr7GX/4QwzyjbPLq4Ne9Uz8un4zR37NrHpOl9CrsKkVw7
	5DmHCy9iTuco0zeMacSYzI04hd5reNLpMV7k09WzKmTD3fpmuZ99A9kbAeDeZ7Xf7xgAVj1GbDVZJ
	YN09g/5Eq3gbHpePnax1JaaA2uSOw6R1E9jfymmEN+ywMa6mHCDMCHM23Dm2Y7HWz2H60V9IsemJ2
	FiZPvkTw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58298)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rNyHu-0006nN-2C;
	Thu, 11 Jan 2024 16:52:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rNyHv-0006WK-Bc; Thu, 11 Jan 2024 16:52:15 +0000
Date: Thu, 11 Jan 2024 16:52:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Message-ID: <ZaAcvwWbNmSpw/xt@shell.armlinux.org.uk>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <c795aa28-b6a2-4db8-b941-05b51b44f1fe@lunn.ch>
 <a4af4a08-6eea-420b-b76f-47f4e836b476@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4af4a08-6eea-420b-b76f-47f4e836b476@leica-geosystems.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 11, 2024 at 04:45:26PM +0000, POPESCU Catalin wrote:
> On 11.01.24 17:35, Andrew Lunn wrote:
> > [You don't often get email from andrew@lunn.ch. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > This email is not from Hexagon’s Office 365 instance. Please be careful while clicking links, opening attachments, or replying to this email.
> >
> >
> > On Thu, Jan 11, 2024 at 05:19:25PM +0100, Catalin Popescu wrote:
> >> Add property ti,cfg-dac-minus to allow for voltage tuning
> >> of logical level -1 of the MLT-3 encoded data.
> >>
> >> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> >> ---
> >>   Documentation/devicetree/bindings/net/ti,dp83822.yaml | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> >> index db74474207ed..2f010333be49 100644
> >> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> >> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> >> @@ -62,6 +62,15 @@ properties:
> >>          for the PHY.  The internal delay for the PHY is fixed to 3.5ns relative
> >>          to transmit data.
> >>
> >> +  ti,cfg-dac-minus:
> >> +    description: |
> >> +       DP83826 PHY only.
> >> +       Sets the voltage ratio of the logical level -1 for the MLT-3 encoded data.
> >> +       0 = 50%, 1 = 56.25%, 2 = 62.50%, 3 = 68.75%, 4 = 75%, 5 = 81.25%, 6 = 87.50%,
> >> +       7 = 93.75%, 8 = 100%, 9 = 106.25%, 10 = 112.50%, 11 = 118.75%, 12 = 125%,
> >> +       13 = 131.25%, 14 = 137.50%, 15 = 143.75%, 16 = 150%.
> >> +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
> > We try to avoid register values in DT. We use real units. This is a
> > voltage you are configuring, so can you change the unit to millivolts?
> > Have the driver do the conversion of volts to register value.
> >
> > Is it possible to configure any of the other logical levels?
> 
> Hi Andrew,
> These are not raw register values and these are not voltage values but 
> voltage ratios. I'm mapping the voltage ratios to enum values [0-16] 
> which are converted to register raw values by the driver. I don't see a 
> better way to do this.

	enum: [ 5000, 5625, 6250, 6875, 7500, 8125, 8750, 9375, 10000,
		10625, 11250, 11875, 12500 13125, 13750, 14375, 15000 ]

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

