Return-Path: <linux-kernel+bounces-67872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC43B857236
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A803E1C230A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E432C95;
	Fri, 16 Feb 2024 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zW9U1gNG"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D93170;
	Fri, 16 Feb 2024 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041989; cv=none; b=qwix2GgDHOujrc5qSyPNXAX0GGTGKdv5O/nTumbYq7rCQ1V0Tnz92b8rZOPWGu5wAlLgVFlOKTxoCWh5Ya+oyc+T/K5q4dG8DujXPBps33f+HvCzzwxiyhuCtK+kRG8VH+o2rMyoWi5kgSCCufH9MaUdlz0fjkytNQly1R5qqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041989; c=relaxed/simple;
	bh=+NwNYv/++O9bOK2RzTUnuM4MI66hrPeGqSXcHcp4kPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQVRGYn9OULReopw5eZ1yFonP+rVXe36pJaMFnifk5qDTPTgwdj0n0Jo/dMPkJOIB0NGQHjrOxQrLuCBeZf04fJfmkHjIFWpiiv00mzF3LulKPr2MPBwSa+a26LRm2UpCYK/oL/F5mM/K43B6otU97ZBJ2bKCVmRvVYttVQeLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zW9U1gNG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RmP9JTuuv/DXYo6pIYbTECgv2ppZgVS4lJRVISVfLRY=; b=zW9U1gNGCdMQFGTwSwyZJKeEUz
	lltLi/NhrEsaC7fN6bC+vl23RvSK3/FFF4ze5HAyfSgGIp6AT/Q/xhQDcTzxuP6G1MxkDtOM0SgZ7
	+2pyiEabRe9qFQ3xubhIzNWNyQzFveqf6TmhBOu7VU1ZObupAh4e231bEp1D6kHfVT5o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ralkF-007voG-3K; Fri, 16 Feb 2024 01:06:23 +0100
Date: Fri, 16 Feb 2024 01:06:23 +0100
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
Subject: Re: [PATCH 4/6] dt-bindings: net: add hisilicon-femac
Message-ID: <c38f7cfd-2eca-40ac-948c-bc98478e67b2@lunn.ch>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-4-e0ad972cda99@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-net-v1-4-e0ad972cda99@outlook.com>

> +  clocks:
> +    minItems: 3
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: mac
> +      - const: macif
> +      - const: phy

The C code has:

+enum clk_type {
+       CLK_MAC,
+       CLK_BUS,
+       CLK_PHY,
+       CLK_NUM,
+};

Could you explain BUS vs macif?

Also, what exactly is the PHY clock?

      Andrew

