Return-Path: <linux-kernel+bounces-15643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC306822F5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66681C2350E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FB81A5A0;
	Wed,  3 Jan 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YqTRV7Vl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF611A585;
	Wed,  3 Jan 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eCxJHVjVhX9miBj2Rlu9rCBVdhCCoWX7LYP4sTNG5GY=; b=YqTRV7Vl5smuubd7bGIR3inNfQ
	+94q6QgmxA3IeXXoHZL+vCBQ/BkV9Iv9O7S873V1kRCxtnKj1mgFPeKU2DRCovyRKXr5ZvpqkSUI0
	cM5B0yuI3FKDC9mTnibQt5HTnPIkqpafopbBDGOATHcWNSKZl87HzRNbZWUYlm0Y/Nvw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rL28V-004GKS-5P; Wed, 03 Jan 2024 15:22:23 +0100
Date: Wed, 3 Jan 2024 15:22:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, corbet@lwn.net, p.zabel@pengutronix.de,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <85590a5b-9d5a-40cb-8a0e-a3a3a1c3720a@lunn.ch>
References: <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
 <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
 <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
 <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
 <ZZPeHJJU96y1kdlZ@shell.armlinux.org.uk>
 <6593e0a3.050a0220.5c543.8e12@mx.google.com>
 <cee9de2c-bfa4-4ca9-9001-725e2041bc25@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee9de2c-bfa4-4ca9-9001-725e2041bc25@quicinc.com>

> Yes, APQ8084 is the application SoC.
> QCA8084 is the pure PHY chip which has quad-phy.

I think everybody agrees these are terrible names, being so close
together but being very different devices.

You have the issues of not giving clear explanations of your
hardware. This is resulting in a lot of wasted tome for everybody. So
please make your explanations very clear. I personally would avoid
using APQ8084 or QCA8084 on there own. Always say the application SoC
APQ8084, or the PHY chip QCA8084, or the switch embedded within the
application processor APQ8084, or the PHYs embedded within the
Application processor etc. This is particularly important when talking
about clocks and resets, since the PHYs embedded within the
application processor are likely to have different clocks and reset
controllers to the PHY chip QCA8084.

	Andrew

