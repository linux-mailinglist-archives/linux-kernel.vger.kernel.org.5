Return-Path: <linux-kernel+bounces-156046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8E8AFD28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08E41F22EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A51FDD;
	Wed, 24 Apr 2024 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4bgLlrc9"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512EF803;
	Wed, 24 Apr 2024 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713917324; cv=none; b=pCbyIvDzeyp6LLZcxo1fmU68B/Br28AZ02dfZ8CNa/XYSWUDUKb/YyGeBKJnYR8ze7bccAIelkfG4zTypoWkrttBZnCIqOX6hCka8tT3AhmhPFPxVpldMso6GRLzzkmhA+F8w/ClJAShG106Khhl2dSyyCnGBXqgFkWjHuSMZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713917324; c=relaxed/simple;
	bh=qesWVnD2Ad3ta6cw21DlBfTA+jZa4ZaJdbNCsj04dqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhi9DeCe0pLX8+sPOUc7X5cFPs+WkCWT3fzyooMaU3Ivl5JN812yQ+tubbA/GuC74W2pimEmNeOSbT9GltA98WYhqwgg3dp9J8OvAiqnvVpR4wUyikbKzKvfwwiZ4pX86hNT9f9ZXDNb19Z5F4myenNK7CsJll6ycdMtp09Ajt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4bgLlrc9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uNVDC5QsEnqtExxfYsYIt46tMXYa2LHua1cwNhaeBw4=; b=4bgLlrc9+y6ie0N//k5D4qgxYj
	L369jntKjV0zhz2vD+jww0GjUevWKHsam1Ug42VzAnBLtKDN4NVi9LuQiyUB1KeMfePwIl6yXXoXW
	FKF8KMxdD+ghHMhirLzpNzCQSefCY3xyyiaxJfPzJmsajyweA2zKyPMO6RmMHicrAvGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzQBb-00DlLG-Te; Wed, 24 Apr 2024 02:08:31 +0200
Date: Wed, 24 Apr 2024 02:08:31 +0200
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
Subject: Re: [PATCH net-next v4 09/12] net: ethernet: oa_tc6: implement
 receive path to receive rx ethernet frames
Message-ID: <574fec4d-5a23-490a-ba12-c40432ebe4b8@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-10-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-10-Parthiban.Veerasooran@microchip.com>

> +static int oa_tc6_allocate_rx_skb(struct oa_tc6 *tc6)
> +{
> +	tc6->rx_skb = netdev_alloc_skb(tc6->netdev, tc6->netdev->mtu + ETH_HLEN +
> +				       ETH_FCS_LEN + NET_IP_ALIGN);
> +	if (!tc6->rx_skb) {
> +		tc6->netdev->stats.rx_dropped++;
> +		return -ENOMEM;
> +	}
> +	skb_reserve(tc6->rx_skb, NET_IP_ALIGN);

I think you can use netdev_alloc_skb_ip_align() here.


