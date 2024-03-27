Return-Path: <linux-kernel+bounces-121288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 231E688E661
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A051B35152
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE22131BD4;
	Wed, 27 Mar 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d2joMcjM"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007DD12EBDD;
	Wed, 27 Mar 2024 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542986; cv=none; b=tIYAF6cB2VPcxWK6tLT2LzjnqXJj1SP6xQzIpFzbRZ1XUNfh4pIzbTWu1YqgXjd+lKPFdwPehcP4CUf3LDYEce8zeYM4sxex+zS/fhigtfWaE84/yqrud/M4joibbxDhiEY0NuEyOeSMmfMX0ZawjktZuR/jtMCiJA4nJHTZIY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542986; c=relaxed/simple;
	bh=oWual4D9pynFOAqFc+0csfX9lRZor/YG/q2D8yBbldk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOjFrYU822uO948yW8KA/TmTrikWc9jt0IcSrnshyXr8fVc646zIGpHebz3XfkJk+h2RUsBbmVcUJerL9YYDEqok6hH4eUi2ni7wTj4HXCk5g/jR+w84M+gEb5JFfvuyZPgPV8eDZY0Fye0XUVXfTCCsPPJKvKKIgpUK0Uyz+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d2joMcjM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W89r0bsVU2voc8CCyX1FkI6R4xhAvahVaf/LUakcvPc=; b=d2joMcjMX0dxYY7/Zc+XxdAyUb
	fPQ77U2Rf+nkpx10PT1uNqjD2l5ZPzPFN0FOb/mfR7jIl6H+rA11CneBdmZRP83hq9LwbDngUjkmC
	puWTS+yXhcBXG9TbRZJSMWETxH9S0fX2dP6M9yF8C3mnPcLT5pZwPiEX3a5Hga3CIW0g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpSVW-00BOJ1-6F; Wed, 27 Mar 2024 13:35:54 +0100
Date: Wed, 27 Mar 2024 13:35:54 +0100
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
Message-ID: <27d960ed-8e67-431b-a910-e6b2fc12e292@lunn.ch>
References: <20240327114054.1907278-1-danishanwar@ti.com>
 <20240327114054.1907278-4-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327114054.1907278-4-danishanwar@ti.com>

On Wed, Mar 27, 2024 at 05:10:54PM +0530, MD Danish Anwar wrote:
> Add support for ICSSG switch firmware using existing Dual EMAC driver
> with switchdev.
> 
> Limitations:
> VLAN offloading is limited to 0-256 IDs.
> MDB/FDB static entries are limited to 511 entries and different FDBs can
> hash to same bucket and thus may not completely offloaded
> 
> Switch mode requires loading of new firmware into ICSSG cores. This
> means interfaces have to taken down and then reconfigured to switch
> mode.

Patch 0/3 does not say this. It just shows the interfaces being added
to the bridge. There should not be any need to down the interfaces.

> Example assuming ETH1 and ETH2 as ICSSG2 interfaces:
> 
> Switch to ICSSG Switch mode:
>  ip link set dev eth1 down
>  ip link set dev eth2 down
>  ip link add name br0 type bridge
>  ip link set dev eth1 master br0
>  ip link set dev eth2 master br0
>  ip link set dev br0 up
>  ip link set dev eth1 up
>  ip link set dev eth2 up
>  bridge vlan add dev br0 vid 1 pvid untagged self
> 
> Going back to Dual EMAC mode:
> 
>  ip link set dev br0 down
>  ip link set dev eth1 nomaster
>  ip link set dev eth2 nomaster
>  ip link set dev eth1 down
>  ip link set dev eth2 down
>  ip link del name br0 type bridge
>  ip link set dev eth1 up
>  ip link set dev eth2 up
> 
> By default, Dual EMAC firmware is loaded, and can be changed to switch
> mode by above steps

I keep asking this, so it would be good to explain it in the commit
message. What configuration is preserved over a firmware reload, and
what is lost?

Can i add VLAN in duel MAC mode and then swap into the switch firmware
and all the VLANs are preserved? Can i add fdb entries to a port in
dual MAC mode, and then swap into the swtich firmware and the FDB
table is preserved? What about STP port state? What about ... ?


> +bool prueth_dev_check(const struct net_device *ndev)
> +{
> +	if (ndev->netdev_ops == &emac_netdev_ops && netif_running(ndev)) {
> +		struct prueth_emac *emac = netdev_priv(ndev);
> +
> +		return emac->prueth->is_switch_mode;
> +	}
> +
> +	return false;
> +}

This does not appear to be used anywhere?

     Andrew

