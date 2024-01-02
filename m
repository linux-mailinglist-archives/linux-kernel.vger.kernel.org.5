Return-Path: <linux-kernel+bounces-14218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E9382194D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD55282E1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD592D271;
	Tue,  2 Jan 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ANLY/JZD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB23CA64;
	Tue,  2 Jan 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9ImigIKQ0f5FtlKrHZFopBhXW0/whWx1b/wua1Xqmmg=; b=ANLY/JZDuRf2a6cANeNpO1omaM
	Wu+MbU007YJGjRFez4pvalbNQj+bcT1dTgsHvNHKDoD9iW2pLH3+YkbcCWM9G1uW9rf2dIFps1Ypm
	3HTGRJkHE499C4nhK7yCS7ECQvO8kuM8j4oZvv5o4SNzVjWfvbn9Iz+AfjO71j6Znd149LPeoC5Vv
	SeZo3iCTVTbRb/HRaQUi5YY/l09hOI+80aUW5aqlN+blrYp5jOhpQZdG0fWbzP1c8boUxCYMakfv8
	J4ZW4XnxjDHcKiBHm3o/XT+eSpMPBuoTP2RLEJhAkRVqgm3wXkXHgJaAf3n8LpWeXeM1nsKDX8PKn
	wYoQPjUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52110)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKbSk-0006Kj-0m;
	Tue, 02 Jan 2024 09:53:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKbSk-00059b-Aq; Tue, 02 Jan 2024 09:53:30 +0000
Date: Tue, 2 Jan 2024 09:53:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: at803x: better align function
 varibles to open parenthesis
Message-ID: <ZZPdGnJQ1V/E8zBP@shell.armlinux.org.uk>
References: <20231217235011.2070-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217235011.2070-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 18, 2023 at 12:50:11AM +0100, Christian Marangi wrote:
> -	if (qca808x_cdt_fault_length_valid(pair_a))
> -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A,
> -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A));
> -	if (qca808x_cdt_fault_length_valid(pair_b))
> -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B,
> -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B));
> -	if (qca808x_cdt_fault_length_valid(pair_c))
> -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C,
> -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C));
> -	if (qca808x_cdt_fault_length_valid(pair_d))
> -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D,
> -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D));
> +	if (qca808x_cdt_fault_length_valid(pair_a)) {
> +		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A);
> +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A, val);
> +	}
> +	if (qca808x_cdt_fault_length_valid(pair_b)) {
> +		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B);
> +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B, val);
> +	}
> +	if (qca808x_cdt_fault_length_valid(pair_c)) {
> +		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C);
> +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C, val);
> +	}
> +	if (qca808x_cdt_fault_length_valid(pair_d)) {
> +		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D);
> +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D, val);
> +	}

Maybe a static function for these?

static void qca808x_get_cdt_length(struct phy_device *phydev, u8 pair)
{
	ethnl_cable_test_fault_length(phydev, pair,
				      qca808x_cdt_fault_length(phydev, pair));
}

or going via 'val'. Either way, repeating the same two lines multiple
times seems a bit suboptimal.

Whether or not you do this:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

