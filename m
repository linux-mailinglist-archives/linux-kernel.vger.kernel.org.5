Return-Path: <linux-kernel+bounces-2294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB4815AA2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736A5285412
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261630FA1;
	Sat, 16 Dec 2023 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z3DOtHl1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367E30655;
	Sat, 16 Dec 2023 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hrOJL9ogPzJ7HEhCd4Qe0YMW4aSLZkhR6ny2rWbeLlM=; b=Z3DOtHl11xt3qjpGvrx8O567YY
	OyRZqagsVzh2T4lVnpWL2B2ZPc0EOjFzOUBFFRuxoOeuDWoEA3rCxNnXSqVaHDO9+5Wbyb++QWrew
	ueLefLLAFgZdPindA0/ncLO5zxGhUBdx+MVI/1Rx4gAWJEoiQZnFiOlGR78C+44X/RTo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEYUC-0036wK-E6; Sat, 16 Dec 2023 18:30:00 +0100
Date: Sat, 16 Dec 2023 18:30:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
	p.zabel@pengutronix.de, f.fainelli@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <15d95222-35dd-4ea1-a1a3-3ad9e4ef0349@lunn.ch>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>

> The following is the chip package, the chip can work on the switch mode
> like the existed upstream code qca8k, where PHY1-PHY4 is connected with
> MAC1-MAC4 directly; The chip can also work on the PHY mode, where PHY1-
> PHY4 is connected with PCS1 by 10g-qxgmii; Either switch mode or PHY mode,
> the PHY4 is optionally connected with PCS0 by SGMII, PCS0 and PCS1
> are connected with the SoC(IPQ platform) PCSes.

I don't really understand. Are you saying the hardware is actually :


+----------------------------------------------+
|          PCS1           PCS0                 |
|                                              |
|          MAC0           MAC5                 |
|           |              |                   |
|     +-----+--------------+-------------+     |
|     |                                  |     |
|     |                Switch            |     |
|     |                                  |     |
|     +-+---------+---------+---------+--+     |
|       |         |         |         |        |
|      MAC1      MAC2      MAC3      MAC4      |
|                                              |
|      PHY1      PHY2      PHY3      PHY4      |
+----------------------------------------------+

When in PHY mode, the switch is hard coded to map the 4 PCS1 channels
straight to MAC1-MAC4 and all switch functionality is disabled. But
then in switch mode, the switch can be controlled as a DSA switch? The
10G PCS1 is then a single 10G port, not 4x 2.5G?

Is there a product brief for this PHY? That might help us understand
this hardware?

    Andrew

