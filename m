Return-Path: <linux-kernel+bounces-138516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9589F27D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A18B1C2158D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1120F15AAAE;
	Wed, 10 Apr 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HQpO3gwE"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1B158A0E;
	Wed, 10 Apr 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752939; cv=none; b=ogsg5IG1CGikyFYOrqVCF57eXm1/dk5PeDgBF7CyOtTVcUffEhlwI3ibcwnLhKFr1+Dvy4FGeKyRcY6JXEAItRsh5vwVE4ndWrV2RKFLXzxCnFb/jpf7ITCpgNEZxyHcKcmGvuVPa8bzoEJosmNM6hjzcQvSmWAGqcYjXFjSMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752939; c=relaxed/simple;
	bh=GMjLD7SrG5OMOHBq4gNh8kcYTqr3qX6bK7WATxsuZmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM+8g2Ez5OLepaYKmYMX2LFXPtqrmjaWz75yU8wQqyOUaAYlwUO/r2Vp5l+d9J78KMir4SgzlnEzcHW6E8ILnDFCL88E5d7ndtT+MTMasc/yCFZutlluRu/96NGryXPa/soDQRpA3lsNje/1HUrzIKHyWGJ36eN/EbtIWbagCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HQpO3gwE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SoSZEGve+s5t8k0cVonVLJJcTb59TwfC12mY12O7vPI=; b=HQpO3gwEqMugshjrtccT1UNovt
	ATwKjSsZUwc3haLkrpAML1vw7N0mAtGRLw/E8TD146xGcratbz+LEiWHD1gYEVOn0jLPOT/JAnYiF
	WwQ5FACtKesKEIKsvKR7STFdjYHNV8S26wlTHqVeuzVN2p+noIOtzoLRJuUIGlQTCXd8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ruXH6-00CfUH-35; Wed, 10 Apr 2024 14:42:00 +0200
Date: Wed, 10 Apr 2024 14:42:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Diogo Ivo <diogo.ivo@siemens.com>, Rob Herring <robh@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Simon Horman <horms@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware
Message-ID: <0039b9d9-9dc5-4b88-99f0-92f275b0b4d3@lunn.ch>
References: <20240327114054.1907278-1-danishanwar@ti.com>
 <20240327114054.1907278-4-danishanwar@ti.com>
 <27d960ed-8e67-431b-a910-e6b2fc12e292@lunn.ch>
 <c94815f8-798a-4167-8f69-359b9b28b7ce@ti.com>
 <cca25c3d-a352-4531-a8ae-5a0fb7de44df@lunn.ch>
 <ff567495-d966-42c9-9015-ba0ba0dbe011@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff567495-d966-42c9-9015-ba0ba0dbe011@ti.com>

> I have been working on this and have found a way to change firmwares
> without bringing the interfaces up / down.
> 
> By default the interfaces are in MAC mode and the ICSSG EMAC firmwares
> are running on pru cores. To enable switch mode we will need to stop the
> cores and reload them with the ICSSG Switch firmwares. We can do this
> without bringing the interfaces up / down.
> 
> When first interface is added to bridge it will still run emac
> firmwares. The moment second interface gets added to bridge, we will
> disable the ports and stop the pru cores. Load the switch firmwares on
> to the cores, start the cores and enable the ports. All of this is done
> from the driver.
> 
> The user need not to bring the interfaces up / down. Loading / Reloading
> of firmwares will be handled inside the driver only. But we do need to
> stop the cores for changing firmwares. For stopping the cores we will
> change the port state to disable by sending r30 command to firmware.
> 
> As we are not restarting the interfaces, the DRAM, SMEM and MSMC RAM
> doesn't get cleared. As a result with this approach all configurations
> will be saved.
> 
> Please let me know if this approach looks ok to you.
> 
> Below will be the commands to enable switch mode now,
> 
>      ip link add name br0 type bridge
>      ip link set dev eth1 master br0
>      ip link set dev eth2 master br0 (At this point we will stop the
> cores, reload switch firmware, start the cores)
>      ip link set dev br0 up
>      bridge vlan add dev br0 vid 1 pvid untagged

This sounds a lot better.

Note that the bridge interface br0 might already be up when the
interfaces are added. So that is a different order to what you showed
here.

There will be some packet losses when you swap firmware, but it
probably is not that bad. When interfaces are added to a bridge
packets are dropped anywhere while spanning tree determines the
network topology. It will just appear your device is slow at doing
that.

	Andrew

