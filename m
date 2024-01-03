Return-Path: <linux-kernel+bounces-15410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D23822BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83467B21A80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2282E18C3B;
	Wed,  3 Jan 2024 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gpZ/aCjn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846918E06;
	Wed,  3 Jan 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UsxFTjUw6Zc2yvy6gkvn2mjApUFXVkeXpGQUxAbjitU=; b=gpZ/aCjnmyd++8LssUZU3FoxdS
	6XaYiNdun0vIQV5JJmt2Pf3BjvxTq5Ch1Z97pUyBawgO/vOBlUiRJAMbQtpTFBBMGKHSmpJoWa4Uw
	WhKFhSIBGDm23A1bEM6Zr3pjEMAboW0AWo5XwZWxX5lQLwHCJvKYhHwrOKLIKs+HRjIsj2q/NtHco
	43oQyAcVgfqZcxIF1IuIsEztTSoukqniwvxlR2Pl+efRByvnAy4PPIeuMIddCRdCbpVqIEp67mitf
	u/RNfIcrqInq0IJoVxyrZ+aTboaQIvXsDmITtylv4fbz/JNmTg+JfDgtS0S5kPUrTJJabNwu0Dhrz
	QRqo0bYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57900)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKyqC-0007Ll-3B;
	Wed, 03 Jan 2024 10:51:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKyqB-0006Ia-VO; Wed, 03 Jan 2024 10:51:15 +0000
Date: Wed, 3 Jan 2024 10:51:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, olteanv@gmail.com,
	hkallweit1@gmail.com, kabel@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: Cleanup struct mdio_driver_common
Message-ID: <ZZU8I5wwH+y1VsIy@shell.armlinux.org.uk>
References: <20231228072350.1294425-1-yajun.deng@linux.dev>
 <ZZRJLg6U0G5CNRQ0@shell.armlinux.org.uk>
 <a5aca886-ca0a-8170-417f-a189ec28c87f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5aca886-ca0a-8170-417f-a189ec28c87f@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 03, 2024 at 10:03:14AM +0800, Yajun Deng wrote:
> 
> On 2024/1/3 01:34, Russell King (Oracle) wrote:
> > I'm not sure why this consistency is even desired, the commit message
> > doesn't properly say _why_ this change is being proposed.
> 
> Most drivers use device_driver directly. This should be added to the commit.
> 
> Like this:
> 
> struct sdio_driver {
> 
> ... ...
> 
>         struct device_driver drv;
> };
> 
> 
> struct pcie_port_service_driver {
> 
> ... ...
> 
>         struct device_driver driver;
> };
> 
> and so on ...

... which is fine for those other drivers because they don't share the
same bus. That is not the case here - we have two different classes
of drivers on the same bus.

I don't like a justification that just because other subsystems do
something in one particular way, that is the only way things should be
done. I think there is good reason to have the structure we have, and
thus there needs to be a good reason to change it.

Maybe Andrew has a different opinion, but I think we need a better
justification for this change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

