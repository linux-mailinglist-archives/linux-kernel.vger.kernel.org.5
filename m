Return-Path: <linux-kernel+bounces-68607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59FC857D13
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B2A1F2688F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8021292F2;
	Fri, 16 Feb 2024 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mEM2voq/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984C77F19;
	Fri, 16 Feb 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088484; cv=none; b=rgSeSUiFHIJouusrCEKDs0Nkutla/K3ktyD16qdKe7A5FGoAdhcmfBIdhjRxS94a86E+kOyHNRBlOXl5DnrNrEGIodighJZPfKjSvhJVs/QQnsLUddOAu8ErwwBJvrYt9Sq3a+PhRYOp72ZIIbtION5hTHoXMjxlxWE4teXfe2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088484; c=relaxed/simple;
	bh=qnUUh8tWzJsSyjT1WlcIqRY2WcqBK0/hUea98FushpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYXbkRrOdDDnDMHZTxzpB97EnmoNxImRNlYB/Ev3wKgT+8+r7w6Pu1+GNVmz9+NYWWLgf+4xmraKZBFnUFRqBBvFVLG7sgIJ0F/ZmBTRpHbNOb95Pylg4KHgqH3PYto3yvapYtCuWle9l9XowCh3+L04T7+6JvX1jfGtgU6KqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mEM2voq/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4dC28a4HbFIUZn2NknmdS3B4n/cJsAhVYpRVdxKWey0=; b=mEM2voq/zYODJrmuHSnzRap9Q2
	KrtoKtaAmSnnc7sxM7TfawMyNV/wLWoHp5GeXheJ/AH6iSAH82MIpTpH5rNDfBcVMHCYsWSTY704K
	4HJsj8ftsRBTK05vzSbI3SbgYc2zS41rQHIpzKnMtluF5ZNUdXlyIlpAI3Riwa9Q+EIs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raxq0-007yqn-Ex; Fri, 16 Feb 2024 14:01:08 +0100
Date: Fri, 16 Feb 2024 14:01:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
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
Subject: Re: [PATCH 2/6] net: hisi_femac: remove unused compatible strings
Message-ID: <428581c5-48e5-4b89-8925-9847bd69dc70@lunn.ch>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-2-e0ad972cda99@outlook.com>
 <68c9477a-3940-4024-8c86-aa6106e8a210@linaro.org>
 <SEZPR06MB695938B228E762B9B53BAF2F964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <d77faffc-5bde-41f1-b6a2-ddd665c3ee08@linaro.org>
 <SEZPR06MB6959592677F8F2C79BC2FBB7964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR06MB6959592677F8F2C79BC2FBB7964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>

> For me, it's a bit lucky to find a (partially) working driver in mainline.
> It'll take me even more time if no mainline driver is available. In fact, i
> wrote the driver for mainline u-boot from scratch and it has been merged. So
> it's good to have this binding accepted unmodified, or i'll have to modify
> u-boot side driver code to keep them sync.

Sorry, but that is not how it works. If during review we decided it
needs to be modified, you will need to modify it.

I would suggest you first mainstream bindings to the kernel, because
it has active DT maintainers how really care about bindings. Then get
is merged to u-boot.

   Andrew

