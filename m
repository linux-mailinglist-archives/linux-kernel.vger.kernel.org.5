Return-Path: <linux-kernel+bounces-68666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D35857E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3DD1F22BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0312C552;
	Fri, 16 Feb 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aUb0aGGL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3C12C533;
	Fri, 16 Feb 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091370; cv=none; b=K/mULLmlAPNbEKQNmP7uqVJgU1ufosfsMnxkivot3dggXkHo2mWdCianPr7XHgCTE6/v0SNJLLh5dL9MVe49Cof5JLW0jlobQ167Oi1BXZQ1nW+fA9MPIefXS3DbC5SOcm/jPuAITWtj1qud5Uwmt7Gi9VC8VV4rphPDY5l/9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091370; c=relaxed/simple;
	bh=OAvtekvkzsY6sVy4RSVkcn9TLp8CwUzvFMDWjc6NkOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/0FYwOlvuxCOcDQXLljVb1aj4Eirn6IRsZfvSd5rYoZ6H/uYWcIr0XFOJWAwPNBgr/UL+V92OvWhBt8kN0/hFlRYnuUJc7IwS3b4qNa3Qo3iPXwwl/P8LPePzLyaJkVQuLfMci+r2t1x5OwDt1KHnZdBNSrGNOBAl2Y85cszB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aUb0aGGL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BLg+bRRNjAsR1JnKoIEnqtsv/s8Y3T60xZKr0hlNMNo=; b=aUb0aGGLh02CYnXXEqfCSdpP1x
	p8NMbSXXc3K5eCuhhZwJ5Qi7kaDeRbeiAxfrvVKNFkqWOyFDmvOGOt7Qb9FM23PZKk3jcmYOAeUg0
	rNc8yK2CA7HAFjfZo5pD+xuO5zVYhYDdHXj1LiXJqNYkg65A7Fy7h1JR91RPTrRJwV7w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rayak-007z7q-9X; Fri, 16 Feb 2024 14:49:26 +0100
Date: Fri, 16 Feb 2024 14:49:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yang Xiwen <forbidden405@outlook.com>
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
Message-ID: <f5453471-ed85-409c-a6a2-04c92e59a7fc@lunn.ch>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-1-e0ad972cda99@outlook.com>
 <c00dad08-00f5-41f0-861c-cb40593b49fd@lunn.ch>
 <SEZPR06MB695972ECA5223EF5F81077BD964D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR06MB695972ECA5223EF5F81077BD964D2@SEZPR06MB6959.apcprd06.prod.outlook.com>

On Fri, Feb 16, 2024 at 07:59:19AM +0800, Yang Xiwen wrote:
> On 2/16/2024 7:57 AM, Andrew Lunn wrote:
> > > +	for (i = 0; i < CLK_NUM; i++) {
> > > +		priv->clks[i] = devm_clk_get_enabled(&pdev->dev, clk_strs[i]);
> > > +		if (IS_ERR(priv->clks[i])) {
> > > +			dev_err(dev, "failed to get enabled clk %s: %ld\n", clk_strs[i],
> > > +				PTR_ERR(priv->clks[i]));
> > > +			ret = -ENODEV;
> > > +			goto out_free_netdev;
> > > +		}
> > The clk API has devm_clk_bulk_ versions. Please take a look at them, and see
> > if it will simplify the code.
> I know this API, but it can't be used. We need to control clocks
> individually in reset procedure.

/**
 * struct clk_bulk_data - Data used for bulk clk operations.
 *
 * @id: clock consumer ID
 * @clk: struct clk * to store the associated clock
 *
 * The CLK APIs provide a series of clk_bulk_() API calls as
 * a convenience to consumers which require multiple clks.  This
 * structure is used to manage data for these calls.
 */
struct clk_bulk_data {
	const char		*id;
	struct clk		*clk;
};

You pass the bulk API calls an array of this structure. After the get
has completed, you can access the individual clocks via the clk
pointer. So you can use the bulk API on probe and remove when you need
to operate on all three, and the single clk API for your reset handler
etc.

       Andrew

