Return-Path: <linux-kernel+bounces-18907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2A08264FE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4121C211CA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4157113AE2;
	Sun,  7 Jan 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SCDVufUw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4313AC8;
	Sun,  7 Jan 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Nfh3SPlScpJNbmFJG3AvjHYz4crJ6ErWPuXcGN1GLks=; b=SCDVufUwJZIwyEBZ8yQr0RsD3y
	lFaH1joDkia+4v8Z3v5GdHoj4lbuPTNvwNRTtcf+6SnmUX9mtkxmgiJnZOOvt9Ca3aJYAfIEodz7r
	cg0jMMEelJmS84t6X9sszVXiZ1AQgc9lDN75GESstm6Wt1R7n2LJrxl7sMpjetu3yCprCIrMjgqN1
	TqIYaKjtW9R4x3XkPv2fcmJxAx0aNnusmr/vGhuHwwvfrC6cxfw4/W3Gzir4LG3wBuExvJzvZd1jR
	q2geFA2iY/djUT/p18XrU602ScW1k+a45rZqNNkfbYq7NllmX16ny/v5YfJuhhKaGHFDkLQQVGonl
	HRKXqcXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54952)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rMVjd-0002Fm-0F;
	Sun, 07 Jan 2024 16:10:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rMVje-0002NN-2m; Sun, 07 Jan 2024 16:10:50 +0000
Date: Sun, 7 Jan 2024 16:10:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: add fixup for tplink 2.5gbase-t rj45 modules
Message-ID: <ZZrNChuIw0X9fr6Z@shell.armlinux.org.uk>
References: <20240106-tplink-25gbaset-sfp-fixup-v1-1-8d26696bd2f4@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106-tplink-25gbaset-sfp-fixup-v1-1-8d26696bd2f4@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 06, 2024 at 05:29:56PM +0100, Josua Mayer wrote:
> TP-Link TL-SM410U modules are single-rate 2.5GBase-T RJ45 SFP modules.
> The EEPROM data is lying about connector and extended cc,
> reporting 25Gbps fiber.
> 
> Add fixup for these specific modules forcing RJ45 @ 2.5Gbase-T.
> 
> For reference original eeprom data dump from ethtool:
> 
> Identifier                : 0x03 (SFP)
> Extended identifier       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
> Connector                 : 0x07 (LC)
> Transceiver codes         : 0x00 0x00 0x00 0x00 0x00 0x00 0x40 0x00 0x00
> Transceiver type          : FC: Twisted Pair (TP)
> Encoding                  : 0x01 (8B/10B)
> BR, Nominal               : 3100MBd

This isn't 25Gbps - it's 2.5Gbps!

So what actually happens with this module without the quirk? We should
end up marking it for use as a 2500base-X fibre module which should
result in it working.

(Please include in the commit message how it works or not without the
patch.)

Also, patches to netdev need to have "net" (for -rc) or "net-next"
(for the next merge window) in the "[PATCH ...]" n the subject line.

Thanks.
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

