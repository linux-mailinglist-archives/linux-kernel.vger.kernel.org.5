Return-Path: <linux-kernel+bounces-15357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A602822A99
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264C11F2400E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B818AF6;
	Wed,  3 Jan 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jg9h8ytC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D718E3C;
	Wed,  3 Jan 2024 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D5wPLE9TZz9FB8/zFddxM+lmOG8aS1WUAq/N+WIF/34=; b=jg9h8ytC1jyaCi86YZ3yq/HzUo
	Seznnu4aTFRdTXJGmfFHAoH6YU3aS90j7cpthWeEQHQJRY2fKCahqw78iCTzpUsUvyYF0Idcea9e7
	4arIyVUDfOFaoh9Ibm0so5z1qetdUTK0DxUHg3rlmi42pbdqAQmsIpfDsucH/U7J2FS+8C1QwFHUG
	/ZaP/aEtdTMz/JKRqc7Fvp06Qz7ijJfpB+2r5LEOqJjR4MudDJfT0fJl8KRvuJCSFaU5DM/lstI4G
	VrnQtA+7spviCCv2HrumYR8WSHEDQpeo70e0Z8kk54G9pVtQUnZ9haza8a/DcL/nUFA4ZkjBsJYKu
	+4iAFSWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45524)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKxtZ-0007JJ-0I;
	Wed, 03 Jan 2024 09:50:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKxtZ-0006G0-1w; Wed, 03 Jan 2024 09:50:41 +0000
Date: Wed, 3 Jan 2024 09:50:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Eric Woudstra <ericwouds@gmail.com>, Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC net-next] net: pcs: pcs-mtk-lynxi fix
 mtk_pcs_lynxi_get_state() for 2500base-x
Message-ID: <ZZUt8YG/z8koXK9y@shell.armlinux.org.uk>
References: <20240102074408.1049203-1-ericwouds@gmail.com>
 <ZZP9GR15ufDbjGAJ@shell.armlinux.org.uk>
 <92190426-3614-4774-9E9F-18F121622788@gmail.com>
 <74223164-ab50-4d6d-a4f4-561b0a70d396@gmail.com>
 <ZZRrk85SCDmo76NJ@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZRrk85SCDmo76NJ@pidgin.makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 02, 2024 at 09:01:23PM +0100, Daniel Golle wrote:
> On Tue, Jan 02, 2024 at 08:33:32PM +0100, Eric Woudstra wrote:
> > [...]
> > 
> > So if phylink_mii_c22_pcs_decode_state() should not set the speed, then it is not correctly set somewhere else.
> 
> Yes, but the fix should go to pcs-mtk-lynxi.c and you don't need to
> change phylink for it to work.

... which is broken thinking. It's "let's add custom hacks to drivers
to implement driver specific behaviour, ignoring what is being asked
of them by the upper layers."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

