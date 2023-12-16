Return-Path: <linux-kernel+bounces-2335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED6815B34
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DF7285DBD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D4931A6F;
	Sat, 16 Dec 2023 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t5qEeIlc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599111E485;
	Sat, 16 Dec 2023 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OkwSnz/x+hw4c0xXlPnigUYNs6Tn7wFQ/QxZa13dJc8=; b=t5qEeIlc3121z+dSVt4ZCU/PYa
	Qv/ZbQtLsVP+9NLHkgFXoa9zPwcH8pqycW42DmsjSo5T6LWzQOXBiAh/lACvS1YoAG+IeJ1ixQ10h
	J8WIYZx5VLPsBXtDExi2XUMs2vk7iNqYL3W3336V1Gor4u4ZakdbwkUIl38IPUA0wagTBD/KUDdVb
	/IIjz+1bDnr61I6QYO7W/NldqalNLQkBQh8fraM392ixYkPDN9i7WS6PK6SbHB/gGZnA7Dr+Ptb2c
	tYojilSRddiwys+a6Wpae2W7TAtkmLuA4wzYwH4lBlXzK3iyGgPQEUxBM4ihHo+usVUTGRMEpK/fs
	Ky5YIWOg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39248)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rEa1O-0003xs-2R;
	Sat, 16 Dec 2023 19:08:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rEa1O-0004tz-Lr; Sat, 16 Dec 2023 19:08:22 +0000
Date: Sat, 16 Dec 2023 19:08:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jie Luo <quic_luoj@quicinc.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, corbet@lwn.net,
	p.zabel@pengutronix.de, f.fainelli@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <ZX31pq4yXM8Fb/rj@shell.armlinux.org.uk>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <15d95222-35dd-4ea1-a1a3-3ad9e4ef0349@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15d95222-35dd-4ea1-a1a3-3ad9e4ef0349@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Dec 16, 2023 at 06:30:00PM +0100, Andrew Lunn wrote:
> > The following is the chip package, the chip can work on the switch mode
> > like the existed upstream code qca8k, where PHY1-PHY4 is connected with
> > MAC1-MAC4 directly; The chip can also work on the PHY mode, where PHY1-
> > PHY4 is connected with PCS1 by 10g-qxgmii; Either switch mode or PHY mode,
> > the PHY4 is optionally connected with PCS0 by SGMII, PCS0 and PCS1
> > are connected with the SoC(IPQ platform) PCSes.
> 
> I don't really understand. Are you saying the hardware is actually :
> 
> 
> +----------------------------------------------+
> |          PCS1           PCS0                 |
> |                                              |
> |          MAC0           MAC5                 |
> |           |              |                   |
> |     +-----+--------------+-------------+     |
> |     |                                  |     |
> |     |                Switch            |     |
> |     |                                  |     |
> |     +-+---------+---------+---------+--+     |
> |       |         |         |         |        |
> |      MAC1      MAC2      MAC3      MAC4      |
> |                                              |
> |      PHY1      PHY2      PHY3      PHY4      |
> +----------------------------------------------+
> 
> When in PHY mode, the switch is hard coded to map the 4 PCS1 channels
> straight to MAC1-MAC4 and all switch functionality is disabled. But
> then in switch mode, the switch can be controlled as a DSA switch? The
> 10G PCS1 is then a single 10G port, not 4x 2.5G?
> 
> Is there a product brief for this PHY? That might help us understand
> this hardware?

Not even digikey give any clues what "QCA8084" is - they list it as
"unclassified" and give no documentation and no photo. Basically it
seems to be a super secret device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

