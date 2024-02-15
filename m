Return-Path: <linux-kernel+bounces-67868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBAE85722A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066D11F24576
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBAA145FF8;
	Thu, 15 Feb 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tPJNliFV"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF7129A98;
	Thu, 15 Feb 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041475; cv=none; b=bG2clH4BN/BChRQujcURxU69aRrjMblMoR3VjAWmRLF0Kyfu0pr+9z6qpqeIRR/4vLpxE3bZS2Mib/lMavK+lLYRdRfGu3hL1bQrJIZk3kC4sJyZYh5kmPGbRCb0Rt6n26x3dtMvBbCb783iBl0dow0XzCKn/HJQag2zwgoEl7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041475; c=relaxed/simple;
	bh=e87TG9k2zm52ZOaEco0QL12er+Soju3xN1+JUy4MxQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYvSEk2SaSvtdhUR3M9cDbd9qrAkAB2yW8ei/yjvfAPus2kEYexc8QdYrr0uotGyZ34kDei5VD7S0XwQJV//EU/PZDK/FmqfLJkaiFG28ce+KIkAGp1tCgIhKU9p4KPbl4eUtCnJ5uerzFj+324QNFMM1GruxKO4+ys2Bardnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tPJNliFV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a/5ys+X72fiaB4snLFRMRpcwJ7D/7XtxdA0xvN7YcGM=; b=tPJNliFVo9uqs4OiCA/0f9ux34
	/rdGJtw8Q/cGN+kDDh6QZLbppt4agJWpoYa9bWfsjS756S7HHOW2tDJtyFNqIupm+PTsM6irB7vzs
	jHIO5hwxmCsN1sMi+0TcSzkmPE+wzofiw0lBvN0ELHaARrrcLcbPTsKMqN9JeCF5YRDc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ralbr-007vkT-4e; Fri, 16 Feb 2024 00:57:43 +0100
Date: Fri, 16 Feb 2024 00:57:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: forbidden405@outlook.com
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] net: hisilicon: add support for hisi_femac core on
 Hi3798MV200
Message-ID: <c00dad08-00f5-41f0-861c-cb40593b49fd@lunn.ch>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-1-e0ad972cda99@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-net-v1-1-e0ad972cda99@outlook.com>

> +	for (i = 0; i < CLK_NUM; i++) {
> +		priv->clks[i] = devm_clk_get_enabled(&pdev->dev, clk_strs[i]);
> +		if (IS_ERR(priv->clks[i])) {
> +			dev_err(dev, "failed to get enabled clk %s: %ld\n", clk_strs[i],
> +				PTR_ERR(priv->clks[i]));
> +			ret = -ENODEV;
> +			goto out_free_netdev;
> +		}

The clk API has devm_clk_bulk_ versions. Please take a look at them, and see
if it will simplify the code.

	Andrew

