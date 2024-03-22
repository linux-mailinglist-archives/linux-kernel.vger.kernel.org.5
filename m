Return-Path: <linux-kernel+bounces-111633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35284886ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7FC1F237FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8DD4AED1;
	Fri, 22 Mar 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FZHzzyPy"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE59E481A5;
	Fri, 22 Mar 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118380; cv=none; b=OZhgdx3Bedx8qA85KcQET/oULw8TwjLoJ/bzkGUj2YK9LWyKzKxjnzBEYPywA+vcie1AgvsF+JicIjK0Q8i8JVO/jKNwnA8g+O0Eln+RF13rIYTgGcrWp+Ba/lmbrbVkENa3d+yB8BZuQhIvKcqeaibkQQYvg5UAdf1neUC6TuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118380; c=relaxed/simple;
	bh=qvgEv8xoVOKzmhqSIz/XjZyBJkCYyUUQ8dtP8nbogms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XADKxnLs/04YE8kAlTYk9XPIVfFm9/g0qhgUuVBJbMSrQdPIlxjselQt+yIcZcXZ7oXKSPm7Y8SC7Sloj+Na9jnL1+TjSHhEEOLXH1mRSHMR0jVm0XpErwh2BAYpZh/lCUVYv9RHLOqXLar8C/sxKq/fN1VsxyxzE+l+ocrCAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FZHzzyPy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jh+g+ZjJveECVOAaqmavHBcWRt5kXcNae6GEoE3SkOs=; b=FZHzzyPySg7OczNavmTGM+TfgL
	sG9rR5BpPicVdWNwMD0PQeoxUv0FA+wt+LvgYwZQwNnipqLD34s2pjpNP6X3ewSHGo4mHEZ47guzq
	Z82++OORRt8tlYNtBgBdJBsXqVGbVr0/nRcueGZ54wndLjIwMGoaQTon5Xe9FUz9Uv14=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rng3I-00Axyo-Qy; Fri, 22 Mar 2024 15:39:24 +0100
Date: Fri, 22 Mar 2024 15:39:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: armada-37xx: remove an unused variable
Message-ID: <76bcbc32-1fa9-466e-881a-cf41dce6af38@lunn.ch>
References: <20240322132205.906729-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322132205.906729-1-arnd@kernel.org>

On Fri, Mar 22, 2024 at 02:21:43PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This variable has never been used and can be removed to avoid a W=1 warning:
> 
> drivers/pinctrl/mvebu/pinctrl-armada-37xx.c:837:6: error: variable 'i' set but not used [-Werror,-Wunused-but-set-variable]
>   837 |         int i = 0;
> 
> Fixes: 87466ccd9401 ("pinctrl: armada-37xx: Add pin controller support for Armada 37xx")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

