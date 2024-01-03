Return-Path: <linux-kernel+bounces-15485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71849822C99
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824541C23240
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129F19BB8;
	Wed,  3 Jan 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tONx/tDO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778619BB1;
	Wed,  3 Jan 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nsC4Et3I1Gf7WygCzSIdwNufdONd9F78NTeV2QKxMqc=; b=tONx/tDO28T27Y2nH3BzU1n1Tx
	E4R6ocwk6+xW/RH5Cgva06EnXOZSaWJhSBLMLF49cwDbFEBziVCWivL+Dp02qjbKf6dNjz7oq+ey0
	mdlY4kfdqfMIamvo+xGaEUykr3N3HIW2lw+lTzqe0hN2FB4Hp6zM9dpyVSNpMX3dGkFRxArWXBiSz
	fksr6GZOmDJ56+L9OdGnlMfaC/666rZoFCvMh329MzZBY54SDfLqG3cwyWsO9uJHuUPv2a+IW6/z1
	10V3Ltl5XgFTYQ5IliDuztXbTDBuCVDWOWucEx7poBakDTe7vsgA5JI7VlhxQqIKBZBFThIN68CFN
	FKX1IwXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49630)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKzvr-0007Pn-03;
	Wed, 03 Jan 2024 12:01:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKzvs-0006LG-KZ; Wed, 03 Jan 2024 12:01:12 +0000
Date: Wed, 3 Jan 2024 12:01:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, kuba@kernel.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mdio: get/put device node during
 (un)registration
Message-ID: <ZZVMiPCoDyv/NZXN@shell.armlinux.org.uk>
References: <20231220045228.27079-2-luizluca@gmail.com>
 <ZZPtUIRerqTI2/yh@shell.armlinux.org.uk>
 <CAJq09z61JRNOBy6zLJ+D2pOVP-FCkofLjNghHSOkFJ=5q=6utQ@mail.gmail.com>
 <ZZU1SJlKpeU38c9I@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZU1SJlKpeU38c9I@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 03, 2024 at 10:22:00AM +0000, Russell King (Oracle) wrote:
> I agree with that approach, but as you rightly point out, we need MDIO
> to behave correctly, and I don't think that patching just one bit of
> MDIO to fix this mess is the right approach.

This is probably a safer approach to ensuring that the firmware data
reference count isn't dropped while the bus exists byensuring that we
always take a reference at register time. It also likely fixes similar
issues with ACPI and swnode based users as well.

It doesn't deal with the excess-refcount problem, as with this approach
the two issues are entirely independent of each other.

Please test to check that this addresses your issue. Thanks.

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 6cf73c15635b..afbad1ad8683 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -193,6 +193,10 @@ static void mdiobus_release(struct device *d)
 	     bus->state != MDIOBUS_ALLOCATED,
 	     "%s: not in RELEASED or ALLOCATED state\n",
 	     bus->id);
+
+	if (bus->state == MDIOBUS_RELEASED)
+		fwnode_handle_put(dev_fwnode(d));
+
 	kfree(bus);
 }
 
@@ -684,6 +688,15 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 	bus->dev.groups = NULL;
 	dev_set_name(&bus->dev, "%s", bus->id);
 
+	/* If the bus state is allocated, we're registering a fresh bus
+	 * that may have a fwnode associated with it. Grab a reference
+	 * to the fwnode. This will be dropped when the bus is released.
+	 * If the bus was set to unregistered, it means that the bus was
+	 * previously registered, and we've already grabbed a reference.
+	 */
+	if (bus->state == MDIOBUS_ALLOCATED)
+		fwnode_handle_get(dev_fwnode(&bus->dev));
+
 	/* We need to set state to MDIOBUS_UNREGISTERED to correctly release
 	 * the device in mdiobus_free()
 	 *
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

