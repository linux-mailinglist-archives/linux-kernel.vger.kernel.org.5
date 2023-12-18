Return-Path: <linux-kernel+bounces-3249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3828B8169E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75B228317D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2211CB9;
	Mon, 18 Dec 2023 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uYDD1Zf2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835D12B61;
	Mon, 18 Dec 2023 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kn4zmaFBjozESWwWrKfESsTCFZ/blBS5KRsj7FAUpT0=; b=uYDD1Zf2+rVDnY4JLZf2awm+dP
	Nvwdtr9XH3ac4S/0D1GWjUeFg5i3cT4+7nIVquTQ4MNB2Wc7XISjwImK2ixEFci9VLhrXOK++0oUo
	FlqToatihkMOqW0NPVNhFKpQXYrbv9qZkeMH5e5TEQEyVYZd+lRH/Q4YIiJCl3Gr1KYk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rFA0n-003EBi-V6; Mon, 18 Dec 2023 10:34:09 +0100
Date: Mon, 18 Dec 2023 10:34:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	hkallweit1@gmail.com, corbet@lwn.net, p.zabel@pengutronix.de,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Message-ID: <b4fe4ac4-9b28-4dba-8287-1af4804eb0be@lunn.ch>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <bdfba8a7-9197-4aae-a7f9-6075a375f60b@linaro.org>
 <c3391e33-e770-4c61-855e-d90e82b95f75@quicinc.com>
 <4cb2bd57-f3d3-49f9-9c02-a922fd270572@lunn.ch>
 <ed0dd288-be8a-4161-a19f-2d4d2d17b3ec@quicinc.com>
 <ZXxXzm8hP68KrXYs@shell.armlinux.org.uk>
 <3a40570b-40bf-4609-b1f4-a0a6974accea@quicinc.com>
 <b5ff9f69-e341-4846-bc5a-ebe636b7a71a@lunn.ch>
 <27ee13e7-5073-413c-8481-52b92d7c3687@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ee13e7-5073-413c-8481-52b92d7c3687@quicinc.com>

> Thanks Andrew for the proposal.
> For the pure PHY chip qca8084, there is no driver to parse the package
> level device tree node for common clocks and resets.

So you still have not look at the work Christian is doing. You must
work together with Christian. This driver is not going to be accepted
unless you do.

> > >          ethernet-phy@0 {
> > >              compatible = "ethernet-phy-id004d.d180";
> > >              reg = <0>;
> > >              clocks = <qca8k_nsscc NSS_CC_GEPHY0_SYS_CLK>,
> > >              clock-names = <"gephy_sys">;
> > >              resets = <&qca8k_nsscc NSS_CC_GEPHY0_SYS_ARES>,
> > >                       <&qca8k_nsscc NSS_CC_GEPHY0_ARES>;
> > >              reset-names = "gephy_sys", "gephy_soft";

Which of these properties exist for the Pure PHY device? Which exist
for the integrated switch? And by that, i mean which are actual pins
on the PHY device? We need the device tree binding to list which
properties are required for each use case.

	   Andrew

