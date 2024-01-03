Return-Path: <linux-kernel+bounces-15782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581308231EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1049289B04
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F73C1C293;
	Wed,  3 Jan 2024 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EFh0ToC/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD2F1BDE9;
	Wed,  3 Jan 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oVTmI+8SJlo66J8e4e/1PXwZd0ZEK+jDBeMKC2o+Ab8=; b=EFh0ToC/9RxY68FyQPfSmJBxkr
	0jQUb8I3mc4fZ2atp9SL3oJkZTRcg5BoLVYQXEK4hQX5h1kbKX9FzGKjkNJ4L28jthZSTu54Xkgl9
	vJP2aYFpNgdwHXJWtAG2ZeWkOqYMEakNXaZID41bdpzDRS+Aig2KRdKGcxTullSakE9yUhOYUmMNm
	WVPNX32gxmcPQmyi8pnR7R7wYIKyxjDlwCdE1gTsasGdWynZb2Zf4/1W/FJdEF3X7UGxoF2yub4WL
	DF/oaj211yxamL9CtaPiSrKsXS2Vu57xo/2owzMqI00cbOX134oGZKetqzS3AkbO9LeA/f/t5Ufzj
	qeLsKXBg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55008)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rL4as-0007iH-2U;
	Wed, 03 Jan 2024 16:59:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rL4as-0006Xp-OQ; Wed, 03 Jan 2024 16:59:50 +0000
Date: Wed, 3 Jan 2024 16:59:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v6 5/5] net: phy: at803x: add LED support for
 qca808x
Message-ID: <ZZWShvM4Fcs3Oogk@shell.armlinux.org.uk>
References: <20240102183835.5332-1-ansuelsmth@gmail.com>
 <20240102183835.5332-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102183835.5332-6-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 02, 2024 at 07:38:34PM +0100, Christian Marangi wrote:
> +	if (active_low) {
> +		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_AN,
> +					 QCA808X_MMD7_LED_POLARITY_CTRL,
> +					 QCA808X_LED_ACTIVE_HIGH);
> +	} else {
> +		ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
> +				       QCA808X_MMD7_LED_POLARITY_CTRL,
> +				       QCA808X_LED_ACTIVE_HIGH);
> +	}

Maybe:

	return phy_modify_mmd(phydev, MDIO_MMD_AN,
			      QCA808X_MMD7_LED_POLARITY_CTRL,
			      active_low ? 0 : QCA808X_LED_ACTIVE_HIGH);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

