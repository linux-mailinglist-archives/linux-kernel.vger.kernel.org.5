Return-Path: <linux-kernel+bounces-96379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3B875B71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702A4B20F82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25BF1103;
	Fri,  8 Mar 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="roLdvQKS"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F419163;
	Fri,  8 Mar 2024 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856870; cv=none; b=YWwzZ7Uwt9mdyTG6nENdi1hg6Yk0TVN084neXnwYKKkH89FWhsSz65NU8FUEtidAPtLTvBGGhF88ZWzOwuSFHDgKeiEWfxIjqAvTd3hl5saXZRfdXaSZreJE5VXOWxnGZPw4YhG1p83+8BIgRtJRZPsrNs4ReuuVLKET2NVGkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856870; c=relaxed/simple;
	bh=ShKAOPsNeFSgfIJeAAMXbVN/XeGuL3Tf/iQlZyZXXPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw0Qu4YuFNAPvmBP52Arx6iwV26vA7VJ5RWfmknSC7cVlBHDWqtDhpLIpIcvr9hFOjItpRf5kWI67qtlzvFpHJhyt8HC9qwHDVxxnfVrIOpx9F1SeF1NBz//NuoKk4NY/Hr8M+EUWUxSjlaJNirQLraG79B6Y4gvDBejSvn2gOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=roLdvQKS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pAdOU+6NWPhS48wWJ2Dtjr5NagG/2OqoNvOJ8IAErUo=; b=roLdvQKShZYIj48y3uP+XHXUvG
	bvAU7PKYoUMK9TezAuxPqMs440C6Rvv284GSZOgip8UL0C1IiP4QMF6MlTGRpbcXsFsilfm7lerKm
	7RdkBOKe8ih9a9tFVzovNeisBpd5nTz9DkC1oXqIhthguUh8dlhRtINBdO6V2S1H5Zag=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riNsf-009fkW-OF; Fri, 08 Mar 2024 01:14:33 +0100
Date: Fri, 8 Mar 2024 01:14:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Message-ID: <49f8b067-4e56-4e8f-97e0-bac314619b82@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-10-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306085017.21731-10-Parthiban.Veerasooran@microchip.com>

> +static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6)
> +{
> +	tc6->rx_skb = netdev_alloc_skb(tc6->netdev, tc6->netdev->mtu + ETH_HLEN +
> +				       ETH_FCS_LEN + NET_IP_ALIGN);
> +	if (!tc6->rx_skb) {
> +		tc6->netdev->stats.rx_dropped++;
> +		netdev_err(tc6->netdev, "Out of memory for rx'd frame");

If that happens, it is not something which will fix itself quickly. So
you are likely to spam the logs. The counter on its own is probably
enough.

	Andrew

