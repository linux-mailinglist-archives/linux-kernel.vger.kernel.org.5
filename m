Return-Path: <linux-kernel+bounces-68621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E57857D56
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210291C23D33
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FB6129A85;
	Fri, 16 Feb 2024 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LFRcf+FG"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A21B966;
	Fri, 16 Feb 2024 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089077; cv=none; b=LOhHTzi4Ypsy5lLMw3sKx70uungcLezdq4iwF62PPYyoXscTVNLyDrpaYfGLZSdvwoKfxpK1rFO+uY0n42IkECrjrvRC955FOEIbwLN3ca1+LpHWddQ8mfmaG2VZezgLb2UEwSfjB4qYsRleaFQIolyyXz/2vla5E5xfD0KW2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089077; c=relaxed/simple;
	bh=09fLeGq9+9S9+JEOIZICcKLW5Nd6nHq8ITKywH2eDxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIzpUYzlcLb2NDJHwhu+Q+yZbmdTEVzigoJpRtds5Z3RByO+9mvIf64/2LvPZA7N9qIpwtcuoiNeXrYK0TZb+SGzHVbY33Vtm3iIgMhjqitAs7qcsPC5qgN8VlgvhSCo6Tn+3LxZMUeS8JcGTi0KK96Kc5xtLWwPzTreclXiJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LFRcf+FG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zhABv1+E2s34SsEus0w3Rug9fR+5Djl5esCNn5JhhIM=; b=LFRcf+FG3WKrUQTPuZovjF3IQP
	WhlQnCR37n3vOdJgAZuZsqn+kfJbd9m+NTqSYGnY12vK39Q9LP15jAhdSWb++wMH8c2fR1kRoULVt
	j9XkyAhile131BRE0LlFLd+3pnhoaMrr/E2bMVMih7e08a6+wl+WZaSQiQHyIZDLiW2Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raxzh-007ytK-C4; Fri, 16 Feb 2024 14:11:09 +0100
Date: Fri, 16 Feb 2024 14:11:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: forbidden405@outlook.com
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: net: add hisilicon-femac
Message-ID: <6dbd998c-269d-44eb-bf00-1eb79ee66f0e@lunn.ch>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-4-e0ad972cda99@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-net-v1-4-e0ad972cda99@outlook.com>

> +    femac: ethernet@9c30000 {
> +        compatible = "hisilicon,hi3798mv200-femac";
> +        reg = <0x9c30000 0x1000>, <0x9c31300 0x200>;
> +        ranges = <0x0 0x9c30000 0x10000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&crg HISTB_ETH0_MAC_CLK>,
> +                 <&crg HISTB_ETH0_MACIF_CLK>,
> +                 <&crg HISTB_ETH0_PHY_CLK>;
> +        clock-names = "mac", "macif", "phy";
> +        resets = <&crg 0xd0 3>, <&crg 0x388 4>;
> +        reset-names = "mac", "phy";
> +        phy-handle = <&fephy>;
> +        phy-connection-type = "mii";
> +        // To be filled by bootloader
> +        mac-address = [00 00 00 00 00 00];
> +        hisilicon,phy-reset-delays-us = <10000 10000 500000>;
> +        status = "okay";
> +
> +        mdio: mdio@1100 {
> +            compatible = "hisilicon,hisi-femac-mdio";

Is the MDIO bus master a device of its own? Is this compatible
actually used anywhere?

There are generally two different ways an MDIO bus master works. It is
an individual device, with its own register space and it gets probed
as an independent device. In this case, it needs a compatible to
indicate what driver should be used.

Or the MDIO bus master is embedded within a MAC driver. It shares the
register space with the MAC driver. It is not a device which gets
probed, and so it does not need a compatible. The MAC drivers
compatible is sufficient.

	Andrew

