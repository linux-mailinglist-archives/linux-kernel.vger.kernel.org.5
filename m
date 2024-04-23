Return-Path: <linux-kernel+bounces-155994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999178AFC74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A71287F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DD93D575;
	Tue, 23 Apr 2024 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZyFFU/cH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B5328DB;
	Tue, 23 Apr 2024 23:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914064; cv=none; b=DAp7AhxVnoJO++nlDcI1KFUi3l2iAR5ssR2hRU+ItooMhgQ50Q5gHank2PwrxiFzio1+fISnpHD/lv6OPRycsrhMTqlo58iq8xkDuUKA5bqNwel1hlwyYUoQV2zBX8oJNFgZn35eHLWDsWHU6JvNIaut7L7eagA7tCpuuwdgLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914064; c=relaxed/simple;
	bh=eMAq++fZHnkcnvl/ND17FJyV1KXG5e/03zd0eFxYkw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hp6I/TtO5MQaWKttYqQvdKhdV9305LsyiJYWZnDJPlSldKRUj+Nq4IKqo09vZ//H4G5B1RQJlD7xd88YStlv42Nm7Db0Uy3lsGpA8VkAtKLuq4AKPMYRt3H/ZOe2jNC7vy4OkACHik6vKDcv5mu37K1zAHOYkcua+Bq4GwS4Kic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZyFFU/cH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t8avKwuQBf4895mG5LdY8jl8M9prfDm1cDn0sgalvio=; b=ZyFFU/cH8BSizjgfswmaRGHUqC
	eqUjb+n0AF/c7bo+0cetDcLdPD64/afbLnOHb2bdDsxyVD7kvCVfJP0E6mp56Nx4g0p5TyKtqVv3n
	2tg6LppQRNLZT2xqhE7w2Ja9XIo5AMLcz4knl3CGOu/p++R9huVQCqHVVFKO5Lj+qObg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzPKu-00Dkzt-LL; Wed, 24 Apr 2024 01:14:04 +0200
Date: Wed, 24 Apr 2024 01:14:04 +0200
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
Subject: Re: [PATCH net-next v4 02/12] net: ethernet: oa_tc6: implement
 register write operation
Message-ID: <c0ffd864-f85b-4dd7-942b-f9cc2c88f678@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-3-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-3-Parthiban.Veerasooran@microchip.com>

On Thu, Apr 18, 2024 at 06:26:38PM +0530, Parthiban Veerasooran wrote:
> Implement register write operation according to the control communication
> specified in the OPEN Alliance 10BASE-T1x MACPHY Serial Interface
> document. Control write commands are used by the SPI host to write
> registers within the MAC-PHY. Each control write commands are composed of
> a 32 bits control command header followed by register write data.
> 
> The MAC-PHY ignores the final 32 bits of data from the SPI host at the
> end of the control write command. The write command and data is also
> echoed from the MAC-PHY back to the SPI host to enable the SPI host to
> identify which register write failed in the case of any bus errors.
> Control write commands can write either a single register or multiple
> consecutive registers. When multiple consecutive registers are written,
> the address is automatically post-incremented by the MAC-PHY. Writing to
> any unimplemented or undefined registers shall be ignored and yield no
> effect.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Apart from the Return: issues:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

