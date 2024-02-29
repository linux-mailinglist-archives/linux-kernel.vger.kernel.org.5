Return-Path: <linux-kernel+bounces-87155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FC386D05D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170161F22A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D370AC4;
	Thu, 29 Feb 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VBYTBo5T"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EDC5E082;
	Thu, 29 Feb 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227108; cv=none; b=RKLgK5tRDyHnMYrUOb1tR53u9H/K6YXWviFFg+3Q5QHx5XI7EYe80Y8mz3jkLZMtGfJHbMOCqUcWg7kxW0IzPqiEpfNNCD0Vi4LKvT2G/UC+K49NJWeT8nNeg+Fu/L504IL/coEiYOnukRqnFyh+yzXqkfAN07NYKGG88gIr3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227108; c=relaxed/simple;
	bh=wLFkbz3gkSljFGtwkfV2wWbaprCVgevB+4kcM+B8hRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTLuM7qtkjK7QKrO6t9FFWYiNlp9kzyRpixL4wGzKWlDr7sCbyk4vgdfqKBCkmRvemZb90mdWK5UliFVZH6ur1HhLHK2GJA+pL+7E7HZ1fFvi9BECtRb+6y3aJsN6KH37R3GuizjAOiHFlHCkHyFDXrhBRbA6Ovsz6Br0OrhIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VBYTBo5T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nDTd85D0N7TgWSzEKq+BxgNnlzgmZW1OM2gxs9VR3ZY=; b=VBYTBo5TjEwXvKL7n0GEU/Bl4R
	qlsi7iODH1JwrBMD+xa9T0IEeF+ITk8FVf1E3AWKHXTguVNnaB0m7XV/71KwVaCTFpvn5whbFRyi2
	EoHvxhoXmXLjV3vOjie/Uc5vH6rfpUgFw0FAOIjvKHPCX6idla2gYa/5a9CyD46UOrt4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfk34-0093vZ-5V; Thu, 29 Feb 2024 18:18:22 +0100
Date: Thu, 29 Feb 2024 18:18:22 +0100
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 07/11] dt-bindings: net: hisi-femac: replace
 deprecated phy-mode with recommended phy-connection-type
Message-ID: <1cba5245-08c7-43b0-8ae3-11db52e036aa@lunn.ch>
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
 <20240228-net-v6-7-6d78d3d598c1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-net-v6-7-6d78d3d598c1@outlook.com>

On Wed, Feb 28, 2024 at 05:02:31PM +0800, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> The old property "phy-mode" should be replaced with the latest
> "phy-connection-type".

In practice, phy-mode is typically used, and phy-connection-type is
not used much. All new user tend to be phy-mode.

~/linux$ grep -r phy-mode arch/* | wc
   1561    6258  113122
~/linux$ grep -r phy-connection-type arch/* | wc
    372    1489   28981

Most of the phy-connection-type appear in PowerPC.

~/linux$ grep -r phy-connection-type arch/powerpc/* | wc
    247     990   18335

It was the early adopter of DT, long before ARM. The DT standard of
the time, which PowerPC followed, said to use
phy-connection-type. When ARM started using DT, it did not follow the
standard too well, and phy-mode got used a lot. Officially, phy-mode
is deprecated because it is not part of the standard. But practice
does not always follow the standard.

So both are O.K, all the generic code accepts both, and there is no
real reason to change.

	Andrew

