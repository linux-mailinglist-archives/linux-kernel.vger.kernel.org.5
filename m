Return-Path: <linux-kernel+bounces-135524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB0589C727
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EC228581D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9B13F006;
	Mon,  8 Apr 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XK6UJWew"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DC13EFEF;
	Mon,  8 Apr 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586751; cv=none; b=AJO4mqgnz4ZmBasZZxnrL31zpJzXMGEYgWe4P5lXpAARibikpXBTJAU3LeBEsftJ8EXAcLqkM7EWJ8ouA+WS6S2QfNora/H2kMUHZxDGhin3sgKjYGEWR3FsMVpH9jSif/KeJXAX9sw8fLNTTCcMp17WTAsfrrMJTP+OQ2DN5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586751; c=relaxed/simple;
	bh=9TDSD9uIP55xM2QfiVD3tizLnik+HLKgD0b97CAPclc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoMnBSwB8U4aLMAxFmsK+/ePBX25pB4zRVkr6FOdNFl7LNXiKkBopw3IamhR0fgERFeHH+YDOuZUtvFsL3uPzERIgPzZFheCHh+fV85V/0Ri7RIC3LVXmrKW3tRPpfg1lbqU57BgGoIXBXEQHBz4MaTLjtTSqizbudAaCfvX7kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XK6UJWew; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B305B2000C;
	Mon,  8 Apr 2024 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712586745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHNHRLwrELN0gZ9di0un0BhrGegDA655T9cUNfuAZNU=;
	b=XK6UJWewqdTcFFRr3jaCZRk7J23rz3mRDA0s70JB9KXkN4tH8Twe1G96yrBpubCSyMZGYf
	LMo0qaK/6T5lb6+akfwOkf+9SCs97lM6bSfudir0FQV8VhRKowA7ZFub2or0SYsVamt5o3
	EYIsnJHlRO7jFXDQSDLnNR1bwS3ijh6B/f9q0o4Evg8bM/iJJOChWncU6DvgQGMewO05at
	+H5FKpNavyKnlVmsfisZRXq8qe5g/UNJwV6eRYdHR5vFpB6eExwfporVFQZa9Ouc6W9P9n
	KjPz9AHlM/RcKEnBzLc8RIG+kMkTlYP1VC6h9mrwPP/RjG34GQ9HIjp5jA5nVw==
Date: Mon, 8 Apr 2024 16:32:19 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, andrew@lunn.ch,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
 christophe.leroy@csgroup.eu, herve.codina@bootlin.com,
 f.fainelli@gmail.com, hkallweit1@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, jesse.brandeburg@intel.com, corbet@lwn.net,
 kabel@kernel.org, piergiorgio.beruto@gmail.com, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240408163219.64fe77b3@device-28.home>
In-Reply-To: <171242462917.4000.9759453824684907063.git-patchwork-notify@kernel.org>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
	<171242462917.4000.9759453824684907063.git-patchwork-notify@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Sat, 06 Apr 2024 17:30:29 +0000
patchwork-bot+netdevbpf@kernel.org wrote:

> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
> 
> On Thu,  4 Apr 2024 11:29:50 +0200 you wrote:
> > Hello everyone,
> > 
> > This is V11 for the link topology addition, allowing to track all PHYs
> > that are linked to netdevices.
> > 
> > This V11 addresses the various netlink-related issues that were raised
> > by Jakub, and fixes some typos in the documentation.
> > 
> > [...]  
> 
> Here is the summary with links:
>   - [net-next,v11,01/13] net: phy: Introduce ethernet link topology representation
>     https://git.kernel.org/netdev/net-next/c/6916e461e793
>   - [net-next,v11,02/13] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
>     https://git.kernel.org/netdev/net-next/c/0ec5ed6c130e
>   - [net-next,v11,03/13] net: phy: add helpers to handle sfp phy connect/disconnect
>     https://git.kernel.org/netdev/net-next/c/e75e4e074c44
>   - [net-next,v11,04/13] net: sfp: Add helper to return the SFP bus name
>     https://git.kernel.org/netdev/net-next/c/fdd353965b52
>   - [net-next,v11,05/13] net: ethtool: Allow passing a phy index for some commands
>     https://git.kernel.org/netdev/net-next/c/841942bc6212
>   - [net-next,v11,06/13] netlink: specs: add phy-index as a header parameter
>     (no matching commit)
>   - [net-next,v11,07/13] net: ethtool: Introduce a command to list PHYs on an interface
>     (no matching commit)
>   - [net-next,v11,08/13] netlink: specs: add ethnl PHY_GET command set
>     (no matching commit)
>   - [net-next,v11,09/13] net: ethtool: plca: Target the command to the requested PHY
>     (no matching commit)
>   - [net-next,v11,10/13] net: ethtool: pse-pd: Target the command to the requested PHY
>     (no matching commit)
>   - [net-next,v11,11/13] net: ethtool: cable-test: Target the command to the requested PHY
>     (no matching commit)
>   - [net-next,v11,12/13] net: ethtool: strset: Allow querying phy stats by index
>     (no matching commit)
>   - [net-next,v11,13/13] Documentation: networking: document phy_link_topology
>     (no matching commit)

It looks like commits 6 to 13 didn't make it upstream with (the "no
matching commit" messages above). Is that expected ?

Thanks,

Maxime



