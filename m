Return-Path: <linux-kernel+bounces-2213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7757815998
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177C11C216C7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D92208B;
	Sat, 16 Dec 2023 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IoXaWU4d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8152C6A9;
	Sat, 16 Dec 2023 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dSsrLnhvQMh6fed+BTCDMZIum7s58eYFEwcQNJr4BqE=; b=IoXaWU4dUaeDmsuhAoOpjm0sd1
	HKoOolEwFK2gD1iF5p99cML3WccY5XjkOnhu4UMZKmToZqqCH+hiLjvMN9jBKK+dYfDMAm1zXNA4W
	6Mk+75xgCTm+tulWvITlE4xFal1mtk7fzv9ibLC7TU9P9Fb4ljxK7g0J+mEijHuAOhf7iQkpgWbAQ
	1kZhD08zTk9W7asMgGI+tx9/oDwtlCzpx8sbvqJ6vsak5wKTn6ji4hH12MjxiN/edLqTJnk3J+/ar
	pVv7Tl243xLUkI7wK8ZVuvXfjwU9bQd8EfYiXFinqZNN1QluCuZw9iN+m2GvZ+XgvSdPHfDsK70R4
	h3akB9TQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55866)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rEV4X-0003ms-22;
	Sat, 16 Dec 2023 13:51:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rEV4V-0004i2-WF; Sat, 16 Dec 2023 13:51:16 +0000
Date: Sat, 16 Dec 2023 13:51:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jie Luo <quic_luoj@quicinc.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, corbet@lwn.net,
	p.zabel@pengutronix.de, f.fainelli@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Dec 16, 2023 at 11:21:53AM +0100, Andrew Lunn wrote:
> > The following is the chip package, the chip can work on the switch mode
> > like the existed upstream code qca8k, where PHY1-PHY4 is connected with
> > MAC1-MAC4 directly;
> 
> Ah, that is new information, and has a big effect on the design.

This QCA8084 that's being proposed in these patches is not a PHY in
itself, but is a SoC. I came across this:

 https://www.rt-rk.com/android-tv-solution-tv-in-smartphone-pantsstb-based-on-qualcomm-soc-design/

It's sounding like what we have here is some PHY IP that is integrated
into a larger SoC, and the larger SoC needs to be configured so the
PHY IP can work correctly.

Given that this package of four PHYs seems to be rather unique, I think
we need Jie Luo to provide sufficient information so we can understand:

1) this package of four PHYs itself
2) how this package is integrated into the SoC

Specifically, what resets and clocks are controlled from within the
package's register space, which are external to the package
register space (and thus are provided by other IPs in the SoC).

As I've said previously, the lack of DT example doesn't help to further
our understanding. The lack of details of what the package encompases
also doesn't help us understand the hardware.

Unless we can gain that understanding, I feel that Jie Luo's patches
are effectively unreviewable and can't be accepted into mainline.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

