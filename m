Return-Path: <linux-kernel+bounces-93991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891F8737E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95921F2744A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48A131749;
	Wed,  6 Mar 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pRmGogdB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333327FBBB;
	Wed,  6 Mar 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732441; cv=none; b=auAO/aanD2p2VgTZFaG5FfWZr7GInESX0NdcTzppzRLBOSJJOw+A47SBAmVXHzL6wsXQHmGAnxGvCXTNUZCIVz9VhwGksrA4m0EnRx43rGFr79tIN4FwxTU2b0KYItg1MerS1ct5C2Si3o+RwYAEUjqCcJQmwvapSYekqBwfN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732441; c=relaxed/simple;
	bh=MI0+GrJQL4JofYsjp7q2Zgut3VuhGSL1qh3TWn5mGm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp0y1A4XfHCj62Y/zrI7d/RTK7jHIgyPcx/PMFJzvIQareWsVANaH8jJOP/hQiweDkPQxgQ2mh2puD3USOPXfy1ztZFT/frBDD0ej/vqqwOBN2UeaCDDm4b2/o+qT1TcEyBDJbsr+yTLYvORu3Xx+um8KIGpkwj4yJbygQaBCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pRmGogdB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=91gSRt6gnV2LL9+GkPFyvaYfVwxeGuHq0ieaBFdOqeo=; b=pRmGogdBNBj+w6+DZ1iaWZrN6U
	jeJRo+f6V1VFBHhsrak6FjUIsu5cyLZHJzLpQBMFyRSsxrkjUDQyWuDFCrNxwcHgjOZid+SL+NZRZ
	W0XILwKDCskZBWTqs+vPdS708GrMhAvlOsJUwqjqKUrjhiJR+YPGZoJOUgve/sYXgxJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhrVv-009VFy-Py; Wed, 06 Mar 2024 14:40:55 +0100
Date: Wed, 6 Mar 2024 14:40:55 +0100
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
Subject: Re: [PATCH net-next v3 02/12] net: ethernet: oa_tc6: implement
 register write operation
Message-ID: <43f49aff-ca74-4d10-a478-89ea7497ba83@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-3-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306085017.21731-3-Parthiban.Veerasooran@microchip.com>

> +config OA_TC6
> +	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support"
> +	depends on SPI
> +	select PHYLIB
> +	help
> +	  This library implements OPEN Alliance TC6 10BASE-T1x MAC-PHY
> +	  Serial Interface protocol for supporting 10BASE-T1x MAC-PHYs.
> +
> +	  To know the implementation details, refer documentation in
> +	  <file:Documentation/networking/oa-tc6-framework.rst>.
> +
> +	  This option is provided for the case where no in-kernel-tree modules
> +	  require OA_TC6 functions, but a module built outside the kernel tree
> +	  does. Such modules that use library OA_TC6 functions require M here.

We generally don't refer to out of tree modules. We know they exist,
but we don't take any steps to support them, the internal APIs are not
fixed etc. So i would drop this last paragraph.

> +static int oa_tc6_check_ctrl_write_reply(struct oa_tc6 *tc6, u8 size)
> +{
> +	u8 *tx_buf = tc6->spi_ctrl_tx_buf;
> +	u8 *rx_buf = tc6->spi_ctrl_rx_buf;
> +
> +	rx_buf += OA_TC6_CTRL_IGNORED_SIZE;
> +
> +	/* The echoed control write must match with the one that was
> +	 * transmitted.
> +	 */
> +	if (memcmp(tx_buf, rx_buf, size - OA_TC6_CTRL_IGNORED_SIZE))
> +		return -ENODEV;
> +

I think EPROTO or EIO would be better. The device might have crashed,
burned and is gone, but isn't a bit flip on the SPI bus more likely?

       Andrew

