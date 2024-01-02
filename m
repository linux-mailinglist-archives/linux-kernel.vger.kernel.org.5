Return-Path: <linux-kernel+bounces-14217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D51482194B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81F4282DD7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CECD266;
	Tue,  2 Jan 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PTjZT+yn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85ACA64;
	Tue,  2 Jan 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hHKFbUEIS5ipHE53Wsnge1tw3F+Oty8Rlp/6KIyJ0SM=; b=PTjZT+ynysR242Cz+a5gDo6Ug6
	vxfDl4l640h+U1q2VFbFKeuf86sURKmW73H8d15Qkn0/7Bsd6oXmu6vvrOpK2Vv8Dkhb3oHRzNU1O
	3HvBChhvWIyTe8Dw0bHzjAbMdF1/76379C2QtzPoBH528P2iBWNoxJuFA1XEMIRoY63PM55QF/DfL
	YL3xMQnMaelYjmhh2hz1Yf3zSHgh4HZriT2ziwBeBmLuWm47C07oskPy+VvfDv1LaMv19ntO3WSNO
	+a7nBcGi5aGRY5sIuKIvUrqhThMA9kRc9gVx4LZDofSfFmu0JiIbf42uI4wuVA039WlaUznPAYtdu
	egnlxz/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37522)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKbWu-0006Ku-1v;
	Tue, 02 Jan 2024 09:57:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKbWu-00059k-UX; Tue, 02 Jan 2024 09:57:48 +0000
Date: Tue, 2 Jan 2024 09:57:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, corbet@lwn.net, p.zabel@pengutronix.de,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <ZZPeHJJU96y1kdlZ@shell.armlinux.org.uk>
References: <20231215074005.26976-15-quic_luoj@quicinc.com>
 <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
 <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
 <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
 <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 18, 2023 at 11:01:03AM +0800, Jie Luo wrote:
> 
> 
> On 12/17/2023 12:09 AM, Russell King (Oracle) wrote:
> > On Sat, Dec 16, 2023 at 10:41:28PM +0800, Jie Luo wrote:
> > > 
> > > 
> > > On 12/16/2023 9:51 PM, Russell King (Oracle) wrote:
> > > > On Sat, Dec 16, 2023 at 11:21:53AM +0100, Andrew Lunn wrote:
> > > > > > The following is the chip package, the chip can work on the switch mode
> > > > > > like the existed upstream code qca8k, where PHY1-PHY4 is connected with
> > > > > > MAC1-MAC4 directly;
> > > > > 
> > > > > Ah, that is new information, and has a big effect on the design.
> > > > 
> > > > This QCA8084 that's being proposed in these patches is not a PHY in
> > > > itself, but is a SoC. I came across this:
> > > > 
> > > >    https://www.rt-rk.com/android-tv-solution-tv-in-smartphone-pantsstb-based-on-qualcomm-soc-design/
> > > 
> > > The chip mentioned in the link you mentioned is SoC, which is not the
> > > chip that the qca8084 driver work for.
> > 
> > So there's two chips called QCA8084 both produced by Qualcomm? I find
> > that hard to believe.
> > 
> 
> The SoC mentioned in the link you provided is the APQ8084 that is introduced
> in the link below:
> https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-processors-805

So the one mentioned in the rt-rk article and a load of CVEs is _not_
QCA8084 but is APQ8084. Sounds like a lot of people are getting stuff
wrong - which is hardly surprising as there are people that seem to
_enjoy_ getting the technical details wrong. I haven't worked out if
it's intentional malace, or they're just fundamentally lazy individuals
who just like to screw with other people.

Sigh.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

